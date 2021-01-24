import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Focus Up',
      home: MyHomePage(title: '집중해'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {

  // final _timenumList = [for(int i=1; i<=59; i++) i];
  var _timeLimitH = 1, _timeLimitM = 0, _durationTime = 5;
  final _durationUnitList = ["초", "분"];
  var _durationUnit = "분";
  var selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Icon(Icons.menu),
        title: Text(widget.title),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        color: Colors.blue,
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(200.0),
            ),
            elevation: 0.0,
            child: Container(
              width: 350,
              height: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("알람 시간"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      time_limit_Hpicker(),
                      Text(":", style: TextStyle(fontSize: 40, color: Colors.blue),),
                      time_limit_Mpicker(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("반복 시간"),
                      Row(
                        children: <Widget>[
                          durationTime_picker(),
                          customRadio(_durationUnitList[0],0),
                          customRadio(_durationUnitList[1],1),
                        ],
                      ),
                    ],
                  ),
                  Text("$_timeLimitH:$_timeLimitM , $_durationTime$_durationUnit"),
                  SizedBox(
                      width: 100,
                      height: 100,
                      child: RaisedButton(
                          child: Text('시작'),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(200.0),
                          ),
                          color: Colors.blue,
                          elevation: 0.0,
                          onPressed: () {}
                      )
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget time_limit_Hpicker(){
    return NumberPicker.integer(
        initialValue: _timeLimitH,
        minValue: 0,
        maxValue: 12,
        selectedTextStyle: TextStyle(fontSize: 45, color: Colors.blue),
        textStyle: TextStyle(fontSize: 16, color: Colors.black),
        listViewWidth: 80,
        zeroPad: false,
        onChanged: (newValue) => setState(() => _timeLimitH = newValue));
  }
  Widget time_limit_Mpicker(){
    return NumberPicker.integer(
        initialValue: _timeLimitM,
        minValue: 0,
        maxValue: 59,
        step: 10,
        selectedTextStyle: TextStyle(fontSize: 45, color: Colors.blue),
        textStyle: TextStyle(fontSize: 16, color: Colors.black),
        listViewWidth: 80,
        zeroPad: true,
        onChanged: (newValue) => setState(() => _timeLimitM = newValue));
  }
  Widget durationTime_picker(){
    return NumberPicker.integer(
        initialValue: _durationTime,
        minValue: 5,
        maxValue: 60,
        step: 5,
        selectedTextStyle: TextStyle(fontSize: 26, color: Colors.black),
        textStyle: TextStyle(fontSize: 16, color: Colors.black),
        listViewWidth: 50,
        zeroPad: false,
        onChanged: (newValue) => setState(() => _durationTime = newValue));
  }

  Widget customRadio(String txt,int index){
    return FlatButton(
      minWidth: 20,
      onPressed: () => changeIndex(index),
      color: Colors.transparent,
      splashColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Text(txt,style: TextStyle(fontSize: selectedIndex == index? 18 : 16, color: selectedIndex == index? Colors.blue : Colors.grey),),
    );
  }

  void changeIndex(int index){
    setState(() {
      selectedIndex = index;
      _durationUnit = _durationUnitList[index];
    });
  }


}
