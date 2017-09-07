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
                                                                         #####
  ####   #    #    ##    #####      #     #####  #####   ######         #     #
 #    #  #    #   #  #   #    #     #       #    #    #  #                    #
 #       ######  #    #  #    #     #       #    #    #  #####           #####
 #       #    #  ######  #####      #       #    #####   #                    #
 #    #  #    #  #    #  #          #       #    #   #   #              #     #
  ####   #    #  #    #  #          #       #    #    #  ###### #######  #####
 #
 #
 #
 #
 #
 #
 #
 #                       CALCUL DE L'IMPOT NET
 #
 #
 #
 #
 #
 #
regle 3009:
application : pro , bareme , oceans , iliad , batch  ;
BCIGA = CRIGA;
regle 301:
application : pro , oceans , bareme , iliad , batch  ;

IRN = min( 0, IAN + AVFISCOPTER - IRE ) + max( 0, IAN + AVFISCOPTER - IRE ) * positif( IAMD1 + 1 - SEUIL_PERCEP) ;


regle 3010:
application : pro , bareme , oceans , iliad , batch  ;

IAR = min( 0, IAN + AVFISCOPTER - IRE ) + max( 0, IAN + AVFISCOPTER - IRE ) ;

regle 302:
application : pro , oceans , iliad , batch  ;
CREREVET =  arr(CIIMPPRO * TX_CREREVET / 100 )
	  + arr(CIIMPPRO2 * TXGAIN1 / 100 );

CIIMPPROTOT = CIIMPPRO + CIIMPPRO2 ;
regle 3025:
application : pro , oceans , iliad , batch  ;

ICREREVET = max(0,min(IAD11 + ITP - CIRCMAVFT - IRETS - min(IAD11 , CRCFA), min(ITP,CREREVET)));

regle 3026:
application : pro , oceans , iliad , batch , bareme ;

INE = (IRETS + min(IAD11 , CRCFA) + ICREREVET + CICULTUR + CIGPA + CIDONENTR + CICORSE + CIRECH + CIRCMAVFT)
            * (1-positif(RE168+TAX1649));

IAN = max( 0, (IRB - AVFISCOPTER + ((- IRETS
                                     - min(IAD11 , CRCFA) 
                                     - ICREREVET
                                     - CICULTUR
                                     - CIGPA
                                     - CIDONENTR
                                     - CICORSE
				     - CIRECH
			             - CIRCMAVFT )
                                   * (1 - positif(RE168+TAX1649)))
                + min(TAXASSUR+0,max(0,INE-IRB+REI+AVFISCOPTER)) 
                + min(RPPEACO+0,max(0,INE-IRB+REI+AVFISCOPTER-min(TAXASSUR+0,max(0,INE-IRB+REI+AVFISCOPTER)))) 
	      )
	  )
 ;

regle 3021:
application : pro , oceans , iliad , batch  ;
IRE = si ( positif(RE168+TAX1649+0) = 0) 
      alors
       (si    ( V_REGCO = 2 )
        alors ( EPAV + CRICH 
             + CICA + CIGE  + IPELUS + CREFAM + CREAPP 
	     + CIDEVDUR + CIDEDUBAIL + CIPRETUD + CILOYIMP + CIGARD
	     + CREAGRIBIO + CREPROSP + CREFORMCHENT + CREARTS + CICONGAGRI 
	     + CRERESTAU + CIHABPRIN + CIADCRE + CIDEBITTABAC + CREINTERESSE
	     + AUTOVERSLIB + CIPERT + CITEC
	      )

        sinon ( EPAV + CRICH
             + CICA +  CIGE  + IPELUS + CREFAM + CREAPP + PPETOT - PPERSA
	     + DIREPARGNE + CIDEVDUR + CIDEDUBAIL + CIPRETUD + CILOYIMP + CIGARD
	     + CREAGRIBIO + CREPROSP + CREFORMCHENT + CREARTS + CICONGAGRI 
	     + CRERESTAU + CIHABPRIN + CIADCRE + CIDEBITTABAC + CREINTERESSE 
	     + AUTOVERSLIB + CIPERT + CITEC
	      )
	     
        finsi)
       finsi;
IRE2 = IRE + (BCIGA * (1 - positif(RE168+TAX1649))); 
regle 3022:
application : pro , oceans , iliad , batch  ;

CRICH =  IPRECH * (1 - positif(RE168+TAX1649));
regle 30221:
application : pro , oceans , iliad , batch  ;
CIRCMAVFT = max(0,min(IRB + TAXASSUR + RPPEACO - AVFISCOPTER , RCMAVFT * (1 - null(2 - V_REGCO))));
regle 30222:
application : pro , oceans , iliad , batch  ;
CIDIREPARGNE = DIREPARGNE * (1 - null(2 - V_REGCO));
regle 30226:
application : pro , batch, oceans, iliad;
CICA =  arr(BAILOC98 * TX_BAIL / 100);
regle 3023:
application : pro , oceans , iliad , batch  ;
CRCFA = (arr(IPQ1 * REGCI / (RB01 + TONEQUO + CHTOT + RDCSG + ABMAR + ABVIE)) * (1 - positif(RE168+TAX1649)));
regle 30231:
application : pro , oceans , iliad , batch ;
CICSG = min( CSGC , arr( IPPNCS * T_CSG/100 ));
CIRDS = min( RDSC , arr( IPPNCS * T_RDS/100 ));
CIPRS = min( PRSC , arr( IPPNCS * T_PREL_SOC/100 ));


regle 30400:
application : pro , oceans ,  iliad , batch  ;
PPE_DATE_DEB = positif(BOOL_0AM)*positif(V_0AX+0) * (V_0AX+0)
             + positif(V_0AD+0)*positif(V_0AY+0) * (V_0AY+0)
             + positif(V_0AC+0)*positif(V_0AY+0) * (V_0AY+0)
             + positif(V_0AV+0)*positif(V_0AY+0) * (V_0AY+0)
             + positif(V_0AV+0)*positif(V_0AZ+0) * (V_0AZ+0)
             + positif(DATRETETR+0)*(DATRETETR+0)
                   *null(V_0AX+0)*null(V_0AY+0)*null(V_0AZ+0);
PPE_DATE_FIN = positif(BOOL_0AM)*positif(V_0AY+0) * (V_0AY+0)
             + positif(BOOL_0AM)*positif(V_0AZ+0) * (V_0AZ+0)
             + positif(V_0AC+0)*positif(V_0AX+0) * (V_0AX+0)
             + positif(V_0AD+0)*positif(V_0AX+0) * (V_0AX+0)
             + positif(V_0AV+0)*positif(V_0AX+0) * (V_0AX+0)
             + positif(DATDEPETR+0)*(DATDEPETR+0)
                   *null(V_0AX+0)*null(V_0AY+0)*null(V_0AZ+0);
