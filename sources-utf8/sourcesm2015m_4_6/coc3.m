#*************************************************************************************************************************
#
#Copyright or Â© or Copr.[DGFIP][2017]
#
#Ce logiciel a Ã©tÃ© initialement dÃ©veloppÃ© par la Direction GÃ©nÃ©rale des 
#Finances Publiques pour permettre le calcul de l'impÃ´t sur le revenu 2016 
#au titre des revenus perÃ§us en 2015. La prÃ©sente version a permis la 
#gÃ©nÃ©ration du moteur de calcul des chaÃ®nes de taxation des rÃ´les d'impÃ´t 
#sur le revenu de ce millÃ©sime.
#
#Ce logiciel est rÃ©gi par la licence CeCILL 2.1 soumise au droit franÃ§ais 
#et respectant les principes de diffusion des logiciels libres. Vous pouvez 
#utiliser, modifier et/ou redistribuer ce programme sous les conditions de 
#la licence CeCILL 2.1 telle que diffusÃ©e par le CEA, le CNRS et l'INRIA  sur 
#le site "http://www.cecill.info".
#
#Le fait que vous puissiez accÃ©der Ã  cet en-tÃªte signifie que vous avez pris 
#connaissance de la licence CeCILL 2.1 et que vous en avez acceptÃ© les termes.
#
#**************************************************************************************************************************
verif 1320:
application : iliad , batch ;


si
   DPVRCM > 0
   et
   BPVRCM + PEA + GAINPEA > 0

alors erreur A320 ;
verif 1323:
application : iliad , batch ;

si
   positif(ABIMPPV + 0) = 1
   et
   positif(ABIMPMV + 0) = 1

alors erreur A323 ;
verif 1325:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   positif(PVSURSI + 0) + positif(COD3WM + 0) = 1

alors erreur A325 ;
verif 1326:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   positif(PVIMPOS + 0) + positif(ABPVNOSURSIS + 0) = 1

alors erreur A326 ;
verif 13271:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   positif(CODRVG + 0) + positif(CODNVG + 0) = 1

alors erreur A32701 ;
verif 13272:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   positif(CODNVG + 0) = 1
   et
   null(4 - CODNVG) = 0

alors erreur A32702 ;
verif 13281:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   positif(CODRWA + 0) + positif(CODNWA + 0) = 1

alors erreur A32801 ;
verif 13282:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   positif(CODNWA + 0) = 1
   et
   null(4 - CODNWA) = 0

alors erreur A32802 ;
verif 13291:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   positif(CODRWB + 0) + positif(CODNWB + 0) = 1

alors erreur A32901 ;
verif 13292:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   positif(CODNWB + 0) = 1
   et
   null(4 - CODNWB) = 0

alors erreur A32902 ;
verif 1420:
application : batch , iliad ;


si
   RFMIC > 0
   et
   (RFORDI > 0 ou RFDORD > 0 ou RFDHIS > 0 ou FONCI > 0 ou REAMOR > 0 et FONCINB > 0 ou REAMORNB > 0)

alors erreur A420 ;
verif 1421:
application : batch , iliad;


si 
   V_IND_TRAIT > 0
   et
   RFMIC > LIM_MICFON
  
alors erreur A421 ;
verif 1422:
application : batch , iliad ;


si
   LOYIMP > 0 et ( present(RFORDI) = 0
                et
                   present(FONCI) = 0
                et
                   present(FONCINB) = 0
                et
                   present(REAMOR) = 0
                et
                   present(REAMORNB) = 0
                et
                   present(RFDORD) = 0
                et
                   present(RFDHIS) = 0
                et
                   present(RFMIC) = 0)

alors erreur A422 ;
verif 1423:
application : batch , iliad ;


si
   RFROBOR > 0
   et
   RFDANT > 0
   et
   present(RFORDI) = 0
   et
   present(RFDORD) = 0
   et
   present(RFDHIS) = 0
   
alors erreur A423 ;
verif 1424:
application : batch , iliad ;


si
   RFROBOR > 0
   et
   (FONCI > 0
    ou
    REAMOR > 0)

alors erreur A424 ;
verif 14251:
application : iliad , batch ;

si
   (V_IND_TRAIT = 4
    et
    (FONCINB < 2 ou FONCINB > 30))
   ou
   (V_IND_TRAIT = 5
    et
    (FONCINB = 1 ou FONCINB > 30))

alors erreur A42501 ;
verif 14252:
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
verif 14261:
application : iliad , batch ;

si
   (V_IND_TRAIT = 4
    et
    (REAMORNB < 2 ou REAMORNB > 14))
   ou
   (V_IND_TRAIT = 5
    et
    (REAMORNB = 1 ou REAMORNB > 14))

alors erreur A42601 ;
verif 14262:
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
verif 1534:
application : batch , iliad ;


si
   APPLI_COLBERT + APPLI_OCEANS = 0
   et
   positif_ou_nul(NAPT) = 0
   et
   (V_BTNATIMP+0) dans (1,11,71,81)
   et
   (positif(V_FORVA + 0) = 1
    ou
    positif(V_FORCA + 0) = 1
    ou
    positif(V_FORPA + 0) = 1)

