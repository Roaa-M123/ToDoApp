import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:todo_project/core/cache_helper.dart';
import 'package:todo_project/view/screens/app_layout.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenstate();
}

class _OnBoardingScreenstate extends State<OnBoardingScreen> {
  List<Map<String, dynamic>> onBordingScreenlList = [
    {
      "image": "assets/Saly-10.png",
      "title": "Organize Your Tasks Easily",
      "description":
      "Manage your daily tasks with ease.\n Create, edit, and delete tasks in just a few taps"
    },
    {
      "image": "assets/Saly-12.png",
      "title": " Add Tasks Anytime, Anywhere",
      "description":
      "Quickly add new tasks to stay on top of your to-do list.\nCategorize and prioritize your tasks effortlessly."
    },
    {
      "image": "assets/Group 1.png",
      "title": "Stay Focused and Productive",
      "description":
      "Keep track of your progress throughout the day.\nAchieve your goals one task at a time!"
    },
  ];
  PageController controller = PageController();
  int currentPageNumber = 0;

  @override
  void dispose()  {
    CacheHelper.setDataAll(key: "onBoarding", value: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XffC5EDF6),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            PageView.builder(
              onPageChanged: (index) {
                setState(() {
                  currentPageNumber = index;
                });
              },
              controller: controller,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    const SizedBox(
                      height:10,
                    ),
                    Image.asset(
                      onBordingScreenlList[index]["image"],
                      height: 500,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Positioned(
                      top: 400,
                      left: 20,
                      right: 20,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.8),
                        child: Text(

                          textAlign: TextAlign.center,
                          onBordingScreenlList[index]["title"],
                          style: const TextStyle(

                              color: Color(0xff094E7F),
                              fontSize: 30,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Positioned(
                      top: 500,
                      left: 20,
                      right: 20,

                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.8),
                        child: Text(
                          textAlign: TextAlign.center,
                          onBordingScreenlList[index]["description"],
                          style: const TextStyle(
                              color: Color(0xff094E7F),
                              fontSize: 20,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    )
                  ]);
              },
              itemCount: onBordingScreenlList.length,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (currentPageNumber < onBordingScreenlList.length - 1)
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                              return const AppLayoutScreen();
                            }));
                      },
                      child: const Text(
                        "Skip",
                        style:
                        TextStyle(color: Color(0xff094E7F), fontSize: 20),
                      ),
                    ),
                  if (currentPageNumber < onBordingScreenlList.length - 1)
                    SmoothPageIndicator(
                      controller: controller,
                      count: onBordingScreenlList.length,
                      effect: ExpandingDotsEffect(
                        spacing: 10,
                        dotHeight: 8,
                        dotWidth: 16,
                        expansionFactor: 2.5,
                        dotColor: const Color(0xff094E7F).withOpacity(0.20),
                        activeDotColor: const Color(0xff094E7F),
                      ),
                    ),

                  if (currentPageNumber < onBordingScreenlList.length - 1)
                    ElevatedButton(
                      onPressed: () {
                        controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff094E7F),
                        shape: const CircleBorder(),
                      ),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    )
                ],
              ),
            ),
            if (currentPageNumber == onBordingScreenlList.length - 1)
              Positioned(
                bottom:20,
                left: 0,
                right: 0,
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const AppLayoutScreen();
                          },
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff094E7F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                    ),
                    child: const Text(
                      "Get Started",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
