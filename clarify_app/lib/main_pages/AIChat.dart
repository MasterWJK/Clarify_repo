import 'dart:async';

import 'package:flutter/material.dart';
import 'package:dart_openai/dart_openai.dart';

class AIChat extends StatefulWidget {
  final String env;

  const AIChat({Key? key, required this.env}) : super(key: key);

  @override
  OpenAIChatPageState createState() => OpenAIChatPageState();
}

class OpenAIChatPageState extends State<AIChat> {
  final TextEditingController _textController = TextEditingController();
  final List<String> _chatHistory = [];
  late OpenAI client;
  StreamSubscription? _chatSubscription;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    OpenAI.apiKey = widget.env;
    print(widget.env);
  }

  /// Sends a user query to OpenAI chatbot and listens to the response stream.
  ///
  /// If the query is not empty, it creates a stream of [OpenAIStreamChatCompletionModel]
  /// using the OpenAI instance and the specified model. The stream listens to the
  /// response from the chatbot and passes the response to [streamWords] function.
  ///
  /// The [query] parameter is the user's input message to the chatbot.
  ///
  /// The function returns nothing, but it sets [_chatSubscription] to the chat stream
  /// subscription, which can be used to cancel the subscription later.
  void sendToAI(String query) async {
    if (query.isNotEmpty) {
      Stream<OpenAIStreamChatCompletionModel> chatStream =
          OpenAI.instance.chat.createStream(
        model: "gpt-3.5-turbo",
        messages: [
          OpenAIChatCompletionChoiceMessageModel(
            content: query,
            role: OpenAIChatMessageRole.user,
          ),
        ],
      );

      _chatSubscription = chatStream.listen(
        (streamChatCompletion) {
          final content = streamChatCompletion.choices.first.delta.content;
          // check if content is empty
          streamWords(content!);
        },
        onError: (error) {
          print(error);
        },
      );
    }
  }

  /// Splits the [response] into words and adds each word to the chat history as a new message starting with "AI: ".
  /// If the previous message in the chat history also starts with "AI: ", the word is appended to the previous message.
  /// Scrolls to the bottom of the chat history after adding the new message.
  void streamWords(String response) {
    var words = response.split(' ');
    for (var word in words) {
      setState(() {
        if (_chatHistory.isNotEmpty && _chatHistory.last.startsWith('AI: ')) {
          // append to last message:
          _chatHistory[_chatHistory.length - 1] += ' $word';
        } else {
          // start with AI:
          _chatHistory.add('AI: $word');
        }
      });
    }
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _chatSubscription?.cancel();
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Dismiss keyboard when tapping outside of TextField
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('OpenAI Chatbot'), // App title
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFC19BFF), // Your specified color
                  Color(0xFFB6E0FE),
                ],
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              // Chat history
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _chatHistory.length,
                itemBuilder: (context, index) {
                  final message = _chatHistory[index];
                  final isUserMessage = message.startsWith('User: ');
                  return Container(
                    alignment: isUserMessage
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color:
                            isUserMessage ? Colors.blue[100] : Colors.grey[200],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        message,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _textController,
                onSubmitted: (text) {
                  setState(() {
                    _chatHistory.add('User: $text');
                  });
                  sendToAI(text);
                  _textController.clear();
                },
                decoration: const InputDecoration(
                  labelText: 'Input your query',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
