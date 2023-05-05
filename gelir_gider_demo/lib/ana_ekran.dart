import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';

class AnaEkran extends StatefulWidget {
  const AnaEkran({Key? key}) : super(key: key);

  @override
  State<AnaEkran> createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late TextEditingController _gelirController = TextEditingController();
  late TextEditingController _giderController = TextEditingController();
  int? gelir;
  late int toplamgelir;

  int? gider;
  late int toplamgider;

  var box = Hive.box<int>("data");

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _controller.forward();
    if (box.get(0) == null) {
      box.put(0, 0);
    }
    if (box.get(1) == null) {
      box.put(1, 0);
    }

    toplamgelir = box.get(0)!;
    toplamgider = box.get(1)!;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gelir Gider"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  LottieBuilder.asset(
                    "animations/96199-round-circle-loading.json",
                    controller: _controller,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${box.get(0)! - box.get(1)!}",
                        style: TextStyle(fontSize: 30),
                      ),
                      const Text("Toplam Gelir"),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 1,
                bottom: 10,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      openDialog();
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Card(
                        child: Column(
                          children: const [
                            Icon(
                              Icons.add_circle_outline_sharp,
                              size: 80,
                              color: Colors.green,
                            ),
                            Text("Gelir Ekle")
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      openDialog1();
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Card(
                        child: Column(
                          children: const [
                            Icon(
                              Icons.remove_circle_outline,
                              size: 80,
                              color: Colors.red,
                            ),
                            Text("Gider Ekle"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    //fonksiyon atanacak
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Card(
                      child: Column(
                        children: const [
                          Icon(
                            Icons.not_accessible,
                            size: 80,
                            color: Colors.red,
                          ),
                          Text("Not Ekle"),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    //fonksiyon atanacak
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Card(
                      child: Column(
                        children: const [
                          Icon(
                            Icons.settings,
                            size: 80,
                            color: Colors.red,
                          ),
                          Text("Ayarlar"),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Card(
                      child: Column(
                        children: [
                          Text(
                            "${box.get(0)}",
                            style: TextStyle(fontSize: 30),
                          ),
                          Text(
                            "Toplam Gelir",
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Card(
                      child: Column(
                        children: [
                          Text(" ${box.get(1)}",
                              style: TextStyle(fontSize: 30)),
                          Text(" Toplam Gider"),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Gelir ekle"),
          content: TextField(
            keyboardType: TextInputType.phone,
            autofocus: true,
            controller: _gelirController,
            onSubmitted: (value) {
              Navigator.pop(context);

              gelir.toString() != value;

              toplamgelir = (toplamgelir + int.parse(value));
              value = toplamgelir.toString();

              box.put(0, toplamgelir);
              value = '';
              setState(() {});
            },
          ),
        ),
      );

  Future openDialog1() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Gider ekle"),
          content: TextField(
            controller: _giderController,
            keyboardType: TextInputType.phone,
            onSubmitted: (value1) {
              Navigator.pop(context);

              gider = int.parse(value1);

              toplamgider = toplamgider + int.parse(value1);

              box.put(1, toplamgider);
              value1 = '';

              setState(() {});
            },
          ),
        ),
      );
}
