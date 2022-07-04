import 'package:fluttertoast/fluttertoast.dart';
import 'package:bebandung/config/constant.dart';
import 'package:bebandung/config/global_style.dart';
import 'package:bebandung/ui/detail_food.dart';
import 'package:bebandung/ui/detail_wisata.dart';
import 'package:bebandung/ui/reusable/cache_image_network.dart';
import 'package:flutter/material.dart';

class ReusableWidget {
  PreferredSizeWidget bottomAppBar() {
    return PreferredSize(
        child: Container(
          color: Colors.grey[100],
          height: 1.0,
        ),
        preferredSize: Size.fromHeight(1.0));
  }

  Widget buildHorizontalListCard(context, data, name, user) {
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
            if (name == 'food') {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailFoodPage(
                            food: data,
                          )));
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailRestaurantPage(
                            wisata: data,
                          )));
            }
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
                      child: name != "food"
                          ? Text(data.name + ' - ' + data.location,
                              style: GlobalStyle.cardTitle,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis)
                          : Text(data.name,
                              style: GlobalStyle.cardTitle,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget divider1() {
    return Container(
      height: 8,
      color: Colors.grey[100],
    );
  }

  Widget divider2() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Divider(
        height: 32,
        color: Colors.grey[400],
      ),
    );
  }

  Widget divider3() {
    return Divider(
      height: 32,
      color: Colors.grey[400],
    );
  }
}
