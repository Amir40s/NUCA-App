import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/subscription_managment_controller.dart';

class SubscriptionManagmentView
    extends GetView<SubscriptionManagmentController> {
  const SubscriptionManagmentView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SubscriptionManagmentView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SubscriptionManagmentView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
