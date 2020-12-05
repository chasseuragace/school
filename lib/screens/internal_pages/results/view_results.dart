import 'package:flutter/material.dart';
import 'package:schoolapp/screens/internal_pages/custom_app_bar.dart';
import 'package:schoolapp/screens/internal_pages/results/pdf_viewer_from_cache.dart';

class ViewResults extends StatefulWidget {
  final title;
  final tag;

  const ViewResults({Key key, this.title, this. tag}) : super(key: key);
  @override
  _ViewResultsState createState() => _ViewResultsState();
}

class _ViewResultsState extends State<ViewResults> {

  final String url;

  _ViewResultsState({this.url =
  "https://www.cambridgeenglish.org/images/141688-results-verification-user-guide.pdf"});


  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(tag: widget.tag, title: "${widget.title} Results",customAsset: 'result',),
            Expanded(
                flex: 1,
                child: PDFViewerCachedFromUrl(
                  url: url,
                )
            ),
          ],
        ),
      ),
    );
  }
}