import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/constants/color_control/all_color.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});
  static const routeName = '/chatScreen';

  @override
  Widget build(BuildContext context) {
    final List<MessageModel> messages = [
      MessageModel(
        text:
        "Hi! I saw your profile and would love to discuss my furniture moving task.",
        time: "10:45 AM",
        isMe: false,
        avatar: "https://i.pravatar.cc/150?img=47",
      ),
      MessageModel(
        text:
        "Hi Emilly! I'd be happy to help. I have experience with furniture moving and have all the necessary equipment.",
        time: "10:50 AM",
        isMe: true,
        avatar: "https://i.pravatar.cc/150?img=32",
      ),
      MessageModel(
        text: "Thank you for your response. lets fixed the price first.",
        time: "10:52 AM",
        isMe: false,
        avatar: "https://i.pravatar.cc/150?img=47",
      ),
      MessageModel(
        text:
        "I can do this for \$45. Would include moving the couch and dining table from your current place to the new apartment.",
        time: "10:57 AM",
        isMe: true,
        avatar: "https://i.pravatar.cc/150?img=32",
      ),
    ];
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(

     //appBar: GlobalAppbar( text: "UserName"),
      appBar: AppBar(
        backgroundColor: AllColor.borderColor,
        leading: InkWell(
          onTap: () {context.pop();},
            child: Icon(Icons.arrow_back_ios)),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Emilly Davis", style:TextStyle(fontSize:22.sp , fontFamily: "headFont", fontWeight: FontWeight.w800,color: AllColor.white),),
            Text("Deep house cleaning service needed", style:TextStyle(fontSize:14.sp, fontWeight: FontWeight.w700, fontFamily: "OpenText", color: AllColor.white ),),
          ],
        ),
      ),
      body: Column(
        children: [
          // Chat List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(message: messages[index]);

              },
            ),
          ),

          // Input Area
          const ChatInputField(),
        ],
      ),
    );
  }
}

/* ================= MODEL ================= */
class MessageModel {
  final String text;
  final String time;
  final bool isMe;
  final String avatar;

  MessageModel({
    required this.text,
    required this.time,
    required this.isMe,
    required this.avatar,
  });
}

/* ================= CHAT BUBBLE ================= */
class ChatBubble extends StatelessWidget {
  final MessageModel message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isMe = message.isMe;

    return Column(
      crossAxisAlignment:
      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment:
          isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (!isMe)
              CircleAvatar(
                radius: 16.r,
                backgroundImage: NetworkImage(message.avatar),
              ),
            SizedBox(width: 8.w),
            Flexible(
              child: Container(
                padding: EdgeInsets.all(12.w),
                margin: EdgeInsets.symmetric(vertical: 4.h),
                decoration: BoxDecoration(
                  color: AllColor.lime,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  message.text,
                  style: TextStyle(fontSize: 12.sp, color: AllColor.black, fontFamily: "OpenText", fontWeight: FontWeight.w400),
                ),
              ),
            ),
            if (isMe)
              SizedBox(width: 8.w),
            if (isMe)
              CircleAvatar(
                radius: 16.r,
                backgroundImage: NetworkImage(message.avatar),
              ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
              left: isMe ? 0 : 40.w, right: isMe ? 40.w : 0, top: 2.h),
          child: Text(
            message.time,
            style: TextStyle(fontSize: 10.sp, color: AllColor.black, fontFamily: "OpenText", fontWeight: FontWeight.w400),
          ),
        )
      ],
    );
  }
}

/* ================= CHAT INPUT ================= */
class ChatInputField extends StatelessWidget {
  const ChatInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: AllColor.grey)),
        color: AllColor.white,
      ),
      child: Row(
        children: [
          Icon(Icons.attach_file, color: AllColor.grey, size: 22.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: TextFormField(
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AllColor.black,
                fontFamily: "OpenText",
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
                hintText: "Type a message...",
                border: InputBorder.none,

              ),
            ),
          ),
          SizedBox(width: 8.w),
          Icon(Icons.send, color: AllColor.black, size: 24.sp),
        ],
      ),
    );
  }
}
