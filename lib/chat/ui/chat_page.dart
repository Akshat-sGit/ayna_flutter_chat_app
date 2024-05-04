import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/chat_bloc.dart';
import '../bloc/chat_state.dart';
import 'chat_input_field.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text(
            'Ayna',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.grey.withOpacity(0.05),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  if (state is ChatLoadingState) {
                    return const Center(
                        child: CupertinoActivityIndicator(
                      color: CupertinoColors.systemBlue,
                    ));
                  } else if (state is ChatLoadedState) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    });

                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: state.messages.length,
                      itemBuilder: (context, index) {
                        final message = state.messages[index];
                        return Align(
                          alignment: message.isSentByUser
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 14.0,
                            ),
                            decoration: BoxDecoration(
                                color: message.isSentByUser
                                    ? CupertinoColors.systemGreen
                                    : CupertinoColors.systemGreen
                                        .withOpacity(0.25),
                                borderRadius:
                                    const BorderRadiusDirectional.only(
                                        topStart: Radius.circular(30.0),
                                        bottomStart: Radius.circular(30.0),
                                        bottomEnd: Radius.circular(30.0))),
                            child: Text(
                              message.content,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is ChatErrorState) {
                    return Center(child: Text(state.error));
                  }
                  return Container();
                },
              ),
            ),
            const ChatInputField(),
          ],
        ),
      ),
    );
  }
}
