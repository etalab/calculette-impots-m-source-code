#*************************************************************************************************************************
#
#Copyright or © or Copr.[DGFIP][2017]
#
#Ce logiciel a été initialement développé par la Direction Générale des 
#Finances Publiques pour permettre le calcul de l'impôt sur le revenu 2013 
#au titre des revenus percus en 2012. La présente version a permis la 
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
       (V_REGCO+0) dans (1,2,3,5,6) 
       et 
       positif(IPVLOC + 0) = 1 
      )

alors erreur A094;
verif 4030:
application : iliad , batch ;
si
   V_REGCO + 0 = 4 
   et IPVLOC + 0 = 0
   et (( V_IND_TRAIT + 0 = 4
        et V_0AM + V_0AO + V_0AC + V_0AD + V_0AV + 0 != 0
       )
      ou
         V_IND_TRAIT + 0 = 5
      )
alors erreur A095;
verif 4032:
application : batch , iliad ;

si
     (V_REGCO = 2 ou V_REGCO = 3 ou V_REGCO = 4)
     et
     (V_NOTRAIT < 20 et BASRET >= 0 et IMPRET >= 0
     ou
     V_NOTRAIT >= 20 et BASRET > 0 et IMPRET > 0)

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
verif 4070:
application : batch , iliad ;
si
  (
   positif(BRAS) = 1 et V_CNR2 +0 != 1
  )
alors erreur A079;
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
   (
   (IPTEFP + IPTEFN + PRODOM + PROGUY > 0)
   et
   (V_CNR + 0 = 1)
   )
alors erreur A088;
verif 4110:
application : iliad, batch ;
si
     
  SALECSG + SALECS + ALLECS + INDECS + PENECS + 0 > 0 et SOMMEDD55 = 0

alors erreur DD55 ;
verif 4120:
application : iliad, batch;
si
    V_IND_TRAIT + 0 > 0
    et
    V_8ZT > ( somme(i=V,C,1..4: TPRi)
	      + somme (i=1..3: GLNiV)
	      + somme (i=1..3: GLNiC)
	      + RVTOT + T2RV 
	      + 2 ) 

alors erreur A090;
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
verif 4200:
application : iliad  , batch;
si ( 
    ( (V_NOTRAIT >= 20)  et (IPTEFP > 0)  et ( IPTEFN > 0) )
    ou  
    ( ((V_NOTRAIT+0) < 20)  et (IPTEFP >= 0)  et (IPTEFN >= 0)  et  (V_ROLCSG+0 < 40)) 
   )
alors erreur A80201;
verif 4201:
application : iliad  , batch;
si
       (
       V_NOTRAIT + 0 < 20
       et
       (IPTEFP + IPTEFN >= 0)
       et
       (PRODOM + PROGUY >= 0)
       )
     ou
       (
       V_NOTRAIT >= 20
       et
       (IPTEFP + IPTEFN > 0)
       et
       (PRODOM + PROGUY > 0)
       )
alors erreur A80202;
verif 4202:
application : iliad  , batch;
si
       (
       V_NOTRAIT + 0 < 20
       et
       SOMMEA802 > 0
       et
       PRODOM + PROGUY >= 0
       )
     ou
       (
       V_NOTRAIT >= 20
       et
       SOMMEA802 > 0
       et
       PRODOM + PROGUY > 0
       )
alors erreur A80203 ;
verif 4210:
application : iliad , batch;
si
    (
      (PROGUY + PRODOM +0 > 0)
       et
      (SOMMEA804 > 0 )
    )
alors erreur A804;
verif 4220:
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
verif 4221:
application : iliad  , batch;
si

  present(IPMOND) = 0
  et
  positif_ou_nul(TEFFHRC 
  ) = 1

alors erreur A88202 ;
verif 42885:
application : iliad  , batch;
si
	
 (
 (positif(CIIMPPRO2 + 0) = 1 et (1 - positif_ou_nul(BPVRCM)) = 1)
 ou
 (CIIMPPRO > 0 et SOMMEA885 = 0)
 )
        
alors erreur A885;
verif 4230:
application : iliad  , batch;
si
	(
	IPBOCH  > 0 et (CIIMPPRO + CIIMPPRO2 + REGCI + PRELIBXT + 0) = 0
	)
alors erreur A883 ;
verif 4240:
application : iliad , batch;
si
     
  REGCI > 0 et SOMMEA884 = 0
     
alors erreur A884;
verif 4250:
application : iliad , batch;
si
     (
       IPPNCS > 0 et positif(REGCI + CIIMPPRO + CIIMPPRO2 + 0) != 1 
     )
alors erreur A886;
verif 4260:
application : iliad , batch;
si
     (
       positif(present( NRBASE ) + present( NRINET )) = 1 
       et
       present( NRBASE ) + present( NRINET ) < 2
     )
alors erreur A086;
