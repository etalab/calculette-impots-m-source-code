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
                                                                       
  ####   #    #    ##    #####      #     #####  #####   ######         
 #    #  #    #   #  #   #    #     #       #    #    #  #          
 #       ######  #    #  #    #     #       #    #    #  #####      
 #       #    #  ######  #####      #       #    #####   #             
 #    #  #    #  #    #  #          #       #    #   #   #              
  ####   #    #  #    #  #          #       #    #    #  ######  
regle 31000:
application : iliad , batch  ;
PERP_BOOL = positif(null(1-(V_0CF+V_0CH+V_0CR+V_0DJ+V_0DN+V_0DP)) *
          null(
   present( TSHALLO2 ) 
 + present( ALLO2 ) 
 + present( TSHALLO3 ) 
 + present( ALLO3 ) 
 + present( TSHALLO4 ) 
 + present( ALLO4 ) 
 + present( FRN2 ) 
 + present( FRN3 ) 
 + present(FRN4)
 + present(CARTSP2)
 + present(CARTSP3)
 + present(CARTSP4)
 + present(REMPLAP2)
 + present(REMPLAP3)
 + present(REMPLAP4)
 )); 
regle 31002:
application : iliad , batch  ;
PERPSALV = 
  TSHALLOV  
 + ALLOV  
 + GLD1V  
 + GLD2V  
 + GLD3V  
 + GLDGRATV
 + BPCOSAV  
 + TSASSUV  
 + CARTSV  
 + REMPLAV
 + CODDAJ
 + CODEAJ
 + SALEXTV
 ;
PERPSALC = 
   TSHALLOC  
 + ALLOC  
 + GLD1C  
 + GLD2C  
 + GLD3C  
 + GLDGRATC
 + BPCOSAC  
 + TSASSUC  
 + CARTSC  
 + REMPLAC
 + CODDBJ
 + CODEBJ
 + SALEXTC
 ;
PERPSALP = PERP_BOOL * (
   TSHALLO1  
 + ALLO1  
 + CARTSP1
 + REMPLAP1
 + SALEXT1
 )
 ;
regle 31003:
application : iliad , batch  ;
PERPSALDV = PREP10V;
PERPSALDC = PREP10C;
PERPSALDP = PREP10P * PERP_BOOL;
regle 31004:
application : iliad , batch  ;
PERPSALNV = PERPSALV - PERPSALDV + ELURASV;
PERPSALNC = PERPSALC - PERPSALDC + ELURASC;
PERPSALNP = PERPSALP -PERPSALDP ;
regle 31005:
application : iliad , batch  ;
PERPBANV = 
   FEXV  
 + BAFV  
 + BAFPVV  
 + BAEXV  
 + BACREV  
 - BACDEV
 + BAHEXV 
 + BAHREV  
 - BAHDEV
 + BAPERPV
 + 4BACREV  
 + 4BAHREV 
 + BAFORESTV
 + BANOCGAV
 + COD5XT
 + COD5XV

 ;
PERPBANC = 
   FEXC  
 + BAFC  
 + BAFPVC  
 + BAEXC  
 + BACREC  
 - BACDEC
 + BAHEXC  
 + BAHREC  
 - BAHDEC
 + BAPERPC 
 + 4BACREC  
 + 4BAHREC 
 + BAFORESTC
 + BANOCGAC
 + COD5XU
 + COD5XW
 ;
PERPBANP = PERP_BOOL * (
   FEXP  
 + BAFP  
 + BAFPVP  
 + BAEXP  
 + BACREP  
 - BACDEP
 + BAHEXP  
 + BAHREP  
 - BAHDEP
 + BAPERPP
 + 4BACREP  
 + 4BAHREP ) 
 + BAFORESTP
 + BANOCGAP
 ;
regle 31006:
application :  iliad , batch  ;
PERPBICMNV =TPMIB_NETPV+TPMIB_NETVV+MIBEXV+MIBPVV-BICPMVCTV;
PERPBICMNC =TPMIB_NETPC+TPMIB_NETVC+MIBEXC+MIBPVC-BICPMVCTC;
PERPBICMNP =(TPMIB_NETPP+TPMIB_NETVP+MIBEXP+MIBPVP-BICPMVCTP) * PERP_BOOL;
regle 31007:
application : iliad , batch  ;
PERPBICPNV =
   BICEXV  
 + BICNOV  
 - BICDNV
 + BIHEXV  
 + BIHNOV  
 - BIHDNV
 + BIPERPV 
 + LOCPROCGAV
 - LOCDEFPROCGAV
 + LOCPROV
 - LOCDEFPROV
 ;
