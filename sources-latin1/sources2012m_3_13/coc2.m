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
verif 2500:
application : iliad , batch;
si (APPLI_OCEANS = 0) et 
  (
   FRNV > (TSHALLOV + ALLOV) * 0.10
  et
   COSBV > 0 
  et 
   PRBRV + PALIV + 0 = 0
  )
alors erreur I00101;
verif 2501:
application : iliad , batch;
si (APPLI_OCEANS = 0) et 
(
(FRNC > (TSHALLOC+ ALLOC) *0.10)
et
COSBC > 0 et (PRBRC + PALIC + 0 = 0)
)
alors erreur I00102;
verif 2502:
application : iliad, batch;
si (APPLI_OCEANS = 0) et 
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
application : batch , iliad ;
si
      ( (APPLI_COLBERT + APPLI_ILIAD+APPLI_OCEANS=1)  et (
		((RDSYVO > 0) et (positif(COSBV+0) = 0))
	ou
		((RDSYCJ > 0) et (positif(COSBC+0) = 0))
	ou
		((RDSYPP > 0) et (positif(COSBP+0) = 0))
					       )
	)
alors erreur IM07;
verif 2504:
application : batch , iliad ;
si
   ( (APPLI_COLBERT + APPLI_ILIAD+APPLI_OCEANS=1)  et (
  V_IND_TRAIT > 0
  et
  CREPROSP > LIM_PROSP
					)
  )
alors erreur IM08;
verif 2511:
application : batch , iliad ;
si
 (APPLI_COLBERT + APPLI_ILIAD+APPLI_OCEANS=1)  et (
   (RDREP > 0 et present(RDFREP) = 0)
   ou
   (DONETRAN > 0 et present(RDFDONETR) = 0)
   ou
   (RDDOUP > 0 et present(RDFDOU) = 0)
   ou
   (DONAUTRE > 0 et present(RDFDAUTRE) = 0))
  
alors erreur IM06 ;
verif 2540:
application : batch , iliad ;
si (APPLI_COLBERT+APPLI_BATCH + APPLI_ILIAD = 1) et 
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
application : batch, iliad ;
si (APPLI_OCEANS = 0) et (
   V_IND_TRAIT + 0 = 4 
   et 
   (1 - V_CNR) > 0 
   et
   (REPSNO3 > LIM_CONTROLE + V_BTPME4
    ou
    REPSNO2 > LIM_CONTROLE + V_BTPME3
    ou
    REPSNO1 > LIM_CONTROLE + V_BTPME2
    ou
    REPSNON > LIM_CONTROLE + V_BTPME1)
   et 
   positif(NATIMP + 0) = 1
                           ) 
alors erreur DD27 ;
verif 51091:
application : batch, iliad ;
si (APPLI_OCEANS = 0) et (
   CREPROSP > 0 
   et 
   positif(V_BTCREPROSP + 0) = 1
                          )
alors erreur DD28 ;
verif 5110:
application : batch , iliad ;
si (APPLI_OCEANS = 0) et 
  ((REPDON03 > LIM_CONTROLE + V_BTDONS5)
   ou
   (REPDON04 > LIM_CONTROLE + V_BTDONS4)
   ou
   (REPDON05 > LIM_CONTROLE + V_BTDONS3)
   ou
   (REPDON06 > LIM_CONTROLE + V_BTDONS2)
   ou
   (REPDON07 > LIM_CONTROLE + V_BTDONS1))
   et 
   positif(NATIMP) = 1
   et 
   V_CNR + 0 = 0
 
alors erreur DD29 ;
verif 3900:
application : batch , iliad ;
si (APPLI_OCEANS = 0) et (
   positif(PERPIMPATRIE + 0) = 1
   et
   positif(V_BTPERPIMP + 0) = 1
                          )
alors erreur DD35 ;
verif 3910:
application : batch , iliad ;
si (APPLI_OCEANS = 0) et (
   1 - V_CNR > 0 
   et 
   V_REGCO+0 != 2 
   et 
   V_REGCO+0 != 4
   et
   PTZDEVDUR > 0	
   et
   (V_BTRFRN3 + 0 > PLAF_RFRN3  
    ou
    RFRN3 + 0 > PLAF_RFRN3)
                          )
alors erreur DD3601 ;
verif 3911:
application : batch , iliad ;
si (APPLI_OCEANS = 0) et (
   1 - V_CNR > 0 
   et 
   V_REGCO+0 != 2 
   et 
   V_REGCO+0 != 4
   et
   PTZDEVDUR > 0	
   et
   positif(V_BTRFRN3 + RFRN3 + 0) = 0  
                           )
alors erreur DD3602 ;
verif 3920:
application : batch , iliad ;
si (APPLI_OCEANS = 0) et (
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
 )        )
alors erreur DD37;
verif 3930:
application : batch , iliad ;
si (APPLI_OCEANS = 0) et (
   1 - V_CNR > 0 
   et 
   V_REGCO+0 != 2 
   et 
   V_REGCO+0 != 4
   et
   V_BTRFRN2 + 0 > arr(LIM_BARN2 * V_BTNBP2)
   et
   pour un i dans V,C,P: positif(AUTOBICVi + AUTOBICPi + AUTOBNCi) = 1 
                          )
alors erreur DD3801 ;
verif 3940:
application : batch , iliad ;
si (APPLI_OCEANS = 0) et (

   1 - V_CNR > 0 
   et 
   V_REGCO+0 != 2 
   et 
   V_REGCO+0 != 4
   et
   positif(V_BTRFRN2 + 0) = 0
   et
   1 - positif_ou_nul(RFRN2) = 1
   et
   pour un i dans V,C,P: positif(AUTOBICVi + AUTOBICPi + AUTOBNCi) = 1 
                           )
