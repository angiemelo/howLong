# How Long?

*A retirement countdown app built with Flutter.*

> Inspired by a conversation with my dad over lunch, *How Long?* lets users countdown the time remaining until their retirement — or any significant life event.

---

## About the App

**How Long?** started as a simple project to calculate the time remaining until retirement based on the user’s date of birth. As the app evolved, it became a flexible, user-friendly tool that allows multiple countdowns, persistent storage and a polished interface — all while staying true to the initial inspiration.

If you would like to learn more about the thinking process, my journey can be found in `/docs/howLong_theProcess`

---

## Features

- 🎂 Input your **Date of Birth** via a simple DatePicker.
- ⏳ See **how long until retirement** (default retirement age is 67).
- ➕ Add **custom countdowns** for any future event (e.g., holidays, weddings).
- 📝 **Edit or delete** countdowns with ease.
- 💾 **Persistent storage** using `SharedPreferences`.
- ♻️ **Reactive state management** with `flutter_riverpod`.
- 🔄 Clean and intuitive **navigation** based on user state.
- 📦 Fully **modular and scalable** codebase.

---

## Project Structure
```
lib/
├── main.dart
├── screens/
│ ├── home_screen.dart
│ └── countdown_screen.dart
├── services/
│ └── countdown_service.dart
├── models/
│ └── countdown.dart
├── providers/
│ └── countdown_provider.dart
├── storage/
│ └── countdown_storage.dart
├── util/
│ └── functions.dart
└── widgets/
└── countdown_display.dart
```
---

## 📱 Screenshots

<img src="assets/screenshots/homeScreen.png" width="300"/>
<img src="assets/screenshots/countdownScreen.png" width="300"/>

---

## 🛠️ Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Android Studio / VS Code with Flutter plugin
- An Android or iOS emulator (or physical device)

### Installation

1. Clone the repository:
   ```
   git clone https://github.com/angiemelo/how-long-app.git
   cd how-long-app
   ```


2. Get dependencies:<p>
    `flutter pub get`

3. Run the app:<p>
    `flutter run`

## Future Ideas
- 🥳 Automatically add birthday countdowns
- 🖼️ Personalised background images for each countdown
- ☁️ Cloud sync and multi-device support
- 🎨 Custom themes or accent colours
- 🔔 Notifications when a countdown is near

## Acknowledgements
Huge thanks to my dad, who inspired this app with one sentence:<br>
*"Only five more years and four months to go!"*

- Flutter Documentation https://flutter.dev/docs
- Riverpod Package https://pub.dev/packages/flutter_riverpod

## License
MIT License © 2025 [aMelo]

## 👾 Author
Angela Melo<br>
Computing and IT Student at the Open University<br>
Inspired by complexity, driven by change and woven with intent.