PERPBICPNC =
   BICEXC  
 + BICNOC  
 - BICDNC
 + BIHEXC  
 + BIHNOC  
 - BIHDNC
 + BIPERPC  
 + LOCPROCGAC
 - LOCDEFPROCGAC
 + LOCPROC
 - LOCDEFPROC
;
PERPBICPNP = PERP_BOOL * (
   BICEXP  
 + BICNOP  
 - BICDNP
 + BIHEXP  
 + BIHNOP  
 - BIHDNP
 + BIPERPP 
 + LOCPROCGAP
 - LOCDEFPROCGAP
 + LOCPROP
 - LOCDEFPROP);
regle 31008:
application : iliad , batch  ;
PERPBNCMNV =  BNCPROEXV + max(0,(BNCPROV+AUTOBNCV) - max(arr((BNCPROV+AUTOBNCV) * SPETXAB/100),MIN_SPEBNC))
                     + BNCPROPVV-BNCPMVCTV;
PERPBNCMNC =  BNCPROEXC + max(0,(BNCPROC+AUTOBNCC) - max(arr((BNCPROC+AUTOBNCC) * SPETXAB/100),MIN_SPEBNC))
                     + BNCPROPVC-BNCPMVCTC;
PERPBNCMNP =  PERP_BOOL * (
              BNCPROEXP + max(0,(BNCPROP+AUTOBNCP) - max(arr((BNCPROP+AUTOBNCP) * SPETXAB/100),MIN_SPEBNC))
                     + BNCPROPVP-BNCPMVCTP);
regle 31009:
application :  iliad , batch  ;
PERPBNCPNV =  
   BNCEXV  
 + BNCREV  
 - BNCDEV
 + BNHEXV  
 + BNHREV  
 - BNHDEV
 + BNCCRV
 ;
PERPBNCPNC =  
   BNCEXC  
 + BNCREC  
 - BNCDEC
 + BNHEXC  
 + BNHREC  
 - BNHDEC
 + BNCCRC
 ;
PERPBNCPNP =  PERP_BOOL * (
   BNCEXP  
 + BNCREP  
 - BNCDEP
 + BNHEXP  
 + BNHREP  
 - BNHDEP
 + BNCCRP
 ); 
regle 31010:
application :  iliad , batch  ;
PERPNONSALV = PERPBANV + PERPBICMNV + PERPBICPNV + PERPBNCMNV + PERPBNCPNV;
PERPNONSALC = PERPBANC + PERPBICMNC + PERPBICPNC + PERPBNCMNC + PERPBNCPNC;
PERPNONSALP = PERPBANP + PERPBICMNP + PERPBICPNP + PERPBNCMNP + PERPBNCPNP;
regle 31011:
application :  iliad , batch  ;
PERPREVTOTV = max(0,PERPSALNV + PERPNONSALV) ;
PERPREVTOTC = max(0,PERPSALNC + PERPNONSALC) ;
PERPREVTOTP = max(0,PERPSALNP + PERPNONSALP) ;
regle 31012:
application : iliad , batch  ;

pour i =V,C:
PERP_INDi = positif( 0 +
  positif(TSHALLOi)  
 + positif(ALLOi)    
 + positif(GLD1i)  + positif(GLD2i) + positif(GLD3i) 
 + positif(GLDGRATi)
 + positif(BPCOSAi)  + positif(TSASSUi) + positif(CARTSi) 
+ positif(FEXi)  + positif(BAFi)  + positif(BAFPVi) + positif(BAEXi)  
+ positif(BACREi) + positif(4BACREi) 
+ positif(BACDEi)  + positif(BAHEXi)  
+ positif(BAHREi) + positif(4BAHREi) 
+ positif(BAHDEi)  + positif(BAPERPi) 
+ positif(MIBEXi) + positif(MIBVENi) + positif(MIBPRESi) + positif(MIBPVi)
+ positif(AUTOBICVi) + positif(AUTOBICPi)
+ positif(BICEXi) + positif(BICNOi) + positif(BICDNi)  
+ positif(BIHEXi) + positif(BIHNOi)  
+ positif(BIHDNi) + positif(BIPERPi) 
+ positif(LOCPROCGAi) 
- positif(LOCDEFPROCGAi)
+ positif(LOCPROi) 
-  positif(LOCDEFPROi)
+ positif(BNCPROEXi) + positif(BNCPROi) + positif(BNCPROPVi)
+ positif(AUTOBNCi) 
+ positif(BNCEXi) + positif(BNCREi) + positif(BNCDEi) + positif(BNHEXi)  
+ positif(BNHREi) + positif(BNHDEi) + positif(BNCCRi) );

