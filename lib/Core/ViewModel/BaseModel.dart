import 'package:flutter/widgets.dart';

enum ViewState { Idle, Busy }

class BaseModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  @override
  void dispose() {
    if (_state == ViewState.Idle) super.dispose();
  }
}
