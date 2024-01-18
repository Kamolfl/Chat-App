import 'package:chat_app/home_screen/model/chat_user.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.user, required this.avatarColor});
  final ChatUser user;
  final Color avatarColor;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 30,)),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: widget.avatarColor,
                  child: Text('${widget.user.firstName[0]}${widget.user.lastName[0]}', style: const TextStyle(color: Colors.white)),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${widget.user.firstName} ${widget.user.lastName}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                    const Text('В сети', style: TextStyle(color: Color(0xFF5E7A90)))
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.15,
                height: MediaQuery.of(context).size.height * 0.08,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFFEDF2F6),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Image.asset('assets/images/Attach.png'),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.02,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.65,
                height: MediaQuery.of(context).size.height * 0.08,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFFEDF2F6),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      labelText: 'Сообщение',
                      labelStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF9DB7CB),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.02,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.15,
                height: MediaQuery.of(context).size.height * 0.08,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFFEDF2F6),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Image.asset('assets/images/Audio.png'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
