import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/images.dart';

class NewsCard extends StatelessWidget {

  var image;
  var text;
  var subText;
  var name;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: whiteColor,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: ClipRect(
                child: Image(
                  image: NetworkImage((image == null) ? '' : '$image'),
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
                  fit: BoxFit.fill,
                  width: 100,
                  height: 100,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    // width: 110,
                    height: 26,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(.0),
                      child: Row(
                        children: [
                          Image(
                            image: AssetImage(bbc),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            name == null ? 'no data' : '$name',
                            style: TextStyle(
                              color: blackColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 200,
                    child: Text(
                      text == null ? 'no data' : '$text',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:
                      TextStyle(fontSize: 14,
                          fontWeight: FontWeight.bold,
                        color: blackColor
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 240,
                    alignment: Alignment.bottomRight,
                    child: Text(
                      (subText == null) ? 'No Data' : '$subText',

                      // ('$subText' == null) ? 'no data' :
                      // '$subText',
                      style: TextStyle(color: subTextColor, fontSize: 12),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  NewsCard({
    required this.image,
    required this.text,
    required this.subText,
    required this.name,
  });
}
