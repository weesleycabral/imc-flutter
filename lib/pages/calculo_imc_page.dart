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

  @override
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
                    RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                          text: "${pesoController.text} / (${alturaController.text} ",
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black, wordSpacing: 1)),
                    ),
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

  String? get _errorTextAltura {
    // at any time, we can get the text from _controller.value.text
    final textAltura = alturaController.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (textAltura.isEmpty) {
      return 'Alura não pode ser vazia';
    }
    // return null if the text is valid
    return null;
  }

  String? get _errorTextPeso {
    // at any time, we can get the text from _controller.value.text
    final textPeso = pesoController.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (textPeso.isEmpty) {
      return 'Peso não pode ser vazio';
    }
    // return null if the text is valid
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              TextField(
                controller: pesoController,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  errorText: _errorTextPeso,
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
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  errorText: _errorTextAltura,
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
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                      Future.delayed(const Duration(milliseconds: 3000), () {
                        setState(() {
                          isLoading = false;
                          _showSimpleModalDialog(context);
                        });
                      });
                    });
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
      ),
    );
  }
}
