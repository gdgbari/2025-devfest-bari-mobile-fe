# DevFest Bari 2025 - Mobile app

## Getting started


1. **Clone the repository**
   ```bash
   git clone git@github.com:gdgbari/2025-devfest-bari-mobile-fe.git
   cd 2025-devfest-bari-mobile-fe
   ```
2. **Install prerequisites**
- Install [FVM](https://fvm.app/documentation/getting-started/installation) (Flutter Version Manager)
- Store the Flutter SDK version in use that can be found into the file `.fvmrc` into a temporary environment variable `FLUTTER_SDK_VERSION`
- Install the Flutter SDK by running the following command:
  ```bash
  fvm install FLUTTER_SDK_VERSION
  fvm use FLUTTER_SDK_VERSION
  ```
- Install [Firebase CLI](https://firebase.google.com/docs/cli?hl=it#setup_update_cli)
- Install FlutterFire CLI by running the following command:
  ```bash
  fvm dart pub global activate flutterfire_cli
  ```
3. **Set up the project**
   - Configure your local `.env` file using the given `.env-template`
   - Clean any previous builds and install project dependencies:
     ```bash
     fvm flutter clean
     fvm flutter pub get
     ```
   - Run build runner to generate necessary files:
     ```bash
     fvm dart run build_runner build --delete-conflicting-outputs
     ```
   - Configure Firebase for your project using FlutterFire CLI:
     ```bash
     fvm dart pub global run flutterfire_cli:flutterfire configure
     ```
4. **Enjoy**