alors erreur DD3802 ;
verif 2554:
application :  batch , iliad  ;
si

   (APPLI_OCEANS = 0) 
   et
   CIDEPENV > LIMDEPENV

alors erreur A733 ;
verif 25110:
application : batch , iliad  ;
si

  (positif(PTZDEVDUR + PTZDEVDURN + 0) = 1
   et
   positif(DEPENVTT + DEPENVTU + DEPENVTV + DEPENVTW + DEPENVTX + DEPENVTY 
	   + CIBOIBAIL + CINRJBAIL + CRENRJ + CINRJ + CIDEP15 + MATISOSI + MATISOSJ + VOLISO + PORENT + ELESOL + CHAUBOISN 
	   + CHAUBOISO + POMPESP + POMPESQ + POMPESR + CHAUFSOL + ENERGIEST + EAUPLUV + DIAGPERF + RESCHAL + 0) = 0)

alors erreur A73501 ;
verif 25111:
application : batch , iliad  ;
si

   (positif(PTZDEVDUR + 0) = 1
    et
    positif(PTZDEVDURN + 0) = 1) 

alors erreur A73502 ;
verif 253:
application : batch , iliad  ;
si

   positif(INDLOCNEUF + 0) = 1
   et
   positif(INVLOCNEUF + 0) = 0

alors erreur A73701;
verif 254:
application : batch , iliad  ;
si

   positif(INDLOCRES + 0) = 1
   et
   positif(INVLOCRES + 0) = 0

alors erreur A73702;
verif 260:
application : batch , iliad  ;
si

   positif(SINISFORET + 0) = 1
   et
   positif(RDFORESTRA + 0) = 0

alors erreur A738;
verif 261:
application : batch , iliad  ;
si
   positif(OPTPLAF15 + 0) = 1
   et
   SOMMEA739 = 0

alors erreur A739 ;
verif 262:
application : batch , iliad  ;
si

   V_IND_TRAIT > 0
   et
   (INVOMRETPR + INVOMRETPW + 0) > PLAF_INVDOM2 
   et
   positif(INVOMENTRI + INVOMENTRO + INVOMENTRT + INVOMENTRY + INVOMENTNY + 0) = 0

alors erreur A74001 ;
verif 263:
application :  batch , iliad  ;
si

   V_IND_TRAIT > 0
   et
   (INVOMENTRI + 0) > PLAFINVDOM2 
   et
   positif(INVOMRETPR + INVOMRETPW + INVOMENTRO + INVOMENTRT + INVOMENTRY + INVOMENTNY + 0) = 0

alors erreur A74002 ;
verif 264:
application : batch , iliad  ;
si

   V_IND_TRAIT > 0
   et
   (INVOMENTRO + INVOMENTRT + INVOMENTRY + INVOMENTNY + 0 > PLAF_INVDOM6
   et
    positif(INVOMRETPR + INVOMRETPW + INVOMENTRI + 0) = 0)

alors erreur A74003 ;
verif 2641:
application : batch , iliad  ;
si

   V_IND_TRAIT > 0
   et
   positif(INVOMRETPR + INVOMRETPW + 0) + positif(INVOMENTRI + INVOMENTRO + INVOMENTRT + INVOMENTRY + INVOMENTNY + 0) = 2 
   et
   (INVOMRETPR + INVOMRETPW + INVOMENTRI + INVOMENTRO + INVOMENTRT + INVOMENTRY + INVOMENTNY + 0 > PLAF_INVDOM2
   ou
   (INVOMRETPR + INVOMRETPW + INVOMENTRI + INVOMENTRO + INVOMENTRT + INVOMENTRY + INVOMENTNY + 0 <= PLAF_INVDOM2
    et
    (INVOMENTRI + 0 > PLAFINVDOM2
    ou
    INVOMENTRO + INVOMENTRT + INVOMENTRY + INVOMENTNY + 0 > PLAF_INVDOM6)))

alors erreur A74004 ;
verif 265:
application : batch , iliad  ;
si

   V_IND_TRAIT > 0
   et
   (REPMEUBLE + 0 > PLAF_99999
    ou
    INVREPMEU + 0 > PLAF_99999
    ou
    INVREPNPRO + 0 > PLAF_99999
    ou
    INVNPROREP + 0 > PLAF_99999)

alors erreur A743;
verif 266:
application : batch , iliad  ;
si

   V_IND_TRAIT > 0
   et
   RISKTEC + 0 > PLAF_TEC

alors erreur A744;
verif 267:
application : batch , iliad  ;
si
   V_IND_TRAIT > 0
   et
   positif(INVREPMEU + 0) + positif(INVREPNPRO + 0) > 1

alors erreur A745;
verif 271:
application : batch , iliad  ;
si
   V_IND_TRAIT > 0
   et
   INVOMRETPR * positif(INVOMRETPR + 0) > INVOMRETPQ * positif(INVOMRETPQ + 0) + 0

alors erreur A74601 ;
verif 272:
application : batch , iliad  ;
si
   V_IND_TRAIT > 0
   et
   INVOMRETPW * positif(INVOMRETPW + 0) > INVOMRETPV * positif(INVOMRETPV + 0) + 0

alors erreur A74602 ;
verif 273:
application : batch , iliad  ;
si
   V_IND_TRAIT > 0
   et
   INVOMENTRI * positif(INVOMENTRI + 0) > INVOMENTRH * positif(INVOMENTRH + 0) + 0

