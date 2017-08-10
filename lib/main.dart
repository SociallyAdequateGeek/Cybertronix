import 'package:flutter/material.dart';
import 'pages/agenda.dart';
import 'pages/browser.dart';
import 'pages/category.dart';
import 'firebase.dart' as firebase;

// Upcoming features
// TODO: Make a pretty looking "Today" page
// TODO: Job names are redundant.
// New format: $date $action $location
// TODO: Add copy support to all Category cards on long-press

// Wishlist
// Future: I'd like CategoryCards to pop up from the bottom, maybe.
// Future: Generate CreatorCard boilerplate from a JSON or something.

/// Cybertronix is a job management software; a work in progress.
class CybertronixApp extends StatefulWidget {
  @override
  _CybertronixAppState createState() => new _CybertronixAppState();
}

class _CybertronixAppState extends State<CybertronixApp> {
  final List<String> _classes = <String>[
    'annuals',
    'contacts',
    'customers',
    'jobs',
    'locations',
    'monthlies',
    'packages'
  ];

  @override
  void initState() {
    super.initState();
    firebase.initDatabase();
  }

  Route<Null> _getRoute(RouteSettings settings) {
    final List<String> path = settings.name.split('/');
    if (path[0] != '') return null;
    if (path[1] == "browse") {
      return new MaterialPageRoute<Null>(
          settings: settings,
          builder: (BuildContext context) => new CategoryPage(path[2]));
    }
    if (_classes.contains(path[1])) {
      /*return new MaterialPageRoute<Null>(
        settings: settings,
        builder: (BuildContext context) => new DataPage(class: path[1], id: path[2])
      );*/
      return null;
    }
    return null;
  }

  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Cybertronix',
      theme: new ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.deepOrange,
      ),
      home: new AgendaPage(),
      routes: <String, WidgetBuilder>{
        '/agenda': (BuildContext context) => new AgendaPage(),
        '/browse': (BuildContext context) => new BrowserPage()
        /*  '/reports': (BuildContext context) => new ReportsPage(),
            '/search': (BuildContext context) => new SearchPage(), // Maybe have a search menu in the AppBar
        */
      },
      onGenerateRoute: _getRoute,
    );
  }
}

void main() {
  runApp(new CybertronixApp());
}
