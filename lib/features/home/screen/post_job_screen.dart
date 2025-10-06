import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_app_bar.dart';
import 'package:workpleis/core/widget/global_bottom.dart';
import 'package:workpleis/core/widget/global_get_started_button.dart';
import 'package:workpleis/features/auth/widgets/custom_choose_file.dart';
import 'package:workpleis/features/auth/widgets/custom_label_text.dart';
import 'package:workpleis/features/home/widget/custom_filter_chips.dart';

class PostJobScreen extends StatefulWidget {
  const PostJobScreen({super.key});

  static const routeName = '/postJobScreen';

  @override
  State<PostJobScreen> createState() => _PostJobScreenState();
}

class _PostJobScreenState extends State<PostJobScreen> {
  String? selectedCategory;
  String budgetType = "Fixed Price";

  final categories = ["Cleaning", "Delivery", "Development", "Other"];

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(text: "Post a Job"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Browse
            CustomLabelText(title: "Title"),
            TextFormField(
                controller:_titleController ,
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: "What do you need help with",
                )),
            SizedBox(height: 16.h),

            // Category
            CustomLabelText(title: "Category"),
            _dropdownField(
              value: selectedCategory,
              hint: "Select a category",
              options: categories,
              onChanged: (val) => setState(() => selectedCategory = val),
            ),
            SizedBox(height: 16.h),

            // Description
            CustomLabelText(title: "Description"),
            TextFormField(
                controller:_descriptionController ,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "What do you need help with",

                )),
            SizedBox(height: 16.h),
            CustomChooseFile(title: "Photos (Optional)",),
            SizedBox(height: 16.h),

            // Date & Time
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      CustomLabelText(title: "Job Type"),
                      CustomDropdown(
                        items: const [
                          'Onsite',
                          'Remote',
                        ],
                        initialValue: 'Onsite',
                        onChanged: (value) {
                          print('Selected: $value');
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(width: 15.w),
                Expanded(
                  child: Column(
                    children: [
                      CustomLabelText(title: "Time"),
                  CustomDropdown(
                    items: const [
                      'Flexible',
                      'Morning',
                      'Afternoon',
                      'Evening',
                    ],
                    initialValue: 'Flexible',
                    onChanged: (value) {
                      print('Selected: $value');
                    },
                  )
                    ],
                  ),
                ),

                // SizedBox(width: 10.w),

              ],
            ),
            CustomLabelText(title: "Date"),
            _datePickerField(),
            SizedBox(height: 16.h),

            // Location
            CustomLabelText(title: "Location"),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                      controller:_locationController ,
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: "Enter your location",
                      )),
                ),
                SizedBox(width: 10.w),
                InkWell(
                  borderRadius: BorderRadius.circular(12.r),
                  onTap: () {},
                  child: Container(
                    width: 45.w,
                    height: 45.w,
                    decoration: BoxDecoration(
                      color: AllColor.primary, // lime color
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      Icons.location_on_outlined,
                      color: AllColor.borderColor, // purple/gray outline
                      size: 26.sp,
                    ),
                  ),
                )
                  ],
                ),
            SizedBox(height: 16.h),

            // Budget Type
            CustomLabelText(title: "Budget"),
            // Total Amount
            TextFormField(
                controller:_amountController ,
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: "Total amount",
                )),
            SizedBox(height: 30.h),
            const CustomCategoryDropdown(),

            // GlobalGetStartedButton(onTap: () { showSearchLocationBottomBar(context);}, buttonName: "Post a Job", color: AllColor.primary,),
          SizedBox(height: 20.h,)
          ],
        ),
      ),
    );
  }

  /* ================= Reusable Widgets ================= */


  Widget _dropdownField({
    required String? value,
    required String hint,
    required List<String> options,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: AllColor.brand2_light.withOpacity(0.05),
        border: Border.all(color: AllColor.borderColor, width: 1.2),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(
            hint,
            style: TextStyle(fontSize: 13.sp, color: AllColor.grey),
          ),
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down, color: AllColor.black),
          dropdownColor: AllColor.black,
          style: TextStyle(fontSize: 13.sp, color: AllColor.white),
          onChanged: onChanged,
          items: options
              .map(
                (opt) => DropdownMenuItem(
                  value: opt,
                  child: Text(
                    opt,
                    style: TextStyle(fontSize: 13.sp, color: AllColor.white),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _datePickerField() {
    return GestureDetector(
      onTap: () async {
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          setState(() => selectedDate = pickedDate);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        decoration: BoxDecoration(
          border: Border.all(color: AllColor.borderColor, width: 1.2),
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_today, size: 16.sp, color: AllColor.black),
            SizedBox(width: 8.w),
            Text(
              selectedDate == null
                  ? "dd/mm/yyyy"
                  : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
              style: TextStyle(fontSize: 12.sp, color: AllColor.black87),
            ),
          ],
        ),
      ),
    );
  }

  Widget _timePickerField() {
    return GestureDetector(
      onTap: () async {
        final pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (pickedTime != null) {
          setState(() => selectedTime = pickedTime);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        decoration: BoxDecoration(
          border: Border.all(color: AllColor.green, width: 1.2),
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Row(
          children: [
            Icon(Icons.access_time, size: 16.sp, color: AllColor.black),
            SizedBox(width: 8.w),
            Text(
              selectedTime == null ? "Time" : selectedTime!.format(context),
              style: TextStyle(fontSize: 12.sp, color: AllColor.black87),
            ),
          ],
        ),
      ),
    );
  }


}


class CustomDropdown extends StatefulWidget {
  const CustomDropdown({
    super.key,
    required this.items,
    this.initialValue,
    this.onChanged,
    this.hintText = 'Select',
  });

  final List<String> items;
  final String? initialValue;
  final String hintText;
  final ValueChanged<String?>? onChanged;

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue ?? widget.items.first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F7FF), // soft light bg
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AllColor.borderColor.withOpacity(0.8),
          width: 1.2,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          isExpanded: true,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.grey.shade700,
          ),

          // normal dropdown display box — no highlight
          selectedItemBuilder: (context) {
            return widget.items.map((item) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  item,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                ),
              );
            }).toList();
          },

          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(10.r),

          // custom highlight only when menu is open
          items: widget.items.map((item) {
            final bool isSelected = item == selectedValue;
            return DropdownMenuItem<String>(
              value: item,
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected
                      ? AllColor.primary // highlight in menu only
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 4.w),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        item,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w400,
                          fontSize: 14.sp,
                        ),
                      )
                    ),
                    if (isSelected)
                      Icon(
                        Icons.check_rounded,
                        color: Colors.black,
                        size: 18.sp,
                      ),
                  ],
                ),
              ),
            );
          }).toList(),

          onChanged: (value) {
            setState(() => selectedValue = value);
            widget.onChanged?.call(value);
          },
        ),
      ),
    );
  }
}


