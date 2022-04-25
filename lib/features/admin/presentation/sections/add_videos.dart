import 'dart:developer';

import 'package:esport_flame/core/app_colors.dart';
import 'package:esport_flame/core/entities/base_state.dart';
import 'package:esport_flame/core/extension/snackbar_extension.dart';
import 'package:esport_flame/core/widgets/custom_bottun.dart';
import 'package:esport_flame/core/widgets/custom_textfield.dart';
import 'package:esport_flame/features/admin/application/admin_controller.dart';
import 'package:esport_flame/features/admin/infrastructure/entities/add_videos.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final addVideosController =
    StateNotifierProvider.autoDispose<AdminController, BaseState>(
        adminController);

class AddVideos extends ConsumerStatefulWidget {
  const AddVideos({Key? key, this.mediaQuery}) : super(key: key);
  final Size? mediaQuery;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddVideosState();
}

class _AddVideosState extends ConsumerState<AddVideos> {
  final _titleController = TextEditingController();
  final _videoLinkController = TextEditingController();
  final _titleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    ref.listen<BaseState>(addVideosController, (oldState, state) {
      state.maybeWhen(
        success: (_) {
          context.showSnackBar(
            'Videos Successfully Added !!!',
            Icons.check_circle,
            AppColors.greencolor,
          );
          _titleController.clear();
          _videoLinkController.clear();

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
    final state = ref.watch(addVideosController);
    final _isLoading = state == const BaseState<void>.loading();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Videos',
          style: GoogleFonts.baskervville(
            textStyle: Theme.of(context).textTheme.headline2?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
      body: Form(
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
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
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
                  controller: _videoLinkController,
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
                SizedBox(
                  height: widget.mediaQuery!.height / 5,
                ),
                CustomButton(
                  isLoading: _isLoading,
                  buttonText: 'Add +',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ref.read(addVideosController.notifier).postVideos(
                            AddVideoRequest(
                              videotitle: _titleController.text.trim(),
                              videoDescpription:
                                  _videoLinkController.text.trim(),
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
    );
  }
}
