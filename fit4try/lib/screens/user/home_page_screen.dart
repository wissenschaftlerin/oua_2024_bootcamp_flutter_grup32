import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fit4try/constants/fonts.dart';
import 'package:fit4try/models/discover_model.dart';
import 'package:fit4try/screens/user/messages_screen.dart';
import 'package:fit4try/screens/user/guest_user_screen.dart';
import 'package:fit4try/screens/user/message_screen.dart';
import 'package:fit4try/screens/user/notifications_screen.dart';
import 'package:fit4try/widgets/buttons.dart';
import 'package:fit4try/widgets/flash_message.dart';
import 'package:fit4try/widgets/home_post.dart';
import 'package:fit4try/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//anasayfanın görüntüsü

class HomeTab extends StatelessWidget {
  Future<String> getDisplayName() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection(
              'users') // Adjust this path if your collection name is different
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        return userDoc.get('displayName') ?? 'Ege'; // Default name if not found
      }
    }
    return 'Ege'; // Default name if no user is logged in
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getDisplayName(),
      builder: (context, snapshot) {
        String greeting = 'Ege'; // Default name
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            greeting = snapshot.data!;
          } else {
            // Handle the case where no display name is returned
            greeting = 'Ege';
          }
        }

        return Container(
          color: AppColors.backgroundColor1,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 60),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Selam ',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: greeting,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple,
                              ),
                            ),
                            TextSpan(
                              text: ',\nBugün harika gözüküyorsun!',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      SearchBar(),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('posts')
                      .orderBy('createdAt', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: LoadingWidget());
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text('No posts available'));
                    }

                    final posts = snapshot.data!.docs.map((doc) {
                      return DiscoverPost.fromMap(
                          doc.data() as Map<String, dynamic>);
                    }).toList();

                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        return PostWidget(post: posts[index]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4, // Increased flex to make the search bar longer
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
              padding: EdgeInsets.symmetric(horizontal: 12),
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(Icons.search),
                  SizedBox(width: 5),
                  Text('Ara'),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3, // Adjusted flex to keep the icon area size
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: const ImageIcon(
                  AssetImage('assets/icon/plus.png'),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewPostScreen()),
                  );
                },
              ),
              SizedBox(width: 1), // Reduced space between icons
              IconButton(
                icon: const ImageIcon(
                  AssetImage('assets/icon/bildirim.png'),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NotificationScreen()));
                },
              ),
              SizedBox(width: 1), // Reduced space between icons
              IconButton(
                icon: const ImageIcon(
                  AssetImage('assets/icon/send.png'),
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
          'name': doc.data().containsKey('displayName')
              ? doc['displayName']
              : 'No Name',
          'username': doc.data().containsKey('username')
              ? doc['username']
              : 'No Username',
          'image': doc.data().containsKey('photoUrl')
              ? doc['photoUrl']
              : 'assets/images/placeholder_profile.jpg',
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

class NewPostScreen extends StatefulWidget {
  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  List<XFile>? selectedImages = [];
  final ImagePicker _picker = ImagePicker();
  bool showGalleryImages = true;

  void _selectImages() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {
      setState(() {
        selectedImages = images;
      });
    }
  }

  Future<List<String>> _uploadImagesToFirebase() async {
    List<String> downloadUrls = [];

    for (XFile image in selectedImages!) {
      File file = File(image.path);
      try {
        // Upload the image to Firebase Storage
        String fileName =
            DateTime.now().millisecondsSinceEpoch.toString() + '_' + image.name;
        Reference ref = FirebaseStorage.instance.ref().child('posts/$fileName');
        await ref.putFile(file);
        // Get the download URL
        String downloadUrl = await ref.getDownloadURL();
        downloadUrls.add(downloadUrl);
      } catch (e) {
        print('Error uploading image: $e');
      }
    }

    return downloadUrls;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yeni Gönderi'),
        actions: [
          TextButton(
            onPressed: () async {
              if (selectedImages!.isNotEmpty) {
                List<String> imageUrls = await _uploadImagesToFirebase();
                // Pass the imageUrls to SharePostScreen or handle them as needed
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SharePostScreen(imageUrls: imageUrls),
                  ),
                );
              }
            },
            child: Text('İlerle',
                style: TextStyle(
                  color: Colors.purple,
                  fontSize: 20.0,
                )),
          ),
        ],
      ),
      body: Container(
        height: selectedImages!.isNotEmpty ? double.infinity : null,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: selectedImages!.isNotEmpty
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Show selected image
            if (selectedImages!.isNotEmpty)
              Image.file(
                File(selectedImages![0].path),
                width: 400.0,
                height: 500.0,
                fit: BoxFit.cover,
              ),
            SizedBox(height: 10),
            Center(
                child: MyButton(
                    text: "Galeriye Git",
                    buttonColor: AppColors.primaryColor5,
                    buttonTextColor: Colors.white,
                    buttonTextSize: 20,
                    borderRadius: BorderRadius.circular(16),
                    buttonTextWeight: FontWeight.normal,
                    onPressed: _selectImages,
                    buttonWidth: ButtonWidth.large)),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: selectedImages!.length,
                itemBuilder: (context, index) {
                  return Image.file(
                    File(selectedImages![index].path),
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SharePostScreen extends StatefulWidget {
  final List<String> imageUrls;

  SharePostScreen({required this.imageUrls});

  @override
  _SharePostScreenState createState() => _SharePostScreenState();
}

class _SharePostScreenState extends State<SharePostScreen> {
  List<String> selectedStylists = [];
  bool showIcon =
      false; // Ikonun gösterilip gösterilmeyeceğini belirleyen değişken
  List<String> tags =
      []; // Seçilen stilistlerin usernamesini kaydedeceğimiz liste

  void _addStylist(String stylist) {
    setState(() {
      selectedStylists.add(stylist);
      tags.add(stylist); // Stilist eklenirken tags listesine de ekle
      showIcon = true; // Stilist eklendiğinde ikonu göster
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text('Yeni Gönderi'),
      ),
      body: Column(
        children: [
          // Seçilen ilk resmi göster
          Image.network(
            widget.imageUrls[0],
            width: 400.0, // İstediğiniz genişliği buraya yazın
            height: 500.0, // İstediğiniz yüksekliği buraya yazın
            fit: BoxFit
                .cover, // Fotoğrafın nasıl ölçekleneceğini buradan seçebilirsiniz
          ),
          SizedBox(height: 35),
          SizedBox(
            width: 312.0, // Genişlik
            height: 56.0, // Yükseklik
            child: ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return StylistSelectionSheet(
                        onStylistSelected: _addStylist);
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF8819DC), // Arka plan rengi
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
                padding: EdgeInsets.zero, // Padding'i sıfırla
                elevation: 0.0, // Opasite etkisi için Elevation'ı sıfırla
              ),
              child: Center(
                child: Text(
                  'Stilist Ekle',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0, // Yazı boyutu
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 25), // Butonlar arasında boşluk
          SizedBox(
            width: 312.0, // Genişlik
            height: 56.0, // Yükseklik
            child: ElevatedButton(
              onPressed: () async {
                try {
                  final User? user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    final userDoc = await FirebaseFirestore.instance
                        .collection('users')
                        .doc(user.uid)
                        .get();
                    final userData = userDoc.data();
                    if (userData != null) {
                      String currentUserImage = userData['photoUrl'] ??
                          'assets/images/placeholder_profile.jpg';
                      String currentUserName =
                          userData['displayName'] ?? 'No Name';
                      final postId = DateTime.now()
                          .millisecondsSinceEpoch
                          .toString(); // Unique ID
                      final postData = {
                        'id': postId,
                        'user_uid': userData['uid'],
                        'createdAt': FieldValue.serverTimestamp(),
                        'description': "",
                        'imageUrl': widget.imageUrls[0],
                        'isFavorited': false,
                        'liked_users': [],
                        'likes': 0,
                        'saved': false,
                        'shares': 0,
                        'tags': tags,
                        'photoUrl': currentUserImage,
                        'username': currentUserName,
                        'views': 0,
                      };

                      await FirebaseFirestore.instance
                          .collection('posts')
                          .doc(postId)
                          .set(postData);
                      showSuccessSnackBar(context, "Post başarıyla paylaşıldı");
                    }
                  }
                } catch (e) {
                  showErrorSnackBar(context, "Post paylaşılırken hata oluştu");
                }
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2B004C), // Arka plan rengi #2B004C
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
                padding: EdgeInsets.zero, // Padding'i sıfırla
                elevation: 0.0, // Opasite etkisi için Elevation'ı sıfırla
              ),
              child: Center(
                child: Text(
                  'Paylaş',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0, // Yazı boyutu
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: selectedStylists.map((stylist) {
                return ListTile(
                  title: Text(stylist),
                  leading: IconButton(
                    icon: const ImageIcon(
                      AssetImage('assets/icon/yıldız2.png'),
                    ),
                    onPressed: () {},
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class StylistSelectionSheet extends StatefulWidget {
  final Function(String) onStylistSelected;

  StylistSelectionSheet({required this.onStylistSelected});

  @override
  _StylistSelectionSheetState createState() => _StylistSelectionSheetState();
}

class _StylistSelectionSheetState extends State<StylistSelectionSheet> {
  String query = '';

  @override
  Widget build(BuildContext context) {
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
          SizedBox(height: 10),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: LoadingWidget());
                }
                final users = snapshot.data!.docs;
                final filteredStylists = users.where((user) {
                  return user['displayName']
                      .toLowerCase()
                      .contains(query.toLowerCase());
                }).toList();

                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: filteredStylists.length,
                  itemBuilder: (context, index) {
                    final user =
                        filteredStylists[index].data() as Map<String, dynamic>;
                    final displayName = user['displayName'] ?? 'No Name';
                    final photoUrl = user.containsKey('photoUrl') &&
                            user['photoUrl'] != null
                        ? user['photoUrl']
                        : 'assets/images/default_profile.png'; // Varsayılan resim yolu

                    return GestureDetector(
                      onTap: () {
                        widget.onStylistSelected(displayName);
                        Navigator.pop(context);
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(photoUrl),
                          ),
                          SizedBox(height: 5),
                          Text(
                            displayName,
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SearchTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Search Tab'),
    );
  }
}

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Profile Tab'),
    );
  }
}
