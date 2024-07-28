import 'package:fit4try/constants/fonts.dart';
import 'package:fit4try/constants/style.dart';
import 'package:fit4try/screens/settings/application_details/kvkk_screen.dart';
import 'package:fit4try/screens/settings/application_details/term_of_use_screen.dart';
import 'package:flutter/material.dart';

class ApplicationDetailsScreen extends StatefulWidget {
  const ApplicationDetailsScreen({super.key});

  @override
  State<ApplicationDetailsScreen> createState() =>
      _ApplicationDetailsScreenState();
}

class _ApplicationDetailsScreenState extends State<ApplicationDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor1,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor1,
        title: Text(
          'Uygulama Hakkında',
          style: fontStyle(20, AppColors.secondaryColor2, FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(16)),
                      child: Icon(Icons.add)),
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor2,
                        borderRadius: BorderRadius.circular(16)),
                    child: Icon(
                      Icons.facebook,
                      color: AppColors.primaryColor5,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor2,
                        borderRadius: BorderRadius.circular(16)),
                    child: Icon(
                      Icons.facebook,
                      color: AppColors.primaryColor5,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor2,
                        borderRadius: BorderRadius.circular(16)),
                    child: Icon(
                      Icons.facebook,
                      color: AppColors.primaryColor5,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor2,
                        borderRadius: BorderRadius.circular(16)),
                    child: Icon(
                      Icons.facebook,
                      color: AppColors.primaryColor5,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => KvkkScreen()));
                },
                child: Container(
                    padding:
                        EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 15),
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(width: 0.2, color: Colors.grey),
                    )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "KVKK",
                          style: fontStyle(
                              15, AppColors.secondaryColor2, FontWeight.normal),
                        ),
                        Icon(Icons.arrow_forward_ios,
                            color: Colors.grey, size: 15),
                      ],
                    )),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TermOfUseScreen()));
                },
                child: Container(
                    padding:
                        EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 15),
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(width: 0.2, color: Colors.grey),
                    )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Kullanım Koşulları",
                          style: fontStyle(
                              15, AppColors.secondaryColor2, FontWeight.normal),
                        ),
                        Icon(Icons.arrow_forward_ios,
                            color: Colors.grey, size: 15),
                      ],
                    )),
              ),
            ],
          )),
    );
  }
}
