import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klontong/bloc/theme/theme.event.dart';
import 'package:klontong/bloc/theme/theme.state.dart';
import 'package:klontong/config/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  static const String themePreferenceKey = 'theme_preference';

  ThemeBloc() : super(ThemeState(themeData: ThemeConfig.lightTheme)) {
    on<ToggleTheme>(_onToggleTheme);
    _loadTheme(); // Load theme on initialization
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkTheme = prefs.getBool(themePreferenceKey) ?? false;
    final initialTheme =
        isDarkTheme ? ThemeConfig.darkTheme : ThemeConfig.lightTheme;
    emit(ThemeState(themeData: initialTheme));
  }

  Future<void> _onToggleTheme(
      ToggleTheme event, Emitter<ThemeState> emit) async {
    final newTheme = state.themeData == ThemeConfig.lightTheme
        ? ThemeConfig.darkTheme
        : ThemeConfig.lightTheme;
    emit(ThemeState(themeData: newTheme));
    await _saveTheme(newTheme == ThemeConfig.darkTheme);
  }

  Future<void> _saveTheme(bool isDarkTheme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(themePreferenceKey, isDarkTheme);
  }
}
