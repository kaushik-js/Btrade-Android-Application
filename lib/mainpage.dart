import 'dart:io';
import 'package:btradeapp/additem.dart';
import 'package:btradeapp/filedata.dart';
import 'package:btradeapp/loginpage.dart';
import 'package:btradeapp/main.dart';
import 'package:btradeapp/myaccount.dart';
import 'package:btradeapp/productdt.dart';
import 'package:btradeapp/tradehistory.dart';
import 'package:btradeapp/traderequest.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';

String cid = " ", cnm = " ", ini = " ";
FirebaseFirestore db = FirebaseFirestore.instance;
double width = 0.0, height = 0.0;
String uvv = "";

class mainpage extends StatefulWidget {
  final String val;
  mainpage({required this.val}) : super();
  @override
  State createState() => _mainpage();
}

class _mainpage extends State<mainpage> {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    cid = widget.val;
    Map<String, dynamic> udt = {};
    return Scaffold(
        appBar: AppBar(
          title: Text("WELCOME TO BTRADE"),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("btrade_itemdt")
                .where('userid', isNotEqualTo: cid)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return Text("Loading Data..Please wait..");
              int i = snapshot.data!.size;
              snapshot.data!.docs.forEach((ele) {
                if (pl.length < i) {
                  pl.add(
                    Container(
                        margin: EdgeInsets.all(10),
                        width: width,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
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
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Item",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: height / 45,
                                          ),
                                        ),
                                        Text(" ",
                                            style: TextStyle(
                                                fontSize: height / 45)),
                                        Text("Name : " + ele['pnm'],
                                            style: TextStyle(
                                                fontSize: height / 45)),
                                        Text("Qty : " + ele['pqty'],
                                            style: TextStyle(
                                                fontSize: height / 45)),
                                        Text(ele['pdes'],
                                            style: TextStyle(
                                                fontSize: height / 45)),
                                        Text(" ")
                                      ],
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Item Expected",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: height / 45),
                                      ),
                                      Text(" "),
                                      Text(ele['penm'],
                                          style:
                                              TextStyle(fontSize: height / 45)),
                                      Text(ele['peqty'],
                                          style:
                                              TextStyle(fontSize: height / 45)),
                                      Text(ele['pedes'],
                                          style:
                                              TextStyle(fontSize: height / 45)),
                                      Text(" ")
                                    ],
                                  ),
                                )),
                              ],
                            ),
                            ButtonTheme(
                              minWidth: width,
                              child: RaisedButton(
                                  child: Text("ADD FOR TRADING"),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => productdt(
                                                  ele: ele,
                                                  myid: widget.val,
                                                )));
                                  }),
                            ),
                          ],
                        )),
                  );
                }
              });
              return SingleChildScrollView(
                  child: Container(
                      width: width,
                      height: height,
                      //color: Colors.blue[300],
                      child: Column(children: [
                        Text(" "),
                        Text("ITEMS AVAILABLE FOR TRADING",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: height / 45)),
                        Text(" "),
                        Column(
                          children: pl,
                        ),
                        Text(" "),
                        Text("END OF LIST",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: height / 45))
                      ])));
            }),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("btrade_userinfo")
                        .doc(cid)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      cnm = snapshot.data!.get("fnm");
                      udt = {
                        'fnm': snapshot.data!.get("fnm"),
                        'phn': snapshot.data!.get("phn"),
                        'add': snapshot.data!.get("add"),
                        'dist': snapshot.data!.get("dist"),
                        'state': snapshot.data!.get("state"),
                      };
                      ini = cnm[0];
                      return Text(cnm);
                    }),
                accountEmail: Text("" + cid),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.yellow,
                  child: StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("btrade_userinfo")
                          .doc(cid)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        cnm = snapshot.data!.get("fnm");
                        return Text(cnm[0]);
                      }),
                ),
              ),
              ListTile(
                title: Text("MY ACCOUNT"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => myaccount(
                                val: udt,
                              )));
                },
              ),
              ListTile(
                title: Text("ADD PRODUCT"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => additem(
                                val: cid,
                              )));
                },
              ),
              ListTile(
                title: Text("TRADE REQUEST"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => traderequest(mid: cid)));
                },
              ),
              ListTile(
                title: Text("TRADING HISTORY"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => tradehistory(
                                val: cid,
                              )));
                },
              ),
              ListTile(
                title: Text("LOG OUT"),
                onTap: () {
                  FileData().writeCounter("");
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => loginpage()));
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => loginpage()),
                      (Route<dynamic> route) => route.isFirst);
                },
              ),
            ],
          ),
        ));
  }

  List<Widget> pl = [];
}