alors erreur A74603 ;
verif 274:
application : batch , iliad  ;
si
   V_IND_TRAIT > 0
   et
   INVOMENTRO * positif(INVOMENTRO + 0) > INVOMENTRN * positif(INVOMENTRN + 0) + 0

alors erreur A74604 ;
verif 275:
application : batch , iliad  ;
si
   V_IND_TRAIT > 0
   et
   INVOMENTRT * positif(INVOMENTRT + 0) > INVOMENTRS * positif(INVOMENTRS + 0) + 0

alors erreur A74605 ;
verif 276:
application : batch , iliad  ;
si
   V_IND_TRAIT > 0
   et
   INVOMENTRY * positif(INVOMENTRY + 0) > INVOMENTRX * positif(INVOMENTRX + 0) + 0

alors erreur A74606 ;
verif 277:
application : batch , iliad  ;
si
   V_IND_TRAIT > 0
   et
   INVOMENTNY * positif(INVOMENTNY + 0) > INVOMENTNX * positif(INVOMENTNX + 0) + 0

alors erreur A74607 ;
verif 2561:
application : iliad ,batch ;
si
(
	RDCOM > 0 et

	SOMMEA700 = 0
)
alors erreur A700;
verif 2562:
application :  iliad , batch ;
si (APPLI_OCEANS = 0) et 
  (
    NBACT > SOMMEA700

    et
    (V_REGCO+0) dans (1,3,5,6)
  )
alors erreur DD19;
verif 2565:
application : batch , iliad ;
si (APPLI_COLBERT+APPLI_BATCH + APPLI_ILIAD = 1) et 
(
RDCOM > 0 et NBACT + 0  = 0
  et ( positif(NATIMP)=1 )
)
alors erreur I009;
verif 2566:
application : batch , iliad ;
si (APPLI_COLBERT+APPLI_BATCH + APPLI_ILIAD = 1) et 
(
CHRFAC > 0 et CHNFAC + 0  = 0
  et ( positif(NATIMP)=1 )
  et V_CNR = 0
)
alors erreur I008;
verif 2572:
application : batch, iliad ;
si (APPLI_OCEANS = 0) et  (
   (1 - V_CNR > 0)
   et
   positif(RNOUV) = 1 
   et 
   positif(RDSNO) = 1 
   et 
   positif(CINE1 + CINE2 ) = 1
                           )
alors erreur DD02 ;
verif 2575:
application : batch , iliad;
si (APPLI_OCEANS = 0) et  
(
  (1 - V_CNR > 0 )
 et
  (( RVAIDE + RVAIDAS + CREAIDE + 0) > (LIM_AIDOMI3 * (1 - positif(PREMAIDE)) + LIM_PREMAIDE2 * positif(PREMAIDE))
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
alors erreur DD21 ;
verif 2610:
application : batch , iliad ;

si
   RDENS + RDENL + RDENU > V_0CF + V_0DJ + V_0DN + 0 

alors erreur A70701 ;
verif 2615:
application : batch , iliad ;

si
   RDENSQAR + RDENLQAR + RDENUQAR > V_0CH + V_0DP + 0 

alors erreur A70702 ;
verif 2651:
application : batch , iliad  ;

si
   SOMMEA709 > 1

alors erreur A709 ;
verif 2642:
application : iliad , batch;
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
   ou 
   REPINVTOU + 0 > LIMLOC2
   ou
   INVLOGREHA + 0 > LIMLOC2
   ou
   INVLOGHOT + 0 > LIMLOC2
   ou
   INVLOCXN + 0 > LIMLOC2
   ou
   INVLOCXV + 0 > LIMLOC2
  )

alors erreur A708;
verif 2644:
application :  iliad ,batch;
si (APPLI_OCEANS = 0 ) et (
          (
                ( REPINVDOMPRO2 +0  > V_BTR4DOMPRO + LIM_REPORT  )
           ou
                ( REPINVDOMPRO2 +0  > LIM_REPORT et V_BTR4DOMPRO+0 = 0 )
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
             ou APPLI_COLBERT = 1
             ou ((V_BTNI1+0) non dans (50,92) et APPLI_BATCH = 1))
                           )
alors erreur DD07;
verif 3645:
application : batch, iliad ;
si (APPLI_OCEANS = 0 ) et (
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
    ( INVLOCHOTR + 0  > LIM_INVLOC3 * ( 1 + V_0AM + V_0AO ) ) 
   ou
    ( REPINVTOU + 0  > LIM_INVLOC3 * ( 1 + V_0AM + V_0AO ) )
   ou
    ( INVLOGREHA + 0  > LIM_INVLOC3 * ( 1 + V_0AM + V_0AO ) )
   ou
    ( INVLOGHOT + 0  > LIM_INVLOC3 * ( 1 + V_0AM + V_0AO ) )
   ou
    ( INVLOCXN + 0  > LIM_INVLOC3 * ( 1 + V_0AM + V_0AO ) )
   ou
    ( INVLOCXV + 0  > LIM_INVLOC3 * ( 1 + V_0AM + V_0AO ) )
   )
 et 
     (RTOURREP + RTOUHOTR + RTOUREPA + 0 > 0)
			   )
alors erreur DD06;
verif 3647:
application : batch, iliad ;
si (APPLI_OCEANS = 0 ) et (

  V_REGCO != 2
  et
  V_REGCO != 4
  et
  positif(PRETUDANT + 0) = 1
  et
  positif(V_BTPRETUD + 0) = 1
                           )
alors erreur DD09;
verif 710:
application : batch, iliad ;
si
   
    V_IND_TRAIT > 0 
    et
    positif(CREAIDE + 0) * positif(RVAIDE + 0) = 1
  
