#*************************************************************************************************************************
#
#Copyright or © or Copr.[DGFIP][2017]
#
#Ce logiciel a été initialement développé par la Direction Générale des 
#Finances Publiques pour permettre le calcul de l'impôt sur le revenu 2011 
#au titre des revenus perçus en 2010. La présente version a permis la 
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
application : batch, pro , iliad  ;
si (
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
    (BPVOPTCS > 99999999)
    ou
    (GSALV > 99999999)
    ou
    (GSALC > 99999999)
    )
   )
alors erreur A00105;
verif non_auto_cc 1101:
application : pro , oceans ,  iliad , batch ;
si
(
  RCMAVFT > PLAF_AF 
  et
  positif(RCMABD + REVACT + REVACTNB + RCMHAD + DISQUO + DISQUONB + RCMHAB + INTERE + INTERENB + 0) = 0
)
alors erreur A21801 ;
verif non_auto_cc 1102:
application : pro , oceans ,  iliad , batch ;
si
(
  DIREPARGNE > PLAF_AF
  et
  (PPLIB + RCMLIB + RCMHAD + RCMHAB + DISQUO + DISQUONB + INTERE + INTERENB + 0 = 0)
)
alors erreur A21802;
verif 1103:
application :  pro , iliad , batch;
si
( (1 - V_CNR > 0) et V_REGCO+0 != 2 et V_REGCO+0 != 4 et 
(
   (
    RCMABD + RCMHAD + RCMHAB + REVACT + DISQUO + INTERE + 0 > 0
    et 
    RCMAVFT > ((1/3) * (RCMABD + RCMHAD + RCMHAB + REVACT + DISQUO + INTERE)) +  PLAF_AF
   )
 ou
   (
     DIREPARGNE > ((PPLIB + RCMLIB + RCMHAD + RCMHAB + DISQUO + INTERE) * (18/100)) + PLAF_AF
     et
     PPLIB + RCMLIB + RCMHAD + RCMHAB + DISQUO + INTERE + 0 > 0
   )
)
)
alors erreur DD04;
verif 1104:
application : pro , iliad , batch ;
si
(
  (1 - V_CNR + 0 > 0) et  
  (
  RCMFR > LIM_CONTROLE  et 
   (
    (RCMFR > 0.30 * ( RCMABD + RCMHAD + REVACT + DISQUO + 0 ))
    ou
    ((RCMABD + RCMHAD + REVACT + DISQUO + 0 = 0) et
     (RCMTNC + RCMAV + RCMHAB + REGPRIV + REVPEA + PROVIE + RESTUC + INTERE + 0 > 0))
   )
  )
)
alors erreur DD03;
verif  1106:
application : batch, iliad, pro, oceans ;
si
   (
   RCMSOC > RCMAV + PROVIE 
          + RCMHAD + DISQUO 
          + RCMHAB + INTERE  
          + RCMABD + REVACT 
	  + 1

   )
alors erreur A222;
verif  1107:
application : batch, iliad, pro, oceans ;

si
    V_IND_TRAIT + 0 > 0
    et
    REVSUIS + 0 > RCMABD + REVACT + 0

