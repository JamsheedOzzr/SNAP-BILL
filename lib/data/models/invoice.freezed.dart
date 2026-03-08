// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invoice.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Invoice _$InvoiceFromJson(Map<String, dynamic> json) {
  return _Invoice.fromJson(json);
}

/// @nodoc
mixin _$Invoice {
  String get id => throw _privateConstructorUsedError;
  String get invoiceNumber => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get businessName => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get originalReceiptPath => throw _privateConstructorUsedError;
  List<InvoiceItem> get items => throw _privateConstructorUsedError;
  double get taxRate => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  String get notes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InvoiceCopyWith<Invoice> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvoiceCopyWith<$Res> {
  factory $InvoiceCopyWith(Invoice value, $Res Function(Invoice) then) =
      _$InvoiceCopyWithImpl<$Res, Invoice>;
  @useResult
  $Res call(
      {String id,
      String invoiceNumber,
      DateTime createdAt,
      String businessName,
      String address,
      String originalReceiptPath,
      List<InvoiceItem> items,
      double taxRate,
      String currency,
      String notes});
}

/// @nodoc
class _$InvoiceCopyWithImpl<$Res, $Val extends Invoice>
    implements $InvoiceCopyWith<$Res> {
  _$InvoiceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? invoiceNumber = null,
    Object? createdAt = null,
    Object? businessName = null,
    Object? address = null,
    Object? originalReceiptPath = null,
    Object? items = null,
    Object? taxRate = null,
    Object? currency = null,
    Object? notes = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      invoiceNumber: null == invoiceNumber
          ? _value.invoiceNumber
          : invoiceNumber // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      businessName: null == businessName
          ? _value.businessName
          : businessName // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      originalReceiptPath: null == originalReceiptPath
          ? _value.originalReceiptPath
          : originalReceiptPath // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<InvoiceItem>,
      taxRate: null == taxRate
          ? _value.taxRate
          : taxRate // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InvoiceImplCopyWith<$Res> implements $InvoiceCopyWith<$Res> {
  factory _$$InvoiceImplCopyWith(
          _$InvoiceImpl value, $Res Function(_$InvoiceImpl) then) =
      __$$InvoiceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String invoiceNumber,
      DateTime createdAt,
      String businessName,
      String address,
      String originalReceiptPath,
      List<InvoiceItem> items,
      double taxRate,
      String currency,
      String notes});
}

/// @nodoc
class __$$InvoiceImplCopyWithImpl<$Res>
    extends _$InvoiceCopyWithImpl<$Res, _$InvoiceImpl>
    implements _$$InvoiceImplCopyWith<$Res> {
  __$$InvoiceImplCopyWithImpl(
      _$InvoiceImpl _value, $Res Function(_$InvoiceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? invoiceNumber = null,
    Object? createdAt = null,
    Object? businessName = null,
    Object? address = null,
    Object? originalReceiptPath = null,
    Object? items = null,
    Object? taxRate = null,
    Object? currency = null,
    Object? notes = null,
  }) {
    return _then(_$InvoiceImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      invoiceNumber: null == invoiceNumber
          ? _value.invoiceNumber
          : invoiceNumber // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      businessName: null == businessName
          ? _value.businessName
          : businessName // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      originalReceiptPath: null == originalReceiptPath
          ? _value.originalReceiptPath
          : originalReceiptPath // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<InvoiceItem>,
      taxRate: null == taxRate
          ? _value.taxRate
          : taxRate // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InvoiceImpl implements _Invoice {
  const _$InvoiceImpl(
      {required this.id,
      required this.invoiceNumber,
      required this.createdAt,
      this.businessName = '',
      this.address = '',
      this.originalReceiptPath = '',
      final List<InvoiceItem> items = const [],
      this.taxRate = 0.0,
      this.currency = '₹',
      this.notes = ''})
      : _items = items;

  factory _$InvoiceImpl.fromJson(Map<String, dynamic> json) =>
      _$$InvoiceImplFromJson(json);

  @override
  final String id;
  @override
  final String invoiceNumber;
  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final String businessName;
  @override
  @JsonKey()
  final String address;
  @override
  @JsonKey()
  final String originalReceiptPath;
  final List<InvoiceItem> _items;
  @override
  @JsonKey()
  List<InvoiceItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey()
  final double taxRate;
  @override
  @JsonKey()
  final String currency;
  @override
  @JsonKey()
  final String notes;

  @override
  String toString() {
    return 'Invoice(id: $id, invoiceNumber: $invoiceNumber, createdAt: $createdAt, businessName: $businessName, address: $address, originalReceiptPath: $originalReceiptPath, items: $items, taxRate: $taxRate, currency: $currency, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvoiceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.invoiceNumber, invoiceNumber) ||
                other.invoiceNumber == invoiceNumber) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.businessName, businessName) ||
                other.businessName == businessName) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.originalReceiptPath, originalReceiptPath) ||
                other.originalReceiptPath == originalReceiptPath) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.taxRate, taxRate) || other.taxRate == taxRate) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      invoiceNumber,
      createdAt,
      businessName,
      address,
      originalReceiptPath,
      const DeepCollectionEquality().hash(_items),
      taxRate,
      currency,
      notes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InvoiceImplCopyWith<_$InvoiceImpl> get copyWith =>
      __$$InvoiceImplCopyWithImpl<_$InvoiceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InvoiceImplToJson(
      this,
    );
  }
}

abstract class _Invoice implements Invoice {
  const factory _Invoice(
      {required final String id,
      required final String invoiceNumber,
      required final DateTime createdAt,
      final String businessName,
      final String address,
      final String originalReceiptPath,
      final List<InvoiceItem> items,
      final double taxRate,
      final String currency,
      final String notes}) = _$InvoiceImpl;

  factory _Invoice.fromJson(Map<String, dynamic> json) = _$InvoiceImpl.fromJson;

  @override
  String get id;
  @override
  String get invoiceNumber;
  @override
  DateTime get createdAt;
  @override
  String get businessName;
  @override
  String get address;
  @override
  String get originalReceiptPath;
  @override
  List<InvoiceItem> get items;
  @override
  double get taxRate;
  @override
  String get currency;
  @override
  String get notes;
  @override
  @JsonKey(ignore: true)
  _$$InvoiceImplCopyWith<_$InvoiceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
