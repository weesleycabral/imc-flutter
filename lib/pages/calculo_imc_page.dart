import 'package:calc_imc/presenter/calculo_imc_presenter.dart';
import 'package:flutter/material.dart';

class CaculoImcPage extends StatefulWidget {
  const CaculoImcPage({super.key});

  @override
  State<CaculoImcPage> createState() => _CaculoImcPageState();
}

class _CaculoImcPageState extends State<CaculoImcPage> {
  late CalculoImcPresenter presenter;

  @override
  void initState() {
    super.initState();
    init();
    presenter.pesoFocusNode.addListener(() {
      setState(() {});
    });

    presenter.alturaFocusNode.addListener(() {
      setState(() {});
    });
  }

  init() {
    presenter = CalculoImcPresenter(widget, context);
  }

  @override
  void dispose() {
    presenter.pesoFocusNode.dispose();
    presenter.alturaFocusNode.dispose();

    super.dispose();
  }

  String? get _errorTextAltura {
    final textAltura = presenter.alturaController.value.text;
    if (textAltura.isEmpty) {
      return 'Altura não pode ser vazia';
    }
    return null;
  }

  String? get _errorTextPeso {
    final textPeso = presenter.pesoController.value.text;
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
            backgroundColor: Theme.of(context).colorScheme.secondary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 200),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Column(
                      children: <Widget>[
                        Text(
                          'IMC: ${presenter.resultadoIMCFormatted}',
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        if (presenter.resultadoIMC < 18.5)
                          // Situação: Abaixo do peso
                          const Text(
                            'Abaixo do peso',
                            style: TextStyle(color: Color(0xff9E9E9E)),
                          )
                        else if (presenter.resultadoIMC >= 18.5 && presenter.resultadoIMC < 24.9)
                          // Situação: Peso normal
                          const Text(
                            'Peso normal',
                            style: TextStyle(color: Color(0xff9E9E9E)),
                          )
                        else if (presenter.resultadoIMC >= 24.9 && presenter.resultadoIMC < 29.9)
                          // Situação: Sobrepeso
                          const Text(
                            'Sobrepeso',
                            style: TextStyle(color: Color(0xff9E9E9E)),
                          )
                        else if (presenter.resultadoIMC >= 29.9 && presenter.resultadoIMC < 34.9)
                          // Situação: Obesidade grau 1
                          const Text(
                            'Obesidade grau 1',
                            style: TextStyle(color: Color(0xff9E9E9E)),
                          )
                        else if (presenter.resultadoIMC >= 34.9 && presenter.resultadoIMC < 39.9)
                          // Situação: Obesidade grau 2
                          const Text(
                            'Obesidade grau 2',
                            style: TextStyle(color: Color(0xff9E9E9E)),
                          )
                        else
                          // Situação: Obesidade grau 3
                          const Text(
                            'Obesidade grau 3',
                            style: TextStyle(color: Color(0xff9E9E9E)),
                          ),
                      ],
                    ),
                    const SizedBox(height: 65),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.all(8),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.tertiary,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Fechar',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
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
              controller: presenter.pesoController,
              focusNode: presenter.pesoFocusNode,
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'e.g. 70',
                hintStyle: const TextStyle(color: Color.fromARGB(80, 255, 255, 255)),
                errorText: presenter.pesoFocusNode.hasFocus ? _errorTextPeso : null,
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
              onChanged: (text) => setState(() => presenter.text),
            ),
            const SizedBox(height: 50),
            TextField(
              controller: presenter.alturaController,
              focusNode: presenter.alturaFocusNode,
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'e.g. 180',
                hintStyle: const TextStyle(color: Color.fromARGB(80, 255, 255, 255)),
                errorText: presenter.alturaFocusNode.hasFocus ? _errorTextAltura : null,
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
              onChanged: (text) => setState(() => presenter.text),
            ),
            const SizedBox(height: 100),
            if (presenter.pesoController.text.isNotEmpty && presenter.alturaController.text.isNotEmpty)
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      presenter.isLoading = true;
                      Future.delayed(const Duration(milliseconds: 3000), () {
                        setState(() {
                          presenter.isLoading = false;
                          _showSimpleModalDialog(context);
                          presenter.alturaController.clear();
                          presenter.pesoController.clear();
                        });
                      });
                    });
                    double alturaMetros = double.parse(presenter.alturaController.text) / 100;
                    presenter.resultadoIMC = int.parse(presenter.pesoController.text) / (alturaMetros * alturaMetros);
                    presenter.resultadoIMCFormatted = presenter.resultadoIMC.toStringAsFixed(1);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.tertiary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 20,
                    ),
                  ),
                  child: !presenter.isLoading
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
