import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/portfolio_project.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class ProjectListPage extends StatelessWidget {
  const ProjectListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = ProjectStore.projects;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Proyek'),
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
      ),
      drawer: const LeftDrawer(),
      body: projects.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.folder_open, size: 64, color: colors.primary),
                    const SizedBox(height: 12),
                    Text('Belum ada proyek', style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 8),
                    const Text('Tambahkan proyek melalui menu Add Project di drawer.'),
                  ],
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: projects.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final project = projects[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(project.name, style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 4),
                        Text(project.category, style: TextStyle(color: colors.primary, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 12),
                        Text(project.description),
                        if (project.technologies.isNotEmpty) ...[
                          const SizedBox(height: 12),
                          Text('Teknologi: ${project.technologies}'),
                        ],
                        if (project.link.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          SelectableText('Tautan: ${project.link}'),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

