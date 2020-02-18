import 'package:amazekart/main.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:amazekart/home/home.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Login extends StatefulWidget {
  Map<String,String> m;
  Login( Map<String,String> m){
    this.m = m;
  }
  @override
  _LoginState createState() => _LoginState(m);
}

class _LoginState extends State<Login> {

  TextEditingController _controllerE;
  TextEditingController _controllerP;
  List<TextEditingController> _controller;

  void initState() {
    super.initState();
    _controllerE = TextEditingController(text: m==null?null:m["email"]);
    _controllerP = TextEditingController(text: m==null?null:m["pass"]);
//    _controller = TextEditingController();
    _controller = List.generate(6, (i) => TextEditingController());
  }

  void dispose() {
    _controllerE.dispose();
    _controllerP.dispose();
    _controller.forEach((c) => c.dispose());
    super.dispose();
  }
  Map<String,String> m;
  String first;
  String last;
  String teEmail;
  String tePassword;
  String teConfirmPassword;

  String teMobile;
  _LoginState(Map<String,String> m){
    this.m = m;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
        ),
        Column(
          children: <Widget>[
            ///holds email header and inputField
            //getTextField("Enter Email", teEmail,false,false),
            Material(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: _controllerE,
                  autocorrect: true,
                  style: TextStyle(fontSize: 20),
                  onChanged: (String value){
                    teEmail = value;
                  },
                  decoration: new InputDecoration(
                    hintText: "Enter Email",
                    suffixIcon:Icon(Icons.email),
                  ),
                ),
              ),
            ),
            //getTextField("Enter Password", tePassword,true,false),
            Material(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: _controllerP,
                  autocorrect: true,
                  obscureText: true,
                  style: TextStyle(fontSize: 20),
                  onChanged: (String value){
                    tePassword = value;
                  },
                  decoration: new InputDecoration(
                    hintText: "Enter Password",
                    suffixIcon:Icon(Icons.lock_outline),
                  ),
                ),
              ),
            ),
            new GestureDetector(
              onTap: () {

//                Navigator.of(context).pop();
              },
              child: roundedRectButton("Let's get Started", signInGradients, false,teEmail,tePassword,context),
            ),
            FlatButton(
              color: Colors.transparent,
              textColor: Colors.black,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.transparent,
              child: Text(
                "AutoFill",
                style: TextStyle(fontSize: 15.0),
              ),
              onPressed: () async{
                await _read();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage(m)));
              },
            ),
            FlatButton(
              color: Colors.transparent,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.transparent,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context){
                      return Container(child: AlertDialog(
                        title: new Text('Welcome to AmazeKart',style: TextStyle(color: Colors.deepOrangeAccent),),
                        content: new SingleChildScrollView(
                          child: new Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              //getTextField("Enter Email", teEmail,false,true),
                              Material(
                                color: Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: TextField(
                                    controller: _controller[0],
                                    autocorrect: true,
                                    style: TextStyle(fontSize: 20),
                                    onChanged: (String value){
                                      teEmail = value;
                                    },
                                    decoration: new InputDecoration(
                                      hintText: "Enter Email",
                                    ),
                                  ),
                                ),
                              ),
//                              getTextField("First Name", first,false,true),
                              Material(
                                color: Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: TextField(
                                    controller: _controller[1],
                                    autocorrect: true,
                                    style: TextStyle(fontSize: 20),
                                    onChanged: (String value){
                                      first = value;
                                    },
                                    decoration: new InputDecoration(
                                      hintText: "First Name",
                                    ),
                                  ),
                                ),
                              ),
//                              getTextField("Last Name", last,false,true),
                              Material(
                                color: Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: TextField(
                                    controller: _controller[2],
                                    autocorrect: true,
                                    style: TextStyle(fontSize: 20),
                                    onChanged: (String value){
                                      last = value;
                                    },
                                    decoration: new InputDecoration(
                                      hintText: "Last Name",
                                    ),
                                  ),
                                ),
                              ),
//                              getTextField("Password", tePassword,true,true),
                              Material(
                                color: Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: TextField(
                                    controller: _controller[3],
                                    autocorrect: true,
                                    obscureText: true,
                                    style: TextStyle(fontSize: 20),
                                    onChanged: (String value){
                                      tePassword = value;
                                    },
                                    decoration: new InputDecoration(
                                      hintText: "Password",
                                    ),
                                  ),
                                ),
                              ),
//                              getTextField("Cofirm Password", teConfirmPassword,true,true),
                              Material(
                                color: Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: TextField(
                                    controller: _controller[4],
                                    autocorrect: true,
                                    obscureText: true,
                                    style: TextStyle(fontSize: 20),
                                    onChanged: (String value){
                                      teConfirmPassword = value;
                                    },
                                    decoration: new InputDecoration(
                                      hintText: "Confirm Password",
                                    ),
                                  ),
                                ),
                              ),
