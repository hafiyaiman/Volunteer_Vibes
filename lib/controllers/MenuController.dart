

import 'package:flutter/material.dart';

class MenuControllers with ChangeNotifier {
  GlobalKey<ScaffoldState>? _scaffoldKey;

  // Method to set the scaffold key
  void setScaffoldKey(GlobalKey<ScaffoldState> key) {
    _scaffoldKey = key;
    notifyListeners();
  }

  // Method to open the drawer using the stored scaffold key
  void openDrawer() {
    if (_scaffoldKey != null) {
      _scaffoldKey!.currentState?.openDrawer();
    }
  }
}
