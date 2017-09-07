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
regle 521000:
application : bareme , iliad , batch ;
 

TAUX1 = (TX_BAR1 - TX_BAR0 ) ;
TAUX2 = (TX_BAR2 - TX_BAR1 ) ;
TAUX3 = (TX_BAR3 - TX_BAR2 ) ;
TAUX4 = (TX_BAR4 - TX_BAR3 ) ;
TAUX5 = (TX_BAR5 - TX_BAR4 ) ;

regle 521010:
application : bareme , iliad , batch ;

pour x=0,5;y=1,2;z=1,2:
DSxyz = max( QFxyz - LIM_BAR1 , 0 ) * (TAUX1   / 100)
      + max( QFxyz - LIM_BAR2 , 0 ) * (TAUX2   / 100)
      + max( QFxyz - LIM_BAR3 , 0 ) * (TAUX3   / 100)
      + max( QFxyz - LIM_BAR4 , 0 ) * (TAUX4   / 100)
      + max( QFxyz - LIM_BAR5 , 0 ) * (TAUX5   / 100);

regle 521020:
application : iliad , batch ;

WTXMARJ = (RB51) / ( NB1 * null(PLAFQF) + NB2 *null(1-PLAFQF)) ;
TXMARJ = max ( positif (WTXMARJ - LIM_BAR1) * TX_BAR1 , 
                max ( positif (WTXMARJ - LIM_BAR2) * TX_BAR2 , 
                      max ( positif (WTXMARJ - LIM_BAR3) * TX_BAR3 , 
                             max ( positif (WTXMARJ - LIM_BAR4) * TX_BAR4 ,
                                   max ( positif (WTXMARJ - LIM_BAR5) * TX_BAR5 , 0
				       )
                                 )
                          )
                     )
              )

          * ( 1 - positif ( 
                              present ( NRBASE ) 
                            + present ( NRINET ) 
                            + present ( IPTEFP ) 
                            + present ( IPTEFN ) 
                            + present ( PRODOM ) 
                            + present ( PROGUY ) 
                          )              
             )
          * (1- V_CNR)
  * positif(IN01+IPQ1001);
TXMARJBA = max ( positif (WTXMARJ - LIM_BAR1) * TX_BAR1 , 
                max ( positif (WTXMARJ - LIM_BAR2) * TX_BAR2 , 
                      max ( positif (WTXMARJ - LIM_BAR3) * TX_BAR3 , 
                             max ( positif (WTXMARJ - LIM_BAR4) * TX_BAR4 ,
                                   max ( positif (WTXMARJ - LIM_BAR5) * TX_BAR5 , 0
				       )
                                 )
                          )
                     )
              )
  * positif(IN01+IPQ1001);

regle 521030:
application : bareme , iliad , batch ;
 

pour y=1,2:
DS0y4 = max( QF0y4 - LIM_BAR1 , 0 ) * (TAUX1 /100)
      + max( QF0y4 - LIM_BAR2 , 0 ) * (TAUX2 /100)
      + max( QF0y4 - LIM_BAR3 , 0 ) * (TAUX3 /100)
      + max( QF0y4 - LIM_BAR4 , 0 ) * (TAUX4 /100)
      + max( QF0y4 - LIM_BAR5 , 0 ) * (TAUX5 /100);
pour x=0,5;y=1,2:
DSxy5 = max( QFxy5 - LIM_BAR1 , 0 ) * (TAUX1 /100)
      + max( QFxy5 - LIM_BAR2 , 0 ) * (TAUX2 /100)
      + max( QFxy5 - LIM_BAR3 , 0 ) * (TAUX3 /100)
      + max( QFxy5 - LIM_BAR4 , 0 ) * (TAUX4 /100)
      + max( QFxy5 - LIM_BAR5 , 0 ) * (TAUX5 /100);
pour y=1,2:
DS0y6 = max( QF0y6 - LIM_BAR1 , 0 ) * (TAUX1 /100)
      + max( QF0y6 - LIM_BAR2 , 0 ) * (TAUX2 /100)
      + max( QF0y6 - LIM_BAR3 , 0 ) * (TAUX3 /100)
      + max( QF0y6 - LIM_BAR4 , 0 ) * (TAUX4 /100)
      + max( QF0y6 - LIM_BAR5 , 0 ) * (TAUX5 /100);

regle 521040:
application : bareme , iliad , batch ;

NB1 = NBPT ;
NB2 = 1 + BOOL_0AM + BOOL_0AZ * V_0AV ;

