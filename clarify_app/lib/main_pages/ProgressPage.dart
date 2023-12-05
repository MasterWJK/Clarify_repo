import 'package:clarify_app/main.dart';
import 'package:flutter/material.dart';

class ProgressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.0), // Default AppBar height.
        child: AppBar(
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
                    size: 32,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0, top: 10.0),
                child: Text('Daily Practice',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white)),
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
        child: const Column(
          children: [
            Padding(
              padding: EdgeInsets.all(24.0),
              child: LearningProgressWidget(
                learnedMinutes: 15,
                totalMinutes: 20,
              ),
            ),
            FlashcardWidget(title: 'Grammar flashcards'),
            FlashcardWidget(title: 'Vocabulary flashcards'),
            FlashcardWidget(title: 'Speech training'),
          ],
        ),
      ),
    );
  }
}

class LearningProgressWidget extends StatelessWidget {
  final int learnedMinutes;
  final int totalMinutes;

  const LearningProgressWidget({
    Key? key,
    required this.learnedMinutes,
    required this.totalMinutes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double progress = learnedMinutes / totalMinutes;
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF957BF9),
            Color(0xFFC19BFF),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Learned today',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(
            '$learnedMinutes min / $totalMinutes min',
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8 * progress,
                height: 10,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFB6E0FE), // Blue color
                      Color(0xFFFFA500), // Orange color
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FlashcardWidget extends StatelessWidget {
  final String title;

  const FlashcardWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width:
          MediaQuery.of(context).size.width * 0.85, // 80% of the screen width
      height: 100,
      padding: EdgeInsets.all(20), // Inner padding for the text
      margin: EdgeInsets.only(bottom: 20), // Space between cards
      decoration: BoxDecoration(
        color: Colors.white, // Background color of the card
        borderRadius: BorderRadius.circular(10), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), // Shadow color
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 2), // Shadow position
          ),
        ],
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
