import 'dart:async';

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

  Future<List<EarthquakeVictims>> getAllEarthquakeVictims();
  Future<List<EarthquakeVictims>> getAllEarthquakeVictimsById(String id);

  Future<FormModel?> getFormsByEarthquakeId(String id);

  Future<String?> checkIdentities(List<String> identityNumber);
  Future<bool> isEarthquakeVictimSavedBefore(String id);
  bool hasBeenFiveDaysSinceTheVictimGetsLastHelp(EarthquakeVictims earthquakeVictims);
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

  @override
  Future<List<EarthquakeVictims>> getAllEarthquakeVictims() async {
    var victims = <EarthquakeVictims>[];
    var databaseEvent =
        await firebaseDatabase.ref().child("earthquakeVictims").once();
    if (databaseEvent.snapshot.value == null) return victims;

    var data = databaseEvent.snapshot.value as Map;

    data.forEach((key, value) {
      victims.add(EarthquakeVictims.fromMap(value));
    });
    return victims;
  }

  @override
  Future<List<EarthquakeVictims>> getAllEarthquakeVictimsById(String id) async {
    var victims = <EarthquakeVictims>[];
    var databaseEvent = await firebaseDatabase
        .ref()
        .child("earthquakeVictims")
        .orderByChild('createdByVolunteerId')
        .equalTo(id)
        .once();
    if (databaseEvent.snapshot.value == null) return victims;

    var data = databaseEvent.snapshot.value as Map;

    for (var key in data.values) {
      victims.add(EarthquakeVictims.fromMap(key));
    }
    return victims;
  }

  @override
  Future<FormModel?> getFormsByEarthquakeId(String id) async {
    var databaseEvent = await firebaseDatabase
        .ref()
        .child("forms")
        .orderByChild('earthquakeVictimsId')
        .equalTo(id)
        .once();
    if (databaseEvent.snapshot.value == null) return null;

    var data = databaseEvent.snapshot.value as Map;
    return FormModel.fromMap(data.values.first);
  }

  @override
  Future<String?> checkIdentities(List<String> identityNumber) async {
    var clearList =
        identityNumber.where((element) => element.isNotEmpty).toList();
    for (var id in clearList) {
      //earthquakeVictims içindeki familyIds listesinin içinde bulunup bulunmadığını kontrol et
      var databaseEvent = await firebaseDatabase
          .ref()
          .child("earthquakeVictims")
          .orderByChild('familyIds')
          .equalTo(id)
          .once();

      if (databaseEvent.snapshot.value != null) {
        return id;
      }
      if (databaseEvent.snapshot.value == null) continue;
      var data = databaseEvent.snapshot.value as Map;
      var earthquakeVictims = EarthquakeVictims.fromMap(data.values.first);
      if (DateTime.parse(earthquakeVictims.createdAt)
          .isAfter(DateTime.now().subtract(Duration(days: 5)))) {
        return earthquakeVictims.id;
      }
    }
  }

  @override
  Future<bool> isEarthquakeVictimSavedBefore(String id) async {
    var result = await firebaseDatabase.ref().child("earthquakeVictims").orderByChild('earthquakeVictimsId').equalTo(id).once();
    if(result.snapshot.value == null) return false;
    return true;
  }

  @override 
  bool hasBeenFiveDaysSinceTheVictimGetsLastHelp(EarthquakeVictims earthquakeVictims) {
    var lastHelpDate = DateTime.parse(earthquakeVictims.createdAt);
    var currentDate = DateTime.now();
    var resultAsDay = currentDate.difference(lastHelpDate).inDays;
    return resultAsDay == 5;
  }


}
