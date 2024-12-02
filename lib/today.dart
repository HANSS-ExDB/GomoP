import 'package:flutter/material.dart';
import 'add_today.dart';
import 'calender.dart';
import 'info.dart';

class today extends StatefulWidget {
  @override
  _TodayPageState createState() => _TodayPageState();
}

class _TodayPageState extends State<today> {
  String _selectedLabel = "전체"; // 라벨 필터링
  String _sortOrder = "제목순"; // 정렬 기준

  int _selectedIndex = 1; // 현재 선택된 버튼 인덱스
  List<bool> _checkedItems = []; // 체크박스 상태 관리

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CalendarPage()), // 달력 화면으로 이동
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => info()), // 나의 정보 화면으로 이동
      );
    }
  }

  // 정렬 방법에 따라 일정 정렬 (예시로 정렬 로직 추가)
  List<Map<String, String>> _sortEvents(List<Map<String, String>> events) {
    if (_sortOrder == "제목순") {
      events.sort((a, b) => a['title']!.compareTo(b['title']!));
    } else if (_sortOrder == "종료시간순") {
      events.sort((a, b) => a['endTime']!.compareTo(b['endTime']!));
    }
    return events;
  }

  @override
  Widget build(BuildContext context) {
    // 예시 일정 목록 (Firestore 제거로 임시 데이터 사용)
    List<Map<String, String>> events = [
      {'title': '회의', 'startTime': '10:00', 'endTime': '11:00', 'label': '업무'},
      {'title': '점심', 'startTime': '12:00', 'endTime': '13:00', 'label': '개인'},
      {'title': '프로젝트 리뷰', 'startTime': '14:00', 'endTime': '15:00', 'label': '중요'},
    ];

    if (_selectedLabel != "전체") {
      events = events.where((event) => event['label'] == _selectedLabel).toList();
    }
    events = _sortEvents(events); // 정렬 적용

    // 체크박스 상태 초기화
    if (_checkedItems.length != events.length) {
      _checkedItems = List.generate(events.length, (index) => false);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('오늘의 일정'),
        backgroundColor: Colors.red,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 정렬하기 및 라벨로 정렬하기 버튼
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 라벨 선택
                DropdownButton<String>(
                  value: _selectedLabel,
                  items: [
                    DropdownMenuItem(value: "전체", child: Text("전체")),
                    DropdownMenuItem(value: "업무", child: Text("업무")),
                    DropdownMenuItem(value: "개인", child: Text("개인")),
                    DropdownMenuItem(value: "중요", child: Text("중요")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedLabel = value!;
                    });
                  },
                ),

                // 정렬하기 버튼
                ElevatedButton(
                  onPressed: () {
                    // 정렬 방식 선택
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('정렬하기'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RadioListTile<String>(
                              title: Text("제목순"),
                              value: "제목순",
                              groupValue: _sortOrder,
                              onChanged: (value) {
                                setState(() {
                                  _sortOrder = value!;
                                });
                                Navigator.pop(context);
                              },
                            ),
                            RadioListTile<String>(
                              title: Text("종료시간순"),
                              value: "종료시간순",
                              groupValue: _sortOrder,
                              onChanged: (value) {
                                setState(() {
                                  _sortOrder = value!;
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Text('정렬하기'),
                ),
              ],
            ),
          ),

          // 일정 목록
          Expanded(
            child: ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                var event = events[index];
                return ListTile(
                  leading: Checkbox(
                    value: _checkedItems[index],
                    onChanged: (bool? value) {
                      setState(() {
                        _checkedItems[index] = value!;
                      });
                    },
                  ),
                  title: Text(event['title'] ?? '제목 없음'),
                  subtitle: Text(
                      '시작: ${event['startTime'] ?? '시작 시간 미정'} - 종료: ${event['endTime'] ?? '종료 시간 미정'}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 수정 버튼
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // 수정 페이지로 이동 (데이터 연결을 해주세요)
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('일정 수정'),
                              content: Text('일정을 수정할 수 있는 페이지로 이동합니다.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => addtoday()),
                                    );
                                  },
                                  child: Text('확인'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      // 삭제 버튼
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          // 삭제 로직 (Firestore 관련 없음, 예시로 UI에만 반영)
                          setState(() {
                            events.removeAt(index);
                            _checkedItems.removeAt(index); // 체크박스 상태도 동기화
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // 오늘의 일정 추가하기 버튼 (중앙에 크게 배치)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // 일정 추가 페이지로 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => addtoday(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(200, 60), // 버튼 크기 크게 설정
                  textStyle: TextStyle(fontSize: 18), // 글자 크기 조정
                ),
                child: Text('오늘의 일정 추가하기'),
              ),
            ),
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
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class AddSchedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("일정 추가하기")),
      body: Center(child: Text("일정 추가 페이지")),
    );
  }
}