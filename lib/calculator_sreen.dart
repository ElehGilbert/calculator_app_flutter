

import 'package:flutter/material.dart';
import'button_values.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String number1 = ""; //. 0-9
   String operand = ""; // + - x /
    String number2 = ""; // . 0 - 9


  @override
  Widget build(BuildContext context) {
    //Getting screen size
  final screenSize=MediaQuery.of(context).size;//This will give me the screen size

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
          //Output
            Expanded(
              child: SingleChildScrollView ( //to make long output scrollable

                reverse: true,// To make the output display at the button right

                child: Container(

                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "$number1$operand$number2".isEmpty?"0":
                    "$number1$operand$number2" , //To make out 0 when theres no input else display input
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.end,
                  ),
                ),
              ),
            ),

          //buttons
        Wrap(
          children: Btn.buttonValues
          .map(
            (value) => SizedBox(
              width: value==Btn.calculate?screenSize.width/2: (screenSize.width/4), //This is the button width
              height: screenSize.width/5 , // button height
              child: buildButton(value)),
          )
          .toList(),
        )

        ],
        ),
      ),
    );
  }
  //######
    Widget buildButton(value){

      //using InWell because we want to make button Tappable
      return Padding(

        padding: const EdgeInsets.all(4.0),

        child: Material(
          color : getBtnColor(value),// CALLING COLOR FUNCTION

          clipBehavior: Clip.hardEdge,//arranging splash effect on tap so it doesnt splash beyond the border
          shape: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blueAccent,
            ),
            borderRadius: BorderRadius.circular(100)),//Button Radius


          child: InkWell(
            onTap:() => onBtnTap(value),
            child: Center(
              child: Text(value,
              style: const TextStyle(fontWeight: FontWeight.bold,
              fontSize:24,),), //Styling Button Text
              ),
          ),
        ),
      );
    }
void onBtnTap(String value){
  //checking if delete button is pressed
  if(value==Btn.del){
    delete();
    return;

  }

  //If clear Button is pressed

  if(value==Btn.clr){
    clearAll();
    return;

  }

  //Checking for PERCENTAGE
  if(value==Btn.per){
    ConvertToPercentage();
  }

if(value == Btn.calculate){
  calculate();
  return;
}




  appendValue(value);
}


    //#########################
    //Calculate the result thats the "EQUAL TO"

  void calculate(){
    // if (number1.isEmpty) return;
    // if (operand.isEmpty) return;
    // if (number2.isEmpty) return;

  //################################################################################
    //Creating Varaibles to use for a switch case for a Selection(),
  final double num1=double.parse(number1);
  final double num2=double.parse(number2);

    var result = 0.0;

    switch(operand)
    {
      case Btn.add:
      result=num1+num2;
      break;

      case Btn.subtract:
      result=num1-num2;
      break;

      case Btn.multiply:
      result=num1*num2;
      break;

      case Btn.divide:
      result=num1/num2;
      break;

      default:
      throw Exception('Invalid Expression');
    }

//Now lets run you amigo

setState((){

  number1 = "$result";



  //Making sure number comes as a whole number withiout .0 where not important
  //Removing last 2 number
  if(number1.endsWith(".0"))
  {
   // const string = 'dartlang';

 number1=number1.substring(0, number1.length -2);
}

operand = "";
//number1 = ""; //Value Assigned to number 1
number2 = "";



});

  }






//#############################
//Converts Output to percentage
void ConvertToPercentage() {



  //ex ample 434+324
  if(number1.isNotEmpty && operand.isEmpty && number2.isNotEmpty) {}
//Calculate before conversion

//"To dO"
calculate();
//final res = number1 operand number2
//number = res;


//cannot be could
if(operand.isNotEmpty){
  //Cannot be converted
  return;
}
final number = double.parse(number1);
setState(() {
  number1="${number/100}";//converting the % number to percentage
operand="";
number2 = "";//

});
}



//#########
//Clears all outputs
void clearAll(){
    setState(() {
      number1 = "";
    operand = "";
        number2 = "";
    });

}




//#######
//Delete one from the end
void delete(){
  if(number2.isNotEmpty){
    //1234=>123
    number2=number2.substring(0,number2.length-1);
  } else if(operand.isNotEmpty){
    operand = "";

  }else if(number1.isNotEmpty){
    number1=number1.substring(0,number1.length-1);
  }
  //Applying Removing the number
  setState(() {});
}




//######################################
//appends value to the end
void appendValue(String value){
  //#####


  // number1 operand number2
  //  234      +      5343
  //checking if it is operand and not "dot(.)"
  if(value!=Btn.dot&&int.tryParse(value)==Null){
    //  Operand Pressed
    if(operand.isNotEmpty&&number2.isNotEmpty){


      // 'TODO calculate the equation before assigning new

      //checking if theres already an operand
      calculate();
    }
    operand = value;

    //assigning Value to number1 variable
  } else if(number1.isEmpty || operand.isEmpty){

    //checking if value is "."
    //"21242" "+" ""
    //example: number1 =1.2

    if(value == Btn.dot && number1.contains(Btn.dot)) return;
    //case: number1 = "." | 0
    if(value == Btn.dot && (number1.isEmpty || number1 == Btn.n0)){
  value="0.";
  }
  number1 += value;

  //#### Assign Value to number2 variable
  }
  else if(number2.isEmpty || operand.isNotEmpty){
    //checking if value is "."
    //"21242" "+" ""
    // example: number2 =1.2

    if(value == Btn.dot && number1.contains(Btn.dot)) return;
    //case: number2 = "." | 0
  if(value == Btn.dot && (number2.isEmpty || number2 == Btn.n0)){
  value="0.";
  }
  number2 += value;
  }


  setState((){
  //number1 += value;  //Making each tap value to be displayed
 // operand += value;
 // number2 += value;
});
}
}



    //Creating a function for Btn colors
//######
    Color getBtnColor(value){
      return  [Btn.del,Btn.clr,].contains(value)? Colors.blueGrey
          :[Btn.per,
          Btn.multiply,
          Btn.add,
          Btn.subtract,
          Btn.divide,
          Btn.calculate,
          ].contains(value)? Colors.blue: Colors.black;

    }




  
