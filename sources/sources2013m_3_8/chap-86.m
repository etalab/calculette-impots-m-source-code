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
regle 8610 :
application : iliad , batch  ;
BNNSV = positif(BNHREV - (BNHDEV * (1 - positif(ART1731BIS))))
				   * arr((BNHREV-(BNHDEV * (1 - positif(ART1731BIS))))*MAJREV) 
				+ (1-positif_ou_nul(BNHREV-(BNHDEV * (1 - positif(ART1731BIS)))))
				   *(BNHREV-(BNHDEV * (1 - positif(ART1731BIS) )));

BNNSC = positif(BNHREC - (BNHDEC * (1 - positif(ART1731BIS))))
				   * arr((BNHREC-(BNHDEC * (1 - positif(ART1731BIS))))*MAJREV) 
				+ (1-positif_ou_nul(BNHREC-(BNHDEC * (1 - positif(ART1731BIS)))))
				   *(BNHREC-(BNHDEC * (1 - positif(ART1731BIS) )));

BNNSP = positif(BNHREP - (BNHDEP * (1 - positif(ART1731BIS) )))
				   * arr((BNHREP-(BNHDEP * (1 - positif(ART1731BIS))))*MAJREV) 
				+ (1-positif_ou_nul(BNHREP-(BNHDEP * (1 - positif(ART1731BIS)))))
				   *(BNHREP-(BNHDEP * (1 - positif(ART1731BIS) )));

BNNAV = (BNCREV - (BNCDEV * (1 - positif(ART1731BIS) ))) ;
BNNAC = (BNCREC - (BNCDEC * (1 - positif(ART1731BIS) ))) ;
BNNAP = (BNCREP - (BNCDEP * (1 - positif(ART1731BIS) ))) ;
BNNAAV = (BNCAABV - (min(BNCAADV,max(BNCAADV_P,BNCAADV1731+0)) * positif(ART1731BIS) + BNCAADV * (1 - ART1731BIS))) ;
BNNAAC = (BNCAABC - (min(BNCAADC,max(BNCAADV_P,BNCAADC1731+0)) * positif(ART1731BIS) + BNCAADC * (1 - ART1731BIS))) ;
BNNAAP = (BNCAABP - (min(BNCAADP,max(BNCAADV_P,BNCAADP1731+0)) * positif(ART1731BIS) + BNCAADP * (1 - ART1731BIS))) ;
regle 86101 :
application : iliad  ;
BNNSV1731R = positif(BNHREV - BNHDEV )
				   * arr((BNHREV-BNHDEV )*MAJREV) 
				+ (1-positif_ou_nul(BNHREV-BNHDEV ))
				   *(BNHREV-BNHDEV );

BNNSC1731R = positif(BNHREC - BNHDEC)
				   * arr((BNHREC-BNHDEC)*MAJREV) 
				+ (1-positif_ou_nul(BNHREC-BNHDEC ))
				   *(BNHREC-BNHDEC);

BNNSP1731R = positif(BNHREP - BNHDEP)
				   * arr((BNHREP-BNHDEP)*MAJREV) 
				+ (1-positif_ou_nul(BNHREP-BNHDEP))
				   *(BNHREP-BNHDEP);

BNNAV1731R = (BNCREV - BNCDEV) ;
BNNAC1731R = (BNCREC - BNCDEC) ;
BNNAP1731R = (BNCREP - BNCDEP) ;
BNNAAV1731R = (BNCAABV - BNCAADV) ;
BNNAAC1731R = (BNCAABC - BNCAADC) ;
BNNAAP1731R = (BNCAABP - BNCAADP) ;
regle 862:
application : iliad , batch  ;
VARDNOCEPV = min(DNOCEP,ANOCEP);
VARDNOCEPC = min(DNOCEPC,ANOVEP);
VARDNOCEPP = min(DNOCEPP,ANOPEP);
NOCEPV = ANOCEP - DNOCEP + (BNCAABV - BNCAADV); 

NOCEPC = ANOVEP - DNOCEPC + (BNCAABC - BNCAADC); 

