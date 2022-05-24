import 'dart:async';

import 'package:bebandung/config/constant.dart';
import 'package:bebandung/config/global_style.dart';
import 'package:bebandung/ui/reusable_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddAddressPage extends StatefulWidget {
  final bool fromList;

  const AddAddressPage({Key? key, this.fromList = false}) : super(key: key);

  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
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
        title: Text('Add New Address', style: GlobalStyle.appBarTitle),
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
          Container(
            margin: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Place Name'),
                SizedBox(height: 4),
                TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: SOFT_GREY, width: 0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: SOFT_GREY, width: 0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    hintText: 'e.g. Home Address, Office Address',
                    hintStyle: TextStyle(color: SOFT_GREY, fontSize: 14),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12.0),
                  ),
                ),
                SizedBox(height: 16),
                Text('Address'),
                SizedBox(height: 4),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0, color: SOFT_GREY),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.all(16),
                          child:
                              Icon(Icons.place, color: ASSENT_COLOR, size: 20)),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Hilltop Playground',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                            SizedBox(height: 2),
                            Text(
                                'Hopkinson Avenue &, Pacific St, Brooklyn, NY 11233, United States',
                                style:
                                    TextStyle(color: SOFT_GREY, fontSize: 13),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Text('Address Detail'),
                SizedBox(height: 4),
                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: SOFT_GREY, width: 0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: SOFT_GREY, width: 0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    hintText: 'e.g. Floor, unit number',
                    hintStyle: TextStyle(color: SOFT_GREY, fontSize: 14),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12.0),
                  ),
                ),
                SizedBox(height: 16),
                Text('Note to driver'),
                SizedBox(height: 4),
                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: SOFT_GREY, width: 0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: SOFT_GREY, width: 0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    hintText: 'e.g. Meet me at the car park',
                    hintStyle: TextStyle(color: SOFT_GREY, fontSize: 14),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12.0),
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) => PRIMARY_COLOR,
                        ),
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.0),
                        )),
                      ),
                      onPressed: () {
                        Fluttertoast.showToast(
                            msg: 'Save Address Success',
                            toastLength: Toast.LENGTH_SHORT);
                        Navigator.pop(context);
                        if (!widget.fromList) {
                          Navigator.pop(context);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(
                          'Save Address',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
