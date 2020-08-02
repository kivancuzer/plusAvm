import 'package:avmv005/widgets/discounts_special_see_all_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class DiscountsSpecialSeeAll extends StatefulWidget {
  @override
  _DiscountsSpecialSeeAllState createState() => _DiscountsSpecialSeeAllState();
}

class _DiscountsSpecialSeeAllState extends State<DiscountsSpecialSeeAll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text("Avm+_Special_Discounts"),
        ),
        drawer: DrawerCodeOnly(),
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              //Avm+ Special Discounts See All Widget
              DiscountsSpecialSeeAllWidget(),
            ],
          ),
        ));
  }
}
