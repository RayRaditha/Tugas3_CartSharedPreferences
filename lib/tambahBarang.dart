import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shoppingcart/tampungKeranjang.dart';
import 'tampungKeranjang.dart';
import 'boxes.dart';

class TambahBarang extends StatefulWidget {
  const TambahBarang({Key? key}) : super(key: key);

  @override
  State<TambahBarang> createState() => TambahBarangState();
}

class TambahBarangState extends State<TambahBarang> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  validated() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _onFormSubmit();
      print('Form validated');
    } else {
      print('Form not validated');
      return;
    }
  }

  late List<List<String>> items = [];
  late String title;
  late String description;

  bool? barangPertama = false;
  bool? barangKedua = false;
  bool? barangKetiga = false;

  String title1 = "Minyak Goreng";
  String title2 = "Nugget";
  String title3 = "Beras";

  String desc1 = "Minyak Bimoli 1L termurah dengan harga Rp. 50.000";
  String desc2 = "Nugget Fiesta lezat dan bergizi dengan harga Rp. 25.000";
  String desc3 = "Beras pulen banget dengan harga Rp. 30.000";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Barang'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CheckboxListTile(
                  title: Text(title1),
                  subtitle: Text(desc1),
                  value: barangPertama,
                  onChanged: (bool? value) {
                    setState(() {
                      barangPertama = value;
                    });
                  },
                  secondary: Icon(Icons.emoji_food_beverage)
                ),
                CheckboxListTile(
                    title: Text(title2),
                    subtitle: Text(desc2),
                    value: barangKedua,
                    onChanged: (bool? value) {
                      setState(() {
                        barangKedua = value;
                      });
                    },
                    secondary: Icon(Icons.emoji_food_beverage)
                ),
                CheckboxListTile(
                    title: Text(title3),
                    subtitle: Text(desc3),
                    value: barangKetiga,
                    onChanged: (bool? value) {
                      setState(() {
                        barangKetiga = value;
                      });
                    },
                    secondary: Icon(Icons.emoji_food_beverage)
                ),
                ElevatedButton(
                    onPressed: () {
                      validated();
                    },
                    child: Text('Tambahkan'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onFormSubmit() {
    Box<Item> listbox = Hive.box<Item>(HiveBoxes.cart);
    if (barangPertama == true) {
      items.add([title1, desc1]);
      barangPertama = false;
    }
    if (barangKedua == true) {
      items.add([title2, desc2]);
      barangKedua = false;
    }
    if (barangKetiga == true) {
      items.add([title2, desc2]);
      barangKetiga = false;
    }
    items.forEach((item) {
      listbox.add(Item(title: item[0], description: item[1]));
    });
    SnackBar snackBar = SnackBar(content: Text("Tambah ke Keranjang"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    print(listbox);
  }
}