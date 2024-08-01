import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit4try/constants/fonts.dart';
import 'package:fit4try/screens/user/messages_screen.dart';
import 'package:fit4try/screens/user/guest_user_screen.dart';
import 'package:fit4try/screens/user/home.dart';
import 'package:fit4try/screens/user/message_screen.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationItem> notifications = [
    NotificationItem(
      username: 'ahmet.ege',
      message: 'Tarzını beğenildi!\n"ahmet.ege adlı kullanıcı tarzını beğendi"',
      time: '1 dk. önce',
      avatarPath: 'assets/images/foto1.png',
    ),
    NotificationItem(
      username: 'dilaraa.19',
      message:
          'Tarzını beğenildi!\n"dilaraa.19 adlı kullanıcı tarzını beğendi"',
      time: '35 dk. önce',
      avatarPath: 'assets/images/foto2.png',
    ),
    NotificationItem(
      username: 'dilaraa.19',
      message:
          'Dikkatleri çekiyorsun!\n"dilaraa.19 adlı kullanıcı seni takip etmek istiyor"',
      time: '36 dk. önce',
      avatarPath: 'assets/images/foto2.png',
    ),
    NotificationItem(
      username: 'mstfkrt82',
      message:
          'Bir mesajın var!\n"mstfkrt82 adlı kullanıcı sana mesaj gönderdi"',
      time: '1 saat önce',
      avatarPath: 'assets/images/foto3.png',
    ),
    NotificationItem(
      username: 'ayse.gull',
      message: 'Tarzını beğenildi!\n"ayse.gull adlı kullanıcı tarzını beğendi"',
      time: '5 saat önce',
      avatarPath: 'assets/images/foto4.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor1,
        automaticallyImplyLeading: false,
        toolbarHeight: 80, // Adjust this value to move the bar lower
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(
              top: 50.0), // Adjust this value to move the bar lower
          child: SearchBar(),
        ),
      ),
      backgroundColor: AppColors.backgroundColor1,
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return NotificationTile(
            notification: notifications[index],
            onAccept: () {
              setState(() {
                notifications[index].isRead = true;
              });
            },
            onReject: () {
              setState(() {
                notifications.removeAt(index);
              });
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType
            .fixed, // İkonların hareket etmesini istersek bu satırı kaldırırız
        onTap: (index) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MyHomePagess(
                      initialIndex: index,
                    )),
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

class NotificationItem {
  final String username;
  final String message;
  final String time;
  final String avatarPath;
  bool isRead;

  NotificationItem({
    required this.username,
    required this.message,
    required this.time,
    required this.avatarPath,
    this.isRead = false,
  });
}

class NotificationTile extends StatefulWidget {
  final NotificationItem notification;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  NotificationTile({
    required this.notification,
    required this.onAccept,
    required this.onReject,
  });

  @override
  _NotificationTileState createState() => _NotificationTileState();
}

class _NotificationTileState extends State<NotificationTile> {
  bool showActions = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          showActions = !showActions;
        });
      },
      child: Card(
        color: widget.notification.isRead ? Colors.grey[200] : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(widget.notification.avatarPath),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.notification.username,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    widget.notification.time,
                    style: TextStyle(color: Color(0xFF8819DC)),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                widget.notification.message,
                style: TextStyle(color: Color(0xFF8819DC)),
              ),
              if (showActions)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: widget.onAccept,
                      icon: Image.asset(
                        'assets/images/tik.png',
                        width: 50,
                        height: 50,
                      ),
                    ),
                    IconButton(
                      onPressed: widget.onReject,
                      icon: Image.asset(
                        'assets/images/çarpı.png',
                        width: 50,
                        height: 50,
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
                      'assets/icon/arama.png', // Replace with your .png icon path
                      width: 20,
                      height: 20,
                    ),
                    onPressed: () {
                      // Handle search icon press
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 5), // Add space between search bar and icons
        Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: Image.asset(
                  'assets/icon/bildirim.png', // Replace with your .png icon path
                  width: 30,
                  height: 30,
                ),
                onPressed: () {
                  // Handle notification icon press
                },
              ),
              IconButton(
                icon: Image.asset(
                  'assets/icon/send.png', // Replace with your .png icon path
                  width: 30,
                  height: 30,
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MessagesScreen()));
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
          'uid': doc.id, // Store the uid of the user
          'name': doc['displayName'] ?? 'No Name',
          'username': doc['username'] ?? 'No Username',
          'image': doc['photoUrl'] ?? 'assets/images/placeholder_profile.jpg',
        };
      }).toList();
      displayedUsers =
          allUsers.take(9).toList(); // Initially show the first 9 users
    });
  }

  @override
  Widget build(BuildContext context) {
    // Filter based on query and limit to 9 displayed users
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
                    // Navigate to user profile screen and pass uid
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
