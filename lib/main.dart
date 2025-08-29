import 'package:flutter/material.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:dotted_border/dotted_border.dart';

void main() {
  runApp(const MaterialApp(title: 'Navigation Basics', home: IndexPage()));
}

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/assets/img/theme_bg.png"),
                fit: BoxFit.cover,
              ),
            ),
            child:
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Center(
                        child:Image.asset("lib/assets/img/logo/app_logo.png",height: 250,)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical:100,
                      horizontal: 50,
                    ),
                    child: SwipeButton.expand(
                      duration: const Duration(milliseconds: 200),
                      thumb: Icon(
                          Icons.double_arrow_rounded,
                          color: Colors.yellow[600]
                      ),
                      activeThumbColor: Colors.blueBrand,
                      activeTrackColor: Colors.white,
                      onSwipe: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MenuPage())
                        );
                      },
                      child: const Text(
                        " Get Started ... ",
                        style: TextStyle(
                            color: Colors.blueBrand,
                            fontWeight : FontWeight.bold,
                            fontSize: 20
                        ),
                      ),
                    ),
                  )
                ]
            )
        )
    );
  }
}
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}


class AppAction {
  final Color color;
  final String label;
  final Color labelColor;
  final IconData iconData;
  final Color iconColor;
  final void Function(BuildContext) callback;

  AppAction({
    this.color = Colors.white,
    required this.label,
    this.labelColor = Colors.blueBrand,
    required this.iconData,
    this.iconColor = Colors.blueBrand,
    required this.callback,
  });
}

final List<AppAction> actions = [
  AppAction(
    color: Colors.mustardBrand,
    label: 'FFMS',
    labelColor: Colors.black87,
    iconData: Icons.dining,
    callback: (context) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => FfmsPage()));
    },
  ),
  AppAction(
    color: Colors.mustardBrand,
    label: 'WORD',
    labelColor: Colors.black87,
    iconData: Icons.auto_stories,
    callback: (context) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => MailScreen()));
    },
  ),
  AppAction(
    color: Colors.mustardBrand,
    label: 'WORSHIP',
    labelColor: Colors.black87,
    iconData: Icons.headset,
    iconColor: Colors.black87,
    callback: (context) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => UrgentScreen()));
    },
  ),
  AppAction(
    color: Colors.mustardBrand,
    label: 'Guide',
    labelColor: Colors.black87,
    iconData: Icons.diversity_3,
    iconColor: Colors.blueBrand,
    callback: (context) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => NewsScreen()));
    },
  ),
];

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});
  @override
  Widget build(BuildContext context) {
    return AppLayout(
        pageTitle: 'Home',
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("lib/assets/img/theme_bg.png"), fit: BoxFit.cover),
          ),
          padding: EdgeInsets.only(left:15,right:15,top:200),
          child: GridView.extent(
            maxCrossAxisExtent: 250,
            crossAxisSpacing: 20,
            mainAxisSpacing: 50,
            children:
            actions.map((action) => ActionButton(action: action)).toList(),
          ),
        )
    );
  }
}

class AppLayout extends StatelessWidget {
  final String? pageTitle;
  final Widget? child;

  const AppLayout({Key? key,  this.pageTitle,  this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(pageTitle!)),
      body: child,
    );
  }
}

class ActionButton extends StatelessWidget {
  final AppAction action;

  const ActionButton({
    Key? key,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    bool isHoverd = false;
    return OutlinedButton(
      onHover: (hovering)=> setState(() => isHoverd = true),
      onPressed: () => action.callback?.call(context),
      style: OutlinedButton.styleFrom(
        backgroundColor: isHoverd ? Colors.yellowBrand : action.color,
        padding: const EdgeInsets.all(30.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      child: Column( // Replace with a Row for horizontal icon + text
        children: <Widget>[
          Icon(
            action.iconData,
            color: action.iconColor,
            size:80,
          ),
          Text(
              action.label,
              style: TextStyle(
                  color: action.labelColor,
                  fontWeight : FontWeight.bold,
                  fontSize: 25
              )
          )
        ],
      ),
    );
  }

  void setState(bool Function() param0) {}
}



class MailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppLayout(
      pageTitle: 'Word Page',
      child: Center(
        child: Text('Daily Devotional'),
      ),
    );
  }
}

class UrgentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppLayout(
      pageTitle: 'Worship Page',
      child: Center(
        child: Text('Coming Soon...', style: TextStyle(color: Colors.redAccent)),
      ),
    );
  }
}

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppLayout(
      pageTitle: 'Guide Page',
      child: Center(
        child: Text('Coming Soon...', style: TextStyle(color: Colors.green)),
      ),
    );
  }
}

