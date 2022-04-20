import 'package:esport_flame/core/widgets/custom_bottun.dart';
import 'package:esport_flame/core/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddVideos extends ConsumerStatefulWidget {
  const AddVideos({Key? key, this.mediaQuery}) : super(key: key);
  final Size? mediaQuery;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddVideosState();
}

class _AddVideosState extends ConsumerState<AddVideos> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _titleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
                SizedBox(
                  height: widget.mediaQuery!.height / 5,
                ),
                CustomButton(
                  // isLoading: isLoading,
                  buttonText: 'Add +',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
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
