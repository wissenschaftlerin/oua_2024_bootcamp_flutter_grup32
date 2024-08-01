import 'package:flutter/material.dart';

class StilistScreen extends StatefulWidget {
  @override
  _StilistScreenState createState() => _StilistScreenState();
}

class _StilistScreenState extends State<StilistScreen> {
  int _selectedIndex = 0;
  final List<Map<String, String>> stylists = [
    {
      'name': 'Sena Erdağ',
      'style': 'Spor / Günlük / Business',
      'avatar': 'assets/images/stilist1.png',
    },
    {
      'name': 'Efe Akmen',
      'style': 'Elegant / Klasik / Business',
      'avatar': 'assets/images/stilist2.png',
    },
    {
      'name': 'Kerem Dursun',
      'style': 'Elegant / Resmi / Business',
      'avatar': 'assets/images/stilist3.png',
    },
    {
      'name': 'Hülya Yıldız',
      'style': 'Resmi / Business',
      'avatar': 'assets/images/stilist4.png',
    },
    {
      'name': 'Chris Brand',
      'style': 'Elegant / Klasik / Resmi',
      'avatar': 'assets/images/stilist5.png',
    },
    {
      'name': 'Hande Ateş',
      'style': 'Spor / Günlük / Resmi',
      'avatar': 'assets/images/stilist6.png',
    },
  ];

  List<Map<String, String>> favoriteStylists = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleFavorite(Map<String, String> stylist) {
    setState(() {
      if (favoriteStylists.contains(stylist)) {
        favoriteStylists.remove(stylist);
      } else {
        favoriteStylists.add(stylist);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isFavoriteTab = _selectedIndex == 1;
    final displayedStylists = isFavoriteTab ? favoriteStylists : stylists;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/icon/foto.png'), // Kullanıcı avatarı
            ),
            SizedBox(width: 15),
            Text('ege.yildirim'), // Kullanıcı adı
            Spacer(),
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
            SizedBox(width: 10),
            IconButton(
              icon: Image.asset(
                'assets/icon/send.png', // Replace with your .png icon path
                width: 30,
                height: 30,
              ),
              onPressed: () {
                // Handle notification icon press
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () => _onItemTapped(0),
                  child: Text('Stilistler'),
                ),
                TextButton(
                  onPressed: () => _onItemTapped(1),
                  child: Text('Favori Stilistlerim'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: displayedStylists.length,
              itemBuilder: (context, index) {
                final stylist = displayedStylists[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(stylist['avatar']!),
                  ),
                  title: Text(stylist['name']!),
                  subtitle: Text(stylist['style']!),
                  onTap: () => _showStylistDetails(stylist),
                );
              },
            ),
          ),
        ],
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
              'assets/icon/yıldız2.png',
              width: 36,
              height: 36,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/icon/foto.png'),
            ),
            label: '',
          ),
        ],
      ),
    );
  }

  void _showStylistDetails(Map<String, String> stylist) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        final isFavorite = favoriteStylists.contains(stylist);
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.star : Icons.star_border,
                      color: isFavorite ? Colors.yellow : Colors.grey,
                    ),
                    onPressed: () {
                      _toggleFavorite(stylist);
                      Navigator.pop(context);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage(stylist['avatar']!),
                  radius: 40,
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  stylist['name']!,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Center(child: Text(stylist['style']!)),
              SizedBox(height: 20),
              Text(
                'Deneyimler',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'Stilist olarak, insanların kendilerini en iyi şekilde ifade etmelerine yardımcı oluyorum. İşim, sadece kıyafet ve aksesuar seçmekten ibaret değil; aynı zamanda müşterilerimin kişisel tarzlarını ve karakterlerini en iyi şekilde yansıtmalarına destek oluyorum.',
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Mesaj Gönder',
                    style: TextStyle(color: Colors.white), // Metin rengini beyaz yapar
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                  ),
                ),
              ),

            ],
          ),
        );
      },
    );
  }
}