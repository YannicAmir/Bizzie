# Manual Verification for Stock Search

## Prerequisites
- Physical Device or Emulator with Internet.
- `adb logcat` or Android Studio Logcat visible (for "App Launch" logs).

## Test Case 1: Fresh Install Sync (First Launch)
1.  **Preparation**: Uninstall the app from the device.
2.  **Action**: Install and Launch the app.
3.  **Observation**:
    - Observe the "Home" or "Landing" screen.
    - Check Logcat/Console for: `I/StockRepository: Downloading stock list...` (or similar network activity).
    - **Verify File**: using Device File Explorer (Android Studio) or `xcrun simctl` (iOS), check `ApplicationDocuments/stock_list.json` exists and size is > 100KB.
4.  **Search**: Open Search. Type "AAP". Verify "AAPL" appears.

## Test Case 2: Offline Start (Cached)
1.  **Preparation**: Ensure Test Case 1 passed. **Turn off Wi-Fi/Data**.
2.  **Action**: Force Kill app. Restart app.
3.  **Observation**:
    - App opens instantly.
    - Go to Search.
    - Type "TSL".
    - Verify "TSLA" appears.
    - **Pass**: Search works without internet using cached file.

## Test Case 3: Silent Auto-Update
1.  **Preparation**:
    - Connect to Internet.
    - (Advanced) Manually edit `shared_preferences` XML/plist to set `stock_list_last_updated` to `0`.
2.  **Action**: Restart App.
3.  **Observation**:
    - App opens without explicit loading spinner.
    - Verify in logs that a download happens in background.
    - Verify `shared_preferences` timestamp is updated to current time.

## Test Case 4: Ranking Logic
1.  **Action**: Open Search.
2.  **Input**: Type "A".
3.  **Verify Order**:
    - **Top Results**: Should be Symbols starting with "A" (e.g. `A`, `AA`, `AAPL`).
    - **Next Results**: Names starting with "A" (e.g. `Agilent Technologies`).
    - **Last Results**: Symbols/Names containing "A" (e.g. `Tesla` - contains 'a').
