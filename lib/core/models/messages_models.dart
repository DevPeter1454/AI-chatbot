// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

/// [Message] which is sent by the user or received from openAI
/// The text message is in [message] and you can use [fromChatGPT] to distinguish whether it is
/// from current user or from openAI API
class Message {
  final String message;
  final bool fromChatGPT;
  final bool isImage;
  Message({
    required this.message,
    required this.fromChatGPT,
    this.isImage = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'fromChatGPT': fromChatGPT,
      'isImage': isImage,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      message: map['message'] as String,
      fromChatGPT: map['fromChatGPT'] as bool,
      isImage: map['isImage'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);
}
