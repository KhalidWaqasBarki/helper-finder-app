import 'dart:async';

import 'package:animations/animations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helper_finder/ui/screens/authentication/authenticate_view_model.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/shared_preferences.dart';
import '../../widgets/background_painter.dart';
import '../main_page/main_page_screen.dart';
import '../sign_in_screen/sign_in_screen.dart';
import '../sign_up_screen/sign_up_screen.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> with SingleTickerProviderStateMixin {


  late AnimationController c;


@override
  initState(){
  super.initState();
  c= AnimationController(vsync: this, duration: const Duration(seconds: 2));
  final auth = Provider.of<AuthProvider>(context, listen: false);
  auth.setController(c);

  Timer(
      const Duration(seconds: 3),
          () {
             isLogin();

          }
  );

}

Future<void> isLogin() async {
           await HelperFunction.getUserLoggedInSharedPreference().then((value) {
    if (value != null) {
      if (value) {
        String  uid=FirebaseAuth.instance.currentUser!.uid;
        if (uid!=null && uid!=""){
          FocusManager.instance.primaryFocus?.unfocus();
          Navigator.of(context!).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const MainPage()),
                  (Route<dynamic> route) => false);
        }
      }
    }
  });
}
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
        builder: (context, auth, child) {

          return Stack(
            children: [
              SizedBox.expand(
                child: CustomPaint(
                  painter: BackgroundPainter(
                    animation: auth.controller,
                  ),
                ),
              ),
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: ValueListenableBuilder<bool>(
                    valueListenable: auth.showSignInPage,
                    builder: (context, value, child) {
                      return SizedBox.expand(
                        child: PageTransitionSwitcher(
                          reverse: !value,
                          duration: const Duration(milliseconds: 800),
                          transitionBuilder:
                              (child, animation, secondaryAnimation) {
                            return SharedAxisTransition(
                              animation: animation,
                              secondaryAnimation: secondaryAnimation,
                              transitionType: SharedAxisTransitionType.vertical,
                              fillColor: Colors.transparent,
                              child: child,
                            );
                          },
                          child: auth.showSignIn
                              ?  SignInScreen(
                            key:  auth.key,

                          )
                              : SignUpScreen(
                            key:  auth.key,

                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          );
          // return auth.showSignIn ? const SignInScreen() : const SignUpScreen();
        },
      )
    ;
  }
}
