import 'package:flutter/material.dart';
import 'package:helper_finder/ui/screens/hire_page/hire_page.dart';
import 'package:helper_finder/ui/screens/main_page/main_page_screen_view_model.dart';
import 'package:provider/provider.dart';
import '../../../core/firebase/auth.dart';
import '../../../core/utils/constants.dart';
import '../../widgets/drawer.dart';
import '../../widgets/searchWorkerDialog.dart';
import '../map_page/google_map_page.dart';
import '../profile_page/profile_page_employee.dart';
import '../profile_page/profile_page_view_model.dart';
import '../profile_page/profile_page_worker.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MainProvider(context),
        child: Consumer<MainProvider>(
          builder: (context, main, child) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                centerTitle: false,
                iconTheme: const IconThemeData(
                  color: Colors.white, //change your color here
                ),
                backgroundColor: kPrimaryColor,
                title: const Text(
                  "Helper Finder",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: main.userType == "client"
                    ? GestureDetector(
                        onTap: () {
                          final profile = Provider.of<ProfileProvider>(context,
                              listen: false);
                          profile.getUser();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const ProfilePage();
                              },
                            ),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.account_circle,
                            color: Colors.white,
                          ),
                        ))
                    : Container(),
                actions: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const GoogleMapPage();
                            },
                          ),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.map_outlined,
                          color: Colors.white,
                        ),
                      )),
                  main.userType == "client"
                      ? GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) => ShowWorkerDialog(
                                  press: () {
                                    Navigator.of(context).pop();
                                  },
                                  type: main.userType),
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.person_search,
                              color: Colors.white,
                            ),
                          ))
                      : Container(),
                  GestureDetector(
                      onTap: () {
                        Auth.funcLogout(context!);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                      )),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const MyDrawer();
                            },
                          ),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.menu_outlined,
                          color: Colors.white,
                        ),
                      )),
                ],
              ),

              body: Scaffold(
                key: main.scaffoldKey,
                body: main.userType == "client"
                    ? const HirePage()
                    : const ProfilePageWorker(),
              ),
              //
            );
          },
        ));
  }
}
