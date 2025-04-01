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
  final int rows = 10; // 10행으로 변경하여 좌측 20개, 우측 20개 생성
  final int seatsPerSide = 2; // 한쪽에 2개의 좌석
  List<List<bool>> seatSelection = [];

  @override
  void initState() {
    super.initState();
    // 초기 좌석 상태 (false: 선택되지 않음, true: 선택됨)
    // 각 행에 4개의 좌석 (왼쪽 2개, 오른쪽 2개)
    seatSelection = List.generate(rows, (_) => List.generate(4, (_) => false));
  }

  void toggleSeat(int row, int col) {
    setState(() {
      // 기존에 선택된 좌석을 모두 해제하고, 새로운 좌석만 선택하도록 함
      for (int i = 0; i < rows; i++) {
        for (int j = 0; j < 4; j++) {
          seatSelection[i][j] = false;
        }
      }
      seatSelection[row][col] = true; // 새로운 좌석만 선택됨
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

            // A, B, C, D 레이블 추가
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 왼쪽 좌석 (A, B)
                Row(
                  children: [
                    Container(
                      width: 60,
                      margin: const EdgeInsets.only(right: 22),
                      child: const Center(
                        child: Text(
                          'A',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 60,
                      margin: const EdgeInsets.only(right: 22),
                      child: const Center(
                        child: Text(
                          'B',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // 통로 (간격)
                const SizedBox(width: 44),
                // 오른쪽 좌석 (C, D)
                Row(
                  children: [
                    Container(
                      width: 60,
                      margin: const EdgeInsets.only(left: 22),
                      child: const Center(
                        child: Text(
                          'C',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 60,
                      margin: const EdgeInsets.only(left: 22),
                      child: const Center(
                        child: Text(
                          'D',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10), // 레이블과 좌석 사이 간격

            // 좌석 배치
            Expanded(
              child: ListView.builder(
                itemCount: rows,
                itemBuilder: (context, row) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 11.0), // 행 간격
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 왼쪽 좌석 2개
                        Row(
                          children: List.generate(seatsPerSide, (col) {
                            int seatIndex = col;
                            bool isSelected = seatSelection[row][seatIndex];
                            int seatNumber = row * 4 + col + 1; // 좌석 번호 계산 (화면에는 표시하지 않음)

                            return GestureDetector(
                              onTap: () => toggleSeat(row, seatIndex),
                              child: Container(
                                width: 60,
                                height: 60,
                                margin: const EdgeInsets.only(right: 22),
                                decoration: BoxDecoration(
                                  color: isSelected ? Colors.purple : Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                // 좌석 번호는 표시하지 않음
                              ),
                            );
                          }),
                        ),
                        // 통로 (간격) - 행 번호 표시
                        Container(
                          width: 44,
                          height: 60,
                          alignment: Alignment.center,
                          child: Text(
                            '${row + 1}', // 행 번호 표시
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // 오른쪽 좌석 2개
                        Row(
                          children: List.generate(seatsPerSide, (col) {
                            int seatIndex = col + seatsPerSide; // 오른쪽 좌석은 2, 3번 인덱스
                            bool isSelected = seatSelection[row][seatIndex];
                            int seatNumber = row * 4 + col + seatsPerSide + 1; // 좌석 번호 계산 (화면에는 표시하지 않음)

                            return GestureDetector(
                              onTap: () => toggleSeat(row, seatIndex),
                              child: Container(
                                width: 60,
                                height: 60,
                                margin: const EdgeInsets.only(left: 22),
                                decoration: BoxDecoration(
                                  color: isSelected ? Colors.purple : Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                // 좌석 번호는 표시하지 않음
                              ),
                            );
                          }),
                        ),
                      ],
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
                  for (int j = 0; j < 4; j++) {
                    if (seatSelection[i][j]) {
                      // 열에 따라 A, B, C, D로 변환
                      String seatColumn = String.fromCharCode(65 + j); // A, B, C, D
                      int seatRow = i + 1;
                      selectedSeats.add("$seatColumn$seatRow");
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