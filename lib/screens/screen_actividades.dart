import 'package:agenda_project/clases/actividad.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

class ScreenActividades extends StatefulWidget {
  List<Actividad> activities;
  ScreenActividades(this.activities);

  @override
  State<ScreenActividades> createState() => _ScreenActividadesState();
}

class _ScreenActividadesState extends State<ScreenActividades> {
  List<Color> colores = [Color.fromRGBO(245, 214, 199, 1),Color.fromRGBO(250, 246, 200, 1),Color.fromRGBO(211, 240, 210, 1),Color.fromRGBO(238, 235, 245, 1)];
  List<Color> coloresText = [Color.fromRGBO(173, 66, 60, 1),Color.fromRGBO(117, 110, 8, 1),Color.fromRGBO(63, 157, 47, 1),Color.fromRGBO(113, 86, 150, 1)];
  late DateTime _myDateTime;
  late TimeOfDay _myTime;
  bool isChecked = false;
  List<Actividad> actividades = [];
  List<String> frases = [];
  TextEditingController miVar = TextEditingController();
  TextEditingController valorHoraInicio = TextEditingController();
  TextEditingController valorHoraFinal = TextEditingController();
  TextEditingController valorFechaInicio = TextEditingController();
  TextEditingController valorFechaFinal = TextEditingController();

  List<String> frasesClave (){
    List<String> aux = [];
    aux.add('ABRIR MENU te permite abrir el modal para agregar una nueva actividad');
    aux.add('AÑADIR ACTIVIDAD te permite agregar una nueva actividad utilizando la asistente por voz');
    aux.add('ELIMINAR ACTIVIDAD te permite eliminar una actividad utilizando la asistente por voz');
    aux.add('CANCELAR te permite cancelar cualquier proceso en cualquier instante');
    return aux;
  }

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void insertActividad(Actividad actividad){
    actividades.add(actividad);
    print('se agregó la actividad');
  }

