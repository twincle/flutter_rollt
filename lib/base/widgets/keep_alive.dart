part of base;

class KeepAliveWidget extends StatefulWidget {
  const KeepAliveWidget(
      {super.key, required this.child, this.keepAlive = true});

  final Widget? child;
  final bool keepAlive;

  @override
  State<KeepAliveWidget> createState() => _KeepAliveWidgetState();
}

class _KeepAliveWidgetState extends State<KeepAliveWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => widget.keepAlive;

  @override
  void didUpdateWidget(covariant KeepAliveWidget oldWidget) {
    if (oldWidget.keepAlive != widget.keepAlive) {
      updateKeepAlive();

      super.didUpdateWidget(oldWidget);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return widget.child!;
  }
}
