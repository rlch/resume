part of 'node.dart';

class Interest extends ResumeNode {
  Interest({required this.title});

  final String title;

  @override
  bool operator ==(Object o) => o is Interest && o.title == title;
  @override
  int get hashCode => title.hashCode;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      title,
      textAlign: TextAlign.center,
      presetFontSizes: presetFontSizes,
      wrapWords: false,
    );
  }

  @override
  ResumeNodeType get type => ResumeNodeType.interest;
}

final _japanese = Interest(title: '日本語'),
    _spanish = Interest(title: 'Español'),
    _languages = Interest(title: 'Languages'),
    _rockClimbing = Interest(title: 'Rock Climbing'),
    _bouldering = Interest(title: 'Bouldering'),
    _gaming = Interest(title: 'Gaming'),
    _traveling = Interest(title: 'Traveling'),
    _gameDev = Interest(title: 'Game Development');
