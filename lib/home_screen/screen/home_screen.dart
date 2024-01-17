import 'package:chat_app/home_screen/screen/chat_screen.dart';
import 'package:flutter/material.dart';

import '../model/chat_user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<ChatUser> chatUsers = [
    ChatUser(firstName: 'Виктор', lastName: 'Власов', lastMessage: 'Уже сделал?', lastSeen: 'Вчера'),
    ChatUser(firstName: 'Саша', lastName: 'Алексеев', lastMessage: 'Я готов!', lastSeen: '12.01.22'),
    ChatUser(firstName: 'Пётр', lastName: 'Жаринов', lastMessage: 'Я вышел', lastSeen: '2 минуты назад'),
    ChatUser(firstName: 'Алина', lastName: 'Жукова', lastMessage: 'Я вышел', lastSeen: '09:23'),
  ];

  List<Color> avatarColors = [
    Colors.green,
    Colors.red,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.indigo,
    Colors.amber,
    Colors.brown,
    Colors.pink,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                const Text('Чаты', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600)),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.08,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFEDF2F6),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Image.asset('assets/images/Search_s.png'),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                        Expanded(
                          child: TextFormField(
                            controller: _searchController,
                            decoration: const InputDecoration(
                              hintText: 'Поиск',
                              hintStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF9DB7CB),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: chatUsers.length,
              itemBuilder: (context, index) {
                ChatUser user = chatUsers[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        // height: MediaQuery.of(context).size.height * 0.12,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatScreen(user: user, avatarColor: avatarColors[index])));
                          },
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundColor: avatarColors[index],
                                child: Text('${user.firstName[0]}${user.lastName[0]}', style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${user.firstName}, ${user.lastName}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                    Text(user.lastMessage, style: const TextStyle(color: Color(0xFF5E7A90))),
                                  ]
                              ),
                              Spacer(),
                              Transform.translate(
                                offset: Offset(0, -20), // Установите отрицательное значение смещения
                                child: Text(user.lastSeen),
                              )
                            ],
                          ),
                        ),
                      ),
                      const Divider(),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
