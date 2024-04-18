import 'package:flutter/material.dart';

Brightness lightMode = Brightness.light;
Brightness darkMode = Brightness.dark;
Icon lightModeIcon = const Icon(Icons.mode_night_outlined);
Icon darkModeIcon = const Icon(Icons.light_mode_outlined);

class ThemeProvider with ChangeNotifier{
  Brightness _themeMode = darkMode;
  Icon _themeIcon = darkModeIcon;

  Brightness get themeMode => _themeMode;
  Icon get themeIcon => _themeIcon; 

  set themeMode(Brightness themeMode){
     _themeMode = themeMode;
    notifyListeners();
  }

  set themeIcon(Icon themeIcon){
     _themeIcon = themeIcon;
    notifyListeners();
  }

  void toggleTheme(){
    if(_themeMode == lightMode){
      _themeMode = darkMode;
      _themeIcon = darkModeIcon;
    } else {
      _themeMode = lightMode;
      _themeIcon = lightModeIcon;
    }
    notifyListeners();
  }
}