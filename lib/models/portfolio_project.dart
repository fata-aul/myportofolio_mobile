class PortfolioProject {
  const PortfolioProject({
    required this.name,
    required this.description,
    required this.category,
    required this.technologies,
    required this.link,
  });

  final String name;
  final String description;
  final String category;
  final String technologies;
  final String link;
}

class ProjectStore {
  ProjectStore._();

  static final List<PortfolioProject> projects = [];

  static void add(PortfolioProject project) => projects.add(project);
}
