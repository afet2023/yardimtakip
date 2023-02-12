import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:yardimtakip/model/inventory_item.dart';
import 'package:yardimtakip/repository/network_repository.dart';

import '../../model/form_model.dart';
import '../../model/inventory_model.dart';
import '../../model/volunteer_model.dart';

class HomeScreen extends StatelessWidget {
  INetworkRepository networkRepository =
      FirebaseRepository(FirebaseDatabase.instance);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          /*   await networkRepository.addInventory(InventoryItemModel(
              id: const Uuid().v4(), name: 'name', description: 'description'));
          await networkRepository.createNewVolunteer(VolunteerModel.fake());

          await networkRepository.addForm(FormModel.fake());
 */
          var inventories = await networkRepository.getAllInventories();

          var volunteers = await networkRepository.getAllVolunteers();
          /* log(volunteers.toString());
          log(inventories.toString()); */

          var forms = await networkRepository
              .getAllFormFilledByVolunteerId('voluntaryId');
          log(forms.toString());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
