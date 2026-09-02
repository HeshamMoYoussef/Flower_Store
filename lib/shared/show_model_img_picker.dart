import 'package:flower_app/provider/registered_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

showModel({context, setState}) {
  final registeredProvider = Provider.of<RegisteredUserProvider>(
    context,
    listen: false,
  );
  return showModalBottomSheet(
    backgroundColor: Colors.grey,
    context: context,
    builder: (BuildContext context) {
      debugPrint('Inside showModel');
      return SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                debugPrint("showModel to select img");

                await registeredProvider.uploadImage2Screen(
                  setState: setState,
                  imageSource: ImageSource.camera,
                );
                debugPrint("showModel to select img done");
                if (context.mounted) Navigator.pop(context);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera, size: 30),
                  SizedBox(width: 15),
                  Text("Camera", style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                await registeredProvider.uploadImage2Screen(
                  setState: setState,
                  imageSource: ImageSource.gallery,
                );
                if (context.mounted) Navigator.pop(context);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.photo_outlined, size: 30),
                  SizedBox(width: 15),
                  Text("Gallery", style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
