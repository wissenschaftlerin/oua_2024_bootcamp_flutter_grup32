import 'dart:convert';

import 'package:fit4try/widgets/flash_message.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Dressing {
  final String api_upper_body =
      "https://fit4try-api-ilvfamkmdq-uc.a.run.app/process_image_upper_body";
  final String api_lower_body =
      "https://fit4try-api-ilvfamkmdq-uc.a.run.app/process_image_upper_body";
  final String api_dress =
      "https://fit4try-api-ilvfamkmdq-uc.a.run.app/process_image_upper_body";

  Future<dynamic> clothe_upper_body(
      String model_path, String clothe_path, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(api_upper_body),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'vton_img': model_path, 'garm_img': clothe_path}));
      if (response.statusCode == 200) {
        showSuccessSnackBar(context, "İşlem tamamlandı");
        return response.bodyBytes;
      } else {
        showErrorSnackBar(context, "Hatalı gönderim ");
      }
    } catch (e) {
      showErrorSnackBar(context, "Hatalı gönderim");
    }
  }

  Future<dynamic> clothe_lower_body(
      String model_path, String clothe_path, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(api_lower_body),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'vton_img': model_path, 'garm_img': clothe_path}));
      if (response.statusCode == 200) {
        showSuccessSnackBar(context, "İşlem tamamlandı");
        return response.bodyBytes;
      } else {
        showErrorSnackBar(context, "Hatalı gönderim ");
      }
    } catch (e) {
      showErrorSnackBar(context, "Hatalı gönderim");
    }
  }

  Future<dynamic> clothe_dress(
      String model_path, String clothe_path, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(api_dress),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'vton_img': model_path, 'garm_img': clothe_path}));
      if (response.statusCode == 200) {
        showSuccessSnackBar(context, "İşlem tamamlandı");
        return response.bodyBytes;
      } else {
        showErrorSnackBar(context, "Hatalı gönderim ");
      }
    } catch (e) {
      showErrorSnackBar(context, "Hatalı gönderim");
    }
  }
}
