import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_example/firebase_options.dart';
import 'package:firebase_example/page/home/home_page.dart';
import 'package:firebase_example/page/sign_in/sign_in_page.dart';
import 'package:firebase_example/page/sign_up/sign_up_page.dart';
import 'package:firebase_example/prefs/prefs.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebaseSetup();
  runApp(const MyApp());
}

Future<void> firebaseSetup() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

///my app
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String?>(
        stream: Prefs.getDataFromLocal(key: 'uid').asStream(),
        builder: (context, snapshot) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            routes: {
              '/login': (context) => const SignInPage(),
              '/sign_up': (context) => const SignUpPage(),
              '/home': (context) => const HomePage()
            },
            home: snapshot.data != null ? const HomePage() : const SignInPage(),
          );
        });
  }
}
