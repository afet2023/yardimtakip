import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:yardimtakip/model/inventory_category_model.dart';

import '../../bloc/inventory_bloc.dart';

class EntryInventoryScreen extends StatefulWidget {
  const EntryInventoryScreen({super.key});

  @override
  State<EntryInventoryScreen> createState() => _EntryInventoryScreenState();
}

class _EntryInventoryScreenState extends State<EntryInventoryScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<InventoryBloc>(context).add(InventoryLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: RawChip(
          label: Text('Listeyi Sıfırla'),
          backgroundColor: context.colorScheme.surface,
          avatar: Icon(Icons.refresh, color: context.colorScheme.onSurface),
          onPressed: () {
            BlocProvider.of<InventoryBloc>(context).add(InventoryLoadEvent());
          },
        ),
        actions: [
          RawChip(
            label: Text('Kaydet'),
            backgroundColor: context.colorScheme.surface,
            avatar: Icon(Icons.save, color: context.colorScheme.onSurface),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<InventoryBloc, InventoryState>(
        builder: (context, state) {
          if (state is InventoryInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is InventoryLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is InventoryLoaded) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.inventoryCategories.length,
              itemBuilder: (context, index) {
                return InventoryCategoryWidget(
                  category: state.inventoryCategories[index],
                );
              },
            );
          } else if (state is InventoryError) {
            return const Center(
              child: Text('Error'),
            );
          } else {
            return const Center(
              child: Text('Error'),
            );
          }
        },
      ),
    );
  }
}

class InventoryCategoryWidget extends StatelessWidget {
  const InventoryCategoryWidget({
    Key? key,
    required this.category,
  }) : super(key: key);
  final InventoryCategoryModel category;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(category.name,
              style: context.textTheme.headline6!.copyWith(
                  color: context.colorScheme.primary,
                  fontWeight: FontWeight.w400)),
        ),
        Divider(
          height: 1,
          thickness: 2,
          color: context.colorScheme.primary,
        ),
        SizedBox(
          height: category.inventoryItems.length * 58.0,
          child: ListView.separated(
              shrinkWrap: true,
              itemCount: category.inventoryItems.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text(category.inventoryItems[index].name),
                    trailing: StatefulBuilder(
                      builder: (context, setQuantityState) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                if (category.inventoryItems[index].quantity >
                                    0) {
                                  category.inventoryItems[index].quantity--;
                                }
                                setQuantityState(() {});
                              },
                              icon: const Icon(Icons.remove),
                            ),
                            Text(
                                category.inventoryItems[index].quantity
                                    .toString(),
                                style: context.textTheme.headline6!.copyWith(
                                    color: context.colorScheme.primary,
                                    fontWeight: FontWeight.w400)),
                            IconButton(
                              onPressed: () {
                                category.inventoryItems[index].quantity++;
                                setQuantityState(() {});
                              },
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        );
                      },
                    ));
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 1,
                  thickness: 0.2,
                  color: Colors.black,
                );
              }),
        )
      ],
    );
  }
}