regle 30500:
application : pro , oceans ,  iliad , batch  ;
PPE_DEBJJMMMM =  PPE_DATE_DEB + (01010000+V_ANREV) * null(PPE_DATE_DEB+0);
PPE_DEBJJMM = arr( (PPE_DEBJJMMMM - V_ANREV)/10000);
PPE_DEBJJ =  inf(PPE_DEBJJMM/100);
PPE_DEBMM =  PPE_DEBJJMM -  (PPE_DEBJJ*100);
PPE_DEBRANG= PPE_DEBJJ 
             + (PPE_DEBMM - 1 ) * 30;
regle 30501:
application : pro , oceans ,  iliad , batch  ;
PPE_FINJJMMMM =  PPE_DATE_FIN + (30120000+V_ANREV) * null(PPE_DATE_FIN+0);
PPE_FINJJMM = arr( (PPE_FINJJMMMM - V_ANREV)/10000);
PPE_FINJJ =  inf(PPE_FINJJMM/100);
PPE_FINMM =  PPE_FINJJMM -  (PPE_FINJJ*100);
PPE_FINRANG= PPE_FINJJ 
             + (PPE_FINMM - 1 ) * 30
             - 1 * positif (PPE_DATE_FIN);
regle 30503:
application : pro , oceans ,  iliad , batch  ;
PPE_DEBUT = PPE_DEBRANG ;
PPE_FIN   = PPE_FINRANG ;
PPENBJ = max(1, arr(min(PPENBJAN , PPE_FIN - PPE_DEBUT + 1))) ;
regle 30508:
application : pro , oceans ,  iliad , batch  ;
PPETX1 = PPE_TX1 ;
PPETX2 = PPE_TX2 ;
PPETX3 = PPE_TX3 ;
regle 30510:
application : pro , oceans ,  iliad , batch  ;
PPE_BOOL_ACT_COND = positif(


   positif ( TSHALLOV ) 
 + positif ( TSHALLOC ) 
 + positif ( TSHALLO1 ) 
 + positif ( TSHALLO2 ) 
 + positif ( TSHALLO3 ) 
 + positif ( TSHALLO4 ) 
 + positif ( GLD1V ) 
 + positif ( GLD2V ) 
 + positif ( GLD3V ) 
 + positif ( GLD1C ) 
 + positif ( GLD2C ) 
 + positif ( GLD3C ) 
 + positif ( BPCOSAV ) 
 + positif ( BPCOSAC ) 
 + positif ( TSASSUV ) 
 + positif ( TSASSUC ) 
 + positif( CARTSV ) * positif( CARTSNBAV )
 + positif( CARTSC ) * positif( CARTSNBAC )
 + positif( CARTSP1 ) * positif( CARTSNBAP1 )
 + positif( CARTSP2 ) * positif( CARTSNBAP2 )
 + positif( CARTSP3 ) * positif( CARTSNBAP3 )
 + positif( CARTSP4 ) * positif( CARTSNBAP4 )
 + positif( TSELUPPEV )
 + positif( TSELUPPEC )
 + positif( HEURESUPV )
 + positif( HEURESUPC )
 + positif( HEURESUPP1 )
 + positif( HEURESUPP2 )
 + positif( HEURESUPP3 )
 + positif( HEURESUPP4 )
 + positif ( FEXV ) 
 + positif ( BAFV ) 
 + positif ( BAFPVV ) 
 + positif ( BAEXV ) 
 + positif ( BACREV ) + positif ( 4BACREV )
 + positif ( BACDEV ) 
 + positif ( BAHEXV ) 
 + positif ( BAHREV ) + positif ( 4BAHREV )
 + positif ( BAHDEV ) 
 + positif ( MIBEXV ) 
 + positif ( MIBVENV ) 
 + positif ( MIBPRESV ) 
 + positif ( MIBPVV ) 
 + positif ( BICEXV ) 
 + positif ( BICNOV ) 
 + positif ( BICDNV ) 
 + positif ( BIHEXV ) 
 + positif ( BIHNOV ) 
 + positif ( BIHDNV ) 
 + positif ( FEXC ) 
 + positif ( BAFC ) 
 + positif ( BAFPVC ) 
 + positif ( BAEXC ) 
 + positif ( BACREC ) + positif ( 4BACREC )
 + positif ( BACDEC ) 
 + positif ( BAHEXC ) 
 + positif ( BAHREC ) + positif ( 4BAHREC )
 + positif ( BAHDEC ) 
 + positif ( MIBEXC ) 
 + positif ( MIBVENC ) 
 + positif ( MIBPRESC ) 
 + positif ( MIBPVC ) 
 + positif ( BICEXC ) 
 + positif ( BICNOC ) 
 + positif ( BICDNC ) 
 + positif ( BIHEXC ) 
 + positif ( BIHNOC ) 
 + positif ( BIHDNC ) 
 + positif ( FEXP ) 
 + positif ( BAFP ) 
 + positif ( BAFPVP ) 
 + positif ( BAEXP ) 
 + positif ( BACREP ) + positif ( 4BACREP )
 + positif ( BACDEP ) 
 + positif ( BAHEXP ) 
 + positif ( BAHREP ) + positif ( 4BAHREP )
 + positif ( BAHDEP ) 
 + positif ( MIBEXP ) 
 + positif ( MIBVENP ) 
 + positif ( MIBPRESP ) 
 + positif ( BICEXP ) 
 + positif ( MIBPVP ) 
 + positif ( BICNOP ) 
 + positif ( BICDNP ) 
 + positif ( BIHEXP ) 
 + positif ( BIHNOP ) 
 + positif ( BIHDNP ) 
 + positif ( BNCPROEXV ) 
 + positif ( BNCPROV ) 
 + positif ( BNCPROPVV ) 
 + positif ( BNCEXV ) 
 + positif ( BNCREV ) 
 + positif ( BNCDEV ) 
 + positif ( BNHEXV ) 
 + positif ( BNHREV ) 
 + positif ( BNHDEV ) 
 + positif ( BNCCRV ) 
 + positif ( BNCPROEXC ) 
 + positif ( BNCPROC ) 
 + positif ( BNCPROPVC ) 
 + positif ( BNCEXC ) 
 + positif ( BNCREC ) 
 + positif ( BNCDEC ) 
 + positif ( BNHEXC ) 
 + positif ( BNHREC ) 
 + positif ( BNHDEC ) 
 + positif ( BNCCRC ) 
 + positif ( BNCPROEXP ) 
 + positif ( BNCPROP ) 
 + positif ( BNCPROPVP ) 
 + positif ( BNCEXP ) 
 + positif ( BNCREP ) 
 + positif ( BNCDEP ) 
 + positif ( BNHEXP ) 
 + positif ( BNHREP ) 
 + positif ( BNHDEP )
 + positif ( BNCCRP ) 
 + positif ( BIPERPV )
 + positif ( BIPERPC )
 + positif ( BIPERPP )
 + positif ( BAFORESTV )
 + positif ( BAFORESTC )
 + positif ( BAFORESTP )
 + positif ( AUTOBICVV ) + positif ( AUTOBICPV ) + positif ( AUTOBNCV ) 
 + positif ( AUTOBICVC ) + positif ( AUTOBICPC ) + positif ( AUTOBNCC )
 + positif ( AUTOBICVP ) + positif ( AUTOBICPP ) + positif ( AUTOBNCP )
 + positif ( LOCPROCGAV ) + positif ( LOCPROV ) + positif ( LOCDEFPROCGAV )
 + positif ( LOCDEFPROV ) + positif ( LOCPROCGAC ) + positif ( LOCPROC )
 + positif ( LOCDEFPROCGAC ) + positif ( LOCDEFPROC ) + positif ( LOCPROCGAP ) 
 + positif ( LOCPROP ) + positif ( LOCDEFPROCGAP ) + positif ( LOCDEFPROP )
 + positif ( XHONOAAV ) + positif ( XHONOAAC ) + positif ( XHONOAAP )
 + positif ( XHONOV ) + positif ( XHONOC ) + positif ( XHONOP )
);
regle 30520:
application : pro , oceans ,  iliad , batch  ;
PPE_BOOL_SIFC 	= (1 - BOOL_0AM)*(1 - positif (V_0AV)*positif(V_0AZ)) ;


