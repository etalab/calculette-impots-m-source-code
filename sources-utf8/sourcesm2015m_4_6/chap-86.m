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
regle 861000:
application : iliad , batch ;

VARBNHDEV = min(max(BNHREV,max(BNHREV_P,BNHREVP2)),BNHDEV);
VARBNHDEC = min(max(BNHREC,max(BNHREC_P,BNHRECP2)),BNHDEC);
VARBNHDEP = min(max(BNHREP,max(BNHREP_P,BNHREPP2)),BNHDEP);
VARBNCDEV = min(max(BNCREV,max(BNCREV_P,BNCREVP2)),BNCDEV);
VARBNCDEC = min(max(BNCREC,max(BNCREC_P,BNCRECP2)),BNCDEC);
VARBNCDEP = min(max(BNCREP,max(BNCREP_P,BNCREPP2)),BNCDEP);
BNNSV = (positif(BNHREV - BNHDEV)
                                   * arr((BNHREV-BNHDEV)*MAJREV)
     + (1-positif_ou_nul(BNHREV-BNHDEV))
                                   *(BNHREV-BNHDEV));
BNNSC = (positif(BNHREC - BNHDEC)
                                   * arr((BNHREC-BNHDEC)*MAJREV)
     + (1-positif_ou_nul(BNHREC-BNHDEC))
                                   *(BNHREC-BNHDEC));
BNNSP = (positif(BNHREP - BNHDEP)
                                   * arr((BNHREP-BNHDEP)*MAJREV)
     + (1-positif_ou_nul(BNHREP-BNHDEP))
                                   *(BNHREP-BNHDEP));
BNNAV = (BNCREV - BNCDEV);
BNNAC = (BNCREC - BNCDEC);
BNNAP = (BNCREP - BNCDEP);
VARBNCAAV = min(max(BNCAABV,max(BNCAABV_P,BNCAABVP2)),BNCAADV) ;
VARBNCAAC = min(max(BNCAABC,max(BNCAABC_P,BNCAABCP2)),BNCAADC) ;
VARBNCAAP = min(max(BNCAABP,max(BNCAABP_P,BNCAABPP2)),BNCAADP) ;
BNNAAV = (BNCAABV - BNCAADV) ;
BNNAAC = (BNCAABC - BNCAADC) ;
BNNAAP = (BNCAABP - BNCAADP) ;

regle 861010:
application : iliad , batch ;


VARDNOCEPV = min(max(DNOCEP,max(DNOCEP_P,DNOCEPP2)),ANOCEP);
VARDNOCEPC = min(max(DNOCEPC,max(DNOCEPC_P,DNOCEPCP2)),ANOVEP);
VARDNOCEPP = min(max(DNOCEPP,max(DNOCEPP_P,DNOCEPPP2)),ANOPEP);
NOCEPV = ANOCEP - DNOCEP + (BNCAABV - BNCAADV); 

NOCEPC = ANOVEP - DNOCEPC + (BNCAABC - BNCAADC); 

NOCEPP = ANOPEP - DNOCEPP + (BNCAABP - BNCAADP); 

NOCEPIMPV = positif(ANOCEP - DNOCEP ) *arr((ANOCEP- DNOCEP)*MAJREV)
                    + positif_ou_nul(DNOCEP -ANOCEP) *(ANOCEP- DNOCEP )+BNNAAV;

NOCEPIMPC = positif(ANOVEP - DNOCEPC ) *arr((ANOVEP- DNOCEPC)*MAJREV)
                    + positif_ou_nul(DNOCEPC -ANOVEP) *(ANOVEP- DNOCEPC )+BNNAAC;
NOCEPIMPP = positif(ANOPEP - DNOCEPP ) *arr((ANOPEP- DNOCEPP)*MAJREV)
                    + positif_ou_nul(DNOCEPP -ANOPEP) *(ANOPEP- DNOCEPP )+BNNAAP;
NOCEPIMP = NOCEPIMPV+NOCEPIMPC+NOCEPIMPP;

