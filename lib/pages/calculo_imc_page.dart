import 'package:flutter/material.dart';

class CaculoImcPage extends StatefulWidget {
  const CaculoImcPage({super.key});

  @override
  State<CaculoImcPage> createState() => _CaculoImcPageState();
}

class _CaculoImcPageState extends State<CaculoImcPage> {
  bool isLoading = false;
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  final _text = '';
  late int resultadoIMC;
  late String resultadoIMCFormatted;
  FocusNode pesoFocusNode = FocusNode();
  FocusNode alturaFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    pesoFocusNode.addListener(() {
      setState(() {});
    });

    alturaFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    pesoFocusNode.dispose();
    alturaFocusNode.dispose();

    super.dispose();
  }

  String? get _errorTextAltura {
    final textAltura = alturaController.value.text;
    if (textAltura.isEmpty) {
      return 'Alura não pode ser vazia';
    }
    return null;
  }

  String? get _errorTextPeso {
    final textPeso = pesoController.value.text;
    if (textPeso.isEmpty) {
      return 'Peso não pode ser vazio';
    }
    return null;
  }

  _showSimpleModalDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 350),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    if (resultadoIMC < 18.5)
                      // Situação: Abaixo do peso
                      Text('Abaixo do peso: $resultadoIMCFormatted')
                    else if (resultadoIMC >= 18.5 && resultadoIMC < 24.9)
                      // Situação: Peso normal
                      Text('Peso normal: $resultadoIMCFormatted')
                    else if (resultadoIMC >= 24.9 && resultadoIMC < 29.9)
                      // Situação: Sobrepeso
                      Text('Sobrepeso: $resultadoIMCFormatted')
                    else if (resultadoIMC >= 29.9 && resultadoIMC < 34.9)
                      // Situação: Obesidade grau 1
                      Text('Obesidade grau 1: $resultadoIMCFormatted')
                    else if (resultadoIMC >= 34.9 && resultadoIMC < 39.9)
                      // Situação: Obesidade grau 2
                      Text('Obesidade grau 2: $resultadoIMCFormatted')
                    else
                      // Situação: Obesidade grau 3
                      Text('Obesidade grau 3: $resultadoIMCFormatted'),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Fechar')),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Cálculo IMC',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Container(
        color: Theme.of(context).colorScheme.secondary,
        padding: const EdgeInsets.all(50),
        child: Column(
          children: [
            TextField(
              controller: pesoController,
              focusNode: pesoFocusNode,
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'e.g. 70',
                hintStyle: const TextStyle(color: Color.fromARGB(80, 255, 255, 255)),
                errorText: pesoFocusNode.hasFocus ? _errorTextPeso : null,
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                border: const OutlineInputBorder(),
                labelText: 'Peso (kg)',
                labelStyle: const TextStyle(
                  color: Colors.white,
                ),
              ),
              onChanged: (text) => setState(() => _text),
            ),
            const SizedBox(height: 50),
            TextField(
              controller: alturaController,
              focusNode: alturaFocusNode,
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'e.g. 180',
                hintStyle: const TextStyle(color: Color.fromARGB(80, 255, 255, 255)),
                errorText: alturaFocusNode.hasFocus ? _errorTextAltura : null,
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                labelText: 'Altura (cm)',
                labelStyle: const TextStyle(
                  color: Colors.white,
                ),
              ),
              onChanged: (text) => setState(() => _text),
            ),
            const SizedBox(height: 100),
            if (pesoController.text.isNotEmpty && alturaController.text.isNotEmpty)
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                      Future.delayed(const Duration(milliseconds: 3000), () {
                        setState(() {
                          isLoading = false;
                          _showSimpleModalDialog(context);
                          alturaController.clear();
                          pesoController.clear();
                        });
                      });
                    });
                    double alturaMetros = double.parse(alturaController.text) / 100;
                    double resultadoIMC = int.parse(pesoController.text) / (alturaMetros * alturaMetros);
                    resultadoIMCFormatted = resultadoIMC.toStringAsFixed(1);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.tertiary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 20,
                    ),
                  ),
                  child: !isLoading
                      ? const Text(
                          'Calcular',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        )
                      : const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ))
          ],
        ),
      ),
    );
  }
}
