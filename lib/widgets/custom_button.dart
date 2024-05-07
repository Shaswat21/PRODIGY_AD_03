import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function()? onTap;

  const CustomButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              offset: const Offset(3, 3),
              blurRadius: 5,
            )
          ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon),
            const SizedBox(width: 10,),
            Text(
              text,
              style: Theme.of(context).textTheme.labelMedium,
            )
          ],
        ),
      ),
    );
  }
}
