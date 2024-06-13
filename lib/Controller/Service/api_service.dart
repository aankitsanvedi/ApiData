import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:project_01/Model/login_response.dart';
import 'package:project_01/Model/product_model.dart';
import 'package:project_01/Model/profile_deails_model.dart';
import 'package:project_01/Model/registration_response.dart';
import 'package:project_01/Model/signup_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/categories_model.dart';

class ApiService {
  var Base_Url = 'https://api.escuelajs.co/api/v1';
  var Url = 'https://reqres.in';
  var id ;


 // SignUp PostApi
  Future<SignUpResponseModel?> userSignUp(
     String name, String email, String password ) async {
    try {
      var url = Uri.parse('$Url/api/register');
      var response = await http.post(
        url,
        body: {
          "name": name,
          "email": email,
          "password": password,
        //  "avatar": avatar
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        SignUpResponseModel signUpResponseModel =
            SignUpResponseModel.fromJson(jsonDecode(response.body));
        return signUpResponseModel;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }



  // Registration PostApi
  Future<RegistrationModel?> userRegistration(
      String email, String password) async {
    try {
      var url = Uri.parse('$Url/api/register');
      var response = await http.post(
        url,
        body: {
          "email": email,
          "password": password,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        RegistrationModel registrationModel =
            RegistrationModel.fromJson(jsonDecode(response.body));
        return registrationModel;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  // Login Post
  Future<LoginResponse?> userLogin(String email, String password) async {
    try {
      var url = Uri.parse('$Base_Url/auth/login');
      var response = await http.post(url, 
      body: {
        "email": email, "password": password
      },
      );
      if (response.statusCode == 200 || response.statusCode==201) {
        LoginResponse loginResponse = LoginResponse.fromJson(jsonDecode(response.body));
        return loginResponse;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  // Image Upload
  Future<dynamic> postUploadImage(Uint8List bytes, String filename) async{
    var request = http.MultipartRequest('POST', Uri.parse('https://api.escuelajs.co/api/v1/files/upload?'));

    var multipartFile = http.MultipartFile(
      'file',
      http.ByteStream.fromBytes(bytes),
      bytes.length,
      filename: filename
    );

    request.files.add(multipartFile);
    final response = await request.send();


    if (response.statusCode == 201 || response.statusCode == 200)  {
      var data = await response.stream.bytesToString();
      return jsonDecode(data);
      
    }else
    {
      return null;
    }
  }

  // User Profile Detials Get
  Future<dynamic> getUserDetails() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString('access_token');
    try {
      var response = await http.get(
          Uri.parse('https://api.escuelajs.co/api/v1/auth/profile'),
          headers: {"Authorization": "Bearer $token"});

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<ProfileModel>?> getProfileDetails() async{
     SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString('access_token');
    try {
      var response = await http.get(
        Uri.parse('$Base_Url/auth/profile'),
        headers: {"Authorization": "Bearer $token"});
      
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<List<CategoriesModel>?> getCategoriesList() async {
    try {
      var url = Uri.parse('$Base_Url/categories');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        List<CategoriesModel> categoriesmodel = List<CategoriesModel>.from(
            jsonDecode(response.body).map((x) => CategoriesModel.fromJson(x)));
        return categoriesmodel;
      }
      
    } catch (e) {
      print(e.toString());
    }
    return null;
  }


  Future<List<ProductModel>?> getProductList() async {
    try {
      var url = Uri.parse('$Base_Url/products');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        List<ProductModel> productmodel = List<ProductModel>.from(
            jsonDecode(response.body).map((x) => ProductModel.fromJson(x)));
        return productmodel;
      }
    } catch (e) {
      print(e.toString());
    }

    return null;
  }





}


