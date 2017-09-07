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
verif 2500:
application : pro , iliad , batch;
si
  (
   FRNV > (TSHALLOV + ALLOV) * 0.10
  et
   COSBV > 0 
  et 
   PRBRV + PALIV + 0 = 0
  )
alors erreur I00101;
verif 2501:
application : pro , iliad , batch;
si
(
(FRNC > (TSHALLOC+ ALLOC) *0.10)
et
COSBC > 0 et (PRBRC + PALIC + 0 = 0)
)
alors erreur I00102;
verif 2502:
application : pro , iliad, batch;
si
(
  (
   (
    ( FRN1 > (TSHALLO1 + ALLO1) *0.10)
          et (PRBR1 + PALI1 + 0 = 0)
   )
   ou
   (
     ( FRN2 > (TSHALLO2 + ALLO2) *0.10)
          et (PRBR2 + PALI2 + 0 = 0)
   )
   ou
   (
     ( FRN3 > (TSHALLO3 + ALLO3) *0.10)
          et (PRBR3 + PALI3 + 0 = 0)
   )
   ou
   (
     ( FRN4 > (TSHALLO4 + ALLO4) *0.10)
          et (PRBR4 + PALI4 + 0 = 0)
   )
  ) et COSBP > 0
)
alors erreur I00103;
verif 2503:
application : pro , iliad ;
si (
		((RDSYVO > 0) et (positif(COSBV+0) = 0))
	ou
		((RDSYCJ > 0) et (positif(COSBC+0) = 0))
	ou
		((RDSYPP > 0) et (positif(COSBP+0) = 0))
	)
alors erreur IM07;
verif 2504:
application : pro , iliad ;
si
  (
  V_IND_TRAIT > 0
  et
  CREPROSP > LIM_PROSP
  )
alors erreur IM08;
verif 2511:
application : pro , iliad ;
si
(
((RDREP > 0) et (present(RDFREP) = 0))
ou
((RDDOUP > 0) et (present(RDFDOU) = 0))
)
alors erreur IM06;
verif 2540:
application : batch , iliad ;
si 
  (
  (
   RFORDI + FONCI + REAMOR 
 + RFDORD  
 + RFDHIS  
 + RFDANT  
   > LIM_BTREVFONC) et (V_BTANC = 1) et (V_BTIRF = 0)
  )
alors erreur DD26;
verif 5108:
application : batch , iliad,pro ;
si 
 (
   V_IND_TRAIT+0 = 4 et 
   (1 - V_CNR > 0) et
   ((REPSNO3 > LIM_CONTROLE + V_BTPME3)
   ou
   (REPSNO2 > LIM_CONTROLE + V_BTPME2)
   ou
   (REPSNO1 > LIM_CONTROLE + V_BTPME1))
   et (positif(NATIMP)=1)
 )
alors erreur DD27;
verif 51091:
application : batch , iliad,pro ;
si 
 (
  (CREPROSP > 0) et (positif(V_BTCREPROSP)=1)
 )
alors erreur DD28;
verif 5110:
application : batch , iliad,pro ;
si 
 (
  ((REPDON03 > LIM_CONTROLE + V_BTDONS5)
   ou
   (REPDON04 > LIM_CONTROLE + V_BTDONS4)
   ou
   (REPDON05 > LIM_CONTROLE + V_BTDONS3)
   ou
   (REPDON06 > LIM_CONTROLE + V_BTDONS2)
   ou
   (REPDON07 > LIM_CONTROLE + V_BTDONS1))
   et (positif(NATIMP)=1)
   et (V_CNR +0 = 0)
 )
alors erreur DD29;
verif 3900:
application : batch , iliad , pro ;
si

 positif(PERPIMPATRIE + 0) = 1
 et
 positif(V_BTPERPIMP + 0) = 1

alors erreur DD35 ;
verif 3910:
application : batch , iliad , pro ;
si

  (1 - V_CNR > 0) et V_REGCO+0 !=2 et V_REGCO+0 != 4
  et
  PTZDEVDUR > 0	
  et
  V_BTRFRN2 + 0 > PLAF_RFRN2  

alors erreur DD3601;
verif 3911:
application : batch , iliad , pro ;
si

  (1 - V_CNR > 0) et V_REGCO+0 !=2 et V_REGCO+0 != 4
  et
  PTZDEVDUR > 0	
  et
  positif(V_BTRFRN2 + 0) = 0  