alors erreur A224 ;
verif 1108:
application : iliad ;
si
(
        (V_IND_TRAIT+0=4 et V_NOTRAIT+0<14) 
         et
	 (
	(RCMAVFT > PLAF_AF
             et 
	( RCMABD+RCMHAD+RCMHAB > 0)
             et
	RCMAVFT > ( arr ( 40 * ( RCMABD+RCMHAD+RCMHAB
	) / 100))
        )
	ou
	(DIREPARGNE > PLAF_AF
	et
	( PPLIB + RCMLIB + RCMHAD + RCMHAB > 0)
	et
	DIREPARGNE > ( arr ( 20 * (PPLIB + RCMLIB + RCMHAD + RCMHAB 
					 )/100))
	)
)
)
alors erreur IM1501;
verif 1109:
application : iliad ;
si
(
       (V_NOTRAIT+0 >=14) et
       (
	(RCMAVFT > PLAF_AF et RCMAVFT <= PLAF_AF2
             et 
	( RCMABD+RCMHAD+RCMHAB > 0)
             et
	RCMAVFT > ( arr ( 40 * ( RCMABD+RCMHAD+RCMHAB
	) / 100))
        )
	ou
	(DIREPARGNE > PLAF_AF et DIREPARGNE <= PLAF_AF2
	et
	( PPLIB + RCMLIB + RCMHAD + RCMHAB > 0)
	et
         DIREPARGNE > (arr (20*(PPLIB + RCMLIB + RCMHAD + RCMHAB 
				      )/100))
	)
)
)
alors erreur IM1502;
verif 11220:
application : batch ;
si
(
       (V_NOTRAIT+0=10)
       et
       (
	(RCMAVFT > PLAF_AF2
             et 
	( RCMABD+RCMHAD+RCMHAB+REVACT+DISQUO+INTERE > 0)
             et
	RCMAVFT > ( arr ( 40 * ( RCMABD+RCMHAD+RCMHAB+REVACT+DISQUO+INTERE ) / 100)))
	ou
	( DIREPARGNE > PLAF_AF2
	  et
	  RCMHAD > 0
	  et
	  DIREPARGNE > ( arr( 20*(PPLIB + RCMLIB + RCMHAD + RCMHAB + DISQUO + INTERE )/100 ))
	)
      )
)
alors erreur A220;
verif 11221:
application : iliad ;
si
(
        ((V_IND_TRAIT+0=5 et V_NOTRAIT+0>14) ou V_NOTRAIT+0=14)
	et
	(
	(RCMAVFT > PLAF_AF2
             et 
	( RCMABD+RCMHAD+RCMHAB+REVACT+DISQUO+INTERE > 0)
             et
	RCMAVFT > ( arr ( 40 * ( RCMABD+RCMHAD+RCMHAB+REVACT+DISQUO+INTERE ) / 100)))
	ou
	( DIREPARGNE > PLAF_AF2
	  et
	  PPLIB + RCMLIB + RCMHAD > 0
	  et
	  DIREPARGNE > ( arr( 20*(PPLIB + RCMLIB + RCMHAD + RCMHAB + DISQUO + INTERE )/100 ))
	)
)
)
alors erreur A220;
verif 1200:
application : pro ,  oceans , batch ,iliad;
si
    (
        (  V_0CF + V_0CR + V_0CH + V_0CI + V_0DJ + V_0DN +V_0DP +0  = 0 )
      et 
        (SOMMEA030 > 0)
      )
alors erreur A030;
verif 12718:
application : pro , oceans , batch , iliad ;
si
    (
       ( CIAQCUL > 0 )
      et 
       ( SOMMEA718 =0 )
    )
alors erreur A718;
verif 12719:
application : pro , oceans , batch , iliad ;
si
    (
       ( RDMECENAT > 0 )
      et 
       ( SOMMEA719 =0 )
    )
alors erreur A719;
verif 1202:
application : pro , oceans , batch , iliad ;
si
    (
       ( V_0AC + V_0AD + 0 > 0 )
      et 
      ( SOMMEA031 >0 )
    )
alors erreur A031;
verif 1210:
application : pro , oceans , iliad , batch;
si
  (
      V_IND_TRAIT > 0
      et
      positif(TREVEX) = 1
      et 
      SOMMEA805 = 0
  )
alors erreur A805;
verif 1215:
application : pro , oceans , iliad , batch ;

si
   (V_IND_TRAIT > 0 )
   et
   present(BASRET) + present(IMPRET) = 1

alors erreur A821 ;
verif 12220:
application : pro , oceans , iliad , batch ;

si 
   (V_IND_TRAIT > 0 )
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
alors erreur A22301 ;
verif 12221:
application : pro , oceans , iliad , batch ;

