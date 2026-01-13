import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nextalk_community/core/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeProvider =
    StateNotifierProvider<ThemeNotifier, ThemeMode>((_) => ThemeNotifier());

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.dark) {
    _loadTheme();
  }

  void _loadTheme() async {
    final pref = await SharedPreferences.getInstance();
    final themeIndex = pref.getInt(AppConstants.cacheThemeKey) ?? 1;
    state = ThemeMode.values[themeIndex];
  }

  void setTheme(ThemeMode mode) async {
    state = mode;
    final pref = await SharedPreferences.getInstance();
    await pref.setInt(AppConstants.cacheThemeKey, mode.index);
  }
}
