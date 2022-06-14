import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sampleproject/screen/DetailsScreen.dart';
import 'package:sampleproject/screen/DetailsScreen2.dart';

class imageStyle1 extends StatelessWidget {
  String urlImage;
  String code;
  double price;
  String title;
  var description;
  int index;
  String idKey;
  imageStyle1({
    required this.idKey,
    required this.index,
    required this.urlImage,
    required this.price,
    required this.code,
    required this.title,
    required this.description,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            child: DetailsScreen2(
                idKey: idKey,
                index: index,
                current_price: price,
                description: description,
                image_code: code,
                image_url_items: urlImage,
                label: '124GA'),
            type: PageTransitionType.rightToLeft,
            duration: Duration(milliseconds: 300),
          ),
        );
      },
      child: Container(
        width: 210,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blueGrey,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 200,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage('${urlImage}'), ////
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    '${title}', ////
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.ethereum,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${price}', ////
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 25),
                  child: Text(
                    '${code}',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
