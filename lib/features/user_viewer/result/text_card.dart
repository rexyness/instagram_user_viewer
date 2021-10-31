import 'package:flutter/material.dart';
import 'package:instagram_user_viewer/core/constants.dart';

class TextCard extends StatelessWidget {
  const TextCard({Key? key, required this.title, required this.desc}) : super(key: key);
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        margin: const EdgeInsets.all(kBorderRadius),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadowColor: Colors.blueGrey,
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            isThreeLine: true,
            autofocus: true,
            
            leading: const Icon(Icons.accessibility_new_outlined, color: Colors.white, size: 45),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
             
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: kListItemSpacing,)
              ],
            ),
            subtitle: Text(
              desc.isNotEmpty ? desc : 'NO BIO HAS BEEN SET FOR THIS USER',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white ,),
            ),
          ),
        ),
      ),
    );
  }
}
