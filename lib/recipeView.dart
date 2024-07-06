import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class RecipePage extends StatefulWidget {
 final String url;
  RecipePage(this.url);
  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  late final Controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)..loadRequest(Uri.parse(widget.url));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text("Coo",style: TextStyle(color: Colors.orange),),
            Text("!<",style: TextStyle(color: Colors.blue),),
            Text("ing",style: TextStyle(color: Colors.black),),
          ],
        ),
      ),
      body: Container(
        child:WebViewWidget(controller: Controller),
      ),
    );
  }
}
