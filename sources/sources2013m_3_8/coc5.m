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
verif 5000:
application : iliad, batch ;
si (APPLI_COLBERT+APPLI_OCEANS=0)et (
    ( NBPT > (V_BTNBP1 + 4 * APPLI_ILIAD + 400 * APPLI_BATCH) )
 et
    ( V_BTNBP1 + 0 > 0     )
 et
   	V_IND_TRAIT+0=4 et V_BTANC =1 et ((V_BTNI1+0) non dans (50,92)) 
 et     
        V_BTMUL !=1 et V_CODILIAD=1
 et
    (V_BT0AC=V_0AC ou V_BT0AM=V_0AM ou V_BT0AO=V_0AO ou V_BT0AD=V_0AD ou V_BT0AV=V_0AV)
    )
 alors erreur DD17;
verif 5001:
application : iliad , batch ;
si
   (
   NBPT > 20
   )
alors erreur A015;
verif 5050:
application : batch , iliad ;
si (APPLI_COLBERT+APPLI_OCEANS=0)et (
   V_ZDC+0 = 0 et V_BTMUL = 0
   et V_0AX+0 = 0 et V_0AY+0 = 0 et V_0AZ+0= 0
   et V_BTRNI > LIM_BTRNI10
   et RNI < V_BTRNI/5
   et V_BTANC+0 = 1  et ((V_BTNI1+0 )non dans (50,92)) 
   )
