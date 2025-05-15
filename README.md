NAVEASE: An app for Visually Impaired
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
<img src="https://github.com/HardikSJain/sih2023/assets/71220869/1bdc56e5-86bc-4c88-9a43-b8479aabb9b6" alt="screenshot1" width="200">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/HardikSJain/sih2023/assets/81674309/ef4448ec-fd25-43e7-968b-51ca5555df10" alt="screenshot1" width="200">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/HardikSJain/sih2023/assets/81674309/9c1b7891-3793-431c-a3d3-9555a40c37c0" alt="screenshot1" width="200">



Workflow Diagram
------------
<img src="https://github.com/HardikSJain/sih2023/assets/71220869/bab4f51c-df6d-49fb-84b1-f3bf6af90e8e" alt="screenshot1" width="800">

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
