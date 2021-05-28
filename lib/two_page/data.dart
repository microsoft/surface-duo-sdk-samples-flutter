import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final landscape = constraints.maxWidth > constraints.maxHeight;
      return Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'The Roman Colosseum',
              style: GoogleFonts.notoSerif(
                textStyle: TextStyle(
                  fontSize: landscape ? 24 : 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: landscape ? 15 : 30),
            Center(
              child: Image.asset('images/two_page_rome_image.png',
                  height: landscape ? 180 : 240),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                'Roman Colosseum, ancient history',
                style: GoogleFonts.notoSans(
                  textStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ),
            SizedBox(height: landscape ? 10 : 20),
            Text(
              'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.',
              style: GoogleFonts.notoSerif(
                textStyle: TextStyle(fontSize: landscape ? 14 : 16),
              ),
            ),
            Expanded(child: Container()),
            Center(
              child: Text(
                'Page 1 of 4',
                style: GoogleFonts.notoSans(
                  textStyle: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final landscape = constraints.maxWidth > constraints.maxHeight;
      return Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Why do we use it?',
              style: GoogleFonts.notoSerif(
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy',
              style: GoogleFonts.notoSerif(
                textStyle: TextStyle(fontSize: landscape ? 14 : 16),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Where can I get some?',
              style: GoogleFonts.notoSerif(
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable.',
              style: GoogleFonts.notoSerif(
                textStyle: TextStyle(fontSize: landscape ? 14 : 16),
              ),
            ),
            Expanded(child: Container()),
            Center(
              child: Text(
                'Page 2 of 4',
                style: GoogleFonts.notoSans(
                  textStyle: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final landscape = constraints.maxWidth > constraints.maxHeight;
      return Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Origins and Discovery',
              style: GoogleFonts.notoSerif(
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              '''
Until recently, the prevailing view assumed lorem ipsum was born as a nonsense text. "It\'s not Latin, though it looks like it, and it actually says nothing," Before & After magazine answered a curious reader, "Its \'words\' loosely approximate the frequency with which letters occur in English, which is why at a glance it looks pretty real.&quot;

As Cicero would put it, "Um, not so fast."

The placeholder text, beginning with the line "Lorem ipsum dolor sit amet, consectetur adipiscing elit", looks like Latin because in its youth, centuries ago, it was Latin.

Richard McClintock, a Latin scholar from Hampden-Sydney College, is credited with discovering the source behind the ubiquitous filler text. In seeing a sample of lorem ipsum, his interest was piqued by consectetur—a genuine, albeit rare, Latin word. Consulting a Latin dictionary led McClintock to a passage from De Finibus Bonorum et Malorum ("On the Extremes of Good and Evil"), a first-century B.C. text from the Roman philosopher Cicero.''',
              style: GoogleFonts.notoSerif(
                textStyle: TextStyle(fontSize: landscape ? 14 : 16),
              ),
            ),
            Expanded(child: Container()),
            Center(
              child: Text(
                'Page 3 of 4',
                style: GoogleFonts.notoSans(
                  textStyle: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    );
  }
}

class Page4 extends StatelessWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final landscape = constraints.maxWidth > constraints.maxHeight;
      return Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Here is the classic lorem ipsum passage followed by Boparai\'s odd, yet mesmerizing version:',
              style: GoogleFonts.notoSerif(
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam hendrerit nisi sed sollicitudin pellentesque. Nunc posuere purus rhoncus pulvinar aliquam. Ut aliquet tristique nisl vitae volutpat. Nulla aliquet porttitor venenatis. Donec a dui et dui fringilla consectetur id nec massa. Aliquam erat volutpat. Sed ut dui ut lacus dictum fermentum vel tincidunt neque. Sed sed lacinia lectus. Duis sit amet sodales felis. Duis nunc eros, mattis at dui ac, convallis semper risus. In adipiscing ultrices tellus, in suscipit massa vehicula eu.',
              style: GoogleFonts.notoSerif(
                textStyle: TextStyle(fontSize: landscape ? 14 : 16),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Boparai\'s version:',
              style: GoogleFonts.notoSerif(
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Rrow itself, let it be sorrow; let him love it; let him pursue it, ishing for its acquisitiendum. Because he will ab hold, uniess but through concer, and also of those who resist. Now a pure snore disturbeded sum dust. He ejjnoyes, in order that somewon, also with a severe one, unless of life. May a cusstums offficer somewon nothing of a poison-filled. Until, from a twho, twho chaffinch may also pursue it, not even a lump. But as twho, as a tank; a proverb, yeast; or else they tinscribe nor. Yet yet dewlap bed. Twho may be, let him love fellows of a polecat.  Now amour, the, twhose being, drunk, yet twhitch and, an enclosed valley’s always a laugh.',
              style: GoogleFonts.notoSerif(
                textStyle: TextStyle(fontSize: landscape ? 14 : 16),
              ),
            ),
            Expanded(child: Container()),
            Center(
              child: Text(
                'Page 4 of 4',
                style: GoogleFonts.notoSans(
                  textStyle: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    );
  }
}