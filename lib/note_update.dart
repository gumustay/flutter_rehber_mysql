import 'package:flutter/material.dart';
import 'rehber.dart';
import 'package:http/http.dart' as http;

class NoteUpdate extends StatefulWidget {
  final Rehbers note;
  NoteUpdate(this.note);

  // final int note;
  //final String not;
  //NoteUpdate(this.note,this.not);


  @override
  State<StatefulWidget> createState() => new _NoteScreenState();
}

class _NoteScreenState extends State<NoteUpdate> {

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
  TextEditingController _dateController;




  @override
  void initState() {
    super.initState();

    /* _nameController = new TextEditingController(text: widget.note.name);
    _turController = new TextEditingController(text: widget.note.tur);
    _mdrController = new TextEditingController(text: widget.note.mdr);
    _ilceController = new TextEditingController(text: widget.note.ilce);
    _telController = new TextEditingController(text: widget.note.tel);
    _cepController = new TextEditingController(text: widget.note.cep);
    _tursnoController = new TextEditingController(text: widget.note.tur_sno);
    _emailController = new TextEditingController(text: widget.note.email);
    _latiController = new TextEditingController(text: widget.note.lati);
    _longiController = new TextEditingController(text: widget.note.longi);*/
    _notController = new TextEditingController(text: widget.note.notes);
    _dateController = new TextEditingController(text: widget.note.date);
    _nameController = new TextEditingController(text: widget.note.name);



    //_idController = new TextEditingController(text: widget.note.id.toString());


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      //appBar: AppBar(title: Text('Notlarım:'+' tarih:'+_dateController.text)),
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              //'Notlarımm - En son değişiklik :'+_dateController.text.substring(8,10)+"."+_dateController.text.substring(5,7)+"."+_dateController.text.substring(0,4),//_dateController.text,
              'Notlarım - En son değişiklik :'+_dateController.text,
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
            Visibility(
              visible: true,
              child: Text(
                _nameController.text,
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[

            TextField(
              maxLines: 10,
              controller: _notController,
              decoration: InputDecoration(labelText: 'Notlarım',fillColor: Colors.amberAccent, filled: true),
            ),

            Padding(padding: new EdgeInsets.all(5.0)),
            RaisedButton(
              child: (widget.note.id != null) ? Text('Güncelle') : Text('Add'),
              onPressed: () {



                if (widget.note.id!= null) {
                 /* db.updateNotlarim(Okuls.fromMapNotum({               // toMapNotum
                    'id': widget.note.id,
                    /*  'name': _nameController.text,
                  'tur': _turController.text,
                  'mdr' : _mdrController.text,
                  'ilce' : _ilceController.text,
                  'tel' : _telController.text,
                  'cep' : _cepController.text,
                  'tur_sno' : _tursnoController.text,
                  'email' : _emailController.text,
                  'lati' : _latiController.text,
                  'longi' : _longiController.text,*/

                    'notes': _notController.text,
                    'date': date,
                  })).then((_)*/
                  NotGuncelle().then((_){
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



  Future<bool> NotGuncelle() async {

    DateTime now = new DateTime.now();
    var date = now.toString().substring(0,10);

    final response = await http.post('http://10.0.2.2/phpmyadmin/rehber/not_update.php', body: {

      "id": widget.note.id,
      "not": _notController.text,
      "date": date,
    });

    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }

}


