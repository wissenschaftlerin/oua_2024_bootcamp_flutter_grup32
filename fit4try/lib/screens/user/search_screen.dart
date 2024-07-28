import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = [];
  List<String> allItems = ['elbise1', 'elbise2', 'gozluk1', 'gozluk2', 'kiyafet1','kiyafet2', 'kiyafet3', 'kiyafet4'];


  @override
  void initState() {
    super.initState();
    _searchResults = List.from(allItems); // Başlangıçta tüm öğeler gösteriliyor
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: SearchBar(
            controller: _searchController,
            onSearchChanged: (query) {
              setState(() {
                _searchResults = _getSearchResults(query);
              });
            },
            onClear: () {
              setState(() {
                _searchController.clear();
                _searchResults = List.from(allItems);
              });
            },
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
              ),
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset(
                    'assets/images/${_searchResults[index]}.png',
                    fit: BoxFit.cover,
                    height: 150,
                    width: double.infinity,
                  ),
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

  List<String> _getSearchResults(String query) {
    if (query.isEmpty) {
      return List.from(allItems);
    }
    return allItems.where((item) => item.toLowerCase().contains(query.toLowerCase())).toList();
  }
}

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onClear;

  SearchBar({
    required this.controller,
    required this.onSearchChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 7,
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
                  child: TextField(
                    controller: controller,
                    onChanged: onSearchChanged,
                    decoration: InputDecoration(
                      hintText: 'Ara',
                      border: InputBorder.none,
                    ),
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