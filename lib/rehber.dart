class Rehbers {
  final String id;
  final String name;
  final String mdr;
  final String ilce;
  final String tur;
  final String cep;
  final String tel;
  final String email;
  final String notes;
  final String date;

  Rehbers({this.id, this.name, this.mdr, this.ilce, this.tur, this.cep, this.tel, this.email, this.notes, this.date});

  factory Rehbers.fromJson(Map<String, dynamic> json) {
    return Rehbers(
      id: json['sno'],
      name: json['name'],
      mdr: json['mdr'],
      ilce: json['ilce'],
      tur: json['tur'],
      cep: json['cep'],
      tel: json['tel'],
      email: json['email'],
      notes: json['notes'],
      date: json['date'],
    );
  }
}