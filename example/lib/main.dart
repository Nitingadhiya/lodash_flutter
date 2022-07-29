import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:lodash_flutter/lodash_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  dynamic _platformVersion = 'Unknown';
  final _lodashFlutterPlugin = LodashFlutter();
  dynamic myList = [];
  dynamic listM = [
    {"title": 'Avengers', "release_date": '10/01/2019'},
    {"title": 'Creed', "release_date": '10/01/2019'},
    {"title": 'Jumanji', "release_date": '30/10/2019'},
  ];
  List sortedByArray = [
    {"fid": 1, "name": "z"},
    {"fid": 10, "name": "b"},
    {"fid": 5, "name": "c"},
    {"fid": 4, "name": "d"}
  ];
  // List sortedByArray = [{"fid":1,"name":"z"},{"fid":10,"name":"b"},{"fid":5,"name":"c"},{"fid":4,"name":"d"}];

  @override
  void initState() {
    super.initState();
    multidimensionArray();
    initPlatformState();
  }

  customMethod() {
    if ('check' == null) {
      return 'val11';
    }
    return 'val';
  }

  multidimensionArray() {
    var N = 10;
    for (var i = 1; i <= N; i++) {
      if (i % 2 == 0) {
        myList.add(
          {'id': i, 'name': "Omi1d", 'abc': 'XYZ'},
        );
        myList.add(
          {'id': i, 'name': "Omi1d--", 'abc': 'XYZ'},
        );
      } else {
        myList.add(
          {'id': 1, 'name': "Omi1d", 'abc': 'XYZ'},
        );
      }
    }
    // myList.addAll([1, 3, 1, 4, 5, 6, 0]);
    print(myList);
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    dynamic platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = LodashFlutter.platformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text('Running on: $_platformVersion\n'),
              ),
              Center(
                child: Text('Check Value is Null: ${LodashFlutter.isNullOrBlank('')}\n'),
              ),
              Center(
                child: Text('isInteger("1"): ${LodashFlutter.isInteger('1')}\n'),
              ),
              Center(
                child: Text('isNumeric("1.2"): ${LodashFlutter.isNumeric('1')}\n'),
              ),
              Center(
                child: Text('Running on: ${LodashFlutter.toNumber('100')}\n'),
              ),
              //[10, '', '', null, 20, 0, 40, 50, false]
              Center(
                child: Text('Concat : ${LodashFlutter.concat([1], [3])}\n'),
              ),
              Center(
                child: Text('Difference From First : ${LodashFlutter.differenceFromFirst([
                      {'a': 1},
                      2,
                      3,
                      4,
                      5,
                      6,
                      7
                    ], [
                      3,
                      5,
                      4,
                      11,
                      6,
                      7,
                      9
                    ])}\n'),
              ),
              Center(
                child: Text('Difference : ${LodashFlutter.difference([
                      {'a': 1},
                      2,
                      3,
                    ], [
                      3,
                      5,
                      {'b': 4},
                      11
                    ])}\n'),
              ),
              Center(
                child: Text('remove At : ${LodashFlutter.removeAt([1, 2, 3, 4, 5], 2)}\n'),
              ),

              Center(
                child: Text('Find Index : ${LodashFlutter.findIndex([
                      {'abc': 'Nitin2', 't': '1'},
                      {'abc': 'Nitin3', 't': '1'},
                      {'abc': 'Nitin', 't': '1'},
                      {'abc': 'Nitin', 't': '1'},
                      // {'abc': 'Nitin'},
                      // {'abc': 'krushant'},
                    ], {
                      'abc': 'Nitin',
                      't': '1'
                    })}\n'),
              ),

              /// findLastIndex
              Center(
                child: Text('Last Index : ${LodashFlutter.findLastIndex([1, 23, 423, 312, 11, 23, 22, 22, 1], 23)}\n'),
              ),
              Center(
                child: Text('Last Index : ${LodashFlutter.findLastIndex([
                      {'abc': 'Nitin2'},
                      {'abc': 'Nitin', 'text': '2'},
                      {'abc': 'Nitin', 'text': '1'},
                      {'abc': 'krushant', 'text': '2'},
                      {'abc': 'Nitin', 'text': '2'},
                    ], {
                      'abc': 'Nitin',
                      'text': '2'
                    })}\n'),
              ),

              /// contains
              Center(
                child: Text('Contains : ${LodashFlutter.contains([1, 2, 3, 4, 6, 7], 5)}\n'),
              ),

              /// containsfromList
              Center(
                child: Text('Contains From List : ${LodashFlutter.containsfromList({1: 'Jupiter', 2: 'Saturn'}, 'Jupiter')}\n'),
              ),

              /// fold
              ///  ${LodashFlutter.fold([10, 2, 5, 0.5])}
              ///   ${LodashFlutter.fold([10, 2, 5, 0.5],initialValue: 100)}
              Center(
                child: Text('Fold : ${LodashFlutter.fold([10, 2, 5, 0.5], initialValue: 100)}\n'),
              ),

              ///skip
              Center(
                child: Text('Skip : ${LodashFlutter.skip([10, 2, 5, 0.5], 2)}\n'),
              ),

              ///take
              Center(
                child: Text('take : ${LodashFlutter.take([10, 2, 5, 0.5], 4)}\n'),
              ),

              ///join
              Center(
                child: Text('join : ${LodashFlutter.join([10, 2, 5, 0.5], '-')}\n'),
              ),

              ///last
              Center(
                child: Text('last : ${LodashFlutter.last([10, 2, 5, 0.5])}\n'),
              ),

              ///first
              Center(
                child: Text('first : ${LodashFlutter.first([10, 2, 5, 0.5])}\n'),
              ),

              ///remove
              Center(
                child: Text('remove : ${LodashFlutter.remove([
                      {'abx': 1},
                      {'abx': 2},
                      {'abx': 3}
                    ], [
                      {'abx': 2}
                    ])}\n'),
              ),

              ///reversed
              Center(
                child: Text('reverse : ${LodashFlutter.reverse([
                      {'abx': 1},
                      {'abx': 2},
                      {'abx': 3}
                    ])}\n'),
              ),

              ///slice
              Center(
                child: Text('slice : ${LodashFlutter.slice([
                      {'abx': 1},
                      {'abx': 2},
                      {'abx': 3}
                    ], 2)}\n'),
              ),

              ///subList
              Center(
                child: Text('subList : ${LodashFlutter.subList([
                      {'abx': 1},
                      {'abx': 2},
                      {'abx': 3},
                      {'abx': 4}
                    ], 1, 2)}\n'),
              ),

              ///sort
              Center(
                child: Text('sort : ${LodashFlutter.sort([1, 3, 4, 5, 6, 0])}\n'),
              ),

              ///uniq
              Center(
                child: Text('uniq : ${LodashFlutter.uniq(myList)}\n'),
              ),

              ///uniqBy
              Center(
                child: Text('uniqBy : ${LodashFlutter.uniqBy(myList, 'id')}\n'),
              ),

              ///filter
              Center(
                child: Text('filter : ${LodashFlutter.filter(myList, {'id': 10, 'name': 'Omi1d', 'abc': 'XYZ'})}\n'),
              ),

              ///find
              Center(
                child: Text('find : ${LodashFlutter.find(myList, customMethod())}\n'),
              ),

              ///groupBy
              Center(
                child: Text('groupby : ${LodashFlutter.groupBy(listM, 'release_date')}\n'),
              ),

              ///size
              Center(
                child: Text('size : ${LodashFlutter.size(listM)}\n'),
              ),

              /// sortedBy
              Center(
                child: Text('sortedBy : ${LodashFlutter.sortedBy(sortedByArray, 'fid')}\n'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
