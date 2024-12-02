import 'package:flutter/material.dart';
import 'point_store.dart';
import 'info.dart';

void main() {
  runApp(pointmanage());
}

class pointmanage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PointManagementScreen(),
    );
  }
}

class PointManagementScreen extends StatelessWidget {
  final int points = 1200; // 총 포인트 값, 파이어베이스에서 데이터 가져와야됨
  final String name = 'name'; //이룸, 파이어베이스로 가져와야됨
  String profileImageUrl = "https://picsum.photos/288/364"; //파이어베이스로 사진 가져올 것

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('포인트 관리하기'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => info()),
            );
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          CircleAvatar(
            radius: 80,
            backgroundImage: NetworkImage(profileImageUrl),
          ),

          SizedBox(height: 20),
          Text(
            '$name 님의 총 포인트는',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            '💰 $points',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '입니다',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[400],
                    minimumSize: Size(double.infinity, 50), // 버튼 크기 고정
                  ),
                  onPressed: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => pointstore()),
                    );
                  },
                  child: Text('포인트 상점'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[400],
                    minimumSize: Size(double.infinity, 50), // 버튼 크기 고정
                  ),
                  onPressed: () {
                    //적립이력
                  },
                  child: Text('포인트 적립이력'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}