import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartBPData {
  ChartBPData(this.x, this.high, this.low);

  final String x;
  final int high;
  final int low;
}

class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final int y;
}

class ChartBWData {
  ChartBWData(this.x, this.y);

  final String x;
  final double y;
}

class BPChart extends StatelessWidget {
  final chartData;

  const BPChart({super.key, this.chartData});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SfCartesianChart(
          palette: const [
            Colors.white,
          ],
          primaryXAxis: CategoryAxis(
              labelStyle: const TextStyle(color: Colors.white),
              majorGridLines: const MajorGridLines(width: 0),
              axisLine: const AxisLine(width: 0),
              majorTickLines: const MajorTickLines(width: 0)),
          primaryYAxis: NumericAxis(
              labelStyle: const TextStyle(color: Colors.white),
              axisLine: const AxisLine(width: 0),
              minimum: 50,
              interval: 10,
              maximumLabels: 5),
          plotAreaBorderWidth: 0,
          series: <ChartSeries>[
            RangeColumnSeries<ChartBPData, String>(
                dataSource: chartData,
                xValueMapper: (ChartBPData data, _) => data.x,
                lowValueMapper: (ChartBPData data, _) => data.low,
                highValueMapper: (ChartBPData data, _) => data.high,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                width: 0.3,
                emptyPointSettings:
                EmptyPointSettings(mode: EmptyPointMode.average))
          ],
        ),
      ),
    );
  }
}

class BWChart extends StatelessWidget {
  final chartData;

  const BWChart({super.key, this.chartData});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SfCartesianChart(
          palette: const [
            Colors.white,
          ],
          primaryXAxis: CategoryAxis(
              labelStyle: const TextStyle(color: Colors.white),
              majorGridLines: const MajorGridLines(width: 0),
              axisLine: const AxisLine(width: 0),
              majorTickLines: const MajorTickLines(width: 0)),
          primaryYAxis: NumericAxis(
              labelStyle: const TextStyle(color: Colors.white),
              axisLine: const AxisLine(width: 0),
              interval: 10,
              maximumLabels: 5),
          plotAreaBorderWidth: 0,
          series: <ChartSeries>[
            LineSeries<ChartBWData, String>(
                dataSource: chartData,
                xValueMapper: (ChartBWData data, _) => data.x,
                yValueMapper: (ChartBWData data, _) => data.y,
                markerSettings: const MarkerSettings(
                  isVisible: true,
                ),
                emptyPointSettings:
                EmptyPointSettings(mode: EmptyPointMode.average))
          ],
        ),
      ),
    );
  }
}

class OtherChart extends StatelessWidget {
  final chartData;

  const OtherChart({super.key, this.chartData});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SfCartesianChart(
          palette: const [
            Colors.white,
          ],
          primaryXAxis: CategoryAxis(
              labelStyle: const TextStyle(color: Colors.white),
              majorGridLines: const MajorGridLines(width: 0),
              axisLine: const AxisLine(width: 0),
              majorTickLines: const MajorTickLines(width: 0)),
          primaryYAxis: NumericAxis(
              labelStyle: const TextStyle(color: Colors.white),
              axisLine: const AxisLine(width: 0),
              minimum: 50,
              interval: 10,
              maximumLabels: 5),
          plotAreaBorderWidth: 0,
          series: <ChartSeries>[
            LineSeries<ChartData, String>(
                dataSource: chartData,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                markerSettings: const MarkerSettings(
                  isVisible: true,
                ),
                emptyPointSettings:
                EmptyPointSettings(mode: EmptyPointMode.average))
          ],
        ),
      ),
    );
  }
}
