import 'package:clarify_app/start_flow/login/LoginSecond.dart';
import 'package:flutter/material.dart';
// import Login2
import 'Login.dart';

class LoginStart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height * 0.3,
              child: Column(
                children: [
                  Image.asset(
                    'assets/icon/ClarifyRound.png',
                    width: 150, // adjust the width as desired
                    height: 150, // adjust the height as desired
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Clarify.AI',
                    style: TextStyle(
                      color: Color(0xFF7A5AF8),
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Your path to language\nspeaking mastery',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF7A5AF8),
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 140),
                  GestureDetector(
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
                            return const LoginSecond();
                          },
                        ),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 55,
                      decoration: BoxDecoration(
                        color: Color(0xFFAF9CFB),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
