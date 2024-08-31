import 'package:flutter/material.dart';
import 'package:water_tracker_app/presentation/models/water_tracker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final TextEditingController _glassNumTEController = TextEditingController(text: '1');

  List<WaterTracker> waterTrackerList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.blueAccent,
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildWaterTrackerCounter(),
              const SizedBox(height: 25),
              Expanded(
                child: Container(
                  color: Colors.blueAccent,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )
                    ),
                    child: _buildWaterTrackerListView(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWaterTrackerCounter() {
    return Column(
      children: [
        const Text(
          'Water Tracker',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          getTotalGlassCounter().toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          'Glass/s',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 50,
              child: TextField(
                controller: _glassNumTEController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 15),
            GestureDetector(
              onTap: _onTapAddWaterTracker,
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Add',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWaterTrackerListView() {
    return Expanded(
      child: ListView.separated(
        itemCount: waterTrackerList.length,
        itemBuilder: (context, index) {
          return _buildWaterTrackListTile(index);
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
      ),
    );
  }

  Widget _buildWaterTrackListTile(int index) {
    final WaterTracker waterTracker = waterTrackerList[index];
    return ListTile(
      title: Text('${waterTracker.dateTime.hour}:${waterTracker.dateTime.minute}'),
      subtitle: Text('${waterTracker.dateTime.day}/${waterTracker.dateTime.month}/${waterTracker.dateTime.year}'),
      leading: CircleAvatar(
        child: Text('${waterTracker.numOfGlass}'),
      ),
      trailing: IconButton(
        onPressed: () => _onTapDeleteButton(index),
        icon: const Icon(Icons.delete),
      ),
    );
  }

  int getTotalGlassCounter() {
    int counter = 0;
    for (WaterTracker t in waterTrackerList) {
      counter += t.numOfGlass;
    }
    return counter;
  }

  void _onTapAddWaterTracker() {
    if (_glassNumTEController.text.isEmpty){
      _glassNumTEController.text = '1';
    }
    final int numOfGlass = int.tryParse(_glassNumTEController.text) ?? 1;
    WaterTracker waterTracker = WaterTracker(numOfGlass: numOfGlass, dateTime: DateTime.now());
    waterTrackerList.add(waterTracker);
    setState(() {});
  }

  void _onTapDeleteButton(int index) {
    waterTrackerList.removeAt(index);
    setState(() {});
  }

  @override
  void dispose() {
    _glassNumTEController.dispose();
    super.dispose();
  }
}
