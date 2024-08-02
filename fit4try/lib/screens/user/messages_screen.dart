import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit4try/constants/fonts.dart';
import 'package:fit4try/screens/user/guest_user_screen.dart';
import 'package:fit4try/screens/user/home.dart';
import 'package:fit4try/screens/user/message_screen.dart';
import 'package:fit4try/widgets/loading.dart';
import 'package:flutter/material.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor1,
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: SearchBar(),
        ),
      ),
      backgroundColor: AppColors.backgroundColor1,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('chats').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: LoadingWidget());
          }

          return ListView(
            children: snapshot.data!.docs.map((document) {
              return ListTile(
                title: Text(document['username']),
                subtitle: Text(document['lastMessage']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MessageScreen(
                        chatId: document.id,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MyHomePagess(
                initialIndex: index,
              ),
            ),
          );
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icon/home.png',
              width: 36,
              height: 36,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icon/community.png',
              width: 36,
              height: 36,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icon/picture.png',
              width: 36,
              height: 36,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icon/aı.png',
              width: 36,
              height: 36,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 12,
              backgroundImage: AssetImage('assets/icon/foto.png'),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 7,
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return SearchBottomSheet();
                },
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Ara',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  IconButton(
                    icon: Image.asset(
                      'assets/icon/arama.png',
                      width: 20,
                      height: 20,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 5),
        Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: Image.asset(
                  'assets/icon/bildirim.png',
                  width: 30,
                  height: 30,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Image.asset(
                  'assets/icon/send.png',
                  width: 30,
                  height: 30,
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          MessageScreen(chatId: 'exampleChatId')));
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SearchBottomSheet extends StatefulWidget {
  @override
  _SearchBottomSheetState createState() => _SearchBottomSheetState();
}

class _SearchBottomSheetState extends State<SearchBottomSheet> {
  List<Map<String, dynamic>> allUsers = [];
  List<Map<String, dynamic>> displayedUsers = [];
  String query = '';

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  void fetchUsers() async {
    final snapshot = await FirebaseFirestore.instance.collection('users').get();
    final userDocs = snapshot.docs;

    setState(() {
      allUsers = userDocs.map((doc) {
        return {
          'uid': doc.id,
          'name': doc['displayName'] ?? 'No Name',
          'username': doc['username'] ?? 'No Username',
          'image': doc['photoUrl'] ?? 'assets/images/placeholder_profile.jpg',
        };
      }).toList();
      displayedUsers = allUsers.take(9).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    displayedUsers = allUsers
        .where((user) {
          return user['name']!.toLowerCase().contains(query.toLowerCase());
        })
        .toList()
        .take(9)
        .toList();

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(Icons.search),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Ara',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      setState(() {
                        query = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: displayedUsers.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GuestUserProfileScreen(
                            uid: displayedUsers[index]['uid']),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            NetworkImage(displayedUsers[index]['image']!),
                      ),
                      SizedBox(height: 10),
                      Text(
                        displayedUsers[index]['name']!,
                        style: TextStyle(fontSize: 15),
                      ),
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
