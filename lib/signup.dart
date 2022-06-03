// @dart=2.9
import 'package:btradeapp/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class signup extends StatelessWidget {
  String fnm = "",
      phn = "",
      add = "",
      dist = "",
      state = "",
      pwd = "",
      apwd = "";
  FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    AssetImage img = new AssetImage('assets/signup.png');
    var image = new Image(
      image: img,
      width: width / 3,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("SIGN UP PAGE"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: width,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: Column(
            children: <Widget>[
              image,
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'NAME',
                    hintText: 'Enter Full Name',
                  ),
                  onChanged: (fnmval) {
                    fnm = fnmval;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'PHONE NUMBER',
                    hintText: 'Enter phone number',
                  ),
                  onChanged: (phnval) {
                    phn = phnval;
                  },
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'ADDRESS',
                      hintText: 'Enter your address',
                    ),
                    onChanged: (addval) {
                      add = addval;
                    },
                  )),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'DISTRICT',
                      hintText: 'Enter your district',
                    ),
                    onChanged: (ctval) {
                      dist = ctval;
                    },
                  )),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'STATE',
                      hintText: 'Enter your state',
                    ),
                    onChanged: (stval) {
                      state = stval;
                    },
                  )),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'PASSWORD',
                      hintText: 'Enter new password',
                    ),
                    onChanged: (pwdval) {
                      pwd = pwdval;
                    },
                  )),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'PASSWORD AGAIN',
                      hintText: 'Enter password again',
                    ),
                    onChanged: (apval) {
                      apwd = apval;
                    },
                  )),
              Padding(
                padding: EdgeInsets.all(10),
                child: ButtonTheme(
                    minWidth: width,
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: () {
                        putdata(context);
                      },
                      child: Text("SIGN UP"),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void putdata(context) {
    if (pwd == apwd) {
      if (pwd.length > 7) {
        db.collection("btrade_userinfo").doc(phn).set({
          'fnm': fnm,
          'phn': phn,
          'add': add,
          'dist': dist,
          'state': state,
        });
        db.collection("btrade_login").doc(phn).set({
          'unm': phn,
          'fnm': fnm,
          'pwd': pwd,
        }).whenComplete(() {
          Fluttertoast.showToast(msg: "Details Saved please login again");
          Navigator.pop(context);
        });
      } else {
        Fluttertoast.showToast(msg: "Password length must be 8 or more");
      }
    } else {
      Fluttertoast.showToast(msg: "Password Doesn't match please check");
      return;
    }
  }
}
