// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$scanNotifierHash() => r'6cafe266b0694bce81e39ade736d0b38d91683d0';

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
String _$currentInvoiceHash() => r'26d31d813c34fa9c461177866ebf267152f40848';

/// See also [CurrentInvoice].
@ProviderFor(CurrentInvoice)
final currentInvoiceProvider =
    NotifierProvider<CurrentInvoice, Invoice?>.internal(
  CurrentInvoice.new,
  name: r'currentInvoiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentInvoiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentInvoice = Notifier<Invoice?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
