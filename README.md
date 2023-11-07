# Installation of Clarify App

Welcome to the installation guide for the Clarify App. This document will walk you through the process of setting up the Clarify Flutter app on your local machine for both MacOS and Windows systems, as well as how to run the app on an iPhone.

## Prerequisites
- Flutter SDK: Download and install Flutter from the [official website](https://flutter.dev).
- Dart SDK: Included with the Flutter SDK, so no separate installation is necessary.

## MacOS Installation (Including Apple Silicon)
1. Open the Terminal. For Apple Silicon, run `sudo softwareupdate --install-rosetta --agree-to-license`.
2. Install Xcode from the Mac App Store.
3. Download and extract the Flutter SDK for Intel or Apple Silicon.
4. Add Flutter to your path permanently by updating your `.zshrc` file.
5. Run `flutter doctor` to verify your installation.

## Windows Installation
1. Download and extract the Flutter SDK for Windows.
2. Update the PATH environment variable to include the path to `flutter\bin`.
3. Run `flutter doctor` to confirm the setup.

## Running the App on an iPhone
- Sign into Xcode with your Apple ID.
- Enable Developer Mode on your iPhone via `Settings` → `Privacy & Security`.
- For first-time installation:
  - Verify the Developer App certificate: Navigate to `Settings` > `General` > `VPN & Device Management` on your device, and trust your Developer App certificate.



## Installation Steps (Common for MacOS and Windows)
1. Open a terminal or command prompt.
2. Navigate to the directory where you want to clone the repository.
3. Run `git clone https://github.com/MasterWJK/Clarify_repo` to clone the repository.
4. Change to the cloned repository directory with `cd Clarify_repo`.
5. Run `flutter pub get` to install dependencies.
6. Connect your Android or iOS device or set up an emulator/simulator.
7. Execute `flutter run` to start the app.

For detailed MacOS and Windows installation instructions, please see the sections above.

Thank you for your interest in the Clarify App, and happy coding!
