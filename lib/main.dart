import 'package:flutter/material.dart';
import 'package:money_keeper/app/core/utils/utils.dart';

import 'app/app.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  ConfigHelper.configLoadingBar();
  runApp(const App());
}

