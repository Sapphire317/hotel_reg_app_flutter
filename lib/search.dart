

import 'package:flutter/material.dart';
import 'dart:async';

@visibleForTesting
enum Location {
  Seoul,
  Daegu,
  Busan
}

enum Room {
  Single,
  Double,
  Family
}

enum Star{
  One,
  Two,
  Three,
  Four,
  Five
}


Widget buildStars(){
  Icon icon;
  icon = Icon(Icons.star, color: Colors.yellow);
  return icon;
}


typedef DemoItemBodyBuilder<T> = Widget Function(DemoItem<T> item);
typedef ValueToString<T> = String Function(T value);

class DualHeaderWithHint extends StatelessWidget {
  const DualHeaderWithHint({
    this.name,
    this.value,
    this.hint,
    this.showHint
  });

  final String name;
  final String value;
  final String hint;
  final bool showHint;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;

    return Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.only(left: 24.0),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  name,
                  style: textTheme.body1.copyWith(fontSize: 15.0),
                ),
              ),
            ),
          ),
          Expanded(
              flex: 3,
              child: Container(
                  margin: const EdgeInsets.only(left: 24.0),
                  child:
                      Text(hint, style: textTheme.caption.copyWith(fontSize: 15.0)),

              )
          )
        ]
    );
  }
}

//class CollapsibleBody extends StatelessWidget {
//  const CollapsibleBody({
//    this.margin = EdgeInsets.zero,
//    this.child,
//    this.onSave,
//    this.onCancel
//  });
//
//  final EdgeInsets margin;
//  final Widget child;
//  final VoidCallback onSave;
//  final VoidCallback onCancel;
//
//  @override
//  Widget build(BuildContext context) {
//    final ThemeData theme = Theme.of(context);
//    final TextTheme textTheme = theme.textTheme;
//
//    return Column(
//        children: <Widget>[
//          Container(
//              margin: const EdgeInsets.only(
//                  left: 24.0,
//                  right: 24.0,
//                  bottom: 24.0
//              ) - margin,
//              child: Center(
//                  child: DefaultTextStyle(
//                      style: textTheme.caption.copyWith(fontSize: 15.0),
//                      child: child
//                  )
//              )
//          ),
//          const Divider(height: 1.0),
//          Container(
//              padding: const EdgeInsets.symmetric(vertical: 16.0),
//              child: Row(
//                  mainAxisAlignment: MainAxisAlignment.end,
//                  children: <Widget>[
//                    Container(
//                        margin: const EdgeInsets.only(right: 8.0),
//                        child: FlatButton(
//                            onPressed: onCancel,
//                            child: const Text('CANCEL', style: TextStyle(
//                                color: Colors.black54,
//                                fontSize: 15.0,
//                                fontWeight: FontWeight.w500
//                            ))
//                        )
//                    ),
//                    Container(
//                        margin: const EdgeInsets.only(right: 8.0),
//                        child: FlatButton(
//                            onPressed: onSave,
//                            textTheme: ButtonTextTheme.accent,
//                            child: const Text('SAVE')
//                        )
//                    )
//                  ]
//              )
//          )
//        ]
//    );
//  }
//}

class DemoItem<T> {
  DemoItem({
    this.name,
    this.value,
    this.hint,
    this.builder,
    this.valueToString
  }) : textController = TextEditingController(text: valueToString(value));

  final String name;
  final String hint;
  final TextEditingController textController;
  final DemoItemBodyBuilder<T> builder;
  final ValueToString<T> valueToString;
  T value;
  bool isExpanded = false;

  ExpansionPanelHeaderBuilder get headerBuilder {
    return (BuildContext context, bool isExpanded) {
      return DualHeaderWithHint(
          name: name,
          value: valueToString(value),
          hint: hint,
          showHint: isExpanded
      );
    };
  }

  Widget build() => builder(this);
}

class ExpansionPanelsDemo extends StatefulWidget {
  static const String routeName = '/material/expansion_panels';



  @override
  _ExpansionPanelsDemoState createState() => _ExpansionPanelsDemoState();
}

class _ExpansionPanelsDemoState extends State<ExpansionPanelsDemo> {
  List<DemoItem<dynamic>> _demoItems;