alors erreur DD3602;
verif 3920:
application : batch , iliad , pro ;
si
  (1 - V_CNR > 0) et V_REGCO+0 !=2 et V_REGCO+0 != 4
  et
  positif(V_BTRFRN2 + 0) = 1
  et
 ( pour un i dans V,C,P:
   ( AUTOBICVi > LIM_MIBVEN )
   ou
   ( AUTOBICPi > LIM_MIBPRES )
   ou
   ( AUTOBICVi + AUTOBICPi > LIM_MIBVEN ) 
   ou
   ( AUTOBNCi > LIM_SPEBNC )
 )
alors erreur DD37;
verif 3930:
application : batch , iliad , pro ;
si
  (1 - V_CNR > 0) et V_REGCO+0 !=2 et V_REGCO+0 != 4
  et
  V_BTRFRN2 + 0 > arr(LIM_BARN2 * V_BTNBP2)
  et
 ( pour un i dans V,C,P:
     positif(AUTOBICVi + AUTOBICPi + AUTOBNCi ) = 1 )
alors erreur DD3801;
verif 3940:
application : batch , iliad , pro ;
si
  (1 - V_CNR > 0) et V_REGCO+0 !=2 et V_REGCO+0 != 4
  et
  positif(V_BTRFRN2 + 0) = 0
  et
 ( pour un i dans V,C,P:
     positif(AUTOBICVi + AUTOBICPi + AUTOBNCi ) = 1 )

alors erreur DD3802;
verif 2560:
application : pro , oceans , iliad  ;
si
        (V_IND_TRAIT > 0)
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
alors erreur A00103;
verif 2559:
application : pro , oceans , iliad  ;
si
	(V_IND_TRAIT > 0)
	et
	(
	NBACT > 9
	)
alors erreur A00102;
verif 2558:
application : pro , batch , oceans , iliad  ;
si
	(V_IND_TRAIT > 0)
	et
	(
	RNBRLOG > 3 
	)
alors erreur A732;
verif 2554:
application : pro , batch , oceans , iliad  ;
si

   RNBRLOG = 1 
   et
   CICHO2BAIL + CIBOIBAIL + CINRJBAIL + CIDEP15 > PLAF_DEVDUR

alors erreur A73301;
verif 2555:
application : pro , batch, oceans , iliad  ;
si

   RNBRLOG = 2 
   et
   CICHO2BAIL + CIBOIBAIL + CINRJBAIL + CIDEP15 > PLAF_DEVDUR * 2

alors erreur A73302;
verif 2556:
application : pro , batch , oceans , iliad  ;
si

   RNBRLOG = 3 
   et
   CICHO2BAIL + CIBOIBAIL + CINRJBAIL + CIDEP15 > PLAF_DEVDUR * 3

alors erreur A73303;
verif 250:
application : pro , batch , oceans , iliad  ;
si

  positif(RNBRLOG + 0) = 0
  et
  positif(CICHO2BAIL + CIBOIBAIL + CINRJBAIL + CIDEP15 + 0) = 1

alors erreur A73401;
verif 251:
application : pro , batch , oceans , iliad  ;
si

  positif(RNBRLOG + 0) = 1
  et
  positif(CICHO2BAIL + CIBOIBAIL + CINRJBAIL + CIDEP15 + 0) = 0

alors erreur A73402;
verif 252:
application : pro , batch , oceans , iliad  ;
si

  positif(PTZDEVDUR + 0) = 1
  et
  positif(CRECHOCON2 + CRECHOBOI + CRENRJRNOUV + CRECHOBAS + 0) = 0

alors erreur A735;
verif 253:
application : pro , batch , oceans , iliad  ;
si

   positif(INDLOCNEUF + 0) = 1
   et
   positif(INVLOCNEUF + 0) = 0

alors erreur A73701;
verif 254:
application : pro , batch , oceans , iliad  ;
si

   positif(INDLOCRES + 0) = 1
   et
   positif(INVLOCRES + 0) = 0

alors erreur A73702;
verif 260:
application : pro , batch , oceans , iliad  ;
si

   positif(SINISFORET + 0) = 1
   et
   positif(RDFORESTRA + 0) = 0

