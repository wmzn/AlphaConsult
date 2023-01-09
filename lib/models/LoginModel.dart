class LoginResponseModel {
  final String token;
  final String error;
  final String id;

  LoginResponseModel({this.token, this.error, this.id});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json["token"] != null ? json["token"] : "",
      id: json["userid"] != null ? json["userid"] : "",
      error: json["error"] != null ? json["error"] : "",
    );
  }
}

class GetSccanedData {
  final String name;
  final String password;

  GetSccanedData({this.name, this.password});

  factory GetSccanedData.fromJson(Map<String, dynamic> json) {
    return GetSccanedData(
      name: json["name"] != null ? json["name"] : "",
      password: json["password"] != null ? json["password"] : "",
    );
  }
}

class LoginRequestModel {
  String Username;
  String password;

  LoginRequestModel({
    this.Username,
    this.password,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'Username': Username.trim(),
      'password': password.trim(),
    };

    return map;
  }
}

class Album {
  final String type;
  final String nom;
  final String prenom;
  final String telephone;
  final String emploi;
  final String entrepris;
  final String services;
  final String info;
  final String id;
  final String email;
  final String siteweb;
  final String rsx;
  final String pres;

  Album(
      {this.type,
      this.nom,
      this.id,
      this.prenom,
      this.telephone,
      this.emploi,
      this.entrepris,
      this.services,
      this.info,
      this.email,
      this.siteweb,
      this.rsx,
      this.pres});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
        id: json['_id'],
        type: json['type'],
        nom: json['nom'],
        prenom: json['prenom'],
        telephone: json['telephone'],
        emploi: json['emploi'],
        info: json['info'],
        entrepris: json['entrepris'],
        services: json['services'],
        email: json['email'],
        siteweb: json['siteweb'],
        rsx: json['rsx'],
        pres: json['pres']);
  }
}

class Listv {
  final String name;
  final String role;
  final String id;

  Listv({this.name, this.role, this.id});

  factory Listv.fromJson(Map<String, dynamic> json) {
    return Listv(
      id: json['_id'],
      name: json['exposerid'],
      role: json['notes'],
    );
  }
}
