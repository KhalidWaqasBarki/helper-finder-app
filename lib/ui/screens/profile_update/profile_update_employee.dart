import 'package:animations/animations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:helper_finder/core/utils/constants.dart';
import 'package:helper_finder/ui/widgets/rounded_button.dart';
import 'package:provider/provider.dart';

import '../../../core/firebase/auth.dart';
import '../../widgets/background_painter.dart';
import '../../widgets/dropDownListProfile.dart';
import '../../widgets/rounded_input_field.dart';
import '../authentication/authenticate_view_model.dart';
import '../main_page/main_page_screen.dart';
import '../profile_page/profile_page_view_model.dart';
import 'profile_update_view_model.dart';

class ProfileUpdateEmployee extends StatefulWidget {
  const ProfileUpdateEmployee({Key? key}) : super(key: key);

  @override
  State<ProfileUpdateEmployee> createState() => _ProfileUpdateEmployeeState();
}

class _ProfileUpdateEmployeeState extends State<ProfileUpdateEmployee> with SingleTickerProviderStateMixin {


  late AnimationController c;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    c= AnimationController(vsync: this, duration: const Duration(seconds: 2));
    final auth = Provider.of<AuthProvider>(context, listen: false);
    auth.setController(c);
    final profile = Provider.of<ProfileProvider>(context, listen: false);
    profile.getUser();

  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(create: (context)=>ProfileUpdateProvider(),child:
    Consumer<ProfileUpdateProvider>(
      builder: (context, profileUpdate, child) {


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
                            child:
                            profileUpdate.isUser? SizedBox(
                              width: double.infinity,
                              height: size.height,
                              child: SafeArea(
                                child: Stack(

                                  alignment: Alignment.center,
                                  children: [

                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(height: size.height * 0.03),

                                        SizedBox(height: size.height * 0.03),
                                        RoundedInputField(
                                          controller: profileUpdate.nameController,
                                          hintText: "Name",
                                          onChanged: (value) {},
                                        ),
                                        RoundedInputField(
                                          controller: profileUpdate.emailController,
                                          icon: Icons.mail,
                                          hintText: "Email",
                                          textInputType: TextInputType.emailAddress,
                                          onChanged: (value) {},
                                        ),
                                        RoundedInputField(
                                          controller: profileUpdate.phoneController,
                                          icon: Icons.phone,
                                          textInputType: TextInputType.phone,
                                          hintText: "Phone",
                                          onChanged: (value) {},
                                        ),
                                        RoundedInputField(
                                          controller: profileUpdate.addressController,
                                          hintText: "Address",
                                          icon: Icons.add_location_alt_sharp,
                                          textInputType: TextInputType.streetAddress,
                                          onChanged: (value) {},
                                        ),

                                      ],
                                    )
                                    ,
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: RoundedButton(
                                          text: profileUpdate.isFirstPage?"Next":"Update Profile",
                                          color: kPrimaryColor,
                                          press: () {
                                            if(profileUpdate.isFirstPage){
                                              profileUpdate.setIsFirstPage(false);
                                            }else{
                                              EasyLoading.show(status: 'loading...');
                                              String uid = FirebaseAuth.instance.currentUser!.uid;

                                              Map<String, Object> userMap = {
                                                "name": profileUpdate.nameController.text,
                                                "email": profileUpdate.emailController.text,
                                                "phone": profileUpdate.phoneController.text,
                                                "address": profileUpdate.addressController.text,
                                                "wage": profileUpdate.wageController.text,
                                                "note": profileUpdate.noteController.text,
                                                "type": profileUpdate.user!.type,
                                                "availableSunday": profileUpdate.availableSunday,
                                                "showProfile": profileUpdate.showProfile,
                                                "lat": profileUpdate.user!.lat.toString(),
                                                "long": profileUpdate.user!.long.toString(),
                                                "skillNo":
                                                profileUpdate.dropDownItemsIds[profileUpdate.dropDownVal],
                                                "skill": profileUpdate.dropDownItems[profileUpdate.dropDownVal],
                                                "otherSkills": profileUpdate.otherSkillController.text,
                                                "createdAt": profileUpdate.user!.createdAt,
                                                "uid": uid
                                              };


                                              FocusManager.instance.primaryFocus?.unfocus();
                                              Auth.funcSaveUser(userMap, uid).whenComplete(() {

                                                final prof = Provider.of<ProfileProvider>(context, listen: false);
                                                prof.getUser();

                                                EasyLoading.dismiss();
                                                Navigator.of(context).pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (context) => const MainPage()),
                                                        (Route<dynamic> route) => false);
                                              }).catchError((onError) {
                                                EasyLoading.dismiss();
                                                profileUpdate.setEmailClear();
                                              }).onError((error, stackTrace) {
                                                EasyLoading.dismiss();
                                                profileUpdate.setEmailClear();
                                              });
                                            }
                                          },
                                          cir: 10),
                                    ),
                                  ],
                                ),
                              ),
                            ):
                            const Center(child: CircularProgressIndicator()),

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
    ),);
  }
}
