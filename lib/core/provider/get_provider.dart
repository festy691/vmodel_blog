import 'package:blog/core/di/injection_container.dart';
import 'package:blog/core/state_managers/news_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class Providers {
  static List<SingleChildWidget> getProviders = [
    ChangeNotifierProvider<NewsProvider>(create: (_) => NewsProvider(sl())),
  ];
}
