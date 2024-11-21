import 'package:flutter/material.dart';

void imagePickerModal(BuildContext context,
    {VoidCallback? onCameraTap, VoidCallback? onGalleryTap}) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        var scheme = Theme.of(context).colorScheme;
        double width = MediaQuery.of(context).size.width;
        double height = MediaQuery.of(context).size.height;
        return Container(
          padding: const EdgeInsets.all(20),
          height: height * 0.75,
          decoration: BoxDecoration(
            color: scheme.primary,
            borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20.0), bottom: Radius.zero),
            border: Border.all(width: 15.0, color: scheme.primary),
            shape: BoxShape.rectangle,
          ),
          child: ListView(
            children: [
              GestureDetector(
                onTap: onCameraTap,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: scheme.primary, width: 5.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt_outlined, color: Colors.redAccent, size: height * 0.15,),
                      Text(
                        "Camera",

                        style: TextStyle(
                            fontWeight: FontWeight.w600,fontSize: 30, color: scheme.outlineVariant),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 35),
              GestureDetector(

                onTap: onGalleryTap,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: scheme.primary, width: 5.0),
                  ),
                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Icon(Icons.photo_library_outlined, color: Colors.redAccent, size: height * 0.15,),
                      const SizedBox(
                        height: 15.0 ,
                      ),
                      Text(
                        "Gallery",
                        style: TextStyle(

                           fontWeight: FontWeight.w600, fontSize: 30, color: scheme.outlineVariant),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      });
}
