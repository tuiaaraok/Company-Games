import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:game/hive/model/game_model.dart';
import 'package:google_fonts/google_fonts.dart';

class GameInfoPage extends StatefulWidget {
  const GameInfoPage({super.key, required this.game});
  final GameModel game;
  @override
  State<GameInfoPage> createState() {
    // TODO: implement createState
    return _GameInfoPageState();
  }
}

class _GameInfoPageState extends State<GameInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.w, bottom: 10.h),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        "assets/arrow_back.svg",
                      ),
                    ),
                  ),
                ),
                Image(
                  image: MemoryImage(widget.game.imageGame!),
                  width: 336.w,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.h),
                  child: SizedBox(
                    width: 340.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Description",
                          style: GoogleFonts.happyMonkey(
                              textStyle: TextStyle(
                            fontSize: 28.sp,
                          )),
                        ),
                        Text(
                          widget.game.description!,
                          style: GoogleFonts.happyMonkey(
                              textStyle: TextStyle(
                            fontSize: 16.sp,
                          )),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 340.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "The rules of the game",
                        style: GoogleFonts.happyMonkey(
                            textStyle: TextStyle(
                          fontSize: 28.sp,
                        )),
                      ),
                      Text(
                        widget.game.rules!,
                        style: GoogleFonts.happyMonkey(
                            textStyle: TextStyle(
                          fontSize: 16.sp,
                        )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
