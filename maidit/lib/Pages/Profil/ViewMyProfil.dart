// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ViewMyProfil extends StatefulWidget {
  const ViewMyProfil({super.key});

  @override
  State<ViewMyProfil> createState() => _ViewMyProfilState();
}

class _ViewMyProfilState extends State<ViewMyProfil> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                color: Colors.grey[50],
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: CircleAvatar(
                        radius: 70,
                        backgroundImage: NetworkImage(
                            "https://img.freepik.com/free-photo/close-up-beautiful-calm-attractive-young-brunette-woman-posing_295783-267.jpg?w=1060&t=st=1678717105~exp=1678717705~hmac=23931e49d182780966778b08d53c1ef8ade4337ee6f7a1bface7d52f0e00ada8"),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Expanded(child: SizedBox()),
                        SizedBox(
                          width: 150,
                          child: Text(
                            "Ghita Moslih",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: Text(
                            "Bonjour, je suis Ghita, j'ai 28 ans et je suis mére de 2 fils.",
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style:
                                TextStyle(fontSize: 14, color: Colors.black45),
                          ),
                        ),
                        Expanded(child: SizedBox()),
                      ],
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  "Mes centres d'intérêts",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontSize: 16),
                ),
              ),
              Container(
                height: 200,
                color: Colors.grey[50],
              ),
              const Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  "Mon agenda",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontSize: 16),
                ),
              ),
              Container(
                height: 300,
                color: Colors.grey[50],
              )
            ],
          ),
        ),
      ],
    );
  }
}