class FfmsPage extends StatelessWidget {
  const FfmsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const String appTitle = 'Food For My Spirit';
    return AppLayout(
        pageTitle: appTitle,
        child: Scaffold(
          body: const SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                ImageSection(
                  image: 'lib/assets/ffms/day1.png',
                ),
                TitleSection(
                  name: 'No More Sin Problem',
                ),
                VerseSection (),
                TextSection(
                  description:
                  'You don’t have to live your life in guilt and shame for'
                      'the sins you have committed in the past. The blood of'
                      'Jesus has wiped out or cancelled the record of charges'
                      'against you by nailing it to the cross. Jesus has triumphed'
                      'over the powers of Satan. The penalty for your sins has'
                      'been paid for.'
                      '\n'
                      '\n'
                      'Come to Jesus and appropriate what He has done'
                      'for you by praying this prayer: Heavenly Father, I repent'
                      'of my sins and I receive the victory that the Lord Jesus has'
                      'given me through His death on the cross. I open the door'
                      'of my heart and receive Him as my Lord and Savior.'
                      'Amen.'
                  ,
                ),
                DeclarationSection(),

              ],
            ),
          ),
        )
    );

  }
}

class TitleSection extends StatelessWidget {
  const TitleSection({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold,fontSize:30),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class VerseSection extends StatelessWidget {
  const VerseSection({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).primaryColor;
    return SizedBox(
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          dashPattern: [10, 5],
          strokeWidth: 2,
          radius: Radius.circular(20),
          color: Colors.blueBrand,
          padding: EdgeInsets.all(12),
        ),
        child: Text(
          'Colossians 2:15\n'
              '“Having disarmed principalities and powers, He'
              'made a public spectacle of them, triumphing over'
              'them in it.”',
          style: TextStyle(
              color: Colors.black,
              fontSize:16
          ),
          softWrap: true,
        ),
      ),
    );
  }

}

class ButtonWithText extends StatelessWidget {
  const ButtonWithText({
    super.key,
    required this.color,
    required this.icon,
    required this.label,
  });

  final Color color;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
class TextSection extends StatelessWidget {
  const TextSection({super.key, required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(description, softWrap: true),
    );
  }
}

class DeclarationSection extends StatelessWidget {
  const DeclarationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Speak the Word',
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                fontStyle:FontStyle.italic
            ),
          ),
          Text(
            '“I am now a child of God through my faith in Jesus Christ.'
                '\nI am whole, I am clean and I have no more record of wrongs.'
                '\nI am free to be what God wants me to be.”',
            softWrap: true,
            textAlign: TextAlign.center,
            maxLines: 4,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class ImageSection extends StatelessWidget {
  const ImageSection({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Image.asset(image, width: 600, height: 240, fit: BoxFit.cover);
  }
}

class DayPage extends StatelessWidget {
  const DayPage({super.key});

  @override
  Widget build(BuildContext context) {
    const String appTitle = 'Food For My Spirit';
    return new Container(
      child: new Column(
        children: <Widget>[
          ImageSection(
            image: 'lib/assets/ffms/day1.png',
          ),
          new Container(
            child: new Image.asset(
              "lib/assets/img/theme_bg.png",
              fit: BoxFit.cover,
            ),
          ),
          new Container(
            child:  new GridView.count(
              crossAxisCount: 4,
              children: new List<Widget>.generate(16, (index) {
                return new GridTile(
                  child: new Card(
                      color: Colors.blue.shade200,
                      child: new Center(
                        child: new Text('tile $index'),
                      )
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );

  }
}