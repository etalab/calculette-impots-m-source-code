#*************************************************************************************************************************
#
#Copyright or © or Copr.[DGFIP][2017]
#
#Ce logiciel a été initialement développé par la Direction Générale des 
#Finances Publiques pour permettre le calcul de l'impôt sur le revenu 2014 
#au titre des revenus perçus en 2013. La présente version a permis la 
#génération du moteur de calcul des chaînes de taxation des rôles d'impôt 
#sur le revenu de ce millésime.
#
#Ce logiciel est régi par la licence CeCILL 2.1 soumise au droit français 
#et respectant les principes de diffusion des logiciels libres. Vous pouvez 
#utiliser, modifier et/ou redistribuer ce programme sous les conditions de 
#la licence CeCILL 2.1 telle que diffusée par le CEA, le CNRS et l'INRIA  sur 
#le site "http://www.cecill.info".
#
#Le fait que vous puissiez accéder à cet en-tête signifie que vous avez pris 
#connaissance de la licence CeCILL 2.1 et que vous en avez accepté les termes.
#
#**************************************************************************************************************************
verif 1005:
application : batch, iliad  ;
si (APPLI_OCEANS=0) et (
    V_IND_TRAIT > 0 et
     (
    (RBG > 99999999)
    ou
    (BCSG > 99999999)
    ou
    (BRDS > 99999999)
    ou
    (BPRS > 99999999)
    ou
    (GSALV > 99999999)
    ou
    (GSALC > 99999999)
    ou
    (CVNSALAV > 99999999)
    ou
    (CVNSALAC > 99999999)
    )
   )
alors erreur A00105 ;
verif isf 1007:
application : batch, iliad  ;
si (APPLI_OCEANS=0) et (
    V_IND_TRAIT > 0 et
     (
    (ISFDONEURO > 99999999)
    ou
    (ISFDONF > 99999999)
    ou
    (ISFETRANG > 99999999)
    ou
    (ISFFCPI > 99999999)
    ou
    (ISFFIP > 99999999)
    ou
    (ISFPMEDI > 99999999)
    ou
    (ISFPMEIN > 99999999)
    ou
    (ISFBASE > 99999999)
    ou
    (ISFVBPAT > 99999999)
     )
   )
alors erreur A00107 ;
verif non_auto_cc 1101:
application : iliad , batch ;
si
(
  RCMAVFT > PLAF_AF 
  et
  positif(RCMABD + REVACT + REVACTNB + RCMHAD + DISQUO + DISQUONB + RCMHAB 
                          + INTERE + INTERENB + RCMTNC + REVPEA + COD2FA + 0) = 0
)
alors erreur A21801 ;
verif non_auto_cc 1102:
application : iliad , batch ;
si
(
  DIREPARGNE > PLAF_AF
  et
  (PPLIB + RCMLIB + RCMHAD + RCMHAB + DISQUO + DISQUONB + INTERE + INTERENB + COD2FA + BPVRCM + 0 = 0)
)
alors erreur A21802;
verif 224:
application :  iliad , batch;

si
   V_IND_TRAIT > 0 
   et
   COD2CK + 0 > 80
   et
   positif(RCMABD + REVACT + RCMHAD + DISQUO + RCMHAB + INTERE + RCMTNC + REVPEA + COD2FA + 0) = 0

alors erreur A224 ;
verif 225:
application :  iliad , batch;

si
   V_IND_TRAIT > 0 
   et
   COD2FA + 0 > 2000

alors erreur A225 ;
verif 226:
application :  iliad , batch;

si
   V_IND_TRAIT > 0 
   et
   positif(COD2FA + 0) + positif(RCMHAB + 0) > 1

