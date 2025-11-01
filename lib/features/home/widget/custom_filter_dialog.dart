//
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:workpleis/core/constants/color_control/all_color.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// final filterProvider = StateNotifierProvider<FilterNotifier, FilterState>(
//       (ref) => FilterNotifier(),
// );
//
// class FilterState {
//   final String? category;
//   final String jobType;
//   final String location;
//   final double distance;
//   final double budget;
//
//   const FilterState({
//     this.category,
//     this.jobType = 'Onsite',
//     this.location = '',
//     this.distance = 50,
//     this.budget = 150,
//   });
//
//   FilterState copyWith({
//     String? category,
//     String? jobType,
//     String? location,
//     double? distance,
//     double? budget,
//   }) {
//     return FilterState(
//       category: category ?? this.category,
//       jobType: jobType ?? this.jobType,
//       location: location ?? this.location,
//       distance: distance ?? this.distance,
//       budget: budget ?? this.budget,
//     );
//   }
//
//   static const initial = FilterState();
// }
//
// class FilterNotifier extends StateNotifier<FilterState> {
//   FilterNotifier() : super(FilterState.initial);
//
//   void updateCategory(String? value) => state = state.copyWith(category: value);
//   void updateJobType(String value) => state = state.copyWith(jobType: value);
//   void updateLocation(String value) => state = state.copyWith(location: value);
//   void updateDistance(double value) => state = state.copyWith(distance: value);
//   void updateBudget(double value) => state = state.copyWith(budget: value);
//   void reset() => state = FilterState.initial;
// }
//
// class FilterJobsBottomSheet extends ConsumerWidget {
//   const FilterJobsBottomSheet({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final state = ref.watch(filterProvider);
//     final notifier = ref.read(filterProvider.notifier);
//
//     final theme = Theme.of(context).textTheme;
//
//     return Padding(
//       padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w,
//           16.h + MediaQuery.of(context).viewInsets.bottom),
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             /// Header
//             Row(
//               children: [
//                 Text("Filter Jobs",
//                     style: TextStyle(fontSize: 16.sp, fontWeight:FontWeight.w800, fontFamily: "headFont", color: AllColor.black)),
//                 const Spacer(),
//                 IconButton(
//                   icon:  Icon(Icons.close, color: AllColor.black,size: 30.sp,),
//                   onPressed: () => Navigator.pop(context),
//                 ),
//               ],
//             ),
//
//             12.verticalSpace,
//
//             /// Category Dropdown
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Text("Categories",
//                   style: TextStyle (fontSize: 16.sp, fontWeight: FontWeight.w800, fontFamily: "headFont", color: AllColor.black)),
//             ),
//             6.verticalSpace,
//             Container(
//               // padding: EdgeInsets.symmetric(horizontal: 12.w),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8.r),
//                 //border: Border.all(color: AllColor.grey),
//               ),
//               child: DropdownButtonFormField<String>(
//                 value: state.category,
//                 isExpanded: true,
//                 hint: const Text("Select categories", style: TextStyle(color: AllColor.black87),),
//                 decoration: const InputDecoration(border: InputBorder.none),
//                 items: ["Design", "Development", "Marketing"]
//                     .map((e) => DropdownMenuItem(value: e, child: Text(e, style: TextStyle(color: Colors.black),)))
//                     .toList(),
//                 iconEnabledColor: AllColor.brand2_light, // <- your color here
//                 iconDisabledColor: AllColor.grey,        // <- optional
//                 onChanged: notifier.updateCategory,
//               ),
//             ),
//
//             16.verticalSpace,
//
//             /// Job Type Segment
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Text("To be done",
//                   style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w800, fontFamily: "headFont",color: AllColor.black )),
//             ),
//             8.verticalSpace,
//             Row(
//               children: [
//                 _pillButton(ref, "Onsite", state.jobType),
//                 8.horizontalSpace,
//                 _pillButton(ref, "Remote", state.jobType),
//                 8.horizontalSpace,
//                 _pillButton(ref, "All", state.jobType),
//               ],
//             ),
//
//             16.verticalSpace,
//
//             /// Location
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Text("Location",
//                   style:
//                   TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w800, fontFamily: "headFont", color: AllColor.black)),
//             ),
//             6.verticalSpace,
//             TextFormField(
//               initialValue: state.location,
//               onChanged: notifier.updateLocation,
//               decoration: InputDecoration(
//                 hintText: "Mckinnery tx 75071, USA",
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.r)),
//                 contentPadding:
//                 EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
//               ),
//             ),
//
//             16.verticalSpace,
//
//             /// Distance
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("Distance", style: TextStyle(fontSize: 16.sp, fontFamily: "headFont", fontWeight: FontWeight.w800, color: AllColor.black)),
//                 Text("${state.distance.toInt()} mi",
//                     style: TextStyle(fontSize: 14.sp)),
//               ],
//             ),
//             Slider(
//               value: state.distance,
//               min: 0,
//               max: 100,
//               onChanged: notifier.updateDistance,
//               activeColor: AllColor.primary,
//               inactiveColor: AllColor.grey,
//             ),
//
//             8.verticalSpace,
//
//             /// Budget
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("Budget Range", style: TextStyle(fontSize: 16.sp)),
//                 Text("\$${state.budget.toInt()}",
//                     style: TextStyle(fontSize: 16.sp, fontFamily: "headFont", fontWeight: FontWeight.w800, color: AllColor.black)),
//               ],
//             ),
//             Slider(
//               value: state.budget,
//               min: 0,
//               max: 100,
//               onChanged: notifier.updateBudget,
//               activeColor: AllColor.primary,
//               inactiveColor: AllColor.grey,
//             ),
//
//             20.verticalSpace,
//
//             /// Action Buttons
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: ()=> context.pop(),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AllColor.brand2_light,
//                       foregroundColor: AllColor.white,
//                       padding: EdgeInsets.symmetric(vertical: 14.h),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30.r)),
//                     ),
//                     child:
//                     Text("Reset", style: TextStyle(fontSize: 18.sp)),
//                   ),
//                 ),
//                 16.horizontalSpace,
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () => context.pop(),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AllColor.grey300,
//                       foregroundColor: AllColor.black,
//                       padding: EdgeInsets.symmetric(vertical: 14.h),
//                       shape: RoundedRectangleBorder(
//
//                           borderRadius: BorderRadius.circular(30.r)),
//                       disabledBackgroundColor: AllColor.red ,
//                     ),
//                     child: Text("Apply",
//                         style: TextStyle(
//                             fontSize: 12.sp, fontWeight: FontWeight.w600, fontFamily: "OpenText", )),
//                   ),
//                 ),
//               ],
//             ),
//
//             SizedBox(height: 10.h,),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _pillButton(WidgetRef ref, String label, String selected) {
//     final selectedBool = label == selected;
//     final notifier = ref.read(filterProvider.notifier);
//
//     return Expanded(
//       child: GestureDetector(
//         onTap: () => notifier.updateJobType(label),
//         child: Container(
//           padding: EdgeInsets.symmetric(vertical: 10.h),
//           decoration: BoxDecoration(
//             color: selectedBool ? AllColor.primary : AllColor.white,
//             borderRadius: BorderRadius.circular(10.r, ),
//             border: Border.all(color: AllColor.primary, width: 1.w),
//           ),
//           child: Center(
//             child: Text(
//               label,
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 fontWeight: FontWeight.w400,
//                 color: selectedBool ? AllColor.black :AllColor.black,
//                 fontFamily: "OpenText"
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';

final filterProvider = StateNotifierProvider<FilterNotifier, FilterState>(
      (ref) => FilterNotifier(),
);

class FilterState {
  final String? category;
  final String jobType;
  final String location;
  final double distance;
  final double budget;

  const FilterState({
    this.category,
    this.jobType = 'Onsite',
    this.location = '',
    this.distance = 50.0,
    this.budget = 50.0,
  });

  FilterState copyWith({
    String? category,
    String? jobType,
    String? location,
    double? distance,
    double? budget,
  }) {
    return FilterState(
      category: category ?? this.category,
      jobType: jobType ?? this.jobType,
      location: location ?? this.location,
      distance: distance ?? this.distance,
      budget: budget ?? this.budget,
    );
  }

  static const initial = FilterState();
}

class FilterNotifier extends StateNotifier<FilterState> {
  FilterNotifier() : super(FilterState.initial);

  void updateCategory(String? value) => state = state.copyWith(category: value);
  void updateJobType(String value) => state = state.copyWith(jobType: value);
  void updateLocation(String value) => state = state.copyWith(location: value);

  void updateDistance(double value) {
    state = state.copyWith(distance: value.clamp(0, 100));
  }

  void updateBudget(double value) {
    state = state.copyWith(budget: value.clamp(0, 100));
  }

  void reset() => state = FilterState.initial;
}

class FilterJobsBottomSheet extends ConsumerWidget {
  const FilterJobsBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(filterProvider);
    final notifier = ref.read(filterProvider.notifier);
    final theme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        16.w,
        24.h,
        16.w,
        16.h + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            /// Header
            Row(
              children: [
                Text(
                  "Filter Jobs",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                    fontFamily: "headFont",
                    color: AllColor.black,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(Icons.close, color: AllColor.black, size: 30.sp),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),

            12.verticalSpace,

            /// Category Dropdown
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Categories",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                  fontFamily: "headFont",
                  color: AllColor.black,
                ),
              ),
            ),
            6.verticalSpace,
            DropdownButtonFormField<String>(
              value: state.category,
              isExpanded: true,
              hint: const Text(
                "Select categories",
                style: TextStyle(color: AllColor.black87),
              ),
              decoration: const InputDecoration(border: InputBorder.none),
              items: ["Design", "Development", "Marketing"]
                  .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e, style: const TextStyle(color: Colors.black)),
              ))
                  .toList(),
              iconEnabledColor: AllColor.brand2_light,
              iconDisabledColor: AllColor.grey,
              onChanged: notifier.updateCategory,
            ),

            16.verticalSpace,

            /// Job Type Segment
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "To be done",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                  fontFamily: "headFont",
                  color: AllColor.black,
                ),
              ),
            ),
            8.verticalSpace,
            Row(
              children: [
                _pillButton(ref, "Onsite", state.jobType),
                8.horizontalSpace,
                _pillButton(ref, "Remote", state.jobType),
                8.horizontalSpace,
                _pillButton(ref, "All", state.jobType),
              ],
            ),

            16.verticalSpace,

            /// Location
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Location",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                  fontFamily: "headFont",
                  color: AllColor.black,
                ),
              ),
            ),
            6.verticalSpace,
            TextFormField(
              initialValue: state.location,
              onChanged: notifier.updateLocation,
              decoration: InputDecoration(
                hintText: "Mckinnery tx 75071, USA",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                contentPadding:
                EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              ),
            ),

            16.verticalSpace,

            /// Distance
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Distance",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: "headFont",
                    fontWeight: FontWeight.w800,
                    color: AllColor.black,
                  ),
                ),
                Text("${state.distance.toInt()} mi",
                    style: TextStyle(fontSize: 14.sp)),
              ],
            ),
            Slider(
              value: state.distance.clamp(0, 100),
              min: 0,
              max: 100,
              onChanged: notifier.updateDistance,
              activeColor: AllColor.primary,
              inactiveColor: AllColor.grey,
            ),

            8.verticalSpace,

            /// Budget
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Budget Range", style: TextStyle(fontSize: 16.sp, fontFamily: "headFont", fontWeight: FontWeight.w800, color: AllColor.black)),
                Text(
                  "\$${state.budget.toInt()}",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: "headFont",
                    fontWeight: FontWeight.w800,
                    color: AllColor.black,
                  ),
                ),
              ],
            ),
            Slider(
              value: state.budget.clamp(0, 100),
              min: 0,
              max: 100,
              onChanged: notifier.updateBudget,
              activeColor: AllColor.primary,
              inactiveColor: AllColor.grey,
            ),

            20.verticalSpace,

            /// Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: notifier.reset,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AllColor.grey,
                      foregroundColor: AllColor.white,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
                    child: Text("Reset", style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w400, fontFamily: "OpenText", color: AllColor.white)),
                  ),
                ),
                16.horizontalSpace,
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => context.pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AllColor.primary,
                      foregroundColor: AllColor.black,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
                    child: Text(
                      "Apply",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: "OpenText",
                        color: AllColor.black

                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  Widget _pillButton(WidgetRef ref, String label, String selected) {
    final selectedBool = label == selected;
    final notifier = ref.read(filterProvider.notifier);

    return Expanded(
      child: GestureDetector(
        onTap: () => notifier.updateJobType(label),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            color: selectedBool ? AllColor.primary : AllColor.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: AllColor.primary, width: 1.w),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AllColor.black,
                fontFamily: "OpenText",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
