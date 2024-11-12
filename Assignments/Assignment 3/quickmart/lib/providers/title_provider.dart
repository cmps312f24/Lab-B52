import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickmart/routes/app_router.dart';

class AppTitleNotifier extends Notifier<String> {
  @override
  String build() {
    return AppRouter.home.name;
  }

  void updateTitle(String title) {
    state = title;
  }
}

final appTitleNotifierProvider =
    NotifierProvider<AppTitleNotifier, String>(() => AppTitleNotifier());