TOTDABNCNP = (DABNCNP6 + DABNCNP5 + DABNCNP4 + DABNCNP3 + DABNCNP2 + DABNCNP1);

regle 861020:
application : iliad , batch ;


BNN = somme(i=V,C,P:BNRi) + SPENETPF + BNCIF ;

regle 861030:
application : iliad , batch ;


pour i = V,C,P:
BNNi =  BNRi + SPENETi ;

regle 861040:
application : iliad , batch ;

pour i = V,C,P:
BNRi = BNNSi + BNNAi;
BNRPROV = (somme(i=V,C,P: (positif(BNHREi - BNHDEi) * arr((BNHREi-BNHDEi)*MAJREV)
                       + (1-positif_ou_nul(BNHREi-BNHDEi)) *(BNHREi-BNHDEi))
                              + (BNCREi - BNCDEi)));
BNRTOT = BNRV + BNRC + BNRP ;

regle 861050:
application : iliad , batch ;


BN1 = somme(i=V,C,P:BN1i) ;

regle 861060:
application : iliad , batch ;


pour i = V,C,P:
BN1i = BN1Ai + PVINiE + INVENTi ;

regle 861070:                                                                    
application : iliad , batch ;                          
                                                                               
                                                                               
pour i = V,C,P:                                                                 
SPETOTi = BNCPROi + BNCNPi ;

regle 861080:
application : iliad , batch ;                          
                                                                   

pour i = V,C,P:                                                                 
SPEBASABi=SPETOTi ;
                                                                               
pour i = V,C,P:                                                                 
SPEABi = arr((max(MIN_SPEBNC,(SPEBASABi * SPETXAB/100))) * 
                       positif_ou_nul(SPETOTi - MIN_SPEBNC)) +
          arr((min(MIN_SPEBNC,SPEBASABi )) * 
                       positif(MIN_SPEBNC - SPETOTi)) ; 

regle 861090:
application : iliad , batch ;                          
                                                                               
                                                                               
pour i = V,C,P:                                                                 
SPEABPi = arr((SPEABi * BNCPROi)/SPETOTi) ; 
                                                                               
pour i = V,C,P:                                                                 
SPEABNPi = SPEABi - SPEABPi ; 

regle 861100:
application : iliad , batch ;                          
                                                                        
                                                                               
pour i = V,C,P:                                                                 
SPENETPi = max (0,(BNCPROi - SPEABPi)) ; 
                                                                               
pour i = V,C,P:                                                                 
SPENETNPi = max (0,(BNCNPi - SPEABNPi)) ;

pour i = V,C,P:                                                                 
SPENETi = SPENETPi + SPENETNPi ;
                                                                               
SPENET = somme(i=V,C,P:(SPENETi)) ;

regle 861110:
application : iliad , batch ;                          

SPENETCT = BNCPROPVV + BNCPROPVC + BNCPROPVP - BNCPMVCTV - BNCPMVCTC - BNCPMVCTP ;
                                                                               
SPENETNPCT = BNCNPPVV + BNCNPPVC + BNCNPPVP - BNCNPDCT ;

regle 861120:
application : iliad , batch ; 

SPENETPF = somme(i=V,C,P:SPENETPi) + SPENETCT ;

SPENETNPF = somme(i=V,C,P:SPENETNPi) + SPENETNPCT ;                                    
BNCNPTOT = SPENETPF + SPENETNPF ;

regle 861130:
application : iliad , batch ;                          
pour i = V,C,P:                                                                 
SPEPVPi = BNCPRO1Ai - BNCPRODEi;
pour i = V,C,P:                                                                 
SPEPVNPi = BNCNP1Ai - BNCNPDEi;
                                                                               
SPEPV = somme(i=V,C,P:max(0,SPEPVPi + SPEPVNPi)) ;

regle 861140:
application : iliad , batch ;                          

DCTSPE = positif_ou_nul(BNRTOT+SPENETPF) * BNCPMVCTV
        + ( 1 - positif_ou_nul(BNRTOT+SPENETPF)) * (BNCPMVCTV-abs(BNRTOT+SPENETPF))
        + ( 1 - positif_ou_nul(BNRTOT+SPENETPF)) * null(BNCPMVCTV-abs(BNRTOT+SPENETPF))* BNCPMVCTV
	;
