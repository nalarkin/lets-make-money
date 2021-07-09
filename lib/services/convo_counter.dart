import 'package:flutter/cupertino.dart';

class ConvoCount with ChangeNotifier {
  int _currVal = 0;
  ConvoCount();

  void add() {
    _currVal += 1;
    notifyListeners();
  }

  void reset() {
    _currVal = 0;
    notifyListeners();
  }

  int get count => _currVal;
}
