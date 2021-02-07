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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("반복 시간"),
                      SizedBox(
                        width: 30,
                      ),
                      durationTime_picker(),
                      Row(
                        children: <Widget>[
                          customRadio(_durationUnitList[0],0),
                          customRadio(_durationUnitList[1],1),
                        ],
                      ),
                    ],
                  ),
                  Text("$_timeLimitH:$_timeLimitM 동안 $_durationTime$_durationUnit마다 반복, $_touchNumForClose"),
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
                          onPressed: _showDialog,
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
        onChanged: (newValue) => setState(() => _timeLimitH = newValue)
      );
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
              borderRadius: BorderRadius.circular(35.0)
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("시작"),
              onPressed: () {
                int durationTime, timeLimit = _timeLimitM*60 + _timeLimitH*360;
                if(_durationUnit=='초') durationTime = _durationTime;
                else durationTime = _durationTime*60;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RunPage(title: widget.title, timeLimit: timeLimit, durationTime: durationTime, touchNumForClose: _touchNumForClose)),
                );
                AndroidAlarmManager.periodic(Duration(seconds: 3), 0, showprint);
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

showprint(){
  print('지창민결혼하자');
}


class RunPage extends StatefulWidget {
  final String title;
  final int timeLimit, durationTime, touchNumForClose;
  RunPage({Key key, this.title, @required this.timeLimit, @required this.durationTime, @required this.touchNumForClose}) : super(key: key);



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
            color: Colors.red,
            child: Container(
              width: 350,
              height: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("${widget.touchNumForClose}회 연속 터치 시 강제종료, ${widget.timeLimit}, ${widget.durationTime}")
                ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}