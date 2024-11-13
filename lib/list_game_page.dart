import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/add_game_page.dart';
import 'package:game/game_info_page.dart';
import 'package:game/hive/boxes.dart';
import 'package:game/hive/model/game_model.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hive_flutter/hive_flutter.dart';

class ListGamePage extends StatefulWidget {
  const ListGamePage({super.key});

  @override
  State<ListGamePage> createState() {
    return _ListGamePageState();
  }
}

class _ListGamePageState extends State<ListGamePage> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<GameModel>(HiveBoxes.gameModel).listenable(),
        builder: (context, Box<GameModel> box, _) {
          return SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const AddGamePage(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: Container(
                          width: 286.w,
                          height: 56.h,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xFFBF5555), width: 2.w),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.r))),
                          child: Center(
                            child: Text("Add New Game",
                                style: GoogleFonts.happyMonkey(
                                  textStyle: TextStyle(fontSize: 28.sp),
                                )),
                          )),
                    ),
                  ),
                  for (int i = 0; i < box.values.length; i++)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => GameInfoPage(
                              game: box.getAt(i)!,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: Container(
                          width: 300.w,
                          height: 187.16.h,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: MemoryImage(box.getAt(i)!.imageGame!)),
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
          );
        });
  }
}
