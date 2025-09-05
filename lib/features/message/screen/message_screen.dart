import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/widget/global_app_bar.dart';
import 'package:workpleis/features/message/screen/chat_screen.dart';

import '../../../core/constants/color_control/all_color.dart';
import '../data/message_data.dart';
class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});
  static const routeName = "/messageScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(text: "Message"),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            ChatSearchBar(),
            SizedBox(height: 20.h),
            Expanded(child: ChatListView()),

          ],
        ),
      ));
  }
}
/* ================= CUSTOM SEARCH BAR ================= */
class ChatSearchBar extends StatelessWidget {
  const ChatSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
        hintText: "Search",
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        prefixIcon: Icon(Icons.search, color: AllColor.black87),
      ),
    );
  }
}

/* ================= CHAT LIST VIEW ================= */
class ChatListView extends StatelessWidget {
  const ChatListView({super.key});

  @override
  Widget build(BuildContext context) {


    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        final chat = chats[index];
        return ChatListTile(
          name: chat.name,
          message: chat.message,
          time: chat.time,
          avatar: chat.avatar,
          unread: chat.unread,
        );
      },
    );
  }
}

/* ================= SINGLE CHAT TILE ================= */
class ChatListTile extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final String avatar;
  final bool unread;

  const ChatListTile({
    super.key,
    required this.name,
    required this.message,
    required this.time,
    required this.avatar,
    required this.unread,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        children: [
          InkWell(
            onTap: (){
              context.push(ChatScreen.routeName);
            },
            child: Row(
              children: [
                CircleAvatar(radius: 22.r, backgroundImage: NetworkImage(avatar)),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(name,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AllColor.black)),
                          Text(time,
                              style: TextStyle(
                                  fontSize: 14.sp, color: AllColor.black87)),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        message,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12.sp, color: AllColor.grey700),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 5.w,),
                if (unread) ...[
                  SizedBox(width: 8.w),
                  Container(
                    width: 8.w,
                    height: 8.w,
                    decoration: BoxDecoration(
                      color: AllColor.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
                ]
              ],
            ),
          ),
          SizedBox(height: 5.h),
          Divider(color: AllColor.grey300),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}
