import 'package:btradeapp/updateitem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';

class tradehistory extends StatefulWidget {
  final String val;
  tradehistory({required this.val}) : super();
  _tradehistory createState() => _tradehistory();
}

String cid = " ", cnm = " ";
FirebaseFirestore db = FirebaseFirestore.instance;
double width = 0.0, height = 0.0;
List<Widget> pl = [];
List item = [];

class _tradehistory extends State<tradehistory> {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    pl.clear();
    return Scaffold(
      appBar: AppBar(
        title: Text("YOUR TRADE HISTORY"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("btrade_itemdt")
            .where('userid', isEqualTo: widget.val)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return Text("Loading Data..Please wait..");
          int i = snapshot.data!.size;
          snapshot.data!.docs.forEach((element) {
            if (pl.length < i) {
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "YOU ADDED PRODUCT FOR TRADING",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(""),
                    Text(
                      "Product : " + element['pnm'],
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "Qty : " + element['pqty'],
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "Expected Product : " + element['penm'],
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "Qty : " + element['peqty'],
                      style: TextStyle(fontSize: 18),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(7),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ButtonTheme(
                                      child: RaisedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => updateitem(
                                                    ele: element,
                                                  )));
                                    },
                                    child: Text("UPDATE"),
                                  ))
                                ],
                                // crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(7),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ButtonTheme(
                                    child: RaisedButton(
                                      onPressed: () {
                                        db
                                            .collection("btrade_itemdt")
                                            .doc(element.id)
                                            .delete();
                                        Fluttertoast.showToast(
                                            msg: "Deleted....");
                                      },
                                      child: Text("DELETE"),
                                    ),
                                  )
                                ],
                                // crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),
                          ),
                        ])
                  ],
                ),
              ));
            }
          });
          return SingleChildScrollView(
              child: Column(
            children: pl,
          ));
        },
      ),
    );
  }
}
