import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/halal_guidlines_controller.dart';

class HalalGuidlinesView extends GetView<HalalGuidlinesController> {
  const HalalGuidlinesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HalalGuidlinesView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'HalalGuidlinesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
