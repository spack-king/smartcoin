// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class Ads extends StatefulWidget {
//   const Ads({super.key});
//
//   @override
//   State<Ads> createState() => _AdsState();
// }
//
// class _AdsState extends State<Ads> {
//   dynamic controller, controller2, controller3, controller4, controller5, controller6, controller7, controller8
//   , controller9, controller10, controller11;
//   bool isLoading = true, failedToLoad = false;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     loadWebSite();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: RefreshIndicator(
//           onRefresh: () async {
//             loadWebSite();
//           },
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 isLoading ? CircularProgressIndicator(color: Colors.orange,)
//                     : Container(
//                     height: 70,
//                     child: WebViewWidget(controller: controller)),
//
//                 isLoading ? CircularProgressIndicator(color: Colors.orange,)
//                     : Container(
//                     height: 70,
//                     child: WebViewWidget(controller: controller2)),
//
//                 isLoading ? CircularProgressIndicator(color: Colors.orange,)
//                     : Container(
//                     height: 70,
//                     child: WebViewWidget(controller: controller3)),
//
//                 isLoading ? CircularProgressIndicator(color: Colors.orange,)
//                     : Container(
//                     height: 70,
//                     child: WebViewWidget(controller: controller4)),
//
//                 isLoading ? CircularProgressIndicator(color: Colors.orange,)
//                     : Container(
//                     height: 70,
//                     child: WebViewWidget(controller: controller5)),
//
//                 isLoading ? CircularProgressIndicator(color: Colors.orange,)
//                     : Container(
//                     height: 70,
//                     child: WebViewWidget(controller: controller6)),
//
//                 isLoading ? CircularProgressIndicator(color: Colors.orange,)
//                     : Container(
//                     height: 70,
//                     child: WebViewWidget(controller: controller7)),
//
//                 isLoading ? CircularProgressIndicator(color: Colors.orange,)
//                     : Container(
//                     height: 70,
//                     child: WebViewWidget(controller: controller8)),
//
//                 isLoading ? CircularProgressIndicator(color: Colors.orange,)
//                     : Container(
//                     height: 70,
//                     child: WebViewWidget(controller: controller9)),
//
//                 isLoading ? CircularProgressIndicator(color: Colors.orange,)
//                     : Container(
//                     height: 70,
//                     child: WebViewWidget(controller: controller10)),
//
//                 isLoading ? CircularProgressIndicator(color: Colors.orange,)
//                     : Container(
//                     height: 70,
//                     child: WebViewWidget(controller: controller11)),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   void loadWebSite() {
//
//     controller = WebViewController()
//
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(Colors.transparent)
//       ..enableZoom(true)
//       ..setUserAgent('Mozilla/5.0 (iPad; CPU OS 16_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/114.0.5735.124 Mobile/15E148 Safari/604.1')
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             // Update loading bar.
//             setState(() {
//               isLoading != failedToLoad;
//             });
//           },
//           onPageStarted: (String url) {
//             setState(() {
//               failedToLoad = false;
//               isLoading = true;
//             });
//           },
//           onPageFinished: (String url) {
//             setState(() {
//               isLoading = false;
//             });
//           },
//           onWebResourceError: (WebResourceError error) {
//             print(error.description);
//             setState(() {
//               failedToLoad = true;
//               isLoading = false;
//             });
//           },
//           onNavigationRequest: (NavigationRequest request) {
//             if (request.url.startsWith('hjdgjntube.com/')) {
//               return NavigationDecision.prevent;
//             }
//             return NavigationDecision.navigate;
//             //to go to browser
//             //launchUrl('request.url');
//             //return NavigationDecision.prevent;
//           },
//         ),
//       )
//       //..loadRequest(Uri.parse('https://explorer-ef6bc.web.app/'));
//     ..loadRequest(Uri.parse('https://curlsbatter.com/fzgm6d3w?key=b7d97f1b334c50c1407bdbffa8810d44'));
//
//     controller2 = WebViewController()
//
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(Colors.transparent)
//       ..enableZoom(true)
//       ..setUserAgent('Mozilla/5.0 (iPad; CPU OS 16_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/114.0.5735.124 Mobile/15E148 Safari/604.1')
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             // Update loading bar.
//             setState(() {
//               isLoading != failedToLoad;
//             });
//           },
//           onPageStarted: (String url) {
//             setState(() {
//               failedToLoad = false;
//               isLoading = true;
//             });
//           },
//           onPageFinished: (String url) {
//             setState(() {
//               isLoading = false;
//             });
//           },
//           onWebResourceError: (WebResourceError error) {
//             print(error.description);
//             setState(() {
//               failedToLoad = true;
//               isLoading = false;
//             });
//           },
//           onNavigationRequest: (NavigationRequest request) {
//             if (request.url.startsWith('hjdgjntube.com/')) {
//               return NavigationDecision.prevent;
//             }
//             return NavigationDecision.navigate;
//             //to go to browser
//             //launchUrl('request.url');
//             //return NavigationDecision.prevent;
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse('https://curlsbatter.com/stvdecvm?key=a0d9c0d7000d9cb0fc77e2e14849c088'));
//
//     controller3 = WebViewController()
//
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(Colors.transparent)
//       ..enableZoom(true)
//       ..setUserAgent('Mozilla/5.0 (iPad; CPU OS 16_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/114.0.5735.124 Mobile/15E148 Safari/604.1')
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             // Update loading bar.
//             setState(() {
//               isLoading != failedToLoad;
//             });
//           },
//           onPageStarted: (String url) {
//             setState(() {
//               failedToLoad = false;
//               isLoading = true;
//             });
//           },
//           onPageFinished: (String url) {
//             setState(() {
//               isLoading = false;
//             });
//           },
//           onWebResourceError: (WebResourceError error) {
//             print(error.description);
//             setState(() {
//               failedToLoad = true;
//               isLoading = false;
//             });
//           },
//           onNavigationRequest: (NavigationRequest request) {
//             if (request.url.startsWith('hjdgjntube.com/')) {
//               return NavigationDecision.prevent;
//             }
//             return NavigationDecision.navigate;
//             //to go to browser
//             //launchUrl('request.url');
//             //return NavigationDecision.prevent;
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse('https://curlsbatter.com/td1cstntx?key=a13fc5348621f90c4c1ccc4a01aacf4b'));
//
//     controller4 = WebViewController()
//
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(Colors.transparent)
//       ..enableZoom(true)
//       ..setUserAgent('Mozilla/5.0 (iPad; CPU OS 16_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/114.0.5735.124 Mobile/15E148 Safari/604.1')
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             // Update loading bar.
//             setState(() {
//               isLoading != failedToLoad;
//             });
//           },
//           onPageStarted: (String url) {
//             setState(() {
//               failedToLoad = false;
//               isLoading = true;
//             });
//           },
//           onPageFinished: (String url) {
//             setState(() {
//               isLoading = false;
//             });
//           },
//           onWebResourceError: (WebResourceError error) {
//             print(error.description);
//             setState(() {
//               failedToLoad = true;
//               isLoading = false;
//             });
//           },
//           onNavigationRequest: (NavigationRequest request) {
//             if (request.url.startsWith('hjdgjntube.com/')) {
//               return NavigationDecision.prevent;
//             }
//             return NavigationDecision.navigate;
//             //to go to browser
//             //launchUrl('request.url');
//             //return NavigationDecision.prevent;
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse('https://curlsbatter.com/iy8x5nfbp?key=d283cd8811432519ad136abcdfcd9579'));
//
//     controller5 = WebViewController()
//
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(Colors.transparent)
//       ..enableZoom(true)
//       ..setUserAgent('Mozilla/5.0 (iPad; CPU OS 16_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/114.0.5735.124 Mobile/15E148 Safari/604.1')
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             // Update loading bar.
//             setState(() {
//               isLoading != failedToLoad;
//             });
//           },
//           onPageStarted: (String url) {
//             setState(() {
//               failedToLoad = false;
//               isLoading = true;
//             });
//           },
//           onPageFinished: (String url) {
//             setState(() {
//               isLoading = false;
//             });
//           },
//           onWebResourceError: (WebResourceError error) {
//             print(error.description);
//             setState(() {
//               failedToLoad = true;
//               isLoading = false;
//             });
//           },
//           onNavigationRequest: (NavigationRequest request) {
//             if (request.url.startsWith('hjdgjntube.com/')) {
//               return NavigationDecision.prevent;
//             }
//             return NavigationDecision.navigate;
//             //to go to browser
//             //launchUrl('request.url');
//             //return NavigationDecision.prevent;
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse('https://curlsbatter.com/nxmjpj0q44?key=67cd4b0c00ab2c1f917bf1d4827079f0'));
//
//     controller6 = WebViewController()
//
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(Colors.transparent)
//       ..enableZoom(true)
//       ..setUserAgent('Mozilla/5.0 (iPad; CPU OS 16_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/114.0.5735.124 Mobile/15E148 Safari/604.1')
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             // Update loading bar.
//             setState(() {
//               isLoading != failedToLoad;
//             });
//           },
//           onPageStarted: (String url) {
//             setState(() {
//               failedToLoad = false;
//               isLoading = true;
//             });
//           },
//           onPageFinished: (String url) {
//             setState(() {
//               isLoading = false;
//             });
//           },
//           onWebResourceError: (WebResourceError error) {
//             print(error.description);
//             setState(() {
//               failedToLoad = true;
//               isLoading = false;
//             });
//           },
//           onNavigationRequest: (NavigationRequest request) {
//             if (request.url.startsWith('hjdgjntube.com/')) {
//               return NavigationDecision.prevent;
//             }
//             return NavigationDecision.navigate;
//             //to go to browser
//             //launchUrl('request.url');
//             //return NavigationDecision.prevent;
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse('https://curlsbatter.com/bwemwntu5?key=26df4974ebf1498375c23e9895dc123e'));
//
//     controller7 = WebViewController()
//
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(Colors.transparent)
//       ..enableZoom(true)
//       ..setUserAgent('Mozilla/5.0 (iPad; CPU OS 16_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/114.0.5735.124 Mobile/15E148 Safari/604.1')
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             // Update loading bar.
//             setState(() {
//               isLoading != failedToLoad;
//             });
//           },
//           onPageStarted: (String url) {
//             setState(() {
//               failedToLoad = false;
//               isLoading = true;
//             });
//           },
//           onPageFinished: (String url) {
//             setState(() {
//               isLoading = false;
//             });
//           },
//           onWebResourceError: (WebResourceError error) {
//             print(error.description);
//             setState(() {
//               failedToLoad = true;
//               isLoading = false;
//             });
//           },
//           onNavigationRequest: (NavigationRequest request) {
//             if (request.url.startsWith('hjdgjntube.com/')) {
//               return NavigationDecision.prevent;
//             }
//             return NavigationDecision.navigate;
//             //to go to browser
//             //launchUrl('request.url');
//             //return NavigationDecision.prevent;
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse('https://explorer-ef6bc.web.app/'));
//
//     controller8 = WebViewController()
//
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(Colors.transparent)
//       ..enableZoom(true)
//       ..setUserAgent('Mozilla/5.0 (iPad; CPU OS 16_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/114.0.5735.124 Mobile/15E148 Safari/604.1')
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             // Update loading bar.
//             setState(() {
//               isLoading != failedToLoad;
//             });
//           },
//           onPageStarted: (String url) {
//             setState(() {
//               failedToLoad = false;
//               isLoading = true;
//             });
//           },
//           onPageFinished: (String url) {
//             setState(() {
//               isLoading = false;
//             });
//           },
//           onWebResourceError: (WebResourceError error) {
//             print(error.description);
//             setState(() {
//               failedToLoad = true;
//               isLoading = false;
//             });
//           },
//           onNavigationRequest: (NavigationRequest request) {
//             if (request.url.startsWith('hjdgjntube.com/')) {
//               return NavigationDecision.prevent;
//             }
//             return NavigationDecision.navigate;
//             //to go to browser
//             //launchUrl('request.url');
//             //return NavigationDecision.prevent;
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse('https://curlsbatter.com/rrv15ez5jq?key=849bdbdd378ed1374676058440b2f318'));
//
//     controller9 = WebViewController()
//
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(Colors.transparent)
//       ..enableZoom(true)
//       ..setUserAgent('Mozilla/5.0 (iPad; CPU OS 16_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/114.0.5735.124 Mobile/15E148 Safari/604.1')
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             // Update loading bar.
//             setState(() {
//               isLoading != failedToLoad;
//             });
//           },
//           onPageStarted: (String url) {
//             setState(() {
//               failedToLoad = false;
//               isLoading = true;
//             });
//           },
//           onPageFinished: (String url) {
//             setState(() {
//               isLoading = false;
//             });
//           },
//           onWebResourceError: (WebResourceError error) {
//             print(error.description);
//             setState(() {
//               failedToLoad = true;
//               isLoading = false;
//             });
//           },
//           onNavigationRequest: (NavigationRequest request) {
//             if (request.url.startsWith('hjdgjntube.com/')) {
//               return NavigationDecision.prevent;
//             }
//             return NavigationDecision.navigate;
//             //to go to browser
//             //launchUrl('request.url');
//             //return NavigationDecision.prevent;
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse('https://curlsbatter.com/cnz4jprtq?key=60056699db2f8179b0c8f138ed59fe43'));
//
//     controller10 = WebViewController()
//
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(Colors.transparent)
//       ..enableZoom(true)
//       ..setUserAgent('Mozilla/5.0 (iPad; CPU OS 16_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/114.0.5735.124 Mobile/15E148 Safari/604.1')
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             // Update loading bar.
//             setState(() {
//               isLoading != failedToLoad;
//             });
//           },
//           onPageStarted: (String url) {
//             setState(() {
//               failedToLoad = false;
//               isLoading = true;
//             });
//           },
//           onPageFinished: (String url) {
//             setState(() {
//               isLoading = false;
//             });
//           },
//           onWebResourceError: (WebResourceError error) {
//             print(error.description);
//             setState(() {
//               failedToLoad = true;
//               isLoading = false;
//             });
//           },
//           onNavigationRequest: (NavigationRequest request) {
//             if (request.url.startsWith('hjdgjntube.com/')) {
//               return NavigationDecision.prevent;
//             }
//             return NavigationDecision.navigate;
//             //to go to browser
//             //launchUrl('request.url');
//             //return NavigationDecision.prevent;
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse('https://curlsbatter.com/pabw7u2az?key=bbe1ccdc052c4a3cb882ef0d232dfb49'));
//
//     controller11 = WebViewController()
//
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(Colors.transparent)
//       ..enableZoom(true)
//       ..setUserAgent('Mozilla/5.0 (iPad; CPU OS 16_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/114.0.5735.124 Mobile/15E148 Safari/604.1')
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             // Update loading bar.
//             setState(() {
//               isLoading != failedToLoad;
//             });
//           },
//           onPageStarted: (String url) {
//             setState(() {
//               failedToLoad = false;
//               isLoading = true;
//             });
//           },
//           onPageFinished: (String url) {
//             setState(() {
//               isLoading = false;
//             });
//           },
//           onWebResourceError: (WebResourceError error) {
//             print(error.description);
//             setState(() {
//               failedToLoad = true;
//               isLoading = false;
//             });
//           },
//           onNavigationRequest: (NavigationRequest request) {
//             if (request.url.startsWith('hjdgjntube.com/')) {
//               return NavigationDecision.prevent;
//             }
//             return NavigationDecision.navigate;
//             //to go to browser
//             //launchUrl('request.url');
//             //return NavigationDecision.prevent;
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse('https://curlsbatter.com/fzgm6d3w?key=b7d97f1b334c50c1407bdbffa8810d44'));
//   }
// }
