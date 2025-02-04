import 'package:flutter/material.dart';

import '../size_config.dart';


class SearchFieldRight extends StatefulWidget {
  final Function() showHistory;
  final Function() findProduct;
  const SearchFieldRight({
    Key? key,
    required this.showHistory,
    required this.findProduct,
  }) : super(key: key);

  @override
  State<SearchFieldRight> createState() => _SearchFieldRightState();
}

class _SearchFieldRightState extends State<SearchFieldRight> {
  static const historyLength = 5;
  List<String> _searchHistory = [
    'sayur',
    'buah',
    'pasar',
    'parak',
    'baru'
  ];

  List<String> filteredSearchHistory = [];

  String selectedTerm="";

  List<String> filterSeacrhTerms({required String filter}){
    if(filter.isNotEmpty){
      return _searchHistory.reversed
          .where((term) => term.startsWith(filter))
          .toList();
    }else{
      return _searchHistory.reversed.toList();
    }
  }

  void addSearchTerm(String term){
    if(_searchHistory.contains(term)){
      putSearchTermFirst(term);
      return;
    }

    _searchHistory.add(term);
    if(_searchHistory.length > historyLength){
      _searchHistory.removeRange(0, _searchHistory.length-historyLength);
    }

    filteredSearchHistory = filterSeacrhTerms(filter: "");
  }

  void deleteSearchTerm(String term){
    _searchHistory.removeWhere((t) => t == term);
    filteredSearchHistory = filterSeacrhTerms(filter: "");
  }

  void putSearchTermFirst(String term){
    deleteSearchTerm(term);
    addSearchTerm(term);
  }

  @override
  void initState() {
    filteredSearchHistory = filterSeacrhTerms(filter: "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value){
        widget.showHistory;
      },
      onSubmitted: (value){
        widget.findProduct;
      },
      decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: "Cari ...",
          suffixIcon: Icon(Icons.search),
          contentPadding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
              vertical: getProportionateScreenHeight(9)
          )
      ),
    );
  }
}


