import 'package:assignment_btf/services/storage_services/get_storage_services.dart';
import 'package:assignment_btf/utils/error_log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  final _storageService = GetStorageServices.instance;

  // Reactive theme mode
  final Rx<ThemeMode> themeMode = ThemeMode.light.obs;
  final RxBool isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadThemeMode();
  }

  // Load theme mode from storage
  void loadThemeMode() {
    try {
      final savedTheme = _storageService.getThemeMode();
      if (savedTheme == 'dark') {
        themeMode.value = ThemeMode.dark;
        isDarkMode.value = true;
      } else {
        themeMode.value = ThemeMode.light;
        isDarkMode.value = false;
      }
      // Update GetX theme
      Get.changeThemeMode(themeMode.value);
    } catch (e) {
      errorLog("ThemeController loadThemeMode", e);
    }
  }

  // Toggle theme
  Future<void> toggleTheme() async {
    try {
      if (isDarkMode.value) {
        themeMode.value = ThemeMode.light;
        isDarkMode.value = false;
        await _storageService.setThemeMode('light');
      } else {
        themeMode.value = ThemeMode.dark;
        isDarkMode.value = true;
        await _storageService.setThemeMode('dark');
      }
      // Update GetX theme
      Get.changeThemeMode(themeMode.value);
    } catch (e) {
      errorLog("ThemeController toggleTheme", e);
    }
  }

  // Set specific theme
  Future<void> setTheme(ThemeMode mode) async {
    try {
      themeMode.value = mode;
      isDarkMode.value = mode == ThemeMode.dark;
      await _storageService.setThemeMode(
        mode == ThemeMode.dark ? 'dark' : 'light',
      );
      // Update GetX theme
      Get.changeThemeMode(mode);
    } catch (e) {
      errorLog("ThemeController setTheme", e);
    }
  }
}
