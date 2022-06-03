// @dart=2.9
import 'package:btradeapp/additem.dart';
import 'package:btradeapp/main.dart';
import 'package:btradeapp/mainpage.dart';
import 'package:btradeapp/signup.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:btradeapp/filedata.dart';

class loginpage extends StatefulWidget{

  @override
  _loginpage createState() => _loginpage();
}
class _loginpage extends State<loginpage>{
  String unm="",pwd="";

  @override
  Widget build(BuildContext context) {
      FirebaseFirestore db = FirebaseFirestore.instance;
      double width = MediaQuery.of(context).size.width,height = MediaQuery.of(context).size.height;
      AssetImage img = new AssetImage('assets/sup.png');
      var image = new Image(image: img,width: width/2.5,);
      return Scaffold(
        appBar: AppBar(title: Text("Authentication"),centerTitle: true,),
        body:SingleChildScrollView(
            child :Container(
          margin: EdgeInsets.all(10),
          width: width,
          height: height,
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.all(10),
                child: image,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  onChanged: (uval) {
                    unm = uval;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Name',
                    hintText: 'Enter Your Name',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  onChanged: (pval) {
                    pwd = pval;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter Password',
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(10),
                child: ButtonTheme(
                    minWidth: width,
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Sign In'),
                      onPressed: () {
                        db.collection("btrade_login").doc(unm).get().then((
                            value) {
                          if (value.data() == null) {
                            Fluttertoast.showToast(msg: 'USERNAME NOT FOUND');
                          }
                          else {
                            if (value.data()["unm"] == unm &&
                                value.data()["pwd"] == pwd) {
                              Fluttertoast.showToast(msg: 'LOGIN SUCCESSFUL');
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>mainpage(val:unm,)));
                              FileData ff = FileData();
                              ff.writeCounter(unm);
                            }
                            else {
                              Fluttertoast.showToast(msg: 'WRONG PASSWORD');
                            }
                          }
                        });
                      },
                    )),),
              FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => signup()));
                  },
                  child: Text("New User ? Click here for Sign up")
              )
            ],
          ),
        ),),
      );
  }


}