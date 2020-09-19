# minimalist_flutter_template

A new Flutter project.

## How We Set Up This App

Below are the steps that were taken to build this example project using the very simple flutter template at `https://github.com/seenickcode/minimalist_flutter_template` (using the `flutter_create` package).

### Basic Set Up

1. Building the app.

How we created this app: `pub global activate flutter_create`.

Then: `flutter_create -a <app name> -u https://github.com/seenickcode/minimalist_flutter_template`

2. Directory structure.

We're separating the home screen from `main.dart`

3. Fonts.

Including the `assets` diretory in `pubspec.yaml` and citing the fonts we'd like. Using the `theme` property of `MaterialApp` in `main.dart` to use our font.

4. Settting up our `home.dart` file:

a. We import the `http` package in `pubspec.yaml`
b. Then, we fetch some data from `postman-echo.com` and display it on screen.

### Setting Up Basic Integration tests

We create a `test/integration` directory. Then add the following to `dev_dependencies` in `pubspec.yaml`:

```
flutter_driver:
  sdk: flutter
```

## Next Up