DCTSPENP = positif_ou_nul(NOCEPIMP+SPENETNPF) * BNCNPDCT
        + ( 1 - positif_ou_nul(NOCEPIMP+SPENETNPF)) * (BNCNPDCT-abs(NOCEPIMP+SPENETNPF))
        + ( 1 - positif_ou_nul(NOCEPIMP+SPENETNPF)) * null(BNCNPDCT-abs(NOCEPIMP+SPENETNPF)) * BNCNPDCT
	;
regle 861150:
application : iliad , batch ;

BNCDF1 = ((1-positif_ou_nul(NOCEPIMP+SPENETNPF)) * abs(NOCEPIMP+SPENETNPF)
                + positif_ou_nul(NOCEPIMP+SPENETNPF)
                * positif_ou_nul(DABNCNP5+DABNCNP4+DABNCNP3+DABNCNP2+DABNCNP1-NOCEPIMP-SPENETNPF)
                * (DABNCNP5+DABNCNP4+DABNCNP3+DABNCNP2+DABNCNP1-NOCEPIMP-SPENETNPF)
                * null(BNCDF6P+BNCDF5P+BNCDF4P+BNCDF3P+BNCDF2P)) * null(4-V_IND_TRAIT)
          + null(5-V_IND_TRAIT) * (
               positif(DEFBNCNPF) * max(0,DEFBNCNPF-DIDABNCNP)
              + (1-positif(DEFBNCNPF)) *  max(0,-(NOCEPIMPV+NOCEPIMPC+NOCEPIMPP+SPENETNPF)));

regle 861160:
application : iliad , batch ;                          
                                                                               
BNCDF2 = ((1-positif_ou_nul(NOCEPIMP+SPENETNPF)) * (DABNCNP1)
                + positif_ou_nul(NOCEPIMP+SPENETNPF)
                * min(max(NOCEPIMP+SPENETNPF-DABNCNP6-DABNCNP5-DABNCNP4-DABNCNP3-DABNCNP2,0)-DABNCNP1,DABNCNP1)*(-1)
                * positif_ou_nul(DABNCNP1-max(NOCEPIMP+SPENETNPF-DABNCNP6-DABNCNP5-DABNCNP4-DABNCNP3-DABNCNP2,0)))* null(4-V_IND_TRAIT)
          + null(5-V_IND_TRAIT) * (
               positif(DEFBNCNPF) * min(DABNCNP1,DEFBNCNPF+DABNCNP-DIDABNCNP-BNCDF1)
              + (1-positif(DEFBNCNPF)) *  min(DABNCNP1,DABNCNP-DIDABNCNP));

regle 861170:
application : iliad , batch ;                          

BNCDF3 = ((1 - positif_ou_nul(NOCEPIMP+SPENETNPF)) * (DABNCNP2)
                 + positif_ou_nul(NOCEPIMP+SPENETNPF)
                 * min(max(NOCEPIMP+SPENETNPF-DABNCNP6-DABNCNP5-DABNCNP4-DABNCNP3,0)-DABNCNP2,DABNCNP2)*(-1)
                 * positif_ou_nul(DABNCNP2-max(NOCEPIMP+SPENETNPF-DABNCNP6-DABNCNP5-DABNCNP4-DABNCNP3,0)))* null(4-V_IND_TRAIT)
          + null(5-V_IND_TRAIT) * (
               positif(DEFBNCNPF) * min(DABNCNP2,DEFBNCNPF+DABNCNP-DIDABNCNP-BNCDF1-BNCDF2)
              + (1-positif(DEFBNCNPF)) *  min(DABNCNP2,DABNCNP-DIDABNCNP-BNCDF2));
regle 861180:
application : iliad , batch ;                          
                                                                               
