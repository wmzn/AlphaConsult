import 'package:argon_flutter/constants/Theme.dart';
import 'package:argon_flutter/screens/detailvisites.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:argon_flutter/models/Visite.dart';
import 'detailwidget.dart';

class VisitesList extends StatelessWidget {
  final List<VisiteM> visite;
  VisitesList({Key key, this.visite}) : super(key: key);
  TextEditingController editingController = TextEditingController();
  void initState() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ArgonColors.bgColorScreen,
        drawer: ArgonDrawer(currentPage: "Elements"),
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: visite == null ? 0 : visite.length,
                    itemBuilder: (BuildContext context, int index) {
                      String toshow;
                      Color color;
                      if (visite[index].V9 == "1") {
                        toshow = "Rapport validé";
                        color = ArgonColors.success;
                      } else if (visite[index].V9 == "2") {
                        toshow = "Rapport non validé";
                        color = ArgonColors.error;
                      }
                      return Card(
                          color: Colors.white,
                          margin: EdgeInsets.all(10.0),
                          shadowColor: Colors.green,
                          elevation: 10.0,
                          child: InkWell(
                        onTap: () {
                          print(visite[index]);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailVisite(visite[index])),
                          );
                        },
                        child: ListTile(
                          leading:
                              Icon(Icons.person, color: ArgonColors.success),
                          title: Text(visite[index].NomDr),
                          subtitle: Text(
                            toshow + " \n" + visite[index].date.split(" ")[0],
                            style: TextStyle(fontSize: 14, color: color),
                          ),
                        ),
                      ));
                    }),
              )
            ],
          ),
        ));
  }
}
