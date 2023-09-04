import 'package:flutter/material.dart';
import 'package:helper_finder/core/utils/constants.dart';
import 'package:helper_finder/ui/screens/authentication/authenticate.dart';
import 'package:helper_finder/ui/widgets/rounded_button.dart';
import 'package:provider/provider.dart';

import 'agreement_view_model.dart';

class AgreementScreen extends StatelessWidget {
  const AgreementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
        create: (context) => AgreementProvider(),
        child: Consumer<AgreementProvider>(
          builder: (context, register, child) {
            return Scaffold(
              body: SizedBox(
                height: size.height,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Image.asset(
                        "assets/images/main_top.png",
                        width: size.width * 0.3,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Image.asset(
                        "assets/images/main_bottom.png",
                        width: size.width * 0.2,
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: size.height / 5,
                            child: Center(
                              child: Image.asset(
                                "assets/images/worker.png",
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          RoundedButton(
                              text: "Register/Login",
                              press: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Authenticate()));
                              }),
                          const SizedBox(height: 30),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              "Back",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: kPrimaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: const [
                                    Text(
                                      "Privacy Policy:",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  "We and selected third parties use cookies or similar technologies for technical purposes and, with your consent, for other purposes as specified in the cookie policy. You can consent to the use of such technologies by using the “Accept” button. By closing this notice, you continue without accepting.",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: const [
                                    Text(
                                      "Availability::",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  "We and selected third parties use cookies or similar technologies for technical purposes and, with your consent, for other purposes as specified in the cookie policy. You can consent to the use of such technologies by using the “Accept” button. By closing this notice, you continue without accepting.",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Center(
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Switch(
                                          value: true,
                                          onChanged: (val) {},
                                        ))),
                                const Expanded(
                                  flex: 1,
                                  child: Text(
                                    "I Agree",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
