import 'package:dual_screen_samples/dual_view_notepad/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';

class DualViewNotepad extends StatefulWidget {
  const DualViewNotepad({Key? key}) : super(key: key);

  @override
  _DualViewNotepadState createState() => _DualViewNotepadState();
}

class _DualViewNotepadState extends State<DualViewNotepad> {
  String data = initialMarkdownData;
  bool editing = true;
  TextEditingController textController =
      TextEditingController(text: initialMarkdownData);

  @override
  Widget build(BuildContext context) {
    bool singleScreen = MediaQuery.of(context).hinge == null;
    var panePriority = TwoPanePriority.both;
    if (singleScreen) {
      panePriority = editing ? TwoPanePriority.pane1 : TwoPanePriority.pane2;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Dual View Notepad'),
        actions: [
          if (singleScreen)
            TextButton(
              style: TextButton.styleFrom(primary: Colors.white),
              onPressed: () {
                setState(() {
                  editing = !editing;
                });
              },
              child: Text(editing ? 'View' : 'Edit'),
            )
        ],
      ),
      body: TwoPane(
        pane1: DraftSavedMessage(
          child: PaneDecorations(
            header: Text('Editor'),
            contentColor: Colors.white,
            headerColor: Colors.blue[200]!,
            child: TextField(
              controller: textController,
              maxLines: 999,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(16),
              ),
              style: GoogleFonts.robotoMono(),
              onChanged: (text) {
                setState(() {
                  this.data = text;
                });
              },
            ),
          ),
        ),
        pane2: PaneDecorations(
          header: Text('Preview'),
          contentColor: Colors.transparent,
          headerColor: Colors.green[200]!,
          child: Markdown(data: data),
        ),
        panePriority: panePriority,
      ),
    );
  }
}

class DraftSavedMessage extends StatelessWidget {
  const DraftSavedMessage({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(
          bottom: 32,
          left: 32,
          right: 32,
          child: Material(
            borderRadius: BorderRadius.circular(6),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(child: Text('Your drafts have been saved!')),
                  Text(
                    'Close',
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class PaneDecorations extends StatelessWidget {
  const PaneDecorations({
    Key? key,
    required this.contentColor,
    required this.headerColor,
    required this.header,
    required this.child,
  }) : super(key: key);

  final Color contentColor;
  final Color headerColor;
  final Text header;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[600]!, width: 1),
        borderRadius: BorderRadius.circular(6),
        color: contentColor,
      ),
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(6),
                topRight: Radius.circular(6),
              ),
              color: headerColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: DefaultTextStyle(
                style: TextStyle(fontSize: 16, color: Colors.black),
                child: header,
              ),
            ),
          ),
          Container(
            height: 1,
            color: Colors.grey[600],
          ),
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}
