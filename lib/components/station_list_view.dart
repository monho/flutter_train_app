import 'package:flutter/material.dart';

class StationListView extends StatelessWidget {
  final List<String> stations;
  final void Function(String station)? onTap;

  const StationListView({
    super.key,
    required this.stations,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: stations.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(stations[index]),
          onTap: () {
            if (onTap != null) {
              onTap!(stations[index]);
            }
          },
        );
      },
    );
  }
}
