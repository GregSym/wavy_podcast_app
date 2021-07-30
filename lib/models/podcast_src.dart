List<String> mockSrcs = [
  "https://feeds.simplecast.com/y1LF_sn2",
  'https://feeds.simplecast.com/wjQvYtdl',
  'https://feeds.simplecast.com/9YNI3WaL',
];

Map<String, Object?> mockSrcsJson() {
  Map<String, Object?> _jsonPacket = {};
  for (String src in mockSrcs) {
    _jsonPacket.addEntries({'src': src}.entries);
  }
  return _jsonPacket;
}

Map<String, Object?> mockSrcsJsonListVersion() {
  Map<String, Object?> _jsonPacket = {};
  _jsonPacket['src_link'] = mockSrcs;
  return _jsonPacket;
}

class PodcastSource {
  late List<String> srcLink;

  PodcastSource({required this.srcLink});

  PodcastSource.fromJson(Map<String, dynamic> json) {
    srcLink = json['src_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['src_link'] = this.srcLink;
    return data;
  }
}

var schema = {'src': 'uri', 'metadata': {}};
