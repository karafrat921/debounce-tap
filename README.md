# debounce_tap

A Flutter package that provides debounced tap functionality for various Flutter widgets like InkWell, GestureDetector, IconButton, and TextButton. This package helps prevent rapid successive taps and provides a better user experience.

## Features

- **Debounced InkWell**: Prevents rapid successive taps on InkWell widgets
- **Debounced GestureDetector**: Adds debounce functionality to GestureDetector
- **Debounced IconButton**: Debounced tap support for IconButton
- **Debounced TextButton**: Prevents rapid taps on TextButton
- **Customizable Duration**: Set your own debounce duration
- **Blocked Tap Callback**: Get notified when taps are blocked during debounce period
- **Easy to Use**: Simple API that wraps existing Flutter widgets

## Getting started

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  debounce_tap: ^0.1.0
```

## Usage

### Basic Usage

```dart
import 'package:debounce_tap/debounce_tap.dart';

// Debounced InkWell
Debounce.inkwell(
  onTap: () {
    print('Tapped!');
  },
  debounceDuration: const Duration(milliseconds: 500),
  child: Container(
    padding: const EdgeInsets.all(16),
    child: const Text('Tap me!'),
  ),
);

// Debounced GestureDetector
Debounce.gestureDetector(
  onTap: () {
    print('Gesture tapped!');
  },
  debounceDuration: const Duration(milliseconds: 300),
  child: Container(
    padding: const EdgeInsets.all(16),
    child: const Text('Gesture tap me!'),
  ),
);

// Debounced IconButton
Debounce.iconButton(
  onTap: () {
    print('Icon button tapped!');
  },
  icon: const Icon(Icons.favorite),
  debounceDuration: const Duration(milliseconds: 200),
);

// Debounced TextButton
Debounce.textButton(
  onTap: () {
    print('Text button tapped!');
  },
  debounceDuration: const Duration(milliseconds: 100),
  child: const Text('Text Button'),
);
```

### Advanced Usage with Blocked Tap Callback

```dart
Debounce.inkwell(
  onTap: () {
    print('Tapped!');
  },
  onTapBlocked: (remainingMs) {
    print('Tap blocked! Remaining time: ${remainingMs}ms');
  },
  debounceDuration: const Duration(milliseconds: 1000),
  child: Container(
    padding: const EdgeInsets.all(16),
    child: const Text('Tap me with feedback!'),
  ),
);
```

## API Reference

### Debounce.inkwell

Creates a debounced InkWell widget.

**Parameters:**
- `onTap`: Callback function when tapped
- `onTapBlocked`: Optional callback when tap is blocked during debounce period
- `debounceDuration`: Duration for debounce (default: 300ms)
- `child`: The child widget
- All other InkWell properties are supported

### Debounce.gestureDetector

Creates a debounced GestureDetector widget.

**Parameters:**
- `onTap`: Callback function when tapped
- `debounceDuration`: Duration for debounce (default: 300ms)
- `child`: The child widget
- All other GestureDetector properties are supported

### Debounce.iconButton

Creates a debounced IconButton widget.

**Parameters:**
- `onTap`: Callback function when tapped
- `debounceDuration`: Duration for debounce (default: 300ms)
- `icon`: The icon to display
- All other IconButton properties are supported

### Debounce.textButton

Creates a debounced TextButton widget.

**Parameters:**
- `onTap`: Callback function when tapped
- `debounceDuration`: Duration for debounce (default: 300ms)
- `child`: The child widget
- All other TextButton properties are supported

## Additional information

For more examples, check out the `/example` folder in this package.

### Contributing

Feel free to contribute to this package by submitting issues or pull requests.

### License

This package is licensed under the MIT License.
