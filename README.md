PathEASE: An app for Visually Impaired
====================
Visually impaired individuals and senior citizens encounter substantial difficulties when navigating complex and unfamiliar environments, such as shopping malls, hospitals, and public spaces. These challenges encompass struggles in determining their current location, identifying the most efficient path to their desired destination, and maintaining a sense of independence and confidence. Consequently, there exists a compelling necessity for the development of a user-friendly, voice-controlled application tailored explicitly to visually impaired individuals and senior citizens. This app aims to facilitate independent navigation within enclosed spaces, enabling them to efficiently reach their destinations with minimal assistance and boosting their self-assurance.

Features
--------

  - Allow users to interact with the app using voice commands.

  - Real-time Audio instructons:
    - Text-to-Speech to the users and 
    - Speech-to-Text to the app
 
  - The app provides precise indoor navigation within complex spaces like staircases, step counts, etc From the backend.

  - Informing user about essential amenities along their way while reaching to their destination like water stations, restrooms, etc.

Glimpses of the developed app
------------
<img src="https://raw.githubusercontent.com/yashitz07/Nav-frontend/main/assets/images/navease1.png" alt="screenshot1" width="200">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://raw.githubusercontent.com/yashitz07/Nav-frontend/main/assets/images/navease2.jpeg" alt="screenshot1" width="200">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;




Workflow Diagram
------------
<img src="https://raw.githubusercontent.com/yashitz07/Nav-frontend/main/assets/images/navease-workflow.png" alt="screenshot1" width="800">

### 📦 Download APK
------------
You can try the app by downloading the latest APK:

👉 [Click here to download PathEASE APK](https://drive.google.com/drive/folders/1PfPhp6dOAjogAYgfnKXbPnsiZPqJxRm9)

> ℹ️ Make sure "Install from unknown sources" is enabled on your Android device.

## 📁 Project Structure & Key Files

| Path                              | Description                                                                 |
|-----------------------------------|-----------------------------------------------------------------------------|
| `lib/`                            | Main Dart source code of the Flutter app                                   |
| ├── `main.dart`                   | Entry point of the application                                             |
| ├── `screens/home_page.dart`      | Contains the UI and logic for navigation & voice interaction               |
| ├── `services/apiService.dart`    | Handles API calls to the backend navigation model                          |
| `android/`                        | Android-specific configuration and native code                             |
| ├── `app/`                        | Contains AndroidManifest and launcher configuration                        |
| ├── `build.gradle`                | Project-level Gradle build file                                            |
| ├── `gradle.properties`           | Configures Gradle build settings                                           |
| ├── `settings.gradle`             | Specifies modules and plugin management                                    |
| `assets/images/`                  | Image assets used in the app                                               |
| `pubspec.yaml`                    | Lists dependencies and assets; configures app-level settings               |

---