NOCEPP = ANOPEP - DNOCEPP + (BNCAABP - BNCAADP); 

NOCEPIMPV = positif(ANOCEP - (min(DNOCEP,max(DNOCEP_P,DNOCEP1731+0)) * positif(ART1731BIS) + DNOCEP * (1 - ART1731BIS)))
		    *arr((ANOCEP-(min(DNOCEP,max(DNOCEP_P,DNOCEP1731+0)) * positif(ART1731BIS) + DNOCEP * (1 - ART1731BIS)))*MAJREV) 
	   + positif_ou_nul((min(DNOCEP,max(DNOCEP_P,DNOCEP1731+0)) * positif(ART1731BIS) + DNOCEP * (1 - ART1731BIS))-ANOCEP)
	           *(ANOCEP-(min(DNOCEP,max(DNOCEP_P,DNOCEP1731+0)) * positif(ART1731BIS) + DNOCEP * (1 - ART1731BIS)))+BNNAAV;

NOCEPIMPC = positif(ANOVEP - (min(DNOCEPC,max(DNOCEPC_P,DNOCEPC1731+0)) * positif(ART1731BIS) + DNOCEPC * (1 - ART1731BIS)))
			    *arr((ANOVEP-(min(DNOCEPC,max(DNOCEPC_P,DNOCEPC1731+0)) * positif(ART1731BIS) + DNOCEPC * (1 - ART1731BIS)))*MAJREV) 
	   + positif_ou_nul((min(DNOCEPC,max(DNOCEPC_P,DNOCEPC1731+0)) * positif(ART1731BIS) + DNOCEPC * (1 - ART1731BIS))-ANOVEP)
			    *(ANOVEP-(min(DNOCEPC,max(DNOCEPC_P,DNOCEPC1731+0)) * positif(ART1731BIS) + DNOCEPC * (1 - ART1731BIS)))+BNNAAC;

NOCEPIMPP = positif(ANOPEP - (min(DNOCEPP,max(DNOCEPP_P,DNOCEPP1731+0)) * positif(ART1731BIS) + DNOCEPP * (1 - ART1731BIS)))
				    *arr((ANOPEP-(min(DNOCEPP,max(DNOCEPP_P,DNOCEPP1731+0)) * positif(ART1731BIS) + DNOCEPP * (1 - ART1731BIS)))*MAJREV) 
	   + positif_ou_nul((min(DNOCEPP,max(DNOCEPP_P,DNOCEPP1731+0)) * positif(ART1731BIS) + DNOCEPP * (1 - ART1731BIS))-ANOPEP)
				    *(ANOPEP-(min(DNOCEPP,max(DNOCEPP_P,DNOCEPP1731+0)) * positif(ART1731BIS) + DNOCEPP * (1 - ART1731BIS)))+BNNAAP;

NOCEPIMP = NOCEPIMPV+NOCEPIMPC+NOCEPIMPP;

TOTDABNCNP = null(4-V_IND_TRAIT) * (DABNCNP6 + DABNCNP5 + DABNCNP4 + DABNCNP3 + DABNCNP2 + DABNCNP1) * (1-ART1731BIS)
	   + null(5-V_IND_TRAIT) * max(0,min(DABNCNP6 + DABNCNP5 + DABNCNP4 + DABNCNP3 + DABNCNP2 + DABNCNP1,TOTDABNCNP1731*ART1731BIS+
				      (DABNCNP6 + DABNCNP5 + DABNCNP4 + DABNCNP3 + DABNCNP2 + DABNCNP1) * (1-ART1731BIS))); 
BNN = somme(i=V,C,P:BNRi) + SPENETPF + max(0,SPENETNPF + NOCEPIMP - TOTDABNCNP);
regle 86201:
application : iliad  ;
NOCEPV1731R = ANOCEP - DNOCEP + (BNCAABV - BNCAADV); 

NOCEPC1731R = ANOVEP - DNOCEPC + (BNCAABC - BNCAADC); 

NOCEPP1731R = ANOPEP - DNOCEPP + (BNCAABP - BNCAADP); 

