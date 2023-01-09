class Cases {
  final String id;
  final String NomDr;
  final String NomVm;
  final String NomContact;
  final String Phone;
  final String Spicialite;
  final String Secteur;
  final String Wilaya;
  final String Commun;
  final String Daira;
  final String CodeP;
  final String Route;
  final String name;
  final String gender;
  final String age;
  final String address;
  final String city;
  final String country;
  final String status;
  final String updated;
  final String Lat;
  final String Lng;
  final String prenom;
  final String email;
  final String option;
  final String potentielPation;
  final String potentielProduit;

  Cases(
      {this.prenom,
      this.email,
      this.option,
      this.potentielPation,
      this.potentielProduit,
      this.NomDr,
      this.NomVm,
      this.NomContact,
      this.Phone,
      this.Spicialite,
      this.Secteur,
      this.Wilaya,
      this.Commun,
      this.Daira,
      this.CodeP,
      this.Route,
      this.id,
      this.name,
      this.gender,
      this.age,
      this.address,
      this.city,
      this.country,
      this.status,
      this.updated,
      this.Lat,
      this.Lng});

  factory Cases.fromJson(Map<String, dynamic> json) {
    return Cases(
      id: json['_id'] as String,
      name: json['name'] as String,
      gender: json['gender'] as String,
      age: json['age'] as String,
      address: json['address'] as String,
      city: json['city'] as String,
      country: json['country'] as String,
      status: json['status'] as String,
      updated: json['updated'] as String,
      Lat: json['Lat'] as String,
      Lng: json['Lng'] as String,
      NomDr: json['NomDr'] as String,
      NomVm: json['NomVm'] as String,
      NomContact: json['NomContact'] as String,
      Phone: json['Phone'] as String,
      Spicialite: json['Spicialite'] as String,
      Secteur: json['Secteur'] as String,
      Wilaya: json['Wilaya'] as String,
      Commun: json['Commun'] as String,
      Daira: json['Daira'] as String,
      CodeP: json['CodeP'] as String,
      Route: json['Route'] as String,
      prenom: json['prenom'] as String,
      email: json['email'] as String,
      option: json['option'] as String,
      potentielPation: json['potentielPation'] as String,
      potentielProduit: json['potentielProduit'] as String,
    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $name, age: $age,gender: $gender,address: $address,age: $age,city: $city,country: $country,status: $status,Lat: $Lat,Lng: $Lng, NomDr:$NomDr,NomVm:$NomVm,NomContact:$NomContact,Phone:$Phone,Spicialite:$Spicialite,Secteur:$Secteur,Wilaya:$Wilaya,Commun:$Commun,Daira:$Daira,CodeP:$CodeP,Route:$Route,prenom:$prenom,email:$email,option:$option,potentielPation:$potentielPation,potentielProduit:$potentielProduit}';
  }
}