PPE_BOOL_SIFM	= BOOL_0AM  + positif (V_0AV)*positif(V_0AZ) ;

PPESEUILKIR   = PPE_BOOL_SIFC * PPELIMC  
                + PPE_BOOL_SIFM * PPELIMM
                + (NBPT - 1 - PPE_BOOL_SIFM - NBQAR) * 2 * PPELIMPAC
                + NBQAR * PPELIMPAC * 2 ;


PPE_KIRE =  REVKIRE * PPENBJAN / PPENBJ;

PPE_BOOL_KIR_COND =   (1 - null (IND_TDR)) * positif_ou_nul ( PPESEUILKIR - PPE_KIRE);

regle 30525:
application : pro , oceans ,  iliad , batch  ;
pour i=V,C:
PPE_BOOL_NADAi = positif (TSHALLOi+HEURESUPi+0 ) * null ( PPETPi+0  ) * null (PPENHi+0);
pour i=1,2,3,4:
PPE_BOOL_NADAi = positif (TSHALLOi+HEURESUPPi+0 ) * null ( PPETPPi+0 ) * null (PPENHPi+0);

PPE_BOOL_NADAU = positif(TSHALLO1 + TSHALLO2 + TSHALLO3 + TSHALLO4 
			  + HEURESUPP1 + HEURESUPP2 + HEURESUPP3 + HEURESUPP4 + 0)
                 * null ( PPETPP1 + PPETPP2 + PPETPP3 + PPETPP4     +0)
                 * null ( PPENHP1 + PPENHP2 + PPENHP3 + PPENHP4     +0);  

PPE_BOOL_NADAN=0;

regle 30530:
application : pro , oceans ,  iliad , batch  ;
pour i=V,C:
PPE_SALAVDEFi =
   TSHALLOi
 + HEURESUPi
 +  BPCOSAi  
 + GLD1i  
 + GLD2i  
 + GLD3i  
 + TSASSUi  
 + TSELUPPEi
 + CARTSi * positif(CARTSNBAi)
  ;
pour i =1..4:
PPE_SALAVDEFi= TSHALLOi + HEURESUPPi + CARTSPi * positif(CARTSNBAPi) ;

regle 30540:
application : pro , oceans ,  iliad , batch  ;
pour i = V,C,P:
PPE_RPRO1i =   
(
   FEXi  
 + BAFi  
 + BAEXi  
 + BACREi + 4BACREi
 - BACDEi  
 + BAHEXi  
 + BAHREi + 4BAHREi 
 - BAHDEi  
 + BICEXi  
 + BICNOi  
 - BICDNi  
 + BIHEXi  
 + BIHNOi  
 - BIHDNi  
 + BNCEXi  
 + BNCREi  
 - BNCDEi  
 + BNHEXi  
 + BNHREi  
 - BNHDEi  
 + MIBEXi  
 + BNCPROEXi  
 + TMIB_NETVi  
 + TMIB_NETPi
 + TSPENETPi  
 + BAFPVi  
 + MIBPVi  
 + BNCPROPVi  
 + BAFORESTi
 + LOCPROi + LOCPROCGAi - LOCDEFPROCGAi - LOCDEFPROi
 + XHONOAAi + XHONOi

) ;

pour i = V,C,P:
PPE_AVRPRO1i = 
(
   FEXi  
 + BAFi  
 + BAEXi  
 + BACREi + 4BACREi 
 - BACDEi  
 + BAHEXi  
 + BAHREi + 4BAHREi 
 - BAHDEi  
 + BICEXi  
 + BICNOi  
 - BICDNi  
 + BIHEXi   
 + BIHNOi  
 - BIHDNi  
 + BNCEXi  
 + BNCREi  
 - BNCDEi  
 + BNHEXi  
 + BNHREi  
 - BNHDEi  
 + MIBEXi  
 + BNCPROEXi  
 + MIBVENi  
 + MIBPRESi
 + BNCPROi  
 + BAFPVi  
 + MIBPVi  
 + BNCPROPVi  
 + BAFORESTi
 + AUTOBICVi + AUTOBICPi + AUTOBNCi 
 + LOCPROi + LOCPROCGAi + LOCDEFPROCGAi + LOCDEFPROi
 + XHONOAAi + XHONOi
) ;

