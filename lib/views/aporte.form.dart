import 'package:InvestAportes/infra/aporte.service.dart';
import 'package:InvestAportes/model/aporte.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:google_fonts/google_fonts.dart';

class AporteForm extends StatefulWidget {
  @override
  _AporteFormState createState() => _AporteFormState();
}

class _AporteFormState extends State<AporteForm> {

  var _myFormKey = GlobalKey<FormState>();
  var model = Aporte();
  var inputValor = MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  var inputSaldoAnterior = MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  var service = AporteService();
  var isLoading = false;

  Future<void> _submit() async {
    setState(() {
      isLoading = true;
    });
    if(_myFormKey.currentState.validate()){
      _myFormKey.currentState.save();
      await service.saveAporte(model);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var textStyle = GoogleFonts.quicksand(
      textStyle: TextStyle(color: Colors.white)
    );
    return Scaffold(
        backgroundColor: Colors.white ,
        appBar: AppBar(
          title: Text('Novo Aporte', style: textStyle,),
        ),
        body: isLoading ? 
        Center(child: CircularProgressIndicator(),)
          :
        Form(
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
                    onSaved: (value) => model.ano = int.parse(value),
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
                    onSaved: (value) => model.mes = int.parse(value),
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
                    onSaved: (value) {
                      var formatted = value.replaceAll('.', '').replaceAll(',', '.');
                      var doubleValue = double.parse(formatted);
                      model.saldoAnterior = doubleValue;
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
                    onSaved: (value) {
                      var formatted = value.replaceAll('.', '').replaceAll(',', '.');
                      var doubleValue = double.parse(formatted);
                      model.valor = doubleValue;
                    },
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: RaisedButton.icon(
                      label: Text('Salvar', style: textStyle,),
                      icon: Icon(Icons.save),
                      onPressed: () async {
                         await _submit();
                         Scaffold.of(context).showSnackBar(SnackBar(content: Text('Salvo com sucesso!'),));
                      },
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