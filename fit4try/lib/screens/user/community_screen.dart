import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit4try/constants/fonts.dart';
import 'package:fit4try/screens/user/messages_screen.dart';
import 'package:fit4try/screens/user/message_screen.dart';
import 'package:fit4try/screens/user/notifications_screen.dart';
import 'package:fit4try/widgets/loading.dart';
import 'package:flutter/material.dart';

class CommunityScreen extends StatefulWidget {
  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  String? _profilePhotoUrl;
  String _displayName = 'User';

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            _profilePhotoUrl = userDoc.get('photoUrl');
            _displayName = userDoc.get('displayName') ?? 'User';
          });
        }
      }
    } catch (e) {
      print('Error fetching user profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: CircleAvatar(
          backgroundImage: _profilePhotoUrl != null
              ? NetworkImage(_profilePhotoUrl!)
              : AssetImage('assets/icon/foto.png') as ImageProvider,
        ),
        title: Text(
          _displayName,
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Image.asset('assets/icon/bildirim.png'),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NotificationScreen()));
            },
          ),
          IconButton(
            icon: Image.asset('assets/icon/send.png'),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MessagesScreen()));
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
            color: Colors.grey[300],
            height: 10,
          ),
        ),
      ),
      backgroundColor: AppColors.backgroundColor1,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('community_posts')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: LoadingWidget());
          }

          return ListView(
            children: snapshot.data!.docs.map((document) {
              return PostWidget(
                avatar: document['avatar'],
                username: document['username'],
                time: document['time'],
                content: document['content'],
                likes: document['likes'].toString(),
                comments: document['comments'].toString(),
                views: document['views'].toString(),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class PostWidget extends StatefulWidget {
  final String avatar;
  final String username;
  final String time;
  final String content;
  final String likes;
  final String comments;
  final String views;

  PostWidget({
    required this.avatar,
    required this.username,
    required this.time,
    required this.content,
    required this.likes,
    required this.comments,
    required this.views,
  });

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.avatar),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.username,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(widget.time, style: TextStyle(color: Colors.grey)),
                  ],
                ),
                Spacer(),
                IconButton(
                  icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border),
                  onPressed: () {
                    setState(() {
                      isLiked = !isLiked;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(widget.content),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: isLiked
                          ? ImageIcon(AssetImage("assets/icon/kalp2.png"))
                          : ImageIcon(AssetImage("assets/icon/kalp.png")),
                      onPressed: () {
                        setState(() {
                          isLiked = !isLiked;
                        });
                      },
                    ),
                    SizedBox(width: 5),
                    Text(widget.likes),
                    IconButton(
                      icon: Image.asset('assets/icon/yorum.png'),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => CommentsSheet(),
                        );
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Image.asset('assets/icon/goz.png'),
                      onPressed: () {},
                    ),
                    Text(widget.views),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CommentsSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Image.asset('assets/icon/back.png'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Yorumlar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Container(),
                  onPressed: null,
                ),
              ],
            ),
            Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            // Comments widgets
            CommentWidget(
              avatar: 'https://example.com/aramafoto1.png',
              username: 'yunusea1',
              content:
                  'Aynı fikirdeyim! Lavanta rengi gerçekten harika. Hangi mağazadan aldın?',
              likes: '1.6K',
            ),
            CommentWidget(
              avatar: 'https://example.com/aramafoto5.png',
              username: 'zehranurbs',
              content:
                  'Ben de lavanta rengini çok seviyorum ama hangi tonunu tercih etmeliyim, fikirlerin var mı?',
              likes: '1.8K',
            ),
            CommentWidget(
              avatar: 'https://example.com/aramafoto4.png',
              username: 'yaren.n24',
              content:
                  'Bu rengi nasıl kombinliyorsun? Ben de denemek istiyorum',
              likes: '2.5K',
            ),
          ],
        ),
      ),
    );
  }
}

class CommentWidget extends StatefulWidget {
  final String avatar;
  final String username;
  final String content;
  final String likes;

  CommentWidget({
    required this.avatar,
    required this.username,
    required this.content,
    required this.likes,
  });

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  bool _isLiked = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(widget.avatar),
      ),
      title: Text(widget.username),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.content),
          Row(
            children: [
              SizedBox(width: 5),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isLiked = !_isLiked;
                  });
                },
                child: Icon(
                  _isLiked ? Icons.favorite : Icons.favorite_border,
                  color: _isLiked ? Colors.red : Colors.black,
                ),
              ),
              SizedBox(width: 5),
              Text(widget.likes),
            ],
          ),
        ],
      ),
    );
  }
}
