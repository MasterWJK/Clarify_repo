import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:clarify_app/main.dart';
import 'package:flutter/material.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

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
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer.newPlayer();

  @override
  void initState() {
    super.initState();
    OpenAI.apiKey = widget.env;
    print(widget.env);
  }

  Future<String> createSpeech(String inputParameter) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    // The speech request.
    File speechFile = await OpenAI.instance.audio.createSpeech(
      model: "tts-1",
      input: inputParameter,
      voice: "nova",
      responseFormat: OpenAIAudioSpeechResponseFormat.mp3,
      outputDirectory: await Directory('$appDocPath/speechOutput').create(),
      outputFileName: "output",
    );
    return speechFile.path;
  }

  Future<void> createTranscription(String filePath) async {
    OpenAIAudioModel transcription =
        await OpenAI.instance.audio.createTranscription(
      file: File(filePath),
      model: "whisper-1",
      responseFormat: OpenAIAudioResponseFormat.json,
    );

    // print the transcription.
    print(transcription.text);
    // play the trascription
    playAudioTranscript(transcription.text);
  }

  // Play the audio transcript
  void playAudioTranscript(String filePath) {
    assetsAudioPlayer.open(
      Audio.file(filePath),
      autoStart: true,
      showNotification: true,
    );
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
    assetsAudioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Dismiss keyboard when tapping outside of TextField
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 2,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    // go to Home page
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 300),
                        transitionsBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation,
                            Widget child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        pageBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation) {
                          return HomePage();
                        },
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.keyboard_arrow_left_rounded,
                    size: 35,
                  ),
                ),
              ),
              const CircleAvatar(
                backgroundImage: AssetImage('assets/icon/ClarifyRound.png'),
              ),
              const SizedBox(width: 20),
              const Padding(
                padding: EdgeInsets.only(top: 6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Clarify.ai',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.black)),
                    Text('Active now',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
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
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFC19BFF),
                Colors.white,
              ],
            ),
          ),
          child: Column(
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
                          color: isUserMessage
                              ? Color(0xFFB6E0FE)
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        constraints: BoxConstraints(
                          maxWidth:
                              250, // Set the maximum width for the container
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () async {
                                String inputText = message.substring(6);
                                String filepath = await createSpeech(inputText);
                                // print(filepath);
                                createTranscription(filepath); // for the output
                              },
                              icon: Icon(
                                Icons.play_arrow,
                                color: Colors.black,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                message,
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 30),
                child: TextField(
                  controller: _textController,
                  onSubmitted: (text) {
                    setState(() {
                      if (text.isNotEmpty) {
                        _chatHistory.add('User: $text');
                      }
                    });
                    sendToAI(text);
                    _textController.clear();
                  },
                  decoration: InputDecoration(
                    labelText: 'Input your query',
                    labelStyle: TextStyle(color: Color(0xFFC19BFF)),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFC19BFF)),
                    ),
                    // recoding icon
                    suffixIcon: IconButton(
                      onPressed: () async {
                        // possibilty to record
                      },
                      icon: const Icon(
                        Icons.mic,
                        color: Color(0xFFC19BFF),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
