import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yardimtakip/model/earthquake_victims_model.dart';

import '../../bloc/eathquake_bloc.dart';

class EarthquakeVictimsListScreen extends StatefulWidget {
  const EarthquakeVictimsListScreen({super.key});

  @override
  State<EarthquakeVictimsListScreen> createState() =>
      _EarthquakeVictimsListScreenState();
}

class _EarthquakeVictimsListScreenState
    extends State<EarthquakeVictimsListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Kaydettiğim Kişiler'),
              Tab(text: 'Tüm Kişiler'),
            ],
          ),
          title: Text('Deprem Mağdurları'),
        ),
        body: BlocBuilder<EathquakeBloc, EathquakeState>(
          builder: (context, state) {
            if (state.status == EathquakeStatus.loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return TabBarView(
              children: [
                UserCardListWidget(
                  earthquakeVictims: state.earthquakeVictims,
                ),
                UserCardListWidget(
                  earthquakeVictims: state.earthquakeVictimsAll,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class UserCardListWidget extends StatelessWidget {
  const UserCardListWidget({
    Key? key,
    required this.earthquakeVictims,
  }) : super(key: key);
  final List<EarthquakeVictims> earthquakeVictims;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<EathquakeBloc>().add(EathquakeLoadEvent());
        },
        child: ListView.builder(
          itemCount: earthquakeVictims.length,
          itemBuilder: (context, index) {
            var earthquakeVictimsItem = earthquakeVictims[index];
            return ListTile(
              title: Text(earthquakeVictimsItem.nameAndSurname),
              subtitle: Text(earthquakeVictimsItem.phoneNumber),
            );
          },
        ),
      ),
    );
  }
}
