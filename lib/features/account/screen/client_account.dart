import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workpleis/features/Payment/screen/payment_methods_screen.dart';
import 'package:workpleis/features/account/screen/profile_edit_screen.dart';
import 'package:workpleis/features/account/widget/custom_buttom.dart';
import 'package:workpleis/features/auth/screens/login_screen.dart';
import 'package:workpleis/features/jobs/screen/service_my_offers.dart';
import 'package:workpleis/features/jobs/screen/jobs_screen.dart';
import 'package:workpleis/features/security/screen/settings_screen.dart';
import 'package:workpleis/features/wallet/screen/service_wallet_screen.dart';
import 'package:workpleis/features/wallet/screen/wallet_screen.dart';
import '../../../core/constants/color_control/all_color.dart';
import '../../../core/widget/global_app_bar.dart';
import '../../security/screen/security_guide_screen.dart';

class AccountOverviewClientScreen extends StatefulWidget {
  const AccountOverviewClientScreen({super.key});
  static const routeName = '/accountOverviewClientScreen';

  @override
  State<AccountOverviewClientScreen> createState() =>
      _AccountOverviewClientScreenState();
}

class _AccountOverviewClientScreenState
    extends State<AccountOverviewClientScreen> {
  bool isLoading = true;

  // Simulated API Data
  Map<String, dynamic> profileData = {};
  Map<String, dynamic> stats = {};
  String memberSince = "";
  String? userRole = "";
  @override
  void initState() {
    super.initState();
    _fetchData();
    getUserRole();
  }


  Future<void> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    final role = prefs.getString('role');
    setState(() {
      userRole = role;
    });
  }
  Future<void> _fetchData() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      profileData = {
        "name": "Jhon Doe",
        "email": "jhon@example.com",
        "avatar": "https://i.pravatar.cc/150?img=5",
        "verified": true
      };
      stats = {
        "posted": 28,
        "pending": 10,
        "rating": 4.8,
        "spent": 1000,
      };
      memberSince = "March 2023";
      isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(text: "Account"),
   
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _profileSection(),
            SizedBox(height: 20.h),
            _accountOverviewSection(),
            SizedBox(height: 20.h),
            _paymentMethodSection(context),
            SizedBox(height: 20.h),
            if (userRole == "client")  _specialProjectsSection(context),
            SizedBox(height: 20.h),
            InkWell(
              onTap: (){
                if(userRole == "client"){
                    context.push(WalletScreen.routeName);}
                else{
                  context.push(ProviderWalletScreen.routeName);
                }
              },
                child: _menuTile(Icons.account_balance_wallet_outlined, "Wallet")),
            InkWell(
                onTap: (){
                  userRole == "client" ?
                  context.push(JobsScreen.routeName): context.push(JobsOffers.routeName);
                },
                child: _menuTile(Icons.work_outline, userRole == "client" ?"Jobs": "Offers")),
            InkWell(
                onTap: (){
                  context.push(SettingsScreen.routeName);
                },
                child: _menuTile(Icons.settings_outlined, "Settings")),
            InkWell(
                onTap: (){
                  context.push(SecurityGuideScreen.routeName);
                },
                child: _menuTile(Icons.help_outline, "Help & Support")),
            SizedBox(height: 30.h),
            Text(
              "Member since $memberSince",
              style: TextStyle(color: Colors.grey, fontSize: 12.sp, fontFamily: "OpenText", fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 10.h),
            _signOutButton(),
          ],
        ),
      ),
    );
  }

  /// ---------------- PROFILE ----------------
  Widget _profileSection() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AllColor.brand2_light, width: 1),
        boxShadow: [
          BoxShadow(
              color: AllColor.black, blurRadius: 5, offset: const Offset(0, 2))
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage(profileData["avatar"]),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(profileData["name"],
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w800, fontFamily: "headFont", color: AllColor.brand2_light)),
                    SizedBox(width: 6.w),
                    
                  ],
                ),
                SizedBox(height: 4.h),
                Text(profileData["email"],
                    style: TextStyle(color: AllColor.grey, fontSize: 14.sp, fontFamily: "OpenText", fontWeight: FontWeight.w400)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (profileData["verified"])
                   Text("Verified",
                      style: TextStyle(
                          color: AllColor.brand2_light,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400, fontFamily: "OpenText",)),

              SizedBox(height: 10.h,),
                
              InkWell(
                onTap: (){
                  context.push(EditProfileScreen.routeName) ;
                }
                ,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: AllColor.white,
                    borderRadius: BorderRadius.circular(10.r),

                   // border: Border.all(color: AllColor.grey, width: 1 ),
                  ),
                  child:  Text("Edit",
                      style: TextStyle(color: AllColor.brand2_light, fontSize: 12.sp,  fontWeight: FontWeight.w400, fontFamily: "OpenText")),
                ),
              )
            ],
          )
          
        ],
      ),
    );
  }

  /// ---------------- ACCOUNT OVERVIEW ----------------
  Widget _accountOverviewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Account Overview",
            style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 16.sp,
                color: Colors.black,
              fontFamily: "headFont",

            )),
        SizedBox(height: 10.h),
        Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          alignment: WrapAlignment.center,
          children: [
            _infoBox(Icons.work_outline, "${stats["posted"]}", "Posted Jobs",
                AllColor.white, AllColor.brand2_light),
            _infoBox(Icons.pending_actions_outlined, "${stats["pending"]}",
                "Pending Jobs", AllColor.white, AllColor.brand2_light),
            _infoBox(Icons.star_border, "${stats["rating"]}", "Rating",
                AllColor.white, AllColor.brand2_light),
            _infoBox(Icons.attach_money, "\$${stats["spent"]}", "Total Spent",
                AllColor.white, AllColor.brand2_light),
          ],
        ),
      ],
    );
  }

  /// 🔹 Background color added here
  Widget _infoBox(
      IconData icon, String value, String label, Color bgColor, Color borderColor) {
    return Container(
      width: 160.w,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: bgColor.withOpacity(0.5), // ✅ Light background tint
        border: Border.all(color: borderColor, width: 1.2),  // same border color
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(icon, color: AllColor.brand2_light, size: 18.sp, ),
            SizedBox(width: 6.w),
            Text(value,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AllColor.brand2_light, fontFamily: "OpenText")),
          ]),
          SizedBox(height: 4.h),
          Text(label,
              style: TextStyle(fontSize: 14.sp, color: AllColor.brand2_light, fontFamily: "OpenText", fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }
  //
  // /// ---------------- PAYMENT METHOD ----------------
  // Widget _paymentMethodSection() {
  //   return Container(
  //     width: double.infinity,
  //     padding: EdgeInsets.all(14.w),
  //     decoration: BoxDecoration(
  //       gradient: const LinearGradient(
  //         colors: [AllColor.white, AllColor.grey],
  //         begin: Alignment.topLeft,
  //         end: Alignment.bottomRight,
  //       ),
  //       borderRadius: BorderRadius.circular(10.r),
  //       border: Border.all(color:AllColor.brand2_light, width: 1)
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(children: [
  //           const Icon(Icons.credit_card, color: Colors.black),
  //           SizedBox(width: 10.w),
  //           Expanded(
  //             child: Text("Add Payment Method",
  //                 style: TextStyle(
  //                     fontSize: 16.sp,
  //                     fontWeight: FontWeight.w800,
  //                     color: Colors.black,
  //                   fontFamily: "headFont", )
  //             ),
  //           ),
  //         ]),
  //         SizedBox(height: 5.h),
  //          Text(
  //           "Securely save your wallet for faster checkout.",
  //           style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: AllColor.black, fontFamily: "OpenText"),
  //         ),
  //         SizedBox(height: 10.h),
  //         CustomButtom(onTap:(){
  //                            context.push(PaymentMethodsScreen.routeName);
  //         },text: "Add Payment", icon: Icons.credit_card, color: AllColor.primary)
  //
  //       ],
  //     ),
  //   );
  // }
  //
  // /// ---------------- SPECIAL PROJECTS ----------------
  // Widget _specialProjectsSection() {
  //   return Container(
  //     width: double.infinity,
  //     padding: EdgeInsets.all(14.w),
  //     decoration: BoxDecoration(
  //       gradient: const LinearGradient(
  //         colors: [AllColor.white, AllColor.grey],
  //         begin: Alignment.topLeft,
  //         end: Alignment.bottomRight,
  //       ),
  //       borderRadius: BorderRadius.circular(10.r),
  //         border: Border.all(color:AllColor.borderColor, width: 1)
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(children: [
  //           const Icon(Icons.assignment, color: AllColor.black),
  //           SizedBox(width: 10.w),
  //           Expanded(
  //             child: Text("Track Your Special Projects",
  //                 style: TextStyle(
  //                     fontSize: 16.sp,
  //                     fontWeight: FontWeight.w800,
  //                     color: Colors.black,
  //                   fontFamily: "headFont",
  //
  //                 )),
  //           ),
  //         ]),
  //         SizedBox(height: 5.h),
  //          Text(
  //           "Monitor the progress of your confidential high-stakes projects.",
  //           style: TextStyle( fontWeight: FontWeight.w400, fontSize: 12.sp, color: AllColor.black, fontFamily: "OpenText"),
  //         ),
  //         SizedBox(height: 10.h),
  //         CustomButtom(
  //             onTap: (){
  //
  //             },
  //             text: "Track Special Project", icon: Icons.fingerprint, color: AllColor.primary, )
  //
  //       ],
  //     ),
  //   );
  // }


  /// ---------------- MENU ----------------
  Widget _menuTile(IconData icon, String title) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
      decoration: BoxDecoration(
        border: Border.all(color: AllColor.grey300, width: 1),
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Icon(icon, color: AllColor.black, size: 22.sp),
          SizedBox(width: 10.w),
          Expanded(
              child: Text(title,
                  style: TextStyle(fontSize: 18.sp, color: AllColor.black, fontWeight: FontWeight.w800, fontFamily: "headFont"))),
           Icon(Icons.arrow_forward_ios, color: AllColor.grey, size: 18.sp),
        ],
      ),
    );
  }

  /// ---------------- SIGN OUT ----------------
  Widget _signOutButton() {
    return CustomButtom(
      onTap: (){
        context.push(LoginScreen.routeName);
      },
        icon: Icons.logout, text: "Sign out", color: AllColor.primary, textColor: AllColor.black,);
  }
}



/// ---------------- PAYMENT METHOD ----------------
Widget _paymentMethodSection(BuildContext context) {
  return CustomSectionCard(
    icon: Icons.credit_card,
    title: "Add Payment Method",
    description: "Securely save your wallet for faster checkout.",
    buttonText: "Add Payment",
    buttonIcon: Icons.credit_card,
    onTap: () => context.push(PaymentMethodsScreen.routeName),
    borderColor: AllColor.brand2_light,
  );
}

/// ---------------- SPECIAL PROJECTS ----------------
Widget _specialProjectsSection(BuildContext context) {
  return CustomSectionCard(
    icon: Icons.assignment,
    title: "Track Your Special Projects",
    description:
    "Monitor the progress of your confidential high-stakes projects.",
    buttonText: "Track Special Project",
    buttonIcon: Icons.fingerprint,
    onTap: () {
      // handle navigation or action
    },
    borderColor: AllColor.borderColor,
  );
}


class CustomSectionCard extends StatelessWidget {
  const CustomSectionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.buttonIcon,
    required this.onTap,
    this.borderColor = AllColor.borderColor,
    this.gradientColors = const [AllColor.white, AllColor.grey],
  });

  final IconData icon;
  final String title;
  final String description;
  final String buttonText;
  final IconData buttonIcon;
  final VoidCallback onTap;
  final List<Color> gradientColors;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AllColor.black),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                    fontFamily: "headFont",
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          Text(
            description,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: AllColor.black,
              fontFamily: "OpenText",
            ),
          ),
          SizedBox(height: 10.h),
          CustomButtom(
            onTap: onTap,
            text: buttonText,
            icon: buttonIcon,
            color: AllColor.primary,
          ),
        ],
      ),
    );
  }
}