BNCDF4 = ((1 - positif_ou_nul(NOCEPIMP+SPENETNPF)) * (DABNCNP3)
                 + positif_ou_nul(NOCEPIMP+SPENETNPF)
                 * min(max(NOCEPIMP+SPENETNPF-DABNCNP6-DABNCNP5-DABNCNP4,0)-DABNCNP3,DABNCNP3)*(-1)
                 * positif_ou_nul(DABNCNP3-max(NOCEPIMP+SPENETNPF-DABNCNP6-DABNCNP5-DABNCNP4,0)))* null(4-V_IND_TRAIT)
          + null(5-V_IND_TRAIT) * (
               positif(DEFBNCNPF) * min(DABNCNP3,DEFBNCNPF+DABNCNP-DIDABNCNP-BNCDF1-BNCDF2-BNCDF3)
              + (1-positif(DEFBNCNPF)) *  min(DABNCNP3,DABNCNP-DIDABNCNP-BNCDF2-BNCDF3));
regle 861190:
application : iliad , batch ;                          

BNCDF5 = ((1 - positif_ou_nul(NOCEPIMP+SPENETNPF)) * (DABNCNP4)
                 + positif_ou_nul(NOCEPIMP+SPENETNPF)
                 * min(max(NOCEPIMP+SPENETNPF-DABNCNP6-DABNCNP5,0)-DABNCNP4,DABNCNP4)*(-1)
                 * positif_ou_nul(DABNCNP4-max(NOCEPIMP+SPENETNPF-DABNCNP6-DABNCNP5,0)))* null(4-V_IND_TRAIT)
          + null(5-V_IND_TRAIT) * (
               positif(DEFBNCNPF) * min(DABNCNP4,DEFBNCNPF+DABNCNP-DIDABNCNP-BNCDF1-BNCDF2-BNCDF3-BNCDF4)
              + (1-positif(DEFBNCNPF)) *  min(DABNCNP4,DABNCNP-DIDABNCNP-BNCDF2-BNCDF3-BNCDF4));
regle 861200:
application : iliad , batch ;                          

BNCDF6 = ((1 - positif_ou_nul(NOCEPIMP+SPENETNPF)) * (DABNCNP5)
                 + positif_ou_nul(NOCEPIMP+SPENETNPF)
                 * min(max(NOCEPIMP+SPENETNPF-DABNCNP6,0)-DABNCNP5,DABNCNP5)*(-1)
                 * positif_ou_nul(DABNCNP5-max(NOCEPIMP+SPENETNPF-DABNCNP6,0)))* null(4-V_IND_TRAIT)
          + null(5-V_IND_TRAIT) * (
               positif(DEFBNCNPF) * min(DABNCNP5,DEFBNCNPF+DABNCNP-DIDABNCNP-BNCDF1-BNCDF2-BNCDF3-BNCDF4-BNCDF5)
              + (1-positif(DEFBNCNPF)) *  min(DABNCNP5,DABNCNP-DIDABNCNP-BNCDF2-BNCDF3-BNCDF4-BNCDF5));
regle 86917:
application : iliad , batch  ;
BNCDF2P = ((1-positif_ou_nul(NOCEPIMP+SPENETNPF)) * (DABNCNP1)
                + positif_ou_nul(NOCEPIMP+SPENETNPF)
                * min(max(NOCEPIMP+SPENETNPF-DABNCNP6-DABNCNP5-DABNCNP4-DABNCNP3-DABNCNP2,0)-DABNCNP1,DABNCNP1)*(-1)
                * positif_ou_nul(DABNCNP1-max(NOCEPIMP+SPENETNPF-DABNCNP6-DABNCNP5-DABNCNP4-DABNCNP3-DABNCNP2,0)));
BNCDF3P = ((1 - positif_ou_nul(NOCEPIMP+SPENETNPF)) * (DABNCNP2)
                 + positif_ou_nul(NOCEPIMP+SPENETNPF)
                 * min(max(NOCEPIMP+SPENETNPF-DABNCNP6-DABNCNP5-DABNCNP4-DABNCNP3,0)-DABNCNP2,DABNCNP2)*(-1)
                 * positif_ou_nul(DABNCNP2-max(NOCEPIMP+SPENETNPF-DABNCNP6-DABNCNP5-DABNCNP4-DABNCNP3,0)));