  @override
  Widget build(BuildContext context) {
    actividades = widget.activities;
    frases = frasesClave();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agenda',
      home: Scaffold(
        drawer: Drawer(
          child: Container(
            color: Colors.white, //Color de fondo del drawer
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top:45),
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
                      SizedBox(   //Espacio entre textos
                        height: 10,
                      ),
                      Text(
                        'No olvides que después de activar alguna opción debes seguir las instrucciones de la asistente por voz.',
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
                        title: Text('${frases[index]}'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(233, 240, 215, 1),
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
                    leading: Image.asset('assets/arco_iris.png', height: 35),
                    title: const Text(
                      'Todas las actividades',
                      style: TextStyle(
                        color: Color.fromRGBO(189, 211, 135, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Quicksand'
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: actividades.length,
                    itemBuilder: (context, index) => Card(
                      color: colores[index%4],
                      margin: const EdgeInsets.only(top:9,right: 10, left: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ListTile(
                        
                        title: Text('${actividades[index].descripcion}', style: TextStyle(fontFamily: 'DidactGothic', color: Color.fromRGBO(56, 56, 56, 1)),),
                        //subtitle: Text('Icream is good for health'),
                        trailing: 
                        Row(
                          mainAxisSize: MainAxisSize.min,

                          children: [
                            Text('${actividades[index].hora_inicio} - ${actividades[index].hora_final}',style: TextStyle(color: coloresText[index%4], fontFamily: 'DidactGothic')),
                            SizedBox(width: 10)
                            ,CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 15,
                              child: IconButton(
                                onPressed: (){
                                  setState(() {
                                    print(index);
                                    actividades.removeAt(index);
                                  });
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.grey,
                                  size: 15,
                                ),
                              ),
                            ),
                          ],),
                        
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
                  child: const Icon(Icons.mic, size: 30, color: Color.fromRGBO(189, 211, 135, 1),),
                  backgroundColor: Color.fromRGBO(233, 240, 215, 1),
                  onPressed: _listen,
                ),
              ),
            ),
            Positioned(
              bottom: 15,
              right: 40,
              child: Container(
                height: 40,
                width: 40,
                child: FloatingActionButton(
                  child: const Icon(Icons.add, size: 30, color: Color.fromRGBO(189, 211, 135, 1),),
                  backgroundColor: const Color.fromRGBO(233, 240, 215, 1),
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
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = '';
  FlutterTts flutertts = FlutterTts();
  bool eliminar = true;
  int controlador = 0;
  String descripcionActividad = '';
  int dia = -1, mes = -1, hora1 = -1, hora2 = -1;
  String fechaActividad = '', horaInicioActividad = '', horaFinalActividad = '';

  void _read (String text) async{
    await flutertts.setLanguage('es-ES');
    await flutertts.setPitch(1);
    await flutertts.speak(text);
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            print(_text);
            if(_text.contains('Abrir menú') || _text.contains('abrir menú')){
              modalAddTarea(context);
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
      print(_text);
      print(controlador);
      if(_text.isEmpty){
        _read('No se le escuchó, puede repetir por favor');
      } else {
        if (_text.contains('cancelar') || _text.contains('Cancelar')){
          _read('Proceso cancelado');
          controlador = 0;
          eliminar = true;
          _text = '';
        } else if(_text.contains('Eliminar actividad')|| _text.contains('eliminar actividad')){
          _read('Ok!, dime el título de la actividad que quieres eliminar');
          eliminar = false;
          controlador = 0;
          _text = '';
        } else {
          if (eliminar) {
            if(controlador==0){
              if(_text.contains('añadir actividad') || _text.contains('Añadir actividad')){
                _read('Hola!, por favor dime la descripción de la actividad que quieres añadir');
                controlador = 1;
              } else {
                _read('Ocurrio un error puede repetir la orden por favor');
              }
            } else if (controlador==1){
              _read('Indique el día en el que se realizará la actividad');
              descripcionActividad = _text;
              print('Descripcion: '+descripcionActividad);
              controlador = 2;
            } else if (controlador==2){
              try {
                dia = int.parse(_text);
                _read('Indique el mes en el que se realizará la actividad');
                controlador = 3;
              } on FormatException {
                _read("No es un día, por favor intente de nuevo");
              }
            } else if (controlador==3){
              if (comprobarMes(_text)>0) {
                mes = comprobarMes(_text);
                _read('Indique el año en el que se realizará la actividad');
                controlador = 4;
              } else {
                _read("No es un mes, por favor intente de nuevo");
              }
            } else if (controlador==4){
              try {
                int anio = int.parse(_text);
                if(dia<10){
                  if(mes<10){
                    fechaActividad = '$anio-0$mes-0$dia';
                  } else {
                    fechaActividad = '$anio-$mes-0$dia';
                  }
                } else {
                  if(mes<10){
                    fechaActividad = '$anio-0$mes-$dia';
                  } else {
                    fechaActividad = '$anio-$mes-$dia';
                  }
                }
                _read("Indique solo la hora de inicio de la actividad");
                controlador = 5;
              } on FormatException {
                _read("No es un año, por favor intente de nuevo");
              }
            } else if (controlador==5) {
              try {
                hora1 = int.parse(_text);
                _read('Indique solo los minutos de inicio de la actividad');
                controlador = 6;
              } on FormatException {
                _read("No es una hora, por favor intente de nuevo");
              }
            } else if (controlador==6) {
              try {
                int min1 = int.parse(_text);
                if(hora1<10){
                  if(min1<10){
                    horaInicioActividad = '0$hora1:0$min1';
                  } else {
                    horaInicioActividad = '0$hora1:$min1';
                  }
                } else {
                  if(min1<10){
                    horaInicioActividad = '$hora1:0$min1';
                  } else {
                    horaInicioActividad = '$hora1:$min1';
                  }
                }
                _read('Indique solo la hora final de la actividad');
                controlador = 7;
              } on FormatException {
                _read("No son minutos, por favor intente de nuevo");
              }
            } else if (controlador==7) {
              try {
                hora2 = int.parse(_text);
                _read('Indique solo los minutos del final de la actividad');
                controlador = 8;
              } on FormatException {
                _read("No es una hora, por favor intente de nuevo");
              }
            } else if (controlador==8) {
              try {
                int min2 = int.parse(_text);
                if(hora2<10){
                  if(min2<10){
                    horaFinalActividad = '0$hora2:0$min2';
                  } else {
                    horaFinalActividad = '0$hora2:$min2';
                  }
                } else {
                  if(min2<10){
                    horaFinalActividad = '$hora2:0$min2';
                  } else {
                    horaFinalActividad = '$hora2:$min2';
                  }
                }
                var aux = Actividad(cod_actividad: 5, descripcion: descripcionActividad, fecha_inicio: fechaActividad, fecha_final: '00-00-00', hora_inicio: horaInicioActividad, hora_final: horaFinalActividad);
                actividades.add(aux);
                _read('La actividad se guardo de forma adecuada');
                controlador = 0;
              } on FormatException {
                _read("No son minutos, por favor intente de nuevo");
              }
            }
            _text = '';
          } else {
            bool f = false;
            print('entro');
            for(int i=0;i<actividades.length;i++){
              if(actividades[i].descripcion.toUpperCase()==_text.toUpperCase()){
                setState((){
                  actividades.removeAt(i);
                  f = true;
                  print('Eliminado');
                  _read('Ok! se eliminó la actividad');
                });
              }
            }
            if (f){
              eliminar = true;
              _text = '';
            } else {
              _read('Actividad no encontrada intente de nuevo');
            }
          }
        }
      }
    }
  }

  int comprobarMes(String mes){
    int flag = -1;
    switch(mes){
      case 'Enero': flag = 1; break;
      case 'enero': flag = 1; break;
      case 'Febrero': flag = 2; break;
      case 'febrero': flag = 2; break;
      case 'Marzo': flag = 3; break;
      case 'marzo': flag = 3; break;
      case 'Abril': flag = 4; break;
      case 'abril': flag = 4; break;
      case 'Mayo': flag = 5; break;
      case 'mayo': flag = 5; break;
      case 'Junio': flag = 6; break;
      case 'junio': flag = 6; break;
      case 'Julio': flag = 7; break;
      case 'julio': flag = 7; break;
      case 'Agosto': flag = 8; break;
      case 'agosto': flag = 8; break;
      case 'Septiembre': flag = 9; break;
      case 'septiembre': flag = 9; break;
      case 'Octubre': flag = 10; break;
      case 'octubre': flag = 10; break;
      case 'Noviembre': flag = 11; break;
      case 'noviembre': flag = 11; break;
      case 'Diciembre': flag = 12; break;
      case 'diciembre': flag = 12; break;
    }
    return flag;
  }

  modalAddTarea(BuildContext context){
    Widget okButton = TextButton(
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(189, 211, 135, 1))),
        onPressed: (){
          setState(() {
            Navigator.of(context).pop();
            print(miVar.text);
            var actividad = Actividad(
                cod_actividad: 0,
                descripcion: miVar.text,
                fecha_inicio: valorFechaInicio.text,
                fecha_final: valorFechaFinal.text,
                hora_inicio: valorHoraInicio.text,
                hora_final: valorHoraFinal.text,
            );
            insertActividad(actividad);
            miVar.text='';
            valorHoraInicio.text = '';
            valorHoraFinal.text = '';
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
            valorHoraInicio.text = '';
            valorHoraFinal.text = '';
            valorFechaFinal.text = '';
            valorFechaInicio.text = '';
          });
        },child: const Text('Cancelar', style: TextStyle(fontSize: 15, color: Colors.white),)
    );



    AlertDialog alert = AlertDialog(
      title: const Text('Ingresar nueva actividad', style: TextStyle(color: Color.fromRGBO(56, 56, 56, 1))),
      content:
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: <Widget>[
              const Text('Asunto:', style: TextStyle(fontSize: 14),),
              SizedBox(width: 4,),
              Expanded(
                child: TextField(
                  style:TextStyle(fontSize: 14),
                  controller: miVar,
                  decoration: const InputDecoration(
                    hintText: 'Ingresa un asunto',
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding: EdgeInsets.all(6),
                  ) ,
                ),
              ),
            ],
          ),
          SizedBox(height: 6,),
          Row(
            children: <Widget>[
              const Text('Fecha inicio:',style: TextStyle(fontSize: 14)),
              SizedBox(width: 4,),
              Expanded(
                child: TextField(
                  style: TextStyle(fontSize: 14),
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
              SizedBox(width: 4,),
              Container(
                  height: 30,
                  width: 30,
                  child: RawMaterialButton(
                      fillColor: Color.fromRGBO(189, 211, 135, 1),
                      shape: CircleBorder(),
                      elevation: 0.0,
                      child: Icon(Icons.date_range, color: Colors.white, size: 17,),
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
          SizedBox(height: 6,),
          Row(
            children: <Widget>[
              const Text('Fecha final:', style: TextStyle(fontSize: 14)),
              SizedBox(width: 10,),
              Expanded(
                child: TextField(
                  style: TextStyle(fontSize: 14),
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
              SizedBox(width: 4,),
              Container(
                height: 30,
                width: 30,
                child: RawMaterialButton(
                  fillColor: Color.fromRGBO(189, 211, 135, 1),
                  shape: CircleBorder(),
                  elevation: 0.0,
                  child: Icon(Icons.date_range, color: Colors.white, size: 17,),
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
          SizedBox(height: 6,),
          Row(
            children: <Widget>[
              const Text('Hora inicio:', style: TextStyle(fontSize: 13)),
              SizedBox(width: 2,),
              Expanded(
                child: TextField(
                  style: TextStyle(fontSize: 12),
                  controller: valorHoraInicio,
                  keyboardType: TextInputType.none,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '🕐',
                    isDense: true,
                    contentPadding: EdgeInsets.all(6),
                  ) ,
                ),
              ),
              SizedBox(width: 2,),
              Container(
                  height: 20,
                  width: 20,
                  child: RawMaterialButton(
                      fillColor: Color.fromRGBO(189, 211, 135, 1),
                      shape: CircleBorder(),
                      elevation: 0.0,
                      child: Icon(Icons.hourglass_top, color: Colors.white, size: 15,),
                      onPressed: () async{
                        _myTime = (await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now()
                        ))!;
                        setState((){
                          if(_myTime.minute<10){
                            valorHoraInicio.text = '${_myTime.hour}:0${_myTime.minute}';
                          }else{
                            valorHoraInicio.text = '${_myTime.hour}:${_myTime.minute}';
                          }
                        });
                      }
                  )
              ),
              SizedBox(width: 6,),
              const Text('Hora final:', style: TextStyle(fontSize: 13)),
              SizedBox(width: 2,),
              Expanded(
                child: TextField(
                  style: TextStyle(fontSize: 12),
                  controller: valorHoraFinal,
                  keyboardType: TextInputType.none,
                  decoration: const InputDecoration(
                    hintText: '🕐',
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding: EdgeInsets.all(6),
                  ) ,
                ),
              ),
              SizedBox(width: 2,),
              Container(
                  height: 20,
                  width: 20,
                  child: RawMaterialButton(
                      fillColor: Color.fromRGBO(189, 211, 135, 1),
                      shape: CircleBorder(),
                      elevation: 0.0,
                      child: Icon(Icons.hourglass_bottom, color: Colors.white, size: 15,),
                      onPressed: () async{
                        _myTime = (await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now()
                        ))!;
                        setState((){
                          if(_myTime.minute<10){
                            valorHoraFinal.text = '${_myTime.hour}:0${_myTime.minute}';
                          }else{
                            valorHoraFinal.text = '${_myTime.hour}:${_myTime.minute}';
                          }
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
      ..color = const Color.fromRGBO(226, 221, 235, 0.48)
      ..strokeWidth = 2;

    Paint circlePink = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color.fromRGBO(211, 240, 210, 0.47)
      ..strokeWidth = 2;

    canvas.drawCircle(Offset(width*0.05, height*0.23), 100, circleGrey);
    canvas.drawCircle(Offset(width*0.9, height*0.7), 100, circlePink);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
