import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

import '../models/band.dart';
import '../services/socket_service.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    // Band(id: '1', name: 'Metallica', votes: 5),
    // Band(id: '2', name: 'Scorpion', votes: 2),
    // Band(id: '3', name: 'Queen', votes: 3),
    // Band(id: '3', name: 'Bon Jovi', votes: 4),
  ];

  @override
  void initState() {
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.on('active-bands', _handleActiveBands);
    super.initState();
  }

  _handleActiveBands(dynamic payload) {
    bands = (payload as List).map((band) => Band.fromMap(band)).toList();
    setState(() {});
  }

  @override
  void dispose() {
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.off('active-bands');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: const Text(
          'BandNames',
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: (socketService.serverStatus == ServerStatus.Online)
                ? Icon(Icons.check_circle, color: Colors.blue[300])
                : Icon(Icons.offline_bolt, color: Colors.red[300]),
          )
        ],
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          (bands.isNotEmpty)
              ? _showGraph()
              : const Text(
                  'No hay bandas',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
          Expanded(
            child: ListView.builder(
              itemCount: bands.length,
              itemBuilder: (context, i) => _bandTitle(bands[i]),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewBand,
        elevation: 1,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _bandTitle(
      // int index
      Band band) {
    final socketService = Provider.of<SocketService>(context, listen: false);

    return Dismissible(
        key: Key(band.id),
        direction: DismissDirection.startToEnd,
        onDismissed: (_) =>
            // print('Direction:$direction');
            socketService.socket.emit('delete-band', {
              'id': band.id,
            }),
        background: Container(
          padding: const EdgeInsets.only(left: 8.0),
          color: Colors.red,
          child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Delete Band',
                style: TextStyle(color: Colors.white),
              )),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue[200],
            child: Text(band.name!.substring(0, 2)),
          ),
          title: Text(band.name!),
          trailing: Text(
            '${band.votes!}',
            style: const TextStyle(fontSize: 20),
          ),
          onTap: () =>
              //print(band.id)
              socketService.socket.emit('vote-band', {'id': band.id}),
        ));
  }

  addNewBand() {
    final textController = TextEditingController();
    if (Platform.isAndroid) {
      return showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: const Text('New Band Name:'),
                content: TextField(
                  controller: textController,
                ),
                actions: [
                  MaterialButton(
                      textColor: Colors.blue,
                      elevation: 5,
                      onPressed: () => addBandToList(textController.text),
                      child: const Text('Add'))
                ],
              ));
    } else {
      showCupertinoDialog(
          context: context,
          builder: (_) => CupertinoAlertDialog(
                title: const Text('New Band Name:'),
                content: CupertinoTextField(controller: textController),
                actions: [
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    onPressed: () => addBandToList(textController.text),
                    child: const Text('Add'),
                  ),
                  CupertinoDialogAction(
                    isDestructiveAction: true,
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Dismiss'),
                  )
                ],
              ));
    }
  }

  void addBandToList(String name) {
    if (name.length > 1) {
      //bands.add(Band(id: DateTime.now().toString(), name: name, votes: 0));
      // setState(() {});
      final socketService = Provider.of<SocketService>(context, listen: false);
      socketService.socket.emit('add-band', {'name': name});
    }
    Navigator.pop(context);
  }

  // Mostrar gráfica
  Widget _showGraph() {
    Map<String, double> dataMap = new Map();
    // dataMap.putIfAbsent('Flutter', () => 5);
    bands.forEach((band) {
      dataMap.putIfAbsent(band.name.toString(), () => band.votes!.toDouble());
    });

    final List<Color> colorList = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.yellow,
      Colors.orange,
      Colors.pink,
    ];

    return Container(
        padding: const EdgeInsets.only(top: 10),
        width: double.infinity,
        height: 200,
        child: PieChart(
          dataMap: dataMap,
          animationDuration: const Duration(milliseconds: 800),
          chartType: ChartType.ring,
          colorList: colorList,
        ));
  }
}
