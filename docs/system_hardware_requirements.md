# System and Hardware Requirements

## System Requirements

### Operating System Requirements

#### Android
- **Minimum SDK Version**: API 21 (Android 5.0 Lollipop)
- **Target SDK Version**: API 34 (Android 14)
- **Recommended Version**: Android 8.0 (Oreo) or higher for optimal performance
- **Architecture Support**: ARM64-v8a, armeabi-v7a, x86_64

**Justification**: 
- API 21 (Android 5.0) provides support for 99.9% of active Android devices as of 2024
- Modern Android features require API 21+ (Material Design, runtime permissions)
- Firebase services require minimum API 21

**Configuration Location**: `android/app/build.gradle.kts`
```kotlin
defaultConfig {
    minSdk = 21  // Minimum SDK version
    targetSdk = 34  // Target SDK version
}
```

#### iOS
- **Minimum iOS Version**: iOS 12.0
- **Target iOS Version**: iOS 17.0
- **Recommended Version**: iOS 14.0 or higher for optimal performance
- **Architecture Support**: arm64 (64-bit devices)

**Justification**:
- iOS 12.0 provides support for 95%+ of active iOS devices
- Modern iOS features and security improvements available
- Firebase iOS SDK requires iOS 12.0+

**Configuration Location**: `ios/Podfile`
```ruby
platform :ios, '12.0'  # Minimum iOS version
```

---

### Flutter SDK Requirements

- **Minimum Flutter SDK Version**: 3.9.2
- **Recommended Version**: 3.22.0 or higher (latest stable)
- **Dart SDK Version**: 3.0.0 or higher (comes with Flutter SDK)

**Justification**:
- Flutter 3.9.2 includes required features for Firebase integration
- Latest stable version includes bug fixes and performance improvements
- Dart 3.0+ provides modern language features (null safety, records)

**Configuration Location**: `pubspec.yaml`
```yaml
environment:
  sdk: ^3.9.2  # Minimum Dart SDK version
```

---

### Development Environment Requirements

#### For Android Development:
- **Android Studio**: Latest stable version (recommended: Hedgehog or later)
- **Android SDK**: Platform SDK 34 (Android 14)
- **Android SDK Build Tools**: Version 34.0.0 or higher
- **Java Development Kit (JDK)**: JDK 11 or higher
- **Gradle**: Version 8.0 or higher (managed by Flutter)

#### For iOS Development (macOS only):
- **Xcode**: Version 14.0 or higher
- **CocoaPods**: Version 1.11.0 or higher
- **macOS**: macOS 12.0 (Monterey) or higher
- **Command Line Tools**: Latest version

#### General Development:
- **Git**: For version control
- **VS Code** or **Android Studio**: Code editor with Flutter extensions
- **Chrome/Edge**: For web debugging (optional)

---

### Runtime System Requirements

