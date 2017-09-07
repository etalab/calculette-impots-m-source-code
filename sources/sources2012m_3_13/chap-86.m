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

regle 8610 :
application : iliad , batch  ;
BNNSV = positif(BNHREV - BNHDEV)* arr((BNHREV-BNHDEV)*MAJREV) + (1-positif_ou_nul(BNHREV-BNHDEV))*(BNHREV-BNHDEV);

BNNSC = positif(BNHREC - BNHDEC)* arr((BNHREC-BNHDEC)*MAJREV) + (1-positif_ou_nul(BNHREC-BNHDEC))*(BNHREC-BNHDEC);

BNNSP = positif(BNHREP - BNHDEP)* arr((BNHREP-BNHDEP)*MAJREV) + (1-positif_ou_nul(BNHREP-BNHDEP))*(BNHREP-BNHDEP);

BNNAV = (BNCREV - BNCDEV) ;
BNNAC = (BNCREC - BNCDEC) ;
BNNAP = (BNCREP - BNCDEP) ;
BNNAAV = (BNCAABV - BNCAADV) ;
BNNAAC = (BNCAABC - BNCAADC) ;
BNNAAP = (BNCAABP - BNCAADP) ;
regle 862:
application : iliad , batch  ;

NOCEPV = ANOCEP - DNOCEP + BNNAAV; 

NOCEPC = ANOVEP - DNOCEPC + BNNAAC; 

NOCEPP = ANOPEP - DNOCEPP + BNNAAP; 

NOCEPIMPV = positif(ANOCEP - DNOCEP)*arr((ANOCEP-DNOCEP)*MAJREV) 
	   + positif_ou_nul(DNOCEP-ANOCEP)*(ANOCEP-DNOCEP)+BNNAAV;

NOCEPIMPC = positif(ANOVEP - DNOCEPC)*arr((ANOVEP-DNOCEPC)*MAJREV) 
	   + positif_ou_nul(DNOCEPC-ANOVEP)*(ANOVEP-DNOCEPC)+BNNAAC;

NOCEPIMPP = positif(ANOPEP - DNOCEPP)*arr((ANOPEP-DNOCEPP)*MAJREV) 
	   + positif_ou_nul(DNOCEPP-ANOPEP)*(ANOPEP-DNOCEPP)+BNNAAP;

NOCEPIMP = NOCEPIMPV+NOCEPIMPC+NOCEPIMPP;

BNN = somme(i=V,C,P:BNRi) + SPENETPF + max(0,SPENETNPF + NOCEPIMP-DABNCNP6-DABNCNP5-DABNCNP4-DABNCNP3-DABNCNP2-DABNCNP1) ;
regle 8621:
application : iliad , batch  ;
pour i = V,C,P:
BNNi =  BNRi + SPENETi;
regle 86211:
application : iliad , batch  ;
pour i = V,C,P:
BNRi = BNNSi + BNNAi;
BNRTOT = BNRV + BNRC + BNRP;
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

BNCDF6 = (1 - positif_ou_nul(NOCEPIMP+SPENETNPF)) * (DABNCNP5)
          + positif_ou_nul(NOCEPIMP+SPENETNPF) 
	    * min(max(NOCEPIMP+SPENETNPF-DABNCNP6,0)-DABNCNP5,DABNCNP5)*(-1)
            * positif_ou_nul(DABNCNP5-max(NOCEPIMP+SPENETNPF-DABNCNP6,0));

BNCDF5 = (1 - positif_ou_nul(NOCEPIMP+SPENETNPF)) * (DABNCNP4)
          + positif_ou_nul(NOCEPIMP+SPENETNPF) 
	    * min(max(NOCEPIMP+SPENETNPF-DABNCNP6-DABNCNP5,0)-DABNCNP4,DABNCNP4)*(-1)
            * positif_ou_nul(DABNCNP4-max(NOCEPIMP+SPENETNPF-DABNCNP6-DABNCNP5,0));

BNCDF4 = (1 - positif_ou_nul(NOCEPIMP+SPENETNPF)) * (DABNCNP3)
          + positif_ou_nul(NOCEPIMP+SPENETNPF) 
	    * min(max(NOCEPIMP+SPENETNPF-DABNCNP6-DABNCNP5-DABNCNP4,0)-DABNCNP3,DABNCNP3)*(-1)
            * positif_ou_nul(DABNCNP3-max(NOCEPIMP+SPENETNPF-DABNCNP6-DABNCNP5-DABNCNP4,0));

BNCDF3 = (1 - positif_ou_nul(NOCEPIMP+SPENETNPF)) * (DABNCNP2)
          + positif_ou_nul(NOCEPIMP+SPENETNPF)  
            * min(max(NOCEPIMP+SPENETNPF-DABNCNP6-DABNCNP5-DABNCNP4-DABNCNP3,0)-DABNCNP2,DABNCNP2)*(-1)
            * positif_ou_nul(DABNCNP2-max(NOCEPIMP+SPENETNPF-DABNCNP6-DABNCNP5-DABNCNP4-DABNCNP3,0));

BNCDF2 = (1-positif_ou_nul(NOCEPIMP+SPENETNPF)) * (DABNCNP1)
          + positif_ou_nul(NOCEPIMP+SPENETNPF)  
            * min(max(NOCEPIMP+SPENETNPF-DABNCNP6-DABNCNP5-DABNCNP4-DABNCNP3-DABNCNP2,0)-DABNCNP1,DABNCNP1)*(-1)
            * positif_ou_nul(DABNCNP1-max(NOCEPIMP+SPENETNPF-DABNCNP6-DABNCNP5-DABNCNP4-DABNCNP3-DABNCNP2,0));

BNCDF1 = (1-positif_ou_nul(NOCEPIMP+SPENETNPF)) * abs(NOCEPIMP+SPENETNPF)
          + positif_ou_nul(NOCEPIMP+SPENETNPF)  
            * positif_ou_nul(DABNCNP5+DABNCNP4+DABNCNP3+DABNCNP2+DABNCNP1-NOCEPIMP-SPENETNPF)
            * (DABNCNP5+DABNCNP4+DABNCNP3+DABNCNP2+DABNCNP1-NOCEPIMP-SPENETNPF)
	    * null(BNCDF6+BNCDF5+BNCDF4+BNCDF3+BNCDF2) ;

regle 8692:
application : iliad , batch  ;                          
DABNCNP = DABNCNP1 + DABNCNP2 + DABNCNP3 + DABNCNP4 + DABNCNP5 + DABNCNP6;
