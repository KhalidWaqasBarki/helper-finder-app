import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:helper_finder/core/firebase/auth.dart';
import 'package:helper_finder/ui/screens/main_page/main_page_screen.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/constants.dart';
import '../../../core/utils/shared_preferences.dart';
import '../../widgets/already_have_an_account_acheck.dart';
import '../../widgets/background_painter.dart';
import '../../widgets/rounded_button.dart';
import '../../widgets/rounded_input_field.dart';
import '../../widgets/rounded_password_field.dart';
import '../authentication/authenticate_view_model.dart';
import '../sign_up_screen/sign_up_screen.dart';
import 'sign_in_screen_view_model.dart';
class SignInScreen extends StatelessWidget  {

  const SignInScreen({  Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(create: (context)=>SignInProvider(),
        child: Consumer<SignInProvider>(
          builder: (context,login,child){


            return
               SizedBox(
                width: double.infinity,
                height: size.height,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[

                    SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>  [
                          const Text(
                            "LOGIN",
                            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),
                          ),
                          SizedBox(height: size.height * 0.03),
                          const Center(child: Text("Welcome back! Login with your Credentials",style: TextStyle(color: Colors.white),)),
                          SizedBox(height: size.height * 0.03),
                          RoundedInputField(
                            textInputType: TextInputType.emailAddress,
                            controller: login.emailController,
                            icon: Icons.mail,
                            hintText: "Email",
                            onChanged: (value) {},
                          ),
                          RoundedPasswordField(
                            controller: login.passController,
                            onChanged: (value) {},
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: CheckboxListTile(
                              title:const Text("Remember Me"),
                              value: login.rememberMe,
                              onChanged: (newValue) {

                                login.setRememberMe(newValue!)  ;

                              },
                              controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                            ),
                          ),
                          RoundedButton(
                            text: "Login",
                            press: () {

                              EasyLoading.show(status: 'loading...');
                              if (emailValidatorRegExp.hasMatch(login.emailController.text)) {
                                Future<void> isLogin=  Auth.funcLogin(login.emailController.text, login.passController.text);
                                isLogin.whenComplete(()  {
                                   Auth.funcGetUser(FirebaseAuth.instance.currentUser!.uid).then((value) {


                                    HelperFunction.saveUserTypeSharedPreference(value.get("type"));
                                    HelperFunction.saveUserLoggedInSharedPreference(login.rememberMe);
                                    HelperFunction.saveUserNameSharedPreference(value.get("name"));
                                    HelperFunction.saveUserEmailSharedPreference(value.get("email"));
                                  }).whenComplete(() {

                                     FocusManager.instance.primaryFocus?.unfocus();

                                     EasyLoading.dismiss();
                                     Navigator.of(context).pushAndRemoveUntil(
                                         MaterialPageRoute(builder: (context) => const MainPage()),
                                             (Route<dynamic> route) => false);
                                   });



                                }).onError((error, stackTrace) {

                                  EasyLoading.showError("User not found");

                                  EasyLoading.dismiss();
                                  login.setEmailClear();
                                  login.setPassClear();
                                });
                              } else {

                                EasyLoading.dismiss();
                                login.setEmailClear();

                              }
                            },
                          ),
                          SizedBox(height: size.height * 0.03),
                          AlreadyHaveAnAccountCheck(
                            press: () {
                              final auth = Provider.of<AuthProvider>(context, listen: false);
                              auth.toggleView();
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) {
                              //       return const SignUpScreen();
                              //     },
                              //   ),
                              // );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
          },
        )

    );

  }
}
