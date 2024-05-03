import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http_with_flutter/models/all_products_model.dart';
import 'package:http_with_flutter/services/http_service.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

import '../services/storage_service.dart';
import 'found_data.dart';


class Search extends StatefulWidget {
  final void Function()? back;
  const Search({this.back, super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<String> history = List<String>.from(jsonDecode(StorageService.get(StorageKey.history) ?? '[]').map((e) => e.toString()));

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if(widget.back != null) widget.back!();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          surfaceTintColor: Colors.white,
          actions: [
            const SizedBox(width: 20),
            InkWell(
              onTap: (){
                if(!StorageService.searchResult){
                  startListening();
                }
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: .26,
                      spreadRadius: level * 1.5,
                      color: Colors.black.withOpacity(.05)
                    )
                  ],
                  color: Colors.deepPurple.withOpacity(0.15),
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                ),
                child: const Icon(Icons.mic),
              ),
            ),
            // GestureDetector(
            //   onTap: widget.back,
            //   child: Container(
            //     width: 48,
            //     height: 48,
            //     padding: const EdgeInsets.all(10),
            //     decoration: BoxDecoration(
            //       color: Colors.deepPurple.withOpacity(0.15),
            //       borderRadius: BorderRadius.circular(15),
            //     ),
            //     // ignore: deprecated_member_use
            //     child: SvgPicture.asset('assets/icons/back.svg', color: const Color(0xff818898)),
            //   ),
            // ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                onTap: () => setState(() => StorageService.searchResult = false),
                onSubmitted: (text) {
                  if(text.trim().isEmpty) return;
                  StorageService.searchResult = true;
                  setState((){});
                },
                onEditingComplete: () {
                  if(_controller.text.trim().isNotEmpty){
                    _focusNode.unfocus();
                  }
                },
                onChanged: (text) => search,
                autofocus: !StorageService.searchResult,
                controller: _controller,
                focusNode: _focusNode,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.deepPurple.withOpacity(0.15),
                  prefixIcon: const Icon(Icons.search, color: Color(0xff818898)),
                  suffixIcon: InkWell(
                    onTap: () {
                      _controller.clear();
                      StorageService.searchResult = false;
                      search;
                      _focusNode.requestFocus();
                      setState(() {});
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Transform.scale(
                      scale: 0.65,
                      // ignore: deprecated_member_use
                      child: SvgPicture.asset('assets/icons/clear.svg', color: const Color(0xff818898))
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  hintText: 'Qidiruv...',
                  hintStyle: const TextStyle(color: Color(0xff818898), fontSize: 16, fontWeight: FontWeight.w400),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15)
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20)
          ],
        ),
        body: StorageService.searchResult ? FutureBuilder(
          future: searching(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: LoadingAnimationWidget.threeRotatingDots(color: Colors.blue, size: 50));
            } else if(snapshot.hasData){
              return snapshot.data ?? const Center(child: Text('Nimadir xato ketdi', style: TextStyle(color: Colors.red)));
            } else {
              return const Center(child: Text('Nimadir xato ketdi', style: TextStyle(color: Colors.red)));
            }
          },
        ) : ListView.builder(
          itemCount: history.length,
          itemBuilder: (context, index) {
            return SizedBox(
              height: 40,
              child: ListTile(
                onTap: () {
                  _controller.text = history[index];
                  _focusNode.unfocus();
                  StorageService.searchResult = true;
                  setState(() {});
                },
                onLongPress: (){
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      contentPadding: const EdgeInsets.only(top: 15, left: 10, right: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Ushbu element o'chirilsinmi?",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: (){
                                  history.removeAt(index);
                                  StorageService.storage(StorageKey.history, jsonEncode(history));
                                  setState(() {});
                                  Navigator.pop(context);
                                },
                                child: const Text("O'chirilsin",
                                  style: TextStyle(
                                    color: Color(0xffCE4342),
                                    fontWeight: FontWeight.bold
                                  )
                                ),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Bekor qilish",
                                  style: TextStyle(
                                    color: Color(0xff5793C3),
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
                leading: SvgPicture.asset('assets/icons/history.svg'),
                title: Text(history[index], maxLines: 1, overflow: TextOverflow.ellipsis),
                trailing: IconButton(
                  onPressed: () {
                    _controller.text = history[index];
                    search;
                  },
                  icon: SvgPicture.asset('assets/icons/arrow-up-left.svg', width: 20, height: 20),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    initSpeechState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  get search {
    history = List<String>
        .from(jsonDecode(StorageService.get(StorageKey.history) ?? '[]')
        .map((e) => e
        .toString()))
        .where((element) => element
        .toLowerCase()
        .contains(_controller.text.trim()
        .toLowerCase()))
        .toList();
    setState(() {});
  }

  Future<Widget> searching() async {
    history = List<String>.from(jsonDecode(StorageService.get(StorageKey.history) ?? '[]').map((e) => e.toString()));
    if(history.contains(_controller.text.trim())) history.remove(_controller.text.trim());
    history.insert(0, _controller.text.trim());

    if(history.length > 30){
      List<String> list = history.sublist(history.length - 30, history.length);
      history = list;
    }

    StorageService.storage(StorageKey.history, jsonEncode(history));

    String? result = await NetworkService.getDate(
      api: _controller.text.trim().toLowerCase() == 'all products'
          ? NetworkService.apiAllProducts
          : NetworkService.apiSearchProducts,
      param: NetworkService.searchParam(_controller.text.trim())
    );

    if(result != null){
      AllProductsModel allProductsModel = AllProductsModel.fromJson(json.decode(result));

      if(allProductsModel.products.isEmpty){
        return const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.not_interested, color: Colors.red, size: 30),
              SizedBox(height: 10),
              Text("Not Found", style: TextStyle(color: Colors.grey, fontSize: 20))
            ],
          ),
        );
      }

      return FoundData(allProductsModel: allProductsModel);
    }
    return const Center(child: Text('Nimadir xato ketdi', style: TextStyle(color: Colors.red)));
  }



  /// speech to text

  bool _hasSpeech = false;
  final bool _logEvents = false;
  final bool _onDevice = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = '';
  String lastStatus = '';
  String _currentLocaleId = 'en_US';
  final SpeechToText speech = SpeechToText();

  Future<void> initSpeechState() async {
    try {
      var hasSpeech = await speech.initialize(
        onStatus: statusListener,
        debugLogging: _logEvents,
      );
      if (hasSpeech) _currentLocaleId = 'en_US';
      setState(() => _hasSpeech = hasSpeech);
    } catch (e) {
      setState(() => _hasSpeech = false);
    }
  }

  void startListening() {
    lastWords = '';
    _controller.text = '';
    final pauseFor = int.tryParse('3');
    final listenFor = int.tryParse('30');
    final options = SpeechListenOptions(
        onDevice: _onDevice,
        listenMode: ListenMode.confirmation,
        cancelOnError: true,
        partialResults: true,
        autoPunctuation: true,
        enableHapticFeedback: true
    );

    speech.listen(
      onResult: resultListener,
      listenFor: Duration(seconds: listenFor ?? 30),
      pauseFor: Duration(seconds: pauseFor ?? 3),
      localeId: _currentLocaleId,
      onSoundLevelChange: soundLevelListener,
      listenOptions: options,
    );
    setState(() {});
  }

  void resultListener(SpeechRecognitionResult result) {
    lastWords = result.recognizedWords;
    _controller.text = result.recognizedWords;
    setState(() {});
  }

  void statusListener(String status) {
    lastStatus = status;

    if(lastStatus == 'listening'){
      _focusNode.unfocus();
    }

    if(lastStatus == 'done' && _controller.text.trim().isNotEmpty){
      _focusNode.unfocus();
      StorageService.searchResult = true;
    }

    setState((){});
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    setState(() => this.level = level);
  }
}