alors erreur A226 ;
verif 1103:
application :  iliad , batch;
si (APPLI_OCEANS=0) et 
( (1 - V_CNR > 0) et V_REGCO+0 != 2 et V_REGCO+0 != 4 et 
(
   (
    RCMABD + RCMHAD + RCMHAB + REVACT + DISQUO + INTERE + RCMTNC + REVPEA + COD2FA + 0 > 0
    et 
    RCMAVFT > ((1/3) * (RCMABD + RCMHAD + RCMHAB + REVACT + DISQUO + INTERE + RCMTNC + REVPEA + COD2FA)) +  PLAF_AF
   )
 ou
   (
     DIREPARGNE > ((PPLIB + RCMLIB + RCMHAD + RCMHAB + DISQUO + INTERE + COD2FA + BPVRCM) * (538/1000)) + PLAF_AF
     et
     PPLIB + RCMLIB + RCMHAD + RCMHAB + DISQUO + INTERE + COD2FA + BPVRCM + 0 > 0
   )
)
)
alors erreur DD04;
verif 1104:
application : iliad , batch ;
si (APPLI_OCEANS=0) et 
(
  (1 - V_CNR + 0 > 0) et  
  (
  RCMFR > LIM_CONTROLE  et 
   (
    (RCMFR > 0.30 * ( RCMABD + RCMHAD + REVACT + DISQUO + RCMHAB + INTERE + 0 ))
    ou
    ((RCMABD + RCMHAD + REVACT + DISQUO + RCMHAB + INTERE + 0 = 0) 
     et
     (RCMTNC + RCMAV + REGPRIV + REVPEA + PROVIE + RESTUC + 0 > 0))
   )
  )
)
alors erreur DD03;
verif  1106:
application : batch, iliad ;
si
   (
   RCMSOC > RCMAV + PROVIE 
          + RCMHAD + DISQUO 
          + RCMHAB + INTERE  
          + RCMABD + REVACT 
	  + 1

   )
alors erreur A222;
verif 1108:
application : iliad ;
si (APPLI_OCEANS=0) et 
(
        (V_IND_TRAIT + 0 = 4 et V_NOTRAIT + 0 <14) 
         et
       (
	(RCMAVFT > PLAF_AF
         et 
	 RCMABD + REVACT + RCMHAD + DISQUO + RCMHAB + INTERE + RCMTNC + REVPEA + COD2FA > 0
         et
	 RCMAVFT > arr(40 * (RCMABD + REVACT + RCMHAD + DISQUO + RCMHAB + INTERE + RCMTNC + REVPEA + COD2FA) / 100)
        )
	ou
	(DIREPARGNE > PLAF_AF
	 et
	 PPLIB + RCMLIB + RCMHAD + DISQUO + RCMHAB + INTERE + COD2FA + BPVRCM > 0
	 et
	 DIREPARGNE > arr(60 * (PPLIB + RCMLIB + RCMHAD + DISQUO + RCMHAB + INTERE + COD2FA + BPVRCM) / 100)
	)
       )
)
alors erreur IM1501;
verif 1109:
application : iliad ;
si (APPLI_OCEANS=0) et 
(
       (V_NOTRAIT+0 >=14) et
       (
	(RCMAVFT > PLAF_AF et RCMAVFT <= PLAF_AF2
         et 
	 RCMABD + REVACT + RCMHAD + DISQUO + RCMHAB + INTERE + RCMTNC + REVPEA + COD2FA > 0
         et
	 RCMAVFT > arr(40 * (RCMABD + REVACT + RCMHAD + DISQUO + RCMHAB + INTERE + RCMTNC + REVPEA + COD2FA) / 100)
        )
	ou
	(DIREPARGNE > PLAF_AF et DIREPARGNE <= PLAF_AF2
	 et
	 PPLIB + RCMLIB + RCMHAD + DISQUO + RCMHAB + INTERE + COD2FA + BPVRCM > 0
	 et
         DIREPARGNE > arr(60 * (PPLIB + RCMLIB + RCMHAD + DISQUO + RCMHAB + INTERE + COD2FA + BPVRCM) / 100)
	)
       )
)
alors erreur IM1502;
verif 11220:
application : batch ;
si 
   APPLI_COLBERT = 0 
   et 
   (
    V_NOTRAIT + 0 = 10
    et
    (
     (RCMAVFT > PLAF_AF2
      et 
      RCMABD + RCMHAD + RCMHAB + REVACT + DISQUO + INTERE + RCMTNC + REVPEA + COD2FA > 0
      et
      RCMAVFT > arr((RCMABD + RCMHAD + RCMHAB + REVACT + DISQUO + INTERE + RCMTNC + REVPEA + COD2FA) * 40/100))
     ou
     (DIREPARGNE > PLAF_AF2
      et
      PPLIB + RCMLIB + RCMHAD + RCMHAB + DISQUO + INTERE + COD2FA + BPVRCM > 0
      et
      DIREPARGNE > arr((PPLIB + RCMLIB + RCMHAD + RCMHAB + DISQUO + INTERE + COD2FA + BPVRCM) * 60/100 ))
    )
   )
 