alors erreur A710;
verif 2649:
application : batch, iliad ;
si 
   V_IND_TRAIT > 0 
   et
   INAIDE > 0 
   et 
   positif(RVAIDE + RVAIDAS + CREAIDE + 0) = 0 
    
alors erreur A71101 ;
verif 2650:
application : batch, iliad ;

si
   V_IND_TRAIT > 0 
   et
   positif(ASCAPA + 0) + positif(RVAIDAS + 0) = 1
    
alors erreur A71102 ;
verif 26501:
application : batch, iliad ;

si
   V_IND_TRAIT > 0 
   et
   PREMAIDE > 0   
   et 
   positif(RVAIDE + RVAIDAS + CREAIDE + 0) = 0
   
alors erreur A71103 ;
verif 2690:
application : batch, iliad ;
si
	( 
         ((PRESCOMP2000 + 0 > PRESCOMPJUGE ) et (positif(PRESCOMPJUGE)=1))
	)
alors erreur A712;
verif non_auto_cc 2698:
application : batch, iliad ;
si
          (  PRESCOMPJUGE+0 > 0 et PRESCOMP2000+0 =0 )
        ou
          (  PRESCOMPJUGE+0 =0 et PRESCOMP2000+0 > 0)
alors erreur A713;
verif 2700:
application : batch, iliad ;
si
(RDPRESREPORT+0 > 0) et
          (  PRESCOMPJUGE + PRESCOMP2000 + 0 >0 )
alors erreur A714;
verif 2736:
application : batch, iliad ;
si

  V_IND_TRAIT > 0 
  et
  positif(LOCRESINEUV + 0) + positif(MEUBLENP + 0) + positif(INVNPROF1 + 0) + positif(INVNPROF2 + 0) > 1

alors erreur A73602 ;
verif 2737:
application : batch, iliad ;
si

  V_IND_TRAIT > 0 
  et
  positif(RESIVIEU + 0) + positif(RESIVIANT + 0) > 1

alors erreur A73603 ;
verif 2738 :
application : batch, iliad ;
si
  V_IND_TRAIT > 0
  et
  positif(LOCMEUBID + 0) + positif(LOCMEUBIE + 0) + positif(LOCMEUBIF + 0) + positif(LOCMEUBIG + 0) > 1

alors erreur A73601 ;
verif 2730:
application : batch, iliad ;
si

  V_IND_TRAIT > 0 
  et
  REPFOR + 0 > 0 et REPSINFOR + 0 > 0 

alors erreur A73001;
verif 2731:
application : batch, iliad ;
si

  V_IND_TRAIT > 0 
  et
  REPFOR1 + 0 > 0 et REPSINFOR1 + 0 > 0 

alors erreur A73002 ;
verif 2732:
application : batch, iliad ;
si

  V_IND_TRAIT > 0 
  et
  REPFOR2 + 0 > 0 et REPSINFOR2 + 0 > 0 

alors erreur A73003 ;
verif 27001:
application : batch, iliad ;

si

 (V_IND_TRAIT > 0)
 et 
 (SOMMEA71701 > 1)

alors erreur A71701 ;
verif 27002:
application : batch, iliad ;

si

 (V_IND_TRAIT > 0)
 et 
 (SOMMEA71702 > 1)

alors erreur A71702 ;
verif 27003:
application : batch, iliad ;
si

  V_IND_TRAIT > 0
  et
  (positif(CELLIERHJ) + positif(CELLIERHK) + positif(CELLIERHN) + positif(CELLIERHO) > 1 )

alors erreur A71703 ;
verif 27004:
application : batch, iliad ;
si

  V_IND_TRAIT > 0
  et
  ( CELLIERHL + 0 > 0) et ( CELLIERHM + 0 > 0 )

alors erreur A71704 ;
verif 27005:
application : batch, iliad ;
si

   V_IND_TRAIT > 0 
   et
   ((CELREPHR + 0 > PLAF_99999)
    ou
    (CELREPHS + 0 > PLAF_99999)
    ou
    (CELREPHT + 0 > PLAF_99999)
    ou
    (CELREPHU + 0 > PLAF_99999)
    ou
    (CELREPHV + 0 > PLAF_99999)
    ou
    (CELREPHW + 0 > PLAF_99999)
    ou
    (CELREPHX + 0 > PLAF_99999)
    ou
    (CELREPHZ + 0 > PLAF_99999)) 

alors erreur A741;
verif 27007:
application : batch, iliad ;
si
   V_IND_TRAIT > 0 
   et 
   positif(CELREPHR + 0) + positif(CELREPHS + 0) > 1

alors erreur A74201 ;
verif 27008:
application : batch, iliad ;
si
   V_IND_TRAIT > 0 
   et 
   positif(CELREPHT + 0) + positif(CELREPHU + 0) > 1

alors erreur A74202 ;
verif 27009:
application : batch, iliad ;
si
   V_IND_TRAIT > 0 
   et 
   positif(CELREPHV + 0) + positif(CELREPHW + 0) + positif(CELREPHX + 0) + positif(CELREPHZ + 0) > 1

alors erreur A74203 ;
verif 27010:
application : batch, iliad ;
si
   V_IND_TRAIT > 0 
   et 
   positif(CELREPHD + 0) + positif(CELREPHE + 0) > 1

alors erreur A74204 ;
verif 27012:
application : batch, iliad ;
si
   V_IND_TRAIT > 0 
   et 
   positif(CELREPHA + 0) + positif(CELREPHB + 0) + positif(CELREPHG + 0) + positif(CELREPHH + 0) > 1

