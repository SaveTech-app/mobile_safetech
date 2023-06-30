import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_safetech/domain/services/client_services.dart';
import 'package:mobile_safetech/domain/services/technical_services.dart';
import 'package:mobile_safetech/ui/client/chat/chat_page.dart';

import '../../../common/commons.dart';

import '../../../domain/models/client.dart';
import '../../../domain/models/technical.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  String search = "";

  _goToChatPage(Technical technical, Client client) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatPage(
          nombreSender: client.firstName,
          apellidoSender: client.lastName,
          anotherUserUid: technical.id,
          anotherUserName: technical.firstName,
          anotherUserSurname: technical.lastName,
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
                FutureBuilder<List<Technical>>(
                  future: TechnicalServices().getTechnicals(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    List<Technical> technicals = snapshot.data!;
                    return technicalItemList(technicals: technicals);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget technicalItemList({required List<Technical> technicals}) {
    if (technicals.isEmpty) {
      return const Text("Hubo un error al obtener los técnicos");
    }

    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(
        height: 15,
      ),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: technicals.length,
      itemBuilder: (context, index) {
        Technical technical = technicals[index];

        if (search.isEmpty) {
          technicalItemCard(technical);
        }

        final fullName = "${technical.firstName} ${technical.lastName}";

        if (fullName.toLowerCase().contains(search.toLowerCase())) {
          return technicalItemCard(technical);
        }

        return Container();
      },
    );
  }

  Widget technicalItemCard(Technical technical) {
    final User user = FirebaseAuth.instance.currentUser!;
    return FutureBuilder<Client>(
      future: ClientServices().getClientById(user.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Error obteniendo el cliente");
        } else if (!snapshot.hasData) {
          return Text("Cliente no encontrado");
        }
        Client client = snapshot.data!;
        return Container(
          decoration: AppStyles.greyWithGreen,
          padding: const EdgeInsets.symmetric(vertical: 5),
          width: double.infinity,
          child: ListTile(
            leading: const CircleAvatar(
                backgroundImage: AssetImage(AppAssets.technicalImagePath)),
            title: Text("${technical.firstName} ${technical.lastName}"),
            trailing: IconButton(
              icon: const Icon(Icons.chat),
              onPressed: () {
                _goToChatPage(technical, client);
              },
            ),
          ),
        );
      },
    );
  }
}