alors erreur A738;
verif 261:
application : pro , batch , oceans , iliad  ;
si
   positif(OPTPLAF15 + 0) = 1
   et
   positif(INVLGAUTRE
            + INVLGDEB2010 + INVLOG2009
            + INVSOC2010 + INVLOGSOC + INVSOCNRET
            + INVRETRO1 + INVRETRO2
	    + INVIMP + INVAUTRE + INVDOMRET50
	    + INVDOMRET60 + NRETROC50 
	    + NRETROC40 + INVDIR2009
	    + INVAUTEN2009 + INVENDI + AUTRENT + 0) = 0
alors erreur A739;
verif 262:
application : pro , batch , oceans , iliad  ;
si

   V_IND_TRAIT > 0
   et
   (INVDIR2009 +INVIMP+ 0) > PLAF_INVDOM2 

alors erreur A74001;
verif 263:
application : pro , batch , oceans , iliad  ;
si

   V_IND_TRAIT > 0
   et
   INVDIR2009 + 0 > INVDIRENT + 0

alors erreur A74002;
verif 264:
application : pro , batch , oceans , iliad  ;
si

   V_IND_TRAIT > 0
   et
   INVIMP + 0 > INVINIT + 0

alors erreur A74003;
verif 265:
application : pro , batch , oceans , iliad  ;
si

   V_IND_TRAIT > 0
   et
   REPMEUBLE + 0 > PLAF_99999

alors erreur A743;
verif 266:
application : pro , batch , oceans , iliad  ;
si

   V_IND_TRAIT > 0
   et
   RISKTEC + 0 > PLAF_TEC

alors erreur A744;
verif 2561:
application : pro , oceans , iliad ,batch ;
si
(
	RDCOM > 0 et

	SOMMEA700 = 0
)
alors erreur A700;
verif 2562:
application :  pro , iliad , batch ;
si
  (
    NBACT > SOMMEA700

    et
    (V_REGCO+0) dans (1,3,5,6)
  )
alors erreur DD19;
verif 2565:
application : batch , iliad ;
si
(
RDCOM > 0 et NBACT + 0  = 0
  et ( positif(NATIMP)=1 )
)
alors erreur I009;
verif 2566:
application : batch , iliad ;
si
(
CHRFAC > 0 et CHNFAC + 0  = 0
  et ( positif(NATIMP)=1 )
  et V_CNR = 0
)
alors erreur I008;
verif 2572:
application : batch , iliad, pro ;
si
(
 positif(RNOUV) = 1 
 et 
 positif(RDSNO) = 1 
 et 
 positif(CINE1 + CINE2 ) = 1
)
alors erreur DD02;
verif 2575:
application : batch , iliad , pro;
si
(
  (1 - V_CNR > 0 )
 et
  (( RVAIDE + CREAIDE + 0) > (LIM_AIDOMI3 * (1 - positif(PREMAIDE)) + LIM_PREMAIDE2 * positif(PREMAIDE))
  et  
     INAIDE = 1 )
  et
  (    positif(V_0AP+0)=0 
    et positif(V_0AF+0)=0
    et positif(V_0CG+0)=0
    et positif(V_0CI+0)=0
    et positif(V_0CR+0)=0 
  ) 
)
alors erreur DD21;
verif 2610:
application : pro , oceans , batch , iliad ;

si
(
RDENS + RDENL + RDENU > V_0CF + V_0DJ + V_0DN + 0 
)
alors erreur A70701 ;
verif 2615:
application : pro , oceans , batch , iliad ;

si
(
RDENSQAR + RDENLQAR + RDENUQAR > V_0CH + V_0DP + 0 
)
alors erreur A70702 ;
verif 2651:
application : pro , oceans , batch , iliad  ;

si
(
 SOMMEA70901 > 1
)
alors erreur A70901;
verif 2652:
application : pro , oceans , batch , iliad  ;
si
(
 positif(INVLOCHOT+0) = 1
 et
 positif(SOMMEA70902) = 1
)
alors erreur A70902;
verif 2642:
application : pro , oceans ,  iliad , batch;
si
 
  V_IND_TRAIT > 0 
  et 
  (
   REPINVLOCINV + 0 > LIMLOC2
   ou
   RINVLOCINV + 0 > LIMLOC2
   ou
   REPINVLOCREA + 0 > LIMLOC2
   ou
   RINVLOCREA + 0 > LIMLOC2
   ou
   INVLOCHOTR1 + 0 > LIMLOC2
   ou 
   INVLOCHOTR + 0 > LIMLOC2
  )

