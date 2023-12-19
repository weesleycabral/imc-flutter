import 'package:calc_imc/pages/calculo_imc_page.dart';
import 'package:flutter/material.dart';

class CalculoImcPresenter {
  final CaculoImcPage view;
  final BuildContext context;
  CalculoImcPresenter(this.view, this.context);

  bool isLoading = false;
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  final text = '';
  late double resultadoIMC;
  late String resultadoIMCFormatted;
  FocusNode pesoFocusNode = FocusNode();
  FocusNode alturaFocusNode = FocusNode();
}
