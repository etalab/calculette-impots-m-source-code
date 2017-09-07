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
verif 1700:
application : iliad ,batch ;

si
   RDCOM > 0
   et
   SOMMEA700 = 0

alors erreur A700 ;
verif 1702:
application : batch , iliad ;

si
   (V_REGCO+0) dans (1,3,5,6,7)
   et
   INTDIFAGRI * positif(INTDIFAGRI) + 0 > RCMHAB * positif(RCMHAB) + COD2FA * positif(COD2FA) + 0

alors erreur A702 ;
verif 1703:
application : batch , iliad ;

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
alors erreur A703 ;
verif 1704:
application : batch , iliad ;


si
   (positif(CASEPRETUD + 0) = 1 et positif(PRETUDANT + 0) = 0)
   ou
   (positif(CASEPRETUD + 0) = 0 et positif(PRETUDANT + 0) = 1)

alors erreur A704 ;
verif 17071:
application : batch , iliad ;


si
   RDENS + RDENL + RDENU > V_0CF + V_0DJ + V_0DN + 0

alors erreur A70701 ;
verif 17072:
application : batch , iliad ;


si
   RDENSQAR + RDENLQAR + RDENUQAR > V_0CH + V_0DP + 0

alors erreur A70702 ;
verif 1708:
application : iliad , batch;


si
   V_IND_TRAIT > 0
   et
   (
    RINVLOCINV + 0 > LIMLOC2
    ou
    RINVLOCREA + 0 > LIMLOC2
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
    ou
    COD7UY + 0 > LIMLOC2
    ou
    COD7UZ + 0 > LIMLOC2
   )

alors erreur A708 ;
verif 1709:
application : batch , iliad ;


si
   SOMMEA709 > 1

alors erreur A709 ;
verif 1710:
application : batch , iliad ;

si
   V_IND_TRAIT > 0
   et
   positif(CREAIDE + 0) * positif(RVAIDE + 0) = 1

alors erreur A710 ;
verif 17111:
application : batch , iliad ;


si
   V_IND_TRAIT > 0
   et
   INAIDE > 0
   et
   positif(RVAIDE + RVAIDAS + CREAIDE + 0) = 0

alors erreur A71101 ;
verif 17112:
application : batch , iliad ;

si
   V_IND_TRAIT > 0
   et
   positif(ASCAPA + 0) + positif(RVAIDAS + 0) = 1

alors erreur A71102 ;
verif 17113:
application : batch , iliad ;

si
   V_IND_TRAIT > 0
   et
   PREMAIDE > 0
   et
   positif(RVAIDE + RVAIDAS + CREAIDE + 0) = 0

alors erreur A71103 ;
verif 1712:
application : batch , iliad ;


si
   PRESCOMP2000 + 0 > PRESCOMPJUGE
   et
   positif(PRESCOMPJUGE) = 1

alors erreur A712 ;
verif non_auto_cc 1713:
application : batch , iliad ;


si
   (PRESCOMPJUGE + 0 > 0 et PRESCOMP2000 + 0 = 0)
   ou
   (PRESCOMPJUGE + 0 = 0 et PRESCOMP2000 + 0 > 0)

alors erreur A713 ;
verif 1714:
application : batch , iliad ;


si
   RDPRESREPORT + 0 > 0
   et
   PRESCOMPJUGE + PRESCOMP2000 + 0 > 0

alors erreur A714 ;
verif 1715:
application : batch , iliad ;

si
   V_IND_TRAIT > 0
   et
   RDPRESREPORT + 0 > LIM_REPCOMPENS

alors erreur A715 ;
verif 1716:
application : batch , iliad ;

si
   V_IND_TRAIT > 0
   et
   ((SUBSTITRENTE < PRESCOMP2000 + 0)
    ou
    (SUBSTITRENTE > 0 et present(PRESCOMP2000) = 0))

alors erreur A716 ;
verif 17171:
application : batch , iliad ;

si
   V_IND_TRAIT > 0
   et
   positif(CELLIERFA) + positif(CELLIERFB) + positif(CELLIERFC) + positif(CELLIERFD) > 1

alors erreur A71701 ;
verif 17172:
application : batch , iliad ;

si
   V_IND_TRAIT > 0
   et
   SOMMEA71701 > 1

alors erreur A71702 ;
verif 17173:
application : batch , iliad ;

si
   V_IND_TRAIT > 0
   et
   SOMMEA71702 > 1

alors erreur A71703 ;
verif 17174:
application : batch , iliad ;

si
   V_IND_TRAIT > 0
   et
   positif(CELLIERHJ) + positif(CELLIERHK) + positif(CELLIERHN) + positif(CELLIERHO) > 1

alors erreur A71704 ;
verif 17175:
application : batch , iliad ;


si
   V_IND_TRAIT > 0
   et
   positif(CELLIERHL) + positif(CELLIERHM) > 1

alors erreur A71705 ;
verif 1718:
application : batch , iliad ;


si
   CIAQCUL > 0
   et
   SOMMEA718 = 0

