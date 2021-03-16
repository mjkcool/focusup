import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:google_fonts/google_fonts.dart';
// https://fonts.google.com/specimen/Chakra+Petch?preview.text=6:57&preview.text_type=custom&category=Serif,Sans+Serif,Display,Monospace&sidebar.open=true&selection.family=Chakra+Petch:wght@600


var _title = 'Focus Up';
var _appbarTitle = '집중해';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyHomePage(title: _appbarTitle),
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

  int _timeLimitH = 1, _timeLimitM = 0, _durationTime = 5;
  final _durationUnitList = ["초", "분"];
  String _durationUnit = "분";
  int selectedIndex = 1, _touchNumForClose = 200;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Icon(Icons.menu),
        title: Text(widget.title),
        backgroundColor: Colors.blue,
        elevation: 0.0,
      ),
      body: Center(
        child: Container(
          color: Colors.blue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                  children: <Widget>[
                    SizedBox(height: 50,),
                    Text("알람 시간", style: TextStyle(fontSize: 30),),
                    SizedBox(height: 40,),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.all(
                            Radius.circular(200) //                 <--- border radius here
                        ),
                      ),
                      width: 250, height: 250,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          time_limit_Hpicker(),
                          Text(":", style: TextStyle(fontSize: 40, color: Colors.white),),
                          time_limit_Mpicker(),
                        ],
                      ),
                    ),
                  ]
              ),
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("반복 시간", style: TextStyle(fontSize: 20),),
                      SizedBox(width: 30),
                      durationTime_picker(),
                      Row(
                        children: <Widget>[
                          customRadio(_durationUnitList[0],0),
                          customRadio(_durationUnitList[1],1),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 40,),
                  FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                      side: BorderSide(color: Colors.white),
                    ),
                    color: Colors.transparent,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(14.0),
                    onPressed: _showDialog,
                    child: Text(
                      '시작',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 60,),
                ],
              ),
            ],
          ),
        )
      ),
    );
  }

  Widget time_limit_Hpicker(){
    return NumberPicker.integer(
        initialValue: _timeLimitH,
        minValue: 0,
        maxValue: 11,
        selectedTextStyle: TextStyle(fontSize: 45, color: Colors.white),
        textStyle: TextStyle(fontSize: 25, color: Colors.white38),
        listViewWidth: 80,
        zeroPad: false,
        onChanged: (newValue) => setState(() => _timeLimitH = newValue)
      );
  }

  Widget time_limit_Mpicker(){
    return NumberPicker.integer(
        initialValue: _timeLimitM,
        minValue: 0,
        maxValue: 59,
        step: 10,
        selectedTextStyle: TextStyle(fontSize: 45, color: Colors.white),
        textStyle: TextStyle(fontSize: 25, color: Colors.white38),
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
        selectedTextStyle: TextStyle(fontSize: 26, color: Colors.white),
        textStyle: TextStyle(fontSize: 16, color: Colors.white38),
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
      child: Text(txt,style: TextStyle(fontSize: selectedIndex == index? 18 : 16, color: selectedIndex == index? Colors.white : Colors.white38),),
    );
  }

  void changeIndex(int index){
    setState(() {
      selectedIndex = index;
      _durationUnit = _durationUnitList[index];
    });
  }

  void showprint(){
    print("실행");
  }

  void _showDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          titlePadding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 15.0),
          contentPadding: EdgeInsets.fromLTRB(30.0, 0, 30.0, 5.0),
          actionsPadding: EdgeInsets.fromLTRB(0, 0, 5.0, 5.0),
          title: Text("$_timeLimitH시간 $_timeLimitM분 동안 $_durationTime$_durationUnit마다 알람"),
          content: SingleChildScrollView(
            child: Text("알람을 시작하겠습니까? $_touchNumForClose회 터치해야 강제종료됩니다.")
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("시작"),
              onPressed: () {
                int durationTime, timeLimit = _timeLimitM + _timeLimitH*60; //분단위
                int raw_durationTime = _durationTime;
                if(_durationUnit=='초') durationTime = _durationTime;
                else durationTime = _durationTime*60;
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => RunPage(title: widget.title, timeLimit: timeLimit, durationTime: durationTime, raw_durationTime: raw_durationTime, durationUnit: _durationUnit, touchNumForClose: _touchNumForClose)),
                  (Route<dynamic> route) => false,
                );
                AndroidAlarmManager.periodic(Duration(seconds: 10), 0, showprint);
                // Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("취소"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}


class RunPage extends StatefulWidget {
  final String title, durationUnit;
  final int timeLimit, durationTime, raw_durationTime, touchNumForClose;
  RunPage({Key key, this.title, @required this.timeLimit, @required this.durationTime, @required this.raw_durationTime, @required this.durationUnit, @required this.touchNumForClose}) : super(key: key);

  @override
  _RunPageState createState() => _RunPageState();
}


class _RunPageState extends State<RunPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        backgroundColor: Colors.blue,
        elevation: 0.0,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.blue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 50,),
              Text("리마인더 실행 중", style: TextStyle(fontSize: 30),),
              SizedBox(height: 40,),
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(
                      Radius.circular(200) //                 <--- border radius here
                  ),
                ),
                width: 250, height: 250,
                child: Center(child: Text("${widget.timeLimit}", style: TextStyle(fontSize: 40, color: Colors.white),),),
              ),
              SizedBox(height: 50,),
              Text("${widget.touchNumForClose}회 연속 터치 시 강제종료", style: TextStyle(fontSize: 20, color: Colors.white54),),
              SizedBox(height: 40,),
              Text("${widget.raw_durationTime} ${widget.durationUnit} 마다 알림", style: TextStyle(fontSize: 35),),
            ],
          )
        ),
      ),
    );
  }
}