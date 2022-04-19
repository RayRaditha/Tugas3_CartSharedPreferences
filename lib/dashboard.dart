import 'package:flutter/material.dart';
import 'listBelanja.dart';
import 'settingsPage.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  int index = 0;
  List<Widget> listItem = [
    ListBarang(title: "List Barang Belanja"),
    Settings()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listItem[index],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Keranjang'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: index,
        selectedItemColor: Colors.deepOrange,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
      ),
    );
  }
}
