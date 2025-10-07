class Count {
  Count({
    this.tele = 0,
    this.pcr = 0,
    this.hvd = 0,
    this.hhc = 0,
    this.phys = 0,
  });

  int tele, hvd, pcr, hhc, phys;

  factory Count.fromJson(Map<String, dynamic> json) => Count(
        tele: json['tele_appointment'] ?? 0,
        pcr: json['pcr_appointment'] ?? 0,
        hhc: json['hhc_appointment'] ?? 0,
        hvd: json['hvd_appointment'] ?? 0,
        phys: json['phys_appointment'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "tele_appointment": tele,
        "hvd_appointment": hvd,
        "hhc_appointment": hhc,
        "phys_appointment": phys,
        "pcr_appointment": pcr,
      };
}
