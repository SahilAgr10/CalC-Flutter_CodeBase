import 'package:flutter/material.dart';

class CalcUi extends StatefulWidget {
   const CalcUi({super.key});

  @override
  State<CalcUi> createState() => _CalcUiState();
}

class _CalcUiState extends State<CalcUi> {
  String display = '0';

  Widget equalButton(){
    return Expanded( child: Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.orange.shade900,
      ), child:
      TextButton(
        onPressed: () {  },
        child: const Text('=',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 29)),

      ),),
    ));
  }
  void onNumberPress(String num){
    setState(() {
      if(display=='0'){
        setState(() {
          display='0';
        });
      }
      display+= num;
    });

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
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    display,
                    style: const TextStyle(
                      fontSize: 58.0,
                      color: Colors.black,
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
