import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class AporteForm extends StatefulWidget {
  @override
  _AporteFormState createState() => _AporteFormState();
}

class _AporteFormState extends State<AporteForm> {

  var _myFormKey = GlobalKey<FormState>();
  var inputValor = MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  var inputSaldoAnterior = MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');

  _submit(){
    if(_myFormKey.currentState.validate()){
      Scaffold
        .of(context)
        .showSnackBar(
          SnackBar(
            content: Text('Ok!'),
            )
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white ,
        appBar: AppBar(
          title: Text('Novo Aporte'),
        ),
        body: Form(
          key: _myFormKey,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child:
              Column(
                children: [

                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Ano'
                    ),
                    validator: (value){
                      if(value.isEmpty){
                        return 'Informe o Ano';
                      }
                      int ano = int.parse(value);
                      if(ano < 1970 || ano > 9999){
                        return 'Ano Inválido!';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Mês'
                    ),
                    validator: (value){
                      if(value.isEmpty){
                        return 'Informe o mês';
                      }
                      int mes = int.parse(value);
                      if(mes < 1 || mes > 12){
                        return 'Mês Inválido!';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: inputSaldoAnterior,
                    decoration: InputDecoration(
                      labelText: 'Saldo Anterior'
                    ),
                    validator: (value){
                      if(value.isEmpty){
                        return 'Informe o Saldo Anterior';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: inputValor,
                    decoration: InputDecoration(
                      labelText: 'Valor Aporte'
                    ),
                    validator: (value){
                      if(value.isEmpty){
                        return 'Valor Aporte';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: RaisedButton.icon(
                      
                      label: Text('Salvar'),
                      icon: Icon(Icons.save),
                      onPressed: _submit,
                      color: Colors.lightBlue,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                    ),
                  )
                  
                ],
              ),
          ),

        )
    );
  }
}