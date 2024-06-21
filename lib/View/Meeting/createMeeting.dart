import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CreateMeeting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
        ),
        title: Image.asset(
          'assets/h_logo1.png',
          scale: 10,
        ),
        shape: ContinuousRectangleBorder(
          side: BorderSide(
            style: BorderStyle.solid,
            color: Colors.white.withOpacity(0.7),
          ),
        ),
      ),
      body: MeetingForm(),
    );
  }
}

class MeetingForm extends StatefulWidget {
  @override
  _MeetingFormState createState() => _MeetingFormState();
}

class _MeetingFormState extends State<MeetingForm> {
  List<PlatformFile> pickedFiles = [];
  String textHolder = "";
  List<TextEditingController> controllers = [];

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.any,
    );
    if (result != null) {
      List<PlatformFile> files = result.files;
      files.forEach((element) {
        setState(() {
          pickedFiles.add(element);
        });
      });
    } else {
      return;
    }
  }

  DateTime currentDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        textHolder = "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
        currentDate = pickedDate;
      });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Titre',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: TextFormField(
              maxLines: null,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Description',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Responsable',
              ),
            ),
          ),
          ListView.builder(
            itemCount: controllers.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Participants présents',
                      ),
                      controller: controllers[index],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        controllers.removeAt(index);
                      });
                    },
                    child: Text("Supprimer"),
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.redAccent),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Container(
            margin: EdgeInsets.all(25),
            child: ElevatedButton(
              child: Text(
                "Ajouter un participant",
                style: TextStyle(fontSize: 20),
              ),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.redAccent),
                  ),
                ),
              ),
              onPressed: () {
                setState(() {
                  controllers.add(TextEditingController());
                });
              },
            ),
          ),
          Card(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                maxLines: 8,
                decoration: InputDecoration.collapsed(hintText: "Notes"),
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              child: Text(
                "Choisir des fichiers",
                style: TextStyle(fontSize: 20),
              ),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.redAccent),
                  ),
                ),
              ),
              onPressed: () {
                _pickFile();
              },
            ),
          ),
          Center(child: Text('$textHolder')),
          Center(
            child: ElevatedButton(
              child: Text(
                "Date",
                style: TextStyle(fontSize: 20),
              ),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.redAccent),
                  ),
                ),
              ),
              onPressed: () {
                _selectDate(context);
              },
            ),
          ),
          if (pickedFiles.isNotEmpty)
            Center(
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: pickedFiles.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return Center(
                    child: Column(
                      children: [
                        Text(
                          pickedFiles[index].name,
                          style: TextStyle(fontSize: 20),
                        ),
                        ElevatedButton(
                          child: Text(
                            "Supprimer",
                            style: TextStyle(fontSize: 20),
                          ),
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.red),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.redAccent),
                              ),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              pickedFiles.removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          Center(
            child: ElevatedButton(
              child: Text(
                "Enregistrer",
                style: TextStyle(fontSize: 20),
              ),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.redAccent),
                  ),
                ),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
