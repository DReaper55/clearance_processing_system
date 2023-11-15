// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:clearance_processing_system/general_widgets/shrink_button.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class PaymentPage extends StatefulWidget {
//   final String url;
//
//   const PaymentPage({
//     Key? key,
//     required this.url,
//   }) : super(key: key);
//
//   @override
//   State<PaymentPage> createState() => _PaymentPageState();
// }
//
// class _PaymentPageState extends State<PaymentPage> {
//   late WebViewController _controller;
//
//   @override
//   void initState() {
//     _checkNetworkStatus();
//     super.initState();
//
//     _instantiateWebViewController();
//   }
//
//   @override
//   void dispose() {
//     // connectionSubscription.cancel();
//
//     super.dispose();
//   }
//
//   _instantiateWebViewController() {
//     _controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(const Color(0x00000000))
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             // Update loading bar.
//           },
//           onPageStarted: (String url) {},
//           onPageFinished: (String url) {},
//           onWebResourceError: (WebResourceError error) {},
//           onNavigationRequest: (NavigationRequest request) {
//             // if (request.url.startsWith('')) {
//             //   return NavigationDecision.prevent;
//             // }
//             return NavigationDecision.navigate;
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse(widget.url));
//   }
//
//   bool hasNetwork = false;
//   // late StreamSubscription<ConnectivityResult> connectionSubscription;
//
//   //......................................................
//   //  End payment process the moment network becomes unstable,
//   // leave the rest to PayStack
//   //......................................................
//   _checkNetworkStatus() async {
//     // hasNetwork = await NetWorkCheck().hasNetwork();
//
//     /*connectionSubscription = Connectivity()
//         .onConnectivityChanged
//         .listen((ConnectivityResult result) {
//       if (result.name == ConnectivityResult.none.name) {
//         materialPushReplaceToPage(
//             context, OrderDetailsPage(
//           isFromMap: widget.isFromMap,
//           isFromCart: true,
//           listOfOrders: widget.listOfOrders,
//           order: widget.order,
//           reference: widget.access,
//         ));
//       }
//     });*/
//   }
//
//   //......................................................
//   //  Use a webView to render the html contents of the
//   // checkout page on the mobile app and return the
//   // reference code after successful/failed payment when
//   // the check button on appBar is clicked
//   //......................................................
//   @override
//   Widget build(BuildContext context) {
//     if (Platform.isAndroid) {
//       // WebViewWidget.platform = SurfaceAndroidWebView();
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Payment Page",
//           style: TextStyle(color: Colors.black),
//         ),
//         leading: IconButton(
//           onPressed: () => Navigator.of(context).pop(false),
//           icon: const Icon(Icons.close),
//         ),
//         actions: [
//           ShrinkButton(
//             hasGradientBackground: true,
//             onTap: () => Navigator.of(context).pop(true),
//             text: 'Done',
//             textColor: Colors.white,
//           ),
//         ],
//       ),
//       body: SizedBox(
//         child: WebViewWidget(controller: _controller),
//       ),
//     );
//   }
// }