pour i=V,C,P:
SOMMEAVRPROi = present(FEXi) + present(BAFi) + present(BAEXi) 
	      + present(BACREi) + present(4BACREi) + present(BACDEi) + present(BAHEXi) 
	      + present(BAHREi) + present(4BAHREi) + present(BAHDEi) + present(BICEXi) + present(BICNOi) 
	      + present(BICDNi) + present(BIHEXi) + present(BIHNOi) 
	      + present(BIHDNi) + present(BNCEXi) + present(BNCREi) 
              + present(BNCDEi) + present(BNHEXi) + present(BNHREi) + present(BNHDEi) + present(MIBEXi) 
              + present(BNCPROEXi) + present(MIBVENi) + present(MIBPRESi) + present(BNCPROi) 
	      + present(BAFPVi) + present(MIBPVi) + present(BNCPROPVi) + present(BAFORESTi)
	      + present(AUTOBICVi) + present(AUTOBICPi) + present(AUTOBNCi) + present(LOCPROi) + present(LOCPROCGAi)
	      + present(LOCDEFPROCGAi) + present(LOCDEFPROi) + present(XHONOAAi) + present(XHONOi)
;

pour i=V,C,P:
PPE_RPROi = positif(PPE_RPRO1i) * arr((1+ PPETXRPRO/100) * PPE_RPRO1i )
           +(1-positif(PPE_RPRO1i)) * arr(PPE_RPRO1i * (1- PPETXRPRO/100));
regle 30550:
application : pro , oceans ,  iliad , batch  ;


PPE_BOOL_SEULPAC = null(V_0CF + V_0CR + V_0DJ + V_0DN + V_0CH + V_0DP -1);

PPE_SALAVDEFU = (somme(i=1,2,3,4: PPE_SALAVDEFi))* PPE_BOOL_SEULPAC;
PPE_KIKEKU = 1 * positif(PPE_SALAVDEF1 )
           + 2 * positif(PPE_SALAVDEF2 )
           + 3 * positif(PPE_SALAVDEF3 )
           + 4 * positif(PPE_SALAVDEF4 );


pour i=V,C:
PPESALi = PPE_SALAVDEFi + PPE_RPROi*(1 - positif(PPE_RPROi)) ;
 
PPESALU = (PPE_SALAVDEFU + PPE_RPROP*(1 - positif(PPE_RPROP)))
          * PPE_BOOL_SEULPAC;


pour i = 1..4:
PPESALi =  PPE_SALAVDEFi * (1 - PPE_BOOL_SEULPAC) ;

regle 30560:
application : pro , oceans ,  iliad , batch  ;

pour i=V,C:
PPE_RTAi = max(0,PPESALi +  PPE_RPROi * positif(PPE_RPROi));


pour i =1..4:
PPE_RTAi = PPESALi;

PPE_RTAU = max(0,PPESALU + PPE_RPROP * positif(PPE_RPROP)) * PPE_BOOL_SEULPAC;
PPE_RTAN = max(0, PPE_RPROP ) * (1 - PPE_BOOL_SEULPAC);
regle 30570:
application : pro , oceans ,  iliad , batch  ;
pour i=V,C:
PPE_BOOL_TPi = positif
             (
                 positif ( PPETPi+0) * positif(PPE_SALAVDEFi+0)
               + null (PPENHi+0) * null(PPETPi+0)* positif(PPE_SALAVDEFi)
               + positif ( 360 / PPENBJ * ( PPENHi*positif(PPE_SALAVDEFi+0) /1820 
                                            + PPENJi*(present(PPE_AVRPRO1i)-(null(PPE_AVRPRO1i)*null(SOMMEAVRPROi-1)*present(BAFi))) /360 ) - 1 )
               + positif_ou_nul (PPENHi*positif(PPE_SALAVDEFi+0) - 1820 )
               + positif_ou_nul (PPENJi*(present(PPE_AVRPRO1i)-(null(PPE_AVRPRO1i)*null(SOMMEAVRPROi-1)*present(BAFi))) - 360 )
               + positif(PPEACi*(present(PPE_AVRPRO1i)-(null(PPE_AVRPRO1i)*null(SOMMEAVRPROi-1)*present(BAFi)))+0)  
               + (1 - positif(PPENJi*(present(PPE_AVRPRO1i)-(null(PPE_AVRPRO1i)*null(SOMMEAVRPROi-1)*present(BAFi)))))
				    *(present(PPE_AVRPRO1i)-(null(PPE_AVRPRO1i)*null(SOMMEAVRPROi-1)*present(BAFi)))
             ) ;

PPE_BOOL_TPU = positif
             (
               (  positif ( PPETPP1 + PPETPP2 + PPETPP3 + PPETPP4) * positif(PPE_SALAVDEF1+PPE_SALAVDEF2+PPE_SALAVDEF3+PPE_SALAVDEF4)
               + null (PPENHP1+PPENHP2+PPENHP3+PPENHP4+0)
                 * null(PPETPP1+PPETPP2+PPETPP3+PPETPP4+0)
                 * positif(PPE_SALAVDEF1+PPE_SALAVDEF2
                          +PPE_SALAVDEF3+PPE_SALAVDEF4)  
               + positif( ( 360 / PPENBJ * ((PPENHP1+PPENHP2+PPENHP3+PPENHP4)*positif(PPE_SALAVDEF1+PPE_SALAVDEF2+PPE_SALAVDEF3+PPE_SALAVDEF4))/1820 + PPENJP*(present(PPE_AVRPRO1P)-(null(PPE_AVRPRO1P)*null(SOMMEAVRPROP-1)*present(BAFP))) /360 ) - 1 )
               + positif_ou_nul (((PPENHP1+PPENHP2+PPENHP3+PPENHP4)*positif(PPE_SALAVDEF1+PPE_SALAVDEF2+PPE_SALAVDEF3+PPE_SALAVDEF4))-1820)
               + positif_ou_nul ( PPENJP*(present(PPE_AVRPRO1P)-(null(PPE_AVRPRO1P)*null(SOMMEAVRPROP-1)*present(BAFP))) - 360 )
               + positif(PPEACP*(present(PPE_AVRPRO1P)-(null(PPE_AVRPRO1P)*null(SOMMEAVRPROP-1)*present(BAFP))))  
               + (1 - positif(PPENJP*(present(PPE_AVRPRO1P)-(null(PPE_AVRPRO1P)*null(SOMMEAVRPROP-1)*present(BAFP)))))
			  *(present(PPE_AVRPRO1P)-(null(PPE_AVRPRO1P)*null(SOMMEAVRPROP-1)*present(BAFP)))) 
          * PPE_BOOL_SEULPAC
              );


