// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$scanNotifierHash() => r'4d4508ae3fd6ab8f5a1dd99fda14b63520904f82';

/// See also [ScanNotifier].
@ProviderFor(ScanNotifier)
final scanNotifierProvider =
    AutoDisposeNotifierProvider<ScanNotifier, ScanState>.internal(
  ScanNotifier.new,
  name: r'scanNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$scanNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ScanNotifier = AutoDisposeNotifier<ScanState>;
String _$currentInvoiceHash() => r'9ad11d04f4e02cea45fc148ca3d0ab9fd8c177f7';

/// See also [CurrentInvoice].
@ProviderFor(CurrentInvoice)
final currentInvoiceProvider =
    AutoDisposeNotifierProvider<CurrentInvoice, Invoice?>.internal(
  CurrentInvoice.new,
  name: r'currentInvoiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentInvoiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentInvoice = AutoDisposeNotifier<Invoice?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
