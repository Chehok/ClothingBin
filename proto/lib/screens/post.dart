import 'package:flutter/material.dart';
import 'package:proto/screens/qr_screen.dart';

class Post extends StatefulWidget {
  @override
  _PostState createState() =>
      _PostState();
}

class _PostState
    extends State<Post> {
  String _selectedCategory = '전체 의류';
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('의류 등록'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 16.0),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> QrScreen(), fullscreenDialog: true));
                },
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: Colors.grey),
                    ),
                    child: Image.asset(''),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: '상품 제목',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: '설명',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: InputDecoration(
                  labelText: '카테고리',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
                items: [
                  DropdownMenuItem(value: '전체 의류', child: Text('전체 의류')),
                  DropdownMenuItem(value: '상의', child: Text('상의')),
                  DropdownMenuItem(value: '하의', child: Text('하의')),
                  DropdownMenuItem(value: '신발', child: Text('신발')),
                  DropdownMenuItem(value: '가방', child: Text('가방')),
                ],
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: '상품의 가격을 입력해주세요. 가격 미입력시 기부 처리 됩니다.',
                  border: OutlineInputBorder(
                  ),
                ),
              ),
              SizedBox(height: 32.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.height * 0.2,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.teal)),
                      onPressed: () {},
                      child: Text('등록',style: TextStyle(fontSize: 25),),
                    ),
                  ),
                  SizedBox(width:90, height: 50.0),
                  Container(
                    width: MediaQuery.of(context).size.height * 0.2,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('취소', style: TextStyle(fontSize: 25),),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
