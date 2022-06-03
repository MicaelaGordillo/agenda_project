import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../clases/tarea.dart';

class ScreenWork extends StatefulWidget {
  const ScreenWork({Key? key}) : super(key: key);

  @override
  State<ScreenWork> createState() => _ScreenWorkState();
}

class _ScreenWorkState extends State<ScreenWork> {
  int _selectedIndex = 0;

  bool isChecked = false;
  //final tareas = List<String>.generate(100, (i) => "Tarea $i");
  List<Tarea> tareas = [];
  final frases = List<String>.generate(20, (i) => "Frase $i");
  late DateTime _myDateTime;
  TextEditingController miVar = TextEditingController();
  TextEditingController valorFechaInicio = TextEditingController();
  TextEditingController valorFechaFinal = TextEditingController();



  void insertTarea(Tarea tarea){
    tareas.add(tarea);
    print('se agregó la tarea');
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agenda',
      home: Scaffold(
        backgroundColor: Colors.white,
        drawer: Drawer(
          backgroundColor:Colors.white ,
          child: Container(
            color: Colors.white, //Color de fondo del drawer
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top:20, bottom: 0),
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,//Toma el largo horizontal
                  //color: Colors.grey[100], //Color de fondo
                  child: Column(
                    children: const [
                      Text(
                        'Bienvenid@',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(   //Espacio entre textos
                        height: 10,
                      ),
                      Text(
                        'Estas son las frases que puedes utilizar para realizar acciones en la aplicación sin necesidad de escribir :)',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                      itemCount: frases.length,
                      itemBuilder: (context, index) => Card(
                        margin: const EdgeInsets.only(bottom: 2),
                        color: Colors.grey[100],
                        child: ListTile(
                          title: Text(frases[index]),
                          subtitle: const Text('Icream is good for health'),
                        ),
                      ),
                    ),
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(226, 221, 235, 1),
        ),
        body: CustomPaint(
          painter: BluePainter(),
          child: Container(
            margin: const EdgeInsets.only(top: 25, right: 35, left: 35, bottom: 25),
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)
              ),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.4),
                  offset: Offset(0, 0.75),
                  blurRadius: 25
                )
              ],
            ),
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color.fromRGBO(226, 221, 235, 100),
                        width: 3.0,
                      ),
                    )
                  ),
                  child: ListTile(
                    leading: Image.asset('assets/check.png', height: 35),
                    title: const Text(
                      'Todas las tareas',
                      style: TextStyle(
                          color: Color.fromRGBO(181, 156, 232, 1),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Quicksand')
                    ),
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                      itemCount: tareas.length,
                      itemBuilder: (context, index) => Card(
                        margin: const EdgeInsets.only(bottom: 2),
                        child: ListTile(
                          leading: Checkbox(
                            activeColor: const Color.fromRGBO(169, 151, 196, 1),
                            value: tareas[index].terminada,
                            onChanged: (value) {
                              setState(() {
                                print(index);
                                isChecked = value!;
                                if(tareas[index].terminada){
                                  tareas[index].terminada = false;
                                }else{
                                  tareas[index].terminada = true;
                                }
                              });
                            },
                          ),
                          title: Text(tareas[index].descripcion, style: TextStyle(fontFamily: 'DidactGothic')),
                          //subtitle: Text('Icream is good for health'),
                          trailing: CircleAvatar(
                            backgroundColor: const Color.fromRGBO(255, 212, 212, 1),
                            radius: 15,
                            child: IconButton(
                              onPressed: (){
                                setState(() {
                                  print(index);
                                  tareas.removeAt(index);
                                });
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Stack(
          children: [
            Positioned(
              right: 15,
              top: 90,
              child: Container(
                height: 50,
                width: 50,
                child: FloatingActionButton(
                  child: const Icon(Icons.mic, size: 30, color: Color.fromRGBO(169, 151, 196, 1),),
                  backgroundColor: const Color.fromRGBO(226, 221, 235, 1),
                  onPressed: (){
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 15,
              right: 40,
              child: SizedBox(
                height: 40,
                width: 40,
                child: FloatingActionButton(
                  child: const Icon(Icons.add, size: 30,color: Color.fromRGBO(169, 151, 196, 1)),
                  backgroundColor: const Color.fromRGBO(226, 221, 235, 1),
                  onPressed: (){
                    modalAddTarea(context);
                  },
                ),
              ),
            ),
            // Add more floating buttons if you want
            // There is no limit
          ],
        ),
      ),
    );
  }
  modalAddTarea(BuildContext context){
    Widget okButton = TextButton(
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(169, 151, 196, 1))),
        onPressed: (){
          setState(() {
            Navigator.of(context).pop();
            print(miVar.text);
            var tarea = Tarea(
                cod_tarea: 1,
                descripcion: miVar.text,
                fecha_inicio: valorFechaInicio.text,
                terminada: false
            );
            insertTarea(tarea);
            miVar.text='';
            valorFechaFinal.text = '';
            valorFechaInicio.text = '';

          });
        },child: const Text('OK', style: TextStyle(fontSize: 15, color: Colors.white),)
    );
    Widget cancelButton = TextButton(
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(255, 191, 176, 1))),
        onPressed: (){
          setState(() {
            Navigator.of(context).pop();
            miVar.text='';
            valorFechaFinal.text = '';
            valorFechaInicio.text = '';
          });
        },child: const Text('Cancelar', style: TextStyle(fontSize: 15, color: Colors.white),)
    );

    AlertDialog alert = AlertDialog(
      title: const Text('Ingresar nueva tarea', style: TextStyle(color: Color.fromRGBO(56, 56, 56, 1))),
      content:
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: <Widget>[
              const Text('Tarea:', style: TextStyle(fontSize: 14),),
              const SizedBox(width: 4,),
              Expanded(
                child: TextField(
                  style:const TextStyle(fontSize: 14),
                  controller: miVar,
                  decoration: const InputDecoration(
                    hintText: 'Ingresa una tarea',
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding: EdgeInsets.all(6),
                  ) ,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6,),
          Row(
            children: <Widget>[
              const Text('Fecha inicio:',style: TextStyle(fontSize: 14)),
              const SizedBox(width: 4,),
              Expanded(
                child: TextField(
                  style: const TextStyle(fontSize: 14),
                  controller: valorFechaInicio,
                  keyboardType: TextInputType.none,
                  decoration: const InputDecoration(
                      hintText: 'Ingresa una fecha',
                      border: OutlineInputBorder(),
                      isDense: true,
                      contentPadding: EdgeInsets.all(6)
                  ) ,
                ),
              ),
              const SizedBox(width: 4,),
              SizedBox(
                  height: 30,
                  width: 30,
                  child: RawMaterialButton(
                      fillColor: const Color.fromRGBO(169, 151, 196, 1),
                      shape: const CircleBorder(),
                      elevation: 0.0,
                      child: const Icon(Icons.date_range, color: Colors.white, size: 17,),
                      onPressed: () async{
                        _myDateTime = (await showDatePicker(
                            firstDate: DateTime(2010),
                            initialDate: DateTime.now(),
                            context: context,
                            lastDate: DateTime(2030)
                        ))!;
                        setState((){
                          valorFechaInicio.text = DateFormat('dd-MM-yy').format(_myDateTime);
                        });
                      }
                  )
              )
            ],
          ),
          const SizedBox(height: 6,),
          Row(
            children: <Widget>[
              const Text('Fecha final:', style: TextStyle(fontSize: 14)),
              const SizedBox(width: 10,),
              Expanded(
                child: TextField(
                  style: const TextStyle(fontSize: 14),
                  controller: valorFechaFinal,
                  keyboardType: TextInputType.none,
                  decoration: const InputDecoration(
                    hintText: 'Ingresa una fecha',
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding: EdgeInsets.all(6),
                  ) ,
                ),
              ),
              const SizedBox(width: 4,),
              SizedBox(
                  height: 30,
                  width: 30,
                  child: RawMaterialButton(
                      fillColor: const Color.fromRGBO(169, 151, 196, 1),
                      shape: const CircleBorder(),
                      elevation: 0.0,
                      child: const Icon(Icons.date_range, color: Colors.white, size: 17,),
                      onPressed: () async{
                        _myDateTime = (await showDatePicker(
                            firstDate: DateTime(2010),
                            initialDate: DateTime.now(),
                            context: context,
                            lastDate: DateTime(2030)
                        ))!;
                        setState((){
                          valorFechaFinal.text = DateFormat('dd-MM-yy').format(_myDateTime);
                        });
                      }
                  )
              )

            ],
          ),
        ],
      ),
      actions: [
        cancelButton,okButton
      ],
    );

    showDialog(
      context: context,
      barrierDismissible: false, //modal
      builder: (BuildContext dialogContext){
        return alert;
      },
    );
  }

}

class BluePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;

    Paint circleGrey = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color.fromRGBO(230, 230, 230, 1)
      ..strokeWidth = 2;

    Paint circlePink = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color.fromRGBO(242, 217, 229, 1)
      ..strokeWidth = 2;

    canvas.drawCircle(Offset(width*0.05, height*0.23), 100, circleGrey);
    canvas.drawCircle(Offset(width*0.9, height*0.7), 100, circlePink);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
