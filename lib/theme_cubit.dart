import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';


class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit():super(_lightTheme);
  void toggletheme()=> emit(state.brightness == Brightness.dark ? _lightTheme : _darktheme);
}

final _lightTheme=ThemeData(
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: Colors.tealAccent,
  ),
  useMaterial3: true,
);
final _darktheme=ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.tealAccent,  // Replace this with your desired seed color
    brightness: Brightness.dark,
  ),
  useMaterial3: true,
);



