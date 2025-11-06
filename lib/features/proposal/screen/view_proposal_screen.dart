import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_aleart_box.dart';
import 'package:workpleis/core/widget/global_app_bar.dart';
import 'package:workpleis/features/account/screen/account_screen.dart';
import 'package:workpleis/features/message/screen/chat_screen.dart';

final tabProvider = StateProvider<int>((ref) => 0);

class Proposal {
  final String title;
  final String details;
  final String eta;
  final int price;
  final bool rejected;
  final bool accepted;

  Proposal(this.title, this.price, this.details, this.eta,
      {this.rejected = false, this.accepted = false});

  Proposal copyWith({bool? rejected, bool? accepted}) =>
      Proposal(title, price, details, eta,
          rejected: rejected ?? this.rejected,
          accepted: accepted ?? this.accepted);
}

final proposalProvider =
StateNotifierProvider<_ProposalNotifier, List<Proposal>>(
      (_) => _ProposalNotifier(),
);

class _ProposalNotifier extends StateNotifier<List<Proposal>> {
  _ProposalNotifier()
      : super([
    Proposal("Deliver something for me", 3500,
        "Seeking experienced full-stack developer to build modern e-commerce platform with React/Node.js. ", "3–5 days"),
    Proposal("Deliver something for me",
        1200, "Seeking experienced full-stack developer to build modern e-commerce platform with React/Node.js.",
        "5–7 days"),
    Proposal("Deliver something for me", 800,
        "Seeking experienced full-stack developer to build modern e-commerce platform with React/Node.js.", "2–4 days"),
    Proposal("Deliver something for me", 2100, "RBAC, charts, CSV.",
        "6–10 days"),
    Proposal(
        "Deliver something for me", 600, "Seeking experienced full-stack developer to build modern e-commerce platform with React/Node.js.", "1–2 days"),
  ]);

  void accept(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index)
          state[i].copyWith(accepted: true)
        else
          state[i]
    ];
  }

  void reject(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index)
          state[i].copyWith(rejected: true)
        else
          state[i]
    ];
  }
}

class ViewProposalScreen extends ConsumerWidget {
  const ViewProposalScreen({super.key});

  static const routeName = "/proposal";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabIndex = ref.watch(tabProvider);
    final proposals = ref.watch(proposalProvider);
    final filtered = proposals.where((p) {
      if (tabIndex == 0) return !p.rejected && !p.accepted;
      if (tabIndex == 1) return p.accepted;
      return p.rejected;
    }).toList();

    return Scaffold(
      appBar: GlobalAppbar(text: 'Proposals'),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            Row(
              children: [
                SegmentControl(
                  selected: tabIndex,
                  onChanged: (i) =>
                  ref.read(tabProvider.notifier).state = i,
                ),
                const Spacer(),
                Text(
                  "${filtered.length} ${tabIndex == 0 ? 'pending' : tabIndex == 1 ? 'approved' : 'rejected'}",
                  style: TextStyle(
                    color: AllColor.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w200,
                    fontFamily: "headFont"
                  ),
                )
              ],
            ),
            12.verticalSpace,
            Expanded(
              child: filtered.isEmpty
                  ? EmptyState(
                  msg: tabIndex == 0
                      ? "No pending proposals"
                      : tabIndex == 1
                      ? "No approved proposals"
                      : "No rejected proposals")
                  : ListView.separated(
                itemCount: filtered.length,
                separatorBuilder: (_, __) => 12.verticalSpace,
                itemBuilder: (_, i) {
                  final index = proposals.indexOf(filtered[i]);
                  return ProposalCard(
                    data: filtered[i],
                    showActions: tabIndex == 0,
                    onAccept: () {
                      ref
                          .read(proposalProvider.notifier)
                          .accept(index);
                      globalShowAlertDialog(
                        context: context,
                        oneTap: () {
                          context.pop();
                        },
                        message: "Proposal is accepted",
                      );
                    },
                    onReject: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20.r)),
                        ),
                        builder: (context) => CustomRejectBottomSheet(
                          onSubmit: (reason) {
                            ref
                                .read(proposalProvider.notifier)
                                .reject(index);
                            Navigator.pop(context);
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SegmentControl extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onChanged;

  const SegmentControl(
      {required this.selected, required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.r),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AllColor.black.withOpacity(.1)),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Row(
        children: [
          _tab("Pending", selected == 0, () => onChanged(0)),
          _tab("Approved", selected == 1, () => onChanged(1)),
          _tab("Rejected", selected == 2, () => onChanged(2)),
        ],
      ),
    );
  }

  Widget _tab(String title, bool active, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Container(

      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: active ? AllColor.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(30.r),
       // border: Border.all(width: 1.h, color: AllColor.grey),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w200,
          //color: active ? AllColor.white : AllColor.black,
            color:AllColor.black,
          fontFamily: "headFont"
        ),
      ),
    ),
  );
}

class ProposalCard extends StatelessWidget {

  final Proposal data;
  final bool showActions;
  final VoidCallback onAccept, onReject;

