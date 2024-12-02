import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login.dart'; // 로그인 화면을 정의한 파일
import 'register.dart'; // 회원가입 화면을 정의한 파일
import 'firebase_options.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(  // Column을 SingleChildScrollView로 감싸서 스크롤 가능하게 설정
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 400, // 원하는 너비
                  height: 400, // 원하는 높이
                  child: Image(
                    image: AssetImage('assets/images/logo.png'),
                    fit: BoxFit.contain, // 이미지를 컨테이너 내부에 맞춤
                  ),
                ),
                Text(
                  "Task Quest에 로그인하기",
                  style: TextStyle(fontSize: 30.0, color: Colors.blue),
                ),
                SizedBox(height: 30),

                Builder(
                  builder: (context) {
                    return ElevatedButton(
                      child: Text("로그인하기"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()), // Login 화면으로 이동
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                      ),
                    );
                  },
                ),

                SizedBox(height: 20),

                Builder(
                  builder: (context) {
                    return ElevatedButton(
                      child: Text("회원가입하기"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Register()), // Register 화면으로 이동
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Firebase 초기화를 위한 필수 코드
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); // Firebase 초기화
  runApp(MyApp());
}