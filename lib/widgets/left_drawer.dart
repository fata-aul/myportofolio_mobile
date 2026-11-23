import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/menu.dart';
import 'package:myportofolio_mobile/screens/education_form_page.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.indigo),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('My Portfolio', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)),
                SizedBox(height: 10),
                Text('Explore personal projects and experiences!', style: TextStyle(fontSize: 15, color: Colors.white)),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const MyHomePage()),
                (route) => false,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text('Add Project'),
            onTap: () => Navigator.pushNamed(context, '/project-form'),
          ),
          ListTile(
            leading: const Icon(Icons.school_outlined),
            title: const Text('Add Education'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const EducationFormPage()));
            },
          ),
        ],
      ),
    );
  }
}
