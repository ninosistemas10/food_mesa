

import 'package:dashboard_bloc/app/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Message {
    static void taskErrororWarning(String taskName, String taskErrorOrWarning) {
        Get.snackbar(
            taskName, taskErrorOrWarning,
            backgroundColor: AppColor.blue,
            titleText: Text(taskName, style: const TextStyle(fontSize:  20, fontWeight: FontWeight.bold, color: Colors.white)),
            messageText: Text(taskErrorOrWarning, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.yellowAccent))
        );
    }
}