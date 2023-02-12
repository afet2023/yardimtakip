import 'package:firebase_database/firebase_database.dart';
import 'package:yardimtakip/model/earthquake_victims_model.dart';
import 'package:yardimtakip/model/inventory_category_model.dart';
import 'package:yardimtakip/model/inventory_item.dart';
import 'package:yardimtakip/model/volunteer_model.dart';

import '../model/form_model.dart';

abstract class INetworkRepository {
  Future<void> createNewVolunteer(VolunteerModel volunteerModel);
  Future<List<VolunteerModel>> getAllVolunteers();
  Future<VolunteerModel?> getVolunteerById(String volunteerId);
  Future<bool> isVolunteerExist(String volunteerId);
  Future<bool> verifiedVolunteer(String volunteerId);

  Future<void> addCategoryInventory(InventoryCategoryModel categoryModel);
  Future<List<InventoryCategoryModel>> getAllInventoryCategories();
  Future<List<InventoryItemModel>> getAllInventories();
  Future<void> addForm(FormModel formModel);
  Future<void> addEarthquakeVictims(EarthquakeVictims earthquakeVictims);

  Future<List<FormModel>> getAllFormFilledByVolunteerId(String volunteerId);
}

class FirebaseRepository implements INetworkRepository {
  final FirebaseDatabase firebaseDatabase;

  FirebaseRepository(this.firebaseDatabase);
  @override
  Future<void> addForm(FormModel formModel) async {
    return await firebaseDatabase
        .ref()
        .child('forms')
        .push()
        .set(formModel.toMap());
  }

  @override
  Future<void> createNewVolunteer(VolunteerModel volunteerModel) {
    return firebaseDatabase
        .ref()
        .child('volunteers')
        .push()
        .set(volunteerModel.toMap());
  }

  @override
  Future<List<InventoryItemModel>> getAllInventories() async {
    var inventories = <InventoryItemModel>[];
    var databaseEvent =
        await firebaseDatabase.ref().child("inventories").once();
    if (databaseEvent.snapshot.value == null) return inventories;
    var data = databaseEvent.snapshot.value as Map;
    data.forEach((key, value) {
      inventories.add(InventoryItemModel.fromMap(value));
    });

    return inventories;
  }

  @override
  Future<List<VolunteerModel>> getAllVolunteers() async {
    var volunteers = <VolunteerModel>[];
    var databaseEvent = await firebaseDatabase.ref().child("volunteers").once();
    if (databaseEvent.snapshot.value == null) {
      return volunteers;
    }
    var data = databaseEvent.snapshot.value as Map;
    data.forEach((key, value) {
      volunteers.add(VolunteerModel.fromMap(value));
    });
    return volunteers;
  }

  @override
  Future<List<FormModel>> getAllFormFilledByVolunteerId(
      String volunteerId) async {
    var forms = <FormModel>[];
    var databaseEvent = await firebaseDatabase
        .ref()
        .child('forms')
        .orderByChild('voluntaryId')
        .equalTo(volunteerId)
        .once();
    if (databaseEvent.snapshot.value == null) {
      return forms;
    }
    var data = databaseEvent.snapshot.value as Map;
    data.forEach((key, value) {
      forms.add(FormModel.fromMap(value));
    });
    return forms;
  }

  @override
  Future<VolunteerModel?> getVolunteerById(String volunteerId) async {
    var databaseEvent = await firebaseDatabase
        .ref()
        .child('volunteers')
        .orderByChild('id')
        .equalTo(volunteerId)
        .once();
    if (databaseEvent.snapshot.value == null) return null;

    var data = databaseEvent.snapshot.value as Map;
    return VolunteerModel.fromMap(data);
  }

  @override
  Future<bool> isVolunteerExist(String volunteerId) {
    // TODO: implement isVolunteerExist
    throw UnimplementedError();
  }

  @override
  Future<bool> verifiedVolunteer(String volunteerId) {
    // TODO: implement verifiedVolunteer
    throw UnimplementedError();
  }

  @override
  Future<void> addCategoryInventory(InventoryCategoryModel categoryModel) {
    return firebaseDatabase
        .ref()
        .child('inventoryCategories')
        .push()
        .set(categoryModel.toMap());
  }

  @override
  Future<List<InventoryCategoryModel>> getAllInventoryCategories() async {
    var categories = <InventoryCategoryModel>[];
    var databaseEvent =
        await firebaseDatabase.ref().child("inventoryCategories").once();
    if (databaseEvent.snapshot.value == null) return categories;
    var data = databaseEvent.snapshot.value as Map;
    data.forEach((key, value) {
      categories.add(InventoryCategoryModel.fromMap(value));
    });
    return categories;
  }

  @override
  Future<void> addEarthquakeVictims(EarthquakeVictims earthquakeVictims) {
    return firebaseDatabase
        .ref()
        .child('earthquakeVictims')
        .push()
        .set(earthquakeVictims.toMap());
  }
}
