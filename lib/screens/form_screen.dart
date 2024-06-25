import 'package:ficha_de_ponto/providers/pontos_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _nomeController = TextEditingController();
  bool _isSaida = false;

  void _submitForm() {
    final nome = _nomeController.text;
    if (nome.isEmpty) return;

    Provider.of<PontosProvider>(context, listen: false).adicionarPonto(nome, _isSaida);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text('Registrar Ponto')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome do Funcionário'),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Saída'),
                  Checkbox(
                    value: _isSaida,
                    onChanged: (value) {
                      setState(() {
                        _isSaida = value!;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Registrar Ponto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