//                              getTextField("10 Digit Mobile Number", teMobile,false,true),
                              Material(
                                color: Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: _controller[5],
                                    autocorrect: true,
                                    style: TextStyle(fontSize: 20),
                                    onChanged: (String value){
                                      teMobile = value;
                                    },
                                    decoration: new InputDecoration(
                                      hintText: "10 Digit Whatsapp Number",
                                    ),
                                  ),
                                ),
                              ),
                              new GestureDetector(
                                onTap: () async{
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                    return Opacity(child:Center(
                                      child: CircularProgressIndicator(),
                                    ),opacity:1);
                                  }));
                                  if(tePassword==teConfirmPassword){
                                    var dio = Dio();
                                    FormData formData = new FormData.fromMap({
                                      "email": teEmail,
                                      "firstname": first,
                                      "lastname": last,
                                      "password":tePassword,
                                      "phoneno": teMobile,
                                    });
                                    Response response;
                                    String url = 'http://amazekart.tech:8000/mainapp/registerapi/';
                                    response = await dio.post(url, data: formData );
                                    if(response.data.toString()=="[F]"){
                                      _showToast2(context);
                                    }
                                  }
                                  else{
                                    _showToast1(context);
                                  }
                                  Navigator.pop(context);
                                  Navigator.of(context).pop();

                                },
                                child: new Container(
                                  margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                  child: getAppBorderButton(
                                      "Add", EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),);
                    }
                );
//              _launchURL();
              },
              child: Text(
                "Create an Account",
                style: TextStyle(fontSize: 15.0),
              ),
            ),

          ],
        )
      ],
    );

  }

  _read() async {
    final prefs = await SharedPreferences.getInstance();
    final key1 = 'email';
    final key2 = 'pass';
    String email = await prefs.get(key1);
    String pass = await prefs.get(key2);
    this.m =  {"email":email,"pass":pass};
  }

  _save(String email,String password) async {
    final prefs = await SharedPreferences.getInstance();
    final key1 = 'email';
    final key2 = 'pass';
    prefs.setString(key1, email);
    prefs.setString(key2, password);
  }

//  Widget getTextField(
//      String inputBoxName, TextEditingController inputBoxController,bool isPass,bool c){
//    var loginBtn = new Material(
//      color: Colors.transparent,
//      child:Padding(
//        padding: const EdgeInsets.all(20.0),
//        child: new TextFormField(
//          style: TextStyle(fontSize: 20),
//          autocorrect: true,
//          obscureText: isPass,
//          controller: inputBoxController,
//          decoration: new InputDecoration(
//            hintText: inputBoxName,
//            suffixIcon: c? null:isPass? Icon(Icons.lock_outline):Icon(Icons.email),
//          ),
//        ),
//      )
//    );
//    return loginBtn;
//  }

  void _showToast(BuildContext context) {
    Toast.show("Authenticating User", context, gravity: Toast.BOTTOM);
  }

  void _showToast1(BuildContext context) {
    Toast.show("Wrong Credentials", context, gravity: Toast.BOTTOM);
  }
  void _showToast2(BuildContext context) {
    Toast.show("Already Exist", context, gravity: Toast.BOTTOM);
  }


  Widget roundedRectButton(
      String title, List<Color> gradient, bool isEndIconVisible,String email,String password,BuildContext context) {
    return Builder(builder: (BuildContext mContext) {
      return Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Stack(
          alignment: Alignment(1.0, 0.0),
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(mContext).size.width / 1.7,
              height: 60,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),side: BorderSide(width: 1,color: Colors.blueGrey)),
                gradient: LinearGradient(
                    colors: gradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
              ),
              child: MaterialButton(
                child: Text(title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
                onPressed: () async{
                  _showToast(context);
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                   return Opacity(child:Center(
                     child: CircularProgressIndicator(),
                   ),opacity:1);
                  }));
                  var dio = Dio();
                FormData formData = new FormData.fromMap({
                  "email": email,
                  "password": password,
                });
                Response response1;
                String url = 'http://amazekart.tech:8000/mainapp/loginapi/';
                response1 = await dio.post(url, data: formData );
                Navigator.pop(context);
                  if(response1.data.toString()!="[F]"){
                    _save(email, password);
                    Response response = await dio.get('http://amazekart.tech:8000/mainapp/productdatabase/?format=json');
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Page(response.data,response1.data)));
                  }
                  else{
                    _showToast1(context);
                  }
                },
                highlightColor: Colors.transparent,
                splashColor: Colors.red,
              ),
              padding: EdgeInsets.only(top: 16, bottom: 16),
            ),
          ],
        ),
      );
    });
  }
}


Widget getAppBorderButton(String buttonLabel, EdgeInsets margin) {
  var loginBtn = new Container(
      margin: margin,
      padding: EdgeInsets.all(8.0),
      alignment: FractionalOffset.center,
      decoration: new BoxDecoration(
        border: Border.all(color: Colors.deepOrangeAccent),
        borderRadius: new BorderRadius.all(const Radius.circular(6.0)),
      ),
      child: new Text(
        buttonLabel,
        style: new TextStyle(
          color: Colors.deepOrangeAccent,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.3,
        ),
      )
  );
  return loginBtn;
}



const List<Color> signInGradients = [
  Colors.transparent,
  Colors.transparent,
];