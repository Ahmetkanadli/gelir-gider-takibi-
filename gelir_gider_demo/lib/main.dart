import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'ana_ekran.dart';


Future<void> setupHive() async {
  await Hive.initFlutter();

  var box = await Hive.openBox<int>("data");

}

Future<void> main() async {
  await setupHive();
  runApp(giderTakip());
}

class giderTakip extends StatelessWidget {
  const giderTakip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnaEkran(),
    );
  }
}