alors erreur A708;
verif 2644:
application :  iliad, pro ,batch;
si
          (
                ( REPINVDOMPRO1 +0  > V_BTR5DOMPRO + LIM_REPORT )
           ou
                ( REPINVDOMPRO2 +0  > V_BTR4DOMPRO + LIM_REPORT  )
           ou
                ( REPINVDOMPRO3 +0  > V_BTR3DOMPRO + LIM_REPORT  )
           ou
                ( REPINVDOMPRO4 +0  > V_BTR2DOMPRO + LIM_REPORT  )
           ou
                ( REPINVDOMPRO1 +0  > LIM_REPORT et V_BTR5DOMPRO+0 = 0 )
           ou
                ( REPINVDOMPRO2 +0  > LIM_REPORT et V_BTR4DOMPRO+0 = 0 )
           ou
                ( REPINVDOMPRO3 +0  > LIM_REPORT et V_BTR3DOMPRO+0 = 0 )
           ou
                ( REPINVDOMPRO4 +0  > LIM_REPORT et V_BTR2DOMPRO+0 = 0 )
          )
          et
          (
              1 - V_CNR > 0
          )
          et
          (
                  RIDOMPRO > 0
          )
         et
          ((APPLI_ILIAD = 1 et V_NOTRAIT+0 < 16)
             ou APPLI_PRO = 1
             ou ((V_BTNI1+0) non dans (50,92) et APPLI_BATCH = 1))

alors erreur DD07;
verif 3645:
application : batch, iliad, pro ;
si
   (
    ( REPINVLOCINV + 0  > LIM_INVLOC3 * ( 1 + V_0AM + V_0AO ) )
   ou
    ( RINVLOCINV + 0  > LIM_INVLOC3 * ( 1 + V_0AM + V_0AO ) )
   ou
    ( REPINVLOCREA + 0  > LIM_INVLOC3 * ( 1 + V_0AM + V_0AO ) )
   ou
    ( RINVLOCREA + 0  > LIM_INVLOC3 * ( 1 + V_0AM + V_0AO ) )
   ou
    ( INVLOCHOTR1 + 0  > LIM_INVLOC3 * ( 1 + V_0AM + V_0AO ) )
   ou
    ( INVLOCHOTR + 0  > LIM_INVLOC3 * ( 1 + V_0AM + V_0AO ) ) )
 et 
     (RTOURREP + RTOUHOTR + RTOUREPA + 0 > 0)
alors erreur DD06;
verif 3647:
application : batch, iliad, pro ;
si

  V_REGCO != 2
  et
  V_REGCO != 4
  et
  positif(PRETUDANT + 0) = 1
  et
  positif(V_BTPRETUD + 0) = 1

alors erreur DD09;
verif 710:
application : batch, iliad, pro, oceans ;
si
  ( 
    positif(CREAIDE+0) * positif(RVAIDE+0) = 1
   et
    positif(ASCAPA+0) = 0
  )
alors erreur A710;
verif 2649:
application : batch, iliad, pro, oceans ;
si 
   (
    INAIDE > 0 
   et 
    positif(RVAIDE+CREAIDE+0) = 0 
   ) 
   ou
   (
    ASCAPA > 0  
   et 
    positif(RVAIDE+0) = 0
   )
   ou
   ( 
    PREMAIDE > 0   
   et 
    positif(RVAIDE+CREAIDE+0) = 0
   )
alors erreur A711;
verif 2690:
application : batch, iliad, pro, oceans ;
si
	( 
         ((PRESCOMP2000 + 0 > PRESCOMPJUGE ) et (positif(PRESCOMPJUGE)=1))
	)
alors erreur A712;
verif non_auto_cc 2698:
application : batch, iliad, pro, oceans ;
si
          (  PRESCOMPJUGE+0 > 0 et PRESCOMP2000+0 =0 )
        ou
          (  PRESCOMPJUGE+0 =0 et PRESCOMP2000+0 > 0)
alors erreur A713;
verif 2700:
application : batch, iliad, pro, oceans ;
si
(RDPRESREPORT+0 > 0) et
          (  PRESCOMPJUGE + PRESCOMP2000 + 0 >0 )