PERP_INDP = positif( 0+
  positif(TSHALLO1)    
 + positif(ALLO1)    
+ positif(FEXP)  + positif(BAFP)  + positif(BAFPVP)  + positif(BAEXP)  
+ positif(BACREP) + positif(4BACREP) 
+ positif(BACDEP)  + positif(BAHEXP)  
+ positif(BAHREP) + positif(4BAHREP) 
+ positif(BAHDEP)  + positif(BAPERPP) 
+ positif(MIBEXP) + positif(MIBVENP) + positif(MIBPRESP) + positif(MIBPVP)
+ positif(AUTOBICVP) + positif(AUTOBICPP)
+ positif(BICEXP) + positif(BICNOP) + positif(BICDNP)  
+ positif(BIHEXP) + positif(BIHNOP)  
+ positif(BIHDNP) + positif(BIPERPP) 
+ positif(LOCPROCGAP) 
- positif(LOCDEFPROCGAP) 
+ positif(LOCPROP) 
-  positif(LOCDEFPROP)   
+ positif(BNCPROEXP) + positif(BNCPROP) + positif(BNCPROPVP)
+ positif(AUTOBNCP)
+ positif(BNCEXP) + positif(BNCREP) + positif(BNCDEP) + positif(BNHEXP)  
+ positif(BNHREP) + positif(BNHDEP) + positif(BNCCRP) );

regle 31013:
application : iliad , batch  ;

PERPINDV = positif(
	    (positif(positif(PERP_INDV)
	      + (1 - positif(PERP_INDV))
		 * (1 - positif(PRBRV+PALIV)))
	    * positif(INDREV1A8))
	    + (1 - positif(PERP_INDV)) * positif(PRBRV+PALIV) 
			* positif(PERP_COTV) 
	    +PERPMUTU * (1 - positif(PERP_INDV+PERP_COTV)))
	    * (1 - PERP_NONV)
	    * (1 -V_CNR) ;
PERPINDC = positif(
	    (positif(positif(PERP_INDC)
	      + (1 - positif(PERP_INDC))
		 * (1 - positif(PRBRC+PALIC)))
	    * positif(INDREV1A8))
	    + (1 - positif(PERP_INDC)) * positif(PRBRC+PALIC)
			* positif(PERP_COTC) 
	    +PERPMUTU * (1 - positif(PERP_INDC+PERP_COTC)))		
	    * (1 - PERP_NONC)
	    * BOOL_0AM
	    * (1 -V_CNR) ;
PERPINDP = positif(
	    (positif(positif(PERP_INDP)
	      + (1 - positif(PERP_INDP))
		 * (1 - positif(PRBR1+PALIP)))
	    * positif(INDREV1A8))
	    + (1 - positif(PERP_INDP)) * positif(PRBR1+PALIP)
			* positif(PERP_COTP) 
	    )
	    * PERP_BOOL
	    * (1 -V_CNR) ;

regle 31014:
application : iliad , batch  ;
PERPINDCV = positif(V_BTPERPTOTV + PERPPLAFCV 
		+ PERPPLAFNUV1 + PERPPLAFNUV2 +PERPPLAFNUNV
		+ PERP_COTV) 
	    * PERPINDV
	    * (1 -V_CNR);
PERPINDCC = BOOL_0AM 
	    * positif(V_BTPERPTOTC + PERPPLAFCC 
		+ PERPPLAFNUC1 + PERPPLAFNUC2 +PERPPLAFNUNC
		+ PERP_COTC) 
	    * PERPINDC
            * (1 -V_CNR);
PERPINDCP = PERP_BOOL 
	  * positif(V_BTPERPTOTP + PERPPLAFCP 
		+ PERPPLAFNUP1 + PERPPLAFNUP2 +PERPPLAFNUNP
		+ PERP_COTP) 
	+0
	   * (1 -V_CNR);
regle 31015:
application : iliad , batch  ;
PERPPLAFV = positif(PERPINDV) *
	      max(0,positif(PERPREVTOTV) 
	      * (max(min(arr(PERPREVTOTV * TX_PERPPLAF/100),LIM_PERPMAX),LIM_PERPMIN)-PERPV)
            + (1 - positif(PERPREVTOTV)) * (LIM_PERPMIN - PERPV) 
               )
 	   * (1 -V_CNR);
PERPPLAFC = positif(PERPINDC) * BOOL_0AM * 
		max(0,positif(PERPREVTOTC) 
		* (max(min(arr(PERPREVTOTC * TX_PERPPLAF/100),LIM_PERPMAX),LIM_PERPMIN)-PERPC)
                + (1 - positif(PERPREVTOTC)) * (LIM_PERPMIN - PERPC)
                   ) 
 	   * (1 -V_CNR);