pour i =1,2,3,4:
PPE_BOOL_TPi = positif  
             (   positif ( PPETPPi) * positif(PPE_SALAVDEFi+0)
              + null (PPENHPi+0) * null(PPETPPi+0)* positif(PPE_SALAVDEFi)  
              + positif_ou_nul ( 360 / PPENBJ * PPENHPi*positif(PPE_SALAVDEFi+0) - 1820 )
             );

PPE_BOOL_TPN= positif 
             (
                positif_ou_nul ( 360 / PPENBJ * PPENJP*(present(PPE_AVRPRO1P)-(null(PPE_AVRPRO1P)*null(SOMMEAVRPROP-1)*present(BAFP))) - 360 )
              + positif(PPEACP*(present(PPE_AVRPRO1P)-(null(PPE_AVRPRO1P)*null(SOMMEAVRPROP-1)*present(BAFP))))  
              + (1 - positif(PPENJP*(present(PPE_AVRPRO1P)-(null(PPE_AVRPRO1P)*null(SOMMEAVRPROP-1)*present(BAFP)))))
		   *(present(PPE_AVRPRO1P)-(null(PPE_AVRPRO1P)*null(SOMMEAVRPROP-1)*present(BAFP)))
             ) ;

regle 30580:
application : pro , oceans ,  iliad , batch  ;


pour i =V,C:
PPE_COEFFi =  PPE_BOOL_TPi * 360/  PPENBJ
             +  ( 1 -  PPE_BOOL_TPi)  / (PPENHi*positif(PPE_SALAVDEFi+0) /1820 + PPENJi*(present(PPE_AVRPRO1i)-(null(PPE_AVRPRO1i)*null(SOMMEAVRPROi-1)*present(BAFi))) /360);

PPE_COEFFU =       PPE_BOOL_TPU * 360/  PPENBJ
       	     +  ( 1 -  PPE_BOOL_TPU)  / 
               ((PPENHP1+PPENHP2+PPENHP3+PPENHP4)/1820 + PPENJP*(present(PPE_AVRPRO1P)-(null(PPE_AVRPRO1P)*null(SOMMEAVRPROP-1)*present(BAFP))) /360)
          * PPE_BOOL_SEULPAC;


pour i =1..4:
PPE_COEFFi =       PPE_BOOL_TPi * 360/  PPENBJ
       	     +  ( 1 -  PPE_BOOL_TPi)  / (PPENHPi*positif(PPE_SALAVDEFi+0) /1820 );


PPE_COEFFN =       PPE_BOOL_TPN * 360/  PPENBJ
     	     +  ( 1 -  PPE_BOOL_TPN)  / (PPENJP*(present(PPE_AVRPRO1P)-(null(PPE_AVRPRO1P)*null(SOMMEAVRPROP-1)*present(BAFP))) /360);


 
pour i= V,C,1,2,3,4,U,N:
PPE_RCONTPi = arr (  PPE_RTAi * PPE_COEFFi ) ;


regle 30590:
application : pro , oceans ,  iliad , batch  ;

pour i=V,C,U,N,1,2,3,4:
PPE_BOOL_MINi = positif_ou_nul (PPE_RTAi- PPELIMRPB) * (1 - PPE_BOOL_NADAi);

regle 30600:
application : pro , oceans ,  iliad , batch  ;

INDMONO =  BOOL_0AM 
            * (
                   positif_ou_nul(PPE_RTAV  - PPELIMRPB)
                 * positif(PPELIMRPB - PPE_RTAC)
               +
                   positif_ou_nul(PPE_RTAC - PPELIMRPB )
                   *positif(PPELIMRPB - PPE_RTAV)
               );

regle 30605:
application : pro , oceans ,  iliad , batch  ;
PPE_HAUTE = PPELIMRPH * (1 - BOOL_0AM)
          + PPELIMRPH * BOOL_0AM * null(INDMONO)
                      * positif_ou_nul(PPE_RCONTPV - PPELIMRPB)
                      * positif_ou_nul(PPE_RCONTPC - PPELIMRPB)
          + PPELIMRPH2 * INDMONO;

regle 30610:
application : pro , oceans ,  iliad , batch  ;

pour i=V,C:
PPE_BOOL_MAXi = positif_ou_nul(PPE_HAUTE - PPE_RCONTPi);

pour i=U,N,1,2,3,4:
PPE_BOOL_MAXi = positif_ou_nul(PPELIMRPH - PPE_RCONTPi);

regle 30615:
application : pro , oceans ,  iliad , batch  ;

pour i = V,C,U,N,1,2,3,4:
PPE_FORMULEi =  PPE_BOOL_KIR_COND
               *PPE_BOOL_ACT_COND
               *PPE_BOOL_MINi
               *PPE_BOOL_MAXi
               *arr(positif_ou_nul(PPELIMSMIC - PPE_RCONTPi)
                     * arr(PPE_RCONTPi * PPETX1/100)/PPE_COEFFi
                    +
                        positif(PPE_RCONTPi - PPELIMSMIC)
                      * positif_ou_nul(PPELIMRPH - PPE_RCONTPi )
                      * arr(arr((PPELIMRPH  - PPE_RCONTPi ) * PPETX2 /100)/PPE_COEFFi)
                    +
                      positif(PPE_RCONTPi - PPELIMRPHI)
                      * positif_ou_nul(PPE_HAUTE - PPE_RCONTPi )
                      * arr(arr((PPELIMRPH2 - PPE_RCONTPi ) * PPETX3 /100)/PPE_COEFFi)
                   );


regle 30620:
application : pro , oceans ,  iliad , batch  ;


pour i =V,C:

PPE_COEFFCONDi = (1 - PPE_BOOL_TPi)
               * (   null(PPENBJ - 360) * PPE_COEFFi
                  +
                    (1 - null(PPENBJ - 360)) 
                          * (    PPENBJ * 1820/360 
                                      /
                                (PPENHi*positif(PPE_SALAVDEFi+0) + PPENJi*(present(PPE_AVRPRO1i)-(null(PPE_AVRPRO1i)*null(SOMMEAVRPROi-1)*present(BAFi))) * 1820/360)
                            )
                 );

pour i =U,N:
PPE_COEFFCONDi = (1 - PPE_BOOL_TPi)
               * (   null(PPENBJ - 360) * PPE_COEFFi
                  +
                    (1 - null(PPENBJ - 360)) 
                       * ( PPENBJ * 1820/360
                                        /
                          ((PPENHP1+PPENHP2+PPENHP3+PPENHP4) + PPENJP*(present(PPE_AVRPRO1P)-(null(PPE_AVRPRO1P)*null(SOMMEAVRPROP-1)*present(BAFP))) * 1820/360))
                 );
