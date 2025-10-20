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
                  style: theme.titleSmall?.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AllColor.black,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AllColor.brand2_light,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  widget.status,
                  style: theme.titleMedium?.copyWith(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: AllColor.white,
                  ),
                ),
              ),
            ],
          ),
          8.verticalSpace,

          Text(
            widget.providerName,
            style: theme.titleMedium?.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AllColor.black.withOpacity(.7),
            ),
          ),
          8.verticalSpace,

          Row(
            children: [
              Text(
                "\$${widget.price}",
                style: theme.titleSmall?.copyWith(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: AllColor.black,
                ),
              ),
              16.horizontalSpace,
              Icon(Icons.location_on_outlined,
                  size: 14.sp, color: AllColor.black.withOpacity(.6)),
              4.horizontalSpace,
              Expanded(
                child: Text(
                  widget.location,
                  style: theme.titleMedium?.copyWith(
                    fontSize: 12.sp,
                    color: AllColor.black.withOpacity(.6),
                  ),
                ),
              ),
              Text(
                widget.date,
                style: theme.titleMedium?.copyWith(
                  fontSize: 12.sp,
                  color: AllColor.black.withOpacity(.6),
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
            style: theme.bodyMedium?.copyWith(
              fontSize: 13.sp,
              color: AllColor.black87,
              height: 1.3,
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
            GlobalGetStartedButton(onTap:widget.onTap ?? (){}, color: AllColor.brand2_light,height: 40,borderRadius: 20.r,textColor: AllColor.white,buttonName: widget.buttonText ??"Get Started",)
        ],
      ),
    );
  }
}