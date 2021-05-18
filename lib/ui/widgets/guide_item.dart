
import 'package:flutter/material.dart';

class GuideWidget extends StatelessWidget {
  String name;
  String imageUrl;
  String id;
  GuideWidget(this.id, this.name, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(this.imageUrl),
            ),
          ),
          Text(this.name, overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold)
          ),
        ],
      ),
    );
  }
}