pour i =1,2,3,4:
PPE_COEFFCONDi = (1 - PPE_BOOL_TPi)
               * (  null(PPENBJ - 360) * PPE_COEFFi
                  + (1 - null(PPENBJ - 360)) 
                          * (    PPENBJ * 1820/360 
                                      /
                                (PPENHPi*positif(PPE_SALAVDEFi+0) + PPENJP*(present(PPE_AVRPRO1P)-(null(PPE_AVRPRO1P)*null(SOMMEAVRPROP-1)*present(BAFP))) * 1820/360)
                            )
                 );

pour i =V,C,U,1,2,3,4,N:
PPENARPRIMEi =   PPE_FORMULEi * ( 1 + PPETXMAJ2)
               * positif_ou_nul(PPE_COEFFCONDi - 2)
               * (1 - PPE_BOOL_TPi)

              +  (arr(PPE_FORMULEi * PPETXMAJ1) + arr(PPE_FORMULEi * (PPE_COEFFi * PPETXMAJ2 )))
               * positif (2 - PPE_COEFFCONDi)
               * positif (PPE_COEFFCONDi  -1 )
               * (1 - PPE_BOOL_TPi)

              + PPE_FORMULEi  * positif(PPE_BOOL_TPi + positif_ou_nul (1 - PPE_COEFFCONDi))  ; 


regle 30625:
application : pro , oceans ,  iliad , batch  ;
pour i =V,C,U,1,2,3,4,N:
PPEPRIMEi =arr( PPENARPRIMEi) ;

PPEPRIMEPAC = PPEPRIMEU + PPEPRIME1 + PPEPRIME2 + PPEPRIME3 + PPEPRIME4 + PPEPRIMEN ;


PPEPRIMETTEV = PPE_BOOL_KIR_COND *  PPE_BOOL_ACT_COND 
               *(
                    ( PPE_PRIMETTE
                      * BOOL_0AM
                      * INDMONO
                      *  positif_ou_nul (PPE_RTAV - PPELIMRPB)
                      *  positif_ou_nul(PPELIMRPHI - PPE_RCONTPV)
                      *  (1 - positif(PPE_BOOL_NADAV))
                     )
                   ) 
               * ( 1 - positif(V_PPEISF + PPEISFPIR+PPEREVPRO))    
               * ( 1 -  V_CNR);
                     
PPEPRIMETTEC =  PPE_BOOL_KIR_COND *  PPE_BOOL_ACT_COND 
                *(
                     ( PPE_PRIMETTE
                      * BOOL_0AM
                      * INDMONO
                      *  positif_ou_nul(PPELIMRPHI - PPE_RCONTPC)
                      *  positif_ou_nul (PPE_RTAC - PPELIMRPB)
                      *  (1 - positif(PPE_BOOL_NADAC))
                      )
                    )
               * ( 1 - positif(V_PPEISF + PPEISFPIR+PPEREVPRO))    
               * ( 1 -  V_CNR);
PPEPRIMETTE = PPEPRIMETTEV + PPEPRIMETTEC ;




regle 30800:
application : pro , oceans ,  iliad , batch  ;

BOOLENF = positif(V_0CF + V_0CH + V_0DJ + V_0CR + 0) ;

PPE_NB_PAC= V_0CF + V_0CR + V_0DJ + V_0DN  ;
PPE_NB_PAC_QAR =  V_0CH + V_0DP ;
TOTPAC = PPE_NB_PAC + PPE_NB_PAC_QAR;



PPE_NBNONELI = ( 
                        somme(i=1,2,3,4,U,N: positif(PPEPRIMEi))
                      + somme(i=1,2,3,4,U,N: positif_ou_nul(PPE_RTAi - PPELIMRPB) 
                                           * positif(PPE_RCONTPi - PPELIMRPH)
                              )
                  );
  



PPE_NBELIGI = PPE_NB_PAC + PPE_NB_PAC_QAR - PPE_NBNONELI;


PPE_BOOL_BT = V_0BT * positif(2 - V_0AV - BOOLENF) ;

PPE_BOOL_MAJO = (1 - PPE_BOOL_BT)
               * positif (  positif_ou_nul (PPELIMRPH - PPE_RCONTPV)
                           *positif_ou_nul (PPE_RTAV - PPELIMRPB)
                           *(1 - positif(PPE_BOOL_NADAV))
                          +
                            positif_ou_nul (PPELIMRPH - PPE_RCONTPC)
                           *positif_ou_nul (PPE_RTAC - PPELIMRPB)
                           *(1 - positif(PPE_BOOL_NADAC))
                          )
                        ;
PPE_NBMAJO =    positif_ou_nul (PPE_NB_PAC - PPE_NBELIGI)
                 *PPE_NBELIGI
               + (1 - positif_ou_nul (PPE_NB_PAC - PPE_NBELIGI))
               *  PPE_NB_PAC ;
PPE_NBMAJOQAR =    positif_ou_nul (PPE_NB_PAC - PPE_NBELIGI)
                 * 0
               + (1 - positif_ou_nul (PPE_NB_PAC - PPE_NBELIGI))
                 * ( PPE_NBELIGI - PPE_NB_PAC ) ;




PPE_MAJO =   PPE_BOOL_MAJO 
           * positif( PPE_NBELIGI )
           * ( PPE_NBMAJO * PPEMONMAJO
             + PPE_NBMAJOQAR * PPEMONMAJO / 2
             );

regle 30810:
application : pro , oceans ,  iliad , batch  ;


PPE_BOOL_MONO =  (1 - PPE_BOOL_MAJO )
                *  (1 - PPE_BOOL_MAJOBT)
                * positif( PPE_NB_PAC + PPE_NB_PAC_QAR - PPE_NBNONELI)
                * INDMONO
                *( ( positif( PPE_BOOL_BT + BOOL_0AM )
                    *  positif_ou_nul (PPE_RTAV - PPELIMRPB)
                    *  positif_ou_nul (PPELIMRPH2 - PPE_RCONTPV)
                    *  (1 - positif(PPE_BOOL_NADAV))
                   )
                 + (  positif(  BOOL_0AM )
                    *  positif_ou_nul (PPE_RTAC - PPELIMRPB)
                    *  positif_ou_nul (PPELIMRPH2 - PPE_RCONTPC)
                    *  (1 - positif(PPE_BOOL_NADAC))
                  )
                 );
PPE_MONO = PPE_BOOL_MONO * ( 1 + PPE_BOOL_BT)
          *( positif( PPE_NBMAJO) * PPEMONMAJO 
            + 
             null( PPE_NBMAJO)*positif(PPE_NBMAJOQAR) * PPEMONMAJO / 2
           )
           ;


