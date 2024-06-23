import 'dart:typed_data';

import 'package:bike_rental/app/modules/auth/controllers/auth_controller.dart';
import 'package:bike_rental/app/routes/app_pages.dart';
import 'package:bike_rental/app/views/bricks/form_input.dart';
import 'package:bike_rental/app/views/views/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

// ignore: constant_identifier_names
enum DocumentType { id_card, admission_letter, nin_slip }

class SignupForm extends GetView<AuthController> {
  SignupForm({super.key});

  final GlobalKey signupForm = GlobalKey<FormState>();
  final TextEditingController admissionNumber = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController nin = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController passwordConfirmation = TextEditingController();

  final Rx<DocumentType?> documentType = Rx<DocumentType?>(null);
  final Rx<XFile?> profilePicture = Rx<XFile?>(null);
  final Rx<XFile?> documentImage = Rx<XFile?>(null);
  final Rx<Uint8List?> profilePicturePreview = Rx<Uint8List?>(null);
  final Rx<Uint8List?> documentImagePreview = Rx<Uint8List?>(null);
  final RxBool acceptTerms = false.obs;

  final isLoading = false.obs;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: signupForm,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: AutofillGroup(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FormInput(
            inputController: admissionNumber,
            label: 'Admission number',
            hint: 'Enter student admission number',
            autofillHints: const [AutofillHints.newUsername],
          ),
          UIHelperViews.vSpaceMedium,
          FormInput(
            inputController: name,
            label: 'Name',
            hint: 'Enter student fullname',
            autofillHints: const [AutofillHints.name],
          ),
          UIHelperViews.vSpaceMedium,
          FormInput(
            inputController: email,
            label: 'Email',
            hint: 'Enter email',
            autofillHints: const [
              AutofillHints.newUsername,
              AutofillHints.email
            ],
          ),
          UIHelperViews.vSpaceMedium,
          FormInput(
            inputController: phone,
            label: 'Phone number',
            hint: 'Enter Phone number',
            autofillHints: const [
              AutofillHints.newUsername,
              AutofillHints.telephoneNumber
            ],
          ),
          UIHelperViews.vSpaceMedium,
          FormInput(
            inputController: nin,
            label: 'NIN',
            hint: 'Enter student NIN',
            autofillHints: const [AutofillHints.creditCardNumber],
          ),
          UIHelperViews.vSpaceMedium,
          FormInput(
            inputController: password,
            label: 'Password',
            hint: 'Enter password',
            obscure: true,
            autofillHints: const [AutofillHints.newPassword],
          ),
          UIHelperViews.vSpaceMedium,
          FormInput(
            inputController: passwordConfirmation,
            label: 'Confirm password',
            hint: 'Re-enter Password',
            obscure: true,
            autofillHints: const [AutofillHints.newPassword],
          ),
          UIHelperViews.vSpaceMedium,
          // --picker--
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return Dialog(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: SingleChildScrollView(
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              width: 360,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text('Pick profile picture',
                                            maxLines: 2,
                                            style: Get
                                                .theme.textTheme.headlineSmall),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                        onPressed: () => Get.back(),
                                        icon: Icon(
                                          Icons.close,
                                          color: Get.theme.colorScheme.error,
                                        ),
                                      )
                                    ],
                                  ),
                                  const Divider(),
                                  ObxValue((data) {
                                    if (data.value != null) {
                                      return Container(
                                        width: 340,
                                        height: 340,
                                        margin: const EdgeInsets.all(8),
                                        child: Image.memory(
                                          profilePicturePreview.value!,
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    }
                                    return Container(
                                      width: 340,
                                      height: 340,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Get.theme.disabledColor),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Get.theme.disabledColor
                                              .withOpacity(.8)),
                                    );
                                  }, profilePicture),
                                  const Divider(),
                                  ElevatedButton(
                                    onPressed: () async {
                                      XFile? file = await ImagePicker()
                                          .pickImage(
                                              source: ImageSource.gallery);
                                      if (file == null) {
                                        Get.snackbar(
                                            'Error', 'Invalid file selected');
                                      } else {
                                        profilePicture.value = file;
                                        profilePicturePreview.value =
                                            await file.readAsBytes();
                                      }
                                    },
                                    child: const Text('From files'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
                icon: const Icon(Icons.account_circle_rounded),
                label: const Text('Profile Image'),
              ),
              UIHelperViews.hSpaceMedium,
              ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return Dialog(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: SingleChildScrollView(
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              width: 360,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text('Pick KYC document',
                                            maxLines: 2,
                                            style: Get
                                                .theme.textTheme.headlineSmall),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                        onPressed: () => Get.back(),
                                        icon: Icon(
                                          Icons.close,
                                          color: Get.theme.colorScheme.error,
                                        ),
                                      )
                                    ],
                                  ),
                                  const Divider(),
                                  const Text('Document Type'),
                                  ObxValue((data) {
                                    return RadioListTile.adaptive(
                                      value: DocumentType.id_card,
                                      groupValue: documentType.value,
                                      onChanged: (value) {
                                        documentType.value =
                                            value as DocumentType;
                                      },
                                      title: const Text('Id Card'),
                                    );
                                  }, documentType),
                                  ObxValue((data) {
                                    return RadioListTile.adaptive(
                                      value: DocumentType.admission_letter,
                                      groupValue: documentType.value,
                                      onChanged: (value) {
                                        documentType.value =
                                            value as DocumentType;
                                      },
                                      title: const Text('Admission letter'),
                                    );
                                  }, documentType),
                                  ObxValue((data) {
                                    return RadioListTile.adaptive(
                                      value: DocumentType.nin_slip,
                                      groupValue: documentType.value,
                                      onChanged: (value) {
                                        data.value = value as DocumentType;
                                      },
                                      title: const Text('NIN slip'),
                                    );
                                  }, documentType),
                                  ObxValue((data) {
                                    if (data.value != null) {
                                      return Container(
                                        width: 340,
                                        height: 340,
                                        margin: const EdgeInsets.all(8),
                                        child: Image.memory(
                                          documentImagePreview.value!,
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    }
                                    return Container(
                                      width: 340,
                                      height: 340,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Get.theme.disabledColor),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Get.theme.disabledColor
                                              .withOpacity(.8)),
                                    );
                                  }, documentImage),
                                  const Divider(),
                                  ElevatedButton(
                                    onPressed: () async {
                                      XFile? file = await ImagePicker()
                                          .pickImage(
                                              source: ImageSource.gallery);
                                      if (file == null) {
                                        Get.snackbar(
                                            'Error', 'Invalid file selected');
                                      } else {
                                        documentImage.value = file;
                                        documentImagePreview.value =
                                            await file.readAsBytes();
                                      }
                                    },
                                    child: const Text('From files'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
                icon: const Icon(Icons.perm_identity_rounded),
                label: const Text('KYC Document'),
              ),
            ],
          ),
          UIHelperViews.vSpaceMedium,
          Obx(() {
            if (documentImage.value != null || profilePicture.value != null) {
              return SizedBox(
                height: 200,
                width: 360,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ObxValue((data) {
                        if (data.value != null) {
                          return Container(
                            height: 200,
                            margin: const EdgeInsets.all(8),
                            child: Image.memory(
                              data.value!,
                              fit: BoxFit.cover,
                            ),
                          );
                        }
                        return Container(
                          height: 200,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Get.theme.disabledColor),
                              borderRadius: BorderRadius.circular(15),
                              color: Get.theme.disabledColor.withOpacity(.8)),
                        );
                      }, profilePicturePreview),
                    ),
                    UIHelperViews.hSpaceMedium,
                    Expanded(
                      child: ObxValue((data) {
                        if (data.value != null) {
                          return Container(
                            height: 200,
                            margin: const EdgeInsets.all(8),
                            child: Image.memory(
                              data.value!,
                              fit: BoxFit.cover,
                            ),
                          );
                        }
                        return Container(
                          height: 200,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Get.theme.disabledColor),
                              borderRadius: BorderRadius.circular(15),
                              color: Get.theme.disabledColor.withOpacity(.8)),
                        );
                      }, documentImagePreview),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          }),
          // --picker-end--
          ObxValue((value) {
            return CheckboxListTile.adaptive(
              value: value.value,
              onChanged: (value) {
                acceptTerms.value = value!;
              },
              title: Wrap(
                children: [
                  const Text('I accept'),
                  TextButton(
                    onPressed: () {
                      // TODO: Navigate to terms and conditions page
                    },
                    child: const Text('The terms and conditions'),
                  ),
                ],
              ),
            );
          }, acceptTerms),
          UIHelperViews.vSpaceMedium,
          ObxValue((data) {
            return ElevatedButton(
              onPressed: data.value ? null : register,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: data.value
                    ? const CircularProgressIndicator.adaptive()
                    : const Text('Sign Up'),
              ),
            );
          }, isLoading),
        ],
      )),
    );
  }

  register() async {
    isLoading(true);
    try {
      if (admissionNumber.text.isEmpty) {
        throw SignupException(message: 'Admission number is required.');
      }
      if (name.text.isEmpty) {
        throw SignupException(message: 'Name is required.');
      }
      if (!email.text.isEmail) {
        throw SignupException(message: 'Invalid email.');
      }
      if (phone.text.isEmpty) {
        throw SignupException(message: 'Phone number is required.');
      }
      if (nin.text.isEmpty) {
        throw SignupException(message: 'NIN number is required.');
      }
      if ((password.text.length < 6 ||
          password.text != passwordConfirmation.text)) {
        throw SignupException(
            message: 'Invalid password or password not Match.');
      }
      if (documentType.value == null) {
        throw SignupException(message: 'KYC document type not specified.');
      }
      if (profilePicture.value == null || documentImage.value == null) {
        throw SignupException(
            message: 'Profile picture and KYC document are required.');
      }
      if (!acceptTerms.value) {
        throw SignupException(
            message:
                'You have to accept the term and condition before you proceed. Make sure to look at our privacy policies.');
      }

      await controller.register(
          admissionNo: admissionNumber.text,
          name: name.text,
          email: email.text,
          phone: phone.text,
          nin: nin.text,
          password: password.text,
          password2: passwordConfirmation.text,
          photo: profilePicture.value!,
          document: documentImage.value!,
          docType: documentType.value!.name);

      Get.toNamed(Routes.HOME);
    } on SignupException catch (e) {
      Get.snackbar('Sign Up Error', e.message,
          duration: 5.seconds, snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      e.printError();
    } finally {
      isLoading(false);
    }
  }
}

class SignupException implements Exception {
  final String message;

  SignupException({required this.message});

  @override
  String toString() {
    return 'Sign Up error: $message';
  }
}