alors erreur A220 ;
verif 11221:
application : iliad ;
si 
   APPLI_OCEANS = 0 
   et 
   ( ((V_IND_TRAIT+0=5 et V_NOTRAIT+0>14) ou V_NOTRAIT+0=14)
    et
    (
     (RCMAVFT > PLAF_AF2
      et 
      RCMABD + RCMHAD + RCMHAB + REVACT + DISQUO + INTERE + RCMTNC + REVPEA + COD2FA > 0
      et
      RCMAVFT > arr((RCMABD + RCMHAD + RCMHAB + REVACT + DISQUO + INTERE + RCMTNC + REVPEA + COD2FA) * 40/ 100))
     ou
     (DIREPARGNE > PLAF_AF2
      et
      PPLIB + RCMLIB + RCMHAD + RCMHAB + DISQUO + INTERE + COD2FA + BPVRCM > 0
      et
      DIREPARGNE > arr((PPLIB + RCMLIB + RCMHAD + RCMHAB + DISQUO + INTERE + COD2FA + BPVRCM) * 60/100 ))
    )
   )

alors erreur A220 ;
verif 30:
application : batch , iliad ;

si
   V_0CF + V_0CG + V_0CH + V_0CI + V_0CR + V_0DJ + V_0DN + V_0DP + 0 = 0 
   et 
   SOMMEA030 > 0
      
alors erreur A030 ;
verif 718:
application : batch , iliad ;

si
   CIAQCUL > 0 
   et 
   SOMMEA718 = 0 
    
alors erreur A718 ;
verif 719:
application : batch , iliad ;

si
   RDMECENAT > 0 
   et 
   SOMMEA719 = 0
    
alors erreur A719 ;
verif 1202:
application : batch , iliad ;

si
   V_0AC + V_0AD + 0 > 0
   et 
   SOMMEA031 > 0
    
alors erreur A031 ;
verif 805:
application : iliad , batch;

si
   V_IND_TRAIT > 0
   et
   positif(TREVEX) = 1
   et 
   SOMMEA805 = 0
  
alors erreur A805 ;
verif 807:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   positif(PRELIBXT + 0) = 1
   et
   positif(PCAPTAXV + PCAPTAXC + 0) = 0

alors erreur A807 ;
verif 864:
application : iliad , batch ;

si
   V_IND_TRAIT > 0 
   et
   COD8YL + 0 > CGLOA + 0

alors erreur A864 ;
verif 865:
application : iliad , batch ;

si
   V_IND_TRAIT > 0 
   et
   COD8YT + 0 > CVNSALC + 0

alors erreur A865 ;
verif 8661:
application : iliad , batch ;

si
   V_IND_TRAIT > 0 
   et
   CSPROVYD + 0 > max(0,RSE1 + PRSE1 - CIRSE1) + 0

alors erreur A86601 ;
verif 8662:
application : iliad , batch ;

si
   V_IND_TRAIT > 0 
   et
   CSPROVYE + 0 >  max(0,RSE5 + PRSE5 - CIRSE5) + 0

alors erreur A86602 ;
verif 8663:
application : iliad , batch ;

si
   V_IND_TRAIT > 0 
   et
   CSPROVYF + 0 >  max(0,RSE2 + PRSE2 - CIRSE2) + 0

alors erreur A86603 ;
verif 8664:
application : iliad , batch ;

si
   V_IND_TRAIT > 0 
   et
   CSPROVYG + 0 >  max(0,RSE3 + PRSE3 - CIRSE3) + 0

alors erreur A86604 ;
verif 8665:
application : iliad , batch ;

si
   V_IND_TRAIT > 0 
   et
   CSPROVYH + 0 >  max(0,RSE4 + PRSE4 - CIRSE4) + 0

alors erreur A86605 ;
verif 821:
application : iliad , batch ;

si
   (V_IND_TRAIT > 0 )
   et
   present(BASRET) + present(IMPRET) = 1

alors erreur A821 ;
verif 12220:
application : iliad , batch ;

si 
  ((V_IND_TRAIT = 4 )
   et
   (
    REVACTNB < 2 ou REVACTNB > 20
    ou
    REVPEANB < 2 ou REVPEANB > 20
    ou
    PROVIENB < 2 ou PROVIENB > 20
    ou
    DISQUONB < 2 ou DISQUONB > 20
    ou
    RESTUCNB < 2 ou RESTUCNB > 20
    ou
    INTERENB < 2 ou INTERENB > 20
   )
  )
  ou
  ((V_IND_TRAIT = 5 )
   et
   (
    REVACTNB = 1 ou REVACTNB > 20
    ou
    REVPEANB = 1 ou REVPEANB > 20
    ou
    PROVIENB = 1 ou PROVIENB > 20
    ou
    DISQUONB = 1 ou DISQUONB > 20
    ou
    RESTUCNB = 1 ou RESTUCNB > 20
    ou
    INTERENB = 1 ou INTERENB > 20
   )
  )
