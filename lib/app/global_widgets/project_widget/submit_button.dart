import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CustomSubmitButton extends StatelessWidget {
  const CustomSubmitButton(
      {Key? key, required this.onPressed, required this.label})
      : super(key: key);

  final Function onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return FadeOutDown(
      child: ReactiveFormConsumer(
        builder: (context, form, child) => DisableWidget(
          condition: !form.valid,
          child: InkWell(
            onTap: () => onPressed(),
            child: Container(
              height: 50,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Text(
                  label,
                  style: const TextStyle(
                      fontSize: 18,
                      // color: AppColors.lightTextButton,
                      // fontFamily: "DinNextLtW23",
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DisableWidget extends StatelessWidget {
  const DisableWidget({
    Key? key,
    required this.child,
    this.condition = true,
    this.withOpacity = true,
  }) : super(key: key);
  final Widget child;
  final bool condition;
  final bool withOpacity;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: condition,
      child: withOpacity
          ? Opacity(
              opacity: !condition ? 1 : 0.6,
              child: child,
            )
          : child,
    );
  }
}