alors erreur A718 ;
verif 1719:
application : batch , iliad ;


si
   RDMECENAT > 0
   et
   SOMMEA719 = 0

alors erreur A719 ;
verif 17301:
application : batch , iliad ;


si
   V_IND_TRAIT > 0
   et
   REPFOR + 0 > 0
   et
   REPSINFOR2 + 0 > 0

alors erreur A73001 ;
verif 17302:
application : batch , iliad ;


si
   V_IND_TRAIT > 0
   et
   REPFOR1 + 0 > 0
   et
   REPSINFOR3 + 0 > 0

alors erreur A73002 ;
verif 17303:
application : batch , iliad ;


si
   V_IND_TRAIT > 0
   et
   REPFOR2 + 0 > 0
   et
   REPSINFOR4 + 0 > 0

alors erreur A73003 ;
verif 1731:
application : batch , iliad ;


si
   V_IND_TRAIT > 0
   et
   CASEPRETUD + 0 > 5

alors erreur A731 ;
verif 1734:
application : batch , iliad ;

si
    positif(PTZDEVDUR + 0) = 1
    et
    positif(PTZDEVDURN + 0) = 1

alors erreur A734 ;
verif 1735:
application : batch , iliad ;

si
   positif(PTZDEVDUR + 0) + positif(PTZDEVDURN + 0) = 1
   et
   positif(CIBOIBAIL + CINRJBAIL + CRENRJ + TRAMURWC + CINRJ + TRATOIVG + CIDEP15 + MATISOSI + TRAVITWT + MATISOSJ 
           + VOLISO + PORENT + CHAUBOISN + POMPESP + POMPESQ + POMPESR + CHAUFSOL + ENERGIEST + DIAGPERF + RESCHAL 
           + COD7SA + COD7SB + COD7SC + COD7WB + COD7RG + COD7VH + COD7RH + COD7RI + COD7WU + COD7RJ + COD7RK + COD7RL 
           + COD7RN + COD7RP + COD7RR + COD7RS + COD7RQ + COD7RT + COD7TV + COD7TW + COD7RV + COD7RW + COD7RZ + COD7TA 
           + COD7TB + COD7TC + COD7XB + COD7XC + COD7WH + COD7WI + COD7VI + COD7WV + COD7WW + COD7VK + COD7VL + COD7TN 
           + COD7TP + COD7TR + COD7TS + COD7TQ + COD7TT + COD7TX + COD7TY + COD7RU + COD7SU + COD7RM + COD7SM + COD7RO 
           + COD7SO + COD7SZ + COD7AA + COD7AD + COD7AF + COD7AH + COD7AK + COD7AL + COD7AM + COD7AN + COD7AQ + COD7AR 
           + COD7AV + COD7AX + COD7AY + COD7AZ + COD7BB + COD7BC + COD7BD + COD7BE + COD7BF + COD7BH + COD7BK + COD7BL
           + 0) = 0

alors erreur A735 ;
verif 17361:
application : batch , iliad ;

si
   V_IND_TRAIT > 0
   et
   positif(DUFLOEK) + positif(DUFLOEL) + positif(PINELQA) + positif(PINELQB) + positif(PINELQC) + positif(PINELQD) + 0 > 2

alors erreur A73601 ;
verif 17362:
application : batch , iliad ;

si
   V_IND_TRAIT > 0
   et
   positif(PINELQE) + positif(PINELQF) + positif(PINELQG) + positif(PINELQH) + 0 > 2

alors erreur A73602 ;
verif 17401:
application : batch , iliad ;

si
   V_IND_TRAIT > 0
   et
   (CODHAE + CODHAJ + 0) > PLAF_INVDOM5
   et
   positif(CODHAO + CODHAT + CODHAY + CODHBG + 0) = 0

alors erreur A74001 ;
verif 17402:
application : batch , iliad ;

si
   V_IND_TRAIT > 0
   et
   (CODHAO + CODHAT + CODHAY + CODHBG + 0) > PLAF_INVDOM6

alors erreur A74002 ;
verif 17403:
application : batch , iliad ;

si
   V_IND_TRAIT > 0
   et
   positif(CODHAE + CODHAJ + 0) = 1
   et
   positif(CODHAO + CODHAT + CODHAY + CODHBG + 0) = 1
   et
   (CODHAE + CODHAJ + CODHAO + CODHAT + CODHAY + CODHBG + 0) > PLAF_INVDOM6

alors erreur A74003 ;
verif 17404:
application : batch , iliad ;

si
   V_IND_TRAIT > 0
   et
   (CODHBM + CODHBR + CODHBW + CODHCB + CODHCG + 0) > PLAF_INVDOM2

alors erreur A74004 ;
verif 1741:
application : batch , iliad ;


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

alors erreur A741 ;
verif 1743:
application : batch , iliad ;

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

alors erreur A743 ;
verif 1745:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   positif_ou_nul(COD7ZW + COD7ZX + COD7ZY + COD7ZZ) = 1
   et
   positif_ou_nul(COD7ZW) + positif_ou_nul(COD7ZX) + positif_ou_nul(COD7ZY) + positif_ou_nul(COD7ZZ) < 4