alors erreur A534 ;
verif 1538: 
application : iliad , batch ;


si
   (RCSV > 0 et SOMMEA538VB = 0)
   ou
   (RCSC > 0 et SOMMEA538CB = 0)
   ou
   (RCSP > 0 et SOMMEA538PB = 0)

alors erreur A538 ;
verif 1600:
application : iliad , batch ;

si
   APPLI_OCEANS = 0
   et
   positif(PERPIMPATRIE+0) != 1
   et
   V_CNR + 0 != 1
   et
   ((positif(PERP_COTV+0) > 0 et
     present(PERPPLAFCV)*present(PERPPLAFNUV1)*present(PERPPLAFNUV2)*present(PERPPLAFNUV3) = 0)
    ou
    (positif(PERP_COTC+0) > 0 et
     present(PERPPLAFCC)*present(PERPPLAFNUC1)*present(PERPPLAFNUC2)*present(PERPPLAFNUC3) = 0)
    ou
    (positif(PERP_COTP+0) > 0 et
     present(PERPPLAFCP)*present(PERPPLAFNUP1)*present(PERPPLAFNUP2)*present(PERPPLAFNUP3) = 0))

alors erreur A600 ;
verif 1601:
application : iliad , batch ;

si
   APPLI_OCEANS = 0
   et
   V_CNR + 0 != 1 
   et
   positif(PERPIMPATRIE+0) != 1
   et
   (PERPPLAFCV > LIM_PERPMAXBT
    ou
    PERPPLAFCC > LIM_PERPMAXBT)

alors erreur A601 ;
verif 1603:
application : iliad , batch ;

si
   APPLI_OCEANS = 0
   et
   positif(PERPIMPATRIE + 0) != 1
   et
   positif(V_CALCULIR + 0) = 0
   et
   V_CNR + 0 != 1
   et
  (
  (positif_ou_nul(PLAF_PERPV) = 1 et
            (present(PERPPLAFCV) = 0 et present(PERPPLAFNUV1) = 0
             et present(PERPPLAFNUV2) = 0 et present(PERPPLAFNUV3) = 0 ))
  ou
  (positif_ou_nul(PLAF_PERPC) = 1 et
            (present(PERPPLAFCC) = 0 et present(PERPPLAFNUC1) = 0
             et present(PERPPLAFNUC2) = 0 et present(PERPPLAFNUC3) = 0 ))
  ou
  (positif_ou_nul(PLAF_PERPP) = 1 et
            (present(PERPPLAFCP) = 0 et present(PERPPLAFNUP1) = 0
             et present(PERPPLAFNUP2) = 0 et present(PERPPLAFNUP3) = 0 ))
  ou
  (positif_ou_nul(PLAF_PERPV) = 1
                 et (PERPPLAFCV+PERPPLAFNUV1+PERPPLAFNUV2+PERPPLAFNUV3 =
                      V_BTPERPV+V_BTPERPNUV1+V_BTPERPNUV2+V_BTPERPNUV3) )
  ou
  (positif_ou_nul(PLAF_PERPC) = 1
                 et (PERPPLAFCC+PERPPLAFNUC1+PERPPLAFNUC2+PERPPLAFNUC3 =
                      V_BTPERPC+V_BTPERPNUC1+V_BTPERPNUC2+V_BTPERPNUC3) )
  ou
  (positif_ou_nul(PLAF_PERPP) = 1
                 et (PERPPLAFCP+PERPPLAFNUP1+PERPPLAFNUP2+PERPPLAFNUP3 =
                      V_BTPERPP+V_BTPERPNUP1+V_BTPERPNUP2+V_BTPERPNUP3) )
  )
alors erreur A603 ;
verif 1604:
application : iliad , batch ;

si
   APPLI_OCEANS = 0
   et
   (positif(PERPMUTU) = 1 et (V_0AM + V_0AO = 1) et ((V_REGCO+0) dans (1,3,5,6,7))
    et positif(PERPIMPATRIE+0) = 0
    et (present(PERPPLAFCV) = 0 ou present(PERPPLAFNUV1) = 0
        ou present(PERPPLAFNUV2) = 0 ou present(PERPPLAFNUV3) = 0
        ou present(PERPPLAFCC) = 0 ou present(PERPPLAFNUC1) = 0
        ou present(PERPPLAFNUC2) = 0 ou present(PERPPLAFNUC3) =0))

alors erreur A604 ;
verif 16051:
application : iliad , batch ;

si
   APPLI_OCEANS = 0
   et
   V_IND_TRAIT > 0
   et
   PERPV + 0 < EXOCETV + 0
   et
   positif(EXOCETV + 0) = 1

alors erreur A60501 ;
verif 16052:
application : iliad , batch ;

si
   APPLI_OCEANS = 0
   et
   V_IND_TRAIT > 0
   et
   PERPC + 0 < EXOCETC + 0
   et
   positif(EXOCETC + 0) = 1

alors erreur A60502 ;
