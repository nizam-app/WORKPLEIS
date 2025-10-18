

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_app_bar.dart';
import 'package:workpleis/features/message/screen/chat_screen.dart';

final tabP = StateProvider<int>((_) => 0);

class P {
  P(this.t, this.p, this.d, this.eta, {this.rej = false});
  String t, d, eta;
  int p;
  bool rej;
}

final jobsP = StateNotifierProvider<_S, List<P>>((_) => _S());

class _S extends StateNotifier<List<P>> {
  _S()
      : super([
    P("Deliver something for me", 3500, "Modern e-commerce React/Node.js.", "3–5 days"),
    P("Marketing site revamp", 1200, "LP redesign, blog, CMS.", "5–7 days"),
    P("iOS MVP polish", 800, "Bug-fix, TestFlight, analytics.", "2–4 days"),
    P("Admin dashboard", 2100, "RBAC, charts, CSV.", "6–10 days"),
    P("Stripe integration", 600, "Checkout, webhooks.", "1–2 days"),
  ]);

  void accept(int i) {
    // Accept logic placeholder
  }

  void reject(int i) {
    state = [
      for (int k = 0; k < state.length; k++)
        k == i
            ? P(state[k].t, state[k].p, state[k].d, state[k].eta, rej: true)
            : state[k]
    ];
  }
}

class JobsOffers extends ConsumerWidget {
  const JobsOffers({super.key});
  static const routeName = "/jobsOffers";

