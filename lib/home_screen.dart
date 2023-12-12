import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_api/models/newsModel.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<String> images = [
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png"
  ];
  CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: getNews(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              List<NewsArticle> news = snapshot.data ?? [];
              return Column(
                children: [
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/newsLogo.png",
                        height: 30,width: 30,
                      ),
                      SizedBox(width: 10,),
                      Text("NEWSIFY",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SF Compact',
                            fontWeight: FontWeight.bold,
                            fontSize: 26
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: Colors.black,
                        ),
                        labelText: "Search Anything",
                        labelStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontFamily: 'SF Compact',
                            fontWeight: FontWeight.bold
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/megaphone.png",
                      height: 30,width: 30,
                      ),
                      SizedBox(width: 10,),
                      Text("BREAKING NEWS",
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontFamily: 'SF Compact',
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  if (snapshot.connectionState == ConnectionState.waiting) Shimmer.fromColors(
                    baseColor: Colors.lightGreenAccent,
                    highlightColor: Colors.lightBlueAccent,
                    child: Container(
                      height: 300,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      width: double.maxFinite,
                    ),
                  ) else CarouselSlider.builder(
                    itemCount: news.length,
                    options: CarouselOptions(
                      enlargeCenterPage: true,
                      aspectRatio: 9/16,
                      height: 320,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: false,
                      autoPlayAnimationDuration: const Duration(milliseconds: 800),
                      viewportFraction: 0.8,
                    ),
                    itemBuilder: (BuildContext context, int index, int realIndex) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  child: Image.network(news[index].urlToImage??'',
                                    height: 200,
                                    width: double.maxFinite,
                                    fit: BoxFit.cover,
                                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                      return Container(
                                        height: 200,
                                        width: double.maxFinite,
                                        color: Colors.grey, // You can use any color you prefer
                                        child: Center(
                                          child: Text(
                                            'ERROR GETTING IMAGE',
                                            style: TextStyle(color: Colors.white,
                                            fontFamily: 'SF Compact',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )),
                            SizedBox(height: 10,),
                            Container(
                              child: Text(news[index].title.toString().toUpperCase(),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'SF Compact',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/webpages.png",
                      height: 30, width: 30,
                      ),
                      SizedBox(width: 10,),
                      Text("RECENT NEWS",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontFamily: 'SF Compact',
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 1, itemBuilder: (BuildContext context, int index) {
                    return Container(
                      color: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Your row content goes here
                        ],
                      ),
                    );
                  }, // Set it to null for infinite list
                  )
                ],
              );
          },
    ),
      )));
  }

  //APIS HERE
  Future<List<NewsArticle>> getNews() async {
    List<NewsArticle> news = [];
    try {
      String url = "https://newsapi.org/v2/everything?q=tesla&from=2023-07-10&sortBy=publishedAt&apiKey=8b5168ef43a9407291595f36b36124e6";
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      var responseData = json.decode(response.body);
      if (response.statusCode == 200) {
         final articles = responseData['articles'];
         for(int i = 0; i < articles.length; ++i){
           NewsArticle dataNews = NewsArticle.fromJson(articles[i]);
           news.add(dataNews);
         }
      }
      print("TILL HERE"+news.length.toString());
    }
    catch (e) {
      print("EXCEPTION - " + e.toString());
    }
    return news;
  }
}
