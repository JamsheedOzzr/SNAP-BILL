// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claude_ocr_datasource.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$anthropicDioHash() => r'cb5b1ba8985a2e7c63e424bc6804e975278939b5';

/// Provides a singleton Dio instance configured for the Anthropic API
///
/// Copied from [anthropicDio].
@ProviderFor(anthropicDio)
final anthropicDioProvider = AutoDisposeProvider<Dio>.internal(
  anthropicDio,
  name: r'anthropicDioProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$anthropicDioHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AnthropicDioRef = AutoDisposeProviderRef<Dio>;
String _$claudeOcrDatasourceHash() =>
    r'4ff5925850f6ffb94759f325e93c81619622c8ef';

/// Datasource responsible for calling Claude Vision API with a receipt image
///
/// Copied from [claudeOcrDatasource].
@ProviderFor(claudeOcrDatasource)
final claudeOcrDatasourceProvider =
    AutoDisposeProvider<ClaudeOcrDatasource>.internal(
  claudeOcrDatasource,
  name: r'claudeOcrDatasourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$claudeOcrDatasourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ClaudeOcrDatasourceRef = AutoDisposeProviderRef<ClaudeOcrDatasource>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
