import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yardimtakip/bloc/eathquake_bloc.dart';

import '../../model/earthquake_victims_model.dart';

class EarthquakeVictimsDetailScreen extends StatefulWidget {
  final EarthquakeVictims earthquakeVictims;

  const EarthquakeVictimsDetailScreen(
      {super.key, required this.earthquakeVictims});

  @override
  State<EarthquakeVictimsDetailScreen> createState() =>
      _EarthquakeVictimsDetailScreenState();
}

class _EarthquakeVictimsDetailScreenState
    extends State<EarthquakeVictimsDetailScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<EathquakeBloc>()
        .add(EathquakeLoadDetailEvent(widget.earthquakeVictims.id));
  }

  @override
  void dispose() {
    context.read<EathquakeBloc>().add(EathquakeClearDetailEvent());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<EathquakeBloc>().add(EathquakeClearDetailEvent());
        },
        child: Icon(Icons.delete),
      ),
      appBar: AppBar(
        title: Text(widget.earthquakeVictims.nameAndSurname),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.earthquakeVictims.nameAndSurname,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              widget.earthquakeVictims.city,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              widget.earthquakeVictims.phoneNumber,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            BlocBuilder<EathquakeBloc, EathquakeState>(
              builder: (context, state) {
                if (state.formModel == null)
                  return Center(child: CircularProgressIndicator());
                return Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      var inventory = state.formModel!.inventories[index];
                      return ListTile(
                        title: Text(inventory.name),
                        subtitle: Text(inventory.quantity.toString()),
                      );
                    },
                    itemCount: state.formModel!.inventories.length,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
