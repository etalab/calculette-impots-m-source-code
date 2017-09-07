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
verif 5000:
application : iliad, batch ;
si (
    ( NBPT > (V_BTNBP + 4 * APPLI_ILIAD + 400 * APPLI_BATCH) )
 et
    ( V_BTNBP + 0 > 0     )
 et
   	V_IND_TRAIT+0=4 et V_BTANC =1 et ((V_BTNI1+0) non dans (50,92)) 
 et     
        V_BTMUL !=1 et V_CODILIAD=1
 et
    (V_BT0AC=V_0AC ou V_BT0AM=V_0AM ou V_BT0AO=V_0AO ou V_BT0AD=V_0AD ou V_BT0AV=V_0AV)
    )
 alors erreur DD17;
verif 5001:
application : pro , iliad , batch , oceans ;
si
   (
   NBPT > 20
   )
alors erreur A015;
verif 5050:
application : batch , iliad ;
si (
   V_ZDC+0 = 0 et V_BTMUL = 0
   et V_0AX+0 = 0 et V_0AY+0 = 0 et V_0AZ+0= 0
   et V_BTRNI > LIM_BTRNI10
   et RNI < V_BTRNI/5
   et V_BTANC+0 = 1  et ((V_BTNI1+0 )non dans (50,92)) 
   )
alors erreur DD05;
verif 5060:
application : iliad;
si (
	   V_ZDC+0 = 0 et V_BTMUL+0 = 0
   et V_0AX+0 = 0 et V_0AY+0 = 0 et V_0AZ+0 = 0 et V_0AO+0 = 0
   et V_BTRNI > LIM_BTRNI
   et
      (RNI > V_BTRNI*9
	et
	RNI < 100000)
   )
alors erreur IM1601;
verif 5061:
application : iliad;

si (
	   V_ZDC+0 = 0 et V_BTMUL+0 = 0
   et V_0AX+0 = 0 et V_0AY+0 = 0 et V_0AZ+0 = 0 et V_0AO+0 = 0
   et V_BTRNI > LIM_BTRNI
   et
       (RNI > V_BTRNI*5
	et
	RNI >= 100000)
   )
alors erreur IM1602;
verif 5100:
application : iliad;
si 
  (V_NOTRAIT+0  != 14) et
(
V_BTANC+0 = 1  et ((V_BTNI1+0 )non dans (50,92)) 
 et V_BTIMP+0 <= 0 et IINET > (LIM_BTIMP*2) et V_ZDC+0 = 0
)
alors erreur IM20;
verif 5101:
application : iliad;
si (
V_BTIMP > LIM_BTIMP et IINET >= V_BTIMP * 2 et V_ZDC+0 = 0
)
alors erreur IM17;
verif 5102:
application : iliad;
si (
   V_BTIMP > LIM_BTIMP et IINET <= V_BTIMP / 2 et V_ZDC+0 = 0
   )
alors erreur IM18;
verif 5103:
application : batch,iliad;
si (
   DAR > LIM_CONTROLE et V_BTRNI > 0 et ((V_BTNI1+0) non dans (50,92))
   )
alors erreur DD18;
verif 5104:
application : batch , iliad ;


si (
   V_BTANC = 1 et 
   (DAGRI1 + DAGRI2 + DAGRI3 + DAGRI4 + DAGRI5 + DAGRI6 > LIM_CONTROLE + V_BTDBA) 
   )
alors erreur DD20;
verif 5203:
application : pro , iliad,batch ;

si 
   positif(
   present ( BAFV ) 
 + present ( BAFC ) 
          ) = 1 
et
   positif(

   present ( BICEXV ) + present ( BICEXC ) + present ( BICNOV ) 
 + present ( BICNOC )  
 + present ( BI1AV ) + present ( BI1AC ) + present ( BICDNV ) 
 + present ( BICDNC )  
 + present ( BIHEXV ) + present ( BIHEXC ) + present ( BIHNOV ) 
 + present ( BIHNOC )  
 + present ( BIHDNV ) + present ( BIHDNC ) 
 + present ( BNCEXV ) + present ( BNCEXC ) 
 + present ( BNCREV ) + present ( BNCREC ) + present ( BN1AV ) 
 + present ( BN1AC ) + present ( BNCDEV ) + present ( BNCDEC ) 
 + present ( BNHEXV ) + present ( BNHEXC ) + present ( BNHREV ) 
 + present ( BNHREC ) + present ( BNHDEV ) + present ( BNHDEC ) 
 + present ( LOCPROCGAV ) + present ( LOCPROCGAC ) + present ( LOCDEFPROCGAV )
 + present ( LOCDEFPROCGAC ) + present ( LOCPROV ) + present ( LOCPROC )
 + present ( LOCDEFPROV ) + present ( LOCDEFPROC )

    ) = 1
