// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:chat_route/my_theme.dart';

class CustomButton extends StatelessWidget {
  String text;
  void Function()? onPressed;
  CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return      Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: ElevatedButton(
                    onPressed: onPressed,
                    child: Text(
                     text,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: MyTheme.whiteColor),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: MyTheme.primary,
                        padding: const EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        side: BorderSide(
                          color: MyTheme.whiteColor,
                          width: 2,
                        )),
                  ),
                )
             ;
  }
}
