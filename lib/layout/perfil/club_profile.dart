import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:peneiras/constants/app_colors.dart';
import 'package:peneiras/utils/global_keys.dart';

import 'package:peneiras/widgets/perfil/perfil_infos.dart';
import 'package:peneiras/widgets/perfil/perfil_ui.dart';

class ClubProfile extends StatefulWidget {
  final bool isFake;

  const ClubProfile({super.key, this.isFake = false});

  @override
  State<ClubProfile> createState() => _ClubProfileState();
}

class _ClubProfileState extends State<ClubProfile> {
  late bool isLoading;

  late String image;
  late String name;
  late String subtitle;
  late String location;
  late String aboutText;
  late List<String> categories;
  late String email;
  late String phone;
  late String socialMedia;

  @override
  void initState() {
    super.initState();

    isLoading = !widget.isFake;

    if (widget.isFake) {
      _loadMockData();
    } else {
      image = "";
      name = "";
      subtitle = "";
      location = "";
      aboutText = "";
      categories = [];
      email = "";
      phone = "";
      socialMedia = "";
      _fetchClubData();
    }
  }

  void _loadMockData() {
    image = "assets/logo.png";
    name = "Peneiras f.c";
    subtitle = "Clube de futebol";
    location = "São Paulo - SP";
    aboutText = "Formando talentos desde 1999";
    categories = ["Sub-15", "Sub-17", "Profissional"];
    email = "contato@peneirasfc.com";
    phone = "(11) 99999-9999";
    socialMedia = "@peneirasfc";
  }

  Future<void> _fetchClubData() async {
    await Future.delayed(const Duration(milliseconds: 800));

    if (!mounted) return;

    setState(() {
      _loadMockData();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.lightGreen),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.lightGreen, width: 2),
            ),
            child: ClipOval(
              child: Image.asset(image, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            name,
            style: GoogleFonts.judson(
              fontSize: 26,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on,
                  size: 16, color: AppColors.lightGreen),
              const SizedBox(width: 4),
              Text(
                location,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 20),
          PerfilCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.info_outline,
                        color: AppColors.lightGreen, size: 18),
                    SizedBox(width: 6),
                    Text(
                      "Sobre",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  aboutText,
                  style: const TextStyle(
                      color: Colors.white70, fontSize: 14, height: 1.4),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          PerfilCard(
            key: perfilClubInfoKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Categorias",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children:
                      categories.map((cat) => PerfilChip(label: cat)).toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          PerfilCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Contato",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                PerfilContato(icon: Icons.email, text: email),
                PerfilContato(icon: Icons.phone, text: phone),
                PerfilContato(icon: Icons.camera_alt, text: socialMedia),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, color: Colors.black, size: 20),
              label: Text(
                "Criar Peneira",
                style: GoogleFonts.judson(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.lightGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          const SizedBox(height: 25),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.person,
                  color: AppColors.lightGreen, size: 20),
              label: Text(
                "Ver Peneiras",
                style: GoogleFonts.judson(
                  fontSize: 15,
                  color: AppColors.lightGreen,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.lightGreen),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.symmetric(vertical: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
