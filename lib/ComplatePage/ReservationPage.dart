import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ReservationPage extends StatelessWidget {
  final String departure;
  final String arrival;
  final String departureTime;
  final String arrivalTime;
  final String duration;
  final String seatNumber;

  const ReservationPage({
    super.key,
    required this.departure,
    required this.arrival,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.seatNumber,
  });

  @override
  Widget build(BuildContext context) {
    String reservationCode = "$departure-$arrival-$seatNumber"; // QR코드 데이터

    return Scaffold(
      appBar: AppBar(title: const Text("예매 확인") , centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("🚄 기차표", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),

            const SizedBox(height: 20),
            _infoRow("출발역", departure),
            _infoRow("도착역", arrival),
            _infoRow("출발 시간", departureTime),
            _infoRow("도착 시간", arrivalTime),
            _infoRow("소요 시간", duration),
            _infoRow("좌석 번호", seatNumber),

            const SizedBox(height: 20),

            // QR 코드 생성
            QrImageView(
              data: reservationCode,
              version: QrVersions.auto,
              size: 200.0,
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              child: const Text("확인", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(value, style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
