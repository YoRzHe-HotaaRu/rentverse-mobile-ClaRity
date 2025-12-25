# RENTVERSE - Mobile Application

Platform properti rental modern yang menghubungkan pemilik properti (landlord) dengan penyewa (tenant) dengan fitur-fitur canggih seperti chat real-time, payment gateway, dan verifikasi identitas.

## 📱 Tentang Aplikasi

RENTVERSE adalah aplikasi mobile berbasis Flutter yang menyediakan platform lengkap untuk rental properti dengan dua role utama:

- **Tenant (Penyewa)**: Mencari dan menyewa properti
- **Landlord (Pemilik)**: Mengelola dan menyewakan properti

### ✨ Fitur Utama

#### Untuk Tenant
- 🏠 Browse dan cari properti berdasarkan lokasi
- 📍 Integrasi peta untuk melihat lokasi properti
- 💬 Chat real-time dengan pemilik properti
- 💳 Pembayaran terintegrasi dengan Midtrans
- 📄 Manajemen booking dan kontrak sewa
- ⭐ Review dan rating properti
- 🔔 Notifikasi real-time via Firebase
- 👤 Verifikasi identitas (iKYC)

#### Untuk Landlord
- 📊 Dashboard analytics properti
- ➕ Tambah dan kelola properti
- 📝 Manajemen booking dari tenant
- 💰 Wallet dan sistem payout
- 📈 Statistik performa properti
- 🔍 Verifikasi properti

## 🛠️ Teknologi yang Digunakan

### Framework & Language
- **Flutter** (SDK >=3.5.1 <4.0.0)
- **Dart**

### State Management & Architecture
- `flutter_bloc` ^8.1.0 - State management
- `provider` ^6.1.2 - Dependency injection
- `get_it` ^7.6.0 - Service locator
- `equatable` ^2.0.5 - Value equality

### Backend & API
- `dio` ^5.4.0 - HTTP client
- `retrofit` ^4.1.0 - Type-safe REST client
- `socket_io_client` ^2.0.3 - Real-time communication

### Database
- `floor` ^1.4.2 - Local SQLite database
- `shared_preferences` ^2.2.2 - Key-value storage

### UI & Design
- `google_fonts` ^6.1.0 - Custom fonts
- `lucide_icons` ^0.257.0 - Modern icon set
- `cached_network_image` ^3.3.0 - Image caching
- `carousel_slider` ^5.0.0 - Image carousel

### Maps & Location
- `flutter_map` ^6.0.0 - Interactive maps
- `latlong2` ^0.9.0 - Coordinate handling
- `geolocator` ^11.0.0 - Location services

### Payment
- `midtrans_snap` ^1.0.1 - Payment gateway integration
- `webview_flutter` ^4.4.0 - In-app browser

### Firebase Services
- `firebase_core` ^2.27.0
- `firebase_messaging` ^14.7.0 - Push notifications
- `flutter_local_notifications` ^17.0.0

### Utilities
- `intl` ^0.19.0 - Internationalization
- `logger` ^2.0.0 - Logging
- `file_picker` ^10.0.0 - File selection
- `camera` ^0.10.5 - Camera access
- `url_launcher` ^6.2.0 - External links
- `device_info_plus` ^9.0.0 - Device information

## 📋 Prasyarat

Sebelum menjalankan aplikasi, pastikan Anda telah menginstal:

1. **Flutter SDK** (versi 3.5.1 atau lebih tinggi)
   ```bash
   flutter --version
   ```

2. **Android Studio** atau **VS Code** dengan Flutter extension

3. **Android SDK** (untuk development Android)
   - Android SDK Platform 21 atau lebih tinggi
   - Android Build Tools

4. **Xcode** (untuk development iOS - hanya di macOS)

5. **Git**

## 🚀 Cara Menjalankan Aplikasi

### 1. Install Dependencies

```bash
flutter pub get
```

### 2. Generate Kode (untuk Retrofit & Floor)

Aplikasi ini menggunakan code generation untuk Retrofit (API client) dan Floor (database). Jalankan perintah berikut:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

> **Catatan**: Perintah ini akan generate file-file seperti `*.g.dart` yang diperlukan untuk menjalankan aplikasi.

### 3. Konfigurasi Firebase (Opsional)

Jika Anda ingin menggunakan fitur notifikasi:

