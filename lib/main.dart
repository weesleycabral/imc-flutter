import 'package:calc_imc/pages/calculo_imc_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cálculo IMC',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0x001F1F1F),
              primary: const Color(0xff181818),
              secondary: const Color(0xff1F1F1F),
              tertiary: const Color(0xff235997),
              onError: const Color(0xffDCDCDC)),
          useMaterial3: true,
        ),
        home: const CaculoImcPage());
  }
}
