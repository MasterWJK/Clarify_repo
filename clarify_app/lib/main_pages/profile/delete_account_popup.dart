import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class DeleteAccountPopup extends StatefulWidget {
  const DeleteAccountPopup({Key? key}) : super(key: key);

  @override
  DeleteAccountPopupState createState() => DeleteAccountPopupState();
}

class DeleteAccountPopupState extends State<DeleteAccountPopup> {
  TextEditingController textController = TextEditingController();

  bool _makeTextVisible = false;
  @override
  void initState() {
    super.initState();
    textController.addListener(_makeClickableTextController);
  }

  void _makeClickableTextController() {
    if (textController.text == "delete!") {
      setState(() {
        _makeTextVisible = true;
      });
    }
    if (textController.text != "delete!") {
      setState(() {
        _makeTextVisible = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      //alignment: Alignment.centerLeft,
      //Header AlertDialog
      shape: const RoundedRectangleBorder(
        // how round the egdes
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      contentPadding: const EdgeInsets.only(top: 20),
      content: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: RichText(
            text: const TextSpan(children: <TextSpan>[
              TextSpan(
                text: "Delete account? \n",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              TextSpan(
                text: "This action cannot be undone \n",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  height: 1,
                ),
              ),
              TextSpan(
                text: 'Type "delete!" to confirm',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  height: 2.5,
                ),
              ),
            ]),
          )),
      //downpart of the AlerDialog
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 18, 12, 4),
          child: SizedBox(
            height: 20,
            child: TextField(
                controller: textController,
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                )),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                // InWell buttonsize
                padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                child: GradientText(
                  "CANCEL",
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
            _makeTextVisible
                ? InkWell(
                    onTap: () async {
                      // var prefs = await SharedPreferences.getInstance();
                      // String uid = prefs.getString("uid")!;
                      // // delete account permanently with all relevant data
                      // DatabaseService().deleteUser(uid);
                      // // Go back to start page, reset uid
                      // prefs.remove("uid");
                      // Phoenix.rebirth(context);
                    },
                    child: Padding(
                      // InWell buttonsize
                      padding:
                          const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      child: GradientText(
                        "CONFIRM",
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
                  )
                : Padding(
                    // InWell buttonsize
                    padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                    child: GradientText(
                      "CONFIRM",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      colors: [
                        Color(0xFF2196F3)
                            .withOpacity(0.5), // A vibrant light blue.
                        Color(0xFF0D47A1).withOpacity(0.5), // A deep blue.
                      ],
                    ),
                  ),
          ],
        ),
      ],
    );
  }
}
