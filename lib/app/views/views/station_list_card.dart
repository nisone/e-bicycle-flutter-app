import 'package:bike_rental/app/models/station_model.dart';
import 'package:flutter/material.dart';

class StationListCard extends StatelessWidget {
  const StationListCard({super.key, required this.station});

  final StationModel station;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minWidth: 360,
            minHeight: 200,
            maxHeight: MediaQuery.sizeOf(context).height / 3),
        child: Stack(
          children: [
            Center(
              child: Image.network(
                station.imageUrl,
                fit: BoxFit.cover,
                alignment: Alignment.center,
                loadingBuilder: (context, child, loadingProgress) {
                  return child;
                },
                errorBuilder: (context, error, stackTrace) {
                  print(error);
                  return Image.asset(
                    'assets/images/bike_parking.png',
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            Positioned(
              top: 4,
              right: 4,
              child: Badge.count(
                count: station.bikesCount,
              ),
            ),
            Container(
              color: Colors.white10,
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(8),
                height: 60,
                width: MediaQuery.sizeOf(context).width,
                decoration: const BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      station.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      station.address,
                      style: const TextStyle(fontSize: 10),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
