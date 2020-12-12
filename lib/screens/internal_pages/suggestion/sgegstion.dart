import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schoolapp/const.dart';
import 'package:schoolapp/screens/internal_pages/custom_app_bar.dart';
import 'package:schoolapp/simple_utils/widgets.dart';

class Suggestion extends StatelessWidget {
  static const String tag = "suggestions";
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _contentController = TextEditingController();
  final _subjectNode = FocusNode();
  final _contentNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              CustomAppBar(tag: tag, title: "Suggestion"),
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Center(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * .2,
                            child: TweenAnimationBuilder(
                              curve: Curves.easeInOutBack,
                              duration: Duration(milliseconds: 800),
                              tween: Tween<double>(begin: .1, end: 1),
                              builder: (BuildContext context, double value,
                                  Widget child) {
                                return Transform.scale(
                                    scale: value,
                                    child: Transform.translate(
                                      offset: Offset(0, (value - 1) * 80),
                                      child: child,
                                    ));
                              },
                              child: Image.asset(
                                "assets/intro1.png",
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            autofocus: true,
                            focusNode: _subjectNode,
                            controller: _subjectController,
                            onFieldSubmitted: (x) {
                              _contentNode.requestFocus();
                            },
                            validator: (s) {
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Eg. Inquiry on Bus Schedule",
                              labelText: "Subject",
                              labelStyle:
                                  Constants.title.copyWith(fontSize: 16),
                              prefixIcon: Icon(
                                Icons.subtitles_rounded,
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.green)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            focusNode: _contentNode,
                            keyboardType: TextInputType.multiline,
                            minLines: 8,
                            maxLines: 24,
                            controller: _contentController,
                            validator: (s) {
                              return null;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide(color: Colors.green)),
                              hintText: "Any queries or suggestions",
                            ),
                          ),
                        ),
                        appButton(
                            text: "Submit",
                            onTap: () {
                              _formKey.currentState.validate()
                                  ? proceedToSubmit(context)
                                  : null;
                            })
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  proceedToSubmit(context) {
    FocusScope.of(context).unfocus();

    Navigator.of(context).pop();
  }
}
