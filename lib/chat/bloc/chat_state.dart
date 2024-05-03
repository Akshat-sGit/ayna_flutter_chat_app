import '../data/message_model.dart';

abstract class ChatState {}

class ChatLoadingState extends ChatState {}

class ChatLoadedState extends ChatState {
  final List<MessageModel> messages;
  ChatLoadedState(this.messages);
}

class ChatErrorState extends ChatState {
  final String error;
  ChatErrorState(this.error);
}
