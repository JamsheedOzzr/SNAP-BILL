// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$invoiceHash() => r'181d4361e4edf057fc5305d671ed59d017d03621';

/// Convenience provider that exposes the current [Invoice] (non-nullable).
/// Throws if no invoice has been set.
///
/// Copied from [invoice].
@ProviderFor(invoice)
final invoiceProvider = AutoDisposeProvider<Invoice>.internal(
  invoice,
  name: r'invoiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$invoiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef InvoiceRef = AutoDisposeProviderRef<Invoice>;
String _$invoiceItemsHash() => r'bfadfedeab70d3c9ab70e55e592d7f78cd5118c2';

/// All line items of the current invoice.
///
/// Copied from [invoiceItems].
@ProviderFor(invoiceItems)
final invoiceItemsProvider = AutoDisposeProvider<List<InvoiceItem>>.internal(
  invoiceItems,
  name: r'invoiceItemsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$invoiceItemsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef InvoiceItemsRef = AutoDisposeProviderRef<List<InvoiceItem>>;
String _$invoiceTotalsHash() => r'9db39452a2a0bf0a2eb8a608662b5c9e803a77ef';

/// Subtotal, tax, and grand total.
///
/// Copied from [invoiceTotals].
@ProviderFor(invoiceTotals)
final invoiceTotalsProvider = AutoDisposeProvider<
    ({double subtotal, double tax, double grandTotal})>.internal(
  invoiceTotals,
  name: r'invoiceTotalsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$invoiceTotalsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef InvoiceTotalsRef = AutoDisposeProviderRef<
    ({double subtotal, double tax, double grandTotal})>;
String _$invoiceEditorHash() => r'fd5ee90d77e36addcd91220bc5cb6109ba6b7b53';

/// See also [InvoiceEditor].
@ProviderFor(InvoiceEditor)
final invoiceEditorProvider =
    AutoDisposeNotifierProvider<InvoiceEditor, bool>.internal(
  InvoiceEditor.new,
  name: r'invoiceEditorProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$invoiceEditorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$InvoiceEditor = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
