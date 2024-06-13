import 'package:flutter/material.dart';
import 'package:project_01/View/Pages/Auth/login_page.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List onBoardingData = [
    {
      "image": "assets/images/onboarding0.png",
      "name": "Work on Time",
      "description": " If Work Culture is Flexible "
    },
    {
      "image": "assets/images/onboarding1.jpg",
      "name": "Believe In Your Work",
      "description": " Always Believe in your Self and your Work"
    },
    {
      "image": "assets/images/onboarding2.jpg",
      "name": "Salary Quotes",
      "description":
          "If to love each other is the job \nthen the happy life is the salary"
    },
  ];

  Color whiteColor = Colors.white;
  Color otherColor = const Color(0xFF19173D);

  PageController pageController = PageController();
  int currentPage = 0;
  onChanged(int index) {
    setState(() {
      currentPage = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          TextButton(
            onPressed: continueMethod,
            child: Text(
              'skip',
              style: TextStyle(color: otherColor),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          PageView.builder(
            scrollDirection: Axis.horizontal,
            controller: pageController,
            itemCount: onBoardingData.length,
            onPageChanged: onChanged,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Image.asset(
                    onBoardingData[index]['image'],
                    height: 400,
                    width: 300,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    onBoardingData[index]['name'],
                    style: TextStyle(fontSize: 20, color: otherColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    onBoardingData[index]['description'],
                    style: TextStyle(fontSize: 20, color: otherColor),
                  ),
                ],
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                (currentPage == (onBoardingData.length - 1))
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: ElevatedButton(
                          onPressed: continueMethod,
                          child: const Text('Continue'),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List<Widget>.generate(onBoardingData.length,
                            (index) {
                          return AnimatedContainer(
                            duration: const Duration(
                              milliseconds: 200,
                            ),
                            height: 10,
                            width: (index == currentPage) ? 15 : 10,
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: (index == currentPage)
                                  ? Colors.deepOrange
                                  : Colors.grey,
                            ),
                          );
                        }),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }

  continueMethod() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginPage()),
        (Route<dynamic> route) => false);
  }
}