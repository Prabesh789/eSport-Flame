import 'dart:developer';
import 'dart:io';

import 'package:esport_flame/core/app_colors.dart';
import 'package:esport_flame/core/entities/base_state.dart';
import 'package:esport_flame/core/extension/snackbar_extension.dart';
import 'package:esport_flame/core/widgets/custom_body.dart';
import 'package:esport_flame/core/widgets/custom_bottun.dart';
import 'package:esport_flame/core/widgets/custom_textfield.dart';
import 'package:esport_flame/features/admin/application/admin_controller.dart';
import 'package:esport_flame/features/admin/infrastructure/entities/add_ads_request.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final addAdsController =
    StateNotifierProvider.autoDispose<AdminController, BaseState>(
        adminController);

class AddAds extends ConsumerStatefulWidget {
  const AddAds({Key? key, this.mediaQuery}) : super(key: key);
  final Size? mediaQuery;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddAdsState();
}

class _AddAdsState extends ConsumerState<AddAds> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _titleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  late File _imageFile = File('');
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _titleFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageFile.delete();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<BaseState>(addAdsController, (oldState, state) {
      state.maybeWhen(
        success: (_) {
          context.showSnackBar(
            'Ads Successfully Added !!!',
            Icons.check_circle,
            AppColors.greencolor,
          );
          _titleController.clear();
          _descriptionController.clear();
          _imageFile.delete();
          log('==>>data cleared.');
          Navigator.of(context).pop();
        },
        error: (_) {
          context.showSnackBar(
              'Something went wrong !!!', Icons.error, AppColors.redColor);
        },
        orElse: () => const LinearProgressIndicator(
          backgroundColor: AppColors.blueColor,
        ),
      );
    });
    final state = ref.watch(addAdsController);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Ads',
          style: GoogleFonts.baskervville(
            textStyle: Theme.of(context).textTheme.headline2?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
      body: CustomBodyWidget(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomTextField(
                    labelText: 'Title',
                    context: context,
                    controller: _titleController,
                    prefixIcon: const Icon(
                      Icons.title,
                      size: 18,
                    ),
                    focusNode: _titleFocusNode,
                    onEditingComplete: () {
                      FocusScope.of(context)
                          .requestFocus(_descriptionFocusNode);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'title required';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    maxLines: 5,
                    labelText: 'Description',
                    context: context,
                    controller: _descriptionController,
                    prefixIcon: const Icon(
                      Icons.description,
                      size: 18,
                    ),
                    focusNode: _descriptionFocusNode,
                    onEditingComplete: () {
                      FocusScope.of(context).unfocus();
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Description required';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Choose Ads Image',
                    style: GoogleFonts.baskervville(
                      textStyle: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: widget.mediaQuery!.height / 4,
                    width: widget.mediaQuery!.width / 1.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.blue[50],
                      image: DecorationImage(
                        image: FileImage(
                          _imageFile,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        chooseImg(ImageSource.gallery);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.image,
                              color: AppColors.blackColor,
                            ),
                            Text(
                              'From Gallery',
                              style: GoogleFonts.baskervville(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: widget.mediaQuery!.height / 5,
                  ),
                  CustomButton(
                    isLoading: state.maybeMap(
                        orElse: () => false, loading: (_) => true),
                    buttonText: 'Add +',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ref.read(addAdsController.notifier).addAds(
                              AddAdsRequest(
                                adsDescpription:
                                    _descriptionController.text.trim(),
                                adsTitle: _titleController.text.trim(),
                                adsImage: _imageFile,
                              ),
                            );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //taking a picture from camera or gallery

  void chooseImg(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
    );

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }
}
