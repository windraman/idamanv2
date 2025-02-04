import 'package:flutter/material.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:idaman/api/api_service.dart';
import 'package:idaman/components/product_card.dart';
import 'package:idaman/helper/location_service.dart';
import 'package:idaman/models/Location.dart';
import 'package:idaman/models/Product.dart';
import 'package:idaman/size_config.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

List<String> _searchHistory = [];

List<String> filteredSearchHistory = [];

String selectedTerm="";

class Body extends StatefulWidget {
  final String searchString;
  final String keyword;
  const Body({Key? key,required this.searchString, required this.keyword}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Product> produks = [];
  final RefreshController refreshController = RefreshController(initialRefresh: true);
  int currentPage = 1;
  int offset = 10;

  static const historyLength = 5;


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
  void dispose(){
    _floatingSearchBarController.dispose();
        super.dispose();
  }

  FloatingSearchBarController _floatingSearchBarController = FloatingSearchBarController();

  @override
  Widget build(BuildContext context) {
    selectedTerm = widget.keyword;
    addSearchTerm(widget.keyword);
    return Stack(
      fit: StackFit.expand,
      children: [
        SafeArea(
            child: Column(
              children: [
                SizedBox(height: 50),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SmartRefresher(
                      enablePullUp: true,
                      controller: refreshController,
                      onRefresh: () async {
                        final result = await cari(widget.searchString,isRefresh: true);
                        if(result){
                          refreshController.refreshCompleted();
                        }else{
                          refreshController.refreshFailed();
                        }
                      },
                      onLoading: () async{
                        final result = await cari(widget.searchString,isRefresh: false);
                        if(result){
                          refreshController.loadComplete();
                        }else{
                          refreshController.loadFailed();
                        }
                      },
                      child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 300,
                              childAspectRatio: 1/1.5,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                          ),
                          itemCount: produks.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return  ProductCard(
                                product: produks[index],
                              width: getProportionateScreenWidth(150),
                              aspectRetio: 1.02,
                            );
                          }),
                    ),
                  ),
                ),
              ],
            )
        ),
        buildFloatingSearchBar()
      ],
    );
  }

  Widget buildFloatingSearchBar() {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      controller: _floatingSearchBarController ,
      hint: 'Telusuri ... ',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      title: Text(
        selectedTerm.isNotEmpty ? selectedTerm : '',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      onQueryChanged: (query) {
        setState(() {
          filteredSearchHistory = filterSeacrhTerms(filter: query);
          print(query);
        });
      },
      onSubmitted: (query){
        setState(() {
          addSearchTerm(query);
          selectedTerm = query;
          _floatingSearchBarController.close();
          print(query);
          find(query,isRefresh: true);
        });
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.place),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Builder(
              builder: (context){
                if(filteredSearchHistory.isEmpty && _floatingSearchBarController.query.isEmpty){
                  return Text(
                    "Mulai pencarian",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall,
                  );
                }else if(filteredSearchHistory.isEmpty && _floatingSearchBarController.query.isNotEmpty){
                  return ListTile(
                    title: Text(_floatingSearchBarController.query),
                    leading: Icon(Icons.search),
                    onTap: (){
                      setState(() {
                        addSearchTerm(_floatingSearchBarController.query);
                        selectedTerm = _floatingSearchBarController.query;
                        _floatingSearchBarController.close();
                        print(_floatingSearchBarController.query);
                      });
                    },
                  );
                }else{
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: filteredSearchHistory.map(
                            (term) =>  ListTile(
                              title: Text(
                                term,
                                maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                              ),
                              leading: Icon(Icons.history),
                              trailing: IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: (){
                                  setState(() {
                                    deleteSearchTerm(term);
                                  });
                                },
                              ),
                              onTap: (){
                                setState(() {
                                  putSearchTermFirst(term);
                                  selectedTerm = term;
                                });
                                _floatingSearchBarController.close();
                              },
                            )
                    ).toList(),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }

  Future<bool> cari(String query, {bool isRefresh = false}) async {
    if(isRefresh){
      currentPage = 1;
    }
    APIService apiService = new APIService();
    await apiService.findProduk(query,currentPage,offset).then((value) {
      if(currentPage==1) {
        produks = value;
      }else{
        produks.addAll(value);
      }
      if(produks.isNotEmpty){
        currentPage++;
        return true;
      }else{
        return false;
      }
    });
    setState(() {

    });
    return false;
  }

  Future<bool> find(String query, {bool isRefresh = false}) async {
    LocationService ls = new LocationService();
    LocationModel lm = await ls.getCurrentPosition();
    String requery = "nama_produk_jasa=$query&deskripsi_produk=$query&reorder=jarak&user_lat=${lm.longitude}&user_lon=${lm.longitude}";
    if(isRefresh){
      currentPage = 1;
    }
    APIService apiService = new APIService();
    await apiService.findProduk(requery,currentPage,offset).then((value) {
      if(currentPage==1) {
        produks = value;
        print(produks[0].isFavourite);
      }else{
        produks.addAll(value);
      }
      if(produks.isNotEmpty){
        currentPage++;
        return true;
      }else{
        return false;
      }
    });
    setState(() {

    });
    return false;
  }
}
