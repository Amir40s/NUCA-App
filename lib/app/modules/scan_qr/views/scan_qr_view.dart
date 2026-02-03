import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/scan_qr_controller.dart';

class ScanQrView extends GetView<ScanQrController> {
  const ScanQrView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ScanQrView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ScanQrView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