BNCDF4P = ((1 - positif_ou_nul(NOCEPIMP+SPENETNPF)) * (DABNCNP3)
                 + positif_ou_nul(NOCEPIMP+SPENETNPF)
                 * min(max(NOCEPIMP+SPENETNPF-DABNCNP6-DABNCNP5-DABNCNP4,0)-DABNCNP3,DABNCNP3)*(-1)
                 * positif_ou_nul(DABNCNP3-max(NOCEPIMP+SPENETNPF-DABNCNP6-DABNCNP5-DABNCNP4,0)));
BNCDF5P = ((1 - positif_ou_nul(NOCEPIMP+SPENETNPF)) * (DABNCNP4)
                 + positif_ou_nul(NOCEPIMP+SPENETNPF)
                 * min(max(NOCEPIMP+SPENETNPF-DABNCNP6-DABNCNP5,0)-DABNCNP4,DABNCNP4)*(-1)
                 * positif_ou_nul(DABNCNP4-max(NOCEPIMP+SPENETNPF-DABNCNP6-DABNCNP5,0)));
BNCDF6P = ((1 - positif_ou_nul(NOCEPIMP+SPENETNPF)) * (DABNCNP5)
                 + positif_ou_nul(NOCEPIMP+SPENETNPF)
                 * min(max(NOCEPIMP+SPENETNPF-DABNCNP6,0)-DABNCNP5,DABNCNP5)*(-1)
                 * positif_ou_nul(DABNCNP5-max(NOCEPIMP+SPENETNPF-DABNCNP6,0)));
regle 861210:
application : iliad , batch ;

DABNCNP = DABNCNP1 + DABNCNP2 + DABNCNP3 + DABNCNP4 + DABNCNP5 + DABNCNP6 ;
VAREDABNCNP = min(DABNCNP,SPENETNPF + NOCEPIMP) ;

DEFBNCNP = (SPENETNPV+SPENETNPC+SPENETNPP+BNCNPPVV+BNCNPPVC+BNCNPPVP+BNCAABV+ANOCEP*MAJREV+BNCAABC+ANOVEP*MAJREV+BNCAABP+ANOPEP*MAJREV);
regle 861220:
application : iliad , batch ;

DEFBNCNPF = (1-PREM8_11) * positif(positif(SOMMEBNCND_2) * positif(BNCDF_P +BNCDFP2 +BNCDF1731))
                      * (max(0,min(min(max(BNCDF_P +BNCDF7_P,BNCDFP2+BNCDF7P2),BNCDF1731+BNCDF71731),
                               BNCNPDCT+DIDABNCNP+BNCAABV+ANOCEP*MAJREV+BNCAABC+ANOVEP*MAJREV+BNCAABP+ANOPEP*MAJREV-NOCEPIMPV-NOCEPIMPC-NOCEPIMPP
                                                            -(max(DEFBNCNP1731,max(DEFBNCNP_P,DEFBNCNPP2)))
                                                            - max(0,SPENETNPV+SPENETNPC+SPENETNPP+BNCNPPVV+BNCNPPVC+BNCNPPVP+BNCAABV+ANOCEP*MAJREV+BNCAABC+ANOVEP*MAJREV+BNCAABP+ANOPEP*MAJREV
                                                                                         -DEFBNCNPP3))))
             + PREM8_11 * positif(SPENETNPV+SPENETNPC+SPENETNPP+BNCNPPVV+BNCNPPVC+BNCNPPVP+BNCAABV+ANOCEP*MAJREV+BNCAABC+ANOVEP*MAJREV+BNCAABP+ANOPEP*MAJREV) *
                        (BNCNPDCT+DIDABNCNP+BNCAABV+ANOCEP*MAJREV+BNCAABC+ANOVEP*MAJREV+BNCAABP+ANOPEP*MAJREV-NOCEPIMPV-NOCEPIMPC-NOCEPIMPP
                        - min(BNCNPDCT,max(DEFBNCNP1731,DEFBNCNPP2)))+0;
