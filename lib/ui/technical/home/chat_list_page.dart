import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_safetech/domain/models/technical.dart';
import 'package:mobile_safetech/domain/services/client_services.dart';
import 'package:mobile_safetech/domain/services/technical_services.dart';

import '../../../common/commons.dart';

import '../../../domain/models/client.dart';
import '../../shared/chat_page.dart';

class TechnicalChatList extends StatefulWidget {
  const TechnicalChatList({super.key});

  @override
  State<TechnicalChatList> createState() => _TechnicalChatListState();
}

class _TechnicalChatListState extends State<TechnicalChatList> {
  String search = "";

  _goToChatPage(Client client, Technical technical) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatPage(
          nombreSender: technical.firstName,
          apellidoSender: technical.lastName,
          anotherUserUid: client.id,
          anotherUserName: client.firstName,
          anotherUserSurname: client.lastName,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.myWhite,
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 15.0, left: 15.0, bottom: 10.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.primaryColor)),
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Buscar...',
                    ),
                    onChanged: (val) {
                      setState(() {
                        search = val;
                      });
                    },
                  ),
                ),
                FutureBuilder<List<Client>>(
                  future: ClientServices().getClients(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    List<Client> clients = snapshot.data!;
                    return clientItemList(clients: clients);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget clientItemList({required List<Client> clients}) {
    if (clients.isEmpty) {
      return const Text("Hubo un error al obtener los técnicos");
    }

    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(
        height: 15,
      ),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: clients.length,
      itemBuilder: (context, index) {
        Client client = clients[index];

        if (search.isEmpty) {
          clientItemCard(client);
        }

        final fullName = "${client.firstName} ${client.lastName}";

        if (fullName.toLowerCase().contains(search.toLowerCase())) {
          return clientItemCard(client);
        }

        return Container();
      },
    );
  }

  Widget clientItemCard(Client client) {
    final User user = FirebaseAuth.instance.currentUser!;
    return FutureBuilder<Technical>(
      future: TechnicalServices().getTechnicalById(user.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Error obteniendo el technicale");
        } else if (!snapshot.hasData) {
          return Text("Technicale no encontrado");
        }
        Technical technical = snapshot.data!;
        return Container(
          decoration: AppStyles.greyWithGreen,
          padding: const EdgeInsets.symmetric(vertical: 5),
          width: double.infinity,
          child: ListTile(
            leading: const CircleAvatar(
                backgroundImage: AssetImage(AppAssets.clientImagePath)),
            title: Text("${client.firstName} ${client.lastName}"),
            trailing: IconButton(
              icon: const Icon(Icons.chat),
              onPressed: () {
                _goToChatPage(client, technical);
              },
            ),
          ),
        );
      },
    );
  }
}