alors erreur A745 ;
verif 17461:
application : batch , iliad ;

si
   V_IND_TRAIT > 0
   et
   CODHBM * positif(CODHBM + 0) > CODHBL * positif(CODHBL + 0) + 0

alors erreur A74601 ;
verif 17462:
application : batch , iliad ;

si
   V_IND_TRAIT > 0
   et
   CODHBR * positif(CODHBR + 0) > CODHBQ * positif(CODHBQ + 0) + 0

alors erreur A74602 ;
verif 17463:
application : batch , iliad ;

si
   V_IND_TRAIT > 0
   et
   CODHBW * positif(CODHBW + 0) > CODHBV * positif(CODHBV + 0) + 0

alors erreur A74603 ;
verif 17464:
application : batch , iliad ;

si
   V_IND_TRAIT > 0
   et
   CODHCB * positif(CODHCB + 0) > CODHCA * positif(CODHCA + 0) + 0

alors erreur A74604 ;
verif 17465:
application : batch , iliad ;

si
   V_IND_TRAIT > 0
   et
   CODHCG * positif(CODHCG + 0) > CODHCF * positif(CODHCF + 0) + 0

alors erreur A74605 ;
verif 1747:
application : iliad , batch ;

si
   FIPDOMCOM + 0 > 0
   et
   V_EAD + V_EAG + 0 = 0

alors erreur A747 ;
verif 17511:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   positif(TRAVITWT + 0) + positif(MATISOSJ + 0) > 1

alors erreur A75101 ;
verif 17512:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   positif(COD7WU + 0) + positif(COD7RJ + 0) > 1

alors erreur A75102 ;
verif 17513:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   positif(COD7WV + 0) + positif(COD7WW + 0) > 1

alors erreur A75103 ;
verif 17514:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   positif(TRAVITWT + 0) + positif(COD7WU + 0) + positif(COD7WV + 0) > 2

alors erreur A75104 ;
verif 17515:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   positif(TRAMURWC + 0) + positif(CINRJ + 0) > 1

alors erreur A75105 ;
verif 17516:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   positif(COD7WB + 0) + positif(COD7RG + 0) > 1

alors erreur A75106 ;
verif 17517:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   positif(COD7XB + 0) + positif(COD7XC + 0) > 1

alors erreur A75107 ;
verif 17518:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   positif(TRAMURWC + 0) + positif(COD7WB + 0) + positif(COD7XB + 0) > 2

alors erreur A75108 ;
verif 17519:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   positif(TRATOIVG + 0) + positif(CIDEP15 + 0) > 1

alors erreur A75109 ;
verif 175110:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   positif(COD7VH + 0) + positif(COD7RH + 0) > 1

alors erreur A75110 ;
verif 175111:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   positif(COD7WH + 0) + positif(COD7WI + 0) > 1

alors erreur A75111 ;
verif 175112:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   positif(TRATOIVG + 0) + positif(COD7VH + 0) + positif(COD7WH + 0) > 1

alors erreur A75112 ;
verif 1752:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   positif_ou_nul(COD7XD + COD7XE + COD7XF + COD7XG) = 1
   et
   positif_ou_nul(COD7XD) + positif_ou_nul(COD7XE) + positif_ou_nul(COD7XF) + positif_ou_nul(COD7XG) < 4

alors erreur A752 ;
verif 1753:
application : iliad , batch ;

si
   positif(COD7AA + COD7AD + COD7AF + COD7AH + COD7AK + COD7AL + COD7AM + COD7AN + COD7AQ + COD7AR + COD7AV 
           + COD7AX + COD7AY + COD7AZ + COD7BB + COD7BC + COD7BD + COD7BE + COD7BF + COD7BH + COD7BK + COD7BL + 0) = 1
   et
   positif(CIBOIBAIL + CINRJBAIL + CRENRJ + TRAMURWC + CINRJ + TRATOIVG + CIDEP15 + MATISOSI + TRAVITWT + MATISOSJ 
           + VOLISO + PORENT + CHAUBOISN + POMPESP + POMPESQ + POMPESR + CHAUFSOL + ENERGIEST + DIAGPERF + RESCHAL 
           + COD7SA + COD7SB + COD7SC + COD7WB + COD7RG + COD7VH + COD7RH + COD7RI + COD7WU + COD7RJ + COD7RK 
           + COD7RL + COD7RN + COD7RP + COD7RR + COD7RS + COD7RQ + COD7RT + COD7TV + COD7TW + COD7RV + COD7RW 
           + COD7RZ + COD7TA + COD7TB + COD7TC + COD7XB + COD7XC + COD7WH + COD7WI + COD7VI + COD7WV + COD7WW 
           + COD7VK + COD7VL + COD7TN + COD7TP + COD7TR + COD7TS + COD7TQ + COD7TT + COD7TX + COD7TY + COD7RU 
           + COD7SU + COD7RM + COD7SM + COD7RO + COD7SO + COD7SZ + 0) = 1

alors erreur A753 ;
