import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:helpital_mobile_app/Utils/values.dart';

class PDFViewerFromUrl extends StatelessWidget {
  const PDFViewerFromUrl({Key key, this.url}) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HelpitalColors.myColorPrimary,
        title: Text(url.split('/').last),
      ),
      body: PDF(
        swipeHorizontal: true,
      ).cachedFromUrl(
        //url,
          'http://www.crdp-strasbourg.fr/je_lis_libre/livres/Carroll_AliceAuPaysDesMerveilles.pdf',
        placeholder: (double progress) {
          return Center (child: Text('$progress %'));
        },
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
    );
  }
}
