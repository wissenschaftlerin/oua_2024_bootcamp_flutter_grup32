import 'package:fit4try/constants/fonts.dart';
import 'package:fit4try/constants/style.dart';
import 'package:fit4try/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class StylesScreen extends StatelessWidget {
  const StylesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor1,
      body: Center(
          child: Container(
              color: AppColors.backgroundColor1,
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(child: Image.asset("assets/images/Group16.png")),
                  Container(
                      child: Column(
                    children: [
                      Text(
                        "👕",
                        style: fontStyle(25, Colors.black, FontWeight.bold),
                      ),
                      Text(
                        "Kombini",
                        style: fontStyle(25, Colors.black, FontWeight.bold),
                      ),
                      Text(
                        "Belirle",
                        style: fontStyle(25, Colors.black, FontWeight.bold),
                      ),
                      Text(
                        "Bedenine ve tarzına uygun, stilistlerin senin için seçtikleri ve ünlü markaların sana sunduğu kombinleri keşfet...",
                        textAlign: TextAlign.center,
                        style: fontStyle(14, Colors.black, FontWeight.normal),
                      ),
                    ],
                  )),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                      child: MyButton(
                          text: "Stil Tarzını Seç",
                          buttonColor: AppColors.primaryColor5,
                          buttonTextColor: Colors.white,
                          buttonTextSize: 20,
                          buttonTextWeight: FontWeight.normal,
                          borderRadius: BorderRadius.circular(16),
                          onPressed: () => Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: const WomanStyle())),
                          buttonWidth: ButtonWidth.xLarge)),
                ],
              ))),
    );
  }
}

class WomanStyle extends StatefulWidget {
  const WomanStyle({super.key});

  @override
  State<WomanStyle> createState() => _WomanStyleState();
}

