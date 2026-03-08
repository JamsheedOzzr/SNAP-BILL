import 'package:freezed_annotation/freezed_annotation.dart';

part 'invoice_item.freezed.dart';
part 'invoice_item.g.dart';

@freezed
class InvoiceItem with _$InvoiceItem {
  const factory InvoiceItem({
    required String id,
    required String desc,
    @Default('') String note,
    @Default(1) int qty,
    @Default(0.0) double price,
  }) = _InvoiceItem;

  factory InvoiceItem.fromJson(Map<String, dynamic> json) =>
      _$InvoiceItemFromJson(json);
}

extension InvoiceItemX on InvoiceItem {
  double get total => qty * price;
}
