import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage(
      this.onPressTable, this.onPressReservation, this.onPressSettings,
      {super.key});
  final VoidCallback onPressTable;
  final VoidCallback onPressReservation;
  final VoidCallback onPressSettings;
  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  String timeNow = DateFormat("dd/MM/yy").format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            width: 300.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 10.w,
                ),
                Text(timeNow,
                    style: GoogleFonts.seymourOne(
                      textStyle: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )),
                CircleAvatar(
                  backgroundColor: const Color(0XFFBF5555),
                  child: SvgPicture.asset(
                    "assets/Date_range.svg",
                    // ignore: deprecated_member_use
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 40.h),
              child: Image(
                image: const AssetImage("assets/preview.png"),
                fit: BoxFit.fitHeight,
                height: 294.75.h,
                width: 393.w,
              )),
          SizedBox(
            width: 309.w,
            height: 270.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    widget.onPressTable();
                  },
                  child: Container(
                    width: 309.w,
                    height: 68.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20.r))),
                    child: Center(
                      child: Text(
                        "Table games",
                        style: GoogleFonts.happyMonkey(
                          textStyle: TextStyle(
                            fontSize: 28.sp,
                            color: const Color(0xFFBF5555),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    widget.onPressReservation();
                  },
                  child: Container(
                    width: 309.w,
                    height: 68.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20.r))),
                    child: Center(
                      child: Text(
                        "Reservations",
                        style: GoogleFonts.happyMonkey(
                          textStyle: TextStyle(
                            fontSize: 28.sp,
                            color: const Color(0xFFBF5555),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    widget.onPressSettings();
                  },
                  child: Container(
                    width: 309.w,
                    height: 68.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20.r))),
                    child: Center(
                      child: Text(
                        "Setting",
                        style: GoogleFonts.happyMonkey(
                          textStyle: TextStyle(
                            fontSize: 28.sp,
                            color: const Color(0xFFBF5555),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
