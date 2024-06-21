import 'package:flutter/material.dart';
import 'package:helpital_mobile_app/Utils/values.dart';

import 'package:helpital_mobile_app/Widgets/UtilsWidgets/imageViewer.dart';

import '../../Models/Message/message.dart';
import '../../Widgets/UtilsWidgets/pdfViewer.dart';
///import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class FileAndTextMessage extends StatelessWidget {
  FileAndTextMessage({
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
            height: size.height * 0.15,
            width: size.width * 0.05,
            child: TextButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute<dynamic>(
            builder: (_) => PDFViewerFromUrl(
              url: message.file,
            ),
          ),
        ),
        child:  Row(
          children: [
            Icon(Icons.upload_outlined),
            Text(
              message.file.split('/').last.toString(),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 10
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
          horizontal: myDefaultPadding * 0.75,
          vertical: myDefaultPadding / 2,
        ),
        decoration: BoxDecoration(
          color: HelpitalColors.myColorFourth.withOpacity(0.7),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
            children: [
            Text(
            message.text,
            style: TextStyle(
              color: message.isSender
                  ? Colors.white
                  : Theme.of(context).textTheme.bodyText1.color,
            ),
            ),
            value,



            ]
        )
    );
  }
}