import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_bill/core/router/app_router.dart';
import 'package:snap_bill/core/theme/app_theme.dart';
import 'package:snap_bill/data/models/invoice_item.dart';
import 'package:snap_bill/features/invoice/presentation/providers/invoice_provider.dart';
import 'package:snap_bill/features/scan/presentation/providers/scan_provider.dart';
import 'package:snap_bill/features/upload/presentation/providers/upload_provider.dart';

class InvoiceScreen extends ConsumerWidget {
  const InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invoice = ref.watch(invoiceProvider);
    final totals = ref.watch(invoiceTotalsProvider);
    final editor = ref.read(invoiceEditorProvider.notifier);
    final uploadState = ref.watch(uploadNotifierProvider);
    final isDirty = ref.watch(invoiceEditorProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ── Sticky app bar ───────────────────────────────
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.white.withOpacity(0.85),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
              color: AppTheme.primary,
              onPressed: () => context.pop(),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Edit Invoice'),
                Text(invoice.invoiceNumber,
                    style: AppTextStyles.bodySmall),
              ],
            ),
            actions: [
              if (isDirty)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: IconButton(
                    icon: const Icon(Icons.save_outlined),
                    color: AppTheme.primary,
                    onPressed: () {
                      ref
                          .read(invoiceEditorProvider.notifier)
                          .markSaved();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Saved!')),
                      );
                    },
                  ),
                ),
            ],
          ),

          SliverPadding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // ── Section header ─────────────────────
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Invoice Details',
                        style: AppTextStyles.displayMedium),
                    Text('Review and modify line items',
                        style: AppTextStyles.bodySmall),
                  ],
                ).animate().fadeIn(duration: 300.ms),
                const SizedBox(height: 20),

                // ── Line items card ────────────────────
                _LineItemsCard(
                  items: invoice.items,
                  editor: editor,
                ).animate().fadeIn(delay: 100.ms),
                const SizedBox(height: 16),

                // ── Notes + Totals ─────────────────────
                _NotesField(
                  initial: invoice.notes,
                  onChanged: editor.updateNotes,
                ).animate().fadeIn(delay: 200.ms),
                const SizedBox(height: 12),

                _TotalsCard(totals: totals, currency: invoice.currency)
                    .animate()
                    .fadeIn(delay: 250.ms),
                const SizedBox(height: 16),

                // ── Original receipt reference ─────────
                if (!uploadState.isDemo &&
                    uploadState.selectedImage != null)
                  _ReceiptReference(
                    path: uploadState.selectedImage!.path,
                    name: uploadState.selectedImage!.path
                        .split('/')
                        .last,
                  ).animate().fadeIn(delay: 300.ms),

                const SizedBox(height: 16),

                // ── CTA ───────────────────────────────
                ElevatedButton.icon(
                  onPressed: () => context.push(AppRoutes.export),
                  icon: const Text('Review & Export'),
                  label: const Icon(Icons.arrow_forward_rounded,
                      size: 18),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 54),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ).animate().fadeIn(delay: 350.ms),
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Line items card ───────────────────────────────────────────
class _LineItemsCard extends StatelessWidget {
  const _LineItemsCard({required this.items, required this.editor});

