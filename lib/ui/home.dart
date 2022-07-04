import 'dart:convert';

import 'package:bebandung/model/user_model.dart';
import 'package:bebandung/ui/food_list.dart';
import 'package:bebandung/ui/favorites_food_list.dart';
import 'package:bebandung/ui/search_screen.dart';
import 'package:bebandung/ui/wisata_list.dart';
import 'package:bebandung/ui/user_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bebandung/config/constant.dart';
import 'package:bebandung/config/global_style.dart';
import 'package:bebandung/ui/reusable/cache_image_network.dart';
import 'package:bebandung/model/feature/banner_slider_model.dart';
import 'package:bebandung/model/feature/category_model.dart';
import 'package:bebandung/model/food_model.dart';
import 'package:bebandung/model/wisata_model.dart';
import 'package:bebandung/ui/reusable_widget.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // initialize global function and reusable widget
  final _reusableWidget = ReusableWidget();

  int _currentImageSlider = 0;
  List<BannerSliderModel> _bannerData = [];
  List<CategoryModel> _categoryData = [];
  List<FoodModel> _foodData = [];
  List<WisataModel> _moreRestaurantData = [];

  List _get = [];

  final user = FirebaseAuth.instance.currentUser;
  Users? loggedInUser;

  @override
  void initState() {
    _getData();
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) => loggedInUser = Users.fromMap(value.data()));
    Future.delayed(Duration.zero, () {
      getNews();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Stream<List<FoodModel>> readFoods() => FirebaseFirestore.instance
      .collection("foods")
      .snapshots()
      .map((snapshots) =>
          snapshots.docs.map((doc) => FoodModel.fromMap(doc.data())).toList());

  Stream<List<WisataModel>> readWisata() => FirebaseFirestore.instance
      .collection("wisata")
      .snapshots()
      .map((snapshots) => snapshots.docs
          .map((doc) => WisataModel.fromMap(doc.data()))
          .toList());

  Future getNews() async {
    const String baseUrl = 'https://newsapi.org/v2';
    const String apiKey = 'apiKey=f8fd87d48cf746e0a817a4f7a21bafe4';
    try {
      const url = '$baseUrl/everything?$apiKey&q=bandung&language=id';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _get = data['articles'];
        });
      }
    } catch (e) {
      throw e;
    }
  }

  void _getData() {
    /*
    Banner Data Information
    width = 800px
    height = 320px
     */
    _bannerData.add(BannerSliderModel(id: 1, image: BANNER_NO_IMAGE_URL));
    _bannerData.add(BannerSliderModel(id: 2, image: BANNER_NO_IMAGE_URL));
    _bannerData.add(BannerSliderModel(id: 3, image: BANNER_NO_IMAGE_URL));
    _bannerData.add(BannerSliderModel(id: 4, image: BANNER_NO_IMAGE_URL));

    /*
    Image Information
    width = 110px
    height = 110px
     */
    _categoryData.add(CategoryModel(
        id: 1,
        name: 'Wisata',
        image: GLOBAL_URL +
            '/assets/images/apps/food_delivery/category/nearby.png'));
    _categoryData.add(CategoryModel(
        id: 2,
        name: 'Kuliner',
        image: GLOBAL_URL +
            '/assets/images/apps/food_delivery/category/western.png'));
    _categoryData.add(CategoryModel(
        id: 3,
        name: 'Coming Soon',
        image:
            GLOBAL_URL + '/assets/images/apps/food_delivery/category/new.png'));
    _categoryData.add(CategoryModel(
        id: 4,
        name: 'Coming Soon',
        image: GLOBAL_URL +
            '/assets/images/apps/food_delivery/category/best.png'));
  }

  @override
  Widget build(BuildContext context) {
    final double boxImageSize = (MediaQuery.of(context).size.width / 3);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: GlobalStyle.appBarIconThemeColor,
        ),
        systemOverlayStyle: GlobalStyle.appBarSystemOverlayStyle,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bebandung',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black)),
            GestureDetector(
              child: Row(
                children: [
                  Flexible(
                    child: Text("Wisata menjadi lebih seru",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: GlobalStyle.appBarBackgroundColor,
        // create search text field in the app bar
        bottom: PreferredSize(
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                color: Colors.grey[100]!,
                width: 1.0,
              )),
            ),
            padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
            height: kToolbarHeight,
            child: Container(
              child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) => Colors.grey[100]!,
                    ),
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchAddressPage()));
                    // Fluttertoast.showToast(
                    //     msg: 'Not Implemented',
                    //     toastLength: Toast.LENGTH_SHORT);
                  },
                  child: Row(
                    children: [
                      SizedBox(width: 8),
                      Icon(Icons.search, color: Colors.grey[500], size: 18),
                      SizedBox(width: 8),
                      Text('What are you craving ?',
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontWeight: FontWeight.normal))
                    ],
                  )),
            ),
          ),
          preferredSize: Size.fromHeight(kToolbarHeight),
        ),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 16),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FavoritesFoodListPage()));
                  // Fluttertoast.showToast(
                  //     msg: 'Not Implemented', toastLength: Toast.LENGTH_SHORT);
                },
                child: Icon(Icons.favorite_border, color: BLACK77),
              )),
          Padding(
              padding: EdgeInsets.only(right: 16),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      (context),
                      MaterialPageRoute(
                          builder: (context) => UserProfilePage()),
                      (route) => false);
                  // Fluttertoast.showToast(
                  //     msg: 'Not Implemented', toastLength: Toast.LENGTH_SHORT);
                },
                child: Icon(Icons.person, color: BLACK77),
              )),
        ],
      ),
      body: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: [
          _buildHomeBanner(),
          SizedBox(height: 16),
          _buildMenu(),
          _buildWisata(boxImageSize),
          _buildFoods(boxImageSize),
        ],
      ),
    );
  }

  Widget _buildHomeBanner() {
    return Column(
      children: [
        SizedBox(height: 12),
        _get.isEmpty
            ? Center(
                child: Text('No News Available'),
              )
            : CarouselSlider(
                items: _get
                    .map((item) => Stack(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                Uri newsUrl = Uri.parse(item['url']);
                                if (await canLaunchUrl(newsUrl)) {
                                  await launchUrl(newsUrl);
                                }
                              },
                              child: Stack(
                                alignment: Alignment.bottomLeft,
                                children: [
                                  Container(
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      child: buildCacheNetworkImage(
                                          url: item['urlToImage'],
                                          width: 0.87 *
                                              MediaQuery.of(context)
                                                  .size
                                                  .width),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 15, left: 15, right: 15),
                                    child: Text(
                                      item['title'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ))
                    .toList(),
                options: CarouselOptions(
                    aspectRatio: 2.88,
                    viewportFraction: 0.9,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 4),
                    autoPlayAnimationDuration: Duration(milliseconds: 300),
                    enlargeCenterPage: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentImageSlider = index;
                      });
                    }),
              ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _bannerData.map((item) {
            int index = _bannerData.indexOf(item);
            return AnimatedContainer(
              duration: Duration(milliseconds: 150),
              width: _currentImageSlider == index ? 8.0 : 4.0,
              height: 4.0,
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color:
                    _currentImageSlider == index ? SOFT_BLUE : Colors.grey[300],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildMenu() {
    return GridView.count(
      padding: EdgeInsets.symmetric(horizontal: 16),
      primary: false,
      childAspectRatio: 1,
      shrinkWrap: true,
      crossAxisSpacing: 0,
      mainAxisSpacing: 0,
      crossAxisCount: 4,
      children: List.generate(_categoryData.length, (index) {
        return GestureDetector(
            onTap: () {
              if (_categoryData[index].name == "Coming Soon") {
                Fluttertoast.showToast(
                    msg: 'Coming Soon!', toastLength: Toast.LENGTH_SHORT);
              } else if (_categoryData[index].name == "Kuliner") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FoodListPage(
                              user: loggedInUser!,
                            )));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RestaurantListPage(
                              title: _categoryData[index].name,
                              user: loggedInUser!,
                            )));
              }
            },
            child: Column(children: [
              buildCacheNetworkImage(
                  width: 40,
                  height: 40,
                  url: _categoryData[index].image,
                  plColor: Colors.transparent),
              Flexible(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    _categoryData[index].name,
                    style: TextStyle(
                      color: BLACK55,
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ]));
      }),
    );
  }

  Widget _buildWisata(boxImageSize) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Wisata', style: GlobalStyle.horizontalTitle),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RestaurantListPage(
                                title: 'Wisata',
                                user: loggedInUser!,
                              )));
                },
                child: Text('View All',
                    style: GlobalStyle.viewAll, textAlign: TextAlign.end),
              )
            ],
          ),
        ),
        StreamBuilder<List<WisataModel>>(
            stream: readWisata(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final wisata = snapshot.data;
                return Container(
                    margin: EdgeInsets.only(top: 8),
                    height: boxImageSize * GlobalStyle.cardHeightMultiplication,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      scrollDirection: Axis.horizontal,
                      itemCount: wisata!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _reusableWidget.buildHorizontalListCard(
                            context, wisata[index], 'restaurant', loggedInUser);
                      },
                    ));
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ],
    );
  }

  Widget _buildFoods(boxImageSize) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Kuliner', style: GlobalStyle.horizontalTitle),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FoodListPage(
                                title: 'Food',
                                user: loggedInUser!,
                              )));
                },
                child: Text('View All',
                    style: GlobalStyle.viewAll, textAlign: TextAlign.end),
              )
            ],
          ),
        ),
        StreamBuilder<List<FoodModel>>(
            stream: readFoods(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final food = snapshot.data!;
                return Container(
                    margin: EdgeInsets.only(top: 8),
                    height: boxImageSize * GlobalStyle.cardHeightMultiplication,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      scrollDirection: Axis.horizontal,
                      itemCount: food.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _reusableWidget.buildHorizontalListCard(
                            context, food[index], 'food', loggedInUser);
                      },
                    ));
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ],
    );
  }
}
