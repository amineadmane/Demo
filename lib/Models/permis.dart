class Permis {
  String nOM;
  String pRNOM;
  String dATEDENAISSANCE;
  String cATEGORIES;
  String sEXE;

  Permis(
      {this.nOM, this.pRNOM, this.dATEDENAISSANCE, this.cATEGORIES, this.sEXE});

  Permis.fromJson(Map<String, dynamic> json) {
    nOM = json['NOM'];
    pRNOM = json['PRENOM'];
    print("prenom :" + json['PRENOM'].toString());
    dATEDENAISSANCE = json['DATE DE NAISSANCE'];
    cATEGORIES = json['CATEGORIES'];
    sEXE = json['SEXE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NOM'] = this.nOM;
    data['PRENOM'] = this.pRNOM;
    data['DATE DE NAISSANCE'] = this.dATEDENAISSANCE;
    data['CATEGORIES'] = this.cATEGORIES;
    data['SEXE'] = this.sEXE;
    return data;
  }
}
