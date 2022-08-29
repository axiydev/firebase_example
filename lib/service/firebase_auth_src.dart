import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_example/model/user_model.dart';
import 'package:firebase_example/prefs/prefs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class FirebaseAuthServiceRepository {
  final FirebaseAuth? auth;
  FirebaseAuthServiceRepository(this.auth);

  Future<void> signUpUser(UserModel? user, BuildContext context);
  Future<void> loginUser(UserModel? user, BuildContext context);
  Future<void> deleteUser();
  Future<void> updateUser(String? password);
}

class FireAuthSrc extends FirebaseAuthServiceRepository {
  FireAuthSrc({FirebaseAuth? auth}) : super(auth);
  @override
  Future<void> deleteUser() async {
    await auth!.currentUser!.delete().then((value) {
      if (kDebugMode) {
        print('User successfully deleted');
      }
    });
  }

  @override
  Future<void> loginUser(UserModel? user, BuildContext context) async {
    try {
      final UserCredential? credential = await auth!
          .signInWithEmailAndPassword(
              email: user!.email!, password: user.password!)
          .then((value) {
        if (kDebugMode) {
          print(value);
          print('User succesfully login');
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home', (route) => false);
        }
      }).onError((error, stackTrace) {
        if (kDebugMode) {
          print('you have an error');
        }
      }).whenComplete(() {
        if (kDebugMode) {
          print('done');
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signUpUser(UserModel? user, BuildContext context) async {
    try {
      UserCredential? credential = await auth!
          .createUserWithEmailAndPassword(
              email: user!.email!, password: user.password!)
          .then((value) async {
        if (kDebugMode) {
          print(value);
          print('User succesfully created');
          print(value.user!.uid);
          bool? isSignedIn =
              await Prefs.saveDataToLocal(key: 'uid', token: value.user!.uid);
          if (isSignedIn) {
            // ignore: use_build_context_synchronously
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/home', (route) => false);
          }
        }
      }).onError((error, stackTrace) {
        if (kDebugMode) {
          print('you have an error');
        }
      }).whenComplete(() {
        if (kDebugMode) {
          print('done');
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  @override
  Future<void> updateUser(String? password) async {
    await auth!.currentUser!.updatePassword(password!).then((value) {
      if (kDebugMode) {
        print('password was successfully updated');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error);
        print('you have an error');
      }
    });
  }
}