alors erreur A74205 ;
verif 2701:
application : batch, iliad ;
si
(V_IND_TRAIT > 0) et 
(RDPRESREPORT+0 > LIM_REPCOMPENS)
alors erreur A715;
verif 27011:
application : batch, iliad ;
si
(V_IND_TRAIT > 0) et 
(
(SUBSTITRENTE < PRESCOMP2000+0)
ou
(SUBSTITRENTE > 0 et present(PRESCOMP2000)=0)
)
alors erreur A716;
verif 2510:
application : batch ,  iliad ;
si
	(V_IND_TRAIT > 0)
        et
        (
        RDFREP + RDFDONETR > PLAF_REDREPAS
        )
alors erreur A701;
verif 2520:
application : batch ,  iliad ;
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
application : batch ,  iliad ;
si
 (
  ( (positif(PRETUD+0) = 1 ou positif(PRETUDANT+0) = 1)
   et
    V_0DA < 1979
   et
    positif(BOOL_0AM+0) = 0 ) 
  ou
  ( (positif(PRETUD+0) = 1 ou positif(PRETUDANT+0) = 1)
   et 
   positif(BOOL_0AM+0) = 1
   et
   V_0DA < 1979 
   et
   V_0DB < 1979 )
  )
alors erreur A703;
verif 704:
application : batch ,  iliad ;
si
  (
   (positif( CASEPRETUD + 0 ) = 1 et positif( PRETUDANT + 0 ) = 0)
    ou
   (positif( CASEPRETUD + 0 ) = 0 et positif( PRETUDANT + 0 ) = 1)
  )
alors erreur A704;
verif 7501:
application : batch ,  iliad ;

si
  CONVCREA  + 0 > 15 
  et 
  V_IND_TRAIT > 0

alors erreur A705 ;
verif 7601:
application : batch ,  iliad ;

si
   CONVHAND + 0 > CONVCREA + 0
  et 
   V_IND_TRAIT > 0

alors erreur A706 ;
verif 731:
application : batch ,  iliad ;
si
   V_IND_TRAIT > 0
   et
   CASEPRETUD + 0 > 5

alors erreur A731 ;
verif 2097:
application : batch, iliad ;
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
alors erreur A097 ;
verif 2098:
application : batch , iliad ;

si
    positif(PVMOBNR + 0) = 1
    et
    V_REGCO != 2
    et
    V_REGCO != 4
  
alors erreur A098 ;
verif 3400:
application : batch, iliad ;

si (APPLI_OCEANS = 0) et (
  (1 - V_CNR > 0) et V_REGCO+0 !=2 et V_REGCO+0 != 4
  et
  positif(FIPCORSE+0) = 1
  et
  positif(FFIP + FCPI) = 1
                         )
alors erreur DD34;
verif 3410:
application : batch , iliad ;

si (APPLI_OCEANS = 0) et (
   V_IND_TRAIT > 0
   et
   V_REGCO+0 != 2
   et
   V_REGCO+0 != 4
   et
   REPGROREP1 + REPGROREP2 + REPGROREP11 > LIM_CONTROLE + V_BTNUREPAR
                          )
alors erreur DD39 ;
verif 3420:
application : batch , iliad ;

si (APPLI_OCEANS = 0) et (
   V_IND_TRAIT > 0
   et
   V_REGCO+0 != 2
   et
   V_REGCO+0 != 4
   et
   CELRREDLA + CELRREDLB + CELRREDLE > LIM_CONTROLE + V_BTRRCEL3
                          )
alors erreur DD40 ;
verif 34201:
application : batch , iliad ;

si (APPLI_OCEANS = 0) et (
   V_IND_TRAIT > 0
   et
   V_REGCO+0 != 2
   et
   V_REGCO+0 != 4
   et
   CELRREDLC + CELRREDLD > LIM_CONTROLE + V_BTRRCEL4
                          )
alors erreur DD48 ;
verif 3430:
application : batch , iliad ;

si (APPLI_OCEANS = 0) et (
   V_IND_TRAIT > 0
   et
   V_REGCO+0 != 2
   et
   V_REGCO+0 != 4
   et
   REDMEUBLE + REDREPNPRO + LOCMEUBIX > LIM_CONTROLE + V_BTRESINEUV
                          )
alors erreur DD41 ;
verif 34301:
application : batch , iliad ;

si (APPLI_OCEANS = 0) et (
   V_IND_TRAIT > 0
   et
   V_REGCO+0 != 2
   et
   V_REGCO+0 != 4
   et
   INVREDMEU + LOCMEUBIH > LIM_CONTROLE + V_BTREPNEUV
                          )
alors erreur DD49 ;
verif 3440:
application : batch , iliad ;

si (APPLI_OCEANS = 0) et (
   V_IND_TRAIT > 0
   et
   V_REGCO+0 != 2
   et
   V_REGCO+0 != 4
   et
   (REPFOR + REPFOR1 + REPFOR2 > LIM_CONTROLE + V_BTFOREST
    ou
    REPSINFOR + REPSINFOR1 + REPSINFOR2 > LIM_CONTROLE + V_BTSINFOR)
                        )
alors erreur DD42 ;
verif 3450:
application : batch , iliad ;