si 
   (V_IND_TRAIT > 0 )
   et
   (
    present(REVACT) + present(REVACTNB) = 1
    ou
    present(REVPEA) + present(REVPEANB) = 1
    ou
    present(PROVIE) + present(PROVIENB) = 1
    ou
    present(DISQUO) + present(DISQUONB) = 1
    ou 
    present(RESTUC) + present(RESTUCNB) = 1
    ou
    present(INTERE) + present(INTERENB) = 1
   )
alors erreur A22302 ;
verif 12222:
application : pro , oceans , iliad , batch ;

si 
   (V_IND_TRAIT > 0 )
   et
   (FONCINB < 2 ou FONCINB > 30)

alors erreur A42501 ;
verif 12223:
application : pro , oceans , iliad , batch ;

si 
   (V_IND_TRAIT > 0 )
   et
   present(FONCI) + present(FONCINB) = 1

alors erreur A42502 ;
verif 12224:
application : pro , oceans , iliad , batch ;

si 
   (V_IND_TRAIT > 0 )
   et
   (REAMORNB < 2 ou REAMORNB > 14)

alors erreur A42601 ;
verif 12225:
application : pro , oceans , iliad , batch ;

si 
   (V_IND_TRAIT > 0 )
   et
   present(REAMOR) + present(REAMORNB) = 1

alors erreur A42602 ;
verif 1222:
application : pro , oceans , iliad  , batch;
si
        (V_IND_TRAIT > 0 )
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
alors erreur A14001;
verif 1223:
application : pro , oceans , iliad  , batch;
si
        (V_IND_TRAIT > 0 )
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
alors erreur A13901;
verif 1224:
application : pro , oceans , iliad  , batch;
si
    (
     (present(CARTSV) + present(CARTSNBAV) = 1)
     ou
     (present(CARTSC) + present(CARTSNBAC) = 1)
     ou
     (present(CARTSP1) + present(CARTSNBAP1) = 1)
     ou
     (present(CARTSP2) + present(CARTSNBAP2) = 1)
     ou
     (present(CARTSP3) + present(CARTSNBAP3) = 1)
     ou
     (present(CARTSP4) + present(CARTSNBAP4) = 1)
     ou
     (present(REMPLAV) + present(REMPLANBV) = 1)
     ou
     (present(REMPLAC) + present(REMPLANBC) = 1)
     ou
     (present(REMPLAP1) + present(REMPLANBP1) = 1)
     ou
     (present(REMPLAP2) + present(REMPLANBP2) = 1)
     ou
     (present(REMPLAP3) + present(REMPLANBP3) = 1)
     ou
     (present(REMPLAP4) + present(REMPLANBP4) = 1)
    )
alors erreur A14002;
verif 1225:
application : pro , oceans , iliad  , batch;
si
    (
     (present(CARPEV) + present(CARPENBAV) = 1)
     ou
     (present(CARPEC) + present(CARPENBAC) = 1)
     ou
     (present(CARPEP1) + present(CARPENBAP1) = 1)
     ou
     (present(CARPEP2) + present(CARPENBAP2) = 1)
     ou
     (present(CARPEP3) + present(CARPENBAP3) = 1)
     ou
     (present(CARPEP4) + present(CARPENBAP4) = 1)
     ou
     (present(PENSALV) + present(PENSALNBV) = 1)
     ou
     (present(PENSALC) + present(PENSALNBC) = 1)
     ou
     (present(PENSALP1) + present(PENSALNBP1) = 1)
     ou
     (present(PENSALP2) + present(PENSALNBP2) = 1)
     ou
     (present(PENSALP3) + present(PENSALNBP3) = 1)
     ou
     (present(PENSALP4) + present(PENSALNBP4) = 1)
     ou
     (present(RENTAX) + present(RENTAXNB) = 1)
     ou
     (present(RENTAX5) + present(RENTAXNB5) = 1)
     ou
     (present(RENTAX6) + present(RENTAXNB6) = 1)
     ou
     (present(RENTAX7) + present(RENTAXNB7) = 1)
    )
