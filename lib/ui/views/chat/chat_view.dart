import 'package:ask_ai/ui/common/ui_helpers.dart';

import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:pie_menu/pie_menu.dart';

import 'chat_view.form.dart';
import 'chat_viewmodel.dart';

enum AudioEncoder {
  /// Will output to MPEG_4 format container
  AAC,

  /// Will output to MPEG_4 format container
  AAC_LD,

  /// Will output to MPEG_4 format container
  AAC_HE,

  /// sampling rate should be set to 8kHz
  /// Will output to 3GP format container on Android
  AMR_NB,

  /// sampling rate should be set to 16kHz
  /// Will output to 3GP format container on Android
  AMR_WB,

  /// Will output to MPEG_4 format container
  /// /!\ SDK 29 on Android /!\
  /// /!\ SDK 11 on iOs /!\
  OPUS,
}

@FormView(fields: [
  FormTextField(name: 'question'),
])
class ChatView extends StackedView<ChatViewModel> with $ChatView {
  ChatView({Key? key}) : super(key: key);

  final ScrollController controller = ScrollController();

  @override
  Widget builder(
    BuildContext context,
    ChatViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: PieCanvas(
        theme: PieTheme(
          overlayColor: viewModel.menuActive
              ? Colors.white.withOpacity(0.5)
              : Colors.black54,
          buttonSize: 56,
          pointerColor: Colors.transparent,
        ),
        child: Column(children: [
          Expanded(
              child: CustomScrollView(
                  physics: viewModel.menuActive
                      ? const NeverScrollableScrollPhysics()
                      : const BouncingScrollPhysics(),
                  controller: controller,
                  slivers: [
                SliverAppBar(
                  leading: Image.asset('assets/logos/logo.png'),
                  elevation: 0.0,
                  floating: true,
                  snap: false,
                  pinned: false,
                  expandedHeight: 0,
                  toolbarHeight: 40,
                  backgroundColor: Colors.white,
                ),
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final message = viewModel.messages[index];
                    return PieMenu(
                      onToggle: (active) => viewModel.toggleMenu(active),
                      actions: [
                        PieAction(
                            tooltip: 'Download',
                            child: const Icon(Icons.download),
                            onSelect: () async {
                              if (!message.isImage) return;
                              await viewModel.downloadImage(message.message);
                            }),
                        PieAction(
                          tooltip: 'Copy',
                          child: const Icon(Icons.copy),
                          onSelect: () async {
                            await viewModel.copyText(message.message);
                          },
                        ),
                        PieAction(
                            tooltip: 'Delete',
                            child: const Icon(Icons.delete),
                            onSelect: () async {
                              await viewModel.deleteMessage(index);
                            }),
                      ],
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 10.0),
                        child: message.isImage
                            ? BubbleNormalImage(
                                onTap: () {},
                                id: viewModel.generateRandomFileName(10),
                                image: Image.network(
                                  message.message,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.error);
                                  },
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                ),
                                isSender: !message.fromChatGPT,
                                sent: !message.fromChatGPT,
                                seen: !message.fromChatGPT,
                                tail: true,
                              )
                            : BubbleSpecialThree(
                                text: message.message,
                                isSender: !message.fromChatGPT,
                                sent: !message.fromChatGPT,
                                seen: !message.fromChatGPT,
                                tail: true,
                                color: !message.fromChatGPT
                                    ? const Color.fromRGBO(212, 234, 244, 1.0)
                                    : Colors.grey.shade100,
                                textStyle: GoogleFonts.poppins(
                                    color: Colors.grey[800], fontSize: 16),
                              ),
                      ),
                    );
                  },
                  childCount: viewModel.messages.length,
                ))
              ])),
          viewModel.isBusy
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'Loading ...',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    horizontalSpaceSmall,
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        color: Colors.black,
                        strokeWidth: 6,
                      ),
                    )
                  ],
                )
              : const SizedBox(
                  height: 10,
                ),
          Row(
            children: [
              Expanded(
                child: MessageBar(
                  actions: [
                    IconButton(
                      icon: viewModel.isImageGeneration
                          ? const Icon(
                              Icons.short_text,
                            )
                          : const Icon(Icons.image),
                      tooltip: viewModel.isImageGeneration
                          ? 'Change to Text Generation'
                          : 'Change to Image Generation',
                      onPressed: viewModel.toggleMode,
                    ),
                  ],
                  onSend: (value) {
                    questionController.text = value;
                    FocusScope.of(context).unfocus();
                    viewModel
                        .addMessage(questionController.text.trim())
                        .then((value) {
                      questionController.clear();
                      controller.animateTo(
                        controller.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    });
                  },
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }

  @override
  ChatViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ChatViewModel();

  @override
  void onViewModelReady(ChatViewModel viewModel) => SchedulerBinding.instance
      .addPostFrameCallback((timeStamp) => viewModel.runStartupLogic());
}
