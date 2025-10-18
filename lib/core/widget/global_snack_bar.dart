import 'package:flutter/material.dart';

enum CustomSnackType { info, success, error, warning }
enum SnackPos { top, bottom }

class GlobalSnackBar {
  static OverlayEntry? _entry;

  /// Show Snackbar (like GetX style)
  static void show(
      BuildContext context, {
        required String title,
        required String message,
        CustomSnackType type = CustomSnackType.info,
        SnackPos position = SnackPos.top,
        Duration duration = const Duration(seconds: 2),
        bool isDismissible = true,
      }) {
    hide(); // remove any old one

    final overlay = Overlay.of(context, rootOverlay: true);
    if (overlay == null) return;

    final media = MediaQuery.of(context);
    final safeTop = media.padding.top;
    final safeBottom = media.padding.bottom;

    final style = _style(type);

    _entry = OverlayEntry(
      builder: (_) {
        final topPos = position == SnackPos.top ? safeTop + 12 : null;
        final bottomPos = position == SnackPos.bottom ? safeBottom + 12 : null;

        return Positioned(
          left: 12,
          right: 12,
          top: topPos,
          bottom: bottomPos,
          child: _SnackCard(
            title: title,
            message: message,
            style: style,
            duration: duration,
            onClose: isDismissible ? hide : null,
          ),
        );
      },
    );

    overlay.insert(_entry!);

    // auto remove after duration
    Future.delayed(duration + const Duration(milliseconds: 200), hide);
  }

  static void hide() {
    _entry?..remove();
    _entry = null;
  }

  static _SnackStyle _style(CustomSnackType type) {
    switch (type) {
      case CustomSnackType.success:
        return _SnackStyle(
          icon: Icons.check_circle_rounded,
          accent: Colors.green.shade700,
        );
      case CustomSnackType.error:
        return _SnackStyle(
          icon: Icons.error_rounded,
          accent: Colors.red.shade700,
        );
      case CustomSnackType.warning:
        return _SnackStyle(
          icon: Icons.warning_amber_rounded,
          accent: Colors.orange.shade700,
        );
      case CustomSnackType.info:
      default:
        return _SnackStyle(
          icon: Icons.info_rounded,
          accent: Colors.blue.shade700,
        );
    }
  }
}

class _SnackStyle {
  final IconData icon;
  final Color accent;
  const _SnackStyle({required this.icon, required this.accent});
}

class _SnackCard extends StatefulWidget {
  const _SnackCard({
    required this.title,
    required this.message,
    required this.style,
    required this.duration,
    this.onClose,
  });

  final String title, message;
  final _SnackStyle style;
  final Duration duration;
  final VoidCallback? onClose;

  @override
  State<_SnackCard> createState() => _SnackCardState();
}

class _SnackCardState extends State<_SnackCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 220),
  )..forward();

  late final Animation<Offset> _slide =
  Tween(begin: const Offset(0, -0.15), end: Offset.zero).animate(
    CurvedAnimation(parent: _c, curve: Curves.easeOutCubic),
  );

  late final Animation<double> _fade =
  CurvedAnimation(parent: _c, curve: Curves.easeOut);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final card = Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 12,
              offset: Offset(0, 5),
            ),
          ],
          border: Border(
            left: BorderSide(color: widget.style.accent, width: 4),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(widget.style.icon, color: widget.style.accent, size: 22),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title,
                      style: const TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      )),
                  const SizedBox(height: 2),
                  Text(widget.message,
                      style: TextStyle(
                        fontSize: 13.5,
                        color: Colors.black87.withOpacity(.8),
                      )),
                ],
              ),
            ),
            if (widget.onClose != null) ...[
              const SizedBox(width: 6),
              InkWell(
                onTap: widget.onClose,
                child: Icon(Icons.close_rounded,
                    color: Colors.black54, size: 20),
              ),
            ]
          ],
        ),
      ),
    );

    return GestureDetector(
      onTap: widget.onClose,
      child: SlideTransition(
        position: _slide,
        child: FadeTransition(opacity: _fade, child: card),
      ),
    );
  }
}
