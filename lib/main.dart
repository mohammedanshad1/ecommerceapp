import 'package:flutter/material.dart';
import 'package:innoitlabsmachintest/screens/homescreen/view/homescreen.dart';
import 'package:innoitlabsmachintest/screens/homescreen/viewmodel/homescreen_viewmodel.dart';
import 'package:innoitlabsmachintest/screens/productdetailscreen/viewmodel/productview_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeScreenViewModel()),
          ChangeNotifierProvider(
      create: (context) => ProductViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product App',
      home: HomeScreenView(),
    );
  }
}
