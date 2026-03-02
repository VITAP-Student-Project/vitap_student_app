class Contributor {
  final String login;
  final String avatarUrl;
  final String htmlUrl;
  final int contributions;

  const Contributor({
    required this.login,
    required this.avatarUrl,
    required this.htmlUrl,
    required this.contributions,
  });

  factory Contributor.fromJson(Map<String, dynamic> json) {
    return Contributor(
      login: json['login'] as String,
      avatarUrl: json['avatar_url'] as String,
      htmlUrl: json['html_url'] as String,
      contributions: json['contributions'] as int,
    );
  }
}
