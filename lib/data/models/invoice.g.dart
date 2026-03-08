// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InvoiceImpl _$$InvoiceImplFromJson(Map<String, dynamic> json) =>
    _$InvoiceImpl(
      id: json['id'] as String,
      invoiceNumber: json['invoiceNumber'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      businessName: json['businessName'] as String? ?? '',
      address: json['address'] as String? ?? '',
      originalReceiptPath: json['originalReceiptPath'] as String? ?? '',
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => InvoiceItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      taxRate: (json['taxRate'] as num?)?.toDouble() ?? 0.0,
      currency: json['currency'] as String? ?? '₹',
      notes: json['notes'] as String? ?? '',
    );

Map<String, dynamic> _$$InvoiceImplToJson(_$InvoiceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'invoiceNumber': instance.invoiceNumber,
      'createdAt': instance.createdAt.toIso8601String(),
      'businessName': instance.businessName,
      'address': instance.address,
      'originalReceiptPath': instance.originalReceiptPath,
      'items': instance.items,
      'taxRate': instance.taxRate,
      'currency': instance.currency,
      'notes': instance.notes,
    };
