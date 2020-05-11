import 'package:flutter/material.dart';
import 'package:amazekart/login/background.dart';
import 'package:amazekart/login/loading.dart';
import 'package:amazekart/login/loginUi.dart';
void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  initialRoute: '/loading',
  routes: {
    '/loading': (context) => ColorLoader3(radius: 20,dotRadius: 6,),
  },
));
class MyApp extends StatelessWidget {
  Map<String,String> m;
  MyApp(this.m);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(m),
    );
  }
}

class MyHomePage extends StatefulWidget {
  Map<String,String> m;
  @override
  MyHomePage(this.m);

  @override
  _MyHomePageState createState() => _MyHomePageState(m);
}

class _MyHomePageState extends State<MyHomePage>{
  Map<String,String> m;
  _MyHomePageState(this.m);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Background(),
            Login(m),
          ],
        ));
  }
}