si 
   APPLI_OCEANS = 0 
   et 
   V_IND_TRAIT > 0
   et
   V_REGCO+0 != 2
   et
   V_REGCO+0 != 4
   et
   (INVOMREP + NRETROC50 + NRETROC40 + INVENDI + INVOMENTMN + RETROCOMLH
   + RETROCOMMB + INVOMENTKT + RETROCOMLI + RETROCOMMC + INVOMENTKU 
   + INVOMQV + INVRETRO1 + INVRETRO2 + INVIMP + INVDOMRET50 + INVDOMRET60
   + INVDIR2009 + INVENDEB2009 + INVOMRETPA + INVOMRETPB + INVOMRETPD
   + INVOMRETPE + INVOMRETPF + INVOMRETPH + INVOMRETPI + INVOMRETPJ + INVOMRETPL
   > LIM_CONTROLE + V_BTREPLGI + V_BTREPLH + V_BTREPMAC + V_BTREPMB + V_BTREPPA + V_BTREPPB + V_BTREPPD + V_BTREPPE
		  + V_BTREPPF + V_BTREPPH + V_BTREPPI + V_BTREPPJ + V_BTREPPL + V_BTREPQE + V_BTREPQF + V_BTREPQG 
		  + V_BTREPQI + V_BTREPQO + V_BTREPQP + V_BTREPQR + V_BTREPQV)

                           
alors erreur DD43 ;
verif 3460:
application : batch , iliad ;

si 
   APPLI_OCEANS = 0 
   et 
   V_IND_TRAIT > 0
   et
   V_REGCO+0 != 2
   et
   V_REGCO+0 != 4
   et
   INVSOCNRET + INVOMSOCKH + INVOMSOCKI + INVSOC2010 + INVOMSOCQU + INVLOGSOC > LIM_CONTROLE + V_BTREPQK + V_BTREPQN + V_BTREPQU
                         
alors erreur DD44 ;
verif 3470:
application : batch , iliad ;

si (APPLI_OCEANS = 0) et (

   V_IND_TRAIT > 0
   et
   V_REGCO+0 != 2
   et
   V_REGCO+0 != 4
   et
   (CELREPHR > LIMLOC2
    ou
    CELREPHS > LIMLOC2 
    ou 
    CELREPHT > LIMLOC2
    ou
    CELREPHU > LIMLOC2
    ou
    CELREPHV > LIMLOC2
    ou
    CELREPHW > LIMLOC2
    ou
    CELREPHX > LIMLOC2
    ou
    CELREPHZ > LIMLOC2)
                        )
alors erreur DD45 ;
verif 3480:
application : batch , iliad ;
si (APPLI_OCEANS = 0) et (
   V_IND_TRAIT > 0
   et
   V_REGCO+0 != 2
   et
   V_REGCO+0 != 4
   et
   (INVREPMEU > LIMLOC2
    ou
    INVREPNPRO > LIMLOC2
    ou
    INVNPROREP > LIMLOC2
    ou
    REPMEUBLE > LIMLOC2) 
                           )
alors erreur DD46 ;
verif 3490:
application : batch , iliad ;

si (APPLI_OCEANS = 0) et (
   V_IND_TRAIT > 0
   et
   V_REGCO+0 != 2
   et
   V_REGCO+0 != 4
   et
   PATNAT1 + PATNAT2 > LIM_CONTROLE + V_BTPATNAT
                          )
alors erreur DD50 ;
verif 34901:
application : batch , iliad ;

si (APPLI_OCEANS = 0) et (
   V_IND_TRAIT > 0
   et
   V_REGCO+0 != 2
   et
   V_REGCO+0 != 4
   et
   LNPRODEF10 + LNPRODEF9 + LNPRODEF8 + LNPRODEF7 + LNPRODEF6 
   + LNPRODEF5 + LNPRODEF4 + LNPRODEF3 + LNPRODEF2 + LNPRODEF1 > LIM_CONTROLE + V_BTDEFNPLOC
                          )
alors erreur DD52 ;
verif 34902:
application : batch , iliad ;

si (APPLI_OCEANS = 0) et (
   V_IND_TRAIT > 0
   et
   V_REGCO+0 != 2
   et
   V_REGCO+0 != 4
   et
   DEFBIC6 + DEFBIC5 + DEFBIC4 + DEFBIC3 + DEFBIC2 + DEFBIC1 > LIM_CONTROLE + V_BTBNCDF
                         )
alors erreur DD53 ;
verif 34903:
application : batch , iliad ;

si (APPLI_OCEANS = 0) et (
   V_IND_TRAIT > 0
   et
   V_REGCO+0 != 2 
   et 
   V_REGCO+0 != 4
   et
   positif(PTZDEVDURN + 0) = 1 
   et 
   positif(DEPENVTT + DEPENVTU + DEPENVTV + DEPENVTW + DEPENVTX + DEPENVTY + CIBOIBAIL + CINRJBAIL + CRENRJ 
	   + CINRJ + CIDEP15 + MATISOSI + MATISOSJ + VOLISO + PORENT + ELESOL + CHAUBOISN + CHAUBOISO
	   + POMPESP + POMPESQ + POMPESR + CHAUFSOL + ENERGIEST + EAUPLUV + DIAGPERF + RESCHAL + 0) = 1
   et
   positif(CIDEVDUR + 0) = 1
                           )
alors erreur DD54 ;
verif 1257:
application : batch , iliad ;

si 
   APPLI_OCEANS = 0 
   et 
   V_IND_TRAIT > 0
   et
   V_REGCO+0 != 2 
   et 
   V_REGCO+0 != 4
   et
   CELRREDLF > LIM_CONTROLE + V_BTRRCEL1

alors erreur DD57 ;
verif 1258:
application : batch , iliad ;

si 
   APPLI_OCEANS = 0 
   et 
   V_IND_TRAIT > 0
   et
   V_REGCO+0 != 2 
   et 
   V_REGCO+0 != 4
   et
   LOCMEUBIZ > LIM_CONTROLE + V_BTRESINEUV

alors erreur DD58 ;
verif 12591:
application : batch , iliad ;

