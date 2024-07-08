import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../main.dart';

class HospitalUserLoginController extends GetxController {
  var obscurePassword = true.obs;
  var rememberMe = false.obs;
  var formKeys = GlobalKey<FormState>().obs;
  TextEditingController email = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void togglePasswordVisibility() {
    obscurePassword.toggle();
  }

  void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
  }

  Future<void> login({required String email, required String password}) async {
    final url = Uri.parse("http://alzaware.runasp.net/api/Relative/Login");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "ssn": email,
          "password": password,
        }),
      );
      Map valueMap = json.decode(response.body);
      print(
          "=====================================$valueMap ===================================");
      if (response.statusCode == 200) {
        // Registration successful
        Fluttertoast.showToast(
            msg: "Login successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white);

        if (valueMap["isSuccess"] == true) {
          Get.offAllNamed("/homeScreen");
          myServices.sharedPreferences.setString("token", valueMap["data"]);
        }
      } else {
        Fluttertoast.showToast(
          msg: "Login failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      // Handle exception
      Fluttertoast.showToast(
        msg: "An error occurred: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  Future<void> signIn() async {
    if (formKeys.value.currentState!.validate()) {
      // Validation passed
      await login(email: email.text, password: passwordController.text);

      if (rememberMe.value == true) {
        myServices.sharedPreferences.setBool("rememberme", true);
      } else {
        myServices.sharedPreferences.setBool("rememberme", true);
      }
    }
  }
}