alors erreur A714;
verif 2736:
application : batch, iliad, pro, oceans ;
si
    (LOCRESINEUV + 0 > 0) et ( MEUBLENP + 0 > 0 )

alors erreur A736 ;
verif 2730:
application : batch, iliad, pro, oceans ;
si
( REPFOR +0 > 0) et ( REPSINFOR + 0 >0 )
alors erreur A730;
verif 27001:
application : batch, iliad, pro, oceans ;
si
( CELLIERM +0 > 0) et ( CELLIERD + 0 >0 )
alors erreur A71701;
verif 27002:
application : batch, iliad, pro, oceans ;
si
( CELLIERM2 +0 > 0) et ( CELLIERD2 + 0 >0 )
alors erreur A71702;
verif 27003:
application : batch, iliad, pro, oceans ;
si
( CELLIERM1 +0 > 0) et ( CELLIERD1 + 0 >0 )
alors erreur A71703;
verif 27004:
application : batch, iliad, pro, oceans ;
si
(
   ( CELREPM09 +0 > 0) et ( CELREPD09 + 0 >0 )
)
alors erreur A71704;
verif 27005:
application : batch, iliad, pro, oceans ;
si
(
 V_IND_TRAIT > 0 
 et
 ((CELREPM09 + 0 > PLAF_99999)
 ou
 (CELREPD09 + 0 > PLAF_99999)) 
)
alors erreur A741;
verif 27007:
application : batch, iliad, pro, oceans ;
si
( CELLIERM +0 > 0) et ( CELLIERM1 + CELLIERD1 + 0 > 0 )
alors erreur A74201;
verif 27008:
application : batch, iliad, pro, oceans ;
si
( CELLIERD +0 > 0) et ( CELLIERM1 + CELLIERD1 + 0 > 0 )
alors erreur A74202;
verif 2701:
application : batch, iliad, pro, oceans ;
si
(V_IND_TRAIT > 0) et 
(RDPRESREPORT+0 > LIM_REPCOMPENS)
alors erreur A715;
verif 27011:
application : batch, iliad, pro, oceans ;
si
(V_IND_TRAIT > 0) et 
(
(SUBSTITRENTE < PRESCOMP2000+0)
ou
(SUBSTITRENTE > 0 et present(PRESCOMP2000)=0)
)
alors erreur A716;
verif 2510:
application : pro , oceans , batch ,  iliad ;
si
	(V_IND_TRAIT > 0)
        et
        (
        RDFREP > PLAF_REDREPAS
        )
alors erreur A701;
verif 2520:
application : pro , oceans , batch ,  iliad ;
si
  (
  ((V_REGCO+0) dans (1,3,5,6))
  et
  INTDIFAGRI > 0
  et
  RCMHAB + 0 < INTDIFAGRI
  )
alors erreur A702;
verif 703:
application : pro , oceans , batch ,  iliad ;
si
 (
  ( (positif(PRETUD+0) = 1 ou positif(PRETUDANT+0) = 1)
   et
    V_0DA < V_ANREV - 30
   et
    positif(BOOL_0AM+0) = 0 ) 
  ou
  ( (positif(PRETUD+0) = 1 ou positif(PRETUDANT+0) = 1)
   et 
   positif(BOOL_0AM+0) = 1
   et
   V_0DA < V_ANREV - 30
   et
   V_0DB < V_ANREV - 30 )
  )
alors erreur A703;
verif 704:
application : pro , oceans , batch ,  iliad ;
si
  (
   (positif( CASEPRETUD + 0 ) = 1 et positif( PRETUDANT + 0 ) = 0)
    ou
   (positif( CASEPRETUD + 0 ) = 0 et positif( PRETUDANT + 0 ) = 1)
  )
alors erreur A704;
verif 7501:
application : pro , oceans , batch ,  iliad ;

si
  CONVCREA  + 0 > 15 
  et 
  V_IND_TRAIT > 0

alors erreur A70503;
verif 75011:
application : pro , oceans , batch ,  iliad ;

si
  NBCREAT  + 0 > 6
  et 
  V_IND_TRAIT > 0

alors erreur A70504;
verif 7502:
application : pro , oceans , batch ,  iliad ;