alors erreur A22301 ;
verif 12221:
application : iliad , batch ;

si 
   (V_IND_TRAIT = 4 
    et
    (
     positif(REVACT) + present(REVACTNB) = 1
     ou
     positif(REVPEA) + present(REVPEANB) = 1
     ou
     positif(PROVIE) + present(PROVIENB) = 1
     ou
     positif(DISQUO) + present(DISQUONB) = 1
     ou 
     positif(RESTUC) + present(RESTUCNB) = 1
     ou
     positif(INTERE) + present(INTERENB) = 1
    )
   )
   ou
   (V_IND_TRAIT = 5 
    et
    (
     positif(REVACT) + positif(REVACTNB) = 1
     ou
     positif(REVPEA) + positif(REVPEANB) = 1
     ou
     positif(PROVIE) + positif(PROVIENB) = 1
     ou
     positif(DISQUO) + positif(DISQUONB) = 1
     ou 
     positif(RESTUC) + positif(RESTUCNB) = 1
     ou
     positif(INTERE) + positif(INTERENB) = 1
    )
   )
alors erreur A22302 ;
verif 12222:
application : iliad , batch ;

si 
   ((V_IND_TRAIT = 4 )
     et
    (FONCINB < 2 ou FONCINB > 30))
   ou
   ((V_IND_TRAIT = 5 )
     et
    (FONCINB = 1 ou FONCINB > 30))

alors erreur A42501 ;
verif 12223:
application : iliad , batch ;

si 
   (V_IND_TRAIT = 4 
    et
    positif(FONCI) + present(FONCINB) = 1)
  ou
   (V_IND_TRAIT = 5 
    et
    positif(FONCI) + positif(FONCINB) = 1)

alors erreur A42502 ;
verif 12224:
application : iliad , batch ;

si 
  ((V_IND_TRAIT = 4 )
    et
   (REAMORNB < 2 ou REAMORNB > 14))
  ou
  ((V_IND_TRAIT = 5 )
    et
   (REAMORNB = 1 ou REAMORNB > 14))

alors erreur A42601 ;
verif 12225:
application : iliad , batch ;

si 
   (V_IND_TRAIT = 4 
    et
    positif(REAMOR) + present(REAMORNB) = 1)
  ou
   (V_IND_TRAIT = 5 
    et
    positif(REAMOR) + positif(REAMORNB) = 1)

alors erreur A42602 ;
verif 1222:
application : iliad , batch ;
si
   ((V_IND_TRAIT = 4 )
     et
    (
     CARTSNBAV < 2 ou CARTSNBAV > 45
     ou
     CARTSNBAC < 2 ou CARTSNBAC > 45
     ou 
     CARTSNBAP1 < 2 ou CARTSNBAP1 > 45
     ou
     CARTSNBAP2 < 2 ou CARTSNBAP2 > 45
     ou
     CARTSNBAP3 < 2 ou CARTSNBAP3 > 45
     ou
     CARTSNBAP4 < 2 ou CARTSNBAP4 > 45
     ou
     REMPLANBV < 2 ou REMPLANBV > 45
     ou
     REMPLANBC < 2 ou REMPLANBC > 45
     ou
     REMPLANBP1 < 2 ou REMPLANBP1 > 45
     ou
     REMPLANBP2 < 2 ou REMPLANBP2 > 45
     ou
     REMPLANBP3 < 2 ou REMPLANBP3 > 45
     ou
     REMPLANBP4 < 2 ou REMPLANBP4 > 45
    )
   )
   ou
   ((V_IND_TRAIT = 5 )
     et
    (
     CARTSNBAV = 1 ou CARTSNBAV > 45
     ou
     CARTSNBAC = 1 ou CARTSNBAC > 45
     ou 
     CARTSNBAP1 = 1 ou CARTSNBAP1 > 45
     ou
     CARTSNBAP2 = 1 ou CARTSNBAP2 > 45
     ou
     CARTSNBAP3 = 1 ou CARTSNBAP3 > 45
     ou
     CARTSNBAP4 = 1 ou CARTSNBAP4 > 45
     ou
     REMPLANBV = 1 ou REMPLANBV > 45
     ou
     REMPLANBC = 1 ou REMPLANBC > 45
     ou
     REMPLANBP1 = 1 ou REMPLANBP1 > 45
     ou
     REMPLANBP2 = 1 ou REMPLANBP2 > 45
     ou
     REMPLANBP3 = 1 ou REMPLANBP3 > 45
     ou
     REMPLANBP4 = 1 ou REMPLANBP4 > 45
    )
   )
