import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/search_provider.dart';
import '../../../Utils/Constants/app_colors.dart';
import '../../../Utils/Constants/app_images.dart';
import '../../../Utils/Constants/app_size.dart';
import '../../../Utils/Constants/app_styles.dart';

class CustomSearchPage extends StatelessWidget {
  const CustomSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (context, searchManager, _) {
        return Scaffold(
          appBar: AppBar(
            title: buildSearchField(context, searchManager),
            actions: buildActions(context, searchManager),
          ),
          body: searchManager.isSearching
              ? buildResults(context, searchManager)
              : buildSuggestions(context, searchManager),
        );
      },
    );
  }

  Widget buildSearchField(
    BuildContext context,
    SearchProvider searchManager,
  ) {
    return TextField(
      controller: searchManager.searchController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: searchManager.filterOption == 'family'
            ? 'ابحث عن اسم أسرة'
            : 'ابحث عن اسم طبق',
        border: InputBorder.none,
        prefixIcon: Icon(
          Icons.search,
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white70
              : Colors.black54,
        ),
      ),
      onSubmitted: (query) {
        if (searchManager.debounce?.isActive ?? false) {
          searchManager.debounce!.cancel();
        }
        searchManager.debounce = Timer(const Duration(milliseconds: 500), () {
          if (query.isNotEmpty) {
            searchManager.setIsSearching(true);
            searchManager.search(query: query);
          } else {
            searchManager.setIsSearching(false);
          }
        });
      },
    );
  }

  List<Widget> buildActions(
    BuildContext context,
    SearchProvider searchManager,
  ) {
    return [
      InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Consumer<SearchProvider>(
                builder: (context, searchManager, _) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: const Text('ابحث عن أسرة'),
                        leading: Radio<String>(
                          value: 'family',
                          groupValue: searchManager.filterOption,
                          onChanged: (value) {
                            searchManager.setFilterOption(value!);
                            searchManager.searchController.clear();
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('ابحث عن طبق'),
                        leading: Radio<String>(
                          value: 'dish',
                          groupValue: searchManager.filterOption,
                          onChanged: (value) {
                            searchManager.setFilterOption(value!);
                            searchManager.searchController.clear();
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
        child: Container(
          width: AppSize.widthSize(50, context),
          height: AppSize.heightSize(40, context),
          padding: EdgeInsets.all(AppSize.widthSize(9, context)),
          margin: EdgeInsets.only(left: AppSize.widthSize(5, context)),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Image.asset(AppImages.filtreIcon),
        ),
      ),
    ];
  }

  Widget buildResults(BuildContext context, SearchProvider searchManager) {
    if (searchManager.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (searchManager.searchViewModel == null ||
        searchManager.searchViewModel!.items.isEmpty) {
      return const Center(child: Text('لم يتم العثور على نتائج'));
    }

    return ListView.separated(
      itemCount: searchManager.searchViewModel!.items.length,
      separatorBuilder: (buildContext, index) {
        return const SizedBox(height: 20);
      },
      itemBuilder: (buildContext, index) {
        final item = searchManager.searchViewModel!.items[index];
        return ListTile(
          title: Text(item.itemName!),
          subtitle: Text(item.description!),
          onTap: () {
            // Handle item tap
          },
        );
      },
    );
  }

  Widget buildSuggestions(BuildContext context, SearchProvider searchManager) {
    final suggestions = searchManager.searchHistory
        .where((word) => word.startsWith(searchManager.searchController.text))
        .toList()
        .reversed
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            suggestions[index],
            style: AppStyles.styleRegular(12, context),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.clear,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () {
              searchManager.deleteSearchWord(suggestions[index]);
              searchManager.setIsSearching(
                  searchManager.searchController.text.isNotEmpty);
            },
          ),
          onTap: () {
            searchManager.searchController.text = suggestions[index];
            searchManager.setIsSearching(true);
          },
        );
      },
    );
  }
}
