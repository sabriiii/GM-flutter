import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';

class ImportDocumentButton extends StatefulWidget {
  final Function(List<Map<String, String>>) onFilesSelected;
  const ImportDocumentButton({required this.onFilesSelected, Key? key})
      : super(key: key);

  @override
  State<ImportDocumentButton> createState() => _ImportDocumentButtonState();
}

class _ImportDocumentButtonState extends State<ImportDocumentButton> {
  final List<Map<String, String>> _selectedFiles = [];

  Future<void> _pickDocument(BuildContext context) async {
    // Show options to pick a file or take a photo
    final choice = await showModalBottomSheet<String>(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Take a Photo'),
              onTap: () => Navigator.pop(context, 'photo'),
            ),
            ListTile(
              leading: const Icon(Icons.insert_drive_file),
              title: const Text('Pick a PDF or Document'),
              onTap: () => Navigator.pop(context, 'file'),
            ),
          ],
        );
      },
    );

    if (choice == 'photo') {
      // Use ImagePicker to take a photo
      final picker = ImagePicker();
      final XFile? photo = await picker.pickImage(source: ImageSource.camera);

      if (photo != null) {
        final fileBytes = await File(photo.path).readAsBytes();
        final base64String = base64Encode(fileBytes);

        final fileInfo = {
          'type': 'image',
          'name': photo.name,
          'path': photo.path,
          'base64': base64String,
        };

        setState(() {
          _selectedFiles.add(fileInfo);
        });
        widget.onFilesSelected(
            [..._selectedFiles]); // Pass file information to the parent
      }
    } else if (choice == 'file') {
      // Use FilePicker to pick a document
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'png'],
        allowMultiple: true, // Enable multiple file selection
      );

      if (result != null) {
        final files = result.files.map((file) async {
          final fileBytes = await File(file.path!).readAsBytes();
          final base64String = base64Encode(fileBytes);
          return {
            'type': file.extension == 'pdf' ? 'document' : 'image',
            'name': file.name,
            'path': file.path!,
            'base64': base64String,
          };
        });

        final fileInfos = await Future.wait(files);

        setState(() {
          _selectedFiles.addAll(fileInfos);
        });

        widget.onFilesSelected([..._selectedFiles]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: () => _pickDocument(context),
          icon: const Icon(Icons.upload_file, color: Colors.teal),
          label: const Text(
            'Import Document',
            style: TextStyle(color: Colors.teal),
          ),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            backgroundColor: const Color(0xFFE8F3F1),
            side: const BorderSide(color: Color(0xFFE8F3F1)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(height: 16),
        if (_selectedFiles.isNotEmpty)
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _selectedFiles.length,
            itemBuilder: (context, index) {
              final file = _selectedFiles[index];
              final isImage = file['type'] == 'image';
              return ListTile(
                leading: isImage
                    ? Image.file(
                        File(file['path']!), // Display thumbnail for images
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                    : const Icon(Icons.insert_drive_file,
                        color: Colors.teal, size: 50),
                title: Text(
                  file['name']!,
                  style: const TextStyle(fontSize: 16),
                ),
                subtitle: Text(
                  isImage ? 'Image file' : 'Document file',
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      _selectedFiles.removeAt(index); // Remove file from list
                    });
                  },
                ),
              );
            },
          ),
      ],
    );
  }
}
