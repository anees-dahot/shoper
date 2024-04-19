import 'package:flutter/material.dart';

import '../../../model/user.dart';

class BottomAppbar extends StatelessWidget {
  const BottomAppbar({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              const Text(
                'Hey there ',
                style:  TextStyle(fontSize: 20),
              ),
              Text(
                user.name,
                style: const TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 20),
              ),
            ],
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_outlined,
                size: 28,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search_outlined,
                size: 28,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        )
      ],
    );
  }
}
