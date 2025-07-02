import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit/logic/OCR/ocr_bloc.dart';
import 'package:habit/logic/OCR/ocr_event.dart';
import 'package:habit/logic/OCR/ocr_state.dart';
import 'package:habit/screens/OCR/widgets/ImgSourceDialog.dart';
import 'package:habit/screens/widgets/customSnackbar.dart/customSnackbar.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class OcrScreen extends StatelessWidget {
  const OcrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: BlocListener<OcrBloc, OcrState>(
        listenWhen: (previous, current) =>
            current.textCopied && !previous.textCopied,
        listener: (context, state) {
          CustomSnackbar(context: context, message: 'Text copied').show();
        },
        child: Scaffold(
          floatingActionButton: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.3),
                  offset: const Offset(-4, 4),
                  blurRadius: 8,
                ),
              ],
            ),
            child: FloatingActionButton(
              onPressed: () {
                _showImgDialog(context);
              },
              backgroundColor: const Color(0xFFFFB347),
              elevation: 0,
              shape: const CircleBorder(),
              child: const Icon(Icons.add, color: Colors.white, size: 45),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('Image to Text'),
            backgroundColor: Colors.white,
            elevation: 0,
            actions: [
              BlocBuilder<OcrBloc, OcrState>(
                builder: (context, state) {
                  if (state.selectedImage != null) {
                    return IconButton(
                      onPressed: () {
                        context.read<OcrBloc>().add(CopyTextToClipboard());
                      },
                      icon:
                          const Icon(Icons.copy, color: Colors.black, size: 24),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  BlocBuilder<OcrBloc, OcrState>(
                    builder: (context, state) {
                      return Container(
                        height: 270,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        child: state.selectedImage == null
                            ? const Padding(
                                padding: EdgeInsets.all(32),
                                child: Text(
                                  'Upload an image using the "+" button',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: InteractiveViewer(
                                  panEnabled: true,
                                  scaleEnabled: true,
                                  child: SizedBox.expand(
                                    child: Image.file(
                                      state.selectedImage!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  BlocBuilder<OcrBloc, OcrState>(
                    builder: (context, state) {
                      return Container(
                        constraints: const BoxConstraints(
                          minHeight: 250,
                          maxHeight: 270,
                        ),
                        width: double.infinity,
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        child: state.isProcessing
                            ? Shimmer(
                                duration: const Duration(seconds: 2),
                                color: Colors.grey.shade300,
                                enabled: true,
                                direction: const ShimmerDirection.fromLTRB(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 150,
                                      height: 20,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(height: 16),
                                    Container(
                                      width: double.infinity,
                                      height: 100,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              )
                            : state.extractedText.isNotEmpty
                                ? SelectableText(
                                    state.extractedText,
                                    style: const TextStyle(fontSize: 16),
                                    textAlign: TextAlign.left,
                                  )
                                : const Text(
                                    'Click the "Scan Image" button to perform scan',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context.read<OcrBloc>().add(ClearAllData());
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              const WidgetStatePropertyAll(Colors.white),
                          elevation: const WidgetStatePropertyAll(0),
                          padding: const WidgetStatePropertyAll(
                            EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          ),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: const BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Clear image',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(width: 32),
                      ElevatedButton(
                        onPressed: () {
                          context
                              .read<OcrBloc>()
                              .add(ExtractTextFromImage());
                        },
                        style: ButtonStyle(
                          backgroundColor: const WidgetStatePropertyAll(
                            Color(0xffFFB347),
                          ),
                          elevation: const WidgetStatePropertyAll(4),
                          padding: const WidgetStatePropertyAll(
                            EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          ),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Scan image',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showImgDialog(BuildContext context) async {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Color.fromARGB(255, 116, 116, 116),
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          contentPadding: EdgeInsets.zero,
          content: ImgSourceDialog(
            onTapCamera: () {
              Navigator.of(context).pop();
              context.read<OcrBloc>().add(PickImageFromCamera());
            },
            onTapGallery: () {
              Navigator.of(context).pop();
              context.read<OcrBloc>().add(PickImageFromGallery());
            },
          ),
        );
      },
    );

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }
}
