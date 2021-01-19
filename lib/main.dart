import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

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

  final _timenumList = new List<int>.generate(59, (i) => i + 1);
  var _durationTime = '59';

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
                  Text("00:00"),
                  Text("동안"),
                  Row(
                    children: <Widget>[
                      // DropdownButton(
                      //   value: _durationTime,
                      //   items: _timenumList.map((value) => DropdownMenuItem(
                      //     value: value,
                      //     child: Text(value.toString()),
                      //   )).toList(),
                      //   onChanged: (value){
                      //     setState(() {
                      //       _durationTime = value;
                      //     });
                      //   },
                      // ),
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
}
