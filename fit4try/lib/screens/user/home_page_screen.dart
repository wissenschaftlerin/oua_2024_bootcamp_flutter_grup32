import 'package:flutter/material.dart';
//anasayfanın görüntüsü 

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  bool isFavorited = false;
  final List<Widget> _children = [
    HomeTab(),
    SearchTab(),
    ProfileTab(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // İkonların hareket etmesini istersek bu satırı kaldırırız
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icon/home2.png',
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

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 60), // Ekranın üst kısmında 30 birim boşluk bırakır
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0), // Kenarlardan 20 birim uzaklaştırır
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
                        text: 'Ege',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple, // Mor renk
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
          child: ListView(
            padding: EdgeInsets.zero, // Extra padding kaldırılır
            children: [
              PostWidget(
                imageUrl: 'assets/images/anasayfafoto1.png',
                username: 'ege.yildirim',
                userImage: 'assets/icon/foto.png',
                description: '',
                isFavorited: true,
              ),
              PostWidget(
                imageUrl: 'assets/images/anasayfafoto2.png',
                username: 'ethetheword',
                userImage: 'assets/images/aramafoto6.png',
                description: '',
                isFavorited: false,
              ),
            ],
          ),
        ),
      ],
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
                onPressed: () {},
              ),
              SizedBox(width: 1), // Reduced space between icons
              IconButton(
                icon: const ImageIcon(
                  AssetImage('assets/icon/send.png'),
                ),

                onPressed: () {},
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
  final List<Map<String, String>> suggestions = [
    {
      'name': 'Yunus Emre',
      'username': 'yunusemre',
      'image': 'assets/images/aramafoto1.png'
    },
    {
      'name': 'Feyza',
      'username': 'feyza',
      'image': 'assets/images/aramafoto2.png'
    },
    {
      'name': 'Yasin Kaan',
      'username': 'yasinkaan',
      'image': 'assets/images/aramafoto3.png'
    },
    {
      'name': 'Zehra Nur',
      'username': 'zehranur',
      'image': 'assets/images/aramafoto4.png'
    },
    {
      'name': 'Yaren',
      'username': 'yaren',
      'image': 'assets/images/aramafoto5.png'
    },
    {
      'name': 'Ester',
      'username': 'ester',
      'image': 'assets/images/aramafoto6.png'
    },
  ];

  String query = '';

  @override
  Widget build(BuildContext context) {
    final filteredSuggestions = suggestions.where((suggestion) {
      return suggestion['name']!.toLowerCase().contains(query.toLowerCase());
    }).toList();

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
              itemCount: filteredSuggestions.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage:
                        AssetImage(filteredSuggestions[index]['image']!),
                      ),
                      SizedBox(height: 10),
                      Text(
                        filteredSuggestions[index]['name']!,
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

class PostWidget extends StatefulWidget {
  final String imageUrl;
  final String username;
  final String userImage;
  final String description;
  final bool isFavorited;

  PostWidget({
    required this.imageUrl,
    required this.username,
    required this.userImage,
    required this.description,
    required this.isFavorited,
  });

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool isFavorited = false;

  @override
  void initState() {
    super.initState();
    isFavorited = widget.isFavorited;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(widget.userImage),
            ),
            title: Text(widget.username),
          ),
          Image.asset(widget.imageUrl),
          if (widget.description.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.description),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: ImageIcon(
                    AssetImage(isFavorited
                        ? 'assets/icon/like.png'
                        : 'assets/icon/like2.png'),
                  ),
                  onPressed: () {
                    setState(() {
                      isFavorited = !isFavorited;
                    });
                  },
                ),
                IconButton(
                  icon: const ImageIcon(
                    AssetImage('assets/icon/send.png'),
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const ImageIcon(
                    AssetImage('assets/icon/yıldız.png'),
                  ),
                  onPressed: () {},
                ),
                Expanded(child: Container()), // This takes up the remaining space
                IconButton(
                    icon: const ImageIcon(
                      AssetImage('assets/icon/plus.png'),
                    ),
                    onPressed: () {}
                ),
              ],
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
  String selectedImage = 'assets/images/anasayfafoto2.png';
  bool showGalleryImages = true;

  final List<String> galleryImages = [
    'assets/images/ornek.png',
    'assets/images/ornek2.png',
    'assets/images/ornek3.png',
    'assets/images/ornek4.png',
    'assets/images/ornek5.png',
    'assets/images/ornek6.png',
  ];

  final List<String> photosImages = [
    'assets/images/ornek6.png',
    'assets/images/ornek5.png',
    'assets/images/ornek7.png',
    'assets/images/ornek8.png',
    'assets/images/ornek2.png',
    'assets/images/ornek4.png',


  ];

  void _selectImage(String image) {
    setState(() {
      selectedImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yeni Gönderi'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SharePostScreen(imageUrl: selectedImage),
                ),
              );
            },
            child: Text('İlerle', style: TextStyle(color: Colors.purple, fontSize: 20.0,)),
          ),
        ],
      ),
      body: Column(
        children: [
          Image.asset(
            selectedImage,
            width: 400.0, // İstediğiniz genişliği buraya yazın
            height: 500.0, // İstediğiniz yüksekliği buraya yazın
            fit: BoxFit.cover, // Fotoğrafın nasıl ölçekleneceğini buradan seçebilirsiniz
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        showGalleryImages = true;
                      });
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: showGalleryImages ? Colors.black : Colors.grey, // Renk seçimi
                    ),
                    child: Text(
                      'Galeri',
                      style: TextStyle(fontSize: 20.0), // Yazı boyutunu artırın
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        showGalleryImages = false;
                      });
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: !showGalleryImages ? Colors.black : Colors.grey, // Renk seçimi
                    ),
                    child: Text(
                      'Dolaptan',
                      style: TextStyle(fontSize: 20.0), // Yazı boyutunu artırın
                    ),
                  ),
                ],
              ),
              // Divider'ı yazılara daha yakın ve daha kısa yapmak
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0), // Yatayda boşluk ekleyin
                child: Divider(
                  color: Colors.grey,
                  thickness: 1.0,
                ),
              ),
            ],
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: showGalleryImages ? galleryImages.length : photosImages.length,
              itemBuilder: (context, index) {
                String imagePath = showGalleryImages ? galleryImages[index] : photosImages[index];
                return GestureDetector(
                  onTap: () {
                    _selectImage(imagePath);
                  },
                  child: Image.asset(imagePath),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
class SharePostScreen extends StatefulWidget {
  final String imageUrl;

  SharePostScreen({required this.imageUrl});

  @override
  _SharePostScreenState createState() => _SharePostScreenState();
}

class _SharePostScreenState extends State<SharePostScreen> {
  List<String> selectedStylists = [];
  bool showIcon = false; // Ikonun gösterilip gösterilmeyeceğini belirleyen değişken

  void _addStylist(String stylist) {
    setState(() {
      selectedStylists.add(stylist);
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
          Image.asset(
            widget.imageUrl,
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
                    return StylistSelectionSheet(onStylistSelected: _addStylist);
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
              onPressed: () {
                // Yeni gönderiyi ekleyip ana sayfaya dön
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
                  leading:
                  IconButton(
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
  final List<Map<String, String>> stylists = [
    {'name': 'Sena Erdağ', 'image': 'assets/images/aramafoto1.png'},
    {'name': 'Efe Akman', 'image': 'assets/images/aramafoto2.png'},
    {'name': 'Kerem Dursun', 'image': 'assets/images/aramafoto3.png'},
    {'name': 'Hülya Yıldız', 'image': 'assets/images/aramafoto4.png'},
    {'name': 'Chris Bromd', 'image': 'assets/images/aramafoto5.png'},
    {'name': 'Hande Ateş', 'image': 'assets/images/aramafoto6.png'},
  ];

  String query = '';

  @override
  Widget build(BuildContext context) {
    final filteredStylists = stylists.where((stylist) {
      return stylist['name']!.toLowerCase().contains(query.toLowerCase());
    }).toList();

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
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: filteredStylists.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    widget.onStylistSelected(filteredStylists[index]['name']!);
                    Navigator.pop(context);
                  },
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage:
                        AssetImage(filteredStylists[index]['image']!),
                      ),
                      SizedBox(height: 5),
                      Text(
                        filteredStylists[index]['name']!,
                        style: TextStyle(fontSize: 14),
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