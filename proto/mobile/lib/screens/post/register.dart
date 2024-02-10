import 'package:flutter/material.dart';
import 'package:mobile/constants/variable.dart';
import 'package:mobile/services/bin_function.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mobile/states/user_provider.dart';

class Post extends StatefulWidget {
  const Post({Key? key}) : super(key: key);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  final _formKey = GlobalKey<FormState>();
  final List<String> clothingCategories = ['상의', '하의', '신발', '기타'];
  late String _clothName;
  late String _price;
  String? _category;
  String? _description;
  String? _imageLink;
  String? _localDirectory;
  int _lockerNum = 1;

  void _inputCloth() async {
    if (_formKey.currentState!.validate()) {
      try {
        await inputCloth(
          _clothName,
          _category ?? '',
          _price,
          _description ?? '',
          _imageLink ?? '',
          clothingBinId,
          _lockerNum,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("의류가 등록되었습니다.")),
        );
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('오류가 발생하였습니다.')),
        );
      }
    }
  }

  Future<void> _getImage() async {
    var result = await uploadFile();
    _imageLink = result?['result'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('의류 등록'),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Container(
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
                ElevatedButton(
                  onPressed: _getImage,
                  child: Text('이미지 선택'),
                ),
                // SizedBox(height: 20),
                // if (_imageLink != null)
                //   Image.file(
                //     _localDirectory!,
                //     height: 200,
                //     width: 200,
                //     fit: BoxFit.cover,
                //   ),
                if (_imageLink != null)
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: NetworkImage(
                        _imageLink!,
                      ),
                    ),
                  ),
                ),
                // SizedBox(height: 20),
                // TextFormField(
                //   decoration: InputDecoration(labelText: '입고일자'),
                //   keyboardType: TextInputType.datetime,
                //   onChanged: (value) => _insertDate = value,
                // ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    _inputCloth();
                    Navigator.pop(context);
                  },
                  child: Text('등록하기'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}