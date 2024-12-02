import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'package:firebase_database/firebase_database.dart';


void _showErrorDialog(BuildContext context, String title, String message) {
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


class Register extends StatelessWidget {
  // TextEditingController 생성
  final TextEditingController _nameregister = TextEditingController(); //이름 등록
  final TextEditingController _idregister = TextEditingController(); // 이메일 등록
  final TextEditingController _passwordregister = TextEditingController(); // 비밀번호 등록
  final TextEditingController _passwordregister2 = TextEditingController(); // 비밀번호 맞는지 확인용

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("회원가입"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0), // 화면 여백 추가
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "회원가입하기",
              style: TextStyle(fontSize: 30.0),
            ),
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("이름", style: TextStyle(fontSize: 20)),
                SizedBox(width: 10), // 아이디와 입력창 사이 간격
                SizedBox(
                  width: 200, // 입력창 크기 지정
                  child: TextField(
                    controller: _nameregister,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "이름 입력",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("이메일", style: TextStyle(fontSize: 20)),
                SizedBox(width: 10), // 아이디와 입력창 사이 간격
                SizedBox(
                  width: 200, // 입력창 크기 지정
                  child: TextField(
                    controller: _idregister,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "이메일 입력",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("비밀번호", style: TextStyle(fontSize: 20)),
                SizedBox(width: 10), // 입력창 사이 간격
                SizedBox(
                  width: 200, // 입력창 크기 지정
                  child: TextField(
                    controller: _passwordregister,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "비밀번호 입력",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("비밀번호 다시 입력하기", style: TextStyle(fontSize: 20)),
                SizedBox(width: 10), // 입력창 사이 간격
                SizedBox(
                  width: 200, // 입력창 크기 지정
                  child: TextField(
                    controller: _passwordregister2,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "비밀번호 한번 더 입력",
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                String regist_name = _nameregister.text;
                String regist_id = _idregister.text;
                String regist_psw = _passwordregister.text;
                String regist_psw2 = _passwordregister2.text;

                bool isalpha_ = RegExp(r'^[a-zA-Z]+$').hasMatch(regist_psw);
                bool isnum_ = RegExp(r'^[0-9]+$').hasMatch(regist_psw);

                if (regist_name == "") {
                  _showErrorDialog(context, "오류!", "이름을 입력해야 합니다.");
                } //이름이 입력되지 않은 경우

                else if (regist_id == "") {
                  _showErrorDialog(context, "오류!", "이메일을 입력해야 합니다.");
                } //이메일 입력을 하지 않는 경우

                else if (regist_psw == "") {
                  _showErrorDialog(context, "오류!", "비밀번호를 입력해야 합니다.");
                } //비밀번호칸에 아무것도 없는경우

                else if (regist_psw2 == "") {
                  _showErrorDialog(context, "오류!", "비밀번호 확인란을 입력해야 합니다.");
                } //비밀번호 확인 칸에 아무것도 없는경우

                else if (regist_psw != regist_psw2) {
                  _showErrorDialog(context, "오류!", "비밀번호가 일치하지 않습니다.");
                } //비밀번호 일치하지 않는다면

                else if (regist_psw.length > 12) {
                  _showErrorDialog(context, "오류!", "비밀번호는 12자리 이하여야 합니다.");
                } //비밀번호가 12자리 초과인 경우

                else if(isnum_ == true || isalpha_ == true ){
                  _showErrorDialog(context, "오류!", "비밀번호에는 숫자와 문자 모두 포함되어야 합니다.");
                } //비밀번호에 숫자만 있거나, 문자만 있는 경우

                else {
                  try {
                    // Firestore에서 이메일 중복 체크
                    var querySnapshot = await FirebaseFirestore.instance
                        .collection('userInfo')
                        .where('email', isEqualTo: regist_id)
                        .get();

                    if (querySnapshot.docs.isNotEmpty) {
                      // 이메일 중복 시 오류 메시지
                      _showErrorDialog(context, "오류!", "이미 사용 중인 이메일입니다.");
                    } else {
                      // Firestore에 데이터 추가
                      await FirebaseFirestore.instance.collection('userInfo').add({
                        'name': regist_name,
                        'email': regist_id,
                        'password': regist_psw, // 실제 서비스에서는 비밀번호 해시화 필요
                      });

                      // 회원가입 성공 후 로그인 페이지로 이동
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                      print("회원가입 성공: $regist_name, $regist_id");
                    }
                  } catch (e) {
                    print("회원가입 중 오류 발생: $e");
                    _showErrorDialog(context, "오류!", "회원가입에 실패했습니다. 다시 시도해주세요.");
                  }
                }//파이어베이스 내에 있는 데이터의 이메일 확인, 같은 이메일이 있으면 거부, 다른 이메일이 있으면 등록

              },
              child: Text("회원가입하기"),
            ),
          ],
        ),
      ),
    );
  }
}