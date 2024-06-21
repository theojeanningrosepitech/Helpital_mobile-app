import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Utils/values.dart';

class ChatInputField extends StatelessWidget {

  final Function(String) currentInput;

  String content;


  ChatInputField({this.currentInput});
  var _controller = TextEditingController();
  List<PlatformFile> pickedFiles = [];

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.any,
    );
    if (result != null) {
      List<PlatformFile> files = result.files;

      files.forEach((element) {
        print('element.bytes.toString()');
        print(element.name.toString());
        print(element.path.toString());
        print(element.size.toString());
        print(element.bytes.toString());
          pickedFiles.add(element);
      });
    } else {
      return;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: myDefaultPadding,
        vertical: myDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 32,
            color: Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            SizedBox(width: myDefaultPadding),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: myDefaultPadding * 0.75,
                ),
                decoration: BoxDecoration(
                  color: HelpitalColors.myColorFourth.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    SizedBox(width: myDefaultPadding / 4),
                    Expanded(
                      child: TextFormField(
                        controller: _controller,
                        onChanged: (str) {
                          if(str != null && str != '')
                            this.content = str;

                        },
                        decoration: InputDecoration(
                          hintText: "Écrire un message",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: _pickFile,
                      icon: Icon(
                      Icons.attach_file,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .color
                          .withOpacity(0.64),
                    ),
                    ),
                    SizedBox(width: myDefaultPadding / 4),
                    Icon(
                      Icons.camera_alt_outlined,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .color
                          .withOpacity(0.64),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  if (content != "") {
                    this.currentInput(content);
                    content = "";
                    _controller.clear();
                  }
                })
          ],
        ),
      ),
    );
  }
}