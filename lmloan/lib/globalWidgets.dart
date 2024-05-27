
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lmloan/provider/loan/loan_provider.dart';
import 'package:lmloan/styles/color.dart';

// ignore: must_be_immutable
class ElavatedButton extends StatelessWidget {
 Function() onPressed ;
  String text;
  Color textColor;
  Color bodyColor;
  double elavation;

  ElavatedButton(this.text,this.textColor,this.bodyColor , this.onPressed ,this.elavation );


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed:onPressed,
      style:

      ElevatedButton.styleFrom(
    fixedSize: Size(150, 45),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: elavation, backgroundColor: bodyColor
      ), child: Text(
        text,
        style: TextStyle(
            color: textColor,
                fontSize:17
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class TextWidget extends StatelessWidget {
  FontWeight? weight;

  Color textColor;
  String textBody;

  TextWidget(this.textBody,this.weight,this.textColor);

  @override
  Widget build(BuildContext context) {
    return Text(textBody,
      style: TextStyle(
        color:textColor,
        fontWeight: weight,
        fontSize: 20,
      ),
    );
  }
}



Widget buildDivider(double? width) {
  return Padding(
    padding:  const EdgeInsets.all(1.0),
    child: SizedBox(
      width: width,
      child: const Divider(
        color: grey,
        thickness: 3,
        height: 5,
      ),
    ),
  );
}





Future<dynamic> buildShowProgress(BuildContext context ) {

  return showDialog(
    context: context,
    builder: (BuildContext context) {

      return Consumer<Code>(
          builder:(context,dataProviderModel,child){
            if( dataProviderModel.successfulCode || dataProviderModel.wrongCode ) {
              print( '3 ${Provider.of<Code>(context , listen: false).wrongCode}');
              print( '4 ${Provider.of<Code>(context , listen: false).successfulCode}');
              Navigator.of(context).pop();
            }
            print( '5 ${Provider.of<Code>(context , listen: false).wrongCode}');
            print( '6 ${Provider.of<Code>(context , listen: false).successfulCode}');
            return Stack(
                children: [
                  ModalBarrier(
                    color:  black.withOpacity(.2),
                  ),
                  const AlertDialog(
                    elevation: 0,
                    shadowColor: null,
                    backgroundColor: transparent,
                    content:SpinKitPouringHourGlassRefined(color: mainOrange,size: 60,
                      duration: Duration(seconds: 2),
                    ),



                  ),
                ]
            );
          });
    },
  );
}