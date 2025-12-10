import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/features/role_screen/screen/seclect_type_screen.dart';

enum UserRole { client, provider }

class SeclectRoleScreen extends StatefulWidget {
  const SeclectRoleScreen({super.key});

  static const String routeName = '/role_selection';

  @override
  State<SeclectRoleScreen> createState() => _SeclectRoleScreenState();
}

class _SeclectRoleScreenState extends State<SeclectRoleScreen> {
  UserRole? _selected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // top logo
                      Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: Image.asset(
                          'assets/images/splashlogo.png',
                          height: 47.h,
                        ),
                      ),

                      SizedBox(height: 36.h),

                      // center icon
                      Center(
                        child: Image.asset(
                          'assets/images/roleicon.png',
                          height: 115.h,
                        ),
                      ),

                      SizedBox(height: 32.h),

                      Center(
                        child: Text(
                          'Select your role',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 40.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'sf_Pro',
                            color: Colors.black,
                          ),
                        ),
                      ),

                      SizedBox(height: 8.h),

                      Center(
                        child: Text(
                          'A  Sustainable Marketplace For\nBusinesses',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'sf_Pro',
                            color: Colors.black.withOpacity(0.6),
                            height: 1.3,
                          ),
                        ),
                      ),

                      SizedBox(height: 32.h),

                      _RoleCard(
                        label: "I'm a Client",
                        selected: _selected == UserRole.client,
                        onTap: () {
                          setState(() => _selected = UserRole.client);
                        },
                      ),

                      SizedBox(height: 16.h),

                      _RoleCard(
                        label: "I'm Service Provider",
                        selected: _selected == UserRole.provider,
                        onTap: () {
                          setState(() => _selected = UserRole.provider);
                        },
                      ),

                      SizedBox(height: 32.h),

                      // button
                      SizedBox(
                        width: double.infinity,
                        height: 56.h,
                        child: ElevatedButton(
                          onPressed: _selected == null
                              ? null
                              : () => context.push(SeclectTypeScreen.routeName),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF03051A),
                            disabledBackgroundColor:
                            const Color(0xFF03051A).withOpacity(0.3),
                            shape: StadiumBorder(
                              side: BorderSide(
                                color: const Color(0xFF03051A),
                                width: 1.2.w,
                              ),
                            ),
                            elevation: 0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Next',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'sf_Pro',
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16.sp,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 16.h),

                      Center(
                        child: TextButton(
                          onPressed: () =>
                              context.push(SeclectTypeScreen.routeName),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.black,
                          ),
                          child: Text(
                            'Skip',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontFamily: 'sf_Pro',
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


/// ROLE CARD
class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderColor =
    selected ? Colors.black : Colors.black.withOpacity(0.18);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: borderColor, width: 1.2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: 'sf_Pro',
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),

            // circle check
            Container(
              height: 22.r,
              width: 22.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected
                      ? Colors.black
                      : Colors.black.withOpacity(0.25),
                  width: 1.4,
                ),
                color: selected ? Colors.black : Colors.transparent,
              ),
              child: selected
                  ? Icon(Icons.check, size: 16.sp, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