PERPPLAFP = positif(PERPINDP) *
	      max(0,positif(PERPREVTOTP) 
	      * (max(min(arr(PERPREVTOTP * TX_PERPPLAF/100),LIM_PERPMAX),LIM_PERPMIN)-PERPP)
            + (1 - positif(PERPREVTOTP)) * (LIM_PERPMIN - PERPP) 
               )
 	   * (1 -V_CNR);
regle 31016:
application : iliad , batch  ;
pour i =V,C,P:
PERPPLAFTi = PERPINDi 
	     * max(0,PERPPLAFi + PERPPLAFNUNi + PERPPLAFNU1i + PERPPLAFNU2i) 
	     * (1 - V_CNR);
regle 31017:
application : iliad , batch  ;
pour i =V,C,P:
PERPPLATiANT = (1 - positif(present(PERPPLAFCi) + present(PERPPLAFNUi1)
		+ present(PERPPLAFNUi2) + present(PERPPLAFNUi3)))
		* V_BTPERPTOTi
		+ positif(present(PERPPLAFCi) + present(PERPPLAFNUi1)
		+ present(PERPPLAFNUi2) + present(PERPPLAFNUi3))
		 *(PERPPLAFCi + PERPPLAFNUi1 + PERPPLAFNUi2 + PERPPLAFNUi3);
pour i =V,C,P:
PERPPLAFiANT = present(PERPPLAFCi) * PERPPLAFCi
	      + (1 - present(PERPPLAFCi)) * V_BTPERPi;
pour i =V,C,P:
PERPPLAFNUi2ANT = present(PERPPLAFNUi2) * PERPPLAFNUi2
 		+(1 - present(PERPPLAFNUi2)) * V_BTPERPNUi2 ;
pour i =V,C,P:
PERPPLAFNUi3ANT = present(PERPPLAFNUi3) * PERPPLAFNUi3
 		+(1 - present(PERPPLAFNUi3)) * V_BTPERPNUi3 ;
regle 31018:
application : iliad , batch  ;
PERPPLAFNUTV = (1 - positif(PERP_COND1)) * (1 - positif(PERP_COND2))
		* max(PERPPLATVANT - RPERPV,0)
		+ positif(PERP_COND1) * 0
		+ positif(PERP_COND2) * max(0,PERPPLATVANT - RPERPV - RPERPMUTC)
		;
PERPPLAFNUTC = (1 - positif(PERP_COND1)) * (1 - positif(PERP_COND2))
		* max(PERPPLATCANT - RPERPC,0)
		+ positif(PERP_COND1) * max(0,PERPPLATCANT - RPERPC - RPERPMUTV)
		+ positif(PERP_COND2) * 0
		;
PERPPLAFNUTP = max(PERPPLATPANT - RPERPP,0) ;
PERPPLAFNUV = (1 - positif(PERP_COND1)) * (1 - positif(PERP_COND2))
		* ((1 - positif(PERPIMPATRIE+0)) * max(0,PERPPLAFVANT - RPERPV)
	         + positif(PERPIMPATRIE+0) * max(0,PERPPLAFV - RPERPV))
	       + positif(PERP_COND1) * 0
	       + positif(PERP_COND2) 
	       * ((1 - positif(PERPIMPATRIE))
		 * max(0,PERPPLAFVANT - RPERPV - RPERPMUTC)
		 + positif(PERPIMPATRIE)
		 * max(0,PERPPLAFV - RPERPV - RPERPMUTC))
	       ;
PERPPLAFNUC = (1 - positif(PERP_COND1)) * (1 - positif(PERP_COND2))
		* ((1 - positif(PERPIMPATRIE+0)) * max(0,PERPPLAFCANT - RPERPC)
	         + positif(PERPIMPATRIE+0) * max(0,PERPPLAFC - RPERPC))
	       + positif(PERP_COND1) 
	       * ((1 - positif(PERPIMPATRIE))
	       * max(0,PERPPLAFCANT - RPERPC - RPERPMUTV)
		 + positif(PERPIMPATRIE)
	       * max(0,PERPPLAFC - RPERPC - RPERPMUTV))
	       + positif(PERP_COND2) * 0
	       ;
PERPPLAFNUP = (1 - positif(PERPIMPATRIE+0)) * max(0,PERPPLAFPANT - RPERPP)
	       + positif(PERPIMPATRIE+0) * max(0,PERPPLAFP - RPERPP)
	       ;
