// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'model/product.dart';
import 'model/products_repository.dart';
import 'favorite_hotels.dart';
import 'detail.dart';


class DrawerItem{
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class HomePage extends StatefulWidget {

  final drawerItems = [
    new DrawerItem("Home", Icons.home),
    new DrawerItem("Search", Icons.search),
    new DrawerItem("Favorite Hotel", Icons.location_city),
    new DrawerItem("Ranking", Icons.insert_chart),
    new DrawerItem("My Page", Icons.person),
  ];



  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage>{

  int _selectedDrawerIndex = 5;


  _onSelectItem(int index){
    if(index==2){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Favorite_HotelsPage()),
      );
    }else{
      Navigator.pushNamed(context, '/$index');
    }

  }


  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];

    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
          new ListTile(
            leading: new Icon(d.icon),
            title: new Text(d.title),
            selected: i == _selectedDrawerIndex,
            onTap: () => _onSelectItem(i),
          )
      );
    }

    return Scaffold(
      // TODO: Add app bar (102)
      appBar: AppBar(
        title: Center(
          child:
          Text(
              'Main',
            style: TextStyle(color: Colors.white,),
          ),
        ),

        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              semanticLabel: 'search',
            ),
            onPressed: (){
              Navigator.pushNamed(context, '/1');
            },
          ),
          IconButton(
            icon: Icon(
              Icons.tune,
              semanticLabel: 'filter',
            ),
            onPressed: (){
              Navigator.pushNamed(context, '/language');
            },
          )
        ],
      ),
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(
                accountName: new Text("Page"), accountEmail: null),
            new Column(children: drawerOptions)
          ],
        ),
      ),
      // TODO: Add a grid view (102)
      body:
        OrientationBuilder(builder: (context, orientation) {
          return GridView.count(
            crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
            padding: EdgeInsets.fromLTRB(16.0, 30.0, 16.0, 8.0),
            childAspectRatio: 8.0/9.0,
            children: _buildGridCards(context),
          );
        })
    );
  }
}


List<Card> _buildGridCards(BuildContext context) {
  List<Product> products = ProductsRepository.loadProducts(Category.all);

  if( products == null || products.isEmpty){
    return const <Card>[];
  }



  final ThemeData theme = Theme.of(context);


  return products.map((product) {
    return Card(
      elevation: 3.0,
      child : Column (
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          AspectRatio(
            aspectRatio: 18/12,
            child: InkWell(
              child:
              Hero(
                tag: product.name,
                child:
                Image.asset(
                    product.assetName,
                    package: product.assetPackage,
                    fit:BoxFit.fitWidth,
                ),
              ),
              onTap: () => print('product id = ${product.name}')
            ),
          ),
          Expanded(

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children:<Widget>[
                Text(
                        product == null ? '' : product.name,
                        style: theme.textTheme.button,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines:1,
                ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      Container(
                        child:
                        Icon(
                          Icons.location_on,
                          semanticLabel: 'location',
                          size:15.0,
                          color:Colors.blue,
                        ),
                      ),
                      Text(
                      product == null ? '' : product.location,
                      style:theme.textTheme.caption,
                      maxLines:1,
                      ),
                    ]
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        child :
                            FlatButton(
                              child: Text(
                                'more',
                                  style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  fontSize: 10.0
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => DetailPage(index:product.id, name:product.name, location:product.location, rating:product.rating)),
                                );
                              },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),

                      )
                    ],
                  )
                ],
              ),

          ),
        ],
      ),
    );
  }).toList();
}


