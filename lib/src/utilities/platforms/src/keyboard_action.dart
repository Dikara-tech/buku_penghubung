import 'package:flutter/services.dart';

class KeyboardAction {
  static void hide() {
    SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
  }
}
