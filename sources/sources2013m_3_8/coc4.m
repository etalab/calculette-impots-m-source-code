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
verif 4010:
application : iliad ,  batch ;
si (APPLI_OCEANS +APPLI_BATCH = 1) et 
      (
      V_8ZT >= 0 et V_REGCO+0 != 2
      )
alors erreur A089;
verif 4012:
application : iliad ;
si
(
positif(present(RE168)+present(TAX1649)) =1 et present(IPVLOC) = 1
)
alors erreur A990;
verif 4015:
application : iliad ;
si (APPLI_OCEANS = 0) et (
      ( V_8ZT >= 0 et V_CR2+0 != 1 et V_NOTRAIT + 0 < 20) 
      ou
      ( V_8ZT > 0 et V_CR2+0 != 1 et V_NOTRAIT >= 20)
                          ) 
alors erreur A089;
verif 4020:
application : iliad , batch;
si
      (
       V_IND_TRAIT + 0 > 0
       et
       (V_REGCO+0) dans (1,2,3,5,6,7) 
       et 
       positif(IPVLOC + 0) = 1 
      )

alors erreur A094;
verif 95:
application : iliad , batch ;

si
   V_REGCO + 0 = 4 
   et 
   IPVLOC + 0 = 0
   et (
       ( V_IND_TRAIT + 0 = 4
        et V_0AM + V_0AO + V_0AC + V_0AD + V_0AV + 0 != 0)
      ou
       ( V_IND_TRAIT + 0 = 5
	et positif(ANNUL2042 + 0) = 0)
      )
alors erreur A095 ;
verif 96:
application : batch , iliad ;

si
   V_REGCO dans (2,3,4) 
   et
   ((V_IND_TRAIT = 4 et BASRET >= 0 et IMPRET >= 0)
    ou
    (V_IND_TRAIT = 5 et BASRET > 0 et IMPRET > 0))

alors erreur A096 ;
verif 4050:
application : batch , iliad ;
si (APPLI_OCEANS = 0) et 
  (
  V_IND_TRAIT > 0
  et
  VALREGCO non dans (1,2,4) 
  )
alors erreur A082;
verif 4060:
application : batch , iliad;
si (APPLI_OCEANS = 0) et 
  (
  V_NOTRAIT+0 = 10
  et
   (VALREGCO = 2 ou VALREGCO = 4) et V_CNR2+0!=1 
  )
alors erreur A083;
verif 77:
application : batch , iliad ;

si
   positif(COD8XK + 0) = 1
   et
   V_REGCO + 0 != 3
   
alors erreur A077 ;
verif 78:
application : batch , iliad ;

si
   positif(COD8YK + 0) = 1
   et
   ((V_REGCO+0) dans (2,3,4))

alors erreur A078 ; 
verif 79:
application : batch , iliad ;

si
   positif_ou_nul(BRAS) = 1 
   et 
   V_CNR2 + 0 != 1
  
alors erreur A079 ;
verif 4080:
application : batch , iliad ;
si
   (
    V_NOTRAIT + 0 < 20 
   et
    present(BRAS) = 1 et V_REGCO+0 != 2 et V_CNR2+0 = 1
   )
  ou
   (
    V_NOTRAIT >= 20 
   et
    positif(BRAS) = 1 et V_REGCO+0 != 2 et V_CNR2+0 = 1
   )
alors erreur A080;
verif 4100:
application : iliad , batch ;

si
   (IPTEFP + IPTEFN 
    + SALEXTV + SALEXTC + SALEXT1 + SALEXT2 + SALEXT3 + SALEXT4
    + COD1AH + COD1BH + COD1CH + COD1DH + COD1EH + COD1FH
    + PRODOM + PROGUY 
    + CODDAJ + CODDBJ + CODEAJ + CODEBJ + 0) > 0
   et
   (V_REGCO + 0 = 2
    ou
    V_REGCO + 0 = 4)
   
alors erreur A088 ;
verif 4110:
application : iliad, batch ;
si
     
  SALECSG + SALECS + ALLECS + INDECS + PENECS + 0 > 0 et SOMMEDD55 = 0

alors erreur DD55 ;
verif 90:
application : iliad, batch;

si
    V_IND_TRAIT + 0 > 0
    et
    V_8ZT > ( somme(i=V,C,1..4: TPRi)
	      + somme (i=1..3: GLNiV)
	      + somme (i=1..3: GLNiC)
	      + RVTOT + T2RV 
	      + 2 ) 

alors erreur A090 ;
verif 4130:
application : iliad , batch;
si 
    ( V_NOTRAIT + 0 < 20
      et
     ( present(RMOND) = 1 ou present(DMOND) = 1 ) 
      et V_REGCO+0 !=2 )
    ou
    ( V_NOTRAIT >= 20
      et
     ( positif(RMOND) = 1 ou positif(DMOND) = 1 ) 
      et V_REGCO+0 !=2 )
	
alors erreur A091;
verif 4140:
application : iliad , batch;
si (
           V_NOTRAIT + 0 < 20
           et
           (
                  ( positif(IPTXMO)=1 et present(DMOND)!=1 et present(RMOND)!=1 )
           ou
                  ( (present(RMOND)=1 ou present(DMOND)=1) et positif(IPTXMO+0) !=1 )
           )
   )
        ou
   (
           V_NOTRAIT >= 20
           et
           (
                   ( positif(IPTXMO)=1 et positif(DMOND)!=1 et positif(RMOND)!=1 )
           ou
                   ( (positif(RMOND)=1 ou positif(DMOND)=1) et positif(IPTXMO+0) !=1 )
           )
   )
