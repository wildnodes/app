# Wildnodes Mesh Weather App

Offline Android app built with Flutter to fetch weather data from ESP32 mesh nodes. No internet permission. No cloud dependencies. Designed for sideloading into mesh-only environments.

---

## 🚀 Why Flutter?

Flutter is the least painful way to build Android apps without touching Android Studio. Android Studio is bloated, slow, and opaque — Flutter gives you a clean CLI workflow, fast builds, and total control over your app structure. Dart is fast, readable, and avoids the legacy traps of Java-based Android builds.

---

## 🛠 Installing Flutter (Windows)

1. Download SDK from [flutter.dev](https://flutter.dev/docs/get-started/install)
2. Extract to `D:\tools\flutter`
3. Add to PATH:

    ```
    set PATH=%PATH%;D:\tools\flutter\bin
    ```

4. Run:

    ```
    flutter doctor
    ```

Expect errors. You’ll need:

- Git (for Flutter itself)
- Android SDK (can be standalone)
- Platform tools (`adb`, `sdkmanager`, etc.)

---

## ⚙️ Creating the Project

```
flutter create esp32_weather_app
cd esp32_weather_app
```

Then strip out the boilerplate and replace `main.dart` with your own logic.

---

## 📦 Dependencies

Edit `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0
  connectivity_plus: ^5.0.2
```

Optional:

```yaml
  wifi_iot: ^0.3.19
```

Run:

```
flutter pub get
```

---

## 🔥 Common Issues

- **Version mismatches**: Dart, Gradle, SDK — expect pain. Use `flutter doctor` and `flutter pub get` to debug.
- **Wrong JSON format**: ESP32 must serve valid JSON at `/data.json`. If you get `FormatException`, check for trailing commas or malformed keys.
- **SSID/IP mismatch**: App assumes Wi-Fi is connected and ESP32 is at `http://10.1.0.1`. Change this in `main.dart`.
- **Permission confusion**: Remove `INTERNET` from `AndroidManifest.xml`. Only `ACCESS_WIFI_STATE` is needed.
- **ADB not found**: Add platform-tools to PATH:

    ```
    set PATH=%PATH%;D:\projects\tools\platform-tools
    ```

---

## 📡 Mesh Setup

- ESP32 node serves weather data at `http://10.1.0.1/data.json`
- Android device connects via Wi-Fi (no internet)
- App checks `ConnectivityResult.wifi` before fetching

---

## 🧱 Building the APK

```
flutter clean
flutter pub get
flutter build apk --release
```

---

## 📲 Installing the APK

```
adb install -r build\app\outputs\flutter-apk\app-release.apk
```

Make sure `adb devices` shows your phone before installing.

---

## 🧠 How to Modify

- **App name**: `android/app/src/main/res/values/strings.xml`
- **Mesh IP**: Edit `main.dart`
- **Permissions**: `AndroidManifest.xml` — only `ACCESS_WIFI_STATE`
- **Fallback UI**: Add error handling in `_checkAndFetch()`
- **SSID check**: Use `wifi_iot` to verify mesh SSID

---

## 🔐 Permissions

```xml
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
```

No internet. No location. No background services.

---

## 🧪 Tested On

- Heltec V3 ESP32 node
- Android 11–13 sideloaded devices
- Mesh-only Wi-Fi, no gateway

---

## 🧭 Future Work

- SSID verification
- Node scanning
- Offline dashboard
- RFID sync

---

## 🧼 Philosophy

- No symbolic fluff
- Every module earns its place
- Configuration before initialization
- Inspectable, modular, minimal
