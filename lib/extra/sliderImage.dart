import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sampleproject/Database/dataInf.dart';
import 'package:sampleproject/screen/DetailsScreen2.dart';

class sliderImage extends StatefulWidget {
  String idKey;
  sliderImage({required this.idKey});
  @override
  State<sliderImage> createState() => _sliderImageState();
}

class _sliderImageState extends State<sliderImage> {
  Widget getIndex(bool index) {
    return Container(
      width: 12,
      height: 12,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: index ? Colors.deepOrange : Colors.white,
      ),
    );
  }

  int count = 0;

  bool isLikeImage = false;

  var colorButton = Color(0xffFFFFFF);

  getIndexImage() {
    List<Widget> getColor = [];
    for (int i = 0; i < 3; i++) {
      if (count == i) {
        getColor.add(getIndex(true));
      } else {
        getColor.add(getIndex(false));
      }
    }
    return getColor;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: ((context) => descriptionPage(
            //               urlImage: '',
            //             ))));
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    child: DetailsScreen2(
                        idKey: widget.idKey,
                        index: dataInf[count]['id'],
                        current_price: dataInf[count]['price'],
                        description: dataInf[count]['description'],
                        image_code: dataInf[count]['code'],
                        image_url_items: dataInf[count]['imageUrl'],
                        label: dataInf[count]['title']),
                    type: PageTransitionType.rightToLeft,
                    duration: Duration(milliseconds: 300),
                  ),
                );
              },
              child: CarouselSlider.builder(
                  itemCount: 3,
                  options: CarouselOptions(
                    onPageChanged: ((index, reason) {
                      setState(() {
                        count = index;

                        print('index == $count');
                      });
                    }),

                    autoPlay: true,
                    height: 260,
                    autoPlayCurve: Curves.easeIn,
                    autoPlayAnimationDuration: Duration(milliseconds: 700),
                    enlargeCenterPage: true,
                    // viewportFraction: 1,
                  ),
                  itemBuilder: (context, index, i) {
                    return Container(
                      // width: double.infinity,
                      alignment: Alignment.bottomLeft,
                      // height: 356,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage(
                            dataInf[index]['imageUrl'] as String,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Text(
                          dataInf[index]['title'] as String,
                          style: GoogleFonts.roadRage(
                            fontSize: 80,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ),
        Positioned(
          bottom: 1,
          child: Container(
            margin: EdgeInsets.all(20),
            child: Row(
              children: getIndexImage(),
            ),
          ),
        ),
      ],
    );
  }
}
