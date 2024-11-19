import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() {
    return _InfoPageState();
  }
}

class _InfoPageState extends State<InfoPage> {
  late AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isSwitched = themeProvider.isDarkMode;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Background music",
                style: GoogleFonts.happyMonkey(
                    textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 32.sp,
                )),
              ),
              Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                    themeProvider.toggleTheme();
                  });
                },
                inactiveTrackColor: Colors.white,
                inactiveThumbColor: Colors.red,
                activeTrackColor: Colors.white,
                activeColor: Colors.green,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 40.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () async {
                  String? encodeQueryParameters(Map<String, String> params) {
                    return params.entries
                        .map((MapEntry<String, String> e) =>
                            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                        .join('&');
                  }

                  // ···
                  final Uri emailLaunchUri = Uri(
                    scheme: 'mailto',
                    path: 'tumayaltinli56@icloud.com',
                    query: encodeQueryParameters(<String, String>{
                      '': '',
                    }),
                  );
                  try {
                    if (await canLaunchUrl(emailLaunchUri)) {
                      await launchUrl(emailLaunchUri);
                    } else {
                      throw Exception("Could not launch $emailLaunchUri");
                    }
                  } catch (e) {
                    log('Error launching email client: $e'); // Log the error
                  }
                },
                child: Text(
                  "Contact us",
                  style: GoogleFonts.happyMonkey(
                      textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 32.sp,
                  )),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15.h),
                child: GestureDetector(
                  onTap: () async {
                    final Uri url = Uri.parse(
                        'https://docs.google.com/document/d/1nbCtHTFGuTOtagCK13mGmoAtImGRt_4iexX8fOh8RTg/mobilebasic');
                    if (!await launchUrl(url)) {
                      throw Exception('Could not launch $url');
                    }
                  },
                  child: Text(
                    "Privacy polycy",
                    style: GoogleFonts.happyMonkey(
                        textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 32.sp,
                    )),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  final InAppReview inAppReview = InAppReview.instance;
                  inAppReview.openStoreListing(
                    appStoreId: '6738127943',
                  );
                },
                child: Text(
                  "Rate us",
                  style: GoogleFonts.happyMonkey(
                      textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 32.sp,
                  )),
                ),
              ),
            ],
          ),
        ),
        Image(
          image: const AssetImage("assets/preview.png"),
          fit: BoxFit.fitHeight,
          height: 294.75.h,
          width: 393.w,
        ),
      ],
    );
  }
}
