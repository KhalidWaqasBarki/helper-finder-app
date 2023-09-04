import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:helper_finder/ui/screens/authentication/authenticate.dart';
import 'package:helper_finder/ui/screens/authentication/authenticate_view_model.dart';
import 'package:helper_finder/ui/screens/hire_page/hire_page_view_model.dart';
import 'package:helper_finder/ui/screens/profile_page/profile_page_view_model.dart';
import 'package:helper_finder/ui/screens/profile_update/profile_update_view_model.dart';
import 'package:helper_finder/ui/screens/sign_up_screen/sign_up_screen_view_model.dart';
import 'package:helper_finder/ui/screens/splash_screen/splash_screen.dart';
import 'package:helper_finder/ui/screens/splash_screen/splash_view_model.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SplashProvider()),
        ChangeNotifierProvider(
            create: (context) => AuthProvider(context: context)),
        ChangeNotifierProvider(create: (context) => SignUpProvider()),
        ChangeNotifierProvider(create: (context) => HireProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
      ],
      child: MaterialApp(
          builder: EasyLoading.init(),
          debugShowCheckedModeBanner: false,
          title: 'Helper Finder',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const SplashScreen()),
    );
  }
}
