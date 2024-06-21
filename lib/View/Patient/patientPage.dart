import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Models/Utils/Cookies.dart';
import 'package:helpital_mobile_app/Services/cookiesService.dart';
import 'package:helpital_mobile_app/Services/roomsService.dart';
import 'package:helpital_mobile_app/View/Patient/PatientProfil/patientProfil.dart';
import 'package:helpital_mobile_app/View/Patient/scanPatientPage.dart';
import 'package:helpital_mobile_app/View/ScanQrCode/scanQrCode.dart';
import 'package:helpital_mobile_app/Widgets/PatternPages/pageScrollableDefault.dart';
import 'package:helpital_mobile_app/Widgets/mySearchingBar.dart';
import 'package:http/http.dart';

import '../../Models/Patients/Favoris.dart';
import '../../Models/Patients/Patient.dart';
import '../../Models/Rooms/Room.dart';
import '../../Models/User/User.dart';
import '../../Services/patientService.dart';
import '../../Utils/values.dart';
import '../../Widgets/UtilsWidgets/myCustomScrollView.dart';
import '../../Widgets/UtilsWidgets/myErrorWidget.dart';
import '../../Widgets/UtilsWidgets/myListBuilder.dart';
import '../../Widgets/UtilsWidgets/myLoading.dart';

class PatientPage extends StatefulWidget {
  const PatientPage({Key key}) : super(key: key);

