import 'package:btradeapp/tradeitem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class productdt extends StatefulWidget{
  final ele;
  final myid;
  productdt({required this.ele,this.myid}) : super();
  @override
  State createState() => _productdt();
}
List<Widget> pl = [];
double width=0.0,height=0.0;
class _productdt extends State<productdt>{

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    final TextEditingController pnm = TextEditingController(),pqty = TextEditingController(),pdes = TextEditingController(),penm = TextEditingController(),peqty = TextEditingController(),pedes = TextEditingController();
    pnm.text = widget.ele['pnm'];
    pqty.text = widget.ele['pqty'];
    pdes.text = widget.ele['pdes'];
    penm.text = widget.ele['penm'];
    peqty.text = widget.ele['peqty'];
    pedes.text = widget.ele['pedes'];
    return Scaffold(
      appBar: AppBar(title: Text(""+widget.ele['pnm']),),
      body:SingleChildScrollView(
      child : Container(
          margin: EdgeInsets.all(10),
          width: width,
          decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1)),
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(10),
                child:TextField(
                  controller: pnm,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'PRODUCT NAME',),
                ),),
              Padding(padding: EdgeInsets.all(10),
                child:TextField(
                  controller: pqty,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'QUANTITY',),
                ),),
              Padding(padding: EdgeInsets.all(10),
                child:TextField(
                  controller: pdes,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'DESCRIPTION',),
                ),),
              Padding(padding: EdgeInsets.all(10),
                child:TextField(
                  controller: penm,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'EXPECTED ITEM FOR TRADE',),
                ),),
              Padding(padding: EdgeInsets.all(10),
                child:TextField(
                  controller: peqty,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'EXPECTED QUANTITY',),
                ),),
              Padding(padding: EdgeInsets.all(10),
                child:TextField(
                  controller: pedes,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'DESCRIPTION',),
                ),),
              Padding(
                padding: EdgeInsets.all(10),
                child : ButtonTheme(
                    minWidth: width,
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder:(context) => tradeitem(val: widget.ele,myid: widget.myid,)));
                      },
                      child: Text("TRADE"),
                    )),
              ),
            ],

          )
      ),)


    );
  }
}