alors erreur DD05;
verif 5060:
application : iliad;
si (APPLI_OCEANS=0) et (
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

si (APPLI_OCEANS=0) et (
	   V_ZDC+0 = 0 et V_BTMUL+0 = 0
   et V_0AX+0 = 0 et V_0AY+0 = 0 et V_0AZ+0 = 0 et V_0AO+0 = 0
   et V_BTRNI > LIM_BTRNI
   et
       (RNI > V_BTRNI*5
	et
	RNI >= 100000)
   )
alors erreur IM1602;
verif 5105:
application : iliad ;

si
   APPLI_OCEANS = 0 
   et
   COD8UV > 500
   et 
   COD8UV > arr((TSHALLOV + TSHALLOC + TSHALLO1 + TSHALLO2 + TSHALLO3 + TSHALLO4
                 + CARTSV + CARTSC + CARTSP1 + CARTSP2 + CARTSP3 + CARTSP4
                 + CODEAJ + CODEBJ
                 + ALLOV + ALLOC + ALLO1 + ALLO2 + ALLO3 + ALLO4
                 + REMPLAV + REMPLAC + REMPLAP1 + REMPLAP2 + REMPLAP3 + REMPLAP4
                 + PRBRV + PRBRC + PRBR1 + PRBR2 + PRBR3 + PRBR4
                 + CARPEV + CARPEC + CARPEP1 + CARPEP2 + CARPEP3 + CARPEP4
                 + RVB1 + RVB2 + RVB3 + RVB4 + RENTAX + RENTAX5 + RENTAX6 + RENTAX7) * TX30/100)

alors erreur IM21 ;
verif 5100:
application : iliad ;
si 
   APPLI_OCEANS = 0 
   et 
   V_NOTRAIT + 0 != 14 
   et
   (
    V_BTANC + 0 = 1  
    et 
    ((V_BTNI1+0 )non dans (50,92)) 
    et 
    V_BTIMP + 0 <= 0 
    et 
    IINET > (LIM_BTIMP*2) 
    et 
    V_ZDC + 0 = 0
   )

alors erreur IM20 ;
verif 5101:
application : iliad;
si (APPLI_OCEANS=0) et (
V_BTIMP > LIM_BTIMP et IINET >= V_BTIMP * 2 et V_ZDC+0 = 0
)
alors erreur IM17;
verif 5102:
application : iliad;
si (APPLI_OCEANS=0) et (
   V_BTIMP > LIM_BTIMP et IINET <= V_BTIMP / 2 et V_ZDC+0 = 0
   )
alors erreur IM18;
verif 5103:
application : batch,iliad;
si (APPLI_COLBERT+APPLI_OCEANS=0)et (
   DAR > LIM_CONTROLE et V_BTRNI > 0 et ((V_BTNI1+0) non dans (50,92))
   )
alors erreur DD18;
verif 5104:
application : batch , iliad ;

si (APPLI_COLBERT+APPLI_OCEANS=0)et (
   V_BTANC = 1 et 
   ( DAGRI1 + DAGRI2 + DAGRI3 + DAGRI4 + DAGRI5 + DAGRI6 > LIM_CONTROLE + V_BTDBA) 
   )
alors erreur DD20;
verif 5203:
application : iliad,batch ;

si (APPLI_OCEANS=0)et 
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
application : batch , iliad  ;
si (APPLI_OCEANS = 0) et 
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
application : iliad , batch;
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
application : iliad   , batch ;
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
application : iliad , batch  ;
si
(
RG + 2 < PRODOM + PROGUY
)
alors erreur A800;
verif 5600:
application : iliad , batch ;
si
(
max(0 , IRB + TAXASSUR + IPCAPTAXT + TAXLOY + IHAUTREVT + PTOTD  
	    - IAVT - RCMAVFT - CICA - I2DH - CICORSE - CIRECH - CICAP
	    - CICHR - CICULTUR - CREREVET - CIGLO - CIDONENTR ) < IRANT
)
alors erreur A875;
verif 5700:
application : iliad , batch  ;
si (APPLI_OCEANS=0) et 
     (
       CSGIM > CSG 
     )
alors erreur A873;
verif corrective 5701:
application :  iliad ;
si (APPLI_OCEANS = 0) et 
    (
      present (CSGIM) = 1 et (V_NOTRAIT > 20)
    )
alors erreur A852;
verif 5710:
application : iliad , batch  ;
si
( 
  V_IND_TRAIT + 0 > 0
  et
  PRSPROV > PRS
)
alors erreur A872;
verif corrective 57101:
application :  iliad ;
si (APPLI_OCEANS = 0) et 
    (
      present (PRSPROV) = 1 et (V_NOTRAIT > 20)
    )
alors erreur A853 ;
verif corrective 8630:
application :  iliad ;
si (APPLI_OCEANS = 0) et 
  positif(AUTOVERSSUP + 0) = 1
  et
  positif(AUTOBICVV + AUTOBICPV + AUTOBNCV 
	  + AUTOBICVC + AUTOBICPC + AUTOBNCC
	  + AUTOBICVP + AUTOBICPP + AUTOBNCP
          + 0) = 0

alors erreur A863 ;
verif 5712:
application :  batch , iliad ;
si
    (
     CRDSIM > RDSN 
    )
alors erreur A871;
verif 57120:
application :  batch , iliad ;
si
    V_IND_TRAIT + 0 > 0
    et
    (CDISPROV + 0 > CDIS + 0
     ou
     (positif(CDISPROV + 0) = 1 et positif(GSALV + GSALC + 0) = 0))

alors erreur A868 ;
verif corrective 5713:
application :  iliad ;
si (APPLI_OCEANS = 0) et 
    (
     (V_NOTRAIT > 20) et positif(CRDSIM)=1
    )
alors erreur A851;
verif corrective 57131:
application :  iliad ;
si 
   APPLI_OCEANS = 0 
   et 
   V_NOTRAIT > 20
   et
   (positif(CSPROVYD) = 1
    ou
    positif(CSPROVYE) = 1
    ou
    positif(CSPROVYF) = 1
    ou
    positif(CSPROVYG) = 1
    ou
    positif(CSPROVYH) = 1
    ou
    positif(COD8YL) = 1
    ou
    positif(COD8YT) = 1
    ou
    positif(CDISPROV) = 1
    ou
    positif(IRANT) = 1
    ou
    positif(CRDSIM) = 1
    ou
    positif(CSGIM) = 1
    ou
    positif(DCSGIM) = 1
    ou
    positif(PRSPROV) = 1)

alors erreur A850;
verif 5714:
application :  batch , iliad ;
si
    (
	positif(DCSGIM)=1 et positif(CSGIM+0)!=1
    )
alors erreur A870;
