import 'dart:convert';
import 'dart:io';

import 'package:demo/Models/CarteGrise.dart';
import 'package:demo/Models/permis.dart';
import 'package:demo/Models/permisRouge.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  CarteGrise carteGrise;
  Permis permis;
  PermisRouge permisRouge;
  Future uploadImage(
    BuildContext context,
    File image,
    int id,
  ) async {
    final uri = Uri.parse(
        'http://35.238.162.27:8000/api/documents/' + id.toString() + '/');
    var request = http.MultipartRequest('POST', uri)
      ..headers.addAll({"Accept": "application/json"});

    var pic = await http.MultipartFile.fromPath("document", image.path);
    request.files.add(pic);
    var response = await request.send();
    var json = await http.Response.fromStream(response);
    if (response.statusCode == 201) {
      if (id == 0) {
        permis = Permis.fromJson(jsonDecode(json.body));
        showAlertDialogPermis(context, permis);
      } else if (id == 1) {
        permisRouge = PermisRouge.fromJson(jsonDecode(json.body));
        showAlertDialogPermisRouge(context, permisRouge);
      } else {
        carteGrise = CarteGrise.fromJson(jsonDecode(json.body));
        showAlertDialogCarteGrise(context, carteGrise);
      }
    } else {
      print(response.statusCode);
    }
  }

  File _image;
  final picker = ImagePicker();
  String photoName;

  Future getImage(
    BuildContext context,
    int id,
  ) async {
    final pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      await uploadImage(context, _image, id);
      setState(() {});
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: Future.delayed(Duration(seconds: 3)),
        builder: (context, AsyncSnapshot snapshot) {
          // Show splash screen while waiting for app resources to load:
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(home: Splash());
          } else {
            // Loading is done, return the app:
            return SafeArea(
              child: Scaffold(
                body: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Document personels",
                          style: GoogleFonts.poppins(
                              fontSize: 30, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Image.asset('assets/personal.png'),
                        ),
                      ],
                    ),
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: _image == null
                          ? Center(child: Text('No Image Selected'))
                          : Center(child: Image.file(_image)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xFF81ab95)),
                          child: FlatButton(
                            padding: EdgeInsets.all(5),
                            onPressed: () => getImage(context, 0),
                            child: Text(
                              "Permis Bio.",
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xFFdbaac0)),
                          child: FlatButton(
                            padding: EdgeInsets.all(5),
                            onPressed: () => getImage(context, 1),
                            child: Text(
                              "Permis Rouge",
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xFFa59f85)),
                          child: FlatButton(
                            padding: EdgeInsets.all(5),
                            onPressed: () => getImage(context, 2),
                            child: Text(
                              "Carte Grise",
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
              ),
            );
          }
        },
      ),
    );
  }

  showAlertDialogPermis(BuildContext context, Permis permis) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Permis Biometrique"),
      content: Container(
          width: 600,
          height: 600,
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Nom :"),
              Text(permis.nOM != null ? permis.nOM : "")
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Prenom :"),
              Text(permis.pRNOM != null ? permis.pRNOM : "")
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Date de naissance :"),
              Text(permis.dATEDENAISSANCE != null ? permis.dATEDENAISSANCE : "")
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Categorie :"),
              Text(permis.cATEGORIES != null ? permis.cATEGORIES : "")
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Sexe :"),
              Text(permis.sEXE != null ? permis.sEXE : "")
            ]),
          ])),
      actions: [
        okButton,
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

  showAlertDialogPermisRouge(BuildContext context, PermisRouge permisRouge) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Permis Rouge"),
      content: Container(
          width: 600,
          height: 600,
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Nom Arabe :"),
              Text(permisRouge.nOMARABE != null ? permisRouge.nOMARABE : "")
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Prenom Arabe :"),
              Text(permisRouge.pRNOMARABE != null ? permisRouge.pRNOMARABE : "")
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Date de naissance :"),
              Text(permisRouge.dATEDENAISSANCE != null
                  ? permisRouge.dATEDENAISSANCE
                  : "")
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Nom Fr :"),
              Text(permisRouge.nOMFR != null ? permisRouge.nOMFR : "")
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Prenom Fr :"),
              Text(permisRouge.pRNOMFR != null ? permisRouge.pRNOMFR : "")
            ]),
          ])),
      actions: [
        okButton,
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

  showAlertDialogCarteGrise(BuildContext context, CarteGrise carteGrise) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Carte Grise"),
      content: Container(
          width: 600,
          height: 600,
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Matricule :"),
              Text(carteGrise.nDIMMATRICULATION != null
                  ? carteGrise.nDIMMATRICULATION
                  : "")
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("A.P.M.C :"),
              Text(carteGrise.aNNEEDEPREMIEREMISEENCIRCULATION != null
                  ? carteGrise.aNNEEDEPREMIEREMISEENCIRCULATION
                  : "")
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Puissance :"),
              Text(carteGrise.pUISSANCE != null ? carteGrise.pUISSANCE : "")
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Nombre de places :"),
              Text(carteGrise.pLACESASSISES != null
                  ? carteGrise.pLACESASSISES
                  : "")
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Marque Fr :"),
              Text(carteGrise.mARQUEFR != null ? carteGrise.mARQUEFR : "")
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Marque Ar :"),
              Text(carteGrise.mARQUEARABE != null ? carteGrise.mARQUEARABE : "")
            ]),
          ])),
      actions: [
        okButton,
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
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 200,
                height: 200,
                child: Image.asset("assets/Yassir.png")),
            Text(
              "YASSIR",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600, fontSize: 50),
            ),
            Text('Chauffeur',
                style: GoogleFonts.poppins(
                    fontSize: 25,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w200))
          ],
        ),
      ),
    );
  }
}
