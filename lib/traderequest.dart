import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class traderequest extends StatefulWidget {
  String mid;
  traderequest({required this.mid}) : super();
  @override
  _traderequest createState() => _traderequest();
}

FirebaseFirestore db = FirebaseFirestore.instance;
double width = 0.0, height = 0.0;
List<Widget> pl = [];
List<Widget> rl = [];
List<Widget> ml = [];

class _traderequest extends State<traderequest> {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text("TRADE REQUESTS"),
          centerTitle: true,
        ),
        body: WillPopScope(
            onWillPop: () async {
              pl = [];
              rl = [];
              ml = [];
              Navigator.pop(context);
              return true;
            },
            child: SingleChildScrollView(
                child: Column(children: [
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("btrade_tradedt")
                      .where('trader', isEqualTo: widget.mid)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    snapshot.data!.docs.forEach((element) {
                      if (rl.length < snapshot.data!.size) {
                        rl.add(Container(
                            margin: EdgeInsets.all(10),
                            width: width,
                            padding: EdgeInsets.all(15),
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
                            child: Text(
                              "Trade Request for " +
                                  element['pnm'] +
                                  " is " +
                                  element['status'],
                              style: TextStyle(fontSize: 18),
                            )));
                      }
                    });
                    return (Column(
                      children: rl,
                    ));
                  }),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("btrade_tradedt")
                      .where(
                        'seller',
                        isEqualTo: widget.mid,
                      )
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData)
                      return Text("Loading Data..Please wait..");
                    int i = snapshot.data!.size;
                    snapshot.data!.docs.forEach((ele) {
                      if (pl.length < i && ele['status'] == "pending") {
                        pl.add(Container(
                            margin: EdgeInsets.all(10),
                            width: width,
                            padding: EdgeInsets.all(15),
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
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("- PRODUCT - ",
                                      style: TextStyle(fontSize: height / 45)),
                                  Text(ele['pnm']),
                                  Text(ele['pqty']),
                                  Text(ele['des']),
                                  Text("\n-PRODUCT OFFERED - ",
                                      style: TextStyle(fontSize: height / 45)),
                                  Text(ele['tpnm']),
                                  Text(ele['tpqty']),
                                  Text(ele['tdes'] + "\n"),
                                  Text("\n-TRADER DETAILS - ",
                                      style: TextStyle(fontSize: height / 45)),
                                  StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection("btrade_userinfo")
                                          .doc("" + ele['trader'])
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<DocumentSnapshot>
                                              snapshot) {
                                        return Container(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("Name : " +
                                                snapshot.data!.get("fnm")),
                                            Text("Phone no : " +
                                                snapshot.data!.get("phn")),
                                            Text("Address : " +
                                                snapshot.data!.get("add")),
                                            Text("District : " +
                                                snapshot.data!.get("dist")),
                                          ],
                                        ));
                                      }),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                            child: Container(
                                                child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            ButtonTheme(
                                                child: RaisedButton(
                                              onPressed: () {
                                                db
                                                    .collection(
                                                        "btrade_tradedt")
                                                    .doc(ele.id)
                                                    .update(
                                                        {'status': 'accepted'});
                                                pl = [];
                                                rl = [];
                                                ml = [];
                                                Navigator.pop(context);
                                              },
                                              child: Text("ACCEPT"),
                                            )),
                                          ],
                                        ))),
                                        Expanded(
                                            child: Container(
                                                margin: EdgeInsets.all(7),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    ButtonTheme(
                                                        child: RaisedButton(
                                                      onPressed: () {
                                                        db
                                                            .collection(
                                                                "btrade_tradedt")
                                                            .doc(ele.id)
                                                            .update({
                                                          'status': 'rejected'
                                                        });
                                                        pl = [];
                                                        rl = [];
                                                        ml = [];
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text("REJECT"),
                                                    )),
                                                  ],
                                                )))
                                      ]),
                                ])));
                      }
                    });
                    return SingleChildScrollView(
                        child: Column(
                      children: pl,
                    ));
                  }),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("btrade_tradedt")
                      .where(
                        'seller',
                        isEqualTo: widget.mid,
                      )
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData)
                      return Text("Loading Data..Please wait..");
                    int i = snapshot.data!.size;
                    snapshot.data!.docs.forEach((ele) {
                      if (ml.length < i && ele['status'] == "accepted") {
                        ml.add(Container(
                          margin: EdgeInsets.all(10),
                          width: width,
                          padding: EdgeInsets.all(15),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("TRADING REQUEST YOU ACCEPTED",
                                  style: TextStyle(fontSize: height / 45)),
                              Text(" "),
                              Text("- PRODUCT - ",
                                  style: TextStyle(fontSize: height / 45)),
                              Text(ele['pnm']),
                              Text(ele['pqty']),
                              Text(ele['des']),
                              Text("\n-PRODUCT OFFERED - ",
                                  style: TextStyle(fontSize: height / 45)),
                              Text(ele['tpnm']),
                              Text(ele['tpqty']),
                              Text(ele['tdes'] + ""),
                              Text("\n-TRADER DETAILS - ",
                                  style: TextStyle(fontSize: height / 45)),
                              StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection("btrade_userinfo")
                                      .doc("" + ele['trader'])
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<DocumentSnapshot>
                                          snapshot) {
                                    return Container(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Name : " +
                                            snapshot.data!.get("fnm")),
                                        Text("Phone no : " +
                                            snapshot.data!.get("phn")),
                                        Text("Address : " +
                                            snapshot.data!.get("add")),
                                        Text("District : " +
                                            snapshot.data!.get("dist")),
                                      ],
                                    ));
                                  }),
                            ],
                          ),
                        ));
                      }
                    });

                    return SingleChildScrollView(
                        child: Column(
                      children: ml,
                    ));
                  }),
            ]))));
  }
}
