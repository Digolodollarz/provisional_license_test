import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class DashboardStatisticsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            Align(
              child: Text(
                "Your stats",
                style: Theme.of(context)
                    .textTheme
                    .body1
                    .copyWith(color: Theme.of(context).primaryColorDark),
              ),
              alignment: Alignment(-1, 0),
            ),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: StatsLineChart.withSampleData(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  "You are getting better, keep going",
                  style: Theme.of(context)
                      .textTheme
                      .body1
                      .copyWith(color: Theme.of(context).accentColor),
                ),
                Icon(
                  Icons.keyboard_arrow_right,
                  color: Theme.of(context).accentColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class StatsLineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  StatsLineChart(this.seriesList, {this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory StatsLineChart.withSampleData() {
    return new StatsLineChart(
      _createSampleData(),
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(
      seriesList,
      animate: animate,
      domainAxis: charts.AxisSpec<num>(renderSpec: charts.NoneRenderSpec()),
      primaryMeasureAxis: charts.AxisSpec<num>(renderSpec: charts.NoneRenderSpec()),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 45),
      new LinearSales(1, 25),
      new LinearSales(2, 90),
      new LinearSales(4, 75),
      new LinearSales(5, 78),
      new LinearSales(6, 88),
      new LinearSales(7, 98),
      new LinearSales(8, 96),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'stats',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
