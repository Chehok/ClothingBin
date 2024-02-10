import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:mobile/screens/home/home_screen.dart';
import 'package:mobile/services/bin_function.dart';
import 'package:flutter/services.dart';

class ProfileScreen extends StatefulWidget {
  final Map<String, dynamic> userInfo;

  const ProfileScreen({Key? key, required this.userInfo}) : super(key: key);

  @override
  State<ProfileScreen> createState() => ProfileScreenState();
// @override
// ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  String _imageLink = '';

  bool _isEditing = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  Future<void> _getImage() async {
    var result = await uploadFile();
    setState(() {
      _imageLink = result?['result'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('프로필 수정'),
        backgroundColor: Colors.indigoAccent,
      ),
      body: widget.userInfo.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              // child: _buildProfileView(),
              child: Column(
                children: [
                  const SizedBox(height: 40.0),
                  GestureDetector(
                    onTap: () {
                      _getImage();
                    },
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.white,
                      child: _imageLink != '' ? Image.network(_imageLink)
                          : widget.userInfo['profileImg'] != "" ? Image.network(widget.userInfo['profileImg'])
                          : Image.asset('assets/images/user.png'),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: '변경할 이름',
                      hintText: '${widget.userInfo['name']}',
                    ),
                  ),
                  const Divider(),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: '변경할 이메일',
                      hintText: '${widget.userInfo['email']}',
                    ),
                  ),
                  const Divider(),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
                      LengthLimitingTextInputFormatter(11),
                    ],
                    controller: _phoneNumberController,
                    decoration: InputDecoration(
                      labelText: '변경할 번호',
                      hintText: '${widget.userInfo['phoneNum']}',
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      // _toggleEditing();
                      modifyUserInfo(_nameController.text, _imageLink,
                          _emailController.text, _phoneNumberController.text);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('프로필 수정'),
                            content: const Text('프로필 수정이 완료되었습니다.'),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home()));
                                },
                                child: const Text('확인'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text(
                      '저장',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

//   Widget _buildTextField({
//     required String hintText,
//     required TextEditingController controller,
//     bool isEditable = false,
//   }) {
//     return TextField(
//       controller: controller,
//       enabled: isEditable,
//       style: TextStyle(fontSize: 16.0),
//       decoration: InputDecoration(
//         hintText: hintText,
//         isDense: true,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10.0),
//           borderSide: BorderSide(
//             color: Colors.grey,
//             width: 1.0,
//           ),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10.0),
//           borderSide: BorderSide(
//             color: Colors.grey,
//             width: 1.0,
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10.0),
//           borderSide: BorderSide(
//             color: Colors.indigoAccent,
//             width: 1.0,
//           ),
//         ),
//         contentPadding: EdgeInsets.symmetric(
//           vertical: 14.0,
//           horizontal: 16.0,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildProfileItem(
//       String label, String hintText, TextEditingController controller) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: TextStyle(fontSize: 16.0),
//           ),
//           Expanded(
//             child: Container(
//               alignment: Alignment.centerRight,
//               child: _isEditing
//                   ? _buildTextField(
//                       hintText: hintText,
//                       controller: controller,
//                       isEditable: true,
//                     )
//                   : _buildTextField(
//                       hintText: hintText,
//                       controller: controller,
//                       isEditable: false,
//                     ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildProfileView() {
//     return Column(
//       children: [
//         SizedBox(height: 40.0),
//         CircleAvatar(
//           radius: 80,
//           child: Image.asset('assets/images/user.png'),
//           backgroundColor: Colors.white,
//         ),
//         SizedBox(height: 20.0),
//         _buildProfileItem('', '변경할 이름을 입력해주세요', _nameController),
//         Divider(),
//         _buildProfileItem('', '변경할 이메일을 입력해주세요', _emailController),
//         Divider(),
//         _buildProfileItem('', '변경할 전화번호를 입력해주세요', _phoneNumberController),
//         SizedBox(height: 20.0),
//         ElevatedButton(
//           onPressed: () {
//             _toggleEditing();
//             showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return AlertDialog(
//                   title: Text('프로필 수정'),
//                   content: Text('프로필 수정이 완료되었습니다.'),
//                   actions: [
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) => Home()));
//                       },
//                       child: Text('확인'),
//                     ),
//                   ],
//                 );
//               },
//             );
//           },
//           child: Text(
//             '저장',
//             style: TextStyle(fontSize: 18.0),
//           ),
//         ),
//       ],
//     );
//   }
}
