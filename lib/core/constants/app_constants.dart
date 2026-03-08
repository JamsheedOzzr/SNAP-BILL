abstract class AppConstants {
  // ── API ──────────────────────────────────────────────────
  static const String claudeBaseUrl = 'https://api.anthropic.com';
  static const String claudeMessagesEndpoint = '/v1/messages';
  static const String claudeModel = 'claude-sonnet-4-20250514';
  static const int claudeMaxTokens = 1024;
  static const String anthropicVersion = '2023-06-01';

  // Store your key in --dart-define or a .env file; never hard-code in prod
  static const String claudeApiKey = String.fromEnvironment(
    'CLAUDE_API_KEY',
    defaultValue: '',
  );

  // ── Hive Box Names ───────────────────────────────────────
  static const String invoiceBox = 'invoices';
  static const String settingsBox = 'settings';

  // ── Shared Prefs Keys ────────────────────────────────────
  static const String prefApiKey = 'api_key';
  static const String prefCurrency = 'currency';
  static const String prefBusinessName = 'business_name';

  // ── Invoice Defaults ─────────────────────────────────────
  static const String defaultCurrency = '₹';
  static const double defaultTaxRate = 0.0;

  // ── Image Constraints ────────────────────────────────────
  static const int maxImageSizeMb = 10;
  static const int imageQuality = 85;

  // ── OCR Prompt ───────────────────────────────────────────
  static const String ocrSystemPrompt = '''
You are a precise OCR engine specialized in reading handwritten and printed receipts/bills.

Extract ALL line items from the provided image and return ONLY a valid JSON object with this exact structure — no markdown, no explanation, no extra text:

{
  "business_name": "string or empty",
  "address": "string or empty",
  "date": "string or empty",
  "items": [
    {
      "desc": "item description",
      "note": "sub-description or empty",
      "qty": 1,
      "price": 0.0
    }
  ]
}

Rules:
- qty must be a positive integer
- price must be a positive number (unit price, not total)
- If a field is unclear, make a best guess
- Include ALL line items, including taxes and service charges
''';
}
