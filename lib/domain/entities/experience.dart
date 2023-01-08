class Experience {
  final String company;
  final String position;
  final String from;
  final String to;
  final ExperienceDescription experienceDescription;

  Experience({
    required this.company,
    required this.position,
    required this.from,
    required this.to,
    required this.experienceDescription,
  });

  static List<Experience> instance() {
    return [
      Experience(
        company: 'Mmenu',
        position: 'FUTTER DEVELOPER',
        from: '08/2021',
        to: 'Đến nay',
        experienceDescription: ExperienceDescription(
          project: 'Mmenu admin - Mmenu customer Application',
          description: 'All in one solution in the business of F&B',
          teamSize: '8',
          responsiblities:
              'Review code, management App store and Play store, develop the frameworks and modules of the system.',
          accomplishments:
              'Xây dựng và quản lý máy in ESC/POS. Improved teamwork and communication skills.',
          stores: [
            'https://apps.apple.com/vn/app/mmenu-admin/id1610048415',
            'https://play.google.com/store/apps/details?id=admin.mmenu.io'
          ],
          tech:
              'Front-end: Flutter + Bloc pattern, Firebase, Protobuf, Rest API, Kotlin',
        ),
      ),
      Experience(
        company: 'Mmenu',
        position: 'FUTTER DEVELOPER',
        from: '08/2021',
        to: 'Đến nay',
        experienceDescription: ExperienceDescription(
          project: 'Mmenu admin - Mmenu customer Application',
          description: 'All in one solution in the business of F&B',
          teamSize: '8',
          responsiblities:
              'Review code, management App store and Play store, develop the frameworks and modules of the system.',
          accomplishments:
              'Xây dựng và quản lý máy in ESC/POS. Improved teamwork and communication skills.',
          stores: [
            'https://apps.apple.com/vn/app/mmenu-admin/id1610048415',
            'https://play.google.com/store/apps/details?id=admin.mmenu.io'
          ],
          tech:
              'Front-end: Flutter + Bloc pattern, Firebase, Protobuf, Rest API, Kotlin',
        ),
      ),
    ];
  }
}

class ExperienceDescription {
  final String project;
  final String description;
  final String teamSize;
  final String responsiblities;
  final String accomplishments;
  final List<String> stores;
  final String tech;

  ExperienceDescription({
    required this.project,
    required this.description,
    required this.teamSize,
    required this.responsiblities,
    required this.accomplishments,
    required this.stores,
    required this.tech,
  });
}
