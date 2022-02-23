List<String> mockSrcs = [
  "https://feeds.simplecast.com/y1LF_sn2",
  'https://feeds.simplecast.com/wjQvYtdl',
  'https://feeds.simplecast.com/9YNI3WaL',
  'https://feeds.99percentinvisible.org/99percentinvisible',
  'https://feeds.megaphone.fm/behindthebastards',
  'https://rss.art19.com/musicalsplaining',
  'https://feeds.simplecast.com/p7S4nr_h',
  'https://rss.acast.com/theeconomisteditorspicks',
  'https://feeds.npr.org/381444908/podcast.xml',
  'https://rss.acast.com/theeconomistallaudio',
  // 'https://feeds.npr.org/500005/podcast.xml',
  'https://iono.fm/rss/chan/2349',
  'https://iono.fm/rss/chan/2812',
  'https://www.omnycontent.com/d/playlist/5dcefa8e-00a9-4595-8ce1-a4ab0080f142/1ecba37a-6d83-4ee9-a295-a57100b7f2df/fea13fc9-5335-475c-8d7f-a8f800d24e67/podcast.rss',
  'https://feeds.simplecast.com/Urk3897_',
  'https://feeds.acast.com/public/shows/worstideaofalltime',
  'https://feeds.simplecast.com/dHoohVNH',
  'https://feeds.simplecast.com/xl36XBC2',
  'https://blart.libsyn.com/rss',
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
