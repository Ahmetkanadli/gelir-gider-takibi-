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
   int ? gelir;
  int  toplamgelir = 0;
  int ? gider;
  int toplamgider =0;


  var box = Hive.box<int>("data");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gelir Gider"),
      ),
      body: Column(
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
                    Text("Toplam Gelir"),
                    Text("${box.get(0)!-box.get(1)!}"),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 1, bottom: 10),
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
                        children: [
                          Icon(
                            Icons.add_circle_outline_sharp,
                            size: 40,
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
                        children: [
                          Icon(
                            Icons.remove_circle_outline,
                            size: 40,
                          ),
                          Text("Gider Ekle"),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1,
              child: Card(
                child: Text("Toplam Gelir:   ${box.get(0)}"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1,
              child: Card(
                child: Text("Toplam gider: $toplamgider"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Gelir ekle"),
          content: TextField(
            controller: _gelirController,
            onSubmitted: (value)  {
              Navigator.pop(context);




              print(box.get(0));
              gelir.toString() != value;
              print("çıktı ${int.parse(value)}");
              //toplamgelir = box.get(0)!;
              toplamgelir =(toplamgelir! + int.parse(value)!) ;
              value = toplamgelir.toString();
              print("toplam gelir $toplamgelir");
              box.put(0, toplamgelir);
              setState(() {

              });
              /*
              box.put(0, int.parse(value));
              print(box.get(0));
              gelir.toString() != value;
              print("çıktı ${int.parse(value)}");
              toplamgelir = box.get(0)!;
              toplamgelir =(toplamgelir! + gelir!) ;
              value = toplamgelir.toString();
              print("toplam gelir $toplamgelir");
               */


            },
          ),
        ),
      );
  Future openDialog1() => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Gider ekle"),
      content: TextField(
        controller: _giderController,
        onSubmitted: (value1)  {
          Navigator.pop(context);

          //print(box.get(1));
          gider = int.parse(value1);
          print("gider $gider");
          print("çıktı ${int.parse(value1)}");
          toplamgider =toplamgider! +int.parse(value1);
          value1 = toplamgider.toString();
          print("toplam gider $toplamgider");
          box.put(1, toplamgider);

setState(() {
  
});


          /*
              box.put(0, int.parse(value));
              print(box.get(0));
              gelir.toString() != value;
              print("çıktı ${int.parse(value)}");
              toplamgelir = box.get(0)!;
              toplamgelir =(toplamgelir! + gelir!) ;
              value = toplamgelir.toString();
              print("toplam gelir $toplamgelir");
               */


        },
      ),
    ),
  );
}