  final List<InvoiceItem> items;
  final InvoiceEditor editor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.divider),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Table header
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: AppTheme.primary.withOpacity(0.05),
            child: Row(
              children: [
                Expanded(
                    flex: 5,
                    child: Text('Description',
                        style: AppTextStyles.labelSmall)),
                SizedBox(
                    width: 64,
                    child: Text('Qty',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.labelSmall)),
                SizedBox(
                    width: 80,
                    child: Text('Price',
                        textAlign: TextAlign.right,
                        style: AppTextStyles.labelSmall)),
                SizedBox(
                    width: 70,
                    child: Text('Total',
                        textAlign: TextAlign.right,
                        style: AppTextStyles.labelSmall)),
              ],
            ),
          ),

          const Divider(height: 1),

          // Items
          ...items.asMap().entries.map((entry) => Column(
                children: [
                  _LineItemRow(item: entry.value, editor: editor),
                  if (entry.key < items.length - 1)
                    const Divider(height: 1),
                ],
              )),

          // Add row button
          Padding(
            padding: const EdgeInsets.all(16),
            child: GestureDetector(
              onTap: editor.addItem,
              child: Row(
                children: [
                  const Icon(Icons.add_circle_outline,
                      color: AppTheme.primary, size: 20),
                  const SizedBox(width: 8),
                  Text('Add Line Item',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppTheme.primary,
                        fontWeight: FontWeight.w600,
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LineItemRow extends StatelessWidget {
  const _LineItemRow({required this.item, required this.editor});

  final InvoiceItem item;
  final InvoiceEditor editor;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(item.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: AppTheme.error.withOpacity(0.1),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(Icons.delete_outline, color: AppTheme.error),
      ),
      onDismissed: (_) => editor.removeItem(item.id),
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Description
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    initialValue: item.desc,
                    onChanged: (v) => editor.updateItemDesc(item.id, v),
                    style: AppTextStyles.bodyMedium
                        .copyWith(fontWeight: FontWeight.w600),
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      hintText: 'Item name…',
                    ),
                  ),
                  if (item.note.isNotEmpty || item.desc.isEmpty)
                    TextFormField(
                      initialValue: item.note,
                      onChanged: (v) =>
                          editor.updateItemNote(item.id, v),
                      style: AppTextStyles.bodySmall,
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        hintText: 'Description',
                      ),
                    ),
                ],
              ),
            ),

            // Qty stepper
            SizedBox(
              width: 64,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _SmallBtn(
                    icon: Icons.remove,
                    onTap: () => editor.decrementQty(item.id),
                  ),
                  const SizedBox(width: 2),
                  Text('${item.qty}',
                      style: AppTextStyles.bodyMedium
                          .copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(width: 2),
                  _SmallBtn(
                    icon: Icons.add,
                    onTap: () => editor.incrementQty(item.id),
                  ),
                ],
              ),
            ),

            // Price
            SizedBox(
              width: 80,
              child: TextFormField(
                initialValue: item.price.toStringAsFixed(0),
                keyboardType: const TextInputType.numberWithOptions(
                    decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^\d+\.?\d{0,2}'))
                ],
                onChanged: (v) => editor.updateItemPrice(
                    item.id, double.tryParse(v) ?? 0),
                textAlign: TextAlign.right,
                style: AppTextStyles.bodyMedium,
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  hintText: '0',
                ),
              ),
            ),

            // Total
            SizedBox(
              width: 70,
              child: Text(
                '₹${item.total.toStringAsFixed(2)}',
                textAlign: TextAlign.right,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SmallBtn extends StatelessWidget {
  const _SmallBtn({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          color: AppTheme.primaryContainer,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 14, color: AppTheme.primary),
      ),
    );
  }
}

class _NotesField extends StatelessWidget {
  const _NotesField({required this.initial, required this.onChanged});
  final String initial;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.65),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('INTERNAL NOTES', style: AppTextStyles.labelSmall),
          const SizedBox(height: 8),
          TextFormField(
            initialValue: initial,
            onChanged: onChanged,
            maxLines: 2,
            decoration: const InputDecoration(
              hintText: 'Add private notes…',
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              isDense: true,
            ),
            style: AppTextStyles.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _TotalsCard extends StatelessWidget {
  const _TotalsCard({required this.totals, required this.currency});

  final ({double subtotal, double tax, double grandTotal}) totals;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.65),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.divider),
      ),
      child: Column(
        children: [
          _TotalsRow(
            label: 'Subtotal',
            value: '$currency${totals.subtotal.toStringAsFixed(2)}',
          ),
          const SizedBox(height: 8),
          _TotalsRow(
            label: 'Tax (0%)',
            value: '$currency${totals.tax.toStringAsFixed(2)}',
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(),
          ),
          _TotalsRow(
            label: 'Total Amount',
            value: '$currency${totals.grandTotal.toStringAsFixed(2)}',
            isTotal: true,
          ),
        ],
      ),
    );
  }
}

class _TotalsRow extends StatelessWidget {
  const _TotalsRow(
      {required this.label,
      required this.value,
      this.isTotal = false});

  final String label;
  final String value;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal
              ? AppTextStyles.titleMedium.copyWith(fontSize: 18)
              : AppTextStyles.bodyMedium
                  .copyWith(color: AppTheme.textSecondary),
        ),
        Text(
          value,
          style: isTotal
              ? AppTextStyles.headlineMedium.copyWith(
                  color: AppTheme.primary,
                  fontSize: 20,
                )
              : AppTextStyles.bodyMedium
                  .copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class _ReceiptReference extends StatelessWidget {
  const _ReceiptReference({required this.path, required this.name});
  final String path;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.55),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.divider),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(File(path),
                width: 48, height: 48, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ORIGINAL SCAN', style: AppTextStyles.labelSmall),
                Text(name,
                    style: AppTextStyles.bodyMedium
                        .copyWith(fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          Text('View',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppTheme.primary,
                fontWeight: FontWeight.w700,
              )),
        ],
      ),
    );
  }
}