regle 30820:
application : pro , oceans ,  iliad , batch  ;


PPE_BOOL_MAJOBT = positif (  positif_ou_nul (PPELIMRPH - PPE_RCONTPV)
                            *positif_ou_nul (PPE_RTAV - PPELIMRPB)
                            *(1 - positif(PPE_BOOL_NADAV))
                          )
                * PPE_BOOL_BT;

PPE_MABT =   PPE_BOOL_MAJOBT
           * positif( PPE_NBMAJO)
           * (( PPE_NBMAJO + 1) * PPEMONMAJO
             + PPE_NBMAJOQAR * PPEMONMAJO / 2
             )
         +   PPE_BOOL_MAJOBT
           * null( PPE_NBMAJO + 0)*positif(PPE_NBMAJOQAR)
           * (  positif(PPE_NBMAJOQAR-1) *  PPE_NBMAJOQAR * PPEMONMAJO / 2
                + PPEMONMAJO 
             )
          +  positif_ou_nul (PPELIMRPH2 - PPE_RCONTPV)
           * positif_ou_nul (PPE_RTAV - PPELIMRPB)
           * (1 - PPE_BOOL_MAJOBT)
           * (1 - positif(PPE_BOOL_NADAV))
           * PPE_BOOL_BT
           * ( positif( PPE_NB_PAC) * 2 * PPEMONMAJO
             + positif( PPE_NB_PAC_QAR ) * null ( PPE_NB_PAC + 0 ) * PPEMONMAJO
             )
            ;

                 
regle 30830:
application : pro , oceans ,  iliad , batch  ;
PPEMAJORETTE =   PPE_BOOL_KIR_COND
               * PPE_BOOL_ACT_COND
               * arr ( PPE_MONO + PPE_MAJO + PPE_MABT )
               * ( 1 - positif(V_PPEISF + PPEISFPIR+PPEREVPRO))    
               * ( 1 -  V_CNR);

regle 30900:
application : pro , oceans ,  iliad , batch  ;

PPETOT = positif ( somme(i=V,C,U,1,2,3,4,N:PPENARPRIMEi)
                   +PPEPRIMETTE
                   +PPEMAJORETTE +0

 
                   +somme(i=V,C,U,1,2,3,4,N :( 1 - positif(PPELIMRPH - PPE_RCONTPi - 10))
                     *  PPE_BOOL_KIR_COND
                     *  PPE_BOOL_ACT_COND
                     *  PPE_BOOL_MINi
                     *  PPE_BOOL_MAXi)
                   +somme(i=V,C,U,1,2,3,4,N :( 1 - positif(PPELIMRPH2 - PPE_RCONTPi - 10))
                     *  PPE_BOOL_KIR_COND
                     *  PPE_BOOL_ACT_COND
                     *  PPE_BOOL_MINi
                     *  PPE_BOOL_MAXi)

           )
        
           * max(0,arr( (somme(i=V,C,U,1,2,3,4,N :PPEPRIMEi)
                                +PPEPRIMETTE
                                +PPEMAJORETTE
                        ) 
                      )
                 )
           * positif_ou_nul(arr( (somme(i=V,C,U,1,2,3,4,N :PPEPRIMEi)
                                +PPEPRIMETTE
                                +PPEMAJORETTE
				- PPELIMTOT                  )) 
                           )
       * ( 1 - positif(V_PPEISF + PPEISFPIR+PPEREVPRO))    
       * ( 1 -  V_CNR);

regle 30910:
application : iliad , batch ;
PPENATREST = positif(IRE) * positif(IREST) * 
           (
            (1 - null(2 - V_REGCO))  *
            (
             ( null(IRE - PPETOT + PPERSA) * 1                                              * 1
             + (1 - positif(PPETOT-PPERSA))                                                 * 2 
             + null(IRE) * (1 - positif(PPETOT-PPERSA))                                     * 3 
	     + positif(PPETOT-PPERSA) * positif(IRE-PPETOT+PPERSA)                          * 4
             )
	    )
           + 2 * null(2 - V_REGCO) 
           )
            ;

PPERESTA = positif(PPENATREST) * max(0,min(IREST , PPETOT-PPERSA)) ;

PPENATIMPA = positif(PPETOT-PPERSA) * (positif(IINET - PPETOT + PPERSA - ICREREVET) + positif( PPETOT - PPERSA - PPERESTA));

PPEIMPA = positif(PPENATIMPA) * positif_ou_nul(PPERESTA) * (PPETOT - PPERSA - PPERESTA) ;

PPENATREST2 = (positif(IREST - V_ANTRE + V_ANTIR) + positif(V_ANTRE - IINET)) * positif(IRE) *
             (
              (1 - null(2 - V_REGCO))  *
               (
                ( null(IRE - PPETOT + PPERSA) * 1                                              * 1
                + (1 - positif(PPETOT-PPERSA))                                                 * 2 
                + null(IRE) * (1 - positif(PPETOT-PPERSA))                                     * 3 
	        + positif(PPETOT-PPERSA) * positif(IRE-PPETOT+PPERSA)                          * 4
                )
	       )
              + 2 * null(2 - V_REGCO) 
             )
            ;

PPEREST2A = positif(PPENATREST2) * (max(0,min(IREST - V_ANTRE + V_ANTIR , PPETOT-PPERSA)) + max(0,min(V_ANTRE - IINET , PPETOT-PPERSA))) ; 

PPEIMP2A = positif_ou_nul(PPEREST2A) * (PPETOT - PPERSA - PPEREST2A) ;

regle 30912:
application : iliad , batch,pro  ;

pour i=V,C,1,2,3,4,N,U:
PPETEMPSi = arr(1 / PPE_COEFFi * 100) ;




pour i=V,C,1,2,3,4,N,U:
PPECOEFFi= arr(PPE_COEFFCONDi * 100 );
regle 990:
application : iliad, batch, pro, oceans ;

REST = positif(IRE) * positif(IREST) ;

LIBREST = positif(REST) * max(0,min(AUTOVERSLIB , IREST-(PPETOT-PPERSA))) ;

LIBIMP = positif_ou_nul(LIBREST) * (AUTOVERSLIB - LIBREST) ;

LOIREST = positif(REST) * max(0,min(CILOYIMP , IREST-(PPETOT-PPERSA)-AUTOVERSLIB)) ;

LOIIMP = positif_ou_nul(LOIREST) * (CILOYIMP - LOIREST) ;

TABREST = positif(REST) * max(0,min(CIDEBITTABAC , IREST-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP)) ;

