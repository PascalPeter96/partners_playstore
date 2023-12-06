import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wena_partners/app_style/app_theme.dart';
import 'package:wena_partners/delivery/models/notification.dart';
import 'package:wena_partners/widgets/title_app_bar.dart';


class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {

  var myNotifications = NotificationModel.myNotifications;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: TitleAppBar(
          title: 'Notifications',
          titleWidget: Container(width: 10.w,),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        child: ListView.builder(
            itemCount: myNotifications.length,
            itemBuilder: (context, index){
              var myNote = myNotifications[index];
              return FadeInUp(
                child: Padding(
                  padding:EdgeInsets.symmetric(vertical: 1.h),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.sp),
                    ),
                    child: ListTile(
                      leading: const CircleAvatar(),
                      title: Text(myNote.title.toString(), style: AppTheme.sectionMediumTitle,),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(myNote.message.toString(), style: AppTheme.greySmallSegoe,),
                          Text(myNote.date.toString(), style: AppTheme.subtitleSmall,)
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
        ),
      ),

    );

  }
}