1. Download file `google-services.json` (Android) dan `GoogleService-Info.plist` (iOS) dari Firebase Console
2. Letakkan file tersebut di:
   - Android: `android/app/google-services.json`
   - iOS: `ios/Runner/GoogleService-Info.plist`

### 5. Jalankan Aplikasi

#### Menggunakan Emulator/Simulator

```bash
# Cek device yang tersedia
flutter devices

# Jalankan di device yang dipilih
flutter run
```

#### Menggunakan Device Fisik

1. Aktifkan **Developer Mode** dan **USB Debugging** di perangkat Android Anda
2. Hubungkan perangkat ke komputer via USB
3. Jalankan:
   ```bash
   flutter run
   ```

#### Mode Debug vs Release

```bash
# Debug mode (default)
flutter run

# Release mode (lebih cepat, untuk testing)
flutter run --release

# Profile mode (untuk performance profiling)
flutter run --profile
```

### 6. Build APK (Android)

```bash
# Debug APK
flutter build apk --debug

# Release APK
flutter build apk --release

# Split APK per ABI (ukuran lebih kecil)
flutter build apk --split-per-abi
```

APK akan tersimpan di: `build/app/outputs/flutter-apk/`

### 7. Build App Bundle (untuk Google Play Store)

```bash
flutter build appbundle --release
```

App Bundle akan tersimpan di: `build/app/outputs/bundle/release/`

## 🧪 Testing

### Menjalankan Unit Tests

```bash
flutter test
```

### Menjalankan dengan UI Testing Mode

```bash
# Jalankan main_test.dart untuk UI slicing tanpa auth
flutter run lib/main_test.dart
```

File `main_test.dart` berguna untuk development UI tanpa perlu login, langsung menampilkan tenant navigation.

## 📁 Struktur Proyek

```
lib/
├── common/              # Komponen dan utilities bersama
│   ├── bloc/           # Global BLoCs (Auth, Navigation)
│   ├── colors/         # Custom color definitions
│   ├── screen/         # Reusable screens
│   └── widget/         # Reusable widgets
├── core/               # Core functionality
│   └── services/       # Services (DI, Notifications, etc.)
├── features/           # Feature modules
│   ├── auth/          # Authentication & Profile
│   ├── bookings/      # Booking management
│   ├── chat/          # Real-time chat
│   ├── disputes/      # Dispute handling
│   ├── map/           # Map integration
│   ├── notification/  # Notifications
│   ├── review/        # Reviews & ratings
│   └── wallet/        # Wallet & payments
└── role/              # Role-specific features
    ├── lanlord/       # Landlord features
    └── tenant/        # Tenant features
```

## 🔧 Troubleshooting

### Error: "Gradle build failed"

```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```

### Error: "CocoaPods not installed" (iOS)

```bash
sudo gem install cocoapods
cd ios
pod install
cd ..
flutter run
```

### Error: "Version solving failed"

```bash
flutter clean
rm pubspec.lock
flutter pub get
```

### Error: LucideIcons tidak ditemukan

Pastikan Anda sudah menjalankan `flutter pub get` setelah clone repository.

## 🌐 Konfigurasi Backend

Aplikasi ini memerlukan backend API. Pastikan untuk mengkonfigurasi base URL API di file konfigurasi yang sesuai.

## 📱 Platform Support

- ✅ Android (API 21+)
- ✅ iOS (iOS 12+)
- ✅ Web (experimental)
- ⚠️ Windows, macOS, Linux (belum dioptimalkan)

## 👥 Role & Permissions

Aplikasi mendukung 2 role utama:
1. **TENANT** - Penyewa properti
2. **LANDLORD** - Pemilik properti

Role ditentukan saat registrasi dan mempengaruhi UI/UX serta fitur yang tersedia.

## 📄 Lisensi

Proyek ini dibuat untuk keperluan pendidikan dan development.

## 🤝 Kontribusi

Untuk berkontribusi pada proyek ini:
1. Fork repository
2. Buat branch baru (`git checkout -b feature/AmazingFeature`)
3. Commit perubahan (`git commit -m 'Add some AmazingFeature'`)
4. Push ke branch (`git push origin feature/AmazingFeature`)
5. Buat Pull Request

## 📞 Kontak & Support

Jika mengalami masalah atau memiliki pertanyaan, silakan buat issue di repository ini.

---

**Versi**: 1.0.0+1  
**Last Updated**: Desember 2025
