import 'package:avmv005/commons/collapsing_navigation_drawer_widget.dart';
import 'package:avmv005/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";

class CinemaPage extends StatefulWidget {
  @override
  _CinemaPageState createState() => _CinemaPageState();
}

class _CinemaPageState extends State<CinemaPage> {
  String avm = "Kipa";

  Future getPosts() async {
    var firestore = Firestore.instance;
    //Anasayfa_Avmler Koleksiyonunu çek
    QuerySnapshot qs = await firestore
        .collection("Cinema")
        .orderBy("avm_name", descending: false)
        .getDocuments();
    return qs.documents;
  }

  @override
  Widget build(BuildContext context) {
    print(avm);

    Future getMovies(String avmName) async {
      var firestore = Firestore.instance;
      //Anasayfa_Avmler Koleksiyonunu çek
      QuerySnapshot qs = await firestore
          .collection("Cinema")
          .document(avmName)
          .collection("Movies")
          .getDocuments();
      print(qs.documents.toString());

      return qs.documents;
    }

    void changeAvmName(String avmName) {
      avm = avmName;
      setState(() {
        avm = avmName;
      });
      getMovies(avm);
      print(avmName);
    }

    return Scaffold(
      appBar: buildAppBar(),
      drawer: CollapsingNavigationDrawer(),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              height: 100,
              width: double.infinity,
              child: FutureBuilder(
                future: getPosts(),
                builder: (_, AsyncSnapshot snapshot) {
                  //Veriler Yülenirke
                  if (snapshot.connectionState == ConnectionState.waiting) {
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
                        return Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 5.0,
                            vertical: 15.0,
                          ),
                          width: 100,
                          child: FlatButton(
                            onPressed: () => changeAvmName(snapshot
                                .data[index].data['avm_name']
                                .toString()),
                            child: Text(
                              snapshot.data[index].data['avm_name'].toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  color: Color(0xFFC9CBCE)),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder(
                future: getMovies(avm),
                builder: (_, AsyncSnapshot snapshot) {
                  //Veriler Yülenirke
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Text(avm),
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
                          onTap: () => {},
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
          ],
        ),
      ),
    );
  }
}
