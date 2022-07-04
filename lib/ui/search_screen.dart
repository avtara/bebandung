import 'dart:async';

import 'package:bebandung/config/global_style.dart';
import 'package:bebandung/model/food_model.dart';
import 'package:bebandung/model/wisata_model.dart';
import 'package:bebandung/ui/detail_food.dart';
import 'package:bebandung/ui/detail_wisata.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchAddressPage extends StatefulWidget {
  const SearchAddressPage({Key? key}) : super(key: key);

  @override
  _SearchAddressPageState createState() => _SearchAddressPageState();
}

class _SearchAddressPageState extends State<SearchAddressPage> {
  Timer? _timerDummy;

  TextEditingController foodsController = TextEditingController();
  TextEditingController wisataController = TextEditingController();

  Timer? _debounce;

  List _searchFoods = [];
  List<FoodModel> foods = [];
  List _searchWisata = [];
  List<WisataModel> wisata = [];

  @override
  void initState() {
    super.initState();
    _getDataFood();
    getDataWisata();
  }

  @override
  void dispose() {
    _timerDummy?.cancel();

    foodsController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  QuerySnapshot? _tempData;
  QuerySnapshot? _tempData2;

  void _getDataFood() async {
    _tempData = await FirebaseFirestore.instance.collection('foods').get();
    for (int i = 0; i < _tempData!.docs.length; i++) {
      foods.add(FoodModel.fromMap(_tempData!.docs[i]));
    }
    setState(() {});
  }

  void searchFoods(String query) {
    final suggestions = foods.where((element) {
      final foodName = element.name!.toLowerCase();
      final input = query.toLowerCase();

      return foodName.contains(input);
    }).toList();

    setState(() => _searchFoods = suggestions);
  }

  void getDataWisata() async {
    _tempData2 = await FirebaseFirestore.instance.collection('wisata').get();
    for (int i = 0; i < _tempData2!.docs.length; i++) {
      wisata.add(WisataModel.fromMap(_tempData2!.docs[i]));
    }
    setState(() {});
  }

  void searchWisata(String query) {
    final suggestions = wisata.where((element) {
      final wisataName = element.name!.toLowerCase();
      final input = query.toLowerCase();

      return wisataName.contains(input);
    }).toList();

    setState(() => _searchWisata = suggestions);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: GlobalStyle.appBarIconThemeColor,
          ),
          systemOverlayStyle: GlobalStyle.appBarSystemOverlayStyle,
          centerTitle: true,
          titleSpacing: 0.0,
          backgroundColor: GlobalStyle.appBarBackgroundColor,
          elevation: 0,
          // create search text field in the app bar
          title: const Text(
            'Search',
            style: TextStyle(color: Colors.black),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2.4,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 16),
                    height: kToolbarHeight - 16,
                    child: TextField(
                      controller: foodsController,
                      autofocus: true,
                      textInputAction: TextInputAction.search,
                      onChanged: searchFoods,
                      maxLines: 1,
                      style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search,
                            color: Colors.grey[500], size: 18),
                        suffixIcon: (foodsController.text == '')
                            ? null
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    foodsController =
                                        TextEditingController(text: '');
                                  });
                                },
                                child: Icon(Icons.close,
                                    color: Colors.grey[500], size: 18)),
                        contentPadding: EdgeInsets.all(0),
                        isDense: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: 'Enter Food Name',
                        hintStyle:
                            TextStyle(fontSize: 13, color: Colors.grey[500]),
                      ),
                    ),
                  ),
                  _searchFoods.isEmpty
                      ? Container(
                          height: MediaQuery.of(context).size.height / 3,
                          child: Center(
                            child: Text('No Data'),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                              itemCount: _searchFoods.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: Container(
                                    width: 50,
                                    height: 50,
                                    child: ClipPath(
                                      child: ClipRRect(
                                        child: CachedNetworkImage(
                                          imageUrl: _searchFoods[index].image!,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              const CircularProgressIndicator(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  title: Text(_searchFoods[index].name!),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DetailFoodPage(
                                                  food: _searchFoods[index],
                                                )));
                                  },
                                );
                              }),
                        ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2.4,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 16),
                    height: kToolbarHeight - 16,
                    child: TextField(
                      controller: wisataController,
                      autofocus: true,
                      textInputAction: TextInputAction.search,
                      onChanged: searchWisata,
                      maxLines: 1,
                      style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search,
                            color: Colors.grey[500], size: 18),
                        suffixIcon: (wisataController.text == '')
                            ? null
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    wisataController =
                                        TextEditingController(text: '');
                                  });
                                },
                                child: Icon(Icons.close,
                                    color: Colors.grey[500], size: 18)),
                        contentPadding: EdgeInsets.all(0),
                        isDense: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: 'Enter Wisata Name',
                        hintStyle:
                            TextStyle(fontSize: 13, color: Colors.grey[500]),
                      ),
                    ),
                  ),
                  _searchWisata.isEmpty
                      ? Container(
                          height: MediaQuery.of(context).size.height / 3,
                          child: Center(
                            child: Text('No Data'),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                              itemCount: _searchWisata.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: Container(
                                    width: 50,
                                    height: 50,
                                    child: ClipPath(
                                      child: ClipRRect(
                                        child: CachedNetworkImage(
                                          imageUrl: _searchWisata[index].image!,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              const CircularProgressIndicator(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  title: Text(_searchWisata[index].name!),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DetailRestaurantPage(
                                                  wisata: _searchWisata[index],
                                                )));
                                  },
                                );
                              }),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