NOCEPIMPV1731R = positif(ANOCEP - DNOCEP)
		    *arr((ANOCEP- DNOCEP)*MAJREV) 
	   + positif_ou_nul(DNOCEP-ANOCEP)
	           *(ANOCEP- DNOCEP)+BNNAAV;

NOCEPIMPC1731R = positif(ANOVEP - DNOCEPC)
			    *arr((ANOVEP- DNOCEPC)*MAJREV) 
	   + positif_ou_nul(DNOCEPC-ANOVEP)
			    *(ANOVEP- DNOCEPC)+BNNAAC;

NOCEPIMPP1731R = positif(ANOPEP - DNOCEPP)
				    *arr((ANOPEP- DNOCEPP)*MAJREV) 
	   + positif_ou_nul(DNOCEPP-ANOPEP)
				    *(ANOPEP- DNOCEPP)+BNNAAP;

NOCEPIMP1731R = NOCEPIMPV1731R+NOCEPIMPC1731R+NOCEPIMPP1731R;

TOTDABNCNP1731R = null(4-V_IND_TRAIT) * (DABNCNP6 + DABNCNP5 + DABNCNP4 + DABNCNP3 + DABNCNP2 + DABNCNP1)
	   + null(5-V_IND_TRAIT) * max(0,min(DABNCNP6 + DABNCNP5 + DABNCNP4 + DABNCNP3 + DABNCNP2 + DABNCNP1,TOTDABNCNP1731*ART1731BIS+
				      (DABNCNP6 + DABNCNP5 + DABNCNP4 + DABNCNP3 + DABNCNP2 + DABNCNP1) * (1-ART1731BIS))); 
BNN1731R = somme(i=V,C,P:BNRi) + SPENETPF + max(0,SPENETNPF + NOCEPIMP - TOTDABNCNP);
regle 8621:
application : iliad , batch  ;
pour i = V,C,P:
BNNi =  BNRi + SPENETi;
regle 862101:
application : iliad ;
pour i = V,C,P:
BNNi1731R =  BNRi1731R + SPENETi1731R;
regle 86211:
application : iliad , batch  ;
pour i = V,C,P:
BNRi = BNNSi + BNNAi;
BNRTOT = BNRV + BNRC + BNRP;
regle 862111:
application : iliad  ;
pour i = V,C,P:
BNRi1731R = BNNSi1731R + BNNAi1731R;
BNRTOT1731R = BNRV1731R + BNRC1731R + BNRP1731R;
regle 863:
application : iliad , batch  ;
BN1 = somme(i=V,C,P:BN1i);
regle 8631:
application : iliad , batch  ;
pour i = V,C,P:
BN1i = BN1Ai + PVINiE + INVENTi;
regle 864:                                                                    
application : iliad , batch  ;                          
pour i = V,C,P:                                                                 
SPETOTi = BNCPROi + BNCNPi;
regle 8641:
application : iliad , batch  ;                          
pour i = V,C,P:                                                                 
SPEBASABi=SPETOTi;
pour i = V,C,P:                                                                 
SPEABi = arr((max(MIN_SPEBNC,(SPEBASABi * SPETXAB/100))) * 
                       positif_ou_nul(SPETOTi - MIN_SPEBNC)) +
          arr((min(MIN_SPEBNC,SPEBASABi )) * 
                       positif(MIN_SPEBNC - SPETOTi)); 
