// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ocr_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OcrResult _$OcrResultFromJson(Map<String, dynamic> json) {
  return _OcrResult.fromJson(json);
}

/// @nodoc
mixin _$OcrResult {
  String get businessName => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  List<OcrLineItem> get items => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OcrResultCopyWith<OcrResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OcrResultCopyWith<$Res> {
  factory $OcrResultCopyWith(OcrResult value, $Res Function(OcrResult) then) =
      _$OcrResultCopyWithImpl<$Res, OcrResult>;
  @useResult
  $Res call(
      {String businessName,
      String address,
      String date,
      List<OcrLineItem> items});
}

/// @nodoc
class _$OcrResultCopyWithImpl<$Res, $Val extends OcrResult>
    implements $OcrResultCopyWith<$Res> {
  _$OcrResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? businessName = null,
    Object? address = null,
    Object? date = null,
    Object? items = null,
  }) {
    return _then(_value.copyWith(
      businessName: null == businessName
          ? _value.businessName
          : businessName // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<OcrLineItem>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OcrResultImplCopyWith<$Res>
    implements $OcrResultCopyWith<$Res> {
  factory _$$OcrResultImplCopyWith(
          _$OcrResultImpl value, $Res Function(_$OcrResultImpl) then) =
      __$$OcrResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String businessName,
      String address,
      String date,
      List<OcrLineItem> items});
}

/// @nodoc
class __$$OcrResultImplCopyWithImpl<$Res>
    extends _$OcrResultCopyWithImpl<$Res, _$OcrResultImpl>
    implements _$$OcrResultImplCopyWith<$Res> {
  __$$OcrResultImplCopyWithImpl(
      _$OcrResultImpl _value, $Res Function(_$OcrResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? businessName = null,
    Object? address = null,
    Object? date = null,
    Object? items = null,
  }) {
    return _then(_$OcrResultImpl(
      businessName: null == businessName
          ? _value.businessName
          : businessName // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<OcrLineItem>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OcrResultImpl implements _OcrResult {
  const _$OcrResultImpl(
      {this.businessName = '',
      this.address = '',
      this.date = '',
      final List<OcrLineItem> items = const []})
      : _items = items;

  factory _$OcrResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$OcrResultImplFromJson(json);

  @override
  @JsonKey()
  final String businessName;
  @override
  @JsonKey()
  final String address;
  @override
  @JsonKey()
  final String date;
  final List<OcrLineItem> _items;
  @override
  @JsonKey()
  List<OcrLineItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'OcrResult(businessName: $businessName, address: $address, date: $date, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OcrResultImpl &&
            (identical(other.businessName, businessName) ||
                other.businessName == businessName) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.date, date) || other.date == date) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, businessName, address, date,
      const DeepCollectionEquality().hash(_items));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OcrResultImplCopyWith<_$OcrResultImpl> get copyWith =>
      __$$OcrResultImplCopyWithImpl<_$OcrResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OcrResultImplToJson(
      this,
    );
  }
}

abstract class _OcrResult implements OcrResult {
  const factory _OcrResult(
      {final String businessName,
      final String address,
      final String date,
      final List<OcrLineItem> items}) = _$OcrResultImpl;

  factory _OcrResult.fromJson(Map<String, dynamic> json) =
      _$OcrResultImpl.fromJson;

  @override
  String get businessName;
  @override
  String get address;
  @override
  String get date;
  @override
  List<OcrLineItem> get items;
  @override
  @JsonKey(ignore: true)
  _$$OcrResultImplCopyWith<_$OcrResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OcrLineItem _$OcrLineItemFromJson(Map<String, dynamic> json) {
  return _OcrLineItem.fromJson(json);
}

/// @nodoc
mixin _$OcrLineItem {
  String get desc => throw _privateConstructorUsedError;
  String get note => throw _privateConstructorUsedError;
  int get qty => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OcrLineItemCopyWith<OcrLineItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OcrLineItemCopyWith<$Res> {
  factory $OcrLineItemCopyWith(
          OcrLineItem value, $Res Function(OcrLineItem) then) =
      _$OcrLineItemCopyWithImpl<$Res, OcrLineItem>;
  @useResult
  $Res call({String desc, String note, int qty, double price});
}

/// @nodoc
class _$OcrLineItemCopyWithImpl<$Res, $Val extends OcrLineItem>
    implements $OcrLineItemCopyWith<$Res> {
  _$OcrLineItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? desc = null,
    Object? note = null,
    Object? qty = null,
    Object? price = null,
  }) {
    return _then(_value.copyWith(
      desc: null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
      qty: null == qty
          ? _value.qty
          : qty // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OcrLineItemImplCopyWith<$Res>
    implements $OcrLineItemCopyWith<$Res> {
  factory _$$OcrLineItemImplCopyWith(
          _$OcrLineItemImpl value, $Res Function(_$OcrLineItemImpl) then) =
      __$$OcrLineItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String desc, String note, int qty, double price});
}

/// @nodoc
class __$$OcrLineItemImplCopyWithImpl<$Res>
    extends _$OcrLineItemCopyWithImpl<$Res, _$OcrLineItemImpl>
    implements _$$OcrLineItemImplCopyWith<$Res> {
  __$$OcrLineItemImplCopyWithImpl(
      _$OcrLineItemImpl _value, $Res Function(_$OcrLineItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? desc = null,
    Object? note = null,
    Object? qty = null,
    Object? price = null,
  }) {
    return _then(_$OcrLineItemImpl(
      desc: null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
      qty: null == qty
          ? _value.qty
          : qty // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OcrLineItemImpl implements _OcrLineItem {
  const _$OcrLineItemImpl(
      {this.desc = '', this.note = '', this.qty = 1, this.price = 0.0});

  factory _$OcrLineItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$OcrLineItemImplFromJson(json);

  @override
  @JsonKey()
  final String desc;
  @override
  @JsonKey()
  final String note;
  @override
  @JsonKey()
  final int qty;
  @override
  @JsonKey()
  final double price;

  @override
  String toString() {
    return 'OcrLineItem(desc: $desc, note: $note, qty: $qty, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OcrLineItemImpl &&
            (identical(other.desc, desc) || other.desc == desc) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.qty, qty) || other.qty == qty) &&
            (identical(other.price, price) || other.price == price));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, desc, note, qty, price);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OcrLineItemImplCopyWith<_$OcrLineItemImpl> get copyWith =>
      __$$OcrLineItemImplCopyWithImpl<_$OcrLineItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OcrLineItemImplToJson(
      this,
    );
  }
}

abstract class _OcrLineItem implements OcrLineItem {
  const factory _OcrLineItem(
      {final String desc,
      final String note,
      final int qty,
      final double price}) = _$OcrLineItemImpl;

  factory _OcrLineItem.fromJson(Map<String, dynamic> json) =
      _$OcrLineItemImpl.fromJson;

  @override
  String get desc;
  @override
  String get note;
  @override
  int get qty;
  @override
  double get price;
  @override
  @JsonKey(ignore: true)
  _$$OcrLineItemImplCopyWith<_$OcrLineItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
