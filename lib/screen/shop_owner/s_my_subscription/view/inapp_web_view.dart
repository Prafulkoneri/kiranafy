import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class InAppWebView extends StatefulWidget {
  const InAppWebView({super.key});

  @override
  State<InAppWebView> createState() => _InAppWebViewState();
}

class _InAppWebViewState extends State<InAppWebView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Testing the downloading'),
      ),
      body: InAppWebView(
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(useOnDownloadStart: true),
        ),
        initialUrlRequest: URLRequest(url: Your_URL_HERE),

        // new from stackoverflow
        onDownloadStartRequest: downloadStartMethodUsingFlutterDownloader,
      ),
    );
  }
}