  const ProposalCard({
    required this.data,
    required this.showActions,
    required this.onAccept,
    required this.onReject,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //final  selectedColor = true;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AllColor.black.withOpacity(.06)),
        boxShadow: [
          BoxShadow(
            color: AllColor.black.withOpacity(.06),
            blurRadius: 16.r,
            offset: Offset(0, 6.h),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    context.push(AccountOverviewScreen.routeName);
                  },
                  child: Text(data.title,
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w700, fontFamily: "headFont")),
                ),
              ),
              Text("\$${_formatPrice(data.price)}",
                  style: TextStyle(
                      fontSize: 14.sp, fontWeight: FontWeight.w600, fontFamily: "OpenText", color: AllColor.black)),
            ],
          ),
          8.verticalSpace,
          Text(data.details,
              style: TextStyle(
                  color: AllColor.brand2_light, fontSize: 14.sp, fontFamily: "OpenText", fontWeight: FontWeight.w400)),
          12.verticalSpace,
          // Row(
          //   children: [
          //     _eta("Est: ${data.eta}"),
          //     SizedBox(width: 20.w,),
          //     // const Spacer(),
          //     _icon(Icons.chat_bubble_outline_outlined, () {
          //       context.push(ChatScreen.routeName);
          //     }),
          //   ],
          // ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _eta("Est: ${data.eta}"),
              const Spacer(),
              _icon(Icons.chat_bubble_outline, () {
                context.push(ChatScreen.routeName);
              }),
              if (showActions) ...[
                 8.horizontalSpace,
                _actionButton("Accept", true,  onAccept, ),
                 8.horizontalSpace,
                _actionButton("Reject",false,  onReject),
              ]
            ],
          )
        ],
      ),
    );
  }

  String _formatPrice(int value) {
    final s = value.toString();
    final b = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      b.write(s[i]);
      final r = s.length - i;
      if (r > 1 && r % 3 == 1) b.write(',');
    }
    return b.toString();
  }

  Widget _eta(String label) => Row(
    children: [
      Text(label,
          style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              fontFamily: "OpenText",
              color: AllColor.brand2_light)),
    ],
  );

  Widget _actionButton(String label, bool selectedColor,  VoidCallback onPressed) => Material(
    color: selectedColor? AllColor.parpale: AllColor.grey300,
    borderRadius: BorderRadius.circular(10.r),
    child: InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(10.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        child: Text(
          label,
          style: TextStyle(
            color: selectedColor? AllColor.black: AllColor.black,
            fontSize: 14.sp,
            fontWeight: FontWeight.w800,
            fontFamily: "OpenText"
          ),
        ),
      ),
    ),
  );

  Widget _icon(IconData icon, VoidCallback onPressed) => InkWell(
    onTap: onPressed,
    borderRadius: BorderRadius.circular(30.r),

    child: Padding(
      padding: EdgeInsets.all(8.r),
      child: Icon(
        icon,
        size: 20.sp,
        color: AllColor.brand2_light,
      ),
    ),
  );
}

class EmptyState extends StatelessWidget {
  final String msg;

  const EmptyState({required this.msg, super.key});

  @override
  Widget build(BuildContext context) => Center(
    child: Text(
      msg,
      style:
      TextStyle(color: AllColor.black.withOpacity(.6), fontSize: 13.sp),
    ),
  );
}

class CustomRejectBottomSheet extends StatefulWidget {
  final ValueChanged<String> onSubmit;
  final String text1;
  final String text2;

  const CustomRejectBottomSheet(
      {required this.onSubmit,
        super.key,
        this.text1 = "Rejection Message",
        this.text2 = "Tell something for rejection"});

  @override
  State<CustomRejectBottomSheet> createState() =>
      _CustomRejectBottomSheetState();
}

class _CustomRejectBottomSheetState extends State<CustomRejectBottomSheet> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: AllColor.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  widget.text1,
                  style: TextStyle(
                    color: AllColor.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 16.sp,
                    fontFamily: "headFont"
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(Icons.close, color: AllColor.black),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
            12.verticalSpace,
            TextField(
              controller: _controller,
              maxLines: 4,
              style: theme.bodyMedium?.copyWith(color: AllColor.black),
              decoration: InputDecoration(
                hintText: widget.text2,
                hintStyle: theme.titleMedium?.copyWith(
                  color: AllColor.black.withOpacity(.4),
                ),
                filled: true,
                fillColor: AllColor.black.withOpacity(.05),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
            20.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AllColor.black,
                      side: BorderSide(color: AllColor.black.withOpacity(.6)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 10.h),
                    ),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: AllColor.black,
                        fontWeight: FontWeight.w400,
                        fontFamily: "OpenText",
                        fontSize: 16.sp
                      ),
                    ),
                  ),
                ),
                12.horizontalSpace,
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final text = _controller.text.trim();
                      widget.onSubmit(text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AllColor.bgcolor,
                      foregroundColor: AllColor.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 10.h),
                      elevation: 0,
                    ),
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        color: AllColor.black,
                        fontWeight: FontWeight.w400,
                        fontFamily: "OpenText",
                        fontSize: 16.sp,


                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
