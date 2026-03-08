# Snap & Bill — Flutter + Riverpod Workflow

## Project Structure

```
lib/
├── main.dart                          # App entry point + ProviderScope
│
├── core/
│   ├── constants/app_constants.dart   # API keys, endpoints, OCR prompt
│   ├── router/app_router.dart         # GoRouter + @riverpod provider
│   ├── theme/app_theme.dart           # Colors, text styles, spacing
│   └── utils/                        # Formatters, helpers
│
├── data/
│   ├── models/
│   │   ├── invoice.dart              # @freezed Invoice model
│   │   ├── invoice_item.dart         # @freezed InvoiceItem model
│   │   └── ocr_result.dart           # @freezed OcrResult model
│   ├── datasources/
│   │   └── claude_ocr_datasource.dart  # Calls Claude Vision API
│   └── repositories/
│       └── invoice_repository.dart     # OCR → Invoice mapping
│
└── features/
    ├── upload/                       # Phase 01
    ├── scan/                         # Phase 02
    ├── invoice/                      # Phase 03
    └── export/                       # Phase 04
```

---

## Riverpod Provider Map

```
┌─────────────────────────────────────────────────────────────┐
│                        PROVIDER TREE                        │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  anthropicDioProvider                                       │
│    └─► claudeOcrDatasourceProvider                          │
│          └─► invoiceRepositoryProvider                      │
│                                                             │
│  uploadNotifierProvider  ◄──── UploadScreen                 │
│    (UploadState)                                            │
│       • selectedImage: File?                                │
│       • isDemo: bool                                        │
│                                                             │
│  scanNotifierProvider  ◄──── ScanScreen                     │
│    (ScanState)                                              │
│       • currentStep: ScanStep                               │
│       • errorMessage: String                                │
│                 │                                           │
│                 ▼ writes to                                 │
│  currentInvoiceProvider   (Invoice?)                        │
│    ▲─────────────────────────────────┐                      │
│    │                                 │                      │
│  invoiceProvider (non-null guard)    │ clearance on new scan│
│    ├─► invoiceItemsProvider          │                      │
│    └─► invoiceTotalsProvider         │                      │
│                                      │                      │
│  invoiceEditorProvider  ◄──── InvoiceScreen                 │
│    (isDirty: bool)                   │                      │
│       • addItem / removeItem         │                      │
│       • updateQty / updatePrice      │                      │
│       • updateBusinessName           │                      │
│                                      │                      │
│  exportNotifierProvider  ◄──── ExportScreen                 │
│    (ExportStatus sealed class)       │                      │
│       • ExportIdle                   │                      │
│       • ExportLoading                │                      │
│       • ExportSuccess(message)       │                      │
│       • ExportFailure(error)         │                      │
│                                      │                      │
│  appRouterProvider  ◄──── main.dart  │                      │
│    (GoRouter)          MaterialApp   │                      │
└──────────────────────────────────────┴──────────────────────┘
```

---

## User Flow (5 Phases)

