import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chart1/task.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<charts.Series<Task, String>> _elmaVeriSerisi;

  _veriYaz() {
    var elmaDilim = [
      Task("İş", 8.0, Colors.red),
      Task("Ders", 8.0, Colors.green),
      Task("Kitap", 1.0, Colors.blue),
      Task("Yemek", 1.0, Colors.amberAccent),
      Task("Uyku", 6.0, Colors.deepPurpleAccent),
    ];

    _elmaVeriSerisi.add(charts.Series(
        data: elmaDilim,
        domainFn: (Task task, _) => task.task,
        measureFn: (Task task, _) => task.taskvalue,
        colorFn: (Task task, _) =>
            charts.ColorUtil.fromDartColor(task.colorval),
        id: "Günlük Görev",
        labelAccessorFn: (Task row, _) => "${row.taskvalue}"));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _elmaVeriSerisi = List<charts.Series<Task, String>>();
    _veriYaz();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Elma Dilim Grafik"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text(
            "Günlük Harcanan Zaman Grafiği",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: charts.PieChart(
              _elmaVeriSerisi,
              animate: true,
              animationDuration: Duration(seconds: 5),
              behaviors: [
                charts.DatumLegend(
                  outsideJustification: charts.OutsideJustification.endDrawArea,
                  horizontalFirst: false,
                  desiredMaxRows: 2,
                  cellPadding: EdgeInsets.only(right: 4, bottom: 4),
                  entryTextStyle: charts.TextStyleSpec(
                    color: charts.MaterialPalette.purple.shadeDefault,
                  ),
                ),
              ],
              defaultRenderer: charts.ArcRendererConfig(
                arcWidth: 100,
                arcRendererDecorators: [
                  charts.ArcLabelDecorator(
                    labelPosition: charts.ArcLabelPosition.inside,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
