import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:snap_bill/data/datasources/claude_ocr_datasource.dart';
import 'package:snap_bill/data/models/invoice.dart';
import 'package:snap_bill/data/models/invoice_item.dart';
import 'package:snap_bill/data/models/ocr_result.dart';

part 'invoice_repository.g.dart';

@riverpod
InvoiceRepository invoiceRepository(InvoiceRepositoryRef ref) {
  final ocrDatasource = ref.watch(claudeOcrDatasourceProvider);
  return InvoiceRepository(ocrDatasource);
}

class InvoiceRepository {
  const InvoiceRepository(this._ocrDatasource);

  final ClaudeOcrDatasource _ocrDatasource;

  static const _uuid = Uuid();

  /// Calls OCR on [imageFile] and returns a fully-formed [Invoice].
  Future<Invoice> createInvoiceFromImage(File imageFile) async {
    final ocrResult = await _ocrDatasource.extractFromImage(imageFile);
    return _buildInvoice(ocrResult, originalPath: imageFile.path);
  }

  /// Builds a demo invoice without hitting the API.
  Invoice createDemoInvoice() {
    return _buildInvoice(
      OcrResult(
        businessName: 'Hotel Saravana Bhavan',
        address: '23, Anna Salai, Chennai',
        date: 'Today',
        items: const [
          OcrLineItem(desc: 'Masala Dosa', note: 'Fresh & crispy', qty: 2, price: 120),
          OcrLineItem(desc: 'Filter Coffee', qty: 3, price: 40),
          OcrLineItem(desc: 'Idly (2 pcs)', note: 'Served with sambar', qty: 1, price: 80),
          OcrLineItem(desc: 'Vada', qty: 2, price: 55),
          OcrLineItem(desc: 'Service Charge', qty: 1, price: 50),
        ],
      ),
    );
  }

  Invoice _buildInvoice(OcrResult ocr, {String originalPath = ''}) {
    final items = ocr.items.map((i) {
      return InvoiceItem(
        id: _uuid.v4(),
        desc: i.desc,
        note: i.note,
        qty: i.qty,
        price: i.price,
      );
    }).toList();

    final invoiceNumber =
        'INV-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';

    return Invoice(
      id: _uuid.v4(),
      invoiceNumber: invoiceNumber,
      createdAt: DateTime.now(),
      businessName: ocr.businessName,
      address: ocr.address,
      originalReceiptPath: originalPath,
      items: items,
    );
  }
}