regle 86411:
application : iliad , batch  ;                          
pour i = V,C,P:                                                                 
SPEABPi = arr((SPEABi * BNCPROi)/SPETOTi);                                  
pour i = V,C,P:                                                                 
SPEABNPi = SPEABi - SPEABPi;                                  
regle 8642:
application : iliad , batch  ;                          
pour i = V,C,P:                                                                 
SPENETPi = max (0,(BNCPROi - SPEABPi));                                    
pour i = V,C,P:                                                                 
SPENETNPi = max (0,(BNCNPi - SPEABNPi));
pour i = V,C,P:                                                                 
SPENETi = SPENETPi + SPENETNPi;
SPENET = somme(i=V,C,P:(SPENETi));
regle 8650:
application : iliad , batch  ;                          
SPENETCT = BNCPROPVV + BNCPROPVC + BNCPROPVP - BNCPMVCTV - BNCPMVCTC - BNCPMVCTP  ;
SPENETNPCT = BNCNPPVV + BNCNPPVC + BNCNPPVP - BNCNPDCT;
regle 8660:
application : iliad , batch  ;                          
SPENETPF = somme(i=V,C,P:SPENETPi) + SPENETCT;
SPENETNPF = somme(i=V,C,P:SPENETNPi) + SPENETNPCT;                                    
BNCNPTOT = SPENETPF + SPENETNPF;
regle 8680:
application : iliad , batch  ;                          
pour i = V,C,P:                                                                 
SPEPVPi = BNCPRO1Ai - BNCPRODEi;
pour i = V,C,P:                                                                 
SPEPVNPi = BNCNP1Ai - BNCNPDEi;
SPEPV = somme(i=V,C,P:max(0,SPEPVPi + SPEPVNPi));

regle 8690:
application :  iliad , batch  ;                          

DCTSPE = positif_ou_nul(BNRTOT+SPENETPF) * BNCPMVCTV
        + ( 1 - positif_ou_nul(BNRTOT+SPENETPF)) * (BNCPMVCTV-abs(BNRTOT+SPENETPF))
        + ( 1 - positif_ou_nul(BNRTOT+SPENETPF)) * null(BNCPMVCTV-abs(BNRTOT+SPENETPF))* BNCPMVCTV
	;
DCTSPENP = positif_ou_nul(NOCEPIMP+SPENETNPF) * BNCNPDCT
        + ( 1 - positif_ou_nul(NOCEPIMP+SPENETNPF)) * (BNCNPDCT-abs(NOCEPIMP+SPENETNPF))
        + ( 1 - positif_ou_nul(NOCEPIMP+SPENETNPF)) * null(BNCNPDCT-abs(NOCEPIMP+SPENETNPF)) * BNCNPDCT
	;
regle 8691:
application : iliad , batch  ;

BNCDF6 = ((1 - positif_ou_nul(NOCEPIMP+SPENETNPF)) * (DABNCNP5)
                 + positif_ou_nul(NOCEPIMP+SPENETNPF)
                 * min(max(NOCEPIMP+SPENETNPF-DABNCNP6,0)-DABNCNP5,DABNCNP5)*(-1)
                 * positif_ou_nul(DABNCNP5-max(NOCEPIMP+SPENETNPF-DABNCNP6,0)))
		 * (1-positif(ART1731BIS))
                 + (min(DABNCNP5,BNCDF61731) *positif_ou_nul(BNCDF61731) + DABNCNP5 * (1-positif_ou_nul(BNCDF61731))) * positif(ART1731BIS)
                          ;

BNCDF5 = ((1 - positif_ou_nul(NOCEPIMP+SPENETNPF)) * (DABNCNP4)
                 + positif_ou_nul(NOCEPIMP+SPENETNPF)
                 * min(max(NOCEPIMP+SPENETNPF-DABNCNP6-DABNCNP5,0)-DABNCNP4,DABNCNP4)*(-1)
                 * positif_ou_nul(DABNCNP4-max(NOCEPIMP+SPENETNPF-DABNCNP6-DABNCNP5,0)))
		 * (1-positif(ART1731BIS)) 
                 + (min(DABNCNP4,BNCDF51731)  *positif_ou_nul(BNCDF51731) + DABNCNP4 * (1-positif_ou_nul(BNCDF51731)))* positif(ART1731BIS)
                          ;

BNCDF4 = ((1 - positif_ou_nul(NOCEPIMP+SPENETNPF)) * (DABNCNP3)
                 + positif_ou_nul(NOCEPIMP+SPENETNPF)
                 * min(max(NOCEPIMP+SPENETNPF-DABNCNP6-DABNCNP5-DABNCNP4,0)-DABNCNP3,DABNCNP3)*(-1)
                 * positif_ou_nul(DABNCNP3-max(NOCEPIMP+SPENETNPF-DABNCNP6-DABNCNP5-DABNCNP4,0)))
		 * (1-positif(ART1731BIS))
                 + (min(DABNCNP3,BNCDF41731) *positif_ou_nul(BNCDF41731) + DABNCNP3 * (1-positif_ou_nul(BNCDF41731))) * positif(ART1731BIS)
                          ;

