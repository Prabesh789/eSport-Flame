import 'dart:io';

import 'package:esport_flame/core/app_colors.dart';
import 'package:esport_flame/core/widgets/custom_bottun.dart';
import 'package:esport_flame/core/widgets/custom_textfield.dart';
import 'package:esport_flame/feature/admin/notifiers/image_picked_notifier.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddGames extends ConsumerStatefulWidget {
  const AddGames({Key? key, this.mediaQuery}) : super(key: key);
  final Size? mediaQuery;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddGamesState();
}

class _AddGamesState extends ConsumerState<AddGames> {
  DateTime selectedDate = DateTime.now();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  final _prizeController = TextEditingController();
  final _titleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _dateFocusNode = FocusNode();
  final _prizeFocusNode = FocusNode();
  late File _imageFile = File('');
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? _datePicker = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (_datePicker != null && _datePicker != selectedDate) {
      setState(() {
        selectedDate = _datePicker;

        final _date = DateFormat('MMM dd,yyyy').format(_datePicker);
        _dateController.text = _date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isImgPicked = ref.watch(adsImagePickedNotifier).value;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Games',
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
                const SizedBox(
                  height: 10,
                ),
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
                    FocusScope.of(context).unfocus();
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
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: CustomTextField(
                          isEnabled: false,
                          labelText: 'Match Date',
                          context: context,
                          controller: _dateController,
                          prefixIcon: const Icon(
                            Icons.date_range,
                            size: 18,
                          ),
                          focusNode: _dateFocusNode,
                          onEditingComplete: () {
                            FocusScope.of(context).unfocus();
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Date is empty';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: CustomTextField(
                        keyboardType: TextInputType.number,
                        labelText: 'Winner prize',
                        hintText: '\$',
                        context: context,
                        controller: _prizeController,
                        prefixIcon: const Icon(
                          Icons.price_change,
                          size: 18,
                        ),
                        focusNode: _prizeFocusNode,
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
                    ),
                  ],
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
                  'Choose Game Poster',
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
                    child: !isImgPicked
                        ? Padding(
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
                          )
                        : const SizedBox(),
                  ),
                ),
                SizedBox(
                  height: widget.mediaQuery!.width / 4,
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
