import 'package:clarify_app/main.dart';
import 'package:flutter/material.dart';

class AITraining extends StatefulWidget {
  const AITraining({Key? key}) : super(key: key);

  @override
  State<AITraining> createState() => _AITrainingState();
}

class _AITrainingState extends State<AITraining> {
  String _selectedSegment = 'Roleplay'; // Initial selected segment

  void _onSegmentTap(String segment) {
    setState(() {
      _selectedSegment = segment;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 85,
        elevation: 2,
        title: Row(
          children: [
            IconButton(
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
            const Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 40.0, top: 10),
                child: Text(
                  'Conversation training with\n your AI tutor',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
        flexibleSpace: Container(
          color: Color(0xFFEAD9FF),
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
            // Your segmented control widget
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSegmentedControlButton(
                      'Roleplay', _selectedSegment == 'Roleplay'),
                  _buildSegmentedControlButton(
                      'Custom', _selectedSegment == 'Custom'),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24.0), // Padding around the grid
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                  shrinkWrap: true, // Use this to prevent any sizing issues
                  physics:
                      NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                  children: List.generate(6, (index) {
                    // Array of titles for the cards
                    const titles = [
                      'Team Collaboration',
                      'Client Meeting',
                      'Project Planning',
                      'Sales Strategy',
                      'Market Research',
                      'Innovation Brainstorm'
                    ];

                    // Array of asset paths for icons, replace with your actual asset paths
                    const icons = [
                      'assets/icon/TeamCollaboration.png',
                      'assets/icon/ClientMeeting.png',
                      'assets/icon/ProjectPlanning.png',
                      'assets/icon/SalesStrategy.png',
                      'assets/icon/MarketResearch.png',
                      'assets/icon/InnovationBrainstorm.png',
                    ];

                    // Ensure the index is within the range of available titles and icons
                    final title = titles[index % titles.length];
                    final icon = icons[index % icons.length];

                    return _buildGridCard(title, icon);
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSegmentedControlButton(String text, bool isSelected) {
    return ElevatedButton(
      onPressed: () {
        _onSegmentTap(text);
      },
      style: ElevatedButton.styleFrom(
        primary: isSelected
            ? Colors.deepPurple.withOpacity(0.8)
            : Colors.transparent, // Background color
        onPrimary: isSelected ? Colors.white : Colors.deepPurple, // Text color
        side: BorderSide(color: Colors.deepPurple, width: 1), // Border color
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
      ),
      child: Text(text),
    );
  }

  Widget _buildGridCard(String title, String assetName) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2,
      color: Colors.white
          .withOpacity(0.9), // Adjust opacity for less white background
      child: InkWell(
        onTap: () {
          // go to AI chat page
          Navigator.pushNamed(context, '/daily_ai');
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  assetName,
                  width: 100,
                  height: 100,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
