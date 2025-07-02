import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:habit/logic/OCR/ocr_event.dart';
import 'package:habit/logic/OCR/ocr_state.dart';
import 'package:image_picker/image_picker.dart';

class OcrBloc extends Bloc<OcrEvent, OcrState> {
  final ImagePicker _picker = ImagePicker();
  final TextRecognizer _textRecognizer = TextRecognizer();

  OcrBloc() : super(const OcrState()) {
    on<PickImageFromGallery>(_onPickImageFromGallery);
    on<PickImageFromCamera>(_onPickImageFromCamera);
    on<ExtractTextFromImage>(_onExtractTextFromImage);
    on<ClearAllData>(_onClearAllData);
    on<CopyTextToClipboard>(_onCopyTextToClipboard);
  }

  Future<void> _onPickImageFromGallery(
    PickImageFromGallery event,
    Emitter<OcrState> emit,
  ) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      emit(
        OcrState(
          selectedImage: File(image.path),
          extractedText: '',
          isProcessing: false,
          errorMessage: null,
          textCopied: false,
        ),
      );
    }
  }

  Future<void> _onPickImageFromCamera(
    PickImageFromCamera event,
    Emitter<OcrState> emit,
  ) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      emit(
        OcrState(
          selectedImage: File(image.path),
          extractedText: '',
          isProcessing: false,
          errorMessage: null,
          textCopied: false,
        ),
      );
    }
  }

  Future<void> _onExtractTextFromImage(
    ExtractTextFromImage event,
    Emitter<OcrState> emit,
  ) async {
    if (state.selectedImage == null) return;

    emit(
      OcrState(
        selectedImage: state.selectedImage,
        extractedText: state.extractedText,
        isProcessing: true,
        errorMessage: null,
        textCopied: false,
      ),
    );

    try {
      final InputImage inputImage = InputImage.fromFile(state.selectedImage!);
      final RecognizedText recognizedText = await _textRecognizer.processImage(
        inputImage,
      );

      emit(
        OcrState(
          selectedImage: state.selectedImage,
          extractedText: recognizedText.text,
          isProcessing: false,
          errorMessage: null,
          textCopied: false,
        ),
      );
    } catch (e) {
      emit(
        OcrState(
          selectedImage: state.selectedImage,
          extractedText: 'Error occurred: $e',
          isProcessing: false,
          errorMessage: 'Error occurred: $e',
          textCopied: false,
        ),
      );
    }
  }

  void _onClearAllData(ClearAllData event, Emitter<OcrState> emit) {
    emit(const OcrState());
  }

  Future<void> _onCopyTextToClipboard(
    CopyTextToClipboard event,
    Emitter<OcrState> emit,
  ) async {
    if (state.extractedText.isNotEmpty) {
      await Clipboard.setData(ClipboardData(text: state.extractedText));

      // First emit with textCopied = true
      emit(
        OcrState(
          selectedImage: state.selectedImage,
          extractedText: state.extractedText,
          isProcessing: false,
          errorMessage: null,
          textCopied: true,
        ),
      );

      // After 2 seconds, emit again with textCopied = false
      await Future.delayed(const Duration(seconds: 2));
      emit(
        OcrState(
          selectedImage: state.selectedImage,
          extractedText: state.extractedText,
          isProcessing: false,
          errorMessage: null,
          textCopied: false,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _textRecognizer.close();
    return super.close();
  }
}
