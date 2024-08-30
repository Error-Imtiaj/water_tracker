import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:water_tracker/screens/water_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController watercontroller = TextEditingController();
  List<AddWater> waterlist = [];

  @override
  void dispose() {
    // TODO: implement dispose
    watercontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: Text(
          'Water Tracker',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        toolbarHeight: 60,
      ),
      body: SafeArea(child: waterTracker()),
    );
  }

  Widget waterTracker() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: Column(
        children: [
          _waterFristContainer(),
          SizedBox(
            height: 30,
          ),
          _waterSecondContainer(),
        ],
      ),
    );
  }

  Widget _waterFristContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          totalglassescount().toString(),
          style: GoogleFonts.poppins(fontSize: 48, fontWeight: FontWeight.bold),
        ),
        Text(
          'glasses',
          style: GoogleFonts.poppins(fontSize: 24),
        ),
        SizedBox(
          height: 30,
        ),
        _addsection()
      ],
    );
  }

  // ADD glass DATA section
  Widget _addsection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 42,
          width: 80,
          child: TextField(
            controller: watercontroller,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.amber.shade900,
                border: InputBorder.none),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        TextButton(
            onPressed: () => addwatertrack(),
            style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                shape: ContinuousRectangleBorder()),
            child: Text(
              'Add',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.amber.shade900),
            ))
      ],
    );
  }

// _Water tracker 2nd portion

  Widget _waterSecondContainer() {
    return Expanded(
      child: ListView.separated(
          itemBuilder: (context, index) {
            int reverse = waterlist.length - 1 - index;
            final AddWater mywater = waterlist[reverse];
            return ListTile(
              title: Text(
                '${mywater.time.hour} : ${mywater.time.minute}',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 20),
              ),
              subtitle: Text(
                '${mywater.time.day} / ${mywater.time.month} / ${mywater.time.year}',
                style: GoogleFonts.poppins(),
              ),
              leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.white, width: 3)),
                  child: Center(
                      child: Text(
                    '${mywater.noOfGlasses}',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black),
                  ))),
              trailing: IconButton.outlined(
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () => delete(index),
                  icon: Icon(
                    Icons.delete_rounded,
                    color: Colors.deepOrange,
                  )),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              color: Colors.white,
              thickness: 2,
            );
          },
          itemCount: waterlist.length),
    );
  }

  int totalglassescount() {
    int count = 0;
    for (AddWater i in waterlist) {
      count += i.noOfGlasses;
    }
    return count;
  }

  void addwatertrack() {
    if (watercontroller.text.isEmpty) {
      watercontroller.text = '1';
    }
    int noOfGlassses = int.tryParse(watercontroller.text) ?? 1;
    AddWater addWater =
        AddWater(noOfGlasses: noOfGlassses, time: DateTime.now());
    setState(() {
      waterlist.add(addWater);
    });
  }

  void delete(index) {
    setState(() {
      waterlist.removeAt(index);
    });
  }
}
