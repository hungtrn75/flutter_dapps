import 'package:flutter/material.dart';
import 'package:ong_nft/contract_linking.dart';
import 'package:ong_nft/home_page.dart';
import 'package:ong_nft/test/stream_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ContractLinking(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StreamPage(),
    );
  }
}
