import 'package:dashboard_bloc/app/controller/notification_admin.dart';
import 'package:dashboard_bloc/app/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationAdmin extends GetView<NotificationAdminController> {
    const NotificationAdmin({super.key});

    @override
    Widget build(BuildContext context) {
        return GetBuilder<NotificationAdminController>(builder: (notAdminCntrll) {
            return Container(
                decoration: BoxDecoration(
                color: AppColor.yellow, borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                    children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Obx(() => Text.rich(TextSpan(
                                    style: TextStyle(fontSize: 16, color: AppColor.black),
                                    children: [
                                        TextSpan(text: getTimeOfDay()),
                                        TextSpan(
                                            text: '  ${notAdminCntrll.nombre.value}',
                                            style: const TextStyle(fontWeight: FontWeight.bold)
                                        ),
                                    ]
                                ))),
                            ],
                        ),
                        const Spacer(),
                        Image.asset("assets/images/notification_image.png", height: 80)
                    ],
                ),
            );
        });
    }

    String getTimeOfDay(){
        DateTime now = DateTime.now();
        int hour = now.hour;

        if(hour >= 0 && hour < 12){
            return 'Buenos Dias';
        } else if (hour >= 12 && hour < 19) {
            return 'Buenas tardes';
        } else {
            return 'Buenas noches';
        }

    }
}
