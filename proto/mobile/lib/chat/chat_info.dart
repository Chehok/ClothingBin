import 'package:flutter/material.dart';

class ChatMessage {
  final String sender;
  final String message;
  final String time;
  final String profileImage;

  ChatMessage({
    required this.sender,
    required this.message,
    required this.time,
    required this.profileImage,
  });
}

class ChatInfo extends StatefulWidget {
  const ChatInfo({Key? key}) : super(key: key);

  @override
  _ChatInfoState createState() => _ChatInfoState();
}

class _ChatInfoState extends State<ChatInfo>
    with SingleTickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  late AnimationController _controller;
  final List<ChatMessage> chatMessages = [
    ChatMessage(
      sender: '나',
      message: '안녕하세요. 반갑습니다.',
      time: '10-25 10:05',
      profileImage: 'assets/images/profile2.png',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void sendMessage(String message) {
    final newMessage = ChatMessage(
      sender: '나',
      message: message,
      time: '${DateTime.now().toString().substring(5, 16)}',
      profileImage: 'assets/images/profile2.png',
    );

    setState(() {
      chatMessages.add(newMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('김민준'),
        backgroundColor: Colors.indigoAccent,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.phone),
            onPressed: () {
              // Handle phone button pressed
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0.0, (1 - _controller.value) * 50),
                  child: ListView.builder(
                    // Reverse the list to show new messages at the bottom
                    itemCount: chatMessages.length,
                    itemBuilder: (context, index) {
                      final message = chatMessages[index];
                      final isSender = message.sender == '나';
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: isSender
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            if (!isSender)
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage(message.profileImage),
                              ),
                            SizedBox(width: 8.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: isSender
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  if (isSender)
                                    Text(
                                      message.time,
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  SizedBox(height: 4.0),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: isSender
                                          ? Colors.indigoAccent
                                          : Colors.grey,
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    padding: EdgeInsets.all(12.0),
                                    child: Text(
                                      message.message,
                                      style: TextStyle(
                                          fontSize: 20.0, color: Colors.white),
                                    ),
                                  ),
                                  if (!isSender)
                                    Text(
                                      message.time,
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(width: 8.0),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    // Handle add button pressed
                  },
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _messageController,
                            decoration: InputDecoration(
                              hintText: '채팅 보내기',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 12.0),
                            ),
                            // onSubmitted: (value) {
                            //   sendMessage(value);
                            // },
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.emoji_emotions),
                          onPressed: () {
                            // Handle emoji button pressed
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Handle send button pressed
                    sendMessage(_messageController.text);
                    _messageController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
