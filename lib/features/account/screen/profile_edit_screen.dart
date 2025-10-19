import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';

import '../../../core/widget/global_app_bar.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});
  static const routeName = '/editProfileScreen';

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: "John Doe");
    final emailController = TextEditingController(text: "jhon@example.com");
    final phoneController = TextEditingController();
    final cityController = TextEditingController(text: "New York");
    final bioController = TextEditingController();

    String country = "United States";

    return Scaffold(
      appBar:GlobalAppbar(text: "Edit Profile"),
      backgroundColor: AllColor.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Photo
            ProfileImagePicker(),  
                 
                  SizedBox(height: 6.h),
                  Center(
                    child: Text(
                      "Tap to change photo",
                      style: TextStyle(fontSize: 12.sp, color: AllColor.black87),
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

            _label("Phone Number"),
            _inputField(controller: phoneController, hint: "Enter phone"),
            SizedBox(height: 14.h),

            // Country + City
            // Row(
            //   children: [
            //     Expanded(
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           _label("Country"),
            //           Container(
            //             padding: EdgeInsets.symmetric(horizontal: 12.w),
            //             decoration: BoxDecoration(
            //               border: Border.all(color: AllColor.borderColor, width: 1.2),
            //               borderRadius: BorderRadius.circular(8.r),
            //             ),
            //             child: DropdownButton<String>(
            //               value: country,
            //               isExpanded: true,
            //               underline: const SizedBox(),
            //               items: const [
            //                 DropdownMenuItem(
            //                     value: "United States",
            //                     child: Text("United States")),
            //                 DropdownMenuItem(
            //                     value: "Canada", child: Text("Canada")),
            //                 DropdownMenuItem(
            //                     value: "UK", child: Text("UK")),
            //               ],
            //               onChanged: (val) {
            //                 // TODO: handle change
            //               },
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     SizedBox(width: 12.w),
            //     Expanded(
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           _label("City"),
            //           _inputField(controller: cityController, hint: "City"),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),

            CountryCityPicker(), 

            SizedBox(height: 14.h),
            LanguageField(), 
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
                  backgroundColor: AllColor.borderColor,
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

class ProfileImagePicker extends StatefulWidget {
  const ProfileImagePicker({super.key});

  @override
  State<ProfileImagePicker> createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          GestureDetector(
            onTap: () {
              // Edit profile
            },
            child: CircleAvatar(
              radius: 45.r,
              backgroundColor: AllColor.grey200,
              backgroundImage:
              _imageFile != null ? FileImage(_imageFile!) : null,
              child: _imageFile == null
                  ? Icon(Icons.person, size: 40.sp, color: AllColor.grey)
                  : null,
            ),
          ),
          Positioned(
            bottom: 2,
            right: 2,
            child: GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 25.h,
                width: 25.h,
                decoration: BoxDecoration(
                  color: AllColor.borderColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.camera_alt, color: Colors.white, size: 18.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class CountryCityPicker extends StatefulWidget {
  const CountryCityPicker({super.key});

  @override
  State<CountryCityPicker> createState() => _CountryCityPickerState();
}

class _CountryCityPickerState extends State<CountryCityPicker> {
  Country? selectedCountry;
  final TextEditingController cityController = TextEditingController();

  // ✅ Country wise cities map
  final Map<String, List<String>> countryCities = {
    "United States": [
      "New York",
      "Los Angeles",
      "Chicago",
      "Houston",
      "San Francisco",
      "Miami",
    ],
    "Canada": [
      "Toronto",
      "Vancouver",
      "Montreal",
      "Calgary",
      "Ottawa",
    ],
    "United Kingdom": [
      "London",
      "Manchester",
      "Birmingham",
      "Liverpool",
      "Leeds",
    ],
    "Bangladesh": [
      "Dhaka",
      "Chittagong",
      "Khulna",
      "Rajshahi",
      "Sylhet",
      "Barishal",
    ],
    "India": [
      "Delhi",
      "Mumbai",
      "Kolkata",
      "Bangalore",
      "Chennai",
      "Hyderabad",
    ],
  };

  void _showCountryPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: false,
      onSelect: (Country country) {
        setState(() {
          selectedCountry = country;
          cityController.clear(); // Reset city when country changes
        });
      },
      countryListTheme: CountryListThemeData(
        flagSize: 25,
        backgroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 16, color: Colors.black87),
        bottomSheetHeight: 500,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
        inputDecoration: InputDecoration(
          labelText: 'Search Country',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AllColor.borderColor),
          ),
        ),
      ),
    );
  }

  Widget _label(String text) => Padding(
    padding: EdgeInsets.only(bottom: 6.h),
    child: Text(
      text,
      style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final List<String> availableCities = selectedCountry != null
        ? (countryCities[selectedCountry!.name] ?? [])
        : [];

    return Row(
      children: [
        /// Country Picker
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label("Country"),
              GestureDetector(
                onTap: _showCountryPicker,
                child: Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: AllColor.borderColor, width: 1.2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      if (selectedCountry != null) ...[
                        Text(selectedCountry!.flagEmoji,
                            style: TextStyle(fontSize: 20.sp)),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            selectedCountry!.name,
                            style: TextStyle(
                                fontSize: 14.sp, color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ] else
                        Text(
                          "Select Country",
                          style: TextStyle(
                              fontSize: 14.sp, color: Colors.grey),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),

        /// City AutoComplete
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label("City"),
              Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<String>.empty();
                  }
                  return availableCities.where((city) => city
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase()));
                },
                onSelected: (String selection) {
                  cityController.text = selection;
                },
                fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                  cityController.text = controller.text;
                  return TextField(
                    controller: controller,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      hintText: "Search City",
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(
                            color: AllColor.borderColor, width: 1.2),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LanguageField extends StatefulWidget {
  const LanguageField({super.key});

  @override
  State<LanguageField> createState() => _LanguageFieldState();
}

class _LanguageFieldState extends State<LanguageField> {
  String selectedLanguage = "English";

  Widget _label(String text) => Padding(
    padding: EdgeInsets.only(bottom: 6.h),
    child: Text(
      text,
      style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Label
    


        SizedBox(height: 12.h),

        /// ✅ Language Dropdown (only name)
        _label("Language"),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            border: Border.all(color: AllColor.borderColor, width: 1.2),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedLanguage,
              isExpanded: true,
              items: const [
                DropdownMenuItem(value: "English", child: Text("English")),
                DropdownMenuItem(value: "বাংলা", child: Text("বাংলা")),
                DropdownMenuItem(value: "हिन्दी", child: Text("हिन्दी")),
                DropdownMenuItem(value: "Français", child: Text("Français")),
                DropdownMenuItem(value: "Arabic", child: Text("Arabic")),
              ],
              onChanged: (val) {
                setState(() => selectedLanguage = val!);
              },
            ),
          ),
        ),
      ],
    );
  }
}