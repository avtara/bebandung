import 'dart:async';

import 'package:bebandung/config/global_style.dart';
import 'package:bebandung/model/user_model.dart';
import 'package:bebandung/model/wisata_model.dart';
import 'package:bebandung/ui/detail_food.dart';
import 'package:bebandung/ui/detail_wisata.dart';
import 'package:bebandung/model/food_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoritesFoodListPage extends StatefulWidget {
  const FavoritesFoodListPage({
    Key? key,
  }) : super(key: key);

  @override
  _FavoritesFoodListPageState createState() => _FavoritesFoodListPageState();
}

class _FavoritesFoodListPageState extends State<FavoritesFoodListPage> {
  Timer? _timerDummy;

  List<FoodModel> _foodData = [];
  List<WisataModel> _wisataData = [];

  final user = FirebaseAuth.instance.currentUser;
  Users? loggedInUser;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = Users.fromMap(value.data());
      food = loggedInUser!.favouriteFoods!;
      wisatas = loggedInUser!.favouriteWisata!;
      favouriteFoods();
      favouriteWisata();
      setState(() {});
    });
    getDataFood();
    getDataWisata();
    setState(() {});
  }

  @override
  void dispose() {
    _timerDummy?.cancel();
    super.dispose();
  }

  List<FoodModel> _favouriteFoods = [];
  List<FoodModel> foods = [];
  List<WisataModel> _favouriteWisata = [];
  List<WisataModel> wisata = [];

  List food = [];
  List wisatas = [];

  QuerySnapshot? _tempData;
  QuerySnapshot? _tempData2;

  void getDataFood() async {
    _tempData = await FirebaseFirestore.instance.collection('foods').get();
    for (int i = 0; i < _tempData!.docs.length; i++) {
      foods.add(FoodModel.fromMap(_tempData!.docs[i]));
    }
    setState(() {});
  }

  void favouriteFoods() {
    for (int i = 0; i < food.length; i++) {
      final suggestions = foods.where((element) {
        final foodName = element.name;
        final input = food[i];

        return foodName!.contains(input);
      }).toList();
      setState(() => _favouriteFoods.add(suggestions.first));
    }
  }

  void getDataWisata() async {
    _tempData2 = await FirebaseFirestore.instance.collection('wisata').get();
    for (int i = 0; i < _tempData2!.docs.length; i++) {
      wisata.add(WisataModel.fromMap(_tempData2!.docs[i]));
    }
    setState(() {});
  }

  void favouriteWisata() {
    for (int i = 0; i < wisatas.length; i++) {
      final suggestions = wisata.where((element) {
        final wisataName = element.name;
        final input = wisatas[i];

        return wisataName!.contains(input);
      }).toList();
      setState(() => _favouriteWisata.add(suggestions.first));
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: GlobalStyle.appBarIconThemeColor,
          ),
          systemOverlayStyle: GlobalStyle.appBarSystemOverlayStyle,
          centerTitle: true,
          title: Text('Favorites', style: GlobalStyle.appBarTitle),
          backgroundColor: GlobalStyle.appBarBackgroundColor,
          bottom: const TabBar(
            labelColor: Colors.black,
            tabs: [
              Tab(
                text: 'Foods',
              ),
              Tab(
                text: 'Wisata',
              )
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {
                  _favouriteFoods.clear();
                  _favouriteWisata.clear();
                  FirebaseFirestore.instance
                      .collection("users")
                      .doc(user!.uid)
                      .get()
                      .then((value) {
                    loggedInUser = Users.fromMap(value.data());
                    food = loggedInUser!.favouriteFoods!;
                    wisatas = loggedInUser!.favouriteWisata!;
                    favouriteFoods();
                    favouriteWisata();
                    setState(() {});
                  });
                  getDataFood();
                  getDataWisata();
                  setState(() {});
                },
                icon: Icon(Icons.refresh_rounded))
          ],
        ),
        body: TabBarView(children: [
          _listFavouriteFood(_favouriteFoods),
          _listFavouriteWisata(_favouriteWisata),
        ]),
      ),
    );
  }

  Widget _listFavouriteFood(List<FoodModel> datas) {
    return datas.isEmpty
        ? Center(
            child: Text('No Favourites Available'),
          )
        : Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      final data = datas[index];
                      return ListTile(
                        leading: Container(
                          width: 50,
                          height: 50,
                          child: ClipPath(
                            child: ClipRRect(
                              child: CachedNetworkImage(
                                imageUrl: data.image!,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          data.name!,
                          style: const TextStyle(color: Colors.black),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: ElevatedButton(
                            onPressed: () {
                              List food = [];
                              food.add(data.name);
                              _favouriteFoods.remove(data);
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(loggedInUser!.id)
                                  .update({
                                "favouriteFoods": FieldValue.arrayRemove(food)
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
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.orange)),
                            child: const Text(
                              'Remove',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 16),
                            )),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailFoodPage(
                                        food: data,
                                      )));
                        },
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: datas.length),
              ),
            ],
          );
  }

  Widget _listFavouriteWisata(List<WisataModel> datas) {
    return datas.isEmpty
        ? Center(
            child: Text('No Favourites Available'),
          )
        : Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      final data = datas[index];
                      return ListTile(
                        leading: Container(
                          width: 50,
                          height: 50,
                          child: ClipPath(
                            child: ClipRRect(
                              child: CachedNetworkImage(
                                imageUrl: data.image!,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          data.name!,
                          style: const TextStyle(color: Colors.black),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: ElevatedButton(
                            onPressed: () {
                              List food = [];
                              _favouriteWisata.remove(data);
                              food.add(data.name);
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
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.orange)),
                            child: const Text(
                              'Remove',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 16),
                            )),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailRestaurantPage(
                                        wisata: data,
                                      )));
                        },
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: datas.length),
              ),
            ],
          );
  }
}
