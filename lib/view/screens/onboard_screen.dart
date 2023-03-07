import 'package:flutter/material.dart';
import 'package:observer/constants/icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:observer/constants/colors.dart';
import 'package:observer/constants/images.dart';

import '../../model/onboard_model.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({Key? key}) : super(key: key);

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  var currentIndex = 0;
  late PageController _pageController;

  List<OnboardModel> screens = <OnboardModel>[
    OnboardModel(
      image: splash1,
      whiteText: 'Get the latest news from ',
      redText: 'reliable sources',
    ),
    OnboardModel(image: splash2,
      whiteText: 'Still ',
      redText: 'up to date ',
      whiteText2: 'news from all around the world ',
    ),
    OnboardModel(image: splash3,
      whiteText: 'From art to politics ',
      redText: 'anything ',
      whiteText2: 'in Observer ',
    ),
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _storeOnboardInfo() async{
    var isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
    print(prefs.getInt('onBoard'));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        centerTitle: false,
        title: Image(
          image: AssetImage(
            logoSmall,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _storeOnboardInfo();
              Navigator.pushReplacementNamed(context, '/layoutScreen');
            },
            child: Text(
              'Skip',
              style: TextStyle(
                color: blackColor,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: PageView.builder(
            itemCount: screens.length,
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: (int index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      // alignment: Alignment.centerLeft,
                      children: [
                        Image(
                          image: AssetImage(
                            screens[index].image,
                          ),
                        ),
                        Positioned.fill(
                          bottom: 20,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: 300,
                                  child: RichText(
                                    text: TextSpan(
                                        text: screens[index].whiteText,
                                        style: TextStyle(
                                            color: whiteColor,
                                            fontSize: 40,
                                            fontWeight: FontWeight.w700,
                                            height: 1.5),
                                        children: [
                                          TextSpan(
                                              text: screens[index].redText,
                                              style: TextStyle(color: mainColor)),
                                          TextSpan(
                                              text: screens[index].whiteText2,
                                              style: TextStyle(
                                                  color: whiteColor
                                              )
                                          )
                                        ]),),
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                Container(
                                  height: 4,
                                  child: ListView.builder(
                                      itemCount: screens.length,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin:
                                                  EdgeInsets.symmetric(horizontal: 3),
                                              width: 35,
                                              decoration: BoxDecoration(
                                                color: currentIndex == index
                                                    ? whiteColor
                                                    : subTextColor,
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () async {
                        if(index == screens.length -1){
                          await _storeOnboardInfo();
                          Navigator.pushReplacementNamed(context, '/interestingScreen');
                        }
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.bounceIn
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 17),
                        decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                              'Next',
                          style: TextStyle(
                            fontSize: 20,
                            color: whiteColor,
                            fontWeight: FontWeight.w600
                          ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}

// Dear programmer
// When I wrote this code, only god and
// I knew how it worked
// Now, only god know it!
//
// Therefor, if you are trying to optimize
// this routine and it fails (most surely),
// Please increase this counter as a
// warning for next person:

// total_hours_wasted_here = 254
//
