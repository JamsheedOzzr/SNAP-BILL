import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_bill/core/router/app_router.dart';
import 'package:snap_bill/core/theme/app_theme.dart';
import 'package:snap_bill/data/models/invoice.dart';
import 'package:snap_bill/features/export/presentation/providers/export_provider.dart';
import 'package:snap_bill/features/invoice/presentation/providers/invoice_provider.dart';
import 'package:snap_bill/features/scan/presentation/providers/scan_provider.dart';
import 'package:snap_bill/features/upload/presentation/providers/upload_provider.dart';
import 'package:snap_bill/features/upload/presentation/widgets/bottom_nav_bar.dart';

class ExportScreen extends ConsumerWidget {
  const ExportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invoice = ref.watch(invoiceProvider);
    final totals = ref.watch(invoiceTotalsProvider);
    final exportStatus = ref.watch(exportNotifierProvider);
    final exporter = ref.read(exportNotifierProvider.notifier);

    // Show toast on status change
    ref.listen(exportNotifierProvider, (_, next) {
      if (next is ExportSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.message),
            backgroundColor: AppTheme.success,
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else if (next is ExportFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error),
            backgroundColor: AppTheme.error,
          ),
        );
      }
    });

    final isLoading = exportStatus is ExportLoading;

    return Scaffold(
      body: Stack(
        children: [
          // Background orbs
          Positioned(
            top: -40, left: -60,
            child: Container(
              width: 280, height: 280,
              decoration: BoxDecoration(
                color: AppTheme.primary.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: 100, right: -80,
            child: Container(
              width: 320, height: 320,
              decoration: BoxDecoration(
                color: AppTheme.primaryLight.withOpacity(0.06),
                shape: BoxShape.circle,
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // ── App bar ──────────────────────────────
                _ExportAppBar(onBack: () => context.pop()),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                    child: Column(
                      children: [
                        // ── Success card ─────────────────
                        _SuccessCard().animate().scale(
                              delay: 100.ms,
                              duration: 500.ms,
                              curve: Curves.elasticOut,
                            ),
                        const SizedBox(height: 20),

                        // ── Summary ──────────────────────
                        _SummaryCard(
                          invoiceNum: invoice.invoiceNumber,
                          total:
                              '${invoice.currency}${totals.grandTotal.toStringAsFixed(2)}',
                          itemCount: invoice.items.length,
                          date: invoice.formattedDate,
                        ).animate().fadeIn(delay: 300.ms),
                        const SizedBox(height: 20),

                        // ── Actions ──────────────────────
                        _ActionButtons(
                          isLoading: isLoading,
                          onPdf: () =>
                              exporter.export(ExportFormat.pdf),
                          onPrint: () =>
                              exporter.export(ExportFormat.print),
                          onNewScan: () {
                            ref
                                .read(uploadNotifierProvider.notifier)
                                .clear();
                            ref
                                .read(scanNotifierProvider.notifier)
                                .reset();
                            ref
                                .read(currentInvoiceProvider.notifier)
                                .clear();
                            context.go(AppRoutes.upload);
                          },
                        ).animate().fadeIn(delay: 400.ms),

                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),

                // ── Bottom nav ────────────────────────────
                const SnapBillBottomNav(activeIndex: 0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Widgets ───────────────────────────────────────────────────
class _ExportAppBar extends StatelessWidget {
  const _ExportAppBar({required this.onBack});
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.6),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
            color: AppTheme.textPrimary,
            onPressed: onBack,
          ),
          Expanded(
            child: Text('Export Invoice',
                textAlign: TextAlign.center,
                style: AppTextStyles.titleMedium),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }
}

class _SuccessCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withOpacity(0.1),
            blurRadius: 32,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // Animated check icon
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: AppTheme.primaryContainer,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primary.withOpacity(0.2),
                      blurRadius: 20,
                      spreadRadius: 4,
                    ),
                  ],
                ),
              ),
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  color: AppTheme.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_rounded,
                    color: Colors.white, size: 32),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text('Invoice Ready!', style: AppTextStyles.displayMedium),
          const SizedBox(height: 8),
          Text(
            'Your receipt has been processed and formatted into a professional digital invoice.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium
                .copyWith(color: AppTheme.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.invoiceNum,
    required this.total,
    required this.itemCount,
    required this.date,
  });

  final String invoiceNum;
  final String total;
  final int itemCount;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.divider),
      ),
      child: Column(
        children: [
          _SumRow(label: 'Invoice No.', value: invoiceNum, bold: true),
          const SizedBox(height: 10),
          _SumRow(label: 'Date', value: date),
          const SizedBox(height: 10),
          _SumRow(label: 'Line Items', value: '$itemCount items'),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(),
          ),
          _SumRow(
            label: 'Total Amount',
            value: total,
            bold: true,
            valueColor: AppTheme.primary,
          ),
        ],
      ),
    );
  }
}

class _SumRow extends StatelessWidget {
  const _SumRow({
    required this.label,
    required this.value,
    this.bold = false,
    this.valueColor,
  });

  final String label;
  final String value;
  final bool bold;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: AppTextStyles.bodyMedium
                .copyWith(color: AppTheme.textSecondary)),
        Text(
          value,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
            color: valueColor ?? AppTheme.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons({
    required this.isLoading,
    required this.onPdf,
    required this.onPrint,
    required this.onNewScan,
  });

  final bool isLoading;
  final VoidCallback onPdf;
  final VoidCallback onPrint;
  final VoidCallback onNewScan;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Primary: Share to WhatsApp
        ElevatedButton.icon(
          onPressed: isLoading ? null : onPdf,
          icon: isLoading
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: Colors.white))
              : const Icon(Icons.share_rounded, size: 18),
          label: Text(isLoading ? 'Processing…' : 'Share to WhatsApp'),
        ),
        const SizedBox(height: 12),

        // Secondary row
        Row(
          children: [
            Expanded(
              child: _SecondaryBtn(
                icon: Icons.print_outlined,
                label: 'Print',
                onTap: onPrint,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Scan new
        OutlinedButton.icon(
          onPressed: onNewScan,
          icon: const Icon(Icons.add_a_photo_outlined, size: 18),
          label: const Text('Scan New Receipt'),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppTheme.primary,
            side: const BorderSide(
                color: AppTheme.primary, width: 1.5),
            minimumSize: const Size(double.infinity, 54),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ],
    );
  }
}

class _SecondaryBtn extends StatelessWidget {
  const _SecondaryBtn({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.55),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.divider),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppTheme.primary, size: 20),
            const SizedBox(width: 8),
            Text(label,
                style: AppTextStyles.bodyMedium
                    .copyWith(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
