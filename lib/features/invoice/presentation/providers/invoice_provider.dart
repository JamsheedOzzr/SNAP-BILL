import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:snap_bill/data/models/invoice.dart';
import 'package:snap_bill/data/models/invoice_item.dart';
import 'package:snap_bill/features/scan/presentation/providers/scan_provider.dart';

part 'invoice_provider.g.dart';

const _uuid = Uuid();

/// Convenience provider that exposes the current [Invoice] (non-nullable).
/// Throws if no invoice has been set.
@riverpod
Invoice invoice(InvoiceRef ref) {
  return ref.watch(currentInvoiceProvider)!;
}

/// All line items of the current invoice.
@riverpod
List<InvoiceItem> invoiceItems(InvoiceItemsRef ref) {
  return ref.watch(invoiceProvider).items;
}

/// Subtotal, tax, and grand total.
@riverpod
({double subtotal, double tax, double grandTotal}) invoiceTotals(
    InvoiceTotalsRef ref) {
  final inv = ref.watch(invoiceProvider);
  final subtotal = inv.subtotal;
  final tax = inv.taxAmount;
  return (subtotal: subtotal, tax: tax, grandTotal: inv.grandTotal);
}

// ── Editor Notifier ───────────────────────────────────────────
@riverpod
class InvoiceEditor extends _$InvoiceEditor {
  @override
  bool build() => false; // isDirty flag

  // ── Item CRUD ────────────────────────────────────────────
  void addItem() {
    final newItem = InvoiceItem(
      id: _uuid.v4(),
      desc: '',
      qty: 1,
      price: 0,
    );
    _mutate((inv) => inv.copyWith(items: [...inv.items, newItem]));
  }

  void removeItem(String itemId) {
    _mutate((inv) => inv.copyWith(
          items: inv.items.where((i) => i.id != itemId).toList(),
        ));
  }

  void updateItemDesc(String itemId, String desc) {
    _mutateItem(itemId, (item) => item.copyWith(desc: desc));
  }

  void updateItemNote(String itemId, String note) {
    _mutateItem(itemId, (item) => item.copyWith(note: note));
  }

  void updateItemQty(String itemId, int qty) {
    if (qty < 1) return;
    _mutateItem(itemId, (item) => item.copyWith(qty: qty));
  }

  void incrementQty(String itemId) {
    final current = _item(itemId);
    if (current != null) updateItemQty(itemId, current.qty + 1);
  }

  void decrementQty(String itemId) {
    final current = _item(itemId);
    if (current != null && current.qty > 1) {
      updateItemQty(itemId, current.qty - 1);
    }
  }

  void updateItemPrice(String itemId, double price) {
    _mutateItem(itemId, (item) => item.copyWith(price: price));
  }

  // ── Header fields ────────────────────────────────────────
  void updateBusinessName(String name) {
    _mutate((inv) => inv.copyWith(businessName: name));
  }

  void updateNotes(String notes) {
    _mutate((inv) => inv.copyWith(notes: notes));
  }

  void updateTaxRate(double rate) {
    _mutate((inv) => inv.copyWith(taxRate: rate));
  }

  // ── Helpers ──────────────────────────────────────────────
  void _mutate(Invoice Function(Invoice) updater) {
    ref.read(currentInvoiceProvider.notifier).updateInvoice(updater);
    state = true; // mark dirty
  }

  void _mutateItem(String id, InvoiceItem Function(InvoiceItem) updater) {
    _mutate((inv) => inv.copyWith(
          items: inv.items.map((i) => i.id == id ? updater(i) : i).toList(),
        ));
  }

  InvoiceItem? _item(String id) {
    return ref.read(currentInvoiceProvider)?.items
        .cast<InvoiceItem?>()
        .firstWhere((i) => i?.id == id, orElse: () => null);
  }

  void markSaved() => state = false;
}
