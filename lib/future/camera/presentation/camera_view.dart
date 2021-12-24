import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:whats_app_clone/core/lib/custom_widgets.dart';
import 'package:whats_app_clone/future/camera/presentation/pages/preview/preview_view.dart';

import '../../../main.dart';

class CameraView extends StatefulWidget {
  const CameraView({Key? key}) : super(key: key);

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> with WidgetsBindingObserver {
  VideoPlayerController? videoController;
  CameraController? controller;
  File? _imageFile;
  File? _videoFile;
  List<File> allFileList = [];

  bool _isCameraInitialized = false,
      _isVideoCameraSelected = false,
      _isRecordingInProgress = false,
      _isVideoRecordingPaused = false,
      _isLight = false,
      _isRearCameraSelected = true;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;
  double _currentZoomLevel = 1.0;
  double _minAvailableExposureOffset = 0.0;
  double _maxAvailableExposureOffset = 0.0;
  double _currentExposureOffset = 0.0;
  FlashMode? _currentFlashMode;

  Future<void> _startVideoPlayer() async {
    if (_videoFile != null) {
      videoController = VideoPlayerController.file(_videoFile!);
      await videoController!.initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized,
        // even before the play button has been pressed.
        setState(() {});
      });
      await videoController!.setLooping(true);
      await videoController!.play();
    }
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = controller;
    // Instantiating the camera controller
    final CameraController cameraController = CameraController(
        cameraDescription, ResolutionPreset.max,
        imageFormatGroup: ImageFormatGroup.jpeg, enableAudio: true);

    // Dispose the previous controller
    await previousCameraController?.dispose();

    // Replace with the new controller
    if (mounted) {
      setState(() {
        controller = cameraController;
      });
    }

    // Update UI if controller updated
    cameraController.addListener(() {
      if (mounted) setState(() {});
    });

    try {
      await cameraController.initialize();
      await Future.wait([
        cameraController
            .getMinExposureOffset()
            .then((value) => _minAvailableExposureOffset = value),
        cameraController
            .getMaxExposureOffset()
            .then((value) => _maxAvailableExposureOffset = value),
        cameraController
            .getMaxZoomLevel()
            .then((value) => _maxAvailableZoom = value),
        cameraController
            .getMinZoomLevel()
            .then((value) => _minAvailableZoom = value),
      ]);

      _currentFlashMode = controller!.value.flashMode;
    } on CameraException catch (e) {
      print('Error initializing camera: $e');
    }