alors erreur A14001 ;
verif 1223:
application : iliad , batch ;
si
   ((V_IND_TRAIT = 4 )
     et
    (
     CARPENBAV < 2 ou CARPENBAV > 45
     ou
     CARPENBAC < 2 ou CARPENBAC > 45
     ou
     CARPENBAP1 < 2 ou CARPENBAP1 > 45
     ou
     CARPENBAP2 < 2 ou CARPENBAP2 > 45
     ou
     CARPENBAP3 < 2 ou CARPENBAP3 > 45
     ou
     CARPENBAP4 < 2 ou CARPENBAP4 > 45
     ou
     PENSALNBV < 2 ou PENSALNBV > 45
     ou
     PENSALNBC < 2 ou PENSALNBC > 45
     ou
     PENSALNBP1 < 2 ou PENSALNBP1 > 45
     ou
     PENSALNBP2 < 2 ou PENSALNBP2 > 45
     ou
     PENSALNBP3 < 2 ou PENSALNBP3 > 45
     ou
     PENSALNBP4 < 2 ou PENSALNBP4 > 45
     ou
     RENTAXNB < 2 ou RENTAXNB > 45
     ou
     RENTAXNB5 < 2 ou RENTAXNB5 > 45
     ou
     RENTAXNB6 < 2 ou RENTAXNB6 > 45
     ou
     RENTAXNB7 < 2 ou RENTAXNB7 > 45
    )
   )
   ou
   ((V_IND_TRAIT = 5 )
     et
    (
     CARPENBAV = 1 ou CARPENBAV > 45
     ou
     CARPENBAC = 1 ou CARPENBAC > 45
     ou
     CARPENBAP1 = 1 ou CARPENBAP1 > 45
     ou
     CARPENBAP2 = 1 ou CARPENBAP2 > 45
     ou
     CARPENBAP3 = 1 ou CARPENBAP3 > 45
     ou
     CARPENBAP4 = 1 ou CARPENBAP4 > 45
     ou
     PENSALNBV = 1 ou PENSALNBV > 45
     ou
     PENSALNBC = 1 ou PENSALNBC > 45
     ou
     PENSALNBP1 = 1 ou PENSALNBP1 > 45
     ou
     PENSALNBP2 = 1 ou PENSALNBP2 > 45
     ou
     PENSALNBP3 = 1 ou PENSALNBP3 > 45
     ou
     PENSALNBP4 = 1 ou PENSALNBP4 > 45
     ou
     RENTAXNB = 1 ou RENTAXNB > 45
     ou
     RENTAXNB5 = 1 ou RENTAXNB5 > 45
     ou
     RENTAXNB6 = 1 ou RENTAXNB6 > 45
     ou
     RENTAXNB7 = 1 ou RENTAXNB7 > 45
    )
   )
alors erreur A13901;
verif 1224:
application : iliad , batch ;
si
  (V_IND_TRAIT = 4
    et
    (
     (positif(CARTSV) + present(CARTSNBAV) = 1)
     ou
     (positif(CARTSC) + present(CARTSNBAC) = 1)
     ou
     (positif(CARTSP1) + present(CARTSNBAP1) = 1)
     ou
     (positif(CARTSP2) + present(CARTSNBAP2) = 1)
     ou
     (positif(CARTSP3) + present(CARTSNBAP3) = 1)
     ou
     (positif(CARTSP4) + present(CARTSNBAP4) = 1)
     ou
     (positif(REMPLAV) + present(REMPLANBV) = 1)
     ou
     (positif(REMPLAC) + present(REMPLANBC) = 1)
     ou
     (positif(REMPLAP1) + present(REMPLANBP1) = 1)
     ou
     (positif(REMPLAP2) + present(REMPLANBP2) = 1)
     ou
     (positif(REMPLAP3) + present(REMPLANBP3) = 1)
     ou
     (positif(REMPLAP4) + present(REMPLANBP4) = 1)
    )
  )
  ou
  (V_IND_TRAIT = 5
    et
    (
     (positif(CARTSV) + positif(CARTSNBAV) = 1)
     ou
     (positif(CARTSC) + positif(CARTSNBAC) = 1)
     ou
     (positif(CARTSP1) + positif(CARTSNBAP1) = 1)
     ou
     (positif(CARTSP2) + positif(CARTSNBAP2) = 1)
     ou
     (positif(CARTSP3) + positif(CARTSNBAP3) = 1)
     ou
     (positif(CARTSP4) + positif(CARTSNBAP4) = 1)
     ou
     (positif(REMPLAV) + positif(REMPLANBV) = 1)
     ou
     (positif(REMPLAC) + positif(REMPLANBC) = 1)
     ou
     (positif(REMPLAP1) + positif(REMPLANBP1) = 1)
     ou
     (positif(REMPLAP2) + positif(REMPLANBP2) = 1)
     ou
     (positif(REMPLAP3) + positif(REMPLANBP3) = 1)
     ou
     (positif(REMPLAP4) + positif(REMPLANBP4) = 1)
    )
  )