pour i =V,C,P:
PERPPLAFNUNi = max(0,PERPPLAFNUi);
PERPPLAFNU3V = (1 - positif(PERP_COND1)) * (1 - positif(PERP_COND2))
		* ((1 - positif(PERPIMPATRIE+0)) 
		* (positif(PERPPLAFNUV) * PERPPLAFNUV3ANT
	             + (1 - positif(PERPPLAFNUV)) 
		    * max(0,PERPPLAFNUV3ANT - (RPERPV - PERPPLAFVANT)))
		    + positif(PERPIMPATRIE+0) * 0 )
   		+ positif(PERP_COND1) * 0
   		+ positif(PERP_COND2) * (positif(PERPPLAFNUV) * PERPPLAFNUV3ANT
			+ (1 - positif(PERPPLAFNUV)) *max(0,PERPPLAFNUV3ANT - (RPERPV + RPERPMUTC- PERPPLAFVANT)))
		    ;
PERPPLAFNU3C = (1 - positif(PERP_COND1)) * (1 - positif(PERP_COND2))
		* ((1 - positif(PERPIMPATRIE+0)) 
		* (positif(PERPPLAFNUC) * PERPPLAFNUC3ANT
	             + (1 - positif(PERPPLAFNUC)) 
		    * max(0,PERPPLAFNUC3ANT - (RPERPC - PERPPLAFCANT)))
		    + positif(PERPIMPATRIE+0) * 0 )
   		+ positif(PERP_COND1) * (positif(PERPPLAFNUC) * PERPPLAFNUC3ANT
			+ (1 - positif(PERPPLAFNUC)) *max(0,PERPPLAFNUC3ANT - (RPERPC + RPERPMUTV- PERPPLAFCANT)))
   		+ positif(PERP_COND2) * 0
		    ;
PERPPLAFNU3P = (1 - positif(PERPIMPATRIE+0)) 
		* (
		  max(0,positif(PERPPLAFNUP) * PERPPLAFNUP3ANT
	             + (1 - positif(PERPPLAFNUP+0)) 
		    * (PERPPLAFNUP3ANT - (RPERPP - PERPPLAFPANT)))
		    )
		 + positif(PERPIMPATRIE+0) * 0 ;
PERPPLAFNU2V = (1 - positif(PERP_COND1)) * (1 - positif(PERP_COND2))
		* ((1 - positif(PERPIMPATRIE+0)) 
		* (positif(PERPPLAFVANT + PERPPLAFNUV3ANT - RPERPV) 
				* PERPPLAFNUV2ANT
	          + (1 - positif(PERPPLAFVANT + PERPPLAFNUV3ANT - RPERPV)) 
		    * max(0,PERPPLAFNUV2ANT - (RPERPV - PERPPLAFVANT - PERPPLAFNUV3ANT)))
		    + positif(PERPIMPATRIE+0) * 0 )
   		+ positif(PERP_COND1) * 0
   		+ positif(PERP_COND2) 
		* ((1 - positif(PERPIMPATRIE+0)) 
		* (positif(PERPPLAFVANT + PERPPLAFNUV3ANT - RPERPV - RPERPMUTC) 
				* PERPPLAFNUV2ANT
	          + (1 - positif(PERPPLAFVANT + PERPPLAFNUV3ANT - RPERPV - RPERPMUTC)) 
		    * max(0,PERPPLAFNUV2ANT - (RPERPV + RPERPMUTC) - (PERPPLAFVANT + PERPPLAFNUV3ANT)))
		    + positif(PERPIMPATRIE+0) * 0 )
		;
PERPPLAFNU2C = (1 - positif(PERP_COND1)) * (1 - positif(PERP_COND2))
		* ((1 - positif(PERPIMPATRIE+0)) 
		* (positif(PERPPLAFCANT + PERPPLAFNUC3ANT - RPERPC) 
				* PERPPLAFNUC2ANT
	          + (1 - positif(PERPPLAFCANT + PERPPLAFNUC3ANT - RPERPC)) 
		    * max(0,PERPPLAFNUC2ANT - (RPERPC - PERPPLAFCANT - PERPPLAFNUC3ANT)))
		    + positif(PERPIMPATRIE+0) * 0 )
   		+ positif(PERP_COND1) 
		* ((1 - positif(PERPIMPATRIE+0)) 
		    * (positif(PERPPLAFCANT + PERPPLAFNUC3ANT - RPERPC - RPERPMUTV) 
				* PERPPLAFNUC2ANT
	          + (1 - positif(PERPPLAFCANT + PERPPLAFNUC3ANT - RPERPC - RPERPMUTV)) 
		    * max(0,PERPPLAFNUC2ANT - (RPERPC + RPERPMUTV) - (PERPPLAFCANT + PERPPLAFNUC3ANT)))
		    + positif(PERPIMPATRIE+0) * 0 )
   		+ positif(PERP_COND2) * 0
		;