  //Location
  String selectedLocation;

  //Room
  String selectedRoom;

  //Class
  bool star_1 = false;
  bool star_2 = false;
  bool star_3 = false;
  bool star_4 = false;
  bool star_5 = false;

  List<int> selectedStar = [];

  //Time&Date
  bool isDateVisible = true;
  String checkInDate;
  String checkOutDate;
  String checkInTime;
  String checkOutTime;
  bool ischeckIndatePicked = false;
  bool ischeckIntimePicked = false;
  bool ischeckOutdatePicked = false;
  bool ischeckOuttimePicked = false;
  DateTime _date = new DateTime.now();
  TimeOfDay _time = new TimeOfDay.now();


  //Fee
  double val = 50.0;




  void changeLocate(String location){
    setState(() {
      selectedLocation = location;
    });
  }

  void changeRoom(String room){
    setState(() {
      selectedRoom = room;
    });
  }

  Widget showLocate(){
    if(selectedLocation!=null){
      return Text(selectedLocation);
    }else{
      return Text('Not Selected');
    }
  }

  Widget showRoom(){
    if(selectedRoom!=null){
      return Text(selectedRoom);
    }else{
      return Text('Not Selected');
    }
  }


  List<Icon> starList(int num){

    List<Icon> temp = [];

    for(var i=1; i <= num; i++){
      temp.add(
          Icon(Icons.star, color:Colors.yellow)
      );
    }

    return temp;
  }


  Widget showStar(){

    List<Widget> classList = [];

    selectedStar.forEach((data){
      if((selectedStar.indexOf(data)+1) == selectedStar.length){
        classList.add(Row(children:starList(data)));
      }else{
        classList.add(Row(children:starList(data)));
        classList.add(Text('/'));
      }
    });



    if(selectedStar.isEmpty){
      return Text('Not Selected');
    }else{
      return Row(
        children: classList,
      );
    }
  }

  Widget showFee(){
    return Text('\$$val');
  }


  void addStar(int num){
    if(selectedStar.indexOf(num) < 0){
      setState((){
        selectedStar.add(num);
      });
    }else{
      setState(() {
        selectedStar.remove(num);
      });
    }
  }


