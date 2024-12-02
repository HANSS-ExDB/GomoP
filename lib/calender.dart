import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'today.dart';
import 'info.dart';
import 'add_today.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  // 달력에서 선택한 날짜
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  // 일정 데이터
  Map<DateTime, List<String>> _events = {
    DateTime(2024, 11, 18): ['미팅', '프로젝트 진행'],
  };

  // 선택한 날짜에 일정 추가
  List<String> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  int _selectedIndex = 0; // 현재 선택된 버튼 인덱스

  void _onItemTapped(int index) {
    if (index == _selectedIndex) {
      // 현재 선택된 버튼을 다시 누른 경우, 아무 동작도 하지 않음
      return;
    }

    setState(() {
      _selectedIndex = index;
    });

    // 버튼 클릭 시 네비게이션
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => today(), // 새 화면 위젯
        ),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => info(), // 다른 화면 위젯
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("일정 관리"),
      ),
      body: Column(
        children: [
          // 달력
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            eventLoader: _getEventsForDay,
          ),

          // 선택한 날짜에 대한 일정 표시
          ..._getEventsForDay(_selectedDay).map(
                (event) => ListTile(
              title: Text(event),
            ),
          ),

          // 일정 추가 버튼
          ElevatedButton(
            onPressed: () {
              // 새로운 페이지로 이동
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => addtoday(), // AddToday 클래스 사용
                ),
              );
            },
            child: Text("일정 추가"),
          ),
        ],
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