regle 521050:
application : bareme , iliad , batch ;
pour y=1,2;z=1,2:
QF0yz = arr(RB0z) / NBy;
pour y=1,2;z=1,2:
QF5yz = arr(RB5z) / NBy;
pour y=1,2:
QF0y4 = arr(RB04) / NBy;
pour x=0,5;y=1,2:
QFxy5 = arr(RBx5) / NBy;
pour y=1,2:
QF0y6 = arr(RB06) / NBy;
regle corrective 521070:
application : iliad , batch ;
CFRIAHP = ARESTIMO + ALOGDOM + ADUFREPFI + ADUFREPFK + ADUFLOEKL + ADUFLOGIH + APIREPAI
         + APIREPBI + APIREPCI + APIREPDI + APIQGH + APIQEF + APIQCD + APIQAB + ATOURREP
         + ATOUHOTR + ATOUREPA + ACELRREDLA + ACELRREDLB + ACELRREDLE + ACELRREDLM + ACELRREDLN
         + ACELRREDLG + ACELRREDLC + ACELRREDLD + ACELRREDLS + ACELRREDLT + ACELRREDLH + ACELRREDLF
         + ACELRREDLZ + ACELRREDLX + ACELRREDLI + ACELRREDMG + ACELRREDMH + ACELRREDLJ + ACELREPHS
         + ACELREPHR + ACELREPHU + ACELREPHT + ACELREPHZ + ACELREPHX + ACELREPHW + ACELREPHV + ACELREPHF
         + ACELREPHD + ACELREPHH + ACELREPHG + ACELREPHA + ACELREPGU + ACELREPGX + ACELREPGS + ACELREPGW
         + ACELREPGL + ACELREPGV + ACELREPGJ + ACELREPYH + ACELREPYL + ACELREPYF + ACELREPYK + ACELREPYD
         + ACELREPYJ + ACELREPYB + ACELREPYP + ACELREPYS + ACELREPYO + ACELREPYR + ACELREPYN + ACELREPYQ
         + ACELREPYM + ACELHM + ACELHL + ACELHNO + ACELHJK + ACELNQ + ACELNBGL + ACELCOM + ACEL + ACELJP
         + ACELJBGL + ACELJOQR + ACEL2012 + ACELFD + ACELFABC + AREDMEUB + AREDREP + AILMIX + AILMIY + AILMPA
         + AILMPF + AINVRED + AILMIH + AILMJC + AILMPB + AILMPG + AILMIZ + AILMJI + AILMPC + AILMPH + AILMJS
         + AILMPD + AILMPI + AILMPE + AILMPJ + AMEUBLE + APROREP + AREPNPRO + AREPMEU + AILMIC + AILMIB + AILMIA
         + AILMJY + AILMJX + AILMJW + AILMJV + AILMOE + AILMOD + AILMOC + AILMOB + AILMOA + AILMOJ + AILMOI + AILMOH
         + AILMOG + AILMOF + ARESIMEUB + ARESIVIEU + ARESINEUV + ALOCIDEFG + ACODJTJU + ACODOU + ACODOV;
CFRIRHP =  RRESTIMO + RLOGDOM + RDUFREPFI + RDUFREPFK + RDUFLOEKL + RDUFLOGIH + RPIREPAI + RPIREPBI
          + RPIREPCI + RPIREPDI + RPIQGH + RPIQEF + RPIQCD + RPIQAB + RTOURREP + RTOUHOTR + RTOUREPA
          + RCELRREDLA + RCELRREDLB + RCELRREDLE + RCELRREDLM + RCELRREDLN + RCELRREDLG + RCELRREDLC
          + RCELRREDLD + RCELRREDLS + RCELRREDLT + RCELRREDLH + RCELRREDLF + RCELRREDLZ + RCELRREDLX
          + RCELRREDLI + RCELRREDMG + RCELRREDMH + RCELRREDLJ + RCELREPHS + RCELREPHR + RCELREPHU + RCELREPHT
          + RCELREPHZ + RCELREPHX + RCELREPHW + RCELREPHV + RCELREPHF + RCELREPHD + RCELREPHH + RCELREPHG
          + RCELREPHA + RCELREPGU + RCELREPGX + RCELREPGS + RCELREPGW + RCELREPGL + RCELREPGV + RCELREPGJ
          + RCELREPYH + RCELREPYL + RCELREPYF + RCELREPYK + RCELREPYD + RCELREPYJ + RCELREPYB + RCELREPYP
          + RCELREPYS + RCELREPYO + RCELREPYR + RCELREPYN + RCELREPYQ + RCELREPYM + RCELHM + RCELHL + RCELHNO
          + RCELHJK + RCELNQ + RCELNBGL + RCELCOM + RCEL + RCELJP + RCELJBGL + RCELJOQR + RCEL2012 + RCELFD
          + RCELFABC + RREDMEUB + RREDREP + RILMIX + RILMIY + RILMPA + RILMPF + RINVRED + RILMIH + RILMJC
          + RILMPB + RILMPG + RILMIZ + RILMJI + RILMPC + RILMPH + RILMJS + RILMPD + RILMPI + RILMPE
          + RILMPJ + RMEUBLE + RPROREP + RREPNPRO + RREPMEU + RILMIC + RILMIB + RILMIA + RILMJY + RILMJX
          + RILMJW + RILMJV + RILMOE + RILMOD + RILMOC + RILMOB + RILMOA + RILMOJ + RILMOI + RILMOH + RILMOG
          + RILMOF + RRESIMEUB + RRESIVIEU + RRESINEUV + RLOCIDEFG + RCODJTJU + RCODOU + RCODOV ;
