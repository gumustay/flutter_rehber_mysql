import 'package:flutter/material.dart';
import 'rehber.dart';
import 'detay_list.dart';
import 'notlar_list.dart';
//import 'package:toast/toast.dart';
import 'okul_insert.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "List in Flutter",
      home: new Scaffold(
        appBar: new AppBar(
          title: Text("Kocaeli Okul Rehber "),
          //backgroundColor: Color(0xFF537ca3),
          //backgroundColor: Colors.amber[800],
          backgroundColor: Colors.blue[900],
        ),
        body: RandomFruits(),
      ),
    );
  }
}




class RandomFruits extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RandomFruitsState();
  }
}

class RandomFruitsState extends State<RandomFruits>  {

  final _biggerFont = const TextStyle(fontSize: 18.0);



  //List<Fruits> items = new List(); // VT den gelecek liste için 2. YÖNTEM

  //YENİ
  List<Rehbers> futureRehber = [];
  List countries = [];
  bool isSearching = false;

  // İlk başta bütün datayı filteredCountries e aktarmak için
  @override
  void initState() {


    getAllRehber().then((data) {   // VT den gele sorgu "data" adında değişkene atandı (listeleme için kullanılacak)
      setState(() {

        countries = futureRehber = data;  // liste ye atandı

      });
    });

    super.initState();
  }


