part of base;

class TopBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final Color? backgroundColor;

  const TopBarWidget({super.key, required this.text, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? primaryColor,
      title: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Size get preferredSize {
    return const Size(double.infinity, 60);
  }
}
