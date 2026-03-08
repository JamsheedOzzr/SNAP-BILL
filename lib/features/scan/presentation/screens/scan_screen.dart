import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_bill/core/router/app_router.dart';
import 'package:snap_bill/core/theme/app_theme.dart';
import 'package:snap_bill/features/scan/presentation/providers/scan_provider.dart';
import 'package:snap_bill/features/upload/presentation/providers/upload_provider.dart';

class ScanScreen extends ConsumerStatefulWidget {
  const ScanScreen({super.key});

  @override
  ConsumerState<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends ConsumerState<ScanScreen> {
  @override
  void initState() {
    super.initState();
    // Start scanning after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) => _startScan());
  }

  Future<void> _startScan() async {
    final success =
        await ref.read(scanNotifierProvider.notifier).startScan();
    if (success && mounted) {
      context.pushReplacement(AppRoutes.invoice);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scanState = ref.watch(scanNotifierProvider);
    final uploadState = ref.watch(uploadNotifierProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ── App bar ──────────────────────────────────
            _ScanAppBar(
              onBack: () => context.pop(),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 12),

                    // ── Circular progress ────────────────
                    _CircularProgressCard(
                      progress: scanState.currentStep.progress,
                    ).animate().fadeIn(duration: 350.ms),

                    const SizedBox(height: 16),

                    // ── Pipeline steps ───────────────────
                    _PipelineCard(
                      currentStep: scanState.currentStep,
                    ).animate().fadeIn(delay: 100.ms),

                    const SizedBox(height: 16),

                    // ── File pill ────────────────────────
                    _FilePill(
                      fileName: uploadState.isDemo
                          ? 'demo-receipt.jpg'
                          : uploadState.selectedImage?.path
                                  .split('/')
                                  .last ??
                              'receipt.jpg',
                      thumbPath: uploadState.selectedImage?.path,
                      isDemo: uploadState.isDemo,
                    ).animate().fadeIn(delay: 200.ms),

                    if (scanState.currentStep == ScanStep.error) ...[
                      const SizedBox(height: 16),
                      _ErrorBanner(
                          message: scanState.errorMessage,
                          onRetry: _startScan),
                    ],

                    const Spacer(),
                    Text(
                      'Processing takes less than 15 seconds.\nPlease don\'t close the app.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodySmall,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Widgets ───────────────────────────────────────────────────
class _ScanAppBar extends StatelessWidget {
  const _ScanAppBar({required this.onBack});
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.6),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
            color: AppTheme.textPrimary,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Snap & Bill', style: AppTextStyles.titleMedium),
                Text('AI Document Analysis',
                    style: AppTextStyles.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CircularProgressCard extends StatelessWidget {
  const _CircularProgressCard({required this.progress});
  final double progress;

  @override
  Widget build(BuildContext context) {
    final pct = (progress * 100).round();

    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.65),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.45)),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withOpacity(0.07),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            width: 160,
            height: 160,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox.expand(
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: progress),
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.easeOutCubic,
                    builder: (_, value, __) => CircularProgressIndicator(
                      value: value,
                      strokeWidth: 6,
                      backgroundColor:
                          AppTheme.primary.withOpacity(0.1),
                      valueColor: const AlwaysStoppedAnimation(
                          AppTheme.primary),
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TweenAnimationBuilder<int>(
                      tween: IntTween(begin: 0, end: pct),
                      duration: const Duration(milliseconds: 700),
                      builder: (_, value, __) => Text(
                        '$value%',
                        style: const TextStyle(
                          fontFamily: 'Syne',
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                    Text('Scanning',
                        style: AppTextStyles.labelSmall
                            .copyWith(color: AppTheme.textSecondary)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text('AI Document Analysis',
              style: AppTextStyles.headlineMedium.copyWith(fontSize: 18)),
          const SizedBox(height: 4),
          Text(
            'Extracting line items and vendor details',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _PipelineCard extends StatelessWidget {
  const _PipelineCard({required this.currentStep});
  final ScanStep currentStep;

  static const _pipelineSteps = [
    ScanStep.preprocessing,
    ScanStep.detectingText,
    ScanStep.runningOcr,
    ScanStep.parsingData,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.65),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('PIPELINE STATUS',
              style: AppTextStyles.labelSmall
                  .copyWith(color: AppTheme.primary)),
          const SizedBox(height: 16),
          ...List.generate(_pipelineSteps.length, (i) {
            final step = _pipelineSteps[i];
            final isLast = i == _pipelineSteps.length - 1;
            final isDone = step.index < currentStep.index;
            final isActive = step == currentStep;

            return _PipelineStep(
              step: step,
              isDone: isDone,
              isActive: isActive,
              showLine: !isLast,
            );
          }),
        ],
      ),
    );
  }
}

class _PipelineStep extends StatelessWidget {
  const _PipelineStep({
    required this.step,
    required this.isDone,
    required this.isActive,
    required this.showLine,
  });

  final ScanStep step;
  final bool isDone;
  final bool isActive;
  final bool showLine;

  @override
  Widget build(BuildContext context) {
    Color dotColor;
    Widget icon;

    if (isDone) {
      dotColor = AppTheme.primary;
      icon = const Icon(Icons.check_rounded,
          color: Colors.white, size: 16);
    } else if (isActive) {
      dotColor = Colors.transparent;
      icon = SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: AppTheme.primary,
        ),
      );
    } else {
      dotColor = Colors.transparent;
      icon = const Icon(Icons.schedule_rounded,
          color: AppTheme.textHint, size: 16);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isDone
                    ? AppTheme.primary
                    : isActive
                        ? AppTheme.primaryContainer
                        : AppTheme.surfaceVariant,
                shape: BoxShape.circle,
                border: isActive
                    ? Border.all(color: AppTheme.primary, width: 2)
                    : null,
              ),
              child: Center(child: icon),
            ),
            if (showLine)
              Container(
                width: 2,
                height: 32,
                color: isDone
                    ? AppTheme.primary
                    : AppTheme.divider,
              ),
          ],
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.label,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDone || isActive
                        ? AppTheme.textPrimary
                        : AppTheme.textSecondary,
                  ),
                ),
                if (isActive)
                  Text(step.subtitle,
                      style: AppTextStyles.bodySmall
                          .copyWith(color: AppTheme.primary))
                else if (isDone)
                  Text('Complete',
                      style: AppTextStyles.bodySmall)
                else
                  Text(step.subtitle,
                      style: AppTextStyles.bodySmall),
                if (showLine) const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _FilePill extends StatelessWidget {
  const _FilePill({
    required this.fileName,
    this.thumbPath,
    required this.isDemo,
  });

  final String fileName;
  final String? thumbPath;
  final bool isDemo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.divider),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppTheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            clipBehavior: Clip.antiAlias,
            child: thumbPath != null
                ? Image.file(File(thumbPath!), fit: BoxFit.cover)
                : const Center(
                    child: Text('📜', style: TextStyle(fontSize: 24))),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(fileName,
                    style: AppTextStyles.bodyMedium
                        .copyWith(fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                Text('Processing…', style: AppTextStyles.bodySmall),
              ],
            ),
          ),
          const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
                strokeWidth: 2, color: AppTheme.primary),
          ),
        ],
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.error.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.error.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: AppTheme.error),
          const SizedBox(width: 10),
          Expanded(
            child: Text(message,
                style: AppTextStyles.bodySmall
                    .copyWith(color: AppTheme.error)),
          ),
          TextButton(
            onPressed: onRetry,
            child: const Text('Retry',
                style: TextStyle(color: AppTheme.error)),
          ),
        ],
      ),
    );
  }
}
