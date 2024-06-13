import 'package:flutter/material.dart';
import 'package:project_01/Controller/Service/api_service.dart';
import 'package:project_01/Model/profile_deails_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  dynamic userDetails;
  bool isLoading = false;

  getUserDetails() {
    isLoading = true;
    ApiService().getProfileDetails().then((value) {
      print('user Details:-  ${value.toString()}');
      setState(() {
        userDetails = value;
        isLoading = false;
      });
    }).onError((error, stackTrace) {
      print(error.toString());
      isLoading = false;
    });
  }

  @override
  void initState() {
    getUserDetails();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('User Details'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: isLoading == true
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Image.network(
                        userDetails['avatar'],
                        height: 150,
                        width: 150,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      userDetails['name'].toString(),
                      style: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      userDetails['role'].toString(),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w100),
                    ),
                    const SizedBox(
                      height: 20.0,
                      width: 150,
                      child: Divider(
                        color: Colors.red,
                      ),
                    ),
                    InkWell(
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 25.0),
                        child: ListTile(
                          leading: const Icon(
                            Icons.email,
                            color: Colors.red,
                          ),
                          title: Text(
                            userDetails['email'].toString(),
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w100),
                          ),
                        ),
                      ),
                      onTap: () {},
                    ),
                    InkWell(
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 25.0),
                        child: ListTile(
                          leading: const Icon(
                            Icons.calendar_month,
                            color: Colors.red,
                          ),
                          title: Text(
                            userDetails['creationAt'].toString(),
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w100),
                          ),
                        ),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