alors erreur A14002;
verif 1225:
application : iliad , batch ;
si
  (V_IND_TRAIT = 4
    et
    (
     (positif(CARPEV) + present(CARPENBAV) = 1)
     ou
     (positif(CARPEC) + present(CARPENBAC) = 1)
     ou
     (positif(CARPEP1) + present(CARPENBAP1) = 1)
     ou
     (positif(CARPEP2) + present(CARPENBAP2) = 1)
     ou
     (positif(CARPEP3) + present(CARPENBAP3) = 1)
     ou
     (positif(CARPEP4) + present(CARPENBAP4) = 1)
     ou
     (positif(PENSALV) + present(PENSALNBV) = 1)
     ou
     (positif(PENSALC) + present(PENSALNBC) = 1)
     ou
     (positif(PENSALP1) + present(PENSALNBP1) = 1)
     ou
     (positif(PENSALP2) + present(PENSALNBP2) = 1)
     ou
     (positif(PENSALP3) + present(PENSALNBP3) = 1)
     ou
     (positif(PENSALP4) + present(PENSALNBP4) = 1)
     ou
     (positif(RENTAX) + present(RENTAXNB) = 1)
     ou
     (positif(RENTAX5) + present(RENTAXNB5) = 1)
     ou
     (positif(RENTAX6) + present(RENTAXNB6) = 1)
     ou
     (positif(RENTAX7) + present(RENTAXNB7) = 1)
    )
  )
  ou
  (V_IND_TRAIT = 5
    et
    (
     (positif(CARPEV) + positif(CARPENBAV) = 1)
     ou
     (positif(CARPEC) + positif(CARPENBAC) = 1)
     ou
     (positif(CARPEP1) + positif(CARPENBAP1) = 1)
     ou
     (positif(CARPEP2) + positif(CARPENBAP2) = 1)
     ou
     (positif(CARPEP3) + positif(CARPENBAP3) = 1)
     ou
     (positif(CARPEP4) + positif(CARPENBAP4) = 1)
     ou
     (positif(PENSALV) + positif(PENSALNBV) = 1)
     ou
     (positif(PENSALC) + positif(PENSALNBC) = 1)
     ou
     (positif(PENSALP1) + positif(PENSALNBP1) = 1)
     ou
     (positif(PENSALP2) + positif(PENSALNBP2) = 1)
     ou
     (positif(PENSALP3) + positif(PENSALNBP3) = 1)
     ou
     (positif(PENSALP4) + positif(PENSALNBP4) = 1)
     ou
     (positif(RENTAX) + positif(RENTAXNB) = 1)
     ou
     (positif(RENTAX5) + positif(RENTAXNB5) = 1)
     ou
     (positif(RENTAX6) + positif(RENTAXNB6) = 1)
     ou
     (positif(RENTAX7) + positif(RENTAXNB7) = 1)
    )
  )
alors erreur A13902;
verif 1220:
application : iliad , batch ;
si
        (V_IND_TRAIT > 0 )
       et
    (
     COTFV + 0 > 25
     ou
     COTFC + 0 > 25
     ou
     COTF1 + 0 > 25
     ou
     COTF2 + 0 > 25
     ou
     COTF3 + 0 > 25
     ou
     COTF4 + 0 > 25
     )
