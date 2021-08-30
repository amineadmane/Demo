class PermisRouge {
  String nOMARABE;
  String pRNOMARABE;
  String dATEDENAISSANCE;
  String nOMFR;
  String pRNOMFR;

  PermisRouge(
      {this.nOMARABE,
      this.pRNOMARABE,
      this.dATEDENAISSANCE,
      this.nOMFR,
      this.pRNOMFR});

  PermisRouge.fromJson(Map<String, dynamic> json) {
    nOMARABE = json['NOM-ARABE'];
    pRNOMARABE = json['PRÉNOM-ARABE'];
    dATEDENAISSANCE = json['DATE DE NAISSANCE'];
    nOMFR = json['NOM-FR'];
    pRNOMFR = json['PRÉNOM-FR'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NOM-ARABE'] = this.nOMARABE;
    data['PRÉNOM-ARABE'] = this.pRNOMARABE;
    data['DATE DE NAISSANCE'] = this.dATEDENAISSANCE;
    data['NOM-FR'] = this.nOMFR;
    data['PRÉNOM-FR'] = this.pRNOMFR;
    return data;
  }
}
