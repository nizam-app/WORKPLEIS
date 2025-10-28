import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_get_started_button.dart';

import '../../../core/widget/global_app_bar.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  static const routeName = '/editProfileScreen';

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}
String? user_role ="client";

class _EditProfileScreenState extends State<EditProfileScreen> {
  Future<String?> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    String? role = prefs.getString('role');
    setState(() {
   role =  user_role = role ;
    });
    return   role ;
  }
  @override
  void initState() {
    // TODO: implement initState
    getUserRole();

    super.initState();
  }
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
                      style: TextStyle(fontSize: 12.sp, color: AllColor.black,fontFamily: "OpenText", fontWeight: FontWeight.w400),
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

            // Bio
            _label("Bio"),
            _inputField(
                controller: bioController,
                hint: "Write something about yourself...",
                maxLines: 2),
            SizedBox(height: 14.h),
         if(user_role == "provider")   TagInputField(
              title: "Skills",
              options: ["Web Development", "UI/UX Design", "Mobile App Design"],
            ),
            24.verticalSpace,
            TagInputField(
              title: "Language",
              options: ["English", "Bengli", "বাংলা", "Français", "Arabic"],
            ),
            SizedBox(height: 30.h),

            // Save Changes
            GlobalGetStartedButton(onTap: () {context.pop();},color: AllColor.primary, buttonName: "Save Changes",textColor:AllColor.borderColor)
            // SizedBox(
            //   width: double.infinity,
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom
            //       backgroundColor: AllColor.primary,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(8.r),
            //       ),
            //       padding: EdgeInsets.symmetric(vertical: 14.h),
            //     ),
            //     onPressed: () {
            //       // TODO: save changes logic
            //     },
            //     child: Text(
            //       "Save Changes",
            //       style: TextStyle(
            //           color: AllColor.borderColor,
            //           fontSize: 14.sp,
            //           fontWeight: FontWeight.w600),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: AllColor.black,
          fontFamily: "headFont"
        ),
      ),
    );
  }

  Widget _inputField(
      {required TextEditingController controller,
        required String hint,

        int maxLines = 1,

      }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: TextStyle(color:AllColor.black,fontWeight: FontWeight.w400, fontFamily: "OpenText", fontSize: 12.sp),
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
              radius: 30.r,
              backgroundColor: AllColor.grey300,
              backgroundImage:
              _imageFile != null ? FileImage(_imageFile!) : null,
              child: _imageFile == null
                  ? Icon(Icons.person, size: 40.sp, color: AllColor.white)
                  : null,
            ),
          ),
          Positioned(
            bottom: 2,
            right: 2,
            child: GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 15.h,
                width: 15.h,
                padding: EdgeInsets.all(2.r),
                decoration: BoxDecoration(
                  color: AllColor.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.camera_alt_outlined, color: AllColor.black, size: 12.sp),
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
      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400,fontFamily: "headFont", color: AllColor.black),
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
                  EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: AllColor.borderColor, width: 1.2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      if (selectedCountry != null) ...[
                        Text(selectedCountry!.flagEmoji,
                            style: TextStyle(fontSize: 20.sp, fontFamily: "OpenText", fontWeight: FontWeight.w400, color: AllColor.black)),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            selectedCountry!.name,
                            style: TextStyle(
                                fontSize: 14.sp, color: AllColor.black, fontFamily: "OpenText", fontWeight: FontWeight.w400 ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ] else
                        Text(
                          "Select Country",
                          style: TextStyle(
                              fontSize: 14.sp, color: Colors.grey, fontWeight: FontWeight.w400, fontFamily: "OpenText"),
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

class TagInputField extends StatefulWidget {
  final String title;
  final List<String> options;

  const TagInputField({
    super.key,
    required this.title,
    required this.options,
  });

  @override
  State<TagInputField> createState() => _TagInputFieldState();
}

class _TagInputFieldState extends State<TagInputField> {
  late String _dropdownValue;
  final List<String> _selectedItems = [];

  @override
  void initState() {
    super.initState();
    _dropdownValue = widget.options.first;
  }

  void _addItem() {
    if (!_selectedItems.contains(_dropdownValue)) {
      setState(() => _selectedItems.add(_dropdownValue));
    }
  }

  void _removeItem(String value) {
    setState(() => _selectedItems.remove(value));
  }

  Widget _tag(String label) {
    return Container(
      margin: EdgeInsets.only(right: 8.w, bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AllColor.grey200.withOpacity(0.6),
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: TextStyle(fontSize: 12.sp, fontFamily: "OpenText", fontWeight: FontWeight.w400, color: AllColor.black)),
          6.horizontalSpace,
          GestureDetector(
            onTap: () => _removeItem(label),
            child: Icon(Icons.close, size: 14.sp),
          ),
        ],
      ),
    );
  }

  Widget _label(String text) => Padding(
    padding: EdgeInsets.only(bottom: 6.h),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        fontFamily: "OpenText",
        color:AllColor.black,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(widget.title),

        Row(
          children: [
            /// Dropdown
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  color: AllColor.grey100,
                  border: Border.all(color: AllColor.borderColor, width: 1.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _dropdownValue,
                    isExpanded: true,
                    icon: Icon(Icons.arrow_drop_down),
                    items: widget.options.map((opt) {
                      return DropdownMenuItem(
                        value: opt,
                        child: Text(opt),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => _dropdownValue = val);
                      }
                    },
                  ),
                ),
              ),
            ),

            12.horizontalSpace,

            /// Add Button
            ElevatedButton(
              onPressed: _addItem,
              style: ElevatedButton.styleFrom(
                backgroundColor: AllColor.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
                elevation: 0,
              ),
              child: Text(
                "Add",
                style:TextStyle(
                  fontWeight: FontWeight.w400,
                  color: AllColor. borderColor,
                  fontSize: 14.sp,
                  fontFamily: "OpenText"
                ),
              ),
            ),
          ],
        ),

        12.verticalSpace,

        Wrap(
          children: _selectedItems.map((val) => _tag(val)).toList(),
        ),
      ],
    );
  }
}