  Future<Null> _selectDate(BuildContext context, int inOut) async{
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2019),
    );

    if(picked!= null && picked != _date){
      print('Date selected: ${_date.toString()}');
      setState((){
        if(inOut ==0){//if it is check-in,
          ischeckIndatePicked = true;
          _date = picked;
          checkInDate = _date.toString();
          checkInDate = checkInDate.substring(0,10);
        }else{ //if it is check-out
          ischeckOutdatePicked = true;
          _date = picked;
          checkOutDate = _date.toString();
          checkOutDate = checkOutDate.substring(0,10);
        }
      });
    }
  }

  Future<Null> _selectTime(BuildContext context, int inOut) async{
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );

    if(picked != null && picked != _time){
      print('Time selected: ${_time.toString()}');
      setState((){
        if(inOut ==0){//if it is check-in,
          ischeckIntimePicked = true;
          _time = picked;
          checkInTime = _time.toString();
          checkInTime = checkInTime.substring(10,15);
        }else{ //if it is check-out
          ischeckOuttimePicked = true;
          _time = picked;
          checkOutTime = _time.toString();
          checkOutTime = checkOutTime.substring(10,15);
        }
      });
    }
  }

  Widget DialogSection(){
    return Container(
      padding: new EdgeInsets.all(10.0),
      width: 500.0,
      height: 300.0,
      child:Center(
          child:Column(
            children: <Widget>[
              Container(
                padding: new EdgeInsets.all(5.0),
                child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.location_on, color: Colors.blue,),
                  showLocate(),
                ],
              ),
              ),
        Container(
          padding: new EdgeInsets.all(5.0),
          child:
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.credit_card, color: Colors.blue,),
                  showRoom(),
                ],
              ),
        ),
        Container(
          padding: new EdgeInsets.all(5.0),
          child:
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.star, color: Colors.blue,),
                  showStar(),
                ],
              ),
        ),
        Container(
          padding: new EdgeInsets.all(5.0),
          child:
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.calendar_today, color: Colors.blue,),
                  Column(children: <Widget>[
                    Row(children: <Widget>[
                      Text('In', style:TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold)),
                      showPickedDate(0),
                      showPickedTime(0)
                    ],),
                    Row(
                      children: <Widget>[
                        Text('Out', style:TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold)),
                        showPickedDate(1),
                        showPickedTime(1)
                      ],
                    ),
                  ],
                  ),

                ],
              ),
        ),
             ]
              )
              }
            ],
          )
      )
    );
  }
  Widget TitleSection(){
    return Container(
      color:Colors.blue,
      child: Center(child:Text("Please check your choice:)", style:TextStyle(color:Colors.white, fontSize: 15.0))),
      height: 100.0,
    );
  }

  void search(){
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: TitleSection(),
          titlePadding: new EdgeInsets.all(0.0),
          content: DialogSection(),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget showPickedDate(int num) {
    if(num == 0 && ischeckIndatePicked){
      return Text(checkInDate);
    }else if(num == 1 && ischeckOutdatePicked){
      return Text(checkOutDate);
    }else{
      return Text('');
    }
  }

  Widget showPickedTime(int num) {
    if(num == 0 && ischeckIntimePicked){
      return Text(checkInTime);
    }else if( num ==1 && ischeckOuttimePicked){
      return Text(checkOutTime);
    }else{
      return Text('');
    }
  }



  @override
  void initState() {
    super.initState();

    _demoItems = <DemoItem<dynamic>>[

      DemoItem<Location>(
          name: 'Location',
          value: Location.Daegu,
          hint: 'Select location',
          valueToString: (Location location) => location.toString().split('.')[1],
          builder: (DemoItem<Location> item) {
            return Form(
                child: Builder(
                    builder: (BuildContext context) {
                      return FormField<Location>(
                            initialValue: item.value,
                            onSaved: (Location result) { item.value = result; },
                            builder: (FormFieldState<Location> field) {
                              return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    RadioListTile<Location>(
                                      value: Location.Daegu,
                                      title: const Text('Daegu'),
                                      groupValue: field.value,
                                      onChanged: (Location newValue){
                                        field.didChange(newValue);
                                        setState((){
                                          selectedLocation = field.value.toString();
                                          selectedLocation = selectedLocation.substring(9,14);
                                        });
                                      },
                                    ),
                                    RadioListTile<Location>(
                                      value: Location.Seoul,
                                      title: const Text('Seoul'),
                                      groupValue: field.value,
                                      onChanged: (Location newValue){
                                        field.didChange(newValue);
                                        setState((){
                                          selectedLocation = field.value.toString();
                                          selectedLocation = selectedLocation.substring(9,14);
                                        });
                                      },
                                    ),
                                    RadioListTile<Location>(
                                      value: Location.Busan,
                                      title: const Text('Busan'),
                                      groupValue: field.value,
                                      onChanged: (Location newValue){
                                        field.didChange(newValue);
                                        setState((){
                                          selectedLocation = field.value.toString();
                                          selectedLocation = selectedLocation.substring(9,14);
                                        });
                                      },
                                    ),
                                  ]
                              );
                            }
                        );

                    }
                )
            );
          }
      ),
      DemoItem<Room>(
          name: 'Room',
          value: Room.Single,
          hint: 'Select room',
          valueToString: (Room room) => room.toString().split('.')[1],
          builder: (DemoItem<Room> item) {
            return Form(
                child: Builder(
                    builder: (BuildContext context) {
                      return  FormField<Room>(
                            initialValue: item.value,
                            onSaved: (Room result) { item.value = result; },
                            builder: (FormFieldState<Room> field) {
                              return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    RadioListTile<Room>(
                                      value: Room.Single,
                                      title: const Text('Single'),
                                      groupValue: field.value,
                                      onChanged: (Room newValue){
                                        field.didChange(newValue);
                                        setState((){
                                          selectedRoom = field.value.toString();
                                          selectedRoom = selectedRoom.substring(5,11);
                                        });
                                      },
                                    ),
                                    RadioListTile<Room>(
                                      value: Room.Double,
                                      title: const Text('Double'),
                                      groupValue: field.value,
                                      onChanged: (Room newValue){
                                        field.didChange(newValue);
                                        setState((){
                                          selectedRoom = field.value.toString();
                                          selectedRoom = selectedRoom.substring(5,11);
                                        });
                                      },
                                    ),
                                    RadioListTile<Room>(
                                      value: Room.Family,
                                      title: const Text('Family'),
                                      groupValue: field.value,
                                      onChanged: (Room newValue){
                                        field.didChange(newValue);
                                        setState((){
                                          selectedRoom = field.value.toString();
                                          selectedRoom = selectedRoom.substring(5,11);
                                        });
                                      },
                                    ),
                                  ]
                              );
                            }
                        );

                    }
                )
            );
          }
      ),
      DemoItem<Star>(
          name: 'Class',
          value: Star.One,
          hint: 'Select class',
          valueToString: (Star star) => star.toString().split('.')[1],
          builder: (DemoItem<Star> item) {
            return Form(
                child: Builder(
                    builder: (BuildContext context) {
                      return  FormField<Star>(
                            initialValue: item.value,
                            onSaved: (Star result) { item.value = result; },
                            builder: (FormFieldState<Star> field) {
                              return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children:[
                                        Checkbox(
                                          value: star_1,
                                          onChanged: (bool newValue) {
                                            setState(() {
                                              star_1 = newValue;
                                            });
                                            addStar(1);
                                          },
                                       ),
                                        Row(
                                          children: new List.generate(1, (index) => buildStars())
                                        )
                                      ]
                                    ),
                                    Row(
                                        children:[
                                          Checkbox(
                                            value: star_2,
                                            onChanged: (bool newValue) {
                                              setState(() {
                                                star_2 = newValue;
                                              });
                                              addStar(2);
                                            },
                                          ),
                                          Row(
                                              children: new List.generate(2, (index) => buildStars())
                                          )
                                        ]
                                    ),
                                    Row(
                                        children:[
                                          Checkbox(
                                            value: star_3,
                                            onChanged: (bool newValue) {
                                              setState(() {
                                                star_3 = newValue;
                                              });
                                              addStar(3);
                                            },
                                          ),
                                          Row(
                                              children: new List.generate(3, (index) => buildStars())
                                          )
                                        ]
                                    ),
                                    Row(
                                        children:[
                                          Checkbox(
                                            value: star_4,
                                            onChanged: (bool newValue) {
                                              setState(() {
                                                star_4 = newValue;
                                              });
                                              addStar(4);
                                            },
                                          ),
                                          Row(
                                              children: new List.generate(4, (index) => buildStars())
                                          )
                                        ]
                                    ),
                                    Row(
                                        children:[
                                          Checkbox(
                                            value: star_5,
                                            onChanged: (bool newValue) {
                                              setState(() {
                                                star_5 = newValue;
                                              });
                                              addStar(5);
                                            },
                                          ),
                                          Row(
                                              children: new List.generate(5, (index) => buildStars())
                                          )
                                        ]
                                    ),
                                  ]
                              );
                            }
                        );
                    }
                )
            );
          }
      ),
    ];
  }



  @override
  Widget build(BuildContext context) {

    Widget DateRow(){
      return Container(
        child:
        Row(
            children: <Widget>[
              Expanded(
                flex:2,
                child: Container(
                  margin: const EdgeInsets.only(left: 24.0),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Date',style:TextStyle(fontWeight: FontWeight.bold, fontSize:15.0),

                    ),
                  ),
                ),
              ),
              Expanded(
              flex: 3,
                  child: Container(
                      margin: const EdgeInsets.only(left: 24.0),
                      child:Row(
                        children: <Widget>[
                          Text("I don't have specific dates yet",
                              style: new TextStyle(fontSize: 10.0)),
                          Switch(
                            value: isDateVisible,
                            onChanged: (bool newValue) {
                              setState(() {
                                isDateVisible= newValue;
                              });
                            },
                          )
                        ],
                      )
                  )
              )
            ]
        )
      );
    }



    Widget DateSection(){
      if(!isDateVisible){
        return Container(
            child:Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: new EdgeInsets.all(15.0),
                      child:
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('check-in',style:TextStyle(fontWeight: FontWeight.bold, fontSize:15.0),),
                          showPickedDate(0),
                          showPickedTime(0),
                        ],
                      ),
                    ),
                    Padding(
                      padding: new EdgeInsets.only(left : 150.0),
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new MaterialButton(
                            height: 20.0,
                            child: const Text('select date'),
                            color: Theme.of(context).accentColor,
                            elevation: 4.0,
                            splashColor: Colors.blueGrey,
                            onPressed: () {
                              _selectDate(context,0);
                            },
                          ),
                          new MaterialButton(
                            height: 20.0,
                            child: const Text('select time'),
                            color: Theme.of(context).accentColor,
                            elevation: 4.0,
                            splashColor: Colors.blueGrey,
                            onPressed: () {
                              _selectTime(context,0);
                            },
                          ),
                        ],
                      ),
                    )

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: new EdgeInsets.all(15.0),
                      child:
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('check-out', style:TextStyle(fontWeight: FontWeight.bold, fontSize:15.0),),
                          showPickedDate(1),
                          showPickedTime(1),
                        ],
                      ),
                    ),
                    Padding(
                      padding: new EdgeInsets.only(left : 140.0),
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new MaterialButton(
                            height: 20.0,
                            minWidth: 10.0,
                            child: const Text('select date'),
                            color: Theme.of(context).accentColor,
                            elevation: 4.0,
                            splashColor: Colors.blueGrey,
                            onPressed: () {
                              _selectDate(context,1);
                            },
                          ),
                          new MaterialButton(
                            height: 20.0,
                            child: const Text('select time'),
                            color: Theme.of(context).accentColor,
                            elevation: 4.0,
                            splashColor: Colors.blueGrey,
                            onPressed: () {
                              _selectTime(context,1);
                            },
                          ),
                        ],
                      ),
                    )

                  ],
                ),
              ],
            )
        );
      }else{
        return Container();
      }

    }

    Widget FeeSection(){

      void changed(e){
        setState((){
          val = e;
        });
      }



      return Container(
          child:
              Column(
                children: <Widget>[
                  Row(
                      children: <Widget>[
                        Expanded(
                          flex:2,
                          child: Container(
                            margin: const EdgeInsets.only(left: 24.0),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Fee',style:TextStyle(fontWeight: FontWeight.bold, fontSize:15.0),

                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 3,
                            child: Container(
                                margin: const EdgeInsets.only(left: 24.0),
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text('Up to \$$val')
                                  ],
                                )
                            )
                        )
                      ]
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:<Widget>[
                      Slider(
                        min: 0.0,
                        max: 150.0,
                        divisions: 10,
                        activeColor: Colors.orange[100 + (1 * 5.0).round()],
                        label: 'Fee Slider',
                        value: val,
                        onChanged: (double e) => changed(e)
                      ),
                    ]
                  )
                ],
              ),

      );
    }


    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children:[
            SafeArea(
          top: false,
          bottom: false,
          child: Container(
            margin: const EdgeInsets.all(24.0),
            child: ExpansionPanelList(
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    _demoItems[index].isExpanded = !isExpanded;
                  });
                },
                children: _demoItems.map<ExpansionPanel>((DemoItem<dynamic> item) {
                  return ExpansionPanel(
                      isExpanded: item.isExpanded,
                      headerBuilder: item.headerBuilder,
                      body: item.build()
                  );
                }).toList()
            ),

          ),
        ),
        Divider(height: 1.0,),
        SafeArea(
          top: false,
          bottom: false,
          child:Container(
            margin: const EdgeInsets.all(14.0),
          child: Center(
            child:Column(
                children:[
                  DateRow(),
                  DateSection()
                ]
          )
         )
        )
        ),
            Divider(height: 1.0,),
            SafeArea(
              top:false,
              bottom:false,
              child:Container(
                margin: const EdgeInsets.all(14.0),
                child: Center(
                  child:Column(
                    children: <Widget>[
                      FeeSection()
                    ],
                  )
                )
              )
            ),
            Divider(height:1.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new RaisedButton(
                  onPressed: search,
                  textColor: Colors.white,
                  color: Colors.blue,
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(
                    "Search",
                  ),
                ),
              ],
            )
        ],
      ),
      ),
    );
  }
}


