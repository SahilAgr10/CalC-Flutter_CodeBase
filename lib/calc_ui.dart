import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalcUi extends StatefulWidget {
   const CalcUi({super.key});

  @override
  State<CalcUi> createState() => _CalcUiState();
}

class _CalcUiState extends State<CalcUi> {
  String input = '0';
  String output = '=0';

  Widget equalButton(){
    return Expanded( child: Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.orange.shade900,
      ), child:
      TextButton(
        onPressed: () { calculate; },
        child: const Text('=',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 29)),
      ),),
    ));
  }
  void calculate(){
    try{
      var parser = Parser();
      var exp = parser.parse(input);
      var context = ContextModel();
      var eResult = exp.evaluate(EvaluationType.REAL,context);
      setState(() {
        output = eResult.toString();
      });
    }catch(e){
      setState(() {
        output='0x00';
      });
    }
  }
  void onNumberPress(String num){
    if(num=='AC') input='0';
    else if(num=='Del'){
      if(num!='0')  input=input.substring(0,input.length-1);
    } else if(num=='Sci') {} else input+=num;
    setState(() {});

  }
  Widget button ( {required String numText,Color textColor = Colors.black,Color backColor= Colors.white}) {
    return (Expanded(
        child:TextButton(
          onPressed: () {
            onNumberPress(numText);
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            backgroundColor: backColor,
            padding: const EdgeInsets.all(30),
            textStyle: const TextStyle(
              fontSize: 8.0,
            ),
          ),
          child: Text(numText,style: TextStyle(color: textColor,fontWeight: FontWeight.w500,fontSize: 24),),
        )
    ));}


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        drawer: const Drawer(
          shadowColor: Colors.white,
        ),
        appBar: AppBar(
          title: const Text('Calculator',style: TextStyle(fontSize: 20,color: Colors.black),),
          toolbarHeight: 60,
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              icon: const Icon(Icons.grid_view_outlined,size: 17,),
              onPressed: () {
                // TODO: Implement grid view functionality
              },
            ),
            IconButton(
              icon: const Icon(Icons.home,size: 20,),
              onPressed: () {
                // TODO: Implement home functionality
              },
            ),
            IconButton(
              icon: const Icon(Icons.more_vert,size: 20,),
              onPressed: () {
                // TODO: Implement more options functionality
              },
            ),
          ],
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.bottomRight,
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 20,right: 15),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      input,
                      style:  TextStyle(
                        fontSize: 54.0,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 20),
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    output,
                    style:  TextStyle(
                      fontSize: 34.0,
                      color: Colors.black45,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
              const Divider(thickness: 1.5,),
              Row(children: [
                button(numText: 'AC',textColor: Colors.orange.shade900,),
                button(numText: "Del",textColor: Colors.orange.shade900),
                button(numText: '%',textColor: Colors.orange.shade900),
                button(numText: '/',textColor: Colors.orange.shade900),],),
              Row(children: [
                button(numText: '7',),
                button(numText: "8"),
                button(numText: '9'),
                button(numText: 'X',textColor: Colors.orange.shade900),

              ],),
              Row(children: [
                button(numText: '4',textColor: Colors.black,),
                button(numText: "5",textColor: Colors.black),
                button(numText: '6',textColor: Colors.black),
                button(numText: '-',textColor: Colors.orange.shade900),

              ],),
              Row(children: [
                button(numText: '1',textColor: Colors.black,),
                button(numText: "2",textColor: Colors.black),
                button(numText: '3',textColor: Colors.black),
                button(numText: '+',textColor: Colors.orange.shade900),

              ],),
              Row(children: [
                button(numText: 'Sci',textColor: Colors.orange.shade900),
                button(numText: "0"),
                button(numText: '.'),
                equalButton()

              ],)
            ]
        ),
      ),
    );
  }
}
