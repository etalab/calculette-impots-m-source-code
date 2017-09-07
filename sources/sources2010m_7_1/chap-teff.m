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
regle 99991000:
application : pro ,  oceans , iliad , batch ;

pour i = V,C,P:
TMIB_TVENi = MIBVENi + AUTOBICVi + MIBNPVENi ;

pour i = V,C,P:
TMIB_TPRESi = MIBPRESi + AUTOBICPi + MIBNPPRESi ;

pour i = V,C,P:
TMIB_TTi = TMIB_TVENi + TMIB_TPRESi;
regle 99991004:
application : pro ,  oceans , iliad , batch ;


pour i = V,C,P:
TMIB_AVi = min ( TMIB_TVENi,
                         (max(MIN_MBIC,
                              arr( TMIB_TVENi*TX_MIBVEN/100))
                         )
              );
pour i = V,C,P:
TMIB_VENTAi = min ( (MIBVENi + MIBNPVENi),
                         (max(MIN_MBIC,
                              arr( (MIBVENi + MIBNPVENi)*TX_MIBVEN/100))
                         )
              );
pour i = V,C,P:
TMIB_AUTOAVi= TMIB_AVi - TMIB_VENTAi; 

pour i = V,C,P:
TPMIB_AVi = min ( (MIBVENi + AUTOBICVi),
                         (max(MIN_MBIC,
                              arr( (MIBVENi+ AUTOBICVi)*TX_MIBVEN/100))
                         )
              );


pour i = V,C,P:
TMIB_APi = min ( TMIB_TPRESi,
                         (max(MIN_MBIC,
                              arr( TMIB_TPRESi*TX_MIBPRES/100))
                         )
               );
pour i = V,C,P:
TMIB_PRESAi = min ( (MIBPRESi + MIBNPPRESi),
                         (max(MIN_MBIC,
                              arr( (MIBPRESi + MIBNPPRESi)*TX_MIBPRES/100))
                         )
               );
pour i = V,C,P:
TMIB_AUTOAPi= TMIB_APi - TMIB_PRESAi; 
pour i = V,C,P:
TPMIB_APi = min ( (MIBPRESi+ AUTOBICPi),
                         (max(MIN_MBIC,
                              arr( (MIBPRESi+ AUTOBICPi)*TX_MIBPRES/100))
                         )
               );



regle 99991005:
application : pro ,  oceans , iliad , batch ;

pour i = V,C,P:
TMIB_ABVi = max(0,arr(TMIB_AVi * (MIBVENi + AUTOBICVi)/ TMIB_TVENi));
pour i = V,C,P:
TMIB_ABNPVi = TMIB_AVi - TMIB_ABVi;

pour i = V,C,P:
TMIB_ABPi = max(0,arr(TMIB_APi * (MIBPRESi + AUTOBICPi)/ TMIB_TPRESi));
pour i = V,C,P:
TMIB_ABNPPi = TMIB_APi - TMIB_ABPi;


regle 99991006:
application : pro ,  oceans , iliad , batch ;
pour i = V,C,P:
TPMIB_NETVi = MIBVENi + AUTOBICVi - TPMIB_AVi;
pour i = V,C,P:
TPMIB_NETPi = MIBPRESi + AUTOBICPi - TPMIB_APi;

pour i = V,C,P:
TMIB_NETVi = MIBVENi + AUTOBICVi - TMIB_ABVi;
TMIBNETVF = somme(i=V,C,P:TMIB_NETVi) ;
pour i = V,C,P:
TMIB_NETNPVi = MIBNPVENi - TMIB_ABNPVi;
TMIBNETNPVF = somme(i=V,C,P:TMIB_NETNPVi);

pour i = V,C,P:
TMIB_NETPi = MIBPRESi + AUTOBICPi - TMIB_ABPi;
TMIBNETPF = somme(i=V,C,P:TMIB_NETPi) ;
pour i = V,C,P:
TMIB_NETNPPi = MIBNPPRESi - TMIB_ABNPPi;
TMIBNETNPPF = somme(i=V,C,P:TMIB_NETNPPi);

