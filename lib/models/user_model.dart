import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? firebaseUser;

  Map<String, dynamic> userData = {};

  bool isLoading = false;

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    _loadCurrentUser();
  }

  void signUp(
      {required Map<String, dynamic> userData,
      required String pass,
      required VoidCallback onSuccess,
      required VoidCallback onFail}) {
    isLoading = true;
    notifyListeners();
    _auth
        .createUserWithEmailAndPassword(
            email: userData['email'], password: pass)
        .then((data) async {
      firebaseUser = data.user;
      await _saveUserDate(userData);
      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((error) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void signIn(
      {required String email,
      required String password,
      required VoidCallback onSuccess,
      required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((credential) async {
      firebaseUser = credential.user;
      await _loadCurrentUser();
      onSuccess();
    }).catchError((onError) {
      onFail();
    });

    isLoading = false;
    notifyListeners();
  }

  Future<void> _loadCurrentUser() async {
    firebaseUser = _auth.currentUser;
    FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser!.uid)
        .get()
        .then((value) {
      userData = value.data()!;
      notifyListeners();
    });
  }

  void recoverPass() {}
  bool isLoggedIn() {
    return firebaseUser != null;
  }

  void signOut() async {
    await _auth.signOut();
    userData = {};
    firebaseUser = null;
    notifyListeners();
  }

  Future<void> _saveUserDate(Map<String, dynamic> data) async {
    userData = data;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser!.uid)
        .set(data);
  }
}
