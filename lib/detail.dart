import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/product.dart';
import 'model/products_repository.dart';
import 'home.dart';




SharedPreferences prefs;

class DetailPage extends StatefulWidget {



  final int index;
  final String name;
  final String location;
  final int rating;

  DetailPage({Key key, this.index, this.name, this.location, this.rating}) : super(key: key);
  @override
  _DetailPageState createState() => _DetailPageState();
}



class _DetailPageState extends State<DetailPage>{

  bool _isFavorited = false;
  List<String> FavList;
  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((SharedPreferences sp) {
      prefs = sp;
      _isFavorited = prefs.getBool(widget.name);
      // will be null if never previously saved
      if (_isFavorited == null) {
        _isFavorited = false;
        persist(); // set an initial value
      }

      FavList = prefs.getStringList('FavList');

      if(FavList == null){
        FavList =[];
        persist_list();
      }

    });
  }

  void persist() {
    setState(() {
      _isFavorited = false;
    });
    prefs?.setBool(widget.name, false);
  }

  void persist_list(){
    setState((){
      FavList.add('None');
    });
    prefs?.setStringList('FavList', FavList);
  }

  _fillh() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(widget.name, true);
  }

  _emptyh() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(widget.name, false);
  }

  _addList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    FavList = prefs.getStringList('FavList');
    setState(() {
      FavList.add(widget.name);
    });
  prefs.setStringList('FavList', FavList);
}

  _removeList() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    FavList = prefs.getStringList('FavList');
    setState(() {
      FavList.remove(widget.name);
    });
    prefs.setStringList('FavList', FavList);
  }



  void _toggleFavorite(){
    setState((){
      if(_isFavorited){
        _isFavorited = false;
        _emptyh();
        _removeList();
      }else{
        _isFavorited = true;
        _fillh();
        _addList();
      }
    });
  }

  List<Product> products = ProductsRepository.loadProducts(Category.all);
  @override
  Widget build(BuildContext context) {


    final title = 'Detail';


    List<Icon> starList(int num){

      List<Icon> temp = [];

      for(var i=1; i <= num; i++){
        temp.add(
          Icon(Icons.star, color:Colors.yellow)
        );
      }

      return temp;
    }

    Widget titleSection = Container(
      padding: const EdgeInsets.all(32.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: starList(widget.rating)
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    widget.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children:[
                    Icon(
                      Icons.location_on,
                      color: Colors.blue[500],
                    ),
                Text(
                  widget.location,
                  style: TextStyle(
                    color: Colors.blue[500],
                      ),
                    ),
                  ],
                ),
                Row(
                  children:[
                    Icon(
                      Icons.local_phone,
                      color: Colors.blue[500],
                    ),
                    Text(
                      '+48 22 102 4500',
                      style: TextStyle(
                        color: Colors.blue[500],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

        ],
      ),
    );



    Widget textSection = Container(
      padding: const EdgeInsets.all(32.0),
      child: Text(
        '''
Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.
        ''',
        softWrap: true,
        style:TextStyle(
        color:Colors.blue
        ),
      ),
    );

    return
        MaterialApp(
      title: title,

      home: Hero(
        tag: widget.name,
        child:Scaffold(
        appBar: AppBar(
          title: Text(title),
          leading:
          IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: (){
              if(_isFavorited){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              }else{
                Navigator.pop(context);
              }
            },
          ),

        ),
    body:
        ListView(
          children: [
            Stack(
                children:<Widget>[
                  new Container(
                    child: InkWell(
            child:Image.asset(
                products[widget.index].assetName,
                package: products[widget.index].assetPackage,
              ),
                      onTap:() => print(widget.name)
        )


                  ),

                  new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child:IconButton(
                            icon:( _isFavorited ? Icon(
                              Icons.favorite,
                              color: Colors.red[400],
                            ) : Icon(
                              Icons.favorite_border,
                              color: Colors.red[400],
                            )),
                            onPressed:(){
                              _toggleFavorite();
                            }
                        ),
                      ),
                    ],
                  )
                ]
            ),

            titleSection,
            Divider(height:3.0,indent:3.0),
            textSection,
          ],
        ),


          ),
        ),
        );
  }
}