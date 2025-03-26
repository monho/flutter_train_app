import 'package:flutter/material.dart';
class SeatSelectionPage extends StatefulWidget {
  final String? selectedDeparture;
  final String? selectedArrival;

  const SeatSelectionPage({
    super.key,
    this.selectedDeparture,
    this.selectedArrival,
  });

  @override
  State<SeatSelectionPage> createState() => _SeatSelectionPageState();
}

class _SeatSelectionPageState extends State<SeatSelectionPage> {
  final int rows = 10;
  final int columns = 4;
  List<List<bool>> seatSelection = [];

  @override
  void initState() {
    super.initState();
    // 초기 좌석 상태 (false: 선택되지 않음, true: 선택됨)
    seatSelection = List.generate(rows, (_) => List.generate(columns, (_) => false));
  }

  void toggleSeat(int row, int col) {
    setState(() {
      seatSelection[row][col] = !seatSelection[row][col];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("좌석 선택"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 출발역 & 도착역 표시
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.selectedDeparture ?? '',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),
                ),
                const Icon(Icons.arrow_forward),
                Text(
                  widget.selectedArrival ?? '',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),
                ),
              ],
            ),
            const SizedBox(height: 10),
            
            // 좌석 상태 설명
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _seatIndicator(Colors.purple, "선택됨"),
                const SizedBox(width: 10),
                _seatIndicator(Colors.grey, "선택 가능"),
              ],
            ),
            const SizedBox(height: 20),

            // 좌석 배치 (Grid)
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // 4개의 좌석 열
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: rows * columns,z
                itemBuilder: (context, index) {
                  int row = index ~/ columns;
                  int col = index % columns;
                  bool isSelected = seatSelection[row][col];

                  return GestureDetector(
                    onTap: () => toggleSeat(row, col),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.purple : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  );
                },
              ),
            ),

            // 예매하기 버튼
            ElevatedButton(
              onPressed: () {
                // 선택된 좌석 확인
                List<String> selectedSeats = [];
                for (int i = 0; i < rows; i++) {
                  for (int j = 0; j < columns; j++) {
                    if (seatSelection[i][j]) {
                      selectedSeats.add("Row ${i + 1}, Seat ${j + 1}");
                    }
                  }
                }
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("선택된 좌석"),
                    content: Text(selectedSeats.isEmpty ? "좌석을 선택하세요" : selectedSeats.join("\n")),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context), child: const Text("확인")),
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("예매 하기", style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  // 좌석 상태 인디케이터 (설명용)
  Widget _seatIndicator(Color color, String label) {
    return Row(
      children: [
        Container(width: 20, height: 20, color: color),
        const SizedBox(width: 5),
        Text(label),
      ],
    );
  }
}
