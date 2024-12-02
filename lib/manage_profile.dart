import 'package:flutter/material.dart';
import 'info.dart';
import 'main.dart';

void main() {
  runApp(manage());
}

class manage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  String profileImageUrl = "https://picsum.photos/288/364"; //파이어베이스로 사진 가져올 것
  String name = 'name'; //아이디 파이어베이스에서 가져올 것

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('프로필 관리하기'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => info()),
            );
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(height: 20),
              CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(profileImageUrl),
              ),
              SizedBox(height: 10),
              Text(
                '아이디: $name', //아이디는 이름으로, 파이어베이스 내에 있는 데이터 가져다 쓸 것
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(200, 50), // 버튼의 고정 크기 설정 (너비: 200, 높이: 50)
                        padding: EdgeInsets.zero, // 패딩을 제거해 고정 크기에 영향을 미치지 않도록 함
                      ),
                      onPressed: () {
                        // 프로필 사진 변경 로직
                      },
                      child: Text('프로필 사진 변경하기'),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(200, 50), // 버튼의 고정 크기 설정 (너비: 200, 높이: 50)
                        padding: EdgeInsets.zero, // 패딩을 제거해 고정 크기에 영향을 미치지 않도록 함
                      ),
                      onPressed: () {
                        // 아이디 변경 로직
                      },
                      child: Text('아이디 변경하기'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              onPressed: () {
                showDialog(context: context,
                  builder: (BuildContext context){
                    return AlertDialog(
                      title: Text("로그아웃 하시겠습니까? "),
                      actions: <Widget> [
                        TextButton(onPressed: (){
                          Navigator.of(context).pop();
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MyApp()),
                          );
                        }, child: Text("네"),
                        ),
                        TextButton(onPressed: (){
                          Navigator.of(context).pop();
                        }, child: Text("아니오"),
                        ),

                      ],
                    );
                  },
                );
              },
              child: Text('로그아웃하기'),
            ),
          ),
        ],
      ),
    );
  }
}