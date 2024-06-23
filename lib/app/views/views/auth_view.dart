import 'package:bike_rental/app/views/views/helper.dart';
import 'package:bike_rental/app/views/views/signin_form.dart';
import 'package:bike_rental/app/views/views/signup_form.dart';
import 'package:flutter/material.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key, required this.draggableScrollableController});

  final DraggableScrollableController draggableScrollableController;

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  List<Widget> forms = [SigninForm(), SignupForm()];
  List<String> formLabels = ['Sign in', 'Sign Up'];
  int selectedFormIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0,
      minChildSize: 0.0,
      maxChildSize: 0.75,
      controller: widget.draggableScrollableController,
      snapSizes: const [.01, .5, .75],
      snap: true,
      builder: (context, scrollController) {
        return Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                // Colors.white60,
                // Colors.white30,
                Color(0xffffcc00),
                Color(0xffff2e17),
              ],
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd,
            ),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            border: Border.all(
              width: 1.5,
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        formLabels[selectedFormIndex],
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        widget.draggableScrollableController.animateTo(0,
                            duration: Durations.medium1,
                            curve: Curves.bounceOut);
                      },
                      icon: const Icon(Icons.close_rounded),
                    ),
                  ],
                ),
                UIHelperViews.vSpaceMedium,
                Align(
                  alignment: Alignment.bottomCenter,
                  child: selectedFormIndex == 0
                      ? Row(
                          children: [
                            const Text('Don\'t have an acoount?'),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  selectedFormIndex = 1;
                                });
                              },
                              child: const Text('Sign Up'),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            const Text('Already have an acoount?'),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  selectedFormIndex = 0;
                                });
                              },
                              child: const Text('Sign In'),
                            ),
                          ],
                        ),
                ),
                UIHelperViews.vSpaceMedium,
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 360),
                  child: forms[selectedFormIndex],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
