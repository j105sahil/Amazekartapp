import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'package:toast/toast.dart';
import 'package:amazekart/sell/image_picker_handler.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
class Sell extends StatefulWidget {
  List<dynamic> data;
  Map<dynamic,dynamic> user;

  Sell(List<dynamic> d,Map<dynamic,dynamic> u){
    this.data = d;
    this.user = u;
  }
  @override
  _SellState createState() => _SellState(data,user);
}

class _SellState extends State<Sell> with TickerProviderStateMixin,ImagePickerListener{
  List<TextEditingController> _controller;
  AnimationController _controllerA;
  String price;
  String description;
  String productName;
  var dropdownValue;

  @override
  void initState() {
    super.initState();
    _controller = List.generate(3, (i) => TextEditingController());
    _controllerA = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    imagePicker=new ImagePickerHandler(this,_controllerA);
    imagePicker.init();
  }
  void dispose() {
    _controller.forEach((c) => c.dispose());
    _controllerA.dispose();
    super.dispose();
  }
  File _image0;
  File _image1;
  File _image2;
  File _image3;
  String url1;
  String url2;
  String url3;
  String url4;
  int i=0;

  ImagePickerHandler imagePicker;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();


//            Electronics
//            Course Books
//            Laptop/Mobile Acc.
//            Room Accessory
//            Novels
//            Gym Equipment
//            Online Accounts
//            Clothes & Shoes
//            Other
  var teMobile = TextEditingController();
  final Map<String, IconData> _data = Map.fromIterables(
      ['Category','Electronics', 'Course Books', 'Laptop/Mobile Acc.','Room Accessory','Novels','Gym Equipment','Online Accounts','Clothes & Shoes','Other'],
      [ Icons.photo_filter ,Icons.filter_1, Icons.filter_2, Icons.filter_3,Icons.filter_4,Icons.filter_5, Icons.filter_6, Icons.filter_7,Icons.filter_8,Icons.filter_9]);
  String _selectedType;
  IconData _selectedIcon;
  List<dynamic> data;
  Map<dynamic,dynamic> user;
  _SellState(List<dynamic> d,Map<dynamic,dynamic> u){
    this.data = d;
    this.user = u;
  }
  var dio = Dio();
  String t;
  @override
  Widget build(BuildContext context) {
      Future uploadPic(BuildContext context,File _image,int i) async{
        String fileName = basename(_image.path);
        StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(DateTime.now().millisecondsSinceEpoch.toString());
        StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
        var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();
        String url = dowurl.toString();
        print(url);
        if(i==0){
          url1 = url;
        }
        if(i==1){
          url2 = url;
        }
        if(i==2){
          url3 = url;
        }
        if(i==3){
          url4 = url;
        }

      //       StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
      }
    return Scaffold(
      appBar: AppBar(title: Text("Sell a Product",style:TextStyle(fontSize: 28) ),backgroundColor: Color(0xFF083663),),
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/aa.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        width: MediaQuery.of(context).size.width,
        // Box decoration takes a gradient
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center ,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Text("Product Name",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold ),),
              ),
              Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        controller: _controller[0],
                        autocorrect: true,
                        style: TextStyle(fontSize: 20),
                        onChanged: (String value){
                          productName = value;
                        },
                        decoration: new InputDecoration(
                          hintText: "Product Name",
                        ),
                      ),
                    ),
                  ),),
              //getTextField("Product Name", productName)
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Text("Description",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold ),),
              ),
              Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        controller: _controller[1],
                        autocorrect: true,
                        style: TextStyle(fontSize: 20),
                        onChanged: (String value){
                          description = value;
                        },
                        decoration: new InputDecoration(
                          hintText: "Description",
                        ),
                      ),
                    ),
                  ),),
                  //getTextField("Description", description
                  //
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Text("Price ₹ ",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold ),),
              ),
              Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        controller: _controller[2],
                        keyboardType: TextInputType.number,
                        autocorrect: true,
                        style: TextStyle(fontSize: 20),
                        onChanged: (String value){
                          price = value;
                        },
                        decoration: new InputDecoration(
                          hintText: "Price",
                        ),
                      ),
                    ),
                  ),),
              //getTextField("Price", price)
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Text("Category",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold ),),
              ),
              Container(
                color: Colors.transparent.withOpacity(0.08),
                padding: EdgeInsets.all(1.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                      icon: Icon(Icons.arrow_downward,color: Colors.black,),
                      iconSize: 30,
                      items: _data.keys.map((String val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Icon(_data[val]),
                              ),
                              Text(val),
                            ],
                          ),
                        );
                      }).toList(),
                      hint:Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child:
                            Icon(_selectedIcon ?? _data.values.toList()[0]),
                          ),
                          Text(_selectedType ?? _data.keys.toList()[0],style: TextStyle(fontSize: 20,color: Colors.black),),
                        ],
                      ),
                      //hint: Text("Category",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black),),
                      onChanged: (String val) {
                        setState(() {
                          _selectedType = val;
                          _selectedIcon = _data[val];
                        });
                      }),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text("Upload Images",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold ),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    decoration: const ShapeDecoration(
                      color: Colors.blueGrey,
                      shape: CircleBorder(),
                    ),
                    child:  IconButton(
                        icon: Icon(_image0==null?Icons.add_circle_outline:Icons.camera_alt),
                        tooltip: 'Upload a photo',
                        onPressed: (){i = 1;imagePicker.showDialog(context);},
                        color: Colors.black
                    ),
                  ),
                  Container(
                    decoration: const ShapeDecoration(
                      color: Colors.blueGrey,
                      shape: CircleBorder(),
                    ),
                    child:  IconButton(
                        icon: Icon(_image1==null?Icons.add_circle_outline:Icons.camera_alt),
                        tooltip: 'Upload a photo',
                        onPressed: () {i =2; imagePicker.showDialog(context);},
                        color: Colors.black
                    ),
                  ),
                  Container(
                    decoration: const ShapeDecoration(
                      color: Colors.blueGrey,
                      shape: CircleBorder(),
                    ),
                    child:  IconButton(
                        icon: Icon(_image2==null?Icons.add_circle_outline:Icons.camera_alt),
                        tooltip: 'Upload a photo',
                        onPressed: (){i=3; imagePicker.showDialog(context);},
                        color: Colors.black
                    ),
                  ),
                  Container(
                    decoration: const ShapeDecoration(
                      color: Colors.blueGrey,
                      shape: CircleBorder(),
                    ),
                    child:  IconButton(
                        icon: Icon(_image3==null?Icons.add_circle_outline:Icons.camera_alt),
                        tooltip: 'Upload a photo',
                        onPressed: (){i=4; imagePicker.showDialog(context);},
                        color: Colors.black
                    ),
                  ),
                ],
              ),
              OutlineButton(
                onPressed: () async{
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return Opacity(child:Center(
                      child: CircularProgressIndicator(),
                    ),opacity:1);
                  }));
                  _showToast2(context);
                  if(_image0!=null || _image1!=null ||_image2!=null ||_image3!=null){
                    if(_image0!=null)
                      await uploadPic(context, _image0,0);
                    if(_image1!=null)
                      await uploadPic(context, _image1,1);
                    if(_image2!=null)
                      await uploadPic(context, _image2,2);
                    if(_image3!=null)
                      await uploadPic(context, _image3,3);
                    List<String> urls = [];
                    if(_image0!=null)
                      urls.add(url1);
                    if(_image1!=null)
                      urls.add(url2);
                    if(_image2!=null)
                      urls.add(url3);
                    if(_image3!=null)
                      urls.add(url4);

                    var dio = Dio();
                    FormData formData = new FormData.fromMap({
                      "name": productName,
                      "cat": _selectedType.toString(),
                      "price": price,
                      "desc":description,
                      "image":urls.toString(),
                      "email":user["email"],
                    });
                    Response response1;
                    String url = 'http://amazekart.tech:8000/mainapp/productdatabase/';
                    response1 = await dio.post(url, data: formData );
                    _showToast1(context);
                   // 18.222.65.138
                  }
                  else{
                    _showToast(context);
                  }
                  Navigator.pop(context);
                  Navigator.pop(context);
                  },
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text('Submit',style: TextStyle(fontSize: 25),),
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
  //
  Widget getTextField(
      String inputBoxName, TextEditingController inputBoxController){
    var loginBtn = new Material(
        color: Colors.transparent,
        child:Padding(
          padding: const EdgeInsets.all(20.0),
          child: new TextFormField(
            cursorColor: Colors.greenAccent,
            style: TextStyle(fontSize: 20),
            autocorrect: true,
            controller: inputBoxController,
            decoration: new InputDecoration(
              hintText: inputBoxName,
            ),
          ),
        )
    );
    return loginBtn;
  }

  void _showToast(BuildContext context) {
    Toast.show("Upload a photo", context, gravity: Toast.BOTTOM);
  }
  void _showToast1(BuildContext context) {
    Toast.show("Successful", context, gravity: Toast.BOTTOM);
  }
  void _showToast2(BuildContext context) {
    Toast.show("Uploading", context, gravity: Toast.BOTTOM);
  }

@override
  userImage(File _image) {
    setState(() {
      if(this.i==1)
        this._image0 = _image;
      else if(this.i==2)
        this._image1 = _image;
      else if(this.i==3)
        this._image2 = _image;
      else
        this._image3 = _image;
    });
  }
}