alors erreur A092;
verif 4150:
application : iliad , batch;
si  (
     V_NOTRAIT + 0 < 20
     et
     present(RMOND) = 1 et present(DMOND) = 1
    )
  ou
    (
     V_NOTRAIT >= 20
     et
     positif(RMOND) = 1 et positif(DMOND) = 1
    )
alors erreur A093;
verif 8021:
application : iliad  , batch;

si (
       ( (V_NOTRAIT >= 20) et (IPTEFP > 0) et ( IPTEFN > 0) )
     ou
       ( ((V_NOTRAIT+0) < 20) et (IPTEFP >= 0) et (IPTEFN >= 0) et (V_ROLCSG+0 < 40))
   )
alors erreur A80201 ;
verif 8022:
application : iliad , batch ;

si
   (
    V_NOTRAIT + 0 < 20
    et
    IPTEFP + IPTEFN >= 0
    et
    PRODOM + PROGUY + CODDAJ + CODDBJ + CODEAJ + CODEBJ >= 0
   )
   ou
   (
    V_NOTRAIT >= 20
    et
    IPTEFP + IPTEFN > 0
    et
    PRODOM + PROGUY + CODDAJ + CODDBJ + CODEAJ + CODEBJ > 0
   )

alors erreur A80202 ;
verif 8023:
application : iliad , batch ;
si
   (
    V_NOTRAIT + 0 < 20
    et
    SOMMEA802 > 0
    et
    PRODOM + PROGUY + CODDAJ + CODDBJ + CODEAJ + CODEBJ >= 0
   )
   ou
   (
    V_NOTRAIT >= 20
    et
    SOMMEA802 > 0
    et
    PRODOM + PROGUY + CODDAJ + CODDBJ + CODEAJ + CODEBJ > 0
   )

alors erreur A80203 ;
verif 803:
application : iliad  , batch;

si
   V_IND_TRAIT > 0
   et
   positif(CODDAJ + CODDBJ + CODEAJ + CODEBJ + 0) = 1
   et
   V_REGCO + 0 != 1

alors erreur A803 ;
verif 804:
application : iliad , batch;
si
    (
      (PROGUY + PRODOM +0 > 0)
       et
      (SOMMEA804 > 0 )
    )
alors erreur A804;
verif 8821:
application : iliad  , batch;

si
  (
   IPMOND > 0
   et
   (present(IPTEFP) = 0 et present(IPTEFN) = 0)
  )
  ou
  (
   (present(IPTEFP) = 1 ou present(IPTEFN) = 1)
   et
   present(IPMOND) = 0
  )

alors erreur A88201 ;
verif 8822:
application : iliad  , batch;

si
   (present(IPMOND) 
    + present(SALEXTV) + present(SALEXTC) + present(SALEXT1) + present(SALEXT2) + present(SALEXT3) + present(SALEXT4)
    + present(COD1AH) + present(COD1BH) + present(COD1CH) + present(COD1DH) + present(COD1EH) + present(COD1FH)) = 0
   et
   positif_ou_nul(TEFFHRC + COD8YJ) = 1

alors erreur A88202 ;
verif 8851:
application : iliad  , batch;

si
   positif(CIIMPPRO2 + 0) = 1 
   et 
   present(BPVSJ) = 0
        
alors erreur A88501 ;
verif 8852:
application : iliad  , batch;

si
   positif(COD8XV + 0) = 1 
   et 
   present(COD2FA) = 0
        
alors erreur A88502 ;
verif 8853:
application : iliad  , batch;

si
   positif(CIIMPPRO + 0) = 1 
   et 
   somme(i=V,C,P:present(BA1Ai) + present(BI1Ai) + present(BN1Ai)) = 0
        
alors erreur A88503 ;
verif 8854:
application : iliad  , batch;

si
   positif(COD8XF + 0) = 1 
   et 
   present(BPV18V) + present(BPV18C) = 0
        
alors erreur A88504 ;
verif 8855:
application : iliad  , batch;

si
   positif(COD8XG + 0) = 1 
   et 
   present(BPCOPTV) + present(BPCOPTC) = 0
        
alors erreur A88505 ;
verif 8856:
application : iliad  , batch;

si
   positif(COD8XH + 0) = 1 
   et 
   present(BPV40V) + present(BPV40C) = 0
        
alors erreur A88506 ;
verif 883:
application : iliad  , batch;

si
   IPBOCH > 0 
   et 
   CIIMPPRO + CIIMPPRO2 + REGCI + PRELIBXT + COD8XF + COD8XG + COD8XH + COD8XV + 0 = 0
	
alors erreur A883 ;
verif 884:
application : iliad , batch;

si
   REGCI > 0 
   et 
   SOMMEA884 = 0
     
alors erreur A884 ;
verif 886:
application : iliad , batch;

si
   IPPNCS > 0 
   et 
   positif(REGCI + CIIMPPRO + CIIMPPRO2 + COD8XV + COD8XF + COD8XG + COD8XH + 0) != 1 
     
alors erreur A886 ;
verif 4260:
application : iliad , batch;
si
     (
       positif(present( NRBASE ) + present( NRINET )) = 1 
       et
       present( NRBASE ) + present( NRINET ) < 2
     )
alors erreur A086;
verif 4380:
application : iliad ;
si
                      ((DEFRI = 1)  et (PREM8_11=1) et (VARR30R32=0))
alors erreur IM42 ;
verif 4382:
application : iliad ;
si
                      ((DEFRI = 1)  et (CODERAPHOR=0))
alors erreur IM42 ;
verif 4384:
application : iliad ;
si
                      ((DEFRI = 1)  et (PREM8_11 >0) et (VARR30R32>0))
alors erreur A992 ;
verif 4386:
application : iliad ;
si
                      ((DEFRI = 1)  et (CODERAPHOR>0))
alors erreur A992 ;
