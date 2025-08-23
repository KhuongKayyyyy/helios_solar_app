// import 'dart:io';

// import 'package:drag_select_grid_view/drag_select_grid_view.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:get/get.dart' hide Trans;
// import 'package:photo_gallery/photo_gallery.dart';
// import 'package:transparent_image/transparent_image.dart';
// import 'package:video_player/video_player.dart';

// import '../../constants/ColorConstants.dart';
// import '../../constants/ImageConstants.dart';
// import 'AppButton.dart';

// class GalleryBottomSheet extends StatefulWidget {
//   ScrollController? controller;
//   Function(List<Medium>) onTapSend;
//   int limitCnt;
//   String sendText;
//   bool onlyImage;
//   GalleryBottomSheet(
//       {super.key,
//       this.controller,
//       required this.onTapSend,
//       this.limitCnt = 10,
//       this.sendText = "",
//       this.onlyImage = false});

//   @override
//   State<GalleryBottomSheet> createState() => _GalleryBottomSheet();
// }

// class _GalleryBottomSheet extends State<GalleryBottomSheet> {
//   final List<Medium> _media = [];
//   late Album album;

//   late Future albumFuture;

//   final gridController = DragSelectGridViewController();
//   final Set<int> selectedIndexes = <int>{};
//   final key = GlobalKey();
//   int? startTarget;
//   bool isStart = false;
//   final Set<int> _trackTaped = <int>{};

//   int page = 0;
//   bool isLast = false;
//   bool isLoading = false;

//   _detectTapedItem(PointerEvent event) {
//     if (!isStart || getSelectedCount() >= widget.limitCnt) {
//       return;
//     }
//     final RenderBox box = key.currentContext!.findRenderObject()! as RenderBox;
//     final result = BoxHitTestResult();
//     Offset local = box.globalToLocal(event.position);
//     if (box.hitTest(result, position: local)) {
//       for (final hit in result.path) {
//         /// temporary variable so that the [is] allows access of [index]
//         final target = hit.target;
//         print(target);
//         if (target is _MediaItem) {
//           if (_trackTaped.isNotEmpty &&
//               _trackTaped.first != target.index! &&
//               _trackTaped.last != target.index!) startTarget ??= target.index!;
//           _trackTaped.clear();
//           if (startTarget! < target.index!) {
//             for (int i = startTarget!; i <= target.index!; i++) {
//               if (!selectedIndexes.contains(i)) {
//                 if (getSelectedCount() < widget.limitCnt) {
//                   _trackTaped.add(i);
//                 } else {
//                   break;
//                 }
//               }
//             }
//           } else if (startTarget! > target.index!) {
//             for (int i = target.index!; i <= startTarget!; i++) {
//               if (!selectedIndexes.contains(i)) {
//                 if (getSelectedCount() < widget.limitCnt) {
//                   _trackTaped.add(i);
//                 } else {
//                   break;
//                 }
//               }
//             }
//           } else {
//             _trackTaped.add(target.index!);
//           }
//           _selectIndex();
//         }
//       }
//     }
//   }

//   _selectIndex() {
//     setState(() {});
//   }

//   int getSelectedCount() {
//     Set<int> tempSet = <int>{};
//     tempSet.addAll(selectedIndexes);
//     tempSet.addAll(_trackTaped);
//     return tempSet.length;
//   }

//   void _clearSelection(PointerUpEvent event) {
//     selectedIndexes.addAll(_trackTaped);
//     _trackTaped.clear();
//     setState(() {
//       isStart = false;
//       startTarget = null;
//     });
//   }

//   @override
//   void initState() {
//     albumFuture = initAsync();
//     super.initState();
//     gridController.addListener(scheduleRebuild);
//     widget.controller?.addListener(getNextPhotos);
//   }

//   @override
//   void dispose() {
//     gridController.removeListener(scheduleRebuild);
//     widget.controller?.removeListener(getNextPhotos);
//     super.dispose();
//   }

//   void scheduleRebuild() => setState(() {});

