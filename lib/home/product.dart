import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
class ProductDetailPage extends StatefulWidget {
  Map m;
  ProductDetailPage(this.m);
  @override
  _ProductDetailPageState createState() => _ProductDetailPageState(m);
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with TickerProviderStateMixin {
  Map m;
  List<dynamic> links = [];
  _ProductDetailPageState(Map m){
    this.m = m;
    for(int i=0;i<m['images'].length;i++){
      links.add(m['images'][i]['imageurl']);
    }
  }

  List<Widget> _generalWidgets = List<Widget>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: 40.0,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
        title: Text(
          "PRODUCT DETAIL",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: _buildProductDetailsPage(context),
    );
  }

  _buildProductDetailsPage(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return ListView(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(4.0),
          child: Card(
            elevation: 4.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildProductImagesWidgets(),
                _buildProductTitleWidget(),
                SizedBox(height: 12.0),
                _buildPriceWidgets(),
                SizedBox(height: 12.0),
                _buildDivider(screenSize),
                SizedBox(height: 12.0),
                _buildFurtherInfoWidget(),
                SizedBox(height: 12.0),
                _buildDivider(screenSize),
                SizedBox(height: 12.0),
                _buildSizeChartWidgets(),
                SizedBox(height: 12.0),
                _buildDivider(screenSize),
                SizedBox(height: 12.0),
                _buildDetailsAndMaterialWidgets(),
                SizedBox(height: 12.0),
              ],
            ),
          ),
        ),
      ],
    );
  }
  List<Widget> getWidgets() {
    _generalWidgets.clear();
    for (int i = 0; i < links.length; i++) {
      _generalWidgets.add(Image.network(links[i]));
    }
    return _generalWidgets;
  }
  _buildDivider(Size screenSize) {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.grey[600],
          width: screenSize.width,
          height: 0.25,
        ),
      ],
    );
  }

  _buildProductImagesWidgets() {
    TabController imagesController = TabController(length: links.length, vsync: this);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: MediaQuery.of(context).size.height/2,
        child: Center(
          child: DefaultTabController(
            length: links.length,
            child: Stack(
              children: <Widget>[
                TabBarView(
                  controller: imagesController,
                  children: getWidgets(),
                ),

                Container(
                  alignment: FractionalOffset(0.5, 0.95),
                  child: TabPageSelector(
                    controller: imagesController,
                    selectedColor: Colors.grey,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildProductTitleWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Center(
        child: Text(
          //name,
          m['productname'],
          style: TextStyle(fontSize: 25.0, color: Colors.black),
        ),
      ),
    );
  }

  _buildPriceWidgets() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Center(
        child: Text(
          "₹ "+m['price'].toString(),
          style: TextStyle(fontSize: 20.0, color: Colors.black),
        ),
      ),
    );
  }

  _buildFurtherInfoWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.phone,
            color: Colors.grey[700],
          ),
          SizedBox(
            width: 5.0,
          ),
          FlatButton(
            onPressed: () async {
              String temp = m['productname'];
             FlutterOpenWhatsapp.sendSingleMessage("91"+m["user"]["phoneno"], "I'm interested in buying *$temp* which your are selling on AmazeKart");
            },
            child:Text(
              m["user"]["phoneno"],
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ),
          SizedBox(
            width: 5.0,
          ),
          Icon(
            Icons.keyboard_backspace,
            color: Colors.grey[700],
          ),
          Text("Click here",style: TextStyle(color: Colors.grey[700]),)
        ],
      ),
    );
  }

  _buildSizeChartWidgets() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.face,
                color: Colors.grey[700],
              ),
              SizedBox(
                width: 22.0,
              ),
              Text(
                m["user"]["firstname"]+" "+m["user"]["lastname"],
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildDetailsAndMaterialWidgets() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
            child: Text(
              "DETAILS",
              style: TextStyle(
                color: Colors.black,fontSize: 20
              ),
            ),
          ),
          SizedBox(height: 12.0),
          Container(
              child: Text(
                m['description'],
                style: TextStyle(
                  color: Colors.black,fontSize: 15
                ),
              ),
          ),
        ],
      ),
    );
  }


}