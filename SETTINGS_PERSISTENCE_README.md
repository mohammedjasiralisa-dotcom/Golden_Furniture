# Settings Persistence Integration - Golden Furniture App

## Overview
The app now has complete end-to-end settings persistence. Users can configure their business information in the Settings screen, and those values are automatically used when generating customer list PDFs.

## Architecture

### 1. **SettingsManager** (`lib/settings_manager.dart`)
**Purpose**: Centralized abstraction layer for persistent storage

**Key Features**:
- Uses `shared_preferences` package for cross-platform key-value storage
- 7 configuration keys: business_name, owner_name, phone_number, email, gst_number, business_address, currency
- **Fallback defaults** ensure app works on first use or after storage clear
- Async/await pattern for all persistence operations

**Default Values**:
```
Business Name: Golden Furniture
Owner Name: Business Owner
Phone Number: +91 9876543210
Email: business@example.com
GST Number: 27AABCU9603R1Z0
Business Address: Chennai, Tamil Nadu
Currency: INR
```

**Methods**:
- `saveBusinessName(String)`, `saveOwnerName(String)`, etc. - Individual save operations
- `saveAllSettings(...)` - Bulk save of all 7 configuration values
- `getBusinessName()`, `getBusinessAddress()`, `getGstNumber()` - Load with fallback defaults
- `getAllSettings()` - Returns Map<String, String> of all saved settings

### 2. **AppSettingsScreen** (`lib/app_settings.dart`)
**Purpose**: User-facing configuration UI

**Workflow**:
1. Screen initialization → `_loadSettings()` async method called
2. `_loadSettings()` fetches all saved values from SettingsManager
3. TextControllers populated with loaded values (or defaults if none exist)
4. User modifies fields → clicks "Save Settings" button
5. `_saveSettings()` calls `SettingsManager.saveAllSettings()` to persist all changes
6. Success snackbar shown to user

**Behavior**:
- On first launch: Shows default values
- On subsequent launches: Shows previously saved configuration
- Changes persist across app sessions and device restarts

### 3. **SidebarMenu PDF Generation** (`lib/sidebar_menu.dart`)
**Purpose**: Generate customer list PDFs using saved business configuration

**Workflow**:
1. User clicks "Export Customer Details (PDF)" menu item
2. `_generateCustomerPDF()` async method called
3. Fetches saved settings: `businessName`, `businessAddress`, `gstNumber`
4. Passes saved values to `PDFGenerator.generateCustomerListPDF(customers, businessName, businessAddress, gstNumber)`
5. PDF is generated with user-configured business information instead of hardcoded defaults

**Error Handling**:
- If no customers exist: Yellow snackbar "No customers to export"
- If PDF generation succeeds: Green snackbar with file location
- If error occurs: Red snackbar with error message

## Complete Flow Example

### Scenario: User changes business name and generates PDF

1. **User navigates to Settings Screen**
   ```
   AppSettingsScreen loads
   → _loadSettings() executed
   → SettingsManager.getBusinessName() returns "Golden Furniture" (default or saved)
   → TextController populated with value
   → Screen displays current business name
   ```

2. **User modifies the business name**
   ```
   User changes "Golden Furniture" → "Raj's Furniture Store"
   Presses "Save Settings" button
   ```

3. **Settings are persisted**
   ```
   _saveSettings() called
   → SettingsManager.saveAllSettings(..., businessName: "Raj's Furniture Store", ...)
   → All 7 values saved to SharedPreferences
   → Success snackbar shown
   ```

4. **Later, user generates PDF**
   ```
   User opens sidebar menu
   Clicks "Export Customer Details (PDF)"
   → _generateCustomerPDF() called
   → Fetches: businessName = await SettingsManager.getBusinessName()
   → Returns: "Raj's Furniture Store" (from SharedPreferences)
   → PDF generated with "Raj's Furniture Store" in header instead of "Golden Furniture"
   ```

## Dependencies Added
- `shared_preferences: ^2.2.0` - Cross-platform local key-value storage

## File Structure
```
lib/
├── settings_manager.dart          [NEW] Core persistence abstraction
├── app_settings.dart              [MODIFIED] Now loads/saves via SettingsManager
├── sidebar_menu.dart              [MODIFIED] Fetches saved settings before PDF generation
├── pdf_generator.dart             [Unchanged] Accepts business config as parameters
├── my_business.dart               [Unchanged] Customer list screen
├── coustumer.dart                 [Unchanged] Add customer form
├── customer_details.dart          [Unchanged] Customer details screen
├── main.dart                       [Unchanged] App entry point
├── strings.dart                    [Unchanged] Translations
└── language.dart                  [Unchanged] Language selection

pubspec.yaml                        [MODIFIED] Added shared_preferences dependency
```

## Testing Checklist

### ✅ Unit Test: Settings Save/Load
```
1. Open Settings Screen
2. Verify all fields show default values
3. Modify Business Name field
4. Click "Save Settings"
5. Verify success snackbar appears
6. Close app completely
7. Reopen app and navigate to Settings
8. Verify Business Name shows the modified value (persisted!)
```

### ✅ Integration Test: Settings → PDF
```
1. Open Settings Screen
2. Change Business Name to "Test Business"
3. Click "Save Settings" (verify success)
4. Add at least one customer in My Business
5. Click menu → "Export Customer Details (PDF)"
6. Verify PDF contains "Test Business" in header
7. Confirm it does NOT contain "Golden Furniture"
```

### ✅ Integration Test: Multiple Settings
```
1. Settings Screen
2. Change: Name, Owner, Phone, Email, GST, Address, Currency
3. Save all changes
4. Close app
5. Reopen and verify all fields retained values
6. Generate PDF and verify at least Name, Address, GST appear in PDF
```

## Known Behaviors

### Default Fallback
If user has never opened Settings or storage is cleared, the app will use hardcoded defaults. This ensures:
- No crashes on first launch
- Consistent user experience
- Grace degradation if storage unavailable

### Async/Await Pattern
All persistence operations use async/await to avoid blocking UI:
- `_loadSettings()` in AppSettingsScreen initiated from `initState()`
- `_generateCustomerPDF()` fetches settings asynchronously
- UI remains responsive during save/load operations

### Platform Compatibility
Settings persist across all platforms (Android, iOS, Web, Windows, Linux, macOS) via SharedPreferences abstraction.

## Future Enhancements
- Customer list persistence to device storage (currently in-memory only)
- User profile picture/logo storage
- Multi-user support with separate settings per user
- Settings backup/restore functionality
- Settings encryption for sensitive data (GST number, email)

## Troubleshooting

### Settings not persisting?
1. Verify `shared_preferences` is installed: `flutter pub get`
2. Check device storage permissions
3. Try: Settings → Clear all → Re-save
4. On web, check browser localStorage enabled

### PDF not showing saved business name?
1. Verify you saved settings first (green snackbar should appear)
2. Check that at least one customer exists
3. Try restarting the app (force refresh cache)
4. Generate PDF again

### App crashes on Settings screen?
1. Run `flutter clean` and `flutter pub get`
2. Verify `SettingsManager.dart` file exists in `lib/` folder
3. Check for any compilation errors: `flutter analyze`
4. Try full rebuild: `flutter run --no-fast-start`

---

**Status**: ✅ Complete and tested
**Last Updated**: Nov 14
**Functionality**: Settings → Storage → PDF Generation chain fully operational
