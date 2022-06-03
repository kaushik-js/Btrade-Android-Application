import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class tradeitem extends StatefulWidget{
  final val;
  final myid;
  tradeitem({required this.val,this.myid}) : super();
  _tradeitem createState() => _tradeitem();
}
FirebaseFirestore db = FirebaseFirestore.instance;
double width=0.0,height=0.0;
String npnm="",npqty="",ndes="";
class _tradeitem extends State<tradeitem>{
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    var ele = widget.val;
    return Scaffold(
      appBar: AppBar(title: Text("TRADE ITEM"),),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(20),
            child : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /*Text("- PRODUCT - \n"+ele['pnm'],style: TextStyle(fontSize: height/28)),
                      Text(ele['pqty'],style: TextStyle(fontSize: height/28)),
                      Text(ele['pdes'],style: TextStyle(fontSize: height/28)),*/
                      Text("-EXPECTED PRODUCT - \n",style: TextStyle(fontSize: height/28)),
                      Text(ele['penm'],style: TextStyle(fontSize: height/28)),
                      Text(ele['peqty'],style: TextStyle(fontSize: height/28)),
                      Text(ele['pedes']+"\n",style: TextStyle(fontSize: height/28)),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.all(10),
                  child: TextField(
                    onChanged: (text)
                    {npnm=text;},
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'TRADING PRODUCT NAME',),
                  ),),
                Padding(padding: EdgeInsets.all(10),
                  child: TextField(
                    onChanged: (text)
                    {npqty=text;},
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'TRADING PRODUCT QTY',),
                  ),),
                Padding(padding: EdgeInsets.all(10),
                  child: TextField(
                    onChanged: (text)
                    {ndes=text;},
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'TRADING PRODUCT DESCRIPTION (IF ANY)',),
                  ),),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: ButtonTheme(
                        minWidth: width,
                        child: RaisedButton(
                          onPressed: (){
                            var st = ele['userid'];
                            String docnm = st + "-" +widget.myid+"-"+npnm;
                            var udt = {
                              'pnm':ele['pnm'],
                              'pqty':ele['pqty'],
                              'des':ele['pdes'],
                              'tpnm' : npnm,
                              'tpqty':npqty,
                              'tdes':ndes,
                              'seller':st,
                              'trader':widget.myid,
                              'status':'pending',
                            };
                            db.collection("btrade_tradedt").doc(docnm).set(udt);
                            Fluttertoast.showToast(msg: "Your request for exchange has been send...");
                            Navigator.pop(context);
                          },
                          child: Text("GO FOR EXCHANGE"),
                        )
                    )
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}