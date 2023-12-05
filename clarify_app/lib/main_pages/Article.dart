import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Article extends StatelessWidget {
  final List<Map<String, String>> articles = [
    {
      'title':
          'OpenAI launches API that lets developers build assistants into their apps',
      'preview':
          'OpenAI has launched an API that lets developers build assistants into their apps. The API is designed to help developers create assistants that can understand natural language and perform tasks such as scheduling appointments, booking flights, and ordering food. The API is available for free to developers who sign up for OpenAI’s developer program.',
      'url':
          'https://techcrunch.com/2023/11/06/openai-launches-api-that-lets-developers-build-assistants-into-their-apps/?guccounter=1#:~:text=URL%3A%20https%3A%2F%2Ftechcrunch.com%2F2023%2F11%2F06%2Fopenai',
    },
    {
      'title':
          'Ministry of Education partners with ASI to develop AI tutor to boost education for all',
      'preview':
          'The Ministry of Education has partnered with ASI to develop an AI tutor to boost education for all. The AI tutor will be able to provide personalized learning experiences for students, helping them to learn at their own pace and in their own way. The project is part of the government’s efforts to improve education for all.',
      'url':
          'https://www.zawya.com/en/press-release/government-news/ministry-of-education-partners-with-asi-to-develop-ai-tutor-to-boost-education-for-all-c5bkn0f6',
    },
    {
      'title':
          'OpenAI wants to work with organizations to build new AI training data sets',
      'preview':
          'OpenAI is looking to work with organizations to build new AI training data sets. The company is hoping to create data sets that are more diverse and representative of the real world, which will help improve the accuracy and fairness of AI systems. OpenAI is inviting organizations to submit proposals for data sets that they would like to create.',
      'url':
          'https://techcrunch.com/2023/11/09/openai-wants-to-work-with-organizations-to-build-new-ai-training-data-sets/',
    },
    {
      'title':
          'A future-facing minister, a young inventor and a shared vision: an AI tutor for every student',
      'preview':
          'A new AI tutor is being developed to help every student in the UK. The project is being led by the UK’s Department for Education and is being developed in collaboration with a young inventor. The AI tutor will be able to provide personalized learning experiences for students, helping them to learn at their own pace and in their own way.',
      'url':
          'https://news.microsoft.com/europe/features/a-future-facing-minister-a-young-inventor-and-a-shared-vision-an-ai-tutor-for-every-student/',
    },
  ];

  Future<void> launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI New Articles'),
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
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ListTile(
              title: Text(articles[index]['title'] ?? ''),
              subtitle: Text(articles[index]['preview'] ?? ''),
              onTap: () => launchURL(articles[index]['url'] ?? ''),
            ),
          );
        },
      ),
    );
  }
}
