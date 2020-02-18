import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:amazekart/home/product.dart';
import 'package:dio/dio.dart';
import 'package:amazekart/home/home.dart';
class Category extends StatefulWidget {
  List<dynamic> data;
  Category(this.data);
  @override
  _CategoryState createState() => _CategoryState(data);
}

class _CategoryState extends State<Category> {
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
  _CategoryState(this.data);
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
//          gradient: LinearGradient(
//            // Where the linear gradient begins and ends
//            begin: Alignment.topRight,
//            end: Alignment.bottomLeft,
//            // Add one stop for each color. Stops should increase from 0 to 1
//            stops: [0.1, 0.5, 0.7, 0.9],
//            colors: [
//              // Colors are easy thanks to Flutter's Colors class.
//              Colors.red[300],
//              Colors.red[200],
//              Colors.red[100],
//              Colors.red[50],
//            ],
//          ),
//        ),
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
                      data[0]["category"].toString(),
                      style: TextStyle(color: Colors.white, fontSize: 30.0,letterSpacing: 3,fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                    child: ListView.builder(itemCount:data.length%2==1? (data.length~/2 + 3):(data.length~/2 + 2),
                        itemBuilder: (context,index) {
                          int i = index;
                          if (i == 0) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(),
                            );
//                            return Padding(
//                              padding: EdgeInsets.all(10),
//                              child: ButtonTheme(
//                                height: 80,
//                                child: RaisedButton(
//                                  shape: RoundedRectangleBorder(
//                                    borderRadius: BorderRadius.circular(80.0),),
//                                  elevation: 10,
//                                  onPressed: () {},
//                                  textColor: Colors.white,
//                                  color: Color(0xFF083780),
//                                  padding: const EdgeInsets.all(8.0),
//                                  child: new Text(
//                                    "Try Selling Something",
//                                    style: TextStyle(fontSize: 25),
//                                  ),
//                                ),
//                              ),
//                            );
                          }
                          else if(i==1){
                            return Container();
//                            return Row(
//                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                              children: <Widget>[
//                                Material(
//                                  elevation: 10.0,
//                                  shape: CircleBorder(),
//                                  clipBehavior: Clip.hardEdge,
//                                  color: Colors.transparent,
//                                  child: Ink.image(
//                                    image: AssetImage('assets/collaboration.png'),
//                                    fit: BoxFit.cover,
//                                    width: MediaQuery.of(context).size.width/3.2,
//                                    height: 120.0,
//                                    child: InkWell(
//                                      onTap: () {},
//                                    ),
//                                  ),
//                                ),
//                                Material(
//                                  elevation: 10.0,
//                                  shape: CircleBorder(),
//                                  clipBehavior: Clip.hardEdge,
//                                  color: Colors.transparent,
//                                  child: Ink.image(
//                                    image: AssetImage('assets/collaboration.png'),
//                                    fit: BoxFit.cover,
//                                    width: MediaQuery.of(context).size.width/3.2,
//                                    height: 120.0,
//                                    child: InkWell(
//                                      onTap: () {},
//                                    ),
//                                  ),
//                                ),
//                                Material(
//                                  elevation: 10.0,
//                                  shape: CircleBorder(),
//                                  clipBehavior: Clip.hardEdge,
//                                  color: Colors.transparent,
//                                  child: Ink.image(
//                                    image: AssetImage('assets/collaboration.png'),
//                                    fit: BoxFit.cover,
//                                    width: MediaQuery.of(context).size.width/3.2,
//                                    height: 120.0,
//                                    child: InkWell(
//                                      onTap: () {},
//                                    ),
//                                  ),
//                                )
//                              ],
//                            );
                          }
                          else{
                            i =2*index-2;
                            if((index==(data.length~/2 + 2))){
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailPage(data[i-2])));
                                      },
                                      splashColor: Color(0xFF083663),
                                      child: Card(
                                          shape: new RoundedRectangleBorder(
                                            borderRadius: new BorderRadius.circular(15),
                                          ),
                                          elevation: 10,
                                          child: Column(
                                            children: <Widget>[
                                              Image.network(
                                                data[i-2]['images'][0]['imageurl'],
                                                height: MediaQuery.of(context).size.height/3.5,
                                                width: MediaQuery.of(context).size.width/2.2,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context).size.width/2.2,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(1.0),
                                                  child:  Center(child: AutoSizeText(data[i-2]['productname'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),maxLines: 2,overflow: TextOverflow.ellipsis,)),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0,1,0,1),
                                                child: Container(child: AutoSizeText('₹ '+data[i-2]['price'].toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),maxLines: 2)),
                                              )
                                            ],
                                          )
                                      ),
                                    ),
                                  ),
                                  Material(
                                    color:Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
//                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailPage(data[index-2])));
                                      },
                                      splashColor: Color(0xFF083663),
                                      child: Card(
                                          shape: new RoundedRectangleBorder(
                                            borderRadius: new BorderRadius.circular(15),
                                          ),
                                          elevation: 10,
                                          child: Column(
                                            children: <Widget>[
                                              Image.asset(
                                                'assets/logo.png',
                                                height: MediaQuery.of(context).size.height/3.5,
                                                width: MediaQuery.of(context).size.width/2.2,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context).size.width/2.2,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(1.0),
                                                  child:  AutoSizeText('',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),maxLines: 2,overflow: TextOverflow.ellipsis,),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0,1,0,1),
                                                child: Container(child: AutoSizeText('',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),maxLines: 2)),
                                              )
                                            ],
                                          )
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                            else{
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailPage(data[i-2])));
                                      },
                                      splashColor: Color(0xFF083663),
                                      child: Card(
                                          shape: new RoundedRectangleBorder(
                                            borderRadius: new BorderRadius.circular(15),
                                          ),
                                          elevation: 10,
                                          child: Column(
                                            children: <Widget>[
                                              Image.network(
                                                data[i-2]['images'][0]['imageurl'],
                                                height: MediaQuery.of(context).size.height/3.5,
                                                width: MediaQuery.of(context).size.width/2.2,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context).size.width/2.2,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(1.0),
                                                  child:  Center(child: AutoSizeText(data[i-2]['productname'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),maxLines: 2,overflow: TextOverflow.ellipsis,)),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0,1,0,1),
                                                child: Container(child: AutoSizeText('₹ '+data[i-2]['price'].toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),maxLines: 2)),
                                              )
                                            ],
                                          )
                                      ),
                                    ),
                                  ),
                                  Material(
                                    color:Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailPage(data[i-1])));
                                      },
                                      splashColor: Color(0xFF083663),
                                      child: Card(
                                          shape: new RoundedRectangleBorder(
                                            borderRadius: new BorderRadius.circular(15),
                                          ),
                                          elevation: 10,
                                          child: Column(
                                            children: <Widget>[
                                              Image.network(
                                                data[i-1]['images'][0]['imageurl'],
                                                height: MediaQuery.of(context).size.height/3.5,
                                                width: MediaQuery.of(context).size.width/2.2,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context).size.width/2.2,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(2.0),
                                                  child:  Center(child: AutoSizeText(data[i-1]['productname'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),maxLines: 2,overflow: TextOverflow.ellipsis,)),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0,1,0,1),
                                                child: Container(child: AutoSizeText('₹ '+data[i-1]['price'].toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),maxLines: 2)),
                                              )
                                            ],
                                          )
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                          }
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
                          decoration: InputDecoration(
                            hintText: "Search",
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Color(0xFF442B2D),
                        ),
                        onPressed: () async{
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                            return Opacity(child:Center(
                              child: CircularProgressIndicator(),
                            ),opacity:1);
                          }));
                          Response response;
                          Dio dio = new Dio();
                          response = await dio.get("http://amazekart.tech:8000/mainapp/productdatabase", queryParameters: {"search": t,"cat":data[0]["category"].toString()});
//                          data = response.data;
                          Navigator.pop(context);
                          if(response.data.length==0){
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => Category(response.data)));
                          }
                          else{
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => Category(response.data)));
                          }

                        },
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
