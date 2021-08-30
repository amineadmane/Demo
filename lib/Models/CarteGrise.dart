class CarteGrise {
  String nDIMMATRICULATION;
  String aNNEEDEPREMIEREMISEENCIRCULATION;
  String pUISSANCE;
  String pLACESASSISES;
  String mARQUEARABE;
  String mARQUEFR;

  CarteGrise(
      {this.nDIMMATRICULATION,
      this.aNNEEDEPREMIEREMISEENCIRCULATION,
      this.pUISSANCE,
      this.pLACESASSISES,
      this.mARQUEARABE,
      this.mARQUEFR});

  CarteGrise.fromJson(Map<String, dynamic> json) {
    nDIMMATRICULATION = json["N° D'IMMATRICULATION"];
    aNNEEDEPREMIEREMISEENCIRCULATION =
        json['ANNEE DE PREMIERE MISE EN CIRCULATION'];
    pUISSANCE = json['PUISSANCE'];
    pLACESASSISES = json['PLACES ASSISES'];
    mARQUEARABE = json['MARQUE-ARABE'];
    mARQUEFR = json['MARQUE-FR'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['N° D\'IMMATRICULATION'] = this.nDIMMATRICULATION;
    data['ANNEE DE PREMIERE MISE EN CIRCULATION'] =
        this.aNNEEDEPREMIEREMISEENCIRCULATION;
    data['PUISSANCE'] = this.pUISSANCE;
    data['PLACES ASSISES'] = this.pLACESASSISES;
    data['MARQUE-ARABE'] = this.mARQUEARABE;
    data['MARQUE-FR'] = this.mARQUEFR;
    return data;
  }
}
