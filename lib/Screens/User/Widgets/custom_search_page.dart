import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/user_manager_provider.dart';
import '../../../Utils/Constants/app_colors.dart';
import '../../../Utils/Constants/app_images.dart';
import '../../../Utils/Constants/app_size.dart';
import '../../../Utils/Constants/app_styles.dart';

class CustomSearchPage extends StatelessWidget {
  const CustomSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserManagerProvider>(
      builder: (context, userManager, _) {
        return Scaffold(
          appBar: AppBar(
            title: buildSearchField(context, userManager),
            actions: buildActions(context, userManager),
          ),
          body: userManager.isSearching
              ? buildResults(context, userManager)
              : buildSuggestions(context, userManager),
        );
      },
    );
  }

  Widget buildSearchField(
      BuildContext context, UserManagerProvider userManager) {
    return TextField(
      controller: userManager.searchController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: userManager.filterOption == 'family'
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
        if (userManager.debounce?.isActive ?? false) {
          userManager.debounce!.cancel();
        }
        userManager.debounce = Timer(const Duration(milliseconds: 500), () {
          if (query.isNotEmpty) {
            userManager.setIsSearching(true);
            userManager.search(query: query);
          } else {
            userManager.setIsSearching(false);
          }
        });
      },
    );
  }

  List<Widget> buildActions(
      BuildContext context, UserManagerProvider userManager) {
    return [
      InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Consumer<UserManagerProvider>(
                builder: (context, userManager, _) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: const Text('ابحث عن أسرة'),
                        leading: Radio<String>(
                          value: 'family',
                          groupValue: userManager.filterOption,
                          onChanged: (value) {
                            userManager.setFilterOption(value!);
                            userManager.searchController.clear();
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('ابحث عن طبق'),
                        leading: Radio<String>(
                          value: 'dish',
                          groupValue: userManager.filterOption,
                          onChanged: (value) {
                            userManager.setFilterOption(value!);
                            userManager.searchController.clear();
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

  Widget buildResults(BuildContext context, UserManagerProvider userManager) {
    if (userManager.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (userManager.searchViewModel == null ||
        userManager.searchViewModel!.items.isEmpty) {
      return const Center(child: Text('لم يتم العثور على نتائج'));
    }

    return ListView.separated(
      itemCount: userManager.searchViewModel!.items.length,
      separatorBuilder: (buildContext, index) {
        return const SizedBox(height: 20);
      },
      itemBuilder: (buildContext, index) {
        final item = userManager.searchViewModel!.items[index];
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

  Widget buildSuggestions(
      BuildContext context, UserManagerProvider userManager) {
    final suggestions = userManager.searchHistory
        .where((word) => word.startsWith(userManager.searchController.text))
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
              userManager.deleteSearchWord(suggestions[index]);
              userManager
                  .setIsSearching(userManager.searchController.text.isNotEmpty);
            },
          ),
          onTap: () {
            userManager.searchController.text = suggestions[index];
            userManager.setIsSearching(true);
          },
        );
      },
    );
  }
}
