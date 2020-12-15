import 'dart:io';

import 'package:band_names/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

List<Band> bands = [

  Band(id:'1',name: 'Villanos', votes:5),
  Band(id:'2',name: 'La Renga', votes:5),
  Band(id:'3',name: 'Pepito', votes:5),
  Band(id:'4',name: 'Mambru', votes:5),
  Band(id:'5',name: 'Los Pericos', votes:5)
  
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text('BandNames', style: TextStyle( color:Colors.black87) ),
        backgroundColor: Colors.white,
        ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: ( context, i) => _bandTile(bands[i])
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        child: Icon(Icons.add),
        onPressed: (){
          setState(() {
            addNewBand();
          });
        }
        ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
          key: Key(band.id),
          direction: DismissDirection.startToEnd,
          onDismissed: ( DismissDirection direction){
            print('direction: $direction');
            print('id: ${band.id}');
            print('name: ${band.name}');
            print('voto: ${band.votes}');

            //llamar al borrado en el server
          },
          background: Container(
            padding: EdgeInsets.only(left: 8.0),
            color: Colors.red,
            child: Align(
            alignment:Alignment.centerLeft,
            child: Text('Delete Band',style: TextStyle( color: Colors.white),
            ),
            ),
            ),
          child: ListTile(
            leading: CircleAvatar(
            child: Text(band.name.substring(0,2)),  
            backgroundColor: Colors.blue[100],
              ),
            title: Text(band.name),
            trailing: Text('${band.votes}', style: TextStyle(fontSize: 20),),
            onTap: (){
              print (band.name);
            },
          ),
    );
  }

addNewBand(){

  final textController = new TextEditingController();

  if (Platform.isAndroid){
    //Android
    return showDialog(
  context: context,
  builder: (context){
    return AlertDialog(
      title: Text('New band name:'),
      content: TextField(
        controller: textController,
      ),
      actions: <Widget>[
        MaterialButton(
          child: Text('Add'),
          elevation: 5,
          textColor: Colors.blue,
          onPressed: ()=> addBandToList(textController.text),
        )
      ]
    );
  },
  );
  }

showCupertinoDialog(
  context: context, 
  builder: ( _ ){
return CupertinoAlertDialog(
  title: Text('New band name:'),
  content: CupertinoTextField(
    controller: textController,
    ),
actions: <Widget>[
  CupertinoDialogAction(
    isDefaultAction: true,
    child: Text('Add'),
    onPressed: ()=>addBandToList(textController.text),
    ),
    CupertinoDialogAction(
    isDefaultAction: true,
    child: Text('Dismiss'),
    onPressed: ()=>Navigator.pop(context),
    ),
],

);
  }
  );

}

void addBandToList (String name){
  if(name.length >1){
this.bands.add(new Band(id: DateTime.now().toString(),name:name,votes:0));
setState(() {
});
  Navigator.pop(context);
}
}
}