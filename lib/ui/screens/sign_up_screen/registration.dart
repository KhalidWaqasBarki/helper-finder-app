import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:helper_finder/core/utils/shared_preferences.dart';
import 'package:helper_finder/ui/widgets/text_field_container.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../../../core/firebase/auth.dart';
import '../../../core/utils/constants.dart';
import '../../widgets/already_have_an_account_acheck.dart';
import '../../widgets/or_divider.dart';
import '../../widgets/rounded_button.dart';
import '../../widgets/rounded_input_field.dart';
import '../../widgets/rounded_password_field.dart';
import '../../widgets/social_icon.dart';
import '../main_page/main_page_screen.dart';
import 'sign_up_screen_view_model.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  GlobalKey<FormState> _passKey = GlobalKey<FormState>();
  bool isObscure = true;
  String? _currentAddress;
  Position? _currentPosition;
  bool isLoading = false;

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() => _currentPosition = position);
      await _getAddressFromLatLng(_currentPosition!);
      print(_currentAddress);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
        print('Address : ');
        print(_currentAddress);
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<SignUpProvider>(
      builder: (context, register, child) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Sign Up",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20),
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                controller: register.nameController,
                hintText: "Name",
                onChanged: (value) {},
              ),
              RoundedInputField(
                controller: register.emailController,
                icon: Icons.mail,
                hintText: "Email",
                textInputType: TextInputType.emailAddress,
                onChanged: (value) {},
              ),

              RoundedInputField(
                controller: register.phoneController,
                icon: Icons.phone,
                textInputType: TextInputType.phone,
                hintText: "Phone",
                onChanged: (value) {},
              ),
              Container(
                width: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 350,
                      height: 55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: kPrimaryLightColor),
                      child: Row(children: [
                        Container(
                          width: 30,
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 5),
                          child: Icon(
                            Icons.add_location_alt_outlined,
                            color: kPrimaryColor,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        isLoading
                            ? CircularProgressIndicator()
                            : Container(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    await _getCurrentPosition();
                                    setState(() {
                                      isLoading = false;
                                    });
                                  },
                                  child: Text(
                                    'Get Current Location',
                                  ),
                                ),
                              )
                      ]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'ADDRESS: ${_currentAddress ?? ""}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),

              // RoundedPasswordField(
              //   controller: register.passController,
              //   key: _passkey,
              //   onChanged: (value) {},
              // ),
              Stack(
                children: [
                  TextFieldContainer(
                    child: Form(
                      key: _passKey,
                      child: TextFormField(
                        controller: register.passController,
                        obscureText: isObscure,
                        validator: (value) {
                          if (value!.length < 6) {
                            return 'Password must be longer than 6 characters';
                          }
                        },
                        onChanged: (value) {},
                        cursorColor: kPrimaryColor,
                        decoration: const InputDecoration(
                          hintText: "Password",
                          icon: Icon(
                            Icons.lock,
                            color: kPrimaryColor,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 15,
                    height: 80,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                      child: isObscure
                          ? const Icon(
                              Icons.visibility,
                              color: kPrimaryColor,
                            )
                          : const Icon(
                              Icons.visibility_off,
                              color: kPrimaryColor,
                            ),
                    ),
                  )
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: CheckboxListTile(
                  title: const Text("Remember Me"),
                  value: register.rememberMe,
                  onChanged: (newValue) {
                    register.setRememberMe(newValue!);
                  },
                  controlAffinity:
                      ListTileControlAffinity.leading, //  <-- leading Checkbox
                ),
              ),
              RoundedButton(
                text: "Sign Up",
                press: () {
                  print(_passKey.currentState);
                  if (_passKey.currentState!.validate()) {
                    EasyLoading.show(status: 'loading...');

                    if (emailValidatorRegExp
                        .hasMatch(register.emailController.text)) {
                      Future<void> isLogin = Auth.funcSignUp(
                          register.nameController.text,
                          register.phoneController.text,
                          register.emailController.text,
                          register.passController.text);
                      isLogin.whenComplete(() {
                        String uid = "";
                        try {
                          uid = FirebaseAuth.instance.currentUser!.uid;
                        } on Exception catch (_) {
                          EasyLoading.dismiss();
                          register.setEmailClear();
                        } catch (_) {
                          EasyLoading.dismiss();
                          register.setEmailClear();
                        }

                        if (uid.isEmpty) {
                          EasyLoading.dismiss();
                          register.setEmailClear();
                        } else {
                          Map<String, Object> userMap = {
                            "name": register.nameController.text,
                            "email": register.emailController.text,
                            "phone": register.phoneController.text,
                            "address": _currentAddress!,
                            "wage": register.wageController.text,
                            "note": register.noteController.text,
                            "type": register.type,
                            "availableSunday": true,
                            "showProfile": true,
                            "lat": register.position.latitude.toString(),
                            "long": register.position.longitude.toString(),
                            "skillNo":
                                register.dropDownItemsIds[register.dropDownVal],
                            "skill":
                                register.dropDownItems[register.dropDownVal],
                            "otherSkills": register.otherSkillController.text,
                            "createdAt": DateTime.now().microsecondsSinceEpoch,
                            "uid": uid
                          };

                          FocusManager.instance.primaryFocus?.unfocus();
                          Auth.funcSaveUser(userMap, uid).whenComplete(() {
                            HelperFunction.saveUserTypeSharedPreference(
                                register.type);
                            HelperFunction.saveUserLoggedInSharedPreference(
                                register.rememberMe);
                            HelperFunction.saveUserNameSharedPreference(
                                register.nameController.text);
                            HelperFunction.saveUserEmailSharedPreference(
                                register.emailController.text);
                            EasyLoading.dismiss();

                            register.clearAll(context);
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const MainPage()),
                                (Route<dynamic> route) => false);
                          }).catchError((onError) {
                            EasyLoading.dismiss();
                            register.setEmailClear();
                          }).onError((error, stackTrace) {
                            EasyLoading.dismiss();
                            register.setEmailClear();
                          });
                        }
                      });
                    } else {
                      EasyLoading.dismiss();
                      register.setEmailClear();
                    }
                  }
                },
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  register.clearAll(context);
                },
              ),
              Visibility(visible: true, child: OrDivider()),
              Visibility(
                visible: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SocalIcon(
                      iconSrc: "assets/icons/facebook.svg",
                      press: () {},
                    ),
                    SocalIcon(
                      iconSrc: "assets/icons/twitter.svg",
                      press: () {},
                    ),
                    SocalIcon(
                      iconSrc: "assets/icons/google-plus.svg",
                      press: () {},
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