TABIMP = positif_ou_nul(TABREST) * (CIDEBITTABAC - TABREST) ;

TAUREST = positif(REST) * max(0,min(CRERESTAU , IREST-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC)) ;

TAUIMP = positif_ou_nul(TAUREST) * (CRERESTAU - TAUREST) ;

AGRREST = positif(REST) * max(0,min(CICONGAGRI , IREST-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU)) ;

AGRIMP = positif_ou_nul(AGRREST) * (CICONGAGRI - AGRREST) ;

ARTREST = positif(REST) * max(0,min(CREARTS , IREST-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI)) ;

ARTIMP = positif_ou_nul(ARTREST) * (CREARTS - ARTREST) ;

INTREST = positif(REST) * max(0,min(CREINTERESSE , IREST-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS)) ;

INTIMP = positif_ou_nul(INTREST) * (CREINTERESSE - INTREST) ;

FORREST = positif(REST) * max(0,min(CREFORMCHENT , IREST-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE)) ;

FORIMP = positif_ou_nul(FORREST) * (CREFORMCHENT - FORREST) ;

PROREST = positif(REST) * max(0,min(CREPROSP , IREST-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
						-CREFORMCHENT)) ;

PROIMP = positif_ou_nul(PROREST) * (CREPROSP - PROREST) ;

BIOREST = positif(REST) * max(0,min(CREAGRIBIO , IREST-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
						 -CREFORMCHENT-CREPROSP)) ;

BIOIMP = positif_ou_nul(BIOREST) * (CREAGRIBIO - BIOREST) ;

APPREST = positif(REST) * max(0,min(CREAPP , IREST-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
					     -CREFORMCHENT-CREPROSP-CREAGRIBIO)) ;

APPIMP = positif_ou_nul(APPREST) * (CREAPP - APPREST) ;

FAMREST = positif(REST) * max(0,min(CREFAM , IREST-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
					     -CREFORMCHENT-CREPROSP-CREAGRIBIO-CREAPP)) ;

FAMIMP = positif_ou_nul(FAMREST) * (CREFAM - FAMREST) ;

HABREST = positif(REST) * max(0,min(CIHABPRIN , IREST-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
						-CREFORMCHENT-CREPROSP-CREAGRIBIO-CREAPP-CREFAM)) ;

HABIMP = positif_ou_nul(HABREST) * (CIHABPRIN - HABREST) ;

SALREST = positif(REST) * max(0,min(CIADCRE , IREST-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
                                              -CREFORMCHENT-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN)) ;

SALIMP = positif_ou_nul(SALREST) * (CIADCRE - SALREST) ;

PREREST = positif(REST) * max(0,min(CIPRETUD , IREST-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
					       -CREFORMCHENT-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIADCRE)) ;

PREIMP = positif_ou_nul(PREREST) * (CIPRETUD - PREREST) ;

GARREST = positif(REST) * max(0,min(CIGARD , IREST-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
					     -CREFORMCHENT-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIADCRE-CIPRETUD)) ;

GARIMP = positif_ou_nul(GARREST) * (CIGARD - GARREST) ;

BAIREST = positif(REST) * max(0,min(CICA , IREST-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
					   -CREFORMCHENT-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIADCRE-CIPRETUD-CIGARD)) ;
 
BAIIMP = positif_ou_nul(BAIREST) * (CICA - BAIREST) ;

ELUREST = positif(REST) * max(0,min(IPELUS , IREST-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
					     -CREFORMCHENT-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIADCRE-CIPRETUD-CIGARD-CICA)) ;
 
ELUIMP = positif_ou_nul(ELUREST) * (IPELUS - ELUREST) ;

TECREST = positif(REST) * max(0,min(CITEC , IREST-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
					    -CREFORMCHENT-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIADCRE-CIPRETUD-CIGARD-CICA-IPELUS)) ;

TECIMP = positif_ou_nul(TECREST) * (CITEC - TECREST) ;

DELREST = positif(REST) * max(0,min(CIDEDUBAIL , IREST-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
						 -CREFORMCHENT-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIADCRE-CIPRETUD-CIGARD-CICA-IPELUS-CITEC)) ;

DELIMP = positif_ou_nul(DELREST) * (CIDEDUBAIL - DELREST) ;

DEPREST = positif(REST) * max(0,min(CIDEVDUR , IREST-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
					       -CREFORMCHENT-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIADCRE-CIPRETUD-CIGARD-CICA-IPELUS-CITEC
					       -CIDEDUBAIL)) ;

DEPIMP = positif_ou_nul(DEPREST) * (CIDEVDUR - DEPREST) ;

AIDREST = positif(REST) * max(0,min(CIGE , IREST-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
					   -CREFORMCHENT-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIADCRE-CIPRETUD-CIGARD-CICA-IPELUS-CITEC
					   -CIDEDUBAIL-CIDEVDUR)) ;

AIDIMP = positif_ou_nul(AIDREST) * (CIGE - AIDREST) ;

ASSREST = positif(REST) * max(0,min(I2DH , IREST-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
					   -CREFORMCHENT-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIADCRE-CIPRETUD-CIGARD-CICA-IPELUS-CITEC
					   -CIDEDUBAIL-CIDEVDUR-CIGE)) ;

ASSIMP = positif_ou_nul(ASSREST) * (I2DH - ASSREST) ;

EPAREST = positif(REST) * max(0,min(DIREPARGNE , IREST-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
						 -CREFORMCHENT-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIADCRE-CIPRETUD-CIGARD-CICA-IPELUS-CITEC
						 -CIDEDUBAIL-CIDEVDUR-CIGE-I2DH)) ;

EPAIMP = positif_ou_nul(EPAREST) * (DIREPARGNE - EPAREST) ;

PERREST = positif(REST) * max(0,min(CIPERT , IREST-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
					     -CREFORMCHENT-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIADCRE-CIPRETUD-CIGARD-CICA-IPELUS-CITEC
					     -CIDEDUBAIL-CIDEVDUR-CIGE-I2DH-DIREPARGNE)) ;

PERIMP = positif_ou_nul(PERREST) * (CIPERT - PERREST) ;

RECREST = positif(REST) * max(0,min(IPRECH , IREST-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
					     -CREFORMCHENT-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIADCRE-CIPRETUD-CIGARD-CICA-IPELUS-CITEC
					     -CIDEDUBAIL-CIDEVDUR-CIGE-I2DH-DIREPARGNE-CIPERT)) ;

RECIMP = positif_ou_nul(RECREST) * (IPRECH - RECREST) ;

