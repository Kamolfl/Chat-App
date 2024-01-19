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
  bool isTyping = false;

  @override
  void initState() {
    super.initState();
    _messageController.addListener(() {
      setState(() {
        isTyping = _messageController.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          _buildMyAppBar(context),
          const Divider(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildContainerDate(context, '27.01.22'),
                  _buildMessageSend(context, 'Сделай мне кофе, пожалуйста', '21:41', 'assets/images/Read.png', 'assets/images/VectorRight.png'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 29),
                          child: Image.asset('assets/images/VectorLeft.png'),
                        ),
                        Container(
                          constraints: const BoxConstraints(
                            minHeight: 50,
                          ),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(20),
                            ),
                            color: Color(0xFFEDF2F6),
                          ),
                          child: const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                    "Окей",
                                    style: TextStyle(
                                      color: Color(0xFF2B333E),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    )
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 10, right: 10),
                                    child: Text(
                                        "21:41",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF2B333E)
                                        )
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildContainerDate(context, 'Сегодня'),
                  _buildMessageSend(context, 'Уже сделал?', '21:41', 'assets/images/UnRead.png', 'assets/images/VectorRight.png'),
                ],
              ),
            ),
          ),
          _buildInputArea(context),
        ],
      ),
    );
  }

  Widget _buildMessageSend(BuildContext context, String title, String subtitle, String firstImage, String secondImage) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            constraints: const BoxConstraints(
              minHeight: 50,
            ),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(0),
                ),
                color: Color(0xFF3CED78)
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                      title,
                      style: const TextStyle(
                        color: Color(0xFF00521C),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      )
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                          subtitle,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF00521C)
                          )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 26,left: 3, right: 15, bottom: 8),
                      child: Image.asset(
                        firstImage,
                        width: 12,
                        height: 7,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 29),
            child: Image.asset(secondImage),
          )
        ],
      ),
    );
  }

  Widget _buildInputArea(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildActionButton(context, 'assets/images/Attach.png'),
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
              Expanded(child: _buildMessageTextFormField(context)),
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
              isTyping
                  ? _buildSendContainer()
                  : _buildActionButton(context, 'assets/images/Audio.png')
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, String assetName) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.15,
      height: MediaQuery.of(context).size.height * 0.068,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFEDF2F6),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Image.asset(assetName),
      ),
    );
  }

  Widget _buildSendContainer() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.15,
      height: MediaQuery.of(context).size.height * 0.068,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFEDF2F6),
      ),
      child: IconButton(onPressed: () {}, icon: const Icon(Icons.send, color: Colors.blue, size: 30)),
    );

  }

  Widget _buildMessageTextFormField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFEDF2F6),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: TextFormField(
          controller: _messageController,
          maxLines: 5,
          minLines: 1,
          decoration: const InputDecoration(
            hintText: 'Сообщение',
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF9DB7CB),
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildMyAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          IconButton(onPressed: () {
            Navigator.pop(context);
          }, icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 30)),
          SizedBox(width: MediaQuery.of(context).size.width * 0.02),
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
    );
  }

  Widget _buildContainerDate(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.35,
            height: MediaQuery.of(context).size.height * 0.005,
            color: const Color(0xFFEDF2F6),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.35,
            height: MediaQuery.of(context).size.height * 0.005,
            color: const Color(0xFFEDF2F6),
          ),
        ],
      ),
    );
  }
}
