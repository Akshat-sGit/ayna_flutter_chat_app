import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../data/message_model.dart';
import '../data/message_repository.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final _messageRepository = MessageRepository();
  final _channel =
      WebSocketChannel.connect(Uri.parse('wss://echo.websocket.org'));

  ChatBloc() : super(ChatLoadingState()) {
    on<SendMessageEvent>((event, emit) async {
      _channel.sink.add(event.message);
      await _messageRepository.addMessage(
        MessageModel(content: event.message, isSentByUser: true),
      );
      add(LoadMessagesEvent());
    });

    on<ReceiveMessageEvent>((event, emit) async {
      await _messageRepository.addMessage(
        MessageModel(content: event.message, isSentByUser: false),
      );
      add(LoadMessagesEvent());
    });

    on<LoadMessagesEvent>((event, emit) async {
      final messages = await _messageRepository.getAllMessages();
      emit(ChatLoadedState(messages));
    });

    _channel.stream.listen((message) {
      add(ReceiveMessageEvent(message));
    });

    add(LoadMessagesEvent());
  }

  @override
  Future<void> close() {
    _channel.sink.close();
    return super.close();
  }
}