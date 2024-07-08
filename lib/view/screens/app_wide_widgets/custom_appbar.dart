import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/constants/colors.dart';
import 'custom_shape_border.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackArrow;
  final String title;
  final IconData? leadingIcon;
  final VoidCallback? leadingOnPressed;

  const CustomAppBar({
    Key? key,
    required this.showBackArrow,
    this.leadingIcon,
    this.leadingOnPressed,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: showBackArrow
          ? IconButton(
        onPressed: () => Get.back(), // Assuming you're using GetX for navigation
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white, // تغيير لون الأيقونة هنا إلى الأبيض
        ),
      )
          : (leadingIcon != null
          ? IconButton(
        onPressed: leadingOnPressed,
        icon: Icon(
          leadingIcon,
          color: Colors.white, // تغيير لون الأيقونة هنا إلى الأبيض
        ),
      )
          : null),
      backgroundColor: TColors.primary,
      shape: CustomShapeBorder(), // Use your custom shape border here
      title: Text(
        title,style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.white)),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
