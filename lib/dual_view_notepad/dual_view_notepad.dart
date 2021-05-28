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
        pane1: TextField(
          controller: textController,
          maxLines: 999,
          decoration: const InputDecoration(
            contentPadding: const EdgeInsets.all(16.0),
          ),
          style: GoogleFonts.robotoMono(),
          onChanged: (text) {
            setState(() {
              this.data = text;
            });
          },
        ),
        pane2: Markdown(data: data),
        panePriority: panePriority,
      ),
    );
  }
}
