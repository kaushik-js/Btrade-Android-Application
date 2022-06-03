// @dart=2.9
import 'package:btradeapp/filedata.dart';
import 'package:btradeapp/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:btradeapp/loginpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
String uid;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FileData().readCounter().then((String value){
    uid=value;
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    if(uid.length>1)
      return MaterialApp(home: mainpage(val:uid),);
    else
      return MaterialApp(home: loginpage(),);
  }
}
