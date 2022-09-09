import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'rehber.dart';

class OkulUpdate extends StatefulWidget {
  final Rehbers note;
  OkulUpdate(this.note);

  // final int note;
  //final String not;
  //NoteUpdate(this.note,this.not);

  @override
  State<StatefulWidget> createState() => new _NoteScreenState();
}

class _NoteScreenState extends State<OkulUpdate> {
  //DatabaseHelper db = new DatabaseHelper();

  TextEditingController _nameController;
  TextEditingController _turController;
  TextEditingController _mdrController;
  TextEditingController _ilceController;
  TextEditingController _telController;
  TextEditingController _cepController;
  TextEditingController _tursnoController;
  TextEditingController _emailController;
  TextEditingController _latiController;
  TextEditingController _longiController;
  TextEditingController _notController;
  //TextEditingController _idController;




  @override
  void initState() {
    super.initState();

    _nameController = new TextEditingController(text: widget.note.name);
    //_turController = new TextEditingController(text: widget.note.tur);
    _mdrController = new TextEditingController(text: widget.note.mdr);
    //_ilceController = new TextEditingController(text: widget.note.ilce);
    _telController = new TextEditingController(text: widget.note.tel);
    _cepController = new TextEditingController(text: widget.note.cep);
    //_tursnoController = new TextEditingController(text: widget.note.tur_sno);
    _emailController = new TextEditingController(text: widget.note.email);
    //_latiController = new TextEditingController(text: widget.note.lati);
    //_longiController = new TextEditingController(text: widget.note.longi);
    //_notController = new TextEditingController(text: widget.note.notes);

    //_idController = new TextEditingController(text: widget.note.id.toString());


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Okul Bilgilerini Güncelle')),
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: ListView(
          children: <Widget>[
            TextField(
              //maxLines: 10,
              controller: _mdrController,
              decoration: InputDecoration(labelText: 'Müdür',fillColor: Colors.amberAccent, filled: true),
            ),
            TextField(
              //maxLines: 10,
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Okul',fillColor: Colors.amberAccent, filled: true),
            ),
            TextField(
              //maxLines: 10,
              controller: _telController,
              decoration: InputDecoration(labelText: 'Telefon',fillColor: Colors.amberAccent, filled: true),
            ),
            TextField(
              //maxLines: 10,
              controller: _cepController,
              decoration: InputDecoration(labelText: 'Cep Telefonu',fillColor: Colors.amberAccent, filled: true),
            ),
            TextField(
              //maxLines: 10,
              controller: _emailController,
              decoration: InputDecoration(labelText: 'E Mail',fillColor: Colors.amberAccent, filled: true),
            ),


            Padding(padding: new EdgeInsets.all(5.0)),
            RaisedButton(
              child: (widget.note.id != null) ? Text('Güncelle') : Text('Add'),
              onPressed: () {
                if (widget.note.id!= null) {
                  /*db.updateOkulBilgileri(Okuls.fromMapOkul1({           //  toMapOkul1
                    'id': widget.note.id,
                    'name': _nameController.text,
                    //'tur': _turController.text,
                    'mdr' : _mdrController.text,
                    //'ilce' : _ilceController.text,
                    'tel' : _telController.text,
                    'cep' : _cepController.text,
                    //'tur_sno' : _tursnoController.text,
                    'email' : _emailController.text,
                    //'lati' : _latiController.text,
                    //'longi' : _longiController.text,
                    //'notes': _notController.text,
                  })).then((_)*/

                  UpdateOkul().then((_){
                    Navigator.pop(context);
                    Navigator.pop(context, 'update');// 2 defa pop yapıp ana sayfaya gitmesini ve listeyi güncellemesini sağladık
                  });
                }else {

                }
              },
            ),


          ],
        ),
      ),
    );
  }


  Future<bool> UpdateOkul() async {
    final response = await http.post('http://10.0.2.2/phpmyadmin/rehber/update.php', body: {
      "id": widget.note.id,
      "name": _nameController.text,
      "mdr": _mdrController.text,
      "tel": _telController.text,
      "cep": _cepController.text,
      "email": _emailController.text,
    });

    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }
}
