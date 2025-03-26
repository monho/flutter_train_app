import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../components/station_list_view.dart';

class StationListPage extends StatefulWidget {
  final String? selectedDeparture;
  final String? selectedArrival;
  final bool isDeparture; // 출발역 선택 여부 추가

  const StationListPage({
    super.key,
    this.selectedDeparture,
    this.selectedArrival,
    required this.isDeparture, // 필수 매개변수로 설정
  });

  @override
  State<StationListPage> createState() => _StationListPageState();
}

class _StationListPageState extends State<StationListPage> {
  List<String> stations = [];

  @override
  void initState() {
    super.initState();
    loadStationData();
  }

  Future<void> loadStationData() async {
    final String jsonString = await rootBundle.loadString('assets/stations.json');
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    List<String> allStations = List<String>.from(jsonData['stations']);

    // 출발역과 도착역을 제외한 역 목록 필터링
    setState(() {
      stations = allStations.where((station) {
        return station != widget.selectedDeparture && station != widget.selectedArrival;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isDeparture ? '출발역' : '도착역'), // 동적 제목 설정
        centerTitle: true,
      ),
      body: stations.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : StationListView(
              stations: stations,
              onTap: (station) {
                Navigator.pop(context, station);
              },
            ),
    );
  }
}
