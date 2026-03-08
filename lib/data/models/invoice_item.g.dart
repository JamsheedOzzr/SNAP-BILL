// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InvoiceItemImpl _$$InvoiceItemImplFromJson(Map<String, dynamic> json) =>
    _$InvoiceItemImpl(
      id: json['id'] as String,
      desc: json['desc'] as String,
      note: json['note'] as String? ?? '',
      qty: (json['qty'] as num?)?.toInt() ?? 1,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$InvoiceItemImplToJson(_$InvoiceItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'desc': instance.desc,
      'note': instance.note,
      'qty': instance.qty,
      'price': instance.price,
    };
