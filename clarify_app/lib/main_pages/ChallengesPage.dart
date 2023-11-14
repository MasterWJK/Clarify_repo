import 'package:flutter/material.dart';

class ChallengesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.0), // Default AppBar height.
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF2196F3), // Lighter blue
                  Color(0xFF0D47A1), // Darker blue
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: Text('Language Challenges'),
        ),
      ),
      body: ListView.builder(
        itemCount: challenges.length,
        itemBuilder: (context, index) {
          final challenge = challenges[index];
          return ChallengeTile(
            challengeText: challenge['challengeText']!,
            level: challenge['level']!,
          );
        },
      ),
    );
  }
}

class ChallengeTile extends StatelessWidget {
  final String challengeText;
  final String level;

  const ChallengeTile({
    Key? key,
    required this.challengeText,
    required this.level,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: Icon(Icons.language, color: Colors.blue),
        title: Text(challengeText),
        subtitle: Text('Level: $level'),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Handle the tap event for the challenge
        },
      ),
    );
  }
}

// A list of challenges for demonstration purposes.
final List<Map<String, String>> challenges = [
  {
    'challengeText': 'Introduce yourself in Spanish',
    'level': 'Beginner',
  },
  {
    'challengeText': 'Order food in French',
    'level': 'Intermediate',
  },
  {
    'challengeText': 'Discuss your daily routine in German',
    'level': 'Advanced',
  },
  {
    'challengeText': 'Debate a topic in Mandarin',
    'level': 'Expert',
  },
  // More challenges
  {
    'challengeText': 'Give directions to a tourist in Italian',
    'level': 'Beginner',
  },
  {
    'challengeText': 'Describe your favorite movie in Japanese',
    'level': 'Intermediate',
  },
  {
    'challengeText': 'Negotiate a contract in Russian',
    'level': 'Advanced',
  },
  {
    'challengeText': 'Write a poem in Portuguese',
    'level': 'Expert',
  },
  {
    'challengeText': 'Express your opinion about environmental issues in Dutch',
    'level': 'Intermediate',
  },
  {
    'challengeText': 'Tell a folk tale in Korean',
    'level': 'Advanced',
  },
  {
    'challengeText': 'Discuss a historical event in Arabic',
    'level': 'Expert',
  },
  {
    'challengeText': 'Explain a scientific concept in Hindi',
    'level': 'Advanced',
  },
  {
    'challengeText': 'Narrate a day in your life in Swedish',
    'level': 'Intermediate',
  },
  {
    'challengeText': 'Engage in a sales pitch in Turkish',
    'level': 'Advanced',
  },
  {
    'challengeText': 'Present a cooking recipe in Greek',
    'level': 'Beginner',
  },
];