PERPPLAFNU2P = (1 - positif(PERPIMPATRIE+0)) 
             * (
             max(0,positif(PERPPLAFPANT + PERPPLAFNUP3ANT - RPERPP) 
             * PERPPLAFNUP2ANT
             + (1 - positif(PERPPLAFPANT + PERPPLAFNUP3ANT - RPERPP)) 
             * max(0,PERPPLAFNUP2ANT - (RPERPP - PERPPLAFPANT - PERPPLAFNUP3ANT)))
             )
             + positif(PERPIMPATRIE+0) * 0 ;
PERPPLAFNU1V = (1 - positif(PERP_COND1)) * (1 - positif(PERP_COND2))
		* ((1 - positif(PERPIMPATRIE+0)) 
	         * max(PERPPLAFNUTV - PERPPLAFNUNV - PERPPLAFNU3V - PERPPLAFNU2V,0)
	       	+ positif(PERPIMPATRIE+0) * 0 )
		+ positif(PERP_COND1) * 0
		+ positif(PERP_COND2) 
		* ((1 - positif(PERPIMPATRIE+0)) 
	         * max(PERPPLAFNUTV - PERPPLAFNUNV - PERPPLAFNU3V - PERPPLAFNU2V,0)
   		+ positif(PERP_COND2) * 0)
	       ;
PERPPLAFNU1C = (1 - positif(PERP_COND1)) * (1 - positif(PERP_COND2))
		* ((1 - positif(PERPIMPATRIE+0)) 
	         * max(PERPPLAFNUTC - PERPPLAFNUNC - PERPPLAFNU3C - PERPPLAFNU2C,0)
	       	+ positif(PERPIMPATRIE+0) * 0 )
		+ positif(PERP_COND1) 
		* ((1 - positif(PERPIMPATRIE+0)) 
	         * max(PERPPLAFNUTC - PERPPLAFNUNC - PERPPLAFNU3C - PERPPLAFNU2C,0)
		    + positif(PERPIMPATRIE+0) * 0) 
		+ positif(PERP_COND2) * 0
	       ;
PERPPLAFNU1P = (1 - positif(PERPIMPATRIE+0)) 
	         * max(PERPPLAFNUTP - PERPPLAFNUNP - PERPPLAFNU3P - PERPPLAFNU2P,0)
	       + positif(PERPIMPATRIE+0) * 0 ;
regle 31019:
application : iliad , batch  ;
PERP_NONV = positif(
		(1 - positif(PERP_INDV)) * (1 - positif(PRBRV+PALIV))
		* (1 - positif(PERP_COTV))
		* (1 - positif(PERP_INDC)) * positif(PRBRC+PALIC)
	  ) ;
PERP_NONC = BOOL_0AM * positif(
		(1 - positif(PERP_INDC)) * (1 - positif(PRBRC+PALIC))
		* (1 - positif(PERP_COTC))
		* (1 - positif(PERP_INDV)) * positif(PRBRV+PALIV)
	  ) ;
PERP_NONP = PERP_BOOL * positif(PERP_NONC + PERP_NONV) ;
regle 31020:
application : iliad , batch  ;
pour i=V,C,P:
PERPPLAFCOMi = positif(PERPIMPATRIE) * PERPPLAFi *3
	      + (1 - positif(PERPIMPATRIE)) * 0;
pour i=V,C,P:
PERPPLAFIMPi = positif(PERPIMPATRIE) * (PERPPLAFCOMi + PERPPLAFi)
	      + (1 - positif(PERPIMPATRIE)) * 0;
regle 31021:
application : iliad , batch  ;
PERP_MUT = positif(PERPMUTU)
	   * positif(V_0AM+V_0AO)
	   * (1 - positif(V_0AC+V_0AD+V_0AV))
	   ;
PERP_COND1 =  positif(PERP_MUT)
	      *((1 - positif(PERPIMPATRIE))
	      * positif(PERP_COTV  - PERPPLATVANT)
	      * positif(PERPPLATCANT - PERP_COTC)
	      + positif(PERPIMPATRIE)
	      * positif(PERP_COTV  - PERPPLAFIMPV)
	      * positif(PERPPLAFIMPC - PERP_COTC)
	      );
PERP_COND2 =  positif(PERP_MUT) 
	      *((1 - positif(PERPIMPATRIE))
	      * positif(PERP_COTC  - PERPPLATCANT)
	      * positif(PERPPLATVANT - PERP_COTV)
	      + positif(PERPIMPATRIE)
	      * positif(PERP_COTC  - PERPPLAFIMPC)
	      * positif(PERPPLAFIMPV - PERP_COTV)
	      );
