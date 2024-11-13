import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:game/hive/boxes.dart';
import 'package:game/hive/model/game_model.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class AddGamePage extends StatefulWidget {
  const AddGamePage({super.key});

  @override
  State<AddGamePage> createState() {
    return _AddGamePageState();
  }
}

class _AddGamePageState extends State<AddGamePage> {
  TextEditingController descrioptionController = TextEditingController();
  TextEditingController rulesController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  Uint8List? _image;
  Future getLostData() async {
    XFile? picker = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picker == null) return;
    List<int> imageBytes = await picker.readAsBytes();
    _image = Uint8List.fromList(imageBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
        child: KeyboardActions(
          config: KeyboardActionsConfig(nextFocus: false, actions: [
            KeyboardActionsItem(
              focusNode: _nodeText1,
            ),
            KeyboardActionsItem(
              focusNode: _nodeText2,
            ),
          ]),
          child: SizedBox(
            width: double.infinity,
            height: 800.h,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
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
                  GestureDetector(
                    onTap: () async {
                      try {
                        await getLostData();
                        setState(() {});
                      } catch (e) {
                        log(e.toString());
                      }
                    },
                    child: Container(
                        height: 127.h,
                        width: 286.w,
                        decoration: _image == null
                            ? BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.r)))
                            : BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.r)),
                                image: DecorationImage(
                                    image: MemoryImage(_image!),
                                    fit: BoxFit.fill)),
                        child: _image == null
                            ? Center(
                                child: Image(
                                  image: const AssetImage(
                                      "assets/default_image.png"),
                                  width: 131.w,
                                  height: 109.h,
                                  fit: BoxFit.fill,
                                ),
                              )
                            : const SizedBox.shrink()),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 340.w,
                          child: Text(
                            "Description",
                            style: TextStyle(fontSize: 28.sp),
                          ),
                        ),
                        Container(
                          height: 109.h,
                          width: 340.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: const Color(0xFFBF5555), width: 2.w),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.r)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: TextField(
                              minLines: 1,
                              maxLines:
                                  null, // Позволяет полю расширяться по мере добавления строк
                              controller: descrioptionController,
                              focusNode: _nodeText1,
                              textInputAction: TextInputAction.newline,
                              decoration: InputDecoration(
                                  border: InputBorder.none, // Убираем обводку
                                  focusedBorder: InputBorder
                                      .none, // Убираем обводку при фокусе
                                  hintText: '',
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                      fontSize: 16.sp)),
                              keyboardType: TextInputType.multiline,
                              cursorColor: Colors.black,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp),
                              onChanged: (text) {
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: 340.w,
                        child: Text(
                          "The rules of the game",
                          style: TextStyle(fontSize: 28.sp),
                        ),
                      ),
                      Container(
                        height: 340.h,
                        width: 340.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: const Color(0xFFBF5555), width: 2.w),
                          borderRadius: BorderRadius.all(Radius.circular(20.r)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Column(
                            children: [
                              Expanded(
                                child: TextField(
                                  minLines: 1,
                                  maxLines:
                                      null, // Позволяет полю расширяться по мере добавления строк
                                  controller: rulesController,
                                  focusNode: _nodeText2,
                                  textInputAction: TextInputAction.newline,
                                  decoration: InputDecoration(
                                      border:
                                          InputBorder.none, // Убираем обводку
                                      focusedBorder: InputBorder
                                          .none, // Убираем обводку при фокусе
                                      hintText: '',
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                          fontSize: 16.sp)),
                                  keyboardType: TextInputType.multiline,
                                  cursorColor: Colors.black,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp),
                                  onChanged: (text) {
                                    setState(() {});
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        descrioptionController.text = "";
                                        rulesController.text = "";
                                        _image = null;
                                        setState(() {});
                                      },
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(fontSize: 18.sp),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (_image != null &&
                                            descrioptionController
                                                .text.isNotEmpty &&
                                            rulesController.text.isNotEmpty) {
                                          Box<GameModel> contactsBox =
                                              Hive.box<GameModel>(
                                                  HiveBoxes.gameModel);
                                          contactsBox.add(GameModel(
                                              imageGame: _image,
                                              description:
                                                  descrioptionController.text,
                                              rules: rulesController.text));
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: Text(
                                        "Save",
                                        style: TextStyle(fontSize: 18.sp),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
