import 'package:flutter/material.dart';
import 'manage_point.dart';


void main() {
  runApp(pointstore());
}

class pointstore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PointStoreScreen(),
    );
  }
}

class PointStoreScreen extends StatefulWidget {
  @override
  _PointStoreScreenState createState() => _PointStoreScreenState();
}

class _PointStoreScreenState extends State<PointStoreScreen> {
  int points = 1200; // 보유 포인트, 파이어베이스 연동 필요
  String profileImageUrl = "https://picsum.photos/288/364"; //파이어베이스로 사진 가져올 것

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('포인트 상점'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => pointmanage()),
              );
            },
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: '배경테마'),
              Tab(text: '스티커'),
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(profileImageUrl),
                  ),
                  Text(
                    '💰 $points',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildThemeTab(),
                  _buildStickerTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeTab() {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  color: Colors.pink[100],
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('밤하늘 테마', style: TextStyle(fontSize: 16)),
                    Text('💰 80', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink[200],
              ),
              onPressed: () {
                setState(() {
                  if (points >= 80) {
                    points -= 80;
                    // 구매 성공 처리
                  } else {
                    // 포인트 부족 처리
                  }
                });
              },
              child: Text('구매하기'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStickerTab() {
    return Center(
      child: Text('스티커 탭 내용'), // 스티커 탭 내용 추가
    );
  }
}