alors erreur DD13;
verif 5205:
application : pro, batch , iliad  ;
si
( 
  ( (CIGARD > 0) et ( 1 - V_CNR > 0) et 
   (positif(RDGARD1) + positif(RDGARD2) + positif(RDGARD3) 
   + positif(RDGARD4) > ( EM7 + 0)))
 ou
  ( (CIGARD > 0) et ( 1 - V_CNR > 0) et 
   (positif(RDGARD1QAR) + positif(RDGARD2QAR) + positif(RDGARD3QAR) 
   + positif(RDGARD4QAR) > ( EM7QAR + 0)))
)
alors erreur DD10;
verif 5500:
application : pro , oceans , iliad , batch;
si
(
     (  (V_NOTRAIT+0 < 20)
	et
	((NRBASE  >= 0 ou NRINET  >= 0)
        et 
        ( V_REGCO !=3)))
   ou
      ( (V_NOTRAIT+0 > 20)
        et
	((NRBASE  > 0 ou NRINET  > 0)
        et
        ( V_REGCO !=3)))

)
alors erreur A085;
verif 5502:
application : pro , iliad   , batch , oceans;
si
(
((V_NOTRAIT+0 < 20)
et
(V_CNR + 0 = 1 et IND_TDR >= 0) 
)
ou
( (V_NOTRAIT+0 > 20)
et
(V_CNR + 0 = 1 et IND_TDR > 0))
)
alors erreur A087;
verif 5510:
application : pro , oceans , iliad , batch  ;
si
(
RG + 2 < PRODOM + PROGUY
)
alors erreur A800;
verif 5600:
application : pro , iliad , batch , oceans ;
si
(
max(0 , IRB + TAXASSUR + RPPEACO + PTOTD + AME 
	    - IAVT - RCMAVFT - CICA - I2DH - CICORSE - CIRECH - CICULTUR 
	    - CREREVET - CIDONENTR ) < IRANT
)
alors erreur A875;
verif 5700:
application : pro , iliad , batch  ;
si
     (
       CSGIM > CSG 
     )
alors erreur A873;
verif corrective 5701:
application :  iliad ;
si
    (
      present (CSGIM) = 1 et (V_NOTRAIT > 20)
    )
alors erreur A852;
verif 5710:
application : pro , oceans , iliad , batch  ;
si
( 
  V_IND_TRAIT + 0 > 0
  et
  PRSPROV > PRS
)
alors erreur A872;
verif corrective 57101:
application :  iliad ;
si
    (
      present (PRSPROV) = 1 et (V_NOTRAIT > 20)
    )
alors erreur A853;
verif corrective 5711:
application :  iliad ;
si
    (
      present (CSALPROV) = 1 et (V_NOTRAIT > 20)
    )
alors erreur A854;
verif 5712:
application :  batch , iliad, pro, oceans ;
si
    (
     CRDSIM > RDSN 
    )
alors erreur A871;
verif 57121:
application :  batch , iliad, pro, oceans ;
si
    V_IND_TRAIT + 0 > 0
    et
    (
     CSALPROV + 0 > CSAL + 0
     ou
     positif(CSALPROV + 0) = 1 et present(BPVOPTCS) = 0
    )
alors erreur A869;
verif corrective 5713:
application :  iliad ;
si
    (
     (V_NOTRAIT > 20) et positif(CRDSIM)=1
    )
alors erreur A851;
verif corrective 57131:
application :  iliad ;
si
    (
     (V_NOTRAIT > 20) et positif(IRANT)=1
    )
alors erreur A850;
verif 5714:
application :  batch , oceans , iliad, pro ;
si
    (
	positif(DCSGIM)=1 et positif(CSGIM+0)!=1
    )
alors erreur A870;