CFRIADON = AREPA + ADONS;
CFRIRDON = RREPA + RDONS;
CFRIAENF = APRESCOMP;
CFRIRENF = RPRESCOMP + RRETU;
CFRIADEP = AHEBE + AAIDE;
CFRIRDEP = RHEBE + RAIDE;
CFRIAFOR = BFCPI + ACOMP + AFOREST + AFORET + ANOUV + ALOCENT + ALOGSOC + ACOLENT + ACOTFOR + ADOMSOC1 + AFIPDOM;
CFRIRFOR = RINNO + RCOMP + RFOREST + RFORET + RNOUV + RLOCENT + RLOGSOC + RCOLENT + RCOTFOR + RDOMSOC1 + RFIPDOM;
CFRIAVIE = ASURV;
CFRIRVIE = RSURV;
CFRIAAUTRE = AFIPC + ADIFAGRI + ASOCREPR+ASOUFIP+ARIRENOV+APATNAT+APATNAT1+APATNAT2+APATNAT3;
CFRIRAUTRE = RFIPC + RDIFAGRI + RSOCREPR+RSOUFIP+RRIRENOV+RPATNAT+RPATNAT1+RPATNAT2+RPATNAT3;
CFCIDIV = CIGARD + CISYND + CIADCRE + CIFORET;
TOTDEFRCM = DFRCM1 + DFRCM2+DFRCM3 +DFRCM4 +DFRCM5 +DFRCMN;
TOTDEFLOC = DEFLOC1 + DEFLOC2 +DEFLOC3 +DEFLOC4 +DEFLOC5 +DEFLOC6 +DEFLOC7 +DEFLOC8 +DEFLOC9 +DEFLOC10;
TOTMIBV = MIBRNETV + MIBNPRNETV + MIBNPPVV + MIBPVV - BICPMVCTV - MIBNPDCT;
TOTMIBC = MIBRNETC + MIBNPRNETC + MIBNPPVC + MIBPVC - BICPMVCTC;
TOTMIBP = MIBRNETP + MIBNPRNETP + MIBNPPVP + MIBPVP - BICPMVCTP;
TOTBNCV = SPENETPV + SPENETNPV + BNCPROPVV - BNCPMVCTV + BNCNPPVV - BNCNPDCT;
TOTBNCC = SPENETPC + SPENETNPC + BNCPROPVC - BNCPMVCTC + BNCNPPVC;
TOTBNCP = SPENETPP + SPENETNPP + BNCPROPVP - BNCPMVCTP + BNCNPPVP;
TOTSPEREP = SPEDREPV + SPEDREPC +SPEDREPP;
TOTSPEREPNP = SPEDREPNPV + SPEDREPNPC +SPEDREPNPP;
IRNINCFIR = IAN+AVFISCOPTER-IRE;

regle 522000:
application : iliad , batch ;

CODMESGOUV = positif(NBPT - 10) + positif(LIGTTPVQ + LIG74 + LIGHAUTNET) + null(2 - V_REGCO) + positif(CESSASSV + CESSASSC + PCAPTAXV + PCAPTAXC + LOYELEV + 0)
             + positif(IPROP + AVFISCOPTER + IPREP + IPPRICORSE) + (null(V_ZDC - 1) * positif(V_0AC + V_0AD + V_0AV + V_0AM + V_0AO + 0)) ;

MESGOUV2 =  1 * positif((IDRS3 - IDECA) * positif(IDECA + 0) + (IDRS3 - IDEC) * positif(IDEC + 0)) * (1 - positif(CODMESGOUV)) * (1 - positif(V_BTPPE + 0))
          + 2 * positif((IDRS3 - IDECA) * positif(IDECA + 0) + (IDRS3 - IDEC) * positif(IDEC + 0)) * (1 - positif(CODMESGOUV)) * positif(V_BTPPE + 0)
          + 3 * positif((null(IDRS3 - IDECA) * positif(IDECA + 0)) + null(IDEC) + CODMESGOUV) ;

sortie(V_CALCUL_MESGOUV) ;

regle 522010:
application : iliad , batch ;

V_ANC_NAP = V_ANC_NAPE * (1 - (2 * V_ANC_NEG)) ;

GAINDBLELIQ = max(0 , V_ANC_NAP - NAPT) * null(MESGOUV2 - 1) ; 

VANCNAP = V_ANC_NAP ;

regle 522020:
application : iliad , batch ;

MESGOUV = MESGOUV2 ;

