import 'package:flutter/material.dart';

class StyleText extends StatelessWidget {
  const StyleText({
    Key? key,
    required this.Name,
  }) : super(key: key);
  final String Name;
  @override
  Widget build(BuildContext context) {
    return Text(
      Name,
      style: TextStyle(color: Colors.black),
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
      ),
      title: StyleText(
        Name: text,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_sharp,
        size: 20,
      ),
    );
  }
}
