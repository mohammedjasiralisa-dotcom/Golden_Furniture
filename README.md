# Golden Furniture
## Environment Setup
## 🧩 Prerequisites

Before running this project, make sure you have the following tools installed and properly configured on your system.

---

## 🧰 1️⃣ System Requirements

| Component | Requirement |
|------------|--------------|
| **Operating System** | Windows 10/11, macOS, or Linux |
| **Processor** | Intel i5 / AMD Ryzen 5 or higher |
| **RAM** | Minimum 8 GB (Recommended 16 GB for Android Studio) |
| **Storage** | At least 10 GB free for SDKs and build tools |
| **Internet** | Required for package and dependency downloads |

---

## 🧱 2️⃣ Install Flutter SDK

### 🔹 Step 1: Download Flutter
Visit the official Flutter installation page:  
👉 [https://docs.flutter.dev/get-started/install](https://docs.flutter.dev/get-started/install)

Choose your operating system (Windows/macOS/Linux) and download the latest stable Flutter SDK.

### 🔹 Step 2: Extract Flutter
Extract the downloaded file to a permanent location, for example:

```
C:\src\flutter
```

### 🔹 Step 3: Add Flutter to PATH
1. Copy the path to your Flutter `bin` directory:
   ```
   C:\src\flutter\bin
   ```
2. Add it to your **Environment Variables**:
   - Open **Search → Edit the system environment variables**
   - Click **Environment Variables**
   - Under **System Variables**, find **Path** → **Edit**
   - Click **New** → Paste `C:\src\flutter\bin`
   - Click **OK** to save

### 🔹 Step 4: Verify Installation
Open **Command Prompt** or **PowerShell** and run:
```bash
flutter doctor
```

You should see a report showing your Flutter setup details.  
If anything is missing (like Android SDK), follow the recommendations shown.

---

## 🧩 3️⃣ Install Dart SDK

> Note: Flutter includes Dart SDK by default.  
> You **don’t need to install Dart separately** unless you want to use it standalone.

To verify Dart installation:
```bash
dart --version
```

If you see an error like `'dart' is not recognized`, restart your terminal or re-check your PATH.

---

## 🤖 4️⃣ Install Android Studio (for Emulator & SDK)

### 🔹 Step 1: Download Android Studio
Download from:  
👉 [https://developer.android.com/studio](https://developer.android.com/studio)

### 🔹 Step 2: Install Required Components
During installation, make sure the following are selected:
- Android SDK
- Android SDK Platform
- Android Virtual Device (AVD)
- Android SDK Command-line Tools

### 🔹 Step 3: Configure Android SDK Path
After installation, open Android Studio →  
**File → Settings → Appearance & Behavior → System Settings → Android SDK**

Note down the SDK path, typically:
```
C:\Users\<YourName>\AppData\Local\Android\sdk
```

Add it to your environment variables as:
```
ANDROID_HOME = C:\Users\<YourName>\AppData\Local\Android\sdk
```

Also add to **PATH**:
```
%ANDROID_HOME%\platform-tools
%ANDROID_HOME%\tools
%ANDROID_HOME%\tools\bin
```

### 🔹 Step 4: Test ADB
Run:
```bash
adb devices
```
You should see your connected device or emulator listed.

---

## 📱 5️⃣ Connect a Device or Emulator

- **Physical Device **  
  - Enable **Developer Options** on your Android phone  
  - Turn on **USB Debugging**  
  - Connect your phone via USB  
  - Run:
    ```bash
    flutter devices
    ```
  - Your device should appear


---

## 🧩 6️⃣ Install Visual Studio Code (Optional but Recommended)

Download VS Code:  
👉 [https://code.visualstudio.com/](https://code.visualstudio.com/)

Then install these extensions:
- Flutter
- Dart
- Pubspec Assist
- Error Lens
- Material Icon Theme

---

## 🪄 7️⃣ Verify Flutter Setup

Run:
```bash
flutter doctor -v
```

✅ You should see:
```
[✓] Flutter (Channel stable)
[✓] Android toolchain - develop for Android devices
[✓] Chrome (for web)
[✓] Visual Studio Code
[✓] Connected device
```


---

## 🧾 Summary

| Step | Task | Status |
|------|------|---------|
| 1 | Install Flutter SDK | ✅ |
| 2 | Set environment variables | ✅ |
| 3 | Install Android Studio | ✅ |
| 4 | Configure SDK Path | ✅ |
| 5 | Connect device/emulator | ✅ |
| 6 | Verify with `flutter doctor` | ✅ |


A new Flutter project.
