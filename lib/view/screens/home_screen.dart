import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:observer/constants/colors.dart';
import 'package:observer/constants/icons.dart';
import 'package:observer/controller/news_controller.dart';
import '../../constants/images.dart';
import '../components/news_card.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> _selectedItems = [];
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
        title: Image.asset(logoSmall),
        centerTitle: false,
        actions: [
          IconButton(onPressed: (){
            Navigator.pushNamed(context, '/searchScreen');
          },
              icon: Image.asset(search),),
        ],
      ),
      body: LiquidPullToRefresh(
        onRefresh: _handleRefresh,
        color: mainColor,
        height: 100,
        backgroundColor: whiteColor,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                FutureBuilder(
                  future: NewsApi.getData(),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  return (snapshot.hasData) ?
                  CarouselSlider.builder(
                      itemCount: 4,
                      itemBuilder: (BuildContext context , int index, int realIndex){
                        return Stack(
                          children: [
                            ClipRect(
                              child: Image(
                                image: NetworkImage((snapshot
                                    .data[index].urlToImage ==
                                    null)
                                    ? 'https://studio.uxpincdn.com/studio/wp-content/uploads/2021/06/10-error-404-page-examples-for-UX-design.png.webp'
                                    : '${snapshot.data[index].urlToImage}'),
                                errorBuilder: (BuildContext, Object exception, StackTrace) {
                                  return Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(35.0),
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
                                height: MediaQuery.of(context).size.height,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Positioned(
                              child: Padding(
                                padding: EdgeInsets.all(2),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(5),
                                        color: Colors.black.withOpacity(.6),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          children: [
                                            Image(
                                              image: AssetImage(bbc),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '${snapshot.data[index].name}',
                                              style: TextStyle(
                                                color: whiteColor,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(5),
                                              color: Colors.black
                                                  .withOpacity(.6),
                                            ),
                                            width: 330,
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.all(
                                                    5.0),
                                                child: Text(
                                                  '${snapshot.data[index].title}',
                                                  // textDirection: (TextDirection.rtl),
                                                  style: TextStyle(
                                                    color: whiteColor,
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 7,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                ),
                              ),
                              bottom: 40,
                              left: 10,
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: ListView.builder(
                                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/2.8),
                                  itemCount: 4,
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
                                                ? mainColor
                                                : subTextColor,
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          height: 5,
                                        ),
                                      ],
                                    );
                                  },
                                physics: NeverScrollableScrollPhysics(),
                                  ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: GestureDetector(
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.black.withOpacity(.5),
                                    ),
                                    child: Image(
                                      image: AssetImage(_selectedItems.contains(index)? bookmarkActive : bookmarkDisable),
                                     color: _selectedItems.contains(index)
                                          ? mainColor
                                          : whiteColor,
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _selectedItems.contains(index)
                                          ? _selectedItems.remove(index)
                                          : _selectedItems.add(index);
                                    });                                },
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      options: CarouselOptions(
                        autoPlayInterval: Duration(seconds: 2),
                        autoPlay: true,
                        scrollDirection: Axis.horizontal,
                        initialPage: 0,
                        viewportFraction: 1,
                        height: MediaQuery.of(context).size.height / 2.5,
                        onPageChanged: (index, reason){
                          setState(() {
                            currentIndex = index;
                          });
                        }
                      )) :
                  Center(
                    child: CircularProgressIndicator(
                      color: mainColor,
                    ),
                  );
                },),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Business',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: blackColor
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 100,
                    ),
                    FutureBuilder(
                      future: NewsApi.getCategoryData('business'),
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
                            : Center(child: CircularProgressIndicator(color: mainColor,));
                      },
                    ),
                    Row(
                      children: [
                        Text(
                          'More from Business',
                          style: TextStyle(
                              color: blackColor
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Image(image: AssetImage(right))
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sports',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: blackColor
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 100,
                    ),
                    FutureBuilder(
                      future: NewsApi.getCategoryData('sports'),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        return (snapshot.hasData)
                            ? ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 2,
                          itemBuilder: (BuildContext context, int index) {
                            return NewsCard(
                              image: (snapshot.data[index].urlToImage ==
                                  null)
                                  ? 'https://studio.uxpincdn.com/studio/wp-content/uploads/2021/06/10-error-404-page-examples-for-UX-design.png.webp'
                                  : snapshot.data[index].urlToImage,
                              text: (snapshot.data[index].title == null)
                                  ? 'No Data'
                                  : snapshot.data[index].title,
                              subText:
                              (snapshot.data[index].publishedAt == null)
                                  ? 'No Data'
                                  : snapshot.data[index].publishedAt,
                              name: (snapshot.data[index].name == null)
                                  ? 'No Data'
                                  : snapshot.data[index].name,
                            );
                          },
                        )
                            : Center(child: CircularProgressIndicator(color: mainColor,));
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 50,
                    ),
                    Row(
                      children: [
                        Text(
                          'More from sports',
                          style: TextStyle(
                            color: blackColor
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Image(image: AssetImage(right))
                      ],
                    )
                  ],
                ),
                SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}