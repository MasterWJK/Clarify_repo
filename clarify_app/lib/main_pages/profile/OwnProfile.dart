import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'package:clarify_app/components/layout_provider.dart';
import 'package:clarify_app/main_pages/profile/SettingsProfile.dart';

class OwnProfile extends StatefulWidget {
  const OwnProfile({Key? key}) : super(key: key);

  @override
  OwnProfileState createState() => OwnProfileState();
}

class OwnProfileState extends State<OwnProfile> {
  // late OwnProfileProvider userProvider;

  @override
  void initState() {
    super.initState();
    // userProvider = Provider.of<OwnProfileProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    var topBarHeight = LayoutProvider(context).topBarHeight;
    var indentation = LayoutProvider(context).indentation;
    return Scaffold(
        body: FutureBuilder(
      // future: userProvider.setUser,
      future: null,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        }
        return SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 6, // top:10
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        // Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.keyboard_arrow_left_rounded,
                        size: 35,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) => ScrollConfiguration(
                            behavior: const ScrollBehavior(),
                            child: SettingsProfile(
                              topBarHeight: topBarHeight,
                            ),
                          ),
                        ),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(right: 22.0),
                      child: Icon(
                        Icons.settings_rounded,
                        //UnitedCustomIcons.person_connected,
                        size: 25,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  // Bounce Bounce
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.2,
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     CustomRoute(
                              //         destination: OwnProfilePreview(
                              //           userId: userProvider.ownId,
                              //         ),
                              //         darken: true));
                            },
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.39,
                                    height: MediaQuery.of(context).size.width *
                                        0.39,
                                    child: FittedBox(
                                        fit: BoxFit.cover,
                                        child: Image.asset(
                                          'assets/icon/ClarifyAI.png',
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        createUserContainer(context, indentation, topBarHeight),
                        const SizedBox(height: 50),
                        Container(
                          height: MediaQuery.of(context).size.width * 0.6,
                          width: MediaQuery.of(context).size.width * 0.75,
                          decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF006D77), // A teal blue color
                                Color(0xFF003C64), // A darker navy blue color
                              ],
                              begin: Alignment(-1.0, -2.0),
                              end: Alignment(1.0, 2.0),
                            ),
                          ),
                          child: const Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 16.0),
                                    child: Text(
                                      'Clarify AI',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 28.0),
                                child: Text(
                                  "Our AI-driven language learning system is designed to provide personalized conversational practice and real-time speaking feedback, filling the gap left by traditional language apps and inconsistent personal tutoring.",
                                  style: TextStyle(
                                    height: 1.5,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              // Container(
                              //   height: MediaQuery.of(context).size.width * 0.1,
                              //   width: MediaQuery.of(context).size.width * 0.4,
                              //   decoration: const BoxDecoration(
                              //     borderRadius:
                              //         BorderRadius.all(Radius.circular(27.0)),
                              //     color: Colors.white,
                              //   ),
                              //   child: const Center(
                              //     child: Text(
                              //       "Activated",
                              //       style: TextStyle(
                              //         fontSize: 14,
                              //         fontWeight: FontWeight.w400,
                              //         color: Color(0xFF707070),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ));
  }

  Widget createUserContainer(
      BuildContext context, double indentation, topBarHeight) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.2,
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                child: Text(
                  "Clarify User",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                child: Text(
                  "Master in Management & Technology",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Icon(
              //   Icons.school_rounded,
              //   size: 17,
              // ),
              // SizedBox(
              //   width: 5.0,
              // ),
              Flexible(
                child: Text(
                  "Technical University of Munich",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.43,
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.of(context)
                          //     .push(CupertinoPageRoute(
                          //       builder: (_) => ScrollConfiguration(
                          //         behavior: MyScrollBehavior(),
                          //         child: EditProfile(
                          //             userProvider: userProvider,
                          //             topBarHeight: topBarHeight,
                          //             profile: userProvider.myUser!,
                          //             imageUrl: userProvider.downloadImage,
                          //             imageUrlSmall:
                          //                 userProvider.downloadImageSmall,
                          //             indentation: indentation),
                          //       ),
                          //     ))
                          //     .then((_) => setState(() {}));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 11.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(27.0)),
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF0077B5).withOpacity(
                                    0.15), // Lighter blue with opacity
                                Color(0xFF005691).withOpacity(
                                    0.15) // Darker blue with opacity
                              ],
                              begin: const Alignment(-1.0, -2.0),
                              end: const Alignment(1.0, 2.0),
                            ),
                          ),
                          child: Center(
                            child: GradientText(
                              "Edit Profile",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              colors: const [
                                Color(0xFF0077B5), // Lighter blue
                                Color(0xFF005691), // Darker blue
                              ],
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
        ],
      ),
    );
  }
}
