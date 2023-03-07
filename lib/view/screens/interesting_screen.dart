import 'package:flutter/material.dart';
import 'package:observer/constants/colors.dart';
import 'package:observer/constants/images.dart';
import 'package:observer/model/interesting_model.dart';

class InterestingScreen extends StatefulWidget {
  const InterestingScreen({Key? key}) : super(key: key);

  @override
  State<InterestingScreen> createState() => _InterestingScreenState();
}

class _InterestingScreenState extends State<InterestingScreen> {
  var currentIndex = 0;
  List<int> _selectedItems = [];
  List items = [
    InterestingModel(image: technology, text: 'Technology'),
    InterestingModel(image: science, text: 'Science'),
    InterestingModel(image: politics, text: 'Politics'),
    InterestingModel(image: food, text: 'Food'),
    InterestingModel(image: business2, text: 'Business'),
    InterestingModel(image: health, text: 'Health'),
    InterestingModel(image: technology, text: 'Technology'),
    InterestingModel(image: science, text: 'Science'),
    InterestingModel(image: politics, text: 'Politics'),
    InterestingModel(image: food, text: 'Food'),
    InterestingModel(image: business2, text: 'Business'),
    InterestingModel(image: health, text: 'Health'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        title: Text(
          'What\'s interest you?',
          style: TextStyle(
              color: blackColor, fontSize: 26, fontWeight: FontWeight.w600),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: Theme(
            data: Theme.of(context).copyWith(),
            child: Container(
              child: RichText(
                text: TextSpan(
                    text: 'Pick',
                    style: TextStyle(
                      color: subTextColor,
                    ),
                    children: [
                      TextSpan(
                          text: ' topics ',
                          style: TextStyle(
                              color: mainColor, fontWeight: FontWeight.w500)),
                      TextSpan(text: 'to start reading and saving news')
                    ]),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 630,
                child: GridView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: items.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 45,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedItems.contains(index)
                              ? _selectedItems.remove(index)
                              : _selectedItems.add(index);
                        });
                      },
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          ClipRect(
                            child: AspectRatio(
                              child: FittedBox(
                                child: Image(
                                  image: AssetImage(
                                    items[index].image,
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              aspectRatio: 1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              items[index].text,
                              style: TextStyle(
                                  color: whiteColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            right: 30,
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: _selectedItems.contains(index)
                                    ? whiteColor
                                    : whiteColor.withOpacity(.2),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Image(
                                image: AssetImage(true_),
                                color: _selectedItems.contains(index)
                                    ? mainColor
                                    : whiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: () async {
                    Navigator.pushReplacementNamed(context, '/layoutScreen');
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 17),
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                            fontSize: 20,
                            color: whiteColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