#### Minimum Device Specifications (Android):
- **RAM**: 2 GB minimum, 3 GB recommended
- **Storage**: 50 MB for app installation, additional space for cached data
- **Display**: 320x480 dp minimum (supports 4" screens)
- **CPU**: ARMv7 or ARM64 processor

#### Minimum Device Specifications (iOS):
- **RAM**: 2 GB minimum, 3 GB recommended
- **Storage**: 50 MB for app installation, additional space for cached data
- **Display**: iPhone SE (1st generation) or newer (4" screen minimum)
- **CPU**: 64-bit processor (iPhone 5s or newer)

---

### Backend Service Requirements

#### Firebase Services:
- **Firebase Project**: Active Firebase project with billing enabled (for production)
- **Firebase Authentication**: Enabled with Email/Password provider
- **Cloud Firestore**: Database with proper security rules
- **Firebase Storage**: Storage bucket for image uploads
- **Firebase Hosting**: Optional, for web deployment

#### Network Requirements:
- **Internet Connection**: Required for:
  - User authentication
  - Data synchronization (Firestore)
  - Image uploads/downloads (Firebase Storage)
  - Real-time updates
- **Network Protocol**: HTTPS (required by Firebase)
- **Bandwidth**: Minimum 1 Mbps for smooth operation, 5 Mbps recommended for image uploads

**Offline Support**: 
- Limited offline functionality available
- Data cached locally using SharedPreferences and Firestore offline persistence
- Full functionality requires internet connection

---

## Hardware Requirements

### Required Hardware

#### 1. Camera
- **Required**: No (Optional, but recommended)
- **Usage**: 
  - Cooks can upload meal images using camera
  - Students can upload lost & found item images (when implemented)
- **Platform Support**:
  - Android: Camera API available on devices with camera hardware
  - iOS: Camera access via AVFoundation framework

**Permission Declaration**:

**Android** (`android/app/src/main/AndroidManifest.xml`):
```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-feature 
    android:name="android.hardware.camera" 
    android:required="false" />
```

**iOS** (`ios/Runner/Info.plist`):
```xml
<key>NSCameraUsageDescription</key>
<string>Need camera to take photos of meals and lost items</string>
```

**Implementation**: Uses `image_picker` package which handles platform-specific camera access

---

#### 2. Internet Connection
- **Required**: Yes
- **Usage**:
  - User authentication (Firebase Auth)
  - Data fetching and synchronization (Firestore)
  - Image uploads/downloads (Firebase Storage)
  - Real-time updates

**Network Handling**:
- Graceful error handling when network is unavailable
- Error messages displayed to users
- Retry mechanisms for failed operations
- Offline caching for basic functionality

**Implementation**: 
```dart
// Network error handling example
try {
  await FirebaseFirestore.instance.collection('menu_items').get();
} on FirebaseException catch (e) {
  if (e.code == 'unavailable') {
    // Handle offline scenario
    showErrorMessage('No internet connection');
  }
}
```

---

#### 3. Storage
- **Required**: Yes
- **Usage**:
  - App installation (50 MB)
  - Cached images and data
  - Local data storage (SharedPreferences)
  - Firestore offline persistence cache

**Storage Management**:
- Automatic cache management by Flutter
- Firestore offline persistence limited to 40 MB by default
- Image cache managed by Firebase Storage SDK

---

### Optional Hardware

#### 4. GPS/Location Services
- **Required**: No (Not currently used, but available for future features)
- **Potential Usage**:
  - Room location mapping
  - Finding nearby facilities
  - Location-based notifications

**Note**: GPS permissions not currently declared in manifest files, but can be added if needed.

---

#### 5. Biometric Authentication
- **Required**: No
- **Potential Usage**:
  - Fingerprint/Face ID login
  - Secure app access

**Note**: Not currently implemented, but Flutter supports `local_auth` package for future implementation.

---

#### 6. Push Notifications
- **Required**: No (Optional)
- **Potential Usage**:
  - Assignment deadline reminders
  - New meal notifications
  - System announcements

**Implementation**: Can be added using Firebase Cloud Messaging (FCM)

---

## Additional System Requirements

### Permissions Required

#### Android Permissions (`android/app/src/main/AndroidManifest.xml`):

```xml
<!-- Internet connection -->
<uses-permission android:name="android.permission.INTERNET" />

<!-- Camera access -->
<uses-permission android:name="android.permission.CAMERA" />

<!-- Storage access (for older Android versions) -->
<uses-permission 
    android:name="android.permission.READ_EXTERNAL_STORAGE" 
    android:maxSdkVersion="32" />
<uses-permission 
    android:name="android.permission.WRITE_EXTERNAL_STORAGE" 
    android:maxSdkVersion="32" />

<!-- Media access (Android 13+) -->
<uses-permission android:name="android.permission.READ_MEDIA_IMAGES" />
```

#### iOS Permissions (`ios/Runner/Info.plist`):

```xml
<!-- Camera access -->
<key>NSCameraUsageDescription</key>
<string>Need camera to take photos of meals and lost items</string>

<!-- Photo library access -->
<key>NSPhotoLibraryUsageDescription</key>
<string>Need photo library access to select meal images</string>
```

---

### Firebase Configuration Files

#### Android:
- **File**: `android/app/google-services.json`
- **Location**: Project root → `android/app/`
- **Purpose**: Firebase configuration for Android platform
- **Source**: Downloaded from Firebase Console

#### iOS:
- **File**: `ios/Runner/GoogleService-Info.plist`
- **Location**: `ios/Runner/`
- **Purpose**: Firebase configuration for iOS platform
- **Source**: Downloaded from Firebase Console

---

## Installation Requirements Summary

### For End Users:
1. **Android Device**: Android 5.0 (Lollipop) or higher
2. **iOS Device**: iPhone/iPad with iOS 12.0 or higher
3. **Internet Connection**: Required for app functionality
4. **Storage Space**: 50 MB minimum
5. **Camera**: Optional (for image uploads)

### For Developers:
1. **Flutter SDK**: 3.9.2 or higher
2. **Dart SDK**: 3.0.0 or higher
3. **Android Studio** or **VS Code**: With Flutter extensions
4. **Firebase Account**: For backend services
5. **Git**: For version control

---

## Verification and Testing

### System Requirements Testing:
- ✅ Tested on Android API 21 (Android 5.0) - Minimum requirement met
- ✅ Tested on Android API 34 (Android 14) - Target SDK confirmed
- ✅ Tested on iOS 12.0 - Minimum requirement met
- ✅ Tested on iOS 17.0 - Latest version confirmed
- ✅ Verified camera functionality on both platforms
- ✅ Verified internet connectivity requirements
- ✅ Verified storage permissions and usage

### Device Testing:
- **Android**: Tested on multiple devices (various screen sizes, Android versions)
- **iOS**: Tested on iPhone and iPad (various iOS versions)
- **Screen Sizes**: Verified responsiveness from 4" to 12.9" displays

---

## Conclusion

The University Management Mobile Application has been designed with broad device compatibility in mind. The minimum SDK version (Android API 21, iOS 12.0) ensures the app can run on 99%+ of active mobile devices. All hardware requirements (except internet) are optional, making the app accessible to users with basic smartphones. The use of Flutter framework and Firebase backend ensures consistent functionality across all supported platforms and devices.

