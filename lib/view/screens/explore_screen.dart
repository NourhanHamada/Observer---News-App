import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../constants/colors.dart';
import '../../constants/icons.dart';
import '../../controller/news_controller.dart';
import '../components/news_card.dart';

class ExploreScreen extends StatefulWidget {
  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  var texts = [
    'General',
    'Sports',
    'Health',
    'Politics',
    'Entertainment',
    'Technology',
    'Business',
    'Science',
  ];
  var categories = [
    'general',
    'sports',
    'health',
    'politics',
    'entertainment',
    'technology',
    'business',
    'science',
  ];
  var currentIndex = 0;

  Future<void> _handleRefresh() async {
    // reloading takes some time
    return await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        title: Text(
          'Explore',
          style: TextStyle(
              color: blackColor,
              fontSize: 30,
              fontWeight: FontWeight.w700),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: Text(
            'Explore the world by one click!',
            style: TextStyle(color: subTextColor, fontSize: 16),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: LiquidPullToRefresh(
          onRefresh: _handleRefresh,
          color: mainColor,
          height: 100,
          backgroundColor: whiteColor,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      Navigator.pushNamed(context, '/searchScreen');
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            Image(
                              image: AssetImage(search),
                              color: subTextColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Search',
                              style: TextStyle(color: subTextColor),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  // width: 110,
                  height: 47,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: categories.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            currentIndex = index;
                            categories[index];
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Container(
                            width: 110,
                            decoration: BoxDecoration(
                                color: currentIndex == index
                                    ? mainColor
                                    : whiteColor,
                                borderRadius: BorderRadius.circular(15),
                                border: currentIndex == index
                                    ? null
                                    : Border.all(color: mainColor, width: 1)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  texts[index],
                                  style: TextStyle(
                                    color: currentIndex == index
                                        ? whiteColor
                                        : mainColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Center(
                  child: FutureBuilder(
                    future:
                        NewsApi.getCategoryData('${categories[currentIndex]}'),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      return (snapshot.hasData)
                          ? ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return (index == 0)
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 20),
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.pushNamed(context,
                                                      '/detailsScreen');
                                                },
                                                child: Image(
                                                  errorBuilder: (BuildContext,
                                                      Object exception,
                                                      StackTrace) {
                                                    return Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(35.0),
                                                        child: Icon(
                                                          Icons.do_not_disturb,
                                                          size: 35,
                                                          color: mainColor,
                                                        ),
                                                      ),
                                                    );
                                                    // https://www.appsloveworld.com/flutter/100/29/handle-statuscode-403-for-image-network
                                                    // Solved - Handle StateCode: 403 For Image.Network - Flutter
                                                    // Cause Image failed in Api - -
                                                  },
                                                  image: NetworkImage(
                                                    '${snapshot.data[index].urlToImage}',
                                                  ),
                                                  fit: BoxFit.cover,
                                                  height: 200,
                                                  width: 400,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 10,
                                              bottom: 20,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .only(right: 10),
                                                      child: Text(
                                                        '${snapshot.data[index].title}',
                                                        style: TextStyle(
                                                            color: whiteColor,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    width: 330,
                                                    decoration: BoxDecoration(
                                                        color: Colors.black
                                                            .withOpacity(.7),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5,
                                                          vertical: 3),
                                                      child: Text(
                                                        '${snapshot.data[index].publishedAt}',
                                                        // '${currentDate} ${currentTime}',
                                                        style: TextStyle(
                                                            color: whiteColor,
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                        color: Colors.black
                                                            .withOpacity(.7),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        child: NewsCard(
                                          image: (snapshot
                                                      .data[index].urlToImage ==
                                                  null)
                                              ? 'https://studio.uxpincdn.com/studio/wp-content/uploads/2021/06/10-error-404-page-examples-for-UX-design.png.webp'
                                              : snapshot.data[index].urlToImage,
                                          text: (snapshot.data[index].title ==
                                                  null)
                                              ? 'No Data'
                                              : snapshot.data[index].title,
                                          subText: (snapshot.data[index]
                                                      .publishedAt ==
                                                  null)
                                              ? 'No Data'
                                              : snapshot
                                                  .data[index].publishedAt,
                                          name: (snapshot.data[index].name ==
                                                  null)
                                              ? 'No Data'
                                              : snapshot.data[index].name,
                                        ),
                                      );
                              },
                            )
                          : Center(
                              child: CircularProgressIndicator(
                              color: mainColor,
                            ));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
