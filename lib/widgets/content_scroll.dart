import 'dart:async';
import 'package:avmv005/Pages/AvmScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// yorum satırı denemesi

// ignore: must_be_immutable
class ContentScroll extends StatelessWidget {
  String a;
  Future getPosts() async {
    var firestore = Firestore.instance;
    //Anasayfa_Avmler Koleksiyonunu çek
    QuerySnapshot qs =
        await firestore.collection("Anasayfa_Avmler").getDocuments();

    return qs.documents;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
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
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AvmScreen(
                            avmName: snapshot.data[index].data["avm_name"],
                            imageUrl: snapshot.data[index].data["image"],
                            stars: snapshot.data[index].data["stars"],
                            carPark: snapshot.data[index].data["otopark"],
                            cafe: snapshot.data[index].data["cafe"],
                            food: snapshot.data[index].data["yemek"],
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
    );
  }
}

/*
GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(
                      builder: (_) => MovieScreen(movie: snapshot.data[index].data["image"].toString()),
                      ),
                      ),
*/
