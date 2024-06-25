import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String? message;
  String? token;

  final firebaseAuth = FirebaseAuth.instance;


  Future<bool> signUp(String email, String password) async {
    try{
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email, password: password
    );
    token = userCredential.credential?.token.toString();
    message = "Usuário cadastrado com sucesso!";
    return true;
    } on FirebaseAuthException catch (e) {
      message = "Erro ao cadastrar Usuário!";
      print(e.code);
      print(e.message);
      return false;
    }
  }

  Future<bool> signIn(String email, String password) async {
    try { 
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(
      email: email, password: password);
      token = userCredential.credential?.token.toString();
      return true;
    } on FirebaseAuthException catch (e) {
      message = "Erro ao autenticar Usuário!";
      print(e.code);
      print(e.message);
      return false;
    }
  }
}