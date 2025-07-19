import 'package:flutter/material.dart';

class Debounce {
  static Widget inkwell({
    required VoidCallback onTap,
    required Widget child,
    Duration debounceDuration = const Duration(milliseconds: 500),
    void Function(int remainingMs)? onTapBlocked,
    BorderRadius? borderRadius,
    Color? splashColor,
    Color? highlightColor,
    Color? hoverColor,
    GestureTapCallback? onDoubleTap,
    GestureLongPressCallback? onLongPress,
  }) {
    return _Debounced(
      debounceDuration: debounceDuration,
      originalOnTap: onTap,
      onTapBlocked: onTapBlocked,
      builder: (context, debouncedOnTap) {
        return InkWell(
          onTap: debouncedOnTap,
          onDoubleTap: onDoubleTap,
          onLongPress: onLongPress,
          splashColor: splashColor,
          highlightColor: highlightColor,
          hoverColor: hoverColor,
          borderRadius: borderRadius,
          child: child,
        );
      },
    );
  }

  static Widget gestureDetector({
    required VoidCallback onTap,
    required Widget child,
    Duration debounceDuration = const Duration(milliseconds: 500),
    void Function(int remainingMs)? onTapBlocked,
    GestureLongPressCallback? onLongPress,
    GestureTapCallback? onDoubleTap,
  }) {
    return _Debounced(
      debounceDuration: debounceDuration,
      originalOnTap: onTap,
      onTapBlocked: onTapBlocked,
      builder: (context, debouncedOnTap) {
        return GestureDetector(
          onTap: debouncedOnTap,
          onDoubleTap: onDoubleTap,
          onLongPress: onLongPress,
          child: child,
        );
      },
    );
  }

  static Widget iconButton({
    required VoidCallback onTap,
    required Icon icon,
    Duration debounceDuration = const Duration(milliseconds: 500),
    void Function(int remainingMs)? onTapBlocked,
    double? iconSize,
    Color? color,
    String? tooltip,
  }) {
    return _Debounced(
      debounceDuration: debounceDuration,
      originalOnTap: onTap,
      onTapBlocked: onTapBlocked,
      builder: (context, debouncedOnTap) {
        return IconButton(
          icon: icon,
          onPressed: debouncedOnTap,
          iconSize: iconSize ?? 24,
          color: color,
          tooltip: tooltip,
        );
      },
    );
  }

  static Widget textButton({
    required VoidCallback onTap,
    required Widget child,
    Duration debounceDuration = const Duration(milliseconds: 500),
    void Function(int remainingMs)? onTapBlocked,
  }) {
    return _Debounced(
      debounceDuration: debounceDuration,
      originalOnTap: onTap,
      onTapBlocked: onTapBlocked,
      builder: (context, debouncedOnTap) {
        return TextButton(onPressed: debouncedOnTap, child: child);
      },
    );
  }
}

class _Debounced extends StatefulWidget {
  final Widget Function(BuildContext, VoidCallback) builder;
  final VoidCallback originalOnTap;
  final void Function(int remainingMs)? onTapBlocked;
  final Duration debounceDuration;

  const _Debounced({
    required this.builder,
    required this.originalOnTap,
    required this.debounceDuration,
    this.onTapBlocked,
  });

  @override
  State<_Debounced> createState() => _DebouncedState();
}

class _DebouncedState extends State<_Debounced> {
  int? _lastTapTime;

  void _debouncedTap() {
    final now = DateTime.now().millisecondsSinceEpoch;
    if (_lastTapTime == null ||
        (now - _lastTapTime!) >= widget.debounceDuration.inMilliseconds) {
      _lastTapTime = now;
      widget.originalOnTap();
    } else {
      final remaining =
          widget.debounceDuration.inMilliseconds - (now - _lastTapTime!);
      if (widget.onTapBlocked != null) {
        widget.onTapBlocked!(remaining);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _debouncedTap);
  }
}
