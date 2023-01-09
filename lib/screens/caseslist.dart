import 'package:argon_flutter/constants/Theme.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:argon_flutter/models/cases.dart';
import 'detailwidget.dart';

class CasesList extends StatelessWidget {
  final List<Cases> cases;

  CasesList({Key key, this.cases}) : super(key: key);
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
                    itemCount: cases == null ? 0 : cases.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                          color: Colors.white,
                          margin: EdgeInsets.all(10.0),
                          shadowColor: Colors.green,
                          elevation: 10.0,
                          child: InkWell(
                        onTap: () {
                          print(cases[index]);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailWidget(cases[index])),
                          );
                        },
                        child: ListTile(
                          leading:
                              Icon(Icons.person, color: ArgonColors.success),
                          title: Text(
                              cases[index].NomDr + " " + cases[index].prenom),
                          subtitle: Text(cases[index].Phone),
                        ),
                      ));
                    }),
              )
            ],
          ),
        ));
  }
}

// class CasesList extends StatefulWidget {
//   CasesList({Key key, this.title, this.cases}) : super(key: key);
//   final List<Cases> cases;
//   final String title;

//   @override
//   _CasesListState createState() => new _CasesListState();
// }

// class _CasesListState extends State<CasesList> {
//   TextEditingController editingController = TextEditingController();

//   final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
//   var items = List<String>();

//   @override
//   void initState() {
//     items.addAll(duplicateItems);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: new AppBar(
//         title: new Text(widget.title),
//       ),
//       body: Container(
//         child: Column(
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextField(
//                 onChanged: (value) {},
//                 controller: editingController,
//                 decoration: InputDecoration(
//                     labelText: "Search",
//                     hintText: "Search",
//                     prefixIcon: Icon(Icons.search),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(25.0)))),
//               ),
//             ),
//             Expanded(
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: items.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text('${items[index]}'),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
