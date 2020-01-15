//Para o "runApp" funcionar, devemos importar a biblioteca "material.dart"
import 'package:flutter/material.dart';

//Função principal
void main() {
  //runApp espera como um parametro um Widget e como padrão passamos sempre o
  //"MaterialApp"
  runApp(MaterialApp(
    home: Home(), //Passando a classe home como um Widget
  ));
}

//Criando uma classe que se chama "Home" e herda da classe "StateFul"
//Pois nossa home terá uma interação com o usuário
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Criando uma variavel do tipo "Global Key".
  GlobalKey<FormState> _form = GlobalKey<FormState>();

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  String _infoText = "Informe seus dados!";

  void _resetFields(){
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
      _form = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      if (imc < 18.6) {
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(3)})";
      } else if (imc > 18.6 && imc < 24.9) {
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(3)})";
      } else if (imc > 24.9 && imc < 29.9) {
        _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(3)})";
      } else if (imc > 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
      } else if (imc > 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 40) {
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.deepPurpleAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _resetFields();
              },
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            //Passando como filho um formulario
            key:
                _form, //Como chave desse formulario, passamos a variavel do global
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.account_circle,
                    size: 120.0, color: Colors.deepPurpleAccent),
                TextFormField(
                  //Trocando para "TextFormField" pois assim teremos uma opção chamada "validator"
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso (Kg)",
                      labelStyle: TextStyle(color: Colors.deepPurpleAccent)),
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 25.0, color: Colors.deepPurpleAccent),
                  controller: weightController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira seu Peso";
                    }
                  },
                ),
                TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Altura (cm)",
                        labelStyle: TextStyle(color: Colors.deepPurpleAccent)),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 25.0, color: Colors.deepPurpleAccent),
                    controller: heightController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira sua Altura";
                      }
                    }),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Container(
                    height: 60.0,
                    child: RaisedButton(
                      onPressed: () {
                        if (_form.currentState.validate()) {
                          _calculate();
                        }
                      },
                      child: Text("Calcular",
                          style:
                              TextStyle(fontSize: 25.0, color: Colors.white)),
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 25.0, color: Colors.deepPurpleAccent),
                ),
              ],
            ),
          ),
        ));
  }
}
