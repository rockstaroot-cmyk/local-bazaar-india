
ANDROID APK BUILD - EASIEST WAY (NO INSTALL)

OPTION 1: BUILD ON YOUR PC (5 mins) - RECOMMENDED FOR YOU

Step 1: Install Flutter (one time):
- Go to flutter.dev -> Install Windows
- Download, extract to C:\src\flutter
- Add to Path
- Install Android Studio

Step 2: Build APK:
Open Command Prompt in project folder and run:

flutter pub get
flutter build apk --debug

This builds DEBUG APK - fastest, no keystore needed.
Location: build/app/outputs/flutter-apk/app-debug.apk
Size: ~20MB
You can install this directly on your phone.

For release APK (for sharing):
flutter build apk --release

Location: build/app/outputs/flutter-apk/app-release.apk

OPTION 2: BUILD ON GITHUB - NO INSTALL ON YOUR PC (EASIEST IF YOU DON'T WANT TO INSTALL FLUTTER)

1. Create GitHub account (github.com)
2. Create new repository: local-bazaar-india
3. Upload this entire folder to GitHub (drag and drop)
4. Go to Actions tab -> You will see "Build Android APK" running
5. After 3-4 mins, it finishes -> Click on it -> Download artifact "LocalBazaar-APK"
6. Inside you get app-debug.apk and app-release.apk - Download to phone!

No Flutter install needed on your PC. GitHub builds for you free.

OPTION 3: Use flutterflow.io - Import lib/main.dart and click Build APK

APK vs AAB:
- APK = Install directly on phone via WhatsApp, for testing
- AAB = For Play Store upload (need keystore, next step)

START WITH APK DEBUG - 1 command: flutter build apk --debug
