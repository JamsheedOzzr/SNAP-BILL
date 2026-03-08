import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:snap_bill/data/models/invoice.dart';
import 'package:snap_bill/data/repositories/invoice_repository.dart';
import 'package:snap_bill/features/upload/presentation/providers/upload_provider.dart';

part 'scan_provider.g.dart';
part 'scan_provider.freezed.dart';

// ── Pipeline step enum ────────────────────────────────────────
enum ScanStep {
  idle,
  preprocessing,
  detectingText,
  runningOcr,
  parsingData,
  done,
  error,
}

extension ScanStepX on ScanStep {
  String get label => switch (this) {
        ScanStep.idle => 'Waiting',
        ScanStep.preprocessing => 'Preprocessing',
        ScanStep.detectingText => 'Detecting Text',
        ScanStep.runningOcr => 'Running OCR',
        ScanStep.parsingData => 'Parsing Data',
        ScanStep.done => 'Done',
        ScanStep.error => 'Error',
      };

  String get subtitle => switch (this) {
        ScanStep.preprocessing => 'Enhancing contrast & sharpness',
        ScanStep.detectingText => 'Locating character regions',
        ScanStep.runningOcr => 'Neural text extraction',
        ScanStep.parsingData => 'Structuring line items',
        ScanStep.done => 'Complete',
        _ => '',
      };

  /// 0.0 → 1.0 progress for the circular indicator
  double get progress => switch (this) {
        ScanStep.idle => 0,
        ScanStep.preprocessing => 0.20,
        ScanStep.detectingText => 0.45,
        ScanStep.runningOcr => 0.70,
        ScanStep.parsingData => 0.90,
        ScanStep.done => 1.0,
        ScanStep.error => 0,
      };

  bool get isCompleted =>
      index > ScanStep.idle.index && index < ScanStep.done.index
          ? false
          : this == ScanStep.done;

  List<ScanStep> get completedSteps {
    const pipeline = [
      ScanStep.preprocessing,
      ScanStep.detectingText,
      ScanStep.runningOcr,
      ScanStep.parsingData,
    ];
    return pipeline.where((s) => s.index < index).toList();
  }
}

// ── State ─────────────────────────────────────────────────────
@freezed
class ScanState with _$ScanState {
  const factory ScanState({
    @Default(ScanStep.idle) ScanStep currentStep,
    @Default('') String errorMessage,
  }) = _ScanState;
}

// ── Notifier ──────────────────────────────────────────────────
@riverpod
class ScanNotifier extends _$ScanNotifier {
  @override
  ScanState build() => const ScanState();

  Future<bool> startScan() async {
    final uploadState = ref.read(uploadNotifierProvider);
    final repo = ref.read(invoiceRepositoryProvider);

    _setStep(ScanStep.preprocessing);
    await _simulateStep();

    _setStep(ScanStep.detectingText);
    await _simulateStep();

    _setStep(ScanStep.runningOcr);

    try {
      final invoice = uploadState.isDemo
          ? repo.createDemoInvoice()
          : await repo.createInvoiceFromImage(uploadState.selectedImage!);

      _setStep(ScanStep.parsingData);
      await _simulateStep();

      _setStep(ScanStep.done);

      // Store invoice in the invoice provider
      ref.read(currentInvoiceProvider.notifier).setInvoice(invoice);
      return true;
    } catch (e) {
      state = ScanState(
        currentStep: ScanStep.error,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  void reset() => state = const ScanState();

  void _setStep(ScanStep step) {
    state = state.copyWith(currentStep: step);
  }

  Future<void> _simulateStep() =>
      Future.delayed(const Duration(milliseconds: 800));
}

// ── Shared current invoice (cross-feature) ─────────────────────
// Kept here to avoid circular imports; screens read from this.

@riverpod
class CurrentInvoice extends _$CurrentInvoice {
  @override
  Invoice? build() => null;

  void setInvoice(Invoice invoice) => state = invoice;

  void updateInvoice(Invoice Function(Invoice) updater) {
    if (state != null) state = updater(state!);
  }

  void clear() => state = null;
}
