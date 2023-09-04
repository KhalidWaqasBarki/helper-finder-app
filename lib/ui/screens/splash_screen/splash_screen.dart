import 'dart:async';

import 'package:animations/animations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helper_finder/ui/screens/authentication/authenticate.dart';
import 'package:helper_finder/ui/screens/authentication/authenticate_view_model.dart';
import 'package:helper_finder/ui/screens/splash_screen/splash_view_model.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/shared_preferences.dart';
import '../../widgets/background_painter.dart';
import '../main_page/main_page_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>  with SingleTickerProviderStateMixin {


  late AnimationController c;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    c= AnimationController(vsync: this, duration:  Duration(seconds: 1));
    final auth = Provider.of<AuthProvider>(context, listen: false);
    auth.setController(c);

    Timer(
        const Duration(seconds: 1),
            () => getLogin());
  }

  Future<void> getLogin() async {
    await HelperFunction.getUserLoggedInSharedPreference().then((value) {
      if (value != null) {
        if (value) {
          String uid = FirebaseAuth.instance.currentUser!.uid;
          if (uid != null && uid != "") {
            FocusManager.instance.primaryFocus?.unfocus();
            Navigator.of(context!).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const MainPage()),
                    (Route<dynamic> route) => false);
          }else{
            goAuth();
          }
        }else{
          goAuth();
        }
      }else{
        goAuth();
      }
    });
  }

  void goAuth() {
       Navigator.of(context!).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const Authenticate()),
            (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return  Consumer<SplashProvider>(
          builder: (context, splash, child) {
            final auth = Provider.of<AuthProvider>(context, listen: false);

            return Scaffold(
                  body: SizedBox(
                    height: size.height,
                    width: double.infinity,
                    child: Stack(
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
                                        transitionType: SharedAxisTransitionType
                                            .vertical,
                                        fillColor: Colors.transparent,
                                        child: child,
                                      );
                                    },
                                    child: SizedBox(
                                      height: size.height / 3,
                                      child: Center(
                                        child: Image.asset(
                                          "assets/images/worker.png",
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );

          },
        );
  }
}
