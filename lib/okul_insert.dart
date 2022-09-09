import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class OkulInsert extends StatefulWidget {


  @override
  State<StatefulWidget> createState() => new _NoteScreenState();
}

class _NoteScreenState extends State<OkulInsert> {


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
  TextEditingController _idController;




  @override
  void initState() {
    super.initState();

    _nameController = new TextEditingController(text: "");
    _mdrController = new TextEditingController(text: "");

  }

  // *** DROPDOWN
  String dropdownValue = 'BAŞİSKELE';

  Widget dropdownWidget2() {
    return DropdownButton<String>(
      //isExpanded: true,
      value: dropdownValue,
      icon: Icon(Icons.arrow_drop_down),

      iconSize: 24,
      elevation: 16,
      style: TextStyle(
        //color: Colors.orange
          color: Colors.deepPurple
      ),
      underline: Container(
        height: 2,
        //color: Colors.red,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
          //showShortToast(dropdownValue);
        });
      },
      items: <String>['BAŞİSKELE', 'ÇAYIROVA', 'DARICA', 'DERİNCE', 'DİLOVASI', 'GEBZE', 'GÖLCÜK', 'İZMİT', 'KANDIRA', 'KARAMÜRSEL', 'KARTEPE', 'KÖRFEZ']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      })
          .toList(),
    );
  }
  // *** DROPDOWN

  // *** DROPDOWN
  String dropdownTurValue = 'İmam Hatip Ortaokulu';

  Widget dropdownTur() {
    return DropdownButton<String>(
      //isExpanded: true,
      value: dropdownTurValue,
      icon: Icon(Icons.arrow_drop_down),

      iconSize: 24,
      elevation: 16,
      style: TextStyle(
        //color: Colors.orange
          color: Colors.deepPurple
      ),
      underline: Container(
        height: 2,
        //color: Colors.red,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownTurValue = newValue;
          //showShortToast(dropdownValue);
        });
      },
      items: <String>['İmam Hatip Ortaokulu', 'Anadolu İmam Hatip Lisesi']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      })
          .toList(),
    );
  }
  // *** DROPDOWN

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Yeni Okul Girişi')),
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: ListView(
          children: <Widget>[
            TextField(
              //maxLines: 10,
              controller: _mdrController,
              decoration: InputDecoration(labelText: 'Müdür Adı Soyadı Giriniz',fillColor: Colors.lightBlueAccent[100], filled: true),
            ),
            TextField(
              //maxLines: 10,
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Okul Adı Giriniz',fillColor: Colors.lightBlueAccent[100], filled: true),
            ),
            dropdownWidget2(),
            dropdownTur(),



            Padding(padding: new EdgeInsets.all(5.0)),
            RaisedButton(
              child: Text('Yeni Okul Ekle'),
              onPressed: () {

                /*db.ekle(Okuls.fromMapEkle({
                  'name': _nameController.text,
                  //'tur': _turController.text,
                  'mdr' : _mdrController.text,
                  //'ilce' : _ilceController.text,
                  'ilce' : dropdownValue,
                  'tur' : dropdownTurValue,
                  //'tur_sno' : _tursnoController.text,
                  //'lati' : _latiController.text,
                  //'longi' : _longiController.text,
                  //'notes': _notController.text,
                })).then((_) {
                  //Navigator.pop(context, 'update');
                  //Navigator.pop(context);
                  Navigator.pop(context, 'update');//  pop yapıp ana sayfaya gitmesini ve listeyi güncellemesini sağladık
                });*/


                signupUser().then((_) {
                  //Navigator.pop(context, 'update');
                  //Navigator.pop(context);
                  Navigator.pop(context, 'update');//  pop yapıp ana sayfaya gitmesini ve listeyi güncellemesini sağladık
                });;




              },
            ),


          ],
        ),
      ),
    );
  }


  Future<bool> signupUser() async {
    final response = await http.post('http://10.0.2.2/phpmyadmin/rehber/insert.php', body: {
      "name": _nameController.text,
      "mdr": _mdrController.text,
      "ilce": dropdownValue,
      "tur": dropdownTurValue,
    });

    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }
}
