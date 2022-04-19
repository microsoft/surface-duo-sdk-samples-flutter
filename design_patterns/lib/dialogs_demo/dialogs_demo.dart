import 'package:dual_screen/dual_screen.dart';
import 'package:flutter/material.dart';

class DialogsDemo extends StatelessWidget {
  const DialogsDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Dialogs Demo'),
      ),
      body: TwoPane(
        startPane: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: ElevatedButton(
              child: Text('SHOW DEFAULT DIALOG'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      content: Text('Dialog shows on the left screen by default, since this a left-to-right layout.'),
                      actions: [
                        TextButton(
                            onPressed: Navigator.of(context).pop,
                            child: Text('Ok'))
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
        endPane: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: ElevatedButton(
              child: Text('SHOW ON THE RIGHT SCREEN'),
              onPressed: () {
                showDialog(
                  context: context,
                  anchorPoint: Offset(1000, 1000),
                  builder: (_) {
                    return AlertDialog(
                      content: Text('Dialog shows on the right screen since this is where the anchorPoint was positioned.'),
                      actions: [
                        TextButton(
                            onPressed: Navigator.of(context).pop,
                            child: Text('Ok'))
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
        panePriority: TwoPanePriority.both,
        direction: Axis.vertical,
      ),
    );
  }
}