TBICPABV =   arr((TMIB_ABVV * AUTOBICVV/(MIBVENV+AUTOBICVV))
          + (TMIB_ABPV * AUTOBICPV/(MIBPRESV+AUTOBICPV)));

TBICPROVC = max(0,arr((TMIB_ABVC * AUTOBICVC/(MIBVENC+AUTOBICVC)) + (TMIB_ABPC * AUTOBICPC/(MIBPRESC+AUTOBICPC))));

TBICPABC =  min(TBICPROVC,arr((TMIB_ABVC * AUTOBICVC/(MIBVENC+AUTOBICVC))
          + (TMIB_ABPC * AUTOBICPC/(MIBPRESC+AUTOBICPC))));

TBICPROVP = max(0,arr((TMIB_ABVP * AUTOBICVP/(MIBVENP+AUTOBICVP)) + (TMIB_ABPP * AUTOBICPP/(MIBPRESP+AUTOBICPP))));

TBICPABP =  min(TBICPROVP,arr((TMIB_ABVP * AUTOBICVP/(MIBVENP+AUTOBICVP))
          + (TMIB_ABPP* AUTOBICPP/(MIBPRESP+AUTOBICPP))));

TBICNPABV = arr((TMIB_ABNPVV /(MIBNPVENV))
          + (TMIB_ABNPPV /(MIBNPPRESV)));
TBICNPPROVC = max(0,arr((TMIB_ABNPVC /(MIBNPVENC)) + (TMIB_ABNPPC /(MIBNPPRESC))));
TBICNPABC = min(TBICNPPROVC,arr((TMIB_ABNPVC /(MIBNPVENC))
          + (TMIB_ABNPPC /(MIBNPPRESC))));
TBICNPPROVP = max(0,arr((TMIB_ABNPVP /(MIBNPVENP)) + (TMIB_ABNPPP /(MIBNPPRESP))));
TBICNPABP = min(TBICNPPROVP,arr((TMIB_ABNPVP /(MIBNPVENP))
          + (TMIB_ABNPPP /(MIBNPPRESP))));
ABICPDECV = AUTOBICVV + AUTOBICPV;
ABICPDECC = AUTOBICVC + AUTOBICPC;
ABICPDECP = AUTOBICVP + AUTOBICPP;
ABICPNETV =  AUTOBICVV + AUTOBICPV - TMIB_AUTOAVV - TMIB_AUTOAPV;
ABICPNETC =  AUTOBICVC + AUTOBICPC - TMIB_AUTOAVC -TMIB_AUTOAPC;
ABICPNETP =  AUTOBICVP + AUTOBICPP - TMIB_AUTOAVP -TMIB_AUTOAPP;



AUTOBICPNET = ABICPNETV + ABICPNETC + ABICPNETP;
regle 99991009:                                                                    
application : pro , oceans , iliad , batch  ;                          
pour i = V,C,P:                                                                 
TSPETOTi = BNCPROi + AUTOBNCi + BNCNPi ;
regle 99991010:
application : pro , oceans , iliad , batch  ;                          
pour i = V,C,P:                                                                 
TSPEBASABi=TSPETOTi;
pour i = V,C,P:                                                                 
TSPEABi = arr((max(MIN_SPEBNC,(TSPEBASABi * SPETXAB/100))) * 
                       positif_ou_nul(TSPETOTi - MIN_SPEBNC)) +
          arr((min(MIN_SPEBNC,TSPEBASABi )) * 
                       positif(MIN_SPEBNC - TSPETOTi)); 
regle 99991011:
application : pro , oceans , iliad , batch  ;                          
pour i = V,C,P:                                                                 
TSPEABPi = arr((TSPEABi * (BNCPROi + AUTOBNCi))/TSPETOTi);                                  
pour i = V,C,P:                                                                 
TBNCPABi = arr(TSPEABPi * AUTOBNCi/(BNCPROi+AUTOBNCi)); 
pour i = V,C,P:                                                                 
TBNCTOTABi = arr(TSPEABi * (AUTOBNCi)/(TSPETOTi)); 

