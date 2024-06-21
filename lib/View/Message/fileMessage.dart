import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Utils/values.dart';

import '../../Models/Message/message.dart';
import '../../Widgets/UtilsWidgets/imageViewer.dart';
import '../../Widgets/UtilsWidgets/pdfViewer.dart';


class FileMessage extends StatelessWidget {
  FileMessage({
    Key key,
    this.message,
  }) : super(key: key);

  final ChatMessage message;
  Widget value;

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    if (message.file.contains('.pdf')) {

      value = Container(
        width: size.width * 0.30,
        child: TextButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute<dynamic>(
            builder: (_) => PDFViewerFromUrl(
              url: message.file,
            ),
          ),
        ),
        child: Row(
          children: [
             Icon(Icons.upload_outlined, size: 10,),

            Expanded(
                child: Text(
                  message.file.split('/').last.toString(),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 10
                  ),
                ),
            ),

          ],
        )

      )
      );

    } else {
      value = Container(
        height: size.height * 0.15,
        width: size.width * 0.15,
        child: TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute<dynamic>(
                builder: (_) => ImageViewer(
                  url: message.file,
                ),
              ),
            ),
            child: Image.network(message.file)
        )
      );
    }
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: myDefaultPadding * 0.5,
        vertical: myDefaultPadding / 6,
      ),
      decoration: BoxDecoration(
        color: HelpitalColors.myColorFourth.withOpacity(0.7),
        borderRadius: BorderRadius.circular(30),
      ),
      child: value
    );
  }
}