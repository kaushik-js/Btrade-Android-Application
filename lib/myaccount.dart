import 'package:btradeapp/mainpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class myaccount extends StatefulWidget {
  final Map<String, dynamic> val;
  myaccount({required this.val}) : super();
  _myaccount createState() => _myaccount();
}

List<Widget> pl = [];
FirebaseFirestore db = FirebaseFirestore.instance;
double width = 0.0, height = 0.0;

class _myaccount extends State<myaccount> {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    getDt();
    return Scaffold(
      appBar: AppBar(
        title: Text("MY ACCOUNT DETAILS"),
      ),
      body: WillPopScope(
          onWillPop: () async {
            pl = [];
            Navigator.pop(context);
            return true;
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(
                    5.0,
                    5.0,
                  ),
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                ), //BoxShadow
                BoxShadow(
                  color: Colors.white,
                  offset: const Offset(0.0, 0.0),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ), //BoxShadow
              ],
            ),
            margin: EdgeInsets.all(10),
            width: width,
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: pl,
              ),
            ),
          )),
    );
  }

  getDt() {
    if (pl.length < 1) {
      var ele = widget.val;
      TextEditingController fnm = TextEditingController(text: ele['fnm']),
          phn = TextEditingController(text: ele['phn']),
          add = TextEditingController(text: ele['add']),
          dist = TextEditingController(text: ele['dist']),
          state = TextEditingController(text: ele['state']);
      pl.add(Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: fnm,
                decoration: InputDecoration(
                    labelText: "Full Name", border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: phn,
                decoration: InputDecoration(
                    labelText: "Phone Number", border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: add,
                decoration: InputDecoration(
                    labelText: "Address", border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: dist,
                decoration: InputDecoration(
                    labelText: "District", border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: state,
                decoration: InputDecoration(
                    labelText: "State", border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: ButtonTheme(
                minWidth: width,
                child: RaisedButton(
                  onPressed: () {
                    db.collection("btrade_userinfo").doc(ele['phn']).update({
                      'fnm': fnm.text,
                      'phn': phn.text,
                      'add': add.text,
                      'dist': dist.text,
                      'state': state.text,
                    });
                    Fluttertoast.showToast(msg: "Details Updated...");
                  },
                  child: Text("UPDATE"),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: ButtonTheme(
                minWidth: width,
                child: RaisedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('CONFIRM DELETION....'),
                            content: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                      'Would you like to Delete your Account :('),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text('Confirm'),
                                onPressed: () {
                                  db
                                      .collection("btrade_userinfo")
                                      .doc(ele['phn'])
                                      .delete();
                                  db
                                      .collection("btrade_login")
                                      .doc(ele['phn'])
                                      .delete();
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                  },
                  child: Text("DELETE MY ACCOUNT"),
                ),
              ),
            ),
          ],
        ),
      ));
    }
  }
}