  @override
  _PatientPageState createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> {

  List<Patient> listPatient = [];
  String query;
  List<Favoris> listFavoris;
  List<Patient> listPatientFavoris = [];
  Cookies myCookies;
  _PatientPageState() {
    CookiesService().getCookies().then((value) => {
      setState(() {
        myCookies = value;
      })
    });
    PatientService().getFavoris().then((value) => {
      setState(() {
        listFavoris = value;
      })
    });
  }
  setListofSearch(str) {
    List<Patient> bufferListPatient = [];
    if (str != null && str != '') {
      listPatient.forEach((element) {
        if (element.lastname.contains(str)) {
          bufferListPatient.add(element);
        } else if (element.firstname.contains(str)) {
          bufferListPatient.add(element);
        } else if (element.ssNumber.contains(str)) {
          bufferListPatient.add(element);
        }
      });
      listPatient = bufferListPatient;
    }
  }
  void deleteListPatientFavorisFavoris(Patient patient) {
    List<Patient> list = [];
    listFavoris.add(Favoris(
      id: listFavoris.length,
      patientId: patient.id,
      userId: int.parse(myCookies.userId),
    ));
    /*listPatientFavoris.forEach((element) {
      if (element.id != patient.id) {
        list.add(element);
      } else {
        listPatient.add(element);
      }
    });
    listPatientFavoris = [];
    listPatientFavoris = list;*/
  }
  void deleteListPatientFavoris(Patient patient) {
    List<Patient> list = [];
    for (int i = 0; i < listFavoris.length; i++) {
      if (listFavoris[i].patientId == patient.id) {
        listFavoris.removeAt(i);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    if (listFavoris != null) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 4,
                child: MySearchingBar(
                    currentInput: (str) {
                      if (listPatient != null) {
                        setState(() {
                          query = str;
                        });
                      }
                    }
                ),
              ),
              Expanded(
                  flex: 1,
                  child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (_) => ScanPatientPage(),
                          ),
                        );
                      },
                      icon: Icon(Icons.qr_code, color: HelpitalColors.myColorTextIcon,)
                  )
              ),

            ],
          ),

          Container(
            height: SizeCustom().assignHeight(context: context, fraction: 0.7),

            child:buildCore(),

          ),
        ],


      );
    } else {
      return MyLoading();
    }
  }

  void triPatient(List<Patient> list) {
    listPatientFavoris = [];
    listPatient = [];
    print("Trie Patient");
    print(listPatientFavoris.length);
    list.forEach((patient) {
      int i = 0;
      listFavoris.forEach((fav) {
        if (patient.id == fav.patientId) {
          print(patient.firstname);
          listPatientFavoris.add(patient);
          i = 1;

        }
      });
      if (i == 0) {
        listPatient.add(patient);
      }
    });
  }
  Widget buildCore() {
    return FutureBuilder(
      future: PatientService().getPatients(),
      initialData: 0,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MyLoading();
        }
        if (snapshot.hasError || snapshot.connectionState == ConnectionState.active) {
          return MyErrorWidget();
        } else {
          if (snapshot.data != null) {
            triPatient(snapshot.data);
            setListofSearch(query);
            print("=======================");
            print(listPatientFavoris.length);
            return  Column(
              children: [
                listFavoris != null ? Container(
                  height: SizeCustom().assignHeight(context: context, fraction: 0.3),
                  child: MyListBuilder(
                    list: listPatientFavoris,
                    builder: (context, index) {
                      return MyAnimationListBuilder(
                          index: index,
                          child: buildPatientElement(listPatientFavoris[index], true)
                      );
                    },
                  ),
                ): Container(),

                Container(
                    height: SizeCustom().assignHeight(context: context, fraction: 0.4),
                    child: MyListBuilder(
                      list: listPatient,
                      builder: (context, index) {
                        return MyAnimationListBuilder(
                            index: index,
                            child: buildPatientElement(listPatient[index], false)
                        );
                      },
                    )
                )
              ],
            );
          } else {
            return MyErrorWidget();
          }

        }
      },
    );
  }
  Widget buildPatientElement(Patient patient, bool isFav) {
    Room room;
    Icon iconStar;
    if (isFav) {
      iconStar = Icon(
          Icons.star,
          color: HelpitalColors.yellow
      );
    } else {
      iconStar = Icon(
          Icons.star_border_outlined,
          color: HelpitalColors.black
      );
    }

    return FutureBuilder(
      future: RoomsService().getRoom(patient.roomId),
      initialData: 0,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (_) => PatientProfil(patient: patient),
                ),
              );
            },
            child: ListTile(
              leading: isFav ? IconButton(
                  onPressed: () {
                    List<Favoris> favoris = listFavoris.where((element) => element.patientId == patient.id).toList();
                    PatientService().deleteFavoris(favoris[0].id);
                    setState(() {
                      deleteListPatientFavoris(patient);
                      iconStar =  Icon(
                          Icons.star_border_outlined,
                          color: HelpitalColors.black
                      );

                    });
                  },
                  icon: iconStar

              ) :  IconButton(
                  onPressed: () {
                    PatientService().setFavoris(patient.id);
                    setState(() {
                      //listPatient.where((element) => element.id = patient.id).re
                      deleteListPatientFavorisFavoris(patient);
                      iconStar = Icon(
                          Icons.star,
                          color: HelpitalColors.yellow
                      );

                    });
                  },
                  icon: iconStar
              ),
              title: Text(patient.firstname + ' ' + patient.lastname),
              subtitle: Text('${patient.birthdate.day.toString()}/${patient.birthdate.month.toString()}/${patient.birthdate.year.toString()}'),
              trailing: Text('recherche de salle ...'),
            ),
          );
        }
        if (snapshot.hasError || snapshot.connectionState == ConnectionState.active) {
          return MyErrorWidget();
        } else {
          if (snapshot.data != null) {
            room = snapshot.data;
            //setListofSearch(query);
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (_) => PatientProfil(patient: patient),
                  ),
                );
              },
              child: ListTile(
                leading: isFav ? IconButton(
                    onPressed: () {
                      List<Favoris> favoris = listFavoris.where((element) => element.patientId == patient.id).toList();
                      PatientService().deleteFavoris(favoris[0].id);
                      setState(() {
                        deleteListPatientFavoris(patient);
                        //listFavoris.where((element) => element.patientId == patient.id)
                        iconStar =  Icon(
                            Icons.star_border_outlined,
                            color: HelpitalColors.black
                        );});

                    },
                    icon: iconStar

                ) :  IconButton(
                    onPressed: () {
                      PatientService().setFavoris(patient.id);
                      setState(() {
                        deleteListPatientFavorisFavoris(patient);
                        iconStar = Icon(
                            Icons.star,
                            color: HelpitalColors.yellow
                        );});

                    },
                    icon: iconStar

                ),
                title: Text(patient.firstname + ' ' + patient.lastname),
                subtitle: Text('${patient.birthdate.day.toString()}/${patient.birthdate.month.toString()}/${patient.birthdate.year.toString()}'),
                trailing: Text(room.title),
              ),
            );
          } else {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (_) => PatientProfil(patient: patient),
                  ),
                );
              },
              child: ListTile(
                leading: isFav ? IconButton(
                    onPressed: () {
                      List<Favoris> favoris = listFavoris.where((element) => element.patientId == patient.id).toList();
                      PatientService().deleteFavoris(favoris[0].id);
                      setState(() {

                        iconStar =  Icon(
                            Icons.star_border_outlined,
                            color: HelpitalColors.black
                        );});
                    },
                    icon: iconStar

                ) :  IconButton(
                    onPressed: () {
                      PatientService().setFavoris(patient.id);
                      setState(() {

                        iconStar = Icon(
                            Icons.star,
                            color: HelpitalColors.yellow
                        );});
                    },
                    icon: iconStar

                ),
                title: Text(patient.firstname + ' ' + patient.lastname),
                subtitle: Text('${patient.birthdate.day.toString()}/${patient.birthdate.month.toString()}/${patient.birthdate.year.toString()}'),
                trailing: Text('aucune salle attribuée'),
              ),
            );
          }

        }
      },
    );

  }
}
