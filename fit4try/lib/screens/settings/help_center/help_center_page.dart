import 'package:flutter/material.dart';


class HelpCenterScreen extends StatefulWidget {
  @override
  _HelpCenterScreenState createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  TextEditingController _controller = TextEditingController();
  bool _isMessageEntered = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isMessageEntered = _controller.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0), // AppBar'ın yüksekliğini ayarlayın
        child: AppBar(
          centerTitle: true, // Başlığı ortalayın
          title: Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: Text('Yardım Merkezi'),
          ),
          leading: IconButton(
            icon: Image.asset('assets/icon/back.png'),
            onPressed: () {
              // Geri butonuna basılınca yapılacak işlemler
            },
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.0),
            child: Divider(thickness: 1.0, height: 1.0), // İnce çizgi
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20.0), // Metni biraz aşağıya kaydırmak için
            Text(
              'Sorularınız ve yorumlarınız için bizlere ulaşabilirsiniz.',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold), // Metin rengini koyu yapın
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30.0), // Mesaj kutusunu biraz aşağıya kaydırmak için
            TextField(
              controller: _controller,
              maxLines: 6,
              decoration: InputDecoration(
                hintText: 'Mesajınızı giriniz...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: _isMessageEntered ? Color(0xFF2B004C) : Color(0xFFE7E7E7),
                  ),
                ),
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: _isMessageEntered ? () {
                // Kaydet düğmesi işlevi
              } : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isMessageEntered ? Color(0xFF9F49DF) : Color(0xFFC1AFCF),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                'Kaydet',
                style: TextStyle(fontSize: 16.0, color: Colors.white), // Buton yazı rengini beyaz yapın
              ),
            ),
          ],
        ),
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