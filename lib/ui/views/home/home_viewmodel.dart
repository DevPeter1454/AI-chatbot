import 'package:ask_ai/core/models/messages_models.dart';
import 'package:stacked/stacked.dart';
import 'package:logger/logger.dart';

class HomeViewModel extends FormViewModel {
  final log = Logger();

  bool _menuActive = false;

  bool get menuActive => _menuActive;

  final List<Message> _messagesList = [];

  List<Message> get messagesList => _messagesList;

  void loading() {
    setBusy(true);
  }

  void loaded() {
    setBusy(false);
  }

  void toggleMenu(bool active) {
    _menuActive = active;
    notifyListeners();
  }

  void addMessage(dynamic messages) {
    // log.d(_messagesList);

    log.v(messages.length);

    for (var i = 0; i < messages.length; i++) {
      log.v(messages[i].message);
      // _messagesList.add(Message(
      //     message: messages[i].message, fromChatGPT: messages[i].fromChatGPT));
    }

    // log.d(_messagesList.length);
  }
}