BNCDF3 = ((1 - positif_ou_nul(NOCEPIMP+SPENETNPF)) * (DABNCNP2)
                 + positif_ou_nul(NOCEPIMP+SPENETNPF)
                 * min(max(NOCEPIMP+SPENETNPF-DABNCNP6-DABNCNP5-DABNCNP4-DABNCNP3,0)-DABNCNP2,DABNCNP2)*(-1)
                 * positif_ou_nul(DABNCNP2-max(NOCEPIMP+SPENETNPF-DABNCNP6-DABNCNP5-DABNCNP4-DABNCNP3,0)))
		 * (1-positif(ART1731BIS))
                 + (min(DABNCNP2,BNCDF31731) *positif_ou_nul(BNCDF31731) + DABNCNP2 * (1-positif_ou_nul(BNCDF31731))) * positif(ART1731BIS)
                          ;
BNCDF2 = ((1-positif_ou_nul(NOCEPIMP+SPENETNPF)) * (DABNCNP1)
                + positif_ou_nul(NOCEPIMP+SPENETNPF)
                * min(max(NOCEPIMP+SPENETNPF-DABNCNP6-DABNCNP5-DABNCNP4-DABNCNP3-DABNCNP2,0)-DABNCNP1,DABNCNP1)*(-1)
                * positif_ou_nul(DABNCNP1-max(NOCEPIMP+SPENETNPF-DABNCNP6-DABNCNP5-DABNCNP4-DABNCNP3-DABNCNP2,0)))
		 * (1-positif(ART1731BIS))
                 + (min(DABNCNP1,BNCDF21731) *positif_ou_nul(BNCDF21731) + DABNCNP1 * (1-positif_ou_nul(BNCDF21731))) * positif(ART1731BIS)
                          ;

BNCDF1 = (((1-positif_ou_nul(NOCEPIMP+SPENETNPF)) * abs(NOCEPIMP+SPENETNPF)
                + positif_ou_nul(NOCEPIMP+SPENETNPF)
                * positif_ou_nul(DABNCNP5+DABNCNP4+DABNCNP3+DABNCNP2+DABNCNP1-NOCEPIMP-SPENETNPF)
                * (DABNCNP5+DABNCNP4+DABNCNP3+DABNCNP2+DABNCNP1-NOCEPIMP-SPENETNPF)
                * null(BNCDF6+BNCDF5+BNCDF4+BNCDF3+BNCDF2))
		* (1-positif(ART1731BIS))
                + ((
                  DNOCEP-min(DNOCEP,max(DNOCEP_P,DNOCEP1731+0)) 
                  +DNOCEPC-min(DNOCEPC,max(DNOCEPC_P,DNOCEPC1731+0)) 
                  +DNOCEPP-min(DNOCEPP,max(DNOCEPP_P,DNOCEPP1731+0)) 
                  +BNCAADV-min(BNCAADV,max(BNCAADV_P,BNCAADV1731+0)) 
                  +BNCAADC-min(BNCAADC,max(BNCAADC_P,BNCAADC1731+0)) 
                  +BNCAADP-min(BNCAADP,max(BNCAADP_P,BNCAADP1731+0)) 
                  ) *positif_ou_nul(BNCDF11731)
                  +(DNOCEP +DNOCEPC +DNOCEPP +BNCAADV +BNCAADC +BNCAADP) * (1-positif_ou_nul(BNCDF11731))
                  )* positif(ART1731BIS))
                          ;
regle 8692:
application : iliad , batch  ;                          
DABNCNP = DABNCNP1 + DABNCNP2 + DABNCNP3 + DABNCNP4 + DABNCNP5 + DABNCNP6;
VAREDABNCNP = min(DABNCNP,SPENETNPF + NOCEPIMP);