alors erreur A14101;
verif 1221:
application : iliad , batch ;
si
  (V_IND_TRAIT = 4
    et
    (
     (positif(PEBFV) + present(COTFV) = 1)
     ou
     (positif(PEBFC) + present(COTFC) = 1)
     ou
     (positif(PEBF1) + present(COTF1) = 1)
     ou
     (positif(PEBF2) + present(COTF2) = 1)
     ou
     (positif(PEBF3) + present(COTF3) = 1)
     ou
     (positif(PEBF4) + present(COTF4) = 1)
     ou
     (positif(COTFV) + present(PEBFV) = 1)
     ou
     (positif(COTFC) + present(PEBFC) = 1)
     ou
     (positif(COTF1) + present(PEBF1) = 1)
     ou
     (positif(COTF2) + present(PEBF2) = 1)
     ou
     (positif(COTF3) + present(PEBF3) = 1)
     ou
     (positif(COTF4) + present(PEBF4) = 1)
    )
   )
  ou
  (V_IND_TRAIT = 5
    et
    (
     (positif(PEBFV) + positif(COTFV) = 1)
     ou
     (positif(PEBFC) + positif(COTFC) = 1)
     ou
     (positif(PEBF1) + positif(COTF1) = 1)
     ou
     (positif(PEBF2) + positif(COTF2) = 1)
     ou
     (positif(PEBF3) + positif(COTF3) = 1)
     ou
     (positif(PEBF4) + positif(COTF4) = 1)
     ou
     (positif(COTFV) + positif(PEBFV) = 1)
     ou
     (positif(COTFC) + positif(PEBFC) = 1)
     ou
     (positif(COTF1) + positif(PEBF1) = 1)
     ou
     (positif(COTF2) + positif(PEBF2) = 1)
     ou
     (positif(COTF3) + positif(PEBF3) = 1)
     ou
     (positif(COTF4) + positif(PEBF4) = 1)
    )
   )

alors erreur A14102;
verif 1301:
application : iliad ;
si (APPLI_OCEANS=0) et 
        (V_IND_TRAIT > 0 )
       et
     (
      BAFV > PLAF_FORFBA  ou  BAFC > PLAF_FORFBA  ou  BAFP > PLAF_FORFBA
     )
alors erreur IM02;
verif 1312:
application : batch ,iliad;
si (APPLI_COLBERT + APPLI_OCEANS=0) et 
    ( (positif_ou_nul(NAPT) = 0) et (APPLI_COLBERT = 0)
     et ( (V_BTNATIMP+0) dans (1,11,71,81) )
     et ( 
	 (positif(V_FORVA+0)=1) 
	ou
	 (positif(V_FORCA+0)=1) 
	ou
	 (positif(V_FORPA+0)=1)
        )
   ) 
alors erreur A534;
verif 1330:
application : batch , iliad ;
si (APPLI_OCEANS=0) et 
  pour un i dans V,C,P: 
  (
   (MIBVENi + MIBNPVENi + MIBGITEi + LOCGITi > LIM_MIBVEN)
   ou  
   (MIBPRESi + MIBNPPRESi + MIBMEUi > LIM_MIBPRES)
   ou 
   (MIBVENi + MIBNPVENi + MIBGITEi + LOCGITi + MIBPRESi + MIBNPPRESi + MIBMEUi <= LIM_MIBVEN 
    et 
    MIBPRESi + MIBNPPRESi + MIBMEUi > LIM_MIBPRES)
   ou 
   (MIBVENi + MIBNPVENi + MIBGITEi + LOCGITi + MIBPRESi + MIBNPPRESi + MIBMEUi > LIM_MIBVEN)
   ou 
   (BNCPROi + BNCNPi > LIM_SPEBNC)
  )

