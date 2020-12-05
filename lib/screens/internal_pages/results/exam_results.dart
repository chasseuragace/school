import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:schoolapp/const.dart';
import 'package:schoolapp/screens/internal_pages/custom_app_bar.dart';
import 'package:numberpicker/numberpicker.dart';

List<String> generateExamNames() {
  var examNames = [
    "First Term Exam",
    "Mid Term -qualifier  Exam",
    "Mid Term Exam",
    "Final Term-qualifier  Exam",
  ];
  return examNames;
}

class ExamResults extends StatelessWidget {
  static const String tag = "result";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(tag: tag, title: "Results"),
            Expanded(
                flex: 1,
                child: ListView.builder(
                  itemCount: generateExamNames().length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Container(
                        color: Colors.grey.withOpacity((index + 1) / 2 * .08),
                        child: ListTile(
                          title: Text(generateExamNames()[index]),
                          onTap: () async {
                           await setOrientation(context);
                            await Navigator.of(context)
                                .push(MaterialPageRoute(builder: (c) {
                              return ViewResults(title:generateExamNames()[index]);
                            }));
                            resetOrientation();
                          },
                        ),
                      ),
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }

  setOrientation(context)async {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
if( MediaQuery.of(context).orientation!=Orientation.portrait) {
      await Future.delayed(Duration(milliseconds: 100),);
    }
  }

  resetOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp,
    ]);
  }
}

class ViewResults extends StatefulWidget {
  final title;

  const ViewResults({Key key, this.title}) : super(key: key);
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
            CustomAppBar(tag: 'result', title: "${widget.title} Results"),
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


class PDFViewerCachedFromUrl extends StatelessWidget {

   PDFViewerCachedFromUrl({Key key, @required this.url, }) : super(key: key);

  final String url;
  final ValueNotifier<PDFViewController> _controller =
  ValueNotifier<PDFViewController>(null);
  final ValueNotifier<List<int>> _pageNotifer =
  ValueNotifier<List<int>>([0, 0]);
  @override
  Widget build(BuildContext context) {


    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: ValueListenableBuilder<PDFViewController>(
          builder: (BuildContext context, value, Widget child) {
            return value != null
                ? FloatingActionButton(
              elevation: 4.0,
              tooltip: 'Jump To',
              child: Icon(
                Icons.view_carousel,
                color: Colors.white,
              ),
              backgroundColor: Constants.lightAccent,
              onPressed: () async {
                int count = await value.getPageCount();
                int current = await value.getCurrentPage();
                _pickPage(context, count, current, (page) {
                  _controller.value.setPage(page);
                });
              },
            )
                : SizedBox();
          },
          valueListenable: _controller,
        ),
        body: Stack(
          children: [
            PDF(
              onViewCreated: (PDFViewController controller) {
                _controller.value = controller;
              },
              onPageChanged: (v1, v2) {
                _pageNotifer.value = [v1 + 1, v2 ];
              },
              swipeHorizontal: true,
            ).cachedFromUrl(url,

              placeholder: (double progress) {
                return
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    (progress!=0)?  CircularProgressIndicator(value: progress/100,):CircularProgressIndicator(),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text("Loading Exam Results"),
                      ),
                    ],
                  ),
                );
              },
              errorWidget: (dynamic error) {

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/errorConnection.png',
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * .3,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          "Oops! something happened on the way!",
                          textAlign: TextAlign.center,
                          style: Constants.title.copyWith(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                );
              },
              maxAgeCacheObject: Duration(days: 15),
            maxNrOfCacheObjects: 7,

            ),
            Positioned(right: 8,top: 8,
              child: ValueListenableBuilder<List<int>>(
                builder: (BuildContext context, value, Widget child) {
                  return
                    value.contains(0)?SizedBox():

                    Material(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[200].withOpacity(.6),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('${value[0]} of ${value[1]}'),
                    ),
                  );
                }, valueListenable: _pageNotifer,),
            )
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: ValueListenableBuilder<List<int>>(
            valueListenable: _pageNotifer,
            builder: (context, value,_) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: IconButton(
                      icon: Icon(Icons.first_page),
                      tooltip: 'First',
                      onPressed: value.contains (1)? null:() async {
                        _controller.value.setPage(0);
                      },
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: Icon(Icons.chevron_left),
                      tooltip: "Previous",
                      onPressed: value.contains (1)? null :() async {
                        var current = await _controller.value.getCurrentPage();
                        if (current - 1 >= 0)
                          _controller.value.setPage(current - 1);
                      },
                    ),
                  ),
                 const Expanded(child: Text('')),
                  Expanded(
                    child: IconButton(
                      icon: Icon(Icons.chevron_right),
                      tooltip: 'Next',
                      onPressed: value[0]==(value[1])? null:() async {
                        var current = await _controller.value.getCurrentPage();
                        _controller.value.setPage(current + 1);
                      },
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: Icon(Icons.last_page),
                      tooltip: 'Last',
                      onPressed:value[0]==(value[1])? null: () async {
                        var count = await _controller.value.getPageCount();
                        _controller.value.setPage(count - 1);
                      },
                    ),
                  ),
                ],
              );
            }
          ),
        ));
  }

    _pickPage(context, count, current, jump(int)) {
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return NumberPickerDialog.integer(
            title: Text('Jump To Page'),
            minValue: 1,
            cancelWidget: Container(),
            maxValue: count,
            initialIntegerValue: current + 1,
          );
        }).then((int value) {
      if (value != null) {
        jump(value - 1);
      }
    });
  }


}
