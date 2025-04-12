import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

extension StringExtensions on String {
  bool get isValidEmail {
    final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(this);
  }

  String truncate({int maxLength = 20, String trailing = '...'}) {
    if (length <= maxLength) {
      return this;
    } else {
      return '${substring(0, maxLength)}$trailing';
    }
  }

  String removeTrailingDigit() {
    // Check if the last character is a digit
    if (isNotEmpty && int.tryParse(substring(length - 1)) != null) {
      // Remove the last character
      return substring(0, length - 1).toTitleCase();
    } else {
      return toTitleCase();
    }
  }

  String toTitleCase() {
    if (isEmpty) return this;
    return split(' ')
        .map((word) {
          if (word.isEmpty) return word;
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        })
        .join(' ');
  }

  Future<double> get imageWidth async {
    Completer<double> completer = Completer();
    FileImage(File(this))
        .resolve(const ImageConfiguration())
        .addListener(
          ImageStreamListener((ImageInfo info, bool _) {
            completer.complete(info.image.width.toDouble());
          }),
        );
    return completer.future;
  }

  Future<double> get imageHeight async {
    Completer<double> completer = Completer();
    FileImage(File(this))
        .resolve(const ImageConfiguration())
        .addListener(
          ImageStreamListener((ImageInfo info, bool _) {
            completer.complete(info.image.height.toDouble());
          }),
        );
    return completer.future;
  }
}

extension SpaceBox on num {
  SizedBox get ph => SizedBox(height: toDouble());
  SizedBox get pw => SizedBox(width: toDouble());
}

extension TextStyleExtension on BuildContext {
  /// Use for large headings
  TextStyle get display => Theme.of(this).textTheme.displayLarge ?? const TextStyle();

  /// Use for section headings
  TextStyle get heading => Theme.of(this).textTheme.headlineMedium ?? const TextStyle();

  /// Use for smaller titles
  TextStyle get title => Theme.of(this).textTheme.titleMedium ?? const TextStyle();

  /// Use for main body text
  TextStyle get body => Theme.of(this).textTheme.bodyMedium ?? const TextStyle();

  /// Use for smaller notes or captions
  TextStyle get caption => Theme.of(this).textTheme.bodySmall ?? const TextStyle();

  /// Use for labels on buttons or small controls
  TextStyle get label => Theme.of(this).textTheme.labelLarge ?? const TextStyle();

  /// Use to access theme itself (for more extensions if needed)
  ThemeData get theme => Theme.of(this);

  /// Use to access color scheme
  ColorScheme get color => Theme.of(this).colorScheme;
}
