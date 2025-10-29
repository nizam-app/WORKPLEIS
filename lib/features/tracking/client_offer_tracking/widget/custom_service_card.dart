import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workpleis/core/widget/global_get_started_button.dart';
import 'package:workpleis/features/tracking/client_offer_tracking/offer_tacking_screen1.dart';

import '../../../../core/constants/color_control/all_color.dart';
import '../../../projects/screen/project_screen.dart';
import '../../client_project_tracking/special_request_screen.dart';

class CustomServiceCard extends StatefulWidget {
  final String title;
  final String status;
  final String providerName;
  final int price;
  final String location;
  final String date;
  final String description;
  final int trakingID;
  final VoidCallback? onTap;
  final String? buttonText;

  const CustomServiceCard({
    super.key,
    required this.title,
    required this.status,
    required this.providerName,
    required this.price,
    required this.location,
    required this.date,
    required this.description,
    this.trakingID = 0,
    this.onTap,
    this.buttonText = "Get Started",
  });

  @override
  State<CustomServiceCard> createState() => _CustomServiceCardState();
}

class _CustomServiceCardState extends State<CustomServiceCard> {
  String? checkRole = "client";
  bool reviewDone = false;


                                                                                         


  void checkUserRole()async {
    SharedPreferences _prefs =await SharedPreferences.getInstance();
    String? role = _prefs.getString("role");
    setState(() {
      checkRole = role;
    });
  }

  @override
  void initState() {
    checkUserRole();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AllColor.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AllColor.borderColor.withOpacity(.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
    
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AllColor.black,
                    fontFamily: "headFont"
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AllColor.primary,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  widget.status,
                  style:TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AllColor.black,
                    fontFamily: "OpenText"
                  ),
                ),
              ),
            ],
          ),
          8.verticalSpace,

          Text(
            widget.providerName,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AllColor.brand2_light,
              fontFamily: "OpenText"
            ),
          ),
          8.verticalSpace,

          Row(
            children: [
              Text(
                "\$${widget.price}",
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AllColor.brand2_light,
                    fontFamily: "OpenText"
                ),
              ),
              16.horizontalSpace,
              Icon(Icons.location_on_outlined,
                  size: 14.sp, color: AllColor.brand2_light),
              4.horizontalSpace,
              Expanded(
                child: Text(
                  widget.location,
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AllColor.brand2_light,
                      fontFamily: "OpenText"
                  ),
                ),
              ),
              Text(
                widget.date,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AllColor.brand2_light,
                    fontFamily: "OpenText"
                ),
              ),
            ],
          ),
          12.verticalSpace,
          if (widget.trakingID >= 2)
            ReviewNoticeCard(onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.vertical(top: Radius.circular(20.r)),
                ),
                builder: (_) => const CustomProjectCompletionBottomSheet(check: true,),
              );
            }),
          12.verticalSpace,

          Text(
            widget.description,
            style: TextStyle(
              fontSize: 14.sp,
              color: AllColor.brand2_light,
              height: 1,
              fontWeight: FontWeight.w400,
              fontFamily: "OpenText"
            ),
          ),
          12.verticalSpace,

          if (widget.trakingID == 4)
            reviewDone == false
                ? ReviewForm(
              onSubmit: () {
                setState(() => reviewDone = true);
              },
            )
                : Column(
              children: const [
                ReviewCard(
                  name: "provider name",
                  rating: 4,
                  comment: "nizam is working great. thanks",
                ),
                ReviewCard(
                  name: "You",
                  rating: 5,
                  comment: "great work experience. thanks",
                  isYou: true,
                ),
              ],
            ),
            GlobalGetStartedButton(onTap:widget.onTap ?? (){}, color: AllColor.primary,height: 40,borderRadius: 20.r,textColor: AllColor.black,buttonName: widget.buttonText ??"Get Started",)
        ],
      ),
    );
  }
}