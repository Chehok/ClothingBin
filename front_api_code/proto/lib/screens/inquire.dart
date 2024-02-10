import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class InquireScreen extends StatefulWidget {
  const InquireScreen({Key? key}) : super(key: key);

  @override
  State<InquireScreen> createState() => _InquireScreenState();
}

class _InquireScreenState extends State<InquireScreen> {
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("의류 조회"),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 120,
                  ),
                  Flexible(
                    child: DropdownButtonFormField<String>(
                      value: _selectedCategory,
                      decoration: InputDecoration(
                        labelText: '정렬',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value!;
                        });
                      },
                      items: [
                        DropdownMenuItem(value: '최신', child: Text('최신순')),
                        DropdownMenuItem(value: '오래됨', child: Text('오래된순')),
                        DropdownMenuItem(value: '낮은가격', child: Text('낮은가격순')),
                        DropdownMenuItem(value: '높은가격', child: Text('높은가격순')),
                        DropdownMenuItem(value: '무료나눔', child: Text('무료나눔')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Flexible(
              flex: 1,
              child: Container(
                child: Align(
                  alignment: Alignment.center,
                  child: Text('등록된 의류 목록입니다.'),
                ),
              ),
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Row(
                children: [
                  Icon(
                    Icons.person,
                    size: 90,
                  ),
                  Text(
                    '인증 정보',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 38,
                        color: Colors.white),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
            ),
            ListTile(
              title: Text('전체 의류'),
              onTap: () {
                // 메뉴 선택시 처리할 내용
              },
            ),
            ListTile(
              title: Text('상의'),
              onTap: () {
                // 메뉴 선택시 처리할 내용
              },
            ),
            ListTile(
              title: Text('하의'),
              onTap: () {
                // 메뉴 선택시 처리할 내용ㄴ
              },
            ),
            ListTile(
              title: (Text('신발')),
            ),
            ListTile(
              title: (Text('가방')),
            )
          ],
        ),
      ),
    );
  }
}
