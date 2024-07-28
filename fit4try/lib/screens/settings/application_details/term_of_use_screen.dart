import 'package:fit4try/constants/fonts.dart';
import 'package:fit4try/constants/style.dart';
import 'package:flutter/material.dart';

class TermOfUseScreen extends StatefulWidget {
  const TermOfUseScreen({super.key});

  @override
  State<TermOfUseScreen> createState() => _TermOfUseScreenState();
}

class _TermOfUseScreenState extends State<TermOfUseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor1,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor1,
        title: Text(
          'Kullanım Koşulları',
          style: fontStyle(20, AppColors.secondaryColor2, FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Kullanım Koşulları",
                style:
                    fontStyle(18, AppColors.secondaryColor2, FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "1. Giriş\n"
                "Bu kullanım koşulları, [Uygulama Adı] adlı mobil uygulamanın kullanımına ilişkin şartları ve hükümleri içermektedir. Uygulamayı kullanarak, bu kullanım koşullarını kabul etmiş sayılırsınız.\n",
                style:
                    fontStyle(15, AppColors.secondaryColor2, FontWeight.normal),
              ),
              SizedBox(height: 10),
              Text(
                "2. Hizmet Tanımı\n"
                "[Uygulama Adı], kullanıcılara [hizmetin tanımı] hizmetlerini sunmaktadır. Hizmetin kapsamı ve içeriği uygulama tarafından belirlenir ve zaman zaman değiştirilebilir.\n",
                style:
                    fontStyle(15, AppColors.secondaryColor2, FontWeight.normal),
              ),
              SizedBox(height: 10),
              Text(
                "3. Kullanıcı Yükümlülükleri\n"
                "Kullanıcılar, uygulamayı kullanırken yasalara, ahlaka ve bu kullanım koşullarına uygun davranmayı kabul ederler. Uygulamanın kötüye kullanılması, hizmetin durdurulmasına veya sona erdirilmesine neden olabilir.\n",
                style:
                    fontStyle(15, AppColors.secondaryColor2, FontWeight.normal),
              ),
              SizedBox(height: 10),
              Text(
                "4. Fikri Mülkiyet Hakları\n"
                "Uygulama ve içeriğindeki tüm materyaller, [Şirket Adı]’nın mülkiyetindedir ve telif hakkı yasaları ile korunmaktadır. Kullanıcılar, bu materyalleri izinsiz kopyalayamaz, dağıtamaz veya değiştiremez.\n",
                style:
                    fontStyle(15, AppColors.secondaryColor2, FontWeight.normal),
              ),
              SizedBox(height: 10),
              Text(
                "5. Sorumluluğun Sınırlandırılması\n"
                "[Şirket Adı], uygulamanın kullanılmasından kaynaklanan doğrudan veya dolaylı zararlardan sorumlu tutulamaz. Uygulama, \"olduğu gibi\" sağlanmaktadır ve herhangi bir garanti verilmemektedir.\n",
                style:
                    fontStyle(15, AppColors.secondaryColor2, FontWeight.normal),
              ),
              SizedBox(height: 10),
              Text(
                "6. Değişiklikler\n"
                "[Şirket Adı], bu kullanım koşullarını herhangi bir zamanda değiştirme hakkını saklı tutar. Değişiklikler, uygulama üzerinden duyurulacaktır ve kullanıcıların uygulamayı kullanmaya devam etmeleri, değişiklikleri kabul ettikleri anlamına gelecektir.\n",
                style:
                    fontStyle(15, AppColors.secondaryColor2, FontWeight.normal),
              ),
              SizedBox(height: 10),
              Text(
                "7. İletişim\n"
                "Bu kullanım koşulları ile ilgili herhangi bir sorunuz varsa, lütfen bizimle [email@example.com] adresinden iletişime geçin.\n",
                style:
                    fontStyle(15, AppColors.secondaryColor2, FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
