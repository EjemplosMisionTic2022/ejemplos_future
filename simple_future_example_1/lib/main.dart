import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
  int forceRefresh = 0;

  void refresh() {
    setState(() {
      forceRefresh += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Future sample 1"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(onPressed: () => refresh(), child: Text('Refresh')),
            FutureBuilder(
                future: getData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState != ConnectionState.done ||
                      !snapshot.hasData) {
                    return Center(child: new CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('ERROR -> ${snapshot.error}'));
                  }
                  if (snapshot.hasData) {
                    return Center(child: Text('DONE with ${snapshot.data}'));
                  }

                  // should not happen
                  return Center(child: new CircularProgressIndicator());
                })
          ],
        ));
  }
}

Future<bool> getData() async {
  //  <--- async function
  Random random = new Random();
  int value = random.nextInt(20);
  await Future.delayed(Duration(seconds: 3));
  if (value % 2 == 0) {
    if (value <= 10) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  } else {
    return Future.error("NO ES PAR!!!");
  }
}