si 
   APPLI_OCEANS = 0 
   et 
   V_IND_TRAIT > 0
   et
   positif(BPVOPTCSV + 0) = 1
   et
   positif(BPCOPTV + BPCOSAV + 0) = 0

alors erreur DD5901 ;
verif 12592:
application : batch , iliad ;

si 
   APPLI_OCEANS = 0 
   et 
   V_IND_TRAIT > 0
   et
   positif(BPVOPTCSC + 0) = 1
   et
   positif(BPCOPTC + BPCOSAC + 0) = 0

alors erreur DD5902 ;
verif 12601:
application : batch , iliad ;

si 
   APPLI_OCEANS = 0 
   et 
   V_IND_TRAIT > 0
   et
   positif(GAINSALAV + 0) = 1
   et
   positif(BPV18V + BPCOPTV + BPV40V + BPCOSAV + 0) = 0

alors erreur DD6001 ;
verif 12602:
application : batch , iliad ;

si 
   APPLI_OCEANS = 0 
   et 
   V_IND_TRAIT > 0
   et
   positif(GAINSALAC + 0) = 1
   et
   positif(BPV18C + BPCOPTC + BPV40C + BPCOSAC + 0) = 0

alors erreur DD6002 ;
verif 12611:
application : batch , iliad ;

si 
   APPLI_OCEANS = 0 
   et 
   V_IND_TRAIT > 0
   et
   positif(CVNSALAV + 0) = 1
   et
   positif(BPV18V + BPCOPTV + BPV40V + BPCOSAV + 0) = 0

alors erreur DD6101 ;
verif 12612:
application : batch , iliad ;

si 
   APPLI_OCEANS = 0 
   et 
   V_IND_TRAIT > 0
   et
   positif(CVNSALAC + 0) = 1
   et
   positif(BPV18C + BPCOPTC + BPV40C + BPCOSAC + 0) = 0

alors erreur DD6102 ;
verif 1262:
application : batch , iliad ;

si 
   APPLI_OCEANS = 0 
   et 
   V_REGCO+0 != 2 
   et 
   V_REGCO+0 != 4
   et
   positif(CRECHOCON2 + 0) = 1
   et
   (positif(MATISOSJ) * (positif(CINRJ) + positif(CIDEP15) + positif(CHAUBOISN + CHAUBOISO) + positif(POMPESR + CHAUFSOL) 
					+ positif(CIBOIBAIL + CINRJBAIL + POMPESP + POMPESQ + ENERGIEST)) + 0 = 0
    et
    positif(CINRJ) * (positif(CIDEP15) + positif(CHAUBOISN + CHAUBOISO) + positif(POMPESR + CHAUFSOL)
				       + positif(CIBOIBAIL + CINRJBAIL + POMPESP + POMPESQ + ENERGIEST)) + 0 = 0
    et
    positif(CIDEP15) * (positif(CHAUBOISN + CHAUBOISO) + positif(POMPESR + CHAUFSOL)
						       + positif(CIBOIBAIL + CINRJBAIL + POMPESP + POMPESQ + ENERGIEST)) + 0 = 0
    et
    positif(CHAUBOISN + CHAUBOISO) * (positif(POMPESR + CHAUFSOL) + positif(CIBOIBAIL + CINRJBAIL + POMPESP + POMPESQ + ENERGIEST)) + 0 = 0
    et
    positif(POMPESR + CHAUFSOL) * positif(CIBOIBAIL + CINRJBAIL + POMPESP + POMPESQ + ENERGIEST) + 0 = 0)

alors erreur DD62 ;
verif 1263:
application : batch , iliad ;

si 
   APPLI_OCEANS = 0 
   et 
   V_IND_TRAIT > 0
   et
   IPTEFP < RNI + 0

