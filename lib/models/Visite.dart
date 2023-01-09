class VisiteM {
  final String id;
  final String NomDr;
  final String NomDrid;
  final String NomContact;
  final String Rapport;
  final String V1;
  final String V2;
  final String V3;
  final String V4;
  final String V5;
  final String V6;
  final String V7;
  final String V8;
  final String V9;
  final String Lng;
  final String Lat;
  final String ob;
  final String date;

  VisiteM(
      {this.NomContact,
      this.NomDrid,
      this.Rapport,
      this.V1,
      this.V2,
      this.V3,
      this.V4,
      this.V5,
      this.V6,
      this.V7,
      this.V8,
      this.V9,
      this.id,
      this.Lat,
      this.Lng,
      this.NomDr,
      this.ob,
      this.date});

  factory VisiteM.fromJson(Map<String, dynamic> json) {
    return VisiteM(
        id: json['_id'] as String,
        NomDr: json['NomDr'] as String,
        NomDrid: json['NomDrid'] as String,
        V1: json['V1'] as String,
        V2: json['V2'] as String,
        V3: json['V3'] as String,
        V4: json['V4'] as String,
        V5: json['V5'] as String,
        V6: json['V6'] as String,
        V7: json['V7'] as String,
        V8: json['V8'] as String,
        V9: json['V9'] as String,
        Lat: json['Lat'] as String,
        Lng: json['Lng'] as String,
        NomContact: json['NomContact'] as String,
        Rapport: json['Rapport'] as String,
        ob: json['ob'] as String,
        date: json['date'] as String);
  }

  @override
  String toString() {
    return 'Trans{id: $id, NomDr: $NomDr,NomDrid: $NomDrid, Rapport: $Rapport,V1: $V1,V2: $V2,V3: $V3,V4: $V4,V5: $V5,V6: $V6,V7: $V7,V8: $V8, V9:$V9,Lng:$Lng,Lat:$Lat,ob:$ob,date:$date}';
  }
}
