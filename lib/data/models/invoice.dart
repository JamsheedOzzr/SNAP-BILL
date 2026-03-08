import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snap_bill/data/models/invoice_item.dart';

part 'invoice.freezed.dart';
part 'invoice.g.dart';

@freezed
class Invoice with _$Invoice {
  const factory Invoice({
    required String id,
    required String invoiceNumber,
    required DateTime createdAt,
    @Default('') String businessName,
    @Default('') String address,
    @Default('') String originalReceiptPath,
    @Default([]) List<InvoiceItem> items,
    @Default(0.0) double taxRate,
    @Default('₹') String currency,
    @Default('') String notes,
  }) = _Invoice;

  factory Invoice.fromJson(Map<String, dynamic> json) =>
      _$InvoiceFromJson(json);
}

extension InvoiceX on Invoice {
  double get subtotal =>
      items.fold(0, (sum, item) => sum + item.total);

  double get taxAmount => subtotal * taxRate;

  double get grandTotal => subtotal + taxAmount;

  String get formattedDate {
    final d = createdAt;
    const months = [
      'Jan','Feb','Mar','Apr','May','Jun',
      'Jul','Aug','Sep','Oct','Nov','Dec'
    ];
    return '${months[d.month - 1]} ${d.day}, ${d.year}';
  }
}
