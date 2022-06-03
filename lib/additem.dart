// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

String pnm = "",
    pqty = "",
    pdes = "",
    penm = "",
    peqty = "",
    pedes = "",
    tl = "";
FirebaseFirestore db = FirebaseFirestore.instance;

class additem extends StatefulWidget {
  final String val;
  additem({Key key, this.val}) : super(key: key);
  @override
  _additem createState() => _additem();
}

class _additem extends State<additem> {
  @override
  Widget build(BuildContext context) {
    var groupValue;

    double width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    AssetImage img = new AssetImage('assets/Add-item-icon.png');
    var image = new Image(
      image: img,
      width: width / 3,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("ADD PRODUCT FOR TRADING"),
      ),
      body: Container(
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
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              image,
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: "PRODUCT TITLE",
                          hintText: "Enter product name",
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (val) {
                          pnm = val;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: "PRODUCT QTY",
                          hintText: "Enter product quantity",
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (val) {
                          pqty = val;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: "PRODUCT DESCRIPTION",
                          hintText: "Enter product description",
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (val) {
                          pdes = val;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: "PRODUCT EXPECTED FOR TRADING",
                          hintText: "Enter expected product name for trading",
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (val) {
                          penm = val;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: "EXPECTED PRODUCT QTY",
                          hintText: "Enter product quantity",
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (val) {
                          peqty = val;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: "EXCPECTED PRODUCT DESCRIPTION",
                          hintText: "Enter product description",
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (val) {
                          pedes = val;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: ButtonTheme(
                  minWidth: width,
                  child: RaisedButton(
                      child: Text("SAVE"),
                      onPressed: () {
                        db
                            .collection("btrade_itemdt")
                            .doc(widget.val +
                                "" +
                                pnm.replaceAll(" ", "").trim() +
                                "" +
                                penm.replaceAll(" ", "").trim())
                            .set({
                          'userid': widget.val,
                          'pnm': pnm,
                          'pqty': pqty,
                          'pdes': pdes,
                          'penm': penm,
                          'peqty': peqty,
                          'pedes': pedes,
                        });
                        Fluttertoast.showToast(msg: "Item Added For Trading");
                        Navigator.pop(context);
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
