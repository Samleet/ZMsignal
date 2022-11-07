import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

 class WebViewScreen extends StatefulWidget {
  final String url;
  final String title;
  final bool appbar;
  final Map? cookies;

  const WebViewScreen({
    required this.url,
    required this.title,
    this.appbar = true,
    this.cookies
  });
  
   @override
   WebViewScreenState createState() => WebViewScreenState();
 }

 class WebViewScreenState extends State<WebViewScreen> {
  late WebViewController _controller;
  final cookieManager = WKWebViewCookieManager();
  bool isLoading = true;
  
  @override
  void initState() {    
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  Future<bool> goBack(BuildContext context) async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
      return Future.value(false);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Do you really want to exit the app?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              child: Text('Yes'),
            ),
          ],
        )
      );

      return Future.value(true); // Exit app here and redirect
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => goBack(context),
      child: Scaffold(
        appBar: widget.appbar ? AppBar(title: Text(widget.title)) : null,
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              WebView(
                initialUrl: Uri.encodeFull(widget.url),
                onPageFinished: (finish) {
                  setState(() {
                    isLoading = false;
                  });
                },
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController getController) async {   
                  _controller = getController;

                  var cookies = _controller.runJavascriptReturningResult (
                    'document.cookie',
                  );
                  
                },                
              ),
              isLoading ? Center(
                child: CircularProgressIndicator()
              ) 
              : Stack(),
            ]
          ),
        ),
      ),
    );
  }
 }