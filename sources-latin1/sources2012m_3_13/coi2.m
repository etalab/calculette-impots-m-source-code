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
verif 20091:
application :   iliad  ;
si  (APPLI_OCEANS=0) et 
  (
   V_IND_TRAIT > 0 
       et
  positif(ANNUL2042) = 1
  )
alors erreur IM40;
verif 2009:
application :   iliad  ;
si  (APPLI_OCEANS=0) et 
  (
  present (V_BTCO2044P) = 1
 et
  present (CO2044P)   = 0
  )
alors erreur IM09;
verif 2010:
application :  batch , iliad  ;
si (APPLI_COLBERT+APPLI_OCEANS=0) et (
    (
     (V_BTCSGDED * (1-present(DCSG)) + DCSG) * (1-null(4 -V_REGCO)) > V_BTCSGDED +  LIM_CONTROLE 
    )
    et
    ( 
      1 - V_CNR > 0
    )    
    et
    ( 
      RDCSG > 0
    )    
     et
      ((APPLI_ILIAD = 1 et V_NOTRAIT+0 < 16)
      ou 
      ((V_BTNI1+0) non dans (50,92) et APPLI_BATCH = 1)))

alors erreur DD22;
verif 2020:
application : batch , iliad ;
si (APPLI_COLBERT+APPLI_ILIAD=1) et 
   V_IND_TRAIT > 0 
   et
   CHNFAC > 9
  
alors erreur A00101 ;
verif 20201:
application : batch , iliad ;

si (APPLI_COLBERT+APPLI_ILIAD=1) et 
   V_IND_TRAIT > 0
   et
   NBACT > 9

alors erreur A00102 ;
verif 20202:
application : batch , iliad ;

si (APPLI_COLBERT+APPLI_ILIAD=1) et 
   V_IND_TRAIT > 0
   et
  (
   RDENS > 9
   ou
   RDENL > 9
   ou
   RDENU > 9
   ou
   RDENSQAR > 9
   ou
   RDENLQAR > 9
   ou
   RDENUQAR > 9
  )
alors erreur A00103 ;
verif 20203:
application : batch , iliad ;

si (APPLI_COLBERT+APPLI_ILIAD=1) et 
   V_IND_TRAIT > 0
   et
   ASCAPA > 9

alors erreur A00104 ;
verif 2022:
application : batch , iliad ;

si (APPLI_BATCH+APPLI_ILIAD+APPLI_OCEANS=1) et 
   1 - V_CNR > 0
   et
   CHRFAC > 0 
   et 
   V_0CR > 0 
   et
   RFACC != 0

alors erreur DD16 ;
verif 2100:
application : iliad  ,batch;
si
   (
     IPELUS > 0
     et 
     positif(present(TSHALLOV) + present(TSHALLOC) + present(CARTSV) + present(CARTSC) + present(CARTSNBAV) + present(CARTSNBAC)) = 0
     et
     positif(present(ALLOV) + present(ALLOC) + present(REMPLAV) + present(REMPLAC) + present(REMPLANBV) + present(REMPLANBC)) = 0
   )
alors erreur A888;
verif 2110:
application : iliad  ,batch;
si (APPLI_OCEANS=0) et
(
REGCI+0 > IPBOCH+0
)
alors erreur A887;
verif 2111:
application : iliad  ,batch;
si (APPLI_OCEANS=0) et
(
REVFONC+0 > IND_TDR+0 et present(IND_TDR)=0
)
alors erreur A889;
verif 2101:
application : iliad , batch;
si

	IPSOUR > 0 et V_CNR + 0 = 0 et SOMMEA874 = 0 

alors erreur A874;
verif 2200:
application : iliad , batch ;

si
  (IPRECH + 0 > 0 ou IPCHER + 0 > 0) 
  et 
  SOMMEA877 = 0

alors erreur A877 ;
verif 2205:
application : batch , iliad  ;
si (APPLI_COLBERT+APPLI_OCEANS+APPLI_ILIAD=1) et 
	(
	V_IND_TRAIT > 0
	et
        CREFAM+0 > 500000
	)
alors erreur IM03;
verif 2220:
application : iliad , batch ;

si 
   AUTOVERSLIB > 0 
   et 
   SOMMEA862 = 0

alors erreur A862 ;
verif 2221:
application : iliad , batch ;

si
   CIINVCORSE + CICORSENOW + 0 > 0 
   et 
   SOMMEA879 = 0

alors erreur A879 ;
verif 2223:
application : iliad , batch ;

si
   CREFAM > 0 
   et 
   SOMMEA881 = 0

alors erreur A881 ;
verif 2229:
application : iliad  , batch ;

si
   CREAPP > 0 
   et 
   SOMMEA890 = 0

alors erreur A890 ;
verif 891:
application : iliad , batch ;

si
   CREPROSP > 0 
   et 
   SOMMEA891 = 0

alors erreur A891 ;
verif 893:
application : iliad , batch ;

si
   CREFORMCHENT > 0 
   et 
   SOMMEA893 = 0

alors erreur A893 ;
verif 894:
application : iliad , batch ;

si
   CREINTERESSE > 0 
   et 
   SOMMEA894 = 0

alors erreur A894 ;
verif 895:
application : iliad  , batch ;

si
   CREAGRIBIO > 0 
   et 
   SOMMEA895 = 0

alors erreur A895 ;
verif 896:
application : iliad , batch ;
si
   CREARTS > 0 
   et 
   SOMMEA896 = 0

alors erreur A896 ;
verif 898:
application : iliad , batch ;
si
   CRECONGAGRI > 0 
   et 
   SOMMEA898 = 0

alors erreur A898 ;
verif 899:
application : iliad , batch ;

si 
   CRERESTAU > 0 
   et 
   SOMMEA899 = 0

alors erreur A899 ;
verif 859:
application : iliad , batch ;

si
   PRESINTER > 0
   et
   SOMMEA859 = 0

alors erreur A859 ;
verif 900:
application : iliad , batch ;

si 
   CIDEBITTABAC > 0 
   et 
   SOMMEA860 = 0

alors erreur A860 ;
verif 2222:
application : iliad , batch ;
si
   CRIGA > 0  
   et 
   SOMMEA880 = 0         

alors erreur A880 ;
verif 2290:
application : batch , iliad ;
si  
   APPLI_OCEANS = 0 
   et
   (
    (PPEACV+0 > 0 et PPENJV+0 > 0) 
    ou
    (PPEACC+0 > 0 et PPENJC+0 > 0) 
    ou
    (PPEACP+0 > 0 et PPENJP+0 > 0) 
   )
alors erreur A542 ;
