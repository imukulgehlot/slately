// import 'dart:io';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class WebViewScreen extends StatefulWidget {
//   final String webPageURL;
//
//   const WebViewScreen({Key? key, required this.webPageURL}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() => _WebViewState();
// }
//
// class _WebViewState extends State<WebViewScreen> {
//   RxBool isLoading = true.obs;
//
//   final controller = WebViewController();
//
//   @override
//   void initState() {
//     controller
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(Colors.white)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             const CupertinoActivityIndicator(
//               radius: 15,
//             );
//           },
//           onPageStarted: (String url) {
//             debugPrint('Page started loading: $url');
//           },
//           onPageFinished: (String url) {
//             debugPrint('Page finished loading: $url');
//             isLoading.value = false;
//           },
//           onWebResourceError: (WebResourceError error) {},
//           onNavigationRequest: (NavigationRequest request) {
//             return NavigationDecision.navigate;
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse(widget.webPageURL));
//
//     super.initState();
//   }
//
//   /*checkInternet() async {
//     final bool isConnected = await ConnectivityService.isConnected();
//     if (!isConnected) {
//       return (
//         barrierDismissible: false,
//         context: Get.context!,
//         builder: (_) => const NoInterNetScreen(),
//       );
//       // return;
//     }
//   }*/
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Stack(
//         children: [
//           WebViewWidget(
//             controller: controller,
//           ),
//           isLoading.value
//               ? Platform.isIOS
//                   ? const Center(
//                       child: CupertinoActivityIndicator(
//                       radius: 15,
//                     ))
//                   : const Center(child: CircularProgressIndicator())
//               : const SizedBox()
//         ],
//       ),
//     );
//   }
//
//   data(int a) {
//     return const CupertinoActivityIndicator(
//       radius: 15,
//     );
//   }
// }
