import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kenya_yetu_admin/const/AppColors.dart';
import 'package:kenya_yetu_admin/ui/login_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  // void initState() {
  //   () => super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    int active = 0;
    final urlImages = [
      'asset/pic1.png',
      'asset/pic5.png',
      'asset/pic3.png',
      'asset/pic4.png',
      'asset/pic6.png',
    ];
    List<T> map<T>(List list, Function handler) {
      List<T> result = [];
      for (var i = 0; i < list.length; i++) {
        result.add(handler(i, list[i]));
      }
      return result;
    }

    return Scaffold(
      backgroundColor: green,
      body: SafeArea(
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                height: 100,
                child: Image.asset("asset/logo.png"),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Kenya Yetu Admin",
                style: TextStyle(
                    color: grey, fontWeight: FontWeight.bold, fontSize: 40.sp),
              ),
              SizedBox(
                height: 60.h,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: Colors.white,
                  height: 50,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => LoginScreen()));
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(color: green, fontSize: 20),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 80,
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CarouselSlider.builder(
                          options: CarouselOptions(
                            height: 200,
                            autoPlay: true,
                            autoPlayInterval: const Duration(
                              seconds: 5,
                            ),
                            viewportFraction: 1,
                            enlargeCenterPage: true,
                            enlargeStrategy: CenterPageEnlargeStrategy.height,
                            onPageChanged: (index, reason) =>
                                setState(() {
                              active = index;
                            }),
                          ),
                          itemCount: urlImages.length,
                          itemBuilder: (context, index, realIndex) {
                            final urlImage = urlImages[index];
                            return imageBuilder(urlImage);
                          },
                        ),
                        SizedBox(
                          height: 32,
                        ),
                      ],
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

  Container imageBuilder(String urlImage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      // color: Colors.grey,
      child: Image.asset(
        urlImage,
        fit: BoxFit.cover,
      ),
    );
  }
}