si
   NBCREAT1 + 0 > 9
  et 
   V_IND_TRAIT > 0

alors erreur A70501;
verif 7503:
application : pro , oceans , batch ,  iliad ;

si
   NBCREAT2 + 0 > 15
  et 
   V_IND_TRAIT > 0

alors erreur A70502;
verif 76011:
application : pro , oceans , batch ,  iliad ;

si
   NBCREATHANDI + 0 > NBCREAT + 0
  et 
   V_IND_TRAIT > 0

alors erreur A70604;
verif 7601:
application : pro , oceans , batch ,  iliad ;

si
   CONVHAND + 0 > CONVCREA + 0
  et 
   V_IND_TRAIT > 0

alors erreur A70603;
verif 7602:
application : pro , oceans , batch ,  iliad ;

si
   NBCREATHANDI1 + 0 > NBCREAT1 + 0
  et 
   V_IND_TRAIT > 0

alors erreur A70601;
verif 7603:
application : pro , oceans , batch ,  iliad ;

si
   NBCREATHANDI2 + 0 > NBCREAT2 + 0
  et 
   V_IND_TRAIT > 0

alors erreur A70602;
verif 731:
application : pro , oceans , batch ,  iliad ;
si
   V_IND_TRAIT > 0
   et
   CASEPRETUD + 0 > 5
alors erreur A731;
verif 2097:
application : batch, iliad, oceans, pro ;
si
  (
    present(PERPIMPATRIE) = 1
    et
    V_CNR = 1
    et 
    (V_REGCO = 2
    ou
    V_REGCO = 4)
  )
alors erreur A097;
verif 3400:
application : batch, iliad, pro ;

si
  (1 - V_CNR > 0) et V_REGCO+0 !=2 et V_REGCO+0 != 4
  et
  positif(FIPCORSE+0) = 1
  et
  positif(FFIP + FCPI) = 1

alors erreur DD34;
verif 3410:
application : batch, iliad, pro ;

si

   V_IND_TRAIT > 0
   et
   V_REGCO + 0 = 1
   et
   REPGROREP > LIM_CONTROLE + V_BTNUREPAR

alors erreur DD39 ;
verif 3420:
application : batch, iliad, pro ;

si

   V_IND_TRAIT > 0
   et
   V_REGCO + 0 = 1
   et
   CELRRED09 > LIM_CONTROLE + V_BTREPCEL

alors erreur DD40 ;
verif 3430:
application : batch, iliad, pro ;

si

   V_IND_TRAIT > 0
   et
   V_REGCO + 0 = 1
   et
   REDMEUBLE > LIM_CONTROLE + V_BTRESINEUV

alors erreur DD41 ;
verif 3440:
application : batch, iliad, pro ;

si

   V_IND_TRAIT > 0
   et
   V_REGCO + 0 = 1
   et
   REPFOR + REPSINFOR > LIM_CONTROLE + V_BTSINFOR + V_BTFOREST

alors erreur DD42 ;
verif 3470:
application : batch, iliad, pro ;

si

   V_IND_TRAIT > 0
   et
   V_REGCO + 0 = 1
   et
   CELREPM09 + CELREPD09 > LIMLOC2 

alors erreur DD45 ;
verif 3480:
application : batch, iliad, pro ;

si

   V_IND_TRAIT > 0
   et
   V_REGCO + 0 = 1
   et
   REPMEUBLE > LIMLOC2 

alors erreur DD46 ;
verif 3490:
application : batch, iliad, pro ;

si

   V_IND_TRAIT > 0
   et
   BPVRCM + 0 > PVSOCG + 0
   et
   positif(BPVRCM + 0) = 1

