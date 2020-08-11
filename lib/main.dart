import 'package:avmv005/Pages/NavigationBar/events_page.dart';
import 'package:avmv005/Pages/NavigationBar/trends_page.dart';
import 'package:avmv005/View_Model/user_model.dart';
import 'package:avmv005/locator.dart';
import 'package:avmv005/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Pages/NavigationBar/bilboard_page.dart';
import 'Pages/NavigationBar/discounts_page.dart';
import 'Pages/NavigationBar/gallery_page.dart';

void main() {
  setupLocator();
  runApp(
    MaterialApp(initialRoute: "/", routes: {
      "/": (context) => ScaffoldOgesi(),
    }),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserModel(),
      child: MaterialApp(
        title: 'Avm+',
        theme: ThemeData(
          primaryColor: Colors.amber,
          primarySwatch: Colors.amber,
          accentColor: Colors.amber,
        ),
        home: ScaffoldOgesi(),
      ),
    );
  }
}

class DrawerCodeOnly extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
        child: Drawer(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          UserAccountsDrawerHeader(accountName: Text("omercansucu"),
          accountEmail: Text("omercansucu@gmail.com"),
          currentAccountPicture: Image.network("https://emrealtunbilek.com/wp-content/uploads/2016/10/apple-icon-72x72.png"),
          ),
          Expanded(child: ListView(children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, "/");
            },
            splashColor: Color.fromRGBO(80, 77, 229, 100),
            child: ListTile(
              leading: Icon(Icons.home),
              title: Text("Ana Sayfa"),
              trailing: Icon(Icons.chevron_right),
            ),
          ),
          InkWell(
            onTap: () {
               Navigator.push(
                          context,
                          new MaterialPageRoute(
                          builder: (context) => new DiscountsScreen()));
            },
            splashColor: Color.fromRGBO(80, 77, 229, 100),
            child: ListTile(
              leading: Icon(Icons.trending_down),
              title: Text("İndirimler"),
              trailing: Icon(Icons.chevron_right),
            ),
          ),
            InkWell(
            onTap: () {
               Navigator.push(
                          context,
                          new MaterialPageRoute(
                          builder: (context) => new EventsScreen()));
            },
            splashColor: Color.fromRGBO(80, 77, 229, 100),
            child: ListTile(
              leading: Icon(Icons.event),
              title: Text("Etkinlikler"),
              trailing: Icon(Icons.chevron_right),
            ),
          ),
          InkWell(
            onTap: () {
               Navigator.push(
                          context,
                          new MaterialPageRoute(
                          builder: (context) => new TrendsScreen()));
            },
            splashColor: Color.fromRGBO(80, 77, 229, 100),
            child: ListTile(
              leading: Icon(Icons.trending_up),
              title: Text("Trendler"),
              trailing: Icon(Icons.chevron_right),
            ),
          ),

          InkWell(
            onTap: () {
               Navigator.push(
                          context,
                          new MaterialPageRoute(
                          builder: (context) => new GalleryScreen()));
            },
            splashColor: Color.fromRGBO(80, 77, 229, 100),
            child: ListTile(
              leading: Icon(Icons.photo),
              title: Text("Galeri"),
              trailing: Icon(Icons.chevron_right),
            ),
          ),
          InkWell(
            onTap: () {
               Navigator.push(
                          context,
                          new MaterialPageRoute(
                          builder: (context) => new BilboardScreen()));
            },
            splashColor: Color.fromRGBO(80, 77, 229, 100),
            child: ListTile(
              leading: Icon(Icons.dvr),
              title: Text("Bilboard"),
              trailing: Icon(Icons.chevron_right),
            ),
          ),
          ],
          ),
          )
        ],
      ),
    ));
  }
}

Widget buildAppBar() {
  return new AppBar(
    backgroundColor: Color.fromRGBO(80, 77, 229, 100),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
      bottom: Radius.circular(30),
    )),
    title: Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(73, 70, 218, 100),
        borderRadius: BorderRadius.circular(5),
      ),
    ),
  );
}
