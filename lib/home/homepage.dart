import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
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
                            onPressed: (){}, 
                            child: const Text(
                               '선택',
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
                            onPressed: (){}, 
                            child: const Text(
                               '선택',
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
                    onPressed: (){},
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