import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_aleart_box.dart';
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
            SizedBox(height: 16.h),
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
                  onTap: () { showSearchLocationBottomBar(context);},
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
            GlobalGetStartedButton(onTap: () {globalShowAlertDialog(context: context, oneTap: (){
             Navigator.pop(context); 
            },message:"Post create success" );}, buttonName: "Post a Job", color: AllColor.bgcolor,),
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
            style: TextStyle(fontSize: 13.sp, color: AllColor.borderColor),
          ),
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down, color: AllColor.black),
          dropdownColor: AllColor.white,
          style: TextStyle(fontSize: 13.sp, color: AllColor.black),
          onChanged: onChanged,
          items: options
              .map(
                (opt) => DropdownMenuItem(
                  value: opt,
                  child: Text(
                    opt,
                    style: TextStyle(fontSize: 13.sp, color: AllColor.black),
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



Future<void> showSearchLocationBottomBar(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (_) => const SearchLocationBottomBar(),
  );
}

class SearchLocationBottomBar extends StatefulWidget {
  const SearchLocationBottomBar({super.key});

  @override
  State<SearchLocationBottomBar> createState() =>
      _SearchLocationBottomBarState();
}

class _SearchLocationBottomBarState extends State<SearchLocationBottomBar> {
  final TextEditingController _controller = TextEditingController();

  final List<String> allLocations = [
    "Banasree, Dhaka",
    "Feni, Bangladesh",
    "Chittagong, Bangladesh",
    "Gulshan, Dhaka",
    "Mirpur, Dhaka",
    "Sylhet, Bangladesh",
    "Rajshahi, Bangladesh",
  ];

  List<String> filteredLocations = [];
  bool showDropdown = false;

  void _onSearchChanged(String query) {
    if (query.isEmpty) {
      setState(() {
        showDropdown = false;
        filteredLocations = [];
      });
      return;
    }

    final results = allLocations
        .where((loc) => loc.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      filteredLocations = results;
      showDropdown = results.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 20.h,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          /// 🔹 Main Column (title, search, map)
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              Text(
                "Search the location",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10.h),

              /// Search Field
              TextField(
                controller: _controller,
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  hintText: "Enter your location",
                  prefixIcon:
                  const Icon(Icons.search_rounded, color: Colors.grey),
                  hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: AllColor.borderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide:
                    BorderSide(color: AllColor.borderColor, width: 1.4),
                  ),
                ),
              ),

              SizedBox(height: 60.h),

              /// Map Placeholder (Always visible)
              Container(
                width: double.infinity,
                height: 220.h,
                decoration: BoxDecoration(
                  color: AllColor.primary.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Center(
                  child: Text(
                    "Map preview placeholder",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
            ],
          ),

          /// 🔹 Floating Dropdown (on top of map)
          if (showDropdown)
            Positioned(
              top: 90.h,
              left: 0,
              right: 0,
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(10.r),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: AllColor.borderColor.withOpacity(0.4),
                    ),
                  ),
                  constraints: BoxConstraints(maxHeight: 150.h),
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: filteredLocations.length,
                    separatorBuilder: (_, __) => Divider(
                      height: 1,
                      color: Colors.grey.shade200,
                    ),
                    itemBuilder: (context, index) {
                      final location = filteredLocations[index];
                      return ListTile(
                        dense: true,
                        title: Text(
                          location,
                          style: TextStyle(
                              fontSize: 14.sp, color: Colors.black87),
                        ),
                        onTap: () {
                          _controller.text = location;
                          setState(() {
                            showDropdown = false;
                          });
                          Navigator.pop(context, location);
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}