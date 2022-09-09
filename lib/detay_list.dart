import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'rehber.dart';
import 'note_update.dart';
import 'okul_update.dart';
import 'package:nice_button/nice_button.dart';
//import 'okul_insert.dart';
import 'package:http/http.dart' as http;

class DetayList extends StatefulWidget {
  final Rehbers note;
  DetayList(this.note);



  @override
  State<StatefulWidget> createState() => new _NoteScreenState();
}



// İKİ SÜTUNLU YAPI
class CustomListItem extends StatelessWidget {
  const CustomListItem({
    this.thumbnail,
    this.thumbnail2,
  });

  final Widget thumbnail;
  final Widget thumbnail2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: thumbnail,
          ),
          Expanded(
            flex: 2,
            child: thumbnail2,
          ),


        ],
      ),
    );
  }
}
// İKİ SÜTUNLU YAPI



class _NoteScreenState extends State<DetayList> {

  //TextEditingController _idController;
  TextEditingController _titleController;
  TextEditingController _descriptionController;
  TextEditingController _ilceController;
  TextEditingController _nameController;
  TextEditingController _mdrController;
  TextEditingController _telController;
  TextEditingController _cepController;
  TextEditingController _emailController;
  TextEditingController _latiController;
  TextEditingController _longiController;
  TextEditingController _notesController;


  bool isButtonPressed = false;

  //Title baslik;


  @override
  void initState() {
    super.initState();

    // _idController = new TextEditingController(text : widget.note.id);
    _titleController = new TextEditingController(text: widget.note.name);
    _descriptionController = new TextEditingController(text: widget.note.tur);
    _ilceController = new TextEditingController(text: widget.note.ilce);
    _nameController = new TextEditingController(text: widget.note.name);
    _mdrController = new TextEditingController(text: widget.note.mdr);
    _telController = new TextEditingController(text: widget.note.tel);
    _cepController = new TextEditingController(text: widget.note.cep);
    //_latiController = new TextEditingController(text: widget.note.lati);
    //_longiController = new TextEditingController(text: widget.note.longi);
    _notesController = new TextEditingController(text: widget.note.notes);
    _emailController = new TextEditingController(text: widget.note.email);
    //baslik =new  Title (title: widget.note.name);


  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text("Kurum Bilgileri"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(


          children: <Widget>[


            // İKİ SÜTUNLU YAPI
            CustomListItem(

              thumbnail: Container(
                child:
                ListTile(
                  leading: const Icon(Icons.account_balance),
                  title: const Text('İlçe'),
                  //title:  new Text('$_titleController'),
                  subtitle: Text(_ilceController.text),
                ),
              ),
              thumbnail2: Container(
                child:
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Okul'),
                  //title:  new Text('$_titleController'),
                  subtitle: Text(_nameController.text),
                ),
              ),

            ),
            // İKİ SÜTUNLU YAPI



            /*
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Okul'),
              //title:  new Text('$_titleController'),
              subtitle: Text(_nameController.text),
            ),
            */
            NiceButton(
              width: 200,
              elevation: 3.0,  // GÖLGE
              radius: 10.0,
              text: "Haritaya Git",
              icon: Icons.map,

              background: Color(0xFF42A5F5),
              onPressed: () {
                launch("https://www.google.com/maps/search/?api=1&query="+"Kocaeli "+_nameController.text+"");
              },
            ),

            SizedBox(height: 10,),  // BOŞLUK

            SizedBox(
              height: MediaQuery.of(context).size.height / 5,
              //width: 200.0,
              //height: 100.0,

              child:
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red[500],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),

                //color: Colors.orange[100],//remove color to make it transpatrent
                child: ListTile(
                  leading: const Icon(Icons.note),
                  title: const Text('Notlarım'),
                  //title:  new Text('$_titleController'),
                  subtitle: Text(_notesController.text),
                  onTap:() {
                    _navigateToNote(context,widget.note);
                  },
                ),
              ),
            ),

            /*    NiceButton(
              width: 200,
              elevation: 8.0,
              radius: 12.0,
              text: "Not Düzenle",
              icon: Icons.note,
              background:  Colors.amberAccent,
              onPressed: () {
                _navigateToNote(context,widget.note);
              },
            ),*/

            SizedBox(height: 10,),  // BOŞLUK

            // İKİ SÜTUNLU YAPI
            CustomListItem(

              thumbnail: Container(
                child:
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Müdür'),
                  //title:  new Text('$_titleController'),
                  subtitle: Text(_mdrController.text),
                ),
              ),
              thumbnail2: Container(
                child:
                ListTile(
                  leading: const Icon(Icons.alternate_email),
                  title: const Text('E Mail'),
                  //title:  new Text('$_titleController'),
                  subtitle: Text(_emailController.text),
                ),
              ),

            ),
            // İKİ SÜTUNLU YAPI


