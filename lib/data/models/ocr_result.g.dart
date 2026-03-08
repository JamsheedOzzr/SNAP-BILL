// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ocr_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OcrResultImpl _$$OcrResultImplFromJson(Map<String, dynamic> json) =>
    _$OcrResultImpl(
      businessName: json['businessName'] as String? ?? '',
      address: json['address'] as String? ?? '',
      date: json['date'] as String? ?? '',
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => OcrLineItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$OcrResultImplToJson(_$OcrResultImpl instance) =>
    <String, dynamic>{
      'businessName': instance.businessName,
      'address': instance.address,
      'date': instance.date,
      'items': instance.items,
    };

_$OcrLineItemImpl _$$OcrLineItemImplFromJson(Map<String, dynamic> json) =>
    _$OcrLineItemImpl(
      desc: json['desc'] as String? ?? '',
      note: json['note'] as String? ?? '',
      qty: (json['qty'] as num?)?.toInt() ?? 1,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$OcrLineItemImplToJson(_$OcrLineItemImpl instance) =>
    <String, dynamic>{
      'desc': instance.desc,
      'note': instance.note,
      'qty': instance.qty,
      'price': instance.price,
    };