PERPPLAFMUTV = positif(PERP_COND1)
	      *((1 - positif(PERPIMPATRIE))
	       * (PERPPLATVANT + max(0,PERPPLATCANT - PERP_COTC))
	      + positif(PERPIMPATRIE)
	       * (PERPPLAFIMPV + max(0,PERPPLAFIMPC - PERP_COTC))
	      );
PERPPLAFMUTC = positif(PERP_COND2)
	      *((1 - positif(PERPIMPATRIE))
	       * (PERPPLATCANT + max(0,PERPPLATVANT - PERP_COTV))
	      + positif(PERPIMPATRIE)
	       * (PERPPLAFIMPC + max(0,PERPPLAFIMPV - PERP_COTV))
	      );
regle 310211:
application : iliad , batch  ;
PERPPLAFMU1V = positif(PERP_COND1) 
	      *((1 - positif(PERPIMPATRIE)) * (PERPPLATVANT + RPERPMUTV)
	      + positif(PERPIMPATRIE) * (PERPPLAFIMPV + RPERPMUTV))
		+ positif(PERP_COND2) 
	      *((1 - positif(PERPIMPATRIE)) * (PERPPLATVANT - RPERPMUTC)
	      + positif(PERPIMPATRIE) * (PERPPLAFIMPV - RPERPMUTC));
PERPPLAFMU1C = positif(PERP_COND1) 
	      *((1 - positif(PERPIMPATRIE)) * (PERPPLATCANT - RPERPMUTV)
	      + positif(PERPIMPATRIE) * (PERPPLAFIMPC - RPERPMUTV))
		+ positif(PERP_COND2) 
      		*((1 - positif(PERPIMPATRIE)) * (PERPPLATCANT + RPERPMUTC)
      		+positif(PERPIMPATRIE) *(PERPPLAFIMPC + RPERPMUTC));
regle 31022:
application : iliad , batch  ;
pour i =V,C,P:
DPERPi = PERP_COTi;
RPERPV = (1 - positif(PERP_COND1)) * (1 - positif(PERP_COND2)) 
          * ((1 - positif(PERPIMPATRIE))
		 * max(0,min(PERP_COTV,PERPPLATVANT))
	    + positif(PERPIMPATRIE)
		 * max(0,min(PERP_COTV,PERPPLAFIMPV)))
	 + positif(PERP_COND1) 
		* (min(PERP_COTV,PERPPLAFMUTV))
	 + positif(PERP_COND2) 
          * ((1 - positif(PERPIMPATRIE))
		 * max(0,min(PERP_COTV,PERPPLATVANT))
	    + positif(PERPIMPATRIE)
		 * max(0,min(PERP_COTV,PERPPLAFIMPV)))
	 ;
RPERPC = (1 - positif(PERP_COND1)) * (1 - positif(PERP_COND2)) 
          * ((1 - positif(PERPIMPATRIE))
		 * max(0,min(PERP_COTC,PERPPLATCANT))
	    + positif(PERPIMPATRIE)
		 * max(0,min(PERP_COTC,PERPPLAFIMPC)))
	 + positif(PERP_COND1) 
          * ((1 - positif(PERPIMPATRIE))
		 * max(0,min(PERP_COTC,PERPPLATCANT))
	    + positif(PERPIMPATRIE)
		 * max(0,min(PERP_COTC,PERPPLAFIMPC)))
	 + positif(PERP_COND2) * (min(PERP_COTC,PERPPLAFMUTC))
	 ;
RPERPP = ( (1 - positif(PERPIMPATRIE))
		 * max(0,min(PERP_COTP,PERPPLATPANT))
	    + positif(PERPIMPATRIE)
		 * max(0,min(PERP_COTP,PERPPLAFIMPP))
	  );	
APERPV = (1 - V_CNR) * max(min(RPERPV,RBG - RPALE - RPALP - RFACC
        - RDDIV - DDCSG + TOTALQUO -SDD), 0);
APERPC = (1 - V_CNR) * max(min(RPERPC,RBG - RPALE - RPALP  - RFACC
        - RDDIV - DDCSG + TOTALQUO -SDD - APERPV), 0);
APERPP = (1 - V_CNR) * max(min(RPERPP,RBG - RPALE - RPALP  - RFACC
        - RDDIV - DDCSG + TOTALQUO -SDD - APERPV - APERPC), 0);
TAPERPV = (1 - V_CNR) * max(min(RPERPV,RBG*(1-INDTEFF)+ TEFFREVTOT3 - RPALE - RPALP - RFACC
        - RDDIV - DDCSG + TOTALQUO -SDD), 0);
