import 'package:fit4try/constants/fonts.dart';
import 'package:fit4try/constants/style.dart';
import 'package:flutter/material.dart';

class KvkkScreen extends StatefulWidget {
  const KvkkScreen({super.key});

  @override
  State<KvkkScreen> createState() => _KvkkScreenState();
}

class _KvkkScreenState extends State<KvkkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor1,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor1,
        title: Text(
          'KVKK',
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
                "Kişisel Verilerin Korunması Kanunu (KVKK)",
                style:
                    fontStyle(18, AppColors.secondaryColor2, FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "1. Giriş\n"
                "Bu metin, 6698 sayılı Kişisel Verilerin Korunması Kanunu'na (\"KVKK\") uygun olarak, [Şirket Adı] tarafından kişisel verilerin işlenmesine ilişkin olarak bilgilendirme amacı taşımaktadır.\n",
                style:
                    fontStyle(15, AppColors.secondaryColor2, FontWeight.normal),
              ),
              SizedBox(height: 10),
              Text(
                "2. Kişisel Verilerin İşlenme Amaçları\n"
                "[Şirket Adı], kişisel verilerinizi aşağıdaki amaçlarla işleyebilir:\n"
                "- Hizmetlerin sunulması ve yürütülmesi\n"
                "- Müşteri ilişkilerinin yönetimi\n"
                "- Hukuki yükümlülüklerin yerine getirilmesi\n"
                "- Pazarlama ve analiz faaliyetlerinin gerçekleştirilmesi\n",
                style:
                    fontStyle(15, AppColors.secondaryColor2, FontWeight.normal),
              ),
              SizedBox(height: 10),
              Text(
                "3. İşlenen Kişisel Veriler\n"
                "[Şirket Adı], aşağıdaki kişisel verilerinizi işleyebilir:\n"
                "- Ad, soyad\n"
                "- İletişim bilgileri (telefon numarası, e-posta adresi, vb.)\n"
                "- Kullanıcı bilgileri ve işlemleri\n"
                "- Finansal veriler\n",
                style:
                    fontStyle(15, AppColors.secondaryColor2, FontWeight.normal),
              ),
              SizedBox(height: 10),
              Text(
                "4. Kişisel Verilerin Toplanma Yöntemleri\n"
                "Kişisel verileriniz, [Şirket Adı] tarafından çeşitli yöntemlerle (çevrimiçi formlar, çağrı merkezleri, e-posta, vb.) toplanabilir.\n",
                style:
                    fontStyle(15, AppColors.secondaryColor2, FontWeight.normal),
              ),
              SizedBox(height: 10),
              Text(
                "5. Kişisel Verilerin Aktarılması\n"
                "[Şirket Adı], kişisel verilerinizi yasal yükümlülükler çerçevesinde üçüncü taraflarla paylaşabilir. Bu paylaşım, sadece gerekli olan durumlarla sınırlıdır.\n",
                style:
                    fontStyle(15, AppColors.secondaryColor2, FontWeight.normal),
              ),
              SizedBox(height: 10),
              Text(
                "6. Kişisel Verilerin Saklanma Süresi\n"
                "Kişisel verileriniz, işleme amaçlarına uygun süre boyunca saklanacaktır. Bu sürelerin sonunda, kişisel verileriniz silinecek veya anonim hale getirilecektir.\n",
                style:
                    fontStyle(15, AppColors.secondaryColor2, FontWeight.normal),
              ),
              SizedBox(height: 10),
              Text(
                "7. Kişisel Veri Sahibi Olarak Haklarınız\n"
                "KVKK uyarınca, kişisel veri sahipleri aşağıdaki haklara sahiptir:\n"
                "- Kişisel verilerin işlenip işlenmediğini öğrenme\n"
                "- Kişisel verileri işlenmişse buna ilişkin bilgi talep etme\n"
                "- Kişisel verilerin işlenme amacını ve bunların amacına uygun kullanılıp kullanılmadığını öğrenme\n"
                "- Yurt içinde veya yurt dışında kişisel verilerin aktarıldığı üçüncü kişileri bilme\n"
                "- Kişisel verilerin eksik veya yanlış işlenmiş olması hâlinde bunların düzeltilmesini isteme\n"
                "- KVKK'ya aykırı olarak işlenen kişisel verilerin silinmesini veya yok edilmesini isteme\n"
                "- İşlenen verilerin münhasıran otomatik sistemler vasıtasıyla analiz edilmesi suretiyle kişinin kendisi aleyhine bir sonucun ortaya çıkmasına itiraz etme\n"
                "- Kişisel verilerin kanuna aykırı olarak işlenmesi sebebiyle zarara uğraması hâlinde zararın giderilmesini talep etme\n",
                style:
                    fontStyle(15, AppColors.secondaryColor2, FontWeight.normal),
              ),
              SizedBox(height: 10),
              Text(
                "8. İletişim\n"
                "Bu KVKK metni ile ilgili herhangi bir sorunuz varsa, lütfen bizimle [email@example.com] adresinden iletişime geçin.\n",
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