pour i = V,C,P:                                                                 
TSPEABNPi = TSPEABi - TSPEABPi;                                  
pour i = V,C,P:                                                                 
TBNCNPABi = (TBNCTOTABi - TBNCPABi) ;

pour i = V,C,P:                                                                 
ABNCPDECi =  AUTOBNCi; 
pour i = V,C,P:                                                                 
ABNCPNETi =  AUTOBNCi - TBNCPABi; 
pour i = V,C,P:                                                                 
HONODECi = XHONOi + XHONOAAi;
pour i = V,C,P:                                                                 
HONONETi = arr(XHONOi * MAJREV) + XHONOAAi ;
AUTOBNCPNET = ABNCPNETV + ABNCPNETC + ABNCPNETP;
HONONET = HONONETV + HONONETC + HONONETP;
regle 99991012:
application : pro , oceans , iliad , batch  ;                          
pour i = V,C,P:                                                                 
TSPENETPi = max (0,(BNCPROi  + AUTOBNCi - TSPEABPi));
pour i = V,C,P:                                                                 
TSPENETNPi = max (0,(BNCNPi - TSPEABNPi));
pour i = V,C,P:                                                                 
TSPENETi = TSPENETPi + TSPENETNPi;
TSPENET = somme(i=V,C,P:(TSPENETi));
regle 99991020:
application : pro , oceans , iliad , batch  ;                          
pour i = V,C,P:                                                                 
TXSPEAAi = BNCREi + XHONOAAi - BNCDEi;
regle 99991022:
application : pro , oceans , iliad , batch  ;                          
pour i = V,C,P:                                                                 
TXSPEHi = max(0,arr((BNHREi + XHONOi - BNHDEi)*MAJREV))
	 + min(0,(BNHREi + XHONOi - BNHDEi));
regle 99991024:
application : pro , oceans , iliad , batch  ;                          
pour i = V,C,P:                                                                 
TXSPENETi = TXSPEAAi + TXSPEHi;
regle 99991026:
application : pro , oceans , iliad , batch  ;                          
TXSPENET = somme(i=V,C,P:(TXSPENETi));
regle 99991030:
application : pro , oceans , iliad , batch  ;                          
TEFFBENEFTOT =  TSPENET + TXSPENET + TMIBNETVF + TMIBNETNPVF + TMIBNETPF + TMIBNETNPPF * (1 - positif(IPTEFP + IPTEFN + IPMOND));
regle 99991040:
application : pro , oceans , iliad , batch  ;
TBICPF = TMIBNETVF + TMIBNETPF + MIB_NETCT  ;
TBICNPF =max(0,somme(i=V,C,P:BINTAi+BINHTAi)+TMIBNETNPVF + TMIBNETNPPF +MIB_NETNPCT - DEFNP);
TBNN =  somme(i=V,C,P:TSPENETPi) + TXSPENET + max(0,somme(i=V,C,P:TSPENETNPi) 
				 + NOCEPIMP-DABNCNP6-DABNCNP5-DABNCNP4-DABNCNP3-DABNCNP2-DABNCNP1) + SPENETCT + SPENETNPCT ;
regle 99991055:
application : pro , oceans , iliad , batch  ;                          
TEFFREVTOT =    INDTEFF *
                (
		(TBICPF + TBICNPF + TBNN 
		+ BIHTAV + BIHTAC + BIHTAP
		+ BIPTAV + BIPTAC + BIPTAP + RFROBOR * V_INDTEO
	        + ESFP + TSPR + RCM + RRFI +PLOCNETF + NPLOCNETF
		+ max(BANOR,0) + REB +
		 min(BANOR,0) *
                 positif(SEUIL_IMPDEFBA + 1 
		 - (REVTP-BA1)
                 - REVQTOT))
		+ R1649 - DAR - DPA - DFA - DEDIV - APERPV - APERPC - APERPP - NUREPAR - ABTPA - ABTMA-DDCSG
		)
		;
