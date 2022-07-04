import 'package:bebandung/config/constant.dart';
import 'package:bebandung/config/global_style.dart';
import 'package:bebandung/model/user_model.dart';
import 'package:bebandung/model/wisata_model.dart';
import 'package:bebandung/model/food_model.dart';
import 'package:bebandung/ui/reusable_widget.dart';
import 'package:bebandung/ui/reusable/cache_image_network.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DetailRestaurantPage extends StatefulWidget {
  final WisataModel wisata;
  const DetailRestaurantPage({Key? key, required this.wisata})
      : super(key: key);

  @override
  _DetailRestaurantPageState createState() => _DetailRestaurantPageState();
}

class _DetailRestaurantPageState extends State<DetailRestaurantPage> {
  // initialize reusable widget
  final _reusableWidget = ReusableWidget();

  bool readMore = false;

  bool _showAppBar = false;

  late ScrollController _scrollController;

  List<FoodModel> _foodData = [];
  List<FoodModel> listFoods = [];

  final user = FirebaseAuth.instance.currentUser;
  Users? loggedInUser;

  @override
  void initState() {
    setupAnimateAppbar();
    super.initState();
    Future.delayed(Duration.zero, () {
      FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .get()
          .then((value) {
        loggedInUser = Users.fromMap(value.data());
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void setupAnimateAppbar() {
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.hasClients &&
            _scrollController.offset >
                (MediaQuery.of(context).size.width * 3 / 4) - 80) {
          setState(() {
            _showAppBar = true;
          });
        } else {
          setState(() {
            _showAppBar = false;
          });
        }
      });
  }

  bool getButton(String name, List data) {
    bool found = false;
    for (int i = 0; i < data.length; i++) {
      if (data[i] == name) {
        found = true;
      }
    }
    return found;
  }

  @override
  Widget build(BuildContext context) {
    final double bannerWidth = MediaQuery.of(context).size.width;
    final double bannerHeight = MediaQuery.of(context).size.width * 3 / 4;
    return loggedInUser == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            body: ListView(
              controller: _scrollController,
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.all(0),
              children: [
                buildCacheNetworkImage(
                    width: bannerWidth,
                    height: bannerHeight,
                    url: widget.wisata.image),
                _buildDetail(),
              ],
            ),
          );
  }

  Widget _buildDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 12,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.wisata.name!,
                  style: GlobalStyle.restaurantTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis),
              getButton(widget.wisata.name!, loggedInUser!.favouriteWisata!)
                  ? IconButton(
                      onPressed: () {
                        List food = [];
                        food.add(widget.wisata.name);
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(loggedInUser!.id)
                            .update({
                          "favouriteWisata": FieldValue.arrayRemove(food)
                        });
                        setState(() {
                          FirebaseFirestore.instance
                              .collection("users")
                              .doc(user!.uid)
                              .get()
                              .then((value) {
                            loggedInUser = Users.fromMap(value.data());
                            setState(() {});
                          });
                        });
                      },
                      icon: Icon(
                        Icons.favorite_rounded,
                        color: Colors.pink,
                      ))
                  : IconButton(
                      onPressed: () {
                        List food = [];
                        food.add(widget.wisata.name);
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(loggedInUser!.id)
                            .update({
                          "favouriteWisata": FieldValue.arrayUnion(food)
                        });
                        setState(() {
                          FirebaseFirestore.instance
                              .collection("users")
                              .doc(user!.uid)
                              .get()
                              .then((value) {
                            loggedInUser = Users.fromMap(value.data());
                            setState(() {});
                          });
                        });
                      },
                      icon: Icon(Icons.favorite_outline_rounded)),
            ],
          ),
        ),
        SizedBox(height: 4),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child:
              Text(widget.wisata.location!, style: GlobalStyle.restaurantTag),
        ),
        SizedBox(height: 8),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text('Rating', style: GlobalStyle.textRatingDistances),
              Icon(Icons.star, color: Colors.orange, size: 15),
              SizedBox(width: 2),
              Text(widget.wisata.rating!,
                  style: GlobalStyle.textRatingDistances),
            ],
          ),
        ),
        _reusableWidget.divider2(),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            widget.wisata.description!,
            textAlign: TextAlign.justify,
            maxLines: readMore ? 20 : 3,
            overflow: readMore ? TextOverflow.visible : TextOverflow.ellipsis,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: TextButton(
              onPressed: () {
                setState(() {
                  readMore = !readMore;
                });
              },
              child: Text(
                readMore ? 'read less' : 'read more',
                style: const TextStyle(color: Colors.orange),
              )),
        ),
      ],
    );
  }
}
