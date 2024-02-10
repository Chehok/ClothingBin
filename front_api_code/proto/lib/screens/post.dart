import 'package:flutter/material.dart';

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
              Center(
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Colors.grey),
                  ),
                  child: Icon(Icons.camera_alt),
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
                  labelText: '가격',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {},
                child: Text('등록'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {},
                child: Text('기부'),
              ),
              SizedBox(height: 16.0),
              TextButton(
                onPressed: () {},
                child: Text('취소'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
