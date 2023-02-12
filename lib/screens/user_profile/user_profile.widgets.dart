import 'package:flutter/material.dart';

class StyleText extends StatelessWidget {
  const StyleText({
    Key? key,
    required this.Name,
    required this.size,
    required this.weight,
    required this.renk,
  }) : super(key: key);
  final String Name;
  final double size;
  final FontWeight weight;
  final Color renk;
  @override
  Widget build(BuildContext context) {
    return Text(
      Name,
      style: TextStyle(color: renk, fontSize: size, fontWeight: weight),
    );
  }
}

class Stylesizedbox extends StatelessWidget {
  const Stylesizedbox({
    Key? key,
    required this.uzun,
  }) : super(key: key);
  final double uzun;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: uzun,
    );
  }
}

class ProfilItem extends StatelessWidget {
  const ProfilItem({
    super.key,
    required this.iconData,
    required this.text,
    required this.onTap,
  });

  final IconData iconData;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        iconData,
        color: Color(0xFFDA291C),
        size: 21,
      ),
      title: StyleText(
        weight: FontWeight.w300,
        size: 16,
        Name: text,
        renk: Color(0xFF181718),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_sharp,
        size: 21,
        color: Color(0xFF757575),
      ),
    );
  }
}

class ExitlItem extends StatelessWidget {
  const ExitlItem({
    super.key,
    required this.onTap,
    required this.text,
  });
  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(
          Icons.exit_to_app,
          size: 21,
          color: Color(0xFFDA291C),
        ),
        title: StyleText(
          Name: "Çıkış",
          size: 16,
          weight: FontWeight.w300,
          renk: Color(0xFF181718),
        ));
  }
}
