import 'package:flutter/material.dart';

class HomescreenProvider extends ChangeNotifier {
  bool? _isBoySelected;
  List<bool> _numberBoxSelections = List.generate(6, (index) => false);

  bool? get isBoySelected => _isBoySelected;
  List<bool> get numberBoxSelections => _numberBoxSelections;

  void selectgender(bool isboy) {
    _isBoySelected = isboy;
    notifyListeners();
  }

  void selectage(int age) {
    _numberBoxSelections = List.generate(6, (i) => i == age);
    notifyListeners();
  }

  int? getselectedage() {
    for (int i = 0; i < _numberBoxSelections.length; i++) {
      if (_numberBoxSelections[i]) return i + 4;
    }
    return null;
  }
}
