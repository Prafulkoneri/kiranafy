import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

class InAppWebScreenView extends StatefulWidget {
  const InAppWebScreenView({super.key});

  @override
  State<InAppWebScreenView> createState() => _InAppWebScreenViewState();
}

class _InAppWebScreenViewState extends State<InAppWebScreenView> {
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
        initialUrlRequest: URLRequest(url: Uri.parse("https://localsupermart.com/testing/storage/subscription_pdf_invoice/LSMSUBS000054-2023-08-0810:50:38.pdf")),

        // new from stackoverflow
        onDownloadStartRequest: (controller, url,) async {
          final id = await FlutterDownloader.enqueue(
            url: "https://localsupermart.com/testing/storage/subscription_pdf_invoice/LSMSUBS000054-2023-08-0810:50:38.pdf",
            savedDir: "/storage/emulated/0/Download",
            showNotification: true,
            openFileFromNotification: true,
            fileName: "file.pdf",
          );
        },
      ),
    );
  }
}
