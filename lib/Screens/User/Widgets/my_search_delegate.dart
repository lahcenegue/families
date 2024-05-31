import 'package:families/Utils/Constants/app_images.dart';
import 'package:families/Utils/Constants/app_size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Providers/user_manager_provider.dart';
import '../../../Utils/Constants/app_colors.dart';

class MySearchDelegate extends SearchDelegate {
  String filterOption = 'family';

  @override
  String get searchFieldLabel {
    return filterOption == 'family' ? 'ابحث عن اسم أسرة' : 'ابحث عن اسم طبق';
  }

  @override
  TextInputType get keyboardType => TextInputType.text;

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: const Icon(Icons.clear),
        ),
        InkWell(
          onTap: () {
            // Show filter options
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
                            groupValue: filterOption,
                            onChanged: (value) {
                              userManager.setFilterOption(value!);
                              filterOption = value;
                              Navigator.pop(context);
                              query = '';
                              showSuggestions(context);
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('ابحث عن طبق'),
                          leading: Radio<String>(
                            value: 'dish',
                            groupValue: filterOption,
                            onChanged: (value) {
                              userManager.setFilterOption(value!);
                              filterOption = value;
                              Navigator.pop(context);
                              query = '';
                              showSuggestions(context);
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

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () => close(context, null),
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
      );

  @override
  Widget buildResults(BuildContext context) {
    final userManager =
        Provider.of<UserManagerProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: FutureBuilder(
        future: userManager.search(query: query),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('حدث خطأ'));
          } else {
            return Consumer<UserManagerProvider>(
              builder: (context, userManager, child) {
                if (userManager.searchViewModel == null ||
                    userManager.searchViewModel!.items.isEmpty) {
                  return const Center(child: Text('لم يتم العثور على نتائج'));
                } else {
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
              },
            );
          }
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final userManager =
        Provider.of<UserManagerProvider>(context, listen: false);

    final suggestions = userManager.searchHistory
        .where((word) => word.startsWith(query))
        .toList()
        .reversed
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          trailing: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              userManager.deleteSearchWord(suggestions[index]);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showSuggestions(context);
              });
            },
          ),
          onTap: () {
            query = suggestions[index];
            showResults(context);
          },
        );
      },
    );
  }
}
