import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_example/model/user_model.dart';
import 'package:firebase_example/prefs/prefs.dart';
import 'package:firebase_example/service/firebase_auth_src.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _authService = FireAuthSrc(auth: FirebaseAuth.instance);
  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  @override
  void didChangeDependencies() {
    show();
    super.didChangeDependencies();
  }

  void show() async {
    if (kDebugMode) {
      print(await Prefs.getDataFromLocal(key: 'uid'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailController!,
                decoration: const InputDecoration(hintText: 'email'),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(hintText: 'password'),
              ),
              const SizedBox(
                height: 20,
              ),
              CupertinoButton.filled(
                  onPressed: () async {
                    if (emailController!.text.isEmpty) return;
                    if (passwordController!.text.isEmpty) return;

                    UserModel user = UserModel(
                        email: emailController!.text,
                        password: passwordController!.text,
                        uuid: '45');
                    emailController!.clear();
                    passwordController!.clear();
                    await _authService.loginUser(user, context);
                  },
                  child: const Text('sign in')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/sign_up');
                  },
                  child: const Text('sign up page')),
            ],
          ),
        ),
      ),
    );
  }
}