            // İKİ SÜTUNLU YAPI
            CustomListItem(

              thumbnail: Container(
                child: ListTile(
                  leading: const Icon(Icons.phone),
                  title: const Text('Kurum Telefonu'),
                  //title:  new Text('$_titleController'),
                  subtitle: Text(_telController.text),
                ),
              ),
              thumbnail2: Container(
                child:
                NiceButton(
                  width: 60,
                  elevation: 8.0,
                  radius: 40.0,
                  text: "",
                  icon: Icons.phone,
                  background: Colors.green[300],
                  onPressed: () {
                    launch("tel:0"+_telController.text);
                  },
                ),
              ),

            ),
            // İKİ SÜTUNLU YAPI

            // İKİ SÜTUNLU YAPI
            CustomListItem(

              thumbnail: Container(
                child: ListTile(
                  leading: const Icon(Icons.phone_android),
                  title: const Text('Cep Telefonu'),
                  //title:  new Text('$_titleController'),
                  subtitle: Text(_cepController.text),
                ),
              ),
              thumbnail2: Container(
                child:
                NiceButton(
                  width: 60,
                  elevation: 8.0,
                  radius: 40.0,
                  text: "",
                  icon: Icons.phone,
                  background: Colors.green[300],
                  onPressed: () {
                    launch("tel:0"+_cepController.text);
                  },
                ),
              ),

            ),
            // İKİ SÜTUNLU YAPI


            //************************************************************************************************************************
            RaisedButton(
              onPressed: () {
                _navigateToOkulUpdate(context,widget.note);


              },
              textColor: Colors.white,
              padding: const EdgeInsets.all(0.0),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xFF0D47A1),
                      Color(0xFF1976D2),
                      Color(0xFF42A5F5),
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(10.0),
                child:
                const Text('Bilgileri Güncelle', style: TextStyle(fontSize: 20)),
              ),
            ),

            RaisedButton(
              onPressed: () {


                //db.delete(widget.note.id);
                showAlertDialog(context);

              },
              textColor: Colors.white,
              padding: const EdgeInsets.all(0.0),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xFF0D47A1),
                      Color(0xFF1976D2),
                      Color(0xFF42A5F5),
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(10.0),
                child:
                const Text('Okul Sil', style: TextStyle(fontSize: 20)),
              ),
            ),

          ],
        ),
      ),
    );

  }

  void _navigateToNote(BuildContext context,Rehbers not) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteUpdate(not)),
    );
  }


  void _navigateToOkulUpdate(BuildContext context,Rehbers not) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OkulUpdate(not)),
    );
  }


  showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("İptal"),
      onPressed:  () {Navigator.of(context).pop();},
    );
    Widget continueButton = FlatButton(
      child: Text("Sil"),
      onPressed:  () {

        DeleteOkul();
        Navigator.of(context).pop();// alertdialog u kapat
        Navigator.pop(context, 'update'); // bir önceki sayfaya dön ve listeyi güncelle yapmasını iste

      },

    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Uyarı"),
      content: Text("Okul silinecek, Onaylıyor Musunuz?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  Future<bool> DeleteOkul() async {
    final response = await http.post('http://10.0.2.2/phpmyadmin/rehber/delete.php', body: {
      "id": widget.note.id,
    });
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }



}



