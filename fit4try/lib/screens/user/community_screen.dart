import 'package:flutter/material.dart';

class CommunityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/icon/foto.png'), // Replace with actual image path
        ),
        title: Text(
          'ege.yildirimm',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Image.asset('assets/icon/bildirim.png'), // Replace with actual image path
            onPressed: () {},
          ),
          IconButton(
            icon: Image.asset('assets/icon/send.png'), // Replace with actual image path
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
            color: Colors.grey[120],
            height: 10,
          ),
        ),
      ),
      body: ListView(
        children: [
          PostWidget(
            avatar: 'assets/icon/foto.png', // Replace with actual image path
            username: 'ege.yildirmm',
            time: '1 dk.',
            content:
            'Bu sezonun en popüler renklerinden biri olan lavanta, gardırobuma mükemmel bir ekleme oldu!',
            likes: '11.4K',
            comments: '154',
            views: '1.2K',
          ),
          PostWidget(
            avatar: 'assets/images/aramafoto6.png', // Replace with actual image path
            username: 'estarhoward',
            time: '3 sa',
            content:
            'Yüksek bel pantolonlar geri döndü! Sizce bu trend ne kadar kalıcı olacak?',
            likes: '1048',
            comments: '128',
            views: '1.3K',
          ),
          PostWidget(
            avatar: 'assets/images/aramafoto6.png', // Replace with actual image path
            username: 'estarhoward',
            time: '4 sa',
            content:
            'Bu hafta sonu moda fuarına katıldım ve inanılmaz tasarımlar gördüm. Sizler de böyle etkinliklere katılıyor musunuz?',
            likes: '1088',
            comments: '158',
            views: '1.1K',
          ),
          PostWidget(
            avatar: 'assets/images/aramafoto3.png', // Replace with actual image path
            username: 'yasinkaan.ygt',
            time: '4 sa',
            content:
            'Bir iş görüşmesi için ne giymeliyim? Profesyonel ama rahat bir görünüm arıyorum.',
            likes: '0',
            comments: '0',
            views: '0',
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/icon/home.png'), // Replace with actual image path
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icon/community2.png'), // Replace with actual image path
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icon/picture.png'), // Replace with actual image path
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icon/aı.png'), // Replace with actual image path
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icon/foto.png'), // Replace with actual image path
            label: '',
          ),
        ],
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
                  backgroundImage: AssetImage(widget.avatar),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.username, style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Spacer(),
                Text(widget.time, style: TextStyle(color: Colors.grey)),
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
                    SizedBox(width:5),
                    Text(widget.likes),
                    IconButton(
                      icon: Image.asset('assets/icon/yorum.png'), // Replace with actual image path
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
                      icon: Image.asset('assets/icon/goz.png'), // Replace with actual image path
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
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Image.asset('assets/icon/back.png'), // Replace with actual image path
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
                      fontSize: 20, // Increase the font size
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Container(), // Placeholder to balance the row
                onPressed: null,
              ),
            ],
          ),
          Divider(
            color: Colors.grey, // Set the color of the divider
            thickness: 1, // Set the thickness of the divider
          ),
          // Comments widgets
          CommentWidget(
            avatar: 'assets/images/aramafoto1.png', // Replace with actual image path
            username: 'yunusea1',
            content: 'Aynı fikirdeyim! Lavanta rengi gerçekten harika. Hangi mağazadan aldın?',
            likes: '1.6K',
          ),
          CommentWidget(
            avatar: 'assets/images/aramafoto5.png', // Replace with actual image path
            username: 'zehranurbs',
            content: 'Ben de lavanta rengini çok seviyorum ama hangi tonunu tercih etmeliyim, fikirlerin var mı?',
            likes: '1.8K',
          ),
          CommentWidget(
            avatar: 'assets/images/aramafoto4.png', // Replace with actual image path
            username: 'yaren.n24',
            content: 'Bu rengi nasıl kombinliyorsun? Ben de denemek istiyorum',
            likes: '2.5K',
          ),
        ],
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
        backgroundImage: AssetImage(widget.avatar),
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
