// import 'package:ask_ai/ui/common/env.dart';
// import 'package:ask_ai/ui/common/ui_helpers.dart';
// import 'package:ask_ai/ui/views/home/home_view.form.dart';
// import 'package:chat_bubbles/chat_bubbles.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:sitesurface_flutter_openai/sitesurface_flutter_openai.dart';
// import 'package:stacked/stacked.dart';
// import 'package:stacked/stacked_annotations.dart';
// import 'package:pie_menu/pie_menu.dart';
// import 'home_viewmodel.dart';

// @FormView(fields: [
//   FormTextField(name: 'question'),
// ])
// class HomeView extends StackedView<HomeViewModel> with $HomeView {
//   HomeView({Key? key}) : super(key: key);

//   // final _openAIClient = OpenAIClient(
//   //     OpenAIConfig(apiKey: apiKey, organizationId: organizationId));
//   final _scrollController = ScrollController();

//   final _completionRequest = CreateCompletionRequest(
//     model: "text-davinci-003",
//     maxTokens: 2048,
//   );

//   @override
//   Widget builder(
//     BuildContext context,
//     HomeViewModel viewModel,
//     Widget? child,
//   ) {
//     return PieCanvas(
//       // onMenuToggle: (active) => viewModel.toggleMenu(active),
//       theme: PieTheme(
//           pointerColor: Colors.transparent,
//           overlayColor: Colors.blueAccent.withOpacity(0.2)),
//       child: Scaffold(
//           appBar: AppBar(
//             leading: Image.asset('assets/logos/logo.png'),
//             backgroundColor: Colors.white,
//             elevation: 0,
//           ),
//           body: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ChatGPTBuilder(
//                 completionRequest: _completionRequest,
//                 // openAIClient: _openAIClient,
//                 builder: (context, messages, onSend) {
//                   return Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Expanded(
//                         child: ListView.separated(
//                             physics: viewModel.menuActive
//                                 ? const NeverScrollableScrollPhysics()
//                                 : const BouncingScrollPhysics(),
//                             itemCount: messages.length,
//                             controller: _scrollController,
//                             separatorBuilder: (context, index) =>
//                                 const SizedBox(
//                                   height: 5,
//                                 ),
//                             itemBuilder: (context, index) {
//                               var isSender = !messages[index].fromChatGPT;
//                               return PieMenu(
//                                 onToggle: (active) {
//                                   print('active: $active');
//                                 },
//                                 actions: [
//                                   PieAction(
//                                       tooltip: 'Copy',
//                                       child: const Icon(Icons.copy),
//                                       onSelect: () {}),
//                                   PieAction(
//                                       tooltip: 'Delete',
//                                       child: const Icon(Icons.delete),
//                                       onSelect: () {}),
//                                 ],
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(bottom: 12.0),
//                                   child: BubbleSpecialThree(
//                                     isSender: isSender,
//                                     sent: isSender,
//                                     seen: isSender,
//                                     text: messages[index].message,
//                                     color: isSender
//                                         ? const Color.fromRGBO(
//                                             212, 234, 244, 1.0)
//                                         : Colors.grey.shade100,
//                                     tail: true,
//                                     textStyle: GoogleFonts.poppins(
//                                         color: Colors.grey[800], fontSize: 16),
//                                   ),
//                                 ),
//                               );
//                             }),
//                       ),
//                       viewModel.isBusy
//                           ? Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: const [
//                                 Text(
//                                   'Loading ...',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                                 horizontalSpaceSmall,
//                                 SizedBox(
//                                   width: 16,
//                                   height: 16,
//                                   child: CircularProgressIndicator(
//                                     color: Colors.black,
//                                     strokeWidth: 6,
//                                   ),
//                                 )
//                               ],
//                             )
//                           : const SizedBox(
//                               height: 10,
//                             ),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Padding(
//                               padding: const EdgeInsets.all(10.0),
//                               child: TextField(
//                                 controller: questionController,
//                                 decoration: InputDecoration(
//                                     hintText: "Enter a prompt",
//                                     border: OutlineInputBorder(
//                                         borderSide: BorderSide(
//                                             color: Colors.grey.shade100,
//                                             width: 1),
//                                         borderRadius:
//                                             BorderRadius.circular(10))),
//                               ),
//                             ),
//                           ),
//                           IconButton(
//                               onPressed: () async {
//                                 if (questionController.text.trim().isEmpty) {
//                                   return;
//                                 }
//                                 viewModel.loading();
//                                 // var result =
//                                 //     await onSend(questionController.text)
//                                 //         .whenComplete(() => print('done'));

//                                 // _scrollController.jumpTo(
//                                 //     _scrollController.position.maxScrollExtent);
//                                 viewModel.loaded();
//                                 // print('value: $result');

//                                 FocusScope.of(context).unfocus();
//                                 questionController.clear();
//                               },
//                               icon: const Icon(
//                                 Icons.send,
//                                 color: Colors.blue,
//                               )),
//                           const SizedBox(
//                             width: 10,
//                           ),
//                         ],
//                       ),
//                     ],
//                   );
//                 }),
//           )),
//     );
//   }

//   @override
//   HomeViewModel viewModelBuilder(
//     BuildContext context,
//   ) =>
//       HomeViewModel();
//   @override
//   void onViewModelReady(HomeViewModel viewModel) {
//     syncFormWithViewModel(viewModel);
//   }

//   @override
//   void onDispose(HomeViewModel viewModel) {
//     super.onDispose(viewModel);
//     disposeForm();
//   }
// }
