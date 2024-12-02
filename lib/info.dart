import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'manage_point.dart';
import 'today.dart';
import 'calender.dart';
import 'manage_profile.dart';

void main() {
  runApp(info());
}

class info extends StatefulWidget {
  @override
  _infoState createState() => _infoState();
}

class _infoState extends State<info> {
  int _selectedIndex = 2; // 현재 선택된 버튼 인덱스
  String userName = "name"; // Firebase에서 가져올 사용자 이름
  String profileImageUrl = "https://picsum.photos/288/364"; // Firebase에서 가져올 프로필 이미지 URL
  int points = 1200; // Firebase에서 가져올 포인트 값

  void _onItemTapped(int index) {
    if (index == _selectedIndex) {
      // 현재 선택된 버튼을 다시 누른 경우, 아무 동작도 하지 않음
      return;
    }

    setState(() {
      _selectedIndex = index;
    });

    // 버튼 클릭 시 네비게이션
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CalendarPage(), // 새 화면 위젯
        ),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => today(), // 다른 화면 위젯
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내 정보'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,  // 수직 중앙 정렬
          crossAxisAlignment: CrossAxisAlignment.center,  // 수평 중앙 정렬
          children: [
            // 프로필 사진 원형 이미지
            CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(profileImageUrl),
            ),
            SizedBox(height: 20),

            // 이름 가져오기 (Firebase 연동 후 변경)
            Text(
              '$userName 님',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),

            // 포인트 값 표시
            Text(
              '💰 $points',
              style: TextStyle(
                fontSize: 24,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),

            // 버튼들
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder:(context) => pointmanage()),
                );
              },
              child: Text('포인트 관리하기'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder:(context) => manage()),
                );
              },
              child: Text('프로필 관리하기'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: '달력',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: '오늘의 할일',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '나',
          ),
        ],
        currentIndex: _selectedIndex, // 현재 선택된 인덱스
        onTap: _onItemTapped, // 탭 이벤트 처리
      ),
    );
  }
}