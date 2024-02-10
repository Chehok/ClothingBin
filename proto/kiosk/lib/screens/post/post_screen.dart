import 'package:flutter/material.dart';
import 'package:kiosk/constants/variable.dart';
import 'package:kiosk/api/bin_function.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final List<String> clothingCategories = [
    'category1',
    'category2',
    'category3'
  ];
  late String _clothName;
  late String _price;
  String? _category; // null 대신 초기값을 지정합니다.(이유: 널값이 들어가서 그냥 얘가 다 널로 인식함)
  String? _description; // null 대신 초기값을 지정합니다.
  String? _imgLink; // null 대신 초기값을 지정합니다.
  String? _insertDate; // null 대신 초기값을 지정합니다.
  int _lockerNum = 1;

  static const String baseUrl = 'http://210.123.255.110:8080/app';

  void _submitCloth() async {
    if (_formKey.currentState!.validate()) {
      try {
        await inputCloth(
          _clothName,
          _category ?? "",
          // null 대신 빈 문자열을 전달합니다.
          _price,
          _description ?? "",
          // null 대신 빈 문자열을 전달합니다.
          _imgLink ?? "",
          // null 대신 빈 문자열을 전달합니다.
          _insertDate ?? "",
          // null 대신 빈 문자열을 전달합니다.
          clothingBinId,
          _lockerNum,
          userId,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('의류가 등록되었습니다.')),
        );
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('오류가 발생하였습니다.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('의류 등록'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: '의류명'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '의류명을 입력해주세요.';
                  }
                  return null;
                },
                onChanged: (value) => _clothName = value,
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(labelText: '가격'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '가격을 입력해주세요.';
                  }
                  final number = num.tryParse(value);
                  if (number == null) {
                    return '올바른 가격을 입력해주세요.';
                  }
                  return null;
                },
                onChanged: (value) => _price = value,
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _category,
                decoration: InputDecoration(labelText: '카테고리'),
                items: clothingCategories
                    .map((category) => DropdownMenuItem(
                  child: Text(category),
                  value: category,
                ))
                    .toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '카테고리를 선택해주세요.';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _category = value!;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(labelText: '설명'),
                maxLines: 3,
                onChanged: (value) => _description = value,
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(labelText: '이미지 링크'),
                onChanged: (value) => _imgLink = value,
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(labelText: '입고일자'),
                keyboardType: TextInputType.datetime,
                onChanged: (value) => _insertDate = value,
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  _submitCloth();
                  Navigator.pop(context);
                },
                child: Text('등록하기'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}