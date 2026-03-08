import 'package:freezed_annotation/freezed_annotation.dart';

part 'ocr_result.freezed.dart';
part 'ocr_result.g.dart';

/// Raw OCR result returned from the Claude Vision API
@freezed
class OcrResult with _$OcrResult {
  const factory OcrResult({
    @Default('') String businessName,
    @Default('') String address,
    @Default('') String date,
    @Default([]) List<OcrLineItem> items,
  }) = _OcrResult;

  factory OcrResult.fromJson(Map<String, dynamic> json) =>
      _$OcrResultFromJson(json);

  factory OcrResult.empty() => const OcrResult();
}

@freezed
class OcrLineItem with _$OcrLineItem {
  const factory OcrLineItem({
    @Default('') String desc,
    @Default('') String note,
    @Default(1) int qty,
    @Default(0.0) double price,
  }) = _OcrLineItem;

  factory OcrLineItem.fromJson(Map<String, dynamic> json) =>
      _$OcrLineItemFromJson(json);
}
