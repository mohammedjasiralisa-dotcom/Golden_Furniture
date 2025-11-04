# Golden Furniture - Flutter OTP App

This Flutter mobile application allows users to enter their **name** and **mobile number**, and then click a **"Get OTP"** button to simulate sending an OTP.  
The app features a **full-screen background image** and a simple, modern UI.

---

## 🚀 Features
- Enter **Name** and **Mobile Number**
- Button to **Get OTP**
- **SnackBar** message confirmation
- Custom **background image**
- Built with **Flutter**

---

## 🧱 Folder Structure

```
lib/
 ├── main.dart          # Main Flutter code
assets/
 └── images/
     └── bg.jpg         # Background image
```

---

## 🛠️ Installation and Setup

### 1. Clone the Repository
```bash
git clone https://github.com/your-username/flutter_otp_app.git
cd flutter_otp_app
```

### 2. Install Flutter Dependencies
```bash
flutter pub get
```

### 3. Add Assets in `pubspec.yaml`
Make sure your `pubspec.yaml` includes:

```yaml
flutter:
  uses-material-design: true

  assets:
    - assets/images/bg.jpg
```

> 📝 Note: Ensure that your background image is placed inside  
> `assets/images/bg.jpg`

---

## ▶️ Run the App

### For Real Device
1. Enable **Developer Mode** and **USB Debugging**
2. Connect your Android device
3. Run:
```bash
flutter run
```

### For Emulator (optional)
If you have an emulator set up:
```bash
flutter emulators --launch <emulator_name>
flutter run
```

---

## 📱 UI Preview
| Home Screen |
|--------------|
| ![Screenshot](assets/images/bg.jpg) |

---

## 🧩 Tech Stack
- Flutter (v3.35.6)
- Dart SDK (v3.9.2)
- Android Studio / VS Code

---

## 📧 Author
**Developed by:** *Mohammed Jasir Ali*  
📅 **Year:** 2025  
📩 **Email:*mohammedjasiralisa@gmail.com*

---

## 📄 License
This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.
