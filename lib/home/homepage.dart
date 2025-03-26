import 'package:flutter/material.dart';
import '../StationListPage/StationListPage.dart';

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
        isDeparture: isDeparture, // 여기에 값 전달!
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
  if (departureStation == null || arrivalStation == null) {
    // 출발역 또는 도착역이 선택되지 않았을 경우
    _showDialog("오류", "출발역과 도착역을 선택해주세요.");
    return;
  }

  if (departureStation == arrivalStation) {
    // 출발역과 도착역이 같으면 다이얼로그 표시
    _showDialog("경고", "출발역과 도착역이 동일할 수 없습니다.");
    return;
  }

  // 예약 진행 로직 추가
  _showDialog("성공", "기차 예약이 완료되었습니다!");
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
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("확인"),
          ),
        ],
      );
    },
  );
}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text('기차 예매'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  padding: EdgeInsets.all(20),
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
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 4),
                          TextButton(
                             onPressed: () => _selectStation(true),
                            child:  Text(
                               departureStation,
                               style: TextStyle(
                                color:  Colors.black,
                                fontSize: 40,
                               ),
                            )
                          )
                        ],
                      ),
                      // 중앙 구분선
                      Container(
                        width: 2,
                        height: 50,
                        color: Colors.grey[400]
                      ),
                      // 도착역
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            '도착역',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 4),
                          TextButton(
                            onPressed: () => _selectStation(false),
                            child:  Text(
                               arrivalStation,
                               style: TextStyle(
                                color:  Colors.black,
                                fontSize: 40,
                               ),
                            )
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => ReservationTrain(),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor:Colors.purple,                    
                      shape: RoundedRectangleBorder(  
                      borderRadius: BorderRadius.circular(20),  
                     ),  
                    ),
                    child: const Text('좌석 선택',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}