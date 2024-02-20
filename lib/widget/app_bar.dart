import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volunteer_vibes/app_color.dart';

class HAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HAppBar({
    super.key,
    this.title,
    this.titleColor, // New property to specify title color
    this.showBackButton = false,
    this.leadingIcon,
    this.actions,
    this.leadingOnPressed,
    this.shape,
    this.size,
  });

  final Widget? title;
  final Color? titleColor; // New property to specify title color
  final bool showBackButton;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final ShapeBorder? shape;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AppBar(
        backgroundColor: AppColors.primary,
        automaticallyImplyLeading: false,
        leading: showBackButton
            ? IconButton(
                onPressed: () => Get.back(),
                icon: Icon(Icons.arrow_back_ios_new))
            : leadingIcon != null
                ? IconButton(
                    onPressed: () => leadingOnPressed, icon: Icon(leadingIcon))
                : null,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title != null
                ? (title as Text).data.toString()
                : '', // Access title data
            style: TextStyle(
              fontSize: 20,
              color: titleColor ??
                  Colors.white, // Use specified color or default to white
            ),
          ),
        ),
        actions: actions,
        shape: shape,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(size ?? 55.0);
}