  @override
  Widget build(BuildContext c, WidgetRef ref) {
    final tab = ref.watch(tabP);
    final items = ref.watch(jobsP);
    final list = tab == 0
        ? items.where((e) => !e.rej).toList()
        : items.where((e) => e.rej).toList();

    return Scaffold(
      appBar: GlobalAppbar(text: 'Offers'),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            ///search bar
            TextFormField(
              decoration:
              InputDecoration(
                hintText: 'What do you need done today ?',
              )!.copyWith(
                fillColor: AllColor.white,
                prefixIcon: Icon(Icons.search, color: AllColor.grey,),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
            SizedBox(height: 16.h,),
            Row(
              children: [
                _Seg(tab: tab, on: (i) => ref.read(tabP.notifier).state = i),
                const Spacer(),
                Text(
                  "${list.length} ${tab == 0 ? 'pending' : 'rejected'}",
                  style: TextStyle(
                    color: AllColor.black.withOpacity(.6),
                    fontWeight: FontWeight.w300,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
            12.verticalSpace,

            
            Expanded(
              child: list.isEmpty
                  ? _Empty(
                  msg: tab == 0
                      ? "No pending jobs"
                      : "No rejected jobs")
                  : ListView.separated(
                itemCount: list.length,
                separatorBuilder: (_, __) => 12.verticalSpace,
                itemBuilder: (_, i) {
                  final idx = items.indexOf(list[i]);
                  return _Card(
                    d: list[i],
                    showActions: tab == 0, // ✅ only show buttons in Pending tab
                    onAccept: () =>
                        ref.read(jobsP.notifier).accept(idx),
                    onReject: () =>
                        ref.read(jobsP.notifier).reject(idx),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Seg extends StatelessWidget {
  const _Seg({required this.tab, required this.on});
  final int tab;
  final ValueChanged<int> on;

  @override
  Widget build(BuildContext c) => Container(
    padding: EdgeInsets.all(3.r),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: AllColor.black.withOpacity(.1)),
      borderRadius: BorderRadius.circular(999.r),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _chip("Pending", tab == 0, () => on(0)),
        _chip("Rejected", tab == 1, () => on(1)),
      ],
    ),
  );

  Widget _chip(String t, bool s, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: s ? AllColor.brand2_light : Colors.transparent,
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Text(
        t,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 13.sp,
          color: s ? AllColor.white : AllColor.black,
        ),
      ),
    ),
  );
}

class _Card extends StatelessWidget {
  const _Card({
    required this.d,
    required this.showActions,
    required this.onAccept,
    required this.onReject,
  });

  final P d;
  final bool showActions;
  final VoidCallback onAccept, onReject;

  @override
  Widget build(BuildContext c) {

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AllColor.grey, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            blurRadius: 12.r,
            offset: Offset(0, 6.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Header: avatar + name/rating ... price ---
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar (soft purple bg)
              Container(
                width: 30.w,
                height: 30.w,
                decoration: const BoxDecoration(
                  color: AllColor.brand2_light,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(Icons.person, size: 16.sp, color: AllColor.white),
              ),
              10.horizontalSpace,

              // Name + rating (ইমেজের মতো স্ট্যাটিক রাখা হলো—ডাটা মডেল না বদলিয়ে)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "John Due",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AllColor.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        height: 1.1,
                      ),
                    ),
                    2.verticalSpace,
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star_rounded, size: 16.sp, color: AllColor.brand2_light),
                        4.horizontalSpace,
                        Text(
                          "4.9",
                          style: TextStyle(
                            color: AllColor.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Price (top-right)
              Text(
                "\$${_fmt(d.p)}",
                style: TextStyle(
                  color: AllColor.brand2_light,
                  fontWeight: FontWeight.w800,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),

          10.verticalSpace,

          // --- Body text (তোমার ডাটা) ---
          Text(
            d.d,
            style: TextStyle(
              color: AllColor.black87,
              height: 1,
              fontSize: 12.sp,
            ),
          ),

          12.verticalSpace,

          // --- Footer: Est ... chat + buttons/rejected ---
          Row(
            children: [
              Text(
                "Est: ${d.eta}",
                style: TextStyle(
                  color: AllColor.black87,
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                ),
              ),
              const Spacer(),

              // Chat (ghost icon style)
              _ghostIcon(
                icon: Icons.message_outlined,
                onTap: () {
                  c.push(ChatScreen.routeName);
                },
              ),

              if (showActions) ...[
                8.horizontalSpace,
                // Accept = neon-lime filled
                _pillFilled(
                  "Accept",
                  AllColor.white,
                  AllColor.brand2_light,
                  onAccept,
                ),
                8.horizontalSpace,
                // Reject = soft gray ghost
                _pillGhost(
                  "Reject",
                  AllColor.white,
                  AllColor.brand2_light,
                  onReject,
                ),
              ] else ...[
                8.horizontalSpace,
                // Rejected = soft purple filled (disabled look)
                _pillDisabled(
                  "Rejected",
                  AllColor.white,
                  AllColor.brand2_light,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  // ----- Helpers (same signature, inside class) -----
  static String _fmt(int v) {
    final s = "$v";
    final b = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      b.write(s[i]);
      final r = s.length - i;
      if (r > 1 && r % 3 == 1) b.write(',');
    }
    return b.toString();
  }

  Widget _ghostIcon({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Padding(
        padding: EdgeInsets.all(8.r),
        child: Icon(icon, size: 16.sp, color: const Color(0xFF8E7CFF)),
      ),
    );
  }

  Widget _pillFilled(String t, Color bg, Color fg, VoidCallback on) => Material(
    color: bg,
    borderRadius: BorderRadius.circular(999.r),
    child: InkWell(
      onTap: on,
      borderRadius: BorderRadius.circular(999.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
        child: Text(
          t,
          style: TextStyle(
            color: fg,
            fontWeight: FontWeight.w700,
            fontSize: 12.sp,
            letterSpacing: .1,
          ),
        ),
      ),
    ),
  );

  Widget _pillGhost(String t, Color bg, Color fg, VoidCallback on) => Container(
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(999.r),
    ),
    child: Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: on,
        borderRadius: BorderRadius.circular(999.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
          child: Text(
            t,
            style: TextStyle(
              color: fg,
              fontWeight: FontWeight.w600,
              fontSize: 12.sp,
            ),
          ),
        ),
      ),
    ),
  );

  Widget _pillDisabled(String t, Color bg, Color fg) => Container(
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(999.r),
    ),
    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
    child: Text(
      t,
      style: TextStyle(
        color: fg,
        fontWeight: FontWeight.w700,
        fontSize: 12.5.sp,
      ),
    ),
  );
}


class _Empty extends StatelessWidget {
  const _Empty({required this.msg});
  final String msg;

  @override
  Widget build(BuildContext c) => Center(
    child: Text(
      msg,
      style: TextStyle(
        color: AllColor.brand2_light,
        fontSize: 14.sp,
      ),
    ),
  );
}