TAPERPC = (1 - V_CNR) * max(min(RPERPC,RBG *(1-INDTEFF)+ TEFFREVTOT3- RPALE - RPALP  - RFACC
        - RDDIV - DDCSG + TOTALQUO -SDD - APERPV), 0);
TAPERPP = (1 - V_CNR) * max(min(RPERPP,RBG *(1-INDTEFF)+ TEFFREVTOT3- RPALE - RPALP  - RFACC
        - RDDIV - DDCSG + TOTALQUO -SDD - APERPV - APERPC), 0);
regle 310225:
application :  iliad , batch  ;
PERPDCOTV = (1 - positif(PERP_COND1)) * (1 - positif(PERP_COND2)) 
          * ((1 - positif(PERPIMPATRIE))
		 * min(PERP_COTV,PERPPLATVANT)
	    + positif(PERPIMPATRIE)
		 * min(PERP_COTV,PERPPLAFIMPV))
	 + positif(PERP_COND1) 
		* min(PERP_COTV,PERPPLAFMU1V)
	 + positif(PERP_COND2) 
          * ((1 - positif(PERPIMPATRIE))
		 * min(PERP_COTV,PERPPLATVANT)
	    + positif(PERPIMPATRIE)
		 * min(PERP_COTV,PERPPLAFIMPV))
	 ;
PERPDCOTC = (1 - positif(PERP_COND1)) * (1 - positif(PERP_COND2)) 
          * ((1 - positif(PERPIMPATRIE))
		 * min(PERP_COTC,PERPPLATCANT)
	    + positif(PERPIMPATRIE)
		 * min(PERP_COTC,PERPPLAFIMPC))
	 + positif(PERP_COND1) 
          * ((1 - positif(PERPIMPATRIE))
		 * min(PERP_COTC,PERPPLATCANT)
	    + positif(PERPIMPATRIE)
		 * min(PERP_COTC,PERPPLAFIMPC))
	 + positif(PERP_COND2) * min(PERP_COTC,PERPPLAFMU1C)
	 ;
PERPDCOTP = ( (1 - positif(PERPIMPATRIE))
		 * min(PERP_COTP,PERPPLATPANT)
	    + positif(PERPIMPATRIE)
		 * min(PERP_COTP,PERPPLAFIMPP)
	  );	
regle 31023:
application : iliad , batch  ;
RPERPMUTV = positif(PERP_COND1) 
	      *((1 - positif(PERPIMPATRIE))
		* max(0,min(PERP_COTV - PERPPLATVANT,PERPPLATCANT - PERP_COTC))
	      + positif(PERPIMPATRIE)
		* max(0,min(PERP_COTV - PERPPLAFIMPV,PERPPLAFIMPC - PERP_COTC))
		);
RPERPMUTC = positif(PERP_COND2) 
	      *((1 - positif(PERPIMPATRIE))
		* max(0,min(PERP_COTC - PERPPLATCANT,PERPPLATVANT - PERP_COTV))
	      + positif(PERPIMPATRIE)
		* max(0,min(PERP_COTC - PERPPLAFIMPC,PERPPLAFIMPV - PERP_COTV))
		);
regle 31024:
application : iliad , batch  ;
IND_BTANC = null(V_IND_TRAIT -4)
           * (positif(APPLI_OCEANS) * 1
	    + positif(APPLI_COLBERT)
	    + positif(APPLI_BATCH) * V_BTANC
	    + positif(APPLI_ILIAD) * ( positif(V_CALCULIR) * 1
				     + (1 - positif(V_CALCULIR)) * V_BTANC)
	     )
	     + null(V_IND_TRAIT - 5) * 1;
pour i = V,C,P :
PERPINDAFFi = positif(PERPINDi 
		* (1 - V_CNR) * (1 - positif(ANNUL2042))
		* ((null(IND_BTANC - 1)
		* (positif(PERPIMPATRIE+0)
		* positif(PERPPLAFNUNi+PERPPLAFi+positif_ou_nul(PERPi)*positif(PERPREVTOTi))
		+ (1 - positif(PERPIMPATRIE+0))
		* (present(PERPPLAFCi) + present(V_BTPERPi)) 
		* (present(PERPPLAFNUi1) + present(V_BTPERPNUi1))
	        * (present(PERPPLAFNUi2) + present(V_BTPERPNUi2))
		* (present(PERPPLAFNUi3) + present(V_BTPERPNUi3))
	        ))
		+((null(IND_BTANC - 2)
		* positif(V_BTPERPi + V_BTPERPNUi1 + V_BTPERPNUi2 + V_BTPERPNUi3
		     + PERPPLAFCi + PERPPLAFNUi1 + PERPPLAFNUi2 + PERPPLAFNUi3)))));
