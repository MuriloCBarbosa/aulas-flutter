import 'package:calculadora_imc/pessoa.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

enum SingingCharacter { masculino, feminino }

SingingCharacter _character = SingingCharacter.masculino;

class _HomeState extends State<Home> {
  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _result;
  double _imc;
  String _generoText;

  Color _corClassificacao;

  @override
  void initState() {
    super.initState();
    resetFields();
  }

  void resetFields() {
    _weightController.text = '';
    _heightController.text = '';
    _generoText = '';
    setState(() {
      _result = 'Informe seus dados';
      _imc = 0;
      _corClassificacao = Colors.black38;
    });
  }

  void setPessoa(){

    setState(() {

      if (_character == SingingCharacter.masculino){
          _generoText = 'masculino';
      }
      else{
          _generoText = 'feminino';
      }

      Pessoa pessoa = Pessoa(double.parse(_weightController.text), double.parse(_heightController.text), _generoText);
                                  
      _imc = pessoa.calcularImc();
      _result = "IMC = ${_imc.toStringAsPrecision(3)}\n" + pessoa.classificarImc(_imc);
      _corClassificacao = pessoa.corClassificacao;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calculadora de IMC'),
          backgroundColor: Colors.blue,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                resetFields();
              },
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Peso (kg)'),
                      controller: _weightController,
                      validator: (text) {
                        return text.isEmpty ? "Insira seu peso!" : null;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Altura (cm)'),
                      controller: _heightController,
                      validator: (text) {
                        return text.isEmpty ? "Insira sua altura!" : null;
                      },
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Column(
                           children: <Widget>[
                           ListTile(
                              title: const Text('Homem'),
                              leading: Radio(
                              value: SingingCharacter.masculino,
                              groupValue: _character,
                              activeColor: Colors.blue,
                              onChanged: (SingingCharacter value) {
                              setState(() { _character = value; });
                              }
                              )
                              ),
                           ListTile(
                              title: const Text('Mulher'),
                              leading: Radio(
                              value: SingingCharacter.feminino,
                              groupValue: _character,
                              activeColor: Colors.pink,
                              onChanged: (SingingCharacter value) {
                              setState(() { _character = value; });
                              }
                              )
                              )
                          ]
                          )
                          ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Text(_result, textAlign: TextAlign.center, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: _corClassificacao)),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 30.0),
                        child: Container(
                            height: 50,
                            child: RaisedButton(
                              color: Colors.red,
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  setPessoa();
                                }
                              },
                              child: Text('CALCULAR', style: TextStyle(color: Colors.white)),
                            )))                  
                ]
              )
          )
        )
    );
  }
}