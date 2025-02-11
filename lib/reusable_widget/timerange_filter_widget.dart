// ignore_for_file: library_private_types_in_public_api, use_super_parameters, must_be_immutable

import 'package:flutter/material.dart';

class TimeRangeFilterWidget extends StatefulWidget {
  final Function(String)? onCustomRangeSelected;
  final Function(DateTime?, DateTime?)? onTimeRangeSelected;
  final bool? viewCustomTimeRange;
  final bool? viewDateRangePicker;
  final String? currentCustom;
  DateTime? fromDate;
  DateTime? toDate;

  TimeRangeFilterWidget({
    Key? key,
    this.onTimeRangeSelected,
    this.viewCustomTimeRange,
    this.viewDateRangePicker,
    this.currentCustom,
    this.onCustomRangeSelected,
    this.fromDate,
    this.toDate,
  }) : super(key: key);

  @override
  _TimeRangeFilterWidgetState createState() => _TimeRangeFilterWidgetState();
}

class _TimeRangeFilterWidgetState extends State<TimeRangeFilterWidget> {
  String? selectedTimeRange;
  DateTime? fromDate;
  DateTime? toDate;

  @override
  void initState() {
    super.initState();
    if (widget.viewDateRangePicker ?? false) {
      fromDate = widget.fromDate;
      toDate = widget.toDate;
    }

    // Ensure that viewCustomTimeRange is properly handled
    if (widget.viewCustomTimeRange ?? false) {
      selectedTimeRange = widget.currentCustom ?? "TODAY";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Check if viewCustomTimeRange is not null and true
        if (widget.viewCustomTimeRange ?? false)
          Column(
            children: [
              Text("Select Time Range:"),
              DropdownButton<String>(
                value: selectedTimeRange,
                items: <String>['TODAY', 'THIS WEEK', 'THIS MONTH']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    widget.onCustomRangeSelected!(newValue);
                  }
                },
              ),
            ],
          ),
        // Check if viewDateRangePicker is not null and true
        if (widget.viewDateRangePicker ?? false)
          Column(
            children: [
              Row(
                children: [
                  Text("From:"),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: widget.fromDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null && picked != widget.fromDate) {
                        setState(() {
                          widget.fromDate = picked;
                        });
                      }
                    },
                  ),
                  Text(fromDate != null
                      ? "${fromDate?.toLocal()}"
                      : "Date Not Set"),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text("To:"),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: toDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null && picked != toDate) {
                        setState(() {
                          toDate = picked;
                        });
                        widget.onTimeRangeSelected!(fromDate, toDate);
                      }
                    },
                  ),
                  Text(
                      toDate != null ? "${toDate?.toLocal()}" : "Date Not Set"),
                ],
              ),
            ],
          ),
      ],
    );
  }
}
