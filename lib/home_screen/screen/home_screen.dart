import 'package:chat_app/home_screen/screen/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/chat_user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

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
          _buildSearchTextField(context),
          const Divider(),
          StreamBuilder(
              stream: FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Text('Ошибка: ${snapshot.error}');
                }
                var documents = snapshot.data!.docs;
                List<ChatUser> usersFromFirestore = List.generate(documents.length, (index) {
                  var userData = documents[index].data();
                  String firstName = userData['name'] ?? '';
                  String lastName = userData['lastName'] ?? '';
                  String date = userData['date'] ?? '';
                  String myMessage = userData['myMessage'] ?? '';
                  String youMessage = userData['youMessage'] ?? '';
                  return ChatUser(firstName: firstName, lastName: lastName, date: date, youMessage: youMessage, myMessage: myMessage);
                });
                return Expanded(
                  child: ListView.builder(
                    itemCount: usersFromFirestore.length,
                    itemBuilder: (context, index) {
                      if (usersFromFirestore.isEmpty) {
                        return Container(); // Возвращаем пустой контейнер, если список пуст
                      }
                      ChatUser user = usersFromFirestore[index];
                      int colorIndex = index % avatarColors.length;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              // height: MediaQuery.of(context).size.height * 0.12,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatScreen(user: user, avatarColor: avatarColors[colorIndex])));
                                },
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 35,
                                      backgroundColor: avatarColors[colorIndex],
                                      child: Text('${user.firstName[0]}${user.lastName[0]}', style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
                                    ),
                                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                                    Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('${user.firstName} ${user.lastName}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                          user.myMessage.isEmpty
                                          ? Text(user.youMessage)
                                          : Row(
                                            children: [
                                              Text('Вы: ', style: TextStyle(color: Color(0xFF2B333E), fontSize: 12, fontWeight: FontWeight.w500)),
                                              Text(user.myMessage, style: TextStyle(color: Color(0xFF5E7A90), fontSize: 12, fontWeight: FontWeight.w500)),
                                            ],
                                          ),
                                        ]
                                    ),
                                    Spacer(),
                                    Transform.translate(
                                      offset: Offset(0, -20), // Установите отрицательное значение смещения
                                      child: Text(user.date),
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
                );
              }),
        ],
      ),
    );
  }

  Widget _buildSearchTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          const Text('Чаты', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600)),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.07,
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
    );
  }
}
