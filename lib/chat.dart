import 'package:flutter/material.dart';

void main(){
  runApp(const Kakao());
}


class Kakao extends StatelessWidget{
  const Kakao({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      ),
      home: const ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget{
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenStatus();

}


class Chat {
  final String name;
  final String message;
  final bool isMe;
  final String timestamp;
  Chat(this.name, this.message, this.isMe, this.timestamp);
}

class _ChatScreenStatus extends State<ChatScreen> {
  TextEditingController textEditingController = TextEditingController();
  List<dynamic> _chats = [
    Chat("엄준식", "엄", false, DateTime.now().toString()),
    Chat("김상준", "준", true, DateTime.now().toString()),
    Chat("엄준식", "식", false, DateTime.now().toString()),
  ];

  void _addChat(String name, String message, bool isMe){
    if(message.isNotEmpty) {
      setState(() {
        _chats.add(
          Chat(name,message,isMe,DateTime.now().toString())
        );
        textEditingController.clear();
      });
    }
  }

  Widget _chatItem(Chat chat) {
    return Align(
      alignment: chat.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: 250),
        child: Column(
          crossAxisAlignment: chat.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              chat.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: chat.isMe ? Colors.blue[100] : Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                chat.message,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Text(
              chat.timestamp,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: false,
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amberAccent,
          title: Text("엄준식"),
        ),
        body: Column(
            children: [
              Expanded(
                  child: ListView.builder(
                      itemBuilder: (context, index){
                        return _chatItem(_chats[index]);
                      },
                      itemCount: _chats.length)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: textEditingController,
                        decoration: InputDecoration(
                          hintText: 'Type a message',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        _addChat("김상준", textEditingController.text, true);
                      },
                    ),
                  ],
                ),
              ),
            ]
        )
    );
  }
}
