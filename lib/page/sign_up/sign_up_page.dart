import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_example/model/user_model.dart';
import 'package:firebase_example/service/firebase_auth_src.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _authService = FireAuthSrc(auth: FirebaseAuth.instance);
  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  TextEditingController? confirmController = TextEditingController();
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
              TextField(
                controller: confirmController,
                obscureText: true,
                decoration: const InputDecoration(hintText: 'confirm password'),
              ),
              const SizedBox(
                height: 20,
              ),
              CupertinoButton.filled(
                  onPressed: () async {
                    if (emailController!.text.isEmpty) return;
                    if (passwordController!.text.isEmpty) return;
                    if (confirmController!.text.isEmpty ||
                        confirmController!.text != passwordController!.text) {
                      return;
                    }
                    UserModel user = UserModel(
                        email: emailController!.text,
                        password: passwordController!.text,
                        uuid: '45');
                    emailController!.clear();
                    passwordController!.clear();
                    confirmController!.clear();
                    await _authService.signUpUser(user, context);
                  },
                  child: const Text('sign up ')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/login');
                  },
                  child: const Text('sign in page')),
            ],
          ),
        ),
      ),
    );
  }
}