alors erreur A13902;
verif 1220:
application : pro , oceans , iliad  , batch;
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
application : pro , oceans , iliad  , batch;
si
    (
     (present(PEBFV)= 1 et present(COTFV)=0)
     ou
     (present(PEBFC)= 1 et present(COTFC)=0)
     ou
     (present(PEBF1)= 1 et present(COTF1)=0)
     ou
     (present(PEBF2)= 1 et present(COTF2)=0)
     ou
     (present(PEBF3)= 1 et present(COTF3)=0)
     ou
     (present(PEBF4)= 1 et present(COTF4)=0)
     ou
     (present(COTFV)= 1 et present(PEBFV)=0)
     ou
     (present(COTFC)= 1 et present(PEBFC)=0)
     ou
     (present(COTF1)= 1 et present(PEBF1)=0)
     ou
     (present(COTF2)= 1 et present(PEBF2)=0)
     ou
     (present(COTF3)= 1 et present(PEBF3)=0)
     ou
     (present(COTF4)= 1 et present(PEBF4)=0)
     )
alors erreur A14102;
verif 1301:
application : iliad ;
si
        (V_IND_TRAIT > 0 )
       et
     (
      BAFV > PLAF_FORFBA  ou  BAFC > PLAF_FORFBA  ou  BAFP > PLAF_FORFBA
     )
alors erreur IM02;
verif 1312:
application : batch ,iliad;
si ( (positif_ou_nul(NAPT) = 0) 
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
application : batch , iliad , pro ;
si                                                                         
(                                                                              
pour un i dans V,C,P:
   (MIBVENi + MIBNPVENi > LIM_MIBVEN)
 ou  (MIBPRESi + MIBNPPRESi > LIM_MIBPRES)
 ou ((MIBVENi +MIBNPVENi <= LIM_MIBVEN) et (MIBPRESi +MIBNPPRESi > LIM_MIBPRES))
 ou (MIBVENi + MIBNPVENi + MIBPRESi + MIBNPPRESi > LIM_MIBVEN)
 ou (BNCPROi + BNCNPi > LIM_SPEBNC)
)                                                                              
alors erreur DD08;
verif 1340:                                                                  
application : batch , iliad , pro ;
si (V_NOTRAIT+0 < 20) et
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
application : batch , iliad , pro ;
si 
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
application : batch , iliad , pro ;
si
        (V_IND_TRAIT > 0 )
       et (  V_IND_TRAIT+0 = 4 et
(
(  present(V_0AX) =1
  et
   (V_0AX -  inf(V_0AX/ 10000) * 10000) != V_ANREV
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
application : batch , pro ;
si 
        (V_IND_TRAIT > 0 )
       et
(
(  present(V_0AX) =1
  et
  ( V_0AX + 0 < 1012005)
)
ou
(  present(V_0AY) =1
  et
  ( V_0AY + 0 < 1012005)
)
ou
(  present(V_0AZ) =1
  et
  ( V_0AZ + 0 < 1012005)
)
)
alors erreur A02402;
verif 1353:
application : iliad ;
si
        (V_IND_TRAIT > 0 )
       et
    (
      ( V_IND_TRAIT+0 = 4 et (
       (  present(V_0AX) =1
           et
        ( V_0AX + 0 < 1012004)
       )
           ou
       (  present(V_0AY) =1
           et
        ( V_0AY + 0 < 1012004)
       )
           ou
       (  present(V_0AZ) =1
           et
        ( V_0AZ + 0 < 1012004)
       ))
      )
       ou
       ( V_IND_TRAIT = 5 et (
        (  positif(V_0AX) =1
            et
         ( V_0AX + 0 < 1012004)
        )
            ou
        (  positif(V_0AY) =1
            et
         ( V_0AY + 0 < 1012004)
        )
            ou
        (  positif(V_0AZ) =1
            et
         ( V_0AZ + 0 < 1012004)
        )
       ))
     )
alors erreur A02402;
