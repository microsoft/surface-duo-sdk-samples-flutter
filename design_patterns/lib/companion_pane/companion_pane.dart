import 'package:dual_screen/dual_screen.dart';
import 'package:dual_screen_samples/companion_pane/data.dart';
import 'package:flutter/material.dart';

class CompanionPane extends StatelessWidget {
  const CompanionPane({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool singleScreen = MediaQuery.of(context).hinge == null && MediaQuery.of(context).size.width < 1000;
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Companion Pane'),
        ),
        body: TwoPane(
          startPane: PreviewPane(),
          endPane: ToolsPane(),
          paneProportion: 0.7,
          direction: singleScreen ? Axis.vertical : Axis.horizontal,
          padding: EdgeInsets.only(
              top: kToolbarHeight + MediaQuery.of(context).padding.top),
        ),
      ),
    );
  }
}

class PreviewPane extends StatelessWidget {
  const PreviewPane({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Image.asset(
        'images/companion_pane_image.png',
        fit: BoxFit.contain,
      ),
    );
  }
}

class ToolsPane extends StatelessWidget {
  const ToolsPane({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxHeight > 250 && constraints.maxWidth > 400) {
        return LargeToolsPane();
      } else {
        return SmallToolsPane();
      }
    });
  }
}

class LargeToolsPane extends StatelessWidget {
  const LargeToolsPane({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constraints.maxHeight,
          ),
          child: IntrinsicHeight(
            child: Column(
              children: [
                Spacer(flex: 10),
                ...tools
                    .expand((e) => [
                          ExpandedToolTile(tool: e),
                          Spacer(flex: 1),
                        ])
                    .toList(),
                Spacer(flex: 10),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class SmallToolsPane extends StatelessWidget {
  const SmallToolsPane({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(flex: 1),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ToolSlider(),
        ),
        Spacer(flex: 1),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children:
                tools.map((e) => ToolTile(tool: e, onTap: () {})).toList(),
          ),
        ),
        Spacer(flex: 2),
      ],
    );
  }
}

class ExpandedToolTile extends StatelessWidget {
  final Tool tool;

  const ExpandedToolTile({Key? key, required this.tool}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          ToolTile(tool: tool),
          SizedBox(width: 10),
          Expanded(child: ToolSlider()),
        ],
      ),
    );
  }
}

class ToolTile extends StatelessWidget {
  final Tool tool;
  final VoidCallback? onTap;

  const ToolTile({
    Key? key,
    required this.tool,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 82,
        height: 82,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(tool.icon, size: 34),
            SizedBox(height: 10),
            Text(tool.name, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class ToolSlider extends StatefulWidget {
  const ToolSlider({Key? key}) : super(key: key);

  @override
  _ToolSliderState createState() => _ToolSliderState();
}

class _ToolSliderState extends State<ToolSlider> {
  double value = 0;

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: value,
      onChanged: (v) {
        setState(() {
          value = v;
        });
      },
    );
  }
}
