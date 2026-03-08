import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_bill/core/router/app_router.dart';
import 'package:snap_bill/core/theme/app_theme.dart';

class SnapBillBottomNav extends StatelessWidget {
  const SnapBillBottomNav({super.key, required this.activeIndex});

  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.55),
          borderRadius: BorderRadius.circular(99),
          border: Border.all(color: Colors.white.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _NavItem(
              icon: Icons.home_outlined,
              label: 'Home',
              isActive: activeIndex == 0,
              onTap: () => context.go(AppRoutes.upload),
            ),
            _NavItem(
              icon: Icons.receipt_long_outlined,
              label: 'History',
              isActive: activeIndex == 1,
              onTap: () {},
            ),
            // ── Raised camera CTA ────────────────────────
            GestureDetector(
              onTap: () => context.go(AppRoutes.upload),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Transform.translate(
                    offset: const Offset(0, -18),
                    child: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: AppTheme.primary,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primary.withOpacity(0.4),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.camera_alt_outlined,
                          color: Colors.white, size: 24),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(0, -12),
                    child: Text('Scan',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppTheme.primary,
                        )),
                  ),
                ],
              ),
            ),
            _NavItem(
              icon: Icons.analytics_outlined,
              label: 'Stats',
              isActive: activeIndex == 3,
              onTap: () {},
            ),
            _NavItem(
              icon: Icons.person_outline,
              label: 'Profile',
              isActive: activeIndex == 4,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppTheme.primary : AppTheme.textHint;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 2),
          Text(label,
              style: AppTextStyles.labelSmall.copyWith(color: color)),
        ],
      ),
    );
  }
}
