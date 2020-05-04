import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:pie_chart/pie_chart.dart';

import 'distribution_data.dart';

void main() async {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Android Version Distribution'),
        backgroundColor: Colors.teal[900],
      ),
      body: OsVersion(),
    ),
  ));
}

class OsVersion extends StatefulWidget {
  @override
  _OsVersionState createState() => _OsVersionState();
}

class _OsVersionState extends State<OsVersion> {
  DistributionData distData = DistributionData();
  //List<Color> colorList = [
  //  Colors.lightGreen,
  //  Colors.amber,
  //  Colors.lightBlue,
  //  Colors.green,
  //  Colors.cyan,
  //  Colors.purple,
  //  Colors.blueGrey,
  //  Colors.deepOrange,
  //  Colors.indigoAccent,
  //  Colors.pinkAccent,
  //];

  Widget getChart() {
    if (distData.getLength() > 0) {
      return PieChart(
        dataMap: distData.distData,
        //colorList: colorList,
      );
    } else {
      return FlatButton(
        child: Text("Load data"),
        onPressed: () async {
          var url =
              'http://dl.google.com/android/studio/metadata/distributions.json';
          var response = await http.get(url);
          if (response.statusCode == 200) {
            var json = convert.jsonDecode(response.body);
            setState(() {
              for (int i = 0; i < json.length; i++) {
                var name = json[i]['name'];
                var percent = json[i]['distributionPercentage'];
                print('$name = $percent\n');
                distData.addVersionData(osVersion: name, osDist: percent);
              }
            });
          } else {
            print('Request failed with status: ${response.statusCode}.');
          }
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        getChart(),
      ],
    );
  }
}
