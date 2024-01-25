import 'package:flutter/material.dart';
import 'package:inso_chat/component/assets/colors.dart';

class roundButton extends StatefulWidget {
  String? hint;
  var onTap;
  bool loading;
  IconData? icon;
  roundButton({
    super.key,
    this.icon,
    required this.hint,
    required this.onTap,
    this.loading = false,
  });

  @override
  State<roundButton> createState() => _roundButtonState();
}

class _roundButtonState extends State<roundButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Clr.primaryButton,
        ),
        child: widget.loading == true
            ? const CircularProgressIndicator()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.icon == null
                      ? Text(
                          widget.hint.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        )
                      : Row(
                          children: [
                            Icon(
                              widget.icon,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.hint.toString(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                          ],
                        )
                ],
              ),
      ),
    );
  }
}