alors erreur DD47 ;
verif 321:
application : batch, iliad, pro ;
si
  (1 - V_CNR > 0) et V_REGCO+0 !=2 et V_REGCO+0 != 4
  et
  positif(CREAIDE+0) > 0
  et
  (
  (1 - BOOL_0AM) *
   (present(TSHALLOV) + present(ALLOV) + present(GLD1V) + present(GLD2V) + present(GLD3V)
   + present(BPCOSAV) + present(TSASSUV) + present(XETRANV) 
   + present(TSELUPPEV) + present(CARTSV) + present(REMPLAV) + present(HEURESUPV)
   + present(FEXV) + present(BAFV) + positif(V_FORVA) + present(BAFORESTV)
   + present(BAFPVV) + present(BAF1AV) + present(BAEXV) + present(BACREV)
   + present(BACDEV) + present(BAHEXV) + present(BAHREV) + present(BAHDEV)
   + present(BA1AV) + present(BAPERPV)
   + present(MIBEXV) + present(MIBVENV) + present(MIBPRESV) + present(MIBPVV)
   + present(MIB1AV) + present(MIBDEV) + present(MIBDCT) + present(BICEXV)
   + present(BICNOV) + present(BICDNV) 
   + present(BIHEXV) + present(BIHNOV) + present(BIHDNV)
   + present(BI1AV) + present(BIPERPV)
   + present(BNCPROEXV) + present(BNCPROV) + present(BNCPROPVV) + present(BNCPRO1AV)
   + present(BNCPRODEV) + present(BNCPRODCT) + present(BNCEXV) + present(BNCREV)
   + present(BNCDEV) + present(BNHEXV) + present(BNHREV) + present(BNHDEV)
   + present(BN1AV) + present(BNCCRV) + present(CESSASSV))
   + present(AUTOBICVV) + present(AUTOBICPV) + present(LOCPROCGAV)
   + present(LOCDEFPROCGAV) + present(LOCPROV) + present(LOCDEFPROV)
   + present(AUTOBNCV) + present(XHONOAAV) + present(XHONOV)

  + (1 - positif(V_0AP+V_0AF)) * BOOL_0AM *
   (present(TSHALLOV) + present(ALLOV) + present(GLD1V) + present(GLD2V) + present(GLD3V)
   + present(BPCOSAV) + present(TSASSUV) + present(XETRANV) 
   + present(TSELUPPEV) + present(CARTSV) + present(REMPLAV) + present(HEURESUPV)
   + present(FEXV) + present(BAFV) + positif(V_FORVA) + present(BAFORESTV)
   + present(BAFPVV) + present(BAF1AV) + present(BAEXV) + present(BACREV)
   + present(BACDEV) + present(BAHEXV) + present(BAHREV) + present(BAHDEV)
   + present(BA1AV) + present(BAPERPV)
   + present(MIBEXV) + present(MIBVENV) + present(MIBPRESV) + present(MIBPVV)
   + present(MIB1AV) + present(MIBDEV) + present(MIBDCT) + present(BICEXV)
   + present(BICNOV) + present(BICDNV) 
   + present(BIHEXV) + present(BIHNOV) + present(BIHDNV)
   + present(BI1AV) + present(BIPERPV)
   + present(BNCPROEXV) + present(BNCPROV) + present(BNCPROPVV) + present(BNCPRO1AV)
   + present(BNCPRODEV) + present(BNCPRODCT) + present(BNCEXV) + present(BNCREV)
   + present(BNCDEV) + present(BNHEXV) + present(BNHREV) + present(BNHDEV)
   + present(BN1AV) + present(BNCCRV) + present(CESSASSV)) *
   ( present(TSHALLOC) + present(ALLOC) + present(GLD1C) + present(GLD2C) + present(GLD3C)
   + present(BPCOSAC) + present(TSASSUC) + present(XETRANC) 
   + present(TSELUPPEC) + present(CARTSC) + present(REMPLAC) + present(HEURESUPC)
   + present(FEXC) + present(BAFC) + positif(V_FORCA) + present(BAFORESTC)
   + present(BAFPVC) + present(BAF1AC) + present(BAEXC) + present(BACREC)
   + present(BACDEC) + present(BAHEXC) + present(BAHREC) + present(BAHDEC)
   + present(BA1AC) + present(BAPERPC)
   + present(MIBEXC) + present(MIBVENC) + present(MIBPRESC) + present(MIBPVC)
   + present(MIB1AC) + present(MIBDEC) + present(BICEXC)
   + present(BICNOC) + present(BICDNC) 
   + present(BIHEXC) + present(BIHNOC) + present(BIHDNC)
   + present(BI1AC) + present(BIPERPC)
   + present(BNCPROEXC) + present(BNCPROC) + present(BNCPROPVC) + present(BNCPRO1AC)
   + present(BNCPRODEC) + present(BNCEXC) + present(BNCREC)
   + present(BNCDEC) + present(BNHEXC) + present(BNHREC) + present(BNHDEC)
   + present(BN1AC) + present(BNCCRC) + present(CESSASSC))
   + present(AUTOBICVV) + present(AUTOBICPV) + present(LOCPROCGAV)
   + present(LOCDEFPROCGAV) + present(LOCPROV) + present(LOCDEFPROV)
   + present(AUTOBNCV) + present(XHONOAAV) + present(XHONOV)
   + present(AUTOBICVC) + present(AUTOBICVC) + present(LOCPROCGAC)
   + present(LOCDEFPROCGAC) + present(LOCPROC) + present(LOCDEFPROC)
   + present(AUTOBNCC) + present(XHONOAAC) + present(XHONOC)

  + BOOL_0AM * positif(V_0AF) *
   (present(TSHALLOV) + present(ALLOV) + present(GLD1V) + present(GLD2V) + present(GLD3V)
   + present(BPCOSAV) + present(TSASSUV) + present(XETRANV) 
   + present(TSELUPPEV) + present(CARTSV) + present(REMPLAV) + present(HEURESUPV)
   + present(FEXV) + present(BAFV) + positif(V_FORVA) + present(BAFORESTV)
   + present(BAFPVV) + present(BAF1AV) + present(BAEXV) + present(BACREV)
   + present(BACDEV) + present(BAHEXV) + present(BAHREV) + present(BAHDEV)
   + present(BA1AV) + present(BAPERPV)
   + present(MIBEXV) + present(MIBVENV) + present(MIBPRESV) + present(MIBPVV)
   + present(MIB1AV) + present(MIBDEV) + present(MIBDCT) + present(BICEXV)
   + present(BICNOV) + present(BICDNV) 
   + present(BIHEXV) + present(BIHNOV) + present(BIHDNV)
   + present(BI1AV) + present(BIPERPV)
   + present(BNCPROEXV) + present(BNCPROV) + present(BNCPROPVV) + present(BNCPRO1AV)
   + present(BNCPRODEV) + present(BNCPRODCT) + present(BNCEXV) + present(BNCREV)
   + present(BNCDEV) + present(BNHEXV) + present(BNHREV) + present(BNHDEV)
   + present(BN1AV) + present(BNCCRV) + present(CESSASSV))
   + present(AUTOBICVV) + present(AUTOBICPV) + present(LOCPROCGAV)
   + present(LOCDEFPROCGAV) + present(LOCPROV) + present(LOCDEFPROV)
   + present(AUTOBNCV) + present(XHONOAAV) + present(XHONOV)
  
  + BOOL_0AM * positif(V_0AP) *
   (present(TSHALLOC) + present(ALLOC) + present(GLD1C) + present(GLD2C) + present(GLD3C)
   + present(BPCOSAC) + present(TSASSUC) + present(XETRANC) 
   + present(TSELUPPEC) + present(CARTSC) + present(REMPLAC) + present(HEURESUPC)
   + present(FEXC) + present(BAFC) + positif(V_FORCA) + present(BAFORESTC)
   + present(BAFPVC) + present(BAF1AC) + present(BAEXC) + present(BACREC)
   + present(BACDEC) + present(BAHEXC) + present(BAHREC) + present(BAHDEC)
   + present(BA1AC) + present(BAPERPC)
   + present(MIBEXC) + present(MIBVENC) + present(MIBPRESC) + present(MIBPVC)
   + present(MIB1AC) + present(MIBDEC) + present(BICEXC)
   + present(BICNOC) + present(BICDNC) 
   + present(BIHEXC) + present(BIHNOC) + present(BIHDNC)
   + present(BI1AC) + present(BIPERPC)
   + present(BNCPROEXC) + present(BNCPROC) + present(BNCPROPVC) + present(BNCPRO1AC)
   + present(BNCPRODEC) + present(BNCEXC) + present(BNCREC)
   + present(BNCDEC) + present(BNHEXC) + present(BNHREC) + present(BNHDEC)
   + present(BN1AC) + present(BNCCRC) + present(CESSASSC))
   + present(AUTOBICVC) + present(AUTOBICVC) + present(LOCPROCGAC)
   + present(LOCDEFPROCGAC) + present(LOCPROC) + present(LOCDEFPROC)
   + present(AUTOBNCC) + present(XHONOAAC) + present(XHONOC)

   = 0
   )
alors erreur DD32;
