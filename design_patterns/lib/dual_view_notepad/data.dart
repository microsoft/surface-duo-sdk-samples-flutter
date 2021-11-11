const String initialMarkdownData = '''
# Large header (h1) 
###### Small header (h6)

Text can be *italic* or **bold** or *even **both** at the same time*. It can also contain [links](https://pub.dev/packages/dual_screen).

* Lists can be
  * unordered
    * Item
    * Item
  * ordered
    1. Item
    1. Item

This sample can be boiled down to using `TwoPane`:

```
TwoPane(
  pane1: TextField(
    onChanged: (text) {
      setState(() {
        this.data = text;
      });
    },
  ),
  pane2: Markdown(data: data),
  panePriority: panePriority,
)
```

> Markdown is a lightweight markup language with plain-text-formatting syntax, created in 2004 by John Gruber with Aaron Swartz.
''';