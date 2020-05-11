import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:amazekart/home/product.dart';
import 'package:dio/dio.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
      backgroundColor: Colors.blue[100],
      body: Container(
//        decoration: BoxDecoration(
//          image: DecorationImage(
//            image: AssetImage("assets/back.png"),
//            fit: BoxFit.cover,
//          ),
//        ),
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
                          }
                          else if(i==1){
                            return Container();
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
                                          color:Color(0xFF083663),
                                          shape: new RoundedRectangleBorder(
                                            borderRadius: new BorderRadius.circular(15),
                                          ),
                                          elevation: 10,
                                          child: Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: Image.network(
                                                  data[i-2]['images'][0]['imageurl'],
                                                  height: MediaQuery.of(context).size.height/3.5,
                                                  width: MediaQuery.of(context).size.width/2.2,
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context).size.width/2.2,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(1.0),
                                                  child:  Center(child: AutoSizeText(data[i-2]['productname'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color:Colors.white),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0,1,0,1),
                                                child: Container(child: AutoSizeText('₹ '+data[i-2]['price'].toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color:Colors.white),maxLines: 1,overflow: TextOverflow.ellipsis,)),
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
                                          color:Color(0xFF083663),
                                          shape: new RoundedRectangleBorder(
                                            borderRadius: new BorderRadius.circular(15),
                                          ),
                                          elevation: 10,
                                          child: Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: Image.asset(
                                                  'assets/logo.png',
                                                  height: MediaQuery.of(context).size.height/3.5,
                                                  width: MediaQuery.of(context).size.width/2.2,
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context).size.width/2.2,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(1.0),
                                                  child:  AutoSizeText('',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0,1,0,1),
                                                child: Container(child: AutoSizeText('',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),maxLines: 1,overflow: TextOverflow.ellipsis,)),
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
                                          color:Color(0xFF083663),
                                          shape: new RoundedRectangleBorder(
                                            borderRadius: new BorderRadius.circular(15),
                                          ),
                                          elevation: 10,
                                          child: Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: Image.network(
                                                  data[i-2]['images'][0]['imageurl'],
                                                  height: MediaQuery.of(context).size.height/3.5,
                                                  width: MediaQuery.of(context).size.width/2.2,
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context).size.width/2.2,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(1.0),
                                                  child:  Center(child: AutoSizeText(data[i-2]['productname'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0,1,0,1),
                                                child: Container(child: AutoSizeText('₹ '+data[i-2]['price'].toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),maxLines: 1,overflow: TextOverflow.ellipsis,)),
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
                                          color:Color(0xFF083663),
                                          shape: new RoundedRectangleBorder(
                                            borderRadius: new BorderRadius.circular(15),
                                          ),
                                          elevation: 10,
                                          child: Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: Image.network(
                                                  data[i-1]['images'][0]['imageurl'],
                                                  height: MediaQuery.of(context).size.height/3.5,
                                                  width: MediaQuery.of(context).size.width/2.2,
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context).size.width/2.2,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(2.0),
                                                  child:  Center(child: AutoSizeText(data[i-1]['productname'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0,1,0,1),
                                                child: Container(child: AutoSizeText('₹ '+data[i-1]['price'].toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),maxLines: 1,overflow: TextOverflow.ellipsis,)),
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
                            return Scaffold(
                              backgroundColor: Colors.white,
                              body: Center(
                                child: SpinKitCubeGrid(
                                  color:  Color(0xFF083663),
                                ),
                              ),
                            );
                          }));
                          Response response;
                          Dio dio = new Dio();
                          response = await dio.get("http://amazekart.tech/mainapp/productdatabase", queryParameters: {"search": t,"cat":data[0]["category"].toString()});
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
                      IconButton(
                        icon: Icon(
                          Icons.refresh,
                          color: Color(0xFF442B2D),
                        ),
                        onPressed: () async{
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
                          Response response;
                          Dio dio = new Dio();
                          response = await dio.get("http://amazekart.tech/mainapp/productdatabase", queryParameters: {"cat":data[0]["category"].toString()});
//                          data = response.data;
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Category(response.data)));
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