  Future<List<Rehbers>> getAllRehber() async {
     var res;
    List liste = [];
    final response = await http.get('http://10.0.2.2/phpmyadmin/rehber/get_data.php');
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

  String okul = '';

  // *** DROPDOWN
  String dropdownValue = 'TÜM İLÇELER';

  Widget dropdownWidget2() {
    return DropdownButton<String>(
      //isExpanded: true,
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),

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
          _filterIlce(dropdownValue); // sadece ilçeyi filtrele
          this.isSearching = false;   // arama kısmını kapat
          //showShortToast(dropdownValue);
        });
      },
      items: <String>['TÜM İLÇELER','BAŞİSKELE', 'ÇAYIROVA', 'DARICA', 'DERİNCE', 'DİLOVASI', 'GEBZE', 'GÖLCÜK', 'İZMİT', 'KANDIRA', 'KARAMÜRSEL', 'KARTEPE', 'KÖRFEZ']
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



  void showShortToast(String metin) {
    Fluttertoast.showToast(
        msg: metin,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1);
  }




  // filtre İLÇE
  void _filterIlce(value) {
    setState(() {
      if (value=="TÜM İLÇELER")
        futureRehber = countries;
      else {
        futureRehber =countries
            .where((fruit) =>
            fruit.ilce.toLowerCase().contains(value.toLowerCase()) )
            .toList();
      }
    });
  }

  // filtre İLÇE ve İSİM
  void _filterOkulveIlce(value1,value2) {
    setState(() {
      if (value2=="TÜM İLÇELER") {
        futureRehber = countries
            .where((fruit) =>
        fruit.name.toLowerCase().contains(value1.toLowerCase()) || fruit.mdr.toLowerCase().contains(value1.toLowerCase())   )
            .toList();
      }
      else {
        futureRehber = countries
            .where((fruit) =>
        ( fruit.name.toLowerCase().contains(value1.toLowerCase()) || fruit.mdr.toLowerCase().contains(value1.toLowerCase())  ) &&  fruit.ilce.toLowerCase().contains(value2.toLowerCase()) )
            .toList();
      }
    });
  }
  //YENİ



  @override
  Widget build(BuildContext context) {
    return Scaffold (
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: Align(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      /*Icon(
                  Icons.school,
                  color: Colors.white,
                  size: 100.0,
                ),*/
                      Text(
                        "",
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("data/imam_hatip-logo.png"),
                      fit: BoxFit.contain),
                  color: Colors.blue[800],
                ),

              ),



              ListTile(
                leading: Icon(Icons.note),
                title: Text('Not Listesi'),
                trailing: Icon(Icons.arrow_right),
                onTap: () {

                  Navigator.pop(context); // menüyü kapat (menüyüde bir sayfa gibi gördüğü için menüyü geri döndüğünde kapalı göstermek için)
                  buttonNotlarim(context);

                  /*Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => NotlarList()));*/
                  //  Navigator.push(context, NotlarList(""));

                },
              ),

              ListTile(
                leading: Icon(Icons.info),
                title: Text('Yeni Kayıt'),
                trailing: Icon(Icons.arrow_right),
                onTap: () {

                  Navigator.pop(context); // menüyü kapat (menüyüde bir sayfa gibi gördüğü için menüyü geri döndüğünde kapalı göstermek için)
                  buttonYeniKayit(context);

                  /* Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => OkulInsert()));*/

                },
              ),
            ],
          ),
        ),

        appBar: AppBar(
          //title: Text('Load data from DB'),
          //backgroundColor: Colors.yellow[800],
          //backgroundColor: Colors.amber[700],
          backgroundColor: Colors.blue[100],
          //backgroundColor: Color(0xFF537ca3),

          iconTheme: new IconThemeData(color: Colors.blue[900]), // menü Hamburger icon rengini değiştir

          title: !isSearching             // true ise "Okul Ara" yaz.
              ? Text('Okul/Müdür Bul',style: TextStyle(color: Colors.black,fontSize: 17))
              : TextField(
            onChanged: (value) {         // keliime değiştikçe filtre uygula
              // _filterOkul(value);   //
              _filterOkulveIlce(value,dropdownValue);   //
            },
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                hintText: "arama metni",
                hintStyle: TextStyle(color: Colors.black26)),
          ),

          actions: <Widget>[
            isSearching
                ? IconButton(
              icon: Icon(Icons.cancel),
              color: Colors.black,
              onPressed: () {
                setState(() {
                  this.isSearching = false;
                  futureRehber = countries;
                });
              },
            )
                : IconButton(
              icon: Icon(Icons.search),
              color: Colors.black,
              onPressed: () {

                setState(() {

                  this.isSearching = true;
                });
              },
            ),

            dropdownWidget2(),

          ],
          //YENİ


        ),
        body: FutureBuilder<List>(
          //future: _query.getAllOkuls(),
          future: getAllRehber(),
          initialData: List(),
          builder: (context, snapshot) {
            return snapshot.hasData ?
            new ListView.builder(
              padding: const EdgeInsets.all(10.0),
              //itemCount: snapshot.data.length,            // liste sayısını belirliyoruz
              itemCount: futureRehber.length,

              itemBuilder: (context, i) {                // i oluşturulan listenin index i
                //return _buildRow2(snapshot.data[i],i);
                return _buildRow2(futureRehber[i],i); // Fruits indexleme yaparak gönderdik

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

  /* Widget _buildRow(Fruits fruit ) {
    return new ListTile(
      title: new Text(fruit.name+"/"+fruit.tur, style: _biggerFont),

      onTap: () {
        Toast.show(fruit.name, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      },

    );
  }*/

  Widget _buildRow2(Rehbers fruit,int index) {
    return new Card(
      //color: index%2==0 ? Colors.white : Colors.orangeAccent,
        color: Colors.white,
        //color: fruit.name=="Armut" ? Colors.green : Colors.black12,    // değere göre satıra renk verebiliriz
        elevation: 4,

        child: ListTile(
          //leading: Icon(Icons.perm_contact_calendar),

          /*  leading: Container(
            child:
            Icon(Icons.perm_contact_calendar),
            height: double.infinity,),*/
          leading: CircleAvatar( radius: 20.0,
            backgroundImage: AssetImage("data/imam_hatip-01.png") , // no matter how big it is, it won't overflow
          ),

          //title: Text(fruit.ilce),Anadolu İmam Hatip Lisesi  İmam Hatip Ortaokulu
          title: Text('${fruit.ilce}', style: TextStyle(color: Colors.blueAccent, fontSize: 16.0)),  // null değer geldiğnde hata vermemesi için $ kullandık
          //subtitle: Text('${fruit.name}'),
          subtitle: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${fruit.name}',
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                ),
                Text(
                  '${fruit.mdr}',
                  style: TextStyle(color: Colors.deepOrange, fontSize: 14.0),
                ),
              ]),
          //trailing: Icon(Icons.add),
          onTap: () {

            buttonTap1(context , fruit); 
            // Toast.show(fruit.name, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
          },
        )

    );

  }





  //BUTTON NOTLARIM
  buttonNotlarim(BuildContext context) async {
    final result = await Navigator.push(
      context,

      MaterialPageRoute(builder: (context) => NotlarList()),
    );

    // NOTLARIM MENÜSÜNDEN, Gönderilen sayfadan geri geldiğinde, gönderilen değer "update" ise bütün kayıtları göster
    if (result == 'update') {

      // *** DROPDOWN
      dropdownValue = 'TÜM İLÇELER';

      getAllRehber().then((data) {   // VT den gele sorgu "data" adında değişkene atandı (listeleme için kullanılacak)
        setState(() {

          countries = futureRehber = data;  // liste ye atandı
          // ***

        });
      });

    }

  }
  //BUTTON NOTLARIM

  //BUTTON YENİ KAYIT
  buttonYeniKayit(BuildContext context) async {
    final result = await Navigator.push(
      context,

      MaterialPageRoute(builder: (context) => OkulInsert()),
    );

    // YENİ KAYIT MENÜSÜNDEN, Gönderilen sayfadan geri geldiğinde, gönderilen değer "update" ise bütün kayıtları göster
    if (result == 'update') {

      // *** DROPDOWN
      dropdownValue = 'TÜM İLÇELER';

      getAllRehber().then((data) {   // VT den gele sorgu "data" adında değişkene atandı (listeleme için kullanılacak)
        setState(() {

          countries = futureRehber = data;  // liste ye atandı
          // ***

        });
      });

    }

  }
//BUTTON YENİ KAYIT


// BUTTON LİSTE
buttonTap1(BuildContext context, Rehbers fruit) async {
    final result = await Navigator.push(
      context,
      /*MaterialPageRoute(
        builder: (context) => DetaySayfasi(),
        settings: RouteSettings(
          arguments: ("deneme" ) ,
          ),
        ),*/
      MaterialPageRoute(builder: (context) => DetayList(fruit)),
    );


    // LİSTEYE TIKLANDIĞINDA, Gönderilen sayfadan geri geldiğinde, gönderilen değer "update" ise bütün kayıtları göster
    if (result == 'update') {

      // *** DROPDOWN
      dropdownValue = 'TÜM İLÇELER';

      getAllRehber().then((data) {   // VT den gele sorgu "data" adında değişkene atandı (listeleme için kullanılacak)
        setState(() {

          countries = futureRehber = data;  // liste ye atandı
          // ***

        });
      });

    }
    // showSnackBar(context, result);
  }
// BUTTON LİSTE




}