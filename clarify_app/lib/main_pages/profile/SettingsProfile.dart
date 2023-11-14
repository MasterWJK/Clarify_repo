import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:clarify_app/components/layout_provider.dart';
import 'package:clarify_app/main_pages/profile/delete_account_popup.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class SettingsProfile extends StatefulWidget {
  final double topBarHeight;

  const SettingsProfile({Key? key, required this.topBarHeight})
      : super(key: key);

  @override
  SettingsProfileState createState() => SettingsProfileState();
}

class SettingsProfileState extends State<SettingsProfile> {
  double betweenHeaderBox = 12.0;

  @override
  Widget build(BuildContext context) {
    var indentation = LayoutProvider(context).indentation;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 6, // top:10
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.keyboard_arrow_left_rounded,
                      size: 35,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: const Text(
                    "Settings",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              // Bounce Bounce
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              child: Container(
                height: MediaQuery.of(context).size.height / 1.2,
                padding: EdgeInsets.symmetric(horizontal: indentation),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    const Text(
                      "My account",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: betweenHeaderBox,
                    ),
                    InkWell(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 15, 0, 15),
                            child: GradientText(
                              "Change password",
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              colors: const [
                                Color(0xFF2196F3), // A vibrant light blue.
                                Color(0xFF0D47A1), // A deep blue.
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   PageRouteBuilder(
                          //     pageBuilder: (BuildContext context,
                          //         Animation<double> animation,
                          //         Animation<double> secAnimation) {
                          //       return ResetPassword();
                          //     },
                          //   ),
                          // );
                        }),
                    const Divider(
                      color: Color(0xFFDADADA),
                      thickness: 1,
                      height: 1.5,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Help",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: betweenHeaderBox,
                    ),
                    InkWell(
                      onTap: () {
                        launchUrl(Uri.parse(
                            'https://walnut-cow-d31.notion.site/FAQ-page-App-8edaf756459a497380c0e108d5be2f20'));
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 15, 0, 15),
                          child: GradientText(
                            "FAQ",
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            colors: const [
                              Color(0xFF2196F3), // A vibrant light blue.
                              Color(0xFF0D47A1), // A deep blue.
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      color: Color(0xFFDADADA),
                      thickness: 1,
                      height: 1.5,
                    ),
                    InkWell(
                      onTap: () async {
                        final Uri params = Uri(
                          scheme: 'mailto',
                          path: 'clarify.aied@gmail.com',
                          query:
                              'subject=Support&body=Dear support team Clarify,\n\n',
                        );
                        var url = params;
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 15, 0, 15),
                          child: GradientText(
                            "Support",
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            colors: const [
                              Color(0xFF2196F3), // A vibrant light blue.
                              Color(0xFF0D47A1), // A deep blue.
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      color: Color(0xFFDADADA),
                      thickness: 1,
                      height: 1.5,
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "Guidelines",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: betweenHeaderBox,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (_) => ScrollConfiguration(
                              behavior: const ScrollBehavior(),
                              child: // long example licence text
                                  const LicensePage(
                                applicationName: "R3cylce",
                                applicationVersion: "1.0.0",
                                applicationIcon: SizedBox(
                                  height: 100,
                                  width: 100,
                                  // child: SvgPicture.asset(
                                  //   "assets/images/logo.svg",
                                  //   color: Color(0xFF054F46),
                                  // ),
                                ),
                                applicationLegalese: "© 2023 R3",
                              ),
                            ),
                          ),
                        );
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 15, 0, 15),
                          child: GradientText(
                            "Licenses",
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            colors: const [
                              Color(0xFF2196F3), // A vibrant light blue.
                              Color(0xFF0D47A1), // A deep blue.
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      color: Color(0xFFDADADA),
                      thickness: 1,
                      height: 1.5,
                    ),
                    InkWell(
                      onTap: () {
                        //without encodeFull doesnt work!
                        launchUrl(Uri.parse(
                            'https://yuni-app.com/mobile-privacy-policy'));
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 15, 0, 15),
                          child: GradientText(
                            "Privacy Policy",
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            colors: const [
                              Color(0xFF2196F3), // A vibrant light blue.
                              Color(0xFF0D47A1), // A deep blue.
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      color: Color(0xFFDADADA),
                      thickness: 1,
                      height: 1.5,
                    ),
                    const SizedBox(height: 80),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              _logOutPopupDialog(context),
                        );
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.13,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(27.0)),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF2196F3), // A vibrant light blue.
                              Color(0xFF0D47A1), // A deep blue.
                            ],
                            begin: Alignment(-1.0, -2.0),
                            end: Alignment(1.0, 2.0),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Log out',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => const Stack(
                            children: [DeleteAccountPopup()],
                          ),
                        );
                      },
                      child: Center(
                        child: GradientText(
                          "I want to delete my account",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          colors: const [
                            Color(0xFF2196F3), // A vibrant light blue.
                            Color(0xFF0D47A1), // A deep blue.
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Center(
                        child: Text(
                      "App version 1.0.0",
                      style: TextStyle(
                        color: Color(0xFF939DA8),
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _logOutPopupDialog(BuildContext context) {
    return AlertDialog(
      //Header AlertDialog
      shape: const RoundedRectangleBorder(
        // how round the egdes
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 20),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6.0),
            child: Text("Do you really want to log out?"),
          ),
        ],
      ),
      //downpart of the AlerDialog
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Padding(
                // InWell buttonsize
                padding: EdgeInsets.fromLTRB(42.0, 12.0, 42.0, 12.0),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Color(0XFFBFBFBF),
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                // var prefs = await SharedPreferences.getInstance();
                // prefs.remove("uid");
                // Phoenix.rebirth(context);
              },
              child: Padding(
                // InWell buttonsize
                padding: const EdgeInsets.fromLTRB(42.0, 12.0, 42.0, 12.0),
                child: GradientText(
                  "Log out",
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  colors: const [
                    Color(0xFF054F46),
                    Color(0xFF054F46),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
