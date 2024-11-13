import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/hive/boxes.dart';
import 'package:game/hive/model/reserv_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class ReservGamePage extends StatefulWidget {
  const ReservGamePage({super.key});

  @override
  State<ReservGamePage> createState() {
    return _ReservGamePageState();
  }
}

class _ReservGamePageState extends State<ReservGamePage> {
  List<Map<String, String>> res = [];

  TextEditingController tableGames = TextEditingController();
  TextEditingController tableNumber = TextEditingController();
  TextEditingController reservADate = TextEditingController();
  TextEditingController gameTime = TextEditingController();
  TextEditingController pricePreHours = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  final FocusNode _nodeText3 = FocusNode();
  bool isActiveAdd = false;

  @override
  Widget build(BuildContext context) {
    return KeyboardActions(
      config: KeyboardActionsConfig(nextFocus: false, actions: [
        KeyboardActionsItem(
          focusNode: _nodeText1,
        ),
        KeyboardActionsItem(
          focusNode: _nodeText2,
        ),
        KeyboardActionsItem(
          focusNode: _nodeText3,
        ),
      ]),
      child: ValueListenableBuilder(
          valueListenable:
              Hive.box<ReservModel>(HiveBoxes.reservModel).listenable(),
          builder: (context, Box<ReservModel> box, _) {
            return SingleChildScrollView(
              child: SizedBox(
                width: double.maxFinite,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 60.h, bottom: 20.h),
                      child: GestureDetector(
                        onTap: () {
                          isActiveAdd = !isActiveAdd;
                          setState(() {});
                        },
                        child: Container(
                          width: 285.w,
                          height: 56.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.r)),
                            border: Border.all(
                                color: const Color(0xFFBF5555), width: 2.w),
                          ),
                          child: Center(
                              child: Text(
                            "Reserv a game",
                            style: TextStyle(fontSize: 28.sp),
                          )),
                        ),
                      ),
                    ),
                    if (isActiveAdd)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Container(
                          width: 340.w,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.r)),
                            border: Border.all(
                                color: const Color(0xFFBF5555), width: 2.w),
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: 340.w,
                                height: 60.h,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.r),
                                      topRight: Radius.circular(20.r),
                                    ),
                                    border: Border(
                                      bottom: BorderSide(
                                        color: const Color(0xFFBF5555),
                                        width: 2.w,
                                      ),
                                    )),
                                child: Center(
                                    child: Text(
                                  "Reservation",
                                  style: TextStyle(fontSize: 28.sp),
                                )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10.h),
                                child: Wrap(
                                  alignment: WrapAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "Table games",
                                          style: TextStyle(fontSize: 18.sp),
                                        ),
                                        Container(
                                          width: 340.w,
                                          height: 60.h,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border(
                                                  bottom: BorderSide(
                                                    color:
                                                        const Color(0xFFBF5555),
                                                    width: 2.w,
                                                  ),
                                                  top: BorderSide(
                                                    color:
                                                        const Color(0xFFBF5555),
                                                    width: 2.w,
                                                  ))),
                                          child: TextField(
                                            textAlign: TextAlign.center,
                                            controller: tableGames,
                                            decoration: InputDecoration(
                                                border: InputBorder
                                                    .none, // Убираем обводку
                                                focusedBorder: InputBorder
                                                    .none, // Убираем обводку при фокусе
                                                hintText: '',
                                                hintStyle: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey,
                                                    fontSize: 18.sp)),
                                            keyboardType: TextInputType.text,
                                            cursorColor: Colors.black,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.sp),
                                            onChanged: (text) {
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Table number",
                                          style: TextStyle(fontSize: 18.sp),
                                        ),
                                        Container(
                                          width: 158.w,
                                          height: 60.h,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border(
                                                  bottom: BorderSide(
                                                    color:
                                                        const Color(0xFFBF5555),
                                                    width: 2.w,
                                                  ),
                                                  right: BorderSide(
                                                    color:
                                                        const Color(0xFFBF5555),
                                                    width: 2.w,
                                                  ),
                                                  top: BorderSide(
                                                    color:
                                                        const Color(0xFFBF5555),
                                                    width: 2.w,
                                                  ))),
                                          child: TextField(
                                            controller: tableNumber,
                                            focusNode: _nodeText1,
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
                                                border: InputBorder
                                                    .none, // Убираем обводку
                                                focusedBorder: InputBorder
                                                    .none, // Убираем обводку при фокусе
                                                hintText: '',
                                                hintStyle: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey,
                                                    fontSize: 18.sp)),
                                            keyboardType: TextInputType.number,
                                            cursorColor: Colors.black,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.sp),
                                            onChanged: (text) {
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Reserv a date",
                                          style: TextStyle(fontSize: 18.sp),
                                        ),
                                        Container(
                                          width: 158.w,
                                          height: 60.h,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border(
                                                  bottom: BorderSide(
                                                    color:
                                                        const Color(0xFFBF5555),
                                                    width: 2.w,
                                                  ),
                                                  left: BorderSide(
                                                    color:
                                                        const Color(0xFFBF5555),
                                                    width: 2.w,
                                                  ),
                                                  top: BorderSide(
                                                    color:
                                                        const Color(0xFFBF5555),
                                                    width: 2.w,
                                                  ))),
                                          child: TextField(
                                            controller: reservADate,
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
                                                border: InputBorder
                                                    .none, // Убираем обводку
                                                focusedBorder: InputBorder
                                                    .none, // Убираем обводку при фокусе
                                                hintText: '',
                                                hintStyle: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey,
                                                    fontSize: 18.sp)),
                                            keyboardType:
                                                TextInputType.datetime,
                                            cursorColor: Colors.black,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.sp),
                                            onChanged: (text) {
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Game time",
                                          style: TextStyle(fontSize: 18.sp),
                                        ),
                                        Container(
                                          width: 158.w,
                                          height: 60.h,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border(
                                                  bottom: BorderSide(
                                                    color:
                                                        const Color(0xFFBF5555),
                                                    width: 2.w,
                                                  ),
                                                  right: BorderSide(
                                                    color:
                                                        const Color(0xFFBF5555),
                                                    width: 2.w,
                                                  ),
                                                  top: BorderSide(
                                                    color:
                                                        const Color(0xFFBF5555),
                                                    width: 2.w,
                                                  ))),
                                          child: TextField(
                                            controller: gameTime,
                                            focusNode: _nodeText2,
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
                                                border: InputBorder
                                                    .none, // Убираем обводку
                                                focusedBorder: InputBorder
                                                    .none, // Убираем обводку при фокусе
                                                hintText: '',
                                                hintStyle: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey,
                                                    fontSize: 18.sp)),
                                            keyboardType: TextInputType.number,
                                            cursorColor: Colors.black,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.sp),
                                            onChanged: (text) {
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Price per hour",
                                          style: TextStyle(fontSize: 18.sp),
                                        ),
                                        Container(
                                          width: 158.w,
                                          height: 60.h,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border(
                                                  bottom: BorderSide(
                                                    color:
                                                        const Color(0xFFBF5555),
                                                    width: 2.w,
                                                  ),
                                                  left: BorderSide(
                                                    color:
                                                        const Color(0xFFBF5555),
                                                    width: 2.w,
                                                  ),
                                                  top: BorderSide(
                                                    color:
                                                        const Color(0xFFBF5555),
                                                    width: 2.w,
                                                  ))),
                                          child: TextField(
                                            controller: pricePreHours,
                                            focusNode: _nodeText3,
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
                                                border: InputBorder
                                                    .none, // Убираем обводку
                                                focusedBorder: InputBorder
                                                    .none, // Убираем обводку при фокусе
                                                hintText: '',
                                                hintStyle: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey,
                                                    fontSize: 18.sp)),
                                            keyboardType: TextInputType.number,
                                            cursorColor: Colors.black,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.sp),
                                            onChanged: (text) {
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: SizedBox(
                                  width: 286.w,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          tableGames.text = "";
                                          tableNumber.text = "";
                                          reservADate.text = "";
                                          gameTime.text = "";
                                          pricePreHours.text = "";
                                          isActiveAdd = false;
                                          setState(() {});
                                        },
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(fontSize: 18.sp),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (tableGames.text.isNotEmpty &&
                                              tableNumber.text.isNotEmpty &&
                                              reservADate.text.isNotEmpty &&
                                              gameTime.text.isNotEmpty &&
                                              pricePreHours.text.isNotEmpty) {
                                            box.add(ReservModel(
                                              tableName: tableGames.text,
                                              tableNumber: tableNumber.text,
                                              reservDate: reservADate.text,
                                              time: gameTime.text,
                                              price: pricePreHours.text,
                                            ));

                                            tableGames.text = "";
                                            tableNumber.text = "";
                                            reservADate.text = "";
                                            gameTime.text = "";
                                            pricePreHours.text = "";
                                            setState(() {});
                                          }
                                        },
                                        child: Text(
                                          "Save",
                                          style: TextStyle(fontSize: 18.sp),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    for (int i = 0; i < box.values.length; i++)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Container(
                          width: 340.w,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.r)),
                            border: Border.all(
                                color: const Color(0xFFBF5555), width: 2.w),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 10.w),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "tables: ${box.getAt(i)!.tableNumber}",
                                      style: TextStyle(fontSize: 22.sp),
                                    ),
                                    Text(
                                      box.getAt(i)!.tableName.toString(),
                                      style: TextStyle(fontSize: 22.sp),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 340.w,
                                  child: Wrap(
                                    alignment: WrapAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${box.getAt(i)!.reservDate} ",
                                        style: TextStyle(fontSize: 22.sp),
                                      ),
                                      Text(
                                        "${box.getAt(i)!.time.toString()} hours ",
                                        style: TextStyle(fontSize: 22.sp),
                                      ),
                                      Text(
                                        box.getAt(i)!.price.toString(),
                                        style: TextStyle(fontSize: 22.sp),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
