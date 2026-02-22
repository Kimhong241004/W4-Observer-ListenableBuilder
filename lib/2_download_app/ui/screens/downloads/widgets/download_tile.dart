import 'package:flutter/material.dart';
 
import 'download_controler.dart';

class DownloadTile extends StatelessWidget {
  const DownloadTile({super.key, required this.controller});

  final DownloadController controller;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        return GestureDetector(
          onTap: controller.status == DownloadStatus.downloaded ? null : controller.startDownload,
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Resource name
                  Text(
                    controller.ressource.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Progress and size info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Progress text
                            Text(
                              _getProgressText(),
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 8),
                            // Progress bar
                            LinearProgressIndicator(
                              value: controller.status == DownloadStatus.downloading
                                  ? controller.progress
                                  : (controller.status == DownloadStatus.downloaded ? 1.0 : 0.0),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Status icon
                      _getStatusIcon(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _getProgressText() {
    if (controller.status == DownloadStatus.notDownloaded) {
      return "Not downloaded yet";
    } else if (controller.status == DownloadStatus.downloading) {
      int percentage = (controller.progress * 100).toInt();
      int downloaded = ((controller.progress * controller.ressource.size).toInt());
      return "$percentage% completed - ${downloaded}.0 of ${controller.ressource.size}.0 MB";
    } else {
      return "100% completed - ${controller.ressource.size}.0 of ${controller.ressource.size}.0 MB";
    }
  }

  Widget _getStatusIcon() {
    if (controller.status == DownloadStatus.notDownloaded) {
      return const Icon(Icons.download);
    } else if (controller.status == DownloadStatus.downloading) {
      return const Icon(Icons.file_download_outlined);
    } else {
      return const Icon(Icons.folder);
    }
  }
}
