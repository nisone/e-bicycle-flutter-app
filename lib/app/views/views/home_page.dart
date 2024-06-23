import 'package:bike_rental/app/controllers/app_controller.dart';
import 'package:bike_rental/app/models/bike_model.dart';
import 'package:bike_rental/app/models/station_model.dart';
import 'package:bike_rental/app/routes/app_pages.dart';
import 'package:bike_rental/app/services/remote_services.dart';
import 'package:bike_rental/app/views/views/bikes_list_item.dart';
import 'package:bike_rental/app/views/views/helper.dart';
import 'package:bike_rental/app/views/views/station_list_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final Rx<List<BikeModel>> bikes = Rx<List<BikeModel>>([]);
  final Rx<String> currentStation = Rx<String>('');

  Future<List<StationModel>> getStations() async {
    dynamic response = await RemoteServices().getStations();
    if (response != null) {
      List<dynamic> stationsRaw = response['data'] as List<dynamic>;
      return stationsRaw
          .map((station) => StationModel.fromMap(station))
          .toList();
    } else {
      return [];
    }
  }

  Stream<List<StationModel>> getStationStream() async* {
    while (true) {
      yield await getStations();
      await Future.delayed(const Duration(seconds: 60)); // Adjust as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppController app = Get.find<AppController>();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.black54,
            width: Get.width,
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/branding.png',
              height: 50,
            ),
          ),
          UIHelperViews.vSpaceMedium,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Welcome ${app.me.value?.name ?? ''}',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Opacity(
                        opacity: .7,
                        child: Text(
                          'find your bike',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.WALLET);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.wallet_rounded,
                        size: 50,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      UIHelperViews.hSpaceMedium,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ObxValue(
                              (me) => Text(
                                    '${me.value?.wallet.balance ?? 0.00}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                  ),
                              app.me),
                          Text('BALANCE',
                              style: Theme.of(context).textTheme.labelSmall),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 14,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'STATIONS',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            height: 200,
            child: StreamBuilder(
                stream: getStationStream(),
                builder: (context, AsyncSnapshot<List<StationModel>> snapshot) {
                  if (snapshot.hasData) {
                    List<StationModel> stations = snapshot.data!;

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: stations.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, int index) {
                        StationModel st = stations[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: InkWell(
                              onTap: () {
                                currentStation(st.name);
                                bikes.value = st.bikes;
                              },
                              child: StationListCard(station: st)),
                        );
                      },
                      itemExtent: 300,
                    );
                  }

                  if (snapshot.hasError) {
                    return Text('Stream snapshot error: ${snapshot.error}');
                  }

                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: ObxValue((data) {
                return Chip(
                  deleteIcon: const Icon(Icons.clear_rounded),
                  onDeleted: () => currentStation(''),
                  side: BorderSide.none,
                  label: Text(
                    data.value.toUpperCase(),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                );
              }, currentStation),
            ),
          ),
          UIHelperViews.vSpaceMedium,
          ObxValue((data) {
            return Column(
              children: [
                ...data.value.map(
                  (d) => Container(
                    alignment: Alignment.centerLeft,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                    child: BikesListItem(
                      bike: d,
                    ),
                  ),
                ),
              ],
            );
          }, bikes),
          ObxValue(
              (data) => Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                        '${currentStation.value.isEmpty ? 'Select station to view' : '${bikes.value.length}'} bikes available'),
                  ),
              currentStation),
        ],
      ),
    );
  }
}
