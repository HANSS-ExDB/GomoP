import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'today.dart';

void main() {
  runApp(addtoday());
}

class addtoday extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScheduleScreen(),
    );
  }
}

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final TextEditingController _titleController = TextEditingController();
  DateTime? _startDateTime;
  DateTime? _endDateTime;
  String _selectedLabel = "기본";
  bool _isAlarmOn = true;
  bool _isVibrationOn = true;

  final Map<String, Color> _labelColors = {
    "기본": Colors.grey,
    "업무": Colors.blue,
    "개인": Colors.green,
    "중요": Colors.red,
  };

  void _selectDateTime(BuildContext context, bool isStart) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          final pickedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          if (isStart) {
            _startDateTime = pickedDateTime;
          } else {
            _endDateTime = pickedDateTime;
          }
        });
      }
    }
  }

  void _saveSchedule() {
    print("제목: ${_titleController.text}");
    print("시작시간: ${_startDateTime?.toString() ?? "선택 안 됨"}");
    print("종료시간: ${_endDateTime?.toString() ?? "선택 안 됨"}");
    print("라벨: $_selectedLabel");
    print("알림: $_isAlarmOn");
    print("진동: $_isVibrationOn");

    // 일정이 추가되었다는 팝업 띄우기
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('일정 추가됨'),
        content: Text('일정이 성공적으로 추가되었습니다.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // 팝업 닫기
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => today()), // `today` 화면으로 이동
              );
            },
            child: Text('확인'),
          ),
        ],
      ),
    );

    // 초기화
    _titleController.clear();
    _startDateTime = null;
    _endDateTime = null;
    _selectedLabel = "기본";
    _isAlarmOn = true;
    _isVibrationOn = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back), // 뒤로가기 버튼 아이콘
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('일정 추가하기'),
                    content: Text('일정을 취소하시겠습니까?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          // 취소 동작: 다이얼로그 닫기
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => today()), // `today` 화면으로 이동
                          );
                        },
                        child: Text('취소하기'),
                      ),
                      TextButton(
                        onPressed: () {
                          // 계속 작성하기 동작: 다이얼로그 닫기
                          Navigator.pop(context);
                        },
                        child: Text('계속 작성하기'),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(width: 10),
            Text("일정 추가하기"),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _saveSchedule, //파이어베이스를 통해 데이터 저장을 필요로 합니다 현재 콘솔에서 나올 수 있게 만들어놨어요
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 제목 입력
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: "제목",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            // 시작시간과 종료시간
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () => _selectDateTime(context, true),
                  child: Text(
                    "시작시간: ${_startDateTime != null ? DateFormat('yyyy-MM-dd HH:mm').format(_startDateTime!) : "선택"}",
                  ),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => _selectDateTime(context, false),
                  child: Text(
                    "종료시간: ${_endDateTime != null ? DateFormat('yyyy-MM-dd HH:mm').format(_endDateTime!) : "선택"}",
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // 라벨 선택
            DropdownButtonFormField<String>(
              value: _selectedLabel,
              items: _labelColors.keys
                  .map((label) => DropdownMenuItem(
                value: label,
                child: Text(
                  label,
                  style: TextStyle(color: _labelColors[label]),
                ),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedLabel = value!;
                });
              },
              decoration: InputDecoration(
                labelText: "라벨",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            // 알림과 진동
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isAlarmOn = !_isAlarmOn; // 알림 상태 토글
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isAlarmOn ? Colors.red : Colors.grey, // 알림 상태 색상
                  ),
                  child: Text(
                    "알림 ${_isAlarmOn ? 'ON' : 'OFF'}",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(width: 30), // 버튼 간격
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isVibrationOn = !_isVibrationOn; // 진동 상태 토글
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isVibrationOn ? Colors.red : Colors.grey, // 진동 상태 색상
                  ),
                  child: Text(
                    "진동 ${_isVibrationOn ? 'ON' : 'OFF'}",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // 메모 입력
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "일정에 대한 간단한 메모",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}