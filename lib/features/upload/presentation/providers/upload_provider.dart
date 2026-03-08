import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'upload_provider.g.dart';
part 'upload_provider.freezed.dart';

// ── State ─────────────────────────────────────────────────────
@freezed
class UploadState with _$UploadState {
  const factory UploadState({
    File? selectedImage,
    @Default(false) bool isDemo,
    @Default('') String error,
  }) = _UploadState;
}

// ── Notifier ──────────────────────────────────────────────────
@riverpod
class UploadNotifier extends _$UploadNotifier {
  final _picker = ImagePicker();

  @override
  UploadState build() => const UploadState();

  /// Pick image from device gallery
  Future<void> pickFromGallery() async {
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
      maxWidth: 2048,
    );
    if (picked != null) {
      state = UploadState(selectedImage: File(picked.path));
    }
  }

  /// Capture image with camera
  Future<void> captureFromCamera() async {
    final picked = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
      maxWidth: 2048,
    );
    if (picked != null) {
      state = UploadState(selectedImage: File(picked.path));
    }
  }

  /// Load demo flow (no image needed)
  void useDemo() {
    state = const UploadState(isDemo: true);
  }

  /// Clear selection
  void clear() {
    state = const UploadState();
  }

  bool get canProceed => state.selectedImage != null || state.isDemo;
}
