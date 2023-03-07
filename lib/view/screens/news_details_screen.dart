import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/icons.dart';
import '../../constants/images.dart';
import '../../controller/news_controller.dart';
import '../components/news_card.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class NewDetailsScreen extends StatefulWidget {
  const NewDetailsScreen({Key? key}) : super(key: key);

  @override
  State<NewDetailsScreen> createState() => _NewDetailsScreenState();
}

class _NewDetailsScreenState extends State<NewDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //
      // ),
      backgroundColor: whiteColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 55,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      print('tapped');
                      Navigator.pop(context);
                    });
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: blackBackground,
                        borderRadius: BorderRadius.circular(5)),
                    child: Image.asset(
                      left,
                      color: whiteColor,
                    ),
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: blackBackground,
                      borderRadius: BorderRadius.circular(5)),
                  child: Image.asset(
                    bookmarkDisable,
                    color: whiteColor,
                  ),
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: Container(
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 5),
                    child: Row(
                      children: [
                        Container(
                          color: mainColor,
                          width: 2,
                          height: 80,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Container(
                          width: 330,
                          child: Text(
                            'An explosion of joy through Argentina as its football team won the World Cup.',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: blackColor
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                width: double.maxFinite,
                padding: EdgeInsets.only(left: 20, right: 20),
              ),
            ),
            pinned: true,
            backgroundColor: mainColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Image.asset(
                      messi,
                      width: double.maxFinite,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 15),
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: blackBackground,
                                borderRadius: BorderRadius.circular(5)),
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  Share.share('Shared from Observer app - -> ');
                                });
                              },
                              child: Image.asset(
                                share,
                                color: whiteColor,
                              ),
                            ),
                          ),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: blackBackground,
                                borderRadius: BorderRadius.circular(5)),
                            child: GestureDetector(
                              onTap: _browser,
                              child: Image.asset(
                                browser,
                                color: whiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding:
              EdgeInsets.only(bottom: 40, left: 20, right: 20, top: 10),
              // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  Container(
                    width: 370,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: greyBackground,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image(
                                    image: AssetImage(bbc),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'BBC',
                                    style:
                                    TextStyle(
                                        fontWeight: FontWeight.bold,
                                      color: blackColor
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'December 29,2022 - 8:45',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: placeholderColor
                                ),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: mainColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              child: Text(
                                'Sports',
                                style: TextStyle(
                                    color: whiteColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 30,
                      // left: 20,
                      // right: 20,
                      bottom: 20,
                    ),
                    child: ExpandableText(
                      "More than a million fans gathered in Buenos Aires to celebrate the victory - its first in the World Cup since 1986. Supporters gathered at the city's obelisk, on to which pictures of the players were projected. The crowds grew as night fell with more and more people thronging on to the streets to pay homage to the players. Many said that the victory had brought them joy at a time of economic hardship. Fans had started gathering early in the day to watch the match and there was a party atmosphere in the capital. Entire families took to the streets to watch the match unfold, hoisting their children up on their shoulders, so they, too, could get a view of the huge screens which had been erected for the occasion.",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: blackColor
                      ),
                      collapseText: 'show less',
                      expandText: 'Show more',
                      linkColor: mainColor,
                      maxLines: 8,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Related News',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: blackColor
                      ),
                    ),
                  ),
                  FutureBuilder(
                    future: NewsApi.getCategoryData('general'),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      return (snapshot.hasData)
                          ? ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 2,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              NewsCard(
                                image: (snapshot.data[index].urlToImage ==
                                    null)
                                    ? 'https://studio.uxpincdn.com/studio/wp-content/uploads/2021/06/10-error-404-page-examples-for-UX-design.png.webp'
                                    : snapshot.data[index].urlToImage,
                                text: (snapshot.data[index].title == null)
                                    ? 'No Data'
                                    : snapshot.data[index].title,
                                subText: (snapshot
                                    .data[index].publishedAt ==
                                    null)
                                    ? 'No Data'
                                    : snapshot.data[index].publishedAt,
                                name: (snapshot.data[index].name == null)
                                    ? 'No Data'
                                    : snapshot.data[index].name,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          );
                        },
                      )
                          : Center(
                          child: CircularProgressIndicator(
                            color: mainColor,
                          ));
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



_browser ()async {
  const url = 'https://github.com/NourhanHamada';
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch $url';
  }
}