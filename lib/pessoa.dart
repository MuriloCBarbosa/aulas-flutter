import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Pessoa {

  double peso, altura;
  String genero;
  Color corClassificacao;

  Pessoa(this.peso, this.altura, this.genero);

  Color getColor(){
    return corClassificacao;
  }
  
 double calcularImc() {
    altura = altura / 100;
    double imc = peso / (altura * altura);
    return imc;
 }

 String classificarImc (double imc){

      String _result = "";

      if (genero == "masculino"){
        if (imc < 20.7){
           _result += "Abaixo do peso";
           corClassificacao = Colors.redAccent;
        }
        else if (imc < 26.5){
          _result += "Peso ideal";
          corClassificacao = Colors.green;
        }
        else if (imc < 27.9){
          _result += "Pouco acima do peso";
          corClassificacao = Colors.yellow;
        }
        else if (imc < 31.2){
          _result += "Acima do peso";
          corClassificacao = Colors.orange;
        }
        else{
         _result += "Obesidade";
         corClassificacao = Colors.red;
        }    
      }
      
      if (genero == "feminino"){
        if (imc < 19.1){
           _result += "Abaixo do peso";
           corClassificacao = Colors.redAccent;
        }
        else if (imc < 25.9){
          _result += "Peso ideal";
          corClassificacao = Colors.green;
        }
        else if (imc < 27.4){
          _result += "Pouco acima do peso";
          corClassificacao = Colors.yellow;
        }
        else if (imc < 32.4){
          _result += "Acima do peso";
          corClassificacao = Colors.orange;
        } 
        else{
         _result += "Obesidade";
         corClassificacao = Colors.red;
        }        
      }

    return _result;
  }
}