import 'dart:async';

import 'package:datn/models/place_model.dart';
import 'package:datn/providers/app_state.dart';
import 'package:datn/services/log_service.dart';
import 'package:datn/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum SearchBarStatus {
  searching,
  done,
  idle,
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  static const String id = "search_screen";

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  SearchBarStatus _status = SearchBarStatus.idle;
  List<PlaceModel> _result = [];
  Timer? _debounceTimner;

  void _onTextFieldChange(String? value) {
    if(_debounceTimner?.isActive ?? false) _debounceTimner?.cancel();
    if(value == null || value.trim().isEmpty) {
      setState(() {
        _status = SearchBarStatus.idle;
      });
    }
    _debounceTimner = Timer(
        const Duration(milliseconds: 500), 
        () {
          print("searching");
          _searchPlace(value);
        }
      );
  }
  
  Future _searchPlace(String? value) async {
    setState(() {
      _status = SearchBarStatus.searching;
    });
    _result = await StorageService.searchPlaceByKeyWord(value?.trim());
    Logger.log(_result);
    setState(() {
      _status = SearchBarStatus.done;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _debounceTimner?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 10, 10, 10),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () =>  Navigator.of(context).pop(),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.arrow_back,
                        size: 25,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Hero(
                      tag: "search",
                      child: Material(
                        color: Colors.transparent,
                        child: TextField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                            ),
                            hintText: "Nhập địa điểm cần tìm",
                            border: OutlineInputBorder(
                            )
                          ),
                          onChanged: (value) {
                            _onTextFieldChange(value);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Builder(
                  builder: (ctx) {
                    if(_status == SearchBarStatus.idle) {
                      return const SizedBox();
                    }
                    if(_status == SearchBarStatus.searching) return const Center(child: CircularProgressIndicator(),);
                    return ListView.builder(
                      itemCount: _result.length,
                      // shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            _result[index].name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            _result[index].address,
                          ),
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            context.read<AppState>().sortedType = null;
                            Future.delayed(const Duration(milliseconds: 500), () {
                              Navigator.of(context).pop(_result[index].latLong);
                            });
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    
    );
  }
}