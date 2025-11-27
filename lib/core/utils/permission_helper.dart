import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static Future<bool> requestCameraPermission(BuildContext context) async {
    final status = await Permission.camera.request();
    
    if (status.isDenied) {
      if (context.mounted) {
        _showPermissionDeniedDialog(
          context,
          'Camera Permission Required',
          'Please allow camera access to take photos of meals.',
        );
      }
      return false;
    }
    
    if (status.isPermanentlyDenied) {
      if (context.mounted) {
        _showSettingsDialog(context);
      }
      return false;
    }
    
    return status.isGranted;
  }
  
  static Future<bool> requestStoragePermission(BuildContext context) async {
    final status = await Permission.storage.request();
    
    if (status.isDenied) {
      if (context.mounted) {
        _showPermissionDeniedDialog(
          context,
          'Storage Permission Required',
          'Please allow storage access to select photos.',
        );
      }
      return false;
    }
    
    if (status.isPermanentlyDenied) {
      if (context.mounted) {
        _showSettingsDialog(context);
      }
      return false;
    }
    
    return status.isGranted;
  }
  
  static Future<bool> requestPhotosPermission(BuildContext context) async {
    final status = await Permission.photos.request();
    
    if (status.isDenied) {
      if (context.mounted) {
        _showPermissionDeniedDialog(
          context,
          'Photos Permission Required',
          'Please allow access to your photos.',
        );
      }
      return false;
    }
    
    if (status.isPermanentlyDenied) {
      if (context.mounted) {
        _showSettingsDialog(context);
      }
      return false;
    }
    
    return status.isGranted;
  }
  
  static void _showPermissionDeniedDialog(
    BuildContext context,
    String title,
    String message,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
  
  static void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Permission Required'),
        content: const Text(
          'This permission was permanently denied. '
          'Please enable it in Settings.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              openAppSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }
}
