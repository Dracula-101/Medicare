import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicare/core/spacings/app_spacing.dart';
import 'package:medicare/data/models/ocr/ocr_response_model.dart';
import 'package:medicare/features/home/patient/pages/ocr/model_view.dart';
import 'package:medicare/features/home/text_recognizer_painter.dart';
import 'package:medicare/services/log_service/log_service.dart';
import 'package:medicare/services/ocr_service/ocr_service.dart';
import 'package:medicare/theme/app_theme.dart';
import 'package:medicare/theme/colors.dart';
import 'package:medicare/widgets/back_button.dart';

import '../../../../../router/app_router.dart';

class OCRView extends StatefulWidget {
  const OCRView({super.key});

  @override
  State<OCRView> createState() => _OCRViewState();
}

class _OCRViewState extends State<OCRView> {
  ImagePicker? _imagePicker;
  XFile? _imageFile;
  Size? _imageSize;
  bool _canProcess = true;
  CustomPainter? _customPainter;
  TextRecognizer? textRecognizer;
  OCRDocument? ocrDocument;
  RecognizedText? recognizedText;
  String? _text;
  final LogService _logService = GetIt.I.get<LogService>();
  final OCRService _ocrService = GetIt.I.get<OCRService>();
  bool isLoading = false;
  List<String> medicines = [];
  List<RecognizedMedicine> foundMedicines = [];
  List<bool> selectedMedicines = [];

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
    textRecognizer = TextRecognizer();
    getMedicines();
  }

  @override
  void dispose() {
    _canProcess = false;
    textRecognizer?.close();
    super.dispose();
  }

  Future<void> getMedicines() async {
    String assetContent =
        await rootBundle.loadString('assets/raw/medicines.json');
    Map<String, dynamic> json = jsonDecode(assetContent);
    medicines = json['medicines'].cast<String>();
  }

  Future<void> _pickImage(ImageSource source,
      {Function()? onImageSelected}) async {
    if (!_canProcess) return;
    await _imagePicker?.pickImage(source: source).then((value) async {
      if (value == null) return;
      setState(() {
        _imageFile = value;
        foundMedicines = [];
        selectedMedicines = [];
      });
      onImageSelected?.call();
      Image file = Image.file(File(_imageFile!.path));
      double width =
          min(MediaQuery.of(context).size.width, file.width?.toDouble() ?? 0);
      double height =
          min(MediaQuery.of(context).size.height, file.height?.toDouble() ?? 0);
      _imageSize = Size(width, height);
      try {
        // getOCRResults();
        await _processImage(InputImage.fromFilePath(_imageFile!.path));
      } catch (e) {
        _logService.e('Error processing image', e, StackTrace.current);
      }
    });
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    setState(() {
      _text = '';
      foundMedicines.clear();
      selectedMedicines.clear();
    });
    Size deviceSize = MediaQuery.of(context).size;
    Color primaryColor = Theme.of(context).primaryColor;
    ImageProperties properties =
        await FlutterNativeImage.getImageProperties(inputImage.filePath!);
    double aspectRatio = (properties.width ?? 0) / (properties.height ?? 1);
    // max height should be 50% of screen height
    double height =
        min(deviceSize.height * 0.6, properties.height?.toDouble() ?? 0);
    double width = height * aspectRatio;
    width = min(deviceSize.width, width);
    height = width / aspectRatio;
    _imageSize = Size(width, height);
    File compressedFile = await FlutterNativeImage.compressImage(
      inputImage.filePath!,
      targetWidth: width.toInt(),
      targetHeight: height.toInt(),
    );
    inputImage = InputImage.fromFilePath(compressedFile.path);
    await getOCRResults(inputImage.filePath!);
    if (ocrDocument == null) return;
    OCRPainter painter = OCRPainter(
      ocrDocument!,
      Size(
          width.clamp(0, deviceSize.width), height.clamp(0, deviceSize.height)),
      primaryColor,
      padding: 1,
    );
    _customPainter = painter;
    setState(() {
      foundMedicines = findMedicines();
      _logService.i('Found medicines: $foundMedicines');
    });
  }

  List<RecognizedMedicine> findMedicines() {
    if (_text == null) return [];
    String text = _text!
        .replaceAll('\n', ' ')
        .replaceAll("\"", "")
        .replaceAll(",", " ")
        .replaceAll(
          // number
          RegExp(r'[0-9]'),
          '',
        );
    List<String> words = text.split(' ');
    List<RecognizedMedicine> foundMedicines = [];
    if (medicines.isEmpty) return foundMedicines;
    for (String word in words) {
      // find the closest medicine with text similarity upto 80
      List<String> foundMedicine = [];
      for (String med in medicines) {
        double similarity = textSimilar(word.toLowerCase(), med.toLowerCase());
        if (similarity >= 0.95) {
          foundMedicine.add(med);
        }
      }
      foundMedicines.addAll(
        foundMedicine
            .map(
              (e) => RecognizedMedicine(
                e,
                textSimilar(word.toLowerCase(), e.toLowerCase()),
                true,
              ),
            )
            .toList(),
      );
    }
    //remove duplicates via name
    for (int i = 0; i < foundMedicines.length; i++) {
      for (int j = i + 1; j < foundMedicines.length; j++) {
        if (foundMedicines[i].medicine == foundMedicines[j].medicine) {
          foundMedicines.removeAt(j);
          j--;
        }
      }
    }
    foundMedicines.sort((a, b) => a.medicine.compareTo(b.medicine));
    foundMedicines.sort((a, b) => b.confidence.compareTo(a.confidence));
    foundMedicines = foundMedicines
        .map(
          (e) => RecognizedMedicine(
            e.medicine,
            e.confidence,
            e.confidence >= 0.75,
          ),
        )
        .toList();
    return foundMedicines;
  }

  double textSimilar(String str1, String str2) {
    Set<String> set1 = str1.split('').toSet();
    Set<String> set2 = str2.split('').toSet();

    int intersection = set1.intersection(set2).length;
    int union = set1.union(set2).length;
    double similarity = intersection / union;
    return similarity;
  }

  String? getText(List<TextSegment> textSegments) {
    if (textSegments.isEmpty) return null;
    String text = '';
    for (TextSegment segment in textSegments) {
      text += _text?.substring(int.tryParse(segment.startIndex ?? "0") ?? 0,
              int.tryParse(segment.endIndex ?? "0")) ??
          '';
    }
    return text;
  }

  void recognizedBottomSheet(Size size) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      enableDrag: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Container(
          alignment: Alignment.topLeft,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          height: size.height *
              ((ocrDocument?.pages?.first.blocks?.length ?? 0) > 2
                  ? (ocrDocument?.pages?.first.blocks?.length ?? 0) > 5
                      ? 0.7
                      : 0.4
                  : 0.3),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Recognized Text',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      AppSpacing.verticalSpacing12,
                      if (isLoading)
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator(
                                color: Theme.of(context).primaryColor,
                                strokeWidth: 1.5,
                              ),
                              AppSpacing.verticalSpacing12,
                              Text(
                                'Detecting Text',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        )
                      else
                        ...ocrDocument?.pages?.first.blocks
                                ?.map(
                                  (e) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppSpacing.verticalSpacing12,
                                      if (e.layout?.textAnchor?.textSegments !=
                                          null)
                                        Text(
                                          getText(
                                                e.layout?.textAnchor
                                                        ?.textSegments ??
                                                    [],
                                              ) ??
                                              '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
                                      AppSpacing.verticalSpacing12,
                                      const Divider(
                                        height: 1,
                                        color: AppColors.grey300,
                                      ),
                                    ],
                                  ),
                                )
                                .toList() ??
                            [],
                      AppSpacing.verticalSpacing48,
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                width: size.width,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    boxShadow: [
                      boxShadow(),
                    ],
                    border: const Border(
                      top: BorderSide(
                        color: AppColors.grey100,
                        width: 2,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          _pickImage(
                            ImageSource.gallery,
                            onImageSelected: () {
                              Navigator.pop(context);
                            },
                          );
                        },
                        icon: Icon(
                          Icons.photo_library_outlined,
                          color: Theme.of(context).primaryColor,
                        ),
                        label: Text(
                          'From Gallery',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          _pickImage(
                            ImageSource.camera,
                            onImageSelected: () {
                              Navigator.pop(context);
                            },
                          );
                        },
                        icon: Icon(
                          Icons.camera_alt_outlined,
                          color: Theme.of(context).primaryColor,
                        ),
                        label: Text(
                          'From Camera',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> getOCRResults(String imagePath) async {
    setState(() {
      isLoading = true;
    });
    try {
      if (_imageFile == null) return;
      TFLiteModel model = TFLiteModel();
      await model.init();
      ocrDocument = await _ocrService.getOCRDetection(imagePath);
      if (ocrDocument != null) {
        setState(() {
          _text = ocrDocument!.text;
        });
      }
    } catch (e) {
      _logService.e('Error processing image', e, StackTrace.current);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget _buildImage() {
    return isLoading
        ? SizedBox(
            width: MediaQuery.of(context).size.width,
            height: _imageSize?.height,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                    strokeWidth: 1.5,
                  ),
                  AppSpacing.verticalSpacing12,
                  Text(
                    'Detecting Text',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          )
        : _customPainter == null
            ? SizedBox(
                width: _imageSize?.width,
                height: _imageSize?.height,
                child: Image.file(
                  File(_imageFile!.path),
                  fit: BoxFit.scaleDown,
                ),
              )
            : Container(
                width: MediaQuery.of(context).size.width,
                height: _imageSize?.height,
                alignment: Alignment.center,
                child: Stack(
                  fit: StackFit.loose,
                  children: [
                    SizedBox(
                      width: _imageSize?.width,
                      height: _imageSize?.height,
                      child: Image.file(
                        File(_imageFile!.path),
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    CustomPaint(
                      size: Size(
                        _imageSize?.width ?? 0,
                        _imageSize?.height ?? 0,
                      ),
                      foregroundPainter: _customPainter!,
                    ),
                  ],
                ),
              );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _imageFile == null
          ? null
          : FloatingActionButton.extended(
              onPressed: () {
                recognizedBottomSheet(MediaQuery.of(context).size);
              },
              label: const Text('Show Text'),
            ),
      appBar: AppBar(
        leading: CustomBackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Submit Report',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_imageFile != null) ...[
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                child: Text(
                  'Selected Image',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Transform.scale(
                scale: 0.9,
                child: _buildImage(),
              ),
              if (foundMedicines.isNotEmpty)
                Container(
                  margin: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.secondaryContainer,
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Medicines',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      if (foundMedicines.length < 10)
                        Wrap(
                          spacing: 10,
                          children: foundMedicines
                              .map(
                                (e) => Chip(
                                  avatar: e.confidence >= 0.75
                                      ? const Icon(
                                          Icons.check_circle_outline_rounded,
                                          color: AppColors.white,
                                        )
                                      : const Icon(
                                          Icons.error_outline_rounded,
                                          color: AppColors.white,
                                        ),
                                  label: Text(
                                    e.medicine,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                        ),
                                  ),
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  deleteIcon: e.isSelected
                                      ? const Icon(
                                          Icons.delete_outline_rounded,
                                          color: AppColors.white,
                                        )
                                      : const Icon(
                                          Icons.add_circle_outline_rounded,
                                          color: AppColors.white,
                                        ),
                                  onDeleted: () {
                                    setState(() {
                                      e.isSelected = !e.isSelected;
                                    });
                                  },
                                ),
                              )
                              .toList(),
                        )
                      else
                        Column(
                          children: [
                            ...foundMedicines
                                .map(
                                  (e) => Row(
                                    children: [
                                      if (e.confidence >= 0.75)
                                        Icon(
                                          Icons.check_circle_outline_rounded,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondaryContainer,
                                        )
                                      else
                                        Icon(
                                          Icons.error_outline_rounded,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondaryContainer,
                                        ),
                                      const SizedBox(width: 10),
                                      Text(
                                        e.medicine,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondaryContainer,
                                            ),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            e.isSelected = !e.isSelected;
                                          });
                                        },
                                        icon: e.isSelected
                                            ? Icon(
                                                Icons.delete_outline_rounded,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSecondaryContainer,
                                              )
                                            : Icon(
                                                Icons
                                                    .add_circle_outline_rounded,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSecondaryContainer,
                                              ),
                                      ),
                                    ],
                                  ),
                                )
                                .toList(),
                          ],
                        )
                    ],
                  ),
                )
              else
                Container(
                  height: 100,
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Medicines',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      AppSpacing.verticalSpacing12,
                      Text(
                        'No medicines found',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                            ),
                      ),
                      AppSpacing.verticalSpacing8,
                      Text(
                        'Try uploading a correct image or try again later',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                            ),
                      ),
                    ],
                  ),
                ),
              if (foundMedicines.isNotEmpty)
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      List<String> selectedMedicines = foundMedicines
                          .where((element) => element.isSelected)
                          .map((e) => e.medicine)
                          .toList();
                      GoRouter.of(context).pushNamed(
                        AppRouter.medicationSelectedNamed,
                        extra: selectedMedicines,
                      );
                    },
                    child: Text(
                      'Proceed to next',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.white,
                          ),
                    ),
                  ),
                ),
              AppSpacing.verticalSpacing48,
              AppSpacing.verticalSpacing48
            ] else
              Column(
                children: [
                  _uploadImageWidget(context),
                  const Divider(
                    height: 1,
                    color: AppColors.grey300,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.info_outline,
                          color: AppColors.grey300,
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            'Make sure the report is clear and readable',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: AppColors.grey300,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // instruction
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.medical_services_outlined,
                          color: AppColors.grey300,
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            'Medicare will analyze the report and provide you with a summary',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: AppColors.grey300,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // instruction
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.warning_amber_rounded,
                          color: AppColors.grey300,
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            'Some reports might not have correct or detected medicines',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: AppColors.grey300,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }

  Container _uploadImageWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height * 0.6,
      width: MediaQuery.of(context).size.width,
      decoration: DottedDecoration(
        shape: Shape.box,
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.onSecondaryContainer,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.secondaryContainer,
        ),
        alignment: Alignment.center,
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: InkWell(
                onTap: () {
                  _pickImage(ImageSource.camera);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt_outlined,
                      size: 50,
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Take a picture of your report',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              height: 1,
              color: AppColors.grey300,
            ),
            Flexible(
              flex: 1,
              child: InkWell(
                onTap: () {
                  _pickImage(ImageSource.gallery);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.photo_library_outlined,
                      size: 50,
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Upload from gallery',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecognizedMedicine {
  String medicine;
  double confidence;
  bool isSelected;

  RecognizedMedicine(this.medicine, this.confidence, this.isSelected);
}
