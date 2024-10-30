import 'package:flutter/material.dart';
import 'package:kanga_care/core/styling/text_styles_and_colors.dart';

class AccountPageListItem extends StatelessWidget {
  final Icon icon;
  final String title;
  final VoidCallback? onPressed;

  const AccountPageListItem(
      {super.key,
      required this.title,
      required this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.1)))),
      padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
      child: GestureDetector(
        onTap: onPressed,
        child: Row(
          children: <Widget>[
            IconTheme(
              data: const IconThemeData(size: 22),
              child: icon,
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 15),
                child: Text(title,
                    style: TextStyle(
                      fontFamily: CustomTextStyles.fontName,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      letterSpacing: 0.5,
                      color: Theme.of(context).textTheme.headlineSmall?.color,
                    )),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconTheme(
                data: IconThemeData(
                    color: Theme.of(context).textTheme.headlineSmall?.color,
                    size: 13),
                child: const Icon(Icons.arrow_forward_ios),
              ),
            )
          ],
        ),
      ),
    );
  }
}
