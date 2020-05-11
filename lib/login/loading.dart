import 'package:amazekart/main.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:io';
import 'package:toast/toast.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ColorLoader3 extends StatefulWidget {
  final double radius;
  final double dotRadius;

  ColorLoader3({this.radius = 30.0, this.dotRadius = 3.0});

  @override
  _ColorLoader3State createState() => _ColorLoader3State();
}

class _ColorLoader3State extends State<ColorLoader3>
    with SingleTickerProviderStateMixin {
  Animation<double> animation_rotation;
  Animation<double> animation_radius_in;
  Animation<double> animation_radius_out;
  AnimationController controller;
  bool isConnected=false;
  double radius;
  double dotRadius;
  Map<String,String> m;
  @override
  void initState() {
    super.initState();

    radius = widget.radius;
    dotRadius = widget.dotRadius;


    controller = AnimationController(
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: const Duration(milliseconds: 2000),
        vsync: this);

    animation_rotation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 1, curve: Curves.linear),
      ),
    );

    animation_radius_in = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.75, 1.0, curve: Curves.elasticIn),
      ),
    );

    animation_radius_out = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.25, curve: Curves.elasticOut),
      ),
    );

    controller.addListener(() {
      setState(() {
        if (controller.value >= 0.75 && controller.value <= 1.0)
          radius = widget.radius * animation_radius_in.value;
        else if (controller.value >= 0.0 && controller.value <= 0.25)
          radius = widget.radius * animation_radius_out.value;
      });
    });

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {}
    });
    check().then((internet){
      if(internet!=null && internet){
        delay();
        print("connected");
      }
      else{
        _showToast();
      }
    });
    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: <Widget>[
            Image.asset('assets/logo.png',height: MediaQuery.of(context).size.height/2,width: MediaQuery.of(context).size.width/1.5,),
            Container(
              width: 100.0,
              height: 100.0,
              child: new Center(
                child: new RotationTransition(

                  turns: animation_rotation,
                  child: new Container(
                    //color: Colors.limeAccent,
                    child: new Center(
                      child: Stack(
                        children: <Widget>[
                          new Transform.translate(
                            offset: Offset(0.0, 0.0),
                            child: Dot(
                              radius: radius,
                              color: Colors.black12,
                            ),
                          ),
                          new Transform.translate(
                            child: Dot(
                              radius: dotRadius,
                              color: Colors.amber,
                            ),
                            offset: Offset(
                              radius * cos(0.0),
                              radius * sin(0.0),
                            ),
                          ),
                          new Transform.translate(
                            child: Dot(
                              radius: dotRadius,
                              color: Colors.deepOrangeAccent,
                            ),
                            offset: Offset(
                              radius * cos(0.0 + 1 * pi / 4),
                              radius * sin(0.0 + 1 * pi / 4),
                            ),
                          ),
                          new Transform.translate(
                            child: Dot(
                              radius: dotRadius,
                              color: Colors.pinkAccent,
                            ),
                            offset: Offset(
                              radius * cos(0.0 + 2 * pi / 4),
                              radius * sin(0.0 + 2 * pi / 4),
                            ),
                          ),
                          new Transform.translate(
                            child: Dot(
                              radius: dotRadius,
                              color: Colors.purple,
                            ),
                            offset: Offset(
                              radius * cos(0.0 + 3 * pi / 4),
                              radius * sin(0.0 + 3 * pi / 4),
                            ),
                          ),
                          new Transform.translate(
                            child: Dot(
                              radius: dotRadius,
                              color: Colors.yellow,
                            ),
                            offset: Offset(
                              radius * cos(0.0 + 4 * pi / 4),
                              radius * sin(0.0 + 4 * pi / 4),
                            ),
                          ),
                          new Transform.translate(
                            child: Dot(
                              radius: dotRadius,
                              color: Colors.lightGreen,
                            ),
                            offset: Offset(
                              radius * cos(0.0 + 5 * pi / 4),
                              radius * sin(0.0 + 5 * pi / 4),
                            ),
                          ),
                          new Transform.translate(
                            child: Dot(
                              radius: dotRadius,
                              color: Colors.orangeAccent,
                            ),
                            offset: Offset(
                              radius * cos(0.0 + 6 * pi / 4),
                              radius * sin(0.0 + 6 * pi / 4),
                            ),
                          ),
                          new Transform.translate(
                            child: Dot(
                              radius: dotRadius,
                              color: Colors.blueAccent,
                            ),
                            offset: Offset(
                              radius * cos(0.0 + 7 * pi / 4),
                              radius * sin(0.0 + 7 * pi / 4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 80,),
            Text("Developed By:",style: TextStyle(fontWeight: FontWeight.bold),),
            Text("Sahil Jain"),
            Text("Vinayak Aggarwal"),
            Text("Rohan Prabhu"),
          ],
        ),
      ),
    );
  }
  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
  Future delay() async{
    _read();
    Future.delayed(const Duration(milliseconds: 4000), () {
      setState(() {
        print(m);
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) =>
                MyApp(m)));
      });
    });
  }
  void _showToast() {
    Toast.show("Check Internet Connection", context, duration: 10, gravity: Toast.BOTTOM);
  }
  @override
  void dispose() {

    controller.dispose();
    super.dispose();
  }
  Future<String> _read() async {
    String text;
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file1 = File('${directory.path}/temp.txt');
      final File file2 = File('${directory.path}/temp1.txt');
      var email = await file1.readAsString();
      var pass = await file2.readAsString();
      this.m =  {"email":email,"pass":pass};
    } catch (e) {
      print("Couldn't read file");
    }
    return text;
  }
}

class Dot extends StatelessWidget {
  final double radius;
  final Color color;

  Dot({this.radius, this.color});

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),

      ),
    );
  }
}