//   Future<List<Medium>> initAsync() async {
//     List<Album> albums = await PhotoGallery.listAlbums();
//     int maxAlbumCnt = 0;
//     int maxAlbumindex = 0;
//     for (int i = 0; i < albums.length; i++) {
//       if (albums[i].count > maxAlbumCnt) {
//         maxAlbumindex = i;
//         maxAlbumCnt = albums[i].count;
//       }
//     }
//     album = albums[maxAlbumindex];
//     MediaPage mediaPage = await album.listMedia(take: 30);
//     isLast = mediaPage.isLast;
//     page = 1;
//     if (widget.onlyImage) {
//       for (int i = 0; i < mediaPage.items.length; i++) {
//         if (mediaPage.items[i].mediumType == MediumType.image) {
//           _media.add(mediaPage.items[i]);
//         }
//       }
//     } else {
//       _media.addAll(mediaPage.items);
//     }
//     return _media;
//   }

//   Future<void> getNextPhotos() async {
//     if (!isLoading && (widget.controller?.position.extentAfter ?? 201) < 200) {
//       isLoading = true;
//       MediaPage mediaPage = await album.listMedia(skip: 30 * page, take: 30);
//       page += 1;
//       setState(() {
//         if (widget.onlyImage) {
//           for (int i = 0; i < mediaPage.items.length; i++) {
//             if (mediaPage.items[i].mediumType == MediumType.image) {
//               _media.add(mediaPage.items[i]);
//             }
//           }
//         } else {
//           _media.addAll(mediaPage.items);
//         }
//       });
//       isLast = mediaPage.isLast;
//       isLoading = false;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         decoration: BoxDecoration(
//             color: ColorConstants.white,
//             borderRadius: const BorderRadius.only(
//                 topRight: Radius.circular(24), topLeft: Radius.circular(24))),
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 15,
//             ),
//             Center(
//               child: Container(
//                 width: 48,
//                 height: 6,
//                 decoration: BoxDecoration(
//                     color: ColorConstants.colorc8,
//                     borderRadius: BorderRadius.circular(4)),
//               ),
//             ),
//             const SizedBox(height: 15),
//             Expanded(
//                 child: FutureBuilder(
//               future: albumFuture,
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   return Container(
//                       margin: const EdgeInsets.only(left: 10, right: 10),
//                       child: Listener(
//                         onPointerDown: _detectTapedItem,
//                         onPointerMove: _detectTapedItem,
//                         onPointerUp: _clearSelection,
//                         child: GridView.builder(
//                             controller: widget.controller,
//                             key: key,
//                             physics: isStart
//                                 ? const NeverScrollableScrollPhysics()
//                                 : null,
//                             gridDelegate:
//                                 const SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 3,
//                               childAspectRatio: 1.0,
//                               crossAxisSpacing: 5.0,
//                               mainAxisSpacing: 5.0,
//                             ),
//                             itemCount: _media.length,
//                             itemBuilder: (context, index) {
//                               return MediaItem(
//                                 index: index,
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     if (selectedIndexes.contains(index)) {
//                                       selectedIndexes.remove(index);
//                                     } else {
//                                       if (selectedIndexes.length <
//                                           widget.limitCnt) {
//                                         selectedIndexes.add(index);
//                                       }
//                                     }
//                                   },
//                                   onLongPressStart: (details) {
//                                     setState(() {
//                                       isStart = true;
//                                       startTarget = index;
//                                     });
//                                   },
//                                   child: Container(
//                                       color: ColorConstants.colorf0,
//                                       child: Stack(
//                                         children: [
//                                           Center(
//                                               child: SizedBox(
//                                             width: double.maxFinite,
//                                             height: double.maxFinite,
//                                             child: FadeInImage(
//                                               fit: BoxFit.cover,
//                                               placeholder: MemoryImage(
//                                                   kTransparentImage),
//                                               image: ThumbnailProvider(
//                                                 mediumId: _media[index].id,
//                                                 mediumType:
//                                                     _media[index].mediumType,
//                                                 highQuality: true,
//                                               ),
//                                             ),
//                                           )),
//                                           Positioned(
//                                               top: 5,
//                                               left: 5,
//                                               child: InkWell(
//                                                 onTap: () {
//                                                   if (selectedIndexes
//                                                       .contains(index)) {
//                                                     selectedIndexes
//                                                         .remove(index);
//                                                   } else {
//                                                     if (selectedIndexes.length <
//                                                         widget.limitCnt) {
//                                                       selectedIndexes
//                                                           .add(index);
//                                                     }
//                                                   }
//                                                 },
//                                                 child: Image.asset(
//                                                   selectedIndexes.contains(
//                                                               index) ||
//                                                           _trackTaped
//                                                               .contains(index)
//                                                       ? "${iconPath}ic_checked.png"
//                                                       : "${iconPath}ic_unchecked.png",
//                                                   width: 24,
//                                                   height: 24,
//                                                 ),
//                                               ))
//                                         ],
//                                       )),
//                                 ),
//                               );
//                             }),
//                       ));
//                 }

//                 return Center(
//                   child: SizedBox(
//                     height: 10.0,
//                     width: 10.0,
//                     child: Center(
//                         child: CircularProgressIndicator(
//                             color: ColorConstants.appColor)),
//                   ),
//                 );
//               },
//             )),
//             const SizedBox(
//               height: 15,
//             ),
//             if (getSelectedCount() != 0)
//               AppButton(
//                   text: widget.sendText.isEmpty
//                       ? "${getSelectedCount()} 보내기"
//                       : widget.sendText,
//                   disabled: getSelectedCount() == 0,
//                   color: ColorConstants.appColor,
//                   onTap: () {
//                     List<Medium> results = [];
//                     for (int i = 0; i < selectedIndexes.length; i++) {
//                       results.add(_media[selectedIndexes.elementAt(i)]);
//                     }
//                     widget.onTapSend(results);
//                     Get.back();
//                   }),
//             SizedBox(height: MediaQuery.of(context).padding.bottom + 15),
//           ],
//         ));
//   }
// }

// class MediaItem extends SingleChildRenderObjectWidget {
//   final int index;

//   const MediaItem({super.child, required this.index, super.key});

//   @override
//   _MediaItem createRenderObject(BuildContext context) {
//     return _MediaItem()..index = index;
//   }

//   @override
//   void updateRenderObject(BuildContext context, _MediaItem renderObject) {
//     renderObject.index = index;
//   }
// }

// class _MediaItem extends RenderProxyBox {
//   int? index;
// }

// class ViewerPage extends StatelessWidget {
//   final Medium medium;

//   const ViewerPage(Medium medium, {super.key}) : medium = medium;

//   @override
//   Widget build(BuildContext context) {
//     DateTime? date = medium.creationDate ?? medium.modifiedDate;
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//             onPressed: () => Navigator.of(context).pop(),
//             icon: const Icon(Icons.arrow_back_ios),
//           ),
//           title: date != null ? Text(date.toLocal().toString()) : null,
//         ),
//         body: Container(
//           alignment: Alignment.center,
//           child: medium.mediumType == MediumType.image
//               ? GestureDetector(
//                   onTap: () async {
//                     PhotoGallery.deleteMedium(mediumId: medium.id);
//                   },
//                   child: FadeInImage(
//                     fit: BoxFit.cover,
//                     placeholder: MemoryImage(kTransparentImage),
//                     image: PhotoProvider(mediumId: medium.id),
//                   ),
//                 )
//               : VideoProvider(
//                   mediumId: medium.id,
//                 ),
//         ),
//       ),
//     );
//   }
// }

// class VideoProvider extends StatefulWidget {
//   final String mediumId;

//   const VideoProvider({
//     super.key,
//     required this.mediumId,
//   });

//   @override
//   _VideoProviderState createState() => _VideoProviderState();
// }

// class _VideoProviderState extends State<VideoProvider> {
//   VideoPlayerController? _controller;
//   File? _file;

//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       initAsync();
//     });
//     super.initState();
//   }

//   Future<void> initAsync() async {
//     try {
//       _file = await PhotoGallery.getFile(mediumId: widget.mediumId);
//       _controller = VideoPlayerController.file(_file!);
//       _controller?.initialize().then((_) {
//         // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
//         setState(() {});
//       });
//     } catch (e) {
//       print("Failed : $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _controller == null || !_controller!.value.isInitialized
//         ? Container()
//         : Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               AspectRatio(
//                 aspectRatio: _controller!.value.aspectRatio,
//                 child: VideoPlayer(_controller!),
//               ),
//               TextButton(
//                 onPressed: () {
//                   setState(() {
//                     _controller!.value.isPlaying
//                         ? _controller!.pause()
//                         : _controller!.play();
//                   });
//                 },
//                 child: Icon(
//                   _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
//                 ),
//               ),
//             ],
//           );
//   }
// }
