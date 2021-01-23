import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:numberpicker/numberpicker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  var _timeLimitH = 1, _timeLimitM = 0, _durationTime = 0, _durationUnit = '분';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
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
                    mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                    children: <Widget>[
                      time_limit_Hpicker(),
                      Text("시간"),

                      time_limit_Mpicker(),
                      Text("분"),
                    ],
                  ),
                  Row(
                    children: <Widget>[

                    ],
                  ),
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
        selectedTextStyle: TextStyle(fontSize: 35, color: Colors.blue),
        textStyle: TextStyle(fontSize: 16, color: Colors.black),
        listViewWidth: 70,
        itemExtent: 50.0,
        onChanged: (newValue) => setState(() => _timeLimitH = newValue));
  }
  Widget time_limit_Mpicker(){
    return NumberPicker.integer(
        initialValue: _timeLimitM,
        minValue: 0,
        maxValue: 59,
        step: 10,
        selectedTextStyle: TextStyle(fontSize: 35, color: Colors.blue),
        textStyle: TextStyle(fontSize: 16, color: Colors.black),
        listViewWidth: 50,
        itemExtent: 50.0,
        zeroPad: true,
        onChanged: (newValue) => setState(() => _timeLimitM = newValue));
  }


}