class _WomanStyleState extends State<WomanStyle> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  bool isFemale = false;

  Color _indicatorColors(int value) {
    switch (value) {
      case 1:
        return AppColors.primaryColor1;
      case 2:
        return AppColors.secondaryColor1;
      case 3:
        return AppColors.primaryColor2;
      case 4:
        return AppColors.primaryColor3;
      case 5:
        return AppColors.primaryColor4;
      case 6:
        return AppColors.primaryColor5;
      case 7:
        return AppColors.secondaryColor2;
      default:
        return AppColors.primaryColor1;
    }
  }

  void _nextPage() {
    if (_currentStep < 7) {
      setState(() {
        _currentStep++;
      });
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      print("SON");
    }
  }

  void _previousPage() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void _selectGender(bool isFemaleSelected) {
    setState(() {
      isFemale = isFemaleSelected;
      _currentStep++;
    });
    _pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  Widget _buildFemaleContent(int step) {
    switch (step) {
      case 1:
        return Container(
          color: AppColors.backgroundColor1,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Column(
                children: [
                  Text(
                    "😍️",
                    style: fontStyle(24, Colors.black, FontWeight.bold),
                  ),
                  Text(
                    "Neden",
                    style: fontStyle(24, Colors.black, FontWeight.bold),
                  ),
                  Text(
                    "Fit4Try",
                    style: fontStyle(24, Colors.black, FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: MyButton(
                          text: "Alişveris",
                          buttonColor: Colors.amber,
                          buttonTextColor: Colors.white,
                          buttonTextSize: 15,
                          buttonTextWeight: FontWeight.normal,
                          onPressed: () {},
                          buttonWidth: ButtonWidth.xLarge),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: MyButton(
                              text: "Yerli ve milli firmaları tanımak",
                              buttonColor: Colors.amberAccent,
                              buttonTextColor: Colors.white,
                              buttonTextSize: 20,
                              buttonTextWeight: FontWeight.normal,
                              onPressed: () {},
                              buttonWidth: ButtonWidth.medium),
                        ),
                        Container(
                          child: MyButton(
                              text: "Modaya ve trendlere uymak",
                              buttonColor: Colors.amberAccent,
                              buttonTextColor: Colors.white,
                              buttonTextSize: 20,
                              buttonTextWeight: FontWeight.normal,
                              onPressed: () {},
                              buttonWidth: ButtonWidth.medium),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyButton(
                            text: "Kendime yeni bir stil oluşturmak",
                            buttonColor: Colors.amberAccent,
                            buttonTextColor: Colors.white,
                            buttonTextSize: 20,
                            buttonTextWeight: FontWeight.normal,
                            onPressed: () {},
                            buttonWidth: ButtonWidth.medium),
                        MyButton(
                            text: "Yeni kıyafetler keşfetmek",
                            buttonColor: Colors.amberAccent,
                            buttonTextColor: Colors.white,
                            buttonTextSize: 20,
                            buttonTextWeight: FontWeight.normal,
                            onPressed: () {},
                            buttonWidth: ButtonWidth.medium),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyButton(
                            text: "Kendime yeni bir stil oluşturmak",
                            buttonColor: Colors.amberAccent,
                            buttonTextColor: Colors.white,
                            buttonTextSize: 20,
                            buttonTextWeight: FontWeight.normal,
                            onPressed: () {},
                            buttonWidth: ButtonWidth.medium),
                        MyButton(
                            text: "Yeni kıyafetler keşfetmek",
                            buttonColor: Colors.amberAccent,
                            buttonTextColor: Colors.white,
                            buttonTextSize: 20,
                            buttonTextWeight: FontWeight.normal,
                            onPressed: () {},
                            buttonWidth: ButtonWidth.medium),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      case 2:
        return Container(
          color: AppColors.backgroundColor1,
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Text(
                      "👔",
                      style: fontStyle(24, Colors.black, FontWeight.bold),
                    ),
                    Text(
                      "Stil Tercihlerini",
                      style: fontStyle(24, Colors.black, FontWeight.bold),
                    ),
                    Text(
                      "Seç",
                      style: fontStyle(24, Colors.black, FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                giyimMeethod("Üst Giyim", [
                  "Klasik",
                  "Business",
                  "Spor",
                  "Günlük",
                  "Resmi",
                  "Elegant"
                ]),
                SizedBox(
                  height: 20,
                ),
                giyimMeethod("Üst Giyim", [
                  "Klasik",
                  "Business",
                  "Spor",
                  "Günlük",
                  "Resmi",
                  "Elegant"
                ]),
                SizedBox(
                  height: 20,
                ),
                giyimMeethod("Üst Giyim", [
                  "Klasik",
                  "Business",
                  "Spor",
                  "Günlük",
                  "Resmi",
                  "Elegant"
                ]),
                SizedBox(
                  height: 20,
                ),
                giyimMeethod("Üst Giyim", [
                  "Klasik",
                  "Business",
                  "Spor",
                  "Günlük",
                  "Resmi",
                  "Elegant"
                ]),
              ],
            ),
          ),
        );

      case 3:
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    child: Text(
                      "⏫",
                      style: fontStyle(24, Colors.black, FontWeight.bold),
                    ),
                  ),
                  Container(
                    child: Text(
                      "Boyun Kaç",
                      style: fontStyle(24, Colors.black, FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: SizedBox(
                      width: 150, // Kutunun genişliği
                      height: 50, // Kutunun yüksekliği
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Buraya sola tıklama işlemi için kod ekleyebilirsiniz
                              },
                              child: Icon(Icons.remove,
                                  color: AppColors.primaryColor4),
                            ),
                            Text(
                              '5', // Buradaki rakamı dinamik olarak değiştirebilirsiniz
                              style: fontStyle(
                                  24.0, Colors.grey.shade700, FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Buraya sağa tıklama işlemi için kod ekleyebilirsiniz
                              },
                              child: Icon(Icons.add_rounded,
                                  color: AppColors.primaryColor4),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  Container(
                    child: Text(
                      "💪",
                      style: fontStyle(24, Colors.black, FontWeight.bold),
                    ),
                  ),
                  Container(
                    child: Text(
                      "Kaç Kilosun",
                      style: fontStyle(24, Colors.black, FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: SizedBox(
                      width: 150, // Kutunun genişliği
                      height: 50, // Kutunun yüksekliği
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Buraya sola tıklama işlemi için kod ekleyebilirsiniz
                              },
                              child: Icon(Icons.remove,
                                  color: AppColors.primaryColor4),
                            ),
                            Text(
                              '5', // Buradaki rakamı dinamik olarak değiştirebilirsiniz
                              style: fontStyle(
                                  24.0, Colors.grey.shade700, FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Buraya sağa tıklama işlemi için kod ekleyebilirsiniz
                              },
                              child: Icon(Icons.add_rounded,
                                  color: AppColors.primaryColor4),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  Container(
                    child: Text(
                      "👟",
                      style: fontStyle(24, Colors.black, FontWeight.bold),
                    ),
                  ),
                  Container(
                    child: Text(
                      "Ayakkabı Numarası",
                      style: fontStyle(24, Colors.black, FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: SizedBox(
                      width: 150, // Kutunun genişliği
                      height: 50, // Kutunun yüksekliği
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Buraya sola tıklama işlemi için kod ekleyebilirsiniz
                              },
                              child: Icon(Icons.remove,
                                  color: AppColors.primaryColor4),
                            ),
                            Text(
                              '5', // Buradaki rakamı dinamik olarak değiştirebilirsiniz
                              style: fontStyle(
                                  24.0, Colors.grey.shade700, FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Buraya sağa tıklama işlemi için kod ekleyebilirsiniz
                              },
                              child: Icon(Icons.add_rounded,
                                  color: AppColors.primaryColor4),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      case 4:
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                      child: Text(
                        "💯",
                        style: fontStyle(30, Colors.black, FontWeight.bold),
                      ),
                    ),
                    Container(
                      child: Text(
                        "Beden ölçülerin",
                        style: fontStyle(30, Colors.black, FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ustBolgeMethod(
                    "Üst Bölge", ["XS", "S", "M", "L", "XL", "XXL"], false),
                ustBolgeMethod(
                    "Alt Bölge", ["XS", "S", "M", "L", "XL", "XXL"], false),
                ustBolgeMethod(
                    "Jean", ["29", "30", "31", "32", "33", "34"], true),
                ustBolgeMethod(
                    "Ayakkabı", ["36", "37", "38", "39", "40", "41"], true),
                ustBolgeMethod("Sütyen", ["A", "B", "C", "D"], true),
                ustBolgeMethod("Sütyen (Sırt Çevresi)",
                    ["70", "75", "80", "85", "90", "95"], true),
              ],
            ),
          ),
        );
      case 5:
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                      child: Text(
                        "📏",
                        style: fontStyle(30, Colors.black, FontWeight.bold),
                      ),
                    ),
                    Container(
                      child: Text(
                        "Kalıp Tercihin",
                        style: fontStyle(30, Colors.black, FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ustBolgeMethod(
                    "Üst Bölge",
                    [
                      "Skinny",
                      "Slim Fit",
                      "Regular Fit",
                      "OverSize",
                    ],
                    false),
                ustBolgeMethod(
                    "Alt Bölge",
                    [
                      "Skinny",
                      "Slim Fit",
                      "Regular Fit",
                      "OverSize",
                    ],
                    false),
                ustBolgeMethod(
                    "Jean",
                    [
                      "Skinny",
                      "Slim Fit",
                      "Relaxed",
                      "Loose Fit",
                    ],
                    false),
              ],
            ),
          ),
        );
      case 6:
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                      child: Text(
                        "🎨",
                        style: fontStyle(30, Colors.black, FontWeight.bold),
                      ),
                    ),
                    Container(
                      child: Text(
                        "Tercih Ettiğin",
                        style: fontStyle(30, Colors.black, FontWeight.bold),
                      ),
                    ),
                    Container(
                      child: Text(
                        "Renkler",
                        style: fontStyle(30, Colors.black, FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RenkSecWidget(
                          imagePath: 'assets/images/Rectangle205.png',
                        ),
                        RenkSecWidget(
                          imagePath: 'assets/images/Rectangle206.png',
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RenkSecWidget(
                          imagePath: 'assets/images/Rectangle207.png',
                        ),
                        RenkSecWidget(
                          imagePath: 'assets/images/Rectangle208.png',
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RenkSecWidget(
                          imagePath: 'assets/images/Rectangle209.png',
                        ),
                        RenkSecWidget(
                          imagePath: 'assets/images/Rectangle210.png',
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RenkSecWidget(
                          imagePath: 'assets/images/Rectangle211.png',
                        ),
                        RenkSecWidget(
                          imagePath: 'assets/images/Rectangle212.png',
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RenkSecWidget(
                          imagePath: 'assets/images/Rectangle213.png',
                        ),
                        RenkSecWidget(
                          imagePath: 'assets/images/Rectangle214.png',
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RenkSecWidget(
                          imagePath: 'assets/images/Rectangle215.png',
                        ),
                        RenkSecWidget(
                          imagePath: 'assets/images/Rectangle216.png',
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RenkSecWidget(
                          imagePath: 'assets/images/Rectangle217.png',
                        ),
                        RenkSecWidget(
                          imagePath: 'assets/images/Rectangle218.png',
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      default:
        return Container();
    }
  }

  Widget ustBolgeMethod(
      String bolgeAdi, List<String> bedenler, bool digerButton) {
    TextEditingController textEditingController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "$bolgeAdi",
                style:
                    fontStyle(18, AppColors.primaryColor4, FontWeight.normal),
              ),
            ],
          ),
          SizedBox(height: 10),
          Wrap(
            spacing: 10.0, // Spacing between buttons
            runSpacing: 10.0, // Spacing between rows of buttons
            alignment: WrapAlignment.start,
            children: [
              ...bedenler.map((beden) {
                return ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    beden,
                    style: TextStyle(color: Colors.grey),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(width: 1, color: Colors.grey),
                    ),
                  ),
                );
              }),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Diğer'),
                      content: TextField(
                        controller: textEditingController,
                        decoration: InputDecoration(
                          hintText: 'Diğer değeri girin',
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            // Handle the input from text field
                            String enteredValue = textEditingController.text;
                            // Implement your logic with enteredValue
                            Navigator.pop(context); // Close the dialog
                          },
                          child: Text('Tamam'),
                        ),
                      ],
                    ),
                  );
                },
                child: Text(
                  'Diğer',
                  style: TextStyle(color: Colors.grey),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(width: 1, color: Colors.grey),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Container giyimMeethod(String title, List<String> options) {
    return Container(
      width: double.infinity,
      // height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              title,
              style: fontStyle(18, AppColors.primaryColor4, FontWeight.normal),
            ),
          ),
          Wrap(
            spacing: 10.0, // Yanyana butonlar arasındaki boşluk
            runSpacing: 10.0, // Alt alta geçen satırlar arasındaki boşluk
            children: List.generate(options.length, (index) {
              return SizedBox(
                width: 100, // Buton genişliği
                child: ElevatedButton(
                  onPressed: () {
                    // Butona basıldığında renk değişimi sağla
                    // int selectedIndexButtonGiyim = index;
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    // onPrimary: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(width: 1, color: Colors.grey),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      options[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey, // Varsayılan rengi gri yap
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildMaleContent(int step) {
    switch (step) {
      case 1:
        return Container(
          color: AppColors.backgroundColor1,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Column(
                children: [
                  Text(
                    "😍️",
                    style: fontStyle(24, Colors.black, FontWeight.bold),
                  ),
                  Text(
                    "Neden",
                    style: fontStyle(24, Colors.black, FontWeight.bold),
                  ),
                  Text(
                    "Fit4Try",
                    style: fontStyle(24, Colors.black, FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: MyButton(
                          text: "Alişveris",
                          buttonColor: Colors.amber,
                          buttonTextColor: Colors.white,
                          buttonTextSize: 15,
                          buttonTextWeight: FontWeight.normal,
                          onPressed: () {},
                          buttonWidth: ButtonWidth.xLarge),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: MyButton(
                              text: "Yerli ve milli firmaları tanımak",
                              buttonColor: Colors.amberAccent,
                              buttonTextColor: Colors.white,
                              buttonTextSize: 20,
                              buttonTextWeight: FontWeight.normal,
                              onPressed: () {},
                              buttonWidth: ButtonWidth.medium),
                        ),
                        Container(
                          child: MyButton(
                              text: "Modaya ve trendlere uymak",
                              buttonColor: Colors.amberAccent,
                              buttonTextColor: Colors.white,
                              buttonTextSize: 20,
                              buttonTextWeight: FontWeight.normal,
                              onPressed: () {},
                              buttonWidth: ButtonWidth.medium),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyButton(
                            text: "Kendime yeni bir stil oluşturmak",
                            buttonColor: Colors.amberAccent,
                            buttonTextColor: Colors.white,
                            buttonTextSize: 20,
                            buttonTextWeight: FontWeight.normal,
                            onPressed: () {},
                            buttonWidth: ButtonWidth.medium),
                        MyButton(
                            text: "Yeni kıyafetler keşfetmek",
                            buttonColor: Colors.amberAccent,
                            buttonTextColor: Colors.white,
                            buttonTextSize: 20,
                            buttonTextWeight: FontWeight.normal,
                            onPressed: () {},
                            buttonWidth: ButtonWidth.medium),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyButton(
                            text: "Kendime yeni bir stil oluşturmak",
                            buttonColor: Colors.amberAccent,
                            buttonTextColor: Colors.white,
                            buttonTextSize: 20,
                            buttonTextWeight: FontWeight.normal,
                            onPressed: () {},
                            buttonWidth: ButtonWidth.medium),
                        MyButton(
                            text: "Yeni kıyafetler keşfetmek",
                            buttonColor: Colors.amberAccent,
                            buttonTextColor: Colors.white,
                            buttonTextSize: 20,
                            buttonTextWeight: FontWeight.normal,
                            onPressed: () {},
                            buttonWidth: ButtonWidth.medium),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      case 2:
        return Container(
          color: AppColors.backgroundColor1,
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Text(
                      "👔",
                      style: fontStyle(24, Colors.black, FontWeight.bold),
                    ),
                    Text(
                      "Stil Tercihlerini",
                      style: fontStyle(24, Colors.black, FontWeight.bold),
                    ),
                    Text(
                      "Seç",
                      style: fontStyle(24, Colors.black, FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                giyimMeethod("Üst Giyim", [
                  "Klasik",
                  "Business",
                  "Spor",
                  "Günlük",
                  "Resmi",
                  "Elegant"
                ]),
                SizedBox(
                  height: 20,
                ),
                giyimMeethod("Üst Giyim", [
                  "Klasik",
                  "Business",
                  "Spor",
                  "Günlük",
                  "Resmi",
                  "Elegant"
                ]),
                SizedBox(
                  height: 20,
                ),
                giyimMeethod("Üst Giyim", [
                  "Klasik",
                  "Business",
                  "Spor",
                  "Günlük",
                  "Resmi",
                  "Elegant"
                ]),
                SizedBox(
                  height: 20,
                ),
                giyimMeethod("Üst Giyim", [
                  "Klasik",
                  "Business",
                  "Spor",
                  "Günlük",
                  "Resmi",
                  "Elegant"
                ]),
              ],
            ),
          ),
        );

      case 3:
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    child: Text(
                      "⏫",
                      style: fontStyle(24, Colors.black, FontWeight.bold),
                    ),
                  ),
                  Container(
                    child: Text(
                      "Boyun Kaç",
                      style: fontStyle(24, Colors.black, FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: SizedBox(
                      width: 150, // Kutunun genişliği
                      height: 50, // Kutunun yüksekliği
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Buraya sola tıklama işlemi için kod ekleyebilirsiniz
                              },
                              child: Icon(Icons.remove,
                                  color: AppColors.primaryColor4),
                            ),
                            Text(
                              '5', // Buradaki rakamı dinamik olarak değiştirebilirsiniz
                              style: fontStyle(
                                  24.0, Colors.grey.shade700, FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Buraya sağa tıklama işlemi için kod ekleyebilirsiniz
                              },
                              child: Icon(Icons.add_rounded,
                                  color: AppColors.primaryColor4),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  Container(
                    child: Text(
                      "💪",
                      style: fontStyle(24, Colors.black, FontWeight.bold),
                    ),
                  ),
                  Container(
                    child: Text(
                      "Kaç Kilosun",
                      style: fontStyle(24, Colors.black, FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: SizedBox(
                      width: 150, // Kutunun genişliği
                      height: 50, // Kutunun yüksekliği
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Buraya sola tıklama işlemi için kod ekleyebilirsiniz
                              },
                              child: Icon(Icons.remove,
                                  color: AppColors.primaryColor4),
                            ),
                            Text(
                              '5', // Buradaki rakamı dinamik olarak değiştirebilirsiniz
                              style: fontStyle(
                                  24.0, Colors.grey.shade700, FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Buraya sağa tıklama işlemi için kod ekleyebilirsiniz
                              },
                              child: Icon(Icons.add_rounded,
                                  color: AppColors.primaryColor4),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  Container(
                    child: Text(
                      "👟",
                      style: fontStyle(24, Colors.black, FontWeight.bold),
                    ),
                  ),
                  Container(
                    child: Text(
                      "Ayakkabı Numarası",
                      style: fontStyle(24, Colors.black, FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: SizedBox(
                      width: 150, // Kutunun genişliği
                      height: 50, // Kutunun yüksekliği
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Buraya sola tıklama işlemi için kod ekleyebilirsiniz
                              },
                              child: Icon(Icons.remove,
                                  color: AppColors.primaryColor4),
                            ),
                            Text(
                              '5', // Buradaki rakamı dinamik olarak değiştirebilirsiniz
                              style: fontStyle(
                                  24.0, Colors.grey.shade700, FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Buraya sağa tıklama işlemi için kod ekleyebilirsiniz
                              },
                              child: Icon(Icons.add_rounded,
                                  color: AppColors.primaryColor4),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      case 4:
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                      child: Text(
                        "💯",
                        style: fontStyle(30, Colors.black, FontWeight.bold),
                      ),
                    ),
                    Container(
                      child: Text(
                        "Beden ölçülerin",
                        style: fontStyle(30, Colors.black, FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ustBolgeMethod(
                    "Üst Bölge", ["XS", "S", "M", "L", "XL", "XXL"], false),
                ustBolgeMethod(
                    "Alt Bölge", ["XS", "S", "M", "L", "XL", "XXL"], false),
                ustBolgeMethod(
                    "Jean", ["29", "30", "31", "32", "33", "34"], true),
                ustBolgeMethod(
                    "Ayakkabı", ["36", "37", "38", "39", "40", "41"], true),
              ],
            ),
          ),
        );
      case 5:
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                      child: Text(
                        "📏",
                        style: fontStyle(30, Colors.black, FontWeight.bold),
                      ),
                    ),
                    Container(
                      child: Text(
                        "Kalıp Tercihin",
                        style: fontStyle(30, Colors.black, FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ustBolgeMethod(
                    "Üst Bölge",
                    [
                      "Skinny",
                      "Slim Fit",
                      "Regular Fit",
                      "OverSize",
                    ],
                    false),
                ustBolgeMethod(
                    "Alt Bölge",
                    [
                      "Skinny",
                      "Slim Fit",
                      "Regular Fit",
                      "OverSize",
                    ],
                    false),
                ustBolgeMethod(
                    "Jean",
                    [
                      "Skinny",
                      "Slim Fit",
                      "Relaxed",
                      "Loose Fit",
                    ],
                    false),
              ],
            ),
          ),
        );
      case 6:
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                      child: Text(
                        "🎨",
                        style: fontStyle(30, Colors.black, FontWeight.bold),
                      ),
                    ),
                    Container(
                      child: Text(
                        "Tercih Ettiğin",
                        style: fontStyle(30, Colors.black, FontWeight.bold),
                      ),
                    ),
                    Container(
                      child: Text(
                        "Renkler",
                        style: fontStyle(30, Colors.black, FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RenkSecWidget(
                          imagePath: 'assets/images/Rectangle205.png',
                        ),
                        RenkSecWidget(
                          imagePath: 'assets/images/Rectangle206.png',
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RenkSecWidget(
                          imagePath: 'assets/images/Rectangle207.png',
                        ),
                        RenkSecWidget(
                          imagePath: 'assets/images/Rectangle208.png',
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RenkSecWidget(
                          imagePath: 'assets/images/Rectangle209.png',
                        ),
                        RenkSecWidget(
                          imagePath: 'assets/images/Rectangle210.png',
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RenkSecWidget(
                          imagePath: 'assets/images/Rectangle211.png',
                        ),
                        RenkSecWidget(
                          imagePath: 'assets/images/Rectangle212.png',
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RenkSecWidget(
                          imagePath: 'assets/images/Rectangle213.png',
                        ),
                        RenkSecWidget(
                          imagePath: 'assets/images/Rectangle214.png',
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RenkSecWidget(
                          imagePath: 'assets/images/Rectangle215.png',
                        ),
                        RenkSecWidget(
                          imagePath: 'assets/images/Rectangle216.png',
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RenkSecWidget(
                          imagePath: 'assets/images/Rectangle217.png',
                        ),
                        RenkSecWidget(
                          imagePath: 'assets/images/Rectangle218.png',
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      default:
        return Container();
    }
  }

  Widget _buildStepContent(int step) {
    if (step == 0) {
      return Container(
        padding: EdgeInsets.all(16),
        color: AppColors.backgroundColor1,
        margin: EdgeInsets.only(top: 100),
        child: Container(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  "♀️ | ♂️",
                  style: fontStyle(20, Colors.black, FontWeight.normal),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Cinsiyetini",
                style: fontStyle(20, Colors.black, FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Seç",
                style: fontStyle(20, Colors.black, FontWeight.bold),
              ),
              SizedBox(height: 20),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => _selectGender(true),
                      child: Image.asset("assets/images/Group15.png"),
                    ),
                    InkWell(
                      onTap: () => _selectGender(false),
                      child: Image.asset("assets/images/Group18.png"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.all(16),
        // color: _indicatorColors(step).withOpacity(0.1),
        color: AppColors.backgroundColor1,
        child: Center(
          child: isFemale ? _buildFemaleContent(step) : _buildMaleContent(step),
        ),
      );
    }
  }

  Widget _buildProgressBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(8, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          width: 40.0,
          height: 8.0,
          decoration: BoxDecoration(
            color:
                index <= _currentStep ? _indicatorColors(index) : Colors.grey,
            borderRadius: BorderRadius.circular(4.0),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor1,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 75),
          _buildProgressBar(),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 7,
              itemBuilder: (context, index) {
                return _buildStepContent(index);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyButton(
                  text: "Devam Et",
                  buttonColor: AppColors.primaryColor3,
                  buttonTextColor: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  buttonTextSize: 20,
                  buttonTextWeight: FontWeight.normal,
                  onPressed: _nextPage,
                  buttonWidth: ButtonWidth.xLarge,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class RenkSecWidget extends StatefulWidget {
  final String imagePath;

  const RenkSecWidget({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  @override
  _RenkSecWidgetState createState() => _RenkSecWidgetState();
}

class _RenkSecWidgetState extends State<RenkSecWidget> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.purple : Colors.transparent,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image.asset(
          widget.imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
