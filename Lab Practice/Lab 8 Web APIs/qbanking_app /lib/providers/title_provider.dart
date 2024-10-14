import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppTitleNotifier extends Notifier<String> {
  @override
  String build() {
    return "QBanking";
  }

  void setTitle(String title) {
    state = title;
  }
}

final appTitleNotifierProvider =
    NotifierProvider<AppTitleNotifier, String>(() => AppTitleNotifier());
