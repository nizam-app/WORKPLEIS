import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: "John Doe");
    final emailController = TextEditingController(text: "jhon@example.com");
    final phoneController = TextEditingController();
    final cityController = TextEditingController(text: "New York");
    final bioController = TextEditingController();

    String country = "United States";

    return Scaffold(
      backgroundColor: AllColor.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Photo
            GestureDetector(
              onTap: () {
                // TODO: add image picker
              },
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40.r,
                    backgroundColor: AllColor.grey200,
                    child: Icon(Icons.person,
                        size: 40.sp, color: AllColor.grey),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    "Tap to change photo",
                    style: TextStyle(fontSize: 12.sp, color: AllColor.black87),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            // Full Name
            _label("Full Name"),
            _inputField(controller: nameController, hint: "John Doe"),
            SizedBox(height: 14.h),

            // Email
            _label("Email"),
            _inputField(controller: emailController, hint: "example@mail.com"),
            SizedBox(height: 14.h),

            // Phone Number
            _label("Phone Number"),
            _inputField(controller: phoneController, hint: "Enter phone"),
            SizedBox(height: 14.h),

            // Country + City
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _label("Country"),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        decoration: BoxDecoration(
                          border: Border.all(color: AllColor.borderColor, width: 1.2),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: DropdownButton<String>(
                          value: country,
                          isExpanded: true,
                          underline: const SizedBox(),
                          items: const [
                            DropdownMenuItem(
                                value: "United States",
                                child: Text("United States")),
                            DropdownMenuItem(
                                value: "Canada", child: Text("Canada")),
                            DropdownMenuItem(
                                value: "UK", child: Text("UK")),
                          ],
                          onChanged: (val) {
                            // TODO: handle change
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _label("City"),
                      _inputField(controller: cityController, hint: "City"),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.h),

            // Bio
            _label("Bio"),
            _inputField(
                controller: bioController,
                hint: "Write something about yourself...",
                maxLines: 3),
            SizedBox(height: 30.h),

            // Save Changes
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AllColor.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                ),
                onPressed: () {
                  // TODO: save changes logic
                },
                child: Text(
                  "Save Changes",
                  style: TextStyle(
                      color: AllColor.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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

  Widget _inputField(
      {required TextEditingController controller,
        required String hint,
        int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(fontSize: 12.sp, color: AllColor.grey),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AllColor.borderColor, width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AllColor.borderColor, width: 1.5),
        ),
      ),
    );
  }
}
