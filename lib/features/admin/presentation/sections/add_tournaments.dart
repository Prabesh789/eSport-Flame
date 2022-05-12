import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:esport_flame/core/app_colors.dart';
import 'package:esport_flame/core/entities/base_state.dart';
import 'package:esport_flame/core/extension/snackbar_extension.dart';
import 'package:esport_flame/core/notifiers/notifiers.dart';
import 'package:esport_flame/core/widgets/custom_body.dart';
import 'package:esport_flame/core/widgets/custom_bottun.dart';
import 'package:esport_flame/core/widgets/custom_shimmer.dart';
import 'package:esport_flame/core/widgets/custom_textfield.dart';
import 'package:esport_flame/features/admin/application/admin_controller.dart';
import 'package:esport_flame/features/admin/infrastructure/entities/add_tournament_request.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

final addTournamentsController =
    StateNotifierProvider.autoDispose<AdminController, BaseState>(
        adminController);

final updateTournamentsController =
    StateNotifierProvider.autoDispose<AdminController, BaseState>(
        adminController);

class AddTournaments extends ConsumerStatefulWidget {
  const AddTournaments({
    Key? key,
    this.mediaQuery,
    this.isEdit = false,
    this.title,
    this.description,
    this.matchDate,
    this.deadLine,
    this.bookingDate,
    this.prize,
    this.imgUrl,
    this.docId,
  }) : super(key: key);
  final Size? mediaQuery;
  final bool isEdit;
  final String? title;
  final String? description;
  final String? matchDate;
  final String? deadLine;
  final String? bookingDate;
  final String? prize;
  final String? imgUrl;
  final String? docId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTournamentsState();
}

class _AddTournamentsState extends ConsumerState<AddTournaments> {
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
  final _bookingOpencontroller = TextEditingController();
  final _deadLinecontroller = TextEditingController();
   String _imageUrl ='';

  Future<void> _selectDate(BuildContext context, int dateStatus) async {
    final DateTime? _datePicker = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (_datePicker != null && _datePicker != selectedDate) {
      setState(() {
        selectedDate = _datePicker;

        final _date = DateFormat('MMM dd,yyyy').format(_datePicker);
        if (dateStatus == 1) {
          _dateController.text = _date;
        } else if (dateStatus == 2) {
          _bookingOpencontroller.text = _date;
        } else {
          _deadLinecontroller.text = _date;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    editValue();
  }

  void editValue() {
    if (widget.isEdit) {
      _titleController.text = widget.title ?? '';
      _descriptionController.text = widget.description ?? '';
      _dateController.text = widget.matchDate ?? '';
      _bookingOpencontroller.text = widget.bookingDate ?? '';
      _deadLinecontroller.text = widget.deadLine ?? '';
      _prizeController.text = widget.prize ?? '';
      _imageUrl = widget.imgUrl ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<BaseState>(addTournamentsController, (oldState, state) {
      state.maybeWhen(
        success: (_) {
          context.showSnackBar(
            'Tournaments Successfully Added !!!',
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
    ref.listen<BaseState>(updateTournamentsController, (oldState, state) {
      state.maybeWhen(
        success: (_) {
          context.showSnackBar(
            'Tournaments Successfully Updated !!!',
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
    final state = ref.watch(addTournamentsController);
    final tournamentEditStateProvider = ref.watch(isEditNotifier);
    log('${tournamentEditStateProvider.value}');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEdit ? 'Edit Tournaments' : 'Add Tournaments',
          style: GoogleFonts.baskervville(
            textStyle: Theme.of(context).textTheme.headline2?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: CustomBodyWidget(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
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
                        return 'Title required';
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
                            _selectDate(context, 1);
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
                          prefixText: '\$',
                          hintText: '000.0',
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
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            _selectDate(context, 2);
                          },
                          child: CustomTextField(
                            isEnabled: false,
                            labelText: 'Booking Open',
                            context: context,
                            controller: _bookingOpencontroller,
                            prefixIcon: const Icon(
                              Icons.date_range,
                              size: 18,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Date required';
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
                        child: InkWell(
                          onTap: () {
                            _selectDate(context, 3);
                          },
                          child: CustomTextField(
                            isEnabled: false,
                            labelText: 'Date-line',
                            context: context,
                            controller: _deadLinecontroller,
                            prefixIcon: const Icon(
                              Icons.date_range,
                              size: 18,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Date required';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                    ],
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
                  if (!tournamentEditStateProvider.value)
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
                                        fontSize: 14,
                                      ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  if (tournamentEditStateProvider.value)
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.blue[50],
                      ),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              height: widget.mediaQuery!.height / 4,
                              width: widget.mediaQuery!.width / 1.2,
                              imageUrl: _imageUrl,
                              fit: BoxFit.cover,
                              errorWidget: (ctx, str, dy) {
                                return CustomShimmer(
                                  width: widget.mediaQuery!.width,
                                  height: widget.mediaQuery!.width,
                                );
                              },
                              placeholder: (ctx, str) {
                                return CustomShimmer(
                                  width: widget.mediaQuery!.width / 2,
                                  height: widget.mediaQuery!.width / 2.4,
                                );
                              },
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              tournamentEditStateProvider.isEdit(
                                  updatedValue: false);
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
                                            fontSize: 14,
                                          ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: widget.mediaQuery!.width / 1.2,
                    child: CustomButton(
                      isLoading: state.maybeMap(
                          orElse: () => false, loading: (_) => true),
                      buttonText: widget.isEdit ? "Update" : 'Add +',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (!widget.isEdit) {
                            ref
                                .read(addTournamentsController.notifier)
                                .postTournaments(
                                  AddTournament(
                                    gameTitle: _titleController.text.trim(),
                                    gameDescpription:
                                        _descriptionController.text.trim(),
                                    gamePosterImage: _imageFile,
                                    matchDate: _dateController.text.trim(),
                                    winnerPrize: _prizeController.text.trim(),
                                    bookingOpenDate:
                                        _bookingOpencontroller.text.trim(),
                                    deadLineDate:
                                        _deadLinecontroller.text.trim(),
                                  ),
                                );
                          } else {
                            ref
                                .read(updateTournamentsController.notifier)
                                .updateTournament(
                                  AddTournament(
                                    gameTitle: _titleController.text.trim(),
                                    gameDescpription:
                                        _descriptionController.text.trim(),
                                    gamePosterImage: _imageFile,
                                    matchDate: _dateController.text.trim(),
                                    winnerPrize: _prizeController.text.trim(),
                                    bookingOpenDate:
                                        _bookingOpencontroller.text.trim(),
                                    deadLineDate:
                                        _deadLinecontroller.text.trim(),
                                  ),
                                  widget.docId ?? '',
                                );
                          }
                        }
                      },
                    ),
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
