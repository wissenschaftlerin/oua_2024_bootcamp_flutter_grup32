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
      message: 'Tarzını beğenildi!\n"dilaraa.19 adlı kullanıcı tarzını beğendi"',
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
      message: 'Bir mesajın var!\n"mstfkrt82 adlı kullanıcı sana mesaj gönderdi"',
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
        toolbarHeight: 80, // Adjust this value to move the bar lower
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 50.0), // Adjust this value to move the bar lower
          child: SearchBar(),
        ),
      ),
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
        type: BottomNavigationBarType.fixed, // İkonların hareket etmesini istersek bu satırı kaldırırız
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
                  // Handle send icon press
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SearchBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Center(child: Text('Search Bottom Sheet')),
    );
  }
}
