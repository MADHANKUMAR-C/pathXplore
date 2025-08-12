// lib/styles/app_button_styles.dart

import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppButtonStyles {
  static final primaryButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );

  static final secondaryButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.accent,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
}
