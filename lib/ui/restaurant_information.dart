import 'dart:async';

import 'package:bebandung/config/constant.dart';
import 'package:bebandung/config/global_style.dart';
import 'package:bebandung/ui/reusable_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RestaurantInformationPage extends StatefulWidget {
  @override
  _RestaurantInformationPageState createState() =>
      _RestaurantInformationPageState();
}

class _RestaurantInformationPageState extends State<RestaurantInformationPage> {
  // initialize reusable widget
  final _reusableWidget = ReusableWidget();

  @override
  void initState() {
    super.initState();
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
        title: Text('Restaurant Information', style: GlobalStyle.appBarTitle),
        backgroundColor: GlobalStyle.appBarBackgroundColor,
        bottom: _reusableWidget.bottomAppBar(),
      ),
      body: ListView(
        children: [
          (!kIsWeb)
              ? Container(
                  height: MediaQuery.of(context).size.width / 2,
                  child: Stack(
                    children: [],
                  ),
                )
              : SizedBox.shrink(),
          _buildMerchantTop(),
          _reusableWidget.divider2(),
          _buildAddressDetail(),
          SizedBox(height: 16),
          _buildOpeningHours()
        ],
      ),
    );
  }

  Widget _buildMerchantTop() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Text('Preferred Merchants', style: GlobalStyle.preferredMerchant),
          SizedBox(height: 8),
          Text('Steam Boat Lovers - Lefferts Avenue',
              style: GlobalStyle.restaurantTitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
          SizedBox(height: 4),
          Text('Hot, Fresh, Steam', style: GlobalStyle.restaurantTag),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.star, color: Colors.orange, size: 15),
              SizedBox(width: 2),
              Text('4.9', style: GlobalStyle.textRatingDistances),
              SizedBox(width: 6),
              Icon(Icons.location_pin, color: ASSENT_COLOR, size: 15),
              SizedBox(width: 2),
              Text('0.7 miles', style: GlobalStyle.textRatingDistances),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddressDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('Address Detail', style: GlobalStyle.addressDetailTitle),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam eu risus nec arcu cursus accumsan in id felis. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
              style: GlobalStyle.addressDetailValue),
        )
      ],
    );
  }

  Widget _buildOpeningHours() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('Opening Hours', style: GlobalStyle.oph),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Sunday', style: GlobalStyle.ophDay),
                  Text('07:00 - 20:00', style: GlobalStyle.ophValue),
                ],
              ),
              SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Monday', style: GlobalStyle.ophDay),
                  Text('Closed', style: GlobalStyle.ophValue),
                ],
              ),
              SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Tuesday', style: GlobalStyle.ophDay),
                  Text('07:00 - 20:00', style: GlobalStyle.ophValue),
                ],
              ),
              SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Wednesday', style: GlobalStyle.ophDay),
                  Text('07:00 - 20:00', style: GlobalStyle.ophValue),
                ],
              ),
              SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Thursday', style: GlobalStyle.ophDay),
                  Text('07:00 - 20:00', style: GlobalStyle.ophValue),
                ],
              ),
              SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Friday', style: GlobalStyle.ophDay),
                  Text('07:00 - 20:00', style: GlobalStyle.ophValue),
                ],
              ),
              SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Saturday', style: GlobalStyle.ophDay),
                  Text('07:00 - 20:00', style: GlobalStyle.ophValue),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
