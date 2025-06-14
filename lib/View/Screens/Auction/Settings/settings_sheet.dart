import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gaimzone/View/Screens/Auction/Settings/contacts_sheet.dart';
import 'package:gaimzone/View/Widgets/custom_button.dart';
import 'package:intl/intl.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:widget_tooltip/widget_tooltip.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/images.dart';

class SettingsSheet extends StatefulWidget {
  final String auctionStatus;

  const SettingsSheet({super.key, required this.auctionStatus});

  @override
  State<SettingsSheet> createState() => _SettingsSheetState();
}

class _SettingsSheetState extends State<SettingsSheet> {
  String result = "";

  bool isAutoSwitched = true;
  bool isStopSwitched = true;
  bool isStopSwitchActive = true;
  bool auctionLive = true;

  DateTime? _selectedDate;
  DateTime? _selectedDate2;
  TimeOfDay? _selectedTime;

  String? selectedValue;

  final List<String> items = [
    'All Franchises are not online',
    'Reason 2',
    'Reason 3'
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          width: Dimensions.screenWidth(context),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Settings",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context, result);
                      },
                      child: Icon(
                        Icons.close,
                        size: 30,
                        color: Theme.of(context).colorScheme.surfaceDim,
                      ),
                    ),
                  ),
                ],
              ),
              Dimensions.verticalSpace(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        left: 10, right: 20, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            color: Theme.of(context).colorScheme.secondaryFixed,
                            width: 1)),
                    width: Dimensions.screenWidth(context) * .425,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Lufga',
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surfaceBright,
                                ),
                                children: [
                                  const TextSpan(
                                    text: "Online",
                                  ),
                                  TextSpan(
                                      text: "\nFranchise",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surfaceDim)),
                                ])),
                        Text(
                          "10",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.surfaceDim,
                              fontSize: 36,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 10, right: 20, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            color: Theme.of(context).colorScheme.secondaryFixed,
                            width: 1)),
                    width: Dimensions.screenWidth(context) * .425,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Lufga',
                                  color: AppState.isDarkMode(context)
                                      ? DarkColors.notificationOrange
                                      : LightColors.notificationOrange,
                                ),
                                children: [
                                  const TextSpan(
                                    text: "Offline",
                                  ),
                                  TextSpan(
                                      text: "\nFranchise",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surfaceDim)),
                                ])),
                        Text(
                          "4",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.surfaceDim,
                              fontSize: 36,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Dimensions.verticalSpace(20),
              DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceTint,
                          borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(5),
                      child: TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelStyle: Theme.of(context).textTheme.titleMedium,
                        labelColor: AppColors.whiteColor,
                        unselectedLabelColor:
                            Theme.of(context).colorScheme.surfaceDim,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 0.0,
                          vertical: 0.0,
                        ),
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: AppState.isDarkMode(context)
                              ? Theme.of(context).colorScheme.tertiary
                              : Theme.of(context).primaryColor,
                        ),
                        tabs: const [
                          Tab(height: 40, text: "Auction"),
                          Tab(height: 40, text: "Franchises"),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.screenHeight(context) * .5,
                      child: TabBarView(
                        children: [
                          auctionTabView(),
                          franchisesTabView(),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget auctionTabView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Dimensions.verticalSpace(30),
          Container(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: Theme.of(context).colorScheme.outline, width: 1)),
            width: Dimensions.screenWidth(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Auto Pause",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Dimensions.verticalSpace(5),
                    WidgetTooltip(
                      triangleColor: Colors.black12,
                      messageDecoration: const BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      triggerMode: WidgetTooltipTriggerMode.tap,
                      dismissMode: WidgetTooltipDismissMode.tapAnyWhere,
                      message: Text('Info message',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surfaceDim)),
                      child: Opacity(
                        opacity: .2,
                        child: Icon(
                          Icons.info,
                          color: Theme.of(context).colorScheme.surfaceDim,
                          size: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                Switch(
                  inactiveThumbColor: AppColors.darkGrey.withOpacity(.5),
                  trackOutlineColor: WidgetStateProperty.resolveWith<Color?>(
                    (states) {
                      if (states.contains(WidgetState.selected)) {
                        return null;
                      }
                      return AppColors.darkGrey.withOpacity(.5);
                    },
                  ),
                  value: isAutoSwitched,
                  onChanged: (value) {
                    setState(() {
                      isAutoSwitched = value;
                    });
                    setState(() {
                      isAutoSwitched = value;
                    });
                  },
                )
              ],
            ),
          ),
          Dimensions.verticalSpace(20),
          Container(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: Theme.of(context).colorScheme.outline, width: 1)),
            width: Dimensions.screenWidth(context),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Stop Auction",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Switch(
                      inactiveThumbColor: AppColors.darkGrey.withOpacity(.5),
                      trackOutlineColor:
                          WidgetStateProperty.resolveWith<Color?>(
                        (states) {
                          if (states.contains(WidgetState.selected)) {
                            return null;
                          }
                          return AppColors.darkGrey.withOpacity(.5);
                        },
                      ),
                      activeTrackColor: Theme.of(context).colorScheme.primary,
                      value: isStopSwitched,
                      onChanged: (value) {
                        isStopSwitchActive
                            ? {
                                setState(() {
                                  isStopSwitched = value;
                                }),
                                setState(() {
                                  isStopSwitched = value;
                                })
                              }
                            : null;
                      },
                    )
                  ],
                ),
                Dimensions.verticalSpace(10),
                auctionLive
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Reason",
                          ),
                          Container(
                            width: Dimensions.screenWidth(context) * .5,
                            padding: const EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: DropdownButtonFormField<String>(
                              padding: EdgeInsets.zero,
                              value: selectedValue,
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 12),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: .6,
                                      color:
                                          Theme.of(context).colorScheme.outline,
                                    ),
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              hint: const Text('Select'),
                              isExpanded: true,
                              isDense: true,
                              items: [
                                DropdownMenuItem<String>(
                                  value: null,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    height: 16,
                                    child: const Text(
                                      'Select',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                                ...items.map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          height: 16,
                                          child: Text(item)),
                                    )),
                              ],
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedValue = newValue;
                                });
                              },
                            ),
                          ),
                        ],
                      )
                    : Container(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 20, right: 20),
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(30)),
                        alignment: Alignment.center,
                        width: Dimensions.screenWidth(context) * .6,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "10 June",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.whiteColor),
                            ),
                            Countdown(
                              seconds: 1000,
                              build: (_, double time) {
                                int hours = (time / 3600).floor();
                                int minutes = ((time % 3600) / 60).floor();
                                int seconds = (time % 60).floor();

                                return Text(
                                  "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.whiteColor),
                                );
                              },
                              onFinished: () => {},
                            )
                          ],
                        ),
                      ),
                Dimensions.verticalSpace(10),
                auctionLive
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Set Time",
                          ),
                          Container(
                            width: Dimensions.screenWidth(context) * .5,
                            height: 30,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: GestureDetector(
                              onTap: () async {
                                DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: _selectedDate ?? DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101),
                                  initialEntryMode:
                                      DatePickerEntryMode.calendarOnly,
                                  builder:
                                      (BuildContext context, Widget? child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        datePickerTheme: DatePickerThemeData(
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          headerHelpStyle: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                );

                                if (picked != null) {
                                  setState(() {
                                    _selectedDate = picked;
                                  });
                                  if (_selectedDate != null) {
                                    DateTime initialTime = DateTime.now();
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        DateTime pickedTime = initialTime;
                                        return SizedBox(
                                          height: 250,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Container(
                                                margin:
                                                    const EdgeInsets.all(20),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Select Time",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleMedium,
                                                    ),
                                                    TextButton(
                                                      style:
                                                          TextButton.styleFrom(
                                                        foregroundColor:
                                                            Colors.white,
                                                        backgroundColor:
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .primary,
                                                        textStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .titleSmall,
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 0,
                                                                horizontal: 0),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                      ),
                                                      child: const Text("Done"),
                                                      onPressed: () async {
                                                        setState(() {
                                                          _selectedTime =
                                                              TimeOfDay
                                                                  .fromDateTime(
                                                                      pickedTime);
                                                        });
                                                        if (_selectedTime !=
                                                            null) {
                                                          setState(() {
                                                            _selectedDate2 =
                                                                DateTime(
                                                              _selectedDate!
                                                                  .year,
                                                              _selectedDate!
                                                                  .month,
                                                              _selectedDate!
                                                                  .day,
                                                              _selectedTime!
                                                                  .hour,
                                                              _selectedTime!
                                                                  .minute,
                                                            );
                                                          });
                                                        }
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: CupertinoDatePicker(
                                                  mode: CupertinoDatePickerMode
                                                      .time,
                                                  initialDateTime: initialTime,
                                                  use24hFormat: false,
                                                  onDateTimeChanged:
                                                      (DateTime time) {
                                                    setState(() {
                                                      pickedTime = time;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  }
                                }
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Dimensions.horizontalSpace(10),
                                  Text(
                                    _selectedDate2 == null
                                        ? '---'
                                        : DateFormat('MMMM d, y')
                                            .format(_selectedDate2!),
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  Container(
                                    height: 30,
                                    width: Dimensions.screenWidth(context) * .2,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          width: .5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      _selectedDate2 == null
                                          ? '---'
                                          : DateFormat('hh:mm a')
                                              .format(_selectedDate2!),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : Text("Reason: ${selectedValue ?? ""}"),
              ],
            ),
          ),
          Dimensions.verticalSpace(10),
          auctionLive
              ? CustomButton(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return Wrap(
                          children: [
                            Container(
                              width: Dimensions.screenWidth(context),
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 10, bottom: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Icon(Icons.close,
                                          size: 30,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surfaceDim)),
                                  Dimensions.verticalSpace(10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        AppImages.alertSign,
                                        width: 50,
                                        height: 50,
                                        colorFilter: ColorFilter.mode(
                                          AppState.isDarkMode(context)
                                              ? DarkColors.notificationOrange
                                              : LightColors.notificationOrange,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                      Dimensions.verticalSpace(10),
                                      const Text(
                                        "Do you want to STOP this auction?",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Dimensions.verticalSpace(20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              margin: const EdgeInsets.only(
                                                  top: 10,
                                                  bottom: 10,
                                                  left: 10,
                                                  right: 10),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary),
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .surface,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              alignment: Alignment.center,
                                              width: Dimensions.screenWidth(
                                                      context) *
                                                  .35,
                                              child: Text(
                                                "Cancel",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge,
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                auctionLive = false;
                                                result = "stopped";
                                                isStopSwitchActive = false;
                                              });
                                              Navigator.pop(context, result);
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              margin: const EdgeInsets.only(
                                                  top: 10,
                                                  bottom: 10,
                                                  left: 10,
                                                  right: 10),
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              alignment: Alignment.center,
                                              width: Dimensions.screenWidth(
                                                      context) *
                                                  .35,
                                              child: const Text("Yes, stop",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: AppColors
                                                          .whiteColor)),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Dimensions.verticalSpace(30),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  visibility: isStopSwitched,
                  width: Dimensions.screenWidth(context) * .7,
                  labelStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.whiteColor),
                  label: "Stop Auction",
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      onTap: () {
                        setState(() {
                          auctionLive = false;
                          result = "closed";
                          isStopSwitchActive = true;
                        });
                        Navigator.pop(context, result);
                      },
                      border: Border.all(
                          color: Theme.of(context).colorScheme.primary),
                      width: Dimensions.screenWidth(context) * .35,
                      color: Theme.of(context).colorScheme.surface,
                      labelStyle: Theme.of(context).textTheme.titleLarge,
                      label: "Update",
                    ),
                    CustomButton(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return Wrap(
                              children: [
                                Container(
                                  width: Dimensions.screenWidth(context),
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 10, bottom: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Icon(Icons.close,
                                              size: 30,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .surfaceDim)),
                                      Dimensions.verticalSpace(10),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            AppImages.alertSign,
                                            width: 50,
                                            height: 50,
                                            colorFilter: ColorFilter.mode(
                                              AppState.isDarkMode(context)
                                                  ? DarkColors
                                                      .notificationOrange
                                                  : LightColors
                                                      .notificationOrange,
                                              BlendMode.srcIn,
                                            ),
                                          ),
                                          Dimensions.verticalSpace(10),
                                          Container(
                                              width: Dimensions.screenWidth(
                                                      context) *
                                                  .7,
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: AppState.isDarkMode(
                                                          context)
                                                      ? DarkColors
                                                          .highlightYellow
                                                      : LightColors
                                                          .highlightYellow,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(
                                                    AppImages.alertSign2,
                                                    width: 24,
                                                    height: 24,
                                                    colorFilter:
                                                        ColorFilter.mode(
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .surfaceDim,
                                                      BlendMode.srcIn,
                                                    ),
                                                  ),
                                                  Dimensions.horizontalSpace(10),
                                                  Text(
                                                    "2 franchises are offline",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium,
                                                  ),
                                                ],
                                              )),
                                          Dimensions.verticalSpace(10),
                                          const Text(
                                            "Do you want to RESUME this auction?",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Dimensions.verticalSpace(20),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10, bottom: 10),
                                                  margin: const EdgeInsets.only(
                                                      top: 10,
                                                      bottom: 10,
                                                      left: 10,
                                                      right: 10),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary),
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .surface,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30)),
                                                  alignment: Alignment.center,
                                                  width: Dimensions.screenWidth(
                                                          context) *
                                                      .35,
                                                  child: Text(
                                                    "Cancel",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleLarge,
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    auctionLive = true;
                                                    result = "live";
                                                    isStopSwitchActive = true;
                                                  });
                                                  Navigator.pop(
                                                      context, result);
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10, bottom: 10),
                                                  margin: const EdgeInsets.only(
                                                      top: 10,
                                                      bottom: 10,
                                                      left: 10,
                                                      right: 10),
                                                  decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30)),
                                                  alignment: Alignment.center,
                                                  width: Dimensions.screenWidth(
                                                          context) *
                                                      .35,
                                                  child: const Text(
                                                      "Yes, Resume",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: AppColors
                                                              .whiteColor)),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Dimensions.verticalSpace(30),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      width: Dimensions.screenWidth(context) * .35,
                      labelStyle: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: AppColors.whiteColor),
                      label: "Resume",
                    ),
                  ],
                ),
          Dimensions.verticalSpace(50),
        ],
      ),
    );
  }

  Widget callInfoCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showContactDetails(context);
      },
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 8,
          left: 2,
        ),
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                width: 1, color: Theme.of(context).colorScheme.outline)),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  AppImages.frIcon,
                  height: 40,
                  width: 40,
                ),
                Dimensions.horizontalSpace(10),
                Text(
                  "Phoenix",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceBright,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "Online",
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                    ),
                  ),
                ),
                Dimensions.horizontalSpace(10),
                CircleAvatar(
                  radius: 22,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: const Icon(
                    Icons.call,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget franchisesTabView() {
    return Container(
      width: Dimensions.screenWidth(context),
      height: 400,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      child: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return callInfoCard(context);
        },
      ),
    );
  }

  void showContactDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return const ContactsSheet();
      },
    );
  }
}
