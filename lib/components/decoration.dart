import 'package:flutter/material.dart';

InputDecoration getAuthenticationInputDecpration(String labelText){
  return InputDecoration(
    label: Text(labelText),
    fillColor: Colors.white54,
    filled: true,
  );
}