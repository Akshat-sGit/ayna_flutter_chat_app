import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/chat_bloc.dart';
import '../bloc/chat_event.dart';

class ChatInputField extends StatefulWidget {
  const ChatInputField({Key? key}) : super(key: key);

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      color: Colors.grey.withOpacity(0.10),
      padding: EdgeInsets.only(
        bottom: 10.0 + bottomPadding,
        top: 10.0,
        left: 16.0,
        right: 16.0,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.10), // Background color
                borderRadius: BorderRadius.circular(50.0), // Rounded corners
                border: Border.all(
                    color: CupertinoColors.systemBlue), // Blue border
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      style: const TextStyle(color: Colors.white),
                      cursorColor: CupertinoColors.systemBlue,
                      decoration: const InputDecoration(
                        hintText: 'Type your message...',
                        hintStyle:
                            TextStyle(color: Colors.white, fontSize: 14.0),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                        border: InputBorder.none,
                        enabledBorder:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                        focusedBorder:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (_textController.text.isNotEmpty) {
                        context
                            .read<ChatBloc>()
                            .add(SendMessageEvent(_textController.text));
                        _textController.clear();
                      }
                    },
                    icon: Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: CupertinoColors.systemBlue,
                      ),
                      child: const Icon(
                        Icons.arrow_upward,
                        size: 24.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