alors erreur DD08 ;
verif 1340:                                                                  
application : batch , iliad ;
si (APPLI_OCEANS=0) et 
   (V_NOTRAIT+0 < 20) et
      (  V_IND_TRAIT+0 = 4 et 
(
(  present(V_0AX) =1
 et 
   (inf( ( V_0AX - V_ANREV ) / 1000000) > 31 
     ou
    inf( ( V_0AX - V_ANREV ) / 1000000) = 0 
   )
 )
ou 
(  present(V_0AY) =1
 et 
   (inf( ( V_0AY - V_ANREV ) / 1000000) > 31 
     ou
    inf( ( V_0AY - V_ANREV ) / 1000000) = 0 
   )
 )
ou 
(  present(V_0AZ) =1
 et 
   (inf( ( V_0AZ - V_ANREV ) / 1000000) > 31 
     ou
    inf( ( V_0AZ - V_ANREV ) / 1000000) = 0 
   )
 )
)
)
alors erreur A02301;
verif 1341:                                                                    
application : batch , iliad ;
si (APPLI_OCEANS=0) et 
        (V_IND_TRAIT > 0 )
       et (  V_IND_TRAIT+0 = 4 et
(
(  present(V_0AX) =1
 et
  (
     (    inf ( V_0AX / 10000) * 10000
        - inf ( V_0AX / 1000000)* 1000000
     )/10000 > 12 
   ou
     (    inf ( V_0AX / 10000) * 10000
        - inf ( V_0AX / 1000000)* 1000000
     )/10000 =0
   )
)
ou
(  present(V_0AY) =1
 et
  (
     (    inf ( V_0AY / 10000) * 10000
        - inf ( V_0AY / 1000000)* 1000000
     )/10000 > 12 
   ou
     (    inf ( V_0AY / 10000) * 10000
        - inf ( V_0AY / 1000000)* 1000000
     )/10000 =0
   )
)
ou
(  present(V_0AZ) =1
 et
  (
     (    inf ( V_0AZ / 10000) * 10000
        - inf ( V_0AZ / 1000000)* 1000000
     )/10000 > 12 
   ou
     (    inf ( V_0AZ / 10000) * 10000
        - inf ( V_0AZ / 1000000)* 1000000
     )/10000 =0
   )
)
)
)
alors erreur A02302;
verif 1342:                                                                    
application : batch , iliad ;
si (APPLI_OCEANS=0) et 
        (V_IND_TRAIT > 0 )
       et (  V_IND_TRAIT+0 = 4 et
(
(  present(V_0AX) =1
  et
   (V_0AX -  inf(V_0AX/ 10000) * 10000) != V_ANREV
  et
   (V_0AX -  inf(V_0AX/ 10000) * 10000) != V_ANREV - 1
) 
ou
(  present(V_0AY) =1
  et
   (V_0AY -  inf(V_0AY/ 10000) * 10000) != V_ANREV
) 
ou
(  present(V_0AZ) =1
  et
   (V_0AZ -  inf(V_0AZ/ 10000) * 10000) != V_ANREV
   )
) 
)
alors erreur A02303;
verif 1352:                                                                    
application : batch ;
si 
   V_IND_TRAIT > 0
   et
(
(  present(V_0AX) =1
  et
  ( V_0AX + 0 < (1010000 + (V_ANREV - 1)))
)
ou
(  present(V_0AY) =1
  et
  ( V_0AY + 0 < (1010000 + V_ANREV))
)
ou
(  present(V_0AZ) =1
  et
  ( V_0AZ + 0 < (1010000 + V_ANREV))
)
)
alors erreur A02402;
verif 1353:
application : iliad ;
si (APPLI_OCEANS=0) et 
        (V_IND_TRAIT > 0 )
       et
    (
      ( V_IND_TRAIT+0 = 4 et (
       (  present(V_0AX) =1
           et
        ( V_0AX + 0 < (1010000 + (V_ANREV - 1)))
       )
           ou
       (  present(V_0AY) =1
           et
        ( V_0AY + 0 < (1010000 + V_ANREV))
       )
           ou
       (  present(V_0AZ) =1
           et
        ( V_0AZ + 0 < (1010000 + V_ANREV))
       ))
      )
       ou
       ( V_IND_TRAIT = 5 et (
        (  positif(V_0AX) =1
            et
         ( V_0AX + 0 < (1010000 + (V_ANREV - 1)))
        )
            ou
        (  positif(V_0AY) =1
            et
         ( V_0AY + 0 < (1010000 + V_ANREV))
        )
            ou
        (  positif(V_0AZ) =1
            et
         ( V_0AZ + 0 < (1010000 + V_ANREV))
        )
       ))
     )
alors erreur A02402;
verif 14000:
application : batch , iliad ;

si
   V_IND_TRAIT > 0
   et
   positif(REVCSXA + 0) = 1
   et
   positif(SALECS + 0) = 0

alors erreur A87801 ;
verif 14010:
application : batch , iliad ;

si
   V_IND_TRAIT > 0
   et
   positif(REVCSXB + 0) = 1
   et
   positif(SALECSG + 0) = 0

alors erreur A87802 ;
verif 14020:
application : batch , iliad ;

si
   V_IND_TRAIT > 0
   et
   positif(REVCSXC + 0) = 1
   et
   positif(ALLECS + 0) = 0

alors erreur A87803 ;
verif 14030:
application : batch , iliad ;

si
   V_IND_TRAIT > 0
   et
   positif(REVCSXD + 0) = 1
   et
   positif(INDECS + 0) = 0

alors erreur A87804 ;
verif 14040:
application : batch , iliad ;

si
   V_IND_TRAIT > 0
   et
   positif(REVCSXE + 0) = 1
   et
   positif(PENECS + 0) = 0

alors erreur A87805 ;
