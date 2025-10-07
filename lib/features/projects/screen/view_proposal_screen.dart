// uses: flutter_screenutil + riverpod + AllColor.*
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';
import 'package:workpleis/core/widget/global_app_bar.dart';

final tabP = StateProvider<int>((_) => 0);

class P { P(this.t,this.p,this.d,this.eta,{this.rej=false});
String t,d,eta; int p; bool rej; }

final proposalsP = StateNotifierProvider<_S, List<P>>((_)=>_S());
class _S extends StateNotifier<List<P>>{
  _S():super([
    P("Deliver something for me",3500,"Modern e-commerce React/Node.js.","3–5 days"),
    P("Marketing site revamp",1200,"LP redesign, blog, CMS.","5–7 days"),
    P("iOS MVP polish",800,"Bug-fix, TestFlight, analytics.","2–4 days"),
    P("Admin dashboard",2100,"RBAC, charts, CSV.","6–10 days"),
    P("Stripe integration",600,"Checkout, webhooks.","1–2 days"),
  ]);
  void accept(int i){} // hook
  void reject(int i){ state=[for (int k=0;k<state.length;k++) k==i? P(state[k].t,state[k].p,state[k].d,state[k].eta,rej:true):state[k]]; }
}

class ViewProposalScreen extends ConsumerWidget {
  const ViewProposalScreen({super.key});
  static const routeName="/proposal";

  @override
  Widget build(BuildContext c, WidgetRef ref){
    final tab = ref.watch(tabP), items = ref.watch(proposalsP);
    final list = tab==0? items.where((e)=>!e.rej).toList(): items.where((e)=>e.rej).toList();

    return Scaffold(
      appBar: GlobalAppbar( text: 'Proposals',),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(children:[
          Row(children:[
            _Seg(tab: tab, on:(i)=>ref.read(tabP.notifier).state=i),
            const Spacer(),
            Text("${list.length} ${tab==0?'pending':'rejected'}",
                style: TextStyle(color: AllColor.black.withOpacity(.6), fontWeight: FontWeight.w600, fontSize: 13.sp)),
          ]),
          12.verticalSpace,
          Expanded(
            child: list.isEmpty
                ? _Empty(msg: tab==0?"No pending proposals":"No rejected proposals")
                : ListView.separated(
              itemCount: list.length,
              separatorBuilder:(_,__)=>12.verticalSpace,
              itemBuilder:(_,i){
                final idx = items.indexOf(list[i]);
                return _Card(
                  d:list[i],
                  onAccept:()=>ref.read(proposalsP.notifier).accept(idx),
                  onReject:()=>ref.read(proposalsP.notifier).reject(idx),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}

class _Seg extends StatelessWidget {
  const _Seg({required this.tab, required this.on});
  final int tab; final ValueChanged<int> on;
  @override Widget build(BuildContext c)=>Container(
    padding: EdgeInsets.all(3.r),
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AllColor.black.withOpacity(.1)),
        borderRadius: BorderRadius.circular(999.r)),
    child: Row(mainAxisSize: MainAxisSize.min, children:[
      _chip("Pending", tab==0, ()=>on(0)),
      _chip("Rejected", tab==1, ()=>on(1)),
    ]),
  );
  Widget _chip(String t,bool s,VoidCallback onTap)=>GestureDetector(
      onTap:onTap,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal:14.w, vertical:6.h),
          decoration: BoxDecoration(color:s?AllColor.primary:Colors.transparent,borderRadius:BorderRadius.circular(999.r)),
          child: Text(t,style: TextStyle(fontWeight: FontWeight.w600,fontSize:13.sp))));
}

class _Card extends StatelessWidget {
  const _Card({required this.d, required this.onAccept, required this.onReject});
  final P d; final VoidCallback onAccept,onReject;
  @override Widget build(BuildContext c){
    final muted = AllColor.black.withOpacity(.7);
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AllColor.black.withOpacity(.06)),
          boxShadow:[BoxShadow(color: AllColor.black.withOpacity(.06), blurRadius:16.r, offset: Offset(0,6.h))]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
        Row(crossAxisAlignment: CrossAxisAlignment.start, children:[
          Expanded(child: Text(d.t, style: TextStyle(fontSize:20.sp,fontWeight:FontWeight.w800,color: Colors.black))),
          Text("\$${_fmt(d.p)}", style: TextStyle(fontSize:16.sp,fontWeight:FontWeight.w800,color: Colors.black)),
        ]),
        8.verticalSpace,
        Text(d.d, style: TextStyle(color: muted, height:1.35, fontSize: 13.sp)),
        12.verticalSpace,
        Row(children:[
          _eta("Est: ${d.eta}"),
          const Spacer(),
          _icon(Icons.chat_bubble_outline_rounded, (){}),
          8.horizontalSpace,
          _pill("Accept", AllColor.primary, AllColor.black, onAccept),
          8.horizontalSpace,
          _pill("Reject", AllColor.black.withOpacity(.06), AllColor.black, onReject),
        ])
      ]),
    );
  }

  static String _fmt(int v){ final s="$v"; final b=StringBuffer();
  for(int i=0;i<s.length;i++){ b.write(s[i]); final r=s.length-i; if(r>1 && r%3==1)b.write(','); } return b.toString(); }

  Widget _eta(String s)=>Container(
    padding: EdgeInsets.symmetric(horizontal:10.w,vertical:6.h),
    decoration: BoxDecoration(color: AllColor.black.withOpacity(.05), borderRadius: BorderRadius.circular(999.r)),
    child: Row(children:[Icon(Icons.schedule,size:16.sp,color: AllColor.black), 6.horizontalSpace, Text(s,style: TextStyle(fontWeight: FontWeight.w600,fontSize:12.sp))]),
  );
  Widget _pill(String t, Color bg, Color fg, VoidCallback on)=>Material(
    color: bg, borderRadius: BorderRadius.circular(999.r),
    child: InkWell(onTap:on,borderRadius:BorderRadius.circular(999.r),
        child: Padding(padding: EdgeInsets.symmetric(horizontal:14.w,vertical:8.h),
            child: Text(t, style: TextStyle(color: fg,fontWeight: FontWeight.w700,fontSize:13.sp)))),
  );
  Widget _icon(IconData i, VoidCallback on)=>Container(
    decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(999.r),
        border: Border.all(color: AllColor.black.withOpacity(.15))),
    child: InkWell(onTap:on, borderRadius: BorderRadius.circular(999.r),
        child: Padding(padding: EdgeInsets.all(8.r), child: Icon(i, size:18.sp,color: AllColor.black))),
  );
}

class _Empty extends StatelessWidget {
  const _Empty({required this.msg}); final String msg;
  @override Widget build(BuildContext c)=>Center(child: Text(msg, style: TextStyle(color: AllColor.black.withOpacity(.6), fontSize: 13.sp)));
}