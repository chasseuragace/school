import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:schoolapp/const.dart';


import 'package:schoolapp/simple_utils/ui_modifiers.dart';

class EditText extends StatefulWidget {
  final selectionText;
  EditText({
    Key key, this. selectionText,
  }) : super(key: key);

  @override
  _EditTextState createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
  @override
  void dispose() {

    _applicationController.dispose();
    resetOrientation();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setOrientation();
    _applicationController = TextEditingController(text: "");

    _application.requestFocus();

  }


  TextEditingController _applicationController;
  final FocusNode _application = FocusNode();
  ValueNotifier<bool > _shouldSaveBeAvailable=ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading:
          _applyListnertoChild( IconButton(
            key: ValueKey('save'),
            icon: Icon(Icons.check, color: Constants.lightAccent),
            onPressed: () {
              //todo save application for leave here
              Navigator.of(context).pop();
            },
          ),IconButton(
            key: ValueKey('back'),
            icon: Icon(Icons.arrow_back, color:Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ))

          ,
          actions: [
            _applyListnertoChild(
              IconButton(
                icon: Icon(Icons.close, color: Colors.black),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),SizedBox()
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: ScrollConfiguration(
            behavior: NoGlow(),
            child: SingleChildScrollView(
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * .2,
                      child: TweenAnimationBuilder(
                        curve: Curves.easeInOutBack,
                        duration: Duration(milliseconds: 800),
                        tween: Tween<double>(begin: .1, end: 1),
                        builder:
                            (BuildContext context, double value, Widget child) {
                          return Transform.scale(
                              scale: value,
                              child: Transform.translate(
                                offset: Offset(0, (value - 1) * 80),
                                child: child,
                              ));
                        },
                        child: Hero(
                          tag: "edit",
                          child: Image.asset(
                            "assets/intro2.png",
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        SizedBox(height:55),
                        Flexible(child: Text("Leave${widget.selectionText}",style: Constants.title.copyWith(fontSize: 16),maxLines: 2,)),

                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      minLines: 8,
                      maxLines: 20,
                      keyboardType: TextInputType.multiline,
                      onFieldSubmitted: (va) {},
                      focusNode: _application,
                      textAlign: TextAlign.justify,
                      controller: _applicationController,
                      onChanged: (val) {
                        if(val.trim().isNotEmpty && _shouldSaveBeAvailable.value==false)
                          _shouldSaveBeAvailable.value=true;
                        else if(val.trim().isEmpty){
                          _shouldSaveBeAvailable.value=false;
                        }
                      },
                      style: Theme.of(context).textTheme.headline5,
                      decoration: InputDecoration(
                        // prefixIcon: Icon(Icons.lock),
                        hintText: "Description",
                        border: InputBorder.none,
                        hintStyle: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: Colors.black54),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  resetOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp,
    ]);
  }

  setOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  _applyListnertoChild(Widget child1,Widget child2, ){
    return ValueListenableBuilder(
      valueListenable: _shouldSaveBeAvailable,
      builder: (BuildContext context, bool value, Widget _) {
        return AnimatedSwitcher(
          duration: Duration(milliseconds: 200),
          switchInCurve: Curves.easeIn,
          child: value? child1: child2,

        );
      },

    );
  }
}
