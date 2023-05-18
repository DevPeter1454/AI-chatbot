import 'dart:math';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:ask_ai/app/app.locator.dart';
import 'package:ask_ai/core/models/messages_models.dart';
import 'package:ask_ai/services/download_service.dart';
import 'package:clipboard/clipboard.dart';
import 'package:dart_openai/openai.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ChatViewModel extends BaseViewModel {
  final chat = OpenAI.instance.chat;
  final completion = OpenAI.instance.completion;
  final image = OpenAI.instance.image;
  final log = Logger();
  final List<Message> _messages = [];
  final _snackbarService = locator<SnackbarService>();
  final _downloadService = locator<DownloadService>();
  bool _menuActive = false;
  bool _isImageGeneration = false;
  bool get isImageGeneration => _isImageGeneration;
  bool get menuActive => _menuActive;
  List<Message> get messages => _messages;
  String? filePath;

  void toggleMenu(bool active) {
    _menuActive = active;
    log.v('Menu active: $_menuActive');
    notifyListeners();
  }

  void runStartupLogic() async {
    Directory? appDir = await getExternalStorageDirectory();
    filePath = appDir!.path;
    log.d('File path: $filePath');
    notifyListeners();
  }

  Future copyText(String text) async {
    FlutterClipboard.copy(text).then((value) {
      _snackbarService.showSnackbar(message: 'Copied to clipboard');
      rebuildUi();
    });
  }

  Future deleteMessage(int index) async {
    _snackbarService.showSnackbar(
        message: 'Are you sure you want to delete this message?',
        mainButtonTitle: 'Yes',
        onMainButtonTapped: () => deleteMessageConfirmed(index));
    rebuildUi();
  }

  Future deleteMessageConfirmed(int index) async {
    _messages.removeAt(index);
    _snackbarService.showSnackbar(message: 'Message deleted');
    notifyListeners();
  }

  Future<bool> addMessage(String text, {bool fromChatGPT = false}) async {
    if (text.isEmpty) return false;
    if (!_isImageGeneration) {
      _messages.add(Message(message: text, fromChatGPT: fromChatGPT));
      final response = await getChatGptCompletion(text);
      _messages.add(Message(
        message: response,
        fromChatGPT: true,
      ));
      notifyListeners();
      return true;
    } else {
      _messages.add(Message(message: text, fromChatGPT: fromChatGPT));
      final response = await getImageGeneration(text);
      _messages.add(Message(
        message: response,
        fromChatGPT: true,
        isImage: true,
      ));

      notifyListeners();
      return true;
    }
  }

  Future<String> getChatGptCompletion(String prompt) async {
    setBusy(true);
    try {
      final response = await chat.create(
        model: "gpt-3.5-turbo",
        maxTokens: 256,
        messages: [
          OpenAIChatCompletionChoiceMessageModel(
            content: prompt,
            role: OpenAIChatMessageRole.user,
          ),
        ],
      );
      setBusy(false);

      log.i(response.choices);
      return response.choices.first.message.content;
    } on RequestFailedException catch (e) {
      setBusy(false);
      log.e(e);
      showSnackBar(e.message);
      return '';
    } on Exception catch (e) {
      setBusy(false);
      log.e(e);
      showSnackBar('Something went wrong');
      return '';
    }
  }

  Future<String> getImageGeneration(String prompt) async {
    setBusy(true);
    showSnackBar('Generating image...');
    try {
      final response = await image.create(
        prompt: prompt,
        n: 1,
        size: OpenAIImageSize.size1024,
        responseFormat: OpenAIImageResponseFormat.url,
      );
      setBusy(false);
      log.i(response.data);

      return response.data.first.url;
    } on RequestFailedException catch (e) {
      setBusy(false);
      log.e(e);
      showSnackBar(e.message);
      return '';
    }
  }

  void getVoiceTranscription() {}

  void showSnackBar(String message) {
    _snackbarService.showSnackbar(
        message: message, duration: const Duration(seconds: 5));
    rebuildUi();
  }

  void toggleMode() {
    _isImageGeneration = !_isImageGeneration;
    log.v('image generation mode: $_isImageGeneration');
    _snackbarService.showSnackbar(
        message: _isImageGeneration
            ? 'Switched to Image generation'
            : 'Switched to Chat GPT');

    notifyListeners();
  }

  // Future<String> getImageUrl(String prompt) async {
  //   setBusy(true);
  //   try {
  //     final response = await _apiService.getImageResponse(prompt);
  //     showSnackBar('Image is ${response['status']}, please wait...');
  //     String imageUrl = '';
  //     if (response['status'] == 'processing') {
  //       await Future.delayed(Duration(seconds: response['data'].eta), () async {
  //         final newResponse =
  //             await _apiService.getImageLink(response['data'].fetch_result);
  //         log.i(newResponse);
  //         if (newResponse.status == 'processing') {
  //           imageUrl = await getImageUrl(response['data'].fetch_result);
  //         } else {
  //           imageUrl = newResponse.image;
  //         }
  //       });
  //     } else {
  //       imageUrl = response['data'].image;
  //     }

  //     setBusy(false);
  //     return imageUrl;
  //   } on Exception catch (e) {
  //     setBusy(false);
  //     log.e(e);
  //     showSnackBar(e.toString());
  //     return '';
  //   }
  // }

  String generateRandomFileName(int length) {
    final random = Random();
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    return String.fromCharCodes(Iterable.generate(
      length,
      (_) => chars.codeUnitAt(random.nextInt(chars.length)),
    ));
  }

  Future downloadImage(String url) async {
    showSnackBar('Downloading image...');
    String fileName = generateRandomFileName(10);

    final status =
        await _downloadService.downloadImage(url, fileName: fileName);

    if (status == true) {
      showSnackBar('Image downloaded successfully');
    } else {
      showSnackBar('Image download failed');
    }
  }

  void saveVoice(File soundFile) async {
    String fileName = generateRandomFileName(10);
    String newFilePath = '$filePath/$fileName';
    File file = File(soundFile.path);
    bool exists = await file.exists();
    if (!exists) {
      await file.create();
    }
  }
}
