import 'dart:async';

import 'package:bebandung/config/global_style.dart';
import 'package:bebandung/model/user_model.dart';
import 'package:bebandung/ui/detail_food.dart';
import 'package:bebandung/ui/reusable_widget.dart';
import 'package:bebandung/model/food_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FoodListPage extends StatefulWidget {
  final String title;
  final Users user;
  const FoodListPage({Key? key, this.title = 'Kuliner', required this.user})
      : super(key: key);

  @override
  _FoodListPageState createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPage> {
  final _reusableWidget = ReusableWidget();

  Timer? _timerDummy;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timerDummy?.cancel();
    super.dispose();
  }

  Stream<List<FoodModel>> readFoods() => FirebaseFirestore.instance
      .collection("foods")
      .snapshots()
      .map((snapshots) =>
          snapshots.docs.map((doc) => FoodModel.fromMap(doc.data())).toList());

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
        title: Text(widget.title, style: GlobalStyle.appBarTitle),
        backgroundColor: GlobalStyle.appBarBackgroundColor,
        bottom: _reusableWidget.bottomAppBar(),
      ),
      body: StreamBuilder<List<FoodModel>>(
          stream: readFoods(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final food = snapshot.data!;
              return _listFood(food);
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
    );
  }

  Widget _listFood(List<FoodModel> datas) {
    return datas.isEmpty
        ? Center(
            child: Text('No Foods Available'),
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
                        subtitle: Text(
                          data.description!,
                          style: const TextStyle(color: Colors.grey),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                        ),
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
}
