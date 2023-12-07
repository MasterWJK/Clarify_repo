import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import 'package:clarify_app/main.dart';
import 'package:flutter/material.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class AiChat extends StatefulWidget {
  final String env;

  const AiChat({super.key, required this.env});

  @override
  OpenAIChatPageState createState() => OpenAIChatPageState();
}

class OpenAIChatPageState extends State<AiChat> {
  /// The [TextEditingController] used for inputting text in the chat.
  final TextEditingController _textController = TextEditingController();

  /// The chat history that stores the messages exchanged in the chat.
  final List<String> _chatHistory = [];

  /// The client for interacting with the OpenAI API.
  late OpenAI client;

  /// The subscription to the chat stream.
  StreamSubscription? _chatSubscription;

  /// The scroll controller for scrolling the chat view.
  final ScrollController _scrollController = ScrollController();

  /// The audio player for playing audio assets.
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer.newPlayer();

  @override
  void initState() {
    super.initState();
    OpenAI.apiKey = widget.env;
    if (kDebugMode) {
      print(widget.env);
    }
  }

  /// Represents the system message that will be sent to the request.
  ///
  /// This message is designed for an assistant that responds with kindness and provides constructive feedback when a user makes a mistake. The assistant maintains a positive and supportive tone, ensuring the user feels encouraged and valued. It focuses on guiding the user towards the correct information or approach, while emphasizing learning and growth from mistakes.
  final systemMessage = OpenAIChatCompletionChoiceMessageModel(
    content: [
      OpenAIChatCompletionChoiceMessageContentItemModel.text(
        "{This role is designed for an assistant that responds with kindness and provides constructive feedback when a user makes a mistake. The assistant maintains a positive and supportive tone, ensuring the user feels encouraged and valued. It focuses on guiding the user towards the correct information or approach, while emphasizing learning and growth from mistakes.",
      ),
    ],
    role: OpenAIChatMessageRole.assistant,
  );

  /// Creates a speech file using the OpenAI API.
  ///
  /// The [inputParameter] is the text input for generating the speech.
  /// The method returns a [Future] that resolves to the path of the created speech file.
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
    // print the path of the speech file.
    if (kDebugMode) {
      print(speechFile.path);
    }
    return speechFile.path;
  }

  /// Creates a transcription for the audio file located at the given [filePath].
  /// Returns a [Future] that completes with no return value.
  /// The transcription is created using the OpenAI audio model "whisper-1".
  /// The response format of the transcription is JSON.
  /// Prints the created transcription text to the console.
  Future<void> createTranscription(String filePath) async {
    OpenAIAudioModel transcription =
        await OpenAI.instance.audio.createTranscription(
      file: File(filePath),
      model: "whisper-1",
      responseFormat: OpenAIAudioResponseFormat.json,
    );
    if (kDebugMode) {
      print("Transcription is created: ${transcription.text}");
    }
  }

  /// Plays the audio transcript from the specified file path.
  ///
  /// The [filePath] parameter is the path to the audio file.
  /// This method uses the [assetsAudioPlayer] to open and play the audio file.
  /// The audio will automatically start playing and a notification will be shown.
  void playAudioTranscript(String filePath) {
    assetsAudioPlayer.open(
      Audio.file(filePath),
      autoStart: true,
      showNotification: true,
    );
  }

  /// Sends a user query to the OpenAI chatbot and listens to the response stream.
  ///
  /// If the [query] is not empty, this method creates a stream of [OpenAIStreamChatCompletionModel]
  /// using the OpenAI instance and the specified model. The stream listens to the
  /// response from the chatbot and passes the response to the [streamWords] function.
  ///
  /// The [query] parameter is the user's input message to the chatbot.
  ///
  /// This method does not return anything, but it sets [_chatSubscription] to the chat stream
  /// subscription, which can be used to cancel the subscription later.
  void sendToAI(String query) async {
    if (query.isNotEmpty) {
      final userMessage = OpenAIChatCompletionChoiceMessageModel(
        content: [
          OpenAIChatCompletionChoiceMessageContentItemModel.text(
            query,
          ),
        ],
        role: OpenAIChatMessageRole.user,
      );
      Stream<OpenAIStreamChatCompletionModel> chatStream =
          OpenAI.instance.chat.createStream(
        model: "gpt-3.5-turbo",
        messages: [
          userMessage,
          systemMessage,
        ],
      );

      _chatSubscription = chatStream.listen(
        (streamChatCompletion) {
          for (var element
              in streamChatCompletion.choices.first.delta.content!) {
            if (element.type == 'text') {
              streamWords(element.text!);
            }
          }
        },
        onError: (error) {
          print(error);
        },
      );
    }
  }

  /// Splits the [response] into words and updates the chat history accordingly.
  ///
  /// Each word in the [response] is processed and added to the chat history.
  /// If the chat history is not empty and the last message starts with 'Clarify: ',
  /// the word is appended to the last message. Otherwise, a new message starting
  /// with 'Clarify: ' is added to the chat history.
  /// After updating the chat history, the scroll position is animated to the
  /// maximum scroll extent.
  void streamWords(String response) {
    var words = response.split(' ');
    for (var word in words) {
      setState(() {
        if (_chatHistory.isNotEmpty &&
            _chatHistory.last.startsWith('Clarify: ')) {
          // append to last message:
          _chatHistory[_chatHistory.length - 1] += ' $word';
        } else {
          // start with Clarify:
          _chatHistory.add('Clarify: $word');
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

  /// Builds the AiChat page.
  ///
  /// This method returns a [Widget] that represents the AiChat page.
  /// The AiChat page displays a chat interface where users can interact with an AI assistant.
  /// It includes a chat history, an input text field, and options to play audio and record voice input.
  /// Tapping outside the text field dismisses the keyboard.
  /// Tapping the back button navigates to the Home page.
  /// The app bar displays the Clarify.ai logo, the user's active status, and a gradient background.
  /// The body of the page is decorated with a gradient background and contains the chat history and input text field.
  /// Each chat message is displayed in a container with a play button and the message text.
  /// The user can play audio, send text messages, and record voice input.
  /// The [sendToAI] method is called when the user submits a text message.
  /// The [createSpeech], [createTranscription], and [playAudioTranscript] methods are called when the user plays audio.

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
                          return const HomePage();
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
                    Text(
                      'Clarify.ai',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.black),
                    ),
                    Text(
                      'Active now',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFC19BFF),
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
                        margin: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: isUserMessage
                              ? const Color(0xFFB6E0FE)
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        constraints: const BoxConstraints(
                          maxWidth:
                              300, // Set the maximum width for the container
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () async {
                                String inputText = '';
                                if (message.startsWith('User:')) {
                                  inputText = message.substring(6);
                                } else if (message.startsWith('Clarify:')) {
                                  inputText = message.substring(9);
                                }
                                String filepath = await createSpeech(inputText);
                                // print(filepath);
                                createTranscription(filepath); // for the output
                                playAudioTranscript(filepath);
                              },
                              icon: const Icon(
                                Icons.play_arrow,
                                color: Colors.black,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                message,
                                style: const TextStyle(fontSize: 16.0),
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
                    labelStyle: const TextStyle(color: Color(0xFFC19BFF)),
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
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
