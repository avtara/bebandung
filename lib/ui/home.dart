import 'package:bebandung/ui/detail_food.dart';
import 'package:bebandung/ui/detail_restaurant.dart';
import 'package:bebandung/ui/order_history.dart';
import 'package:bebandung/ui/category_menu.dart';
import 'package:bebandung/ui/favorites_food_list.dart';
import 'package:bebandung/ui/search_restaurant.dart';
import 'package:bebandung/ui/restaurant_list.dart';
import 'package:bebandung/ui/user_profile.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bebandung/config/constant.dart';
import 'package:bebandung/config/global_style.dart';
import 'package:bebandung/ui/reusable/cache_image_network.dart';
import 'package:bebandung/ui/reusable/global_function.dart';
import 'package:bebandung/model/feature/banner_slider_model.dart';
import 'package:bebandung/model/feature/category_model.dart';
import 'package:bebandung/model/food_model.dart';
import 'package:bebandung/model/restaurant_model.dart';
import 'package:bebandung/ui/reusable_widget.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // initialize global function and reusable widget
  final _globalFunction = GlobalFunction();
  final _reusableWidget = ReusableWidget();

  int _currentImageSlider = 0;
  List<BannerSliderModel> _bannerData = [];
  List<CategoryModel> _categoryData = [];
  List<RestaurantModel> _nearbyFoodData = [];
  List<RestaurantModel> _orderAgainData = [];
  List<FoodModel> _foodDiscountData = [];
  List<RestaurantModel> _moreRestaurantData = [];

  List<String> _addressData = [];
  String _address = 'Michelia Home Address';

  @override
  void initState() {
    _getData();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getData() {
    _addressData.add('Michelia Home Address');
    _addressData.add('Office Address');
    _addressData.add('Apartment Address');
    _addressData.add('Mom Address');

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

    /*
    Image Information
    width = 800px
    height = 600px
    ratio width height = 4:3
     */
    _nearbyFoodData = [
      RestaurantModel(
          id: 1,
          name: "Diaswan Chicken",
          tag: "Chicken, Rice",
          image: NO_IMAGE_URL,
          rating: 4.9,
          distance: 0.4,
          promo: '90% Off | Get Gift Voucher If You Buy 4 pcs',
          location: "Dramaga Street II"),
      RestaurantModel(
          id: 2,
          name: "Nasi Uduk Bu Joko",
          tag: "Rice, Indonesian",
          image: NO_IMAGE_URL,
          rating: 5,
          distance: 0.6,
          promo: 'Buy 1 Get 1',
          location: "Dramaga Raya"),
      RestaurantModel(
          id: 3,
          name: "Salad Sehat",
          tag: "Healthy Food, Salad",
          image: NO_IMAGE_URL,
          rating: 4.3,
          distance: 0.7,
          promo: '',
          location: "Dramaga Raya"),
      RestaurantModel(
          id: 4,
          name: "Dimsum",
          tag: "Japanese, Fresh, Steam",
          image: NO_IMAGE_URL,
          rating: 4.9,
          distance: 0.7,
          promo: '20% Off',
          location: "Dramaga Street III"),
    ];

    /*
    Image Information
    width = 800px
    height = 600px
    ratio width height = 4:3
     */
    _orderAgainData = [
      RestaurantModel(
          id: 1,
          name: "Diaswan Chicken",
          tag: "Chicken, Rice",
          image: NO_IMAGE_URL,
          rating: 4.9,
          distance: 0.4,
          promo: '90% Off | Get Gift Voucher If You Buy 4 pcs',
          location: "Dramaga Street II"),
      RestaurantModel(
          id: 2,
          name: "Beef Lovers",
          tag: "Beef, Yakiniku, Japanese Food",
          image: NO_IMAGE_URL,
          rating: 5,
          distance: 0.6,
          promo: 'Buy 1 Get 1',
          location: "Botani Square Mall Bogor"),
      RestaurantModel(
          id: 3,
          name: "Salad Stop",
          tag: "Healthy Food, Salad",
          image: NO_IMAGE_URL,
          rating: 4.3,
          distance: 0.7,
          promo: '',
          location: "Botani Square Mall Bogor"),
      RestaurantModel(
          id: 4,
          name: "Steam Boat Lovers",
          tag: "Hot, Fresh, Steam",
          image: NO_IMAGE_URL,
          rating: 4.9,
          distance: 0.7,
          promo: '20% Off',
          location: "Botani Square Mall Bogor"),
    ];

    /*
    Image Information
    width = 800px
    height = 600px
    ratio width height = 4:3
     */
    _foodDiscountData = [
      FoodModel(
          id: 4,
          restaurantName: "Steam Boat Lovers",
          name: "Seafood shabu-shabu",
          image: NO_IMAGE_URL,
          price: 40000,
          discount: 15,
          location: "Dramaga Street V"),
      FoodModel(
          id: 3,
          restaurantName: "Salad Stop",
          name: "Sesame Salad",
          image: NO_IMAGE_URL,
          price: 22500,
          discount: 5,
          location: "Dramaga Street III"),
      FoodModel(
          id: 2,
          restaurantName: "Beef Lovers",
          name: "Beef Yakiniku",
          image: NO_IMAGE_URL,
          price: 30000,
          discount: 45,
          location: "Dramaga Street IV"),
      FoodModel(
          id: 1,
          restaurantName: "Mr. Hungry",
          name: "Hainam Chicken Rice",
          image: NO_IMAGE_URL,
          price: 21000,
          discount: 10,
          location: "Dramaga Street I"),
    ];

    /*
    Image Information
    width = 800px
    height = 600px
    ratio width height = 4:3
     */
    _moreRestaurantData = [
      RestaurantModel(
          id: 2,
          name: "Beef Lovers",
          tag: "Beef, Yakiniku, Japanese Food",
          image: NO_IMAGE_URL,
          rating: 5,
          distance: 0.6,
          promo: 'Buy 1 Get 1',
          location: "BTM Mall"),
      RestaurantModel(
          id: 1,
          name: "Diaswan Chicken",
          tag: "Chicken, Rice",
          image: NO_IMAGE_URL,
          rating: 4.9,
          distance: 0.4,
          promo: '90% Off | Get Gift Voucher If You Buy 4 pcs',
          location: "Dramaga Street II"),
      RestaurantModel(
          id: 3,
          name: "Salad Stop",
          tag: "Healthy Food, Salad",
          image: NO_IMAGE_URL,
          rating: 4.3,
          distance: 0.7,
          promo: '',
          location: "Botani Square Mall Bogor"),
      RestaurantModel(
          id: 4,
          name: "Italian Food",
          tag: "Penne, Western Food",
          image: NO_IMAGE_URL,
          rating: 4.6,
          distance: 0.9,
          promo: '',
          location: "Dramaga Raya I"),
    ];
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
                            builder: (context) => SearchRestaurantPage()));
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserProfilePage()));
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
          _buildNearbyFood(boxImageSize),
          _buildOrderAgain(boxImageSize),
        ],
      ),
    );
  }

  Widget _buildHomeBanner() {
    return Column(
      children: [
        SizedBox(height: 12),
        CarouselSlider(
          items: _bannerData
              .map((item) => Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      child: buildCacheNetworkImage(
                          url: item.image,
                          width: 0.87 * MediaQuery.of(context).size.width),
                    ),
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
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CategoryMenuPage(
                            title: _categoryData[index].name)));
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

  Widget _buildNearbyFood(boxImageSize) {
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
                          builder: (context) =>
                              RestaurantListPage(title: 'Wisata')));
                  // Fluttertoast.showToast(
                  //     msg: 'Not Implemented', toastLength: Toast.LENGTH_SHORT);
                },
                child: Text('View All',
                    style: GlobalStyle.viewAll, textAlign: TextAlign.end),
              )
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.only(top: 8),
            height: boxImageSize * GlobalStyle.cardHeightMultiplication,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 12),
              scrollDirection: Axis.horizontal,
              itemCount: _nearbyFoodData.length,
              itemBuilder: (BuildContext context, int index) {
                return _reusableWidget.buildHorizontalListCard(
                    context, _nearbyFoodData[index]);
              },
            )),
      ],
    );
  }

  Widget _buildOrderAgain(boxImageSize) {
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
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => RestaurantListPage(title: 'Order Again')));
                  Fluttertoast.showToast(
                      msg: 'Not Implemented', toastLength: Toast.LENGTH_SHORT);
                },
                child: Text('View All',
                    style: GlobalStyle.viewAll, textAlign: TextAlign.end),
              )
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.only(top: 8),
            height: boxImageSize * GlobalStyle.cardHeightMultiplication,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 12),
              scrollDirection: Axis.horizontal,
              itemCount: _orderAgainData.length,
              itemBuilder: (BuildContext context, int index) {
                return _reusableWidget.buildHorizontalListCard(
                    context, _orderAgainData[index]);
              },
            )),
      ],
    );
  }

  Widget _buildFoodCard(data) {
    final double imageWidth = (MediaQuery.of(context).size.width / 2.3);
    final double imageheight = (MediaQuery.of(context).size.width / 3.07);
    return Container(
      width: imageWidth,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        elevation: 2,
        color: Colors.white,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailRestaurantPage()));
            // Fluttertoast.showToast(
            //     msg: 'Not Implemented', toastLength: Toast.LENGTH_SHORT);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DetailFoodPage()));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(6)),
                  child: buildCacheNetworkImage(
                      width: imageWidth, height: imageheight, url: data.image)),
              Container(
                margin: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 36,
                      child: Text(data.name,
                          style: GlobalStyle.cardTitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                    ),
                    SizedBox(height: 6),
                    Text(data.restaurantName + ' - ' + data.location,
                        style: GlobalStyle.textRestaurantNameSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        Text(
                            'Rp.' +
                                _globalFunction.removeDecimalZeroFormat(
                                    ((100 - data.discount) * data.price / 100)),
                            style: GlobalStyle.textPrice),
                        data.discount != 0
                            ? SizedBox(width: 6)
                            : SizedBox.shrink(),
                        data.discount != 0
                            ? Text(
                                'Rp.' +
                                    _globalFunction
                                        .removeDecimalZeroFormat(data.price),
                                style: GlobalStyle.textPriceLineThrough)
                            : SizedBox.shrink()
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
