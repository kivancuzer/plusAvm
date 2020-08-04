import 'package:avmv005/Model/favorites.dart';
import 'package:avmv005/Pages/FullScreen.dart';
import 'package:avmv005/Utils/database_helper.dart';
import "package:flutter/material.dart";

class ProfileWidget extends StatefulWidget {
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  DatabaseHelper _databaseHelper;
  List<Favorites> allFavoritesList;

  int clickedFavoritesIndex;
  int clickedFavoritesID;

  @override
  void initState() {
    super.initState();

    allFavoritesList = List<Favorites>();
    _databaseHelper = DatabaseHelper();

    _databaseHelper.allFavorites().then((allFavoritesMapList) {
      for (Map readFavoritesMap in allFavoritesMapList) {
        allFavoritesList.add(Favorites.fromMap(readFavoritesMap));
      }
      setState(() {});
    }).catchError((hata) => print("hata:" + hata));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 500,
          width: 300,
          child: GridView.builder(
            primary: false,
            itemCount: allFavoritesList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemBuilder: (_, index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FullScreen(
                      imageUrl: allFavoritesList[index].imageUrl.toString(),
                      avmName: allFavoritesList[index].avmName.toString(),
                      brandName: allFavoritesList[index].brandName.toString(),
                      info: allFavoritesList[index].info.toString(),
                      stars: allFavoritesList[index].stars.toString(),
                      title: allFavoritesList[index].title.toString(),
                    ),
                  ),
                ),
                child: Container(
                    width: 100,
                    height: 150,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                  allFavoritesList[index].imageUrl,
                                )),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black87,
                              )
                            ],
                          ),
                        )
                      ],
                    )),
              );
            },
          ),
        ),
      ],
    );
  }
}