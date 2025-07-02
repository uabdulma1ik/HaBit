import 'dart:io';

import 'package:equatable/equatable.dart';

class OcrState extends Equatable {
  final File? selectedImage;
  final String extractedText;
  final bool isProcessing;
  final String? errorMessage;
  final bool textCopied;

  const OcrState({
    this.selectedImage,
    this.extractedText = '',
    this.isProcessing = false,
    this.errorMessage,
    this.textCopied = false,
  });

  @override
  List<Object?> get props => [
    selectedImage,
    extractedText,
    isProcessing,
    errorMessage,
    textCopied,
  ];
}
