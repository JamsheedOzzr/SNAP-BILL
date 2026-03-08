import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:snap_bill/core/constants/app_constants.dart';
import 'package:snap_bill/data/models/ocr_result.dart';

part 'claude_ocr_datasource.g.dart';

/// Provides a singleton Dio instance configured for the Anthropic API
@riverpod
Dio anthropicDio(AnthropicDioRef ref) {
  return Dio(BaseOptions(
    baseUrl: AppConstants.claudeBaseUrl,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 60),
    headers: {
      'x-api-key': AppConstants.claudeApiKey,
      'anthropic-version': AppConstants.anthropicVersion,
      'content-type': 'application/json',
    },
  ));
}

/// Datasource responsible for calling Claude Vision API with a receipt image
@riverpod
ClaudeOcrDatasource claudeOcrDatasource(ClaudeOcrDatasourceRef ref) {
  final dio = ref.watch(anthropicDioProvider);
  return ClaudeOcrDatasource(dio);
}

class ClaudeOcrDatasource {
  const ClaudeOcrDatasource(this._dio);

  final Dio _dio;

  /// Sends [imageFile] to Claude Vision and returns a parsed [OcrResult].
  Future<OcrResult> extractFromImage(File imageFile) async {
    // Read & base64-encode the image
    final bytes = await imageFile.readAsBytes();
    final base64Image = base64Encode(bytes);
    final mimeType = _mimeType(imageFile.path);

    final body = {
      'model': AppConstants.claudeModel,
      'max_tokens': AppConstants.claudeMaxTokens,
      'messages': [
        {
          'role': 'user',
          'content': [
            {
              'type': 'image',
              'source': {
                'type': 'base64',
                'media_type': mimeType,
                'data': base64Image,
              },
            },
            {
              'type': 'text',
              'text': AppConstants.ocrSystemPrompt,
            },
          ],
        },
      ],
    };

    final response = await _dio.post<Map<String, dynamic>>(
      AppConstants.claudeMessagesEndpoint,
      data: body,
    );

    if (response.statusCode != 200 || response.data == null) {
      throw OcrException(
        'API returned status ${response.statusCode}',
      );
    }

    return _parseResponse(response.data!);
  }

  OcrResult _parseResponse(Map<String, dynamic> data) {
    try {
      // Claude returns content as a list; grab first text block
      final contentList = data['content'] as List<dynamic>?;
      if (contentList == null || contentList.isEmpty) {
        throw const OcrException('Empty content from API');
      }

      final rawText = contentList
          .whereType<Map<String, dynamic>>()
          .where((c) => c['type'] == 'text')
          .map<String>((c) => c['text'] as String? ?? '')
          .join();

      // Strip possible markdown code fences
      final cleaned = rawText
          .replaceAll(RegExp(r'```json'), '')
          .replaceAll(RegExp(r'```'), '')
          .trim();

      final json = jsonDecode(cleaned) as Map<String, dynamic>;
      return OcrResult.fromJson(json);
    } catch (e) {
      throw OcrException('Failed to parse OCR response: $e');
    }
  }

  String _mimeType(String path) {
    final ext = path.split('.').last.toLowerCase();
    return switch (ext) {
      'jpg' || 'jpeg' => 'image/jpeg',
      'png' => 'image/png',
      'webp' => 'image/webp',
      'gif' => 'image/gif',
      _ => 'image/jpeg',
    };
  }
}

class OcrException implements Exception {
  const OcrException(this.message);
  final String message;

  @override
  String toString() => 'OcrException: $message';
}
