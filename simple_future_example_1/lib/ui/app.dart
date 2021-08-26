import 'dart:math';

import 'package:flutter/material.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Future sample 1',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilderLoader(),
    );
  }
}

class FutureBuilderLoader extends StatefulWidget {
  @override
  _FutureBuilderLoaderState createState() => _FutureBuilderLoaderState();
}

class _FutureBuilderLoaderState extends State<FutureBuilderLoader> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Future sample 1"),
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: getData(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Center(child: Text('DONE with ${snapshot.data}'));
                    } else if (snapshot.hasError) {
                      return Center(child: Text('ERROR -> ${snapshot.error}'));
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
            Container(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: Text('Restart the app to get different result'),
            )),
          ],
        ));
  }
}

Future<bool> getData() async {
  //  <--- async function
  print("calling getData");
  Random random = new Random();
  int value = random.nextInt(20);
  await Future.delayed(Duration(seconds: 3));
  if (value % 2 == 0) {
    if (value <= 10) {
      print("getData returning true");
      return Future.value(true);
    } else {
      print("getData returning false");
      return Future.value(false);
    }
  } else {
    print("getData returning error");
    return Future.error("NO ES PAR!!!");
  }
}
