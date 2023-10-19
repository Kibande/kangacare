import 'package:flutter/material.dart';

class NotifcationListWidget extends StatelessWidget {
  final String title;
  final String body;

  final String time;
  const NotifcationListWidget({
    super.key,
    required this.title,
    required this.body,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.1),
          ),
        ),
      ),
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        title: Text(
          title,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(body, overflow: TextOverflow.ellipsis),
        trailing: Text(
          time,
          overflow: TextOverflow.ellipsis,
        ),
        minVerticalPadding: null,
        onTap: () {},
      ),
    );
  }
}
