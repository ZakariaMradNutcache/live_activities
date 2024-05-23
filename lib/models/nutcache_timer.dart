class NutcacheTimer {
  int start;

  NutcacheTimer({required this.start});

  Map<String, dynamic> toJson() {
    return {
      'start': start,
      'heading' : 'Nutcache Timer',
    };
  }
}