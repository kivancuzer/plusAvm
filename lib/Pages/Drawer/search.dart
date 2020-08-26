import 'package:avmv005/Pages/AvmScreen.dart';
import 'package:avmv005/custom_navigation_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:avmv005/commons/collapsing_navigation_drawer_widget.dart';

class SearchListExample extends StatefulWidget {
  @override
  _SearchListExampleState createState() => new _SearchListExampleState();
}

class _SearchListExampleState extends State<SearchListExample> {
  Widget appBarTitle = new Text(
    "", //Search Sample
    style: new TextStyle(color: Colors.white),
  );
  Icon icon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  final globalKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _controller = new TextEditingController();
  List<dynamic> _listAvmName;
  List<dynamic> _listImage;
  List<dynamic> _listStars;
  List<dynamic> _listYemek;
  List<dynamic> _listOtopark;
  List<dynamic> _listCafe;

  bool _isSearching;
  List searchresultAvmName = new List();
  List searchresultImage = new List();
  List searchresultStars = new List();
  List searchresultYemek = new List();
  List searchresultOtopark = new List();
  List searchresultCafe = new List();

  _SearchListExampleState() {
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          _isSearching = false;
        });
      } else {
        setState(() {
          _isSearching = true;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _isSearching = false;
    values();
  }

  void values() {
    _listAvmName = List();
    _listImage = List();
    _listStars = List();
    _listYemek = List();
    _listOtopark = List();
    _listCafe = List();

    var firestore = Firestore.instance;
    //Anasayfa_Avmler Koleksiyonunu çek
    firestore
        .collection("Anasayfa_Avmler")
        .getDocuments()
        .then((querySnapshot) {
      querySnapshot.documents.forEach((result) {
        _listAvmName.add(result.data["avm_name"]);
        _listImage.add(result.data["image"]);
        _listStars.add(result.data["stars"]);
        _listYemek.add(result.data["yemek"]);
        _listOtopark.add(result.data["otopark"]);
        _listCafe.add(result.data["cafe"]);
      });
    });
  }

  Future getPosts() async {
    var firestore = Firestore.instance;
    //Anasayfa_Avmler Koleksiyonunu çek
    QuerySnapshot qs =
        await firestore.collection("Anasayfa_Avmler").getDocuments();

    return qs.documents;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: globalKey,
        appBar: buildAppBarSearch(context),
        drawer: CollapsingNavigationDrawer(),
        body: new Container(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "Avmler",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.black),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              new Flexible(
                child: searchresultAvmName.length != 0 ||
                        _controller.text.isNotEmpty
                    ? Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: new ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 30.0),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: searchresultAvmName.length,
                          itemBuilder: (BuildContext context, int index) {
                            String listDataAvmName = searchresultAvmName[index];
                            String listDataImage = searchresultImage[index];
                            String listDataStars = searchresultStars[index];
                            bool listDataCafe = searchresultCafe[index];
                            bool listDataOtopark = searchresultOtopark[index];
                            bool listDataYemek = searchresultYemek[index];
                            return Container(
                              child: new GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => AvmScreen(
                                      imageUrl:
                                          searchresultImage[index].toString(),
                                      avmName:
                                          searchresultAvmName[index].toString(),
                                      carPark: listDataOtopark,
                                      cafe: listDataCafe,
                                      stars: listDataStars.toString(),
                                      food: listDataYemek,
                                    ),
                                  ),
                                ),
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                    vertical: 10.0,
                                  ),
                                  width: 180,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black54,
                                        offset: Offset(0.0, 0.4),
                                        blurRadius: 6.0,
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image(
                                      image: NetworkImage(
                                        listDataImage,
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : new Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: FutureBuilder(
                          future: getPosts(),
                          builder: (_, AsyncSnapshot snapshot) {
                            //Veriler Yülenirke
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: Text("Loading..."),
                              );
                            } //Veriler Yüklendikten sonra
                            else {
                              return ListView.builder(
                                padding: EdgeInsets.symmetric(horizontal: 30.0),
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data.length,
                                itemBuilder: (_, index) {
                                  //Seçilen Containerı(Avmyi) AvmScreende göster
                                  return GestureDetector(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => AvmScreen(
                                          imageUrl: snapshot
                                              .data[index].data["image"]
                                              .toString(),
                                          avmName: snapshot
                                              .data[index].data["avm_name"]
                                              .toString(),
                                          carPark: snapshot
                                              .data[index].data["carPark"],
                                          cafe:
                                              snapshot.data[index].data["info"],
                                          stars: snapshot
                                              .data[index].data["stars"],
                                          food: snapshot
                                              .data[index].data["title"],
                                        ),
                                      ),
                                    ),
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                        vertical: 10.0,
                                      ),
                                      width: 180,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black54,
                                            offset: Offset(0.0, 0.4),
                                            blurRadius: 6.0,
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: Image(
                                          image: NetworkImage(
                                            snapshot.data[index].data['image'],
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
              )
            ],
          ),
        ));
  }

  Widget buildAppBarSearch(BuildContext context) {
    return new AppBar(
        backgroundColor: selectedColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        )),
        centerTitle: true,
        title: appBarTitle,
        actions: <Widget>[
          new IconButton(
            icon: icon,
            onPressed: () {
              setState(() {
                if (this.icon.icon == Icons.search) {
                  this.icon = new Icon(
                    Icons.close,
                    color: Colors.white,
                  );
                  this.appBarTitle = new TextField(
                    controller: _controller,
                    style: new TextStyle(
                      color: Colors.white,
                    ),
                    decoration: new InputDecoration(
                        prefixIcon: new Icon(Icons.search, color: Colors.white),
                        hintText: "Search...",
                        hintStyle: new TextStyle(color: Colors.white)),
                    onChanged: searchOperation,
                  );
                  _handleSearchStart();
                } else {
                  _handleSearchEnd();
                }
              });
            },
          ),
        ]);
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.icon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = new Text(
        "Search Sample",
        style: new TextStyle(color: Colors.white),
      );
      _isSearching = false;
      _controller.clear();
    });
  }

  void searchOperation(String searchText) {
    searchresultAvmName.clear();
    searchresultImage.clear();
    searchresultStars.clear();
    searchresultYemek.clear();
    searchresultOtopark.clear();
    searchresultCafe.clear();

    if (_isSearching != null) {
      for (int i = 0; i < _listAvmName.length; i++) {
        String dataAvmName = _listAvmName[i];
        String dataImage = _listImage[i];
        String dataStars = _listStars[i];
        bool dataYemek = _listYemek[i];
        bool dataOtopark = _listOtopark[i];
        bool dataCafe = _listCafe[i];
        if (dataAvmName.toLowerCase().contains(searchText.toLowerCase())) {
          searchresultAvmName.add(dataAvmName);
          searchresultImage.add(dataImage);
          searchresultStars.add(dataStars);
          searchresultYemek.add(dataYemek);
          searchresultOtopark.add(dataOtopark);
          searchresultCafe.add(dataCafe);

          print(searchresultAvmName.toString());
          print(searchresultImage.toString());
          print(searchresultStars.toString());
          print(searchresultYemek.toString());
          print(searchresultOtopark.toString());
          print(searchresultCafe.toString());
        }
      }
    }
  }
}
