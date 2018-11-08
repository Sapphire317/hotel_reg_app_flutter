import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'detail.dart';
import 'home.dart';



class Favorite_HotelsPage extends StatefulWidget {



  @override
  Favorite_HotelsState createState() {
    return Favorite_HotelsState();
  }
}

class Favorite_HotelsState extends State<Favorite_HotelsPage>{

  List<String> items = [];

  _loadList() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState((){
      items = prefs.getStringList('FavList');
    });
  }
  _saveList(List<String> list) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState((){
      prefs.setStringList('FavList', list);
    });
  }

  void initState() {
    super.initState();
    _loadList();
  }
  @override
  Widget build(BuildContext context) {

    final title = 'Favorite Hotels';


    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
          leading:
          IconButton(
            icon: Icon(
              Icons.arrow_back,

            ),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),

        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];

            return Dismissible(
              // Each Dismissible must contain a Key. Keys allow Flutter to
              // uniquely identify Widgets.
              key: Key(item),
              // We also need to provide a function that tells our app
              // what to do after an item has been swiped away.
              onDismissed: (direction) {
                // Remove the item from our data source.
                setState(() {
                  items.removeAt(index);
                  _saveList(items);
                });

              },
              // Show a red background as the item is swiped away
              background: Container(color: Colors.red),
              child: ListTile(title: Text('$item')),
            );
          },
        ),
      ),
    );
  }
  }
