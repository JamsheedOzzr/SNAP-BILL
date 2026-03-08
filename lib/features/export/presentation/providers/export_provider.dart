import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_plus/share_plus.dart';
import 'package:snap_bill/core/constants/app_constants.dart';
import 'package:snap_bill/data/models/invoice.dart';
import 'package:snap_bill/data/models/invoice_item.dart';
import 'package:snap_bill/features/invoice/presentation/providers/invoice_provider.dart';

part 'export_provider.g.dart';

// ── Export format enum ────────────────────────────────────────
enum ExportFormat { pdf, json, print }

// ── Export status ─────────────────────────────────────────────
sealed class ExportStatus {
  const ExportStatus();
}

class ExportIdle extends ExportStatus {
  const ExportIdle();
}

class ExportLoading extends ExportStatus {
  const ExportLoading();
}

class ExportSuccess extends ExportStatus {
  const ExportSuccess(this.message);
  final String message;
}

class ExportFailure extends ExportStatus {
  const ExportFailure(this.error);
  final String error;
}

// ── Notifier ──────────────────────────────────────────────────
@riverpod
class ExportNotifier extends _$ExportNotifier {
  @override
  ExportStatus build() => const ExportIdle();

  Future<void> export(ExportFormat format) async {
    state = const ExportLoading();
    try {
      final invoice = ref.read(invoiceProvider);
      switch (format) {
        case ExportFormat.pdf:
          await _exportPdf(invoice);
        case ExportFormat.json:
          await _copyJson(invoice);
        case ExportFormat.print:
          await _print(invoice);
      }
    } catch (e) {
      state = ExportFailure(e.toString());
    }
  }

  Future<void> _exportPdf(Invoice invoice) async {
    final pdf = pw.Document();
    final currency = AppConstants.defaultCurrency;

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (ctx) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Header
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      invoice.businessName.isEmpty
                          ? 'Business Name'
                          : invoice.businessName,
                      style: pw.TextStyle(
                        fontSize: 20,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    if (invoice.address.isNotEmpty)
                      pw.Text(invoice.address,
                          style: const pw.TextStyle(fontSize: 11)),
                  ],
                ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text(invoice.invoiceNumber,
                        style: pw.TextStyle(
                          fontSize: 14,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.deepPurple,
                        )),
                    pw.Text(invoice.formattedDate,
                        style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 24),
            pw.Divider(),
            pw.SizedBox(height: 12),
            // Table header
            pw.Row(children: [
              pw.Expanded(
                  flex: 5,
                  child: _headerCell('Description')),
              _headerCell('Qty', flex: 1),
              _headerCell('Price', flex: 2),
              _headerCell('Total', flex: 2),
            ]),
            pw.Divider(color: PdfColors.grey300),
            // Items
            ...invoice.items.map((item) => pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 6),
                  child: pw.Row(children: [
                    pw.Expanded(
                        flex: 5,
                        child: pw.Text(item.desc,
                            style: const pw.TextStyle(fontSize: 12))),
                    _cell('${item.qty}', flex: 1),
                    _cell('$currency${item.price.toStringAsFixed(2)}',
                        flex: 2),
                    _cell('$currency${item.total.toStringAsFixed(2)}',
                        flex: 2),
                  ]),
                )),
            pw.Divider(color: PdfColors.grey300),
            pw.SizedBox(height: 8),
            // Totals
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text(
                      'Total: $currency${invoice.grandTotal.toStringAsFixed(2)}',
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.deepPurple,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/${invoice.invoiceNumber}.pdf');
    await file.writeAsBytes(await pdf.save());

    await Share.shareXFiles(
      [XFile(file.path)],
      subject: invoice.invoiceNumber,
    );

    state = ExportSuccess('PDF saved & shared');
  }

  pw.Widget _headerCell(String text, {int flex = 1}) {
    return pw.Expanded(
      flex: flex,
      child: pw.Text(
        text.toUpperCase(),
        style: pw.TextStyle(
          fontSize: 9,
          fontWeight: pw.FontWeight.bold,
          color: PdfColors.grey600,
        ),
      ),
    );
  }

  pw.Widget _cell(String text, {int flex = 1}) {
    return pw.Expanded(
      flex: flex,
      child: pw.Text(text, style: const pw.TextStyle(fontSize: 12)),
    );
  }

  Future<void> _copyJson(Invoice invoice) async {
    final json = invoice.toJson();
    await Clipboard.setData(ClipboardData(text: json.toString()));
    state = const ExportSuccess('JSON copied to clipboard');
  }

  Future<void> _print(Invoice invoice) async {
    final pdfBytes = await _buildPdfBytes(invoice);
    await Printing.layoutPdf(onLayout: (_) async => pdfBytes);
    state = const ExportSuccess('Sent to printer');
  }

  Future<Uint8List> _buildPdfBytes(Invoice invoice) async {
    final pdf = pw.Document();
    pdf.addPage(pw.Page(build: (_) => pw.Text(invoice.invoiceNumber)));
    return await pdf.save();
  }
}