```
Phase 01 — UPLOAD
─────────────────
User opens app (UploadScreen)
    │
    ├── Taps "Select File"
    │     └── image_picker → gallery
    │           └── uploadNotifier.pickFromGallery()
    │                 └── state = UploadState(selectedImage: File)
    │
    ├── Taps "Take a photo"
    │     └── image_picker → camera
    │           └── uploadNotifier.captureFromCamera()
    │
    └── Taps "Try Demo"
          └── uploadNotifier.useDemo()
                └── state = UploadState(isDemo: true)
    │
    ▼
Taps "Analyze Receipt"
    └── GoRouter.push('/scan')


Phase 02 — SCAN (OCR)
──────────────────────
ScanScreen.initState()
    └── scanNotifier.startScan()
          │
          ├── Step: preprocessing  (800ms simulated)
          ├── Step: detectingText  (800ms simulated)
          ├── Step: runningOcr
          │     └── if isDemo → invoiceRepository.createDemoInvoice()
          │         else      → invoiceRepository.createInvoiceFromImage(file)
          │                         └── claudeOcrDatasource.extractFromImage()
          │                               └── POST /v1/messages (Claude Vision)
          │                                     └── parse JSON → OcrResult
          │                                           └── map → Invoice
          ├── Step: parsingData    (800ms simulated)
          └── Step: done
                └── currentInvoiceProvider.setInvoice(invoice)
                └── GoRouter.pushReplacement('/invoice')


Phase 03 — INVOICE EDITOR
──────────────────────────
InvoiceScreen
    │
    ├── Reads: invoiceProvider (currentInvoice)
    ├── Reads: invoiceItemsProvider
    ├── Reads: invoiceTotalsProvider (live subtotal / tax / grand)
    │
    └── invoiceEditorProvider.notifier
          ├── addItem()             → appends InvoiceItem to list
          ├── removeItem(id)        → filters list
          ├── incrementQty(id)      → qty++
          ├── decrementQty(id)      → qty-- (min 1)
          ├── updateItemPrice(id)   → recomputes totals
          ├── updateItemDesc(id)    → updates description
          └── markSaved()           → isDirty = false
    │
    ▼
Taps "Review & Export"
    └── GoRouter.push('/export')


Phase 04 — EXPORT
──────────────────
ExportScreen
    │
    ├── Reads: invoiceProvider (summary display)
    ├── Reads: invoiceTotalsProvider
    │
    └── exportNotifier.export(format)
          ├── ExportFormat.pdf
          │     └── pdf package → builds A4 page
          │           └── save to documents/
          │                 └── share_plus → Share sheet
          │
          ├── ExportFormat.json
          │     └── invoice.toJson()
          │           └── Clipboard.setData()
          │
          └── ExportFormat.print
                └── printing.layoutPdf()


Phase 05 — NEW SCAN
─────────────────────
Taps "Scan New Receipt"
    └── uploadNotifier.clear()
    └── scanNotifier.reset()
    └── currentInvoiceProvider.clear()
    └── GoRouter.go('/') ← full stack reset
```

---

## Data Flow Diagram

```
Camera / Gallery
      │
      ▼ File
UploadNotifier
      │
      ▼ File
InvoiceRepository
      │
      ▼ File (base64)
ClaudeOcrDatasource
      │  POST /v1/messages
      │  { image: base64, prompt: OCR_PROMPT }
      ▼ JSON string
Claude Vision API
      │
      ▼ OcrResult
InvoiceRepository.buildInvoice()
      │
      ▼ Invoice (Freezed model)
currentInvoiceProvider
      │
      ├──► invoiceItemsProvider
      ├──► invoiceTotalsProvider
      └──► invoiceEditorProvider  ──► mutates Invoice items
                                         │
                                         ▼
                                   ExportNotifier
                                         │
                              ┌──────────┼──────────┐
                              ▼          ▼           ▼
                            PDF        JSON        Print
                         (share_plus) (clipboard) (printing)
```

---

## Code Generation Commands

```bash
# Generate all .g.dart and .freezed.dart files:
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode during development:
flutter pub run build_runner watch --delete-conflicting-outputs
```

## Files that need generation (`.g.dart` + `.freezed.dart`)

| File | Generated |
|------|-----------|
| `invoice.dart` | `invoice.g.dart`, `invoice.freezed.dart` |
| `invoice_item.dart` | `invoice_item.g.dart`, `invoice_item.freezed.dart` |
| `ocr_result.dart` | `ocr_result.g.dart`, `ocr_result.freezed.dart` |
| `claude_ocr_datasource.dart` | `claude_ocr_datasource.g.dart` |
| `invoice_repository.dart` | `invoice_repository.g.dart` |
| `app_router.dart` | `app_router.g.dart` |
| `upload_provider.dart` | `upload_provider.g.dart`, `upload_provider.freezed.dart` |
| `scan_provider.dart` | `scan_provider.g.dart`, `scan_provider.freezed.dart` |
| `invoice_provider.dart` | `invoice_provider.g.dart` |
| `export_provider.dart` | `export_provider.g.dart` |

---

## Running the App

```bash
# Set API key via --dart-define (never hardcode in production)
flutter run --dart-define=CLAUDE_API_KEY=your_key_here

# Build release APK
flutter build apk --dart-define=CLAUDE_API_KEY=your_key_here

# Build iOS
flutter build ios --dart-define=CLAUDE_API_KEY=your_key_here
```

## Android Permissions (AndroidManifest.xml)

```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.INTERNET" />
```

## iOS Permissions (Info.plist)

```xml
<key>NSCameraUsageDescription</key>
<string>Snap & Bill needs camera to scan receipts</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>Snap & Bill needs photo library to pick receipts</string>
```
