Future<void> userNotificationEnable({
  required BuildContext context,
  required bool status,
}) async {
  isSubLoading = true;
  notifyListeners();


  try {
    final result = await _repo.userNotificationsEnable(userId: user!.id,
        status: status);

    log("📥 Repo returned ➝ $result");

    if (result is Success) {
      log("✅ SUCCESS → API Data: ${result.data}");
      final data = result.data as Map<String, dynamic>;
      final message = data['message'] ?? 'No message';
      Utils.showMessage(message, context: context, isError: false);
    } else if (result is Failure) {
      final data = result.error;
      Utils.showMessage(data, context: context, isError: true);

    }
  } catch (e, s) {
    log("💥 EXCEPTION: $e");
    log("📌 STACKTRACE: $s");
  }

  isSubLoading = false;
  notifyListeners();
}