    // Update the Boolean
    if (mounted) {
      setState(() {
        _isCameraInitialized = controller!.value.isInitialized;
      });
    }
  }

  Future<XFile?> takePicture() async {
    final CameraController? cameraController = controller;
    if (cameraController!.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      print("is Taking Picture");
      return null;
    }
    try {
      XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      print('Error occured while taking picture: $e');
      return null;
    }
  }

  void flashAction() async {
    switch (_currentFlashMode) {
      case FlashMode.off:
        setState(() => _currentFlashMode = FlashMode.auto);
        await controller!.setFlashMode(
          FlashMode.auto,
        );
        return;
      case FlashMode.auto:
        setState(() => _currentFlashMode = FlashMode.always);
        await controller!.setFlashMode(
          FlashMode.always,
        );
        return;
      case FlashMode.always:
        setState(() => _currentFlashMode = FlashMode.torch);
        await controller!.setFlashMode(
          FlashMode.torch,
        );
        return;

      case FlashMode.torch:
        setState(() => _currentFlashMode = FlashMode.off);
        await controller!.setFlashMode(
          FlashMode.off,
        );
        return;

      default:
        return;
    }
  }

  Widget flashIcon() {
    switch (_currentFlashMode) {
      case FlashMode.off:
        return Icon(Icons.flash_off, color: const Color(0xFFeeeeee));
      case FlashMode.auto:
        return Icon(Icons.flash_auto, color: const Color(0xFFeeeeee));
      case FlashMode.always:
        return Icon(Icons.flash_on, color: const Color(0xFFeeeeee));
      case FlashMode.torch:
        return Icon(Icons.highlight, color: const Color(0xFFeeeeee));
      default:
        return Icon(Icons.flash_off, color: const Color(0xFFeeeeee));
    }
  }

  Future<void> startVideoRecording() async {
    final CameraController? cameraController = controller;
    if (controller!.value.isRecordingVideo) {
      // A recording has already started, do nothing.
      return;
    }
    try {
      await cameraController!.startVideoRecording();
      setState(() {
        _isRecordingInProgress = true;
        print(_isRecordingInProgress);
      });
    } on CameraException catch (e) {
      print('Error starting to record video: $e');
    }
  }

  Future<XFile?> stopVideoRecording() async {
    if (!controller!.value.isRecordingVideo) {
      // Recording is already is stopped state
      return null;
    }
    try {
      XFile file = await controller!.stopVideoRecording();
      setState(() {
        _isRecordingInProgress = false;
        print(_isRecordingInProgress);
      });
      return file;
    } on CameraException catch (e) {
      print('Error stopping video recording: $e');
      return null;
    }
  }

  Future<void> pauseVideoRecording() async {
    if (!controller!.value.isRecordingVideo) {
      // Video recording is not in progress
      return;
    }
    try {
      setState(() {
        _isVideoRecordingPaused = true;
      });
      await controller!.pauseVideoRecording();
    } on CameraException catch (e) {
      print('Error pausing video recording: $e');
    }
  }

  Future<void> resumeVideoRecording() async {
    if (!controller!.value.isRecordingVideo) {
      // No video recording was in progress
      return;
    }
    try {
      setState(() {
        _isVideoRecordingPaused = false;
      });
      await controller!.resumeVideoRecording();
    } on CameraException catch (e) {
      print('Error resuming video recording: $e');
    }
  }

  refreshAlreadyCapturedImages() async {
    // Get the directory
    final directory = await getApplicationDocumentsDirectory();
    List<FileSystemEntity> fileList = await directory.list().toList();
    allFileList.clear();

    List<Map<int, dynamic>> fileNames = [];

    // Searching for all the image and video files using
    // their default format, and storing them
    fileList.forEach((file) {
      if (file.path.contains('.jpg') || file.path.contains('.mp4')) {
        allFileList.add(File(file.path));

        String name = file.path.split('/').last.split('.').first;
        fileNames.add({0: int.parse(name), 1: file.path.split('/').last});
      }
    });

    // Retrieving the recent file
    if (fileNames.isNotEmpty) {
      final recentFile =
          fileNames.reduce((curr, next) => curr[0] > next[0] ? curr : next);
      String recentFileName = recentFile[1];
      // Checking whether it is an image or a video file
      if (recentFileName.contains('.mp4')) {
        _videoFile = File('${directory.path}/$recentFileName');
        _startVideoPlayer();
      } else {
        _imageFile = File('${directory.path}/$recentFileName');
      }

      setState(() {});
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      onNewCameraSelected(cameraController.description);
    }
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);

    onNewCameraSelected(cameras[0]);
    refreshAlreadyCapturedImages();
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isCameraInitialized
          ? Column(children: [
              AspectRatio(
                aspectRatio: Get.width / Get.height,
                child: Stack(children: [
                  GestureDetector(
                    child: controller!.buildPreview(),
                    onTap: () {
                      setState(() {
                        _isLight = true;
                      });
                    },
                  ),
                  InkWell(
                      onTap: () {
                        print(_imageFile != null || _videoFile != null);
                        if (_imageFile != null || _videoFile != null)
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PreviewView(
                              imageFile: _imageFile!,
                              fileList: allFileList,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Colors.white, width: 2),
                          image: _imageFile != null
                              ? DecorationImage(
                            image: FileImage(_imageFile!),
                            fit: BoxFit.cover,
                          )
                              : null,
                        ),
                        child: videoController != null &&
                            videoController!.value.isInitialized
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: AspectRatio(
                            aspectRatio:
                            videoController!.value.aspectRatio,
                            child: VideoPlayer(videoController!),
                          ),
                        )
                            : Container(),
                      )),
                  // Positioned(
                  //     top: Get.height * 0.05,
                  //     left: Get.width * 0.08,
                  //     child: ),
                  _isLight
                      ? Align(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    _currentExposureOffset.toStringAsFixed(1) +
                                        'x',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                              RotatedBox(
                                quarterTurns: 3,
                                child: Container(
                                  height: 100,
                                  width: 400,
                                  child: Slider(
                                    value: _currentExposureOffset,
                                    min: _minAvailableExposureOffset,
                                    max: _maxAvailableExposureOffset,
                                    activeColor: Colors.white,
                                    inactiveColor: Colors.white30,
                                    onChanged: (value) async {
                                      setState(() {
                                        _currentExposureOffset = value;
                                        Future.delayed(Duration(seconds: 5),
                                            () {
                                          setState(() {
                                            _isLight = false;
                                          });
                                        });
                                      });
                                      await controller!
                                          .setExposureOffset(value);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          alignment: Alignment.topRight,
                        )
                      : Container(),
                  Positioned(
                    bottom: Get.height * .15,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                            width: Get.height * .42,
                            child: Slider(
                              value: _currentZoomLevel,
                              min: _minAvailableZoom,
                              max: _maxAvailableZoom,
                              activeColor: Colors.white,
                              inactiveColor: Colors.white30,
                              onChanged: (value) async {
                                setState(() {
                                  _currentZoomLevel = value;
                                });
                                await controller!.setZoomLevel(value);
                              },
                            )),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _currentZoomLevel.toStringAsFixed(1) + 'x',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      width: Get.width,
                      bottom: Get.height * .05,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                              onTap: flashAction,
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child:
                                  flashIcon() //Icon(Icons.flash_off,color: const Color(0xFFeeeeee),),
                              ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              setState(() {
                                _isVideoCameraSelected = false;
                              });
                              XFile? rawImage = await takePicture();
                              File imageFile = File(rawImage!.path);

                              // rawImage.saveTo(rawImage.path);

                              int currentUnix =
                                  DateTime.now().millisecondsSinceEpoch;
                              final directory =
                                  await getApplicationDocumentsDirectory();
                              String fileFormat =
                                  imageFile.path.split('.').last;

                              await imageFile.copy(
                                '${directory.path}/$currentUnix.$fileFormat',
                              );
                            },
                            onDoubleTap: () async {
                              if (_isVideoRecordingPaused)
                                await resumeVideoRecording();
                              else
                                await pauseVideoRecording();
                            },
                            onLongPress: () async {
                              if (_isRecordingInProgress) {
                                await stopVideoRecording();
                              }
                              if (!_isVideoCameraSelected) {
                                await startVideoRecording();

                                setState(() {
                                  _isVideoCameraSelected = true;
                                });
                              }
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    const BoxShadow(
                                        color: const Color(0xFFeeeeee),
                                        offset: Offset.zero,
                                        blurRadius: 5.0,
                                        spreadRadius: 1.0)
                                  ],
                                  borderRadius: BorderRadius.circular(500),
                                  color: Color(0xffcccccc),
                                  border: Border.all(
                                      color: (_isVideoCameraSelected &&
                                              _isRecordingInProgress)
                                          ? Colors.redAccent.withOpacity(.5)
                                          : Color(0xffdddddd).withOpacity(.5),
                                      width: 5)),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              setState(() {
                                _isCameraInitialized = false;
                              });
                              onNewCameraSelected(
                                cameras[_isRearCameraSelected ? 0 : 1],
                              );
                              setState(() {
                                _isRearCameraSelected = !_isRearCameraSelected;
                              });
                            },
                            child: Icon(
                              Icons.flip_camera_android,
                              color: !_isRearCameraSelected
                                  ? colorSecondary
                                  : const Color(0xFFeeeeee),
                            ),
                          ),
                        ],
                      ))
                ]),
              )
            ])
          : Center(
              child: Text(
                'LOADING',
                style: TextStyle(color: Colors.white),
              ),
            ),
    );
  }
}
