import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:amazekart/home/product.dart';
import 'package:dio/dio.dart';
import 'package:amazekart/home/home.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

enum ConfirmAction { CANCEL, ACCEPT }
class Cart extends StatefulWidget {
  List<dynamic> data;
  Cart(this.data);
  @override
  _Cart createState() => _Cart(data);
}

class _Cart extends State<Cart> {
  TextEditingController _controller;

  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  String t;
  List<dynamic> data;
  _Cart(this.data);
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/back.png"),
            fit: BoxFit.cover,
          ),
        ),
        // Box decoration takes a gradient
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  color:Color(0xFF083663),
                  width: MediaQuery.of(context).size.width,
                  height: 100.0,
                  child: Center(
                    child: Text(
                      "Your Products",
                      style: TextStyle(color: Colors.white, fontSize: 30.0,letterSpacing: 3,fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                    child: ListView.builder(itemCount:data.length,
                        itemBuilder: (context,index) {
                          int i = index;

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetailPage(data[i])));
                                  },
                                  splashColor: Color(0xFF083663),
                                  child: Card(
                                      shape: new RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(
                                            15),
                                      ),
                                      elevation: 10,
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width / 1.2,
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                    1.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: <Widget>[
                                                    Center(
                                                        child: AutoSizeText(
                                                          data[i]['productname'],
                                                          style: TextStyle(
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              fontSize: 30),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,)),
                                                    IconButton(icon:Icon(Icons.delete), iconSize: 25,onPressed: () async{
                                                      showDialog(context: context,
                                                          builder: (BuildContext context){
                                                        return Container(
                                                          child: AlertDialog(
                                                            title: Text('Confirm Delete'),
                                                            actions: <Widget>[
                                                              FlatButton(
                                                                child: const Text('CANCEL'),
                                                                onPressed: () {
                                                                  Navigator.of(context).pop(ConfirmAction.CANCEL);
                                                                },
                                                              ),
                                                              FlatButton(
                                                                child: const Text('ACCEPT'),
                                                                onPressed: () async{
//                                                                  Navigator.of(context).pop(ConfirmAction.ACCEPT);
                                                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                                                    return Scaffold(
                                                                      backgroundColor: Colors.white,
                                                                      body: Center(
                                                                        child: SpinKitCubeGrid(
                                                                          color:  Color(0xFF083663),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }));
                                                                  var dio = Dio();
                                                                  FormData formData = new FormData.fromMap({
                                                                    "id": data[i]["id"],
                                                                    "email": data[i]["user"]["email"],
                                                                    "price": data[i]["price"],
                                                                    "category":data[i]["category"],
                                                                    "productname":data[i]["productname"],
                                                                    "description":data[i]["description"],
                                                                    "delete":"true"
                                                                  });
                                                                  Response response1;
                                                                  String url = 'http://amazekart.tech/mainapp/updateapi/';
                                                                  response1 = await dio.post(url, data: formData );
                                                                  Navigator.pop(context);
                                                                  Navigator.of(context).pop(ConfirmAction.ACCEPT);
                                                                  setState(() {
                                                                    data = response1.data;

                                                                  });

                                                                },
                                                              )
                                                            ],
                                                          ),
                                                        );
                                                          });

                                                    },)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Image.network(
                                              data[i]['images'][0]['imageurl'],
                                              height: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .height / 4,
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width / 1.2,
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                    )
                )
              ],
            ),
            Positioned(
              top: 80.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1.0),
                      border: Border.all(
                          color: Colors.grey.withOpacity(0.5), width: 1.0),
                      color: Colors.white),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Color(0xFF083663),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          onChanged: (String value){
                            t = value;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
