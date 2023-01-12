import 'package:flutter/material.dart';
import 'package:password_storage/pages/detail.dart';
import 'package:password_storage/pages/form.dart';
import 'package:password_storage/pages/home.dart';


void main() async{

  
  runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => Home(),
    '/form': (context) => FormPass(),
    '/detail': (context) => Detail(),
  },
));
}



