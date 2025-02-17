import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Histórico de Operações")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('operations')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          var docs = snapshot.data!.docs;
          if (docs.isEmpty) {
            return Center(child: Text("Nenhum histórico disponível"));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var data = docs[index].data() as Map<String, dynamic>;
              return ListTile(
                title: Text(data['expression'] ?? 'Operação desconhecida'),
                subtitle: Text("Resultado: ${data['result']}"),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('history')
                        .doc(docs[index].id)
                        .delete();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
