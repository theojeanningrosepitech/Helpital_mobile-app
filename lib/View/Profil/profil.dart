import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Models/User/User.dart';
import 'package:helpital_mobile_app/Services/userService.dart';
import 'package:helpital_mobile_app/Utils/values.dart';
import 'package:helpital_mobile_app/View/Profil/profilSettings.dart';
import 'package:helpital_mobile_app/View/Profil/qrCodeGen.dart';
import 'package:helpital_mobile_app/Widgets/Buttons/myButtonCustom.dart';
import 'package:helpital_mobile_app/Widgets/UtilsWidgets/myLoading.dart';
import 'package:helpital_mobile_app/Widgets/UtilsWidgets/myRouteBuilder.dart';
import 'package:helpital_mobile_app/Widgets/myTextFieldCustom.dart';


class Profil extends StatefulWidget {
  const Profil({Key key}) : super(key: key);

  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  User user;

  _ProfilState() {
    UserService().getUserInfo().then((value) {
      setState(() {
        user = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onHorizontalDragUpdate: (details) {
          // Note: Sensitivity is integer used when you don't want to mess up vertical drag
          int sensitivity = 8;
          if (details.delta.dx < -sensitivity) {
            Navigator.pop(context);
          }
        },
        child: Scaffold(
            backgroundColor: HelpitalColors.myColorBackground,
            appBar: buildAppBar(context),
            //body: MyUnvailablePage(),
            body: buildCore(context)));
  }

  Widget buildAppBar(BuildContext context) => AppBar(
    elevation: 0.0,

    backgroundColor: HelpitalColors.white,
        leading: IconButton(
          icon: Icon(
            Icons.settings,
            color: HelpitalColors.myColorTextIcon,
          ),
          onPressed: () {
            if (user != null) {
              Navigator.of(context).push(
                  MyRouteBuilder().createRoute(ProfilSettings(user: this.user,), -1.0, 0.0));
            }

          },
        ),
        title: Image.asset(
          HelpitalAssets.HELPITAL,
          scale: 10,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.arrow_forward_ios_outlined,
              color: HelpitalColors.myColorTextGrey,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );

  Widget buildCore(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Image profilePicture = Image.asset(
      HelpitalAssets.HELPITAL_LOGO,
      scale: 3,
    );

    if (user != null && user.service != null && user.userRole != null) {
      String name = user.firstName + ' ' + user.lastName;
      String poste = user.userRole;
      String id = user.login;
      String password = '12345678';
      String email = user.email;
      String number = user.phone;

      return Center(
        child: Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(10),
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Container(
                          width: size.width * 0.3,
                          height: size.width * 0.3,
                          decoration: new BoxDecoration(
                            color: HelpitalColors.myColorTextGreyClair,
                            shape: BoxShape.circle,
                          ),
                          child: profilePicture),
                      FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          name,
                          style:
                              TextStyle(color: HelpitalColors.myColorTextIcon, fontSize: 25),
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          poste,
                          style:
                              TextStyle(color: HelpitalColors.myColorTextIcon, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 1,
                      ),
                      MyTextFieldCustom(
                        canEdit: false,
                        name: id,
                        icon: Icons.perm_identity,
                        textObscure: false,
                        currentInput: (input) {
                          print(input);
                        },
                      ),
                      MyTextFieldCustom(
                        canEdit: false,
                        name: password,
                        icon: Icons.lock,
                        textObscure: false,
                        currentInput: (input) {
                          print(input);
                        },
                      ),
                      MyTextFieldCustom(
                        canEdit: false,
                        name: email,
                        icon: Icons.email_outlined,
                        textObscure: false,
                        currentInput: (input) {
                          print(input);
                        },
                      ),
                      MyTextFieldCustom(
                        canEdit: false,
                        name: number,
                        icon: Icons.phone,
                        textObscure: false,
                        currentInput: (input) {
                          print(input);
                        },
                      ),
                      SizedBox(
                        height: 1,
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: MyButtonCustom(
                      name: 'Génerer son QrCode',
                      onClick: () {
                        print("ca passe profil");
                        //Navigator.of(context).push(MyRouteBuilder().createRoute(QrCodeGen(), 1.0, 1.0));
                        Navigator.of(context).push(MyRouteBuilder()
                            .createRoute(QrCodeGen(data: user.id,), 1.0, 1.0));
                      })),
            ],
          ),
        ),
      );
    } else {
      return Center(
        child: MyLoading(),
      );
    }
  }
}
