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
  ####   #    #    ##    #####      #     #####  #####   ######      #    
 #    #  #    #   #  #   #    #     #       #    #    #  #           #    #
 #       ######  #    #  #    #     #       #    #    #  #####       #    #
 #       #    #  ######  #####      #       #    #####   #           ######
 #    #  #    #  #    #  #          #       #    #   #   #                #
  ####   #    #  #    #  #          #       #    #    #  ######           #
regle 401:
application : bareme, iliad , batch  ;
IRB = IAMD2; 
IRB2 = IAMD2 + TAXASSUR + IPCAPTAXTOT + TAXLOY + CHRAPRES;
regle 40101:
application : iliad , batch  ;
KIR =   IAMD3 ;
regle 4011:
application : bareme , iliad , batch  ;
IAMD1 = IBM13 ;
IAMD2 = IBM23 ;
IAMD2TH = positif_ou_nul(IBM23 - SEUIL_61)*IBM23;
regle 40110:
application : bareme , iliad , batch  ;
IAMD3 = IBM33 - min(ACP3, IMPIM3);
regle 402112:
application : iliad , batch  ;
ANG3 = IAD32 - IAD31;
regle 40220:
application : iliad , batch  ;
ACP3 = max (0 ,
 somme (a=1..4: min(arr(CHENFa * TX_DPAEAV/100) , SEUIL_AVMAXETU)) - ANG3)
        * (1 - positif(V_CR2 + IPVLOC)) * positif(ANG3) * positif(IMPIM3);
regle 403:
application : bareme ,iliad , batch  ;

IBM13 = IAD11 + ITP + REI + AUTOVERSSUP + TAXASSUR + IPCAPTAXTOT  + TAXLOY + CHRAPRES + AVFISCOPTER ;

IBM23 = IAD11 + ITP + REI + AUTOVERSSUP + AVFISCOPTER ;

regle 404:
application : bareme , iliad , batch  ;
IBM33 = IAD31 + ITP + REI;
regle 4041:
application : iliad , batch  ;
DOMITPD = arr(BN1 + SPEPV + BI12F + BA1) * (TX11/100) * positif(V_EAD);
DOMITPG = arr(BN1 + SPEPV + BI12F + BA1) * (TX09/100) * positif(V_EAG);
DOMAVTD = arr((BN1 + SPEPV + BI12F + BA1) * TX05/100) * positif(V_EAD);
DOMAVTG = arr((BN1 + SPEPV + BI12F + BA1) * TX07/100) * positif(V_EAG);
DOMAVTO = DOMAVTD + DOMAVTG;
DOMABDB = max(PLAF_RABDOM - ABADO , 0) * positif(V_EAD)
          + max(PLAF_RABGUY - ABAGU , 0) * positif(V_EAG);
DOMDOM = max(DOMAVTO - DOMABDB , 0) * positif(V_EAD + V_EAG);
ITP = arr((BPTP2 * TX225/100) 
       + (BPTPVT * TX19/100) 
       + (BPTP4 * TX30/100) 
       +  DOMITPD + DOMITPG
       + (BPTP3 * TX16/100) 
       + (BPTP40 * TX41/100)
       + DOMDOM * positif(V_EAD + V_EAG)
       + (BPTP18 * TX18/100)
       + (BPTPSJ * TX19/100)
       + (BPTPWG * TX19/100)
       + (BPTPWJ * TX19/100)
       + (BPTP24 * TX24/100)
	  )
       * (1-positif(IPVLOC)) * (1 - positif(present(TAX1649)+present(RE168))); 
regle 40412:
application : iliad , batch  ;
REVTP = BPTP2 +BPTPVT+BPTP4+BTP3A+BPTP40+ BPTP24+BPTP18 +BPTPSJ +BPTPWG + BPTPWJ;
regle 40413:
application : iliad , batch  ;
BTP3A = (BN1 + SPEPV + BI12F + BA1) * (1 - positif( IPVLOC ));
BPTPD = BTP3A * positif(V_EAD)*(1-positif(present(TAX1649)+present(RE168)));
BPTPG = BTP3A * positif(V_EAG)*(1-positif(present(TAX1649)+present(RE168)));
BPTP3 = BTP3A * (1 - positif(V_EAD + V_EAG))*(1-positif(present(TAX1649)+present(RE168)));
BTP3N = (BPVKRI) * (1 - positif( IPVLOC ));
BTP3G = (BPVRCM) * (1 - positif( IPVLOC ));
BTP2 = PEA * (1 - positif( IPVLOC ));
BPTP2 = BTP2*(1-positif(present(TAX1649)+present(RE168)));
BTPVT = GAINPEA * (1 - positif( IPVLOC ));
BPTPVT = BTPVT*(1-positif(present(TAX1649)+present(RE168)));

BTP18 = (BPV18V + BPV18C) * (1 - positif( IPVLOC ));
BPTP18 = BTP18 * (1-positif(present(TAX1649)+present(RE168))) ;

BPTP4 = (BPCOPTV + BPCOPTC + BPVSK) * (1 - positif(IPVLOC)) * (1 - positif(present(TAX1649) + present(RE168))) ;
BPTP4I = (BPCOPTV + BPCOPTC) * (1 - positif(IPVLOC)) * (1 - positif(present(TAX1649) + present(RE168))) ;
BTPSK = BPVSK * (1 - positif( IPVLOC ));
BPTPSK = BTPSK * (1-positif(present(TAX1649)+present(RE168))) ;

BTP40 = (BPV40V + BPV40C) * (1 - positif( IPVLOC )) ;
BPTP40 = BTP40 * (1-positif(present(TAX1649)+present(RE168))) ;

BTP5 = PVIMPOS * (1 - positif( IPVLOC ));
BPTP5 = BTP5 * (1-positif(present(TAX1649)+present(RE168))) ;
BPTPWG = PVSURSIWG * (1 - positif( IPVLOC ))* (1-positif(present(TAX1649)+present(RE168)));
BPTPWJ = COD3WJ * (1 - positif( IPVLOC ))* (1-positif(present(TAX1649)+present(RE168)));
BTPSJ = BPVSJ * (1 - positif( IPVLOC ));
BPTPSJ = BTPSJ * (1-positif(present(TAX1649)+present(RE168))) ;
BTPSB = PVTAXSB * (1 - positif( IPVLOC ));
BPTPSB = BTPSB * (1-positif(present(TAX1649)+present(RE168))) ;
BPTP19 = (BPVSJ + GAINPEA + PVSURSIWG + COD3WJ) * (1 - positif( IPVLOC )) * (1 - positif(present(TAX1649) + present(RE168))) ;
BPTP19WGWJ = (PVSURSIWG + COD3WJ) * (1 - positif( IPVLOC )) * (1 - positif(present(TAX1649) + present(RE168))) ;
BPTP24 = RCM2FA *(1-positif(present(TAX1649)+present(RE168))) * (1 - positif(null(2-V_REGCO) + null(4-V_REGCO)));
ITPRCM = arr(BPTP24 * TX24/100);

BPTPDIV = BTP5 * (1-positif(present(TAX1649)+present(RE168))) ;

regle 4042:
application : iliad , batch  ;


REI = IPREP+IPPRICORSE;

regle 40421:
application : iliad , batch  ;


PPERSATOT = RSAFOYER + RSAPAC1 + RSAPAC2 ;

PPERSA = min(PPETOTX , PPERSATOT) * (1 - V_CNR) ;

PPEFINAL = PPETOTX - PPERSA ;

regle 405:
application : bareme , iliad , batch  ;


IAD11 = ( max(0,IDOM11-DEC11-RED) *(1-positif(V_CR2+IPVLOC))
        + positif(V_CR2+IPVLOC) *max(0 , IDOM11 - RED) )
                                * (1-positif(RE168+TAX1649))
        + positif(RE168+TAX1649) * IDOM16;
regle 40510:
application : bareme , iliad , batch  ;
IREXITI = (present(FLAG_EXIT) * ((1-positif(FLAG_3WBNEG)) * abs(NAPTIR - V_NAPTIR3WB) 
           + positif(FLAG_3WBNEG) * abs(NAPTIR + V_NAPTIR3WB)) * positif(present(PVIMPOS) + present(COD3WI)))
          * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

IREXITI19 = ((PVSURSIWG + COD3WJ) * TX19/100) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

IREXITS = ((1-positif(FLAG_3WANEG)) * abs(V_NAPTIR3WA-NAPTIR) 
           + positif(FLAG_3WANEG) * abs(-V_NAPTIR3WA - NAPTIR)) * present(FLAG_EXIT) * present(PVSURSI)
          * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

IREXITS19 = (PVSURSIWF * TX19/100) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

IREXIT = IREXITI + IREXITS ;

EXITTAX3 = ((positif(FLAG_3WBNEG) * (-1) * ( V_NAPTIR3WB) + (1-positif(FLAG_3WBNEG)) * (V_NAPTIR3WB)) * positif(present(PVIMPOS)+present(COD3WI))
            + NAPTIR * present(PVSURSI) * (1-positif(present(PVIMPOS)+present(COD3WI))))
           * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;
regle 406:
application : bareme , iliad , batch  ;
IAD31 = ((IDOM31-DEC31)*(1-positif(V_CR2+IPVLOC)))
        +(positif(V_CR2+IPVLOC)*IDOM31);
IAD32 = ((IDOM32-DEC32)*(1-positif(V_CR2+IPVLOC)))
        +(positif(V_CR2+IPVLOC)*IDOM32);

regle 4052:
application : bareme , iliad , batch  ;

IMPIM3 =  IAD31 ;

regle 4061:
application : bareme , iliad , batch  ;
pour z = 1,2:
DEC1z = min (max( arr(SEUIL_DECOTE/2 - (IDOM1z/2)),0),IDOM1z) * (1 - V_CNR);

pour z = 1,2:
DEC3z = min (max( arr(SEUIL_DECOTE/2 - (IDOM3z/2)),0),IDOM3z) * (1 - V_CNR);

DEC6 = min (max( arr(SEUIL_DECOTE/2 - (IDOM16/2)),0),IDOM16) * (1 - V_CNR);

regle 407:
application : iliad   , batch ;
      
RED =  RCOTFOR + RSURV + RCOMP + RHEBE + RREPA + RDIFAGRI + RDONS
       + RDUFLOGIH
       + RCELTOT
       + RRESTIMO * (1-V_INDTEO)  + V_RRESTIMOXY * V_INDTEO
       + RFIPC + RFIPDOM + RAIDE + RNOUV 
       + RTOURREP 
       + RTOUREPA + RTOUHOTR  
       + RLOGDOM + RLOGSOC + RDOMSOC1 + RLOCENT + RCOLENT
       + RRETU + RINNO + RRPRESCOMP + RFOR 
       + RSOUFIP + RRIRENOV + RSOCREPR + RRESIMEUB + RRESINEUV + RRESIVIEU 
       + RLOCIDEFG + RCODJT + RCODJU
       + RREDMEUB + RREDREP + RILMIX + RILMIY + RINVRED + RILMIH + RILMJC
       + RILMIZ + RILMJI + RILMJS + RMEUBLE + RPROREP + RREPNPRO + RREPMEU 
       + RILMIC + RILMIB + RILMIA + RILMJY + RILMJX + RILMJW + RILMJV
       + RIDOMPROE3   
       + RPATNAT1 + RPATNAT2 + RPATNAT3 + RPATNAT
       + RFORET + RCREAT + RCINE  
       + RREVMOD ;

REDTL = ASURV + ACOMP ;

CIMPTL = ATEC + ADEVDUR + ADEPENV + TOTBGE ;

RED_AVT_DS =
ACOTFOR * TX76/100 + RRS + RFC + RAH + RAA + RAGRI +RON +RDUFLO_GIH
+ somme (i=A,B,E,M,C,D,S,F,Z : ACELRREDLi) + ACELRREDMG
+somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : ACELREPHi)
+ somme (i=U,X,T,S,W,P,L,V,K,J : ACELREPGi )
+ RCEL_HM + RCEL_HL + RCEL_HNO + RCEL_HJK + RCEL_NQ + RCEL_NBGL + RCEL_COM
+ RCEL_2011 + RCEL_JP + RCEL_JBGL + RCEL_JOQR + RCEL_2012 + RCEL_FD + RCEL_FABC
+ RETRESTIMO + RFIPCORSE + RFIPDOMCOM + RAD + RSN
+ ATOURREP * TX_REDIL25 / 100 + ATOUREPA * TX_REDIL20 / 100 + RIHOTR
+ somme (i=1..9 : RLOGi) + somme (i=10..32 : RLOGi) + somme (i=1..8 : RSOCi) 
+ RSOC9 + somme (i=10..28 : RSOCi)
+ somme (i=1..9 : RENTi) + somme (i=10..36 : RENTi) 
+ somme (i=1..9 : RLOCi) + somme (i=10..88 : RLOCi)
+ RETUD + RFCPI + RPRESCOMP + RFOREST + RFIP + RENOV + RSOCREP + RETRESIMEUB
+ RETCODIL + RETCODIN + RETCODIV + RETCODIJ
+ RETRESIVIEU
+ RETCODIE + RETCODIF + RETCODIG + RETCODID
+ RETCODJT + RETCODJU + AREDMEUB + AREDREP + AILMIX + AILMIY + AINVRED
+ AILMIH + AILMJC + AILMIZ + AILMJI + AILMJS + MEUBLERET + RETPROREP
+ RETREPNPRO + RETREPMEU + AILMIC + AILMIB + AILMIA + AILMJY + AILMJX
+ AILMJW + AILMJV + REPINVDOMPRO3 + APATNAT1 + APATNAT2 + APATNAT3 + RAPATNAT
+ RAFORET + RRCN + REVMOD
+ RCREATEUR + RCREATEURHANDI
;


RED_1 =  RCOTFOR_1 + RSURV_1 + RCOMP_1 + RHEBE_1 + RREPA_1 + RDIFAGRI_1 + RDONS_1
       + RDUFLOGIH_1
       + RCELTOT_1
       + RRESTIMO_1 * (1-V_INDTEO)
       + RFIPC_1 + RFIPDOM_1 + RAIDE_1 + RNOUV_1
       + RTOURREP_1
       + RTOUREPA_1 + RTOUHOTR_1
       + RLOGDOM_1 + RLOGSOC_1 + RDOMSOC1_1 + RLOCENT_1 + RCOLENT_1
       + RRETU_1 + RINNO_1 + RRPRESCOMP_1 + RFOR_1
       + RSOUFIP_1 + RRIRENOV_1 + RSOCREPR_1 + RRESIMEUB_1 + RRESINEUV_1 + RRESIVIEU_1
       + RLOCIDEFG_1 + RCODJT_1 + RCODJU_1
       + RREDMEUB_1 + RREDREP_1 + RILMIX_1 + RILMIY_1 + RINVRED_1 + RILMIH_1 + RILMJC_1
       + RILMIZ_1 + RILMJI_1 + RILMJS_1 + RMEUBLE_1 + RPROREP_1 + RREPNPRO_1 + RREPMEU_1
       + RILMIC_1 + RILMIB_1 + RILMIA_1 + RILMJY_1 + RILMJX_1 + RILMJW_1 + RILMJV_1
       + RIDOMPROE3_1
       + RPATNAT1_1 + RPATNAT2_1 + RPATNAT3_1 + RPATNAT_1
       + RFORET_1 + RCREAT_1 + RCINE_1
       + RREVMOD_1 ;

regle 4070:
application : bareme ;
RED = V_9UY;
regle 4025:
application : iliad , batch  ;

PLAFDOMPRO1 = max(0 , RRI1_1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV-RFOR
                          -RTOURREP-RTOUHOTR-RTOUREPA-RCELTOT-RLOCNPRO-RPATNATOT
                          -RDOMSOC1-RLOGSOC ) ;
                          
RIDOMPROE3_1 = min(REPINVDOMPRO3 , PLAFDOMPRO1) * (1 - V_CNR) ;

RIDOMPROE3 = (RIDOMPROE3_1 * (1-ART1731BIS)
              + min(RIDOMPROE3_1 , max(RIDOMPROE3_P, RIDOMPROE31731+0)) * ART1731BIS) * (1-V_CNR);
                  
REPOMENTR3 = positif(REPINVDOMPRO3 - PLAFDOMPRO1) * (REPINVDOMPRO3 - PLAFDOMPRO1) * (1 - V_CNR) ;


RIDOMPROTOT_1 = RIDOMPROE3_1 ;
RIDOMPROTOT = RIDOMPROE3 ;


RINVEST = RIDOMPROE3 ;

RIDOMPRO = REPINVDOMPRO3 ;

DIDOMPRO = ( RIDOMPRO * (1-ART1731BIS) 
             + min( RIDOMPRO, max(DIDOMPRO_P , DIDOMPRO1731+0 )) * ART1731BIS ) * (1 - V_CNR) ;

regle 40749:
application : iliad , batch  ;

DFORET = FORET ;

AFORET_1 = max(min(DFORET,LIM_FORET),0) * (1-V_CNR) ;

AFORET = max( 0 , AFORET_1  * (1-ART1731BIS) 
                  + min( AFORET_1 , max(AFORET_P , AFORET1731+0)) * ART1731BIS
            ) * (1-V_CNR) ;

RAFORET = arr(AFORET*TX_FORET/100) * (1-V_CNR) ;

RFORET_1 =  max( min( RAFORET , IDOM11-DEC11-RCOTFOR-RREPA-RAIDE-RDIFAGRI) , 0 ) ;
RFORET =  max( 0 , RFORET_1 * (1-ART1731BIS) 
                   + min( RFORET_1 , max( RFORET_P , RFORET1731+0 )) * ART1731BIS ) ;

regle 4075:
application : iliad , batch ;

DFIPC = FIPCORSE ;

AFIPC_1 = max( min(DFIPC , LIM_FIPCORSE * (1 + BOOL_0AM)) , 0) * (1 - V_CNR) ;

AFIPC = max( 0, AFIPC_1 * (1-ART1731BIS)
                + min( AFIPC_1 , max( AFIPC_P , AFIPC1731+0 )) * ART1731BIS
           ) * (1 - V_CNR) ;

RFIPCORSE = arr(AFIPC * TX_FIPCORSE/100) * (1 - V_CNR) ;

RFIPC_1 = max( min( RFIPCORSE , IDOM11-DEC11-RCOTFOR-RREPA-RAIDE-RDIFAGRI-RFORET-RFIPDOM) , 0) ;
RFIPC = max( 0, RFIPC_1 * (1 - ART1731BIS) 
                + min( RFIPC_1 , max(RFIPC_P , RFIPC1731+0 )) * ART1731BIS ) ;

regle 40751:
application : iliad , batch ;

DFIPDOM = FIPDOMCOM ;

AFIPDOM_1 = max( min(DFIPDOM , LIMFIPDOM * (1 + BOOL_0AM)) , 0) * (1 - V_CNR) ;
AFIPDOM = max( 0 , AFIPDOM_1 * (1 - ART1731BIS)
               + min( AFIPDOM_1 , max(AFIPDOM_P , AFIPDOM1731+0)) * ART1731BIS
	     ) * (1 - V_CNR) ;

RFIPDOMCOM = arr(AFIPDOM * TXFIPDOM/100) * (1 - V_CNR) ;

RFIPDOM_1 = max( min( RFIPDOMCOM , IDOM11-DEC11-RCOTFOR-RREPA-RAIDE-RDIFAGRI-RFORET),0);
RFIPDOM = max( 0 , RFIPDOM_1 * (1 - ART1731BIS) 
                   + min( RFIPDOM_1, max(RFIPDOM_P ,  RFIPDOM1731+0 )) * ART1731BIS ) ;

regle 4076:
application : iliad , batch  ;
BSURV = min( RDRESU , PLAF_RSURV + PLAF_COMPSURV * (EAC + V_0DN) + PLAF_COMPSURVQAR * (V_0CH + V_0DP) );
RRS = arr( BSURV * TX_REDSURV / 100 ) * (1 - V_CNR);
DSURV = RDRESU;

ASURV = (BSURV * (1-ART1731BIS)
         + min( BSURV , max( ASURV_P , ASURV1731+0 )) * ART1731BIS)  * (1-V_CNR);

RSURV_1 = max( min( RRS , IDOM11-DEC11-RCOTFOR-RREPA-RAIDE-RDIFAGRI-RFORET-RFIPDOM-RFIPC
			  -RCINE-RRESTIMO-RSOCREPR-RRPRESCOMP-RHEBE ) , 0 ) ;

RSURV = max( 0 , RSURV_1 * (1-ART1731BIS) 
                 + min( RSURV_1, max(RSURV_P , RSURV1731+0 )) * ART1731BIS ) ;

regle 4100:
application : iliad , batch ;

RRCN = arr(  min( CINE1 , min( max(SOFIRNG,RNG) * TX_CINE3/100 , PLAF_CINE )) * TX_CINE1/100
        + min( CINE2 , max( min( max(SOFIRNG,RNG) * TX_CINE3/100 , PLAF_CINE ) - CINE1 , 0)) * TX_CINE2/100 
       ) * (1 - V_CNR) ;

DCINE = CINE1 + CINE2 ;

ACINE_1 = max(0,min( CINE1 + CINE2 , min( arr(SOFIRNG * TX_CINE3/100) , PLAF_CINE ))) * (1 - V_CNR) ;
ACINE = max( 0, ACINE_1 * (1-ART1731BIS) 
                + min( ACINE_1 , max(ACINE_P , ACINE1731+0 )) * ART1731BIS
           ) * (1-V_CNR) ; 

RCINE_1 = max( min( RRCN , IDOM11-DEC11-RCOTFOR-RREPA-RAIDE-RDIFAGRI-RFORET-RFIPDOM-RFIPC) , 0 ) ;
RCINE = max( 0, RCINE_1 * (1-ART1731BIS) 
                + min( RCINE_1 , max(RCINE_P , RCINE1731+0 )) * ART1731BIS ) ;

regle 4176:
application : iliad , batch  ;
BSOUFIP = min( FFIP , LIM_SOUFIP * (1 + BOOL_0AM));
RFIP = arr( BSOUFIP * TX_REDFIP / 100 ) * (1 - V_CNR);
DSOUFIP = FFIP;

ASOUFIP = (BSOUFIP * (1-ART1731BIS) 
           + min( BSOUFIP , max(ASOUFIP_P , ASOUFIP1731+0 ))) * (1-V_CNR) ;

RSOUFIP_1 = max( min( RFIP , IDOM11-DEC11-RCOTFOR-RREPA-RAIDE-RDIFAGRI-RFORET-RFIPDOM-RFIPC
			   -RCINE-RRESTIMO-RSOCREPR-RRPRESCOMP-RHEBE-RSURV-RINNO) , 0 ) ;

RSOUFIP = max( 0 , RSOUFIP_1 * (1-ART1731BIS) 
                   + min( RSOUFIP_1 , max(RSOUFIP_P , RSOUFIP1731+0)) * ART1731BIS ) ;

regle 4200:
application : iliad , batch  ;

BRENOV = min(RIRENOV,PLAF_RENOV) ;

RENOV = arr( BRENOV * TX_RENOV / 100 ) * (1 - V_CNR) ;

DRIRENOV = RIRENOV ;

ARIRENOV = (BRENOV * (1-ART1731BIS) 
            + min( BRENOV, max(ARIRENOV_P , ARIRENOV1731+0)) * ART1731BIS ) * (1 - V_CNR) ;

RRIRENOV_1 = max(min(RENOV , IDOM11-DEC11-RCOTFOR-RREPA-RAIDE-RDIFAGRI-RFORET-RFIPDOM-RFIPC-RCINE
			     -RRESTIMO-RSOCREPR-RRPRESCOMP-RHEBE-RSURV-RINNO-RSOUFIP) , 0 ) ;

RRIRENOV = max( 0 , RRIRENOV_1 * (1-ART1731BIS) 
                    + min(RRIRENOV_1 , max(RRIRENOV_P , RRIRENOV1731+0)) * ART1731BIS ) ;

regle 40771:
application : iliad , batch  ;
RFC = min(RDCOM,PLAF_FRCOMPTA * max(1,NBACT)) * present(RDCOM)*(1-V_CNR);
NCOMP = ( max(1,NBACT)* present(RDCOM) * (1-ART1731BIS) + min( max(1,NBACT)* present(RDCOM) , NCOMP1731+0) * ART1731BIS ) * (1-V_CNR);
DCOMP = RDCOM;

ACOMP =  RFC * (1-ART1731BIS) 
         + min( RFC , max(ACOMP_P , ACOMP1731+0 )) * ART1731BIS ;

regle 10040771:
application :  iliad , batch  ;
RCOMP_1 = max(min( RFC , RRI1-RLOGDOM-RCREAT) , 0) ;
RCOMP = max( 0 , RCOMP_1 * (1-ART1731BIS) 
                 + min( RCOMP_1 ,max(RCOMP_P , RCOMP1731+0 )) * ART1731BIS ) ;

regle 4077:
application : iliad , batch  ;
DDUFLOGIH = DUFLOGI + DUFLOGH ;

ADUFLOGIH_1 = ( arr( min( DUFLOGI + 0, LIMDUFLO) / 9 ) +
              arr( min( DUFLOGH + 0, LIMDUFLO - min( DUFLOGI + 0, LIMDUFLO)) / 9 )
            ) * ( 1 - null( 4-V_REGCO )) * ( 1 - null( 2-V_REGCO )) ;

ADUFLOGIH =  ADUFLOGIH_1 * (1-ART1731BIS) 
             + min( ADUFLOGIH_1, max(ADUFLOGIH_P , ADUFLOGIH1731 +0 )) * ART1731BIS ;

RDUFLO_GIH = ( arr( arr( min( DUFLOGI + 0, LIMDUFLO) / 9 ) * (TX29/100)) +
              arr( arr( min( DUFLOGH + 0, LIMDUFLO - min( DUFLOGI + 0, LIMDUFLO)) / 9 ) * (TX18/100))
             ) * ( 1 - null( 4-V_REGCO )) * ( 1 - null( 2-V_REGCO )) ;

regle 40772:
application : iliad , batch  ;

RDUFLOGIH_1 = max( 0, min( RDUFLO_GIH , RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS)) ;

RDUFLOGIH = max( 0, RDUFLOGIH_1 * (1 - ART1731BIS) 
                    + min ( RDUFLOGIH_1 , max(RDUFLOGIH_P , RDUFLOGIH1731+0 )) * ART1731BIS ) ;
regle 40773:
application : iliad , batch  ;

RIVDUFLOGIH = ( arr( arr( min( DUFLOGI + 0, LIMDUFLO) / 9 ) * (TX29/100)) +
                arr( arr( min( DUFLOGH + 0, LIMDUFLO - min( DUFLOGI + 0, LIMDUFLO)) / 9 ) * (TX18/100))
              ) * ( 1 - null( 4-V_REGCO )) * ( 1 - null( 2-V_REGCO )) ;

RIVDUFLOGIH8 = max (0 , ( arr( min( DUFLOGI + 0, LIMDUFLO) * (TX29/100)) +
                          arr( min( DUFLOGH + 0, LIMDUFLO - min( DUFLOGI + 0, LIMDUFLO)) * (TX18/100))
                        ) 
                          - 8 * RIVDUFLOGIH  
                   ) * ( 1 - null( 4-V_REGCO )) * ( 1 - null( 2-V_REGCO )) ; 

REPDUFLOT2013 = RIVDUFLOGIH * 7 + RIVDUFLOGIH8 ;


regle 4078:
application : iliad , batch  ;
BCEL_FABC = arr ( min( CELLIERFA + CELLIERFB + CELLIERFC , LIMCELLIER ) /9 );

BCEL_FD = arr ( min( CELLIERFD , LIMCELLIER ) /5 );

BCEL_2012 = arr( min(( CELLIERJA + CELLIERJD + CELLIERJE + CELLIERJF + CELLIERJH + CELLIERJJ 
		     + CELLIERJK + CELLIERJM + CELLIERJN + 0 ), LIMCELLIER ) /9 );

BCEL_JOQR = arr( min(( CELLIERJO + CELLIERJQ + CELLIERJR + 0 ), LIMCELLIER ) /5 );

BCEL_2011 = arr( min(( CELLIERNA + CELLIERNC + CELLIERND + CELLIERNE + CELLIERNF + CELLIERNH
		     + CELLIERNI + CELLIERNJ + CELLIERNK + CELLIERNM + CELLIERNN + CELLIERNO  + 0 ), LIMCELLIER ) /9 );

BCELCOM2011 = arr( min(( CELLIERNP + CELLIERNR + CELLIERNS + CELLIERNT + 0 ), LIMCELLIER ) /5 );

BCEL_NBGL = arr( min(( CELLIERNB + CELLIERNG + CELLIERNL + 0), LIMCELLIER ) /9 );

BCEL_NQ = arr( min(( CELLIERNQ + 0), LIMCELLIER ) /5 );

BCEL_JBGL = arr( min(( CELLIERJB + CELLIERJG + CELLIERJL + 0), LIMCELLIER ) /9 );

BCEL_JP = arr( min(( CELLIERJP + 0), LIMCELLIER ) /5 );


BCEL_HNO = arr ( min ((CELLIERHN + CELLIERHO + 0 ), LIMCELLIER ) /9 );
BCEL_HJK = arr ( min ((CELLIERHJ + CELLIERHK + 0 ), LIMCELLIER ) /9 );

BCEL_HL = arr ( min ((CELLIERHL + 0 ), LIMCELLIER ) /9 );
BCEL_HM = arr ( min ((CELLIERHM + 0 ), LIMCELLIER ) /9 );


DCELRREDLA = CELRREDLA;
ACELRREDLA_R = CELRREDLA * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


ACELRREDLA = (CELRREDLA * (1-ART1731BIS) 
              + min (CELRREDLA, max(ACELRREDLA_P , ACELRREDLA1731 +0)) * ART1731BIS)
	      * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

DCELRREDLB = CELRREDLB;
ACELRREDLB_R = CELRREDLB * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


ACELRREDLB = (CELRREDLB * (1-ART1731BIS) 
              + min (CELRREDLB, max(ACELRREDLB_P , ACELRREDLB1731 +0)) * ART1731BIS)
	      * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

DCELRREDLE = CELRREDLE;
ACELRREDLE_R = CELRREDLE * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


ACELRREDLE = (CELRREDLE * (1-ART1731BIS)
              + min (CELRREDLE , max(ACELRREDLE_P , ACELRREDLE1731 +0)) * ART1731BIS)
	      * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

DCELRREDLM = CELRREDLM;


ACELRREDLM = (CELRREDLM * (1-ART1731BIS) 
              + min (CELRREDLM, max(ACELRREDLM_P , ACELRREDLM1731 +0)) * ART1731BIS)
	      * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

DCELRREDLC = CELRREDLC;
ACELRREDLC_R = CELRREDLC * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


ACELRREDLC = (CELRREDLC * (1-ART1731BIS) 
              + min (CELRREDLC, max(ACELRREDLC_P , ACELRREDLC1731 +0)) * ART1731BIS)
	      * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

DCELRREDLD = CELRREDLD;
ACELRREDLD_R = CELRREDLD * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


ACELRREDLD = (CELRREDLD * (1-ART1731BIS) 
              + min (CELRREDLD, max(ACELRREDLD_P , ACELRREDLD1731 +0)) * ART1731BIS)
	      * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

DCELRREDLS = CELRREDLS;


ACELRREDLS = (CELRREDLS * (1-ART1731BIS) 
              + min (CELRREDLS, max(ACELRREDLS_P , ACELRREDLS1731 +0)) * ART1731BIS)
	      * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

DCELRREDLF = CELRREDLF;

ACELRREDLF_R = CELRREDLF * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


ACELRREDLF = (CELRREDLF * (1-ART1731BIS) 
              + min (CELRREDLF, max(ACELRREDLF_P , ACELRREDLF1731 +0)) * ART1731BIS)
	      * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

DCELRREDLZ = CELRREDLZ;


ACELRREDLZ = (CELRREDLZ * (1-ART1731BIS) 
              + min (CELRREDLZ, max(ACELRREDLZ_P , ACELRREDLZ1731 +0)) * ART1731BIS)
	      * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

DCELRREDMG = CELRREDMG;



ACELRREDMG = (CELRREDMG * (1-ART1731BIS) 
              + min (CELRREDMG, max(ACELRREDMG_P , ACELRREDMG1731 +0)) * ART1731BIS)
	      * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

DCELREPHS = CELREPHS; 
ACELREPHS_R = DCELREPHS * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


ACELREPHS = (DCELREPHS * (1 - ART1731BIS) 
             + min( DCELREPHS , max(ACELREPHS_P , ACELREPHS1731 + 0 )) * ART1731BIS)
	        * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

DCELREPHR = CELREPHR ;    
ACELREPHR_R = DCELREPHR * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


ACELREPHR = (DCELREPHR * (1 - ART1731BIS) 
             + min( DCELREPHR , max(ACELREPHR_P , ACELREPHR1731 + 0 )) * ART1731BIS)
	        * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

DCELREPHU = CELREPHU; 
ACELREPHU_R = DCELREPHU * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


ACELREPHU = (DCELREPHU * (1 - ART1731BIS) 
             + min( DCELREPHU , max(ACELREPHU_P , ACELREPHU1731 + 0 )) * ART1731BIS)
	        * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

DCELREPHT = CELREPHT; 
ACELREPHT_R = DCELREPHT * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


ACELREPHT = (DCELREPHT * (1 - ART1731BIS) 
             + min( DCELREPHT , max(ACELREPHT_P , ACELREPHT1731 + 0 )) * ART1731BIS)
	        * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

DCELREPHZ = CELREPHZ; 
ACELREPHZ_R = DCELREPHZ * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


ACELREPHZ = (DCELREPHZ * (1 - ART1731BIS) 
             + min( DCELREPHZ , max(ACELREPHZ_P , ACELREPHZ1731 + 0 )) * ART1731BIS)
	        * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

DCELREPHX = CELREPHX; 
ACELREPHX_R = DCELREPHX * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


ACELREPHX = (DCELREPHX * (1 - ART1731BIS) 
             + min( DCELREPHX , max(ACELREPHX_P , ACELREPHX1731 + 0 )) * ART1731BIS)
	        * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

DCELREPHW = CELREPHW; 
ACELREPHW_R = DCELREPHW * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


ACELREPHW = (DCELREPHW * (1 - ART1731BIS) 
             + min( DCELREPHW , max(ACELREPHW_P , ACELREPHW1731 + 0 )) * ART1731BIS)
	        * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

DCELREPHV = CELREPHV; 
ACELREPHV_R = DCELREPHV * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


ACELREPHV = (DCELREPHV * (1 - ART1731BIS) 
             + min( DCELREPHV , max(ACELREPHV_P , ACELREPHV1731 + 0 )) * ART1731BIS)
	        * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

DCELREPHF = CELREPHF; 
ACELREPHF_R = DCELREPHF * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


ACELREPHF = (DCELREPHF * (1 - ART1731BIS) 
             + min( DCELREPHF , max(ACELREPHF_P , ACELREPHF1731 + 0 )) * ART1731BIS)
	        * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

DCELREPHE = CELREPHE ;    
ACELREPHE_R = DCELREPHE * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


ACELREPHE = (DCELREPHE * (1 - ART1731BIS) 
             + min( DCELREPHE , max(ACELREPHE_P , ACELREPHE1731 + 0 )) * ART1731BIS)
	        * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

DCELREPHD = CELREPHD; 
ACELREPHD_R = DCELREPHD * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


ACELREPHD = (DCELREPHD * (1 - ART1731BIS) 
             + min( DCELREPHD , max(ACELREPHD_P , ACELREPHD1731 + 0 )) * ART1731BIS)
	        * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

DCELREPHH = CELREPHH; 
ACELREPHH_R = DCELREPHH * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


ACELREPHH = (DCELREPHH * (1 - ART1731BIS) 
             + min( DCELREPHH , max(ACELREPHH_P , ACELREPHH1731 + 0 )) * ART1731BIS)
	        * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

DCELREPHG = CELREPHG; 
ACELREPHG_R = DCELREPHG * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


ACELREPHG = (DCELREPHG * (1 - ART1731BIS) 
             + min( DCELREPHG , max(ACELREPHG_P , ACELREPHG1731 + 0 )) * ART1731BIS)
	        * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

DCELREPHB = CELREPHB; 
ACELREPHB_R = DCELREPHB * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


ACELREPHB = (DCELREPHB * (1 - ART1731BIS) 
             + min( DCELREPHB , max(ACELREPHB_P , ACELREPHB1731 + 0 )) * ART1731BIS)
	        * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

DCELREPHA = CELREPHA; 
ACELREPHA_R = DCELREPHA * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


ACELREPHA = (DCELREPHA * (1 - ART1731BIS) 
             + min( DCELREPHA , max(ACELREPHA_P , ACELREPHA1731 + 0 )) * ART1731BIS)
	        * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

DCELREPGU = CELREPGU; 


ACELREPGU = (DCELREPGU * (1 - ART1731BIS) 
             + min( DCELREPGU , max (ACELREPGU_P , ACELREPGU1731 + 0 )) * ART1731BIS)
		* (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

DCELREPGX = CELREPGX; 


ACELREPGX = (DCELREPGX * (1 - ART1731BIS) 
             + min( DCELREPGX , max (ACELREPGX_P , ACELREPGX1731 + 0 )) * ART1731BIS)
		* (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

DCELREPGT = CELREPGT; 


ACELREPGT = (DCELREPGT * (1 - ART1731BIS) 
             + min( DCELREPGT , max (ACELREPGT_P , ACELREPGT1731 + 0 )) * ART1731BIS)
		* (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

DCELREPGS = CELREPGS; 


ACELREPGS = (DCELREPGS * (1 - ART1731BIS) 
             + min( DCELREPGS , max (ACELREPGS_P , ACELREPGS1731 + 0 )) * ART1731BIS)
		* (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

DCELREPGW = CELREPGW; 


ACELREPGW = (DCELREPGW * (1 - ART1731BIS) 
             + min( DCELREPGW , max (ACELREPGW_P , ACELREPGW1731 + 0 )) * ART1731BIS)
		* (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

DCELREPGP = CELREPGP; 


ACELREPGP = (DCELREPGP * (1 - ART1731BIS) 
             + min( DCELREPGP , max (ACELREPGP_P , ACELREPGP1731 + 0 )) * ART1731BIS)
		* (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

DCELREPGL = CELREPGL; 


ACELREPGL = (DCELREPGL * (1 - ART1731BIS) 
             + min( DCELREPGL , max (ACELREPGL_P , ACELREPGL1731 + 0 )) * ART1731BIS)
		* (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

DCELREPGV = CELREPGV; 


ACELREPGV = (DCELREPGV * (1 - ART1731BIS) 
             + min( DCELREPGV , max (ACELREPGV_P , ACELREPGV1731 + 0 )) * ART1731BIS)
		* (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

DCELREPGK = CELREPGK; 


ACELREPGK = (DCELREPGK * (1 - ART1731BIS) 
             + min( DCELREPGK , max (ACELREPGK_P , ACELREPGK1731 + 0 )) * ART1731BIS)
		* (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

DCELREPGJ = CELREPGJ; 


ACELREPGJ = (DCELREPGJ * (1 - ART1731BIS) 
             + min( DCELREPGJ , max (ACELREPGJ_P , ACELREPGJ1731 + 0 )) * ART1731BIS)
		* (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

DCELHM = CELLIERHM ; 

ACELHM_R = positif_ou_nul( CELLIERHM) * BCEL_HM * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


ACELHM = ( BCEL_HM * (1-ART1731BIS) 
          + min(BCEL_HM , max(ACELHM_P , ACELHM1731+0))* ART1731BIS )  
         * (positif_ou_nul(CELLIERHM)) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

DCELHL = CELLIERHL ;    

ACELHL_R = positif_ou_nul( CELLIERHL) * BCEL_HL * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


ACELHL = ( BCEL_HL * (1-ART1731BIS) 
          + min(BCEL_HL , max(ACELHL_P , ACELHL1731+0))* ART1731BIS )  
         * (positif_ou_nul(CELLIERHL)) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


DCELHNO = CELLIERHN + CELLIERHO ;

ACELHNO_R = positif_ou_nul( CELLIERHN + CELLIERHO ) * BCEL_HNO * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


ACELHNO = ( BCEL_HNO * (1-ART1731BIS) 
          + min(BCEL_HNO , max(ACELHNO_P , ACELHNO1731+0))* ART1731BIS )  
         * (positif_ou_nul(CELLIERHN + CELLIERHO)) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

DCELHJK = CELLIERHJ + CELLIERHK ;

ACELHJK_R = positif_ou_nul( CELLIERHJ + CELLIERHK ) * BCEL_HJK * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


ACELHJK = ( BCEL_HJK * (1-ART1731BIS) 
          + min(BCEL_HJK , max(ACELHJK_P , ACELHJK1731+0))* ART1731BIS )  
         * (positif_ou_nul(CELLIERHJ + CELLIERHK)) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


DCELNQ = CELLIERNQ;
ACELNQ_R = (positif_ou_nul( CELLIERNQ) * BCEL_NQ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


ACELNQ = ( BCEL_NQ * (1-ART1731BIS) 
          + min(BCEL_NQ , max(ACELNQ_P , ACELNQ1731+0))* ART1731BIS )  
         * (positif_ou_nul(CELLIERNQ)) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

DCELNBGL =   CELLIERNB + CELLIERNG + CELLIERNL;

ACELNBGL_R = positif_ou_nul( CELLIERNB + CELLIERNG + CELLIERNL ) * BCEL_NBGL * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


ACELNBGL = ( BCEL_NBGL * (1-ART1731BIS) 
             + min(BCEL_NBGL , max(ACELNBGL_P , ACELNBGL1731+0))* ART1731BIS )  
           * positif_ou_nul(CELLIERNB + CELLIERNG + CELLIERNL) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

DCELCOM =   CELLIERNP + CELLIERNR + CELLIERNS + CELLIERNT;

ACELCOM_R = positif_ou_nul(CELLIERNP + CELLIERNR + CELLIERNS + CELLIERNT) * BCELCOM2011 * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


ACELCOM = ( BCELCOM2011 * (1-ART1731BIS) 
          + min(BCELCOM2011 , max(ACELCOM_P , ACELCOM1731+0))* ART1731BIS )  
          * positif_ou_nul(CELLIERNP + CELLIERNR + CELLIERNS + CELLIERNT) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

CELSOMN = CELLIERNA+CELLIERNC+CELLIERND+CELLIERNE+CELLIERNF+CELLIERNH
	 +CELLIERNI+CELLIERNJ+CELLIERNK+CELLIERNM+CELLIERNN+CELLIERNO;  

DCEL = CELSOMN ; 


ACEL_R = positif_ou_nul( CELSOMN ) * BCEL_2011 * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


ACEL = (BCEL_2011 * (1 - ART1731BIS) 
        + min(BCEL_2011 , max(ACEL_P , ACEL1731+0)) * ART1731BIS)  
          * positif_ou_nul(CELSOMN) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

DCELJP = CELLIERJP;

ACELJP_R = positif_ou_nul( CELLIERJP) * BCEL_JP * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;



ACELJP = (BCEL_JP * (1 - ART1731BIS) 
          + min(BCEL_JP , max(ACELJP_P , ACELJP1731+0)) * ART1731BIS)  
          * positif_ou_nul(CELLIERJP) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

DCELJBGL =   CELLIERJB + CELLIERJG + CELLIERJL;

ACELJBGL_R = positif_ou_nul( CELLIERJB + CELLIERJG + CELLIERJL ) * BCEL_JBGL * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


ACELJBGL = (BCEL_JBGL * (1 - ART1731BIS) 
          + min(BCEL_JBGL , max(ACELJBGL_P , ACELJBGL1731+0)) * ART1731BIS)  
          * positif_ou_nul(CELLIERJB+CELLIERJG+CELLIERJL) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;



DCELJOQR =   CELLIERJO + CELLIERJQ + CELLIERJR;

ACELJOQR_R = positif_ou_nul(CELLIERJO + CELLIERJQ + CELLIERJR) * BCEL_JOQR * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


ACELJOQR = (BCEL_JOQR * (1 - ART1731BIS) 
          + min(BCEL_JOQR , max(ACELJOQR_P , ACELJOQR1731+0)) * ART1731BIS)  
          * positif_ou_nul(CELLIERJO + CELLIERJQ + CELLIERJR) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


CELSOMJ = CELLIERJA + CELLIERJD + CELLIERJE + CELLIERJF + CELLIERJH 
	  + CELLIERJJ + CELLIERJK + CELLIERJM + CELLIERJN;

DCEL2012 = CELSOMJ ; 

ACEL2012_R = positif_ou_nul( CELSOMJ ) * BCEL_2012 * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


ACEL2012 = (BCEL_2012 * (1 - ART1731BIS) 
            + min( BCEL_2012 , max(ACEL2012_P , ACEL20121731+0)) * ART1731BIS)  
          * positif_ou_nul(CELSOMJ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

DCELFD = CELLIERFD ;

ACELFD_R = positif_ou_nul(DCELFD) * BCEL_FD * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


ACELFD = (BCEL_FD * (1 - ART1731BIS)
          + min(BCEL_FD, max(ACELFD_P , ACELFD1731+0)) * ART1731BIS)
          * positif_ou_nul(DCELFD) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

DCELFABC = CELLIERFA + CELLIERFB + CELLIERFC ;

ACELFABC_R = positif_ou_nul(DCELFABC) * BCEL_FABC 
             * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


ACELFABC = (BCEL_FABC * (1 - ART1731BIS) 
            + min(BCEL_FABC , max( ACELFABC_P , ACELFABC1731+0 )) * ART1731BIS)
           * positif_ou_nul(DCELFABC) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCEL_HM = positif(CELLIERHM) * arr (ACELHM * (TX40/100)) 
             * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCEL_HM_R = positif(CELLIERHM) * arr (ACELHM_R * (TX40/100)) 
             * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCEL_HL = positif( CELLIERHL ) * arr (ACELHL * (TX25/100))
             * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCEL_HL_R = positif( CELLIERHL ) * arr (ACELHL_R * (TX25/100))
             * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCEL_HNO = (  positif(CELLIERHN) * arr(ACELHNO * (TX25/100))
	       + positif(CELLIERHO) * arr(ACELHNO * (TX40/100))
              ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCEL_HNO_R = (  positif(CELLIERHN) * arr(ACELHNO_R * (TX25/100))
	       + positif(CELLIERHO) * arr(ACELHNO_R * (TX40/100))
              ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCEL_HJK = (  positif(CELLIERHJ) * arr(ACELHJK * (TX25/100))
	      + positif(CELLIERHK) * arr(ACELHJK * (TX40/100))
             ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCEL_HJK_R = (  positif(CELLIERHJ) * arr(ACELHJK_R * (TX25/100))
	      + positif(CELLIERHK) * arr(ACELHJK_R * (TX40/100))
             ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCEL_NQ = ( positif(CELLIERNQ) * arr(ACELNQ * (TX40/100)) ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCEL_NQ_R = ( positif(CELLIERNQ) * arr(ACELNQ_R * (TX40/100)) ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCEL_NBGL = (  positif(CELLIERNB) * arr(ACELNBGL * (TX25/100))
	       + positif(CELLIERNG) * arr(ACELNBGL * (TX15/100))
	       + positif(CELLIERNL) * arr(ACELNBGL * (TX40/100))
              ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCEL_NBGL_R = (  positif(CELLIERNB) * arr(ACELNBGL_R * (TX25/100))
	       + positif(CELLIERNG) * arr(ACELNBGL_R * (TX15/100))
	       + positif(CELLIERNL) * arr(ACELNBGL_R * (TX40/100))
              ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCEL_COM = (  positif(CELLIERNP + CELLIERNT) * arr (ACELCOM * (TX36/100))
               + positif(CELLIERNR + CELLIERNS) * arr (ACELCOM * (TX40/100)) 
              ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCEL_COM_R = (  positif(CELLIERNP + CELLIERNT) * arr (ACELCOM_R * (TX36/100))
               + positif(CELLIERNR + CELLIERNS) * arr (ACELCOM_R * (TX40/100)) 
              ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCEL_2011 = (  positif(CELLIERNA + CELLIERNE) * arr (ACEL * (TX22/100))
            + positif(CELLIERNC + CELLIERND + CELLIERNH) * arr (ACEL * (TX25/100))
            + positif(CELLIERNF + CELLIERNJ) * arr (ACEL * (TX13/100))
            + positif(CELLIERNI) * arr (ACEL * (TX15/100))
	    + positif(CELLIERNM + CELLIERNN) * arr (ACEL * (TX40/100))
	    + positif(CELLIERNK + CELLIERNO) * arr (ACEL * (TX36/100))
            ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCEL_2011_R = (  positif(CELLIERNA + CELLIERNE) * arr (ACEL_R * (TX22/100))
            + positif(CELLIERNC + CELLIERND + CELLIERNH) * arr (ACEL_R * (TX25/100))
            + positif(CELLIERNF + CELLIERNJ) * arr (ACEL_R * (TX13/100))
            + positif(CELLIERNI) * arr (ACEL_R * (TX15/100))
	    + positif(CELLIERNM + CELLIERNN) * arr (ACEL_R * (TX40/100))
	    + positif(CELLIERNK + CELLIERNO) * arr (ACEL_R * (TX36/100))
            ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCEL_JP = ( positif(CELLIERJP) * arr(ACELJP * (TX36/100)) ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCEL_JP_R = ( positif(CELLIERJP) * arr(ACELJP_R * (TX36/100)) ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCEL_JBGL = (  positif(CELLIERJB) * arr(ACELJBGL * (TX22/100))
	       + positif(CELLIERJG) * arr(ACELJBGL * (TX13/100))
	       + positif(CELLIERJL) * arr(ACELJBGL * (TX36/100))
              ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCEL_JBGL_R = (  positif(CELLIERJB) * arr(ACELJBGL_R * (TX22/100))
	       + positif(CELLIERJG) * arr(ACELJBGL_R * (TX13/100))
	       + positif(CELLIERJL) * arr(ACELJBGL_R * (TX36/100))
              ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCEL_JOQR = (  positif(CELLIERJQ) * arr (ACELJOQR * (TX36/100))
               + positif(CELLIERJO + CELLIERJR) * arr (ACELJOQR * (TX24/100)) 
              ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCEL_JOQR_R = (  positif(CELLIERJQ) * arr (ACELJOQR_R * (TX36/100))
               + positif(CELLIERJO + CELLIERJR) * arr (ACELJOQR_R * (TX24/100)) 
              ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCEL_2012 = (  positif(CELLIERJA + CELLIERJE + CELLIERJH) * arr (ACEL2012 * (TX13/100)) 
            + positif(CELLIERJD) * arr (ACEL2012 * (TX22/100))
            + positif(CELLIERJF + CELLIERJJ) * arr (ACEL2012 * (TX6/100))
            + positif(CELLIERJK + CELLIERJN) * arr (ACEL2012 * (TX24/100))
	    + positif(CELLIERJM) * arr (ACEL2012 * (TX36/100))
	    ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCEL_2012_R = (  positif(CELLIERJA + CELLIERJE + CELLIERJH) * arr (ACEL2012_R * (TX13/100)) 
            + positif(CELLIERJD) * arr (ACEL2012_R * (TX22/100))
            + positif(CELLIERJF + CELLIERJJ) * arr (ACEL2012_R * (TX6/100))
            + positif(CELLIERJK + CELLIERJN) * arr (ACEL2012_R * (TX24/100))
	    + positif(CELLIERJM) * arr (ACEL2012_R * (TX36/100))
	    ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCEL_FD = positif( CELLIERFD ) * arr (ACELFD * (TX24/100))
             * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCEL_FD_R = positif( CELLIERFD ) * arr (ACELFD_R * (TX24/100))
             * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCEL_FABC = (  positif(CELLIERFA) * arr(ACELFABC * (TX13/100))
             + positif(CELLIERFB) * arr(ACELFABC * (TX6/100))
             + positif(CELLIERFC) * arr(ACELFABC * (TX24/100))
            ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCEL_FABC_R = (  positif(CELLIERFA) * arr(ACELFABC_R * (TX13/100))
               + positif(CELLIERFB) * arr(ACELFABC_R * (TX6/100))
               + positif(CELLIERFC) * arr(ACELFABC_R * (TX24/100))
              ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCELREP_HS = positif(CELREPHS) * arr (ACELREPHS * (TX40/100)) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;
RCELREP_HS_R = positif(CELREPHS) * arr (ACELREPHS_R * (TX40/100)) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCELREP_HR = positif( CELREPHR ) * arr (ACELREPHR * (TX25/100)) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;
RCELREP_HR_R = positif( CELREPHR ) * arr (ACELREPHR_R * (TX25/100)) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCELREP_HU = positif( CELREPHU ) * arr (ACELREPHU * (TX40/100)) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;
RCELREP_HU_R = positif( CELREPHU ) * arr (ACELREPHU_R * (TX40/100)) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCELREP_HT = positif( CELREPHT ) * arr (ACELREPHT * (TX25/100)) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;
RCELREP_HT_R = positif( CELREPHT ) * arr (ACELREPHT_R * (TX25/100)) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCELREP_HZ = positif( CELREPHZ ) * arr (ACELREPHZ * (TX40/100)) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;
RCELREP_HZ_R = positif( CELREPHZ ) * arr (ACELREPHZ_R * (TX40/100)) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCELREP_HX = positif( CELREPHX ) * arr (ACELREPHX * (TX25/100)) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;
RCELREP_HX_R = positif( CELREPHX ) * arr (ACELREPHX_R * (TX25/100)) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCELREP_HW = positif( CELREPHW ) * arr (ACELREPHW * (TX40/100)) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;
RCELREP_HW_R = positif( CELREPHW ) * arr (ACELREPHW_R * (TX40/100)) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCELREP_HV = positif( CELREPHV ) * arr (ACELREPHV * (TX25/100)) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;
RCELREP_HV_R = positif( CELREPHV ) * arr (ACELREPHV_R * (TX25/100)) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

regle 2004078:
application : iliad , batch  ;

REDUCAVTCEL = RCOTFOR+RREPA+RAIDE+RDIFAGRI+RFORET+RFIPDOM+RFIPC+RCINE+RRESTIMO+RSOCREPR
	      + RRPRESCOMP+RHEBE+RSURV+RINNO+RSOUFIP+RRIRENOV+RLOGDOM+RCREAT+RCOMP + RRETU
              + RDONS + RDUFLOGIH + RNOUV + RFOR + RTOURREP + RTOUHOTR + RTOUREPA ;

RCELRREDLA_1 = max( min(ACELRREDLA, IDOM11-DEC11 - REDUCAVTCEL ) , 0 ) ;
RCELRREDLA = max(0, RCELRREDLA_1 * (1 - ART1731BIS) 
                 + min ( RCELRREDLA_1 , max(RCELRREDLA_P , RCELRREDLA1731+0)) * ART1731BIS 
                ) ;

RCELRREDLB_1 = max( min(ACELRREDLB , IDOM11-DEC11 - REDUCAVTCEL - RCELRREDLA ) , 0 ) ;
RCELRREDLB = max(0, RCELRREDLB_1 * (1 - ART1731BIS) 
                 + min ( RCELRREDLB_1 , max(RCELRREDLB_P ,RCELRREDLB1731+0)) * ART1731BIS 
                ) ;

RCELRREDLE_1 = max( min(ACELRREDLE, IDOM11-DEC11 - REDUCAVTCEL 
               - RCELRREDLA-RCELRREDLB ) , 0 ) ;
RCELRREDLE = max(0, RCELRREDLE_1 * (1 - ART1731BIS) 
                 + min ( RCELRREDLE_1 , max(RCELRREDLE_P ,RCELRREDLE1731+0)) * ART1731BIS 
                ) ;

RCELRREDLM_1 = max( min(ACELRREDLM, IDOM11-DEC11 - REDUCAVTCEL 
	      - RCELRREDLA-RCELRREDLB-RCELRREDLE ) , 0 ) ;
RCELRREDLM = max(0, RCELRREDLM_1 * (1 - ART1731BIS) 
                 + min ( RCELRREDLM_1 , max(RCELRREDLM_P ,RCELRREDLM1731+0)) * ART1731BIS 
                ) ;


RCELRREDLC_1 = max( min(ACELRREDLC, IDOM11-DEC11 - REDUCAVTCEL 
	      - RCELRREDLA-RCELRREDLB-RCELRREDLE-RCELRREDLM ) , 0 ) ;
RCELRREDLC = max(0, RCELRREDLC_1 * (1 - ART1731BIS) 
                 + min ( RCELRREDLC_1 , max(RCELRREDLC_P ,RCELRREDLC1731+0)) * ART1731BIS 
                ) ;

RCELRREDLD_1 = max( min(ACELRREDLD , IDOM11-DEC11 - REDUCAVTCEL 
	      - RCELRREDLA-RCELRREDLB-RCELRREDLE-RCELRREDLM-RCELRREDLC ) , 0 ) ;
RCELRREDLD = max(0, RCELRREDLD_1 * (1 - ART1731BIS) 
                 + min ( RCELRREDLD_1 , max(RCELRREDLD_P ,RCELRREDLD1731+0)) * ART1731BIS 
                ) ;

RCELRREDLS_1 = max( min(ACELRREDLS , IDOM11-DEC11 - REDUCAVTCEL 
	      - RCELRREDLA-RCELRREDLB-RCELRREDLE-RCELRREDLM-RCELRREDLC-RCELRREDLD ) , 0 ) ;
RCELRREDLS = max(0, RCELRREDLS_1 * (1 - ART1731BIS) 
                 + min ( RCELRREDLS_1 , max(RCELRREDLS_P ,RCELRREDLS1731+0)) * ART1731BIS 
                ) ;

RCELRREDLF_1 = max( min(ACELRREDLF, IDOM11-DEC11 - REDUCAVTCEL 
	      - RCELRREDLA-RCELRREDLB-RCELRREDLE-RCELRREDLM-RCELRREDLC-RCELRREDLD-RCELRREDLS ) , 0 ) ;
RCELRREDLF = max(0, RCELRREDLF_1 * (1 - ART1731BIS) 
                 + min ( RCELRREDLF_1 , max(RCELRREDLF_P ,RCELRREDLF1731+0)) * ART1731BIS 
                ) ;

RCELRREDLZ_1 = max( min(ACELRREDLZ, IDOM11-DEC11 - REDUCAVTCEL 
	      - RCELRREDLA-RCELRREDLB-RCELRREDLE-RCELRREDLM-RCELRREDLC-RCELRREDLD-RCELRREDLS-RCELRREDLF ) , 0 ) ;
RCELRREDLZ = max(0, RCELRREDLZ_1 * (1 - ART1731BIS) 
                 + min ( RCELRREDLZ_1 , max(RCELRREDLZ_P ,RCELRREDLZ1731+0)) * ART1731BIS 
                ) ;

RCELRREDMG_1 = max( min(ACELRREDMG, IDOM11-DEC11 - REDUCAVTCEL 
	      - RCELRREDLA-RCELRREDLB-RCELRREDLE-RCELRREDLM-RCELRREDLC-RCELRREDLD-RCELRREDLS-RCELRREDLF-RCELRREDLZ ) , 0 ) ;
RCELRREDMG = max(0, RCELRREDMG_1 * (1 - ART1731BIS) 
                 + min ( RCELRREDMG_1 , max(RCELRREDMG_P ,RCELRREDMG1731+0)) * ART1731BIS 
                ) ;

RCELRREDSOM = somme (i=A,B,E,M,C,D,S,F,Z : RCELRREDLi) + RCELRREDMG ;

RCELRREDSOM_1 = somme (i=A,B,E,M,C,D,S,F,Z : RCELRREDLi_1) + RCELRREDMG_1 ;

RCELREPHS_1 = max( min( RCELREP_HS ,IDOM11-DEC11 - REDUCAVTCEL - RCELRREDSOM ) , 0) 
              * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCELREPHS = max( 0, RCELREPHS_1 * (1 - ART1731BIS)
                 + min (RCELREPHS_1 , max(RCELREPHS_P, RCELREPHS1731+0)) * ART1731BIS ) 
	    * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCELREPHR_1 = max( min( RCELREP_HR ,IDOM11-DEC11 - REDUCAVTCEL - RCELRREDSOM
	                            - RCELREPHS ) , 0)
	      * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCELREPHR = max( 0, RCELREPHR_1 * (1 - ART1731BIS)
                 + min (RCELREPHR_1 , max(RCELREPHR_P, RCELREPHR1731+0)) * ART1731BIS ) 
	    * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCELREPHU_1 = max( min( RCELREP_HU , IDOM11-DEC11 - REDUCAVTCEL - RCELRREDSOM
         	                     - RCELREPHS-RCELREPHR ) , 0)
	      * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCELREPHU = max( 0, RCELREPHU_1 * (1 - ART1731BIS)
                 + min (RCELREPHU_1 , max(RCELREPHU_P, RCELREPHU1731+0)) * ART1731BIS ) 
	    * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCELREPHT_1 = max( min( RCELREP_HT, IDOM11-DEC11 - REDUCAVTCEL - RCELRREDSOM 
	                             - RCELREPHS-RCELREPHR-RCELREPHU ) , 0)
              * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCELREPHT = max( 0, RCELREPHT_1 * (1 - ART1731BIS)
                 + min (RCELREPHT_1 , max(RCELREPHT_P, RCELREPHT1731+0)) * ART1731BIS ) 
	    * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCELREPHZ_1 = max( min( RCELREP_HZ , IDOM11-DEC11 - REDUCAVTCEL - RCELRREDSOM
	                              - RCELREPHS-RCELREPHR-RCELREPHU-RCELREPHT ) , 0)
              * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCELREPHZ = max( 0, RCELREPHZ_1 * (1 - ART1731BIS)
                 + min (RCELREPHZ_1 , max(RCELREPHZ_P, RCELREPHZ1731+0)) * ART1731BIS ) 
	    * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCELREPHX_1 = max( min( RCELREP_HX , IDOM11-DEC11 - REDUCAVTCEL - RCELRREDSOM
	                             - RCELREPHS-RCELREPHR-RCELREPHU-RCELREPHT-RCELREPHZ ) , 0)
              * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCELREPHX = max( 0, RCELREPHX_1 * (1 - ART1731BIS)
                 + min (RCELREPHX_1 , max(RCELREPHX_P, RCELREPHX1731+0)) * ART1731BIS ) 
	    * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCELREPHW_1 = max( min( RCELREP_HW , IDOM11-DEC11 - REDUCAVTCEL - RCELRREDSOM
	                             - RCELREPHS-RCELREPHR-RCELREPHU-RCELREPHT-RCELREPHZ-RCELREPHX ) , 0)
              * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCELREPHW = max( 0, RCELREPHW_1 * (1 - ART1731BIS)
                 + min (RCELREPHW_1 , max(RCELREPHW_P, RCELREPHW1731+0)) * ART1731BIS ) 
	    * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCELREPHV_1 = max( min( RCELREP_HV , IDOM11-DEC11 - REDUCAVTCEL - RCELRREDSOM
	                             - RCELREPHS-RCELREPHR-RCELREPHU-RCELREPHT-RCELREPHZ-RCELREPHX-RCELREPHW ) , 0)
              * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCELREPHV = max( 0, RCELREPHV_1 * (1 - ART1731BIS)
                 + min (RCELREPHV_1 , max(RCELREPHV_P, RCELREPHV1731+0)) * ART1731BIS ) 
	    * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCELREPHF_1 = max( min( ACELREPHF , IDOM11-DEC11 - REDUCAVTCEL - RCELRREDSOM
	                            -somme (i=S,R,U,T,Z,X,W,V : RCELREPHi) ) , 0)
	      * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCELREPHF = max( 0, RCELREPHF_1 * (1 - ART1731BIS)
                 + min (RCELREPHF_1 , max(RCELREPHF_P, RCELREPHF1731+0)) * ART1731BIS ) 
	    * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCELREPHE_1 = max( min( ACELREPHE , IDOM11-DEC11 - REDUCAVTCEL - RCELRREDSOM
	                            -somme (i=S,R,U,T,Z,X,W,V,F : RCELREPHi) ) , 0)
	      * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCELREPHE = max( 0, RCELREPHE_1 * (1 - ART1731BIS)
                 + min (RCELREPHE_1 , max(RCELREPHE_P, RCELREPHE1731+0)) * ART1731BIS ) 
	    * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCELREPHD_1 = max( min( ACELREPHD , IDOM11-DEC11 - REDUCAVTCEL - RCELRREDSOM
	                            -somme (i=S,R,U,T,Z,X,W,V,F,E : RCELREPHi) ) , 0)
	    * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCELREPHD = max( 0, RCELREPHD_1 * (1 - ART1731BIS)
                 + min (RCELREPHD_1 , max(RCELREPHD_P, RCELREPHD1731+0)) * ART1731BIS ) 
	    * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCELREPHH_1 = max( min( ACELREPHH , IDOM11-DEC11 - REDUCAVTCEL - RCELRREDSOM
	                            -somme (i=S,R,U,T,Z,X,W,V,F,E,D : RCELREPHi) ) , 0)
	      * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCELREPHH = max( 0, RCELREPHH_1 * (1 - ART1731BIS)
                 + min (RCELREPHH_1 , max(RCELREPHH_P, RCELREPHH1731+0)) * ART1731BIS ) 
	    * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCELREPHG_1 = max( min( ACELREPHG , IDOM11-DEC11 - REDUCAVTCEL - RCELRREDSOM
	                            -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H : RCELREPHi) ) , 0)
	      * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCELREPHG = max( 0, RCELREPHG_1 * (1 - ART1731BIS)
                 + min (RCELREPHG_1 , max(RCELREPHG_P, RCELREPHG1731+0)) * ART1731BIS ) 
	    * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCELREPHB_1 = max( min( ACELREPHB , IDOM11-DEC11 - REDUCAVTCEL - RCELRREDSOM
	                            -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G : RCELREPHi) ) , 0)
	      * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCELREPHB = max( 0, RCELREPHB_1 * (1 - ART1731BIS)
                 + min (RCELREPHB_1 , max(RCELREPHB_P, RCELREPHB1731+0)) * ART1731BIS ) 
	    * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCELREPHA_1 = max( min( ACELREPHA , IDOM11-DEC11 - REDUCAVTCEL - RCELRREDSOM
	                            -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B : RCELREPHi) ) , 0)
	      * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCELREPHA = max( 0, RCELREPHA_1 * (1 - ART1731BIS)
                 + min (RCELREPHA_1 , max(RCELREPHA_P, RCELREPHA1731+0)) * ART1731BIS ) 
	    * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCELREPGU_1 = max( min( ACELREPGU , IDOM11-DEC11 - REDUCAVTCEL - RCELRREDSOM
	                            -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : RCELREPHi) ) , 0)
	      * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCELREPGU = max( 0, RCELREPGU_1 * (1 - ART1731BIS)
                 + min (RCELREPGU_1 ,max(RCELREPGU_P , RCELREPGU1731+0)) * ART1731BIS 
               ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCELREPGX_1 = max( min( ACELREPGX , IDOM11-DEC11 - REDUCAVTCEL - RCELRREDSOM
	                            -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : RCELREPHi)
                                    -RCELREPGU ) , 0)
	      * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCELREPGX = max( 0, RCELREPGX_1 * (1 - ART1731BIS)
                 + min (RCELREPGX_1 ,max(RCELREPGX_P , RCELREPGX1731+0)) * ART1731BIS 
               ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCELREPGT_1 = max( min( ACELREPGT , IDOM11-DEC11 - REDUCAVTCEL - RCELRREDSOM
	                            -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : RCELREPHi)
                                    -somme (i=U,X : RCELREPGi ) ) , 0)
	      * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCELREPGT = max( 0, RCELREPGT_1 * (1 - ART1731BIS)
                 + min (RCELREPGT_1 ,max(RCELREPGT_P , RCELREPGT1731+0)) * ART1731BIS 
               ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCELREPGS_1 = max( min( ACELREPGS , IDOM11-DEC11 - REDUCAVTCEL - RCELRREDSOM
	                            -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : RCELREPHi)
                                    -somme (i=U,X,T : RCELREPGi ) ) , 0)
	      * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCELREPGS = max( 0, RCELREPGS_1 * (1 - ART1731BIS)
                 + min (RCELREPGS_1 ,max(RCELREPGS_P , RCELREPGS1731+0)) * ART1731BIS 
               ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCELREPGW_1 = max( min( ACELREPGW , IDOM11-DEC11 - REDUCAVTCEL - RCELRREDSOM
	                            -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : RCELREPHi)
                                    -somme (i=U,X,T,S : RCELREPGi ) ) , 0)
	      * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCELREPGW = max( 0, RCELREPGW_1 * (1 - ART1731BIS)
                 + min (RCELREPGW_1 ,max(RCELREPGW_P , RCELREPGW1731+0)) * ART1731BIS 
               ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCELREPGP_1 = max( min( ACELREPGP , IDOM11-DEC11 - REDUCAVTCEL - RCELRREDSOM
	                            -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : RCELREPHi)
                                    -somme (i=U,X,T,S,W : RCELREPGi )) , 0)
	      * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCELREPGP = max( 0, RCELREPGP_1 * (1 - ART1731BIS)
                 + min (RCELREPGP_1 ,max(RCELREPGP_P , RCELREPGP1731+0)) * ART1731BIS 
               ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCELREPGL_1 = max( min( ACELREPGL , IDOM11-DEC11 - REDUCAVTCEL - RCELRREDSOM
	                            -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : RCELREPHi)
                                    -somme (i=U,X,T,S,W,P : RCELREPGi )) , 0)
	      * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCELREPGL = max( 0, RCELREPGL_1 * (1 - ART1731BIS)
                 + min (RCELREPGL_1 ,max(RCELREPGL_P , RCELREPGL1731+0)) * ART1731BIS 
               ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCELREPGV_1 = max( min( ACELREPGV , IDOM11-DEC11 - REDUCAVTCEL - RCELRREDSOM
	                            -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : RCELREPHi)
                                    -somme (i=U,X,T,S,W,P,L : RCELREPGi )) , 0)
	      * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCELREPGV = max( 0, RCELREPGV_1 * (1 - ART1731BIS)
                 + min (RCELREPGV_1 ,max(RCELREPGV_P , RCELREPGV1731+0)) * ART1731BIS 
               ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCELREPGK_1 = max( min( ACELREPGK , IDOM11-DEC11 - REDUCAVTCEL - RCELRREDSOM
	                            -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : RCELREPHi)
                                    -somme (i=U,X,T,S,W,P,L,V : RCELREPGi )) , 0)
	      * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCELREPGK = max( 0, RCELREPGK_1 * (1 - ART1731BIS)
                 + min (RCELREPGK_1 ,max(RCELREPGK_P , RCELREPGK1731+0)) * ART1731BIS 
               ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCELREPGJ_1 = max( min( ACELREPGJ , IDOM11-DEC11 - REDUCAVTCEL - RCELRREDSOM
	                            -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : RCELREPHi)
                                    -somme (i=U,X,T,S,W,P,L,V,K : RCELREPGi )) , 0)
	      * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCELREPGJ = max( 0, RCELREPGJ_1 * (1 - ART1731BIS)
                 + min (RCELREPGJ_1 ,max(RCELREPGJ_P , RCELREPGJ1731+0)) * ART1731BIS 
               ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCELHM_1 = (max( min( RCEL_HM , 
                  IDOM11-DEC11 - REDUCAVTCEL - RCELRREDSOM 
	          -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : RCELREPHi) 
                  -somme (i=U,X,T,S,W,P,L,V,K,J : RCELREPGi )) , 0))
	  * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCELHM = max( 0, RCELHM_1 * (1 - ART1731BIS)
              + min (RCELHM_1 , max(RCELHM_P , RCELHM1731+0)) * ART1731BIS 
	    ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCELHL_1 = (max( min( RCEL_HL , 
                  IDOM11-DEC11 - REDUCAVTCEL - RCELRREDSOM 
	          -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : RCELREPHi) 
                  -somme (i=U,X,T,S,W,P,L,V,K,J : RCELREPGi )
                  -RCELHM) , 0 ))
	   * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCELHL = max( 0, RCELHL_1 * (1 - ART1731BIS)
              + min (RCELHL_1 , max(RCELHL_P , RCELHL1731+0)) * ART1731BIS 
	    ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCELHNO_1 = (max( min( RCEL_HNO , 
                  IDOM11-DEC11 - REDUCAVTCEL - RCELRREDSOM 
	          -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : RCELREPHi) 
                  -somme (i=U,X,T,S,W,P,L,V,K,J : RCELREPGi )
	          -RCELHM-RCELHL) , 0 ))
	   * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCELHNO = max( 0, RCELHNO_1 * (1 - ART1731BIS)
              + min (RCELHNO_1 , max(RCELHNO_P , RCELHNO1731+0)) * ART1731BIS 
	    ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCELHJK_1 = (max( min( RCEL_HJK , 
                  IDOM11-DEC11 - REDUCAVTCEL - RCELRREDSOM 
	          -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : RCELREPHi) 
                  -somme (i=U,X,T,S,W,P,L,V,K,J : RCELREPGi )
	          -RCELHM-RCELHL-RCELHNO) , 0 ))
	   * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCELHJK = max( 0, RCELHJK_1 * (1 - ART1731BIS)
              + min (RCELHJK_1 , max(RCELHJK_P , RCELHJK1731+0)) * ART1731BIS 
	    ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCELNQ_1 = max( min( RCEL_NQ , 
                  IDOM11-DEC11 - REDUCAVTCEL - RCELRREDSOM 
	          -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : RCELREPHi) 
                  -somme (i=U,X,T,S,W,P,L,V,K,J : RCELREPGi )
	          -RCELHM-RCELHL-RCELHNO-RCELHJK ) , 0 )
	 * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCELNQ = max( 0, RCELNQ_1 * (1 - ART1731BIS)
              + min (RCELNQ_1 , max(RCELNQ_P , RCELNQ1731+0)) * ART1731BIS 
	    ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCELNBGL_1 = max( min( RCEL_NBGL , 
                  IDOM11-DEC11 - REDUCAVTCEL - RCELRREDSOM 
	          -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : RCELREPHi) 
                  -somme (i=U,X,T,S,W,P,L,V,K,J : RCELREPGi )
	          -RCELHM-RCELHL-RCELHNO-RCELHJK-RCELNQ ) , 0 )
	   * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCELNBGL = max( 0, RCELNBGL_1 * (1 - ART1731BIS)
              + min (RCELNBGL_1 , max(RCELNBGL_P , RCELNBGL1731+0)) * ART1731BIS 
	    ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCELCOM_1 = (max( min( RCEL_COM , 
                  IDOM11-DEC11 - REDUCAVTCEL - RCELRREDSOM 
	          -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : RCELREPHi) 
                  -somme (i=U,X,T,S,W,P,L,V,K,J : RCELREPGi )
	          -RCELHM-RCELHL-RCELHNO-RCELHJK-RCELNQ-RCELNBGL ) , 0 ))
	  * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCELCOM = max( 0, RCELCOM_1 * (1 - ART1731BIS)
               + min (RCELCOM_1 , max(RCELCOM_P , RCELCOM1731+0)) * ART1731BIS 
             ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCEL_1 = max( min( RCEL_2011 , 
                  IDOM11-DEC11 - REDUCAVTCEL - RCELRREDSOM 
	          -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : RCELREPHi) 
                  -somme (i=U,X,T,S,W,P,L,V,K,J : RCELREPGi )
	          -RCELHM-RCELHL-RCELHNO-RCELHJK-RCELNQ-RCELNBGL-RCELCOM ) , 0 )
	     * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;



RCEL = max( 0, RCEL_1 * (1 - ART1731BIS)
              + min (RCEL_1 , max(RCEL_P , RCEL1731+0)) * ART1731BIS 
	    ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCELJP_1 = max( min( RCEL_JP , 
                  IDOM11-DEC11 - REDUCAVTCEL - RCELRREDSOM 
	          -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : RCELREPHi) 
                  -somme (i=U,X,T,S,W,P,L,V,K,J : RCELREPGi )
	          -RCELHM-RCELHL-RCELHNO-RCELHJK-RCELNQ-RCELNBGL-RCELCOM-RCEL ) , 0 )
	 * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCELJP = max( 0, RCELJP_1 * (1 - ART1731BIS)
              + min (RCELJP_1 , max(RCELJP_P , RCELJP1731+0)) * ART1731BIS 
	    ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCELJBGL_1 = max( min( RCEL_JBGL , 
                  IDOM11-DEC11 - REDUCAVTCEL - RCELRREDSOM 
	          -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : RCELREPHi) 
                  -somme (i=U,X,T,S,W,P,L,V,K,J : RCELREPGi )
	          -RCELHM-RCELHL-RCELHNO-RCELHJK-RCELNQ-RCELNBGL-RCELCOM-RCEL-RCELJP ) , 0 )
	   * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCELJBGL = max( 0, RCELJBGL_1 * (1 - ART1731BIS)
              + min (RCELJBGL_1 , max(RCELJBGL_P , RCELJBGL1731+0)) * ART1731BIS 
	    ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCELJOQR_1 = max( min( RCEL_JOQR , 
                  IDOM11-DEC11 - REDUCAVTCEL - RCELRREDSOM 
	          -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : RCELREPHi) 
                  -somme (i=U,X,T,S,W,P,L,V,K,J : RCELREPGi )
	          -RCELHM-RCELHL-RCELHNO-RCELHJK-RCELNQ-RCELNBGL-RCELCOM-RCEL-RCELJP-RCELJBGL) , 0 )
	  * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCELJOQR = max( 0, RCELJOQR_1 * (1 - ART1731BIS)
              + min (RCELJOQR_1 , max(RCELJOQR_P , RCELJOQR1731+0)) * ART1731BIS 
	    ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCEL2012_1 = max( min( RCEL_2012 , 
                  IDOM11-DEC11 - REDUCAVTCEL - RCELRREDSOM 
	          -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : RCELREPHi) 
                  -somme (i=U,X,T,S,W,P,L,V,K,J : RCELREPGi )
	          -RCELHM-RCELHL-RCELHNO-RCELHJK-RCELNQ-RCELNBGL-RCELCOM-RCEL-RCELJP
	          -RCELJBGL-RCELJOQR) , 0 )
	     * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCEL2012 = max( 0, RCEL2012_1 * (1 - ART1731BIS)
              + min (RCEL2012_1 , max(RCEL2012_P , RCEL20121731+0)) * ART1731BIS 
	    ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCELFD_1 = max( min( RCEL_FD , 
                  IDOM11-DEC11 - REDUCAVTCEL - RCELRREDSOM 
	          -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : RCELREPHi) 
                  -somme (i=U,X,T,S,W,P,L,V,K,J : RCELREPGi )
	          -RCELHM-RCELHL-RCELHNO-RCELHJK-RCELNQ-RCELNBGL-RCELCOM-RCEL-RCELJP
	          -RCELJBGL-RCELJOQR-RCEL2012) , 0 )
	     * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCELFD = max( 0, RCELFD_1 * (1 - ART1731BIS)
              + min (RCELFD_1 , max(RCELFD_P , RCELFD1731+0)) * ART1731BIS 
	    ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCELFABC_1 = max( min( RCEL_FABC , 
                  IDOM11-DEC11 - REDUCAVTCEL - RCELRREDSOM 
	          -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : RCELREPHi) 
                  -somme (i=U,X,T,S,W,P,L,V,K,J : RCELREPGi )
	          -RCELHM-RCELHL-RCELHNO-RCELHJK-RCELNQ-RCELNBGL-RCELCOM-RCEL-RCELJP
	          -RCELJBGL-RCELJOQR-RCEL2012-RCELFD) , 0 )
	     * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCELFABC = max( 0, RCELFABC_1 * (1 - ART1731BIS)
              + min (RCELFABC_1 , max(RCELFABC_P , RCELFABC1731+0)) * ART1731BIS 
	    ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCELTOT = RCELRREDSOM
	  + somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : RCELREPHi) 
          + somme (i=U,X,T,S,W,P,L,V,K,J : RCELREPGi )
	  + RCELHM + RCELHL + RCELHNO + RCELHJK + RCELNQ + RCELNBGL + RCELCOM
	  + RCEL + RCELJP + RCELJBGL + RCELJOQR + RCEL2012 + RCELFD + RCELFABC ;

RCELTOT_1 = RCELRREDSOM_1
	  + somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : RCELREPHi_1) 
          + somme (i=U,X,T,S,W,P,L,V,K,J : RCELREPGi_1 )
	  + RCELHM_1 + RCELHL_1 + RCELHNO_1 + RCELHJK_1 + RCELNQ_1 + RCELNBGL_1 + RCELCOM_1
	  + RCEL_1 + RCELJP_1 + RCELJBGL_1 + RCELJOQR_1 + RCEL2012_1 + RCELFD_1 + RCELFABC_1 ;

regle 2004079 :
application : iliad , batch  ;


RIVCELFABC1 = (  positif(CELLIERFA) * arr(BCEL_FABC * (TX13/100))
               + positif(CELLIERFB) * arr(BCEL_FABC * (TX6/100))
               + positif(CELLIERFC) * arr(BCEL_FABC * (TX24/100))
              ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;
 
RIVCELFABC8 = (arr((min (CELLIERFA+CELLIERFB+CELLIERFC,LIMCELLIER) * positif(CELLIERFA) * (TX13/100))
          +(min (CELLIERFA+CELLIERFB+CELLIERFC,LIMCELLIER) * positif(CELLIERFB) * (TX6/100))
          +(min (CELLIERFA+CELLIERFB+CELLIERFC,LIMCELLIER) * positif(CELLIERFC) * (TX24/100)))
          -( 8 * RIVCELFABC1))
          * (1 - V_CNR);

RIVCELFD1 = positif( CELLIERFD ) * arr (BCEL_FD * (TX24/100))
             * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RIVCELFD4 = (arr((min (CELLIERFD, LIMCELLIER) * positif(CELLIERFD) * (TX24/100)))
              - ( 4 * RIVCELFD1))
             * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RIVCEL1 =  RCEL_2011_R * positif(ACEL_R); 

RIVCEL2 = RIVCEL1;

RIVCEL3 = RIVCEL1;

RIVCEL4 = RIVCEL1;

RIVCEL5 = RIVCEL1;

RIVCEL6 = RIVCEL1;

RIVCEL7 = RIVCEL1;

RIVCEL8 = (arr((min (CELSOMN,LIMCELLIER) * positif(CELLIERNM+CELLIERNN) * (TX40/100))
          +(min (CELSOMN,LIMCELLIER) * positif(CELLIERNK+CELLIERNO) * (TX36/100))
	  +(min (CELSOMN,LIMCELLIER) * positif(CELLIERNC+CELLIERND+CELLIERNH) * (TX25/100))
	  +(min (CELSOMN,LIMCELLIER) * positif(CELLIERNA+CELLIERNE) * (TX22/100))
	  +(min (CELSOMN,LIMCELLIER) * positif(CELLIERNI) * (TX15/100))
	  +(min (CELSOMN,LIMCELLIER) * positif(CELLIERNF+CELLIERNJ) * (TX13/100)))
	  -( 8 * RIVCEL1))
	  * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;
RIV2012CEL1 =  RCEL_2012_R * positif(ACEL2012_R) ;
RIV2012CEL2 = RIV2012CEL1;
RIV2012CEL3 = RIV2012CEL1;
RIV2012CEL4 = RIV2012CEL1;
RIV2012CEL5 = RIV2012CEL1;
RIV2012CEL6 = RIV2012CEL1;
RIV2012CEL7 = RIV2012CEL1;

RIV2012CEL8 = (arr((min (CELSOMJ,LIMCELLIER) * positif(CELLIERJM) * (TX36/100))
		+(min (CELSOMJ,LIMCELLIER) * positif(CELLIERJK+CELLIERJN) * (TX24/100))
		+(min (CELSOMJ,LIMCELLIER) * positif(CELLIERJD) * (TX22/100))
		+(min (CELSOMJ,LIMCELLIER) * positif(CELLIERJA+CELLIERJE+CELLIERJH) * (TX13/100))
		+(min (CELSOMJ,LIMCELLIER) * positif(CELLIERJF+CELLIERJJ) * (TX6/100)))
	 	-( 8 * RIV2012CEL1))
 		* (1 - V_CNR);


RIVCELNBGL1 =  RCEL_NBGL_R * positif(ACELNBGL_R); 
RIVCELNBGL2 = RIVCELNBGL1;
RIVCELNBGL3 = RIVCELNBGL1;
RIVCELNBGL4 = RIVCELNBGL1;
RIVCELNBGL5 = RIVCELNBGL1;
RIVCELNBGL6 = RIVCELNBGL1;
RIVCELNBGL7 = RIVCELNBGL1;

RIVCELNBGL8 = (arr((min (CELLIERNB+CELLIERNG+CELLIERNL,LIMCELLIER) * positif(CELLIERNB) * (TX25/100))
          +(min (CELLIERNB+CELLIERNG+CELLIERNL,LIMCELLIER) * positif(CELLIERNG) * (TX15/100))
	  +(min (CELLIERNB+CELLIERNG+CELLIERNL,LIMCELLIER) * positif(CELLIERNL) * (TX40/100)))
	  -( 8 * RIVCELNBGL1))
	  * (1 - V_CNR);

RIVCELJBGL1 =  RCEL_JBGL_R * positif(ACELJBGL_R); 
RIVCELJBGL2 = RIVCELJBGL1;
RIVCELJBGL3 = RIVCELJBGL1;
RIVCELJBGL4 = RIVCELJBGL1;
RIVCELJBGL5 = RIVCELJBGL1;
RIVCELJBGL6 = RIVCELJBGL1;
RIVCELJBGL7 = RIVCELJBGL1;

RIVCELJBGL8 = (arr((min (CELLIERJB+CELLIERJG+CELLIERJL,LIMCELLIER) * positif(CELLIERJB) * (TX22/100))
          +(min (CELLIERJB+CELLIERJG+CELLIERJL,LIMCELLIER) * positif(CELLIERJG) * (TX13/100))
	  +(min (CELLIERJB+CELLIERJG+CELLIERJL,LIMCELLIER) * positif(CELLIERJL) * (TX36/100)))
	  -( 8 * RIVCELJBGL1))
	  * (1 - V_CNR);


RIVCELCOM1 =  RCEL_COM_R * positif(ACELCOM_R); 

RIVCELCOM2 = RIVCELCOM1;

RIVCELCOM3 = RIVCELCOM1;

RIVCELCOM4 = (arr((min (CELLIERNP+CELLIERNR+CELLIERNS+CELLIERNT, LIMCELLIER) * positif(CELLIERNP+CELLIERNT) * (TX36/100))
          +(min (CELLIERNP+CELLIERNR+CELLIERNS+CELLIERNT,LIMCELLIER) * positif(CELLIERNR+CELLIERNS) * (TX40/100)))
	  -( 4 * RIVCELCOM1))
	  * (1 - V_CNR);

RIVCELJOQR1 =  RCEL_JOQR_R * positif(ACELJOQR_R); 
RIVCELJOQR2 = RIVCELJOQR1;
RIVCELJOQR3 = RIVCELJOQR1;
RIVCELJOQR4 = (arr((min (CELLIERJO + CELLIERJQ + CELLIERJR, LIMCELLIER) * positif(CELLIERJQ) * (TX36/100))
          +(min (CELLIERJO + CELLIERJQ + CELLIERJR, LIMCELLIER) * positif(CELLIERJO+CELLIERJR) * (TX24/100)))
	  -( 4 * RIVCELJOQR1))
	  * (1 - V_CNR);


RIVCELNQ1 =  RCEL_NQ_R * positif(ACELNQ_R); 

RIVCELNQ2 = RIVCELNQ1;

RIVCELNQ3 = RIVCELNQ1;

RIVCELNQ4 = (arr((min (CELLIERNQ, LIMCELLIER) * positif(CELLIERNQ) * (TX40/100)))
	  -( 4 * RIVCELNQ1))
	  * (1 - V_CNR);

RIVCELJP1 =  RCEL_JP_R * positif(ACELJP_R); 
RIVCELJP2 = RIVCELJP1;
RIVCELJP3 = RIVCELJP1;

RIVCELJP4 = (arr((min (CELLIERJP, LIMCELLIER) * positif(CELLIERJP) * (TX36/100)))
	  -( 4 * RIVCELJP1))
	  * (1 - V_CNR);


RIVCELHJK1 = RCEL_HJK_R * positif(ACELHJK_R) ; 

RIVCELHJK2 = RIVCELHJK1;

RIVCELHJK3 = RIVCELHJK1;

RIVCELHJK4 = RIVCELHJK1;

RIVCELHJK5 = RIVCELHJK1;

RIVCELHJK6 = RIVCELHJK1;

RIVCELHJK7 = RIVCELHJK1;

RIVCELHJK8 = (arr((min ((CELLIERHK + CELLIERHJ + 0 ), LIMCELLIER ) * positif(CELLIERHJ) * (TX25/100))
	     + (min ((CELLIERHK + CELLIERHJ + 0 ), LIMCELLIER ) * positif(CELLIERHK) * (TX40/100)))  
	     - ( 8 * RIVCELHJK1))
	     * (1 - V_CNR);

RIVCELHNO1 = RCEL_HNO_R * positif(ACELHNO_R) ; 

RIVCELHNO2 = RIVCELHNO1;

RIVCELHNO3 = RIVCELHNO1;

RIVCELHNO4 = RIVCELHNO1;

RIVCELHNO5 = RIVCELHNO1;

RIVCELHNO6 = RIVCELHNO1;

RIVCELHNO7 = RIVCELHNO1;

RIVCELHNO8 = (arr((min ((CELLIERHN + CELLIERHO + 0 ), LIMCELLIER ) * positif(CELLIERHN) * (TX25/100))
	     + (min ((CELLIERHN + CELLIERHO + 0 ), LIMCELLIER ) * positif(CELLIERHO) * (TX40/100)))  
	     - ( 8 * RIVCELHNO1))
	     * (1 - V_CNR);

RIVCELHLM1 = RCEL_HL_R * positif(ACELHL_R) + RCEL_HM_R * positif(ACELHM_R); 

RIVCELHLM2 = RIVCELHLM1;

RIVCELHLM3 = RIVCELHLM1;

RIVCELHLM4 = RIVCELHLM1;

RIVCELHLM5 = RIVCELHLM1;

RIVCELHLM6 = RIVCELHLM1;

RIVCELHLM7 = RIVCELHLM1;

RIVCELHLM8 = (arr((min ((CELLIERHL + CELLIERHM + 0 ), LIMCELLIER ) * positif(CELLIERHL) * (TX25/100))
	     + (min ((CELLIERHL + CELLIERHM + 0 ), LIMCELLIER ) * positif(CELLIERHM) * (TX40/100)))  
	     - ( 8 * RIVCELHLM1))
	     * (1 - V_CNR);

RRCELMG = max(0, CELRREDMG - RCELRREDMG) * positif(CELRREDMG) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RRCEL2013A = ( max(0, RCEL_2012_R - RCEL2012) * positif(CELSOMJ) 
             + max(0, RCEL_JOQR_R - RCELJOQR) * positif(somme(i=O,Q,R:CELLIERJi)) 
             + max(0, CELREPGV - RCELREPGV) * positif(CELREPGV)
             + max(0, CELREPGJ - RCELREPGJ) * positif(CELREPGJ)
             + max(0, RCEL_FABC_R - RCELFABC ) * positif(CELLIERFA +CELLIERFB + CELLIERFC)
             + max(0, RCEL_FD_R - RCELFD ) * positif(CELLIERFD)
             ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RRCELLF = (max(0, CELRREDLF - RCELRREDLF)) * positif(CELRREDLF) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RRCELLZ = (max(0, CELRREDLZ - RCELRREDLZ)) * positif(CELRREDLZ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;




RRCEL = (max(0, RCEL_2011_R - RCEL)) * positif(CELSOMN) * (1 - V_CNR)
        + (max(0, RCEL_COM_R - RCELCOM)) * positif(somme(i=P,R,S,T:CELLIERNi)) * (1 - V_CNR);


RRCEL2013B = (max(0, CELREPGW + CELREPGL + CELREPGK + ACELREPHG_R + ACELREPHA_R + RRCEL + RCEL_JBGL_R + RCEL_JP_R
                     -(RCELREPGW + RCELREPGL + RCELREPGK + RCELREPHG + RCELREPHA + RCELJBGL + RCELJP)
                 )
                   * positif(CELREPGW + CELREPGL + CELREPGK + CELREPHG + CELREPHA + positif(CELSOMN)
			     +somme(i=P,R,S,T:CELLIERNi) + somme(i=B,G,L,P:CELLIERJi))   
             )
               * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RRCELLC = max(0, CELRREDLC - RCELRREDLC) * positif(CELRREDLC) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RRCELLD = max(0, CELRREDLD - RCELRREDLD) * positif(CELRREDLD) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RRCELLS = max(0, CELRREDLS - RCELRREDLS) * positif(CELRREDLS) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RRCEL2013C = (max(0,   CELREPGX + CELREPGS + CELREPGP
	             + ACELREPHH_R + ACELREPHD_R + ACELREPHB_R + RCELREP_HW_R + RCELREP_HV_R
                     + RCEL_NQ_R   + RCEL_NBGL_R + RCEL_HJK_R
                     -( RCELREPGX + RCELREPGS + RCELREPGP
                       + RCELREPHH + RCELREPHD + RCELREPHB + RCELREPHW  + RCELREPHV
		       +RCELNQ + RCELNBGL + RCELHJK )))
               * positif( CELREPGX + CELREPGS + CELREPGP
                         +CELREPHH + CELREPHD + CELREPHB + CELREPHW + CELREPHV 
			 +somme(i=Q,B,G,L:CELLIERNi) + CELLIERHJ + CELLIERHK)   
               * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RRCELLA = max(0, CELRREDLA - RCELRREDLA) * positif(CELRREDLA) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RRCELLB = max(0, CELRREDLB - RCELRREDLB) * positif(CELRREDLB) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RRCELLE = max(0, CELRREDLE - RCELRREDLE) * positif(CELRREDLE) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RRCELLM = max(0, CELRREDLM - RCELRREDLM) * positif(CELRREDLM) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ; 

RRCELHH = (max(0, RCEL_HL_R+RCEL_HM_R+RCEL_HNO_R + somme(i=R,S,T,U,X,Z:RCELREP_Hi_R) 
                 -(RCELHL +RCELHM +RCELHNO  + somme(i=R,S,T,U,X,Z:RCELREPHi))))
               * positif(somme(i=R,S,T,U,X,Z:CELREPHi)+somme(i=L,M,N,O:CELLIERHi))
	       * (1 - V_CNR);

RRCEL2013D = (max(0, CELREPGU + CELREPGT + ACELREPHF_R + ACELREPHE_R + RRCELHH
                     - (RCELREPGU + RCELREPGT + RCELREPHF + RCELREPHE)))
               * positif(somme (i=S,R,U,T,Z,X,F,E:CELREPHi) + somme(i=M,L,N,O:CELLIERHi 
                         + CELREPGU + CELREPGT ))
               * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;



	 
REPCELFABC = 7 * RIVCELFABC1 + RIVCELFABC8;
REPCELFD = 3 * RIVCELFD1 + RIVCELFD4;  

REPCEL = somme(i=1,2,3,4,5,6,7 : RIVCELi) + RIVCEL8;  
REPCEL2012 = somme(i=1,2,3,4,5,6,7 : RIV2012CELi) + RIV2012CEL8;  

REPCELNBGL = somme(i=1,2,3,4,5,6,7 : RIVCELNBGLi) + RIVCELNBGL8;  
REPCELJBGL = somme(i=1,2,3,4,5,6,7 : RIVCELJBGLi) + RIVCELJBGL8;  

REPCELCOM = somme(i=1,2,3 : RIVCELCOMi) + RIVCELCOM4;  
REPCELJOQR = somme(i=1,2,3 : RIVCELJOQRi) + RIVCELJOQR4;  

REPCELNQ = somme(i=1,2,3 : RIVCELNQi) + RIVCELNQ4;  
REPCELJP = somme(i=1,2,3 : RIVCELJPi) + RIVCELJP4;  

REPCELHJK = somme(i=1,2,3,4,5,6,7 : RIVCELHJKi) + RIVCELHJK8;  
REPCELHNO = somme(i=1,2,3,4,5,6,7 : RIVCELHNOi) + RIVCELHNO8;  
REPCELHLM = somme(i=1,2,3,4,5,6,7 : RIVCELHLMi) + RIVCELHLM8;  

regle 40791 :
application : iliad , batch  ;

RITOUR = RILNEUF 
        + RILTRA
	+ RILRES
        + arr((REPINVLOCINV + RINVLOCINV + REPINVTOU + INVLOCXN + COD7UY) * TX_REDIL25 / 100)
        + arr((REPINVLOCREA + RINVLOCREA + INVLOGREHA + INVLOCXV + COD7UZ) * TX_REDIL20 / 100) ;

RIHOTR = arr((INVLOCHOTR1 + INVLOCHOTR + INVLOGHOT) * TX_REDIL25 / 100) * (1-positif(null(2-V_REGCO)+null(4-V_REGCO)));



DTOURREP = REPINVLOCINV + RINVLOCINV + REPINVTOU + INVLOCXN + COD7UY ;
ATOURREP = DTOURREP * (1 - ART1731BIS) 
           + min(DTOURREP , max( ATOURREP_P ,  ATOURREP1731 + 0)) * ART1731BIS ;

DTOUHOTR = INVLOCHOTR1 + INVLOCHOTR + INVLOGHOT ;
ATOUHOTR = (DTOUHOTR * (1 - ART1731BIS) 
            + min(DTOUHOTR , max(ATOUHOTR_P , ATOUHOTR1731 + 0)) * ART1731BIS
	   ) * (1 - positif(null(2 - V_REGCO) + null(4 - V_REGCO))) ;

DTOUREPA = REPINVLOCREA + RINVLOCREA + INVLOGREHA + INVLOCXV + COD7UZ ;
ATOUREPA = DTOUREPA * (1 - ART1731BIS) 
           + min(DTOUREPA , max(ATOUREPA_P , ATOUREPA1731 + 0)) * ART1731BIS ;

regle 10040791 :
application : iliad , batch  ;

RTOURREP_1 = max(min( arr(ATOURREP * TX_REDIL25 / 100) , RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV-RFOR) , 0) ;

RTOURREP = RTOURREP_1 * (1-ART1731BIS) 
           + min( RTOURREP_1 , max(RTOURREP_P , RTOURREP1731+0 )) * ART1731BIS ;

RTOUHOTR_1 = max(min( RIHOTR , RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV-RFOR-RTOURREP) , 0)
	    * (1 - positif(null(2-V_REGCO) + null(4-V_REGCO))) ;

RTOUHOTR = RTOUHOTR_1 * (1-ART1731BIS) 
           + min( RTOUHOTR_1 , max(RTOUHOTR_P , RTOUHOTR1731+0 )) * ART1731BIS ;

RTOUREPA_1 = max(min( arr(ATOUREPA * TX_REDIL20 / 100) ,
                      RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV-RFOR-RTOURREP-RTOUHOTR) , 0) ;

RTOUREPA = RTOUREPA_1 * (1-ART1731BIS) 
           + min( RTOUREPA_1 , max(RTOUREPA_P , RTOUREPA1731+0 )) * ART1731BIS ;

RTOUR = RTOURREP ;

regle 407011 :
application : iliad , batch  ;
BADCRE = min (CREAIDE, min((LIM_AIDOMI * (1 - positif(PREMAIDE)) + LIM_PREMAIDE * positif(PREMAIDE) 
		           + MAJSALDOM * ( positif_ou_nul(V_ANREV-V_0DA-65)
				         + positif_ou_nul(V_ANREV-V_0DB-65)
						     * BOOL_0AM
				         + V_0CF + V_0DJ + V_0DN 
				         + (V_0CH + V_0DP)/2
				         ) 
		           ),LIM_AIDOMI3 * (1 - positif(PREMAIDE)) + LIM_PREMAIDE2 * positif(PREMAIDE) ) * (1-positif(INAIDE + 0))
                    +  LIM_AIDOMI2 * positif(INAIDE + 0));
BADPLAF = (min((LIM_AIDOMI * (1 - positif(PREMAIDE)) + LIM_PREMAIDE * positif(PREMAIDE) 
		           + MAJSALDOM * ( positif_ou_nul(V_ANREV-V_0DA-65)
				         + positif_ou_nul(V_ANREV-V_0DB-65)
						     * BOOL_0AM
				         + V_0CF + V_0DJ + V_0DN 
				         + (V_0CH + V_0DP)/2
				         ) 
		          ),LIM_AIDOMI3 * (1 - positif(PREMAIDE)) + LIM_PREMAIDE2 * positif(PREMAIDE) ) * (1-positif(INAIDE + 0))
                    +  LIM_AIDOMI2 * positif(INAIDE + 0)) * positif(RVAIDE) ;
BADPLAF2 = (min((LIM_AIDOMI * (1 - positif(PREMAIDE)) + LIM_PREMAIDE * positif(PREMAIDE) 
		           + MAJSALDOM * ( positif_ou_nul(V_ANREV-V_0DA-65)
				         + positif_ou_nul(V_ANREV-V_0DB-65)
						     * BOOL_0AM
				         + ASCAPA  
				         + V_0CF + V_0DJ + V_0DN 
				         + (V_0CH + V_0DP)/2
				         ) 
		          ),LIM_AIDOMI3 * (1 - positif(PREMAIDE)) + LIM_PREMAIDE2 * positif(PREMAIDE) ) * (1-positif(INAIDE + 0))
                    +  LIM_AIDOMI2 * positif(INAIDE + 0)) * positif(RVAIDAS) ;

BAD1 = min(RVAIDE , max(0 , BADPLAF - BADCRE)) ;

BAD2 = min (RVAIDAS , max(0 , BADPLAF2 - BADCRE - BAD1)) ;

BAD = BAD1 + BAD2 ;

RAD = arr(BAD * TX_AIDOMI /100) * (1 - V_CNR) ;

DAIDE = RVAIDE + RVAIDAS ;

AAIDE = (BAD * (1-ART1731BIS) 
         + min(BAD , max(AAIDE_P , AAIDE1731+0)) * ART1731BIS) * (1-V_CNR) ;

RAIDE_1 = max( min( RAD , IDOM11-DEC11-RCOTFOR-RREPA),0);
RAIDE = max( RAIDE_1 * (1-ART1731BIS) 
             + min(RAIDE_1, max(RAIDE_P , RAIDE1731+0)) * ART1731BIS , 0 ) ;

regle 4071 :
application : iliad , batch  ;



DPATNAT1 = PATNAT1;
APATNAT1 = (PATNAT1 * (1-ART1731BIS) 
            + min(PATNAT1 , max(APATNAT1_P , APATNAT11731+0)) * ART1731BIS
           ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


DPATNAT2 = PATNAT2;
APATNAT2 = (PATNAT2 * (1-ART1731BIS) 
            + min(PATNAT2 , max(APATNAT2_P , APATNAT21731+0)) * ART1731BIS
           ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


DPATNAT3 = PATNAT3;
APATNAT3 = (PATNAT3 * (1-ART1731BIS) 
            + min(PATNAT3 , max(APATNAT3_P , APATNAT31731+0)) * ART1731BIS
           ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


BPATNAT = min(PATNAT,LIM_PATNAT) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;
RAPATNAT = arr (BPATNAT * TX_PATNAT/100) ;

DPATNAT = PATNAT;
APATNAT = (BPATNAT * (1-ART1731BIS) 
           + min(BPATNAT , max(APATNAT_P , APATNAT1731+0)) * ART1731BIS
          ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

regle 20004071 :
application : iliad , batch  ;

 


RPATNAT1_1  = max( min( APATNAT1, RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV-RFOR-RTOURREP-RTOUHOTR
                                      -RTOUREPA-RCELTOT-RLOCNPRO) , 0 )
               * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RPATNAT1 = max( 0 , RPATNAT1_1 * (1-ART1731BIS) 
                    + min( RPATNAT1_1 , max(RPATNAT_P , RPATNAT11731+0 )) * ART1731BIS  
              ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RPATNAT2_1 = max( min( APATNAT2, RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV-RFOR-RTOURREP-RTOUHOTR 
			               -RTOUREPA-RCELTOT-RLOCNPRO-RPATNAT1) , 0 )
              * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RPATNAT2 = max( 0 , RPATNAT2_1 * (1-ART1731BIS) 
                    + min( RPATNAT2_1 , max(RPATNAT_P , RPATNAT21731+0 )) * ART1731BIS 
              )* (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RPATNAT3_1 = max( min( APATNAT3, RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV-RFOR-RTOURREP-RTOUHOTR 
			              -RTOUREPA-RCELTOT-RLOCNPRO-RPATNAT1-RPATNAT2) , 0 )
              * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RPATNAT3 = max( 0 , RPATNAT3_1 * (1-ART1731BIS) 
                    + min( RPATNAT3_1 , max(RPATNAT_P , RPATNAT31731+0 )) * ART1731BIS 
              ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RPATNAT_1 = max( min( RAPATNAT , RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV-RFOR-RTOURREP-RTOUHOTR 
			             -RTOUREPA-RCELTOT-RLOCNPRO-RPATNAT1-RPATNAT2-RPATNAT3 ) , 0 ) 
             * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RPATNAT = max( 0 , RPATNAT_1  * (1-ART1731BIS) 
                   + min( RPATNAT_1 , max(RPATNAT_P , RPATNAT1731+0 )) * ART1731BIS  
             ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RPATNATOT = RPATNAT + RPATNAT1 + RPATNAT2 + RPATNAT3 ; 
regle 200040711 :
application : iliad , batch  ;

 

REPNATR1 = max(PATNAT1 - RPATNAT1,0) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

REPNATR2 = max(PATNAT2 - RPATNAT2,0) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

REPNATR3 = max(PATNAT3 - RPATNAT3,0) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

REPNATR = max(RAPATNAT - RPATNAT,0) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

regle 40704 :
application : iliad , batch  ;


RRI1_1 = (IDOM11-DEC11-RCOTFOR-RREPA-RAIDE-RDIFAGRI-RFORET-RFIPDOM-RFIPC-RCINE-RRESTIMO
	     -RSOCREPR-RRPRESCOMP-RHEBE-RSURV-RINNO-RSOUFIP-RRIRENOV
       ) * (1-ART1731BIS)
     + (min(IDOM111731+0,IDOM11) - min(DEC111731+0,DEC11) - min(RCOTFOR1731+0,RCOTFOR) - min(RREPA1731+0,RREPA)
	- min(RFIPDOM1731+0,RFIPDOM) - min(RAIDE1731+0,RAIDE) - min(RDIFAGRI1731+0,RDIFAGRI)
	- min(RFORET1731+0,RFORET) - min(RFIPC1731+0,RFIPC) - min(RCINE1731+0,RCINE) - min(RRESTIMO1731+0,RRESTIMO)
	- min(RSOCREPR1731+0,RSOCREPR) - min(RRPRESCOMP1731+0,RRPRESCOMP) - min(RHEBE1731+0,RHEBE) 
	- min(RSURV1731+0,RSURV) - min(RINNO1731+0,RINNO) - min(RSOUFIP1731+0,RSOUFIP) - min(RRIRENOV1731+0,RRIRENOV)
	) * ART1731BIS ;

RRI1 = IDOM11-DEC11-RCOTFOR-RREPA-RAIDE-RDIFAGRI-RFORET-RFIPDOM-RFIPC-RCINE-RRESTIMO
            -RSOCREPR-RRPRESCOMP-RHEBE-RSURV-RINNO-RSOUFIP-RRIRENOV;

regle 4070111 :
application : iliad , batch  ;
BAH = (min (RVCURE,LIM_CURE) + min(RCCURE,LIM_CURE)) * (1 - V_CNR) ;

RAH = arr (BAH * TX_CURE /100) ;
DHEBE = RVCURE + RCCURE ;

AHEBE = BAH * (1-ART1731BIS)
        + min(BAH , max(AHEBE_P , AHEBE1731 + 0)) * ART1731BIS ;

RHEBE_1 = max( min( RAH , IDOM11-DEC11-RCOTFOR-RREPA-RAIDE-RDIFAGRI-RFORET-RFIPDOM-RFIPC
			-RCINE-RRESTIMO-RSOCREPR-RRPRESCOMP) , 0 );
RHEBE = max( 0, RHEBE_1 * (1-ART1731BIS) 
                + min( RHEBE_1 , max(RHEBE_P , RHEBE1731+0 )) * ART1731BIS ) ;

regle 407013:
application : iliad , batch  ;

DREPA = RDREP + DONETRAN;

EXCEDANTA = max(0,RDREP + DONETRAN - PLAF_REDREPAS) ;

BAA = min( RDREP + DONETRAN, PLAF_REDREPAS ) ;

RAA = arr( (TX_REDREPAS) / 100 * BAA ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

AREPA = ( BAA * (1-ART1731BIS) 
          + min( BAA, max(AREPA_P , AREPA1731+0)) * ART1731BIS 
        ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RREPA_1 = max( min( RAA , IDOM11-DEC11-RCOTFOR) , 0) ;

RREPA = RREPA_1 * (1-ART1731BIS) 
        + min( RREPA_1 , max(RREPA_P , RREPA1731+0 )) * ART1731BIS ;

regle 407014:
application : iliad , batch  ;
DNOUV = REPSNO3 + REPSNO2 + REPSNO1 + REPSNON + COD7CQ + PETIPRISE + RDSNO ;

BSN1 = min (REPSNO3 + REPSNO2 + REPSNO1 + REPSNON + PETIPRISE , LIM_SOCNOUV2 * (1 + BOOL_0AM)) ;
BSN2 = min (COD7CQ + RDSNO , LIM_TITPRISE * (1 + BOOL_0AM) - BSN1) ;

BSNCL = min(REPSNO3 , LIM_SOCNOUV2 * (1 + BOOL_0AM)) ;
RSN_CL =  BSNCL * TX25/100 ;

BSNCM = max(0, min(REPSNO2 , LIM_SOCNOUV2 * (1 + BOOL_0AM) - BSNCL)) ;
RSN_CM = BSNCM * TX25/100 ;

BSNCN = max(0, min(REPSNO1 , LIM_SOCNOUV2 * (1 + BOOL_0AM) - BSNCL - BSNCM)) ;
RSN_CN = BSNCN * TX22/100 ;

BSNCC = max(0, min(REPSNON , LIM_SOCNOUV2 * (1 + BOOL_0AM) - BSNCL - BSNCM - BSNCN)) ;
RSN_CC = BSNCC * TX18/100 ;

BSNCU = max(0, min(PETIPRISE , LIM_SOCNOUV2 * (1 + BOOL_0AM) - BSNCL - BSNCM - BSNCN - BSNCC)) ;
RSN_CU = BSNCU * TX18/100 ;

BSNCQ = max(0, min(COD7CQ , LIM_TITPRISE * (1 + BOOL_0AM) - BSN1)) ;
RSN_CQ = BSNCQ * TX18/100 ;

BSNCF = max(0, min(RDSNO , LIM_TITPRISE * (1 + BOOL_0AM) - BSN1 - BSNCQ)) ;
RSN_CF = BSNCF * TX18/100 ;

RSN = arr(RSN_CL + RSN_CM + RSN_CN + RSN_CC + RSN_CU + RSN_CQ + RSN_CF) * (1 - V_CNR) ;

ANOUV = ((BSN1 + BSN2) * (1-ART1731BIS) 
          + min(BSN1 + BSN2 , max(ANOUV_P , ANOUV1731+0)) * ART1731BIS ) * (1 - V_CNR) ;

regle 200407014:
application : iliad , batch  ;

RSNCL = max(0, min(RSN_CL, RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH)) ;
RSNCM = max(0, min(RSN_CM, RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RSNCL )) ;
RSNCN = max(0, min(RSN_CN, RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RSNCL-RSNCM )) ;
RSNCC = max(0, min(RSN_CC, RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RSNCL-RSNCM-RSNCN )) ;
RSNCU = max(0, min(RSN_CU, RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RSNCL-RSNCM-RSNCN-RSNCC )) ;
RSNCQ = max(0, min(RSN_CQ, RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RSNCL-RSNCM-RSNCN-RSNCC-RSNCU )) ;
RSNCF = max(0, min(RSN_CF, RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RSNCL-RSNCM-RSNCN-RSNCC-RSNCU-RSNCQ )) ;

RNOUV_1 = max( min( RSN , RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH) , 0) ;

RNOUV = ( RNOUV_1 * (1-ART1731BIS)
          + min( RNOUV_1, max( RNOUV_P , RNOUV1731 + 0 )) * ART1731BIS ) * (1 - V_CNR) ;

regle 2004070141:
application : iliad , batch  ;


REPINVPME3 = max(0 , REPSNO2 - max(0 , (LIM_SOCNOUV2 * (1+BOOL_0AM)) - min(REPSNO3 , LIM_SOCNOUV2 * (1+BOOL_0AM)))) 
	      * (1 - V_CNR) ; 

REPINVPME2 = max(0 , REPSNO1 - max(0 , (LIM_SOCNOUV2 * (1+BOOL_0AM)) - (min(REPSNO3 , LIM_SOCNOUV2 * (1+BOOL_0AM)) + REPSNO2))) 
	      * (1 - V_CNR) ;

REPINVPME1 = max(0 , REPSNON - max(0 , (LIM_SOCNOUV2 * (1+BOOL_0AM)) - (min(REPSNO3 , LIM_SOCNOUV2 * (1+BOOL_0AM)) + REPSNO2 + REPSNO1)))
	      * (1 - V_CNR) ;

REPINVPMECU = max(0 , PETIPRISE - max(0 , (LIM_SOCNOUV2 * (1+BOOL_0AM)) - (min(REPSNO3 , LIM_SOCNOUV2 * (1+BOOL_0AM)) + REPSNO2 + REPSNO1 + REPSNON)))
	      * (1 - V_CNR) ;

RINVTPME12 = max(0 , COD7CQ - max(0 , (LIM_TITPRISE * (1+BOOL_0AM)) - (min( BSNCL + REPSNO2 + REPSNO1 + REPSNON + PETIPRISE , LIM_SOCNOUV2 * (1 + BOOL_0AM)))))
	      * (1 - V_CNR) ;

RINVTPME13 = max(0 , RDSNO - max(0 , (LIM_TITPRISE * (1 + BOOL_0AM)) 
			     - max(0 , min( BSNCL + REPSNO2 + REPSNO1 + REPSNON + PETIPRISE , LIM_SOCNOUV2 * (1 + BOOL_0AM)) + COD7CQ)))
	      * (1 - V_CNR) ;



regle 407012:
application : iliad , batch  ;

PLAFREPSN4 = arr( max(0, RSNCF - 10000 )) * (1 - V_CNR) * positif(AVFISCOPTER) ;

regle 40000:
application : iliad , batch  ;

DREDMEUB = REDMEUBLE ;

AREDMEUB = (DREDMEUB * (1 - ART1731BIS) + min(DREDMEUB , AREDMEUB1731 + 0) * ART1731BIS) * (1 - V_CNR) ;

DREDREP = REDREPNPRO ;

AREDREP = (DREDREP * (1 - ART1731BIS) + min(DREDREP , AREDREP1731 + 0) * ART1731BIS) * (1 - V_CNR) ;

DILMIX = LOCMEUBIX ;

AILMIX_R = DILMIX * (1 - V_CNR) ;

AILMIX = (DILMIX * (1 - ART1731BIS) + min(DILMIX , AILMIX1731 + 0) * ART1731BIS) * (1 - V_CNR) ;

DILMIY = LOCMEUBIY ;

AILMIY = (DILMIY * (1 - ART1731BIS) + min(DILMIY , AILMIY1731 + 0) * ART1731BIS) * (1 - V_CNR) ;

DINVRED = INVREDMEU ;

AINVRED = (DINVRED * (1 - ART1731BIS) + min(DINVRED , AINVRED1731 + 0) * ART1731BIS) * (1 - V_CNR) ;

DILMIH = LOCMEUBIH ;

AILMIH_R = DILMIH * (1 - V_CNR);
AILMIH = (DILMIH * (1-ART1731BIS) + min(DILMIH , AILMIH1731+0) * ART1731BIS) * (1-V_CNR);

DILMJC = LOCMEUBJC ;

AILMJC = (DILMJC * (1 - ART1731BIS) + min(DILMJC , AILMJC1731 + 0) * ART1731BIS) * (1 - V_CNR) ;

DILMIZ = LOCMEUBIZ ;

AILMIZ_R = DILMIZ * (1 - V_CNR) ;
AILMIZ = (DILMIZ * (1-ART1731BIS) + min(DILMIZ , AILMIZ1731+0) * ART1731BIS) * (1-V_CNR);

DILMJI = LOCMEUBJI ;

AILMJI = (DILMJI * (1 - ART1731BIS) + min(DILMJI , AILMJI1731 + 0) * ART1731BIS) * (1 - V_CNR) ;

DILMJS = LOCMEUBJS ;

AILMJS = (DILMJS * (1 - ART1731BIS) + min(DILMJS , AILMJS1731 + 0) * ART1731BIS) * (1 - V_CNR) ;

DMEUBLE = REPMEUBLE ;

AMEUBLE = (DMEUBLE * (1 - ART1731BIS) + min(DMEUBLE , AMEUBLE1731 + 0) * ART1731BIS) * (1 - V_CNR) ;

MEUBLERET = arr(DMEUBLE * TX25 / 100) * (1 - V_CNR) ;

DPROREP = INVNPROREP ;

APROREP = (DPROREP * (1-ART1731BIS) + min(DPROREP , APROREP1731+0) * ART1731BIS) * (1-V_CNR);

RETPROREP = arr(DPROREP * TX25 / 100) * (1 - V_CNR) ;

DREPNPRO = INVREPNPRO ;

AREPNPRO = (DREPNPRO * (1-ART1731BIS) + min(DREPNPRO , AREPNPRO1731+0) * ART1731BIS) * (1-V_CNR);

RETREPNPRO = arr(DREPNPRO * TX25 / 100) * (1 - V_CNR) ;

DREPMEU = INVREPMEU ;

AREPMEU = (DREPMEU * (1-ART1731BIS) + min(DREPMEU , AREPMEU1731+0) * ART1731BIS) * (1-V_CNR);

RETREPMEU = arr(DREPMEU * TX25 / 100) * (1 - V_CNR) ;

DILMIC = LOCMEUBIC ;

AILMIC_R = DILMIC * (1 - V_CNR) ;
AILMIC = (DILMIC * (1 - ART1731BIS) + min(DILMIC , AILMIC1731 + 0) * ART1731BIS) * (1 - V_CNR) ;

DILMIB = LOCMEUBIB ;

AILMIB_R = DILMIB * (1 - V_CNR) ;
AILMIB = (DILMIB * (1 - ART1731BIS) + min(DILMIB , AILMIB1731 + 0) * ART1731BIS) * (1 - V_CNR) ;

DILMIA = LOCMEUBIA ;

AILMIA_R = DILMIA * (1 - V_CNR) ;
AILMIA = (DILMIA * (1 - ART1731BIS) + min(DILMIA , AILMIA1731 + 0) * ART1731BIS) * (1 - V_CNR) ;

DILMJY = LOCMEUBJY ;

AILMJY = (DILMJY * (1 - ART1731BIS) + min(DILMJY , AILMJY1731 + 0) * ART1731BIS) * (1 - V_CNR) ;

DILMJX = LOCMEUBJX ;

AILMJX = (DILMJX * (1 - ART1731BIS) + min(DILMJX , AILMJX1731 + 0) * ART1731BIS) * (1 - V_CNR) ;

DILMJW = LOCMEUBJW ;

AILMJW = (DILMJW * (1 - ART1731BIS) + min(DILMJW , AILMJW1731 + 0) * ART1731BIS) * (1 - V_CNR) ;

DILMJV = LOCMEUBJV ;

AILMJV = (DILMJV * (1 - ART1731BIS) + min(DILMJV , AILMJV1731 + 0) * ART1731BIS) * (1 - V_CNR) ;

regle 40002:
application : iliad , batch  ;


RREDMEUB_1 = max(min(AREDMEUB , RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV-RFOR
                                    -RTOURREP-RTOUHOTR-RTOUREPA-RCELTOT) , 0) ;


RREDMEUB = max(0 , RREDMEUB_1 * (1-ART1731BIS) 
               + min( RREDMEUB_1 , max(RREDMEUB_P , RREDMEUB1731+0)) * ART1731BIS 
              ) ;

REPMEUIS = (DREDMEUB - RREDMEUB) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

regle 40004:
application : iliad , batch  ;


RREDREP_1 = max(min(AREDREP , RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV-RFOR
                                  -RTOURREP-RTOUHOTR-RTOUREPA-RCELTOT-RREDMEUB) , 0) ;


RREDREP = max( 0 , RREDREP_1 * (1-ART1731BIS) 
               + min( RREDREP_1 , max(RREDREP_P , RREDREP1731+0 )) * ART1731BIS 
             ) ;

REPMEUIU = (DREDREP - RREDREP) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

regle 40006:
application : iliad , batch  ;


RILMIX_1 = max(min(AILMIX , RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV-RFOR
                                -RTOURREP-RTOUHOTR-RTOUREPA-RCELTOT-RREDMEUB-RREDREP) , 0) ;


RILMIX = max(0 , RILMIX_1 * (1-ART1731BIS) 
             + min( RILMIX_1 , max(RILMIX_P , RILMIX1731+0 )) * ART1731BIS 
            ) ;

REPMEUIX = (AILMIX_R - RILMIX) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

regle 40008:
application : iliad , batch  ;


RILMIY_1 = max(min(AILMIY , RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV-RFOR
                                -RTOURREP-RTOUHOTR-RTOUREPA-RCELTOT-RREDMEUB-RREDREP-RILMIX) , 0) ;


RILMIY = max(0 , RILMIY_1 * (1 - ART1731BIS) 
             + min(RILMIY_1 , max(RILMIY_P , RILMIY1731 + 0)) * ART1731BIS
            ) ;

REPMEUIY = (DILMIY - RILMIY) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;
 
regle 40010:
application : iliad , batch  ;


RINVRED_1 = max(min(AINVRED , RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV-RFOR
                                  -RTOURREP-RTOUHOTR-RTOUREPA-RCELTOT-RREDMEUB-RREDREP-RILMIX-RILMIY) , 0) ;


RINVRED = max( 0 , RINVRED_1 * (1-ART1731BIS) 
               + min( RINVRED_1 , max(RINVRED_P , RINVRED1731+0 )) * ART1731BIS 
             ) ;

REPMEUIT = (DINVRED - RINVRED) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

regle 40012:
application : iliad , batch  ;


RILMIH_1 = max(min(AILMIH , RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV-RFOR
                                -RTOURREP-RTOUHOTR-RTOUREPA-RCELTOT-RREDMEUB-RREDREP-RILMIX-RILMIY
                                -RINVRED) , 0) ;


RILMIH = max(0 , RILMIH_1 * (1 - ART1731BIS)
             + min(RILMIH_1 , max(RILMIH_P , RILMIH1731 + 0)) * ART1731BIS
            ) ; 

REPMEUIH = (AILMIH_R - RILMIH) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

regle 40014:
application : iliad , batch  ;


RILMJC_1 = max(min(AILMJC , RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV-RFOR
                            -RTOURREP-RTOUHOTR-RTOUREPA-RCELTOT-RREDMEUB-RREDREP-RILMIX-RILMIY
                            -RINVRED-RILMIH) , 0) ;


RILMJC = max(0 , RILMJC_1 * (1 - ART1731BIS) 
             + min(RILMJC_1 , max( RILMJC_P , RILMJC1731 + 0)) * ART1731BIS
            ) ;

REPMEUJC = (DILMJC - RILMJC) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

regle 40016:
application : iliad , batch  ;


RILMIZ_1 = max(min(AILMIZ , RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV-RFOR
                            -RTOURREP-RTOUHOTR-RTOUREPA-RCELTOT-RREDMEUB-RREDREP-RILMIX-RILMIY
                            -RINVRED-RILMIH-RILMJC) , 0) ;


RILMIZ = max( 0 , RILMIZ_1 * (1-ART1731BIS) 
              + min( RILMIZ_1 , max(RILMIZ_P , RILMIZ1731+0 )) * ART1731BIS 
            ) ;

REPMEUIZ = (AILMIZ_R - RILMIZ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

regle 40018:
application : iliad , batch  ;


RILMJI_1 = max(min(AILMJI , RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV-RFOR
                            -RTOURREP-RTOUHOTR-RTOUREPA-RCELTOT-RREDMEUB-RREDREP-RILMIX-RILMIY
                            -RINVRED-RILMIH-RILMJC-RILMIZ) , 0) ;


RILMJI = max(0 , RILMJI_1 * (1 - ART1731BIS) 
             + min(RILMJI_1 , max( RILMJI_P , RILMJI1731 + 0)) * ART1731BIS
            ) ;

REPMEUJI = (DILMJI - RILMJI) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

regle 40020:
application : iliad , batch  ;


RILMJS_1 = max(min(AILMJS , RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV-RFOR
                            -RTOURREP-RTOUHOTR-RTOUREPA-RCELTOT-RREDMEUB-RREDREP-RILMIX-RILMIY
                            -RINVRED-RILMIH-RILMJC-RILMIZ-RILMJI) , 0) ;


RILMJS = max(0 , RILMJS_1 * (1 - ART1731BIS) 
             + min(RILMJS_1 , max( RILMJS_P , RILMJS1731 + 0)) * ART1731BIS
            ) ;

REPMEUJS = (DILMJS - RILMJS) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

regle 40022:
application : iliad , batch  ;


RMEUBLE_1 = max(min(MEUBLERET , RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV-RFOR
                                -RTOURREP-RTOUHOTR-RTOUREPA-RCELTOT-RREDMEUB-RREDREP-RILMIX-RILMIY
                                -RINVRED-RILMIH-RILMJC-RILMIZ-RILMJI-RILMJS) , 0) ;


RMEUBLE = max( 0 , RMEUBLE_1 * (1-ART1731BIS) 
               + min( RMEUBLE_1 , max( RMEUBLE_P , RMEUBLE1731+0)) * ART1731BIS 
             ) ;

REPMEUIK = (MEUBLERET - RMEUBLE) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

regle 40024:
application : iliad , batch  ;


RPROREP_1 = max(min( RETPROREP , RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV-RFOR
                                 -RTOURREP-RTOUHOTR-RTOUREPA-RCELTOT-RREDMEUB-RREDREP-RILMIX-RILMIY
                                 -RINVRED-RILMIH-RILMJC-RILMIZ-RILMJI-RILMJS-RMEUBLE) , 0) ;


RPROREP = max( 0 , RPROREP_1 * (1-ART1731BIS) 
               + min( RPROREP_1 , max( RPROREP_P , RPROREP1731+0 )) * ART1731BIS 
             ) ;

REPMEUIR = (RETPROREP - RPROREP) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

regle 40026:
application : iliad , batch  ;


RREPNPRO_1 = max(min( RETREPNPRO , RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV-RFOR
                                   -RTOURREP-RTOUHOTR-RTOUREPA-RCELTOT-RREDMEUB-RREDREP-RILMIX-RILMIY
                                   -RINVRED-RILMIH-RILMJC-RILMIZ-RILMJI-RILMJS-RMEUBLE-RPROREP) , 0) ; 


RREPNPRO = max( 0 , RREPNPRO_1 * (1-ART1731BIS) 
                + min( RREPNPRO_1 , max( RREPNPRO_P , RREPNPRO1731+0)) * ART1731BIS 
              ) ;

REPMEUIQ = (RETREPNPRO - RREPNPRO) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

regle 40028:
application : iliad , batch  ;


RREPMEU_1 = max(min(RETREPMEU , RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV-RFOR
                                -RTOURREP-RTOUHOTR-RTOUREPA-RCELTOT-RREDMEUB-RREDREP-RILMIX-RILMIY
                                -RINVRED-RILMIH-RILMJC-RILMIZ-RILMJI-RILMJS-RMEUBLE-RPROREP-RREPNPRO) , 0) ; 


RREPMEU = max( 0 , RREPMEU_1 * (1-ART1731BIS) 
               + min( RREPMEU_1 , max(RREPMEU_P , RREPMEU1731+0)) * ART1731BIS 
             ) ;

REPMEUIP = (RETREPMEU - RREPMEU) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

regle 40030:
application : iliad , batch  ;


RILMIC_1 = max(min(AILMIC , RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV-RFOR
                            -RTOURREP-RTOUHOTR-RTOUREPA-RCELTOT-RREDMEUB-RREDREP-RILMIX-RILMIY
			    -RINVRED-RILMIH-RILMJC-RILMIZ-RILMJI-RILMJS-RMEUBLE-RPROREP-RREPNPRO
                            -RREPMEU) , 0) ;


RILMIC = max( 0 , RILMIC_1 * (1-ART1731BIS) 
              + min( RILMIC_1 , max(RILMIC_P , RILMIC1731+0 )) * ART1731BIS 
            ) ;

REPMEUIC = (AILMIC_R - RILMIC) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

regle 40032:
application : iliad , batch  ;


RILMIB_1 = max(min(AILMIB , RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV-RFOR
                            -RTOURREP-RTOUHOTR-RTOUREPA-RCELTOT-RREDMEUB-RREDREP-RILMIX-RILMIY
			    -RINVRED-RILMIH-RILMJC-RILMIZ-RILMJI-RILMJS-RMEUBLE-RPROREP-RREPNPRO
                            -RREPMEU-RILMIC) , 0) ;

RILMIB = max( 0 , RILMIB_1 * (1-ART1731BIS) 
              + min( RILMIB_1 , max(RILMIB_P, RILMIB1731+0 )) * ART1731BIS 
            ) ;

REPMEUIB = (AILMIB_R - RILMIB) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

regle 40034:
application : iliad , batch  ;


RILMIA_1 = max(min(AILMIA , RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV-RFOR
                            -RTOURREP-RTOUHOTR-RTOUREPA-RCELTOT-RREDMEUB-RREDREP-RILMIX-RILMIY
			    -RINVRED-RILMIH-RILMJC-RILMIZ-RILMJI-RILMJS-RMEUBLE-RPROREP-RREPNPRO
                            -RREPMEU-RILMIC-RILMIB) , 0) ;


RILMIA = max(0 , RILMIA_1 * (1 - ART1731BIS) 
             + min(RILMIA_1 , max(RILMIA_P , RILMIA1731 + 0)) * ART1731BIS
            ) ;

REPMEUIA = (AILMIA_R - RILMIA) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;
  
regle 40036:
application : iliad , batch  ;


RILMJY_1 = max(min(AILMJY , RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV-RFOR
                            -RTOURREP-RTOUHOTR-RTOUREPA-RCELTOT-RREDMEUB-RREDREP-RILMIX-RILMIY
			    -RINVRED-RILMIH-RILMJC-RILMIZ-RILMJI-RILMJS-RMEUBLE-RPROREP-RREPNPRO
                            -RREPMEU-RILMIC-RILMIB-RILMIA) , 0) ;


RILMJY = max(0 , RILMJY_1 * (1 - ART1731BIS) 
             + min(RILMJY_1 , max(RILMJY_P , RILMJY1731 + 0)) * ART1731BIS
            ) ;

REPMEUJY = (DILMJY - RILMJY) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

regle 40038:
application : iliad , batch  ;


RILMJX_1 = max(min(AILMJX , RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV-RFOR
                            -RTOURREP-RTOUHOTR-RTOUREPA-RCELTOT-RREDMEUB-RREDREP-RILMIX-RILMIY
			    -RINVRED-RILMIH-RILMJC-RILMIZ-RILMJI-RILMJS-RMEUBLE-RPROREP-RREPNPRO
                            -RREPMEU-RILMIC-RILMIB-RILMIA-RILMJY) , 0) ;


RILMJX = max(0 , RILMJX_1 * (1 - ART1731BIS) 
             + min(RILMJX_1 , max(RILMJX_P , RILMJX1731 + 0)) * ART1731BIS
            ) ;

REPMEUJX = (DILMJX - RILMJX) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

regle 40040:
application : iliad , batch  ;


RILMJW_1 = max(min(AILMJW , RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV-RFOR
                            -RTOURREP-RTOUHOTR-RTOUREPA-RCELTOT-RREDMEUB-RREDREP-RILMIX-RILMIY
			    -RINVRED-RILMIH-RILMJC-RILMIZ-RILMJI-RILMJS-RMEUBLE-RPROREP-RREPNPRO
                            -RREPMEU-RILMIC-RILMIB-RILMIA-RILMJY-RILMJX) , 0) ;


RILMJW = max(0 , RILMJW_1 * (1 - ART1731BIS) 
             + min(RILMJW_1 , max(RILMJW_P , RILMJW1731 + 0)) * ART1731BIS
            ) ;

REPMEUJW = (DILMJW - RILMJW) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

regle 40042:
application : iliad , batch  ;


RILMJV_1 = max(min(AILMJV , RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV-RFOR
                            -RTOURREP-RTOUHOTR-RTOUREPA-RCELTOT-RREDMEUB-RREDREP-RILMIX-RILMIY
			    -RINVRED-RILMIH-RILMJC-RILMIZ-RILMJI-RILMJS-RMEUBLE-RPROREP-RREPNPRO
                            -RREPMEU-RILMIC-RILMIB-RILMIA-RILMJY-RILMJX-RILMJW) , 0) ;


RILMJV = max(0 , RILMJV_1 * (1 - ART1731BIS) 
             + min(RILMJV_1 , max(RILMJV_P , RILMJV1731 + 0)) * ART1731BIS
            ) ;

REPMEUJV = (DILMJV - RILMJV) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

regle 40044:
application : iliad , batch  ;

REPMEUTOT1 = REPRESIMEUB + REPMEUIK + REPMEUIQ + REPMEUIR + RESIVIEUREP ;

REPMEUTOT2 = REPMEUIP + MEUBLEREP + REPRESIVIEU ;

regle 40050:
application : iliad , batch  ;

DRESIMEUB = VIEUMEUB ;

DRESIVIEU = RESIVIEU + RESIVIANT ;

DRESINEUV = LOCRESINEUV + MEUBLENP + INVNPROF1 + INVNPROF2 ;

DLOCIDEFG = LOCMEUBID + LOCMEUBIE + LOCMEUBIF + LOCMEUBIG ;

DCODJTJU = LOCMEUBJT + LOCMEUBJU ;


ACODJT = min(PLAF_RESINEUV , LOCMEUBJT) * (1 - V_CNR) ;
ACODJU = min(PLAF_RESINEUV - ACODJT , LOCMEUBJU) * (1 - V_CNR) ;

ACODJTJU_1 = arr(ACODJT / 9) + arr(ACODJU / 9) ;
ACODJTJU = ACODJTJU_1 * (1 -ART1731BIS) + min(ACODJTJU_1 , ACODJTJU1731 + 0) * ART1731BIS ;

ACODIE = min(PLAF_RESINEUV , LOCMEUBIE) * (1 - V_CNR) ;
ACODIF = min(PLAF_RESINEUV - ACODIE , LOCMEUBIF) * (1 - V_CNR) ;
ACODID = min(PLAF_RESINEUV - ACODIE - ACODIF , LOCMEUBID) * (1 - V_CNR) ;
ACODIG = min(PLAF_RESINEUV - ACODIE - ACODIF - ACODID , LOCMEUBIG) * (1 - V_CNR) ;

ALOCIDEFG_1 = arr(ACODIE / 9) + arr(ACODIF / 9) + arr(ACODID / 9) + arr(ACODIG / 9) ; 
ALOCIDEFG = ALOCIDEFG_1 * (1 - ART1731BIS) + min(ALOCIDEFG_1 , ALOCIDEFG1731 + 0) * ART1731BIS ;

ACODIL = min(PLAF_RESINEUV , MEUBLENP) * (1 - V_CNR) ;
ACODIN = min(PLAF_RESINEUV - ACODIL , INVNPROF1) * (1 - V_CNR) ;
ACODIJ = min(PLAF_RESINEUV - ACODIL - ACODIN , LOCRESINEUV) * (1 - V_CNR) ;
ACODIV = min(PLAF_RESINEUV - ACODIL - ACODIN - ACODIJ , INVNPROF2) * (1 - V_CNR) ;

ARESINEUV_1 = arr(ACODIL / 9) + arr(ACODIN / 9) + arr(ACODIJ / 9) + arr(ACODIV / 9) ; 
ARESINEUV = ARESINEUV_1 * (1 - ART1731BIS) + min(ARESINEUV_1 , ARESINEUV1731 + 0) * ART1731BIS ;

ACODIM = min(PLAF_RESINEUV , RESIVIEU) * (1 - V_CNR) ;
ACODIW = min(PLAF_RESINEUV - ACODIM , RESIVIANT) * (1 - V_CNR) ;

ARESIVIEU_1 = arr(ACODIM / 9) + arr(ACODIW / 9) ;
ARESIVIEU = ARESIVIEU_1 * (1-ART1731BIS) + min( ARESIVIEU_1 , ARESIVIEU1731+0 ) * ART1731BIS ;

ARESIMEUB_1 = arr(min(PLAF_RESINEUV , VIEUMEUB) / 9) * (1 - V_CNR) ;
ARESIMEUB = ARESIMEUB_1 * (1-ART1731BIS) + min( ARESIMEUB_1 , ARESIMEUB1731+0 ) * ART1731BIS ;


RETCODJTJU = arr(arr(ACODJT / 9) * TX11 / 100) + arr(arr(ACODJU / 9) * TX11 / 100) * (1 - ART1731BIS)
             + min(ACODJTJU_1 , ACODJTJU1731 + 0) * ART1731BIS ;

RETCODJT = arr(arr(ACODJT / 9) * TX11 / 100) ;

RETCODJU = arr(arr(ACODJU / 9) * TX11 / 100) ;

RETCODJTJU_1 = RETCODJT + RETCODJU ;

RETCODIE = arr(arr(ACODIE / 9) * TX18 / 100) ;

RETCODIF = arr(arr(ACODIF / 9) * TX18 / 100) ;

RETCODID = arr(arr(ACODID / 9) * TX11 / 100) ;

RETCODIG = arr(arr(ACODIG / 9) * TX11 / 100) ;
 

RETLOCIDEFG_1 = arr(arr(ACODIE / 9) * TX18 / 100) + arr(arr(ACODIF / 9) * TX18 / 100) 
                    + arr(arr(ACODID / 9) * TX11 / 100) + arr(arr(ACODIG / 9) * TX11 / 100) ;

RETLOCIDEFG = arr(arr(ACODIE / 9) * TX18 / 100) + arr(arr(ACODIF / 9) * TX18 / 100) 
                  + arr(arr(ACODID / 9) * TX11 / 100) + arr(arr(ACODIG / 9) * TX11 / 100) * (1 - ART1731BIS)
              + min(ALOCIDEFG_1 , ALOCIDEFG1731 + 0) * ART1731BIS ;

RETRESINEUV = arr(arr(ACODIL / 9) * TX20 / 100) + arr(arr(ACODIN / 9) * TX20 / 100) + arr(arr(ACODIJ / 9) * TX18 / 100) + arr(arr(ACODIV / 9) * TX18 / 100) * (1 - ART1731BIS)
              + min(ARESINEUV_1 , ARESINEUV1731 + 0) * ART1731BIS ;

RETRESINEUV_1 = arr(arr(ACODIL / 9) * TX20 / 100) + arr(arr(ACODIN / 9) * TX20 / 100) + arr(arr(ACODIJ / 9) * TX18 / 100) + arr(arr(ACODIV / 9) * TX18 / 100) ;

RETCODIL = arr(arr(ACODIL / 9) * TX20 / 100) ;

RETCODIN = arr(arr(ACODIN / 9) * TX20 / 100) ;

RETCODIJ = arr(arr(ACODIJ / 9) * TX18 / 100) ;

RETCODIV = arr(arr(ACODIV / 9) * TX18 / 100) ;

RETRESIVIEU = arr(arr(ACODIM / 9) * TX25 / 100) + arr(arr(ACODIW / 9) * TX25 / 100) * (1 - ART1731BIS)
              + min( ARESIVIEU_1 , ARESIVIEU1731+0 ) * ART1731BIS ;
RETRESIVIEU_1 = arr(arr(ACODIM / 9) * TX25 / 100) + arr(arr(ACODIW / 9) * TX25 / 100) ;

RETCODIM = arr(arr(ACODIM / 9) * TX25 / 100) ;

RETCODIW = arr(arr(ACODIW / 9) * TX25 / 100) ;

RETRESIMEUB = arr(ARESIMEUB * TX25 / 100) ;

RETRESIMEUB_1 = arr(ARESIMEUB_1 * TX25 / 100) ;

regle 40052:
application : iliad , batch  ;
 

RRESIMEUB_1 = max(min(RETRESIMEUB , RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV-RFOR
                            -RTOURREP-RTOUHOTR-RTOUREPA-RCELTOT-RREDMEUB-RREDREP-RILMIX-RILMIY
                            -RINVRED-RILMIH-RILMJC-RILMIZ-RILMJI-RILMJS-RMEUBLE-RPROREP-RREPNPRO
                            -RREPMEU-RILMIC-RILMIB-RILMIA-RILMJY-RILMJX-RILMJW-RILMJV) , 0) ;


RRESIMEUB = max( 0 , RRESIMEUB_1 * (1-ART1731BIS) 
                 + min( RRESIMEUB_1 , max(RRESIMEUB_P , RRESIMEUB1731+0)) * ART1731BIS 
               ) ;

REPLOCIO = (RETRESIMEUB_1 - RRESIMEUB) * positif(VIEUMEUB + 0) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

regle 40054:
application : iliad , batch  ;


RCODIW_1 = max(min(RETCODIW , RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV-RFOR
                            -RTOURREP-RTOUHOTR-RTOUREPA-RCELTOT-RREDMEUB-RREDREP-RILMIX-RILMIY
                            -RINVRED-RILMIH-RILMJC-RILMIZ-RILMJI-RILMJS-RMEUBLE-RPROREP-RREPNPRO
                            -RREPMEU-RILMIC-RILMIB-RILMIA-RILMJY-RILMJX-RILMJW-RILMJV-RRESIMEUB) , 0) ;


RCODIW = max( 0 , RCODIW_1 * (1-ART1731BIS) 
              + min( RCODIW_1 , max(RCODIW_P , RCODIW1731 + 0)) * ART1731BIS 
            ) ;

REPLOCIW = (RETCODIW - RCODIW) * positif(RESIVIANT + 0) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCODIM_1 = max(min(RETCODIM , RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV-RFOR
                            -RTOURREP-RTOUHOTR-RTOUREPA-RCELTOT-RREDMEUB-RREDREP-RILMIX-RILMIY
                            -RINVRED-RILMIH-RILMJC-RILMIZ-RILMJI-RILMJS-RMEUBLE-RPROREP-RREPNPRO
                            -RREPMEU-RILMIC-RILMIB-RILMIA-RILMJY-RILMJX-RILMJW-RILMJV-RRESIMEUB-RCODIW) , 0) ;


RCODIM = max( 0 , RCODIM_1 * (1-ART1731BIS) 
              + min( RCODIM_1 , max(RCODIM_P , RCODIM1731 + 0)) * ART1731BIS 
            ) ;

REPLOCIM = (RETCODIM - RCODIM) * positif(RESIVIEU + 0) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RRESIVIEU_1 = RCODIW + RCODIM ;


RRESIVIEU = max( 0 , RRESIVIEU_1 * (1-ART1731BIS) 
                 + min( RRESIVIEU_1 , max(RRESIVIEU_P , RRESIVIEU1731+0 )) * ART1731BIS 
               ) ;
regle 40056:
application : iliad , batch  ;


RCODIL_1 = max(min(RETCODIL , RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV-RFOR
                            -RTOURREP-RTOUHOTR-RTOUREPA-RCELTOT-RREDMEUB-RREDREP-RILMIX-RILMIY
                            -RINVRED-RILMIH-RILMJC-RILMIZ-RILMJI-RILMJS-RMEUBLE-RPROREP-RREPNPRO
                            -RREPMEU-RILMIC-RILMIB-RILMIA-RILMJY-RILMJX-RILMJW-RILMJV-RRESIMEUB
                            -RRESIVIEU) , 0) ;
RCODIL = RCODIL_1 * ( 1-ART1731BIS) 
         + min( RCODIL_1 , max(RCODIL_P , RCODIL1731+0 )) * ART1731BIS ;

REPLOCIL = (RETCODIL - RCODIL) * positif(MEUBLENP + 0) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCODIN_1 = max(min(RETCODIN , RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV-RFOR
                            -RTOURREP-RTOUHOTR-RTOUREPA-RCELTOT-RREDMEUB-RREDREP-RILMIX-RILMIY
                            -RINVRED-RILMIH-RILMJC-RILMIZ-RILMJI-RILMJS-RMEUBLE-RPROREP-RREPNPRO
                            -RREPMEU-RILMIC-RILMIB-RILMIA-RILMJY-RILMJX-RILMJW-RILMJV-RRESIMEUB
                            -RRESIVIEU-RCODIL) , 0) ;

RCODIN = RCODIN_1 * ( 1-ART1731BIS) 
         + min( RCODIN_1 , max(RCODIN_P , RCODIN1731+0 )) * ART1731BIS ;

REPLOCIN = (RETCODIN - RCODIN) * positif(INVNPROF1 + 0) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCODIV_1 = max(min(RETCODIV , RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV-RFOR
                            -RTOURREP-RTOUHOTR-RTOUREPA-RCELTOT-RREDMEUB-RREDREP-RILMIX-RILMIY
                            -RINVRED-RILMIH-RILMJC-RILMIZ-RILMJI-RILMJS-RMEUBLE-RPROREP-RREPNPRO
                            -RREPMEU-RILMIC-RILMIB-RILMIA-RILMJY-RILMJX-RILMJW-RILMJV-RRESIMEUB
                            -RRESIVIEU-RCODIL-RCODIN) , 0) ;

RCODIV = RCODIV_1 * ( 1-ART1731BIS) 
         + min( RCODIV_1 , max(RCODIV_P , RCODIV1731+0 )) * ART1731BIS ;

REPLOCIV = (RETCODIV - RCODIV) * positif(INVNPROF2 + 0) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCODIJ_1 = max(min(RETCODIJ , RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV-RFOR
                            -RTOURREP-RTOUHOTR-RTOUREPA-RCELTOT-RREDMEUB-RREDREP-RILMIX-RILMIY
                            -RINVRED-RILMIH-RILMJC-RILMIZ-RILMJI-RILMJS-RMEUBLE-RPROREP-RREPNPRO
                            -RREPMEU-RILMIC-RILMIB-RILMIA-RILMJY-RILMJX-RILMJW-RILMJV-RRESIMEUB
                            -RRESIVIEU-RCODIL-RCODIN-RCODIV) , 0) ;

RCODIJ = RCODIJ_1 * ( 1-ART1731BIS) 
         + min( RCODIJ_1 , max(RCODIJ_P , RCODIJ1731+0 )) * ART1731BIS ;

REPLOCIJ = (RETCODIJ - RCODIJ) * positif(LOCRESINEUV + 0) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RRESINEUV = RCODIL + RCODIN + RCODIV + RCODIJ ;


regle 40058:
application : iliad , batch  ;


RCODIE_1 = max(min(RETCODIE , RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV-RFOR
                            -RTOURREP-RTOUHOTR-RTOUREPA-RCELTOT-RREDMEUB-RREDREP-RILMIX-RILMIY
                            -RINVRED-RILMIH-RILMJC-RILMIZ-RILMJI-RILMJS-RMEUBLE-RPROREP-RREPNPRO
                            -RREPMEU-RILMIC-RILMIB-RILMIA-RILMJY-RILMJX-RILMJW-RILMJV-RRESIMEUB
                            -RRESIVIEU-RRESINEUV) , 0) ;

RCODIE = RCODIE_1 * ( 1- ART1731BIS ) 
         + min( RCODIE_1 , max( RCODIE_P , RCODIE1731+0 )) * ART1731BIS ;

REPLOC7IE = (RETCODIE - RCODIE) * positif(LOCMEUBIE + 0) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCODIF_1 = max(min(RETCODIF , RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV-RFOR
                            -RTOURREP-RTOUHOTR-RTOUREPA-RCELTOT-RREDMEUB-RREDREP-RILMIX-RILMIY
                            -RINVRED-RILMIH-RILMJC-RILMIZ-RILMJI-RILMJS-RMEUBLE-RPROREP-RREPNPRO
                            -RREPMEU-RILMIC-RILMIB-RILMIA-RILMJY-RILMJX-RILMJW-RILMJV-RRESIMEUB
                            -RRESIVIEU-RRESINEUV-RCODIE) , 0) ;


RCODIF = RCODIF_1 * ( 1- ART1731BIS )
         + min( RCODIF_1 , max( RCODIF_P , RCODIF1731 + 0 )) * ART1731BIS ;

REPLOCIF = (RETCODIF - RCODIF) * positif(LOCMEUBIF + 0) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCODIG_1 = max(min(RETCODIG , RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV-RFOR
                            -RTOURREP-RTOUHOTR-RTOUREPA-RCELTOT-RREDMEUB-RREDREP-RILMIX-RILMIY
                            -RINVRED-RILMIH-RILMJC-RILMIZ-RILMJI-RILMJS-RMEUBLE-RPROREP-RREPNPRO
                            -RREPMEU-RILMIC-RILMIB-RILMIA-RILMJY-RILMJX-RILMJW-RILMJV-RRESIMEUB
                            -RRESIVIEU-RRESINEUV-RCODIE-RCODIF) , 0) ;


RCODIG = RCODIG_1 * ( 1- ART1731BIS ) 
         + min( RCODIG_1 , max( RCODIG_P , RCODIG1731 + 0 )) * ART1731BIS ;

REPLOCIG = (RETCODIG - RCODIG) * positif(LOCMEUBIG + 0) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;


RCODID_1 = max(min(RETCODID , RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV-RFOR
                            -RTOURREP-RTOUHOTR-RTOUREPA-RCELTOT-RREDMEUB-RREDREP-RILMIX-RILMIY
                            -RINVRED-RILMIH-RILMJC-RILMIZ-RILMJI-RILMJS-RMEUBLE-RPROREP-RREPNPRO
                            -RREPMEU-RILMIC-RILMIB-RILMIA-RILMJY-RILMJX-RILMJW-RILMJV-RRESIMEUB
                            -RRESIVIEU-RRESINEUV-RCODIE-RCODIF-RCODIG) , 0) ;

RCODID = RCODID_1 * ( 1- ART1731BIS )
         + min( RCODID_1 ,max( RCODID_P , RCODID1731 +0 )) * ART1731BIS ;

REPLOCID = (RETCODID - RCODID) * positif(LOCMEUBID + 0) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RLOCIDEFG = RCODIE + RCODIF + RCODIG + RCODID ;


regle 40060:
application : iliad , batch  ;


RCODJU_1 = max(min(RETCODJU , RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV-RFOR
                            -RTOURREP-RTOUHOTR-RTOUREPA-RCELTOT-RREDMEUB-RREDREP-RILMIX-RILMIY
                            -RINVRED-RILMIH-RILMJC-RILMIZ-RILMJI-RILMJS-RMEUBLE-RPROREP-RREPNPRO
                            -RREPMEU-RILMIC-RILMIB-RILMIA-RILMJY-RILMJX-RILMJW-RILMJV-RRESIMEUB
                            -RRESIVIEU-RRESINEUV-RLOCIDEFG) , 0) ;

RCODJU = max(0 , RCODJU_1 * ( 1 - ART1731BIS) 
             + min(RCODJU_1 , max(RCODJU_P , RCODJU1731 + 0)) * ART1731BIS 
            ) ;

REPLOCJU = (RETCODJU - RCODJU) * positif(LOCMEUBJU + 0) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RCODJT_1 = max(min(RETCODJT , RRI1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV-RFOR
                            -RTOURREP-RTOUHOTR-RTOUREPA-RCELTOT-RREDMEUB-RREDREP-RILMIX-RILMIY
                            -RINVRED-RILMIH-RILMJC-RILMIZ-RILMJI-RILMJS-RMEUBLE-RPROREP-RREPNPRO
                            -RREPMEU-RILMIC-RILMIB-RILMIA-RILMJY-RILMJX-RILMJW-RILMJV-RRESIMEUB
                            -RRESIVIEU-RRESINEUV-RLOCIDEFG-RCODJU) , 0) ;

RCODJT = max(0 , RCODJT_1 * ( 1 - ART1731BIS) 
             + min(RCODJT_1 , max(RCODJT_P , RCODJT1731 + 0)) * ART1731BIS 
            ) ;

RCODJTJU = RCODJU + RCODJT ;

REPLOCJT = (RETCODJT - RCODJT) * positif(LOCMEUBJT + 0) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

RLOCNPRO = RREDMEUB + RREDREP + RILMIX + RILMIY + RINVRED + RILMIH + RILMJC + RILMIZ + RILMJI + RILMJS 
          + RMEUBLE + RPROREP + RREPNPRO + RREPMEU + RILMIC + RILMIB + RILMIA + RILMJY + RILMJX + RILMJW
	  + RILMJV + RRESIMEUB + RRESIVIEU + RRESINEUV + RLOCIDEFG + RCODJTJU ;

regle 40062:
application : iliad , batch  ;


REPLNPV = REPLOCJT ;

REPLOCNT = REPMEUJS ;

REPLNPW = REPMEUJV + REPLOCIG + REPLOCIF + REPLOCID + REPLOCJU ;


REPRESINEUV = REPMEUJI ;

REPLNPX = REPMEUIA + REPMEUJW + REPLOCIV + REPLOCIN + REPLOCIJ + REPLOC7IE ;

REPINVRED = REPMEUIT ; 

REPLOCN1 = REPMEUJC ;

REPLNPY = REPMEUIP + REPMEUIB + REPMEUJX + REPLOCIM + REPLOCIL ; 

MEUBLERED = REPMEUIS ;

REPREDREP = REPMEUIU ;

REPLOCN2 = REPMEUIY ;

REPLNPZ = REPMEUIK + REPMEUIR + REPMEUIQ + REPMEUIC + REPMEUJY + REPLOCIO + REPLOCIW ;
 
MEUBLEREP = (RETRESINEUV_1 - RRESINEUV) * positif(MEUBLENP) ;

REPRESIVIEU = (RETRESIVIEU_1 - RRESIVIEU) * positif(RESIVIEU) ;

RESIVIEUREP = (RETRESIVIEU_1 - RRESIVIEU) * positif(RESIVIANT) ;

REPRESIMEUB = RETRESIMEUB_1 - RRESIMEUB ;

regle 40064:
application : iliad , batch  ;

RCODJT1 = arr(arr(ACODJT / 9) * TX11/100) ;
RCODJT2 = RCODJT1 ;
RCODJT3 = RCODJT1 ;
RCODJT4 = RCODJT1 ;
RCODJT5 = RCODJT1 ;
RCODJT6 = RCODJT1 ;
RCODJT7 = RCODJT1 ;
RCODJT8 = arr(ACODJT * TX11/100) - 8 * RCODJT1 ; 

REPLNPT = RCODJT1 + RCODJT2 + RCODJT3 + RCODJT4 + RCODJT5 + RCODJT6 + RCODJT7 + RCODJT8 ;

RCODJU1 = arr(arr(ACODJU / 9) * TX11/100) ;
RCODJU2 = arr(arr(ACODJU / 9) * TX11/100) ;
RCODJU3 = arr(arr(ACODJU / 9) * TX11/100) ;
RCODJU4 = arr(arr(ACODJU / 9) * TX11/100) ;
RCODJU5 = arr(arr(ACODJU / 9) * TX11/100) ;
RCODJU6 = arr(arr(ACODJU / 9) * TX11/100) ;
RCODJU7 = arr(arr(ACODJU / 9) * TX11/100) ;
RCODJU8 = arr(ACODJU * TX11/100) - RCODJU1 - RCODJU2 - RCODJU3 - RCODJU4 - RCODJU5 - RCODJU6 - RCODJU7 - RCODJU7 ;

REPLNPU = RCODJU1 + RCODJU2 + RCODJU3 + RCODJU4 + RCODJU5 + RCODJU6 + RCODJU7 + RCODJU8 ;

RLOCIDFG1 = arr(arr(ACODID / 9) * TX11/100) + arr(arr(ACODIF / 9) * TX18/100) + arr(arr(ACODIG / 9) * TX11/100) ;
RLOCIDFG2 = arr(arr(ACODID / 9) * TX11/100) + arr(arr(ACODIF / 9) * TX18/100) + arr(arr(ACODIG / 9) * TX11/100) ; 
RLOCIDFG3 = arr(arr(ACODID / 9) * TX11/100) + arr(arr(ACODIF / 9) * TX18/100) + arr(arr(ACODIG / 9) * TX11/100) ;
RLOCIDFG4 = arr(arr(ACODID / 9) * TX11/100) + arr(arr(ACODIF / 9) * TX18/100) + arr(arr(ACODIG / 9) * TX11/100) ;
RLOCIDFG5 = arr(arr(ACODID / 9) * TX11/100) + arr(arr(ACODIF / 9) * TX18/100) + arr(arr(ACODIG / 9) * TX11/100) ;
RLOCIDFG6 = arr(arr(ACODID / 9) * TX11/100) + arr(arr(ACODIF / 9) * TX18/100) + arr(arr(ACODIG / 9) * TX11/100) ;
RLOCIDFG7 = arr(arr(ACODID / 9) * TX11/100) + arr(arr(ACODIF / 9) * TX18/100) + arr(arr(ACODIG / 9) * TX11/100) ;
RLOCIDFG8 = arr(ACODID * TX11/100) + arr(ACODIF * TX18/100) + arr(ACODIG * TX11/100)
	     - RLOCIDFG1 - RLOCIDFG2 - RLOCIDFG3 - RLOCIDFG4 - RLOCIDFG5 - RLOCIDFG6 - RLOCIDFG7 - RLOCIDFG7 ;

REPLOCIDFG = RLOCIDFG1 + RLOCIDFG2 + RLOCIDFG3 + RLOCIDFG4 + RLOCIDFG5 + RLOCIDFG6 + RLOCIDFG7 + RLOCIDFG8 ;

REPLOCIE1 = arr(arr(ACODIE / 9) * TX18/100) ; 
REPLOCIE2 = arr(arr(ACODIE / 9) * TX18/100) ; 
REPLOCIE3 = arr(arr(ACODIE / 9) * TX18/100) ; 
REPLOCIE4 = arr(arr(ACODIE / 9) * TX18/100) ; 
REPLOCIE5 = arr(arr(ACODIE / 9) * TX18/100) ; 
REPLOCIE6 = arr(arr(ACODIE / 9) * TX18/100) ; 
REPLOCIE7 = arr(arr(ACODIE / 9) * TX18/100) ; 
REPLOCIE8 = arr(ACODIE * TX18/100) - REPLOCIE1 - REPLOCIE2 - REPLOCIE3 - REPLOCIE4 - REPLOCIE5 - REPLOCIE6 - REPLOCIE7 - REPLOCIE7 ;

REPLOCIE = REPLOCIE1 + REPLOCIE2 + REPLOCIE3 + REPLOCIE4 + REPLOCIE5 + REPLOCIE6 + REPLOCIE7 + REPLOCIE8 ;

RESINEUV1 = arr(arr(ACODIN / 9) * TX20/100) + arr(arr(ACODIJ / 9) * TX18/100) + arr(arr(ACODIV / 9) * TX18/100) ;
RESINEUV2 = arr(arr(ACODIN / 9) * TX20/100) + arr(arr(ACODIJ / 9) * TX18/100) + arr(arr(ACODIV / 9) * TX18/100) ;
RESINEUV3 = arr(arr(ACODIN / 9) * TX20/100) + arr(arr(ACODIJ / 9) * TX18/100) + arr(arr(ACODIV / 9) * TX18/100) ;
RESINEUV4 = arr(arr(ACODIN / 9) * TX20/100) + arr(arr(ACODIJ / 9) * TX18/100) + arr(arr(ACODIV / 9) * TX18/100) ;
RESINEUV5 = arr(arr(ACODIN / 9) * TX20/100) + arr(arr(ACODIJ / 9) * TX18/100) + arr(arr(ACODIV / 9) * TX18/100) ;
RESINEUV6 = arr(arr(ACODIN / 9) * TX20/100) + arr(arr(ACODIJ / 9) * TX18/100) + arr(arr(ACODIV / 9) * TX18/100) ;
RESINEUV7 = arr(arr(ACODIN / 9) * TX20/100) + arr(arr(ACODIJ / 9) * TX18/100) + arr(arr(ACODIV / 9) * TX18/100) ;
RESINEUV8 = arr(ACODIN * TX20/100) + arr(ACODIJ * TX18/100) + arr(ACODIV * TX18/100)
	     - RESINEUV1 - RESINEUV2 - RESINEUV3 - RESINEUV4 - RESINEUV5 - RESINEUV6 - RESINEUV7 - RESINEUV7 ;

REPINVLOCNP = RESINEUV1 + RESINEUV2 + RESINEUV3 + RESINEUV4 + RESINEUV5 + RESINEUV6 + RESINEUV7 + RESINEUV8 ;

RRESINEUV1 = arr(arr(ACODIL / 9) * TX20/100) ;
RRESINEUV2 = arr(arr(ACODIL / 9) * TX20/100) ;
RRESINEUV3 = arr(arr(ACODIL / 9) * TX20/100) ;
RRESINEUV4 = arr(arr(ACODIL / 9) * TX20/100) ;
RRESINEUV5 = arr(arr(ACODIL / 9) * TX20/100) ;
RRESINEUV6 = arr(arr(ACODIL / 9) * TX20/100) ;
RRESINEUV7 = arr(arr(ACODIL / 9) * TX20/100) ;
RRESINEUV8 = arr(ACODIL * TX20/100) - RRESINEUV1 - RRESINEUV2 - RRESINEUV3 - RRESINEUV4 - RRESINEUV5 - RRESINEUV6 - RRESINEUV7 - RRESINEUV7 ;

REPINVMEUBLE = RRESINEUV1 + RRESINEUV2 + RRESINEUV3 + RRESINEUV4 + RRESINEUV5 + RRESINEUV6 + RRESINEUV7 + RRESINEUV8 ;

RESIVIEU1 = arr(arr(ACODIM / 9) * TX25/100) ;
RESIVIEU2 = arr(arr(ACODIM / 9) * TX25/100) ;
RESIVIEU3 = arr(arr(ACODIM / 9) * TX25/100) ;
RESIVIEU4 = arr(arr(ACODIM / 9) * TX25/100) ;
RESIVIEU5 = arr(arr(ACODIM / 9) * TX25/100) ;
RESIVIEU6 = arr(arr(ACODIM / 9) * TX25/100) ;
RESIVIEU7 = arr(arr(ACODIM / 9) * TX25/100) ;
RESIVIEU8 = arr(ACODIM * TX25/100) - RESIVIEU1 - RESIVIEU2 - RESIVIEU3 - RESIVIEU4 - RESIVIEU5 - RESIVIEU6 - RESIVIEU7 - RESIVIEU7 ;

REPINVIEU = RESIVIEU1 + RESIVIEU2 + RESIVIEU3 + RESIVIEU4 + RESIVIEU5 + RESIVIEU6 + RESIVIEU7 + RESIVIEU8 ;

RESIVIAN1 = arr(arr(ACODIW / 9) * TX25/100) ;
RESIVIAN2 = arr(arr(ACODIW / 9) * TX25/100) ;
RESIVIAN3 = arr(arr(ACODIW / 9) * TX25/100) ;
RESIVIAN4 = arr(arr(ACODIW / 9) * TX25/100) ;
RESIVIAN5 = arr(arr(ACODIW / 9) * TX25/100) ;
RESIVIAN6 = arr(arr(ACODIW / 9) * TX25/100) ;
RESIVIAN7 = arr(arr(ACODIW / 9) * TX25/100) ;
RESIVIAN8 = arr(ACODIW * TX25/100) - RESIVIAN1 - RESIVIAN2 - RESIVIAN3 - RESIVIAN4 - RESIVIAN5 - RESIVIAN6 - RESIVIAN7 - RESIVIAN7 ;

REPINVIAN = RESIVIAN1 + RESIVIAN2 + RESIVIAN3 + RESIVIAN4 + RESIVIAN5 + RESIVIAN6 + RESIVIAN7 + RESIVIAN8 ;

RESIMEUB1 = arr(arr(min(DRESIMEUB , PLAF_RESINEUV) / 9) * TX25/100) ;
RESIMEUB2 = arr(arr(min(DRESIMEUB , PLAF_RESINEUV) / 9) * TX25/100) ;
RESIMEUB3 = arr(arr(min(DRESIMEUB , PLAF_RESINEUV) / 9) * TX25/100) ;
RESIMEUB4 = arr(arr(min(DRESIMEUB , PLAF_RESINEUV) / 9) * TX25/100) ;
RESIMEUB5 = arr(arr(min(DRESIMEUB , PLAF_RESINEUV) / 9) * TX25/100) ;
RESIMEUB6 = arr(arr(min(DRESIMEUB , PLAF_RESINEUV) / 9) * TX25/100) ;
RESIMEUB7 = arr(arr(min(DRESIMEUB , PLAF_RESINEUV) / 9) * TX25/100) ;
RESIMEUB8 = arr(min(DRESIMEUB , PLAF_RESINEUV) * TX25/100) - RESIMEUB1 - RESIMEUB2 - RESIMEUB3 - RESIMEUB4 - RESIMEUB5 - RESIMEUB6 - RESIMEUB7 - RESIMEUB7 ;

REPMEUB = RESIMEUB1 + RESIMEUB2 + RESIMEUB3 + RESIMEUB4 + RESIMEUB5 + RESIMEUB6 + RESIMEUB7 + RESIMEUB8 ;

REPRETREP = REPRESIVIEU + MEUBLEREP + REPMEUIK ;

regle 407034:
application : iliad , batch  ;

BSOCREP = min(RSOCREPRISE , LIM_SOCREPR * ( 1 + BOOL_0AM)) ;

RSOCREP = arr ( TX_SOCREPR/100 * BSOCREP ) * (1 - V_CNR);

DSOCREPR = RSOCREPRISE;

ASOCREPR = (BSOCREP * (1 - ART1731BIS) 
            + min( BSOCREP , max(ASOCREPR_P , ASOCREPR1731+0 )) * ART1731BIS ) * (1-V_CNR)  ;

RSOCREPR_1 = max( min( RSOCREP , IDOM11-DEC11-RCOTFOR-RREPA-RAIDE-RDIFAGRI-RFORET-RFIPDOM-RFIPC-RCINE-RRESTIMO) , 0 );
RSOCREPR = max( 0, RSOCREPR_1 * (1-ART1731BIS) 
                   + min( RSOCREPR_1 , max( RSOCREPR_P , RSOCREPR1731+0 )) * ART1731BIS ) ;


regle 4070153:
application : iliad , batch  ;

DRESTIMO = RIMOSAUVANT + RIMOPPAUANT + RESTIMOPPAU + RESTIMOSAUV + RIMOPPAURE + RIMOSAUVRF + COD7SY + COD7SX ;

RESTIMOD = min(RIMOSAUVANT , LIM_RESTIMO) ;
RRESTIMOD = max (min (RESTIMOD * TX40/100 , IDOM11-DEC11-RCOTFOR-RREPA-RFIPDOM-RAIDE-RDIFAGRI-RFORET-RFIPC-RCINE) , 0) ;

RESTIMOB = min (RESTIMOSAUV , LIM_RESTIMO - RESTIMOD) ;
RRESTIMOB = max (min (RESTIMOB * TX36/100 , IDOM11-DEC11-RCOTFOR-RREPA-RFIPDOM-RAIDE-RDIFAGRI-RFORET-RFIPC-RCINE
                                            -RRESTIMOD ) , 0) ;

RESTIMOC = min(RIMOPPAUANT , LIM_RESTIMO - RESTIMOD - RESTIMOB) ;
RRESTIMOC = max (min (RESTIMOC * TX30/100 , IDOM11-DEC11-RCOTFOR-RREPA-RFIPDOM-RAIDE-RDIFAGRI-RFORET-RFIPC-RCINE
                                            -RRESTIMOD-RRESTIMOB ) , 0) ;

RESTIMOF = min(RIMOSAUVRF , LIM_RESTIMO - RESTIMOD - RESTIMOB - RESTIMOC) ;
RRESTIMOF = max (min (RESTIMOF * TX30/100 , IDOM11-DEC11-RCOTFOR-RREPA-RFIPDOM-RAIDE-RDIFAGRI-RFORET-RFIPC-RCINE
                                            -RRESTIMOD-RRESTIMOB-RRESTIMOC ) , 0) ;

RESTIMOY = min(COD7SY , LIM_RESTIMO - RESTIMOD - RESTIMOB - RESTIMOC - RESTIMOF) ;
RRESTIMOY = max (min (RESTIMOY * TX30/100 , IDOM11-DEC11-RCOTFOR-RREPA-RFIPDOM-RAIDE-RDIFAGRI-RFORET-RFIPC-RCINE
                                            -RRESTIMOD-RRESTIMOB-RRESTIMOC-RRESTIMOF ) , 0) ;

RESTIMOA = min(RESTIMOPPAU , LIM_RESTIMO - RESTIMOD - RESTIMOB - RESTIMOC - RESTIMOF - RESTIMOY) ;
RRESTIMOA = max (min (RESTIMOA * TX_RESTIMO1/100 , IDOM11-DEC11-RCOTFOR-RREPA-RFIPDOM-RAIDE-RDIFAGRI-RFORET-RFIPC-RCINE
                                            -RRESTIMOD-RRESTIMOB-RRESTIMOC-RRESTIMOF-RRESTIMOY ) , 0) ;

RESTIMOE = min(RIMOPPAURE , LIM_RESTIMO - RESTIMOD - RESTIMOB - RESTIMOC - RESTIMOF - RESTIMOY - RESTIMOA) ;
RRESTIMOE = max (min (RESTIMOE * TX22/100 , IDOM11-DEC11-RCOTFOR-RREPA-RFIPDOM-RAIDE-RDIFAGRI-RFORET-RFIPC-RCINE
                                            -RRESTIMOD-RRESTIMOB-RRESTIMOC-RRESTIMOF-RRESTIMOY-RRESTIMOA ) , 0) ;

RESTIMOX = min(COD7SX , LIM_RESTIMO - RESTIMOD - RESTIMOB - RESTIMOC - RESTIMOF - RESTIMOY - RESTIMOA - RESTIMOE) ;
RRESTIMOX = max (min (RESTIMOX * TX22/100 , IDOM11-DEC11-RCOTFOR-RREPA-RFIPDOM-RAIDE-RDIFAGRI-RFORET-RFIPC-RCINE
                                            -RRESTIMOD-RRESTIMOB-RRESTIMOC-RRESTIMOF-RRESTIMOY-RRESTIMOA-RRESTIMOE ) , 0) ;

ARESTIMO_1 = (RESTIMOD + RESTIMOB + RESTIMOC + RESTIMOF + RESTIMOA + RESTIMOE + RESTIMOY + RESTIMOX) * (1 - V_CNR) ;
ARESTIMO = ( ARESTIMO_1 * (1-ART1731BIS)
             + min( ARESTIMO_1, max(ARESTIMO_P , ARESTIMO1731+0 )) * ART1731BIS
           ) * (1 - V_CNR) ;

RETRESTIMO = arr((RESTIMOD * TX40/100) + (RESTIMOB * TX36/100)
		 + (RESTIMOC * TX30/100) + (RESTIMOA * TX_RESTIMO1/100)
		 + (RESTIMOE * TX22/100) + (RESTIMOF * TX30/100)
                 + (RESTIMOY * TX30/100) + (RESTIMOX * TX22/100)) * (1 - V_CNR) ;

RRESTIMO_1 = max (min (RETRESTIMO , IDOM11-DEC11-RCOTFOR-RREPA-RFIPDOM-RAIDE-RDIFAGRI-RFORET-RFIPC-RCINE) , 0) ;
RRESTIMO = max ( 0 , RRESTIMO_1 * (1-ART1731BIS)
                     + min( RRESTIMO_1 , max(RRESTIMO_P , RRESTIMO1731+0 )) * ART1731BIS ) ;

A12RRESTIMO = arr(max (min(RRESTIMO , RRESTIMOD+RRESTIMOB+RRESTIMOC+RRESTIMOF+RRESTIMOA+RRESTIMOE),0)) * (1 - V_CNR) ;
RRESTIMOXY  = max( RRESTIMO - A12RRESTIMO , 0) * (1 - V_CNR) ;



regle 4070161:
application : iliad , batch  ;
REVDON = max(0,RBL+TOTALQUOHT-SDD-SDC1) ;
BDON7UH = min(LIM15000,COD7UH);
BASEDONB = REPDON03 + REPDON04 + REPDON05 + REPDON06 + REPDON07 + RDDOUP + COD7UH + DONAUTRE;
BASEDONP = RDDOUP + BDON7UH + DONAUTRE + EXCEDANTA;
BON = arr (min (REPDON03+REPDON04+REPDON05+REPDON06+REPDON07+RDDOUP+BDON7UH+DONAUTRE+EXCEDANTA,REVDON *(TX_BASEDUP)/100));


regle 407016101:
application : iliad , batch  ;
BASEDONF = min(REPDON03,arr(REVDON * (TX_BASEDUP)/100)) ;
REPDON = max(BASEDONF + REPDON04 + REPDON05 + REPDON06 + REPDON07+BASEDONP - arr(REVDON * (TX_BASEDUP)/100),0)*(1-V_CNR);

REPDONR4 = (positif_ou_nul(BASEDONF - arr(REVDON * (TX_BASEDUP)/100)) * REPDON04
            + (1 - positif_ou_nul(BASEDONF - arr(REVDON * (TX_BASEDUP)/100)))
	      * max(REPDON04 + (BASEDONF - arr(REVDON * (TX_BASEDUP)/100)),0)
	   )
	   * (1 - V_CNR);

REPDONR3 = (positif_ou_nul(BASEDONF + REPDON04 - arr(REVDON * (TX_BASEDUP)/100)) * REPDON05
	    + (1 - positif_ou_nul(BASEDONF + REPDON04 - arr(REVDON * (TX_BASEDUP)/100)))
	      * max(REPDON05 + (BASEDONF + REPDON04 - arr(REVDON * (TX_BASEDUP)/100)),0)
           ) 
	   * (1 - V_CNR);

REPDONR2 = (positif_ou_nul(BASEDONF + REPDON04 + REPDON05 - arr(REVDON * (TX_BASEDUP)/100)) * REPDON06
            + (1 - positif_ou_nul(BASEDONF + REPDON04 + REPDON05 - arr(REVDON * (TX_BASEDUP)/100)))
	      * max(REPDON06 + (BASEDONF + REPDON04 + REPDON05 - arr(REVDON * (TX_BASEDUP)/100)),0)
	   )
	   * (1 - V_CNR);

REPDONR1 = (positif_ou_nul(BASEDONF + REPDON04 + REPDON05 + REPDON06 - arr(REVDON * (TX_BASEDUP)/100)) * REPDON07
	    + (1 - positif_ou_nul(BASEDONF + REPDON04 + REPDON05 + REPDON06 - arr(REVDON * (TX_BASEDUP)/100)))
	      * max(REPDON07 + (BASEDONF + REPDON04 + REPDON05 + REPDON06 - arr(REVDON * (TX_BASEDUP)/100)),0)
           )
	   * (1 - V_CNR) ;

REPDONR = max(REPDON - REPDONR1 - REPDONR2 - REPDONR3 - REPDONR4 - REPDONR5,0)*(1-V_CNR);

regle 407016:
application : iliad , batch  ;
RON = arr( BON *(TX_REDDON)/100 ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

DDONS = RDDOUP + DONAUTRE + REPDON03 + REPDON04 + REPDON05 + REPDON06 + REPDON07 + COD7UH;
ADONS = ( BON * (1-ART1731BIS) 
          + min( BON , max(ADONS_P , ADONS1731+0 )) * ART1731BIS 
        ) * (1 - null(2 - V_REGCO)) * (1 - null(4 - V_REGCO)) ;

regle 33407016:
application : iliad , batch  ;

RDONS_1 = max( min( RON , RRI1-RLOGDOM-RCREAT-RCOMP-RRETU) , 0 ) ;

RDONS = max( 0, RDONS_1 * (1-ART1731BIS) 
                + min( RDONS_1 , max(RDONS_P , RDONS1731+0 )) * ART1731BIS );

regle 407018:
application : iliad , batch  ;
SEUILRED1=arr((arr(RI1)+REVQUO) / NBPT);
regle 407020:
application:iliad, batch;
RETUD = (1 - V_CNR) * arr((RDENS * MTRC) + (RDENL * MTRL) + (RDENU * MTRS) + (RDENSQAR * MTRC /2) + (RDENLQAR * MTRL /2) + (RDENUQAR * MTRS /2));
RNBE = (RDENS + RDENL + RDENU + RDENSQAR + RDENLQAR + RDENUQAR) * (1-ART1731BIS)
       + min( RDENS + RDENL + RDENU + RDENSQAR + RDENLQAR + RDENUQAR , RNBE1731+0 ) * ART1731BIS ;
DNBE = RDENS + RDENL + RDENU + RDENSQAR + RDENLQAR + RDENUQAR ;
regle 100407020:
application:iliad, batch;

RRETU_1 = max(min( RETUD , RRI1-RLOGDOM-RCREAT-RCOMP) , 0) ;

RRETU = max( 0 , RRETU_1 * (1-ART1731BIS)
                 + min( RRETU_1 , max(RRETU_P , RRETU1731 + 0)) * ART1731BIS ) ;

regle 407022 :
application : iliad , batch  ;

BFCPI_1 = ( positif(BOOL_0AM) * min (FCPI,PLAF_FCPI*2) + positif(1-BOOL_0AM) * min (FCPI,PLAF_FCPI) ) * (1-V_CNR);

BFCPI = BFCPI_1 * (1-ART1731BIS) 
        + min(BFCPI_1 , max(BFCPI_P , BFCPI1731+0)) * ART1731BIS ;

RFCPI = arr (BFCPI * TX_FCPI /100) ;

RINNO_1 = max( min( RFCPI , IDOM11-DEC11-RCOTFOR-RREPA-RFIPDOM-RAIDE-RDIFAGRI-RFORET-RFIPC
			  -RCINE-RRESTIMO-RSOCREPR-RRPRESCOMP-RHEBE-RSURV) , 0 );

RINNO = max( 0, RINNO_1 * (1-ART1731BIS)
                + min( RINNO_1 , max(RINNO_P , RINNO1731+0 )) * ART1731BIS ) ;
regle 407023 :
application : iliad , batch  ;

BPRESCOMP =(RDPRESREPORT 
	   + (1-positif(RDPRESREPORT+0)) * 
	   arr(
	         ((1 - present(SUBSTITRENTE)) * 
                  arr (
                 null(PRESCOMP2000 - PRESCOMPJUGE)
                   * min(PLAFPRESCOMP,PRESCOMP2000)
	         + positif(PRESCOMPJUGE - PRESCOMP2000)
                   * (positif_ou_nul(PLAFPRESCOMP -PRESCOMPJUGE))
                   * PRESCOMP2000
	         + positif(PRESCOMPJUGE - PRESCOMP2000)
                    * (1 - positif_ou_nul(PLAFPRESCOMP -PRESCOMPJUGE))
                    * PLAFPRESCOMP * PRESCOMP2000/PRESCOMPJUGE
                       )
	       +
             present(SUBSTITRENTE) *
                  arr (
                   null(PRESCOMP2000 - SUBSTITRENTE)
		   * 
		   (positif_ou_nul(PLAFPRESCOMP - PRESCOMPJUGE)*SUBSTITRENTE
		   + 
		   positif(PRESCOMPJUGE-PLAFPRESCOMP)*arr(PLAFPRESCOMP*SUBSTITRENTE/PRESCOMPJUGE))
                 + 
		   positif(SUBSTITRENTE - PRESCOMP2000)
		   * (positif_ou_nul(PLAFPRESCOMP - PRESCOMPJUGE)*PRESCOMP2000
		   + 
		   positif(PRESCOMPJUGE-PLAFPRESCOMP)*arr(PLAFPRESCOMP*(SUBSTITRENTE/PRESCOMPJUGE)*(PRESCOMP2000/SUBSTITRENTE)))
                       )
	           )
                )
              )
               *(1 - V_CNR);




RPRESCOMP = arr (BPRESCOMP * TX_PRESCOMP / 100) * (1 -V_CNR);
BPRESCOMP01 = max(0,(1 - present(SUBSTITRENTE)) * 
                   (  positif_ou_nul(PLAFPRESCOMP -PRESCOMPJUGE)
                       * (PRESCOMPJUGE - BPRESCOMP)
                     + positif(PRESCOMPJUGE - PLAFPRESCOMP)
                       * (PLAFPRESCOMP - BPRESCOMP)
                   )
	       +
             present(SUBSTITRENTE) *
                   (  positif_ou_nul(PLAFPRESCOMP -PRESCOMPJUGE)
                       * (SUBSTITRENTE - PRESCOMP2000)
                     + positif(PRESCOMPJUGE - PLAFPRESCOMP)
		     *arr(PLAFPRESCOMP*(SUBSTITRENTE/PRESCOMPJUGE)*((SUBSTITRENTE-PRESCOMP2000)/SUBSTITRENTE))
                   )
		* (1 - V_CNR)
		);
DPRESCOMP = PRESCOMP2000 + RDPRESREPORT ;

APRESCOMP = ( BPRESCOMP * (1-ART1731BIS) 
              + min( BPRESCOMP , max(APRESCOMP_P , APRESCOMP1731+0 )) * ART1731BIS ) * (1 - V_CNR) ;

RRPRESCOMP_1 = max( min( RPRESCOMP , IDOM11-DEC11-RCOTFOR-RREPA-RFIPDOM-RAIDE-RDIFAGRI-RFORET-RFIPC-RCINE-RRESTIMO-RSOCREPR) , 0) ;
RRPRESCOMP = max( 0 , RRPRESCOMP_1 * (1-ART1731BIS) 
                      + min( RRPRESCOMP_1 , max(RRPRESCOMP_P , RRPRESCOMP1731+0 )) * ART1731BIS ) ;

RPRESCOMPREP =  max( min( RPRESCOMP , IDOM11-DEC11-RCOTFOR-RREPA-RFIPDOM-RAIDE-RDIFAGRI-RFORET
				      -RFIPC-RCINE-RRESTIMO-RSOCREPR) , 0) * positif(RDPRESREPORT) ;

RPRESCOMPAN =  RRPRESCOMP * (1-positif(RDPRESREPORT)) ;
regle 4081 :
application : iliad , batch  ;

DCOTFOR = COTFORET ;

ACOTFOR_R = min(DCOTFOR , PLAF_FOREST1 * (1 + BOOL_0AM)) * (1 - V_CNR) ;

ACOTFOR = (ACOTFOR_R * (1 - ART1731BIS) 
           + min( ACOTFOR_R , max(ACOTFOR_P , ACOTFOR1731+0)) * ART1731BIS
          ) * (1 - V_CNR);

RCOTFOR_1 = max( min( arr(ACOTFOR * TX76/100) , IDOM11-DEC11) , 0) ;

RCOTFOR = max(0, RCOTFOR_1 * (1-ART1731BIS) 
                 + min( RCOTFOR_1 , max(RCOTFOR_P , RCOTFOR1731+0)) * ART1731BIS 
             );

regle 408 :
application : iliad , batch  ;


FORTRA = RDFORESTRA + REPFOR + REPSINFOR + REPFOR1 + REPSINFOR1 + REPFOR2 + REPSINFOR2 + REPFOR3 + REPSINFOR3 ;

DFOREST = RDFOREST + FORTRA + RDFORESTGES ;


AFOREST_1 = ( min (RDFOREST, PLAF_FOREST * (1 + BOOL_0AM)) 
	   + min (FORTRA, max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR)) 
	    + min (RDFORESTGES, PLAF_FOREST2 * (1 + BOOL_0AM)) ) * (1 - V_CNR) ;

AFOREST = ( AFOREST_1 * (1-ART1731BIS) 
            + min( AFOREST_1 , max(AFOREST_P , AFOREST1731+0 )) * ART1731BIS ) * (1 - V_CNR) ;


RFOREST1 = min( REPFOR + REPSINFOR + REPFOR1 + REPSINFOR1 , max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR)) ;

RFOREST2 = min( REPFOR2 + REPSINFOR2 , max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR - RFOREST1)) ;

RFOREST3 = min( REPFOR3 + REPSINFOR3 , max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR - RFOREST1 - RFOREST2)) ;

RFOREST = (arr(RFOREST1 * TX25/100) + arr(RFOREST2 * TX22/100) + arr(RFOREST3 * TX18/100)
	  + arr( max(0 , AFOREST - RFOREST1 - RFOREST2 - RFOREST3) * TX18/100)) * (1 - V_CNR) ;

regle 409 :
application : iliad , batch  ;

RFOR_1 = max(min(RFOREST , IDOM11-DEC11-RCOTFOR-RREPA-RAIDE-RDIFAGRI-RFORET-RFIPDOM-RFIPC-RCINE
			   -RRESTIMO-RSOCREPR-RRPRESCOMP-RHEBE-RSURV-RINNO-RSOUFIP-RRIRENOV 
                           -RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV) , 0) ;

RFOR = max( 0 , RFOR_1 * (1-ART1731BIS) 
                + min( RFOR_1 , max(RFOR_P , RFOR1731+0 )) * ART1731BIS ) ; 
regle 4092 :
application : iliad , batch  ;



REPBON = max(0 , REPFOR - max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR_R)) * (1 - V_CNR) ;

REPSIN = max(0 , REPSINFOR - max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR_R)) * (1 - V_CNR) ; 

REPFOREST = max(0 , REPFOR1 - max(0 , max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR_R) - REPFOR - REPSINFOR)) * (1 - V_CNR) ;

REPFORSIN = max(0 , REPSINFOR1 - max(0 , max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR_R) - REPFOR - REPSINFOR)) * (1 - V_CNR) ; 

REPFOREST2 = max(0 , REPFOR2 - max(0 , max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR_R) - REPFOR - REPSINFOR - REPFOR1 - REPSINFOR1)) * (1 - V_CNR) ;

REPFORSIN2 = max(0 , REPSINFOR2 - max(0 , max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR_R) - REPFOR - REPSINFOR - REPFOR1 - REPSINFOR1)) * (1 - V_CNR) ; 

REPFOREST3 = max(0 , REPFOR3 - max(0 , max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR_R) - REPFOR - REPSINFOR - REPFOR1 - REPSINFOR1 - REPFOR2 - REPSINFOR2)) * (1 - V_CNR) ;

REPFORSIN3 = max(0 , REPSINFOR3 - max(0 , max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR_R) - REPFOR - REPSINFOR - REPFOR1 - REPSINFOR1 - REPFOR2 - REPSINFOR2)) * (1 - V_CNR) ; 

REPEST = max(0 , max(0 , FORTRA - max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR_R)) - (REPBON + REPSIN + REPFOREST + REPFORSIN + REPFOREST2 + REPFORSIN2 + REPFOREST3 + REPFORSIN3)) 
	  * (1 - positif(SINISFORET)) * (1 - V_CNR) ; 

REPNIS = max(0 , max(0 , FORTRA - max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR_R)) - (REPBON + REPSIN + REPFOREST + REPFORSIN + REPFOREST2 + REPFORSIN2 + REPFOREST3 + REPFORSIN3)) 
	  * positif(SINISFORET) * (1 - V_CNR) ;

REPFORTOT = REPFOREST + REPFOREST2 + REPFOREST3 + REPEST ;

REPFORESTA = REPSIN + REPFORSIN + REPFORSIN2 + REPFORSIN3 + REPNIS ;

regle 4096:
application : iliad , batch  ;


DCREAT = CONVCREA ;

DCREATHANDI = CONVHAND ;


ACREAT = ( DCREAT * (1-ART1731BIS) 
           + min( DCREAT, max( ACREAT_P , ACREAT1731+0 )) * ART1731BIS 
         ) * (1 - V_CNR) ;

ACREATHANDI = ( DCREATHANDI * (1-ART1731BIS) 
                + min( DCREATHANDI , max(ACREATHANDI_P , ACREATHANDI1731 )) * ART1731BIS 
              ) * (1 - V_CNR) ; 


RCREATEUR = CONVCREA/2 * PLAF_CRENTR * (1 - V_CNR) ;

RCREATEURHANDI = CONVHAND/2 * PLAF_CRENTRH * (1 - V_CNR) ;

regle 1004096:
application : iliad , batch  ;

RCREAT_1 = max(min( RCREATEUR + RCREATEURHANDI , RRI1-RLOGDOM) , 0) ;

RCREAT = max( 0, RCREAT_1 * (1-ART1731BIS) 
                 + min( RCREAT_1 , max(RCREAT_P , RCREAT1731+0 )) * ART1731BIS ) ;

regle 4095:
application : iliad , batch  ;
BDIFAGRI =   min ( INTDIFAGRI , LIM_DIFAGRI * ( 1 + BOOL_0AM)) * ( 1 - V_CNR) ;

DDIFAGRI = INTDIFAGRI ;
ADIFAGRI = BDIFAGRI * (1-ART1731BIS) 
           + min(BDIFAGRI , max(ADIFAGRI_P , ADIFAGRI1731+0)) * ART1731BIS ;

RAGRI = arr (BDIFAGRI  * TX_DIFAGRI / 100 );
RDIFAGRI_1 = max( min(RAGRI , IDOM11-DEC11-RCOTFOR-RREPA-RAIDE),0);
RDIFAGRI = max( 0 , RDIFAGRI_1 * (1-ART1731BIS) 
                    + min( RDIFAGRI_1 , max(RDIFAGRI_P , RDIFAGRI1731+0)) * ART1731BIS );

regle 430 :
application : iliad , batch  ;

ITRED = min( RED , IDOM11-DEC11) ;

MODSEUL = positif(RREVMOD) * null(ITRED - RREVMOD) ;


  ####   #    #    ##    #####           #####    #####   ##   ##    
 #    #  #    #   #  #   #    #          #    #  #     #  # # # #
 #       ######  #    #  #    #    ###   #    #  #     #  #  #  #
 #       #    #  ######  #####           #    #  #     #  #     #
 #    #  #    #  #    #  #               #    #  #     #  #     #
  ####   #    #  #    #  #               #####    #####   #     #

regle 40705 :
application : iliad , batch  ;

NRCREAT = (max(min( RCREATEUR + RCREATEURHANDI , RRI1-NRLOGDOM ) , 0)) ;

NRCOMP = (max(min( RFC , RRI1-NRLOGDOM-NRCREAT) , 0)) ;

NRRETU = (max(min( RETUD , RRI1-NRLOGDOM-NRCREAT-NRCOMP) , 0)) ;

NRDONS = (max(min( RON , RRI1-NRLOGDOM-NRCREAT-NRCOMP-NRRETU) , 0)) ;

NRDUFLOGIH = (max(min( RDUFLO_GIH , RRI1-NRLOGDOM-NRCREAT-NRCOMP-NRRETU-NRDONS) , 0)) ;

NRNOUV = (max(min( RSN , RRI1-NRLOGDOM-NRCREAT-NRCOMP-NRRETU-NRDONS-NRDUFLOGIH) , 0 )) ;

NRFOR = (max(min( RFOREST , RRI1-NRLOGDOM-NRCREAT-NRCOMP-NRRETU-NRDONS-NRDUFLOGIH-NRNOUV) , 0 )) ;

NRTOURREP = (max(min( arr(ATOURREP * TX_REDIL25 / 100) , 
                         RRI1-NRLOGDOM-NRCREAT-NRCOMP-NRRETU-NRDONS-NRDUFLOGIH-NRNOUV-NRFOR) , 0 )) ;

NRTOUHOTR = (max(min( RIHOTR , RRI1-NRLOGDOM-NRCREAT-NRCOMP-NRRETU-NRDONS-NRDUFLOGIH-NRNOUV-NRFOR-NRTOURREP) , 0)
	        * (1-positif(null(2-V_REGCO)+null(4-V_REGCO)))) ;

NRTOUREPA = (max(min( arr(ATOUREPA * TX_REDIL20 / 100) ,
			 RRI1-NRLOGDOM-NRCREAT-NRCOMP-NRRETU-NRDONS-NRDUFLOGIH-NRNOUV-NRFOR-NRTOURREP-NRTOUHOTR) , 0)) ;

NRRI2 = (NRCREAT + NRCOMP + NRRETU + NRDONS + NRDUFLOGIH + NRNOUV + NRFOR + NRTOURREP + NRTOUHOTR + NRTOUREPA) ;

NRCELRREDLA = (max( min(CELRREDLA , RRI1-NRLOGDOM-NRRI2) , 0)) ;

NRCELRREDLB = (max( min(CELRREDLB , RRI1-NRLOGDOM-NRRI2-NRCELRREDLA) , 0)) ;

NRCELRREDLE = (max( min(CELRREDLE , RRI1-NRLOGDOM-NRRI2-NRCELRREDLA-NRCELRREDLB) , 0)) ;

NRCELRREDLM = (max( min(CELRREDLM , RRI1-NRLOGDOM-NRRI2-NRCELRREDLA-NRCELRREDLB-NRCELRREDLE) , 0)) ;

NRCELRREDLC = (max( min(CELRREDLC , RRI1-NRLOGDOM-NRRI2 - somme(i=A,B,E,M : NRCELRREDLi)) , 0)) ;

NRCELRREDLD = (max( min(CELRREDLD , RRI1-NRLOGDOM-NRRI2 - somme(i=A,B,E,M,C : NRCELRREDLi)) , 0)) ;

NRCELRREDLS = (max( min(CELRREDLS , RRI1-NRLOGDOM-NRRI2 - somme(i=A,B,E,M,C,D : NRCELRREDLi)) , 0)) ;

NRCELRREDLF = (max( min(CELRREDLF , RRI1-NRLOGDOM-NRRI2 - somme(i=A,B,E,M,C,D,S : NRCELRREDLi)) , 0)) ;

NRCELRREDLZ = (max( min(CELRREDLZ , RRI1-NRLOGDOM-NRRI2 - somme(i=A,B,E,M,C,D,S,F : NRCELRREDLi)) , 0)) ;

NRCELRREDMG = (max( min(CELRREDMG , RRI1-NRLOGDOM-NRRI2 - somme(i=A,B,E,M,C,D,S,F,Z : NRCELRREDLi)) , 0)) ;

NRCELREPHS = (max( min(RCELREP_HS , RRI1-NRLOGDOM-NRRI2 - somme(i=A,B,E,M,C,D,S,F,Z : NRCELRREDLi) - NRCELRREDMG ) , 0)) ;

NRCELREPHR = (max( min(RCELREP_HR , RRI1-NRLOGDOM-NRRI2-somme(i=A,B,E,M,C,D,S,F,Z : NRCELRREDLi)-NRCELRREDMG-NRCELREPHS) , 0)) ;

NRCELREPHU = (max( min(RCELREP_HU , RRI1-NRLOGDOM-NRRI2-somme(i=A,B,E,M,C,D,S,F,Z : NRCELRREDLi)-NRCELRREDMG
                                                       -somme (i=S,R : NRCELREPHi )) , 0)) ;

NRCELREPHT = (max( min(RCELREP_HT , RRI1-NRLOGDOM-NRRI2-somme(i=A,B,E,M,C,D,S,F,Z : NRCELRREDLi)-NRCELRREDMG
                                                       -somme (i=S,R,U : NRCELREPHi )) , 0)) ;

NRCELREPHZ = (max( min(RCELREP_HZ , RRI1-NRLOGDOM-NRRI2-somme(i=A,B,E,M,C,D,S,F,Z : NRCELRREDLi)-NRCELRREDMG
                                                       -somme (i=S,R,U,T : NRCELREPHi )) , 0)) ;

NRCELREPHX = (max( min(RCELREP_HX , RRI1-NRLOGDOM-NRRI2-somme(i=A,B,E,M,C,D,S,F,Z : NRCELRREDLi)-NRCELRREDMG
                                                       -somme (i=S,R,U,T,Z : NRCELREPHi )) , 0)) ;

NRCELREPHW = (max( min(RCELREP_HW , RRI1-NRLOGDOM-NRRI2-somme(i=A,B,E,M,C,D,S,F,Z : NRCELRREDLi)-NRCELRREDMG
                                                       -somme (i=S,R,U,T,Z,X : NRCELREPHi )) , 0)) ;

NRCELREPHV = (max( min(RCELREP_HV , RRI1-NRLOGDOM-NRRI2-somme(i=A,B,E,M,C,D,S,F,Z : NRCELRREDLi)-NRCELRREDMG
                                                       -somme (i=S,R,U,T,Z,X,W : NRCELREPHi )) , 0)) ;

NRCELREPHF = (max( min(RCELREP_HF , RRI1-NRLOGDOM-NRRI2-somme(i=A,B,E,M,C,D,S,F,Z : NRCELRREDLi)-NRCELRREDMG
                                                       -somme (i=S,R,U,T,Z,X,W,V : NRCELREPHi )) , 0)) ;

NRCELREPHE = (max( min(RCELREP_HE , RRI1-NRLOGDOM-NRRI2-somme(i=A,B,E,M,C,D,S,F,Z : NRCELRREDLi)-NRCELRREDMG
                                                       -somme (i=S,R,U,T,Z,X,W,V,F : NRCELREPHi )) , 0)) ;

NRCELREPHD = (max( min(RCELREP_HD , RRI1-NRLOGDOM-NRRI2-somme(i=A,B,E,M,C,D,S,F,Z : NRCELRREDLi)-NRCELRREDMG
                                                       -somme (i=S,R,U,T,Z,X,W,V,F,E : NRCELREPHi )) , 0)) ;

NRCELREPHH = (max( min(RCELREP_HH , RRI1-NRLOGDOM-NRRI2-somme(i=A,B,E,M,C,D,S,F,Z : NRCELRREDLi)-NRCELRREDMG
                                                       -somme (i=S,R,U,T,Z,X,W,V,F,E,D : NRCELREPHi )) , 0)) ;

NRCELREPHG = (max( min(RCELREP_HG , RRI1-NRLOGDOM-NRRI2-somme(i=A,B,E,M,C,D,S,F,Z : NRCELRREDLi)-NRCELRREDMG
                                                       -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H : NRCELREPHi )) , 0)) ;

NRCELREPHB = (max( min(RCELREP_HB , RRI1-NRLOGDOM-NRRI2-somme(i=A,B,E,M,C,D,S,F,Z : NRCELRREDLi)-NRCELRREDMG
                                                       -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G : NRCELREPHi )) , 0)) ;

NRCELREPHA = (max( min(RCELREP_HA , RRI1-NRLOGDOM-NRRI2-somme(i=A,B,E,M,C,D,S,F,Z : NRCELRREDLi)-NRCELRREDMG
                                                       -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B : NRCELREPHi )) , 0)) ;

NRCELHM = (max( min(RCEL_HM , RRI1-NRLOGDOM-NRRI2-somme(i=A,B,E,M,C,D,S,F,Z : NRCELRREDLi)-NRCELRREDMG
                                                       -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : NRCELREPHi ) 
                                                       -somme (i=U,X,T,S,W,P,L,V,K,J : NRCELREPGi )) , 0)) ;

NRCELHL = (max( min(RCEL_HL , RRI1-NRLOGDOM-NRRI2-somme(i=A,B,E,M,C,D,S,F,Z : NRCELRREDLi)-NRCELRREDMG
                                                       -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : NRCELREPHi ) 
                                                       -somme (i=U,X,T,S,W,P,L,V,K,J : NRCELREPGi )
			                               -NRCELHM) , 0)) ;

NRCELHNO = (max( min(RCEL_HNO , RRI1-NRLOGDOM-NRRI2-somme(i=A,B,E,M,C,D,S,F,Z : NRCELRREDLi)-NRCELRREDMG
                                                       -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : NRCELREPHi ) 
                                                       -somme (i=U,X,T,S,W,P,L,V,K,J : NRCELREPGi )
			                               -NRCELHM-NRCELHL) , 0)) ;

NRCELHJK = (max( min(RCEL_HJK , RRI1-NRLOGDOM-NRRI2-somme(i=A,B,E,M,C,D,S,F,Z : NRCELRREDLi)-NRCELRREDMG
                                                       -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : NRCELREPHi ) 
                                                       -somme (i=U,X,T,S,W,P,L,V,K,J : NRCELREPGi )
			                               -NRCELHM-NRCELHL-NRCELHNO ) , 0)) ;

NRCELNQ = (max( min(RCEL_NQ , RRI1-NRLOGDOM-NRRI2-somme(i=A,B,E,M,C,D,S,F,Z : NRCELRREDLi)-NRCELRREDMG
                                                      -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : NRCELREPHi )
                                                       -somme (i=U,X,T,S,W,P,L,V,K,J : NRCELREPGi ) 
                                                       -NRCELHM-NRCELHL-NRCELHNO-NRCELHJK ) , 0)) ;

NRCELNBGL = (max( min(RCEL_NBGL , RRI1-NRLOGDOM-NRRI2-somme(i=A,B,E,M,C,D,S,F,Z : NRCELRREDLi)-NRCELRREDMG
                                                       -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : NRCELREPHi )
                                                       -somme (i=U,X,T,S,W,P,L,V,K,J : NRCELREPGi ) 
                                                       -NRCELHM-NRCELHL-NRCELHNO-NRCELHJK-NRCELNQ ) , 0)) ;

NRCELCOM = (max( min(RCEL_COM , RRI1-NRLOGDOM-NRRI2-somme(i=A,B,E,M,C,D,S,F,Z : NRCELRREDLi)-NRCELRREDMG
                                                       -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : NRCELREPHi )
                                                       -somme (i=U,X,T,S,W,P,L,V,K,J : NRCELREPGi ) 
                                                       -NRCELHM-NRCELHL-NRCELHNO-NRCELHJK-NRCELNQ-NRCELNBGL ) , 0)) ;

NRCEL = (max( min(RCEL_2011 , RRI1-NRLOGDOM-NRRI2-somme(i=A,B,E,M,C,D,S,F,Z : NRCELRREDLi)-NRCELRREDMG
                                                       -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : NRCELREPHi )
                                                       -somme (i=U,X,T,S,W,P,L,V,K,J : NRCELREPGi ) 
                                                       -NRCELHM-NRCELHL-NRCELHNO-NRCELHJK-NRCELNQ-NRCELNBGL 
                                                       -NRCELCOM) , 0)) ;

NRCELJP = (max( min(RCEL_JP , RRI1-NRLOGDOM-NRRI2-somme(i=A,B,E,M,C,D,S,F,Z : NRCELRREDLi)-NRCELRREDMG
                                                       -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : NRCELREPHi )
                                                       -somme (i=U,X,T,S,W,P,L,V,K,J : NRCELREPGi )
                                                       -NRCELHM-NRCELHL-NRCELHNO-NRCELHJK-NRCELNQ-NRCELNBGL
                                                       -NRCELCOM-NRCEL) , 0)) ;

NRCELJBGL = (max( min(RCEL_JBGL , RRI1-NRLOGDOM-NRRI2-somme(i=A,B,E,M,C,D,S,F,Z : NRCELRREDLi)-NRCELRREDMG
                                                       -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : NRCELREPHi )
                                                       -somme (i=U,X,T,S,W,P,L,V,K,J : NRCELREPGi )
                                                       -NRCELHM-NRCELHL-NRCELHNO-NRCELHJK-NRCELNQ-NRCELNBGL
                                                       -NRCELCOM-NRCEL-NRCELJP) , 0)) ;

NRCELJOQR = (max( min(RCEL_JOQR , RRI1-NRLOGDOM-NRRI2-somme(i=A,B,E,M,C,D,S,F,Z : NRCELRREDLi)-NRCELRREDMG
                                                       -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : NRCELREPHi )
                                                       -somme (i=U,X,T,S,W,P,L,V,K,J : NRCELREPGi )
                                                       -NRCELHM-NRCELHL-NRCELHNO-NRCELHJK-NRCELNQ-NRCELNBGL
                                                       -NRCELCOM-NRCEL-NRCELJP-NRCELJBGL) , 0)) ;

NRCEL2012 = (max( min(RCEL_2012 , RRI1-NRLOGDOM-NRRI2-somme(i=A,B,E,M,C,D,S,F,Z : NRCELRREDLi)-NRCELRREDMG
                                                       -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : NRCELREPHi )
                                                       -somme (i=U,X,T,S,W,P,L,V,K,J : NRCELREPGi )
                                                       -NRCELHM-NRCELHL-NRCELHNO-NRCELHJK-NRCELNQ-NRCELNBGL
                                                       -NRCELCOM-NRCEL-NRCELJP-NRCELJBGL-NRCELJOQR) , 0)) ;

NRCELFD = (max( min(RCEL_FD , RRI1-NRLOGDOM-NRRI2-somme(i=A,B,E,M,C,D,S,F,Z : NRCELRREDLi)-NRCELRREDMG
                                                       -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : NRCELREPHi )
                                                       -somme (i=U,X,T,S,W,P,L,V,K,J : NRCELREPGi )
                                                       -NRCELHM-NRCELHL-NRCELHNO-NRCELHJK-NRCELNQ-NRCELNBGL
                                                       -NRCELCOM-NRCEL-NRCELJP-NRCELJBGL-NRCELJOQR-NRCEL2012) , 0)) ;

NRCELFABC = (max( min(RCEL_FABC , RRI1-NRLOGDOM-NRRI2-somme(i=A,B,E,M,C,D,S,F,Z : NRCELRREDLi)-NRCELRREDMG
                                                       -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : NRCELREPHi )
                                                       -somme (i=U,X,T,S,W,P,L,V,K,J : NRCELREPGi )
                                                       -NRCELHM-NRCELHL-NRCELHNO-NRCELHJK-NRCELNQ-NRCELNBGL
                                                       -NRCELCOM-NRCEL-NRCELJP-NRCELJBGL-NRCELJOQR-NRCEL2012-NRCELFD) , 0)) ;

NRCELTOT = (somme(i=A,B,E,M,C,D,S,F,Z : NRCELRREDLi) + NRCELRREDMG
                  + somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : NRCELREPHi )
                  + somme (i=U,X,T,S,W,P,L,V,K,J : NRCELREPGi )
                  + NRCELHM+NRCELHL+NRCELHNO+NRCELHJK+NRCELNQ+NRCELNBGL
                  + NRCELCOM+NRCEL+NRCELJP+NRCELJBGL+NRCELJOQR+NRCEL2012+NRCELFD+NRCELFABC) ;

NRREDMEUB = (max(min( AREDMEUB , RRI1-NRLOGDOM-NRRI2-NRCELTOT) , 0)) ;

NRREDREP = (max(min( AREDREP , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB) , 0)) ;

NRILMIX = (max(min( AILMIX , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP) , 0)) ;

NRILMIY = (max(min( AILMIY , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX) , 0)) ;

NRINVRED = (max(min( AINVRED , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY) , 0)) ;

NRILMIH = (max(min( AILMIH , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRINVRED) , 0)) ;

NRILMJC = (max(min(AILMJC , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRINVRED-NRILMIH) , 0)) ;

NRILMIZ = (max(min( AILMIZ , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRINVRED-NRILMIH-NRILMJC) , 0)) ;

NRILMJI = (max(min( AILMJI , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRINVRED-NRILMIH-NRILMJC-NRILMIZ) , 0)) ;

NRILMJS = (max(min( AILMJS , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRINVRED-NRILMIH-NRILMJC-NRILMIZ-NRILMJI) , 0)) ;

NRMEUBLE = (max(min( MEUBLERET , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRINVRED-NRILMIH-NRILMJC-NRILMIZ-NRILMJI-NRILMJS) , 0)) ;

NRPROREP = (max(min( RETPROREP , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRINVRED-NRILMIH-NRILMJC-NRILMIZ-NRILMJI-NRILMJS-NRMEUBLE) , 0)) ;

NRREPNPRO = (max(min( RETREPNPRO , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRINVRED-NRILMIH-NRILMJC-NRILMIZ-NRILMJI-NRILMJS-NRMEUBLE-NRPROREP) , 0)) ;

NRREPMEU = (max(min( RETREPMEU , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRINVRED-NRILMIH-NRILMJC-NRILMIZ-NRILMJI-NRILMJS-NRMEUBLE-NRPROREP
                                -NRREPNPRO) , 0)) ;

NRILMIC = (max(min( AILMIC , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRINVRED-NRILMIH-NRILMJC-NRILMIZ-NRILMJI-NRILMJS-NRMEUBLE-NRPROREP
                            -NRREPNPRO-NRREPMEU) , 0)) ;

NRILMIB = (max(min( AILMIB , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRINVRED-NRILMIH-NRILMJC-NRILMIZ-NRILMJI-NRILMJS-NRMEUBLE-NRPROREP
                            -NRREPNPRO-NRREPMEU-NRILMIC) , 0)) ;

NRILMIA = (max(min( AILMIA , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRINVRED-NRILMIH-NRILMJC-NRILMIZ-NRILMJI-NRILMJS-NRMEUBLE-NRPROREP
                            -NRREPNPRO-NRREPMEU-NRILMIC-NRILMIB) , 0)) ;

NRILMJY = (max(min( AILMJY , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRINVRED-NRILMIH-NRILMJC-NRILMIZ-NRILMJI-NRILMJS-NRMEUBLE-NRPROREP
                            -NRREPNPRO-NRREPMEU-NRILMIC-NRILMIB-NRILMIA) , 0)) ;

NRILMJX = (max(min( AILMJX , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRINVRED-NRILMIH-NRILMJC-NRILMIZ-NRILMJI-NRILMJS-NRMEUBLE-NRPROREP
                            -NRREPNPRO-NRREPMEU-NRILMIC-NRILMIB-NRILMIA-NRILMJY) , 0)) ;

NRILMJW = (max(min( AILMJW , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRINVRED-NRILMIH-NRILMJC-NRILMIZ-NRILMJI-NRILMJS-NRMEUBLE-NRPROREP
                            -NRREPNPRO-NRREPMEU-NRILMIC-NRILMIB-NRILMIA-NRILMJY-NRILMJX) , 0)) ;

NRILMJV = (max(min( AILMJV , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRINVRED-NRILMIH-NRILMJC-NRILMIZ-NRILMJI-NRILMJS-NRMEUBLE-NRPROREP
                            -NRREPNPRO-NRREPMEU-NRILMIC-NRILMIB-NRILMIA-NRILMJY-NRILMJX-NRILMJW) , 0)) ;

NRRESIMEUB = (max(min( RETRESIMEUB , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRINVRED-NRILMIH-NRILMJC-NRILMIZ-NRILMJI-NRILMJS-NRMEUBLE-NRPROREP
                                    -NRREPNPRO-NRREPMEU-NRILMIC-NRILMIB-NRILMIA-NRILMJY-NRILMJX-NRILMJW-NRILMJV) , 0)) ;

NRRESIVIEU = (max(min( RETRESIVIEU , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRINVRED-NRILMIH-NRILMJC-NRILMIZ-NRILMJI-NRILMJS-NRMEUBLE-NRPROREP
                                    -NRREPNPRO-NRREPMEU-NRILMIC-NRILMIB-NRILMIA-NRILMJY-NRILMJX-NRILMJW-NRILMJV-NRRESIMEUB) , 0)) ;

NRRESINEUV = (max(min( RETRESINEUV , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRINVRED-NRILMIH-NRILMJC-NRILMIZ-NRILMJI-NRILMJS-NRMEUBLE-NRPROREP
                                    -NRREPNPRO-NRREPMEU-NRILMIC-NRILMIB-NRILMIA-NRILMJY-NRILMJX-NRILMJW-NRILMJV-NRRESIMEUB-NRRESIMEUB) , 0)) ;

NRLOCIDEFG = (max(min( RETLOCIDEFG , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRINVRED-NRILMIH-NRILMJC-NRILMIZ-NRILMJI-NRILMJS-NRMEUBLE-NRPROREP
                                    -NRREPNPRO-NRREPMEU-NRILMIC-NRILMIB-NRILMIA-NRILMJY-NRILMJX-NRILMJW-NRILMJV-NRRESIMEUB-NRRESIMEUB-NRRESINEUV) , 0)) ;

NRCODJU = (max(min( RETCODJU , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRINVRED-NRILMIH-NRILMJC-NRILMIZ-NRILMJI-NRILMJS-NRMEUBLE-NRPROREP
                                  -NRREPNPRO-NRREPMEU-NRILMIC-NRILMIB-NRILMIA-NRILMJY-NRILMJX-NRILMJW-NRILMJV-NRRESIMEUB-NRRESIMEUB-NRRESINEUV-NRLOCIDEFG) , 0)) ;

NRCODJT = (max(min( RETCODJT , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRINVRED-NRILMIH-NRILMJC-NRILMIZ-NRILMJI-NRILMJS-NRMEUBLE-NRPROREP
                                  -NRREPNPRO-NRREPMEU-NRILMIC-NRILMIB-NRILMIA-NRILMJY-NRILMJX-NRILMJW-NRILMJV-NRRESIMEUB-NRRESIMEUB-NRRESINEUV-NRLOCIDEFG-NRCODJU) , 0)) ;

NRLOCNPRO = (NRREDMEUB + NRREDREP + NRILMIX + NRILMIY + NRINVRED + NRILMIH + NRILMJC + NRILMIZ + NRILMJI + NRILMJS + NRMEUBLE + NRPROREP + NRREPNPRO + NRREPMEU 
	           + NRILMIC + NRILMIB + NRILMIA + NRILMJY + NRILMJX + NRILMJW + NRILMJV + NRRESIMEUB + NRRESIVIEU + NRRESINEUV + NRLOCIDEFG + NRCODJU + NRCODJT) ;

NRPATNAT1 = (max(min(APATNAT1 , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO) , 0 )) ;

NRPATNAT2 = (max(min(APATNAT2 , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT1) , 0 )) ;

NRPATNAT3 = (max(min(APATNAT3 , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT1-NRPATNAT2) , 0 )) ;

NRPATNAT = (max(min(RAPATNAT , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT1-NRPATNAT2-NRPATNAT3) , 0 )) ;

regle 40706 :
application : iliad , batch  ;

NPLAFDOMPRO1 = (max(0 , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRCELTOT-NRLOCNPRO-NRPATNAT1-NRPATNAT2-NRPATNAT3-NRPATNAT)) ;

NRIDOMPROE3 = (min(REPINVDOMPRO3 , NPLAFDOMPRO1) * (1 - V_CNR)) ;

NRIDOMPROTOT = NRIDOMPROE3 ;

NRRI3 = NRCELTOT + NRLOCNPRO + NRPATNAT1 + NRPATNAT2 + NRPATNAT3 + NRPATNAT + NRIDOMPROTOT ;

regle 4082 :
application : iliad, batch ;



DLOGDOM = INVLOG2008 + INVLGDEB2009 + INVLGDEB + INVLGAUTRE + INVLGDEB2010 + INVLOG2009 
	  + INVOMLOGOA + INVOMLOGOB + INVOMLOGOC + INVOMLOGOH + INVOMLOGOI + INVOMLOGOJ 
	  + INVOMLOGOK + INVOMLOGOL + INVOMLOGOM + INVOMLOGON + INVOMLOGOO + INVOMLOGOP
	  + INVOMLOGOQ + INVOMLOGOR + INVOMLOGOS + INVOMLOGOT + INVOMLOGOU + INVOMLOGOV + INVOMLOGOW 
          + CODHOD + CODHOE + CODHOF + CODHOG + CODHOX + CODHOY + CODHOZ ;


DDOMSOC1 = INVSOCNRET + INVOMSOCKH + INVOMSOCKI + INVSOC2010 + INVOMSOCQU + INVLOGSOC 
           + INVOMSOCQJ + INVOMSOCQS + INVOMSOCQW + INVOMSOCQX ;

DLOGSOC = CODHRA + CODHRB + CODHRC + CODHRD ;


DCOLENT = INVOMREP + NRETROC50 + NRETROC40 + INVENDI + INVOMENTMN + RETROCOMLH + RETROCOMMB
	  + INVOMENTKT + RETROCOMLI + RETROCOMMC + INVOMENTKU + INVOMQV + INVENDEB2009 + INVRETRO1 
	  + INVRETRO2 + INVIMP + INVDOMRET50 + INVDOMRET60 + INVDIR2009 + INVOMRETPA + INVOMRETPB 
	  + INVOMRETPD + INVOMRETPE + INVOMRETPF + INVOMRETPH + INVOMRETPI + INVOMRETPJ + INVOMRETPL 
          + INVOMRETPM + INVOMRETPN + INVOMRETPO + INVOMRETPP + INVOMRETPR + INVOMRETPS + INVOMRETPT
	  + INVOMRETPU + INVOMRETPW + INVOMRETPX + INVOMRETPY + INVOMENTRG + INVOMENTRI + INVOMENTRJ 
	  + INVOMENTRK + INVOMENTRL + INVOMENTRM + INVOMENTRO + INVOMENTRP + INVOMENTRQ + INVOMENTRR 
	  + INVOMENTRT + INVOMENTRU + INVOMENTRV + INVOMENTRW + INVOMENTRY + INVOMENTNU + INVOMENTNV 
          + INVOMENTNW + INVOMENTNY ;

DLOCENT = CODHSA + CODHSB + CODHSC + CODHSD + CODHSF + CODHSG + CODHSH + CODHSI
          + CODHSK + CODHSL + CODHSM + CODHSN + CODHSP + CODHSQ + CODHSR + CODHSS 
          + CODHSU + CODHSV + CODHSW + CODHSX + CODHSZ + CODHTA + CODHTB + CODHTC ;

regle 4000 :
application : iliad, batch ;


TOTALPLAF1 = INVRETKG + INVRETKH + INVRETKI + INVRETQN + INVRETQU + INVRETQK + INVRETQJ + INVRETQS + INVRETQW + INVRETQX 
             + INVRETRA + INVRETRB + INVRETRC + INVRETRD
	     + INVRETMA + INVRETLG + INVRETMB + INVRETLH + INVRETMC + INVRETLI + INVRETQP + INVRETQG + INVRETQO + INVRETQF  
	     + INVRETPO + INVRETPT + INVRETPN + INVRETPS + INVRETPP + INVRETPU + INVRETKS + INVRETKT + INVRETKU + INVRETQR 
	     + INVRETQI + INVRETPR + INVRETPW + INVRETQL + INVRETQM + INVRETQD + INVRETOB + INVRETOC + INVRETOM + INVRETON  
             + INVRETOD
	     + INVRETKGR + INVRETKHR + INVRETKIR + INVRETQNR + INVRETQUR + INVRETQKR + INVRETQJR + INVRETQSR + INVRETQWR
	     + INVRETQXR + INVRETRAR + INVRETRBR + INVRETRCR + INVRETRDR 
             + INVRETMAR + INVRETLGR + INVRETMBR + INVRETLHR + INVRETMCR + INVRETLIR + INVRETQPR + INVRETQGR 
	     + INVRETQOR + INVRETQFR + INVRETPOR + INVRETPTR + INVRETPNR + INVRETPSR ;

TOTALPLAF2 = INVRETPB + INVRETPF + INVRETPJ + INVRETPA + INVRETPE + INVRETPI + INVRETPY + INVRETPX + INVRETRG + INVRETPD 
	     + INVRETPH + INVRETPL + INVRETRI + INVRETSB + INVRETSG + INVRETSA + INVRETSF + INVRETSC + INVRETSH + INVRETSE 
             + INVRETSJ + INVRETOI + INVRETOJ + INVRETOK + INVRETOP + INVRETOQ + INVRETOR + INVRETOE + INVRETOF
	     + INVRETPBR + INVRETPFR + INVRETPJR + INVRETPAR + INVRETPER + INVRETPIR + INVRETPYR + INVRETPXR + INVRETSBR
             + INVRETSGR + INVRETSAR + INVRETSFR ;

TOTALPLAF3 = INVRETRL + INVRETRQ + INVRETRV + INVRETNV + INVRETRK + INVRETRP + INVRETRU + INVRETNU + INVRETRM + INVRETRR 
	     + INVRETRW + INVRETNW + INVRETRO + INVRETRT + INVRETRY + INVRETNY + INVRETSL + INVRETSQ + INVRETSV + INVRETTA
             + INVRETSK + INVRETSP + INVRETSU + INVRETSZ + INVRETSM + INVRETSR + INVRETSW + INVRETTB + INVRETSO + INVRETST
             + INVRETSY + INVRETTD + INVRETOT + INVRETOU + INVRETOV + INVRETOW + INVRETOG + INVRETOX + INVRETOY + INVRETOZ
	     + INVRETRLR + INVRETRQR + INVRETRVR + INVRETNVR + INVRETRKR + INVRETRPR + INVRETRUR + INVRETNUR + INVRETSLR
             + INVRETSQR + INVRETSVR + INVRETTAR + INVRETSKR + INVRETSPR + INVRETSUR + INVRETSZR ;

RNIDOM1 = arr((RNG + TTPVQ) * TX15/100) ;

RNIDOM2 = arr((RNG + TTPVQ) * TX13/100) ;

RNIDOM3 = arr((RNG + TTPVQ) * TX11/100) ;

INDPLAF1 = positif(RNIDOM1 - TOTALPLAF1) ;



INVRETKGA = min(arr(NINVRETKG * TX35 / 100) , RNIDOM1) * (1 - V_CNR) ;

INVRETKHA = min(arr(NINVRETKH * TX35 / 100) , max(0 , RNIDOM1 -INVRETKGA)) * (1 - V_CNR) ;

INVRETKIA = min(arr(NINVRETKI * TX35 / 100) , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA)) * (1 - V_CNR) ;

INVRETQNA = min(arr(NINVRETQN * TX35 / 100) , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA)) * (1 - V_CNR) ;

INVRETQUA = min(arr(NINVRETQU * TX35 / 100) , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA)) * (1 - V_CNR) ;

INVRETQKA = min(arr(NINVRETQK * TX35 / 100) , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA)) * (1 - V_CNR) ;

INVRETQJA = min(arr(NINVRETQJ * TX35 / 100) , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA)) * (1 - V_CNR) ;

INVRETQSA = min(arr(NINVRETQS * TX35 / 100) , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA)) * (1 - V_CNR) ;

INVRETQWA = min(arr(NINVRETQW * TX35 / 100) , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA)) * (1 - V_CNR) ;

INVRETQXA = min(arr(NINVRETQX * TX35 / 100) , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA
							   )) * (1 - V_CNR) ;

INVRETRAA = min(arr(NINVRETRA * TX35 / 100) , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA)) * (1 - V_CNR) ;

INVRETRBA = min(arr(NINVRETRB * TX35 / 100) , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
                                                              -INVRETRAA)) * (1 - V_CNR) ;

INVRETRCA = min(arr(NINVRETRC * TX35 / 100) , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
                                                              -INVRETRAA-INVRETRBA)) * (1 - V_CNR) ;

INVRETRDA = min(arr(NINVRETRD * TX35 / 100) , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
                                                              -INVRETRAA-INVRETRBA-INVRETRCA)) * (1 - V_CNR) ;

INVRETMAA = min(arr(NINVRETMA * TX40 / 100) , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
                                                              -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA)) * (1 - V_CNR) ;

INVRETLGA = min(arr(NINVRETLG * TX50 / 100) , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
                                                              -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA)) * (1 - V_CNR) ;

INVRETKSA = min(NINVRETKS , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					    -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA)) * (1 - V_CNR) ;

INVRETMBA = min(arr(NINVRETMB * TX40 / 100) , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
                                                              -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA)) * (1 - V_CNR) ;

INVRETMCA = min(arr(NINVRETMC * TX40 / 100) , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
                                                              -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA)) * (1 - V_CNR) ;

INVRETLHA = min(arr(NINVRETLH * TX50 / 100) , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
                                                              -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETMCA)) * (1 - V_CNR) ;

INVRETLIA = min(arr(NINVRETLI * TX50 / 100) , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
                                                              -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA)) * (1 - V_CNR) ;

INVRETKTA = min(NINVRETKT , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					    -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                            -INVRETLIA)) * (1 - V_CNR) ;

INVRETKUA = min(NINVRETKU , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					    -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                            -INVRETLIA-INVRETKTA)) * (1 - V_CNR) ;

INVRETQPA = min(arr(NINVRETQP * TX40 / 100) , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
                                                              -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                                              -INVRETLIA-INVRETKTA-INVRETKUA)) * (1 - V_CNR) ;

INVRETQGA = min(arr(NINVRETQG * TX40 / 100) , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
                                                              -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                                              -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA)) * (1 - V_CNR) ;

INVRETQOA = min(arr(NINVRETQO * TX50 / 100) , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
                                                              -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                                              -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA)) * (1 - V_CNR) ;

INVRETQFA = min(arr(NINVRETQF * TX50 / 100) , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
                                                              -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                                              -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA)) * (1 - V_CNR) ;

INVRETQRA = min(NINVRETQR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					    -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                            -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA)) * (1 - V_CNR) ;

INVRETQIA = min(NINVRETQI , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					    -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                            -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA)) * (1 - V_CNR) ;

INVRETPOA = min(arr(NINVRETPO * TX40 / 100) , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
                                                              -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                                              -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA)) * (1 - V_CNR) ;

INVRETPTA = min(arr(NINVRETPT * TX40 / 100) , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
                                                              -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                                              -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA)) * (1 - V_CNR) ;

INVRETPNA = min(arr(NINVRETPN * TX50 / 100) , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
                                                              -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                                              -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA
                                                              -INVRETPTA)) * (1 - V_CNR) ;

INVRETPSA = min(arr(NINVRETPS * TX50 / 100) , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
                                                              -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                                              -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA
                                                              -INVRETPTA-INVRETPNA)) * (1 - V_CNR) ;

INVRETPPA = min(NINVRETPP , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					    -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                            -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA
                                            -INVRETPTA-INVRETPNA-INVRETPSA)) * (1 - V_CNR) ;

INVRETPUA = min(NINVRETPU , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					    -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                            -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA
                                            -INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA)) * (1 - V_CNR) ;

INVRETPRA = min(NINVRETPR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					    -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                            -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA
                                            -INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA)) * (1 - V_CNR) ;

INVRETPWA = min(NINVRETPW , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					    -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                            -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA
                                            -INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA)) * (1 - V_CNR) ;

INVRETQLA = min(NINVRETQL , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					    -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                            -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA
                                            -INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA)) * (1 - V_CNR) ;

INVRETQMA = min(NINVRETQM , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					    -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                            -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA
                                            -INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA-INVRETQLA)) * (1 - V_CNR) ;

INVRETQDA = min(NINVRETQD , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					    -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                            -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA
                                            -INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA)) * (1 - V_CNR) ;

INVRETOBA = min(NINVRETOB , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA 
					    -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                            -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA
                                            -INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA)) * (1 - V_CNR) ;

INVRETOCA = min(NINVRETOC , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					    -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                            -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA
                                            -INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA
                                            -INVRETOBA)) * (1 - V_CNR) ;

INVRETOMA = min(NINVRETOM , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					    -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                            -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA
                                            -INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA
                                            -INVRETOBA-INVRETOCA)) * (1 - V_CNR) ;

INVRETONA = min(NINVRETON , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					    -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                            -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA
                                            -INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA
                                            -INVRETOBA-INVRETOCA-INVRETOMA)) * (1 - V_CNR) ;

INVRETODA = min(NINVRETOD , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					    -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                            -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA
                                            -INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA
                                            -INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA)) * (1 - V_CNR) ;

INVRETKGRA = min(NINVRETKGR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA 
					      -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                              -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA
                                              -INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA
                                              -INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA-INVRETODA)) * (1 - V_CNR) ;

INVRETKHRA = min(NINVRETKHR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA 
					      -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                              -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA
                                              -INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA
                                              -INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA-INVRETODA-INVRETKGRA)) * (1 - V_CNR) ;

INVRETKIRA = min(NINVRETKIR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA 
					      -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                              -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA
                                              -INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA
                                              -INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA-INVRETODA-INVRETKGRA-INVRETKHRA)) * (1 - V_CNR) ;

INVRETQNRA = min(NINVRETQNR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					      -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                              -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA
                                              -INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA
                                              -INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA-INVRETODA-INVRETKGRA-INVRETKHRA-INVRETKIRA)) * (1 - V_CNR) ;

INVRETQURA = min(NINVRETQUR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA 
					      -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                              -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA
                                              -INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA
                                              -INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA-INVRETODA-INVRETKGRA-INVRETKHRA-INVRETKIRA-INVRETQNRA)) * (1 - V_CNR) ;

INVRETQKRA = min(NINVRETQKR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					      -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                              -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA
                                              -INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA
                                              -INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA-INVRETODA-INVRETKGRA-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA)) * (1 - V_CNR) ;

INVRETQJRA = min(NINVRETQJR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					      -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                              -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA
                                              -INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA
                                              -INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA-INVRETODA-INVRETKGRA-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA
                                              -INVRETQKRA)) * (1 - V_CNR) ;

INVRETQSRA = min(NINVRETQSR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					      -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                              -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA
                                              -INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA
                                              -INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA-INVRETODA-INVRETKGRA-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA
                                              -INVRETQKRA-INVRETQJRA)) * (1 - V_CNR) ;

INVRETQWRA = min(NINVRETQWR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					      -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                              -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA
                                              -INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA
                                              -INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA-INVRETODA-INVRETKGRA-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA
                                              -INVRETQKRA-INVRETQJRA-INVRETQSRA)) * (1 - V_CNR) ;

INVRETQXRA = min(NINVRETQXR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					      -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                              -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA
                                              -INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA
                                              -INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA-INVRETODA-INVRETKGRA-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA
                                              -INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA)) * (1 - V_CNR) ;

INVRETRARA = min(NINVRETRAR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					      -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                              -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA
                                              -INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA
                                              -INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA-INVRETODA-INVRETKGRA-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA
                                              -INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA-INVRETQXRA)) * (1 - V_CNR) ;

INVRETRBRA = min(NINVRETRBR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					      -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                              -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA
                                              -INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA
                                              -INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA-INVRETODA-INVRETKGRA-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA
                                              -INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA-INVRETQXRA-INVRETRARA)) * (1 - V_CNR) ;

INVRETRCRA = min(NINVRETRCR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					      -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                              -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA
                                              -INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA
                                              -INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA-INVRETODA-INVRETKGRA-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA
                                              -INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA-INVRETQXRA-INVRETRARA-INVRETRBRA)) * (1 - V_CNR) ;

INVRETRDRA = min(NINVRETRDR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					      -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                              -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA
                                              -INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA
                                              -INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA-INVRETODA-INVRETKGRA-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA
                                              -INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA-INVRETQXRA-INVRETRARA-INVRETRBRA-INVRETRCRA)) * (1 - V_CNR) ;

INVRETMARA = min(NINVRETMAR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA 
					      -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                              -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA
                                              -INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA
                                              -INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA-INVRETODA-INVRETKGRA-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA
                                              -INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA-INVRETQXRA-INVRETRARA-INVRETRBRA-INVRETRCRA-INVRETRDRA)) * (1 - V_CNR) ;

INVRETLGRA = min(NINVRETLGR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					      -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                              -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA
                                              -INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA
                                              -INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA-INVRETODA-INVRETKGRA-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA
                                              -INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA-INVRETQXRA-INVRETRARA-INVRETRBRA-INVRETRCRA-INVRETRDRA
                                              -INVRETMARA)) * (1 - V_CNR) ;

INVRETMBRA = min(NINVRETMBR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA 
					      -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                              -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA
                                              -INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA
                                              -INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA-INVRETODA-INVRETKGRA-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA
                                              -INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA-INVRETQXRA-INVRETRARA-INVRETRBRA-INVRETRCRA-INVRETRDRA
                                              -INVRETMARA-INVRETLGRA)) * (1 - V_CNR) ;

INVRETMCRA = min(NINVRETMCR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA 
					      -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                              -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA
                                              -INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA
                                              -INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA-INVRETODA-INVRETKGRA-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA
                                              -INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA-INVRETQXRA-INVRETRARA-INVRETRBRA-INVRETRCRA-INVRETRDRA
                                              -INVRETMARA-INVRETLGRA-INVRETMBRA)) * (1 - V_CNR) ;

INVRETLHRA = min(NINVRETLHR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					      -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                              -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA
                                              -INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA
                                              -INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA-INVRETODA-INVRETKGRA-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA
                                              -INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA-INVRETQXRA-INVRETRARA-INVRETRBRA-INVRETRCRA-INVRETRDRA
                                              -INVRETMARA-INVRETLGRA-INVRETMBRA-INVRETMCRA)) * (1 - V_CNR) ;

INVRETLIRA = min(NINVRETLIR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA 
					      -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                              -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA
                                              -INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA
                                              -INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA-INVRETODA-INVRETKGRA-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA
                                              -INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA-INVRETQXRA-INVRETRARA-INVRETRBRA-INVRETRCRA-INVRETRDRA
                                              -INVRETMARA-INVRETLGRA-INVRETMBRA-INVRETMCRA-INVRETLHRA)) * (1 - V_CNR) ;

INVRETQPRA = min(NINVRETQPR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					      -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                              -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA
                                              -INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA
                                              -INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA-INVRETODA-INVRETKGRA-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA
                                              -INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA-INVRETQXRA-INVRETRARA-INVRETRBRA-INVRETRCRA-INVRETRDRA
                                              -INVRETMARA-INVRETLGRA-INVRETMBRA-INVRETLHRA-INVRETLIRA-INVRETMCRA)) * (1 - V_CNR) ;

INVRETQGRA = min(NINVRETQGR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					      -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                              -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA
                                              -INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA
                                              -INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA-INVRETODA-INVRETKGRA-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA
                                              -INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA-INVRETQXRA-INVRETRARA-INVRETRBRA-INVRETRCRA-INVRETRDRA
                                              -INVRETMARA-INVRETLGRA-INVRETMBRA-INVRETLHRA-INVRETLIRA-INVRETMCRA-INVRETQPRA)) * (1 - V_CNR) ;

INVRETQORA = min(NINVRETQOR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					      -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                              -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA
                                              -INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA
                                              -INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA-INVRETODA-INVRETKGRA-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA
                                              -INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA-INVRETQXRA-INVRETRARA-INVRETRBRA-INVRETRCRA-INVRETRDRA
                                              -INVRETMARA-INVRETLGRA-INVRETMBRA-INVRETLHRA-INVRETLIRA-INVRETMCRA-INVRETQPRA-INVRETQGRA)) * (1 - V_CNR) ;

INVRETQFRA = min(NINVRETQFR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					      -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                              -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA
                                              -INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA
                                              -INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA-INVRETODA-INVRETKGRA-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA
                                              -INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA-INVRETQXRA-INVRETRARA-INVRETRBRA-INVRETRCRA-INVRETRDRA
                                              -INVRETMARA-INVRETLGRA-INVRETMBRA-INVRETLHRA-INVRETLIRA-INVRETMCRA-INVRETQPRA-INVRETQGRA-INVRETQORA)) * (1 - V_CNR) ;

INVRETPORA = min(NINVRETPOR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					      -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                              -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA
                                              -INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA
                                              -INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA-INVRETODA-INVRETKGRA-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA
                                              -INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA-INVRETQXRA-INVRETRARA-INVRETRBRA-INVRETRCRA-INVRETRDRA
                                              -INVRETMARA-INVRETLGRA-INVRETMBRA-INVRETLHRA-INVRETLIRA-INVRETMCRA-INVRETQPRA-INVRETQGRA-INVRETQORA
                                              -INVRETQFRA)) * (1 - V_CNR) ;

INVRETPTRA = min(NINVRETPTR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					      -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                              -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA
                                              -INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA
                                              -INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA-INVRETODA-INVRETKGRA-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA
                                              -INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA-INVRETQXRA-INVRETRARA-INVRETRBRA-INVRETRCRA-INVRETRDRA
                                              -INVRETMARA-INVRETLGRA-INVRETMBRA-INVRETLHRA-INVRETLIRA-INVRETMCRA-INVRETQPRA-INVRETQGRA-INVRETQORA
                                              -INVRETQFRA-INVRETPORA)) * (1 - V_CNR) ;

INVRETPNRA = min(NINVRETPNR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					      -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                              -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA
                                              -INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA
                                              -INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA-INVRETODA-INVRETKGRA-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA
                                              -INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA-INVRETQXRA-INVRETRARA-INVRETRBRA-INVRETRCRA-INVRETRDRA
                                              -INVRETMARA-INVRETLGRA-INVRETMBRA-INVRETLHRA-INVRETLIRA-INVRETMCRA-INVRETQPRA-INVRETQGRA-INVRETQORA
                                              -INVRETQFRA-INVRETPORA-INVRETPTRA)) * (1 - V_CNR) ;

INVRETPSRA = min(NINVRETPSR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					      -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETMAA-INVRETLGA-INVRETKSA-INVRETMBA-INVRETLHA-INVRETMCA
                                              -INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA
                                              -INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA
                                              -INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA-INVRETODA-INVRETKGRA-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA
                                              -INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA-INVRETQXRA-INVRETRARA-INVRETRBRA-INVRETRCRA-INVRETRDRA
                                              -INVRETMARA-INVRETLGRA-INVRETMBRA-INVRETLHRA-INVRETLIRA-INVRETMCRA-INVRETQPRA-INVRETQGRA-INVRETQORA
                                              -INVRETQFRA-INVRETPORA-INVRETPTRA-INVRETPNRA)) * (1 - V_CNR) ;

TOTALPLAFA = INVRETKGA + INVRETKHA + INVRETKIA + INVRETQNA + INVRETQUA + INVRETQKA + INVRETQJA + INVRETQSA + INVRETQWA + INVRETQXA 
             + INVRETRAA + INVRETRBA + INVRETRCA + INVRETRDA + INVRETMAA + INVRETLGA + INVRETKSA + INVRETMBA + INVRETLHA + INVRETMCA
             + INVRETLIA + INVRETKTA + INVRETKUA + INVRETQPA + INVRETQGA + INVRETQOA + INVRETQFA + INVRETQRA + INVRETQIA + INVRETPOA
             + INVRETPTA + INVRETPNA + INVRETPSA + INVRETPPA + INVRETPUA + INVRETPRA + INVRETPWA + INVRETQLA + INVRETQMA + INVRETQDA
             + INVRETOBA + INVRETOCA + INVRETOMA + INVRETONA + INVRETODA 
             + INVRETKGRA + INVRETKHRA + INVRETKIRA + INVRETQNRA + INVRETQURA + INVRETQKRA + INVRETQJRA + INVRETQSRA + INVRETQWRA + INVRETQXRA 
             + INVRETRARA + INVRETRBRA + INVRETRCRA + INVRETRDRA + INVRETMARA + INVRETLGRA + INVRETMBRA + INVRETLHRA + INVRETLIRA + INVRETMCRA 
             + INVRETQPRA + INVRETQGRA + INVRETQORA + INVRETQFRA + INVRETPORA + INVRETPTRA + INVRETPNRA + INVRETPSRA ; 

INDPLAF2 = positif(RNIDOM2 - TOTALPLAF2 - TOTALPLAFA) ;


INVRETPBA = min(arr(NINVRETPB*TX375/100) , max(0,RNIDOM2 - TOTALPLAFA)) * (1 - V_CNR) ; 

INVRETPFA = min(arr(NINVRETPF*TX375/100) , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA)) * (1 - V_CNR) ;

INVRETPJA = min(arr(NINVRETPJ*TX375/100) , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA)) * (1 - V_CNR) ;

INVRETPAA = min(arr(NINVRETPA*TX4737/100) , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA)) * (1 - V_CNR) ;

INVRETPEA = min(arr(NINVRETPE*TX4737/100) , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA- INVRETPAA)) * (1 - V_CNR) ;

INVRETPIA = min(arr(NINVRETPI*TX4737/100) , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA)) * (1 - V_CNR) ;

INVRETPDA = min(NINVRETPD , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA)) * (1 - V_CNR) ;

INVRETPHA = min(NINVRETPH , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA)) * (1 - V_CNR) ;

INVRETPLA = min(NINVRETPL , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA)) * (1 - V_CNR) ;

INVRETPYA = min(arr(NINVRETPY*TX375/100) , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA)) * (1 - V_CNR) ;

INVRETPXA = min(arr(NINVRETPX*TX4737/100) , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA
                                                                                -INVRETPYA)) * (1 - V_CNR) ;

INVRETRGA = min(NINVRETRG , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA
                                                                -INVRETPYA-INVRETPXA)) * (1 - V_CNR) ;

INVRETRIA = min(NINVRETRI , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA
                                                                -INVRETPYA-INVRETPXA-INVRETRGA)) * (1 - V_CNR) ;

INVRETSBA = min(arr(NINVRETSB*TX375/100) , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA
                                                                               -INVRETPYA-INVRETPXA-INVRETRGA-INVRETRIA)) * (1 - V_CNR) ;

INVRETSGA = min(arr(NINVRETSG*TX375/100) , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA
                                                                               -INVRETPYA-INVRETPXA-INVRETRGA-INVRETRIA-INVRETSBA)) * (1 - V_CNR) ;

INVRETSAA = min(arr(NINVRETSA*TX4737/100) , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA
                                                                                -INVRETPYA-INVRETPXA-INVRETRGA-INVRETRIA-INVRETSBA-INVRETSGA)) * (1 - V_CNR) ;

INVRETSFA = min(arr(NINVRETSF*TX4737/100) , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA
                                                                                -INVRETPYA-INVRETPXA-INVRETRGA-INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA)) * (1 - V_CNR) ;

INVRETSCA = min(NINVRETSC , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA
                                                                -INVRETPYA-INVRETPXA-INVRETRGA-INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA)) * (1 - V_CNR) ;

INVRETSHA = min(NINVRETSH , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA
                                                                -INVRETPYA-INVRETPXA-INVRETRGA-INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA)) * (1 - V_CNR) ;

INVRETSEA = min(NINVRETSE , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA
                                                                -INVRETPYA-INVRETPXA-INVRETRGA-INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA
                                                                -INVRETSHA)) * (1 - V_CNR) ;

INVRETSJA = min(NINVRETSJ , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA
                                                                -INVRETPYA-INVRETPXA-INVRETRGA-INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA
                                                                -INVRETSHA-INVRETSEA)) * (1 - V_CNR) ;

INVRETOIA = min(NINVRETOI , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA
                                                                -INVRETPYA-INVRETPXA-INVRETRGA-INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA
                                                                -INVRETSHA-INVRETSEA-INVRETSJA)) * (1 - V_CNR) ;

INVRETOJA = min(NINVRETOJ , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA
                                                                -INVRETPYA-INVRETPXA-INVRETRGA-INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA
                                                                -INVRETSHA-INVRETSEA-INVRETSJA-INVRETOIA)) * (1 - V_CNR) ;

INVRETOKA = min(NINVRETOK , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA
                                                                -INVRETPYA-INVRETPXA-INVRETRGA-INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA
                                                                -INVRETSHA-INVRETSEA-INVRETSJA-INVRETOIA-INVRETOJA)) * (1 - V_CNR) ;

INVRETOPA = min(NINVRETOP , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA
                                                                -INVRETPYA-INVRETPXA-INVRETRGA-INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA
                                                                -INVRETSHA-INVRETSEA-INVRETSJA-INVRETOIA-INVRETOJA-INVRETOKA)) * (1 - V_CNR) ;

INVRETOQA = min(NINVRETOQ , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA
                                                                -INVRETPYA-INVRETPXA-INVRETRGA-INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA
                                                                -INVRETSHA-INVRETSEA-INVRETSJA-INVRETOIA-INVRETOJA-INVRETOKA-INVRETOPA)) * (1 - V_CNR) ;

INVRETORA = min(NINVRETOR , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA
                                                                -INVRETPYA-INVRETPXA-INVRETRGA-INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA
                                                                -INVRETSHA-INVRETSEA-INVRETSJA-INVRETOIA-INVRETOJA-INVRETOKA-INVRETOPA-INVRETOQA)) * (1 - V_CNR) ;

INVRETOEA = min(NINVRETOE , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA
                                                                -INVRETPYA-INVRETPXA-INVRETRGA-INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA
                                                                -INVRETSHA-INVRETSEA-INVRETSJA-INVRETOIA-INVRETOJA-INVRETOKA-INVRETOPA-INVRETOQA-INVRETORA)) * (1 - V_CNR) ;

INVRETOFA = min(NINVRETOF , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA
                                                                -INVRETPYA-INVRETPXA-INVRETRGA-INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA
                                                                -INVRETSHA-INVRETSEA-INVRETSJA-INVRETOIA-INVRETOJA-INVRETOKA-INVRETOPA-INVRETOQA-INVRETORA
                                                                -INVRETOEA)) * (1 - V_CNR) ;

INVRETPBRA = min(NINVRETPBR , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA
                                                                  -INVRETPYA-INVRETPXA-INVRETRGA-INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA
                                                                  -INVRETSHA-INVRETSEA-INVRETSJA-INVRETOIA-INVRETOJA-INVRETOKA-INVRETOPA-INVRETOQA-INVRETORA
                                                                  -INVRETOEA-INVRETOFA)) * (1 - V_CNR) ;

INVRETPFRA = min(NINVRETPFR , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA
                                                                  -INVRETPYA-INVRETPXA-INVRETRGA-INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA
                                                                  -INVRETSHA-INVRETSEA-INVRETSJA-INVRETOIA-INVRETOJA-INVRETOKA-INVRETOPA-INVRETOQA-INVRETORA
                                                                  -INVRETOEA-INVRETOFA-INVRETPBRA)) * (1 - V_CNR) ;

INVRETPJRA = min(NINVRETPJR , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA
                                                                  -INVRETPYA-INVRETPXA-INVRETRGA-INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA
                                                                  -INVRETSHA-INVRETSEA-INVRETSJA-INVRETOIA-INVRETOJA-INVRETOKA-INVRETOPA-INVRETOQA-INVRETORA
                                                                  -INVRETOEA-INVRETOFA-INVRETPBRA-INVRETPFRA)) * (1 - V_CNR) ;

INVRETPARA = min(NINVRETPAR , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA
                                                                  -INVRETPYA-INVRETPXA-INVRETRGA-INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA
                                                                  -INVRETSHA-INVRETSEA-INVRETSJA-INVRETOIA-INVRETOJA-INVRETOKA-INVRETOPA-INVRETOQA-INVRETORA
                                                                  -INVRETOEA-INVRETOFA-INVRETPBRA-INVRETPFRA-INVRETPJRA)) * (1 - V_CNR) ;

INVRETPERA = min(NINVRETPER , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA
                                                                  -INVRETPYA-INVRETPXA-INVRETRGA-INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA
                                                                  -INVRETSHA-INVRETSEA-INVRETSJA-INVRETOIA-INVRETOJA-INVRETOKA-INVRETOPA-INVRETOQA-INVRETORA
                                                                  -INVRETOEA-INVRETOFA-INVRETPBRA-INVRETPFRA-INVRETPJRA-INVRETPARA)) * (1 - V_CNR) ;

INVRETPIRA = min(NINVRETPIR , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA
                                                                  -INVRETPYA-INVRETPXA-INVRETRGA-INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA
                                                                  -INVRETSHA-INVRETSEA-INVRETSJA-INVRETOIA-INVRETOJA-INVRETOKA-INVRETOPA-INVRETOQA-INVRETORA
                                                                  -INVRETOEA-INVRETOFA-INVRETPBRA-INVRETPFRA-INVRETPJRA-INVRETPARA-INVRETPERA)) * (1 - V_CNR) ;

INVRETPYRA = min(NINVRETPYR , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA
                                                                  -INVRETPYA-INVRETPXA-INVRETRGA-INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA
                                                                  -INVRETSHA-INVRETSEA-INVRETSJA-INVRETOIA-INVRETOJA-INVRETOKA-INVRETOPA-INVRETOQA-INVRETORA
                                                                  -INVRETOEA-INVRETOFA-INVRETPBRA-INVRETPFRA-INVRETPJRA-INVRETPARA-INVRETPERA-INVRETPIRA)) * (1 - V_CNR) ;

INVRETPXRA = min(NINVRETPXR , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA
                                                                  -INVRETPYA-INVRETPXA-INVRETRGA-INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA
                                                                  -INVRETSHA-INVRETSEA-INVRETSJA-INVRETOIA-INVRETOJA-INVRETOKA-INVRETOPA-INVRETOQA-INVRETORA
                                                                  -INVRETOEA-INVRETOFA-INVRETPBRA-INVRETPFRA-INVRETPJRA-INVRETPARA-INVRETPERA-INVRETPIRA-INVRETPYRA)) * (1 - V_CNR) ;

INVRETSBRA = min(NINVRETSBR , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA
                                                                  -INVRETPYA-INVRETPXA-INVRETRGA-INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA
                                                                  -INVRETSHA-INVRETSEA-INVRETSJA-INVRETOIA-INVRETOJA-INVRETOKA-INVRETOPA-INVRETOQA-INVRETORA
                                                                  -INVRETOEA-INVRETOFA-INVRETPBRA-INVRETPFRA-INVRETPJRA-INVRETPARA-INVRETPERA-INVRETPIRA-INVRETPYRA
                                                                  -INVRETPXRA)) * (1 - V_CNR) ;

INVRETSGRA = min(NINVRETSGR , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA
                                                                  -INVRETPYA-INVRETPXA-INVRETRGA-INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA
                                                                  -INVRETSHA-INVRETSEA-INVRETSJA-INVRETOIA-INVRETOJA-INVRETOKA-INVRETOPA-INVRETOQA-INVRETORA
                                                                  -INVRETOEA-INVRETOFA-INVRETPBRA-INVRETPFRA-INVRETPJRA-INVRETPARA-INVRETPERA-INVRETPIRA-INVRETPYRA
                                                                  -INVRETPXRA-INVRETSBRA)) * (1 - V_CNR) ;

INVRETSARA = min(NINVRETSAR , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA
                                                                  -INVRETPYA-INVRETPXA-INVRETRGA-INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA
                                                                  -INVRETSHA-INVRETSEA-INVRETSJA-INVRETOIA-INVRETOJA-INVRETOKA-INVRETOPA-INVRETOQA-INVRETORA
                                                                  -INVRETOEA-INVRETOFA-INVRETPBRA-INVRETPFRA-INVRETPJRA-INVRETPARA-INVRETPERA-INVRETPIRA-INVRETPYRA
                                                                  -INVRETPXRA-INVRETSBRA-INVRETSGRA)) * (1 - V_CNR) ;

INVRETSFRA = min(NINVRETSFR , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA
                                                                  -INVRETPYA-INVRETPXA-INVRETRGA-INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA
                                                                  -INVRETSHA-INVRETSEA-INVRETSJA-INVRETOIA-INVRETOJA-INVRETOKA-INVRETOPA-INVRETOQA-INVRETORA
                                                                  -INVRETOEA-INVRETOFA-INVRETPBRA-INVRETPFRA-INVRETPJRA-INVRETPARA-INVRETPERA-INVRETPIRA-INVRETPYRA
                                                                  -INVRETPXRA-INVRETSBRA-INVRETSGRA-INVRETSARA)) * (1 - V_CNR) ;

TOTALPLAFB = INVRETPBA + INVRETPFA + INVRETPJA + INVRETPAA + INVRETPEA + INVRETPIA + INVRETPDA + INVRETPHA + INVRETPLA + INVRETPYA + INVRETPXA + INVRETRGA 
             + INVRETRIA + INVRETSBA + INVRETSGA + INVRETSAA + INVRETSFA + INVRETSCA + INVRETSHA + INVRETSEA + INVRETSJA + INVRETOIA + INVRETOJA + INVRETOKA 
             + INVRETOPA + INVRETOQA + INVRETORA + INVRETOEA + INVRETOFA 
             + INVRETPBRA + INVRETPFRA + INVRETPJRA + INVRETPARA + INVRETPERA + INVRETPIRA + INVRETPYRA + INVRETPXRA + INVRETSBRA + INVRETSGRA + INVRETSARA 
             + INVRETSFRA ;
 
INDPLAF3 = positif(RNIDOM3 - TOTALPLAF3 - TOTALPLAFA - TOTALPLAFB) ;


INVRETRLA = min(arr(NINVRETRL*TX375/100) , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB)) * (1 - V_CNR) ; 

INVRETRQA = min(arr(NINVRETRQ*TX375/100) , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA)) * (1 - V_CNR) ;

INVRETRVA = min(arr(NINVRETRV*TX375/100) , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA)) * (1 - V_CNR) ;

INVRETNVA = min(arr(NINVRETNV*TX375/100) , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA)) * (1 - V_CNR) ;

INVRETRKA = min(arr(NINVRETRK*TX4737/100) , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA)) * (1 - V_CNR) ;

INVRETRPA = min(arr(NINVRETRP*TX4737/100) , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA)) * (1 - V_CNR) ;

INVRETRUA = min(arr(NINVRETRU*TX4737/100) , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA)) * (1 - V_CNR) ;

INVRETNUA = min(arr(NINVRETNU*TX4737/100) , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA
											  -INVRETRUA)) * (1 - V_CNR) ;

INVRETRMA = min(NINVRETRM , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA)) * (1 - V_CNR) ;

INVRETRRA = min(NINVRETRR , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									  -INVRETRMA)) * (1 - V_CNR) ;

INVRETRWA = min(NINVRETRW , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									  -INVRETRMA-INVRETRRA)) * (1 - V_CNR) ;

INVRETNWA = min(NINVRETNW , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									  -INVRETRMA-INVRETRRA-INVRETRWA)) * (1 - V_CNR) ;

INVRETROA = min(NINVRETRO , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									  -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA)) * (1 - V_CNR) ;

INVRETRTA = min(NINVRETRT , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									  -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA)) * (1 - V_CNR) ;

INVRETRYA = min(NINVRETRY , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									  -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA)) * (1 - V_CNR) ;

INVRETNYA = min(NINVRETNY , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									  -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA)) * (1 - V_CNR) ;

INVRETSLA = min(arr(NINVRETSL*TX375/100) , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									                 -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA)) * (1 - V_CNR) ;

INVRETSQA = min(arr(NINVRETSQ*TX375/100) , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									                 -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
                                                                                         -INVRETSLA)) * (1 - V_CNR) ;

INVRETSVA = min(arr(NINVRETSV*TX375/100) , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									                 -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
                                                                                         -INVRETSLA-INVRETSQA)) * (1 - V_CNR) ;

INVRETTAA = min(arr(NINVRETTA*TX375/100) , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									                 -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
                                                                                         -INVRETSLA-INVRETSQA-INVRETSVA)) * (1 - V_CNR) ;

INVRETSKA = min(arr(NINVRETSK*TX4737/100) , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									                  -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
                                                                                          -INVRETSLA-INVRETSQA-INVRETSVA-INVRETTAA)) * (1 - V_CNR) ;

INVRETSPA = min(arr(NINVRETSP*TX4737/100) , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									                  -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
                                                                                          -INVRETSLA-INVRETSQA-INVRETSVA-INVRETTAA-INVRETSKA)) * (1 - V_CNR) ;

INVRETSUA = min(arr(NINVRETSU*TX4737/100) , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									                  -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
                                                                                          -INVRETSLA-INVRETSQA-INVRETSVA-INVRETTAA-INVRETSKA-INVRETSPA)) * (1 - V_CNR) ;

INVRETSZA = min(arr(NINVRETSZ*TX4737/100) , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									                  -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
                                                                                          -INVRETSLA-INVRETSQA-INVRETSVA-INVRETTAA-INVRETSKA-INVRETSPA-INVRETSUA)) * (1 - V_CNR) ;

INVRETSMA = min(NINVRETSM , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									  -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
                                                                          -INVRETSLA-INVRETSQA-INVRETSVA-INVRETTAA-INVRETSKA-INVRETSPA-INVRETSUA-INVRETSZA)) * (1 - V_CNR) ;

INVRETSRA = min(NINVRETSR , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									  -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
                                                                          -INVRETSLA-INVRETSQA-INVRETSVA-INVRETTAA-INVRETSKA-INVRETSPA-INVRETSUA-INVRETSZA
                                                                          -INVRETSMA)) * (1 - V_CNR) ;

INVRETSWA = min(NINVRETSW , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									  -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
                                                                          -INVRETSLA-INVRETSQA-INVRETSVA-INVRETTAA-INVRETSKA-INVRETSPA-INVRETSUA-INVRETSZA
                                                                          -INVRETSMA-INVRETSRA)) * (1 - V_CNR) ;

INVRETTBA = min(NINVRETTB , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									  -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
                                                                          -INVRETSLA-INVRETSQA-INVRETSVA-INVRETTAA-INVRETSKA-INVRETSPA-INVRETSUA-INVRETSZA
                                                                          -INVRETSMA-INVRETSRA-INVRETSWA)) * (1 - V_CNR) ;

INVRETSOA = min(NINVRETSO , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									  -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
                                                                          -INVRETSLA-INVRETSQA-INVRETSVA-INVRETTAA-INVRETSKA-INVRETSPA-INVRETSUA-INVRETSZA
                                                                          -INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA)) * (1 - V_CNR) ;

INVRETSTA = min(NINVRETST , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									  -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
                                                                          -INVRETSLA-INVRETSQA-INVRETSVA-INVRETTAA-INVRETSKA-INVRETSPA-INVRETSUA-INVRETSZA
                                                                          -INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA)) * (1 - V_CNR) ;

INVRETSYA = min(NINVRETSY , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									  -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
                                                                          -INVRETSLA-INVRETSQA-INVRETSVA-INVRETTAA-INVRETSKA-INVRETSPA-INVRETSUA-INVRETSZA
                                                                          -INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA-INVRETSTA)) * (1 - V_CNR) ;

INVRETTDA = min(NINVRETTD , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									  -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
                                                                          -INVRETSLA-INVRETSQA-INVRETSVA-INVRETTAA-INVRETSKA-INVRETSPA-INVRETSUA-INVRETSZA
                                                                          -INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA-INVRETSTA-INVRETSYA)) * (1 - V_CNR) ;

INVRETOTA = min(NINVRETOT , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									  -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
                                                                          -INVRETSLA-INVRETSQA-INVRETSVA-INVRETTAA-INVRETSKA-INVRETSPA-INVRETSUA-INVRETSZA
                                                                          -INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA-INVRETSTA-INVRETSYA-INVRETTDA)) * (1 - V_CNR) ;

INVRETOUA = min(NINVRETOU , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									  -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
                                                                          -INVRETSLA-INVRETSQA-INVRETSVA-INVRETTAA-INVRETSKA-INVRETSPA-INVRETSUA-INVRETSZA
                                                                          -INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA-INVRETSTA-INVRETSYA-INVRETTDA
									  -INVRETOTA)) * (1 - V_CNR) ;

INVRETOVA = min(NINVRETOV , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									  -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
									  -INVRETSLA-INVRETSQA-INVRETSVA-INVRETTAA-INVRETSKA-INVRETSPA-INVRETSUA-INVRETSZA
                                                                          -INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA-INVRETSTA-INVRETSYA-INVRETTDA
                                                                          -INVRETOTA-INVRETOUA)) * (1 - V_CNR) ;

INVRETOWA = min(NINVRETOW , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									  -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
									  -INVRETSLA-INVRETSQA-INVRETSVA-INVRETTAA-INVRETSKA-INVRETSPA-INVRETSUA-INVRETSZA
                                                                          -INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA-INVRETSTA-INVRETSYA-INVRETTDA
                                                                          -INVRETOTA-INVRETOUA-INVRETOVA)) * (1 - V_CNR) ;

INVRETOGA = min(NINVRETOG , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									  -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
									  -INVRETSLA-INVRETSQA-INVRETSVA-INVRETTAA-INVRETSKA-INVRETSPA-INVRETSUA-INVRETSZA
                                                                          -INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA-INVRETSTA-INVRETSYA-INVRETTDA
                                                                          -INVRETOTA-INVRETOUA-INVRETOVA-INVRETOWA)) * (1 - V_CNR) ;

INVRETOXA = min(NINVRETOX , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									  -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
									  -INVRETSLA-INVRETSQA-INVRETSVA-INVRETTAA-INVRETSKA-INVRETSPA-INVRETSUA-INVRETSZA
                                                                          -INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA-INVRETSTA-INVRETSYA-INVRETTDA
                                                                          -INVRETOTA-INVRETOUA-INVRETOVA-INVRETOWA-INVRETOGA)) * (1 - V_CNR) ;

INVRETOYA = min(NINVRETOY , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									  -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
									  -INVRETSLA-INVRETSQA-INVRETSVA-INVRETTAA-INVRETSKA-INVRETSPA-INVRETSUA-INVRETSZA
                                                                          -INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA-INVRETSTA-INVRETSYA-INVRETTDA
                                                                          -INVRETOTA-INVRETOUA-INVRETOVA-INVRETOWA-INVRETOGA-INVRETOXA)) * (1 - V_CNR) ;

INVRETOZA = min(NINVRETOZ , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									  -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
									  -INVRETSLA-INVRETSQA-INVRETSVA-INVRETTAA-INVRETSKA-INVRETSPA-INVRETSUA-INVRETSZA
                                                                          -INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA-INVRETSTA-INVRETSYA-INVRETTDA
                                                                          -INVRETOTA-INVRETOUA-INVRETOVA-INVRETOWA-INVRETOGA-INVRETOXA-INVRETOYA)) * (1 - V_CNR) ;

INVRETRLRA = min(NINVRETRLR , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									    -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
									    -INVRETSLA-INVRETSQA-INVRETSVA-INVRETTAA-INVRETSKA-INVRETSPA-INVRETSUA-INVRETSZA
                                                                            -INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA-INVRETSTA-INVRETSYA-INVRETTDA
                                                                            -INVRETOTA-INVRETOUA-INVRETOVA-INVRETOWA-INVRETOGA-INVRETOXA-INVRETOYA-INVRETOZA)) * (1 - V_CNR) ;

INVRETRQRA = min(NINVRETRQR , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									    -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
									    -INVRETSLA-INVRETSQA-INVRETSVA-INVRETTAA-INVRETSKA-INVRETSPA-INVRETSUA-INVRETSZA
                                                                            -INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA-INVRETSTA-INVRETSYA-INVRETTDA
                                                                            -INVRETOTA-INVRETOUA-INVRETOVA-INVRETOWA-INVRETOGA-INVRETOXA-INVRETOYA-INVRETOZA
                                                                            -INVRETRLRA)) * (1 - V_CNR) ;

INVRETRVRA = min(NINVRETRVR , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									    -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
									    -INVRETSLA-INVRETSQA-INVRETSVA-INVRETTAA-INVRETSKA-INVRETSPA-INVRETSUA-INVRETSZA
                                                                            -INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA-INVRETSTA-INVRETSYA-INVRETTDA
                                                                            -INVRETOTA-INVRETOUA-INVRETOVA-INVRETOWA-INVRETOGA-INVRETOXA-INVRETOYA-INVRETOZA
                                                                            -INVRETRLRA-INVRETRQRA)) * (1 - V_CNR) ;

INVRETNVRA = min(NINVRETNVR , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									    -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
									    -INVRETSLA-INVRETSQA-INVRETSVA-INVRETTAA-INVRETSKA-INVRETSPA-INVRETSUA-INVRETSZA
                                                                            -INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA-INVRETSTA-INVRETSYA-INVRETTDA
                                                                            -INVRETOTA-INVRETOUA-INVRETOVA-INVRETOWA-INVRETOGA-INVRETOXA-INVRETOYA-INVRETOZA
                                                                            -INVRETRLRA-INVRETRQRA-INVRETRVRA)) * (1 - V_CNR) ;

INVRETRKRA = min(NINVRETRKR , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									    -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
									    -INVRETSLA-INVRETSQA-INVRETSVA-INVRETTAA-INVRETSKA-INVRETSPA-INVRETSUA-INVRETSZA
                                                                            -INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA-INVRETSTA-INVRETSYA-INVRETTDA
                                                                            -INVRETOTA-INVRETOUA-INVRETOVA-INVRETOWA-INVRETOGA-INVRETOXA-INVRETOYA-INVRETOZA
                                                                            -INVRETRLRA-INVRETRQRA-INVRETRVRA-INVRETNVRA)) * (1 - V_CNR) ;

INVRETRPRA = min(NINVRETRPR , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									    -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
									    -INVRETSLA-INVRETSQA-INVRETSVA-INVRETTAA-INVRETSKA-INVRETSPA-INVRETSUA-INVRETSZA
                                                                            -INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA-INVRETSTA-INVRETSYA-INVRETTDA
                                                                            -INVRETOTA-INVRETOUA-INVRETOVA-INVRETOWA-INVRETOGA-INVRETOXA-INVRETOYA-INVRETOZA
                                                                            -INVRETRLRA-INVRETRQRA-INVRETRVRA-INVRETNVRA-INVRETRKRA)) * (1 - V_CNR) ;

INVRETRURA = min(NINVRETRUR , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									    -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
									    -INVRETSLA-INVRETSQA-INVRETSVA-INVRETTAA-INVRETSKA-INVRETSPA-INVRETSUA-INVRETSZA
                                                                            -INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA-INVRETSTA-INVRETSYA-INVRETTDA
                                                                            -INVRETOTA-INVRETOUA-INVRETOVA-INVRETOWA-INVRETOGA-INVRETOXA-INVRETOYA-INVRETOZA
                                                                            -INVRETRLRA-INVRETRQRA-INVRETRVRA-INVRETNVRA-INVRETRKRA-INVRETRPRA)) * (1 - V_CNR) ;

INVRETNURA = min(NINVRETNUR , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									    -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
									    -INVRETSLA-INVRETSQA-INVRETSVA-INVRETTAA-INVRETSKA-INVRETSPA-INVRETSUA-INVRETSZA
                                                                            -INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA-INVRETSTA-INVRETSYA-INVRETTDA
                                                                            -INVRETOTA-INVRETOUA-INVRETOVA-INVRETOWA-INVRETOGA-INVRETOXA-INVRETOYA-INVRETOZA
                                                                            -INVRETRLRA-INVRETRQRA-INVRETRVRA-INVRETNVRA-INVRETRKRA-INVRETRPRA-INVRETRURA)) * (1 - V_CNR) ;

INVRETSLRA = min(NINVRETSLR , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									    -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
									    -INVRETSLA-INVRETSQA-INVRETSVA-INVRETTAA-INVRETSKA-INVRETSPA-INVRETSUA-INVRETSZA
                                                                            -INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA-INVRETSTA-INVRETSYA-INVRETTDA
                                                                            -INVRETOTA-INVRETOUA-INVRETOVA-INVRETOWA-INVRETOGA-INVRETOXA-INVRETOYA-INVRETOZA
                                                                            -INVRETRLRA-INVRETRQRA-INVRETRVRA-INVRETNVRA-INVRETRKRA-INVRETRPRA-INVRETRURA
                                                                            -INVRETNURA)) * (1 - V_CNR) ;

INVRETSQRA = min(NINVRETSQR , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									    -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
									    -INVRETSLA-INVRETSQA-INVRETSVA-INVRETTAA-INVRETSKA-INVRETSPA-INVRETSUA-INVRETSZA
                                                                            -INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA-INVRETSTA-INVRETSYA-INVRETTDA
                                                                            -INVRETOTA-INVRETOUA-INVRETOVA-INVRETOWA-INVRETOGA-INVRETOXA-INVRETOYA-INVRETOZA
                                                                            -INVRETRLRA-INVRETRQRA-INVRETRVRA-INVRETNVRA-INVRETRKRA-INVRETRPRA-INVRETRURA
                                                                            -INVRETNURA-INVRETSLRA)) * (1 - V_CNR) ;

INVRETSVRA = min(NINVRETSVR , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									    -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
									    -INVRETSLA-INVRETSQA-INVRETSVA-INVRETTAA-INVRETSKA-INVRETSPA-INVRETSUA-INVRETSZA
                                                                            -INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA-INVRETSTA-INVRETSYA-INVRETTDA
                                                                            -INVRETOTA-INVRETOUA-INVRETOVA-INVRETOWA-INVRETOGA-INVRETOXA-INVRETOYA-INVRETOZA
                                                                            -INVRETRLRA-INVRETRQRA-INVRETRVRA-INVRETNVRA-INVRETRKRA-INVRETRPRA-INVRETRURA
                                                                            -INVRETNURA-INVRETSLRA-INVRETSQRA)) * (1 - V_CNR) ;

INVRETTARA = min(NINVRETTAR , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									    -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
									    -INVRETSLA-INVRETSQA-INVRETSVA-INVRETTAA-INVRETSKA-INVRETSPA-INVRETSUA-INVRETSZA
                                                                            -INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA-INVRETSTA-INVRETSYA-INVRETTDA
                                                                            -INVRETOTA-INVRETOUA-INVRETOVA-INVRETOWA-INVRETOGA-INVRETOXA-INVRETOYA-INVRETOZA
                                                                            -INVRETRLRA-INVRETRQRA-INVRETRVRA-INVRETNVRA-INVRETRKRA-INVRETRPRA-INVRETRURA
                                                                            -INVRETNURA-INVRETSLRA-INVRETSQRA-INVRETSVRA)) * (1 - V_CNR) ;

INVRETSKRA = min(NINVRETSKR , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									    -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
									    -INVRETSLA-INVRETSQA-INVRETSVA-INVRETTAA-INVRETSKA-INVRETSPA-INVRETSUA-INVRETSZA
                                                                            -INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA-INVRETSTA-INVRETSYA-INVRETTDA
                                                                            -INVRETOTA-INVRETOUA-INVRETOVA-INVRETOWA-INVRETOGA-INVRETOXA-INVRETOYA-INVRETOZA
                                                                            -INVRETRLRA-INVRETRQRA-INVRETRVRA-INVRETNVRA-INVRETRKRA-INVRETRPRA-INVRETRURA
                                                                            -INVRETNURA-INVRETSLRA-INVRETSQRA-INVRETSVRA-INVRETTARA)) * (1 - V_CNR) ;

INVRETSPRA = min(NINVRETSPR , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									    -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
									    -INVRETSLA-INVRETSQA-INVRETSVA-INVRETTAA-INVRETSKA-INVRETSPA-INVRETSUA-INVRETSZA
                                                                            -INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA-INVRETSTA-INVRETSYA-INVRETTDA
                                                                            -INVRETOTA-INVRETOUA-INVRETOVA-INVRETOWA-INVRETOGA-INVRETOXA-INVRETOYA-INVRETOZA
                                                                            -INVRETRLRA-INVRETRQRA-INVRETRVRA-INVRETNVRA-INVRETRKRA-INVRETRPRA-INVRETRURA
                                                                            -INVRETNURA-INVRETSLRA-INVRETSQRA-INVRETSVRA-INVRETTARA-INVRETSKRA)) * (1 - V_CNR) ;

INVRETSURA = min(NINVRETSUR , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									    -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
									    -INVRETSLA-INVRETSQA-INVRETSVA-INVRETTAA-INVRETSKA-INVRETSPA-INVRETSUA-INVRETSZA
                                                                            -INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA-INVRETSTA-INVRETSYA-INVRETTDA
                                                                            -INVRETOTA-INVRETOUA-INVRETOVA-INVRETOWA-INVRETOGA-INVRETOXA-INVRETOYA-INVRETOZA
                                                                            -INVRETRLRA-INVRETRQRA-INVRETRVRA-INVRETNVRA-INVRETRKRA-INVRETRPRA-INVRETRURA
                                                                            -INVRETNURA-INVRETSLRA-INVRETSQRA-INVRETSVRA-INVRETTARA-INVRETSKRA-INVRETSPRA)) * (1 - V_CNR) ;

INVRETSZRA = min(NINVRETSZR , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									    -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
									    -INVRETSLA-INVRETSQA-INVRETSVA-INVRETTAA-INVRETSKA-INVRETSPA-INVRETSUA-INVRETSZA
                                                                            -INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA-INVRETSTA-INVRETSYA-INVRETTDA
                                                                            -INVRETOTA-INVRETOUA-INVRETOVA-INVRETOWA-INVRETOGA-INVRETOXA-INVRETOYA-INVRETOZA
                                                                            -INVRETRLRA-INVRETRQRA-INVRETRVRA-INVRETNVRA-INVRETRKRA-INVRETRPRA-INVRETRURA
                                                                            -INVRETNURA-INVRETSLRA-INVRETSQRA-INVRETSVRA-INVRETTARA-INVRETSKRA-INVRETSPRA
                                                                            -INVRETSURA)) * (1 - V_CNR) ;

TOTALPLAFC = INVRETRLA + INVRETRQA + INVRETRVA + INVRETNVA + INVRETRKA + INVRETRPA + INVRETRUA + INVRETNUA + INVRETRMA + INVRETRRA + INVRETRWA + INVRETNWA 
             + INVRETROA + INVRETRTA + INVRETRYA + INVRETNYA + INVRETSLA + INVRETSQA + INVRETSVA + INVRETTAA + INVRETSKA + INVRETSPA + INVRETSUA + INVRETSZA
             + INVRETSMA + INVRETSRA + INVRETSWA + INVRETTBA + INVRETSOA + INVRETSTA + INVRETSYA + INVRETTDA + INVRETOTA + INVRETOUA + INVRETOVA + INVRETOWA 
             + INVRETOGA + INVRETOXA + INVRETOYA + INVRETOZA
             + INVRETRLRA + INVRETRQRA + INVRETRVRA + INVRETNVRA + INVRETRKRA + INVRETRPRA + INVRETRURA + INVRETNURA + INVRETSLRA + INVRETSQRA + INVRETSVRA 
             + INVRETTARA + INVRETSKRA + INVRETSPRA + INVRETSURA + INVRETSZRA ;

INDPLAF = positif(TOTALPLAFA + TOTALPLAFB + TOTALPLAFC - TOTALPLAF1 - TOTALPLAF2 - TOTALPLAF3) * positif(INDPLAF1 + INDPLAF2 + INDPLAF3) * positif(OPTPLAF15) ;


ALOGDOM_1 = (INVLOG2008 + INVLGDEB2009 + INVLGDEB + INVOMLOGOA + INVOMLOGOH + INVOMLOGOL + INVOMLOGOO + INVOMLOGOS
                      + (INVRETQL + INVRETQM + INVRETQD + INVRETOB + INVRETOC + INVRETOM + INVRETON + INVRETOI + INVRETOJ + INVRETOK + INVRETOP 
			 + INVRETOQ + INVRETOR + INVRETOT + INVRETOU + INVRETOV + INVRETOW + INVRETOD + INVRETOE + INVRETOF + INVRETOG
                         + INVRETOX + INVRETOY + INVRETOZ) * (1 - INDPLAF)
		      + (INVRETQLA + INVRETQMA + INVRETQDA + INVRETOBA + INVRETOCA + INVRETOMA + INVRETONA + INVRETOIA + INVRETOJA + INVRETOKA 
			 + INVRETOPA + INVRETOQA + INVRETORA + INVRETOTA + INVRETOUA + INVRETOVA + INVRETOWA + INVRETODA + INVRETOEA + INVRETOFA + INVRETOGA
                         + INVRETOXA + INVRETOYA + INVRETOZA) * INDPLAF)
	     * (1 - V_CNR) ;

ALOGDOM = ALOGDOM_1 * (1 - ART1731BIS) 
          + min(ALOGDOM_1 , max( ALOGDOM_P , ALOGDOM1731 + 0)) * ART1731BIS ;

ALOGSOC_1 = ((INVRETRA + INVRETRB + INVRETRC + INVRETRD + INVRETRAR + INVRETRBR + INVRETRCR + INVRETRDR) * (1 - INDPLAF) 
	    + (INVRETRAA + INVRETRBA + INVRETRCA + INVRETRDA + INVRETRARA + INVRETRBRA + INVRETRCRA + INVRETRDRA) * INDPLAF) 
             * (1 - V_CNR) ;

ALOGSOC = ALOGSOC_1 * (1 - ART1731BIS) 
          + min(ALOGSOC_1 , max(ALOGSOC_P , ALOGSOC1731 + 0)) * ART1731BIS ;

ADOMSOC1_1 = ((INVRETKG + INVRETKH + INVRETKI + INVRETQN + INVRETQU + INVRETQK + INVRETQJ + INVRETQS + INVRETQW + INVRETQX 
               + INVRETKGR + INVRETKHR + INVRETKIR + INVRETQNR + INVRETQUR + INVRETQKR + INVRETQJR + INVRETQSR + INVRETQWR + INVRETQXR) * (1 - INDPLAF) 
	     + (INVRETKGA + INVRETKHA + INVRETKIA + INVRETQNA + INVRETQUA + INVRETQKA + INVRETQJA + INVRETQSA + INVRETQWA + INVRETQXA
                + INVRETKGRA + INVRETKHRA + INVRETKIRA + INVRETQNRA + INVRETQURA + INVRETQKRA + INVRETQJRA + INVRETQSRA + INVRETQWRA + INVRETQXRA) * INDPLAF) 
              * (1 - V_CNR) ;

ADOMSOC1 = ADOMSOC1_1 * (1 - ART1731BIS) 
           + min(ADOMSOC1_1 , max(ADOMSOC1_P , ADOMSOC11731 + 0)) * ART1731BIS ;

ALOCENT_1 = ((INVRETSB + INVRETSG + INVRETSA + INVRETSF + INVRETSC + INVRETSH + INVRETSE + INVRETSJ + INVRETSL + INVRETSQ + INVRETSV + INVRETTA + INVRETSK
              + INVRETSP + INVRETSU + INVRETSZ + INVRETSM + INVRETSR + INVRETSW + INVRETTB + INVRETSO + INVRETST + INVRETSY + INVRETTD
              + INVRETSBR + INVRETSGR + INVRETSAR + INVRETSFR + INVRETSLR + INVRETSQR + INVRETSVR + INVRETTAR + INVRETSKR + INVRETSPR + INVRETSUR + INVRETSZR) * (1 - INDPLAF)
            + (INVRETSBA + INVRETSGA + INVRETSAA + INVRETSFA + INVRETSCA + INVRETSHA + INVRETSEA + INVRETSJA + INVRETSLA + INVRETSQA + INVRETSVA + INVRETTAA + INVRETSKA
               + INVRETSPA + INVRETSUA + INVRETSZA + INVRETSMA + INVRETSRA + INVRETSWA + INVRETTBA + INVRETSOA + INVRETSTA + INVRETSYA + INVRETTDA
               + INVRETSBRA + INVRETSGRA + INVRETSARA + INVRETSFRA + INVRETSLRA + INVRETSQRA + INVRETSVRA + INVRETTARA + INVRETSKRA + INVRETSPRA + INVRETSURA + INVRETSZRA) * INDPLAF)
              * (1 - V_CNR) ;

ALOCENT = ALOCENT_1 * (1 - ART1731BIS) 
          + min(ALOCENT_1 , max(ALOCENT_P , ALOCENT1731 + 0)) * ART1731BIS ;

ACOLENT_1 = (INVOMREP + INVOMENTMN + INVENDEB2009 + INVOMQV + INVOMRETPM + INVOMENTRJ
		 + (INVRETMA + INVRETLG + INVRETMB + INVRETLH + INVRETMC + INVRETLI + INVRETQP + INVRETQG + INVRETPB + INVRETPF + INVRETPJ + INVRETQO + INVRETQF 
                    + INVRETPA + INVRETPE + INVRETPI + INVRETKS + INVRETKT + INVRETKU + INVRETQR + INVRETQI + INVRETPD + INVRETPH + INVRETPL + INVRETPO + INVRETPT 
                    + INVRETPY + INVRETRL + INVRETRQ + INVRETRV + INVRETNV + INVRETPN + INVRETPS + INVRETPX + INVRETRK + INVRETRP + INVRETRU + INVRETNU + INVRETPP 
                    + INVRETPU + INVRETRG + INVRETRM + INVRETRR + INVRETRW + INVRETNW + INVRETPR + INVRETPW + INVRETRI + INVRETRO + INVRETRT + INVRETRY + INVRETNY
                    + INVRETMAR + INVRETLGR + INVRETMBR + INVRETLHR + INVRETMCR + INVRETLIR + INVRETQPR + INVRETQGR + INVRETPBR + INVRETPFR + INVRETPJR + INVRETQOR 
                    + INVRETQFR + INVRETPAR + INVRETPER + INVRETPIR + INVRETPOR + INVRETPTR + INVRETPYR + INVRETRLR + INVRETRQR + INVRETRVR + INVRETNVR + INVRETPNR 
                    + INVRETPSR + INVRETPXR + INVRETRKR + INVRETRPR + INVRETRUR + INVRETNUR) * (1 - INDPLAF) 
		 + (INVRETMAA + INVRETLGA + INVRETMBA + INVRETLHA + INVRETMCA + INVRETLIA + INVRETQPA + INVRETQGA + INVRETPBA + INVRETPFA + INVRETPJA + INVRETQOA + INVRETQFA
                    + INVRETPAA + INVRETPEA + INVRETPIA + INVRETKSA + INVRETKTA + INVRETKUA + INVRETQRA + INVRETQIA + INVRETPDA + INVRETPHA + INVRETPLA + INVRETPOA + INVRETPTA
                    + INVRETPYA + INVRETRLA + INVRETRQA + INVRETRVA + INVRETNVA + INVRETPNA + INVRETPSA + INVRETPXA + INVRETRKA + INVRETRPA + INVRETRUA + INVRETNUA + INVRETPPA
                    + INVRETPUA + INVRETRGA + INVRETRMA + INVRETRRA + INVRETRWA + INVRETNWA + INVRETPRA + INVRETPWA + INVRETRIA + INVRETROA + INVRETRTA + INVRETRYA + INVRETNYA
                    + INVRETMARA + INVRETLGRA + INVRETMBRA + INVRETLHRA + INVRETMCRA + INVRETLIRA + INVRETQPRA + INVRETQGRA + INVRETPBRA + INVRETPFRA + INVRETPJRA + INVRETQORA
                    + INVRETQFRA + INVRETPARA + INVRETPERA + INVRETPIRA + INVRETPORA + INVRETPTRA + INVRETPYRA + INVRETRLRA + INVRETRQRA + INVRETRVRA + INVRETNVRA + INVRETPNRA
                    + INVRETPSRA + INVRETPXRA + INVRETRKRA + INVRETRPRA + INVRETRURA + INVRETNURA) * INDPLAF) 
	   * (1 - V_CNR) ;

ACOLENT = ACOLENT_1 * (1 - ART1731BIS) 
          + min(ACOLENT_1 , max(ACOLENT_P ,ACOLENT1731 + 0)) * ART1731BIS ;

regle 4083:
application : iliad, batch ;

NINVRETQB = (max(min(INVLOG2008 , RRI1) , 0) * (1 - V_CNR)) ;

NINVRETQC = (max(min(INVLGDEB2009 , RRI1-INVLOG2008) , 0) * (1 - V_CNR)) ;

NINVRETQT = (max(min(INVLGDEB , RRI1-INVLOG2008-INVLGDEB2009) , 0) * (1 - V_CNR)) ;

NINVRETOA = (max(min(INVOMLOGOA , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB) , 0) * (1 - V_CNR)) ;

NINVRETOH = (max(min(INVOMLOGOH , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB-INVOMLOGOA) , 0) * (1 - V_CNR)) ;

NINVRETOL = (max(min(INVOMLOGOL , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB-INVOMLOGOA-INVOMLOGOH) , 0) * (1 - V_CNR)) ;

NINVRETOO = (max(min(INVOMLOGOO , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB-INVOMLOGOA-INVOMLOGOH-INVOMLOGOL) , 0) * (1 - V_CNR)) ;

NINVRETOS = max(min(INVOMLOGOS , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB-INVOMLOGOA-INVOMLOGOH-INVOMLOGOL-INVOMLOGOO) , 0) * (1 - V_CNR) ;

NINVRETQL = max(min(INVLGAUTRE , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB-INVOMLOGOA-INVOMLOGOH-INVOMLOGOL-INVOMLOGOO-INVOMLOGOS) , 0) * (1 - V_CNR) ;

NINVRETQM = max(min(INVLGDEB2010 , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB-INVOMLOGOA-INVOMLOGOH-INVOMLOGOL-INVOMLOGOO-INVOMLOGOS-NINVRETQL) , 0) * (1 - V_CNR) ;

NINVRETQD = max(min(INVLOG2009 , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB-INVOMLOGOA-INVOMLOGOH-INVOMLOGOL-INVOMLOGOO-INVOMLOGOS-NINVRETQL-NINVRETQM) , 0) * (1 - V_CNR) ;

NINVRETOB = max(min(INVOMLOGOB , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB-INVOMLOGOA-INVOMLOGOH-INVOMLOGOL-INVOMLOGOO-INVOMLOGOS-NINVRETQL-NINVRETQM
				     -NINVRETQD) , 0) * (1 - V_CNR) ;

NINVRETOC = max(min(INVOMLOGOC , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB-INVOMLOGOA-INVOMLOGOH-INVOMLOGOL-INVOMLOGOO-INVOMLOGOS-NINVRETQL-NINVRETQM
				     -NINVRETQD-NINVRETOB) , 0) * (1 - V_CNR) ;

NINVRETOI = max(min(INVOMLOGOI , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB-INVOMLOGOA-INVOMLOGOH-INVOMLOGOL-INVOMLOGOO-INVOMLOGOS-NINVRETQL-NINVRETQM
				     -NINVRETQD-NINVRETOB-NINVRETOC) , 0) * (1 - V_CNR) ;

NINVRETOJ = max(min(INVOMLOGOJ , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB-INVOMLOGOA-INVOMLOGOH-INVOMLOGOL-INVOMLOGOO-INVOMLOGOS-NINVRETQL-NINVRETQM
				     -NINVRETQD-NINVRETOB-NINVRETOC-NINVRETOI) , 0) * (1 - V_CNR) ;

NINVRETOK = max(min(INVOMLOGOK , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB-INVOMLOGOA-INVOMLOGOH-INVOMLOGOL-INVOMLOGOO-INVOMLOGOS-NINVRETQL-NINVRETQM
				     -NINVRETQD-NINVRETOB-NINVRETOC-NINVRETOI-NINVRETOJ) , 0) * (1 - V_CNR) ;

NINVRETOM = max(min(INVOMLOGOM , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB-INVOMLOGOA-INVOMLOGOH-INVOMLOGOL-INVOMLOGOO-INVOMLOGOS-NINVRETQL-NINVRETQM
				     -NINVRETQD-NINVRETOB-NINVRETOC-NINVRETOI-NINVRETOJ-NINVRETOK) , 0) * (1 - V_CNR) ;

NINVRETON = max(min(INVOMLOGON , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB-INVOMLOGOA-INVOMLOGOH-INVOMLOGOL-INVOMLOGOO-INVOMLOGOS-NINVRETQL-NINVRETQM
				     -NINVRETQD-NINVRETOB-NINVRETOC-NINVRETOI-NINVRETOJ-NINVRETOK-NINVRETOM) , 0) * (1 - V_CNR) ;

NINVRETOP = max(min(INVOMLOGOP , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB-INVOMLOGOA-INVOMLOGOH-INVOMLOGOL-INVOMLOGOO-INVOMLOGOS-NINVRETQL-NINVRETQM
				     -NINVRETQD-NINVRETOB-NINVRETOC-NINVRETOI-NINVRETOJ-NINVRETOK-NINVRETOM-NINVRETON) , 0) * (1 - V_CNR) ;

NINVRETOQ = max(min(INVOMLOGOQ , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB-INVOMLOGOA-INVOMLOGOH-INVOMLOGOL-INVOMLOGOO-INVOMLOGOS-NINVRETQL-NINVRETQM
				     -NINVRETQD-NINVRETOB-NINVRETOC-NINVRETOI-NINVRETOJ-NINVRETOK-NINVRETOM-NINVRETON-NINVRETOP) , 0) * (1 - V_CNR) ;

NINVRETOR = max(min(INVOMLOGOR , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB-INVOMLOGOA-INVOMLOGOH-INVOMLOGOL-INVOMLOGOO-INVOMLOGOS-NINVRETQL-NINVRETQM
				     -NINVRETQD-NINVRETOB-NINVRETOC-NINVRETOI-NINVRETOJ-NINVRETOK-NINVRETOM-NINVRETON-NINVRETOP-NINVRETOQ) , 0) * (1 - V_CNR) ;

NINVRETOT = max(min(INVOMLOGOT , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB-INVOMLOGOA-INVOMLOGOH-INVOMLOGOL-INVOMLOGOO-INVOMLOGOS-NINVRETQL-NINVRETQM
				     -NINVRETQD-NINVRETOB-NINVRETOC-NINVRETOI-NINVRETOJ-NINVRETOK-NINVRETOM-NINVRETON-NINVRETOP-NINVRETOQ-NINVRETOR) , 0) * (1 - V_CNR) ;

NINVRETOU = max(min(INVOMLOGOU , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB-INVOMLOGOA-INVOMLOGOH-INVOMLOGOL-INVOMLOGOO-INVOMLOGOS-NINVRETQL-NINVRETQM
				     -NINVRETQD-NINVRETOB-NINVRETOC-NINVRETOI-NINVRETOJ-NINVRETOK-NINVRETOM-NINVRETON-NINVRETOP-NINVRETOQ-NINVRETOR
				     -NINVRETOT) , 0) * (1 - V_CNR) ;

NINVRETOV = max(min(INVOMLOGOV , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB-INVOMLOGOA-INVOMLOGOH-INVOMLOGOL-INVOMLOGOO-INVOMLOGOS-NINVRETQL-NINVRETQM
				     -NINVRETQD-NINVRETOB-NINVRETOC-NINVRETOI-NINVRETOJ-NINVRETOK-NINVRETOM-NINVRETON-NINVRETOP-NINVRETOQ-NINVRETOR
				     -NINVRETOT-NINVRETOU) , 0) * (1 - V_CNR) ;

NINVRETOW = max(min(INVOMLOGOW , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB-INVOMLOGOA-INVOMLOGOH-INVOMLOGOL-INVOMLOGOO-INVOMLOGOS-NINVRETQL-NINVRETQM
				     -NINVRETQD-NINVRETOB-NINVRETOC-NINVRETOI-NINVRETOJ-NINVRETOK-NINVRETOM-NINVRETON-NINVRETOP-NINVRETOQ-NINVRETOR
				     -NINVRETOT-NINVRETOU-NINVRETOV) , 0) * (1 - V_CNR) ;

NINVRETOD = max(min(CODHOD , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB-INVOMLOGOA-INVOMLOGOH-INVOMLOGOL-INVOMLOGOO-INVOMLOGOS-NINVRETQL-NINVRETQM
				 -NINVRETQD-NINVRETOB-NINVRETOC-NINVRETOI-NINVRETOJ-NINVRETOK-NINVRETOM-NINVRETON-NINVRETOP-NINVRETOQ-NINVRETOR
				 -NINVRETOT-NINVRETOU-NINVRETOV-NINVRETOW) , 0) * (1 - V_CNR) ;

NINVRETOE = max(min(CODHOE , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB-INVOMLOGOA-INVOMLOGOH-INVOMLOGOL-INVOMLOGOO-INVOMLOGOS-NINVRETQL-NINVRETQM
				 -NINVRETQD-NINVRETOB-NINVRETOC-NINVRETOI-NINVRETOJ-NINVRETOK-NINVRETOM-NINVRETON-NINVRETOP-NINVRETOQ-NINVRETOR
				 -NINVRETOT-NINVRETOU-NINVRETOV-NINVRETOW-NINVRETOD) , 0) * (1 - V_CNR) ;

NINVRETOF = max(min(CODHOF , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB-INVOMLOGOA-INVOMLOGOH-INVOMLOGOL-INVOMLOGOO-INVOMLOGOS-NINVRETQL-NINVRETQM
				 -NINVRETQD-NINVRETOB-NINVRETOC-NINVRETOI-NINVRETOJ-NINVRETOK-NINVRETOM-NINVRETON-NINVRETOP-NINVRETOQ-NINVRETOR
				 -NINVRETOT-NINVRETOU-NINVRETOV-NINVRETOW-NINVRETOD-NINVRETOE) , 0) * (1 - V_CNR) ;

NINVRETOG = max(min(CODHOG , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB-INVOMLOGOA-INVOMLOGOH-INVOMLOGOL-INVOMLOGOO-INVOMLOGOS-NINVRETQL-NINVRETQM
				 -NINVRETQD-NINVRETOB-NINVRETOC-NINVRETOI-NINVRETOJ-NINVRETOK-NINVRETOM-NINVRETON-NINVRETOP-NINVRETOQ-NINVRETOR
				 -NINVRETOT-NINVRETOU-NINVRETOV-NINVRETOW-NINVRETOD-NINVRETOE-NINVRETOF) , 0) * (1 - V_CNR) ;

NINVRETOX = max(min(CODHOX , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB-INVOMLOGOA-INVOMLOGOH-INVOMLOGOL-INVOMLOGOO-INVOMLOGOS-NINVRETQL-NINVRETQM
				 -NINVRETQD-NINVRETOB-NINVRETOC-NINVRETOI-NINVRETOJ-NINVRETOK-NINVRETOM-NINVRETON-NINVRETOP-NINVRETOQ-NINVRETOR
				 -NINVRETOT-NINVRETOU-NINVRETOV-NINVRETOW-NINVRETOD-NINVRETOE-NINVRETOF-NINVRETOG) , 0) * (1 - V_CNR) ;

NINVRETOY = max(min(CODHOY , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB-INVOMLOGOA-INVOMLOGOH-INVOMLOGOL-INVOMLOGOO-INVOMLOGOS-NINVRETQL-NINVRETQM
				 -NINVRETQD-NINVRETOB-NINVRETOC-NINVRETOI-NINVRETOJ-NINVRETOK-NINVRETOM-NINVRETON-NINVRETOP-NINVRETOQ-NINVRETOR
				 -NINVRETOT-NINVRETOU-NINVRETOV-NINVRETOW-NINVRETOD-NINVRETOE-NINVRETOF-NINVRETOG-NINVRETOX) , 0) * (1 - V_CNR) ;

NINVRETOZ = max(min(CODHOZ , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB-INVOMLOGOA-INVOMLOGOH-INVOMLOGOL-INVOMLOGOO-INVOMLOGOS-NINVRETQL-NINVRETQM
				 -NINVRETQD-NINVRETOB-NINVRETOC-NINVRETOI-NINVRETOJ-NINVRETOK-NINVRETOM-NINVRETON-NINVRETOP-NINVRETOQ-NINVRETOR
				 -NINVRETOT-NINVRETOU-NINVRETOV-NINVRETOW-NINVRETOD-NINVRETOE-NINVRETOF-NINVRETOG-NINVRETOX-NINVRETOY) , 0) * (1 - V_CNR) ;

NRLOGDOM = (INVLOG2008 + INVLGDEB2009 + INVLGDEB + INVOMLOGOA + INVOMLOGOH + INVOMLOGOL + INVOMLOGOO + INVOMLOGOS
	    + NINVRETQL + NINVRETQM + NINVRETQD + NINVRETOB + NINVRETOC + NINVRETOI + NINVRETOJ + NINVRETOK
	    + NINVRETOM + NINVRETON + NINVRETOP + NINVRETOQ + NINVRETOR + NINVRETOT + NINVRETOU + NINVRETOV 
            + NINVRETOW + NINVRETOD + NINVRETOE + NINVRETOF + NINVRETOG + NINVRETOX + NINVRETOY + NINVRETOZ) 
	    * (1 - V_CNR) ;

regle 14084:
application : iliad, batch ;

NINVRETKG = max(min(INVSOCNRET , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT3-NRPATNAT2-NRPATNAT1-NRPATNAT) , 0) * (1 - V_CNR) ;

NINVRETKH = max(min(INVOMSOCKH , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT3-NRPATNAT2-NRPATNAT1-NRPATNAT-NINVRETKG) , 0) * (1 - V_CNR) ;

NINVRETKI = max(min(INVOMSOCKI , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT3-NRPATNAT2-NRPATNAT1-NRPATNAT-NINVRETKG-NINVRETKH) , 0) * (1 - V_CNR) ;

NINVRETQN = max(min(INVSOC2010 , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT3-NRPATNAT2-NRPATNAT1-NRPATNAT-NINVRETKG-NINVRETKH-NINVRETKI) , 0) * (1 - V_CNR) ;

NINVRETQU = max(min(INVOMSOCQU , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT3-NRPATNAT2-NRPATNAT1-NRPATNAT-NINVRETKG-NINVRETKH-NINVRETKI-NINVRETQN) , 0) * (1 - V_CNR) ;

NINVRETQK = max(min(INVLOGSOC , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT3-NRPATNAT2-NRPATNAT1-NRPATNAT-NINVRETKG-NINVRETKH-NINVRETKI-NINVRETQN-NINVRETQU) , 0) * (1 - V_CNR) ;

NINVRETQJ = max(min(INVOMSOCQJ , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT3-NRPATNAT2-NRPATNAT1-NRPATNAT-NINVRETKG-NINVRETKH-NINVRETKI-NINVRETQN-NINVRETQU
				     -NINVRETQK) , 0) * (1 - V_CNR) ;

NINVRETQS = max(min(INVOMSOCQS , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT3-NRPATNAT2-NRPATNAT1-NRPATNAT-NINVRETKG-NINVRETKH-NINVRETKI-NINVRETQN-NINVRETQU
				     -NINVRETQK-NINVRETQJ) , 0) * (1 - V_CNR) ;

NINVRETQW = max(min(INVOMSOCQW , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT3-NRPATNAT2-NRPATNAT1-NRPATNAT-NINVRETKG-NINVRETKH-NINVRETKI-NINVRETQN-NINVRETQU
				     -NINVRETQK-NINVRETQJ-NINVRETQS) , 0) * (1 - V_CNR) ;

NINVRETQX = max(min(INVOMSOCQX , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT3-NRPATNAT2-NRPATNAT1-NRPATNAT-NINVRETKG-NINVRETKH-NINVRETKI-NINVRETQN-NINVRETQU
				     -NINVRETQK-NINVRETQJ-NINVRETQS-NINVRETQW) , 0) * (1 - V_CNR) ;

NINVRETRA = max(min(CODHRA , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT3-NRPATNAT2-NRPATNAT1-NRPATNAT-NINVRETKG-NINVRETKH-NINVRETKI-NINVRETQN-NINVRETQU
				 -NINVRETQK-NINVRETQJ-NINVRETQS-NINVRETQW-NINVRETQX) , 0) * (1 - V_CNR) ;

NINVRETRB = max(min(CODHRB , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT3-NRPATNAT2-NRPATNAT1-NRPATNAT-NINVRETKG-NINVRETKH-NINVRETKI-NINVRETQN-NINVRETQU
				 -NINVRETQK-NINVRETQJ-NINVRETQS-NINVRETQW-NINVRETQX-NINVRETRA) , 0) * (1 - V_CNR) ;

NINVRETRC = max(min(CODHRC , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT3-NRPATNAT2-NRPATNAT1-NRPATNAT-NINVRETKG-NINVRETKH-NINVRETKI-NINVRETQN-NINVRETQU
				 -NINVRETQK-NINVRETQJ-NINVRETQS-NINVRETQW-NINVRETQX-NINVRETRA-NINVRETRB) , 0) * (1 - V_CNR) ;

NINVRETRD = max(min(CODHRD , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT3-NRPATNAT2-NRPATNAT1-NRPATNAT-NINVRETKG-NINVRETKH-NINVRETKI-NINVRETQN-NINVRETQU
				 -NINVRETQK-NINVRETQJ-NINVRETQS-NINVRETQW-NINVRETQX-NINVRETRA-NINVRETRB-NINVRETRC) , 0) * (1 - V_CNR) ;

NINVRETKGR = (NINVRETKG - arr(NINVRETKG * TX35 / 100)) * (1 - V_CNR) ;

NINVRETKHR = (NINVRETKH - arr(NINVRETKH * TX35 / 100)) * (1 - V_CNR) ;

NINVRETKIR = (NINVRETKI - arr(NINVRETKI * TX35 / 100)) * (1 - V_CNR) ;

NINVRETQNR = (NINVRETQN - arr(NINVRETQN * TX35 / 100)) * (1 - V_CNR) ;

NINVRETQUR = (NINVRETQU - arr(NINVRETQU * TX35 / 100)) * (1 - V_CNR) ;

NINVRETQKR = (NINVRETQK - arr(NINVRETQK * TX35 / 100)) * (1 - V_CNR) ;

NINVRETQJR = (NINVRETQJ - arr(NINVRETQJ * TX35 / 100)) * (1 - V_CNR) ;

NINVRETQSR = (NINVRETQS - arr(NINVRETQS * TX35 / 100)) * (1 - V_CNR) ;

NINVRETQWR = (NINVRETQW - arr(NINVRETQW * TX35 / 100)) * (1 - V_CNR) ;

NINVRETQXR = (NINVRETQX - arr(NINVRETQX * TX35 / 100)) * (1 - V_CNR) ;

NINVRETRAR = (NINVRETRA - arr(NINVRETRA * TX35 / 100)) * (1 - V_CNR) ;

NINVRETRBR = (NINVRETRB - arr(NINVRETRB * TX35 / 100)) * (1 - V_CNR) ;

NINVRETRCR = (NINVRETRC - arr(NINVRETRC * TX35 / 100)) * (1 - V_CNR) ;

NINVRETRDR = (NINVRETRD - arr(NINVRETRD * TX35 / 100)) * (1 - V_CNR) ;

NRDOMSOC1 = NINVRETKG + NINVRETKH + NINVRETKI + NINVRETQN + NINVRETQU + NINVRETQK + NINVRETQJ + NINVRETQS + NINVRETQW + NINVRETQX ;

NRLOGSOC = NINVRETRA + NINVRETRB + NINVRETRC + NINVRETRD ;

regle 4084:
application : iliad, batch ;

INVRETKG = min(arr(NINVRETKG * TX35 / 100) , PLAF_INVDOM) * (1 - V_CNR) ;

INVRETKH = min(arr(NINVRETKH * TX35 / 100) , max(0 , PLAF_INVDOM -INVRETKG)) * (1 - V_CNR) ; 

INVRETKI = min(arr(NINVRETKI * TX35 / 100) , max(0 , PLAF_INVDOM -INVRETKG-INVRETKH)) * (1 - V_CNR) ; 

INVRETQN = min(arr(NINVRETQN * TX35 / 100) , max(0 , PLAF_INVDOM -INVRETKG-INVRETKH-INVRETKI)) * (1 - V_CNR) ; 

INVRETQU = min(arr(NINVRETQU * TX35 / 100) , max(0 , PLAF_INVDOM -INVRETKG-INVRETKH-INVRETKI-INVRETQN)) * (1 - V_CNR) ; 

INVRETQK = min(arr(NINVRETQK * TX35 / 100) , max(0 , PLAF_INVDOM -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU)) * (1 - V_CNR) ;

INVRETQJ = min(arr(NINVRETQJ * TX35 / 100) , max(0 , PLAF_INVDOM -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK)) * (1 - V_CNR) ;

INVRETQS = min(arr(NINVRETQS * TX35 / 100) , max(0 , PLAF_INVDOM -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ)) * (1 - V_CNR) ;

INVRETQW = min(arr(NINVRETQW * TX35 / 100) , max(0 , PLAF_INVDOM -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS)) * (1 - V_CNR) ;

INVRETQX = min(arr(NINVRETQX * TX35 / 100) , max(0 , PLAF_INVDOM -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW)) * (1 - V_CNR) ;

INVRETRA = min(arr(NINVRETRA * TX35 / 100) , max(0 , PLAF_INVDOM -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW
                                                                 -INVRETQX)) * (1 - V_CNR) ;

INVRETRB = min(arr(NINVRETRB * TX35 / 100) , max(0 , PLAF_INVDOM -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW
                                                                 -INVRETQX-INVRETRA)) * (1 - V_CNR) ;

INVRETRC = min(arr(NINVRETRC * TX35 / 100) , max(0 , PLAF_INVDOM -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW
                                                                 -INVRETQX-INVRETRA-INVRETRB)) * (1 - V_CNR) ;

INVRETRD = min(arr(NINVRETRD * TX35 / 100) , max(0 , PLAF_INVDOM -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW
                                                                 -INVRETQX-INVRETRA-INVRETRB-INVRETRC)) * (1 - V_CNR) ;

INVRETSOC = INVRETKG + INVRETKH + INVRETKI + INVRETQN + INVRETQU + INVRETQK + INVRETQJ + INVRETQS + INVRETQW + INVRETQX + INVRETRA + INVRETRB + INVRETRC + INVRETRD ;


INVRETKGR = min(max(min(arr(INVRETKG * 13 / 7) , max(0 , NINVRETKG - INVRETKG)) , max(0 , NINVRETKG - INVRETKG)) , PLAF_INVDOM1)
                * (1 - V_CNR) ;

INVRETKHR = min(max(min(arr(INVRETKH * 13 / 7) , max(0 , NINVRETKH - INVRETKH)) , max(0 , NINVRETKH - INVRETKH)) , 
		max(0 , PLAF_INVDOM1 -INVRETKGR)) * (1 - V_CNR) ;

INVRETKIR = min(max(min(arr(INVRETKI * 13 / 7) , max(0 , NINVRETKI - INVRETKI)) , max(0 , NINVRETKI - INVRETKI)) , 
		max(0 , PLAF_INVDOM1 -INVRETKGR-INVRETKHR)) * (1 - V_CNR) ;

INVRETQNR = min(max(min(arr(INVRETQN * 13 / 7) , max(0 , NINVRETQN - INVRETQN)) , max(0 , NINVRETQN - INVRETQN)) , 
		max(0 , PLAF_INVDOM1 -INVRETKGR-INVRETKHR-INVRETKIR)) * (1 - V_CNR) ;

INVRETQUR = min(max(min(arr(INVRETQU * 13 / 7) , max(0 , NINVRETQU - INVRETQU)) , max(0 , NINVRETQU - INVRETQU)) , 
                max(0 , PLAF_INVDOM1 -INVRETKGR-INVRETKHR-INVRETKIR-INVRETQNR)) * (1 - V_CNR) ;

INVRETQKR = min(max(min(arr(INVRETQK * 13 / 7) , max(0 , NINVRETQK - INVRETQK)) , max(0 , NINVRETQK - INVRETQK)) , 
		max(0 , PLAF_INVDOM1 -INVRETKGR-INVRETKHR-INVRETKIR-INVRETQNR-INVRETQUR)) * (1 - V_CNR) ;

INVRETQJR = min(max(min(arr(INVRETQJ * 13 / 7) , max(0 , NINVRETQJ - INVRETQJ)) , max(0 , NINVRETQJ - INVRETQJ)) , 
		max(0 , PLAF_INVDOM1 -INVRETKGR-INVRETKHR-INVRETKIR-INVRETQNR-INVRETQUR-INVRETQKR)) * (1 - V_CNR) ;

INVRETQSR = min(max(min(arr(INVRETQS * 13 / 7) , max(0 , NINVRETQS - INVRETQS)) , max(0 , NINVRETQS - INVRETQS)) , 
		max(0 , PLAF_INVDOM1 -INVRETKGR-INVRETKHR-INVRETKIR-INVRETQNR-INVRETQUR-INVRETQKR-INVRETQJR)) * (1 - V_CNR) ;

INVRETQWR = min(max(min(arr(INVRETQW * 13 / 7) , max(0 , NINVRETQW - INVRETQW)) , max(0 , NINVRETQW - INVRETQW)) , 
		max(0 , PLAF_INVDOM1 -INVRETKGR-INVRETKHR-INVRETKIR-INVRETQNR-INVRETQUR-INVRETQKR-INVRETQJR-INVRETQSR)) * (1 - V_CNR) ;

INVRETQXR = min(max(min(arr(INVRETQX * 13 / 7) , max(0 , NINVRETQX - INVRETQX)) , max(0 , NINVRETQX - INVRETQX)) , 
		max(0 , PLAF_INVDOM1 -INVRETKGR-INVRETKHR-INVRETKIR-INVRETQNR-INVRETQUR-INVRETQKR-INVRETQJR-INVRETQSR-INVRETQWR)) * (1 - V_CNR) ;

INVRETRAR = min(max(min(arr(INVRETRA * 13 / 7) , max(0 , NINVRETRA - INVRETRA)) , max(0 , NINVRETRA - INVRETRA)) , 
		max(0 , PLAF_INVDOM1 -INVRETKGR-INVRETKHR-INVRETKIR-INVRETQNR-INVRETQUR-INVRETQKR-INVRETQJR-INVRETQSR-INVRETQWR-INVRETQXR)) * (1 - V_CNR) ;

INVRETRBR = min(max(min(arr(INVRETRB * 13 / 7) , max(0 , NINVRETRB - INVRETRB)) , max(0 , NINVRETRB - INVRETRB)) , 
		max(0 , PLAF_INVDOM1 -INVRETKGR-INVRETKHR-INVRETKIR-INVRETQNR-INVRETQUR-INVRETQKR-INVRETQJR-INVRETQSR-INVRETQWR-INVRETQXR
                                     -INVRETRAR)) * (1 - V_CNR) ;

INVRETRCR = min(max(min(arr(INVRETRC * 13 / 7) , max(0 , NINVRETRC - INVRETRC)) , max(0 , NINVRETRC - INVRETRC)) , 
		max(0 , PLAF_INVDOM1 -INVRETKGR-INVRETKHR-INVRETKIR-INVRETQNR-INVRETQUR-INVRETQKR-INVRETQJR-INVRETQSR-INVRETQWR-INVRETQXR
                                     -INVRETRAR-INVRETRBR)) * (1 - V_CNR) ;

INVRETRDR = min(max(min(arr(INVRETRD * 13 / 7) , max(0 , NINVRETRD - INVRETRD)) , max(0 , NINVRETRD - INVRETRD)) , 
		max(0 , PLAF_INVDOM1 -INVRETKGR-INVRETKHR-INVRETKIR-INVRETQNR-INVRETQUR-INVRETQKR-INVRETQJR-INVRETQSR-INVRETQWR-INVRETQXR
                                     -INVRETRAR-INVRETRBR-INVRETRCR)) * (1 - V_CNR) ;

regle 4084111:
application : iliad, batch ;

RRISUP = RRI1 - RLOGDOM - RTOURREP - RTOUHOTR - RTOUREPA - RCOMP - RCREAT - RRETU 
              - RDONS - RCELTOT - RLOCNPRO - RDUFLOGIH - RNOUV - RFOR - RPATNATOT ; 

RSOC9 = arr(max(min((INVRETKG * (1 - INDPLAF) + INVRETKGA * INDPLAF) , RRISUP) , 0)) * (1 - V_CNR) ;

RSOC10 = arr(max(min((INVRETKGR * (1 - INDPLAF) + INVRETKGRA * INDPLAF) , RRISUP -RSOC9) , 0)) * (1 - V_CNR) ;

RSOC11 = arr(max(min((INVRETKH * (1 - INDPLAF) + INVRETKHA * INDPLAF) , RRISUP -RSOC9-RSOC10) , 0)) * (1 - V_CNR) ;

RSOC12 = arr(max(min((INVRETKI * (1 - INDPLAF) + INVRETKIA * INDPLAF) , RRISUP -RSOC9-RSOC10-RSOC11) , 0)) * (1 - V_CNR) ;

RSOC13 = arr(max(min((INVRETKHR * (1 - INDPLAF) + INVRETKHRA * INDPLAF) , RRISUP -RSOC9-RSOC10-RSOC11-RSOC12) , 0)) * (1 - V_CNR) ;

RSOC14 = arr(max(min((INVRETKIR * (1 - INDPLAF) + INVRETKIRA * INDPLAF) , RRISUP -RSOC9-RSOC10-RSOC11-RSOC12-RSOC13) , 0)) * (1 - V_CNR) ;

RSOC15 = arr(max(min((INVRETQN * (1 - INDPLAF) + INVRETQNA * INDPLAF) , RRISUP -RSOC9-RSOC10-RSOC11-RSOC12-RSOC13-RSOC14) , 0)) * (1 - V_CNR) ;

RSOC16 = arr(max(min((INVRETQU * (1 - INDPLAF) + INVRETQUA * INDPLAF) , RRISUP -RSOC9-RSOC10-RSOC11-RSOC12-RSOC13-RSOC14-RSOC15) , 0)) * (1 - V_CNR) ;

RSOC17 = arr(max(min((INVRETQK * (1 - INDPLAF) + INVRETQKA * INDPLAF) , RRISUP -RSOC9-RSOC10-RSOC11-RSOC12-RSOC13-RSOC14-RSOC15-RSOC16) , 0)) * (1 - V_CNR) ;

RSOC18 = arr(max(min((INVRETQNR * (1 - INDPLAF) + INVRETQNRA * INDPLAF) , RRISUP -RSOC9-RSOC10-RSOC11-RSOC12-RSOC13-RSOC14-RSOC15-RSOC16-RSOC17) , 0)) * (1 - V_CNR) ;

RSOC19 = arr(max(min((INVRETQUR * (1 - INDPLAF) + INVRETQURA * INDPLAF) , RRISUP -RSOC9-RSOC10-RSOC11-RSOC12-RSOC13-RSOC14-RSOC15-RSOC16-RSOC17-RSOC18) , 0)) * (1 - V_CNR) ;

RSOC20 = arr(max(min((INVRETQKR * (1 - INDPLAF) + INVRETQKRA * INDPLAF) , RRISUP -RSOC9-RSOC10-RSOC11-RSOC12-RSOC13-RSOC14-RSOC15-RSOC16-RSOC17-RSOC18-RSOC19) , 0)) * (1 - V_CNR) ;

RSOC21 = arr(max(min((INVRETQJ * (1 - INDPLAF) + INVRETQJA * INDPLAF) , RRISUP -RSOC9-RSOC10-RSOC11-RSOC12-RSOC13-RSOC14-RSOC15-RSOC16-RSOC17-RSOC18-RSOC19-RSOC20) , 0)) * (1 - V_CNR) ;

RSOC22 = arr(max(min((INVRETQS * (1 - INDPLAF) + INVRETQSA * INDPLAF) , RRISUP -RSOC9-RSOC10-RSOC11-RSOC12-RSOC13-RSOC14-RSOC15-RSOC16-RSOC17-RSOC18-RSOC19-RSOC20
                                                                               -RSOC21) , 0)) * (1 - V_CNR) ;

RSOC23 = arr(max(min((INVRETQW * (1 - INDPLAF) + INVRETQWA * INDPLAF) , RRISUP -RSOC9-RSOC10-RSOC11-RSOC12-RSOC13-RSOC14-RSOC15-RSOC16-RSOC17-RSOC18-RSOC19-RSOC20
                                                                               -RSOC21-RSOC22) , 0)) * (1 - V_CNR) ;

RSOC24 = arr(max(min((INVRETQX * (1 - INDPLAF) + INVRETQXA * INDPLAF) , RRISUP -RSOC9-RSOC10-RSOC11-RSOC12-RSOC13-RSOC14-RSOC15-RSOC16-RSOC17-RSOC18-RSOC19-RSOC20
                                                                               -RSOC21-RSOC22-RSOC23) , 0)) * (1 - V_CNR) ;

RSOC25 = arr(max(min((INVRETQJR * (1 - INDPLAF) + INVRETQJRA * INDPLAF) , RRISUP -RSOC9-RSOC10-RSOC11-RSOC12-RSOC13-RSOC14-RSOC15-RSOC16-RSOC17-RSOC18-RSOC19-RSOC20
                                                                                 -RSOC21-RSOC22-RSOC23-RSOC24) , 0)) * (1 - V_CNR) ;

RSOC26 = arr(max(min((INVRETQSR * (1 - INDPLAF) + INVRETQSRA * INDPLAF) , RRISUP -RSOC9-RSOC10-RSOC11-RSOC12-RSOC13-RSOC14-RSOC15-RSOC16-RSOC17-RSOC18-RSOC19-RSOC20
                                                                                 -RSOC21-RSOC22-RSOC23-RSOC24-RSOC25) , 0)) * (1 - V_CNR) ;

RSOC27 = arr(max(min((INVRETQWR * (1 - INDPLAF) + INVRETQWRA * INDPLAF) , RRISUP -RSOC9-RSOC10-RSOC11-RSOC12-RSOC13-RSOC14-RSOC15-RSOC16-RSOC17-RSOC18-RSOC19-RSOC20
                                                                                 -RSOC21-RSOC22-RSOC23-RSOC24-RSOC25-RSOC26) , 0)) * (1 - V_CNR) ;

RSOC28 = arr(max(min((INVRETQXR * (1 - INDPLAF) + INVRETQXRA * INDPLAF) , RRISUP -RSOC9-RSOC10-RSOC11-RSOC12-RSOC13-RSOC14-RSOC15-RSOC16-RSOC17-RSOC18-RSOC19-RSOC20
                                                                                 -RSOC21-RSOC22-RSOC23-RSOC24-RSOC25-RSOC26-RSOC27) , 0)) * (1 - V_CNR) ;

RDOMSOC1_1 =  (1 - V_CNR) * ((1 - V_INDTEO) * (RSOC9 + RSOC10 + RSOC11 + RSOC12 + RSOC13 + RSOC14 + RSOC15 + RSOC16 + RSOC17 + RSOC18 + RSOC19 + RSOC20
                                               + RSOC21 + RSOC22 + RSOC23 + RSOC24 + RSOC25 + RSOC26 + RSOC27 + RSOC28)

              + V_INDTEO * (arr((V_RSOC9+V_RSOC10 + V_RSOC11+V_RSOC13 + V_RSOC15+V_RSOC18 + V_RSOC21+V_RSOC25
                                + V_RSOC12+V_RSOC14 + V_RSOC16+V_RSOC19  + V_RSOC22+V_RSOC26
                                + V_RSOC17+V_RSOC20 + V_RSOC23+V_RSOC27 
                                + V_RSOC24+V_RSOC28 ) * (TX65/100)))
                            ) ;

RDOMSOC1 = RDOMSOC1_1 * (1 - ART1731BIS) 
           + min(RDOMSOC1_1 , max(RDOMSOC1_P , RDOMSOC11731 + 0)) * ART1731BIS ;

RSOC1 = arr(max(min((INVRETRA * (1 - INDPLAF) + INVRETRAA * INDPLAF) , RRISUP -RDOMSOC1) , 0)) * (1 - V_CNR) ;

RSOC2 = arr(max(min((INVRETRB * (1 - INDPLAF) + INVRETRBA * INDPLAF) , RRISUP -RDOMSOC1-RSOC1) , 0)) * (1 - V_CNR) ;

RSOC3 = arr(max(min((INVRETRC * (1 - INDPLAF) + INVRETRCA * INDPLAF) , RRISUP -RDOMSOC1-RSOC1-RSOC2) , 0)) * (1 - V_CNR) ;

RSOC4 = arr(max(min((INVRETRD * (1 - INDPLAF) + INVRETRDA * INDPLAF) , RRISUP -RDOMSOC1-RSOC1-RSOC2-RSOC3) , 0)) * (1 - V_CNR) ;

RSOC5 = arr(max(min((INVRETRAR * (1 - INDPLAF) + INVRETRARA * INDPLAF) , RRISUP -RDOMSOC1-RSOC1-RSOC2-RSOC3-RSOC4) , 0)) * (1 - V_CNR) ;

RSOC6 = arr(max(min((INVRETRBR * (1 - INDPLAF) + INVRETRBRA * INDPLAF) , RRISUP -RDOMSOC1-RSOC1-RSOC2-RSOC3-RSOC4-RSOC5) , 0)) * (1 - V_CNR) ;

RSOC7 = arr(max(min((INVRETRCR * (1 - INDPLAF) + INVRETRCRA * INDPLAF) , RRISUP -RDOMSOC1-RSOC1-RSOC2-RSOC3-RSOC4-RSOC5-RSOC6) , 0)) * (1 - V_CNR) ;

RSOC8 = arr(max(min((INVRETRDR * (1 - INDPLAF) + INVRETRDRA * INDPLAF) , RRISUP -RDOMSOC1-RSOC1-RSOC2-RSOC3-RSOC4-RSOC5-RSOC6-RSOC7) , 0)) * (1 - V_CNR) ;

RLOGSOC_1 = ((1 - V_INDTEO) * (RSOC1 + RSOC2 + RSOC3 + RSOC4 + RSOC5 + RSOC6 + RSOC7 + RSOC8) 


            + V_INDTEO * ( arr(( V_RSOC1+V_RSOC5 + V_RSOC2 + V_RSOC6 + V_RSOC3 + V_RSOC7 + V_RSOC4 + V_RSOC8 ) * (TX65/100))))  * (1 - V_CNR);

RLOGSOC = RLOGSOC_1 * (1 - ART1731BIS)
          + min(RLOGSOC_1 , max(RLOGSOC_P , RLOGSOC1731 + 0)) * ART1731BIS ;

regle 4085:
application : iliad, batch ;

NINVRETMM = max(min(INVOMREP , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3) , 0) 
	     * (1 - V_CNR) ;

NINVRETMN = max(min(INVOMENTMN , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP) , 0) 
	     * (1 - V_CNR) ;

NINVRETQE = max(min(INVENDEB2009 , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN) , 0) 
	     * (1 - V_CNR) ;

NINVRETQV = max(min(INVOMQV , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVENDEB2009) , 0) 
	     * (1 - V_CNR) ;

NINVRETPM = max(min(INVOMRETPM , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009) , 0) * (1 - V_CNR) ;

NINVRETRJ = max(min(INVOMENTRJ , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM) , 0) * (1 - V_CNR) ;

NINVRETMA = max(min(NRETROC40 , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ) , 0) * (1 - V_CNR) ;

NINVRETLG = max(min(NRETROC50 , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA) , 0) 
             * (1 - V_CNR) ;

NINVRETKS = max(min(INVENDI , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG) , 0) 
             * (1 - V_CNR) ;

NINVRETMB = max(min(RETROCOMMB , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                     -NINVRETKS) , 0) * (1 - V_CNR) ;

NINVRETMC = max(min(RETROCOMMC , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                     -NINVRETKS-NINVRETMB) , 0) * (1 - V_CNR) ;

NINVRETLH = max(min(RETROCOMLH , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                     -NINVRETKS-NINVRETMB-NINVRETMC) , 0) * (1 - V_CNR) ;

NINVRETLI = max(min(RETROCOMLI , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                     -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH) , 0) * (1 - V_CNR) ;

NINVRETKT = max(min(INVOMENTKT , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                     -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI) , 0) * (1 - V_CNR) ;

NINVRETKU = max(min(INVOMENTKU , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                     -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT) , 0) * (1 - V_CNR) ;

NINVRETQP = max(min(INVRETRO2 , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                    -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU) , 0) * (1 - V_CNR) ;

NINVRETQG = max(min(INVDOMRET60 , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                      -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP) , 0) * (1 - V_CNR) ;

NINVRETPB = max(min(INVOMRETPB , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                     -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG) , 0) * (1 - V_CNR) ;

NINVRETPF = max(min(INVOMRETPF , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                     -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETPB) , 0) * (1 - V_CNR) ;

NINVRETPJ = max(min(INVOMRETPJ , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                     -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETPB-NINVRETPF) , 0) * (1 - V_CNR) ;

NINVRETQO = max(min(INVRETRO1 , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                    -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETPB-NINVRETPF-NINVRETPJ) , 0) * (1 - V_CNR) ;

NINVRETQF = max(min(INVDOMRET50 , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                      -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETPB-NINVRETPF-NINVRETPJ
                                      -NINVRETQO) , 0) * (1 - V_CNR) ;

NINVRETPA = max(min(INVOMRETPA , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                     -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETPB-NINVRETPF-NINVRETPJ
                                     -NINVRETQO-NINVRETQF) , 0) * (1 - V_CNR) ;

NINVRETPE = max(min(INVOMRETPE , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                     -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETPB-NINVRETPF-NINVRETPJ
                                     -NINVRETQO-NINVRETQF-NINVRETPA) , 0) * (1 - V_CNR) ;

NINVRETPI = max(min(INVOMRETPI , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                     -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETPB-NINVRETPF-NINVRETPJ
                                     -NINVRETQO-NINVRETQF-NINVRETPA-NINVRETPE) , 0) * (1 - V_CNR) ;

NINVRETQR = max(min(INVIMP , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                 -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETPB-NINVRETPF-NINVRETPJ
                                 -NINVRETQO-NINVRETQF-NINVRETPA-NINVRETPE-NINVRETPI) , 0) * (1 - V_CNR) ;

NINVRETQI = max(min(INVDIR2009 , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                     -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETPB-NINVRETPF-NINVRETPJ
                                     -NINVRETQO-NINVRETQF-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETQR) , 0) * (1 - V_CNR) ;

NINVRETPD = max(min(INVOMRETPD , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                     -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                     -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI) , 0) * (1 - V_CNR) ;

NINVRETPH = max(min(INVOMRETPH , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                     -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                     -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD) , 0) * (1 - V_CNR) ;

NINVRETPL = max(min(INVOMRETPL , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                     -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                     -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH) , 0) * (1 - V_CNR) ;

NINVRETPO = max(min(INVOMRETPO , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                     -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                     -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL) , 0) * (1 - V_CNR) ;

NINVRETPT = max(min(INVOMRETPT , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                     -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                     -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO) , 0) * (1 - V_CNR) ;

NINVRETPY = max(min(INVOMRETPY , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                     -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                     -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT) , 0) 
				     * (1 - V_CNR) ;

NINVRETRL = max(min(INVOMENTRL , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                     -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                     -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
				     -NINVRETPY) , 0) * (1 - V_CNR) ;

NINVRETRQ = max(min(INVOMENTRQ , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                     -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                     -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL) , 0) * (1 - V_CNR) ;

NINVRETRV = max(min(INVOMENTRV , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                     -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                     -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ) , 0) * (1 - V_CNR) ;

NINVRETNV = max(min(INVOMENTNV , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                     -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                     -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV) , 0) * (1 - V_CNR) ;

NINVRETPN = max(min(INVOMRETPN , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                     -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                     -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV) , 0) * (1 - V_CNR) ;

NINVRETPS = max(min(INVOMRETPS , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                     -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                     -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN) , 0) * (1 - V_CNR) ;

NINVRETPX = max(min(INVOMRETPX , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                     -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                     -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS) , 0) * (1 - V_CNR) ;

NINVRETRK = max(min(INVOMENTRK , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                     -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                     -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX) , 0) * (1 - V_CNR) ;

NINVRETRP = max(min(INVOMENTRP , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                     -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                     -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK) , 0) * (1 - V_CNR) ;

NINVRETRU = max(min(INVOMENTRU , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                     -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                     -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP) , 0) * (1 - V_CNR) ;

NINVRETNU = max(min(INVOMENTNU , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                     -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                     -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU) , 0) * (1 - V_CNR) ;

NINVRETPP = max(min(INVOMRETPP , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                     -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                     -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU) , 0) 
				     * (1 - V_CNR) ;

NINVRETPU = max(min(INVOMRETPU , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                     -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                     -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				     -NINVRETPP) , 0) * (1 - V_CNR) ;

NINVRETRG = max(min(INVOMENTRG , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                     -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                     -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				     -NINVRETPP-NINVRETPU) , 0) * (1 - V_CNR) ;

NINVRETRM = max(min(INVOMENTRM , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                     -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                     -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				     -NINVRETPP-NINVRETPU-NINVRETRG) , 0) * (1 - V_CNR) ;

NINVRETRR = max(min(INVOMENTRR , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                     -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                     -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				     -NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM) , 0) * (1 - V_CNR) ;

NINVRETRW = max(min(INVOMENTRW , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                     -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                     -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				     -NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR) , 0) * (1 - V_CNR) ;

NINVRETNW = max(min(INVOMENTNW , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                     -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                     -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				     -NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW) , 0) * (1 - V_CNR) ;

NINVRETPR = max(min(INVOMRETPR , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                     -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                     -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				     -NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW-NINVRETNW) , 0) * (1 - V_CNR) ;

NINVRETPW = max(min(INVOMRETPW , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                     -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                     -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				     -NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW-NINVRETNW-NINVRETPR) , 0) * (1 - V_CNR) ;

NINVRETRI = max(min(INVOMENTRI , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                     -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                     -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				     -NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW-NINVRETNW-NINVRETPR-NINVRETPW) , 0) * (1 - V_CNR) ;

NINVRETRO = max(min(INVOMENTRO , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                     -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                     -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				     -NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW-NINVRETNW-NINVRETPR-NINVRETPW-NINVRETRI) , 0) * (1 - V_CNR) ;

NINVRETRT = max(min(INVOMENTRT , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                     -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                     -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				     -NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW-NINVRETNW-NINVRETPR-NINVRETPW-NINVRETRI-NINVRETRO) , 0) * (1 - V_CNR) ;

NINVRETRY = max(min(INVOMENTRY , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                     -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                     -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				     -NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW-NINVRETNW-NINVRETPR-NINVRETPW-NINVRETRI-NINVRETRO-NINVRETRT) , 0) 
				     * (1 - V_CNR) ;

NINVRETNY = max(min(INVOMENTNY , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                     -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                     -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				     -NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW-NINVRETNW-NINVRETPR-NINVRETPW-NINVRETRI-NINVRETRO-NINVRETRT
				     -NINVRETRY) , 0) * (1 - V_CNR) ;

NINVRETSB = max(min(CODHSB , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                 -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                 -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
			         -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				 -NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW-NINVRETNW-NINVRETPR-NINVRETPW-NINVRETRI-NINVRETRO-NINVRETRT
				 -NINVRETRY-NINVRETNY) , 0) * (1 - V_CNR) ;

NINVRETSG = max(min(CODHSG , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                 -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                 -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
			         -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				 -NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW-NINVRETNW-NINVRETPR-NINVRETPW-NINVRETRI-NINVRETRO-NINVRETRT
				 -NINVRETRY-NINVRETNY-NINVRETSB) , 0) * (1 - V_CNR) ;

NINVRETSL = max(min(CODHSL , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                 -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                 -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
			         -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				 -NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW-NINVRETNW-NINVRETPR-NINVRETPW-NINVRETRI-NINVRETRO-NINVRETRT
				 -NINVRETRY-NINVRETNY-NINVRETSB-NINVRETSG) , 0) * (1 - V_CNR) ;

NINVRETSQ = max(min(CODHSQ , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                 -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                 -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
			         -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				 -NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW-NINVRETNW-NINVRETPR-NINVRETPW-NINVRETRI-NINVRETRO-NINVRETRT
				 -NINVRETRY-NINVRETNY-NINVRETSB-NINVRETSG-NINVRETSL) , 0) * (1 - V_CNR) ;

NINVRETSV = max(min(CODHSV , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                 -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                 -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
			         -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				 -NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW-NINVRETNW-NINVRETPR-NINVRETPW-NINVRETRI-NINVRETRO-NINVRETRT
				 -NINVRETRY-NINVRETNY-NINVRETSB-NINVRETSG-NINVRETSL-NINVRETSQ) , 0) * (1 - V_CNR) ;

NINVRETTA = max(min(CODHTA , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                 -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                 -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
			         -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				 -NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW-NINVRETNW-NINVRETPR-NINVRETPW-NINVRETRI-NINVRETRO-NINVRETRT
				 -NINVRETRY-NINVRETNY-NINVRETSB-NINVRETSG-NINVRETSL-NINVRETSQ-NINVRETSV) , 0) * (1 - V_CNR) ;

NINVRETSA = max(min(CODHSA , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                 -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                 -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
			         -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				 -NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW-NINVRETNW-NINVRETPR-NINVRETPW-NINVRETRI-NINVRETRO-NINVRETRT
				 -NINVRETRY-NINVRETNY-NINVRETSB-NINVRETSG-NINVRETSL-NINVRETSQ-NINVRETSV-NINVRETTA) , 0) * (1 - V_CNR) ;

NINVRETSF = max(min(CODHSF , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                 -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                 -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
			         -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				 -NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW-NINVRETNW-NINVRETPR-NINVRETPW-NINVRETRI-NINVRETRO-NINVRETRT
				 -NINVRETRY-NINVRETNY-NINVRETSB-NINVRETSG-NINVRETSL-NINVRETSQ-NINVRETSV-NINVRETTA-NINVRETSA) , 0) * (1 - V_CNR) ;

NINVRETSK = max(min(CODHSK , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                 -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                 -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
			         -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				 -NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW-NINVRETNW-NINVRETPR-NINVRETPW-NINVRETRI-NINVRETRO-NINVRETRT
				 -NINVRETRY-NINVRETNY-NINVRETSB-NINVRETSG-NINVRETSL-NINVRETSQ-NINVRETSV-NINVRETTA-NINVRETSA-NINVRETSF) , 0) * (1 - V_CNR) ;

NINVRETSP = max(min(CODHSP , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                 -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                 -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
			         -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				 -NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW-NINVRETNW-NINVRETPR-NINVRETPW-NINVRETRI-NINVRETRO-NINVRETRT
				 -NINVRETRY-NINVRETNY-NINVRETSB-NINVRETSG-NINVRETSL-NINVRETSQ-NINVRETSV-NINVRETTA-NINVRETSA-NINVRETSF-NINVRETSK) , 0) * (1 - V_CNR) ;

NINVRETSU = max(min(CODHSU , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                 -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                 -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
			         -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				 -NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW-NINVRETNW-NINVRETPR-NINVRETPW-NINVRETRI-NINVRETRO-NINVRETRT
				 -NINVRETRY-NINVRETNY-NINVRETSB-NINVRETSG-NINVRETSL-NINVRETSQ-NINVRETSV-NINVRETTA-NINVRETSA-NINVRETSF-NINVRETSK-NINVRETSP) , 0) * (1 - V_CNR) ;

NINVRETSZ = max(min(CODHSZ , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                 -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                 -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
			         -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				 -NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW-NINVRETNW-NINVRETPR-NINVRETPW-NINVRETRI-NINVRETRO-NINVRETRT
				 -NINVRETRY-NINVRETNY-NINVRETSB-NINVRETSG-NINVRETSL-NINVRETSQ-NINVRETSV-NINVRETTA-NINVRETSA-NINVRETSF-NINVRETSK-NINVRETSP
                                 -NINVRETSU) , 0) * (1 - V_CNR) ;

NINVRETSC = max(min(CODHSC , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                 -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                 -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
			         -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				 -NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW-NINVRETNW-NINVRETPR-NINVRETPW-NINVRETRI-NINVRETRO-NINVRETRT
				 -NINVRETRY-NINVRETNY-NINVRETSB-NINVRETSG-NINVRETSL-NINVRETSQ-NINVRETSV-NINVRETTA-NINVRETSA-NINVRETSF-NINVRETSK-NINVRETSP
                                 -NINVRETSU-NINVRETSZ) , 0) * (1 - V_CNR) ;

NINVRETSH = max(min(CODHSH , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                 -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                 -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
			         -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				 -NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW-NINVRETNW-NINVRETPR-NINVRETPW-NINVRETRI-NINVRETRO-NINVRETRT
				 -NINVRETRY-NINVRETNY-NINVRETSB-NINVRETSG-NINVRETSL-NINVRETSQ-NINVRETSV-NINVRETTA-NINVRETSA-NINVRETSF-NINVRETSK-NINVRETSP
                                 -NINVRETSU-NINVRETSZ-NINVRETSC) , 0) * (1 - V_CNR) ;

NINVRETSM = max(min(CODHSM , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                 -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                 -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
			         -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				 -NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW-NINVRETNW-NINVRETPR-NINVRETPW-NINVRETRI-NINVRETRO-NINVRETRT
				 -NINVRETRY-NINVRETNY-NINVRETSB-NINVRETSG-NINVRETSL-NINVRETSQ-NINVRETSV-NINVRETTA-NINVRETSA-NINVRETSF-NINVRETSK-NINVRETSP
                                 -NINVRETSU-NINVRETSZ-NINVRETSC-NINVRETSH) , 0) * (1 - V_CNR) ;

NINVRETSR = max(min(CODHSR , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                 -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                 -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
			         -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				 -NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW-NINVRETNW-NINVRETPR-NINVRETPW-NINVRETRI-NINVRETRO-NINVRETRT
				 -NINVRETRY-NINVRETNY-NINVRETSB-NINVRETSG-NINVRETSL-NINVRETSQ-NINVRETSV-NINVRETTA-NINVRETSA-NINVRETSF-NINVRETSK-NINVRETSP
                                 -NINVRETSU-NINVRETSZ-NINVRETSC-NINVRETSH-NINVRETSM) , 0) * (1 - V_CNR) ;

NINVRETSW = max(min(CODHSW , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                 -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                 -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
			         -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				 -NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW-NINVRETNW-NINVRETPR-NINVRETPW-NINVRETRI-NINVRETRO-NINVRETRT
				 -NINVRETRY-NINVRETNY-NINVRETSB-NINVRETSG-NINVRETSL-NINVRETSQ-NINVRETSV-NINVRETTA-NINVRETSA-NINVRETSF-NINVRETSK-NINVRETSP
                                 -NINVRETSU-NINVRETSZ-NINVRETSC-NINVRETSH-NINVRETSM-NINVRETSR) , 0) * (1 - V_CNR) ;

NINVRETTB = max(min(CODHTB , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                 -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                 -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
			         -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				 -NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW-NINVRETNW-NINVRETPR-NINVRETPW-NINVRETRI-NINVRETRO-NINVRETRT
				 -NINVRETRY-NINVRETNY-NINVRETSB-NINVRETSG-NINVRETSL-NINVRETSQ-NINVRETSV-NINVRETTA-NINVRETSA-NINVRETSF-NINVRETSK-NINVRETSP
                                 -NINVRETSU-NINVRETSZ-NINVRETSC-NINVRETSH-NINVRETSM-NINVRETSR-NINVRETSW) , 0) * (1 - V_CNR) ;

NINVRETSE = max(min(CODHSE , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                 -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                 -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
			         -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				 -NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW-NINVRETNW-NINVRETPR-NINVRETPW-NINVRETRI-NINVRETRO-NINVRETRT
				 -NINVRETRY-NINVRETNY-NINVRETSB-NINVRETSG-NINVRETSL-NINVRETSQ-NINVRETSV-NINVRETTA-NINVRETSA-NINVRETSF-NINVRETSK-NINVRETSP
                                 -NINVRETSU-NINVRETSZ-NINVRETSC-NINVRETSH-NINVRETSM-NINVRETSR-NINVRETSW-NINVRETTB) , 0) * (1 - V_CNR) ;

NINVRETSJ = max(min(CODHSJ , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                 -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                 -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
			         -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				 -NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW-NINVRETNW-NINVRETPR-NINVRETPW-NINVRETRI-NINVRETRO-NINVRETRT
				 -NINVRETRY-NINVRETNY-NINVRETSB-NINVRETSG-NINVRETSL-NINVRETSQ-NINVRETSV-NINVRETTA-NINVRETSA-NINVRETSF-NINVRETSK-NINVRETSP
                                 -NINVRETSU-NINVRETSZ-NINVRETSC-NINVRETSH-NINVRETSM-NINVRETSR-NINVRETSW-NINVRETTB-NINVRETSE) , 0) * (1 - V_CNR) ;

NINVRETSO = max(min(CODHSO , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                 -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                 -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
			         -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				 -NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW-NINVRETNW-NINVRETPR-NINVRETPW-NINVRETRI-NINVRETRO-NINVRETRT
				 -NINVRETRY-NINVRETNY-NINVRETSB-NINVRETSG-NINVRETSL-NINVRETSQ-NINVRETSV-NINVRETTA-NINVRETSA-NINVRETSF-NINVRETSK-NINVRETSP
                                 -NINVRETSU-NINVRETSZ-NINVRETSC-NINVRETSH-NINVRETSM-NINVRETSR-NINVRETSW-NINVRETTB-NINVRETSE-NINVRETSJ) , 0) * (1 - V_CNR) ;

NINVRETST = max(min(CODHST , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                 -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                 -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
			         -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				 -NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW-NINVRETNW-NINVRETPR-NINVRETPW-NINVRETRI-NINVRETRO-NINVRETRT
				 -NINVRETRY-NINVRETNY-NINVRETSB-NINVRETSG-NINVRETSL-NINVRETSQ-NINVRETSV-NINVRETTA-NINVRETSA-NINVRETSF-NINVRETSK-NINVRETSP
                                 -NINVRETSU-NINVRETSZ-NINVRETSC-NINVRETSH-NINVRETSM-NINVRETSR-NINVRETSW-NINVRETTB-NINVRETSE-NINVRETSJ-NINVRETSO) , 0) * (1 - V_CNR) ;

NINVRETSY = max(min(CODHSY , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                 -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                 -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
			         -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				 -NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW-NINVRETNW-NINVRETPR-NINVRETPW-NINVRETRI-NINVRETRO-NINVRETRT
				 -NINVRETRY-NINVRETNY-NINVRETSB-NINVRETSG-NINVRETSL-NINVRETSQ-NINVRETSV-NINVRETTA-NINVRETSA-NINVRETSF-NINVRETSK-NINVRETSP
                                 -NINVRETSU-NINVRETSZ-NINVRETSC-NINVRETSH-NINVRETSM-NINVRETSR-NINVRETSW-NINVRETTB-NINVRETSE-NINVRETSJ-NINVRETSO-NINVRETST) , 0) * (1 - V_CNR) ;

NINVRETTD = max(min(CODHTD , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ-NINVRETMA-NINVRETLG
                                 -NINVRETKS-NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                 -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-NINVRETPO-NINVRETPT
			         -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				 -NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW-NINVRETNW-NINVRETPR-NINVRETPW-NINVRETRI-NINVRETRO-NINVRETRT
				 -NINVRETRY-NINVRETNY-NINVRETSB-NINVRETSG-NINVRETSL-NINVRETSQ-NINVRETSV-NINVRETTA-NINVRETSA-NINVRETSF-NINVRETSK-NINVRETSP
                                 -NINVRETSU-NINVRETSZ-NINVRETSC-NINVRETSH-NINVRETSM-NINVRETSR-NINVRETSW-NINVRETTB-NINVRETSE-NINVRETSJ-NINVRETSO-NINVRETST
                                 -NINVRETSY) , 0) * (1 - V_CNR) ;

NINVRETMAR = (NINVRETMA - arr(NINVRETMA * TX40 / 100)) * (1 - V_CNR) ;

NINVRETLGR = (NINVRETLG - arr(NINVRETLG * TX50 / 100)) * (1 - V_CNR) ;

NINVRETMBR = (NINVRETMB - arr(NINVRETMB * TX40 / 100)) * (1 - V_CNR) ;

NINVRETMCR = (NINVRETMC - arr(NINVRETMC * TX40 / 100)) * (1 - V_CNR) ;

NINVRETLHR = (NINVRETLH - arr(NINVRETLH * TX50 / 100)) * (1 - V_CNR) ;

NINVRETLIR = (NINVRETLI - arr(NINVRETLI * TX50 / 100)) * (1 - V_CNR) ;

NINVRETQPR = (NINVRETQP - arr(NINVRETQP * TX40 / 100)) * (1 - V_CNR) ;

NINVRETQGR = (NINVRETQG - arr(NINVRETQG * TX40 / 100)) * (1 - V_CNR) ;

NINVRETQOR = (NINVRETQO - arr(NINVRETQO * TX50 / 100)) * (1 - V_CNR) ;

NINVRETQFR = (NINVRETQF - arr(NINVRETQF * TX50 / 100)) * (1 - V_CNR) ;

NINVRETPOR = (NINVRETPO - arr(NINVRETPO * TX40 / 100)) * (1 - V_CNR) ;

NINVRETPTR = (NINVRETPT - arr(NINVRETPT * TX40 / 100)) * (1 - V_CNR) ;

NINVRETPNR = (NINVRETPN - arr(NINVRETPN * TX50 / 100)) * (1 - V_CNR) ;

NINVRETPSR = (NINVRETPS - arr(NINVRETPS * TX50 / 100)) * (1 - V_CNR) ;

NINVRETPBR = (NINVRETPB - arr(NINVRETPB * TX375/ 100)) * (1 - V_CNR) ;

NINVRETPFR = (NINVRETPF - arr(NINVRETPF * TX375/ 100)) * (1 - V_CNR) ;

NINVRETPJR = (NINVRETPJ - arr(NINVRETPJ * TX375/ 100)) * (1 - V_CNR) ;

NINVRETPAR = (NINVRETPA - arr(NINVRETPA * TX4737/100)) * (1 - V_CNR) ;

NINVRETPER = (NINVRETPE - arr(NINVRETPE * TX4737/100)) * (1 - V_CNR) ;

NINVRETPIR = (NINVRETPI - arr(NINVRETPI * TX4737/100)) * (1 - V_CNR) ;

NINVRETPYR = (NINVRETPY - arr(NINVRETPY * TX375/100)) * (1 - V_CNR) ;

NINVRETPXR = (NINVRETPX - arr(NINVRETPX * TX4737/100)) * (1 - V_CNR) ;

NINVRETSBR = (NINVRETSB - arr(NINVRETSB * TX375/100)) * (1 - V_CNR) ;

NINVRETSGR = (NINVRETSG - arr(NINVRETSG * TX375/100)) * (1 - V_CNR) ;

NINVRETSAR = (NINVRETSA - arr(NINVRETSA * TX4737/100)) * (1 - V_CNR) ;

NINVRETSFR = (NINVRETSF - arr(NINVRETSF * TX4737/100)) * (1 - V_CNR) ;

NINVRETRLR = (NINVRETRL - arr(NINVRETRL * TX375/100)) * (1 - V_CNR) ;

NINVRETRQR = (NINVRETRQ - arr(NINVRETRQ * TX375/100)) * (1 - V_CNR) ;

NINVRETRVR = (NINVRETRV - arr(NINVRETRV * TX375/100)) * (1 - V_CNR) ;

NINVRETNVR = (NINVRETNV - arr(NINVRETNV * TX375/100)) * (1 - V_CNR) ;

NINVRETRKR = (NINVRETRK - arr(NINVRETRK * TX4737/100)) * (1 - V_CNR) ;

NINVRETRPR = (NINVRETRP - arr(NINVRETRP * TX4737/100)) * (1 - V_CNR) ;

NINVRETRUR = (NINVRETRU - arr(NINVRETRU * TX4737/100)) * (1 - V_CNR) ;

NINVRETNUR = (NINVRETNU - arr(NINVRETNU * TX4737/100)) * (1 - V_CNR) ;

NINVRETSLR = (NINVRETSL - arr(NINVRETSL * TX375/100)) * (1 - V_CNR) ;

NINVRETSQR = (NINVRETSQ - arr(NINVRETSQ * TX375/100)) * (1 - V_CNR) ;

NINVRETSVR = (NINVRETSV - arr(NINVRETSV * TX375/100)) * (1 - V_CNR) ;

NINVRETTAR = (NINVRETTA - arr(NINVRETTA * TX375/100)) * (1 - V_CNR) ;

NINVRETSKR = (NINVRETSK - arr(NINVRETSK * TX4737/100)) * (1 - V_CNR) ;

NINVRETSPR = (NINVRETSP - arr(NINVRETSP * TX4737/100)) * (1 - V_CNR) ;

NINVRETSUR = (NINVRETSU - arr(NINVRETSU * TX4737/100)) * (1 - V_CNR) ;

NINVRETSZR = (NINVRETSZ - arr(NINVRETSZ * TX4737/100)) * (1 - V_CNR) ;

regle 14083:
application : iliad, batch ;

INVRETMM = NINVRETMM * (1 - V_CNR) ;

INVRETMN = NINVRETMN * (1 - V_CNR) ;

INVRETQE = NINVRETQE * (1 - V_CNR) ;

INVRETQV = NINVRETQV * (1 - V_CNR) ;

INVRETMA = min(arr(NINVRETMA * TX40 / 100) , max(0 , PLAF_INVDOM -INVRETSOC)) * (1 - V_CNR) ;

INVRETLG = min(arr(NINVRETLG * TX50 / 100) , max(0 , PLAF_INVDOM -INVRETSOC-INVRETMA)) * (1 - V_CNR) ;

INVRETMB = min(arr(NINVRETMB * TX40 / 100) , max(0 , PLAF_INVDOM -INVRETSOC-INVRETMA-INVRETLG)) * (1 - V_CNR) ;

INVRETMC = min(arr(NINVRETMC * TX40 / 100) , max(0 , PLAF_INVDOM -INVRETSOC-INVRETMA-INVRETLG-INVRETMB)) * (1 - V_CNR) ;

INVRETLH = min(arr(NINVRETLH * TX50 / 100) , max(0 , PLAF_INVDOM -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC)) * (1 - V_CNR) ;

INVRETLI = min(arr(NINVRETLI * TX50 / 100) , max(0 , PLAF_INVDOM -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH)) * (1 - V_CNR) ;

INVRETQP = min(arr(NINVRETQP * TX40 / 100) , max(0 , PLAF_INVDOM -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI)) * (1 - V_CNR) ;

INVRETQG = min(arr(NINVRETQG * TX40 / 100) , max(0 , PLAF_INVDOM -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP)) * (1 - V_CNR) ;

INVRETQO = min(arr(NINVRETQO * TX50 / 100) , max(0 , PLAF_INVDOM -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG)) * (1 - V_CNR) ;

INVRETQF = min(arr(NINVRETQF * TX50 / 100) , max(0 , PLAF_INVDOM -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO)) * (1 - V_CNR) ;

INVRETPB = min(arr(NINVRETPB * TX375/ 100) , max(0 , PLAF_INVDOM3 -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO
                                                                  -INVRETQF)) * (1 - V_CNR) ;

INVRETPF = min(arr(NINVRETPF * TX375/ 100) , max(0 , PLAF_INVDOM3 -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO
                                                                  -INVRETQF-INVRETPB)) * (1 - V_CNR) ;

INVRETPJ = min(arr(NINVRETPJ * TX375/ 100) , max(0 , PLAF_INVDOM3 -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO
                                                                  -INVRETQF-INVRETPB-INVRETPF)) * (1 - V_CNR) ;

INVRETPA = min(arr(NINVRETPA * TX4737/100) , max(0 , PLAF_INVDOM3 -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO
                                                                  -INVRETQF-INVRETPB-INVRETPF-INVRETPJ)) * (1 - V_CNR) ;

INVRETPE = min(arr(NINVRETPE * TX4737/100) , max(0 , PLAF_INVDOM3 -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO
                                                                  -INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA)) * (1 - V_CNR) ;

INVRETPI = min(arr(NINVRETPI * TX4737/100) , max(0 , PLAF_INVDOM3 -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO
                                                                  -INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE)) * (1 - V_CNR) ;

INVRETPO = min(arr(NINVRETPO * TX40/100) , max(0 , PLAF_INVDOM -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO
                                                               -INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI)) * (1 - V_CNR) ;

INVRETPT = min(arr(NINVRETPT * TX40/100) , max(0 , PLAF_INVDOM -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO
                                                               -INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO)) * (1 - V_CNR) ;

INVRETPY = min(arr(NINVRETPY * TX375/100) , max(0 , PLAF_INVDOM3 -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO
                                                                 -INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT)) * (1 - V_CNR) ;

INVRETRL = min(arr(NINVRETRL * TX375/100) , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO
                                                                 -INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY)) * (1 - V_CNR) ;

INVRETRQ = min(arr(NINVRETRQ * TX375/100) , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO
                                                                 -INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                 -INVRETRL)) * (1 - V_CNR) ;

INVRETRV = min(arr(NINVRETRV * TX375/100) , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO
                                                                 -INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                 -INVRETRL-INVRETRQ)) * (1 - V_CNR) ;

INVRETNV = min(arr(NINVRETNV * TX375/100) , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO
                                                                 -INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                 -INVRETRL-INVRETRQ-INVRETRV)) * (1 - V_CNR) ;

INVRETPN = min(arr(NINVRETPN * TX50/100) , max(0 , PLAF_INVDOM -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO
                                                               -INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                               -INVRETRL-INVRETRQ-INVRETRV-INVRETNV)) * (1 - V_CNR) ;

INVRETPS = min(arr(NINVRETPS * TX50/100) , max(0 , PLAF_INVDOM -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO
                                                               -INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                               -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN)) * (1 - V_CNR) ;

INVRETPX = min(arr(NINVRETPX * TX4737/100) , max(0 , PLAF_INVDOM3 -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO
                                                                  -INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                  -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS)) * (1 - V_CNR) ;

INVRETRK = min(arr(NINVRETRK * TX4737/100) , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO
                                                                  -INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                  -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX)) * (1 - V_CNR) ;

INVRETRP = min(arr(NINVRETRP * TX4737/100) , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO
                                                                  -INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                  -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK)) * (1 - V_CNR) ;

INVRETRU = min(arr(NINVRETRU * TX4737/100) , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO
                                                                  -INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                  -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP)) * (1 - V_CNR) ;

INVRETNU = min(arr(NINVRETNU * TX4737/100) , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO
                                                                  -INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                  -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP-INVRETRU)) * (1 - V_CNR) ;

INVRETSB = min(arr(NINVRETSB * TX375/100) , max(0 , PLAF_INVDOM3 -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO
                                                                 -INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                 -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP-INVRETRU
                                                                 -INVRETNU)) * (1 - V_CNR) ;

INVRETSG = min(arr(NINVRETSG * TX375/100) , max(0 , PLAF_INVDOM3 -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO
                                                                 -INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                 -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP-INVRETRU
                                                                 -INVRETNU-INVRETSB)) * (1 - V_CNR) ;

INVRETSL = min(arr(NINVRETSL * TX375/100) , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO
                                                                 -INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                 -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP-INVRETRU
                                                                 -INVRETNU-INVRETSB-INVRETSG)) * (1 - V_CNR) ;

INVRETSQ = min(arr(NINVRETSQ * TX375/100) , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO
                                                                 -INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                 -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP-INVRETRU
                                                                 -INVRETNU-INVRETSB-INVRETSG-INVRETSL)) * (1 - V_CNR) ;

INVRETSV = min(arr(NINVRETSV * TX375/100) , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO
                                                                 -INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                 -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP-INVRETRU
                                                                 -INVRETNU-INVRETSB-INVRETSG-INVRETSL-INVRETSQ)) * (1 - V_CNR) ;

INVRETTA = min(arr(NINVRETTA * TX375/100) , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO
                                                                 -INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                 -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP-INVRETRU
                                                                 -INVRETNU-INVRETSB-INVRETSG-INVRETSL-INVRETSQ-INVRETSV)) * (1 - V_CNR) ;

INVRETSA = min(arr(NINVRETSA * TX4737/100) , max(0 , PLAF_INVDOM3 -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO
                                                                  -INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                  -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP-INVRETRU
                                                                  -INVRETNU-INVRETSB-INVRETSG-INVRETSL-INVRETSQ-INVRETSV-INVRETTA)) * (1 - V_CNR) ;

INVRETSF = min(arr(NINVRETSF * TX4737/100) , max(0 , PLAF_INVDOM3 -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO
                                                                  -INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                  -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP-INVRETRU
                                                                  -INVRETNU-INVRETSB-INVRETSG-INVRETSL-INVRETSQ-INVRETSV-INVRETTA-INVRETSA)) * (1 - V_CNR) ;

INVRETSK = min(arr(NINVRETSK * TX4737/100) , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO
                                                                  -INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                  -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP-INVRETRU
                                                                  -INVRETNU-INVRETSB-INVRETSG-INVRETSL-INVRETSQ-INVRETSV-INVRETTA-INVRETSA-INVRETSF)) * (1 - V_CNR) ;

INVRETSP = min(arr(NINVRETSP * TX4737/100) , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO
                                                                  -INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                  -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP-INVRETRU
                                                                  -INVRETNU-INVRETSB-INVRETSG-INVRETSL-INVRETSQ-INVRETSV-INVRETTA-INVRETSA-INVRETSF-INVRETSK)) * (1 - V_CNR) ;

INVRETSU = min(arr(NINVRETSU * TX4737/100) , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO
                                                                  -INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                  -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP-INVRETRU
                                                                  -INVRETNU-INVRETSB-INVRETSG-INVRETSL-INVRETSQ-INVRETSV-INVRETTA-INVRETSA-INVRETSF-INVRETSK
                                                                  -INVRETSP)) * (1 - V_CNR) ;

INVRETSZ = min(arr(NINVRETSZ * TX4737/100) , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO
                                                                  -INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                  -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP-INVRETRU
                                                                  -INVRETNU-INVRETSB-INVRETSG-INVRETSL-INVRETSQ-INVRETSV-INVRETTA-INVRETSA-INVRETSF-INVRETSK
                                                                  -INVRETSP-INVRETSU)) * (1 - V_CNR) ;

INVRETPP = min(NINVRETPP , max(0 , PLAF_INVDOM -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO
                                               -INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                               -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP-INVRETRU
                                               -INVRETNU-INVRETSB-INVRETSG-INVRETSL-INVRETSQ-INVRETSV-INVRETTA-INVRETSA-INVRETSF-INVRETSK
                                               -INVRETSP-INVRETSU-INVRETSZ)) * (1 - V_CNR) ;

INVRETPU = min(NINVRETPU , max(0 , PLAF_INVDOM -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO
                                               -INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                               -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP-INVRETRU
                                               -INVRETNU-INVRETSB-INVRETSG-INVRETSL-INVRETSQ-INVRETSV-INVRETTA-INVRETSA-INVRETSF-INVRETSK
                                               -INVRETSP-INVRETSU-INVRETSZ-INVRETPP)) * (1 - V_CNR) ;

INVRETRG = min(NINVRETRG , max(0 , PLAF_INVDOM3 -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO
                                                -INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP-INVRETRU
                                                -INVRETNU-INVRETSB-INVRETSG-INVRETSL-INVRETSQ-INVRETSV-INVRETTA-INVRETSA-INVRETSF-INVRETSK
                                                -INVRETSP-INVRETSU-INVRETSZ-INVRETPP-INVRETPU)) * (1 - V_CNR) ;

INVRETRM = min(NINVRETRM , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO
                                                -INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP-INVRETRU
                                                -INVRETNU-INVRETSB-INVRETSG-INVRETSL-INVRETSQ-INVRETSV-INVRETTA-INVRETSA-INVRETSF-INVRETSK
                                                -INVRETSP-INVRETSU-INVRETSZ-INVRETPP-INVRETPU-INVRETRG)) * (1 - V_CNR) ;

INVRETRR = min(NINVRETRR , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO
                                                -INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP-INVRETRU
                                                -INVRETNU-INVRETSB-INVRETSG-INVRETSL-INVRETSQ-INVRETSV-INVRETTA-INVRETSA-INVRETSF-INVRETSK
                                                -INVRETSP-INVRETSU-INVRETSZ-INVRETPP-INVRETPU-INVRETRG-INVRETRM)) * (1 - V_CNR) ;

INVRETRW = min(NINVRETRW , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO
                                                -INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP-INVRETRU
                                                -INVRETNU-INVRETSB-INVRETSG-INVRETSL-INVRETSQ-INVRETSV-INVRETTA-INVRETSA-INVRETSF-INVRETSK
                                                -INVRETSP-INVRETSU-INVRETSZ-INVRETPP-INVRETPU-INVRETRG-INVRETRM-INVRETRR)) * (1 - V_CNR) ;

INVRETNW = min(NINVRETNW , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO
                                                -INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP-INVRETRU
                                                -INVRETNU-INVRETSB-INVRETSG-INVRETSL-INVRETSQ-INVRETSV-INVRETTA-INVRETSA-INVRETSF-INVRETSK
                                                -INVRETSP-INVRETSU-INVRETSZ-INVRETPP-INVRETPU-INVRETRG-INVRETRM-INVRETRR-INVRETRW)) * (1 - V_CNR) ;

INVRETSC = min(NINVRETSC , max(0 , PLAF_INVDOM3 -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO
                                                -INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP-INVRETRU
                                                -INVRETNU-INVRETSB-INVRETSG-INVRETSL-INVRETSQ-INVRETSV-INVRETTA-INVRETSA-INVRETSF-INVRETSK
                                                -INVRETSP-INVRETSU-INVRETSZ-INVRETPP-INVRETPU-INVRETRG-INVRETRM-INVRETRR-INVRETRW-INVRETNW)) * (1 - V_CNR) ;

INVRETSH = min(NINVRETSH , max(0 , PLAF_INVDOM3 -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO
                                                -INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP-INVRETRU
                                                -INVRETNU-INVRETSB-INVRETSG-INVRETSL-INVRETSQ-INVRETSV-INVRETTA-INVRETSA-INVRETSF-INVRETSK
                                                -INVRETSP-INVRETSU-INVRETSZ-INVRETPP-INVRETPU-INVRETRG-INVRETRM-INVRETRR-INVRETRW-INVRETNW
                                                -INVRETSC)) * (1 - V_CNR) ;

INVRETSM = min(NINVRETSM , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO
                                                -INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP-INVRETRU
                                                -INVRETNU-INVRETSB-INVRETSG-INVRETSL-INVRETSQ-INVRETSV-INVRETTA-INVRETSA-INVRETSF-INVRETSK
                                                -INVRETSP-INVRETSU-INVRETSZ-INVRETPP-INVRETPU-INVRETRG-INVRETRM-INVRETRR-INVRETRW-INVRETNW
                                                -INVRETSC-INVRETSH)) * (1 - V_CNR) ;

INVRETSR = min(NINVRETSR , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO
                                                -INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP-INVRETRU
                                                -INVRETNU-INVRETSB-INVRETSG-INVRETSL-INVRETSQ-INVRETSV-INVRETTA-INVRETSA-INVRETSF-INVRETSK
                                                -INVRETSP-INVRETSU-INVRETSZ-INVRETPP-INVRETPU-INVRETRG-INVRETRM-INVRETRR-INVRETRW-INVRETNW
                                                -INVRETSC-INVRETSH-INVRETSM)) * (1 - V_CNR) ;

INVRETSW = min(NINVRETSW , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO
                                                -INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP-INVRETRU
                                                -INVRETNU-INVRETSB-INVRETSG-INVRETSL-INVRETSQ-INVRETSV-INVRETTA-INVRETSA-INVRETSF-INVRETSK
                                                -INVRETSP-INVRETSU-INVRETSZ-INVRETPP-INVRETPU-INVRETRG-INVRETRM-INVRETRR-INVRETRW-INVRETNW
                                                -INVRETSC-INVRETSH-INVRETSM-INVRETSR)) * (1 - V_CNR) ;

INVRETTB = min(NINVRETTB , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO
                                                -INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP-INVRETRU
                                                -INVRETNU-INVRETSB-INVRETSG-INVRETSL-INVRETSQ-INVRETSV-INVRETTA-INVRETSA-INVRETSF-INVRETSK
                                                -INVRETSP-INVRETSU-INVRETSZ-INVRETPP-INVRETPU-INVRETRG-INVRETRM-INVRETRR-INVRETRW-INVRETNW
                                                -INVRETSC-INVRETSH-INVRETSM-INVRETSR-INVRETSW)) * (1 - V_CNR) ;

INVRETENT = INVRETMA + INVRETLG + INVRETMB + INVRETMC + INVRETLH + INVRETLI + INVRETQP + INVRETQG + INVRETQO + INVRETQF + INVRETPB + INVRETPF + INVRETPJ 
            + INVRETPA + INVRETPE + INVRETPI + INVRETPO + INVRETPT + INVRETPY + INVRETRL + INVRETRQ + INVRETRV + INVRETNV + INVRETPN + INVRETPS + INVRETPX 
            + INVRETRK + INVRETRP + INVRETRU + INVRETNU + INVRETSB + INVRETSG + INVRETSL + INVRETSQ + INVRETSV + INVRETTA + INVRETSA + INVRETSF + INVRETSK 
            + INVRETSP + INVRETSU + INVRETSZ + INVRETPP + INVRETPU + INVRETRG + INVRETRM + INVRETRR + INVRETRW + INVRETNW + INVRETSC + INVRETSH + INVRETSM 
            + INVRETSR + INVRETSW + INVRETTB ;

INVRETKS = NINVRETKS * (1 - V_CNR) ; 

INVRETKT = NINVRETKT * (1 - V_CNR) ; 

INVRETKU = NINVRETKU * (1 - V_CNR) ; 

INVRETQR = NINVRETQR * (1 - V_CNR) ;

INVRETQI = NINVRETQI * (1 - V_CNR) ;

INVRETPD = NINVRETPD * (1 - V_CNR) ;

INVRETPH = NINVRETPH * (1 - V_CNR) ;

INVRETPL = NINVRETPL * (1 - V_CNR) ;

INVRETPR = NINVRETPR * (1 - V_CNR) ;

INVRETPW = NINVRETPW * (1 - V_CNR) ;

INVRETRI = NINVRETRI * (1 - V_CNR) ;

INVRETRO = NINVRETRO * (1 - V_CNR) ;

INVRETRT = NINVRETRT * (1 - V_CNR) ;

INVRETRY = NINVRETRY * (1 - V_CNR) ;

INVRETNY = NINVRETNY * (1 - V_CNR) ;

INVRETSE = NINVRETSE * (1 - V_CNR) ;

INVRETSJ = NINVRETSJ * (1 - V_CNR) ;

INVRETSO = NINVRETSO * (1 - V_CNR) ;

INVRETST = NINVRETST * (1 - V_CNR) ;

INVRETSY = NINVRETSY * (1 - V_CNR) ;

INVRETTD = NINVRETTD * (1 - V_CNR) ;


INVRETMAR = min(arr(INVRETMA * 3/2) , NINVRETMA - INVRETMA) * (1 - V_CNR) ;

INVRETLGR = min(INVRETLG , max(0 , NINVRETLG - INVRETLG)) * (1 - V_CNR) ;

INVRETMBR = min(arr(INVRETMB * 3/2) , NINVRETMB - INVRETMB) * (1 - V_CNR) ;

INVRETMCR = min(arr(INVRETMC * 3/2) , NINVRETMC - INVRETMC) * (1 - V_CNR) ;

INVRETLHR = min(INVRETLH , max(0 , NINVRETLH - INVRETLH)) * (1 - V_CNR) ;

INVRETLIR = min(INVRETLI , max(0 , NINVRETLI - INVRETLI)) * (1 - V_CNR) ;

INVRETQPR = min(arr(INVRETQP * 3/2) , NINVRETQP - INVRETQP) * (1 - V_CNR) ;

INVRETQGR = min(arr(INVRETQG * 3/2) , NINVRETQG - INVRETQG) * (1 - V_CNR) ;

INVRETQOR = min(INVRETQO , max(0 , NINVRETQO - INVRETQO)) * (1 - V_CNR) ;

INVRETQFR = min(INVRETQF , max(0 , NINVRETQF - INVRETQF)) * (1 - V_CNR) ;

INVRETPBR = (min(arr(INVRETPB * 5/3) , NINVRETPB - INVRETPB) * (1 - null(1 - abs(arr(INVRETPB * 5/3) - (NINVRETPB - INVRETPB))))
             + (NINVRETPB - INVRETPB) * null(1 - abs(arr(INVRETPB * 5/3) - (NINVRETPB - INVRETPB))))
            * (1 - V_CNR) ;

INVRETPFR = (min(arr(INVRETPF * 5/3) , NINVRETPF - INVRETPF) * (1 - null(1 - abs(arr(INVRETPF * 5/3) - (NINVRETPF - INVRETPF))))
             + (NINVRETPF - INVRETPF) * null(1 - abs(arr(INVRETPF * 5/3) - (NINVRETPF - INVRETPF))))
            * (1 - V_CNR) ;

INVRETPJR = (min(arr(INVRETPJ * 5/3) , NINVRETPJ - INVRETPJ) * (1 - null(1 - abs(arr(INVRETPJ * 5/3) - (NINVRETPJ - INVRETPJ))))
             + (NINVRETPJ - INVRETPJ) * null(1 - abs(arr(INVRETPJ * 5/3) - (NINVRETPJ - INVRETPJ))))
            * (1 - V_CNR) ;

INVRETPAR = (min(arr(INVRETPA * 10/9) , NINVRETPA - INVRETPA) * (1 - null(1 - abs(arr(INVRETPA * 10/9) - (NINVRETPA - INVRETPA))))
             + (NINVRETPA - INVRETPA) * null(1 - abs(arr(INVRETPA * 10/9) - (NINVRETPA - INVRETPA))))
            * (1 - V_CNR) ;

INVRETPER = (min(arr(INVRETPE * 10/9) , NINVRETPE - INVRETPE) * (1 - null(1 - abs(arr(INVRETPE * 10/9) - (NINVRETPE - INVRETPE))))
             + (NINVRETPE - INVRETPE) * null(1 - abs(arr(INVRETPE * 10/9) - (NINVRETPE - INVRETPE))))
            * (1 - V_CNR) ;

INVRETPIR = (min(arr(INVRETPI * 10/9) , NINVRETPI - INVRETPI) * (1 - null(1 - abs(arr(INVRETPI * 10/9) - (NINVRETPI - INVRETPI))))
             + (NINVRETPI - INVRETPI) * null(1 - abs(arr(INVRETPI * 10/9) - (NINVRETPI - INVRETPI))))
            * (1 - V_CNR) ;

INVRETPOR = min(arr(INVRETPO * 3/2) , NINVRETPO - INVRETPO) * (1 - V_CNR) ;

INVRETPTR = min(arr(INVRETPT * 3/2) , NINVRETPT - INVRETPT) * (1 - V_CNR) ;

INVRETPYR = (min(arr(INVRETPY * 5/3) , NINVRETPY - INVRETPY) * (1 - null(1 - abs(arr(INVRETPY * 5/3) - (NINVRETPY - INVRETPY))))
             + (NINVRETPY - INVRETPY) * null(1 - abs(arr(INVRETPY * 5/3) - (NINVRETPY - INVRETPY))))
            * (1 - V_CNR) ; 

INVRETRLR = (min(arr(INVRETRL * 5/3) , NINVRETRL - INVRETRL) * (1 - null(1 - abs(arr(INVRETRL * 5/3) - (NINVRETRL - INVRETRL))))
             + (NINVRETRL - INVRETRL) * null(1 - abs(arr(INVRETRL * 5/3) - (NINVRETRL - INVRETRL))))
            * (1 - V_CNR) ; 

INVRETRQR = (min(arr(INVRETRQ * 5/3) , NINVRETRQ - INVRETRQ) * (1 - null(1 - abs(arr(INVRETRQ * 5/3) - (NINVRETRQ - INVRETRQ))))
             + (NINVRETRQ - INVRETRQ) * null(1 - abs(arr(INVRETRQ * 5/3) - (NINVRETRQ - INVRETRQ)))) 
            * (1 - V_CNR) ; 

INVRETRVR = (min(arr(INVRETRV * 5/3) , NINVRETRV - INVRETRV) * (1 - null(1 - abs(arr(INVRETRV * 5/3) - (NINVRETRV - INVRETRV))))
             + (NINVRETRV - INVRETRV) * null(1 - abs(arr(INVRETRV * 5/3) - (NINVRETRV - INVRETRV))))
            * (1 - V_CNR) ;

INVRETNVR = (min(arr(INVRETNV * 5/3) , NINVRETNV - INVRETNV) * (1 - null(1 - abs(arr(INVRETNV * 5/3) - (NINVRETNV - INVRETNV))))
             + (NINVRETNV - INVRETNV) * null(1 - abs(arr(INVRETNV * 5/3) - (NINVRETNV - INVRETNV))))
            * (1 - V_CNR) ;

INVRETPNR = min(INVRETPN , max(0 , NINVRETPN - INVRETPN)) * (1 - V_CNR) ;

INVRETPSR = min(INVRETPS , max(0 , NINVRETPS - INVRETPS)) * (1 - V_CNR) ;

INVRETPXR = (min(arr(INVRETPX * 10/9) , NINVRETPX - INVRETPX) * (1 - null(1 - abs(arr(INVRETPX * 10/9) - (NINVRETPX - INVRETPX))))
             + (NINVRETPX - INVRETPX) * null(1 - abs(arr(INVRETPX * 10/9) - (NINVRETPX - INVRETPX))))
            * (1 - V_CNR) ;

INVRETRKR = (min(arr(INVRETRK * 10/9) , NINVRETRK - INVRETRK) * (1 - null(1 - abs(arr(INVRETRK * 10/9) - (NINVRETRK - INVRETRK))))
             + (NINVRETRK - INVRETRK) * null(1 - abs(arr(INVRETRK * 10/9) - (NINVRETRK - INVRETRK)))) 
            * (1 - V_CNR) ;

INVRETRPR = (min(arr(INVRETRP * 10/9) , NINVRETRP - INVRETRP) * (1 - null(1 - abs(arr(INVRETRP * 10/9) - (NINVRETRP - INVRETRP))))
             + (NINVRETRP - INVRETRP) * null(1 - abs(arr(INVRETRP * 10/9) - (NINVRETRP - INVRETRP))))
            * (1 - V_CNR) ;

INVRETRUR = (min(arr(INVRETRU * 10/9) , NINVRETRU - INVRETRU) * (1 - null(1 - abs(arr(INVRETRU * 10/9) - (NINVRETRU - INVRETRU))))
             + (NINVRETRU - INVRETRU) * null(1 - abs(arr(INVRETRU * 10/9) - (NINVRETRU - INVRETRU))))
            * (1 - V_CNR) ; 

INVRETNUR = (min(arr(INVRETNU * 10/9) , NINVRETNU - INVRETNU) * (1 - null(1 - abs(arr(INVRETNU * 10/9) - (NINVRETNU - INVRETNU))))
             + (NINVRETNU - INVRETNU) * null(1 - abs(arr(INVRETNU * 10/9) - (NINVRETNU - INVRETNU))))
            * (1 - V_CNR) ; 

INVRETSBR = (min(arr(INVRETSB * 5/3) , NINVRETSB - INVRETSB) * (1 - null(1 - abs(arr(INVRETSB * 5/3) - (NINVRETSB - INVRETSB))))  
             + (NINVRETSB - INVRETSB) * null(1 - abs(arr(INVRETSB * 5/3) - (NINVRETSB - INVRETSB))))
            * (1 - V_CNR) ; 

INVRETSGR = (min(arr(INVRETSG * 5/3) , NINVRETSG - INVRETSG) * (1 - null(1 - abs(arr(INVRETSG * 5/3) - (NINVRETSG - INVRETSG))))
             + (NINVRETSG - INVRETSG) * null(1 - abs(arr(INVRETSG * 5/3) - (NINVRETSG - INVRETSG))))
            * (1 - V_CNR) ;

INVRETSLR = (min(arr(INVRETSL * 5/3) , NINVRETSL - INVRETSL) * (1 - null(1 - abs(arr(INVRETSL * 5/3) - (NINVRETSL - INVRETSL))))
             + (NINVRETSL - INVRETSL) * null(1 - abs(arr(INVRETSL * 5/3) - (NINVRETSL - INVRETSL))))
            * (1 - V_CNR) ; 

INVRETSQR = (min(arr(INVRETSQ * 5/3) , NINVRETSQ - INVRETSQ) * (1 - null(1 - abs(arr(INVRETSQ * 5/3) - (NINVRETSQ - INVRETSQ))))
             + (NINVRETSQ - INVRETSQ) * null(1 - abs(arr(INVRETSQ * 5/3) - (NINVRETSQ - INVRETSQ))))
            * (1 - V_CNR) ; 

INVRETSVR = (min(arr(INVRETSV * 5/3) , NINVRETSV - INVRETSV) * (1 - null(1 - abs(arr(INVRETSV * 5/3) - (NINVRETSV - INVRETSV))))
             + (NINVRETSV - INVRETSV) * null(1 - abs(arr(INVRETSV * 5/3) - (NINVRETSV - INVRETSV))))
            * (1 - V_CNR) ; 

INVRETTAR = (min(arr(INVRETTA * 5/3) , NINVRETTA - INVRETTA) * (1 - null(1 - abs(arr(INVRETTA * 5/3) - (NINVRETTA - INVRETTA))))
             + (NINVRETTA - INVRETTA) * null(1 - abs(arr(INVRETTA * 5/3) - (NINVRETTA - INVRETTA))))
            * (1 - V_CNR) ; 

INVRETSAR = (min(arr(INVRETSA * 10/9) , NINVRETSA - INVRETSA) * (1 - null(1 - abs(arr(INVRETSA * 10/9) - (NINVRETSA - INVRETSA))))
             + (NINVRETSA - INVRETSA) * null(1 - abs(arr(INVRETSA * 10/9) - (NINVRETSA - INVRETSA)))) 
            * (1 - V_CNR) ; 

INVRETSFR = (min(arr(INVRETSF * 10/9) , NINVRETSF - INVRETSF) * (1 - null(1 - abs(arr(INVRETSF * 10/9) - (NINVRETSF - INVRETSF))))
             + (NINVRETSF - INVRETSF) * null(1 - abs(arr(INVRETSF * 10/9) - (NINVRETSF - INVRETSF)))) 
            * (1 - V_CNR) ;

INVRETSKR = (min(arr(INVRETSK * 10/9) , NINVRETSK - INVRETSK) * (1 - null(1 - abs(arr(INVRETSK * 10/9) - (NINVRETSK - INVRETSK))))
             + (NINVRETSK - INVRETSK) * null(1 - abs(arr(INVRETSK * 10/9) - (NINVRETSK - INVRETSK)))) 
            * (1 - V_CNR) ; 

INVRETSPR = (min(arr(INVRETSP * 10/9) , NINVRETSP - INVRETSP) * (1 - null(1 - abs(arr(INVRETSP * 10/9) - (NINVRETSP - INVRETSP))))
             + (NINVRETSP - INVRETSP) * null(1 - abs(arr(INVRETSP * 10/9) - (NINVRETSP - INVRETSP))))
            * (1 - V_CNR) ;

INVRETSUR = (min(arr(INVRETSU * 10/9) , NINVRETSU - INVRETSU) * (1 - null(1 - abs(arr(INVRETSU * 10/9) - (NINVRETSU - INVRETSU))))
             + (NINVRETSU - INVRETSU) * null(1 - abs(arr(INVRETSU * 10/9) - (NINVRETSU - INVRETSU)))) 
            * (1 - V_CNR) ; 

INVRETSZR = (min(arr(INVRETSZ * 10/9) , NINVRETSZ - INVRETSZ) * (1 - null(1 - abs(arr(INVRETSZ * 10/9) - (NINVRETSZ - INVRETSZ))))
             + (NINVRETSZ - INVRETSZ) * null(1 - abs(arr(INVRETSZ * 10/9) - (NINVRETSZ - INVRETSZ))))
            * (1 - V_CNR) ; 

regle 7714083:
application : iliad, batch ;

RENT1 = max(min((INVRETSB * (1 - INDPLAF) + INVRETSBA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RCOLENT) , 0) * (1 - V_CNR) ;

RENT2 = max(min((INVRETSG * (1 - INDPLAF) + INVRETSGA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RCOLENT-RENT1) , 0) * (1 - V_CNR) ;

RENT3 = max(min((INVRETSL * (1 - INDPLAF) + INVRETSLA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RCOLENT-RENT1-RENT2) , 0) * (1 - V_CNR) ;

RENT4 = max(min((INVRETSQ * (1 - INDPLAF) + INVRETSQA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RCOLENT-RENT1-RENT2-RENT3) , 0) * (1 - V_CNR) ;

RENT5 = max(min((INVRETSV * (1 - INDPLAF) + INVRETSVA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RCOLENT-RENT1-RENT2-RENT3-RENT4) , 0) * (1 - V_CNR) ;

RENT6 = max(min((INVRETTA * (1 - INDPLAF) + INVRETTAA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RCOLENT-RENT1-RENT2-RENT3-RENT4-RENT5) , 0) * (1 - V_CNR) ;

RENT7 = max(min((INVRETSA * (1 - INDPLAF) + INVRETSAA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RCOLENT-RENT1-RENT2-RENT3-RENT4-RENT5-RENT6) , 0) * (1 - V_CNR) ;

RENT8 = max(min((INVRETSF * (1 - INDPLAF) + INVRETSFA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RCOLENT-RENT1-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7) , 0) * (1 - V_CNR) ;

RENT9 = max(min((INVRETSK * (1 - INDPLAF) + INVRETSKA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RCOLENT-RENT1-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8) , 0) * (1 - V_CNR) ;

RENT10 = max(min((INVRETSP * (1 - INDPLAF) + INVRETSPA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RCOLENT-RENT1-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9) , 0) 
                                                                           * (1 - V_CNR) ;

RENT11 = max(min((INVRETSU * (1 - INDPLAF) + INVRETSUA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RCOLENT-RENT1-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9
                                                                           -RENT10) , 0) * (1 - V_CNR) ;

RENT12 = max(min((INVRETSZ * (1 - INDPLAF) + INVRETSZA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RCOLENT-RENT1-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9
                                                                           -RENT10-RENT11) , 0) * (1 - V_CNR) ;

RENT13 = max(min((INVRETSC * (1 - INDPLAF) + INVRETSCA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RCOLENT-RENT1-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9
                                                                           -RENT10-RENT11-RENT12) , 0) * (1 - V_CNR) ;

RENT14 = max(min((INVRETSH * (1 - INDPLAF) + INVRETSHA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RCOLENT-RENT1-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9
                                                                           -RENT10-RENT11-RENT12-RENT13) , 0) * (1 - V_CNR) ;

RENT15 = max(min((INVRETSM * (1 - INDPLAF) + INVRETSMA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RCOLENT-RENT1-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9
                                                                           -RENT10-RENT11-RENT12-RENT13-RENT14) , 0) * (1 - V_CNR) ;

RENT16 = max(min((INVRETSR * (1 - INDPLAF) + INVRETSRA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RCOLENT-RENT1-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9
                                                                           -RENT10-RENT11-RENT12-RENT13-RENT14-RENT15) , 0) * (1 - V_CNR) ;

RENT17 = max(min((INVRETSW * (1 - INDPLAF) + INVRETSWA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RCOLENT-RENT1-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9
                                                                           -RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16) , 0) * (1 - V_CNR) ;

RENT18 = max(min((INVRETTB * (1 - INDPLAF) + INVRETTBA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RCOLENT-RENT1-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9
                                                                           -RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16-RENT17) , 0) * (1 - V_CNR) ;

RENT19 = max(min((INVRETSE * (1 - INDPLAF) + INVRETSEA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RCOLENT-RENT1-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9
                                                                           -RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16-RENT17-RENT18) , 0) * (1 - V_CNR) ;

RENT20 = max(min((INVRETSJ * (1 - INDPLAF) + INVRETSJA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RCOLENT-RENT1-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9
                                                                           -RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16-RENT17-RENT18-RENT19) , 0) * (1 - V_CNR) ;

RENT21 = max(min((INVRETSO * (1 - INDPLAF) + INVRETSOA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RCOLENT-RENT1-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9
                                                                           -RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16-RENT17-RENT18-RENT19-RENT20) , 0) * (1 - V_CNR) ;

RENT22 = max(min((INVRETST * (1 - INDPLAF) + INVRETSTA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RCOLENT-RENT1-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9
                                                                           -RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16-RENT17-RENT18-RENT19-RENT20-RENT21) , 0) * (1 - V_CNR) ;

RENT23 = max(min((INVRETSY * (1 - INDPLAF) + INVRETSYA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RCOLENT-RENT1-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9
                                                                           -RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16-RENT17-RENT18-RENT19-RENT20-RENT21-RENT22) , 0) * (1 - V_CNR) ;

RENT24 = max(min((INVRETTD * (1 - INDPLAF) + INVRETTDA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RCOLENT-RENT1-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9
                                                                           -RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16-RENT17-RENT18-RENT19-RENT20-RENT21-RENT22
                                                                           -RENT23) , 0) * (1 - V_CNR) ;

RENT25 = max(min((INVRETSBR * (1 - INDPLAF) + INVRETSBRA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RCOLENT-RENT1-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9
                                                                             -RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16-RENT17-RENT18-RENT19-RENT20-RENT21-RENT22
                                                                             -RENT23-RENT24) , 0) * (1 - V_CNR) ;

RENT26 = max(min((INVRETSGR * (1 - INDPLAF) + INVRETSGRA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RCOLENT-RENT1-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9
                                                                             -RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16-RENT17-RENT18-RENT19-RENT20-RENT21-RENT22
                                                                             -RENT23-RENT24-RENT25) , 0) * (1 - V_CNR) ;

RENT27 = max(min((INVRETSAR * (1 - INDPLAF) + INVRETSARA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RCOLENT-RENT1-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9
                                                                             -RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16-RENT17-RENT18-RENT19-RENT20-RENT21-RENT22
                                                                             -RENT23-RENT24-RENT25-RENT26) , 0) * (1 - V_CNR) ;

RENT28 = max(min((INVRETSFR * (1 - INDPLAF) + INVRETSFRA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RCOLENT-RENT1-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9
                                                                             -RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16-RENT17-RENT18-RENT19-RENT20-RENT21-RENT22
                                                                             -RENT23-RENT24-RENT25-RENT26-RENT27) , 0) * (1 - V_CNR) ;

RENT29 = max(min((INVRETSLR * (1 - INDPLAF) + INVRETSLRA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RCOLENT-RENT1-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9
                                                                             -RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16-RENT17-RENT18-RENT19-RENT20-RENT21-RENT22
                                                                             -RENT23-RENT24-RENT25-RENT26-RENT27-RENT28) , 0) * (1 - V_CNR) ;

RENT30 = max(min((INVRETSQR * (1 - INDPLAF) + INVRETSQRA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RCOLENT-RENT1-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9
                                                                             -RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16-RENT17-RENT18-RENT19-RENT20-RENT21-RENT22
                                                                             -RENT23-RENT24-RENT25-RENT26-RENT27-RENT28-RENT29) , 0) * (1 - V_CNR) ;

RENT31 = max(min((INVRETSVR * (1 - INDPLAF) + INVRETSVRA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RCOLENT-RENT1-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9
                                                                             -RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16-RENT17-RENT18-RENT19-RENT20-RENT21-RENT22
                                                                             -RENT23-RENT24-RENT25-RENT26-RENT27-RENT28-RENT29-RENT30) , 0) * (1 - V_CNR) ;

RENT32 = max(min((INVRETTAR * (1 - INDPLAF) + INVRETTARA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RCOLENT-RENT1-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9
                                                                             -RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16-RENT17-RENT18-RENT19-RENT20-RENT21-RENT22
                                                                             -RENT23-RENT24-RENT25-RENT26-RENT27-RENT28-RENT29-RENT30-RENT31) , 0) * (1 - V_CNR) ;

RENT33 = max(min((INVRETSKR * (1 - INDPLAF) + INVRETSKRA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RCOLENT-RENT1-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9
                                                                             -RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16-RENT17-RENT18-RENT19-RENT20-RENT21-RENT22
                                                                             -RENT23-RENT24-RENT25-RENT26-RENT27-RENT28-RENT29-RENT30-RENT31-RENT32) , 0) * (1 - V_CNR) ;

RENT34 = max(min((INVRETSPR * (1 - INDPLAF) + INVRETSPRA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RCOLENT-RENT1-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9
                                                                             -RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16-RENT17-RENT18-RENT19-RENT20-RENT21-RENT22
                                                                             -RENT23-RENT24-RENT25-RENT26-RENT27-RENT28-RENT29-RENT30-RENT31-RENT32-RENT33) , 0) * (1 - V_CNR) ;

RENT35 = max(min((INVRETSUR * (1 - INDPLAF) + INVRETSURA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RCOLENT-RENT1-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9
                                                                             -RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16-RENT17-RENT18-RENT19-RENT20-RENT21-RENT22
                                                                             -RENT23-RENT24-RENT25-RENT26-RENT27-RENT28-RENT29-RENT30-RENT31-RENT32-RENT33-RENT34) , 0) * (1 - V_CNR) ;

RENT36 = max(min((INVRETSZR * (1 - INDPLAF) + INVRETSZRA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RCOLENT-RENT1-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9
                                                                             -RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16-RENT17-RENT18-RENT19-RENT20-RENT21-RENT22
                                                                             -RENT23-RENT24-RENT25-RENT26-RENT27-RENT28-RENT29-RENT30-RENT31-RENT32-RENT33-RENT34-RENT35) , 0)
                                                                            * (1 - V_CNR) ;

RLOCENT_1 = ((1 - V_INDTEO) * (RENT1 + RENT2 + RENT3 + RENT4 + RENT5 + RENT6 + RENT7 + RENT8 + RENT9 + RENT10 + RENT11 + RENT12 + RENT13 + RENT14 + RENT15 + RENT16 
                               + RENT17 + RENT18 + RENT19 + RENT20 + RENT21 + RENT22 + RENT23 + RENT24 + RENT25 + RENT26 + RENT27 + RENT28 + RENT29 + RENT30 + RENT31
			       + RENT32 + RENT33 + RENT34 + RENT35 + RENT36) 
           + V_INDTEO * (
            arr((V_RENT7+V_RENT27)*(5263/10000))
           + arr((V_RENT1+V_RENT25)*(625/1000))
           + arr((V_RENT9+V_RENT33)*(5263/10000))
           + arr((V_RENT3+V_RENT29)*(625/1000))

           + arr((V_RENT8+V_RENT28)*(5263/10000))
           + arr((V_RENT2+V_RENT26)*(625/1000))
           + arr((V_RENT10+V_RENT34)*(5263/10000))
           + arr((V_RENT4+V_RENT30)*(625/1000))

	   + arr((V_RENT11 + V_RENT35)*(5263/10000))
	   + arr((V_RENT5 + V_RENT31)*(625/1000))

          + arr((V_RENT12+V_RENT36)*(5263/10000))
          + arr((V_RENT6+V_RENT32)*(625/1000))
                          )) * (1 - V_CNR) ;

RLOCENT = RLOCENT_1 * (1 - ART1731BIS) 
          + min(RLOCENT_1 , max(RLOCENT_P , RLOCENT1731 + 0)) * ART1731BIS ;

RIDOMENT = RLOCENT ;

regle 14085:
application : iliad, batch ;

INVRETQB = NINVRETQB * (1 - V_CNR) ; 

INVRETQC = NINVRETQC * (1 - V_CNR) ; 

INVRETQT = NINVRETQT * (1 - V_CNR) ; 

INVRETQL = min(NINVRETQL , max(0 , PLAF_INVDOM -INVRETSOC-INVRETENT)) * (1 - V_CNR) ;

INVRETQM = min(NINVRETQM , max(0 , PLAF_INVDOM -INVRETSOC-INVRETENT-INVRETQL)) * (1 - V_CNR) ;

INVRETQD = min(NINVRETQD , max(0 , PLAF_INVDOM -INVRETSOC-INVRETENT-INVRETQL-INVRETQM)) * (1 - V_CNR) ;

INVRETOB = min(NINVRETOB , max(0 , PLAF_INVDOM -INVRETSOC-INVRETENT-INVRETQL-INVRETQM-INVRETQD)) * (1 - V_CNR) ;

INVRETOC = min(NINVRETOC , max(0 , PLAF_INVDOM -INVRETSOC-INVRETENT-INVRETQL-INVRETQM-INVRETQD-INVRETOB)) * (1 - V_CNR) ;

INVRETOI = min(NINVRETOI , max(0 , PLAF_INVDOM3 -INVRETSOC-INVRETENT-INVRETQL-INVRETQM-INVRETQD-INVRETOB-INVRETOC)) * (1 - V_CNR) ;

INVRETOJ = min(NINVRETOJ , max(0 , PLAF_INVDOM3 -INVRETSOC-INVRETENT-INVRETQL-INVRETQM-INVRETQD-INVRETOB-INVRETOC-INVRETOI)) * (1 - V_CNR) ;

INVRETOK = min(NINVRETOK , max(0 , PLAF_INVDOM3 -INVRETSOC-INVRETENT-INVRETQL-INVRETQM-INVRETQD-INVRETOB-INVRETOC-INVRETOI-INVRETOJ)) * (1 - V_CNR) ;

INVRETOM = min(NINVRETOM , max(0 , PLAF_INVDOM -INVRETSOC-INVRETENT-INVRETQL-INVRETQM-INVRETQD-INVRETOB-INVRETOC-INVRETOI-INVRETOJ-INVRETOK)) * (1 - V_CNR) ;

INVRETON = min(NINVRETON , max(0 , PLAF_INVDOM -INVRETSOC-INVRETENT-INVRETQL-INVRETQM-INVRETQD-INVRETOB-INVRETOC-INVRETOI-INVRETOJ-INVRETOK-INVRETOM)) * (1 - V_CNR) ;

INVRETOP = min(NINVRETOP , max(0 , PLAF_INVDOM3 -INVRETSOC-INVRETENT-INVRETQL-INVRETQM-INVRETQD-INVRETOB-INVRETOC-INVRETOI-INVRETOJ-INVRETOK-INVRETOM
                                                -INVRETON)) * (1 - V_CNR) ;

INVRETOQ = min(NINVRETOQ , max(0 , PLAF_INVDOM3 -INVRETSOC-INVRETENT-INVRETQL-INVRETQM-INVRETQD-INVRETOB-INVRETOC-INVRETOI-INVRETOJ-INVRETOK-INVRETOM
                                                -INVRETON-INVRETOP)) * (1 - V_CNR) ;

INVRETOR = min(NINVRETOR , max(0 , PLAF_INVDOM3 -INVRETSOC-INVRETENT-INVRETQL-INVRETQM-INVRETQD-INVRETOB-INVRETOC-INVRETOI-INVRETOJ-INVRETOK-INVRETOM
                                                -INVRETON-INVRETOP-INVRETOQ)) * (1 - V_CNR) ;

INVRETOT = min(NINVRETOT , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETENT-INVRETQL-INVRETQM-INVRETQD-INVRETOB-INVRETOC-INVRETOI-INVRETOJ-INVRETOK-INVRETOM
                                                -INVRETON-INVRETOP-INVRETOQ-INVRETOR)) * (1 - V_CNR) ;

INVRETOU = min(NINVRETOU , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETENT-INVRETQL-INVRETQM-INVRETQD-INVRETOB-INVRETOC-INVRETOI-INVRETOJ-INVRETOK-INVRETOM
                                                -INVRETON-INVRETOP-INVRETOQ-INVRETOR-INVRETOT)) * (1 - V_CNR) ;

INVRETOV = min(NINVRETOV , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETENT-INVRETQL-INVRETQM-INVRETQD-INVRETOB-INVRETOC-INVRETOI-INVRETOJ-INVRETOK-INVRETOM
                                                -INVRETON-INVRETOP-INVRETOQ-INVRETOR-INVRETOT-INVRETOU)) * (1 - V_CNR) ;

INVRETOW = min(NINVRETOW , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETENT-INVRETQL-INVRETQM-INVRETQD-INVRETOB-INVRETOC-INVRETOI-INVRETOJ-INVRETOK-INVRETOM
                                                -INVRETON-INVRETOP-INVRETOQ-INVRETOR-INVRETOT-INVRETOU-INVRETOV)) * (1 - V_CNR) ;

INVRETOD = min(NINVRETOD , max(0 , PLAF_INVDOM -INVRETSOC-INVRETENT-INVRETQL-INVRETQM-INVRETQD-INVRETOB-INVRETOC-INVRETOI-INVRETOJ-INVRETOK-INVRETOM
                                               -INVRETON-INVRETOP-INVRETOQ-INVRETOR-INVRETOT-INVRETOU-INVRETOV-INVRETOW)) * (1 - V_CNR) ;

INVRETOE = min(NINVRETOE , max(0 , PLAF_INVDOM3 -INVRETSOC-INVRETENT-INVRETQL-INVRETQM-INVRETQD-INVRETOB-INVRETOC-INVRETOI-INVRETOJ-INVRETOK-INVRETOM
                                                -INVRETON-INVRETOP-INVRETOQ-INVRETOR-INVRETOT-INVRETOU-INVRETOV-INVRETOW-INVRETOD)) * (1 - V_CNR) ;

INVRETOF = min(NINVRETOF , max(0 , PLAF_INVDOM3 -INVRETSOC-INVRETENT-INVRETQL-INVRETQM-INVRETQD-INVRETOB-INVRETOC-INVRETOI-INVRETOJ-INVRETOK-INVRETOM
                                                -INVRETON-INVRETOP-INVRETOQ-INVRETOR-INVRETOT-INVRETOU-INVRETOV-INVRETOW-INVRETOD-INVRETOE)) * (1 - V_CNR) ;

INVRETOG = min(NINVRETOG , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETENT-INVRETQL-INVRETQM-INVRETQD-INVRETOB-INVRETOC-INVRETOI-INVRETOJ-INVRETOK-INVRETOM
                                                -INVRETON-INVRETOP-INVRETOQ-INVRETOR-INVRETOT-INVRETOU-INVRETOV-INVRETOW-INVRETOD-INVRETOE-INVRETOF)) * (1 - V_CNR) ;

INVRETOX = min(NINVRETOX , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETENT-INVRETQL-INVRETQM-INVRETQD-INVRETOB-INVRETOC-INVRETOI-INVRETOJ-INVRETOK-INVRETOM
                                                -INVRETON-INVRETOP-INVRETOQ-INVRETOR-INVRETOT-INVRETOU-INVRETOV-INVRETOW-INVRETOD-INVRETOE-INVRETOF
                                                -INVRETOG)) * (1 - V_CNR) ;

INVRETOY = min(NINVRETOY , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETENT-INVRETQL-INVRETQM-INVRETQD-INVRETOB-INVRETOC-INVRETOI-INVRETOJ-INVRETOK-INVRETOM
                                                -INVRETON-INVRETOP-INVRETOQ-INVRETOR-INVRETOT-INVRETOU-INVRETOV-INVRETOW-INVRETOD-INVRETOE-INVRETOF
                                                -INVRETOG-INVRETOX)) * (1 - V_CNR) ;

INVRETOZ = min(NINVRETOZ , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETENT-INVRETQL-INVRETQM-INVRETQD-INVRETOB-INVRETOC-INVRETOI-INVRETOJ-INVRETOK-INVRETOM
                                                -INVRETON-INVRETOP-INVRETOQ-INVRETOR-INVRETOT-INVRETOU-INVRETOV-INVRETOW-INVRETOD-INVRETOE-INVRETOF
                                                -INVRETOG-INVRETOX-INVRETOY)) * (1 - V_CNR) ;

INVRETLOG = INVRETQL + INVRETQM + INVRETQD + INVRETOB + INVRETOC + INVRETOI + INVRETOJ + INVRETOK + INVRETOM + INVRETON 
            + INVRETOP + INVRETOQ + INVRETOR + INVRETOT + INVRETOU + INVRETOV + INVRETOW + INVRETOD + INVRETOE + INVRETOF 
            + INVRETOG + INVRETOX + INVRETOY + INVRETOZ ;

regle 14086:
application : iliad, batch ;

RLOG1 = max(min(INVLOG2008 , RRI1) , 0) * (1 - V_CNR) ;

RLOG2 = max(min(INVLGDEB2009 , RRI1-RLOG1) , 0) * (1 - V_CNR) ;

RLOG3 = max(min(INVLGDEB , RRI1-RLOG1-RLOG2) , 0) * (1 - V_CNR) ;

RLOG4 = max(min(INVOMLOGOA , RRI1-RLOG1-RLOG2-RLOG3) , 0) * (1 - V_CNR) ;

RLOG5 = max(min(INVOMLOGOH , RRI1-RLOG1-RLOG2-RLOG3-RLOG4) , 0) * (1 - V_CNR) ;

RLOG6 = max(min(INVOMLOGOL , RRI1-RLOG1-RLOG2-RLOG3-RLOG4-RLOG5) , 0) * (1 - V_CNR) ;

RLOG7 = max(min(INVOMLOGOO , RRI1-RLOG1-RLOG2-RLOG3-RLOG4-RLOG5-RLOG6) , 0) * (1 - V_CNR) ;

RLOG8 = max(min(INVOMLOGOS , RRI1-RLOG1-RLOG2-RLOG3-RLOG4-RLOG5-RLOG6-RLOG7) , 0) * (1 - V_CNR) ;

RLOG9 = max(min((INVRETQL * (1 - INDPLAF) + INVRETQLA * INDPLAF) , RRI1-RLOG1-RLOG2-RLOG3-RLOG4-RLOG5-RLOG6-RLOG7-RLOG8) , 0) * (1 - V_CNR) ;

RLOG10 = max(min((INVRETQM * (1 - INDPLAF) + INVRETQMA * INDPLAF) , RRI1-RLOG1-RLOG2-RLOG3-RLOG4-RLOG5-RLOG6-RLOG7-RLOG8-RLOG9) , 0) * (1 - V_CNR) ;

RLOG11 = max(min((INVRETQD * (1 - INDPLAF) + INVRETQDA * INDPLAF) , RRI1-RLOG1-RLOG2-RLOG3-RLOG4-RLOG5-RLOG6-RLOG7-RLOG8-RLOG9-RLOG10) , 0) * (1 - V_CNR) ;

RLOG12 = max(min((INVRETOB * (1 - INDPLAF) + INVRETOBA * INDPLAF) , RRI1-RLOG1-RLOG2-RLOG3-RLOG4-RLOG5-RLOG6-RLOG7-RLOG8-RLOG9-RLOG10-RLOG11) , 0) * (1 - V_CNR) ;

RLOG13 = max(min((INVRETOC * (1 - INDPLAF) + INVRETOCA * INDPLAF) , RRI1-RLOG1-RLOG2-RLOG3-RLOG4-RLOG5-RLOG6-RLOG7-RLOG8-RLOG9-RLOG10-RLOG11-RLOG12) , 0) * (1 - V_CNR) ;

RLOG14 = max(min((INVRETOI * (1 - INDPLAF) + INVRETOIA * INDPLAF) , RRI1-RLOG1-RLOG2-RLOG3-RLOG4-RLOG5-RLOG6-RLOG7-RLOG8-RLOG9-RLOG10-RLOG11-RLOG12-RLOG13) , 0) 
							                * (1 - V_CNR) ;

RLOG15 = max(min((INVRETOJ * (1 - INDPLAF) + INVRETOJA * INDPLAF) , RRI1-RLOG1-RLOG2-RLOG3-RLOG4-RLOG5-RLOG6-RLOG7-RLOG8-RLOG9-RLOG10-RLOG11-RLOG12-RLOG13
							                -RLOG14) , 0) * (1 - V_CNR) ;

RLOG16 = max(min((INVRETOK * (1 - INDPLAF) + INVRETOKA * INDPLAF) , RRI1-RLOG1-RLOG2-RLOG3-RLOG4-RLOG5-RLOG6-RLOG7-RLOG8-RLOG9-RLOG10-RLOG11-RLOG12-RLOG13
							                -RLOG14-RLOG15) , 0) * (1 - V_CNR) ;
RLOG17 = max(min((INVRETOM * (1 - INDPLAF) + INVRETOMA * INDPLAF) , RRI1-RLOG1-RLOG2-RLOG3-RLOG4-RLOG5-RLOG6-RLOG7-RLOG8-RLOG9-RLOG10-RLOG11-RLOG12-RLOG13
							                -RLOG14-RLOG15-RLOG16) , 0) * (1 - V_CNR) ;

RLOG18 = max(min((INVRETON * (1 - INDPLAF) + INVRETONA * INDPLAF) , RRI1-RLOG1-RLOG2-RLOG3-RLOG4-RLOG5-RLOG6-RLOG7-RLOG8-RLOG9-RLOG10-RLOG11-RLOG12-RLOG13
							                -RLOG14-RLOG15-RLOG16-RLOG17) , 0) * (1 - V_CNR) ;
RLOG19 = max(min((INVRETOP * (1 - INDPLAF) + INVRETOPA * INDPLAF) , RRI1-RLOG1-RLOG2-RLOG3-RLOG4-RLOG5-RLOG6-RLOG7-RLOG8-RLOG9-RLOG10-RLOG11-RLOG12-RLOG13
							                -RLOG14-RLOG15-RLOG16-RLOG17-RLOG18) , 0) * (1 - V_CNR) ;

RLOG20 = max(min((INVRETOQ * (1 - INDPLAF) + INVRETOQA * INDPLAF) , RRI1-RLOG1-RLOG2-RLOG3-RLOG4-RLOG5-RLOG6-RLOG7-RLOG8-RLOG9-RLOG10-RLOG11-RLOG12-RLOG13
							                -RLOG14-RLOG15-RLOG16-RLOG17-RLOG18-RLOG19) , 0) * (1 - V_CNR) ;

RLOG21 = max(min((INVRETOR * (1 - INDPLAF) + INVRETORA * INDPLAF) , RRI1-RLOG1-RLOG2-RLOG3-RLOG4-RLOG5-RLOG6-RLOG7-RLOG8-RLOG9-RLOG10-RLOG11-RLOG12-RLOG13
							                -RLOG14-RLOG15-RLOG16-RLOG17-RLOG18-RLOG19-RLOG20) , 0) * (1 - V_CNR) ;
RLOG22 = max(min((INVRETOT * (1 - INDPLAF) + INVRETOTA * INDPLAF) , RRI1-RLOG1-RLOG2-RLOG3-RLOG4-RLOG5-RLOG6-RLOG7-RLOG8-RLOG9-RLOG10-RLOG11-RLOG12-RLOG13
							                -RLOG14-RLOG15-RLOG16-RLOG17-RLOG18-RLOG19-RLOG20-RLOG21) , 0) * (1 - V_CNR) ;

RLOG23 = max(min((INVRETOU * (1 - INDPLAF) + INVRETOUA * INDPLAF) , RRI1-RLOG1-RLOG2-RLOG3-RLOG4-RLOG5-RLOG6-RLOG7-RLOG8-RLOG9-RLOG10-RLOG11-RLOG12-RLOG13
							                -RLOG14-RLOG15-RLOG16-RLOG17-RLOG18-RLOG19-RLOG20-RLOG21-RLOG22) , 0) * (1 - V_CNR) ;

RLOG24 = max(min((INVRETOV * (1 - INDPLAF) + INVRETOVA * INDPLAF) , RRI1-RLOG1-RLOG2-RLOG3-RLOG4-RLOG5-RLOG6-RLOG7-RLOG8-RLOG9-RLOG10-RLOG11-RLOG12-RLOG13
							                -RLOG14-RLOG15-RLOG16-RLOG17-RLOG18-RLOG19-RLOG20-RLOG21-RLOG22-RLOG23) , 0) * (1 - V_CNR) ;

RLOG25 = max(min((INVRETOW * (1 - INDPLAF) + INVRETOWA * INDPLAF) , RRI1-RLOG1-RLOG2-RLOG3-RLOG4-RLOG5-RLOG6-RLOG7-RLOG8-RLOG9-RLOG10-RLOG11-RLOG12-RLOG13
							                -RLOG14-RLOG15-RLOG16-RLOG17-RLOG18-RLOG19-RLOG20-RLOG21-RLOG22-RLOG23-RLOG24) , 0) * (1 - V_CNR) ;

RLOG26 = max(min((INVRETOD * (1 - INDPLAF) + INVRETODA * INDPLAF) , RRI1-RLOG1-RLOG2-RLOG3-RLOG4-RLOG5-RLOG6-RLOG7-RLOG8-RLOG9-RLOG10-RLOG11-RLOG12-RLOG13
							                -RLOG14-RLOG15-RLOG16-RLOG17-RLOG18-RLOG19-RLOG20-RLOG21-RLOG22-RLOG23-RLOG24-RLOG25) , 0) * (1 - V_CNR) ;

RLOG27 = max(min((INVRETOE * (1 - INDPLAF) + INVRETOEA * INDPLAF) , RRI1-RLOG1-RLOG2-RLOG3-RLOG4-RLOG5-RLOG6-RLOG7-RLOG8-RLOG9-RLOG10-RLOG11-RLOG12-RLOG13
							                -RLOG14-RLOG15-RLOG16-RLOG17-RLOG18-RLOG19-RLOG20-RLOG21-RLOG22-RLOG23-RLOG24-RLOG25
                                                                        -RLOG26) , 0) * (1 - V_CNR) ;

RLOG28 = max(min((INVRETOF * (1 - INDPLAF) + INVRETOFA * INDPLAF) , RRI1-RLOG1-RLOG2-RLOG3-RLOG4-RLOG5-RLOG6-RLOG7-RLOG8-RLOG9-RLOG10-RLOG11-RLOG12-RLOG13
							                -RLOG14-RLOG15-RLOG16-RLOG17-RLOG18-RLOG19-RLOG20-RLOG21-RLOG22-RLOG23-RLOG24-RLOG25
                                                                        -RLOG26-RLOG27) , 0) * (1 - V_CNR) ;

RLOG29 = max(min((INVRETOG * (1 - INDPLAF) + INVRETOGA * INDPLAF) , RRI1-RLOG1-RLOG2-RLOG3-RLOG4-RLOG5-RLOG6-RLOG7-RLOG8-RLOG9-RLOG10-RLOG11-RLOG12-RLOG13
							                -RLOG14-RLOG15-RLOG16-RLOG17-RLOG18-RLOG19-RLOG20-RLOG21-RLOG22-RLOG23-RLOG24-RLOG25
                                                                        -RLOG26-RLOG27-RLOG28) , 0) * (1 - V_CNR) ;

RLOG30 = max(min((INVRETOX * (1 - INDPLAF) + INVRETOXA * INDPLAF) , RRI1-RLOG1-RLOG2-RLOG3-RLOG4-RLOG5-RLOG6-RLOG7-RLOG8-RLOG9-RLOG10-RLOG11-RLOG12-RLOG13
							                -RLOG14-RLOG15-RLOG16-RLOG17-RLOG18-RLOG19-RLOG20-RLOG21-RLOG22-RLOG23-RLOG24-RLOG25
                                                                        -RLOG26-RLOG27-RLOG28-RLOG29) , 0) * (1 - V_CNR) ;

RLOG31 = max(min((INVRETOY * (1 - INDPLAF) + INVRETOYA * INDPLAF) , RRI1-RLOG1-RLOG2-RLOG3-RLOG4-RLOG5-RLOG6-RLOG7-RLOG8-RLOG9-RLOG10-RLOG11-RLOG12-RLOG13
							                -RLOG14-RLOG15-RLOG16-RLOG17-RLOG18-RLOG19-RLOG20-RLOG21-RLOG22-RLOG23-RLOG24-RLOG25
                                                                        -RLOG26-RLOG27-RLOG28-RLOG29-RLOG30) , 0) * (1 - V_CNR) ;

RLOG32 = max(min((INVRETOZ * (1 - INDPLAF) + INVRETOZA * INDPLAF) , RRI1-RLOG1-RLOG2-RLOG3-RLOG4-RLOG5-RLOG6-RLOG7-RLOG8-RLOG9-RLOG10-RLOG11-RLOG12-RLOG13
							                -RLOG14-RLOG15-RLOG16-RLOG17-RLOG18-RLOG19-RLOG20-RLOG21-RLOG22-RLOG23-RLOG24-RLOG25
                                                                        -RLOG26-RLOG27-RLOG28-RLOG29-RLOG30-RLOG31) , 0) * (1 - V_CNR) ;

RLOGDOM_1 = (1 - V_INDTEO) * (RLOG1 + RLOG2 + RLOG3 + RLOG4 + RLOG5 + RLOG6 + RLOG7 + RLOG8 + RLOG9 + RLOG10 + RLOG11 + RLOG12 + RLOG13 + RLOG14 + RLOG15 + RLOG16
			      + RLOG17 + RLOG18 + RLOG19 + RLOG20 + RLOG21 + RLOG22 + RLOG23 + RLOG24 + RLOG25 + RLOG26 + RLOG27 + RLOG28 + RLOG29 + RLOG30 + RLOG31
                              + RLOG32) * (1 - V_CNR) 

         + V_INDTEO * (RLOG1 + RLOG2 + RLOG3 + RLOG4 + RLOG5 + RLOG6 + RLOG7 + RLOG8) * (1 - V_CNR) ;

RLOGDOM = RLOGDOM_1 * (1-ART1731BIS) 
          + min( RLOGDOM_1 , max(RLOGDOM_P, RLOGDOM1731+0 )) * ART1731BIS ;

RINVDOMTOMLG = RLOGDOM ;

regle 4087:
application : iliad, batch ;
RLOC1 = max(min(INVOMREP , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT) , 0) * (1 - V_CNR) ;

RLOC2 = max(min((INVRETMA * (1 - INDPLAF) + INVRETMAA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1) , 0) * (1 - V_CNR) ;

RLOC3 = max(min((INVRETLG * (1 - INDPLAF) + INVRETLGA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2) , 0) * (1 - V_CNR) ;

RLOC4 = max(min((INVRETKS * (1 - INDPLAF) + INVRETKSA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3) , 0) * (1 - V_CNR) ;

RLOC5 = max(min((INVRETMAR * (1 - INDPLAF) + INVRETMARA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4) , 0) * (1 - V_CNR) ;

RLOC6 = max(min((INVRETLGR * (1 - INDPLAF) + INVRETLGRA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5) , 0) * (1 - V_CNR) ;

RLOC7 = max(min(INVOMENTMN , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6) , 0) * (1 - V_CNR) ;

RLOC8 = max(min((INVRETMB * (1 - INDPLAF) + INVRETMBA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7) , 0) * (1 - V_CNR) ;

RLOC9 = max(min((INVRETMC * (1 - INDPLAF) + INVRETMCA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8) , 0) * (1 - V_CNR) ;

RLOC10 = max(min((INVRETLH * (1 - INDPLAF) + INVRETLHA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9) , 0) * (1 - V_CNR) ;

RLOC11 = max(min((INVRETLI * (1 - INDPLAF) + INVRETLIA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10) , 0) * (1 - V_CNR) ;

RLOC12 = max(min((INVRETKT * (1 - INDPLAF) + INVRETKTA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10-RLOC11) , 0) * (1 - V_CNR) ;

RLOC13 = max(min((INVRETKU * (1 - INDPLAF) + INVRETKUA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10-RLOC11-RLOC12) , 0) * (1 - V_CNR) ;

RLOC14 = max(min((INVRETMBR * (1 - INDPLAF) + INVRETMBRA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                             -RLOC10-RLOC11-RLOC12-RLOC13) , 0) * (1 - V_CNR) ;

RLOC15 = max(min((INVRETMCR * (1 - INDPLAF) + INVRETMCRA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                             -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14) , 0) * (1 - V_CNR) ;

RLOC16 = max(min((INVRETLHR * (1 - INDPLAF) + INVRETLHRA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                             -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15) , 0) * (1 - V_CNR) ;

RLOC17 = max(min((INVRETLIR * (1 - INDPLAF) + INVRETLIRA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                             -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16) , 0) * (1 - V_CNR) ;

RLOC18 = max(min(INVOMQV , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                  -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17) , 0) * (1 - V_CNR) ;

RLOC19 = max(min(INVENDEB2009 , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                       -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18) , 0) * (1 - V_CNR) ;

RLOC20 = max(min((INVRETQP * (1 - INDPLAF) + INVRETQPA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19) , 0) * (1 - V_CNR) ;

RLOC21 = max(min((INVRETQG * (1 - INDPLAF) + INVRETQGA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20) , 0) * (1 - V_CNR) ;

RLOC22 = max(min((INVRETPB * (1 - INDPLAF) + INVRETPBA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21) , 0) * (1 - V_CNR) ;

RLOC23 = max(min((INVRETPF * (1 - INDPLAF) + INVRETPFA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                           -RLOC22) , 0) * (1 - V_CNR) ;

RLOC24 = max(min((INVRETPJ * (1 - INDPLAF) + INVRETPJA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                           -RLOC22-RLOC23) , 0) * (1 - V_CNR) ;

RLOC25 = max(min((INVRETQO * (1 - INDPLAF) + INVRETQOA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                           -RLOC22-RLOC23-RLOC24) , 0) * (1 - V_CNR) ;

RLOC26 = max(min((INVRETQF * (1 - INDPLAF) + INVRETQFA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                           -RLOC22-RLOC23-RLOC24-RLOC25) , 0) * (1 - V_CNR) ;

RLOC27 = max(min((INVRETPA * (1 - INDPLAF) + INVRETPAA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                           -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26) , 0) * (1 - V_CNR) ;

RLOC28 = max(min((INVRETPE * (1 - INDPLAF) + INVRETPEA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                           -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27) , 0) * (1 - V_CNR) ;

RLOC29 = max(min((INVRETPI * (1 - INDPLAF) + INVRETPIA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                           -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28) , 0) * (1 - V_CNR) ;

RLOC30 = max(min((INVRETQR * (1 - INDPLAF) + INVRETQRA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                           -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29) , 0) * (1 - V_CNR) ;

RLOC31 = max(min((INVRETQI * (1 - INDPLAF) + INVRETQIA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                           -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30) , 0) * (1 - V_CNR) ;

RLOC32 = max(min((INVRETPD * (1 - INDPLAF) + INVRETPDA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                           -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31) , 0) * (1 - V_CNR) ;

RLOC33 = max(min((INVRETPH * (1 - INDPLAF) + INVRETPHA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                           -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32) , 0) * (1 - V_CNR) ;

RLOC34 = max(min((INVRETPL * (1 - INDPLAF) + INVRETPLA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                           -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33) , 0) * (1 - V_CNR) ;

RLOC35 = max(min((INVRETQPR * (1 - INDPLAF) + INVRETQPRA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                             -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                             -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                             -RLOC34) , 0) * (1 - V_CNR) ;

RLOC36 = max(min((INVRETQGR * (1 - INDPLAF) + INVRETQGRA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                             -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                             -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                             -RLOC34-RLOC35) , 0) * (1 - V_CNR) ;

RLOC37 = max(min((INVRETPBR * (1 - INDPLAF) + INVRETPBRA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                             -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                             -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                             -RLOC34-RLOC35-RLOC36) , 0) * (1 - V_CNR) ;

RLOC38 = max(min((INVRETPFR * (1 - INDPLAF) + INVRETPFRA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                             -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                             -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                             -RLOC34-RLOC35-RLOC36-RLOC37) , 0) * (1 - V_CNR) ;

RLOC39 = max(min((INVRETPJR * (1 - INDPLAF) + INVRETPJRA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                             -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                             -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                             -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38) , 0) * (1 - V_CNR) ;

RLOC40 = max(min((INVRETQOR * (1 - INDPLAF) + INVRETQORA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                             -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                             -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                             -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39) , 0) * (1 - V_CNR) ;

RLOC41 = max(min((INVRETQFR * (1 - INDPLAF) + INVRETQFRA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                             -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                             -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                             -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40) , 0) * (1 - V_CNR) ;

RLOC42 = max(min((INVRETPAR * (1 - INDPLAF) + INVRETPARA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                             -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                             -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                             -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41) , 0) * (1 - V_CNR) ;

RLOC43 = max(min((INVRETPER * (1 - INDPLAF) + INVRETPERA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                             -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                             -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                             -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42) , 0) * (1 - V_CNR) ;

RLOC44 = max(min((INVRETPIR * (1 - INDPLAF) + INVRETPIRA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                             -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                             -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                             -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42-RLOC43) , 0) * (1 - V_CNR) ;

RLOC45 = max(min(INVOMRETPM , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                     -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                     -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                     -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42-RLOC43-RLOC44) , 0) * (1 - V_CNR) ;

RLOC46 = max(min(INVOMENTRJ , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                     -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                     -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                     -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42-RLOC43-RLOC44-RLOC45) , 0) * (1 - V_CNR) ;

RLOC47 = max(min((INVRETPO * (1 - INDPLAF) + INVRETPOA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                           -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                           -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42-RLOC43-RLOC44-RLOC45
                                                                           -RLOC46) , 0) * (1 - V_CNR) ;

RLOC48 = max(min((INVRETPT * (1 - INDPLAF) + INVRETPTA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                           -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                           -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42-RLOC43-RLOC44-RLOC45
                                                                           -RLOC46-RLOC47) , 0) * (1 - V_CNR) ;

RLOC49 = max(min((INVRETPY * (1 - INDPLAF) + INVRETPYA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                           -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                           -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42-RLOC43-RLOC44-RLOC45
                                                                           -RLOC46-RLOC47-RLOC48) , 0) * (1 - V_CNR) ;

RLOC50 = max(min((INVRETRL * (1 - INDPLAF) + INVRETRLA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                           -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                           -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42-RLOC43-RLOC44-RLOC45
                                                                           -RLOC46-RLOC47-RLOC48-RLOC49) , 0) * (1 - V_CNR) ;

RLOC51 = max(min((INVRETRQ * (1 - INDPLAF) + INVRETRQA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                           -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                           -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42-RLOC43-RLOC44-RLOC45
                                                                           -RLOC46-RLOC47-RLOC48-RLOC49-RLOC50) , 0) * (1 - V_CNR) ;

RLOC52 = max(min((INVRETRV * (1 - INDPLAF) + INVRETRVA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                           -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                           -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42-RLOC43-RLOC44-RLOC45
                                                                           -RLOC46-RLOC47-RLOC48-RLOC49-RLOC50-RLOC51) , 0) * (1 - V_CNR) ;

RLOC53 = max(min((INVRETNV * (1 - INDPLAF) + INVRETNVA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                           -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                           -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42-RLOC43-RLOC44-RLOC45
                                                                           -RLOC46-RLOC47-RLOC48-RLOC49-RLOC50-RLOC51-RLOC52) , 0) * (1 - V_CNR) ;

RLOC54 = max(min((INVRETPN * (1 - INDPLAF) + INVRETPNA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                           -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                           -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42-RLOC43-RLOC44-RLOC45
                                                                           -RLOC46-RLOC47-RLOC48-RLOC49-RLOC50-RLOC51-RLOC52-RLOC53) , 0) * (1 - V_CNR) ;

RLOC55 = max(min((INVRETPS * (1 - INDPLAF) + INVRETPSA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                           -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                           -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42-RLOC43-RLOC44-RLOC45
                                                                           -RLOC46-RLOC47-RLOC48-RLOC49-RLOC50-RLOC51-RLOC52-RLOC53-RLOC54) , 0) * (1 - V_CNR) ;

RLOC56 = max(min((INVRETPX * (1 - INDPLAF) + INVRETPXA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                           -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                           -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42-RLOC43-RLOC44-RLOC45
                                                                           -RLOC46-RLOC47-RLOC48-RLOC49-RLOC50-RLOC51-RLOC52-RLOC53-RLOC54-RLOC55) , 0) * (1 - V_CNR) ;

RLOC57 = max(min((INVRETRK * (1 - INDPLAF) + INVRETRKA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                           -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                           -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42-RLOC43-RLOC44-RLOC45
                                                                           -RLOC46-RLOC47-RLOC48-RLOC49-RLOC50-RLOC51-RLOC52-RLOC53-RLOC54-RLOC55-RLOC56) , 0) * (1 - V_CNR) ;

RLOC58 = max(min((INVRETRP * (1 - INDPLAF) + INVRETRPA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                           -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                           -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42-RLOC43-RLOC44-RLOC45
                                                                           -RLOC46-RLOC47-RLOC48-RLOC49-RLOC50-RLOC51-RLOC52-RLOC53-RLOC54-RLOC55-RLOC56-RLOC57) , 0) * (1 - V_CNR) ;

RLOC59 = max(min((INVRETRU * (1 - INDPLAF) + INVRETRUA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                           -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                           -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42-RLOC43-RLOC44-RLOC45
                                                                           -RLOC46-RLOC47-RLOC48-RLOC49-RLOC50-RLOC51-RLOC52-RLOC53-RLOC54-RLOC55-RLOC56-RLOC57
                                                                           -RLOC58) , 0) * (1 - V_CNR) ;

RLOC60 = max(min((INVRETNU * (1 - INDPLAF) + INVRETNUA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                           -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                           -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42-RLOC43-RLOC44-RLOC45
                                                                           -RLOC46-RLOC47-RLOC48-RLOC49-RLOC50-RLOC51-RLOC52-RLOC53-RLOC54-RLOC55-RLOC56-RLOC57
                                                                           -RLOC58-RLOC59) , 0) * (1 - V_CNR) ;

RLOC61 = max(min((INVRETPP * (1 - INDPLAF) + INVRETPPA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                           -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                           -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42-RLOC43-RLOC44-RLOC45
                                                                           -RLOC46-RLOC47-RLOC48-RLOC49-RLOC50-RLOC51-RLOC52-RLOC53-RLOC54-RLOC55-RLOC56-RLOC57
                                                                           -RLOC58-RLOC59-RLOC60) , 0) * (1 - V_CNR) ;

RLOC62 = max(min((INVRETPU * (1 - INDPLAF) + INVRETPUA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                           -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                           -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42-RLOC43-RLOC44-RLOC45
                                                                           -RLOC46-RLOC47-RLOC48-RLOC49-RLOC50-RLOC51-RLOC52-RLOC53-RLOC54-RLOC55-RLOC56-RLOC57
                                                                           -RLOC58-RLOC59-RLOC60-RLOC61) , 0) * (1 - V_CNR) ;

RLOC63 = max(min((INVRETRG * (1 - INDPLAF) + INVRETRGA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                           -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                           -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42-RLOC43-RLOC44-RLOC45
                                                                           -RLOC46-RLOC47-RLOC48-RLOC49-RLOC50-RLOC51-RLOC52-RLOC53-RLOC54-RLOC55-RLOC56-RLOC57
                                                                           -RLOC58-RLOC59-RLOC60-RLOC61-RLOC62) , 0) * (1 - V_CNR) ;

RLOC64 = max(min((INVRETRM * (1 - INDPLAF) + INVRETRMA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                           -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                           -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42-RLOC43-RLOC44-RLOC45
                                                                           -RLOC46-RLOC47-RLOC48-RLOC49-RLOC50-RLOC51-RLOC52-RLOC53-RLOC54-RLOC55-RLOC56-RLOC57
                                                                           -RLOC58-RLOC59-RLOC60-RLOC61-RLOC62-RLOC63) , 0) * (1 - V_CNR) ;

RLOC65 = max(min((INVRETRR * (1 - INDPLAF) + INVRETRRA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                           -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                           -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42-RLOC43-RLOC44-RLOC45
                                                                           -RLOC46-RLOC47-RLOC48-RLOC49-RLOC50-RLOC51-RLOC52-RLOC53-RLOC54-RLOC55-RLOC56-RLOC57
                                                                           -RLOC58-RLOC59-RLOC60-RLOC61-RLOC62-RLOC63-RLOC64) , 0) * (1 - V_CNR) ;

RLOC66 = max(min((INVRETRW * (1 - INDPLAF) + INVRETRWA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                           -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                           -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42-RLOC43-RLOC44-RLOC45
                                                                           -RLOC46-RLOC47-RLOC48-RLOC49-RLOC50-RLOC51-RLOC52-RLOC53-RLOC54-RLOC55-RLOC56-RLOC57
                                                                           -RLOC58-RLOC59-RLOC60-RLOC61-RLOC62-RLOC63-RLOC64-RLOC65) , 0) * (1 - V_CNR) ;

RLOC67 = max(min((INVRETNW * (1 - INDPLAF) + INVRETNWA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                           -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                           -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42-RLOC43-RLOC44-RLOC45
                                                                           -RLOC46-RLOC47-RLOC48-RLOC49-RLOC50-RLOC51-RLOC52-RLOC53-RLOC54-RLOC55-RLOC56-RLOC57
                                                                           -RLOC58-RLOC59-RLOC60-RLOC61-RLOC62-RLOC63-RLOC64-RLOC65-RLOC66) , 0) * (1 - V_CNR) ;

RLOC68 = max(min((INVRETPR * (1 - INDPLAF) + INVRETPRA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                           -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                           -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42-RLOC43-RLOC44-RLOC45
                                                                           -RLOC46-RLOC47-RLOC48-RLOC49-RLOC50-RLOC51-RLOC52-RLOC53-RLOC54-RLOC55-RLOC56-RLOC57
                                                                           -RLOC58-RLOC59-RLOC60-RLOC61-RLOC62-RLOC63-RLOC64-RLOC65-RLOC66-RLOC67) , 0) * (1 - V_CNR) ;

RLOC69 = max(min((INVRETPW * (1 - INDPLAF) + INVRETPWA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                           -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                           -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42-RLOC43-RLOC44-RLOC45
                                                                           -RLOC46-RLOC47-RLOC48-RLOC49-RLOC50-RLOC51-RLOC52-RLOC53-RLOC54-RLOC55-RLOC56-RLOC57
                                                                           -RLOC58-RLOC59-RLOC60-RLOC61-RLOC62-RLOC63-RLOC64-RLOC65-RLOC66-RLOC67-RLOC68) , 0) * (1 - V_CNR) ;

RLOC70 = max(min((INVRETRI * (1 - INDPLAF) + INVRETRIA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                           -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                           -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42-RLOC43-RLOC44-RLOC45
                                                                           -RLOC46-RLOC47-RLOC48-RLOC49-RLOC50-RLOC51-RLOC52-RLOC53-RLOC54-RLOC55-RLOC56-RLOC57
                                                                           -RLOC58-RLOC59-RLOC60-RLOC61-RLOC62-RLOC63-RLOC64-RLOC65-RLOC66-RLOC67-RLOC68-RLOC69) , 0) * (1 - V_CNR) ;

RLOC71 = max(min((INVRETRO * (1 - INDPLAF) + INVRETROA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                           -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                           -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42-RLOC43-RLOC44-RLOC45
                                                                           -RLOC46-RLOC47-RLOC48-RLOC49-RLOC50-RLOC51-RLOC52-RLOC53-RLOC54-RLOC55-RLOC56-RLOC57
                                                                           -RLOC58-RLOC59-RLOC60-RLOC61-RLOC62-RLOC63-RLOC64-RLOC65-RLOC66-RLOC67-RLOC68-RLOC69
                                                                           -RLOC70) , 0) * (1 - V_CNR) ;

RLOC72 = max(min((INVRETRT * (1 - INDPLAF) + INVRETRTA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                           -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                           -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42-RLOC43-RLOC44-RLOC45
                                                                           -RLOC46-RLOC47-RLOC48-RLOC49-RLOC50-RLOC51-RLOC52-RLOC53-RLOC54-RLOC55-RLOC56-RLOC57
                                                                           -RLOC58-RLOC59-RLOC60-RLOC61-RLOC62-RLOC63-RLOC64-RLOC65-RLOC66-RLOC67-RLOC68-RLOC69
                                                                           -RLOC70-RLOC71) , 0) * (1 - V_CNR) ;

RLOC73 = max(min((INVRETRY * (1 - INDPLAF) + INVRETRYA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                           -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                           -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42-RLOC43-RLOC44-RLOC45
                                                                           -RLOC46-RLOC47-RLOC48-RLOC49-RLOC50-RLOC51-RLOC52-RLOC53-RLOC54-RLOC55-RLOC56-RLOC57
                                                                           -RLOC58-RLOC59-RLOC60-RLOC61-RLOC62-RLOC63-RLOC64-RLOC65-RLOC66-RLOC67-RLOC68-RLOC69
                                                                           -RLOC70-RLOC71-RLOC72) , 0) * (1 - V_CNR) ;

RLOC74 = max(min((INVRETNY * (1 - INDPLAF) + INVRETNYA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                           -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                           -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                           -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42-RLOC43-RLOC44-RLOC45
                                                                           -RLOC46-RLOC47-RLOC48-RLOC49-RLOC50-RLOC51-RLOC52-RLOC53-RLOC54-RLOC55-RLOC56-RLOC57
                                                                           -RLOC58-RLOC59-RLOC60-RLOC61-RLOC62-RLOC63-RLOC64-RLOC65-RLOC66-RLOC67-RLOC68-RLOC69
                                                                           -RLOC70-RLOC71-RLOC72-RLOC73) , 0) * (1 - V_CNR) ;

RLOC75 = max(min((INVRETPOR * (1 - INDPLAF) + INVRETPORA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                             -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                             -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                             -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42-RLOC43-RLOC44-RLOC45
                                                                             -RLOC46-RLOC47-RLOC48-RLOC49-RLOC50-RLOC51-RLOC52-RLOC53-RLOC54-RLOC55-RLOC56-RLOC57
                                                                             -RLOC58-RLOC59-RLOC60-RLOC61-RLOC62-RLOC63-RLOC64-RLOC65-RLOC66-RLOC67-RLOC68-RLOC69
                                                                             -RLOC70-RLOC71-RLOC72-RLOC73-RLOC74) , 0) * (1 - V_CNR) ;

RLOC76 = max(min((INVRETPTR * (1 - INDPLAF) + INVRETPTRA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                             -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                             -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                             -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42-RLOC43-RLOC44-RLOC45
                                                                             -RLOC46-RLOC47-RLOC48-RLOC49-RLOC50-RLOC51-RLOC52-RLOC53-RLOC54-RLOC55-RLOC56-RLOC57
                                                                             -RLOC58-RLOC59-RLOC60-RLOC61-RLOC62-RLOC63-RLOC64-RLOC65-RLOC66-RLOC67-RLOC68-RLOC69
                                                                             -RLOC70-RLOC71-RLOC72-RLOC73-RLOC74-RLOC75) , 0) * (1 - V_CNR) ;

RLOC77 = max(min((INVRETPYR * (1 - INDPLAF) + INVRETPYRA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                             -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                             -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                             -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42-RLOC43-RLOC44-RLOC45
                                                                             -RLOC46-RLOC47-RLOC48-RLOC49-RLOC50-RLOC51-RLOC52-RLOC53-RLOC54-RLOC55-RLOC56-RLOC57
                                                                             -RLOC58-RLOC59-RLOC60-RLOC61-RLOC62-RLOC63-RLOC64-RLOC65-RLOC66-RLOC67-RLOC68-RLOC69
                                                                             -RLOC70-RLOC71-RLOC72-RLOC73-RLOC74-RLOC75-RLOC76) , 0) * (1 - V_CNR) ;

RLOC78 = max(min((INVRETRLR * (1 - INDPLAF) + INVRETRLRA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                             -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                             -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                             -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42-RLOC43-RLOC44-RLOC45
                                                                             -RLOC46-RLOC47-RLOC48-RLOC49-RLOC50-RLOC51-RLOC52-RLOC53-RLOC54-RLOC55-RLOC56-RLOC57
                                                                             -RLOC58-RLOC59-RLOC60-RLOC61-RLOC62-RLOC63-RLOC64-RLOC65-RLOC66-RLOC67-RLOC68-RLOC69
                                                                             -RLOC70-RLOC71-RLOC72-RLOC73-RLOC74-RLOC75-RLOC76-RLOC77) , 0) * (1 - V_CNR) ;

RLOC79 = max(min((INVRETRQR * (1 - INDPLAF) + INVRETRQRA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                             -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                             -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                             -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42-RLOC43-RLOC44-RLOC45
                                                                             -RLOC46-RLOC47-RLOC48-RLOC49-RLOC50-RLOC51-RLOC52-RLOC53-RLOC54-RLOC55-RLOC56-RLOC57
                                                                             -RLOC58-RLOC59-RLOC60-RLOC61-RLOC62-RLOC63-RLOC64-RLOC65-RLOC66-RLOC67-RLOC68-RLOC69
                                                                             -RLOC70-RLOC71-RLOC72-RLOC73-RLOC74-RLOC75-RLOC76-RLOC77-RLOC78) , 0) * (1 - V_CNR) ;

RLOC80 = max(min((INVRETRVR * (1 - INDPLAF) + INVRETRVRA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                             -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                             -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                             -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42-RLOC43-RLOC44-RLOC45
                                                                             -RLOC46-RLOC47-RLOC48-RLOC49-RLOC50-RLOC51-RLOC52-RLOC53-RLOC54-RLOC55-RLOC56-RLOC57
                                                                             -RLOC58-RLOC59-RLOC60-RLOC61-RLOC62-RLOC63-RLOC64-RLOC65-RLOC66-RLOC67-RLOC68-RLOC69
                                                                             -RLOC70-RLOC71-RLOC72-RLOC73-RLOC74-RLOC75-RLOC76-RLOC77-RLOC78-RLOC79) , 0) * (1 - V_CNR) ;

RLOC81 = max(min((INVRETNVR * (1 - INDPLAF) + INVRETNVRA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                             -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                             -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                             -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42-RLOC43-RLOC44-RLOC45
                                                                             -RLOC46-RLOC47-RLOC48-RLOC49-RLOC50-RLOC51-RLOC52-RLOC53-RLOC54-RLOC55-RLOC56-RLOC57
                                                                             -RLOC58-RLOC59-RLOC60-RLOC61-RLOC62-RLOC63-RLOC64-RLOC65-RLOC66-RLOC67-RLOC68-RLOC69
                                                                             -RLOC70-RLOC71-RLOC72-RLOC73-RLOC74-RLOC75-RLOC76-RLOC77-RLOC78-RLOC79-RLOC80) , 0) * (1 - V_CNR) ;

RLOC82 = max(min((INVRETPNR * (1 - INDPLAF) + INVRETPNRA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                             -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                             -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                             -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42-RLOC43-RLOC44-RLOC45
                                                                             -RLOC46-RLOC47-RLOC48-RLOC49-RLOC50-RLOC51-RLOC52-RLOC53-RLOC54-RLOC55-RLOC56-RLOC57
                                                                             -RLOC58-RLOC59-RLOC60-RLOC61-RLOC62-RLOC63-RLOC64-RLOC65-RLOC66-RLOC67-RLOC68-RLOC69
                                                                             -RLOC70-RLOC71-RLOC72-RLOC73-RLOC74-RLOC75-RLOC76-RLOC77-RLOC78-RLOC79-RLOC80-RLOC81) , 0) * (1 - V_CNR) ;

RLOC83 = max(min((INVRETPSR * (1 - INDPLAF) + INVRETPSRA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                             -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                             -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                             -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42-RLOC43-RLOC44-RLOC45
                                                                             -RLOC46-RLOC47-RLOC48-RLOC49-RLOC50-RLOC51-RLOC52-RLOC53-RLOC54-RLOC55-RLOC56-RLOC57
                                                                             -RLOC58-RLOC59-RLOC60-RLOC61-RLOC62-RLOC63-RLOC64-RLOC65-RLOC66-RLOC67-RLOC68-RLOC69
                                                                             -RLOC70-RLOC71-RLOC72-RLOC73-RLOC74-RLOC75-RLOC76-RLOC77-RLOC78-RLOC79-RLOC80-RLOC81
                                                                             -RLOC82) , 0) * (1 - V_CNR) ;

RLOC84 = max(min((INVRETPXR * (1 - INDPLAF) + INVRETPXRA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                             -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                             -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                             -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42-RLOC43-RLOC44-RLOC45
                                                                             -RLOC46-RLOC47-RLOC48-RLOC49-RLOC50-RLOC51-RLOC52-RLOC53-RLOC54-RLOC55-RLOC56-RLOC57
                                                                             -RLOC58-RLOC59-RLOC60-RLOC61-RLOC62-RLOC63-RLOC64-RLOC65-RLOC66-RLOC67-RLOC68-RLOC69
                                                                             -RLOC70-RLOC71-RLOC72-RLOC73-RLOC74-RLOC75-RLOC76-RLOC77-RLOC78-RLOC79-RLOC80-RLOC81
                                                                             -RLOC82-RLOC83) , 0) * (1 - V_CNR) ;

RLOC85 = max(min((INVRETRKR * (1 - INDPLAF) + INVRETRKRA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                             -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                             -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                             -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42-RLOC43-RLOC44-RLOC45
                                                                             -RLOC46-RLOC47-RLOC48-RLOC49-RLOC50-RLOC51-RLOC52-RLOC53-RLOC54-RLOC55-RLOC56-RLOC57
                                                                             -RLOC58-RLOC59-RLOC60-RLOC61-RLOC62-RLOC63-RLOC64-RLOC65-RLOC66-RLOC67-RLOC68-RLOC69
                                                                             -RLOC70-RLOC71-RLOC72-RLOC73-RLOC74-RLOC75-RLOC76-RLOC77-RLOC78-RLOC79-RLOC80-RLOC81
                                                                             -RLOC82-RLOC83-RLOC84) , 0) * (1 - V_CNR) ;

RLOC86 = max(min((INVRETRPR * (1 - INDPLAF) + INVRETRPRA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                             -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                             -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                             -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42-RLOC43-RLOC44-RLOC45
                                                                             -RLOC46-RLOC47-RLOC48-RLOC49-RLOC50-RLOC51-RLOC52-RLOC53-RLOC54-RLOC55-RLOC56-RLOC57
                                                                             -RLOC58-RLOC59-RLOC60-RLOC61-RLOC62-RLOC63-RLOC64-RLOC65-RLOC66-RLOC67-RLOC68-RLOC69
                                                                             -RLOC70-RLOC71-RLOC72-RLOC73-RLOC74-RLOC75-RLOC76-RLOC77-RLOC78-RLOC79-RLOC80-RLOC81
                                                                             -RLOC82-RLOC83-RLOC84-RLOC85) , 0) * (1 - V_CNR) ;

RLOC87 = max(min((INVRETRUR * (1 - INDPLAF) + INVRETRURA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                             -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                             -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                             -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42-RLOC43-RLOC44-RLOC45
                                                                             -RLOC46-RLOC47-RLOC48-RLOC49-RLOC50-RLOC51-RLOC52-RLOC53-RLOC54-RLOC55-RLOC56-RLOC57
                                                                             -RLOC58-RLOC59-RLOC60-RLOC61-RLOC62-RLOC63-RLOC64-RLOC65-RLOC66-RLOC67-RLOC68-RLOC69
                                                                             -RLOC70-RLOC71-RLOC72-RLOC73-RLOC74-RLOC75-RLOC76-RLOC77-RLOC78-RLOC79-RLOC80-RLOC81
                                                                             -RLOC82-RLOC83-RLOC84-RLOC85-RLOC86) , 0) * (1 - V_CNR) ;

RLOC88 = max(min((INVRETNUR * (1 - INDPLAF) + INVRETNURA * INDPLAF) , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9
                                                                             -RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18-RLOC19-RLOC20-RLOC21
                                                                             -RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29-RLOC30-RLOC31-RLOC32-RLOC33
                                                                             -RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42-RLOC43-RLOC44-RLOC45
                                                                             -RLOC46-RLOC47-RLOC48-RLOC49-RLOC50-RLOC51-RLOC52-RLOC53-RLOC54-RLOC55-RLOC56-RLOC57
                                                                             -RLOC58-RLOC59-RLOC60-RLOC61-RLOC62-RLOC63-RLOC64-RLOC65-RLOC66-RLOC67-RLOC68-RLOC69
                                                                             -RLOC70-RLOC71-RLOC72-RLOC73-RLOC74-RLOC75-RLOC76-RLOC77-RLOC78-RLOC79-RLOC80-RLOC81
                                                                             -RLOC82-RLOC83-RLOC84-RLOC85-RLOC86-RLOC87) , 0) * (1 - V_CNR) ;

RCOLENT_1 = ((1-V_INDTEO) * (RLOC1 + RLOC2 + RLOC3 + RLOC4 + RLOC5 + RLOC6 + RLOC7 + RLOC8 + RLOC9 + RLOC10 + RLOC11 + RLOC12 + RLOC13 + RLOC14 + RLOC15 
			   + RLOC16 + RLOC17 + RLOC18 + RLOC19 + RLOC20 + RLOC21 + RLOC22 + RLOC23 + RLOC24 + RLOC25 + RLOC26 + RLOC27 + RLOC28 + RLOC29 
			   + RLOC30 + RLOC31 + RLOC32 + RLOC33 + RLOC34 + RLOC35 + RLOC36 + RLOC37 + RLOC38 + RLOC39 + RLOC40 + RLOC41 + RLOC42 + RLOC43 
                           + RLOC44 + RLOC45 + RLOC46 + RLOC47 + RLOC48 + RLOC49 + RLOC50 + RLOC51 + RLOC52 + RLOC53 + RLOC54 + RLOC55 + RLOC56 + RLOC57
                           + RLOC58 + RLOC59 + RLOC60 + RLOC61 + RLOC62 + RLOC63 + RLOC64 + RLOC65 + RLOC66 + RLOC67 + RLOC68 + RLOC69 + RLOC70 + RLOC71
                           + RLOC72 + RLOC73 + RLOC74 + RLOC75 + RLOC76 + RLOC77 + RLOC78 + RLOC79 + RLOC80 + RLOC81 + RLOC82 + RLOC83 + RLOC84 + RLOC85
                           + RLOC86 + RLOC87 + RLOC88)
          + (V_INDTEO) * (RLOC1 + RLOC7 + RLOC18 + RLOC19 +RLOC45 + RLOC46
                        + arr((V_RLOC3+V_RLOC6)*(TX50/100)) 
	                + arr((V_RLOC2+V_RLOC5)*(TX60/100)) 
                        + arr((V_RLOC10+V_RLOC16)*(TX50/100))
			+ arr((V_RLOC8+V_RLOC14)*(TX60/100))
			+ arr((V_RLOC25+V_RLOC40)*(TX60/100))
			+ arr((V_RLOC20+V_RLOC35)*(TX60/100))
			+ arr((V_RLOC54+V_RLOC82)*(TX50/100))
			+ arr((V_RLOC47+V_RLOC75)*(TX60/100))
			+ arr((V_RLOC27+V_RLOC42)*(5263/10000))
			+ arr((V_RLOC22+V_RLOC37)*(625/1000))
			+ arr((V_RLOC57+V_RLOC85)*(5263/10000))
			+ arr((V_RLOC50+V_RLOC78)*(625/1000))

			+ arr((V_RLOC11+V_RLOC17)*(TX50/100))
			+ arr((V_RLOC9+V_RLOC15)*(60/100))
			+ arr((V_RLOC26+V_RLOC41)*(50/100))
			+ arr((V_RLOC21+V_RLOC36)*(60/100))
			+ arr((V_RLOC55+V_RLOC83)*(50/100))
			+ arr((V_RLOC48+V_RLOC76)*(60/100))
			+ arr((V_RLOC28+V_RLOC43)*(5263/10000))
			+ arr((V_RLOC23+V_RLOC38)*(625/1000))
			+ arr((V_RLOC58+V_RLOC86)*(5263/10000))
			+ arr((V_RLOC51+V_RLOC79)*(625/1000))

			+ arr((V_RLOC29+V_RLOC44)*(5263/10000))
			+ arr((V_RLOC24+V_RLOC39)*(625/1000))
                        + arr((V_RLOC56+V_RLOC84)*(5263/10000))
                        + arr((V_RLOC49+V_RLOC77)*(625/1000))
                        + arr((V_RLOC59+V_RLOC87)*(5263/10000))
                        + arr((V_RLOC52+V_RLOC80)*(625/1000))

                        + arr((V_RLOC60+V_RLOC88)*(5263/10000))
                        + arr((V_RLOC53+V_RLOC81)*(625/1000))
			
			)) * (1 - V_CNR) ;

RCOLENT = RCOLENT_1 * (1-ART1731BIS) 
          + min( RCOLENT_1 , max(RCOLENT_P , RCOLENT1731+0 )) * ART1731BIS ;

regle 4086:
application : iliad, batch ;


RRIREP = RRI1 - DLOGDOM - RTOURES - RTOURREP - RTOUHOTR - RTOUREPA - RCOMP - RCREAT - RRETU 
              - RDONS - RCELTOT - RLOCNPRO - RDUFLOGIH - RNOUV - RFOR - RPATNATOT ;

REPKG = ( max(0 , INVSOCNRET - max(0 , RRIREP)) * (1-ART1731BIS) 
                                   + INVSOCNRET * ART1731BIS 
        ) * (1 - V_CNR) ;

REPDOMSOC4 = REPKG * (1 - V_CNR) ;


REPKH = ( max(0 , INVOMSOCKH - max(0 , RRIREP -INVSOCNRET)) * (1-ART1731BIS)
                                               + INVOMSOCKH * ART1731BIS  
        ) * (1 - V_CNR) ;

REPKI = ( max(0 , INVOMSOCKI - max(0 , RRIREP -INVSOCNRET-INVOMSOCKH)) * (1-ART1731BIS)
                                                          + INVOMSOCKI * ART1731BIS  
        ) * (1 - V_CNR) ;
                                                               
REPDOMSOC3 = (REPKH + REPKI) * (1 - V_CNR) ;


REPQN = ( max(0 , INVSOC2010 - max(0 , RRIREP -INVSOCNRET-INVOMSOCKH-INVOMSOCKI)) * (1-ART1731BIS)
                                                                     + INVSOC2010 * ART1731BIS  
        ) * (1 - V_CNR) ;

REPQU = (max(0 , INVOMSOCQU - max(0 , RRIREP -INVSOCNRET-INVOMSOCKH-INVOMSOCKI-INVSOC2010)) * (1-ART1731BIS)
                                                                               + INVOMSOCQU * ART1731BIS  
        ) * (1 - V_CNR) ;

REPQK = (max(0 , INVLOGSOC - max(0 , RRIREP -INVSOCNRET-INVOMSOCKH-INVOMSOCKI-INVSOC2010-INVOMSOCQU)) * (1-ART1731BIS)
                                                                                          + INVLOGSOC * ART1731BIS  
        ) * (1 - V_CNR) ;


REPDOMSOC2 = (REPQN + REPQU + REPQK) * (1 - V_CNR) ;


REPQJ = (max(0 , INVOMSOCQJ - max(0 , RRIREP -INVSOCNRET-INVOMSOCKH-INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC)) * (1-ART1731BIS)
                                                                                                    + INVOMSOCQJ * ART1731BIS  
        ) * (1 - V_CNR) ;

REPQS = (max(0 , INVOMSOCQS - max(0 , RRIREP -INVSOCNRET-INVOMSOCKH-INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-INVOMSOCQJ)) * (1-ART1731BIS)
                                                                                                               + INVOMSOCQS * ART1731BIS
        ) * (1 - V_CNR) ;

REPQW = (max(0 , INVOMSOCQW - max(0 , RRIREP -INVSOCNRET-INVOMSOCKH-INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-INVOMSOCQJ-INVOMSOCQS)) * (1-ART1731BIS) 
                                                                                                                          + INVOMSOCQW * ART1731BIS
        ) * (1 - V_CNR) ;

REPQX = (max(0 , INVOMSOCQX - max(0 , RRIREP -INVSOCNRET-INVOMSOCKH-INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW)) * (1-ART1731BIS)
                                                                                                                                     + INVOMSOCQX * ART1731BIS
        ) * (1 - V_CNR) ;

REPDOMSOC1 = (REPQJ + REPQS + REPQW + REPQX) * (1 - V_CNR) ;


REPRA = (max(0 , CODHRA - max(0 , RRIREP -INVSOCNRET-INVOMSOCKH-INVOMSOCKI-INVSOC2010-INVOMSOCQU
                                        -INVLOGSOC-INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX)) * (1-ART1731BIS)
                                                                                       + CODHRA * ART1731BIS
        ) * (1 - V_CNR) ;

REPRB = (max(0 , CODHRB - max(0 , RRIREP -INVSOCNRET-INVOMSOCKH-INVOMSOCKI-INVSOC2010-INVOMSOCQU
                                        -INVLOGSOC-INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-CODHRA)) * (1-ART1731BIS)
                                                                                               + CODHRB * ART1731BIS
        ) * (1 - V_CNR) ;

REPRC = (max(0 , CODHRC - max(0 , RRIREP -INVSOCNRET-INVOMSOCKH-INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC
                                         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-CODHRA-CODHRB)) * (1-ART1731BIS)
                                                                                             + CODHRC * ART1731BIS
        ) * (1 - V_CNR) ;


REPRD = (max(0 , CODHRD - max(0 , RRIREP -INVSOCNRET-INVOMSOCKH-INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC
                                         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-CODHRA-CODHRB-CODHRC)) * (1-ART1731BIS)
                                                                                                    + CODHRD * ART1731BIS
        ) * (1 - V_CNR) ;

REPDOMSOC = (REPRA + REPRB + REPRC + REPRD) * (1 - V_CNR) ;

REPSOC = INVSOCNRET + INVOMSOCKH + INVOMSOCKI + INVSOC2010 + INVOMSOCQU + INVLOGSOC + INVOMSOCQJ
          + INVOMSOCQS + INVOMSOCQW + INVOMSOCQX + CODHRA + CODHRB + CODHRC + CODHRD ;


REPMM = (max(0 , INVOMREP - max(0 , RRIREP -REPSOC-RIDOMPROTOT)) * (1-ART1731BIS) 
                                                      + INVOMREP * ART1731BIS
        ) * (1 - V_CNR) ;

REPMA = (max(0 , NRETROC40 - max(0 , RRIREP -REPSOC-RIDOMPROTOT-INVOMREP)) * (1-ART1731BIS)
                                                               + NRETROC40 * ART1731BIS
        ) * (1 - V_CNR) ;

REPLG = (max(0 , NRETROC50 - max(0 , RRIREP -REPSOC-RIDOMPROTOT-INVOMREP-NRETROC40)) * (1-ART1731BIS)
                                                                         + NRETROC50 * ART1731BIS
        ) * (1 - V_CNR) ;

REPKS = (max(0 , INVENDI - max(0 , RRIREP -REPSOC-RIDOMPROTOT-INVOMREP-NRETROC40-NRETROC50)) * (1-ART1731BIS)
                                                                                   + INVENDI * ART1731BIS
        )  * (1 - V_CNR) ;

REPDOMENTR4 = REPMM + REPMA + REPLG + REPKS ;

REPENT4 = INVOMREP + NRETROC40 + NRETROC50 + INVENDI ;


REPMN = (max(0 , INVOMENTMN - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4)) * (1-ART1731BIS)
                                                              + INVOMENTMN * ART1731BIS
        ) * (1 - V_CNR) ;

REPMB = (max(0 , RETROCOMMB - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-INVOMENTMN)) * (1-ART1731BIS)
                                                                         + RETROCOMMB * ART1731BIS 
        ) * (1 - V_CNR) ;


REPMC = (max(0 , RETROCOMMC - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-INVOMENTMN-RETROCOMMB)) * (1-ART1731BIS)
                                                                                    + RETROCOMMC * ART1731BIS
        ) * (1 - V_CNR) ;

REPLH = (max(0 , RETROCOMLH - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-INVOMENTMN-RETROCOMMB-RETROCOMMC)) * (1-ART1731BIS)  
                                                                                               + RETROCOMLH * ART1731BIS
        ) * (1 - V_CNR) ;

REPLI = (max(0 , RETROCOMLI - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-INVOMENTMN
                                             -RETROCOMMB-RETROCOMMC-RETROCOMLH)) * (1-ART1731BIS)
                                                                    + RETROCOMLI * ART1731BIS 
        ) * (1 - V_CNR) ;

REPKT = (max(0 , INVOMENTKT - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-INVOMENTMN
                                             -RETROCOMMB-RETROCOMMC-RETROCOMLH-RETROCOMLI)) * (1-ART1731BIS)
                                                                               + INVOMENTKT * ART1731BIS
        ) * (1 - V_CNR) ;

REPKU = (max(0 , INVOMENTKU - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-INVOMENTMN-RETROCOMMB
                                             -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT)) * (1-ART1731BIS) 
                                                                               + INVOMENTKU * ART1731BIS
        ) * (1 - V_CNR) ;

REPDOMENTR3 = REPMN + REPMB + REPMC + REPLH + REPLI + REPKT + REPKU ;

REPENT3 = INVOMENTMN + RETROCOMMB + RETROCOMMC + RETROCOMLH + RETROCOMLI + INVOMENTKT + INVOMENTKU ;


REPQV = (max(0 , INVOMQV - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3)) * (1-ART1731BIS)
                                                                      + INVOMQV * ART1731BIS
        ) * (1 - V_CNR) ;

REPQE = (max(0 , INVENDEB2009 - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-INVOMQV)) * (1-ART1731BIS)
                                                                              + INVENDEB2009 * ART1731BIS 
        ) * (1 - V_CNR) ;

REPQP = (max(0 , INVRETRO2 - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-INVOMQV-INVENDEB2009)) * (1-ART1731BIS)
                                                                                           + INVRETRO2 * ART1731BIS
        ) * (1 - V_CNR) ;

REPQG = (max(0 , INVDOMRET60 - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-INVOMQV-INVENDEB2009-INVRETRO2)) * (1-ART1731BIS)
                                                                                                    + INVDOMRET60 * ART1731BIS 
        ) * (1 - V_CNR) ;

REPPB = (max(0 , INVOMRETPB - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-INVOMQV-INVENDEB2009-INVRETRO2-INVDOMRET60)) * (1-ART1731BIS)
                                                                                                                 + INVOMRETPB * ART1731BIS
        ) * (1 - V_CNR) ;

REPPF = (max(0 , INVOMRETPF - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-INVOMQV
                                             -INVENDEB2009-INVRETRO2-INVDOMRET60-INVOMRETPB)) * (1-ART1731BIS)
                                                                                + INVOMRETPF * ART1731BIS
        ) * (1 - V_CNR) ;

REPPJ = (max(0 , INVOMRETPJ - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-INVOMQV
                                             -INVENDEB2009-INVRETRO2-INVDOMRET60-INVOMRETPB-INVOMRETPF)) * (1-ART1731BIS)
                                                                                            + INVOMRETPJ * ART1731BIS
        ) * (1 - V_CNR) ;

REPQO = (max(0 , INVRETRO1 - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-INVOMQV-INVENDEB2009
                                            -INVRETRO2-INVDOMRET60-INVOMRETPB-INVOMRETPF-INVOMRETPJ)) * (1-ART1731BIS)
                                                                                          + INVRETRO1 * ART1731BIS
        ) * (1 - V_CNR) ;

REPQF = (max(0 , INVDOMRET50 - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-INVOMQV-INVENDEB2009
                                              -INVRETRO2-INVDOMRET60-INVOMRETPB-INVOMRETPF-INVOMRETPJ-INVRETRO1)) * (1-ART1731BIS)
                                                                                                    + INVDOMRET50 * ART1731BIS
        ) * (1 - V_CNR) ;

REPPA = (max(0 , INVOMRETPA - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-INVOMQV-INVENDEB2009-INVRETRO2
                                             -INVDOMRET60-INVOMRETPB-INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50)) * (1-ART1731BIS)
                                                                                                      + INVOMRETPA * ART1731BIS
        ) * (1 - V_CNR) ;

REPPE = (max(0 , INVOMRETPE - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-INVOMQV-INVENDEB2009-INVRETRO2
                                             -INVDOMRET60-INVOMRETPB-INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50
                                             -INVOMRETPA)) * (1-ART1731BIS)
                                              + INVOMRETPE * ART1731BIS
        ) * (1 - V_CNR) ;

REPPI = (max(0 , INVOMRETPI - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-INVOMQV-INVENDEB2009-INVRETRO2
                                             -INVDOMRET60-INVOMRETPB-INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50
                                             -INVOMRETPA-INVOMRETPE)) * (1-ART1731BIS)
                                                         + INVOMRETPI * ART1731BIS
        ) * (1 - V_CNR) ;

REPQR = (max(0 , INVIMP - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-INVOMQV-INVENDEB2009-INVRETRO2
                                         -INVDOMRET60-INVOMRETPB-INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50
                                         -INVOMRETPA-INVOMRETPE-INVOMRETPI)) * (1-ART1731BIS)
                                                                    + INVIMP * ART1731BIS
        ) * (1 - V_CNR) ;

REPQI = (max(0 , INVDIR2009 - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-INVOMQV-INVENDEB2009-INVRETRO2
                                             -INVDOMRET60-INVOMRETPB-INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50
                                             -INVOMRETPA-INVOMRETPE-INVOMRETPI-INVIMP)) * (1-ART1731BIS)
                                                                           + INVDIR2009 * ART1731BIS
        ) * (1 - V_CNR) ;

REPPD = (max(0 , INVOMRETPD - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-INVOMQV-INVENDEB2009-INVRETRO2
                                             -INVDOMRET60-INVOMRETPB-INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50
                                             -INVOMRETPA-INVOMRETPE-INVOMRETPI-INVIMP-INVDIR2009)) * (1-ART1731BIS)
                                                                                      + INVOMRETPD * ART1731BIS
        ) * (1 - V_CNR) ;

REPPH = (max(0 , INVOMRETPH - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-INVOMQV-INVENDEB2009-INVRETRO2
                                            -INVDOMRET60-INVOMRETPB-INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50
                                            -INVOMRETPA-INVOMRETPE-INVOMRETPI-INVIMP-INVDIR2009-INVOMRETPD)) * (1-ART1731BIS)
                                                                                                + INVOMRETPH * ART1731BIS
        ) * (1 - V_CNR) ;

REPPL = (max(0 , INVOMRETPL - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-INVOMQV-INVENDEB2009-INVRETRO2
                                             -INVDOMRET60-INVOMRETPB-INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50
                                             -INVOMRETPA-INVOMRETPE-INVOMRETPI-INVIMP-INVDIR2009-INVOMRETPD-INVOMRETPH)) * (1-ART1731BIS)
                                                                                                            + INVOMRETPL * ART1731BIS
        ) * (1 - V_CNR) ;


REPDOMENTR2 = REPQE + REPQV + REPQP + REPQG + REPQO + REPQF + REPQR + REPQI + REPPB + REPPF + REPPJ + REPPA + REPPE + REPPI + REPPD + REPPH + REPPL ;

REPENT2 = INVOMQV + INVENDEB2009 + INVRETRO2 + INVDOMRET60 + INVOMRETPB + INVOMRETPF + INVOMRETPJ + INVRETRO1 + INVDOMRET50 
          + INVOMRETPA + INVOMRETPE + INVOMRETPI + INVIMP + INVDIR2009 + INVOMRETPD + INVOMRETPH + INVOMRETPL ;


REPPM = (max(0 , INVOMRETPM - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2)) * (1-ART1731BIS)
                                                                              + INVOMRETPM * ART1731BIS
        ) * (1 - V_CNR) ;

REPRJ = (max(0 , INVOMENTRJ - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2
                                             -INVOMRETPM)) * (1-ART1731BIS)
                                              + INVOMENTRJ * ART1731BIS 
        ) * (1 - V_CNR) ;

REPPO = (max(0 , INVOMRETPO - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2
                                             -INVOMRETPM-INVOMENTRJ)) * (1-ART1731BIS)
                                                         + INVOMRETPO * ART1731BIS
        ) * (1 - V_CNR) ;

REPPT = (max(0 , INVOMRETPT - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2
                                             -INVOMRETPM-INVOMENTRJ-INVOMRETPO)) * (1-ART1731BIS)
                                                                    + INVOMRETPT * ART1731BIS
        ) * (1 - V_CNR) ;

REPPY = (max(0 , INVOMRETPY - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2
                                             -INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT)) * (1-ART1731BIS)
                                                                                + INVOMRETPY * ART1731BIS
         ) * (1 - V_CNR) ;

REPRL = (max(0 , INVOMENTRL - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2
                                             -INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY)) * (1-ART1731BIS)
                                                                                          + INVOMENTRL * ART1731BIS
        ) * (1 - V_CNR) ;

REPRQ = (max(0 , INVOMENTRQ - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2
                                             -INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL)) * (1-ART1731BIS)
                                                                                                     + INVOMENTRQ * ART1731BIS
        ) * (1 - V_CNR) ;

REPRV = (max(0 , INVOMENTRV - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-INVOMRETPM
                                             -INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL
                                             -INVOMENTRQ)) * (1-ART1731BIS)
                                              + INVOMENTRV * ART1731BIS
        ) * (1 - V_CNR) ;

REPNV = (max(0 , INVOMENTNV - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-INVOMRETPM
                                             -INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL
                                             -INVOMENTRQ-INVOMENTRV)) * (1-ART1731BIS)
                                                         + INVOMENTNV * ART1731BIS
        ) * (1 - V_CNR) ;

REPPN = (max(0 , INVOMRETPN - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-INVOMRETPM
                                             -INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL
                                             -INVOMENTRQ-INVOMENTRV-INVOMENTNV)) * (1-ART1731BIS)
                                                                    + INVOMRETPN * ART1731BIS
        ) * (1 - V_CNR) ;

REPPS = (max(0 , INVOMRETPS - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-INVOMRETPM
                                             -INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL
                                             -INVOMENTRQ-INVOMENTRV-INVOMENTNV-INVOMRETPN)) * (1-ART1731BIS)
                                                                               + INVOMRETPS * ART1731BIS
        ) * (1 - V_CNR) ;

REPPX = (max(0 , INVOMRETPX - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-INVOMRETPM
                                             -INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL
                                             -INVOMENTRQ-INVOMENTRV-INVOMENTNV-INVOMRETPN-INVOMRETPS)) * (1-ART1731BIS)
                                                                                          + INVOMRETPX * ART1731BIS
        ) * (1 - V_CNR) ;

REPRK = (max(0 , INVOMENTRK - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-INVOMRETPM
                                             -INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL
                                             -INVOMENTRQ-INVOMENTRV-INVOMENTNV-INVOMRETPN-INVOMRETPS
                                             -INVOMRETPX)) * (1-ART1731BIS)
                                              + INVOMENTRK * ART1731BIS
        ) * (1 - V_CNR) ;

REPRP = (max(0 , INVOMENTRP - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-INVOMRETPM
                                             -INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL
                                             -INVOMENTRQ-INVOMENTRV-INVOMENTNV-INVOMRETPN-INVOMRETPS
                                             -INVOMRETPX-INVOMENTRK)) * (1-ART1731BIS)
                                                         + INVOMENTRP * ART1731BIS
        ) * (1 - V_CNR) ;

REPRU = (max(0 , INVOMENTRU - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-INVOMRETPM
                                             -INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL
                                             -INVOMENTRQ-INVOMENTRV-INVOMENTNV-INVOMRETPN-INVOMRETPS
                                             -INVOMRETPX-INVOMENTRK-INVOMENTRP)) * (1-ART1731BIS)
                                                                    + INVOMENTRU * ART1731BIS 
        ) * (1 - V_CNR) ;

REPNU = (max(0 , INVOMENTNU - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-INVOMRETPM
                                             -INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL
                                             -INVOMENTRQ-INVOMENTRV-INVOMENTNV-INVOMRETPN-INVOMRETPS
                                             -INVOMRETPX-INVOMENTRK-INVOMENTRP-INVOMENTRU)) * (1-ART1731BIS)
                                                                               + INVOMENTNU * ART1731BIS
        ) * (1 - V_CNR) ;

REPPP = (max(0 , INVOMRETPP - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-INVOMRETPM
                                             -INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL
                                             -INVOMENTRQ-INVOMENTRV-INVOMENTNV-INVOMRETPN-INVOMRETPS
                                             -INVOMRETPX-INVOMENTRK-INVOMENTRP-INVOMENTRU-INVOMENTNU)) * (1-ART1731BIS)
                                                                                          + INVOMRETPP * ART1731BIS
        ) * (1 - V_CNR) ;

REPPU = (max(0 , INVOMRETPU - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-INVOMRETPM
                                             -INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL
                                             -INVOMENTRQ-INVOMENTRV-INVOMENTNV-INVOMRETPN-INVOMRETPS
                                             -INVOMRETPX-INVOMENTRK-INVOMENTRP-INVOMENTRU-INVOMENTNU
                                             -INVOMRETPP)) * (1-ART1731BIS)
                                              + INVOMRETPU * ART1731BIS
        ) * (1 - V_CNR) ;

REPRG = (max(0 , INVOMENTRG - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-INVOMRETPM
                                             -INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL
                                             -INVOMENTRQ-INVOMENTRV-INVOMENTNV-INVOMRETPN-INVOMRETPS
                                             -INVOMRETPX-INVOMENTRK-INVOMENTRP-INVOMENTRU-INVOMENTNU
                                             -INVOMRETPP-INVOMRETPU)) * (1-ART1731BIS)
                                                         + INVOMENTRG * ART1731BIS
        )* (1 - V_CNR) ;

REPRM = (max(0 , INVOMENTRM - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-INVOMRETPM
                                             -INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL
                                             -INVOMENTRQ-INVOMENTRV-INVOMENTNV-INVOMRETPN-INVOMRETPS
                                             -INVOMRETPX-INVOMENTRK-INVOMENTRP-INVOMENTRU-INVOMENTNU
                                             -INVOMRETPP-INVOMRETPU-INVOMENTRG)) * (1-ART1731BIS)
                                                                    + INVOMENTRM * ART1731BIS
        ) * (1 - V_CNR) ;

REPRR = (max(0 , INVOMENTRR - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-INVOMRETPM
                                             -INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL
                                             -INVOMENTRQ-INVOMENTRV-INVOMENTNV-INVOMRETPN-INVOMRETPS
                                             -INVOMRETPX-INVOMENTRK-INVOMENTRP-INVOMENTRU-INVOMENTNU
                                             -INVOMRETPP-INVOMRETPU-INVOMENTRG-INVOMENTRM)) * (1-ART1731BIS)
                                                                               + INVOMENTRR * ART1731BIS
        ) * (1 - V_CNR) ;

REPRW = (max(0 , INVOMENTRW - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-INVOMRETPM
                                             -INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL
                                             -INVOMENTRQ-INVOMENTRV-INVOMENTNV-INVOMRETPN-INVOMRETPS
                                             -INVOMRETPX-INVOMENTRK-INVOMENTRP-INVOMENTRU-INVOMENTNU
                                             -INVOMRETPP-INVOMRETPU-INVOMENTRG-INVOMENTRM-INVOMENTRR)) * (1-ART1731BIS)
                                                                                          + INVOMENTRW * ART1731BIS
        ) * (1 - V_CNR) ;

REPNW = (max(0 , INVOMENTNW - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-INVOMRETPM
                                             -INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL
                                             -INVOMENTRQ-INVOMENTRV-INVOMENTNV-INVOMRETPN-INVOMRETPS
                                             -INVOMRETPX-INVOMENTRK-INVOMENTRP-INVOMENTRU-INVOMENTNU
                                             -INVOMRETPP-INVOMRETPU-INVOMENTRG-INVOMENTRM-INVOMENTRR
                                             -INVOMENTRW)) * (1-ART1731BIS)
                                              + INVOMENTNW * ART1731BIS
        ) * (1 - V_CNR) ;

REPPR = (max(0 , INVOMRETPR - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-INVOMRETPM
                                             -INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL
                                             -INVOMENTRQ-INVOMENTRV-INVOMENTNV-INVOMRETPN-INVOMRETPS
                                             -INVOMRETPX-INVOMENTRK-INVOMENTRP-INVOMENTRU-INVOMENTNU
                                             -INVOMRETPP-INVOMRETPU-INVOMENTRG-INVOMENTRM-INVOMENTRR
                                             -INVOMENTRW-INVOMENTNW)) * (1-ART1731BIS)
                                                         + INVOMRETPR * ART1731BIS
        )* (1 - V_CNR) ;

REPPW = (max(0 , INVOMRETPW - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-INVOMRETPM
                                             -INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL
                                             -INVOMENTRQ-INVOMENTRV-INVOMENTNV-INVOMRETPN-INVOMRETPS
                                             -INVOMRETPX-INVOMENTRK-INVOMENTRP-INVOMENTRU-INVOMENTNU
                                             -INVOMRETPP-INVOMRETPU-INVOMENTRG-INVOMENTRM-INVOMENTRR
                                             -INVOMENTRW-INVOMENTNW-INVOMRETPR)) * (1-ART1731BIS)
                                                                    + INVOMRETPW * ART1731BIS
        ) * (1 - V_CNR) ;

REPRI = (max(0 , INVOMENTRI - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-INVOMRETPM
                                             -INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL
                                             -INVOMENTRQ-INVOMENTRV-INVOMENTNV-INVOMRETPN-INVOMRETPS
                                             -INVOMRETPX-INVOMENTRK-INVOMENTRP-INVOMENTRU-INVOMENTNU
                                             -INVOMRETPP-INVOMRETPU-INVOMENTRG-INVOMENTRM-INVOMENTRR
                                             -INVOMENTRW-INVOMENTNW-INVOMRETPR-INVOMRETPW)) * (1-ART1731BIS)
                                                                               + INVOMENTRI * ART1731BIS
        ) * (1 - V_CNR) ;

REPRO = (max(0 , INVOMENTRO - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-INVOMRETPM
                                             -INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL
                                             -INVOMENTRQ-INVOMENTRV-INVOMENTNV-INVOMRETPN-INVOMRETPS
                                             -INVOMRETPX-INVOMENTRK-INVOMENTRP-INVOMENTRU-INVOMENTNU
                                             -INVOMRETPP-INVOMRETPU-INVOMENTRG-INVOMENTRM-INVOMENTRR
                                             -INVOMENTRW-INVOMENTNW-INVOMRETPR-INVOMRETPW-INVOMENTRI)) * (1-ART1731BIS)
                                                                                          + INVOMENTRO * ART1731BIS
        ) * (1 - V_CNR) ;

REPRT = (max(0 , INVOMENTRT - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-INVOMRETPM
                                             -INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL
                                             -INVOMENTRQ-INVOMENTRV-INVOMENTNV-INVOMRETPN-INVOMRETPS
                                             -INVOMRETPX-INVOMENTRK-INVOMENTRP-INVOMENTRU-INVOMENTNU
                                             -INVOMRETPP-INVOMRETPU-INVOMENTRG-INVOMENTRM-INVOMENTRR
                                             -INVOMENTRW-INVOMENTNW-INVOMRETPR-INVOMRETPW-INVOMENTRI
                                             -INVOMENTRO)) * (1-ART1731BIS)
                                              + INVOMENTRT * ART1731BIS
         ) * (1 - V_CNR) ;

REPRY = (max(0 , INVOMENTRY - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-INVOMRETPM
                                             -INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL
                                             -INVOMENTRQ-INVOMENTRV-INVOMENTNV-INVOMRETPN-INVOMRETPS
                                             -INVOMRETPX-INVOMENTRK-INVOMENTRP-INVOMENTRU-INVOMENTNU
                                             -INVOMRETPP-INVOMRETPU-INVOMENTRG-INVOMENTRM-INVOMENTRR
                                             -INVOMENTRW-INVOMENTNW-INVOMRETPR-INVOMRETPW-INVOMENTRI
                                             -INVOMENTRO-INVOMENTRT)) * (1-ART1731BIS)
                                                         + INVOMENTRY * ART1731BIS
        ) * (1 - V_CNR) ;

REPNY = (max(0 , INVOMENTNY - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-INVOMRETPM
                                             -INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL
                                             -INVOMENTRQ-INVOMENTRV-INVOMENTNV-INVOMRETPN-INVOMRETPS
                                             -INVOMRETPX-INVOMENTRK-INVOMENTRP-INVOMENTRU-INVOMENTNU
                                             -INVOMRETPP-INVOMRETPU-INVOMENTRG-INVOMENTRM-INVOMENTRR
                                             -INVOMENTRW-INVOMENTNW-INVOMRETPR-INVOMRETPW-INVOMENTRI
                                             -INVOMENTRO-INVOMENTRT-INVOMENTRY)) * (1-ART1731BIS)
                                                                    + INVOMENTNY * ART1731BIS
        ) * (1 - V_CNR) ;

REPDOMENTR1 = REPPM + REPRJ + REPPO + REPPT + REPPY + REPRL + REPRQ + REPRV + REPNV + REPPN + REPPS + REPPX + REPRK + REPRP + REPRU + REPNU 
	      + REPPP + REPPU + REPRG + REPRM + REPRR + REPRW + REPNW + REPPR + REPPW + REPRI + REPRO + REPRT + REPRY + REPNY ;

REPENT1 = INVOMRETPM + INVOMENTRJ + INVOMRETPO + INVOMRETPT + INVOMRETPY + INVOMENTRL + INVOMENTRQ + INVOMENTRV + INVOMENTNV + INVOMRETPN + INVOMRETPS 
          + INVOMRETPX + INVOMENTRK + INVOMENTRP + INVOMENTRU + INVOMENTNU + INVOMRETPP + INVOMRETPU + INVOMENTRG + INVOMENTRM + INVOMENTRR + INVOMENTRW 
          + INVOMENTNW + INVOMRETPR + INVOMRETPW + INVOMENTRI + INVOMENTRO + INVOMENTRT + INVOMENTRY + INVOMENTNY ;


REPSB = (max(0 , CODHSB - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-REPENT1)) * (1-ART1731BIS)
                                                                                      + CODHSB * ART1731BIS           
        ) * (1 - V_CNR) ;

REPSG = (max(0 , CODHSG - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-REPENT1
                                         -CODHSB)) * (1-ART1731BIS)
                                          + CODHSG * ART1731BIS
        ) * (1 - V_CNR) ;

REPSL = (max(0 , CODHSL - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-REPENT1
                                         -CODHSB-CODHSG)) * (1-ART1731BIS)
                                                 + CODHSL * ART1731BIS
        )* (1 - V_CNR) ;

REPSQ = (max(0 , CODHSQ - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-REPENT1
                                         -CODHSB-CODHSG-CODHSL)) * (1-ART1731BIS)
                                                        + CODHSQ * ART1731BIS
        ) * (1 - V_CNR) ;

REPSV = (max(0 , CODHSV - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-REPENT1
                                         -CODHSB-CODHSG-CODHSL-CODHSQ)) * (1-ART1731BIS)
                                                               + CODHSV * ART1731BIS
        ) * (1 - V_CNR) ;

REPTA = (max(0 , CODHTA - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-REPENT1
                                         -CODHSB-CODHSG-CODHSL-CODHSQ-CODHSV)) * (1-ART1731BIS)
                                                                      + CODHTA * ART1731BIS
        ) * (1 - V_CNR) ;

REPSA = (max(0 , CODHSA - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-REPENT1
                                         -CODHSB-CODHSG-CODHSL-CODHSQ-CODHSV-CODHTA)) * (1-ART1731BIS)
                                                                            + CODHSA * ART1731BIS
        ) * (1 - V_CNR) ;

REPSF = (max(0 , CODHSF - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-REPENT1
                                         -CODHSB-CODHSG-CODHSL-CODHSQ-CODHSV-CODHTA-CODHSA)) * (1-ART1731BIS)
                                                                                    + CODHSF * ART1731BIS
        ) * (1 - V_CNR) ;

REPSK = (max(0 , CODHSK - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-REPENT1
                                         -CODHSB-CODHSG-CODHSL-CODHSQ-CODHSV-CODHTA-CODHSA
                                         -CODHSF)) * (1-ART1731BIS)
                                          + CODHSK * ART1731BIS
        ) * (1 - V_CNR) ;

REPSP = (max(0 , CODHSP - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-REPENT1
                                         -CODHSB-CODHSG-CODHSL-CODHSQ-CODHSV-CODHTA-CODHSA
                                         -CODHSF-CODHSK)) * (1-ART1731BIS)
                                                 + CODHSP * ART1731BIS
        ) * (1 - V_CNR) ;

REPSU = (max(0 , CODHSU - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-REPENT1
                                         -CODHSB-CODHSG-CODHSL-CODHSQ-CODHSV-CODHTA-CODHSA
                                         -CODHSF-CODHSK-CODHSP)) * (1-ART1731BIS)
                                                        + CODHSU * ART1731BIS
        ) * (1 - V_CNR) ;

REPSZ = (max(0 , CODHSZ - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-REPENT1
                                         -CODHSB-CODHSG-CODHSL-CODHSQ-CODHSV-CODHTA-CODHSA
                                         -CODHSF-CODHSK-CODHSP-CODHSU)) * (1-ART1731BIS)
                                                               + CODHSZ * ART1731BIS
        ) * (1 - V_CNR) ;

REPSC = (max(0 , CODHSC - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-REPENT1
                                         -CODHSB-CODHSG-CODHSL-CODHSQ-CODHSV-CODHTA-CODHSA
                                         -CODHSF-CODHSK-CODHSP-CODHSU-CODHSZ)) * (1-ART1731BIS)
                                                                      + CODHSC * ART1731BIS
        ) * (1 - V_CNR) ; 

REPSH = (max(0 , CODHSH - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-REPENT1
                                         -CODHSB-CODHSG-CODHSL-CODHSQ-CODHSV-CODHTA-CODHSA
                                         -CODHSF-CODHSK-CODHSP-CODHSU-CODHSZ-CODHSC)) * (1-ART1731BIS)
                                                                             + CODHSH * ART1731BIS
        ) * (1 - V_CNR) ; 

REPSM = (max(0 , CODHSM - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-REPENT1
                                         -CODHSB-CODHSG-CODHSL-CODHSQ-CODHSV-CODHTA-CODHSA
                                         -CODHSF-CODHSK-CODHSP-CODHSU-CODHSZ-CODHSC-CODHSH)) * (1-ART1731BIS)
                                                                                    + CODHSM * ART1731BIS
        ) * (1 - V_CNR) ; 


REPSR = (max(0 , CODHSR - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-REPENT1
                                         -CODHSB-CODHSG-CODHSL-CODHSQ-CODHSV-CODHTA-CODHSA
                                         -CODHSF-CODHSK-CODHSP-CODHSU-CODHSZ-CODHSC-CODHSH
                                         -CODHSM)) * (1-ART1731BIS)
                                          + CODHSR * ART1731BIS
        ) * (1 - V_CNR) ;

REPSW = (max(0 , CODHSW - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-REPENT1
                                         -CODHSB-CODHSG-CODHSL-CODHSQ-CODHSV-CODHTA-CODHSA
                                         -CODHSF-CODHSK-CODHSP-CODHSU-CODHSZ-CODHSC-CODHSH
                                         -CODHSM-CODHSR)) * (1-ART1731BIS)
                                                 + CODHSW * ART1731BIS
        ) * (1 - V_CNR) ;

REPTB = (max(0 , CODHTB - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-REPENT1
                                         -CODHSB-CODHSG-CODHSL-CODHSQ-CODHSV-CODHTA-CODHSA
                                         -CODHSF-CODHSK-CODHSP-CODHSU-CODHSZ-CODHSC-CODHSH
                                         -CODHSM-CODHSR-CODHSW)) * (1-ART1731BIS)
                                                       + CODHTB * ART1731BIS
        ) * (1 - V_CNR) ;

REPSE = (max(0 , CODHSE - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-REPENT1
                                         -CODHSB-CODHSG-CODHSL-CODHSQ-CODHSV-CODHTA-CODHSA
                                         -CODHSF-CODHSK-CODHSP-CODHSU-CODHSZ-CODHSC-CODHSH
                                         -CODHSM-CODHSR-CODHSW-CODHTB)) * (1-ART1731BIS)
                                                               + CODHSE * ART1731BIS
        ) * (1 - V_CNR) ;

REPSJ = (max(0 , CODHSJ - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-REPENT1
                                         -CODHSB-CODHSG-CODHSL-CODHSQ-CODHSV-CODHTA-CODHSA
                                         -CODHSF-CODHSK-CODHSP-CODHSU-CODHSZ-CODHSC-CODHSH
                                         -CODHSM-CODHSR-CODHSW-CODHTB-CODHSE)) * (1-ART1731BIS)
                                                                      + CODHSJ * ART1731BIS
        ) * (1 - V_CNR) ;

REPSO = (max(0 , CODHSO - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-REPENT1
                                         -CODHSB-CODHSG-CODHSL-CODHSQ-CODHSV-CODHTA-CODHSA
                                         -CODHSF-CODHSK-CODHSP-CODHSU-CODHSZ-CODHSC-CODHSH
                                         -CODHSM-CODHSR-CODHSW-CODHTB-CODHSE-CODHSJ)) * (1-ART1731BIS)
                                                                             + CODHSO * ART1731BIS
        ) * (1 - V_CNR) ;

REPST = (max(0 , CODHST - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-REPENT1
                                         -CODHSB-CODHSG-CODHSL-CODHSQ-CODHSV-CODHTA-CODHSA
                                         -CODHSF-CODHSK-CODHSP-CODHSU-CODHSZ-CODHSC-CODHSH
                                         -CODHSM-CODHSR-CODHSW-CODHTB-CODHSE-CODHSJ-CODHSO)) * (1-ART1731BIS)
                                                                                    + CODHST * ART1731BIS
        ) * (1 - V_CNR) ;

REPSY = (max(0 , CODHSY - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-REPENT1
                                         -CODHSB-CODHSG-CODHSL-CODHSQ-CODHSV-CODHTA-CODHSA
                                         -CODHSF-CODHSK-CODHSP-CODHSU-CODHSZ-CODHSC-CODHSH
                                         -CODHSM-CODHSR-CODHSW-CODHTB-CODHSE-CODHSJ-CODHSO-CODHST)) * (1-ART1731BIS)
                                                                                           + CODHSY * ART1731BIS
        ) * (1 - V_CNR) ;

REPTD = (max(0 , CODHTD - max(0 , RRIREP -REPSOC-RIDOMPROTOT-REPENT4-REPENT3-REPENT2-REPENT1
                                         -CODHSB-CODHSG-CODHSL-CODHSQ-CODHSV-CODHTA-CODHSA
                                         -CODHSF-CODHSK-CODHSP-CODHSU-CODHSZ-CODHSC-CODHSH
                                         -CODHSM-CODHSR-CODHSW-CODHTB-CODHSE-CODHSJ-CODHSO-CODHST-CODHSY)) * (1-ART1731BIS)
                                                                                                  + CODHTD * ART1731BIS 
        ) * (1 - V_CNR) ;

REPDOMENTR = REPSB + REPSG + REPSL + REPSQ + REPSV + REPTA + REPSA + REPSF + REPSK + REPSP + REPSU + REPSZ + REPSC 
              + REPSH + REPSM + REPSR + REPSW + REPTB + REPSE + REPSJ + REPSO + REPST + REPSY + REPTD ;

regle 6699:
application : iliad, batch ;


NBMOD = (NBPT - (1 + BOOL_0AM)) * 100/25 ;

REVMOD = positif((LIMMOD * (1 + BOOL_0AM) + (LIMMODQAR * NBMOD)) - REVKIRE) * (1 - null(IND_TDR))
          * (positif_ou_nul((LIMMOD * (1 + BOOL_0AM) + (LIMMODQAR * NBMOD)) - (PRIMMOD * (1 + BOOL_0AM)) - REVKIRE) * PRIMMOD * (1 + BOOL_0AM) 
             + positif(REVKIRE + (PRIMMOD * (1 + BOOL_0AM)) - (LIMMOD * (1 + BOOL_0AM) + (LIMMODQAR * NBMOD))) * (LIMMOD * (1 + BOOL_0AM) + (LIMMODQAR * NBMOD) - REVKIRE)) ;

RREVMOD_1 = max(min(REVMOD , RRISUP -RLOGSOC-RDOMSOC1-RIDOMPROTOT-RCOLENT-RLOCENT) , 0) 
          * (1 - V_CNR) ;

RREVMOD =  max( RREVMOD_1 * (1-ART1731BIS) 
                + min( RREVMOD_1 , max( RREVMOD_P , RREVMOD1731+0 )) * ART1731BIS , 0) ;

regle 66991:
application : iliad, batch ;


INDREVMOD = positif(RREVMOD) * (1 - positif(IINET))
            + 2 * positif(RREVMOD) * positif(IINET)
            + 3 * null(RREVMOD + 0) ;

