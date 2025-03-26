import 'package:flutter/material.dart';
import '../StationListPage/StationListPage.dart';
import '../SeatPage/SeatPage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String departureStation = '선택';
  String arrivalStation = '선택';

  void _selectStation(bool isDeparture) async {
    final selectedStation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StationListPage(
          selectedDeparture: departureStation,
          selectedArrival: arrivalStation,
          isDeparture: isDeparture,
        ),
      ),
    );

    if (selectedStation != null && selectedStation is String) {
      setState(() {
        if (isDeparture) {
          departureStation = selectedStation;
        } else {
          arrivalStation = selectedStation;
        }
      });
    }
  }

  void _seatPage(bool isDeparture) async{
 final selectedStation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SeatSelectionPage(
          selectedDeparture: departureStation,
          selectedArrival: arrivalStation,
        ),
      ),
    );

    if (selectedStation != null && selectedStation is String) {
      setState(() {
        if (isDeparture) {
          departureStation = selectedStation;
        } else {
          arrivalStation = selectedStation;
        }
      });
    }

  }



  void ReservationTrain() {
    if (departureStation == "선택" || arrivalStation == "선택") {
      _showDialog("오류", "출발역과 도착역을 선택해주세요.");
      return;
    }

    if (departureStation == arrivalStation) {
      _showDialog("경고", "출발역과 도착역이 동일할 수 없습니다.");
      return;
    }
    _seatPage(true);
   
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("확인"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isReservable = departureStation != "선택" && arrivalStation != "선택";

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text('기차 예매'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 출발역 & 도착역 선택 컨테이너
              Container(
                height: 200,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // 출발역
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          '출발역',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        TextButton(
                          onPressed: () => _selectStation(true),
                          child: Text(
                            departureStation,
                            style: TextStyle(
                              color: departureStation == "선택" ? Colors.black : Colors.purple,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // 중앙 구분선
                    Container(
                      width: 2,
                      height: 50,
                      color: Colors.grey[400],
                    ),
                    // 도착역
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          '도착역',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        TextButton(
                          onPressed: () => _selectStation(false),
                          child: Text(
                            arrivalStation,
                            style: TextStyle(
                              color: arrivalStation == "선택" ? Colors.black : Colors.purple,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // 예매 버튼
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isReservable ? ReservationTrain : null, // 선택되지 않았을 경우 비활성화
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    disabledBackgroundColor: Colors.grey, // 비활성화 시 회색
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "예매 하기",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
