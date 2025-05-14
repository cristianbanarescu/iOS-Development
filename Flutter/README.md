# Flutte & Dart Knowledge Base

This page contains general details and useful information about `Flutter` and `Dart` development.

## What is Flutter & Dart?

- `Toolkit/framework` to build apps for multiple devices/platforms and sizes. Ex: iOS, Android, Web, etc > https://flutter.dev/
- `Flutter` lets you use one codebase instead of separate codebases for each platform you'd like to deploy your app to
- [Dart](https://dart.dev/) is the programming language used inside Flutter

## How to add dependencies/3rd party packages to your Flutter app

- Use `pubspec.yaml` file from inside your project. Pubspec file can also be used for app configuration, add custom assets, fonts. See more [here](https://docs.flutter.dev/tools/pubspec)
- Use `flutter pub` > https://pub.dev/ > here you have all the flutter packages

## Design

- Flutter uses [MaterialDesign](https://docs.flutter.dev/ui/widgets/material) and also `Cupertino` [design](https://docs.flutter.dev/ui/widgets/cupertino) for iOS 

## How does Flutter work?

- Flutter works with `Widgets` as the main component for development. Widgets on top of other widgets. Ex: `Scaffold, AppBar, Column, Row`, etc > https://docs.flutter.dev/ui/widgets
- Flutter has `Hot reload` (similar to Previews for Swift/SwiftUI in iOS) > basically you write your code, hit save and Flutter will `reload your views` live so you won't need to manually run the app to see your changes (it will reload only the widgets that changed since you last 'reloaded' the UI)
- There's also the `Hot restart` mechanism to use in order to reset the 'state' of your Flutter app (basically will reset any state and UI)
- Main entry point of your app is the `main.dart` file 

## Stateful vs Stateless widgets 

- `Stateful` widgets:
    - https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html
    - the state inside the widget can change (mutable state)
    - state = some info that can be read when the widget is built and that may change during the lifetime of the widget
    - state = a specific `State` object (subclass of `State` class) and this object is created using the `createState` method from a `StatefulWidget`
    - use the `setState()` method to explicitly mark that the state changes
    - `setState()` triggers a re-build (re-call the build method) based on what state changed > everything depending on that state will be redrawn
    - use for dynamic content and UI that updates over time 

- `Stateless` widgets:
    - https://api.flutter.dev/flutter/widgets/StatelessWidget-class.html
    - state doesn't change
    - state is immutable
    - no UI updates based on any 'mutable info'
    - use for static content, UI that doesn't change
    - you don't require mutable state

- A `StatelessWidget` can use a `StatefulWidget` inside its widgets hierarchy

## Useful resources

### Articles, videos, etc for Flutter/Dart/Cross-platform knowledge

- Flutter [cookbook](https://docs.flutter.dev/cookbook)

### Free images for comercial use

- [icons8.com](https://icons8.com/)
- [vecteezy.com](https://www.vecteezy.com/)
- [canva.com](https://www.canva.com/)

### Fonts

- [google fonts](https://fonts.google.com/)

### Colors

- [material colors palette](https://www.materialpalette.com/)
- [Color extension](https://www.colorzilla.com/chrome/)

### App Designs

- [Dribble](https://dribbble.com/)