class CustomCategoryDropdown extends StatefulWidget {
  const CustomCategoryDropdown({super.key});

  @override
  State<CustomCategoryDropdown> createState() =>
      _CustomCategoryDropdownState();
}

class _CustomCategoryDropdownState extends State<CustomCategoryDropdown> {
  String? selectedCategory;
  bool showDropdown = false;

  final categories = [
    "Compliance",
    "Complaince",
    "Specialized Procurement",
    "Rare & Specialized Procurement",
    "Technical & Engineering",
    "Confidential & Sensitive Services",
    "Executive & VIP Services",
    "Custom Projects",
    "Custom",
  ];

  void toggleDropdown() {
    setState(() {
      showDropdown = !showDropdown;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomLabelText(title: "Category"),
        SizedBox(height: 6.h),

        /// Container wrapping dropdown logic
        Stack(
          clipBehavior: Clip.none,
          children: [
            /// Dropdown button
            GestureDetector(
              onTap: toggleDropdown,
              child: Container(
                padding:
                EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border:
                  Border.all(color: AllColor.borderColor, width: 1.2),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        selectedCategory ?? "Select a category",
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: selectedCategory == null
                              ? AllColor.grey
                              : Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down_rounded,
                        color: AllColor.borderColor),
                  ],
                ),
              ),
            ),

            /// Custom dropdown list (below the box)
            if (showDropdown)
              Positioned(
                top: 48.h,
                left: 0,
                right: 0,
                child: Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(6.r),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6.r),
                      border: Border.all(
                        color: AllColor.borderColor.withOpacity(0.4),
                      ),
                    ),
                    constraints: BoxConstraints(maxHeight: 180.h),
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: categories.length,
                      separatorBuilder: (_, __) => Divider(
                        height: 1,
                        color: Colors.grey.shade200,
                      ),
                      itemBuilder: (context, index) {
                        final cat = categories[index];
                        final isSelected = cat == selectedCategory;
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedCategory = cat;
                              showDropdown = false;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 12.w),
                            color: isSelected
                                ? AllColor.borderColor
                                : Colors.transparent,
                            child: Text(
                              cat,
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: isSelected
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
