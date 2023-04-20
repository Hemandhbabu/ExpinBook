// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:expin_book/provider/use_cases_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? _preferences;

class SharedPreferencesWrapper {
  static Future<SharedPreferences> get instance async =>
      _preferences ??= await SharedPreferences.getInstance();
}

const currencies = ['₹', '\$', '€', '£'];
final _defaultReminderTime = DateTime(2020, 1, 1, 20, 0);

const _CURRENCY_KEY = 'CURRENCY-KEY';
const _USERNAME_KEY = 'USERNAME-KEY';
const _THEME_KEY = 'THEME-KEY';
const _SHOW_SAVINGS_KEY = 'show-savings';
const _FIRST_LOGIN_KEY = 'first';
const _HAS_DAILY_NOTIFICATION_KEY = 'daily-notification';
const _DAILY_NOTIFICATION_TIME_KEY = 'daily-notification-time';
const _PINNED_CATEGORIES_KEY = 'PINNED-CATEGORIES-KEY';
const _PINNED_BUDGET_KEY = 'PINNED-BUDGET-KEY';

final currencyPreferencesProvider =
    StateNotifierProvider.autoDispose<_StringPreferenceNotifier, String>(
  (ref) => _StringPreferenceNotifier(
    prefs: _preferences!,
    key: _CURRENCY_KEY,
    defaultValue: currencies[0],
  ),
);
final usernamePreferencesProvider =
    StateNotifierProvider.autoDispose<_StringPreferenceNotifier, String>(
  (ref) => _StringPreferenceNotifier(
    prefs: _preferences!,
    key: _USERNAME_KEY,
    defaultValue: 'Guest',
  ),
);
final themePreferencesProvider =
    StateNotifierProvider.autoDispose<_IntPreferenceNotifier, int>(
  (ref) => _IntPreferenceNotifier(
    prefs: _preferences!,
    key: _THEME_KEY,
    defaultValue: 0,
  ),
);
final showSavingsPreferencesProvider =
    StateNotifierProvider.autoDispose<_BoolPreferenceNotifier, bool>(
  (ref) => _BoolPreferenceNotifier(
    prefs: _preferences!,
    key: _SHOW_SAVINGS_KEY,
    defaultValue: true,
  ),
);
final firstLoginPreferencesProvider =
    StateNotifierProvider.autoDispose<_BoolPreferenceNotifier, bool>(
  (ref) => _BoolPreferenceNotifier(
    prefs: _preferences!,
    key: _FIRST_LOGIN_KEY,
    defaultValue: false,
  ),
);
final hasDailyNotificationPreferencesProvider =
    StateNotifierProvider.autoDispose<_BoolPreferenceNotifier, bool>(
  (ref) => _BoolPreferenceNotifier(
    prefs: _preferences!,
    key: _HAS_DAILY_NOTIFICATION_KEY,
    defaultValue: false,
  ),
);
final dailyNotificationTimePreferencesProvider =
    StateNotifierProvider.autoDispose<_StringPreferenceNotifier, String>(
  (ref) => _StringPreferenceNotifier(
    prefs: _preferences!,
    key: _DAILY_NOTIFICATION_TIME_KEY,
    defaultValue: _defaultReminderTime.toIso8601String(),
  ),
);
final pinnedCategoryPreferencesProvider =
    StateNotifierProvider.autoDispose<_StringPreferenceNotifier, String>(
  (ref) => _StringPreferenceNotifier(
    prefs: _preferences!,
    key: _PINNED_CATEGORIES_KEY,
    defaultValue: json.encode([1, 6]),
  ),
);
final pinnedBudgetPreferencesProvider =
    StateNotifierProvider.autoDispose<_IntPreferenceNotifier, int>(
  (ref) => _IntPreferenceNotifier(
    prefs: _preferences!,
    key: _PINNED_BUDGET_KEY,
    defaultValue: -1,
  ),
);

final pinnedCategoryIdsProvider = Provider.autoDispose((ref) {
  final jsonPinned = ref.watch(pinnedCategoryPreferencesProvider);
  return (json.decode(jsonPinned) as List).cast<int>();
});

final pinnedCategoriesProvider = StreamProvider.autoDispose(
  (ref) {
    final pinnedCategoryIds = ref.watch(pinnedCategoryIdsProvider);
    return ref.watch(
      categoryUseCasesProvider.select(
        (value) => value.getAllCategory.watchAll().map(
              (categories) => categories
                  .where((e) => pinnedCategoryIds.contains(e.id))
                  .toList(),
            ),
      ),
    );
  },
);

class _BoolPreferenceNotifier extends _PreferenceNotifier<bool> {
  _BoolPreferenceNotifier({
    required SharedPreferences prefs,
    required String key,
    required bool defaultValue,
  }) : super(
          prefs,
          key: key,
          defaultValue: defaultValue,
          initialValue: prefs.getBool(key) ?? defaultValue,
        );

  Future<void> setBool(bool value) async {
    if (state != value) {
      state = value;
      await prefs.setBool(key, value);
    }
  }
}

class _IntPreferenceNotifier extends _PreferenceNotifier<int> {
  _IntPreferenceNotifier({
    required SharedPreferences prefs,
    required String key,
    required int defaultValue,
  }) : super(
          prefs,
          key: key,
          defaultValue: defaultValue,
          initialValue: prefs.getInt(key) ?? defaultValue,
        );

  Future<void> setInt(int value) async {
    if (state != value) {
      state = value;
      await prefs.setInt(key, value);
    }
  }
}

class _StringPreferenceNotifier extends _PreferenceNotifier<String> {
  _StringPreferenceNotifier({
    required SharedPreferences prefs,
    required String key,
    required String defaultValue,
  }) : super(
          prefs,
          key: key,
          defaultValue: defaultValue,
          initialValue: prefs.getString(key) ?? defaultValue,
        );

  Future<void> setString(String value) async {
    if (state != value) {
      state = value;
      await prefs.setString(key, value);
    }
  }
}

abstract class _PreferenceNotifier<T> extends StateNotifier<T> {
  final SharedPreferences prefs;
  final String key;
  final T defaultValue;
  final T initialValue;

  _PreferenceNotifier(
    this.prefs, {
    required this.key,
    required this.defaultValue,
    required this.initialValue,
  }) : super(initialValue);

  Future<void> removeKey() async {
    state = defaultValue;
    await prefs.remove(key);
  }
}
