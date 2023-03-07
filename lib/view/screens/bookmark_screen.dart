import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../constants/colors.dart';
import '../../constants/icons.dart';
import '../../controller/news_controller.dart';
import '../components/news_card.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  Future<void> _handleRefresh() async {
    // reloading takes some time
    return await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        title: Text(
          'Bookmarks',
          style: TextStyle(
              color: blackColor, fontSize: 30, fontWeight: FontWeight.w700),
        ),
        centerTitle: false,
      ),
      backgroundColor: whiteColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: LiquidPullToRefresh(
            onRefresh: _handleRefresh,
            color: mainColor,
            height: 100,
            backgroundColor: whiteColor,
            child: ListView(
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
                              'Search in Bookmarks',
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
                FutureBuilder(
                  future: NewsApi.getCategoryData('general'),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    return (snapshot.hasData)
                        ? ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
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
                                    subText:
                                        (snapshot.data[index].publishedAt ==
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
      ),
    );
  }
}