alors erreur DD63 ;
verif 321:
application : batch , iliad ;
si (APPLI_OCEANS = 0) et 
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
   + present(MIB1AV) + present(MIBDEV) 
   + present( BICPMVCTV )
   + present(BICEXV)
   + present(BICNOV) + present(BICDNV) 
   + present(BIHEXV) + present(BIHNOV) + present(BIHDNV)
   + present(BI1AV) + present(BIPERPV)
   + present(BNCPROEXV) + present(BNCPROV) + present(BNCPROPVV) + present(BNCPRO1AV)
   + present(BNCPRODEV) + present(BNCPMVCTV) + present(BNCEXV) + present(BNCREV)
   + present(BNCDEV) + present(BNHEXV) + present(BNHREV) + present(BNHDEV)
   + present(BN1AV) + present(BNCCRV) + present(CESSASSV)
   + present(AUTOBICVV) + present(AUTOBICPV) + present(LOCPROCGAV)
   + present(LOCDEFPROCGAV) + present(LOCPROV) + present(LOCDEFPROV)
   + present(AUTOBNCV) + present(XHONOAAV) + present(XHONOV)
   + present(GLDGRATV) + present(SALINTV) + present(BICPMVCTV))

  + (1 - positif(V_0AP+V_0AF)) * BOOL_0AM *
   (present(TSHALLOV) + present(ALLOV) + present(GLD1V) + present(GLD2V) + present(GLD3V)
    + present(BPCOSAV) + present(TSASSUV) + present(XETRANV) 
    + present(TSELUPPEV) + present(CARTSV) + present(REMPLAV) + present(HEURESUPV)
    + present(FEXV) + present(BAFV) + positif(V_FORVA) + present(BAFORESTV)
    + present(BAFPVV) + present(BAF1AV) + present(BAEXV) + present(BACREV)
    + present(BACDEV) + present(BAHEXV) + present(BAHREV) + present(BAHDEV)
    + present(BA1AV) + present(BAPERPV)
    + present(MIBEXV) + present(MIBVENV) + present(MIBPRESV) + present(MIBPVV)
    + present(MIB1AV) + present(MIBDEV) + present(BICEXV)
    + present(BICPMVCTV) + present(BICNOV) + present(BICDNV) 
    + present(BIHEXV) + present(BIHNOV) + present(BIHDNV)
    + present(BI1AV) + present(BIPERPV)
    + present(BNCPROEXV) + present(BNCPROV) + present(BNCPROPVV) + present(BNCPRO1AV)
    + present(BNCPRODEV) + present(BNCPMVCTV) + present(BNCEXV) + present(BNCREV)
    + present(BNCDEV) + present(BNHEXV) + present(BNHREV) + present(BNHDEV)
    + present(BN1AV) + present(BNCCRV) + present(CESSASSV) 
    + present(AUTOBICVV) + present(AUTOBICPV) + present(LOCPROCGAV)
    + present(LOCDEFPROCGAV) + present(LOCPROV) + present(LOCDEFPROV)
    + present(AUTOBNCV) + present(XHONOAAV) + present(XHONOV)
    + present(GLDGRATV) + present(SALINTV) + present(BICPMVCTV))
   *
   (present(TSHALLOC) + present(ALLOC) + present(GLD1C) + present(GLD2C) + present(GLD3C)
    + present(BPCOSAC) + present(TSASSUC) + present(XETRANC) 
    + present(TSELUPPEC) + present(CARTSC) + present(REMPLAC) + present(HEURESUPC)
    + present(FEXC) + present(BAFC) + positif(V_FORCA) + present(BAFORESTC)
    + present(BAFPVC) + present(BAF1AC) + present(BAEXC) + present(BACREC)
    + present(BACDEC) + present(BAHEXC) + present(BAHREC) + present(BAHDEC)
    + present(BA1AC) + present(BAPERPC)
    + present(MIBEXC) + present(MIBVENC) + present(MIBPRESC) + present(MIBPVC)
    + present(MIB1AC) + present(MIBDEC) + present(BICEXC)
    + present(BICPMVCTC) + present(BICNOC) + present(BICDNC) 
    + present(BIHEXC) + present(BIHNOC) + present(BIHDNC)
    + present(BI1AC) + present(BIPERPC)
    + present(BNCPROEXC) + present(BNCPROC) + present(BNCPROPVC) + present(BNCPRO1AC)
    + present(BNCPRODEC) + present(BNCEXC) + present(BNCREC)
    + present(BNCDEC) + present(BNHEXC) + present(BNHREC) + present(BNHDEC)
    + present(BN1AC) + present(BNCCRC) + present(CESSASSC)
    + present(AUTOBICVC) + present(AUTOBICVC) + present(LOCPROCGAC)
    + present(LOCDEFPROCGAC) + present(LOCPROC) + present(LOCDEFPROC)
    + present(AUTOBNCC) + present(XHONOAAC) + present(XHONOC)
    + present(GLDGRATC) + present(SALINTC) + present(BICPMVCTC) + present(BNCPMVCTC))

  + BOOL_0AM * positif(V_0AF) *
   (present(TSHALLOV) + present(ALLOV) + present(GLD1V) + present(GLD2V) + present(GLD3V)
   + present(BPCOSAV) + present(TSASSUV) + present(XETRANV) 
   + present(TSELUPPEV) + present(CARTSV) + present(REMPLAV) + present(HEURESUPV)
   + present(FEXV) + present(BAFV) + positif(V_FORVA) + present(BAFORESTV)
   + present(BAFPVV) + present(BAF1AV) + present(BAEXV) + present(BACREV)
   + present(BACDEV) + present(BAHEXV) + present(BAHREV) + present(BAHDEV)
   + present(BA1AV) + present(BAPERPV)
   + present(MIBEXV) + present(MIBVENV) + present(MIBPRESV) + present(MIBPVV)
   + present(MIB1AV) + present(MIBDEV) + present(BICEXV)
   + present( BICPMVCTV ) 
   + present(BICNOV) + present(BICDNV) 
   + present(BIHEXV) + present(BIHNOV) + present(BIHDNV)
   + present(BI1AV) + present(BIPERPV)
   + present(BNCPROEXV) + present(BNCPROV) + present(BNCPROPVV) + present(BNCPRO1AV)
   + present(BNCPRODEV) + present(BNCPMVCTV) + present(BNCEXV) + present(BNCREV)
   + present(BNCDEV) + present(BNHEXV) + present(BNHREV) + present(BNHDEV)
   + present(BN1AV) + present(BNCCRV) + present(CESSASSV)
   + present(AUTOBICVV) + present(AUTOBICPV) + present(LOCPROCGAV)
   + present(LOCDEFPROCGAV) + present(LOCPROV) + present(LOCDEFPROV)
   + present(AUTOBNCV) + present(XHONOAAV) + present(XHONOV)
   + present(GLDGRATV) + present(SALINTV) + present(BICPMVCTV))
  
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
   + present(BN1AC) + present(BNCCRC) + present(CESSASSC)
   + present(AUTOBICVC) + present(AUTOBICVC) + present(LOCPROCGAC)
   + present(LOCDEFPROCGAC) + present(LOCPROC) + present(LOCDEFPROC)
   + present(AUTOBNCC) + present(XHONOAAC) + present(XHONOC)
   + present(GLDGRATC) + present(SALINTC) + present(BICPMVCTC) + present(BNCPMVCTC))

   = 0
   )
alors erreur DD32 ;
