import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:vit_ap_student_app/core/utils/launch_web.dart';
import 'package:vit_ap_student_app/core/utils/package_version.dart';
import 'package:vit_ap_student_app/features/account/view/widgets/footer.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String _version = '';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    final version = await packageVersion();
    setState(() {
      _version = version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 125,
              width: 125,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  color: const Color(0xFFFFC68D),
                  image: const DecorationImage(
                    scale: 1.2,
                    image: AssetImage('assets/images/logo/app_icon.png'),
                  )),
              // child: Image.asset(
              //   "assets/images/logo/app_icon.png",
              //   height: 150,
              // ),
            ),
            const SizedBox(
              height: 18,
            ),
            Text(
              'VITAP Student',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Version: $_version',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(),
            ),
            Text(
              '© 2026 Udhay Adithya & Sai Sanjay',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(),
            ),
            const SizedBox(
              height: 12,
            ),
            const Text(
              'An unofficial app built by students for\nstudents of VIT-AP to access academic\ninformation from VTOP with ease.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
              child: const Footer(
                hideVersion: true,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(9),
              ),
              leading: const Icon(Iconsax.document_copy),
              trailing: Icon(
                Icons.arrow_forward_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: const Text('Privacy Policy'),
              onTap: () async {
                await directToWeb('https://vitap.udhay-adithya.me/privacy');
              },
            ),
            const Divider(),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(9),
              ),
              title: const Text('Terms of Use'),
              leading: const Icon(Iconsax.document_1_copy),
              trailing: Icon(
                Icons.arrow_forward_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              onTap: () async {
                await directToWeb('https://vitap.udhay-adithya.me/terms');
              },
            ),
          ],
        ),
      ),
    );
  }
}
