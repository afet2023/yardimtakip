var inventories = {
  'Tekstil Malzemeleri': [
    'Mont',
    'Ceket',
    'Kazak',
    'Çorap',
    'Pantolon',
    'Ayakkabı',
    'İç Çamaşırı'
  ],
  'Hijyen Malzemeleri': [
    'Bebek Bezi',
    'Islak Mendil',
    'Bebek Maması',
    'Tuvalet Kağıdı',
    'Diş Macunu',
    'Diş Fırçası',
  ],
  'Diğer İhtiyaçlar': [
    'Battaniye',
    'Yastık',
    'Temel Gıda',
    'Atıştırmalık',
  ]
};
/* 
 var data = inventories.map((key, value) {
            return MapEntry(
                key,
                InventoryCategoryModel(
                    id: const Uuid().v4(),
                    name: key.toString(),
                    inventoryItems: value
                        .map((e) => InventoryItemModel(
                            id: Uuid().v4(), name: e, description: e))
                        .toList(),
                    createdAt: DateTime.now().toString(),
                    updatedAt: DateTime.now().toString()));
          });
          data.forEach((key, value) {
            context.read<INetworkRepository>().addCategoryInventory(value);
          }); */