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
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('HERE'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      content: Text('Dialog shows on the same screen.'),
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
            ElevatedButton(
              child: Text('HERE'),
              onPressed: () {
                showDialog(
                  context: context,
                  anchorPoint: Offset.infinite,
                  builder: (_) {
                    return AlertDialog(
                      content: Text('Dialog shows on the same screen.'),
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
          ],
        ),
      ),
    );
  }
}
