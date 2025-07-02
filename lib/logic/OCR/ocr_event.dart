import 'package:equatable/equatable.dart';



sealed class OcrEvent extends Equatable {
  const OcrEvent();

  @override
  List<Object> get props => [];
}

class PickImageFromGallery extends OcrEvent {}

class PickImageFromCamera extends OcrEvent {}

class ExtractTextFromImage extends OcrEvent {}

class ClearAllData extends OcrEvent {}

class CopyTextToClipboard extends OcrEvent {}
