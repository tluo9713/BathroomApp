import 'package:flutter/material.dart';
import './google_map.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.orange),
      home: Scaffold(
          appBar: AppBar(
            title: Text('When Urine Trouble'),
          ),
          body: MyBody()),
    );
  }
}

//can't put MyBody directly into the body of MyApp. This is due to a weird
//issue where the context in builder. Specifically context does not contain a
//Navigator
class MyBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text('Welcome Bathroom User!'),
            ),
            Container(
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GoogleMapWidget()));
                },
                child: Text('Find me the nearest bathroom!'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
