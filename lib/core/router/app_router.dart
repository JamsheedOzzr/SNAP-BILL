import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:snap_bill/features/export/presentation/screens/export_screen.dart';
import 'package:snap_bill/features/invoice/presentation/screens/invoice_screen.dart';
import 'package:snap_bill/features/scan/presentation/screens/scan_screen.dart';
import 'package:snap_bill/features/upload/presentation/screens/upload_screen.dart';

part 'app_router.g.dart';

// ── Route Names ──────────────────────────────────────────────
abstract class AppRoutes {
  static const String upload = '/';
  static const String scan = '/scan';
  static const String invoice = '/invoice';
  static const String export = '/export';
}

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    initialLocation: AppRoutes.upload,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRoutes.upload,
        name: 'upload',
        pageBuilder: (context, state) => _fadeTransition(
          state,
          const UploadScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.scan,
        name: 'scan',
        pageBuilder: (context, state) => _slideTransition(
          state,
          const ScanScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.invoice,
        name: 'invoice',
        pageBuilder: (context, state) => _slideTransition(
          state,
          const InvoiceScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.export,
        name: 'export',
        pageBuilder: (context, state) => _slideTransition(
          state,
          const ExportScreen(),
        ),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Route not found: ${state.error}'),
      ),
    ),
  );
}

// ── Page transitions ─────────────────────────────────────────
CustomTransitionPage<T> _fadeTransition<T>(
    GoRouterState state, Widget child) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (_, animation, __, child) => FadeTransition(
      opacity: animation,
      child: child,
    ),
  );
}

CustomTransitionPage<T> _slideTransition<T>(
    GoRouterState state, Widget child) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 350),
    transitionsBuilder: (_, animation, __, child) {
      final tween = Tween(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).chain(CurveTween(curve: Curves.easeOutCubic));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
