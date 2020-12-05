import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:schoolapp/const.dart';
import 'package:schoolapp/screens/internal_pages/custom_app_bar.dart';

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
            Expanded(flex: 1, child: ListView.builder(
              itemCount:generateExamNames().length ,
              itemBuilder: (BuildContext context, int index) { return Padding(

                padding: const EdgeInsets.symmetric(vertical:3.0),
                child: Container(
                  color: Colors.grey.withOpacity((index+1)/2*.08),
                  child: ListTile(
                  title: Text(generateExamNames()[index]),
                  onTap: (){
                     Navigator.of(context).push(MaterialPageRoute(builder: (c){return ViewResults();}));
                  },
            ),
                ),
              ); },)),
          ],
        ),
      ),
    );
  }
}

class ViewResults extends StatefulWidget {
  @override
  _ViewResultsState createState() => _ViewResultsState();
}

class _ViewResultsState extends State<ViewResults> {
  ExamResultFetchController _examResultFetchController;
final String url;

  _ViewResultsState(
      {this.url =
          "https://www.cambridgeenglish.org/images/141688-results-verification-user-guide.pdf"});
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _examResultFetchController = ExamResultFetchController();
    _examResultFetchController.getDocumentFromURL(
      url:
          url,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(

        child: Column(
          children: [
            CustomAppBar(tag: 'result', title: "View Results"),
            Expanded(flex:1,
              child: ValueListenableBuilder<ExamResultFetchStates>(
                valueListenable: _examResultFetchController.currentState,
                builder: (_, state, __) {

                  if (state == ExamResultFetchStates.fail) {

                    return GestureDetector(
                      child:  Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                           Image.asset('assets/errorConnection.png',height:  MediaQuery.of(context).size.height*.3,),
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Text("Oops! something happened on the way!\nTap to retry!",textAlign:TextAlign.center ,style: Constants.title.copyWith(fontSize: 18),),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        _examResultFetchController.getDocumentFromURL(
                            url:
                                url);
                      },
                    );
                  } else if (state == ExamResultFetchStates.done) {
                    return PDFViewer(
                      document: _examResultFetchController.loadedDocument,
                      zoomSteps: 1,
                      pickerButtonColor: Constants.lightAccent,
                    );
                  } else
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        CircularProgressIndicator(),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text("Loading Exam Results"),
                        ),
                      ],
                    );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum ExamResultFetchStates { loading, done, fail }

class ExamResultFetchController {
  ValueNotifier<ExamResultFetchStates> _notifier =
      ValueNotifier<ExamResultFetchStates>(ExamResultFetchStates.loading);

  ValueNotifier<ExamResultFetchStates> get currentState {
    ExamResultFetchStates state;
    if (_notifier == null) state = ExamResultFetchStates.loading;
    _notifier ??= ValueNotifier(state);
    return _notifier;
  }

  PDFDocument _document;
  String _errorMessage;

  String get errorText => _errorMessage;

  PDFDocument get loadedDocument => _document;

  getDocumentFromURL({String url}) async {
    _notifier.value = ExamResultFetchStates.loading;
    try {
      PDFDocument pdf = await PDFDocument.fromURL(
       url,
        cacheManager: CacheManager(
          Config(
           url,
            stalePeriod: const Duration(days: 7),
            maxNrOfCacheObjects: 10,
          ),
        ),
      );
      _document = pdf;
      _notifier.value = ExamResultFetchStates.done;
    } on Exception catch (e) {
      _document=null;
      _errorMessage = e.runtimeType.toString();
      _notifier.value = ExamResultFetchStates.fail;
    }
  }
}
