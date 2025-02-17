import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        height: 500,
        child: Center(
          child: Text("Usuário não autenticado", style: TextStyle(color: Colors.white70)),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      height: 500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Histórico de Operações",
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                icon: Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          SizedBox(height: 10),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('operations')
                  .where('userId', isEqualTo: user.uid)
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(color: Colors.orange));
                }

                if (snapshot.hasError) {
                  print("Erro ao carregar histórico: ${snapshot.error}");
                  return Center(child: Text("Erro ao carregar histórico", style: TextStyle(color: Colors.white70)));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text("Nenhum histórico disponível", style: TextStyle(color: Colors.white70)),
                  );
                }

                var docs = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    var data = docs[index].data() as Map<String, dynamic>;
                    return Card(
                      color: Colors.grey[900],
                      margin: EdgeInsets.symmetric(vertical: 4),
                      child: ListTile(
                        title: Text(
                          data['expression'] ?? 'Operação desconhecida',
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          "Resultado: ${data['result']}",
                          style: TextStyle(color: Colors.orangeAccent),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection('operations')
                                .doc(docs[index].id)
                                .delete();
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
