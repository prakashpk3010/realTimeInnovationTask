import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realtime_task/constants/app_colors.dart';
import 'package:realtime_task/constants/app_font_style.dart';
import 'package:realtime_task/constants/app_layouts.dart';
import 'package:realtime_task/features/provider/provider.dart';
import 'package:realtime_task/features/widgets/buttons.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:realtime_task/utils/date_converter.dart';

class CustomDatePicker extends ConsumerStatefulWidget {
  final bool isfrom;
  const CustomDatePicker(this.isfrom, {super.key});

  @override
  ConsumerState<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends ConsumerState<CustomDatePicker> {
  @override
  Widget build(BuildContext context) {
    final datesel =
        ref.watch(widget.isfrom ? fromdateSelectedProv : todateSelectedProv);
    return SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          Applayout().cornerRadius,
        ),
      ),
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 300, maxHeight: 500),
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.isfrom)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButtons(
                            width: MediaQuery.of(context).size.width * 0.28,
                            function: () {
                              setState(() {
                                today = true;
                                nextMon = false;
                                nextTue = false;
                                nextWeek = false;
                                _currentDate = DateTime.now();
                                ref.read(fromdateSelectedProv.notifier).update(
                                    (state) =>
                                        dateFormattertoStr(_currentDate));
                              });
                            },
                            text: 'Today',
                            isSelected: today),
                        Applayout().withSpacer20,
                        CustomButtons(
                            width: MediaQuery.of(context).size.width * 0.28,
                            function: () {
                              setState(() {
                                today = false;
                                nextMon = true;
                                nextTue = false;
                                nextWeek = false;
                                DateTime now = DateTime.now();
                                int currentDay = now.weekday;
                                _currentDate =
                                    now.add(Duration(days: currentDay + 6));
                                ref.read(fromdateSelectedProv.notifier).update(
                                    (state) =>
                                        dateFormattertoStr(_currentDate));
                              });
                            },
                            text: 'Next Monday',
                            isSelected: nextMon),
                      ],
                    ),
                    Applayout().height10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButtons(
                            width: MediaQuery.of(context).size.width * 0.28,
                            function: () {
                              setState(() {
                                today = false;
                                nextMon = false;
                                nextTue = true;
                                nextWeek = false;
                                DateTime now = DateTime.now();
                                int currentDay = now.weekday;
                                _currentDate =
                                    now.add(Duration(days: currentDay + 7));
                                ref.read(fromdateSelectedProv.notifier).update(
                                    (state) =>
                                        dateFormattertoStr(_currentDate));
                              });
                            },
                            text: 'Next Tuesday',
                            isSelected: nextTue),
                        Applayout().withSpacer20,
                        CustomButtons(
                            width: MediaQuery.of(context).size.width * 0.28,
                            function: () {
                              setState(() {
                                today = false;
                                nextMon = false;
                                nextTue = false;
                                nextWeek = true;
                                _currentDate = DateTime.now().add(
                                  const Duration(
                                    days: 14,
                                  ),
                                );
                              });
                              ref.read(fromdateSelectedProv.notifier).update(
                                  (state) => dateFormattertoStr(_currentDate));
                            },
                            text: 'After a Week',
                            isSelected: nextWeek),
                      ],
                    ),
                  ],
                ),
              if (!widget.isfrom)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButtons(
                        width: MediaQuery.of(context).size.width * 0.28,
                        function: () {
                          setState(() {
                            nodate = true;
                            today = false;
                            _currentDate = DateTime.now();
                            ref
                                .read(todateSelectedProv.notifier)
                                .update((state) => '');
                          });
                        },
                        text: 'No date',
                        isSelected: nodate),
                    CustomButtons(
                        width: MediaQuery.of(context).size.width * 0.28,
                        function: () {
                          setState(() {
                            today = true;
                            nodate = false;
                            _currentDate = DateTime.now();
                          });
                          ref.read(todateSelectedProv.notifier).update(
                              (state) => dateFormattertoStr(_currentDate));
                        },
                        text: 'Today',
                        isSelected: today),
                    Applayout().withSpacer20,
                  ],
                ),
              widgetCalendar(),
              Applayout().listSpacer,
              Row(
                children: [
                  Applayout().withSpacer10,
                  const Expanded(child: Icon(Icons.calendar_today)),
                  Text(
                    datesel.isEmpty ? 'No Date' : datesel,
                    style: AppFontStyles().calenderNormalFont,
                  ),
                  const Spacer(),
                  CustomButtons(
                      width: 70,
                      function: () {
                        if (!widget.isfrom) {
                          ref
                              .read(todateSelectedProv.notifier)
                              .update((state) => '');
                        }
                        if (widget.isfrom) {
                          ref
                              .read(fromdateSelectedProv.notifier)
                              .update((state) => '');
                        }
                        Navigator.pop(context);
                      },
                      text: 'Cancel',
                      isSelected: false),
                  CustomButtons(
                    width: 70,
                    function: () {
                      ref
                          .read(todateSelectedProv.notifier)
                          .update((state) => dateFormattertoStr(_currentDate));
                      Navigator.pop(context);
                    },
                    text: 'Save',
                    isSelected: true,
                  ),
                  Applayout().withSpacer10,
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  bool today = true;
  bool nodate = false;
  bool nextMon = false;
  bool nextTue = false;
  bool nextWeek = false;
  DateTime _currentDate = DateTime.now();
  Widget widgetCalendar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: CalendarCarousel<Event>(
        selectedDayBorderColor: Colors.transparent,
        selectedDayButtonColor: AppColors().primaryColor,
        weekdayTextStyle: AppFontStyles().textFieldStyle,
        todayButtonColor: Colors.grey,
        todayBorderColor: Colors.transparent,
        onDayPressed: (DateTime date, List<Event> events) {
          setState(() => _currentDate = date);
          ref
              .read(widget.isfrom
                  ? fromdateSelectedProv.notifier
                  : todateSelectedProv.notifier)
              .update((state) => dateFormattertoStr(_currentDate));
        },
        weekendTextStyle: const TextStyle(
          color: Colors.black,
        ),
        thisMonthDayBorderColor: Colors.transparent,
        nextMonthDayBorderColor: Colors.transparent,
        customDayBuilder: (
          bool isSelectable,
          int index,
          bool isSelectedDay,
          bool isToday,
          bool isPrevMonthDay,
          TextStyle textStyle,
          bool isNextMonthDay,
          bool isThisMonthDay,
          DateTime day,
        ) {
          return null;
        },
        weekFormat: false,
        height: 325.0,
        selectedDateTime: _currentDate,
        daysHaveCircularBorder: true,
        nextDaysTextStyle: AppFontStyles()
            .calenderNormalFont
            .copyWith(color: Colors.transparent),
        prevDaysTextStyle: AppFontStyles()
            .calenderNormalFont
            .copyWith(color: Colors.transparent),
      ),
    );
  }
}
