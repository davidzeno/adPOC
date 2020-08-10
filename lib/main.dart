import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'globals.dart';

void main() {
  runApp(MyApp());
}

/// This is the title of your application
/// https://miami.craigslist.org/pbc/cpg/d/orlando-looking-for-confident-app/7172022200.html
String title = 'Proof of Concept';

/// This widget is the root of your application.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '$title',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: '$title'),
    );
  }
}

/// This is the stateful of your application
class MyHomePage extends StatefulWidget {
  /// Constructors
  MyHomePage({Key key, this.title}) : super(key: key);

  /// This is the title of your application
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WebViewController _controller;

  Future<bool> _exitApp(BuildContext context) async {
    bool goBack;
    if (await _controller.canGoBack()) {
      print("onwill goback");
      _controller.goBack();
      return Future.value(false);
    } else {
      print("onwill exit");
      await showDialog<int>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Confirmation ',
              style: TextStyle(color: Colors.purple)),
          content: Text('Do you want exit adPOC app?'),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                goBack = false;
                Navigator.of(context).pop();
              },
              child: Text("No"), // No
            ),
            FlatButton(
              onPressed: () {
                goBack = true;
                Navigator.of(context).pop();
              },
              child: Text("Yes"), // Yes
            ),
          ],
        ),
      );
      return Future.value(goBack);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => _exitApp(context),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.purple,
            title: Text(widget.title),
          ),
          body: WebView(
            initialUrl: '$initialUrl',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (webViewController) {
              _controller = webViewController;
            },
          ),
        ));
  }
}
