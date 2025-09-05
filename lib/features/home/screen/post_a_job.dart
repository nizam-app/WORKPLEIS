import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_app_bar.dart';
import 'package:workpleis/core/widget/global_bottom.dart';

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

  final browseController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();
  final amountController = TextEditingController();

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
            _label("Browse"),
            _inputField(browseController, hint: "What do you need help with?"),
            SizedBox(height: 16.h),

            // Category
            _label("Category"),
            _dropdownField(
              value: selectedCategory,
              hint: "Select a category",
              options: categories,
              onChanged: (val) => setState(() => selectedCategory = val),
            ),
            SizedBox(height: 16.h),

            // Description
            _label("Description"),
            _inputField(descriptionController,
                hint: "please provide as much detail as possible...",
                maxLines: 4),
            SizedBox(height: 16.h),

            // Photos Upload
            _label("Photos (Optional)"),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                border: Border.all(color: AllColor.grey300, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                children: [
                  Icon(Icons.upload_file, size: 28.sp, color: AllColor.grey),
                  SizedBox(height: 8.h),
                  Text(
                    "Choose files or drag and drop\nAny file type accepted",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11.sp, color: AllColor.grey),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),

            // Date & Time
            Row(
              children: [
                Expanded(
                  child: _datePickerField(),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: _timePickerField(),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // Location
            _label("Location"),
            _inputField(locationController, hint: "Enter your location"),
            SizedBox(height: 16.h),

            // Budget Type
            _label("Budget"),
            Row(
              children: [
                _budgetOption("Fixed Price"),
                SizedBox(width: 10.w),
                _budgetOption("Hourly Rate"),
              ],
            ),
            SizedBox(height: 16.h),

            // Total Amount
            _inputField(amountController, hint: "Total amount (\$)"),
            SizedBox(height: 30.h),

            // Post Job Button
           GlobalButton(text: "Post Job", onPressed: (){})
          ],
        ),
      ),
    );
  }

  /* ================= Reusable Widgets ================= */

  Widget _label(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
          color: AllColor.black,
        ),
      ),
    );
  }

  Widget _inputField(TextEditingController controller,
      {required String hint, int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(fontSize: 12.sp, color: AllColor.grey),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AllColor.green, width: 1.2),
          borderRadius: BorderRadius.circular(6.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AllColor.green, width: 1.5),
          borderRadius: BorderRadius.circular(6.r),
        ),
      ),
    );
  }

  Widget _dropdownField({
    required String? value,
    required String hint,
    required List<String> options,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        border: Border.all(color: AllColor.green, width: 1.2),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(hint,
              style: TextStyle(fontSize: 13.sp, color: AllColor.grey)),
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down, color: AllColor.black),
          dropdownColor: AllColor.black,
          style: TextStyle(fontSize: 13.sp, color: AllColor.white),
          onChanged: onChanged,
          items: options
              .map((opt) => DropdownMenuItem(
            value: opt,
            child: Text(opt,
                style: TextStyle(fontSize: 13.sp, color: AllColor.white)),
          ))
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
          border: Border.all(color: AllColor.green, width: 1.2),
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
              selectedTime == null
                  ? "Time"
                  : selectedTime!.format(context),
              style: TextStyle(fontSize: 12.sp, color: AllColor.black87),
            ),
          ],
        ),
      ),
    );
  }

  Widget _budgetOption(String type) {
    final isSelected = budgetType == type;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => budgetType = type),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected ? AllColor.green.withOpacity(0.2) : AllColor.white,
            border: Border.all(
                color: isSelected ? AllColor.green : AllColor.grey300),
            borderRadius: BorderRadius.circular(6.r),
          ),
          alignment: Alignment.center,
          child: Text(
            type,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: isSelected ? AllColor.black : AllColor.grey,
            ),
          ),
        ),
      ),
    );
  }
}
