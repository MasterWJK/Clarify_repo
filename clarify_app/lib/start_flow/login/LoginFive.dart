import 'package:clarify_app/main.dart';
import 'package:flutter/material.dart';

class LoginFive extends StatefulWidget {
  const LoginFive({Key? key}) : super(key: key);

  @override
  State<LoginFive> createState() => _LoginFiveState();
}

class _LoginFiveState extends State<LoginFive> {
  int selectedField = 1;

  void setSelectedField(int field) {
    setState(() {
      selectedField = field;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 15.0),
                  const Expanded(
                    child: LinearProgressIndicator(
                      minHeight: 8,
                      value: 0.8, // 20% filled
                      backgroundColor: Colors.white, // white
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFF6448CE),
                      ),
                    ),
                  ),
                  const SizedBox(width: 50.0),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 60.0, right: 50.0, top: 70.0),
                child: Text(
                  'Great! How well do you speak english?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30.0),
              const Padding(
                padding: EdgeInsets.only(left: 60.0, right: 60.0),
                child: Text(
                  'This will help us understand where you currently stand in your language learning journey.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign:
                      TextAlign.center, // Add this line to center the text
                ),
              ),
              // Textfield with "Your name"
              const SizedBox(height: 40.0),
              Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                child: InkWell(
                  onTap: () {
                    setSelectedField(1);
                  },
                  child: Opacity(
                    opacity: selectedField == 1 ? 1.0 : 0.5,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.06,
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        top: 14.0,
                        bottom: 10.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Text(
                        'Just started',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                child: InkWell(
                  onTap: () {
                    setSelectedField(2);
                  },
                  child: Opacity(
                    opacity: selectedField == 2 ? 1.0 : 0.5,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.06,
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        top: 14.0,
                        bottom: 10.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Text(
                        'Can talk about basic topics',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                child: InkWell(
                  onTap: () {
                    setSelectedField(3);
                  },
                  child: Opacity(
                    opacity: selectedField == 3 ? 1.0 : 0.5,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.06,
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        top: 14.0,
                        bottom: 10.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Text(
                        'Daily conversations',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                child: InkWell(
                  onTap: () {
                    setSelectedField(4);
                  },
                  child: Opacity(
                    opacity: selectedField == 4 ? 1.0 : 0.5,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.06,
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        top: 14.0,
                        bottom: 10.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Text(
                        'Can handle almost all situations',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                child: InkWell(
                  onTap: () {
                    setSelectedField(5);
                  },
                  child: Opacity(
                    opacity: selectedField == 5 ? 1.0 : 0.5,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.06,
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        top: 14.0,
                        bottom: 10.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Text(
                        'Am fully fluent',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40.0),

              Padding(
                padding: const EdgeInsets.only(left: 107.0, right: 100.0),
                child: GestureDetector(
                  onTap: () {
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
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: 55,
                    decoration: BoxDecoration(
                      color: const Color(0xFFAF9CFB),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                      child: Text(
                        'Start Learning',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
