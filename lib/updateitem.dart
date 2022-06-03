import 'package:btradeapp/mainpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class updateitem extends StatefulWidget{

  QueryDocumentSnapshot ele;
  updateitem({required this.ele}) : super();
  @override
  _updateitem createState() => _updateitem();
}
FirebaseFirestore db = FirebaseFirestore.instance;
double width=0.0,height=0.0;
String pnm1="",pqty1="",pdes1="",penm1="",peqty1="",pedes1="";
class _updateitem extends State<updateitem>{

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    getItem();
    return Scaffold(
      appBar: AppBar(title: Text("UPDATE"),),
      body: SingleChildScrollView(
        child : Container(
            margin: EdgeInsets.all(10),
            width: width,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black,width: 1)
            ),
            padding: EdgeInsets.all(15),
            child: Column(
              children: pl,
            )
        ),)
    );
  }
  List<Widget> pl = [];
  getItem()
  {
    if(pl.length<1) {
      final TextEditingController pnm = TextEditingController(),pqty = TextEditingController(),pdes = TextEditingController(),penm = TextEditingController(),peqty = TextEditingController(),pedes = TextEditingController();
      pnm.text = widget.ele['pnm'];
      pqty.text = widget.ele['pqty'];
      pdes.text = widget.ele['pdes'];
      penm.text = widget.ele['penm'];
      peqty.text = widget.ele['peqty'];
      pedes.text = widget.ele['pedes'];
      pl.add(Column(children: [
        Padding(padding: EdgeInsets.all(10),
          child: TextField(
            onChanged: (text) {
              pnm1 = text;
            },
            controller: pnm,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'PRODUCT NAME',),
          ),),
        Padding(padding: EdgeInsets.all(10),
          child: TextField(
            onChanged: (text) {
              pqty1 = text;
            },
            controller: pqty,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'QUANTITY',),
          ),),
        Padding(padding: EdgeInsets.all(10),
          child: TextField(
            onChanged: (text) {
              pdes1 = text;
            },
            controller: pdes,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'DESCRIPTION',),
          ),),
        Padding(padding: EdgeInsets.all(10),
          child: TextField(
            onChanged: (text) {
              penm1 = text;
            },
            controller: penm,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'EXPECTED ITEM FOR TRADE',),
          ),),
        Padding(padding: EdgeInsets.all(10),
          child: TextField(
            onChanged: (text) {
              peqty1 = text;
            },
            controller: peqty,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'EXPECTED QUANTITY',),
          ),),
        Padding(padding: EdgeInsets.all(10),
          child: TextField(
            onChanged: (text) {
              pedes1 = text;
            },
            controller: pedes,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'DESCRIPTION',),
          ),),
        Padding(
          padding: EdgeInsets.all(10),
          child: ButtonTheme(
              minWidth: width,
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: () {
                  var ud = {
                    'pnm': pnm.text,
                    'pqty': pqty.text,
                    'pdes': pdes.text,
                    'penm': penm.text,
                    'peqty': peqty.text,
                    'pedes': pedes.text,
                  };
                  db.collection("btrade_itemdt").doc(widget.ele.id).update(ud);
                  Fluttertoast.showToast(msg: "Updated....");
                  Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (BuildContext context) => mainpage(val: widget.ele['userid'])),(Route<dynamic> route) => route.isFirst);
                },
                child: Text("UPDATE"),
              )),
        ),
      ],));
    }
  }

}