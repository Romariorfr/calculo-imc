import 'package:calculadora_imc/componentes/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widgets _widgets = new Widgets();

  final String titleAppBar = "Calculadora imc";
  final String tagPeso = "Peso (kg)";
  final String tagAltura = "Altura (cm)";
  final String tagBotaoCalc = "Calcular";
  final String tagErrorweight = "Insira seu peso";
  final String tagErrorHeight = "Insira sua altura";
  String infoText = "Informe seus dados";


  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  double imc = 0;

  void _resetFields() {
    setState(() {
      //clear fields textfields
      weightController.text = "";
      heightController.text = "";
      infoText = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculateImc() {
    //get weight and height and calculate a imc
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100;

    //applying an imc formula and return result imc
    imc = weight / (height * height);
  }

  void _showInfoText() {
    setState(() {
      if (imc < 18.6) {
        infoText = "Abaixo do peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        infoText = "Peso ideal (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        infoText = "Levemente acima do Peso(${imc.toStringAsPrecision(3)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        infoText = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 40) {
        infoText = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(titleAppBar),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  _resetFields();
                });
              },
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.person_outline,
                    size: 120.0,
                    color: Colors.green,
                  ),
                  _widgets.userInput(weightController, tagPeso, tagErrorweight),
                  _widgets.userInput(
                      heightController, tagAltura, tagErrorHeight),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _calculateImc(); //only calculate imc

                            //compare imc result and show infoText menssage
                            _showInfoText();
                          }
                        },
                        child: Text(
                          tagBotaoCalc,
                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                        ),
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Text(
                    infoText,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25.0),
                  )
                ],
              ),
            )));
  }
}
