import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'calender.dart';

class Login extends StatelessWidget {
  // TextEditingController 생성
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _showDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("로그인"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "로그인하기",
              style: TextStyle(fontSize: 30.0),
            ),
            SizedBox(height: 20),
            // 아이디 입력
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("이메일", style: TextStyle(fontSize: 20)),
                SizedBox(width: 10), // 아이디와 입력창 사이 간격
                SizedBox(
                  width: 200, // 입력창 크기 지정
                  child: TextField(
                    controller: _idController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "이메일 입력",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20), // 위아래 간격

            // 비밀번호 입력
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("비밀번호", style: TextStyle(fontSize: 20)),
                SizedBox(width: 10),
                SizedBox(
                  width: 200, // 입력창 크기 지정
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "비밀번호 입력",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),

            ElevatedButton(
              onPressed: () async {
                String id = _idController.text;
                String psw = _passwordController.text;
                if(id == "")
                {
                  _showDialog(context, "오류!", "아이디를 입력하시오");
                } //아이디 입력 안 한 경우
                else if (psw == "")
                {
                  _showDialog(context, "오류!", "비밀번호를 입력하시오");
                } //비밀번호 입력 안 한 경우

                else{
                  try {
                    // Firestore에서 해당 이메일의 문서 검색
                    var querySnapshot = await FirebaseFirestore.instance
                        .collection('userInfo')
                        .where('email', isEqualTo: id)
                        .get();

                    // 이메일이 존재하지 않는 경우
                    if (querySnapshot.docs.isEmpty) {
                      _showDialog(context, "오류!", "해당 이메일이 존재하지 않습니다.");
                      return;
                    }

                    // 문서에서 비밀번호 가져오기
                    var userDoc = querySnapshot.docs.first;
                    String storedPassword = userDoc['password'];

                    if (storedPassword == psw) {
                      // 비밀번호 일치 -> 로그인 성공
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("성공"),
                            content: Text("로그인에 성공했습니다"),
                            actions: [
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => CalendarPage()), // 추후 today로 바꿀 것
                                  );
                                },
                                icon: Text("캘린더로 이동하기"),
                              ),
                            ],
                          );
                        },
                      );

                    } else {
                      // 비밀번호 불일치
                      _showDialog(context, "오류!", "비밀번호가 올바르지 않습니다.");
                    }
                  } catch (e) {
                    // Firestore 작업 중 오류 처리
                    print("로그인 오류: $e");
                    _showDialog(context, "오류!", "로그인에 실패했습니다. 다시 시도하세요.");
                  }
                }
              },
              child: Text("로그인"),
            ),
          ],
        ),
      ),
    );
  }
}