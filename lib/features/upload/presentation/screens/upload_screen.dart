import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_bill/core/router/app_router.dart';
import 'package:snap_bill/core/theme/app_theme.dart';
import 'package:snap_bill/features/upload/presentation/providers/upload_provider.dart';
import 'package:snap_bill/features/upload/presentation/widgets/bottom_nav_bar.dart';

class UploadScreen extends ConsumerWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(uploadNotifierProvider);
    final notifier = ref.read(uploadNotifierProvider.notifier);

    return Scaffold(
      body: Stack(
        children: [
          // ── Mesh background ──────────────────────────────
          _MeshBackground(),
          SafeArea(
            child: Column(
              children: [
                // ── Header ───────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppTheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(99),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: AppTheme.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'PHASE 01',
                              style: AppTextStyles.labelSmall.copyWith(
                                color: AppTheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text('Snap & Bill',
                          style: AppTextStyles.displayLarge),
                      const SizedBox(height: 6),
                      Text(
                        'Turn receipts into digital invoices',
                        style: AppTextStyles.bodyMedium
                            .copyWith(color: AppTheme.textSecondary),
                      ),
                    ],
                  ),
                ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.2),

                // ── Upload card ───────────────────────────
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        _UploadCard(
                          imagePath: state.selectedImage?.path,
                          isDemo: state.isDemo,
                          onGallery: notifier.pickFromGallery,
                          onCamera: notifier.captureFromCamera,
                        ).animate().fadeIn(delay: 150.ms).slideY(begin: 0.1),

                        const SizedBox(height: 16),

                        // ── CTA ─────────────────────────
                        _ProceedButton(
                          canProceed: notifier.canProceed,
                          onTap: () => context.push(AppRoutes.scan),
                        ).animate().fadeIn(delay: 250.ms),

                        TextButton(
                          onPressed: () {
                            notifier.useDemo();
                            context.push(AppRoutes.scan);
                          },
                          child: Text(
                            'Try with demo receipt →',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        // ── Info pill ────────────────────
                        _GlassPill().animate().fadeIn(delay: 350.ms),
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

// ── Upload card ───────────────────────────────────────────────
class _UploadCard extends StatelessWidget {
  const _UploadCard({
    this.imagePath,
    required this.isDemo,
    required this.onGallery,
    required this.onCamera,
  });

  final String? imagePath;
  final bool isDemo;
  final VoidCallback onGallery;
  final VoidCallback onCamera;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.55),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Icon
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppTheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.cloud_upload_outlined,
                color: AppTheme.primary, size: 36),
          ),
          const SizedBox(height: 16),
          Text('Drop your receipt',
              style: AppTextStyles.headlineMedium.copyWith(fontSize: 20)),
          const SizedBox(height: 4),
          Text('JPG, PNG, PDF — up to 10 MB',
              style: AppTextStyles.bodySmall),
          const SizedBox(height: 20),

          // Preview area
          GestureDetector(
            onTap: onGallery,
            child: DottedBorder(
              color: AppTheme.primary.withOpacity(0.3),
              strokeWidth: 1.5,
              dashPattern: const [8, 4],
              borderType: BorderType.RRect,
              radius: const Radius.circular(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  height: 140,
                  width: double.infinity,
                  color: AppTheme.surfaceVariant,
                  child: imagePath != null
                      ? Image.file(
                          File(imagePath!),
                          fit: BoxFit.cover,
                        )
                      : isDemo
                          ? const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('📜', style: TextStyle(fontSize: 40)),
                                SizedBox(height: 8),
                                Text('Demo receipt',
                                    style: TextStyle(
                                        color: AppTheme.textSecondary,
                                        fontSize: 12)),
                              ],
                            )
                          : const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.receipt_long_outlined,
                                    color: AppTheme.textHint, size: 36),
                                SizedBox(height: 8),
                                Text('Tap to select receipt',
                                    style: TextStyle(
                                        color: AppTheme.textHint,
                                        fontSize: 12)),
                              ],
                            ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Camera button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: onCamera,
              icon: const Icon(Icons.camera_alt_outlined, size: 18),
              label: const Text('Take a photo'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.primary,
                side: const BorderSide(color: AppTheme.primary),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProceedButton extends StatelessWidget {
  const _ProceedButton(
      {required this.canProceed, required this.onTap});

  final bool canProceed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: canProceed ? 1.0 : 0.4,
      child: ElevatedButton(
        onPressed: canProceed ? onTap : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: const Text('Analyze Receipt',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
      ),
    );
  }
}

class _GlassPill extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.4)),
      ),
      child: Row(
        children: [
          const Icon(Icons.auto_awesome,
              color: AppTheme.primary, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Claude AI reads handwriting & extracts items automatically',
              style: AppTextStyles.bodySmall
                  .copyWith(color: AppTheme.textPrimary),
            ),
          ),
        ],
      ),
    );
  }
}

class _MeshBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(-1, -1),
          radius: 1.5,
          colors: [Color(0x266C2BEE), Color(0x00F4F3FA)],
        ),
      ),
    );
  }
}
