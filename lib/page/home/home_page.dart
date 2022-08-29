import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_example/service/firebase_auth_src.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _authService = FireAuthSrc(auth: FirebaseAuth.instance);
  TextEditingController? passController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
              onPressed: () async {
                setState(() {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/login', (route) => false);
                });
              },
              icon: const Icon(Icons.logout)),
          IconButton(
              onPressed: () async {
                await _authService.deleteUser();
                setState(() {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/login', (route) => false);
                });
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: passController!,
                decoration: const InputDecoration(hintText: 'password'),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(hintText: 'new password'),
              ),
              const SizedBox(
                height: 20,
              ),
              CupertinoButton.filled(
                  onPressed: () async {
                    if (passController!.text.isEmpty) return;
                    if (passwordController!.text.isEmpty) return;

                    await _authService.updateUser(passwordController!.text);
                    passController!.clear();
                    passwordController!.clear();
                  },
                  child: const Text('update')),
            ],
          ),
        ),
      ),
    );
  }
}
