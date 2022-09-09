import 'package:flutter/material.dart';
import 'note_update.dart';
import 'package:nice_button/nice_button.dart';
import 'rehber.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotlarList extends StatefulWidget {


  @override
  State<StatefulWidget> createState() => new _NoteScreenState();
}




class _NoteScreenState extends State<NotlarList> {
  final _biggerFont = const TextStyle(fontSize: 18.0);


  //List<Fruits> items = new List(); // VT den gelecek liste için 2. YÖNTEM

  List countries = [];
  bool isSearching = false;
  List<Rehbers> filteredCountries = [
  ]; //



  //Title baslik;


  @override
  void initState() {

    getAllRehber().then((data) {   //
      setState(() {

        countries = filteredCountries = data;  // liste ye atandı

      });
    });

    super.initState();
  }


  Future<List<Rehbers>> getAllRehber() async {
    var res;
    List liste = [];
    final response = await http.get('http://10.0.2.2/phpmyadmin/rehber/get_data_notlar.php');
    //print('getEmployees Response: ${response.body}');
    if (response.statusCode == 200) {

      List<Rehbers> list = parseResponse(response.body);
      //print('deneme');
      return list;

    }else {
      return List<Rehbers>();
    }


  }

  static List<Rehbers> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Rehbers>((json) => Rehbers.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          title: Text("Not Listesi ( Tarih Sıralıdır)"),
        ),
        body: FutureBuilder<List>(
          //future: _query.getAllOkuls(),
          initialData: List(),
          builder: (context, snapshot) {
            return snapshot.hasData ?
            new ListView.builder(
              padding: const EdgeInsets.all(10.0),
              //itemCount: snapshot.data.length,            // liste sayısını belirliyoruz
              itemCount: filteredCountries.length,

              itemBuilder: (context, i) {
                //return _buildRow2(snapshot.data[i],i);
                return _buildRow2(filteredCountries[i],
                    i);

                /*  return ListTile(
                  title: Text(snapshot.data[i].toString()),
              );*/
              },

            )
                : Center(
              child: CircularProgressIndicator(),
            );
          },
        )
    );
  }

  Widget _buildRow2(Rehbers fruit, int index) {
    return new Card(
      //color: index%2==0 ? Colors.white : Colors.orangeAccent,
        color: Colors.amberAccent[100],
        //color: fruit.name=="Armut" ? Colors.green : Colors.black12,    // değere göre satıra renk verebiliriz
        elevation: 4,


        child: ListTile(
          //leading: Icon(Icons.perm_contact_calendar),

          //title: Text(fruit.ilce),Anadolu İmam Hatip Lisesi  İmam Hatip Ortaokulu
          title: Text('${fruit.name}',
              style: TextStyle(color: Colors.blueAccent, fontSize: 16.0)),
          // null değer geldiğnde hata vermemesi için $ kullandık
          //subtitle: Text('${fruit.name}'),
          subtitle: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${fruit.notes}',
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                ),
                Text(
                  //_dateController.text.substring(8,10)+"."+_dateController.text.substring(5,7)+"."+_dateController.text.substring(0,4)
                  '${fruit.date}',
                  style: TextStyle(color: Colors.deepOrange, fontSize: 14.0),
                ),
              ]),
          //trailing: Icon(Icons.add),
          onTap: () {
            buttonTap1(context,
                fruit);

          },
        )

    );
  }


  buttonTap1(BuildContext context, Rehbers fruit) async {
    final result = await Navigator.push(
      context,
      /*MaterialPageRoute(
        builder: (context) => DetaySayfasi(),
        settings: RouteSettings(
          arguments: ("deneme" ) ,
          ),
        ),*/
      MaterialPageRoute(builder: (context) => NoteUpdate(fruit)),
    );
  }


}
