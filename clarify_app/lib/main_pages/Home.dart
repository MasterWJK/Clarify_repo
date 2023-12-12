import 'package:flutter/material.dart';

// Future<void> launchURL(String url) async {
//   final Uri uri = Uri.parse(url);
//   if (!await launchUrl(uri)) {
//     throw Exception('Could not launch $url');
//   }
// }

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: Container(
          color: Color(0xFFEAD9FF), // A much lighter shade, closer to white
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(140.0), // Set your desired height here
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello Woojin!',
                style: TextStyle(
                    fontSize: 12.0, // Adjust the font size as needed
                    color: Colors.black),
              ),
              SizedBox(height: 10),
              Text(
                'Continue your English \nspeaking lesson!',
                style: TextStyle(
                  fontSize: 26.0, // Adjust the font size as needed
                  color: Color(0xFF957BF9), // Your specified color
                  // bold
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Your Lessons',
                style: TextStyle(
                    fontSize: 12.0, // Adjust the font size as needed
                    color: Colors.black),
              ),
              SizedBox(height: 20),
            ],
          ), // This can be an empty Container
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
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/AITraining'),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                          10), // This makes the container round
                    ),
                    width: MediaQuery.of(context).size.width *
                        0.8, // 80% of screen width
                    height: MediaQuery.of(context).size.height *
                        0.2, // 20% of screen height
                    child: Column(
                      children: [
                        Expanded(
                          flex: 55,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10), // Adjust horizontal padding
                            child: const Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'AI conversation training',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          4), // Space between title and text
                                  Text(
                                    'Improve your speaking abilities with your AI tutor, focusing on real-world scenarios.',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 55,
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/Conversation.png'), // Replace with your image path
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => // progress page
                    Navigator.pushNamed(context, '/progress'),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                          10), // This makes the container round
                    ),
                    width: MediaQuery.of(context).size.width *
                        0.8, // 80% of screen width
                    height: MediaQuery.of(context).size.height *
                        0.2, // 20% of screen height
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 50,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 6), // Adjust horizontal padding
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Daily practice',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                    height: 4), // Space between title and text

                                Text(
                                  'Practice vocabulary, grammar and pronunciation. ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 55,
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/Practice.png'), // Replace with your image path
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // in widgetstyle
            // Expanded(
            //     child: ConversationTrainingCard(
            //         content: "Test",
            //         title: "Test",
            //         picture: "assets/Conversation.png")),
          ],
        ),
      ),
    );
  }
}

class ConversationTrainingCard extends StatelessWidget {
  final String title;
  final String content;
  final String picture;

  const ConversationTrainingCard({
    super.key,
    required this.title,
    required this.content,
    required this.picture,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Full width of the parent
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // White container for title and content
          Container(
            padding: EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white, // White background color
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  content,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          // Image container
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: Image.asset(
              picture,
              fit: BoxFit.cover, // Make sure the image covers the container
            ),
          ),
        ],
      ),
    );
  }
}
