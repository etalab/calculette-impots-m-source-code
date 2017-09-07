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
  ####   #    #    ##    #####      #     #####  #####   ######      #    
 #    #  #    #   #  #   #    #     #       #    #    #  #           #    #
 #       ######  #    #  #    #     #       #    #    #  #####       #    #
 #       #    #  ######  #####      #       #    #####   #           ######
 #    #  #    #  #    #  #          #       #    #   #   #                #
  ####   #    #  #    #  #          #       #    #    #  ######           #
regle 401000:
application : bareme , iliad , batch ;


IRB = IAMD2 ; 
IRB2 = IAMD2 + TAXASSUR + IPCAPTAXTOT + TAXLOY + CHRAPRES ;

regle 401010:
application : iliad , batch ;


KIR =   IAMD3 ;

regle 401020:
application : bareme , iliad , batch ;


IAMD1 = IAD11 + ITP + REI + AUTOVERSSUP + TAXASSUR + IPCAPTAXTOT + TAXLOY + CHRAPRES + AVFISCOPTER + BRAS + NRINET + IMPRET;
IAMD2 = IAD11 + ITP + REI + AUTOVERSSUP + AVFISCOPTER;
IAMD2TH = positif_ou_nul(IAMD2 - SEUIL_61)*IAMD2;


regle 401030:
application : bareme , iliad , batch ;
IAVIM2 = IAMD1 + PTOT + PTAXA + PPCAP + PTAXLOY + PHAUTREV ;

regle 401035:
application : bareme , iliad , batch ;


IAMD3 = IAD31 + ITP + REI - min(ACP3, IMPIM3);


regle 401040:
application : iliad , batch ;

ANG3 = IAD32 - IAD31 ;

regle 401050:
application : iliad , batch ;


ACP3 = max (0 , somme (a=1..4: min(arr(CHENFa * TX_DPAEAV/100) , SEUIL_AVMAXETU)) - ANG3) 
                * (1 - positif(V_CNR)) * positif(ANG3) * positif(IMPIM3) ;

regle 401060:
application : iliad , batch ;

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
       + (BPTP24 * TX24/100)
	  )
       * (1 - positif(present(TAX1649)+present(RE168))); 

regle 401070:
application : iliad , batch ;


REVTP = BPTP2 + BPTPVT + BPTP4 + BTP3A + BPTP40 + BPTP24 + BPTP18 + BPTPSJ ;

regle 401080:
application : iliad , batch ;

BTP3A = (BN1 + SPEPV + BI12F + BA1);
BPTPD = BTP3A * positif(V_EAD)*(1-positif(present(TAX1649)+present(RE168)));
BPTPG = BTP3A * positif(V_EAG)*(1-positif(present(TAX1649)+present(RE168)));
BPTP3 = BTP3A * (1 - positif(V_EAD + V_EAG))*(1-positif(present(TAX1649)+present(RE168)));
BTP3G = BPVRCM;
BTP2 = PEA;
BPTP2 = BTP2*(1-positif(present(TAX1649)+present(RE168)));
BTPVT = GAINPEA;
BPTPVT = BTPVT*(1-positif(present(TAX1649)+present(RE168)));

BTP18 = BPV18V;
BPTP18 = BTP18 * (1-positif(present(TAX1649)+present(RE168))) ;

BPTP4 = (BPCOPTV + BPVSK) * (1 - positif(present(TAX1649) + present(RE168))) ;
BPTP4I = BPCOPTV * (1 - positif(present(TAX1649) + present(RE168))) ;
BTPSK = BPVSK ;
BPTPSK = BTPSK * (1-positif(present(TAX1649)+present(RE168))) ;

BTP40 = BPV40V ;
BPTP40 = BTP40 * (1-positif(present(TAX1649)+present(RE168))) ;

BTP5 = PVIMPOS;
BPTP5 = BTP5 * (1-positif(present(TAX1649)+present(RE168))) ;
BTPSJ = BPVSJ;
BPTPSJ = BTPSJ * (1-positif(present(TAX1649)+present(RE168))) ;
BTPSB = PVTAXSB;
BPTPSB = BTPSB * (1-positif(present(TAX1649)+present(RE168))) ;
BPTP19 = (BPVSJ + GAINPEA) * (1 - positif(present(TAX1649) + present(RE168))) ;
BPTP24 = RCM2FA *(1-positif(present(TAX1649)+present(RE168))) * (1 - V_CNR);
ITPRCM = arr(BPTP24 * TX24/100);

BPTPDIV = BTP5 * (1-positif(present(TAX1649)+present(RE168))) ;

regle 401090:
application : iliad , batch ;


REI = IPREP + IPPRICORSE ;

regle 401095:
application : iliad , batch ;

PPERSATOT = RSAFOYER + RSAPAC1 + RSAPAC2 ;

PPERSA = min(PPETOTX , PPERSATOT) * (1 - V_CNR) ;


regle 401100:
application : bareme , iliad , batch ;


IAD11 = ( max(0,IDOM11-DEC11-RED) *(1-positif(V_CNR))
        + positif(V_CNR) *max(0 , IDOM11 - RED) )
                                * (1-positif(RE168+TAX1649))
        + positif(RE168+TAX1649) * IDOM16 ;

regle 401110:
application : bareme , iliad , batch ;


IREXITI = (present(FLAG_EXIT) * ((1-positif(FLAG_3WBNEG)) * abs(NAPTIR - V_NAPTIR3WB) 
           + positif(FLAG_3WBNEG) * abs(NAPTIR + V_NAPTIR3WB)) * positif(present(PVIMPOS)+present(CODRWB)))
          * (1 - V_CNR) ;


IREXITS = (
           ((1-positif(FLAG_3WANEG)) * abs(V_NAPTIR3WA+V_NAPTIR3WB*positif(FLAG_3WBNEG)-V_NAPTIR3WB*(1-positif(FLAG_3WBNEG))) 
           + positif(FLAG_3WANEG) * abs(-V_NAPTIR3WA + V_NAPTIR3WB*positif(FLAG_3WBNEG)-V_NAPTIR3WB*(1-positif(FLAG_3WBNEG)))) * positif(present(PVIMPOS)+present(CODRWB))
           + ((1-positif(FLAG_3WANEG)) * abs(V_NAPTIR3WA-NAPTIR)
           + positif(FLAG_3WANEG) * abs(-V_NAPTIR3WA -NAPTIR)) * (1-positif(present(PVIMPOS)+present(CODRWB)))
          ) 
          * present(FLAG_EXIT) * positif(present(PVSURSI)+present(CODRWA))
          * (1 - V_CNR) ;


IREXIT = IREXITI + IREXITS ;

EXITTAX3 = ((positif(FLAG_3WBNEG) * (-1) * ( V_NAPTIR3WB) + (1-positif(FLAG_3WBNEG)) * (V_NAPTIR3WB)) * positif(present(PVIMPOS)+present(CODRWB))
            + NAPTIR * positif(present(PVSURSI)+present(CODRWA)) * (1-positif(present(PVIMPOS)+present(CODRWB))))
           * (1 - V_CNR) ;


PVCREA = PVSURSI + CODRWA ;

PVCREB = PVIMPOS + CODRWB ;

regle 401120:
application : bareme , iliad , batch ;

IAD31 = ((IDOM31-DEC31)*(1-positif(V_CNR)))
        +(positif(V_CNR)*IDOM31);

IAD32 = ((IDOM32-DEC32)*(1-positif(V_CNR)))
        +(positif(V_CNR)*IDOM32);

regle 401130:
application : bareme , iliad , batch ;

IMPIM3 = IAD31 ;

regle 401140:
application : bareme , iliad , batch ;


pour z = 1,2:
DEC1z = ( min(max(arr((SEUIL_DECOTE1 * (1 - BOOL_0AM)) + (SEUIL_DECOTE2 * BOOL_0AM) - (IDOM1z * 3/4)) , 0) , IDOM1z) * (1 - V_ANC_BAR)
        + min(max( arr((SEUIL_DECOTE1A * (1 - BOOL_0AM)) + (SEUIL_DECOTE2A * BOOL_0AM) - IDOM1z),0),IDOM1z) * V_ANC_BAR
        ) * (1 - V_CNR) ;

pour z = 1,2:
DEC3z = ( min(max(arr((SEUIL_DECOTE1 * (1 - BOOL_0AM)) + (SEUIL_DECOTE2 * BOOL_0AM) - (IDOM3z * 3/4)) , 0) , IDOM3z) * (1 - V_ANC_BAR)
        + min(max( arr((SEUIL_DECOTE1A * (1 - BOOL_0AM)) + (SEUIL_DECOTE2A * BOOL_0AM) - IDOM3z),0),IDOM3z) * V_ANC_BAR
        ) * (1 - V_CNR) ;

DEC6 = ( min(max(arr((SEUIL_DECOTE1 * (1 - BOOL_0AM)) + (SEUIL_DECOTE2 * BOOL_0AM) - (IDOM16 * 3/4)) , 0) , IDOM16) * (1 - V_ANC_BAR)
       + min(max( arr((SEUIL_DECOTE1 * (1 - BOOL_0AM)) + (SEUIL_DECOTE2 * BOOL_0AM) - IDOM16),0),IDOM16) * V_ANC_BAR
       ) * (1 - V_CNR) ;

regle 401150:
application : iliad , batch ;

ART1731BIS = positif(positif(SOMMERI_2) + PREM8_11) ;

regle 401160:
application : iliad , batch ;

      
RED =  RCOTFOR + RREPA + RAIDE + RDIFAGRI + RPRESSE + RFORET + RFIPDOM 
       + RFIPC + RCINE + RRESTIMO * (1-V_INDTEO) + V_RRESTIMOXY * V_INDTEO
       + RSOCREPR + RRPRESCOMP + RHEBE + RSURV + RINNO + RSOUFIP
       + RRIRENOV + RLOGDOM + RCOMP + RRETU + RDONS + CRDIE
       + RDUFLOTOT + RPINELTOT
       + RNOUV + RPLAFREPME4 + RPENTDY + RFOR + RTOURREP + RTOUHOTR + RTOUREPA
       + RCELTOT
       + RREDMEUB + RREDREP + RILMIX + RILMIY + RILMPA + RILMPF + RINVRED + RILMIH + RILMJC + RILMPB
       + RILMPG + RILMIZ + RILMJI + RILMPC + RILMPH + RILMJS + RILMPD + RILMPI + RILMPE + RILMPJ
       + RMEUBLE + RPROREP + RREPNPRO + RREPMEU + RILMIC + RILMIB + RILMIA + RILMJY + RILMJX + RILMJW
       + RILMJV + RILMOE + RILMOD + RILMOC + RILMOB + RILMOA + RILMOJ + RILMOI + RILMOH + RILMOG
       + RILMOF + RRESIMEUB + RRESIVIEU + RRESINEUV + RLOCIDEFG + RCODJTJU + RCODOU + RCODOV       
       + RPATNAT1 + RPATNAT2 + RPATNAT3 + RPATNAT
       + RDOMSOC1 + RLOGSOC + RCOLENT + RLOCENT
        ;

REDTL = ASURV + ACOMP ;

CIMPTL = ATEC + ADEVDUR + TOTBGE ;

regle 401170:
application : bareme ;

RED = V_9UY ;

regle 401180:
application : iliad , batch ;

DPRESSE = COD7BY + COD7BX ;

APRESSE50_1 = max(min(COD7BY,LIM1000*(1+BOOL_0AM)),0) * (1-V_CNR) ;
APRESSE30_1 = max(min(COD7BX,max(0,LIM1000*(1+BOOL_0AM)-APRESSE50_1)),0) * (1-V_CNR) ;

APRESSE = ( (APRESSE50_1+APRESSE30_1) * (1 - ART1731BIS)
              + min( (APRESSE50_1+APRESSE30_1) , APRESSE_2 ) * ART1731BIS
         ) * (1 - V_CNR) ;

RAPRESSE = arr(APRESSE50_1*TX50/100+APRESSE30_1*TX30/100) ;

RPRESSE_1 =  max( min( RAPRESSE , IDOM11-DEC11-RCOTFOR_1-RREPA_1-RAIDE_1-RDIFAGRI_1) , 0 ) ;

RPRESSE = RPRESSE_1 * (1-ART1731BIS)
         + min( RPRESSE_1 , RPRESSE_2 ) * ART1731BIS ;

regle 401185:
application : iliad , batch ;

DFORET = FORET ;

AFORET_1 = max(min(DFORET,LIM_FORET),0) * (1-V_CNR) ;

AFORET = ( AFORET_1 * (1 - ART1731BIS)
              + min( AFORET_1 , AFORET_2 ) * ART1731BIS
         ) * (1 - V_CNR) ;

RAFORET = arr(AFORET_1*TX_FORET/100) ;

RFORET_1 =  max( min( RAFORET , IDOM11-DEC11-RCOTFOR_1-RREPA_1-RAIDE_1-RDIFAGRI_1-RPRESSE_1) , 0 ) ;

RFORET = RFORET_1 * (1-ART1731BIS)
         + min( RFORET_1 , RFORET_2 ) * ART1731BIS ;


regle 401190:
application : iliad , batch ;

DFIPDOM = FIPDOMCOM ;

AFIPDOM_1 = max( min(DFIPDOM , LIMFIPDOM * (1 + BOOL_0AM)) , 0) * (1 - V_CNR) ;

AFIPDOM = max( 0 , AFIPDOM_1 * (1 - ART1731BIS)
                + min( AFIPDOM_1 , AFIPDOM_2 ) * ART1731BIS
	     ) * (1 - V_CNR) ;

RFIPDOMCOM = arr(AFIPDOM_1 * TXFIPDOM/100);

RFIPDOM_1 = max( min( RFIPDOMCOM , IDOM11-DEC11-RCOTFOR_1-RREPA_1-RAIDE_1-RDIFAGRI_1-RPRESSE_1-RFORET_1),0);

RFIPDOM = RFIPDOM_1 * (1 - ART1731BIS)
          + min( RFIPDOM_1, RFIPDOM_2 ) * ART1731BIS ;


regle 401200:
application : iliad , batch ;

DFIPC = FIPCORSE ;

AFIPC_1 = max( min(DFIPC , LIM_FIPCORSE * (1 + BOOL_0AM)) , 0) * (1 - V_CNR) ;

AFIPC = max( 0, AFIPC_1 * (1-ART1731BIS)
                + min( AFIPC_1 , AFIPC_2 ) * ART1731BIS
           ) * (1 - V_CNR) ;

RFIPCORSE = arr(AFIPC_1 * TX_FIPCORSE/100) * (1 - V_CNR) ;

RFIPC_1 = max( min( RFIPCORSE , IDOM11-DEC11-RCOTFOR_1-RREPA_1-RAIDE_1-RDIFAGRI_1-RPRESSE_1-RFORET_1-RFIPDOM_1) , 0) ;

RFIPC = RFIPC_1 * (1 - ART1731BIS) 
        + min( RFIPC_1 , RFIPC_2 ) * ART1731BIS ;

regle 401210:
application : iliad , batch ;

BSURV = min( RDRESU , PLAF_RSURV + PLAF_COMPSURV * (EAC + V_0DN) + PLAF_COMPSURVQAR * (V_0CH + V_0DP) );

RRS = arr( BSURV * TX_REDSURV / 100 ) * (1 - V_CNR);

DSURV = RDRESU;

ASURV = (BSURV * (1-ART1731BIS)
          + min( BSURV , ASURV_2) * ART1731BIS
        )  * (1-V_CNR);

RSURV_1 = max( min( RRS , IDOM11-DEC11-RCOTFOR_1-RREPA_1-RAIDE_1-RDIFAGRI_1-RPRESSE_1-RFORET_1-RFIPDOM_1-RFIPC_1
			              -RCINE_1-RRESTIMO_1-RSOCREPR_1-RRPRESCOMP_1-RHEBE_1 ) , 0 ) ;

RSURV = max( 0 , RSURV_1 * (1-ART1731BIS) 
                  + min( RSURV_1, RSURV_2 ) * ART1731BIS
           ) ;

regle 401220:
application : iliad , batch ;


RRCN = arr(  min( CINE1 , min( max(SOFIRNG,RNG) * TX_CINE3/100 , PLAF_CINE )) * TX_CINE1/100
        + min( CINE2 , max( min( max(SOFIRNG,RNG) * TX_CINE3/100 , PLAF_CINE ) - CINE1 , 0)) * TX_CINE2/100 
       ) * (1 - V_CNR) ;

DCINE = CINE1 + CINE2 ;

ACINE_1 = max(0,min( CINE1 + CINE2 , min( arr(SOFIRNG * TX_CINE3/100) , PLAF_CINE ))) * (1 - V_CNR) ;

ACINE = max( 0, ACINE_1 * (1-ART1731BIS) 
                 + min( ACINE_1 , ACINE_2 ) * ART1731BIS
           ) * (1-V_CNR) ; 

RCINE_1 = max( min( RRCN , IDOM11-DEC11-RCOTFOR_1-RREPA_1-RAIDE_1-RDIFAGRI_1-RPRESSE_1-RFORET_1-RFIPDOM_1-RFIPC_1) , 0 ) ;

RCINE = max( 0, RCINE_1 * (1-ART1731BIS) 
                 + min( RCINE_1 , RCINE_2 ) * ART1731BIS
           ) ;

regle 401230:
application : iliad , batch ;


BSOUFIP = min( FFIP , LIM_SOUFIP * (1 + BOOL_0AM));

RFIP = arr( BSOUFIP * TX_REDFIP / 100 ) * (1 - V_CNR);

DSOUFIP = FFIP;

ASOUFIP = (BSOUFIP * (1-ART1731BIS) 
            + min( BSOUFIP , ASOUFIP_2 ) * ART1731BIS
          ) * (1-V_CNR) ;

RSOUFIP_1 = max( min( RFIP , IDOM11-DEC11-RCOTFOR_1-RREPA_1-RAIDE_1-RDIFAGRI_1-RPRESSE_1-RFORET_1-RFIPDOM_1-RFIPC_1
			   -RCINE_1-RRESTIMO_1-RSOCREPR_1-RRPRESCOMP_1-RHEBE_1-RSURV_1-RINNO_1) , 0 ) ;

RSOUFIP = max( 0 , RSOUFIP_1 * (1-ART1731BIS) 
                   + min( RSOUFIP_1 ,RSOUFIP_2 ) * ART1731BIS 
             ) ;

regle 401240:
application : iliad , batch ;


BRENOV = min(RIRENOV,PLAF_RENOV) ;

RENOV = arr( BRENOV * TX_RENOV / 100 ) * (1 - V_CNR) ;

DRIRENOV = RIRENOV ;

ARIRENOV = (BRENOV * (1-ART1731BIS) 
             + min( BRENOV, ARIRENOV_2 ) * ART1731BIS
           ) * (1 - V_CNR) ;

RRIRENOV_1 = max(min(RENOV , IDOM11-DEC11-RCOTFOR_1-RREPA_1-RAIDE_1-RDIFAGRI_1-RPRESSE_1-RFORET_1-RFIPDOM_1-RFIPC_1-RCINE_1
			     -RRESTIMO_1-RSOCREPR_1-RRPRESCOMP_1-RHEBE_1-RSURV_1-RINNO_1-RSOUFIP_1) , 0 ) ;

RRIRENOV = max( 0 , RRIRENOV_1 * (1-ART1731BIS) 
                    + min(RRIRENOV_1 , RRIRENOV_2) * ART1731BIS
              ) ;

regle 401250:
application : iliad , batch ;


RFC = min(RDCOM,PLAF_FRCOMPTA * max(1,NBACT)) * present(RDCOM)*(1-V_CNR);

NCOMP = ( max(1,NBACT)* present(RDCOM) * (1-ART1731BIS) + min( max(1,NBACT)* present(RDCOM) , NCOMP1731+0) * ART1731BIS ) * (1-V_CNR);

DCOMP = RDCOM;

ACOMP =  RFC * (1-ART1731BIS) 
         + min( RFC , ACOMP_2 ) * ART1731BIS ;

regle 401260:
application : iliad , batch ;

RCOMP_1 = max(min( RFC , RRI1_1-RLOGDOM_1) , 0) ;

RCOMP = max( 0 , RCOMP_1 * (1-ART1731BIS) 
                 + min( RCOMP_1 , RCOMP_2 ) * ART1731BIS 
           ) ; 

regle 401270:
application : iliad , batch ;




DUFREPFI = DUFLOFI ;
DUFREPFK = DUFLOFK ;
DDUFLOEKL = DUFLOEK + DUFLOEL ;
DDUFLOGIH = DUFLOGI + DUFLOGH ;
DPIREPAI = PINELAI ;
DPIREPBI = PINELBI ;
DPIREPCI = PINELCI ;
DPIREPDI = PINELDI ;
DPIQGH = PINELQG + PINELQH ;
DPIQEF = PINELQE + PINELQF ;
DPIQCD = PINELQC + PINELQD ;
DPIQAB = PINELQA + PINELQB ;


ADUFREPFI_1 = (DUFLOFI + 0) * (1 - V_CNR) ;

ADUFREPFI = ADUFREPFI_1 * (1-ART1731BIS)
            + min( ADUFREPFI_1 , ADUFREPFI_2 ) * ART1731BIS ; 

ADUFREPFK_1 = (DUFLOFK + 0) * (1 - V_CNR) ;

ADUFREPFK = ADUFREPFK_1 * (1-ART1731BIS)
            + min( ADUFREPFK_1 , ADUFREPFK_2 ) * ART1731BIS ; 

APIREPAI_1 = (PINELAI + 0) * (1 - V_CNR) ;

APIREPAI = APIREPAI_1 * (1-ART1731BIS)
            + min( APIREPAI_1 , APIREPAI_2 ) * ART1731BIS ; 

APIREPBI_1 = (PINELBI + 0) * (1 - V_CNR) ;

APIREPBI = APIREPBI_1 * (1-ART1731BIS)
            + min( APIREPBI_1 , APIREPBI_2 ) * ART1731BIS ; 

APIREPCI_1 = (PINELCI + 0) * (1 - V_CNR) ;

APIREPCI = APIREPCI_1 * (1-ART1731BIS)
            + min( APIREPBI_1 , APIREPBI_2 ) * ART1731BIS ; 

APIREPDI_1 = (PINELDI + 0) * (1 - V_CNR) ;

APIREPDI = APIREPDI_1 * (1-ART1731BIS)
            + min( APIREPDI_1 , APIREPDI_2 ) * ART1731BIS ; 



APIQGH_1 = ( arr( min( PINELQH + 0, LIMDUFLO) / 9 ) +
             arr( min( PINELQG + 0, LIMDUFLO - min( PINELQH + 0, LIMDUFLO)) / 6 )
           ) * ( 1 - V_CNR ) ;

APIQGH = APIQGH_1 * (1-ART1731BIS) 
         + min( APIQGH_1, APIQGH_2 ) * ART1731BIS ;

APIQEF_1 = (  arr( min( PINELQF + 0, LIMDUFLO - min( PINELQH + PINELQG + 0, LIMDUFLO)) / 9 ) +  
              arr( min( PINELQE + 0, LIMDUFLO - min( PINELQH + PINELQG + PINELQF + 0, LIMDUFLO)) / 6 )
           ) * ( 1 - V_CNR ) ;

APIQEF = APIQEF_1 * (1-ART1731BIS) 
         + min( APIQEF_1, APIQEF_2 ) * ART1731BIS ;

APIQCD_1 = ( arr( min(PINELQD + 0, LIMDUFLO - min( DUFLOEL + 0, LIMDUFLO)) /9 ) +
             arr(min( PINELQC + 0, LIMDUFLO - min( DUFLOEL + PINELQD + 0, LIMDUFLO)) /6 )
           ) * ( 1 - V_CNR ) ;

APIQCD = APIQCD_1 * (1-ART1731BIS) 
         + min( APIQCD_1, APIQCD_2 ) * ART1731BIS ;

APIQAB_1 = (  arr( min(PINELQB + 0, LIMDUFLO - min( DUFLOEL + PINELQD + PINELQC + DUFLOEK + 0, LIMDUFLO)) / 9 ) +
              arr(min( PINELQA + 0, LIMDUFLO - min( DUFLOEL + PINELQD + PINELQC + DUFLOEK + PINELQB + 0, LIMDUFLO)) / 6)
           ) * ( 1 - V_CNR ) ;

APIQAB = APIQAB_1 * (1-ART1731BIS) 
         + min( APIQAB_1, APIQAB_2 ) * ART1731BIS ;


ADUFLOEKL_1 = ( arr( min( DUFLOEL + 0, LIMDUFLO) / 9 ) 
              + arr( min( DUFLOEK + 0, LIMDUFLO - min( DUFLOEL + PINELQD + PINELQC + 0, LIMDUFLO)) / 9 )
              ) * ( 1 - V_CNR ) ;

ADUFLOEKL = ADUFLOEKL_1 * (1-ART1731BIS)
             + min( ADUFLOEKL_1, ADUFLOEKL_2 ) * ART1731BIS ;


ADUFLOGIH_1 = ( arr( min( DUFLOGI + 0, LIMDUFLO) / 9 ) +
              arr( min( DUFLOGH + 0, LIMDUFLO - min( DUFLOGI + 0, LIMDUFLO)) / 9 )
              ) * ( 1 - V_CNR ) ;

ADUFLOGIH =  ADUFLOGIH_1 * (1-ART1731BIS) 
             + min( ADUFLOGIH_1, ADUFLOGIH_2 ) * ART1731BIS ;




RPI_GH = ( arr(  arr( min( PINELQH + 0, LIMDUFLO) / 9 ) * (TX29/100)
               + arr( min( PINELQG + 0, LIMDUFLO - min( PINELQH + 0, LIMDUFLO)) / 6 ) * (TX23/100)
              )            
         ) * ( 1 - V_CNR ) ;

RPI_EF = ( arr(  arr( min( PINELQF + 0, LIMDUFLO - min( PINELQH + PINELQG + 0, LIMDUFLO)) / 9 ) * (TX18/100)
               + arr( min( PINELQE + 0, LIMDUFLO - min( PINELQH + PINELQG + PINELQF + 0, LIMDUFLO)) / 6 ) * (TX12/100)
              )            
         ) * ( 1 - V_CNR ) ;


RDUFLO_EKL = ( arr(arr( min( DUFLOEL + 0, LIMDUFLO) / 9 ) * (TX29/100))
              + arr(arr( min( DUFLOEK + 0, LIMDUFLO - min( DUFLOEL + PINELQD + PINELQC + 0, LIMDUFLO)) / 9 ) * (TX18/100))
              ) * ( 1 - V_CNR ) ;


RPI_CD = ( arr(arr( min(PINELQD + 0, LIMDUFLO - min( DUFLOEL + 0, LIMDUFLO)) /9 ) * (TX29/100))
             + arr(arr(min( PINELQC + 0, LIMDUFLO - min( DUFLOEL + PINELQD + 0, LIMDUFLO)) /6 ) * (TX23/100)) 
         ) * ( 1 - V_CNR ) ; 

RPI_AB = ( arr(arr( min(PINELQB + 0, LIMDUFLO - min( DUFLOEL + PINELQD + PINELQC + DUFLOEK + 0, LIMDUFLO)) / 9 ) * (TX18/100))
             + arr(arr(min( PINELQA + 0, LIMDUFLO - min( DUFLOEL + PINELQD + PINELQC + DUFLOEK + PINELQB + 0, LIMDUFLO)) / 6) * (TX12/100))
         ) * ( 1 - V_CNR ) ; 


RDUFLO_GIH = ( arr( arr( min( DUFLOGI + 0, LIMDUFLO) / 9 ) * (TX29/100)) +
              arr( arr( min( DUFLOGH + 0, LIMDUFLO - min( DUFLOGI + 0, LIMDUFLO)) / 9 ) * (TX18/100))
             ) * ( 1 - V_CNR ) ;


regle 401280:
application : iliad , batch ;


RDUFREPFI_1 = max( 0, min( ADUFREPFI_1 , RRI1_1-RLOGDOM_1-RCOMP_1-RRETU_1-RDONS_1-CRDIE_1)) ;

RDUFREPFI = max( 0, RDUFREPFI_1 * (1 - ART1731BIS)
                    + min( RDUFREPFI_1 , RDUFREPFI_2 ) * ART1731BIS
               ) ; 
RDUFREPFK_1 = max( 0, min( ADUFREPFK_1 , RRI1_1-RLOGDOM_1-RCOMP_1-RRETU_1-RDONS_1-CRDIE_1
                                               -RDUFREPFI_1 )) ;

RDUFREPFK = max( 0, RDUFREPFK_1 * (1 - ART1731BIS)
                    + min( RDUFREPFK_1 , RDUFREPFK_2 ) * ART1731BIS
               ) ; 
RDUFLOEKL_1 = max( 0, min( RDUFLO_EKL , RRI1_1-RLOGDOM_1-RCOMP_1-RRETU_1-RDONS_1-CRDIE_1
                                   -RDUFREPFI_1-RDUFREPFK_1 )) ;

RDUFLOEKL = max( 0, RDUFLOEKL_1 * (1 - ART1731BIS)  
                    + min ( RDUFLOEKL_1 , RDUFLOEKL_2 ) * ART1731BIS
               ) ; 

RDUFLOGIH_1 = max( 0, min( RDUFLO_GIH , RRI1_1-RLOGDOM_1-RCOMP_1-RRETU_1-RDONS_1-CRDIE_1
                                   -RDUFREPFI_1-RDUFREPFK_1-RDUFLOEKL_1 )) ;

RDUFLOGIH = max( 0, RDUFLOGIH_1 * (1 - ART1731BIS) 
                    + min ( RDUFLOGIH_1 , RDUFLOGIH_2 ) * ART1731BIS
               ) ; 

RPIREPAI_1 = max( 0, min( APIREPAI_1 , RRI1_1-RLOGDOM_1-RCOMP_1-RRETU_1-RDONS_1-CRDIE_1
                                             -RDUFREPFI_1-RDUFREPFK_1-RDUFLOEKL_1-RDUFLOGIH_1 )) ;

RPIREPAI = max( 0, RPIREPAI_1 * (1 - ART1731BIS)
                    + min( RPIREPAI_1 , RPIREPAI_2 ) * ART1731BIS
               ) ; 
RPIREPBI_1 = max( 0, min( APIREPBI_1 , RRI1_1-RLOGDOM_1-RCOMP_1-RRETU_1-RDONS_1-CRDIE_1
                                             -RDUFREPFI_1-RDUFREPFK_1-RDUFLOEKL_1-RDUFLOGIH_1 
                                             -RPIREPAI_1 )) ;

RPIREPBI = max( 0, RPIREPBI_1 * (1 - ART1731BIS)
                    + min( RPIREPBI_1 , RPIREPBI_2 ) * ART1731BIS
               ) ; 
RPIREPCI_1 = max( 0, min( APIREPCI_1 , RRI1_1-RLOGDOM_1-RCOMP_1-RRETU_1-RDONS_1-CRDIE_1
                                             -RDUFREPFI_1-RDUFREPFK_1-RDUFLOEKL_1-RDUFLOGIH_1 
                                             -RPIREPAI_1-RPIREPBI_1 )) ;

RPIREPCI = max( 0, RPIREPCI_1 * (1 - ART1731BIS)
                    + min( RPIREPCI_1 , RPIREPCI_2 ) * ART1731BIS
               ) ; 
RPIREPDI_1 = max( 0, min( APIREPDI_1 , RRI1_1-RLOGDOM_1-RCOMP_1-RRETU_1-RDONS_1-CRDIE_1
                                             -RDUFREPFI_1-RDUFREPFK_1-RDUFLOEKL_1-RDUFLOGIH_1 
                                             -RPIREPAI_1-RPIREPBI_1-RPIREPCI_1 )) ;

RPIREPDI = max( 0, RPIREPDI_1 * (1 - ART1731BIS)
                    + min( RPIREPDI_1 , RPIREPDI_2 ) * ART1731BIS
               ) ; 


RPIQGH_1 = max( 0, min( RPI_GH , RRI1_1-RLOGDOM_1-RCOMP_1-RRETU_1-RDONS_1-CRDIE_1
                                 -RDUFREPFI_1-RDUFREPFK_1-RDUFLOEKL_1-RDUFLOGIH_1 
                                 -RPIREPAI_1-RPIREPBI_1-RPIREPCI_1-RPIREPDI_1 )) ;

RPIQGH = max( 0, RPIQGH_1 * (1 - ART1731BIS)
                   + min ( RPIQGH_1 , RPIQGH_2 ) * ART1731BIS
              ) ; 
RPIQEF_1 = max( 0, min( RPI_EF , RRI1_1-RLOGDOM_1-RCOMP_1-RRETU_1-RDONS_1-CRDIE_1
                                 -RDUFREPFI_1-RDUFREPFK_1-RDUFLOEKL_1-RDUFLOGIH_1 
                                 -RPIREPAI_1-RPIREPBI_1-RPIREPCI_1-RPIREPDI_1-RPIQGH_1 )) ;

RPIQEF = max( 0, RPIQEF_1 * (1 - ART1731BIS)
                   + min ( RPIQEF_1 , RPIQEF_2 ) * ART1731BIS
              ) ; 
RPIQCD_1 = max( 0, min( RPI_CD , RRI1_1-RLOGDOM_1-RCOMP_1-RRETU_1-RDONS_1-CRDIE_1
                                 -RDUFREPFI_1-RDUFREPFK_1-RDUFLOEKL_1-RDUFLOGIH_1 
                                 -RPIREPAI_1-RPIREPBI_1-RPIREPCI_1-RPIREPDI_1-RPIQGH_1 
                                 -RPIQEF_1 )) ;

RPIQCD = max( 0, RPIQCD_1 * (1 - ART1731BIS)
                   + min ( RPIQCD_1 , RPIQCD_2 ) * ART1731BIS
              ) ; 

RPIQAB_1 = max( 0, min( RPI_AB , RRI1_1-RLOGDOM_1-RCOMP_1-RRETU_1-RDONS_1-CRDIE_1
                                 -RDUFREPFI_1-RDUFREPFK_1-RDUFLOEKL_1-RDUFLOGIH_1 
                                 -RPIREPAI_1-RPIREPBI_1-RPIREPCI_1-RPIREPDI_1-RPIQGH_1 
                                 -RPIQEF_1-RPIQCD_1 )) ;

RPIQAB = max( 0, RPIQAB_1 * (1 - ART1731BIS)
                   + min ( RPIQAB_1 , RPIQAB_2 ) * ART1731BIS
              ) ; 

RDUFLOTOT = RDUFREPFI + RDUFREPFK + RDUFLOGIH + RDUFLOEKL ;
RDUFLOTOT_1 = RDUFREPFI_1 + RDUFREPFK_1 + RDUFLOGIH_1 + RDUFLOEKL_1 ;
RPINELTOT = RPIREPAI + RPIREPBI + RPIREPCI + RPIREPDI + RPIQGH + RPIQEF + RPIQCD + RPIQAB ;
RPINELTOT_1 = RPIREPAI_1 + RPIREPBI_1 + RPIREPCI_1 + RPIREPDI_1 + 
              RPIQGH_1 + RPIQEF_1 + RPIQCD_1 + RPIQAB_1 ;

regle 401290:
application : iliad , batch ;


RIVPIQF = arr( arr( min( PINELQF + 0, LIMDUFLO - min( PINELQH + PINELQG + 0, LIMDUFLO)) / 9 ) * (TX18/100) 
             ) * ( 1 - V_CNR ) ;

RIVPIQF8 = max (0 , arr( min( PINELQF + 0, LIMDUFLO - min( PINELQH + PINELQG + 0, LIMDUFLO)) * (TX18/100)) 
                    - 8 * RIVPIQF
               ) * ( 1 - V_CNR ) ;

RIVPIQH =  arr( arr( min( PINELQH + 0, LIMDUFLO) / 9 ) * (TX29/100)
              ) * ( 1 - V_CNR ) ;

RIVPIQH8 = max (0 , arr( min( PINELQH + 0, LIMDUFLO) * (TX29/100))
                    - 8 * RIVPIQH
               ) * ( 1 - V_CNR ) ; 


RIVPIQE = arr( arr( min( PINELQE + 0, LIMDUFLO - min( PINELQH + PINELQG + PINELQF + 0, LIMDUFLO)) / 6 ) * (TX12/100)
             ) * ( 1 - V_CNR ) ;

RIVPIQE5 = max (0 ,  arr( min( PINELQE + 0, LIMDUFLO - min( PINELQH + PINELQG + PINELQF + 0, LIMDUFLO)) * (TX12/100)) 
                     - 5 * RIVPIQE 
                ) * ( 1 - V_CNR ) ;
RIVPIQG = arr( arr( min( PINELQG + 0, LIMDUFLO - min( PINELQH + 0, LIMDUFLO)) / 6 ) * (TX23/100)
             ) * ( 1 - V_CNR ) ;

RIVPIQG5 = max (0 , arr( min( PINELQG + 0, LIMDUFLO - min( PINELQH + 0, LIMDUFLO )) * (TX23/100))
                     - 5 * RIVPIQG 
               ) * ( 1 - V_CNR ) ;


RIVDUEKL = ( arr( arr( min( DUFLOEL + 0, LIMDUFLO) / 9 ) * (TX29/100)) 
              + arr(arr( min( DUFLOEK + 0, LIMDUFLO - min( DUFLOEL + PINELQD + PINELQC + 0, LIMDUFLO)) / 9 ) * (TX18/100))
           ) * ( 1 - V_CNR ) ;

RIVDUEKL8 = max (0 , ( arr( min( DUFLOEL + 0, LIMDUFLO) * (TX29/100)) 
                         + arr( min( DUFLOEK + 0, LIMDUFLO - min( DUFLOEL + PINELQD + PINELQC + 0, LIMDUFLO)) * (TX18/100))
                     ) 
                          - 8 * RIVDUEKL  
                ) * ( 1 - V_CNR ) ; 


RIVPIQD = arr(arr( min(PINELQD + 0, LIMDUFLO - min( DUFLOEL + 0, LIMDUFLO)) /9 ) * (TX29/100)
             ) * ( 1 - V_CNR ) ; 

RIVPIQD8 = max (0 , arr( min(PINELQD + 0, LIMDUFLO - min( DUFLOEL + 0, LIMDUFLO)) * (TX29/100)) 
                    - 8 * RIVPIQD  
               ) * ( 1 - V_CNR ) ; 

RIVPIQB =  arr(arr( min(PINELQB + 0, LIMDUFLO - min( DUFLOEL + PINELQD + PINELQC + DUFLOEK + 0, LIMDUFLO)) / 9 ) * (TX18/100)
              )  * ( 1 - V_CNR ) ; 

RIVPIQB8 = max (0 , arr( min(PINELQB + 0, LIMDUFLO - min( DUFLOEL + PINELQD + PINELQC + DUFLOEK + 0, LIMDUFLO)) * (TX18/100)) 
                    - 8 * RIVPIQB  
                ) * ( 1 - V_CNR ) ; 



RIVPIQC = arr(arr(min( PINELQC + 0, LIMDUFLO - min( DUFLOEL + PINELQD + 0, LIMDUFLO)) /6 ) * (TX23/100)
             ) * ( 1 - V_CNR ) ;

RIVPIQC5 = max (0 , arr( min(PINELQC + 0, LIMDUFLO - min( DUFLOEL + PINELQD + 0, LIMDUFLO)) * (TX23/100)) 
                    - 5 * RIVPIQC  
               ) * ( 1 - V_CNR ) ;

RIVPIQA = arr(arr(min( PINELQA + 0, LIMDUFLO - min( DUFLOEL + PINELQD + PINELQC + DUFLOEK + PINELQB + 0, LIMDUFLO)) / 6) * (TX12/100)
             ) * ( 1 - V_CNR ) ;

RIVPIQA5= max (0 , arr( min(PINELQA + 0, LIMDUFLO - min( DUFLOEL + PINELQD + PINELQC + DUFLOEK + PINELQB + 0, LIMDUFLO)) * (TX12/100))
                   - 5 * RIVPIQA
              ) * ( 1 - V_CNR ) ; 


RIVDUGIH = ( arr( arr( min( DUFLOGI + 0, LIMDUFLO) / 9 ) * (TX29/100)) +
                arr( arr( min( DUFLOGH + 0, LIMDUFLO - min( DUFLOGI + 0, LIMDUFLO)) / 9 ) * (TX18/100))
              ) * ( 1 - V_CNR ) ;

RIVDUGIH8 = max (0 , ( arr( min( DUFLOGI + 0, LIMDUFLO) * (TX29/100)) +
                          arr( min( DUFLOGH + 0, LIMDUFLO - min( DUFLOGI + 0, LIMDUFLO)) * (TX18/100))
                     ) 
                          - 8 * RIVDUGIH  
                   ) * ( 1 - V_CNR ) ; 

REPDUEKL = RIVDUEKL * 7 + RIVDUEKL8 ;
REPIQH = RIVPIQH * 7 + RIVPIQH8 ;
REPIQF = RIVPIQF * 7 + RIVPIQF8 ;
REPIQG = RIVPIQG * 4 + RIVPIQG5 ;
REPIQE = RIVPIQE * 4 + RIVPIQE5 ;
REPIQB = RIVPIQB * 7 + RIVPIQB8 ;
REPIQD = RIVPIQD * 7 + RIVPIQD8 ;
REPIQA = RIVPIQA * 4 + RIVPIQA5 ;
REPIQC = RIVPIQC * 4 + RIVPIQC5 ;
REPDUGIH = RIVDUGIH * 7 + RIVDUGIH8 ;

regle 401300:
application : iliad , batch ;

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

ACELRREDLA = (CELRREDLA * (1-ART1731BIS) 
              + min( CELRREDLA, ACELRREDLA_2) * ART1731BIS
             ) * ( 1 - V_CNR ) ;

DCELRREDLB = CELRREDLB;

ACELRREDLB = (CELRREDLB * (1-ART1731BIS) 
              + min( CELRREDLB, ACELRREDLB_2) * ART1731BIS
             ) * ( 1 - V_CNR ) ;

DCELRREDLE = CELRREDLE;

ACELRREDLE = (CELRREDLE * (1-ART1731BIS)
              + min( CELRREDLE, ACELRREDLE_2) * ART1731BIS
             ) * ( 1 - V_CNR ) ;

DCELRREDLM = CELRREDLM;

ACELRREDLM = (CELRREDLM * (1-ART1731BIS) 
              + min( CELRREDLM, ACELRREDLM_2) * ART1731BIS
	     ) * ( 1 - V_CNR ) ;

DCELRREDLN = CELRREDLN;

ACELRREDLN = (CELRREDLN * (1-ART1731BIS) 
              + min( CELRREDLN, ACELRREDLN_2) * ART1731BIS
             ) * ( 1 - V_CNR ) ;

DCELRREDLG = CELRREDLG;

ACELRREDLG = (CELRREDLG * (1-ART1731BIS) 
              + min( CELRREDLG, ACELRREDLG_2) * ART1731BIS
             ) * ( 1 - V_CNR ) ;

DCELRREDLC = CELRREDLC;

ACELRREDLC = (CELRREDLC * (1-ART1731BIS) 
              + min( CELRREDLC, ACELRREDLC_2) * ART1731BIS
	     ) * ( 1 - V_CNR ) ;

DCELRREDLD = CELRREDLD;

ACELRREDLD = (CELRREDLD * (1-ART1731BIS) 
              + min( CELRREDLD, ACELRREDLD_2) * ART1731BIS
	     ) * ( 1 - V_CNR ) ;

DCELRREDLS = CELRREDLS;

ACELRREDLS = (CELRREDLS * (1-ART1731BIS) 
              + min( CELRREDLS, ACELRREDLS_2) * ART1731BIS
	     ) * ( 1 - V_CNR ) ;

DCELRREDLT = CELRREDLT;

ACELRREDLT = (CELRREDLT * (1-ART1731BIS) 
              + min( CELRREDLT, ACELRREDLT_2) * ART1731BIS
	     ) * ( 1 - V_CNR ) ;

DCELRREDLH = CELRREDLH;

ACELRREDLH = (CELRREDLH * (1-ART1731BIS) 
              + min( CELRREDLH, ACELRREDLH_2) * ART1731BIS
	     ) * ( 1 - V_CNR ) ;

DCELRREDLF = CELRREDLF;

ACELRREDLF = (CELRREDLF * (1-ART1731BIS) 
              + min( CELRREDLF, ACELRREDLF_2) * ART1731BIS
	     ) * ( 1 - V_CNR ) ;

DCELRREDLZ = CELRREDLZ;

ACELRREDLZ = (CELRREDLZ * (1-ART1731BIS) 
              + min( CELRREDLZ, ACELRREDLZ_2) * ART1731BIS
	     ) * ( 1 - V_CNR ) ;

DCELRREDLX = CELRREDLX;

ACELRREDLX = (CELRREDLX * (1-ART1731BIS) 
              + min( CELRREDLX, ACELRREDLX_2) * ART1731BIS
	     ) * ( 1 - V_CNR ) ;

DCELRREDLI = CELRREDLI;

ACELRREDLI = (CELRREDLI * (1-ART1731BIS) 
              + min( CELRREDLI, ACELRREDLI_2) * ART1731BIS
	     ) * ( 1 - V_CNR ) ;


DCELRREDMG = CELRREDMG;

ACELRREDMG = (CELRREDMG * (1-ART1731BIS) 
              + min( CELRREDMG, ACELRREDMG_2) * ART1731BIS
	     ) * ( 1 - V_CNR ) ;

DCELRREDMH = CELRREDMH;

ACELRREDMH = (CELRREDMH * (1-ART1731BIS) 
              + min( CELRREDMH, ACELRREDMH_2) * ART1731BIS
	     ) * ( 1 - V_CNR ) ;

DCELRREDLJ = CELRREDLJ;

ACELRREDLJ = (CELRREDLJ * (1-ART1731BIS) 
              + min( CELRREDLJ, ACELRREDLJ_2) * ART1731BIS
	     ) * ( 1 - V_CNR ) ;

DCELREPHS = CELREPHS; 

ACELREPHS = ( CELREPHS * (1 - ART1731BIS) 
              + min( CELREPHS, ACELREPHS_2) * ART1731BIS
            ) * ( 1 - V_CNR ) ; 

DCELREPHR = CELREPHR ;    

ACELREPHR = ( CELREPHR * (1 - ART1731BIS) 
              + min( CELREPHR, ACELREPHR_2) * ART1731BIS
            ) * ( 1 - V_CNR ) ; 


DCELREPHU = CELREPHU ; 

ACELREPHU = ( CELREPHU * (1 - ART1731BIS) 
              + min( CELREPHU, ACELREPHU_2) * ART1731BIS
            ) * ( 1 - V_CNR ) ; 

DCELREPHT = CELREPHT; 

ACELREPHT = ( CELREPHT * (1 - ART1731BIS) 
              + min( CELREPHT, ACELREPHT_2) * ART1731BIS
            ) * ( 1 - V_CNR ) ; 

DCELREPHZ = CELREPHZ; 

ACELREPHZ = ( CELREPHZ * (1 - ART1731BIS) 
              + min( CELREPHZ, ACELREPHZ_2) * ART1731BIS
            ) * ( 1 - V_CNR ) ; 

DCELREPHX = CELREPHX; 

ACELREPHX = ( CELREPHX * (1 - ART1731BIS) 
              + min( CELREPHX, ACELREPHX_2) * ART1731BIS
            ) * ( 1 - V_CNR ) ; 


DCELREPHW = CELREPHW; 

ACELREPHW = ( CELREPHW * (1 - ART1731BIS) 
              + min( CELREPHW, ACELREPHW_2) * ART1731BIS
            ) * ( 1 - V_CNR ) ; 

DCELREPHV = CELREPHV; 

ACELREPHV = ( CELREPHV * (1 - ART1731BIS) 
              + min( CELREPHV, ACELREPHV_2) * ART1731BIS
	    ) * ( 1 - V_CNR ) ;

DCELREPHF = CELREPHF; 

ACELREPHF = ( CELREPHF * (1 - ART1731BIS) 
              + min( CELREPHF, ACELREPHF_2) * ART1731BIS
	    ) * ( 1 - V_CNR ) ;

DCELREPHD = CELREPHD; 

ACELREPHD = ( CELREPHD * (1 - ART1731BIS) 
              + min( CELREPHD, ACELREPHD_2) * ART1731BIS
            ) * ( 1 - V_CNR ) ;

DCELREPHH = CELREPHH; 

ACELREPHH = ( CELREPHH * (1 - ART1731BIS) 
              + min( CELREPHH, ACELREPHH_2) * ART1731BIS
	    ) * ( 1 - V_CNR ) ;

DCELREPHG = CELREPHG; 

ACELREPHG = ( CELREPHG * (1 - ART1731BIS) 
              + min( CELREPHG, ACELREPHG_2) * ART1731BIS
	    ) * ( 1 - V_CNR ) ;


DCELREPHA = CELREPHA; 

ACELREPHA = ( CELREPHA * (1 - ART1731BIS) 
              + min( CELREPHA, ACELREPHA_2) * ART1731BIS
	    ) * ( 1 - V_CNR ) ;

DCELREPGU = CELREPGU; 

ACELREPGU = (CELREPGU * (1 - ART1731BIS) 
              + min( CELREPGU, ACELREPGU_2) * ART1731BIS
	    ) * ( 1 - V_CNR ) ;

DCELREPGX = CELREPGX; 

ACELREPGX = (CELREPGX * (1 - ART1731BIS) 
              + min( CELREPGX, ACELREPGX_2) * ART1731BIS
	    ) * ( 1 - V_CNR ) ;

DCELREPGS = CELREPGS; 

ACELREPGS = (CELREPGS * (1 - ART1731BIS) 
              + min( CELREPGS, ACELREPGS_2) * ART1731BIS
	    ) * ( 1 - V_CNR ) ;

DCELREPGW = CELREPGW; 

ACELREPGW = (CELREPGW * (1 - ART1731BIS) 
              + min( CELREPGW, ACELREPGW_2) * ART1731BIS
             ) * ( 1 - V_CNR ) ;

DCELREPGL = CELREPGL; 

ACELREPGL = (CELREPGL * (1 - ART1731BIS) 
              + min( CELREPGL, ACELREPGL_2) * ART1731BIS
             ) * ( 1 - V_CNR ) ;

DCELREPGV = CELREPGV; 

ACELREPGV = (CELREPGV * (1 - ART1731BIS) 
              + min( CELREPGV, ACELREPGV_2) * ART1731BIS
             ) * ( 1 - V_CNR ) ;

DCELREPGJ = CELREPGJ; 

ACELREPGJ = (CELREPGJ * (1 - ART1731BIS) 
              + min( CELREPGJ, ACELREPGJ_2) * ART1731BIS
             ) * ( 1 - V_CNR ) ;

DCELREPYH = CELREPYH; 

ACELREPYH = (CELREPYH * (1 - ART1731BIS) 
              + min( CELREPYH , ACELREPYH_2) * ART1731BIS
	    ) * ( 1 - V_CNR ) ;

DCELREPYL = CELREPYL; 

ACELREPYL = (CELREPYL * (1 - ART1731BIS) 
              + min( CELREPYL , ACELREPYL_2) * ART1731BIS
	    ) * ( 1 - V_CNR ) ;

DCELREPYF = CELREPYF; 

ACELREPYF = (CELREPYF * (1 - ART1731BIS) 
              + min( CELREPYF , ACELREPYF_2) * ART1731BIS
	    ) * ( 1 - V_CNR ) ;

DCELREPYK = CELREPYK; 

ACELREPYK = (CELREPYK * (1 - ART1731BIS) 
              + min( CELREPYK , ACELREPYK_2) * ART1731BIS
	    ) * ( 1 - V_CNR ) ;


DCELREPYD = CELREPYD; 

ACELREPYD = (CELREPYD * (1 - ART1731BIS) 
              + min( CELREPYD , ACELREPYD_2) * ART1731BIS
	    ) * ( 1 - V_CNR ) ;

DCELREPYJ = CELREPYJ; 

ACELREPYJ = (CELREPYJ * (1 - ART1731BIS) 
              + min( CELREPYJ , ACELREPYJ_2) * ART1731BIS
	    ) * ( 1 - V_CNR ) ;

DCELREPYB = CELREPYB; 

ACELREPYB = (CELREPYB * (1 - ART1731BIS) 
              + min( CELREPYB , ACELREPYB_2) * ART1731BIS
	    ) * ( 1 - V_CNR ) ;

DCELREPYP = CELREPYP; 

ACELREPYP = (CELREPYP * (1 - ART1731BIS) 
              + min( CELREPYP , ACELREPYP_2) * ART1731BIS
	    ) * ( 1 - V_CNR ) ;

DCELREPYS = CELREPYS; 

ACELREPYS = (CELREPYS * (1 - ART1731BIS) 
              + min( CELREPYS , ACELREPYS_2) * ART1731BIS
	    ) * ( 1 - V_CNR ) ;

DCELREPYO = CELREPYO; 

ACELREPYO = (CELREPYO * (1 - ART1731BIS) 
              + min( CELREPYO , ACELREPYO_2) * ART1731BIS
	    ) * ( 1 - V_CNR ) ;

DCELREPYR = CELREPYR; 

ACELREPYR = (CELREPYR * (1 - ART1731BIS) 
              + min( CELREPYR , ACELREPYR_2) * ART1731BIS
	    ) * ( 1 - V_CNR ) ;

DCELREPYN = CELREPYN; 

ACELREPYN = (CELREPYN * (1 - ART1731BIS) 
              + min( CELREPYN , ACELREPYN_2) * ART1731BIS
	    ) * ( 1 - V_CNR ) ;

DCELREPYQ = CELREPYQ; 

ACELREPYQ = (CELREPYQ * (1 - ART1731BIS) 
              + min( CELREPYQ , ACELREPYQ_2) * ART1731BIS
	    ) * ( 1 - V_CNR ) ;

DCELREPYM = CELREPYM; 

ACELREPYM = (CELREPYM * (1 - ART1731BIS) 
              + min( CELREPYM , ACELREPYM_2) * ART1731BIS
	    ) * ( 1 - V_CNR ) ;

DCELHM = CELLIERHM ; 

ACELHM_R = positif_ou_nul( CELLIERHM) * BCEL_HM * ( 1 - V_CNR ) ;

ACELHM = ( BCEL_HM * (1-ART1731BIS) 
           + min(BCEL_HM , ACELHM_2 )* ART1731BIS )
         * (positif_ou_nul(CELLIERHM)) * ( 1 - V_CNR ) ;

DCELHL = CELLIERHL ;    

ACELHL_R = positif_ou_nul( CELLIERHL) * BCEL_HL * ( 1 - V_CNR ) ;

ACELHL = ( BCEL_HL * (1-ART1731BIS) 
           + min(BCEL_HL , ACELHL_2 )* ART1731BIS )
         * (positif_ou_nul(CELLIERHL)) * ( 1 - V_CNR ) ;


DCELHNO = CELLIERHN + CELLIERHO ;

ACELHNO_R = positif_ou_nul( CELLIERHN + CELLIERHO ) * BCEL_HNO * ( 1 - V_CNR ) ;

ACELHNO = ( BCEL_HNO * (1-ART1731BIS) 
           + min(BCEL_HNO , ACELHNO_2 )* ART1731BIS )
         * (positif_ou_nul(CELLIERHN + CELLIERHO)) * ( 1 - V_CNR ) ;

DCELHJK = CELLIERHJ + CELLIERHK ;

ACELHJK_R = positif_ou_nul( CELLIERHJ + CELLIERHK ) * BCEL_HJK * ( 1 - V_CNR ) ;

ACELHJK = ( BCEL_HJK * (1-ART1731BIS) 
           + min(BCEL_HJK , ACELHJK_2 )* ART1731BIS )
         * (positif_ou_nul(CELLIERHJ + CELLIERHK)) * ( 1 - V_CNR ) ;


DCELNQ = CELLIERNQ;

ACELNQ_R = positif_ou_nul( CELLIERNQ) * BCEL_NQ * ( 1 - V_CNR ) ;

ACELNQ = ( BCEL_NQ * (1-ART1731BIS) 
           + min(BCEL_NQ , ACELNQ_2 )* ART1731BIS )
         * (positif_ou_nul(CELLIERNQ)) * ( 1 - V_CNR ) ;

DCELNBGL =   CELLIERNB + CELLIERNG + CELLIERNL;

ACELNBGL_R = positif_ou_nul( CELLIERNB + CELLIERNG + CELLIERNL ) * BCEL_NBGL 
             * ( 1 - V_CNR ) ;

ACELNBGL = ( BCEL_NBGL * (1-ART1731BIS) 
              + min(BCEL_NBGL , ACELNBGL_2 )* ART1731BIS )
           * positif_ou_nul(CELLIERNB + CELLIERNG + CELLIERNL) * ( 1 - V_CNR ) ;

DCELCOM =   CELLIERNP + CELLIERNR + CELLIERNS + CELLIERNT;

ACELCOM_R = positif_ou_nul(CELLIERNP + CELLIERNR + CELLIERNS + CELLIERNT) * BCELCOM2011 
            * ( 1 - V_CNR ) ;

ACELCOM = ( BCELCOM2011 * (1-ART1731BIS) 
           + min(BCELCOM2011 , ACELCOM_2 )* ART1731BIS )
          * positif_ou_nul(CELLIERNP + CELLIERNR + CELLIERNS + CELLIERNT) * ( 1 - V_CNR ) ;

CELSOMN = CELLIERNA+CELLIERNC+CELLIERND+CELLIERNE+CELLIERNF+CELLIERNH
	 +CELLIERNI+CELLIERNJ+CELLIERNK+CELLIERNM+CELLIERNN+CELLIERNO;  

DCEL = CELSOMN ; 

ACEL_R = positif_ou_nul( CELSOMN ) * BCEL_2011 * ( 1 - V_CNR ) ;

ACEL = (BCEL_2011 * (1 - ART1731BIS) 
         + min(BCEL_2011 , ACEL_2 ) * ART1731BIS)
          * positif_ou_nul(CELSOMN) * ( 1 - V_CNR ) ;

DCELJP = CELLIERJP;

ACELJP_R = positif_ou_nul( CELLIERJP) * BCEL_JP * ( 1 - V_CNR ) ;

ACELJP = (BCEL_JP * (1 - ART1731BIS) 
           + min(BCEL_JP , ACELJP_2 ) * ART1731BIS
         ) * positif_ou_nul(CELLIERJP) * ( 1 - V_CNR ) ;

DCELJBGL =   CELLIERJB + CELLIERJG + CELLIERJL;

ACELJBGL_R = positif_ou_nul( CELLIERJB + CELLIERJG + CELLIERJL ) * BCEL_JBGL 
             * ( 1 - V_CNR ) ;

ACELJBGL = (BCEL_JBGL * (1 - ART1731BIS) 
             + min(BCEL_JBGL , ACELJBGL_2 ) * ART1731BIS
           ) * positif_ou_nul(CELLIERJB+CELLIERJG+CELLIERJL) * ( 1 - V_CNR ) ;

DCELJOQR =   CELLIERJO + CELLIERJQ + CELLIERJR;

ACELJOQR_R = positif_ou_nul(CELLIERJO + CELLIERJQ + CELLIERJR) * BCEL_JOQR 
             * ( 1 - V_CNR ) ;

ACELJOQR = (BCEL_JOQR * (1 - ART1731BIS) 
             + min(BCEL_JOQR , ACELJOQR_2 ) * ART1731BIS
           )* positif_ou_nul(CELLIERJO + CELLIERJQ + CELLIERJR) * ( 1 - V_CNR ) ;


CELSOMJ = CELLIERJA + CELLIERJD + CELLIERJE + CELLIERJF + CELLIERJH 
	  + CELLIERJJ + CELLIERJK + CELLIERJM + CELLIERJN;

DCEL2012 = CELSOMJ ; 

ACEL2012_R = positif_ou_nul( CELSOMJ ) * BCEL_2012 * ( 1 - V_CNR ) ;

ACEL2012 = (BCEL_2012 * (1 - ART1731BIS) 
            + min( BCEL_2012 , max(ACEL2012_P+ ACEL2012P2 , ACEL20121731+0)*(1-PREM8_11)) * ART1731BIS)  
          * positif_ou_nul(CELSOMJ) * ( 1 - V_CNR ) ;

DCELFD = CELLIERFD ;

ACELFD_R = positif_ou_nul(DCELFD) * BCEL_FD * ( 1 - V_CNR ) ;

ACELFD = (BCEL_FD * (1 - ART1731BIS)
           + min( BCEL_FD , ACELFD_2 ) * ART1731BIS
         ) * positif_ou_nul(DCELFD) * ( 1 - V_CNR ) ;

DCELFABC = CELLIERFA + CELLIERFB + CELLIERFC ;

ACELFABC_R = positif_ou_nul(DCELFABC) * BCEL_FABC 
             * ( 1 - V_CNR ) ;

ACELFABC = (BCEL_FABC * (1 - ART1731BIS) 
             + min(BCEL_FABC , ACELFABC_2 ) * ART1731BIS
           ) * positif_ou_nul(DCELFABC) * ( 1 - V_CNR ) ; 


RCEL_HM = positif(CELLIERHM) * arr (ACELHM * (TX40/100)) 
             * ( 1 - V_CNR ) ;

RCEL_HM_R = positif(CELLIERHM) * arr (ACELHM_R * (TX40/100)) 
             * ( 1 - V_CNR ) ;

RCEL_HL = positif( CELLIERHL ) * arr (ACELHL * (TX25/100))
             * ( 1 - V_CNR ) ;

RCEL_HL_R = positif( CELLIERHL ) * arr (ACELHL_R * (TX25/100))
             * ( 1 - V_CNR ) ;

RCEL_HNO = (  positif(CELLIERHN) * arr(ACELHNO * (TX25/100))
	       + positif(CELLIERHO) * arr(ACELHNO * (TX40/100))
              ) * ( 1 - V_CNR ) ;

RCEL_HNO_R = (  positif(CELLIERHN) * arr(ACELHNO_R * (TX25/100))
	       + positif(CELLIERHO) * arr(ACELHNO_R * (TX40/100))
              ) * ( 1 - V_CNR ) ;

RCEL_HJK = (  positif(CELLIERHJ) * arr(ACELHJK * (TX25/100))
	      + positif(CELLIERHK) * arr(ACELHJK * (TX40/100))
             ) * ( 1 - V_CNR ) ;

RCEL_HJK_R = (  positif(CELLIERHJ) * arr(ACELHJK_R * (TX25/100))
	      + positif(CELLIERHK) * arr(ACELHJK_R * (TX40/100))
             ) * ( 1 - V_CNR ) ;

RCEL_NQ = ( positif(CELLIERNQ) * arr(ACELNQ * (TX40/100)) ) * ( 1 - V_CNR ) ;

RCEL_NQ_R = ( positif(CELLIERNQ) * arr(ACELNQ_R * (TX40/100)) ) * ( 1 - V_CNR ) ;


RCEL_NBGL = (  positif(CELLIERNB) * arr(ACELNBGL * (TX25/100))
	       + positif(CELLIERNG) * arr(ACELNBGL * (TX15/100))
	       + positif(CELLIERNL) * arr(ACELNBGL * (TX40/100))
              ) * ( 1 - V_CNR ) ;

RCEL_NBGL_R = (  positif(CELLIERNB) * arr(ACELNBGL_R * (TX25/100))
	       + positif(CELLIERNG) * arr(ACELNBGL_R * (TX15/100))
	       + positif(CELLIERNL) * arr(ACELNBGL_R * (TX40/100))
              ) * ( 1 - V_CNR ) ;

RCEL_COM = (  positif(CELLIERNP + CELLIERNT) * arr (ACELCOM * (TX36/100))
               + positif(CELLIERNR + CELLIERNS) * arr (ACELCOM * (TX40/100)) 
              ) * ( 1 - V_CNR ) ;

RCEL_COM_R = (  positif(CELLIERNP + CELLIERNT) * arr (ACELCOM_R * (TX36/100))
               + positif(CELLIERNR + CELLIERNS) * arr (ACELCOM_R * (TX40/100)) 
              ) * ( 1 - V_CNR ) ;

RCEL_2011 = (  positif(CELLIERNA + CELLIERNE) * arr (ACEL * (TX22/100))
            + positif(CELLIERNC + CELLIERND + CELLIERNH) * arr (ACEL * (TX25/100))
            + positif(CELLIERNF + CELLIERNJ) * arr (ACEL * (TX13/100))
            + positif(CELLIERNI) * arr (ACEL * (TX15/100))
	    + positif(CELLIERNM + CELLIERNN) * arr (ACEL * (TX40/100))
	    + positif(CELLIERNK + CELLIERNO) * arr (ACEL * (TX36/100))
            ) * ( 1 - V_CNR ) ;

RCEL_2011_R = (  positif(CELLIERNA + CELLIERNE) * arr (ACEL_R * (TX22/100))
            + positif(CELLIERNC + CELLIERND + CELLIERNH) * arr (ACEL_R * (TX25/100))
            + positif(CELLIERNF + CELLIERNJ) * arr (ACEL_R * (TX13/100))
            + positif(CELLIERNI) * arr (ACEL_R * (TX15/100))
	    + positif(CELLIERNM + CELLIERNN) * arr (ACEL_R * (TX40/100))
	    + positif(CELLIERNK + CELLIERNO) * arr (ACEL_R * (TX36/100))
            ) * ( 1 - V_CNR ) ;

RCEL_JP = ( positif(CELLIERJP) * arr(ACELJP * (TX36/100)) ) * ( 1 - V_CNR ) ;

RCEL_JP_R = ( positif(CELLIERJP) * arr(ACELJP_R * (TX36/100)) ) * ( 1 - V_CNR ) ;


RCEL_JBGL = (  positif(CELLIERJB) * arr(ACELJBGL * (TX22/100))
	       + positif(CELLIERJG) * arr(ACELJBGL * (TX13/100))
	       + positif(CELLIERJL) * arr(ACELJBGL * (TX36/100))
              ) * ( 1 - V_CNR ) ;

RCEL_JBGL_R = (  positif(CELLIERJB) * arr(ACELJBGL_R * (TX22/100))
	       + positif(CELLIERJG) * arr(ACELJBGL_R * (TX13/100))
	       + positif(CELLIERJL) * arr(ACELJBGL_R * (TX36/100))
              ) * ( 1 - V_CNR ) ;

RCEL_JOQR = (  positif(CELLIERJQ) * arr (ACELJOQR * (TX36/100))
               + positif(CELLIERJO + CELLIERJR) * arr (ACELJOQR * (TX24/100)) 
              ) * ( 1 - V_CNR ) ;

RCEL_JOQR_R = (  positif(CELLIERJQ) * arr (ACELJOQR_R * (TX36/100))
               + positif(CELLIERJO + CELLIERJR) * arr (ACELJOQR_R * (TX24/100)) 
              ) * ( 1 - V_CNR ) ;

RCEL_2012 = (  positif(CELLIERJA + CELLIERJE + CELLIERJH) * arr (ACEL2012 * (TX13/100)) 
            + positif(CELLIERJD) * arr (ACEL2012 * (TX22/100))
            + positif(CELLIERJF + CELLIERJJ) * arr (ACEL2012 * (TX6/100))
            + positif(CELLIERJK + CELLIERJN) * arr (ACEL2012 * (TX24/100))
	    + positif(CELLIERJM) * arr (ACEL2012 * (TX36/100))
	    ) * ( 1 - V_CNR ) ;

RCEL_2012_R = (  positif(CELLIERJA + CELLIERJE + CELLIERJH) * arr (ACEL2012_R * (TX13/100)) 
            + positif(CELLIERJD) * arr (ACEL2012_R * (TX22/100))
            + positif(CELLIERJF + CELLIERJJ) * arr (ACEL2012_R * (TX6/100))
            + positif(CELLIERJK + CELLIERJN) * arr (ACEL2012_R * (TX24/100))
	    + positif(CELLIERJM) * arr (ACEL2012_R * (TX36/100))
	    ) * ( 1 - V_CNR ) ;

RCEL_FD = positif( CELLIERFD ) * arr (ACELFD * (TX24/100))
             * ( 1 - V_CNR ) ;

RCEL_FD_R = positif( CELLIERFD ) * arr (ACELFD_R * (TX24/100))
             * ( 1 - V_CNR ) ;

RCEL_FABC = (  positif(CELLIERFA) * arr(ACELFABC * (TX13/100))
             + positif(CELLIERFB) * arr(ACELFABC * (TX6/100))
             + positif(CELLIERFC) * arr(ACELFABC * (TX24/100))
            ) * ( 1 - V_CNR ) ;

RCEL_FABC_R = (  positif(CELLIERFA) * arr(ACELFABC_R * (TX13/100))
               + positif(CELLIERFB) * arr(ACELFABC_R * (TX6/100))
               + positif(CELLIERFC) * arr(ACELFABC_R * (TX24/100))
              ) * ( 1 - V_CNR ) ;

RCELREP_HS = positif(CELREPHS) * arr (ACELREPHS * (TX40/100)) * ( 1 - V_CNR ) ;
RCELREP_HS_R = positif(CELREPHS) * arr (CELREPHS * (TX40/100)) * ( 1 - V_CNR ) ;

RCELREP_HR = positif( CELREPHR ) * arr (ACELREPHR * (TX25/100)) * ( 1 - V_CNR ) ;
RCELREP_HR_R = positif( CELREPHR ) * arr (CELREPHR * (TX25/100)) * ( 1 - V_CNR ) ;

RCELREP_HU = positif( CELREPHU ) * arr (ACELREPHU * (TX40/100)) * ( 1 - V_CNR ) ;
RCELREP_HU_R = positif( CELREPHU ) * arr (CELREPHU * (TX40/100)) * ( 1 - V_CNR ) ;

RCELREP_HT = positif( CELREPHT ) * arr (ACELREPHT * (TX25/100)) * ( 1 - V_CNR ) ;
RCELREP_HT_R = positif( CELREPHT ) * arr (CELREPHT * (TX25/100)) * ( 1 - V_CNR ) ;

RCELREP_HZ = positif( CELREPHZ ) * arr (ACELREPHZ * (TX40/100)) * ( 1 - V_CNR ) ;
RCELREP_HZ_R = positif( CELREPHZ ) * arr (CELREPHZ * (TX40/100)) * ( 1 - V_CNR ) ;

RCELREP_HX = positif( CELREPHX ) * arr (ACELREPHX * (TX25/100)) * ( 1 - V_CNR ) ;
RCELREP_HX_R = positif( CELREPHX ) * arr (CELREPHX * (TX25/100)) * ( 1 - V_CNR ) ;

RCELREP_HW = positif( CELREPHW ) * arr (ACELREPHW * (TX40/100)) * ( 1 - V_CNR ) ;
RCELREP_HW_R = positif( CELREPHW ) * arr (CELREPHW * (TX40/100)) * ( 1 - V_CNR ) ;

RCELREP_HV = positif( CELREPHV ) * arr (ACELREPHV * (TX25/100)) * ( 1 - V_CNR ) ;
RCELREP_HV_R = positif( CELREPHV ) * arr (CELREPHV * (TX25/100)) * ( 1 - V_CNR ) ;

regle 401310:
application : iliad , batch ;

REDUCAVTCEL_1 = RCOTFOR_1+RREPA_1+RAIDE_1+RDIFAGRI_1+RPRESSE_1+RFORET_1+RFIPDOM_1+RFIPC_1+RCINE_1+RRESTIMO_1+RSOCREPR_1
	      + RRPRESCOMP_1+RHEBE_1+RSURV_1+RINNO_1+RSOUFIP_1+RRIRENOV_1+RLOGDOM_1+RCOMP_1 + RRETU_1
              + RDONS_1 + CRDIE_1 + RDUFLOTOT_1 + RPINELTOT_1 + RNOUV_1 + RPLAFREPME4_1 + RPENTDY_1 + RFOR_1 + RTOURREP_1 + RTOUHOTR_1 + RTOUREPA_1 ;
REDUCAVTCEL = RCOTFOR + RREPA + RAIDE + RDIFAGRI + RPRESSE + RFORET + RFIPDOM + RFIPC + RCINE + RRESTIMO + RSOCREPR
	      + RRPRESCOMP + RHEBE + RSURV + RINNO + RSOUFIP + RRIRENOV + RLOGDOM + RCOMP + RRETU
              + RDONS + CRDIE + RDUFLOTOT + RPINELTOT + RNOUV + RPLAFREPME4 + RPENTDY + RFOR + RTOURREP + RTOUHOTR + RTOUREPA ;

RCELRREDLA_1 = max( min(CELRREDLA, IDOM11-DEC11 - REDUCAVTCEL_1 ) , 0 )
                * ( 1 - V_CNR ) ;

RCELRREDLA = max(0, RCELRREDLA_1 * (1 - ART1731BIS) 
                  + min( RCELRREDLA_1, RCELRREDLA_2) * ART1731BIS 
                ) ;

RCELRREDLB_1 = max( min(CELRREDLB , IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDLA_1 ) , 0 )
                * ( 1 - V_CNR ) ;

RCELRREDLB = max(0, RCELRREDLB_1 * (1 - ART1731BIS) 
                  +  min( RCELRREDLB_1, RCELRREDLB_2) * ART1731BIS
                ) ;

RCELRREDLE_1 = max( min(CELRREDLE, IDOM11-DEC11 - REDUCAVTCEL_1
                                   - RCELRREDLA_1-RCELRREDLB_1 ) , 0 )
                * ( 1 - V_CNR ) ;

RCELRREDLE = max(0, RCELRREDLE_1 * (1 - ART1731BIS) 
                  +  min( RCELRREDLE_1, RCELRREDLE_2) * ART1731BIS
                ) ;

RCELRREDLM_1 = max( min(CELRREDLM, IDOM11-DEC11 - REDUCAVTCEL_1
              - RCELRREDLA_1-RCELRREDLB_1-RCELRREDLE_1 ) , 0 )
                * ( 1 - V_CNR ) ;

RCELRREDLM = max(0, RCELRREDLM_1 * (1 - ART1731BIS) 
                  +  min( RCELRREDLM_1, RCELRREDLM_2) * ART1731BIS
                ) ;

RCELRREDLN_1 = max( min(CELRREDLN, IDOM11-DEC11 - REDUCAVTCEL_1
              - RCELRREDLA_1-RCELRREDLB_1-RCELRREDLE_1-RCELRREDLM_1 ) , 0 )
                * ( 1 - V_CNR ) ;

RCELRREDLN = max(0, RCELRREDLN_1 * (1 - ART1731BIS) 
                  +  min( RCELRREDLN_1, RCELRREDLN_2) * ART1731BIS
                ) ;

RCELRREDLG_1 = max( min(CELRREDLG, IDOM11-DEC11 - REDUCAVTCEL_1
              - RCELRREDLA_1-RCELRREDLB_1-RCELRREDLE_1-RCELRREDLM_1-RCELRREDLN_1 ) , 0 )
                * ( 1 - V_CNR ) ;

RCELRREDLG = max(0, RCELRREDLG_1 * (1 - ART1731BIS) 
                  +  min( RCELRREDLG_1, RCELRREDLG_2) * ART1731BIS
                ) ;

RCELRREDLC_1 = max( min(CELRREDLC, IDOM11-DEC11 - REDUCAVTCEL_1
              - RCELRREDLA_1-RCELRREDLB_1-RCELRREDLE_1-RCELRREDLM_1-RCELRREDLN_1-RCELRREDLG_1 ) , 0 )
                * ( 1 - V_CNR ) ;

RCELRREDLC = max(0, RCELRREDLC_1 * (1 - ART1731BIS) 
                  +  min( RCELRREDLC_1, RCELRREDLC_2) * ART1731BIS
                ) ;

RCELRREDLD_1 = max( min(CELRREDLD , IDOM11-DEC11 - REDUCAVTCEL_1
              -RCELRREDLA_1-RCELRREDLB_1-RCELRREDLE_1-RCELRREDLM_1-RCELRREDLN_1-RCELRREDLG_1 
              -RCELRREDLC_1 ) , 0 )
                * ( 1 - V_CNR ) ;

RCELRREDLD = max(0, RCELRREDLD_1 * (1 - ART1731BIS) 
                  +  min( RCELRREDLD_1, RCELRREDLD_2) * ART1731BIS 
                ) ;

RCELRREDLS_1 = max( min(CELRREDLS , IDOM11-DEC11 - REDUCAVTCEL_1 
              -RCELRREDLA_1-RCELRREDLB_1-RCELRREDLE_1-RCELRREDLM_1-RCELRREDLN_1-RCELRREDLG_1 
              -RCELRREDLC_1-RCELRREDLD_1 ) , 0 )
                * ( 1 - V_CNR ) ;

RCELRREDLS = max(0, RCELRREDLS_1 * (1 - ART1731BIS) 
                  +  min( RCELRREDLS_1, RCELRREDLS_2) * ART1731BIS
                ) ;

RCELRREDLT_1 = max( min(CELRREDLT, IDOM11-DEC11 - REDUCAVTCEL_1 
              -RCELRREDLA_1-RCELRREDLB_1-RCELRREDLE_1-RCELRREDLM_1-RCELRREDLN_1-RCELRREDLG_1 
              -RCELRREDLC_1-RCELRREDLD_1-RCELRREDLS_1 ) , 0 )
                * ( 1 - V_CNR ) ;

RCELRREDLT = max(0, RCELRREDLT_1 * (1 - ART1731BIS) 
                  +  min( RCELRREDLT_1, RCELRREDLT_2) * ART1731BIS
                ) ;

RCELRREDLH_1 = max( min(CELRREDLH, IDOM11-DEC11 - REDUCAVTCEL_1
              -RCELRREDLA_1-RCELRREDLB_1-RCELRREDLE_1-RCELRREDLM_1-RCELRREDLN_1-RCELRREDLG_1 
              -RCELRREDLC_1-RCELRREDLD_1-RCELRREDLS_1-RCELRREDLT_1 ) , 0 )
                * ( 1 - V_CNR ) ;

RCELRREDLH = max(0, RCELRREDLH_1 * (1 - ART1731BIS) 
                  +  min( RCELRREDLH_1, RCELRREDLH_2) * ART1731BIS
                ) ;

RCELRREDLF_1 = max( min(CELRREDLF, IDOM11-DEC11 - REDUCAVTCEL_1 
              -RCELRREDLA_1-RCELRREDLB_1-RCELRREDLE_1-RCELRREDLM_1-RCELRREDLN_1-RCELRREDLG_1 
              -RCELRREDLC_1-RCELRREDLD_1-RCELRREDLS_1-RCELRREDLT_1-RCELRREDLH_1 ) , 0 )
                * ( 1 - V_CNR ) ;

RCELRREDLF = max(0, RCELRREDLF_1 * (1 - ART1731BIS) 
                  +  min( RCELRREDLF_1, RCELRREDLF_2) * ART1731BIS
                ) ;

RCELRREDLZ_1 = max( min(CELRREDLZ, IDOM11-DEC11 - REDUCAVTCEL_1 
              -RCELRREDLA_1-RCELRREDLB_1-RCELRREDLE_1-RCELRREDLM_1-RCELRREDLN_1-RCELRREDLG_1 
              -RCELRREDLC_1-RCELRREDLD_1-RCELRREDLS_1-RCELRREDLT_1-RCELRREDLH_1-RCELRREDLF_1 ) , 0 )
                * ( 1 - V_CNR ) ;

RCELRREDLZ = max(0, RCELRREDLZ_1 * (1 - ART1731BIS) 
                  +  min( RCELRREDLZ_1, RCELRREDLZ_2) * ART1731BIS
                ) ;

RCELRREDLX_1 = max( min(CELRREDLX, IDOM11-DEC11 - REDUCAVTCEL_1 
              -RCELRREDLA_1-RCELRREDLB_1-RCELRREDLE_1-RCELRREDLM_1-RCELRREDLN_1-RCELRREDLG_1 
              -RCELRREDLC_1-RCELRREDLD_1-RCELRREDLS_1-RCELRREDLT_1-RCELRREDLH_1-RCELRREDLF_1 
              -RCELRREDLZ_1) , 0 )
                * ( 1 - V_CNR ) ;

RCELRREDLX = max(0, RCELRREDLX_1 * (1 - ART1731BIS) 
                  +  min( RCELRREDLX_1, RCELRREDLX_2) * ART1731BIS

                ) ;

RCELRREDLI_1 = max( min(CELRREDLI, IDOM11-DEC11 - REDUCAVTCEL_1 
              -RCELRREDLA_1-RCELRREDLB_1-RCELRREDLE_1-RCELRREDLM_1-RCELRREDLN_1-RCELRREDLG_1 
              -RCELRREDLC_1-RCELRREDLD_1-RCELRREDLS_1-RCELRREDLT_1-RCELRREDLH_1-RCELRREDLF_1 
              -RCELRREDLZ_1-RCELRREDLX_1) , 0 )
                * ( 1 - V_CNR ) ;

RCELRREDLI = max(0, RCELRREDLI_1 * (1 - ART1731BIS) 
                  +  min( RCELRREDLI_1, RCELRREDLI_2) * ART1731BIS
                ) ;

RCELRREDMG_1 = max( min(CELRREDMG, IDOM11-DEC11 - REDUCAVTCEL_1 
              -RCELRREDLA_1-RCELRREDLB_1-RCELRREDLE_1-RCELRREDLM_1-RCELRREDLN_1-RCELRREDLG_1 
              -RCELRREDLC_1-RCELRREDLD_1-RCELRREDLS_1-RCELRREDLT_1-RCELRREDLH_1-RCELRREDLF_1 
              -RCELRREDLZ_1-RCELRREDLX_1-RCELRREDLI_1) , 0 )
                * ( 1 - V_CNR ) ;

RCELRREDMG = max(0, RCELRREDMG_1 * (1 - ART1731BIS) 
                  + min ( RCELRREDMG_1 , RCELRREDMG_2 ) * ART1731BIS
                ) ;

RCELRREDMH_1 = max( min(CELRREDMH, IDOM11-DEC11 - REDUCAVTCEL_1 
              -RCELRREDLA_1-RCELRREDLB_1-RCELRREDLE_1-RCELRREDLM_1-RCELRREDLN_1-RCELRREDLG_1 
              -RCELRREDLC_1-RCELRREDLD_1-RCELRREDLS_1-RCELRREDLT_1-RCELRREDLH_1-RCELRREDLF_1 
              -RCELRREDLZ_1-RCELRREDLX_1-RCELRREDLI_1-RCELRREDMG_1) , 0 )
                * ( 1 - V_CNR ) ;

RCELRREDMH = max(0, RCELRREDMH_1 * (1 - ART1731BIS) 
                  + min ( RCELRREDMH_1 , RCELRREDMH_2 ) * ART1731BIS
                ) ;

RCELRREDLJ_1 = max( min(CELRREDLJ, IDOM11-DEC11 - REDUCAVTCEL_1 
              -RCELRREDLA_1-RCELRREDLB_1-RCELRREDLE_1-RCELRREDLM_1-RCELRREDLN_1-RCELRREDLG_1 
              -RCELRREDLC_1-RCELRREDLD_1-RCELRREDLS_1-RCELRREDLT_1-RCELRREDLH_1-RCELRREDLF_1 
              -RCELRREDLZ_1-RCELRREDLX_1-RCELRREDLI_1-RCELRREDMG_1-RCELRREDMH_1) , 0 )
                * ( 1 - V_CNR ) ;

RCELRREDLJ = max(0, RCELRREDLJ_1 * (1 - ART1731BIS) 
                  +  min( RCELRREDLJ_1, RCELRREDLJ_2) * ART1731BIS
                ) ;

RCELRREDSOM_1 = somme (i=A,B,E,M,N,G,C,D,S,T,H,F,Z,X,I,J : RCELRREDLi_1) + RCELRREDMG_1 + RCELRREDMH_1 ;

RCELRREDSOM = somme (i=A,B,E,M,N,G,C,D,S,T,H,F,Z,X,I,J : RCELRREDLi) + RCELRREDMG + RCELRREDMH ;

RCELREPHS_1 = max( min( RCELREP_HS ,IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1) , 0) 
              * (1 - V_CNR) ;

RCELREPHS = max( 0, RCELREPHS_1 * (1 - ART1731BIS)
                  +  min( RCELREPHS_1, RCELREPHS_2) * ART1731BIS
	       ) * (1 - V_CNR) ;

RCELREPHR_1 = max( min( RCELREP_HR ,IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1
	                            - RCELREPHS_1 ) , 0)
	      * (1 - V_CNR) ;

RCELREPHR = max( 0, RCELREPHR_1 * (1 - ART1731BIS)
                  + min (RCELREPHR_1 , RCELREPHR_2) * ART1731BIS
	       ) * (1 - V_CNR) ;

RCELREPHU_1 = max( min( RCELREP_HU , IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1
         	                     - RCELREPHS_1-RCELREPHR_1 ) , 0)
	      * (1 - V_CNR) ;

RCELREPHU = max( 0, RCELREPHU_1 * (1 - ART1731BIS)
                  + min (RCELREPHU_1 , RCELREPHU_2 ) * ART1731BIS
	       ) * (1 - V_CNR) ;

RCELREPHT_1 = max( min( RCELREP_HT, IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1 
	                             - RCELREPHS_1-RCELREPHR_1-RCELREPHU_1 ) , 0)
              * (1 - V_CNR) ;

RCELREPHT = max( 0, RCELREPHT_1 * (1 - ART1731BIS)
                  +  min( RCELREPHT_1, RCELREPHT_2) * ART1731BIS
	       ) * (1 - V_CNR) ;

RCELREPHZ_1 = max( min( RCELREP_HZ , IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1
	                              - RCELREPHS_1-RCELREPHR_1-RCELREPHU_1-RCELREPHT_1 ) , 0)
              * (1 - V_CNR) ;

RCELREPHZ = max( 0, RCELREPHZ_1 * (1 - ART1731BIS)
                  +  min( RCELREPHZ_1, RCELREPHZ_2) * ART1731BIS
	       ) * (1 - V_CNR) ;

RCELREPHX_1 = max( min( RCELREP_HX , IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1
	                             - RCELREPHS_1-RCELREPHR_1-RCELREPHU_1-RCELREPHT_1-RCELREPHZ_1 ) , 0)
              * (1 - V_CNR) ;

RCELREPHX = max( 0, RCELREPHX_1 * (1 - ART1731BIS)
                  +  min( RCELREPHX_1, RCELREPHX_2) * ART1731BIS
	       ) * (1 - V_CNR) ;

RCELREPHW_1 = max( min( RCELREP_HW , IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1
	                             - RCELREPHS_1-RCELREPHR_1-RCELREPHU_1-RCELREPHT_1-RCELREPHZ_1-RCELREPHX_1 ) , 0)
              * (1 - V_CNR) ;

RCELREPHW = max( 0, RCELREPHW_1 * (1 - ART1731BIS)
                  +  min( RCELREPHW_1, RCELREPHW_2) * ART1731BIS
	       ) * (1 - V_CNR) ;

RCELREPHV_1 = max( min( RCELREP_HV , IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1
	                             - RCELREPHS_1-RCELREPHR_1-RCELREPHU_1-RCELREPHT_1-RCELREPHZ_1-RCELREPHX_1-RCELREPHW_1 ) , 0)
              * (1 - V_CNR) ;

RCELREPHV = max( 0, RCELREPHV_1 * (1 - ART1731BIS)
                  +  min( RCELREPHV_1, RCELREPHV_2) * ART1731BIS
	       ) * (1 - V_CNR) ;

RCELREPHF_1 = max( min( CELREPHF , IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1
	                            -somme (i=S,R,U,T,Z,X,W,V : RCELREPHi_1) ) , 0)
	      * (1 - V_CNR) ;

RCELREPHF = max( 0, RCELREPHF_1 * (1 - ART1731BIS)
                  +  min( RCELREPHF_1, RCELREPHF_2) * ART1731BIS
	       ) * (1 - V_CNR) ;

RCELREPHD_1 = max( min( CELREPHD , IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1
	                            -somme (i=S,R,U,T,Z,X,W,V,F : RCELREPHi_1) ) , 0)
	    * (1 - V_CNR) ;

RCELREPHD = max( 0, RCELREPHD_1 * (1 - ART1731BIS)
                  +  min( RCELREPHD_1, RCELREPHD_2) * ART1731BIS
	       ) * (1 - V_CNR) ;

RCELREPHH_1 = max( min( CELREPHH , IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1
	                            -somme (i=S,R,U,T,Z,X,W,V,F,D : RCELREPHi_1) ) , 0)
	      * (1 - V_CNR) ;

RCELREPHH = max( 0, RCELREPHH_1 * (1 - ART1731BIS)
                  +  min( RCELREPHH_1, RCELREPHH_2) * ART1731BIS
	       ) * (1 - V_CNR) ;

RCELREPHG_1 = max( min( CELREPHG , IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1
	                            -somme (i=S,R,U,T,Z,X,W,V,F,D,H : RCELREPHi_1) ) , 0)
	      * (1 - V_CNR) ;

RCELREPHG = max( 0, RCELREPHG_1 * (1 - ART1731BIS)
                  +  min( RCELREPHG_1, RCELREPHG_2) * ART1731BIS
	       ) * (1 - V_CNR) ;

RCELREPHA_1 = max( min( CELREPHA , IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1
	                            -somme (i=S,R,U,T,Z,X,W,V,F,D,H,G : RCELREPHi_1) ) , 0)
	      * (1 - V_CNR) ;

RCELREPHA = max( 0, RCELREPHA_1 * (1 - ART1731BIS)
                  +  min( RCELREPHA_1, RCELREPHA_2) * ART1731BIS
	       ) * (1 - V_CNR) ;

RCELREPGU_1 = max( min( CELREPGU , IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1
	                            -somme (i=S,R,U,T,Z,X,W,V,F,D,H,G,A : RCELREPHi_1) ) , 0)
	      *  (1 - V_CNR) ;

RCELREPGU = max( 0, RCELREPGU_1 * (1 - ART1731BIS)
                  +  min( RCELREPGU_1, RCELREPGU_2) * ART1731BIS
               ) * (1 - V_CNR) ;

RCELREPGX_1 = max( min( CELREPGX , IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1
	                            -somme (i=S,R,U,T,Z,X,W,V,F,D,H,G,A : RCELREPHi_1)
                                    -RCELREPGU_1 ) , 0)
	      * (1 - V_CNR) ;

RCELREPGX = max( 0, RCELREPGX_1 * (1 - ART1731BIS)
                  +  min( RCELREPGX_1, RCELREPGX_2) * ART1731BIS
               ) * (1 - V_CNR) ;

RCELREPGS_1 = max( min( CELREPGS , IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1
	                            -somme (i=S,R,U,T,Z,X,W,V,F,D,H,G,A : RCELREPHi_1)
                                    -somme (i=U,X : RCELREPGi_1 ) ) , 0)
	      * (1 - V_CNR) ;

RCELREPGS = max( 0, RCELREPGS_1 * (1 - ART1731BIS)
                  +  min( RCELREPGS_1, RCELREPGS_2) * ART1731BIS
               ) * (1 - V_CNR) ;

RCELREPGW_1 = max( min( CELREPGW , IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1
	                            -somme (i=S,R,U,T,Z,X,W,V,F,D,H,G,A : RCELREPHi_1)
                                    -somme (i=U,X,S : RCELREPGi_1 ) ) , 0)
	      * (1 - V_CNR) ;

RCELREPGW = max( 0, RCELREPGW_1 * (1 - ART1731BIS)
                  +  min( RCELREPGW_1, RCELREPGW_2) * ART1731BIS
               ) * (1 - V_CNR) ;

RCELREPGL_1 = max( min( CELREPGL , IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1
	                            -somme (i=S,R,U,T,Z,X,W,V,F,D,H,G,A : RCELREPHi_1)
                                    -somme (i=U,X,S,W : RCELREPGi_1 )) , 0)
	      * (1 - V_CNR) ;

RCELREPGL = max( 0, RCELREPGL_1 * (1 - ART1731BIS)
                  +  min( RCELREPGL_1, RCELREPGL_2) * ART1731BIS
               ) * (1 - V_CNR) ;

RCELREPGV_1 = max( min( CELREPGV , IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1
	                            -somme (i=S,R,U,T,Z,X,W,V,F,D,H,G,A : RCELREPHi_1)
                                    -somme (i=U,X,S,W,L : RCELREPGi_1 )) , 0)
	      * (1 - V_CNR) ;

RCELREPGV = max( 0, RCELREPGV_1 * (1 - ART1731BIS)
                  +  min( RCELREPGV_1, RCELREPGV_2) * ART1731BIS
               ) * (1 - V_CNR) ;

RCELREPGJ_1 = max( min( CELREPGJ , IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1
	                            -somme (i=S,R,U,T,Z,X,W,V,F,D,H,G,A : RCELREPHi_1)
                                    -somme (i=U,X,S,W,L,V : RCELREPGi_1 )) , 0)
	      * (1 - V_CNR) ;

RCELREPGJ = max( 0, RCELREPGJ_1 * (1 - ART1731BIS)
                  +  min( RCELREPGJ_1, RCELREPGJ_2) * ART1731BIS
               ) * (1 - V_CNR) ;

RCELREPYH_1 = max( min( CELREPYH , IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1
	                            -somme (i=S,R,U,T,Z,X,W,V,F,D,H,G,A : RCELREPHi_1)
                                    -somme (i=U,X,S,W,L,V,J : RCELREPGi_1 )) , 0)
	      * (1 - V_CNR) ;

RCELREPYH = max( 0, RCELREPYH_1 * (1 - ART1731BIS)
                  + min (RCELREPYH_1 , RCELREPYH_2) * ART1731BIS
               ) * (1 - V_CNR) ;

RCELREPYL_1 = max( min( CELREPYL , IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1
	                            -somme (i=S,R,U,T,Z,X,W,V,F,D,H,G,A : RCELREPHi_1)
                                    -somme (i=U,X,S,W,L,V,J : RCELREPGi_1 )
                                    -RCELREPYH_1) , 0)
	      * (1 - V_CNR) ;

RCELREPYL = max( 0, RCELREPYL_1 * (1 - ART1731BIS)
                  + min (RCELREPYL_1 , RCELREPYL_2) * ART1731BIS
               ) * (1 - V_CNR) ;

RCELREPYF_1 = max( min( CELREPYF , IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1
	                            -somme (i=S,R,U,T,Z,X,W,V,F,D,H,G,A : RCELREPHi_1)
                                    -somme (i=U,X,S,W,L,V,J : RCELREPGi_1 )
                                    -somme (i=H,L : RCELREPYi_1 )) , 0)
	      * (1 - V_CNR) ;

RCELREPYF = max( 0, RCELREPYF_1 * (1 - ART1731BIS)
                  + min (RCELREPYF_1 , RCELREPYF_2) * ART1731BIS
               ) * (1 - V_CNR) ;

RCELREPYK_1 = max( min( CELREPYK , IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1
	                            -somme (i=S,R,U,T,Z,X,W,V,F,D,H,G,A : RCELREPHi_1)
                                    -somme (i=U,X,S,W,L,V,J : RCELREPGi_1 )
                                    -somme (i=H,L,F : RCELREPYi_1 )) , 0)
	      * (1 - V_CNR) ;

RCELREPYK = max( 0, RCELREPYK_1 * (1 - ART1731BIS)
                  + min (RCELREPYK_1 , RCELREPYK_2) * ART1731BIS
               ) * (1 - V_CNR) ;

RCELREPYD_1 = max( min( CELREPYD , IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1
	                            -somme (i=S,R,U,T,Z,X,W,V,F,D,H,G,A : RCELREPHi_1)
                                    -somme (i=U,X,S,W,L,V,J : RCELREPGi_1 )
                                    -somme (i=H,L,F,K : RCELREPYi_1 )) , 0)
	      * (1 - V_CNR) ;

RCELREPYD = max( 0, RCELREPYD_1 * (1 - ART1731BIS)
                  + min (RCELREPYD_1 , RCELREPYD_2) * ART1731BIS
               ) * (1 - V_CNR) ;

RCELREPYJ_1 = max( min( CELREPYJ , IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1
	                            -somme (i=S,R,U,T,Z,X,W,V,F,D,H,G,A : RCELREPHi_1)
                                    -somme (i=U,X,S,W,L,V,J : RCELREPGi_1 )
                                    -somme (i=H,L,F,K,D : RCELREPYi_1 )) , 0)
	      * (1 - V_CNR) ;

RCELREPYJ = max( 0, RCELREPYJ_1 * (1 - ART1731BIS)
                  + min (RCELREPYJ_1 , RCELREPYJ_2) * ART1731BIS
               ) * (1 - V_CNR) ;

RCELREPYB_1 = max( min( CELREPYB , IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1
	                            -somme (i=S,R,U,T,Z,X,W,V,F,D,H,G,A : RCELREPHi_1)
                                    -somme (i=U,X,S,W,L,V,J : RCELREPGi_1 )
                                    -somme (i=H,L,F,K,D,J : RCELREPYi_1 )) , 0)
	      * (1 - V_CNR) ;

RCELREPYB = max( 0, RCELREPYB_1 * (1 - ART1731BIS)
                  + min (RCELREPYB_1 , RCELREPYB_2) * ART1731BIS
               ) * (1 - V_CNR) ;

RCELREPYP_1 = max( min( CELREPYP , IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1
	                            -somme (i=S,R,U,T,Z,X,W,V,F,D,H,G,A : RCELREPHi_1)
                                    -somme (i=U,X,S,W,L,V,J : RCELREPGi_1 )
                                    -somme (i=H,L,F,K,D,J,B : RCELREPYi_1 )) , 0)
	      * (1 - V_CNR) ;

RCELREPYP = max( 0, RCELREPYP_1 * (1 - ART1731BIS)
                  + min (RCELREPYP_1 , RCELREPYP_2) * ART1731BIS
               ) * (1 - V_CNR) ;

RCELREPYS_1 = max( min( CELREPYS , IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1
	                            -somme (i=S,R,U,T,Z,X,W,V,F,D,H,G,A : RCELREPHi_1)
                                    -somme (i=U,X,S,W,L,V,J : RCELREPGi_1 )
                                    -somme (i=H,L,F,K,D,J,B,P : RCELREPYi_1 )) , 0)
	      * (1 - V_CNR) ;

RCELREPYS = max( 0, RCELREPYS_1 * (1 - ART1731BIS)
                  + min (RCELREPYS_1 , RCELREPYS_2) * ART1731BIS
               ) * (1 - V_CNR) ;

RCELREPYO_1 = max( min( CELREPYO , IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1
	                            -somme (i=S,R,U,T,Z,X,W,V,F,D,H,G,A : RCELREPHi_1)
                                    -somme (i=U,X,S,W,L,V,J : RCELREPGi_1 )
                                    -somme (i=H,L,F,K,D,J,B,P,S : RCELREPYi_1 )) , 0)
	      * (1 - V_CNR) ;

RCELREPYO = max( 0, RCELREPYO_1 * (1 - ART1731BIS)
                  + min (RCELREPYO_1 , RCELREPYO_2) * ART1731BIS
               ) * (1 - V_CNR) ;

RCELREPYR_1 = max( min( CELREPYR , IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1
	                            -somme (i=S,R,U,T,Z,X,W,V,F,D,H,G,A : RCELREPHi_1)
                                    -somme (i=U,X,S,W,L,V,J : RCELREPGi_1 )
                                    -somme (i=H,L,F,K,D,J,B,P,S,O : RCELREPYi_1 )) , 0)
	      * (1 - V_CNR) ;

RCELREPYR = max( 0, RCELREPYR_1 * (1 - ART1731BIS)
                  + min (RCELREPYR_1 , RCELREPYR_2) * ART1731BIS
               ) * (1 - V_CNR) ;

RCELREPYN_1 = max( min( CELREPYN , IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1
	                            -somme (i=S,R,U,T,Z,X,W,V,F,D,H,G,A : RCELREPHi_1)
                                    -somme (i=U,X,S,W,L,V,J : RCELREPGi_1 )
                                    -somme (i=H,L,F,K,D,J,B,P,S,O,R : RCELREPYi_1 )) , 0)
	      * (1 - V_CNR) ;

RCELREPYN = max( 0, RCELREPYN_1 * (1 - ART1731BIS)
                  + min (RCELREPYN_1 , RCELREPYN_2) * ART1731BIS
               ) * (1 - V_CNR) ;

RCELREPYQ_1 = max( min( CELREPYQ , IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1
	                            -somme (i=S,R,U,T,Z,X,W,V,F,D,H,G,A : RCELREPHi_1)
                                    -somme (i=U,X,S,W,L,V,J : RCELREPGi_1 )
                                    -somme (i=H,L,F,K,D,J,B,P,S,O,R,N : RCELREPYi_1 )) , 0)
	      * (1 - V_CNR) ;

RCELREPYQ = max( 0, RCELREPYQ_1 * (1 - ART1731BIS)
                  + min (RCELREPYQ_1 , RCELREPYQ_2) * ART1731BIS
               ) * (1 - V_CNR) ;

RCELREPYM_1 = max( min( CELREPYM , IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1
	                            -somme (i=S,R,U,T,Z,X,W,V,F,D,H,G,A : RCELREPHi_1)
                                    -somme (i=U,X,S,W,L,V,J : RCELREPGi_1 )
                                    -somme (i=H,L,F,K,D,J,B,P,S,O,R,N,Q : RCELREPYi_1 )) , 0)
	      * (1 - V_CNR) ;

RCELREPYM = max( 0, RCELREPYM_1 * (1 - ART1731BIS)
                  + min (RCELREPYM_1 , RCELREPYQ_2) * ART1731BIS
               ) * (1 - V_CNR) ;

RCELHM_1 = max( min( RCEL_HM_R , 
                  IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1 
	          -somme (i=S,R,U,T,Z,X,W,V,F,D,H,G,A : RCELREPHi_1)
                  -somme (i=U,X,S,W,L,V,J : RCELREPGi_1 )
                  -somme (i=H,L,F,K,D,J,B,P,S,O,R,N,Q,M : RCELREPYi_1 )) , 0)
	  * (1 - V_CNR) ;

RCELHM = max( 0, RCELHM_1 * (1 - ART1731BIS)
               + min (RCELHM_1 , RCELHM_2) * ART1731BIS
	    ) * (1 - V_CNR) ;

RCELHL_1 = (max( min( RCEL_HL_R , 
                  IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1 
	          -somme (i=S,R,U,T,Z,X,W,V,F,D,H,G,A : RCELREPHi_1)
                  -somme (i=U,X,S,W,L,V,J : RCELREPGi_1 )
                  -somme (i=H,L,F,K,D,J,B,P,S,O,R,N,Q,M : RCELREPYi_1 )
                  -RCELHM_1) , 0 ))
	   * (1 - V_CNR) ;

RCELHL = max( 0, RCELHL_1 * (1 - ART1731BIS)
               + min (RCELHL_1 , RCELHL_2) * ART1731BIS
	    ) * (1 - V_CNR) ;

RCELHNO_1 = (max( min( RCEL_HNO_R ,
                  IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1 
	          -somme (i=S,R,U,T,Z,X,W,V,F,D,H,G,A : RCELREPHi_1)
                  -somme (i=U,X,S,W,L,V,J : RCELREPGi_1 )
                  -somme (i=H,L,F,K,D,J,B,P,S,O,R,N,Q,M : RCELREPYi_1 )
	          -RCELHM_1-RCELHL_1) , 0 ))
	   * (1 - V_CNR) ;

RCELHNO = max( 0, RCELHNO_1 * (1 - ART1731BIS)
               + min (RCELHNO_1 , RCELHNO_2) * ART1731BIS
	    ) * (1 - V_CNR) ;

RCELHJK_1 = (max( min( RCEL_HJK_R , 
                  IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1 
	          -somme (i=S,R,U,T,Z,X,W,V,F,D,H,G,A : RCELREPHi_1)
                  -somme (i=U,X,S,W,L,V,J : RCELREPGi_1 )
                  -somme (i=H,L,F,K,D,J,B,P,S,O,R,N,Q,M : RCELREPYi_1 )
	          -RCELHM_1-RCELHL_1-RCELHNO_1) , 0 ))
	   * (1 - V_CNR) ;

RCELHJK = max( 0, RCELHJK_1 * (1 - ART1731BIS)
               + min (RCELHJK_1 , RCELHJK_2) * ART1731BIS
	    ) * (1 - V_CNR) ;

RCELNQ_1 = max( min( RCEL_NQ_R , 
                  IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1 
	          -somme (i=S,R,U,T,Z,X,W,V,F,D,H,G,A : RCELREPHi_1)
                  -somme (i=U,X,S,W,L,V,J : RCELREPGi_1 )
                  -somme (i=H,L,F,K,D,J,B,P,S,O,R,N,Q,M : RCELREPYi_1 )
	          -RCELHM_1-RCELHL_1-RCELHNO_1-RCELHJK_1 ) , 0 )
	 * (1 - V_CNR) ;

RCELNQ = max( 0, RCELNQ_1 * (1 - ART1731BIS)
               + min (RCELNQ_1 , RCELNQ_2) * ART1731BIS
	    ) * (1 - V_CNR) ;

RCELNBGL_1 = max( min( RCEL_NBGL_R , 
                  IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1 
	          -somme (i=S,R,U,T,Z,X,W,V,F,D,H,G,A : RCELREPHi_1)
                  -somme (i=U,X,S,W,L,V,J : RCELREPGi_1 )
                  -somme (i=H,L,F,K,D,J,B,P,S,O,R,N,Q,M : RCELREPYi_1 )
	          -RCELHM_1-RCELHL_1-RCELHNO_1-RCELHJK_1-RCELNQ_1 ) , 0 )
	   * (1 - V_CNR) ;

RCELNBGL = max( 0, RCELNBGL_1 * (1 - ART1731BIS)
               + min (RCELNBGL_1 , RCELNBGL_2) * ART1731BIS
	      ) * (1 - V_CNR) ;

RCELCOM_1 = (max( min( RCEL_COM_R , 
                  IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1 
	          -somme (i=S,R,U,T,Z,X,W,V,F,D,H,G,A : RCELREPHi_1)
                  -somme (i=U,X,S,W,L,V,J : RCELREPGi_1 )
                  -somme (i=H,L,F,K,D,J,B,P,S,O,R,N,Q,M : RCELREPYi_1 )
	          -RCELHM_1-RCELHL_1-RCELHNO_1-RCELHJK_1-RCELNQ_1-RCELNBGL_1 ) , 0 ))
	  * (1 - V_CNR) ;

RCELCOM = max( 0, RCELCOM_1 * (1 - ART1731BIS)
               + min (RCELCOM_1 , RCELCOM_2) * ART1731BIS
             ) * (1 - V_CNR) ;

RCEL_1 = max( min( RCEL_2011_R , 
                  IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1 
	          -somme (i=S,R,U,T,Z,X,W,V,F,D,H,G,A : RCELREPHi_1)
                  -somme (i=U,X,S,W,L,V,J : RCELREPGi_1 )
                  -somme (i=H,L,F,K,D,J,B,P,S,O,R,N,Q,M : RCELREPYi_1 )
	          -RCELHM_1-RCELHL_1-RCELHNO_1-RCELHJK_1-RCELNQ_1-RCELNBGL_1-RCELCOM_1 ) , 0 )
	     * (1 - V_CNR) ;

RCEL = max( 0, RCEL_1 * (1 - ART1731BIS)
               + min (RCEL_1 , RCEL_2) * ART1731BIS
	  ) * (1 - V_CNR) ;

RCELJP_1 = max( min( RCEL_JP_R , 
                  IDOM11-DEC11 - REDUCAVTCEL_1- RCELRREDSOM_1 
	          -somme (i=S,R,U,T,Z,X,W,V,F,D,H,G,A : RCELREPHi_1)
                  -somme (i=U,X,S,W,L,V,J : RCELREPGi_1 )
                  -somme (i=H,L,F,K,D,J,B,P,S,O,R,N,Q,M : RCELREPYi_1 )
	          -RCELHM_1-RCELHL_1-RCELHNO_1-RCELHJK_1-RCELNQ_1-RCELNBGL_1-RCELCOM_1-RCEL_1 ) , 0 )
	 * (1 - V_CNR) ;

RCELJP = max( 0, RCELJP_1 * (1 - ART1731BIS)
                 + min (RCELJP_1 , RCELJP_2) * ART1731BIS
	    ) * (1 - V_CNR) ;

RCELJBGL_1 = max( min( RCEL_JBGL_R , 
                  IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1 
	          -somme (i=S,R,U,T,Z,X,W,V,F,D,H,G,A : RCELREPHi_1)
                  -somme (i=U,X,S,W,L,V,J : RCELREPGi_1 )
                  -somme (i=H,L,F,K,D,J,B,P,S,O,R,N,Q,M : RCELREPYi_1 )
	          -RCELHM_1-RCELHL_1-RCELHNO_1-RCELHJK_1-RCELNQ_1-RCELNBGL_1-RCELCOM_1-RCEL_1-RCELJP_1 ) , 0 )
	   * (1 - V_CNR) ;

RCELJBGL = max( 0, RCELJBGL_1 * (1 - ART1731BIS)
                   + min (RCELJBGL_1 , RCELJBGL_2) * ART1731BIS 
	      ) * (1 - V_CNR) ;

RCELJOQR_1 = max( min( RCEL_JOQR_R , 
                  IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1 
	          -somme (i=S,R,U,T,Z,X,W,V,F,D,H,G,A : RCELREPHi_1)
                  -somme (i=U,X,S,W,L,V,J : RCELREPGi_1 )
                  -somme (i=H,L,F,K,D,J,B,P,S,O,R,N,Q,M : RCELREPYi_1 )
	          -RCELHM_1-RCELHL_1-RCELHNO_1-RCELHJK_1-RCELNQ_1-RCELNBGL_1-RCELCOM_1-RCEL_1-RCELJP_1
	          -RCELJBGL_1) , 0 )
	  * (1 - V_CNR) ;


RCELJOQR = max( 0, RCELJOQR_1 * (1 - ART1731BIS)
                   + min (RCELJOQR_1 , max(RCELJOQR_P+RCELJOQRP2 , RCELJOQR1731+0) * (1-PREM8_11)) * ART1731BIS 
	      ) * (1 - V_CNR) ;

RCEL2012_1 = max( min( RCEL_2012_R , 
                  IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1 
	          -somme (i=S,R,U,T,Z,X,W,V,F,D,H,G,A : RCELREPHi_1)
                  -somme (i=U,X,S,W,L,V,J : RCELREPGi_1 )
                  -somme (i=H,L,F,K,D,J,B,P,S,O,R,N,Q,M : RCELREPYi_1 )
	          -RCELHM_1-RCELHL_1-RCELHNO_1-RCELHJK_1-RCELNQ_1-RCELNBGL_1-RCELCOM_1-RCEL_1-RCELJP_1
	          -RCELJBGL_1-RCELJOQR_1) , 0 )
	     * (1 - V_CNR) ;

RCEL2012 = max( 0, RCEL2012_1 * (1 - ART1731BIS)
                   + min (RCEL2012_1 , RCEL2012_2) * ART1731BIS
	      ) * (1 - V_CNR) ;

RCELFD_1 = max( min( RCEL_FD_R , 
                  IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1 
	          -somme (i=S,R,U,T,Z,X,W,V,F,D,H,G,A : RCELREPHi_1)
                  -somme (i=U,X,S,W,L,V,J : RCELREPGi_1 )
                  -somme (i=H,L,F,K,D,J,B,P,S,O,R,N,Q,M : RCELREPYi_1 )
	          -RCELHM_1-RCELHL_1-RCELHNO_1-RCELHJK_1-RCELNQ_1-RCELNBGL_1-RCELCOM_1-RCEL_1-RCELJP_1
	          -RCELJBGL_1-RCELJOQR_1-RCEL2012_1) , 0 )
	     * (1 - V_CNR) ;

RCELFD = max( 0, RCELFD_1 * (1 - ART1731BIS)
                 + min (RCELFD_1 , RCELFD_2) * ART1731BIS
	    ) * (1 - V_CNR) ;

RCELFABC_1 = max( min( RCEL_FABC_R , 
                  IDOM11-DEC11 - REDUCAVTCEL_1 - RCELRREDSOM_1 
	          -somme (i=S,R,U,T,Z,X,W,V,F,D,H,G,A : RCELREPHi_1)
                  -somme (i=U,X,S,W,L,V,J : RCELREPGi_1 )
                  -somme (i=H,L,F,K,D,J,B,P,S,O,R,N,Q,M : RCELREPYi_1 )
	          -RCELHM_1-RCELHL_1-RCELHNO_1-RCELHJK_1-RCELNQ_1-RCELNBGL_1-RCELCOM_1-RCEL_1-RCELJP_1
	          -RCELJBGL_1-RCELJOQR_1-RCEL2012_1-RCELFD_1) , 0 )
	     * (1 - V_CNR) ;

RCELFABC = max( 0, RCELFABC_1 * (1 - ART1731BIS)
                   + min (RCELFABC_1 , RCELFABC_2) * ART1731BIS
	    ) * (1 - V_CNR) ;

RCELTOT = RCELRREDSOM
	  + somme (i=S,R,U,T,Z,X,W,V,F,D,H,G,A : RCELREPHi) 
          + somme (i=U,X,S,W,L,V,J : RCELREPGi )
          + somme (i=H,L,F,K,D,J,B,P,S,O,R,N,Q,M : RCELREPYi )
	  + RCELHM + RCELHL + RCELHNO + RCELHJK + RCELNQ + RCELNBGL + RCELCOM
	  + RCEL + RCELJP + RCELJBGL + RCELJOQR + RCEL2012 + RCELFD + RCELFABC ;
RCELTOT_1 = RCELRREDSOM_1
	  + somme (i=S,R,U,T,Z,X,W,V,F,D,H,G,A : RCELREPHi_1) 
          + somme (i=U,X,S,W,L,V,J : RCELREPGi_1 )
          + somme (i=H,L,F,K,D,J,B,P,S,O,R,N,Q,M : RCELREPYi_1 )
	  + RCELHM_1 + RCELHL_1 + RCELHNO_1 + RCELHJK_1 + RCELNQ_1 + RCELNBGL_1 + RCELCOM_1
	  + RCEL_1 + RCELJP_1 + RCELJBGL_1 + RCELJOQR_1 + RCEL2012_1 + RCELFD_1 + RCELFABC_1 ;

regle 401320:
application : iliad , batch ;


RIVCELFABC1 = (  positif(CELLIERFA) * arr(BCEL_FABC * (TX13/100))
               + positif(CELLIERFB) * arr(BCEL_FABC * (TX6/100))
               + positif(CELLIERFC) * arr(BCEL_FABC * (TX24/100))
              ) * (1 - V_CNR) ;
 
RIVCELFABC8 = (arr((min (CELLIERFA+CELLIERFB+CELLIERFC,LIMCELLIER) * positif(CELLIERFA) * (TX13/100))
          +(min (CELLIERFA+CELLIERFB+CELLIERFC,LIMCELLIER) * positif(CELLIERFB) * (TX6/100))
          +(min (CELLIERFA+CELLIERFB+CELLIERFC,LIMCELLIER) * positif(CELLIERFC) * (TX24/100)))
          -( 8 * RIVCELFABC1))
          * (1 - V_CNR);

RIVCELFD1 = positif( CELLIERFD ) * arr (BCEL_FD * (TX24/100))
             * (1 - V_CNR) ;

RIVCELFD4 = (arr((min (CELLIERFD, LIMCELLIER) * positif(CELLIERFD) * (TX24/100)))
              - ( 4 * RIVCELFD1))
             * (1 - V_CNR) ;

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
	  * (1 - V_CNR) ;
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

RRCELMG = max(0, CELRREDMG - RCELRREDMG) * positif(CELRREDMG) * (1 - V_CNR) ;

RRCELMH = max(0, CELRREDMH - RCELRREDMH) * positif(CELRREDMH) * (1 - V_CNR) ; 

RRCELLJ = max(0, CELRREDLJ - RCELRREDLJ) * positif(CELRREDLJ) * (1 - V_CNR) ; 



RRCEL2012 =  max( 0, (CELREPYJ + CELREPYB + CELREPYQ + CELREPYM 
                      - RCELREPYJ-RCELREPYB-RCELREPYQ-RCELREPYM
                     ) * positif(somme(i= J,B,Q,M : CELREPYi))

                   + (RCEL_2012_R - RCEL2012) * positif(CELSOMJ) 

                   + (RCEL_JOQR_R - RCELJOQR) * positif(somme(i=O,Q,R:CELLIERJi)) 

                   + (CELREPGV + CELREPGJ - RCELREPGV - RCELREPGJ
                     ) * positif(CELREPGV + CELREPGJ)

                   + (RCEL_FABC_R - RCELFABC ) * positif(CELLIERFA + CELLIERFB + CELLIERFC)

                   + (RCEL_FD_R - RCELFD ) * positif(CELLIERFD)
                ) * (1 - V_CNR) ;

RRCELLF = (max(0, CELRREDLF - RCELRREDLF)) * positif(CELRREDLF) * (1 - V_CNR) ;

RRCELLZ = (max(0, CELRREDLZ - RCELRREDLZ)) * positif(CELRREDLZ) * (1 - V_CNR) ;

RRCELLX = (max(0, CELRREDLX - RCELRREDLX)) * positif(CELRREDLX) * (1 - V_CNR) ;

RRCELLI = (max(0, CELRREDLI - RCELRREDLI)) * positif(CELRREDLI) * (1 - V_CNR) ;


RRCEL2011 =  max( 0, ( RCEL_2011_R - RCEL) * positif(CELSOMN) 

                   + ( RCEL_COM_R - RCELCOM) * positif(somme(i=P,R,S,T:CELLIERNi))

                   + ( CELREPYD + CELREPYK + CELREPYN + CELREPYR
                      - RCELREPYD - RCELREPYK - RCELREPYN - RCELREPYR) * positif( somme(i= D,K,N,R : CELREPYi))

                   + ( CELREPGW + CELREPGL + CELREPHG + CELREPHA + RCEL_JBGL_R + RCEL_JP_R
                          -RCELREPGW - RCELREPGL - RCELREPHG - RCELREPHA - RCELJBGL - RCELJP
                     ) * positif( somme(i=W,L : CELREPGi) + CELREPHG + CELREPHA + somme(i=B,G,L,P:CELLIERJi)) 
                 )
                   * (1 - V_CNR) ;


RRCELLC = max(0, CELRREDLC - RCELRREDLC) * positif(CELRREDLC) * (1 - V_CNR) ;

RRCELLD = max(0, CELRREDLD - RCELRREDLD) * positif(CELRREDLD) * (1 - V_CNR) ;

RRCELLS = max(0, CELRREDLS - RCELRREDLS) * positif(CELRREDLS) * (1 - V_CNR) ;

RRCELLT = max(0, CELRREDLT - RCELRREDLT) * positif(CELRREDLT) * (1 - V_CNR) ;

RRCELLH = max(0, CELRREDLH - RCELRREDLH) * positif(CELRREDLH) * (1 - V_CNR) ;

RRCEL2010 = max( 0, (  CELREPYF + CELREPYL + CELREPYS + CELREPYO
                       - RCELREPYF - RCELREPYL - RCELREPYS - RCELREPYO 
                    ) * positif(CELREPYF + CELREPYL + CELREPYS + CELREPYO)  

                   + ( CELREPGX + CELREPGS 
                       - RCELREPGX - RCELREPGS ) * positif(CELREPGX + CELREPGS)

	           + ( CELREPHH + CELREPHD + RCELREP_HW_R + RCELREP_HV_R
                       - RCELREPHH - RCELREPHD - RCELREPHW - RCELREPHV
                     ) * positif(CELREPHH + CELREPHD + CELREPHW + CELREPHV)

                   + ( RCEL_NQ_R   + RCEL_NBGL_R + RCEL_HJK_R
		       - RCELNQ - RCELNBGL - RCELHJK 
                     ) * positif(somme(i=Q,B,G,L:CELLIERNi) + CELLIERHJ + CELLIERHK)
               ) * (1 - V_CNR) ;


RRCELLA = max(0, CELRREDLA - RCELRREDLA) * positif(CELRREDLA) * (1 - V_CNR) ;

RRCELLB = max(0, CELRREDLB - RCELRREDLB) * positif(CELRREDLB) * (1 - V_CNR) ;

RRCELLE = max(0, CELRREDLE - RCELRREDLE) * positif(CELRREDLE) * (1 - V_CNR) ;

RRCELLM = max(0, CELRREDLM - RCELRREDLM) * positif(CELRREDLM) * (1 - V_CNR) ; 

RRCELLN = max(0, CELRREDLN - RCELRREDLN) * positif(CELRREDLN) * (1 - V_CNR) ; 

RRCELLG = max(0, CELRREDLG - RCELRREDLG) * positif(CELRREDLG) * (1 - V_CNR) ; 


RRCEL2009 = max(0, (RCEL_HL_R+RCEL_HM_R+RCEL_HNO_R + somme(i=R,S,T,U,X,Z:RCELREP_Hi_R) 
                     -(RCELHL +RCELHM +RCELHNO  + somme(i=R,S,T,U,X,Z:RCELREPHi))
                   ) * positif(somme(i=R,S,T,U,X,Z:CELREPHi)+somme(i=L,M,N,O:CELLIERHi))   

                 + ( CELREPGU + CELREPHF + CELREPYH + CELREPYP
                        - RCELREPGU - RCELREPHF  - RCELREPYH - RCELREPYP
                   ) * positif( CELREPGU + CELREPHF + CELREPYH + CELREPYP ) 
                )  * (1 - V_CNR) ;

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

regle 401330:
application : iliad , batch ;

RITOUR = RILNEUF 
        + RILTRA
	+ RILRES
        + arr((RINVLOCINV + REPINVTOU + INVLOCXN + COD7UY) * TX_REDIL25 / 100)
        + arr((RINVLOCREA + INVLOGREHA + INVLOCXV + COD7UZ) * TX_REDIL20 / 100) ;

RIHOTR = arr(INVLOGHOT * TX_REDIL25 / 100) * (1-positif(null(2-V_REGCO)+null(4-V_REGCO)));



DTOURREP = RINVLOCINV + REPINVTOU + INVLOCXN + COD7UY ;

ATOURREP = DTOURREP * (1 - ART1731BIS) 
           + min(DTOURREP , ATOURREP_2 ) * ART1731BIS ;

DTOUHOTR = INVLOGHOT ;

ATOUHOTR = (DTOUHOTR * (1 - ART1731BIS) 
            + min(DTOUHOTR , ATOUHOTR_2 ) * ART1731BIS
	   ) * (1 - positif(null(2 - V_REGCO) + V_CNR)) ;

DTOUREPA = RINVLOCREA + INVLOGREHA + INVLOCXV + COD7UZ ;

ATOUREPA = DTOUREPA * (1 - ART1731BIS) 
            + min(DTOUREPA , ATOUREPA_2 ) * ART1731BIS ;

regle 401340:
application : iliad , batch ;

RTOURREP_1 = max(min( arr(DTOURREP * TX_REDIL25 / 100) , RRI1_1-RLOGDOM_1-RCOMP_1-RRETU_1-RDONS_1-CRDIE_1
                                                               -RDUFLOTOT_1-RPINELTOT_1-RNOUV_1-RPLAFREPME4_1
                                                               -RPENTDY_1-RFOR_1) , 0) ;

RTOURREP = RTOURREP_1 * (1-ART1731BIS) 
           + min( RTOURREP_1 , RTOURREP_2) * ART1731BIS ;


RTOUHOTR_1 = max(min( RIHOTR , RRI1_1-RLOGDOM_1-RCOMP_1-RRETU_1-RDONS_1-CRDIE_1-RDUFLOTOT_1-RPINELTOT_1
                                     -RNOUV_1-RPLAFREPME4_1-RPENTDY_1-RFOR_1-RTOURREP_1) , 0)
	    * (1 - positif(null(2-V_REGCO) + null(4-V_REGCO))) ;

RTOUHOTR = RTOUHOTR_1 * (1-ART1731BIS) 
           + min( RTOUHOTR_1 , RTOUHOTR_2 ) * ART1731BIS ;


RTOUREPA_1 = max(min( arr(DTOUREPA * TX_REDIL20 / 100) ,
                      RRI1_1-RLOGDOM_1-RCOMP_1-RRETU_1-RDONS_1-CRDIE_1-RDUFLOTOT_1-RPINELTOT_1-RNOUV_1
                            -RPLAFREPME4_1-RPENTDY_1-RFOR_1-RTOURREP_1-RTOUHOTR_1) , 0) ;

RTOUREPA = RTOUREPA_1 * (1-ART1731BIS) 
           + min( RTOUREPA_1 , RTOUREPA_2 ) * ART1731BIS ;

RTOUR = RTOURREP ;

regle 401350:
application : iliad , batch ;


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

AAIDE = ( BAD * (1-ART1731BIS)
          + min(BAD, AAIDE_2) * ART1731BIS
        ) * (1-V_CNR) ;

RAIDE_1 = max( min( RAD , IDOM11-DEC11-RCOTFOR_1-RREPA_1),0);

RAIDE =  RAIDE_1 * (1-ART1731BIS)
         + min(RAIDE_1, RAIDE_2) * ART1731BIS ;



regle 401360:
application : iliad , batch ;




DPATNAT1 = PATNAT1;
APATNAT1 = (PATNAT1 * (1-ART1731BIS) 
            + min(PATNAT1 , APATNAT1_2) * ART1731BIS
           ) * (1 - V_CNR) ;


DPATNAT2 = PATNAT2;
APATNAT2 = (PATNAT2 * (1-ART1731BIS) 
             + min(PATNAT2 , APATNAT2_2) * ART1731BIS
           ) * (1 - V_CNR) ;


DPATNAT3 = PATNAT3;
APATNAT3 = (PATNAT3 * (1-ART1731BIS) 
             + min(PATNAT3 , APATNAT3_2) * ART1731BIS
           ) * (1 - V_CNR) ;



DPATNAT = PATNAT4;
APATNAT = (PATNAT4 * (1-ART1731BIS) 
            + min(PATNAT4 , APATNAT_2) * ART1731BIS
          ) * (1 - V_CNR) ;

regle 401370:
application : iliad , batch ;

 

RPATNAT1_1  = max( min( PATNAT1, RRI1_1-RLOGDOM_1-RCOMP_1-RRETU_1-RDONS_1-CRDIE_1-RDUFLOTOT_1
                                -RPINELTOT_1-RNOUV_1-RPLAFREPME4_1-RPENTDY_1-RFOR_1-RTOURREP_1-RTOUHOTR_1
                                -RTOUREPA_1-RCELTOT_1-RLOCNPRO_1) , 0 )
               * (1 - V_CNR) ;

RPATNAT1 = max( 0 , RPATNAT1_1 * (1-ART1731BIS) 
                     + min( RPATNAT1_1 , RPATNAT1_2 ) * ART1731BIS  
              ) * (1 - V_CNR) ;

RPATNAT2_1 = max( min( PATNAT2, RRI1_1-RLOGDOM_1-RCOMP_1-RRETU_1-RDONS_1-CRDIE_1-RDUFLOTOT_1
                                -RPINELTOT_1-RNOUV_1-RPLAFREPME4_1-RPENTDY_1-RFOR_1-RTOURREP_1-RTOUHOTR_1
			        -RTOUREPA_1-RCELTOT_1-RLOCNPRO_1-RPATNAT1_1) , 0 )
              * (1 - V_CNR) ;

RPATNAT2 = max( 0 , RPATNAT2_1 * (1-ART1731BIS) 
                     + min( RPATNAT2_1 ,RPATNAT2_2 ) * ART1731BIS 
              )* (1 - V_CNR) ;

RPATNAT3_1 = max( min( PATNAT3, RRI1_1-RLOGDOM_1-RCOMP_1-RRETU_1-RDONS_1-CRDIE_1-RDUFLOTOT_1
                                -RPINELTOT_1-RNOUV_1-RPLAFREPME4_1-RPENTDY_1-RFOR_1-RTOURREP_1-RTOUHOTR_1 
			        -RTOUREPA_1-RCELTOT_1-RLOCNPRO_1-RPATNAT1_1-RPATNAT2_1) , 0 )
              * (1 - V_CNR) ;

RPATNAT3 = max( 0 , RPATNAT3_1 * (1-ART1731BIS) 
                     + min( RPATNAT3_1 , RPATNAT3_2 ) * ART1731BIS
              ) * (1 - V_CNR) ;


RPATNAT_1 = max( min( PATNAT4, RRI1_1-RLOGDOM_1-RCOMP_1-RRETU_1-RDONS_1-CRDIE_1-RDUFLOTOT_1
                               -RPINELTOT_1-RNOUV_1-RPLAFREPME4_1-RPENTDY_1-RFOR_1-RTOURREP_1-RTOUHOTR_1 
			       -RTOUREPA_1-RCELTOT_1-RLOCNPRO_1-RPATNAT1_1-RPATNAT2_1-RPATNAT3_1 ) , 0 ) 
             * (1 - V_CNR) ;

RPATNAT = max( 0 , RPATNAT_1  * (1-ART1731BIS) 
                    + min( RPATNAT_1 , RPATNAT_2 ) * ART1731BIS
             ) * (1 - V_CNR) ;

RPATNATOT = RPATNAT1 + RPATNAT2 + RPATNAT3 + RPATNAT; 
RPATNATOT_1 = RPATNAT_1 + RPATNAT1_1 + RPATNAT2_1 + RPATNAT3_1 ;

regle 401380:
application : iliad , batch ;
 


REPNATR1 = max(PATNAT1 - RPATNAT1,0) *  (1 - V_CNR) ;

REPNATR2 = max(PATNAT2 - RPATNAT2,0) * (1 - V_CNR) ;

REPNATR3 = max(PATNAT3 - RPATNAT3,0) * (1 - V_CNR) ;

REPNATR = max(PATNAT4 -  RPATNAT,0) * (1 - V_CNR) ;
REPNATR4 = REPNATR ;

regle 401390 :
application : iliad , batch ;

RRI1_1 = IDOM11-DEC11-RCOTFOR_1-RREPA_1-RAIDE_1-RDIFAGRI_1-RPRESSE_1-RFORET_1-RFIPDOM_1-RFIPC_1-RCINE_1-RRESTIMO_1
            -RSOCREPR_1-RRPRESCOMP_1-RHEBE_1-RSURV_1-RINNO_1-RSOUFIP_1-RRIRENOV_1;

RRI1 = IDOM11 - DEC11 - RCOTFOR - RREPA - RAIDE - RDIFAGRI - RPRESSE - RFORET - RFIPDOM - RFIPC - RCINE
              - RRESTIMO - RSOCREPR - RRPRESCOMP - RHEBE - RSURV - RINNO - RSOUFIP - RRIRENOV ;

regle 401400 :
application : iliad , batch ;


BAH = (min (RVCURE,LIM_CURE) + min(RCCURE,LIM_CURE)) * (1 - V_CNR) ;

RAH = arr (BAH * TX_CURE /100) ;

DHEBE = RVCURE + RCCURE ;

AHEBE = BAH * (1-ART1731BIS)
         + min(BAH , AHEBE_2) * ART1731BIS ;

RHEBE_1 = max( min( RAH , IDOM11-DEC11-RCOTFOR_1-RREPA_1-RAIDE_1-RDIFAGRI_1-RPRESSE_1-RFORET_1-RFIPDOM_1-RFIPC_1
			-RCINE_1-RRESTIMO_1-RSOCREPR_1-RRPRESCOMP_1) , 0 );

RHEBE = max( 0, RHEBE_1 * (1-ART1731BIS) 
                 + min( RHEBE_1 , RHEBE_2 ) * ART1731BIS ) ;

regle 401410:
application : iliad , batch ;


DREPA = RDREP + DONETRAN;

EXCEDANTA = max(0,RDREP + DONETRAN - PLAF_REDREPAS) ;

BAA = min( RDREP + DONETRAN, PLAF_REDREPAS ) ;

RAA = arr( (TX_REDREPAS) / 100 * BAA ) * (1 - V_CNR) ;


AREPA = ( BAA * (1-ART1731BIS)
          + min( BAA , AREPA_2 ) * ART1731BIS
        ) * (1 - V_CNR) ;

RREPA_1 = max( min( RAA , IDOM11-DEC11-RCOTFOR_1) , 0) ;

RREPA = RREPA_1 * (1-ART1731BIS)
        + min( RREPA_1 , RREPA_2) * ART1731BIS ;


regle 401420:
application : iliad , batch ;
 
DNOUV = REPSNO3 + REPSNO2 + REPSNO1 + REPSNON + COD7CQ + COD7CR + COD7CV + PETIPRISE + RDSNO ;

BSN1 = min (REPSNO3 + REPSNO2 + REPSNO1 + REPSNON + PETIPRISE , LIM_SOCNOUV2 * (1 + BOOL_0AM)) ;
BSN2 = min (COD7CQ + COD7CR + COD7CV + RDSNO , LIM_TITPRISE * (1 + BOOL_0AM) - BSN1) ;

BSNCL = min(REPSNO3 , LIM_SOCNOUV2 * (1 + BOOL_0AM)) ;
RSN_CL =  BSNCL * TX22/100 ;

BSNCM = max(0, min(REPSNO2 , LIM_SOCNOUV2 * (1 + BOOL_0AM) - BSNCL)) ;
RSN_CM = BSNCM * TX18/100 ;

BSNCN = max(0, min(REPSNO1 , LIM_SOCNOUV2 * (1 + BOOL_0AM) - BSNCL - BSNCM)) ;
RSN_CN = BSNCN * TX18/100 ;

BSNCC = max(0, min(REPSNON , LIM_SOCNOUV2 * (1 + BOOL_0AM) - BSNCL - BSNCM - BSNCN)) ;
RSN_CC = BSNCC * TX18/100 ;

BSNCU = max(0, min(PETIPRISE , LIM_SOCNOUV2 * (1 + BOOL_0AM) - BSNCL - BSNCM - BSNCN - BSNCC)) ;
RSN_CU = BSNCU * TX18/100 ;

BSNCQ = max(0, min(COD7CQ , LIM_TITPRISE * (1 + BOOL_0AM) - BSN1)) ;
RSN_CQ = BSNCQ * TX18/100 ;

BSNCR = max(0, min(COD7CR , LIM_TITPRISE * (1 + BOOL_0AM) - BSN1 - BSNCQ)) ;
RSN_CR = BSNCR * TX18/100 ;

BSNCV = max(0, min(COD7CV , LIM_TITPRISE * (1 + BOOL_0AM) - BSN1 - BSNCQ - BSNCR)) ;
RSN_CV = BSNCV * TX18/100 ;

BSNCF = max(0, min(RDSNO , LIM_TITPRISE * (1 + BOOL_0AM) - BSN1 - BSNCQ  - BSNCR - BSNCV)) ;
RSN_CF = BSNCF * TX18/100 ;

RSN = arr(RSN_CL + RSN_CM + RSN_CN + RSN_CC + RSN_CU + RSN_CQ + RSN_CR  + RSN_CV + RSN_CF) * (1 - V_CNR) ;

ANOUV = ((BSN1 + BSN2) * (1-ART1731BIS) 
          + min(BSN1 + BSN2 , ANOUV_2 ) * ART1731BIS
        ) * (1 - V_CNR) ;

regle 401430:
application : iliad , batch ;

RSNCL_1 = max(0, min(RSN_CL, RRI1_1-RLOGDOM_1-RCOMP_1-RRETU_1-RDONS_1-CRDIE_1-RDUFLOTOT_1-RPINELTOT_1)) ;
RSNCL_2 = max( RSNCL_P + RSNCLP2 , RSNCL1731) * (1-PREM8_11) * ART1731BIS ; 
RSNCL = ( RSNCL_1 * (1-ART1731BIS) + min( RSNCL_1, RSNCL_2 ) * ART1731BIS ) * (1 - V_CNR) ;

RSNCM_1 = max(0, min(RSN_CM, RRI1_1-RLOGDOM_1-RCOMP_1-RRETU_1-RDONS_1-CRDIE_1-RDUFLOTOT_1-RPINELTOT_1-RSNCL_1 )) ;
RSNCM_2 = max( RSNCM_P + RSNCMP2 , RSNCM1731) * (1-PREM8_11) * ART1731BIS ;
RSNCM = ( RSNCM_1 * (1-ART1731BIS) + min( RSNCM_1, RSNCM_2 ) * ART1731BIS ) * (1 - V_CNR) ;

RSNCN_1 = max(0, min(RSN_CN, RRI1_1-RLOGDOM_1-RCOMP_1-RRETU_1-RDONS_1-CRDIE_1-RDUFLOTOT_1-RPINELTOT_1-RSNCL_1-RSNCM_1 )) ;
RSNCN_2 = max( RSNCN_P + RSNCNP2 , RSNCN1731) * (1-PREM8_11) * ART1731BIS ;
RSNCN = ( RSNCN_1 * (1-ART1731BIS) + min( RSNCN_1, RSNCN_2 ) * ART1731BIS ) * (1 - V_CNR) ;

RSNCC_1 = max(0, min(RSN_CC, RRI1_1-RLOGDOM_1-RCOMP_1-RRETU_1-RDONS_1-CRDIE_1-RDUFLOTOT_1-RPINELTOT_1-RSNCL_1-RSNCM_1-RSNCN_1 )) ;
RSNCC_2 = max( RSNCC_P + RSNCCP2 , RSNCC1731) * (1-PREM8_11) * ART1731BIS ;
RSNCC = ( RSNCC_1 * (1-ART1731BIS) + min( RSNCC_1, RSNCC_2 ) * ART1731BIS ) * (1 - V_CNR) ;

RSNCU_1 = max(0, min(RSN_CU, RRI1_1-RLOGDOM_1-RCOMP_1-RRETU_1-RDONS_1-CRDIE_1-RDUFLOTOT_1-RPINELTOT_1-RSNCL_1-RSNCM_1-RSNCN_1-RSNCC_1 )) ;
RSNCU_2 = max( RSNCU_P + RSNCUP2 , RSNCU1731) * (1-PREM8_11) * ART1731BIS ;
RSNCU = ( RSNCU_1 * (1-ART1731BIS) + min( RSNCU_1, RSNCU_2 ) * ART1731BIS ) * (1 - V_CNR) ;

RSNCQ_1 = max(0, min(RSN_CQ, RRI1_1-RLOGDOM_1-RCOMP_1-RRETU_1-RDONS_1-CRDIE_1-RDUFLOTOT_1-RPINELTOT_1-RSNCL_1-RSNCM_1-RSNCN_1-RSNCC_1-RSNCU_1 )) ;
RSNCQ_2 = max( RSNCQ_P + RSNCQP2 , RSNCQ1731) * (1-PREM8_11) * ART1731BIS ;
RSNCQ = ( RSNCQ_1 * (1-ART1731BIS) + min( RSNCQ_1, RSNCQ_2 ) * ART1731BIS ) * (1 - V_CNR) ;

RSNCR_1 = max(0, min(RSN_CR, RRI1_1-RLOGDOM_1-RCOMP_1-RRETU_1-RDONS_1-CRDIE_1-RDUFLOTOT_1-RPINELTOT_1-RSNCL_1-RSNCM_1-RSNCN_1-RSNCC_1-RSNCU_1-RSNCQ_1 )) ;
RSNCR_2 = max( RSNCR_P + RSNCRP2 , RSNCR1731) * (1-PREM8_11) * ART1731BIS ;
RSNCR = ( RSNCR_1 * (1-ART1731BIS) + min( RSNCR_1, RSNCR_2 ) * ART1731BIS ) * (1 - V_CNR) ;

RSNCV_1 = max(0, min(RSN_CV, RRI1_1-RLOGDOM_1-RCOMP_1-RRETU_1-RDONS_1-CRDIE_1-RDUFLOTOT_1-RPINELTOT_1-RSNCL_1-RSNCM_1-RSNCN_1-RSNCC_1-RSNCU_1-RSNCQ-RSNCR_1 )) ;
RSNCV_2 = max( RSNCV_P + RSNCVP2 , RSNCV1731) * (1-PREM8_11) * ART1731BIS ;
RSNCV = ( RSNCV_1 * (1-ART1731BIS) + min( RSNCV_1, RSNCV_2 ) * ART1731BIS ) * (1 - V_CNR) ;

RSNCF_1 = max(0, min(RSN_CF, RRI1_1-RLOGDOM_1-RCOMP_1-RRETU_1-RDONS_1-CRDIE_1-RDUFLOTOT_1-RPINELTOT_1-RSNCL_1-RSNCM_1-RSNCN_1-RSNCC_1-RSNCU_1-RSNCQ-RSNCR_1-RSNCV_1 )) ;
RSNCF_2 = max( RSNCF_P + RSNCFP2 , RSNCF1731) * (1-PREM8_11) * ART1731BIS ;
RSNCF = ( RSNCF_1 * (1-ART1731BIS) + min( RSNCF_1, RSNCF_2 ) * ART1731BIS ) * (1 - V_CNR) ;

RNOUV_1 = max( min( RSN , RRI1_1-RLOGDOM_1-RCOMP_1-RRETU_1-RDONS_1-CRDIE_1-RDUFLOTOT_1-RPINELTOT_1) , 0) ;

RNOUV = ( RNOUV_1 * (1-ART1731BIS)
          + min( RNOUV_1, RNOUV_2 ) * ART1731BIS
        ) * (1 - V_CNR) ;


regle 401440:
application : iliad , batch ;


DPLAFREPME4 = COD7CY ;
APLAFREPME4_1 = COD7CY * positif(COD7CY) * (1 - V_CNR);
APLAFREPME4 = APLAFREPME4_1 * (1-ART1731BIS)
              + min (APLAFREPME4_1 , APLAFREPME4_2) * ART1731BIS ; 

RPLAFREPME4_1 = max( min( APLAFREPME4_1 , RRI1_1-RLOGDOM_1-RCOMP_1-RRETU_1-RDONS_1-CRDIE_1
                                          -RDUFLOTOT_1-RPINELTOT_1-RNOUV_1) , 0) ;

RPLAFREPME4 = RPLAFREPME4_1 * (1-ART1731BIS)
              + min( RPLAFREPME4_1 , RPLAFREPME4_2 ) * ART1731BIS ;

RPENTCY =  RPLAFREPME4 ;

DPENTDY = COD7DY ;
APENTDY_1 = COD7DY * positif(COD7DY) * (1 - V_CNR) ;
APENTDY = APENTDY_1 * (1-ART1731BIS)
          + min (APENTDY_1 , APENTDY_2) * ART1731BIS ;

RPENTDY_1 = max( min( APENTDY_1 , RRI1_1-RLOGDOM_1-RCOMP_1-RRETU_1-RDONS_1-CRDIE_1
                                  -RDUFLOTOT_1-RPINELTOT_1-RNOUV_1-RPLAFREPME4_1) , 0) ;

RPENTDY = RPENTDY_1 * (1-ART1731BIS)
          + min( RPENTDY_1 , RPENTDY_2) * ART1731BIS ;

regle 401450:
application : iliad , batch ;

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

RINVTPME13 = max(0 , COD7CR - max(0 , (LIM_TITPRISE * (1 + BOOL_0AM)) 
			     - max(0 , min( BSNCL + REPSNO2 + REPSNO1 + REPSNON + PETIPRISE , LIM_SOCNOUV2 * (1 + BOOL_0AM)) + COD7CQ)))
	      * (1 - V_CNR) ;

RINVTPME14 = max(0 , COD7CV - max(0 , (LIM_TITPRISE * (1 + BOOL_0AM)) 
			     - max(0 , min( BSNCL + REPSNO2 + REPSNO1 + REPSNON + PETIPRISE , LIM_SOCNOUV2 * (1 + BOOL_0AM)) + COD7CQ + COD7CR)))
	      * (1 - V_CNR) ;

RINVTPME15 = max(0 , RDSNO - max(0 , (LIM_TITPRISE * (1 + BOOL_0AM)) 
			     - max(0 , min( BSNCL + REPSNO2 + REPSNO1 + REPSNON + PETIPRISE , LIM_SOCNOUV2 * (1 + BOOL_0AM)) + COD7CQ + COD7CR + COD7CV)))
	      * (1 - V_CNR) ;

regle 401460:
application : iliad , batch ;



PLAFREPETOT = arr( max(0 , RSNCR + RSNCV + RSNCF + RPLAFREPME4 + RPENTDY - 10000)) * (1 - V_CNR) * positif(AVFISCOPTER) ;

PLAFREPSN5 = arr( max(0, RSNCF - 10000 )) * (1 - V_CNR) * positif(AVFISCOPTER) ;

PLAFREPSN4 = arr( max(0, PLAFREPETOT - PLAFREPSN5 )) ;

PLAFREPSN3 = arr( max(0, PLAFREPETOT - PLAFREPSN5 - PLAFREPSN4)) ;

RPLAFPME13 = PLAFREPSN3 ;

RPLAFPME14 = PLAFREPSN4 ;

RPLAFPME15 = PLAFREPSN5 ;

regle 401470:
application : iliad , batch ;


DREDMEUB = REDMEUBLE ;

AREDMEUB = (DREDMEUB * (1 - ART1731BIS) 
             + min(DREDMEUB , AREDMEUB_2) * ART1731BIS
           ) * (1 - V_CNR) ;

DREDREP = REDREPNPRO ;

AREDREP = (DREDREP * (1 - ART1731BIS) 
            + min(DREDREP , AREDREP_2) * ART1731BIS
          ) * (1 - V_CNR) ;

DILMIX = LOCMEUBIX ;


AILMIX = (DILMIX * (1 - ART1731BIS) 
            + min(DILMIX , AILMIX_2) * ART1731BIS
         ) * (1 - V_CNR) ;

DILMIY = LOCMEUBIY ;

AILMIY = (DILMIY * (1 - ART1731BIS) 
            + min(DILMIY , AILMIY_2) * ART1731BIS
         ) * (1 - V_CNR) ;

DILMPA = COD7PA ;

AILMPA = ( DILMPA * (1 - ART1731BIS)
             + min( DILMPA , AILMPA_2 ) * ART1731BIS
         ) * (1 - V_CNR) ;

DILMPF = COD7PF ;

AILMPF = ( DILMPF * (1 - ART1731BIS)
             + min( DILMPF , AILMPF_2 ) * ART1731BIS
         ) * (1 - V_CNR) ;

DINVRED = INVREDMEU ;

AINVRED = (DINVRED * (1 - ART1731BIS) 
            + min(DINVRED , AINVRED_2) * ART1731BIS
          ) * (1 - V_CNR) ;

DILMIH = LOCMEUBIH ;


AILMIH = (DILMIH * (1-ART1731BIS) 
          + min(DILMIH , max(AILMIH_P+AILMIHP2, AILMIH1731+0)*(1-PREM8_11)) * ART1731BIS
         ) * (1-V_CNR);

DILMJC = LOCMEUBJC ;

AILMJC = (DILMJC * (1 - ART1731BIS) 
           + min(DILMJC , AILMJC_2) * ART1731BIS
         ) * (1 - V_CNR) ;

DILMPB = COD7PB ;

AILMPB = ( DILMPB * (1 - ART1731BIS)
             + min( DILMPB , AILMPB_2 ) * ART1731BIS
         ) * (1 - V_CNR) ;

DILMPG = COD7PG ;

AILMPG = ( DILMPG * (1 - ART1731BIS)
             + min( DILMPG , AILMPG_2 ) * ART1731BIS
         ) * (1 - V_CNR) ;

DILMIZ = LOCMEUBIZ ;


AILMIZ = (DILMIZ * (1-ART1731BIS) 
           + min(DILMIZ , AILMIZ_2) * ART1731BIS
         ) * (1-V_CNR);

DILMJI = LOCMEUBJI ;

AILMJI = (DILMJI * (1 - ART1731BIS) 
           + min(DILMJI , AILMJI_2) * ART1731BIS 
         ) * (1 - V_CNR) ;

DILMPC = COD7PC ;
AILMPC = ( DILMPC * (1 - ART1731BIS)
             + min( DILMPC , AILMPC_2 ) * ART1731BIS
         ) * (1 - V_CNR) ;


DILMPH = COD7PH ;
AILMPH = ( DILMPH * (1 - ART1731BIS)
             + min( DILMPH , AILMPH_2 ) * ART1731BIS
         ) * (1 - V_CNR) ;


DILMJS = LOCMEUBJS ;

AILMJS = (DILMJS * (1 - ART1731BIS) 
           + min(DILMJS , AILMJS_2) * ART1731BIS
         ) * (1 - V_CNR) ;

DILMPD = COD7PD ;

AILMPD = ( DILMPD * (1 - ART1731BIS)
             + min( DILMPD , AILMPD_2 ) * ART1731BIS
         ) * (1 - V_CNR) ;

DILMPI = COD7PI ;

AILMPI = ( DILMPI * (1 - ART1731BIS)
             + min( DILMPI , AILMPI_2 ) * ART1731BIS
         ) * (1 - V_CNR) ;

DILMPE = COD7PE ;

AILMPE = ( DILMPE * (1 - ART1731BIS)
             + min( DILMPE , AILMPE_2 ) * ART1731BIS
         ) * (1 - V_CNR) ;

DILMPJ = COD7PJ ;

AILMPJ = ( DILMPJ * (1 - ART1731BIS)
             + min( DILMPJ , AILMPJ_2 ) * ART1731BIS
         ) * (1 - V_CNR) ;


DMEUBLE = REPMEUBLE ;

AMEUBLE = (DMEUBLE * (1 - ART1731BIS) 
            + min(DMEUBLE , AMEUBLE_2 + 0) * ART1731BIS
          ) * (1 - V_CNR) ;

MEUBLERET = arr(DMEUBLE * TX25 / 100) * (1 - V_CNR) ;

DPROREP = INVNPROREP ;

APROREP = (DPROREP * (1-ART1731BIS) 
            + min(DPROREP , APROREP_2) * ART1731BIS
          ) * (1-V_CNR);

RETPROREP = arr(DPROREP * TX25 / 100) * (1 - V_CNR) ;

DREPNPRO = INVREPNPRO ;

AREPNPRO = (DREPNPRO * (1-ART1731BIS) 
             + min(DREPNPRO , AREPNPRO_2) * ART1731BIS
           ) * (1-V_CNR);

RETREPNPRO = arr(DREPNPRO * TX25 / 100) * (1 - V_CNR) ;

DREPMEU = INVREPMEU ;

AREPMEU = (DREPMEU * (1-ART1731BIS) 
            + min(DREPMEU , AREPMEU_2) * ART1731BIS          
          ) * (1-V_CNR);

RETREPMEU = arr(DREPMEU * TX25 / 100) * (1 - V_CNR) ;

DILMIC = LOCMEUBIC ;


AILMIC = (DILMIC * (1 - ART1731BIS) 
           + min(DILMIC , AILMIC_2 ) * ART1731BIS
         ) * (1 - V_CNR) ;

DILMIB = LOCMEUBIB ;


AILMIB = (DILMIB * (1 - ART1731BIS) 
           + min(DILMIB , AILMIB_2 ) * ART1731BIS
         ) * (1 - V_CNR) ;

DILMIA = LOCMEUBIA ;


AILMIA = (DILMIA * (1 - ART1731BIS)
           + min(DILMIA , AILMIA_2) * ART1731BIS
         ) * (1 - V_CNR) ;

DILMJY = LOCMEUBJY ;

AILMJY = (DILMJY * (1 - ART1731BIS) 
           + min(DILMJY , AILMJY_2 ) * ART1731BIS
         ) * (1 - V_CNR) ;

DILMJX = LOCMEUBJX ;

AILMJX = (DILMJX * (1 - ART1731BIS) 
           + min(DILMJX , AILMJX_2 ) * ART1731BIS
         ) * (1 - V_CNR) ;

DILMJW = LOCMEUBJW ;

AILMJW = (DILMJW * (1 - ART1731BIS) 
           + min(DILMJW , AILMJW_2) * ART1731BIS
         ) * (1 - V_CNR) ;

DILMJV = LOCMEUBJV ;

AILMJV = (DILMJV * (1 - ART1731BIS) 
           + min(DILMJV , AILMJV_2) * ART1731BIS
         ) * (1 - V_CNR) ;

DILMOE = COD7OE ;

AILMOE = ( DILMOE * (1 - ART1731BIS)
             + min( DILMOE , AILMOE_2 ) * ART1731BIS
         ) * (1 - V_CNR) ;


DILMOD = COD7OD ;

AILMOD = ( DILMOD * (1 - ART1731BIS)
             + min( DILMOD , AILMOD_2 ) * ART1731BIS
         ) * (1 - V_CNR) ;


DILMOC = COD7OC ;

AILMOC = ( DILMOC * (1 - ART1731BIS)
             + min( DILMOC , AILMOC_2 ) * ART1731BIS
         ) * (1 - V_CNR) ;


DILMOB = COD7OB ;

AILMOB = ( DILMOB * (1 - ART1731BIS)
             + min( DILMOB , AILMOB_2 ) * ART1731BIS
         ) * (1 - V_CNR) ;

DILMOA = COD7OA ;

AILMOA = ( DILMOA * (1 - ART1731BIS)
             + min( DILMOA , AILMOA_2 ) * ART1731BIS
         ) * (1 - V_CNR) ;

DILMOJ = COD7OJ ;

AILMOJ = ( DILMOJ * (1 - ART1731BIS)
             + min( DILMOJ , AILMOJ_2 ) * ART1731BIS
         ) * (1 - V_CNR) ;

DILMOI = COD7OI ;

AILMOI = ( DILMOI * (1 - ART1731BIS)
             + min( DILMOI , AILMOI_2 ) * ART1731BIS
         ) * (1 - V_CNR) ;

DILMOH = COD7OH ;

AILMOH = ( DILMOH * (1 - ART1731BIS)
             + min( DILMOH , AILMOH_2 ) * ART1731BIS
         ) * (1 - V_CNR) ;

DILMOG = COD7OG ;

AILMOG = ( DILMOG * (1 - ART1731BIS)
             + min( DILMOG , AILMOG_2 ) * ART1731BIS
         ) * (1 - V_CNR) ;

DILMOF = COD7OF ;

AILMOF = ( DILMOF * (1 - ART1731BIS)
             + min( DILMOF , AILMOF_2 ) * ART1731BIS
         ) * (1 - V_CNR) ;

regle 401480:
application : iliad , batch ;


RREDMEUB_1 = max(min(DREDMEUB , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1), 0
                ) * (1 - V_CNR) ;

RREDMEUB = max(0 , RREDMEUB_1 * (1-ART1731BIS) 
                   + min( RREDMEUB_1 , RREDMEUB_2 ) * ART1731BIS
              ) ;

REPMEUIS = (DREDMEUB - RREDMEUB) * (1 - V_CNR) ;

regle 401490:
application : iliad , batch ;


RREDREP_1 = max(min(DREDREP , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                                    -RREDMEUB_1) , 0) 
               * (1 - V_CNR) ;

RREDREP = max( 0 , RREDREP_1 * (1-ART1731BIS) 
                   + min( RREDREP_1 , RREDREP_2 ) * ART1731BIS 
             ) ;

REPMEUIU = (DREDREP - RREDREP) * (1 - V_CNR) ;

regle 401500:
application : iliad , batch ;


RILMIX_1 = max(min(DILMIX , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1 
                                  -RREDMEUB_1-RREDREP_1) , 0)
              * (1 - V_CNR) ;

RILMIX = max(0 , RILMIX_1 * (1-ART1731BIS) 
                 + min( RILMIX_1 , RILMIX_2) * ART1731BIS 
            ) ;

REPMEUIX = (DILMIX - RILMIX) * (1 - V_CNR) ;

regle 401510:
application : iliad , batch ;


RILMIY_1 = max(min(DILMIY , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1 
                                  -RREDMEUB_1-RREDREP_1-RILMIX_1) , 0)
              * (1 - V_CNR)  ;

RILMIY = max(0 , RILMIY_1 * (1 - ART1731BIS) 
                 + min(RILMIY_1 , RILMIY_2) * ART1731BIS
            ) ;

REPMEUIY = (DILMIY - RILMIY) * (1 - V_CNR) ;
 
regle 401520:
application : iliad , batch ;


RILMPA_1 = max(min(DILMPA , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                                -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1) , 0) 
              * (1 - V_CNR) ;

RILMPA = max(0 , RILMPA_1 * (1 - ART1731BIS)
              + min(RILMPA_1 , RILMPA_2) * ART1731BIS
            ) ;

REPMEUPA = (DILMPA - RILMPA) * (1 - V_CNR) ;



RILMPF_1 = max(min(DILMPF , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                            -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1) , 0) 
              * (1 - V_CNR) ;

RILMPF = max(0 , RILMPF_1 * (1 - ART1731BIS)
              + min(RILMPF_1 , RILMPF_2) * ART1731BIS
            ) ;

REPMEUPF = (DILMPF - RILMPF) * (1 - V_CNR) ;

regle 401530:
application : iliad , batch ;


RINVRED_1 = max(min(DINVRED , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1) , 0)
               * (1 - V_CNR) ;

RINVRED = max( 0 , RINVRED_1 * (1-ART1731BIS) 
                   + min( RINVRED_1 , RINVRED_2 ) * ART1731BIS
             ) ;

REPMEUIT = (DINVRED - RINVRED) * (1 - V_CNR) ;

regle 401540:
application : iliad , batch ;


RILMIH_1 = max(min(DILMIH , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1) , 0
              ) * (1 - V_CNR) ;

RILMIH = max(0 , RILMIH_1 * (1 - ART1731BIS)
              + min(RILMIH_1 , RILMIH_2) * ART1731BIS
            ) ; 

REPMEUIH = (DILMIH - RILMIH) * (1 - V_CNR) ;

regle 401550:
application : iliad , batch ;


RILMJC_1 = max(min(DILMJC , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1) , 0
              ) * (1 - V_CNR) ;

RILMJC = max(0 , RILMJC_1 * (1 - ART1731BIS) 
                  + min(RILMJC_1 , RILMJC_2) * ART1731BIS
            ) ;

REPMEUJC = (DILMJC - RILMJC) * (1 - V_CNR) ;

regle 401560:
application : iliad , batch ;

RILMPB_1 = max(min(DILMPB , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1) , 0)
              * (1 - V_CNR) ;

RILMPB = max(0 , RILMPB_1 * (1 - ART1731BIS)
                 + min(RILMPB_1 , RILMPB_2) * ART1731BIS
            ) ;

REPMEUPB = (DILMPB - RILMPB) * (1 - V_CNR) ;

RILMPG_1 = max(min(DILMPG , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1) , 0)
              * (1 - V_CNR) ;

RILMPG = max(0 , RILMPG_1 * (1 - ART1731BIS)
                 + min(RILMPG_1 , RILMPG_2) * ART1731BIS
            ) ;

REPMEUPG = (DILMPG - RILMPG) * (1 - V_CNR) ;

regle 401570:
application : iliad , batch ;


RILMIZ_1 = max(min(DILMIZ , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1
                              -RILMPG_1) , 0)
              * (1 - V_CNR);

RILMIZ = max( 0 , RILMIZ_1 * (1-ART1731BIS) 
                  + min( RILMIZ_1 , RILMIZ_2 ) * ART1731BIS 
            ) ;

REPMEUIZ = (DILMIZ - RILMIZ) * (1 - V_CNR) ;

regle 401580:
application : iliad , batch ;


RILMJI_1 = max(min(DILMJI , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1 
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1
                              -RILMPG_1-RILMIZ_1) , 0)
              * (1 - V_CNR) ;

RILMJI = max(0 , RILMJI_1 * (1 - ART1731BIS) 
                 + min(RILMJI_1 , RILMJI_2 ) * ART1731BIS
            ) ;

REPMEUJI = (DILMJI - RILMJI) * (1 - V_CNR) ;

regle 401590:
application : iliad , batch ;


RILMPC_1 = max(min(DILMPC , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1 
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1
                              -RILMPG_1-RILMIZ_1-RILMJI_1) , 0)
              * (1 - V_CNR) ;

RILMPC = max(0 , RILMPC_1 * (1 - ART1731BIS)
              + min(RILMPC_1 , RILMPC_2) * ART1731BIS
            ) ;

REPMEUPC = (DILMPC - RILMPC) * (1 - V_CNR) ;


RILMPH_1 = max(min(DILMPH , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1 
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1
                              -RILMPG_1-RILMIZ_1-RILMJI_1-RILMPC_1) , 0)
              * (1 - V_CNR) ;

RILMPH = max(0 , RILMPH_1 * (1 - ART1731BIS)
              + min(RILMPH_1 , RILMPH_2) * ART1731BIS
            ) ;

REPMEUPH = (DILMPH - RILMPH) * (1 - V_CNR) ;

regle 401600:
application : iliad , batch ;


RILMJS_1 = max(min(DILMJS , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1 
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1
                              -RILMPG_1-RILMIZ_1-RILMJI_1-RILMPC_1-RILMPH_1) , 0)
                  * (1 - V_CNR) ;

RILMJS = max(0 , RILMJS_1 * (1 - ART1731BIS) 
                 + min(RILMJS_1 , RILMJS_2) * ART1731BIS
            ) ;

REPMEUJS = (DILMJS - RILMJS) * (1 - V_CNR) ;

regle 401610:
application : iliad , batch ;


RILMPD_1 = max(min(DILMPD , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1
                              -RILMPG_1-RILMIZ_1-RILMJI_1-RILMPC_1-RILMPH_1
                              -RILMJS_1) , 0)
            * (1 - V_CNR) ;

RILMPD = max(0 , RILMPD_1 * (1 - ART1731BIS)
              + min(RILMPD_1 , RILMPD_2) * ART1731BIS
            ) ;


REPMEUPD = (DILMPD - RILMPD) * (1 - V_CNR) ;


RILMPI_1 = max(min(DILMPI , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1
                              -RILMPG_1-RILMIZ_1-RILMJI_1-RILMPC_1-RILMPH_1
                              -RILMJS_1-RILMPD_1) , 0)
            * (1 - V_CNR) ;

RILMPI = max(0 , RILMPI_1 * (1 - ART1731BIS)
              + min(RILMPI_1 , RILMPI_2) * ART1731BIS
            ) ;

REPMEUPI = (DILMPI - RILMPI) * (1 - V_CNR) ;

regle 401620:
application : iliad , batch ;


RILMPE_1 = max(min(DILMPE , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1
                              -RILMPG_1-RILMIZ_1-RILMJI_1-RILMPC_1-RILMPH_1
                              -RILMJS_1-RILMPD_1-RILMPI_1) , 0)
            * (1 - V_CNR) ;

RILMPE = max(0 , RILMPE_1 * (1 - ART1731BIS)
              + min(RILMPE_1 , RILMPE_2) * ART1731BIS
            ) ;

REPMEUPE = (DILMPE - RILMPE) * (1 - V_CNR) ;


RILMPJ_1 = max(min(DILMPJ , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1
                              -RILMPG_1-RILMIZ_1-RILMJI_1-RILMPC_1-RILMPH_1
                              -RILMJS_1-RILMPD_1-RILMPI_1-RILMPE_1) , 0)
            * (1 - V_CNR) ;

RILMPJ = max(0 , RILMPJ_1 * (1 - ART1731BIS)
              + min(RILMPJ_1 , RILMPJ_2) * ART1731BIS
            ) ;

REPMEUPJ = (DILMPJ - RILMPJ) * (1 - V_CNR) ;

regle 401630:
application : iliad , batch ;


RMEUBLE_1 = max(min(MEUBLERET , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1
                              -RILMPG_1-RILMIZ_1-RILMJI_1-RILMPC_1-RILMPH_1
                              -RILMJS_1-RILMPD_1-RILMPI_1-RILMPE_1-RILMPJ_1) , 0) ;

RMEUBLE = max( 0 , RMEUBLE_1 * (1-ART1731BIS) 
                   + min( RMEUBLE_1 , RMEUBLE_2 ) * ART1731BIS 
             ) ;

REPMEUIK = (MEUBLERET - RMEUBLE) * (1 - V_CNR) ;

regle 401640:
application : iliad , batch ;


RPROREP_1 = max(min( RETPROREP , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1
                              -RILMPG_1-RILMIZ_1-RILMJI_1-RILMPC_1-RILMPH_1
                              -RILMJS_1-RILMPD_1-RILMPI_1-RILMPE_1-RILMPJ_1
                              -RMEUBLE_1) , 0) ;

RPROREP = max( 0 , RPROREP_1 * (1-ART1731BIS) 
                   + min( RPROREP_1 , RPROREP_2 ) * ART1731BIS
             ) ;

REPMEUIR = (RETPROREP - RPROREP) * (1 - V_CNR) ;

regle 401650:
application : iliad , batch ;


RREPNPRO_1 = max(min( RETREPNPRO , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1
                              -RILMPG_1-RILMIZ_1-RILMJI_1-RILMPC_1-RILMPH_1
                              -RILMJS_1-RILMPD_1-RILMPI_1-RILMPE_1-RILMPJ_1
                              -RMEUBLE_1-RPROREP_1) , 0) ;

RREPNPRO = max( 0 , RREPNPRO_1 * (1-ART1731BIS) 
                    + min( RREPNPRO_1 , RREPNPRO_2 ) * ART1731BIS 
              ) ;

REPMEUIQ = (RETREPNPRO - RREPNPRO) * (1 - V_CNR) ;

regle 401660:
application : iliad , batch ;


RREPMEU_1 = max(min(RETREPMEU , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1
                              -RILMPG_1-RILMIZ_1-RILMJI_1-RILMPC_1-RILMPH_1
                              -RILMJS_1-RILMPD_1-RILMPI_1-RILMPE_1-RILMPJ_1
                              -RMEUBLE_1-RPROREP_1-RREPNPRO_1) , 0) ;

RREPMEU = max( 0 , RREPMEU_1 * (1-ART1731BIS) 
                   + min( RREPMEU_1 , RREPMEU_2 ) * ART1731BIS
             ) ;

REPMEUIP = (RETREPMEU - RREPMEU) * (1 - V_CNR) ;

regle 401670:
application : iliad , batch ;


RILMIC_1 = max(min(DILMIC , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1
                              -RILMPG_1-RILMIZ_1-RILMJI_1-RILMPC_1-RILMPH_1
                              -RILMJS_1-RILMPD_1-RILMPI_1-RILMPE_1-RILMPJ_1
                              -RMEUBLE_1-RPROREP_1-RREPNPRO_1-RREPMEU_1) , 0)
              * (1 - V_CNR) ;

RILMIC = max( 0 , RILMIC_1 * (1-ART1731BIS) 
                  + min( RILMIC_1 , RILMIC_2 ) * ART1731BIS
            ) ;

REPMEUIC = (DILMIC - RILMIC) * (1 - V_CNR) ;

regle 401680:
application : iliad , batch ;


RILMIB_1 = max(min(DILMIB , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1
                              -RILMPG_1-RILMIZ_1-RILMJI_1-RILMPC_1-RILMPH_1
                              -RILMJS_1-RILMPD_1-RILMPI_1-RILMPE_1-RILMPJ_1
                              -RMEUBLE_1-RPROREP_1-RREPNPRO_1-RREPMEU_1-RILMIC_1) , 0)
              * (1 - V_CNR) ;

RILMIB = max( 0 , RILMIB_1 * (1-ART1731BIS) 
                  + min( RILMIB_1 , RILMIB_2 ) * ART1731BIS
            ) ;

REPMEUIB = (DILMIB - RILMIB) * (1 - V_CNR) ;

regle 401690:
application : iliad , batch ;


RILMIA_1 = max(min(DILMIA , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1
                              -RILMPG_1-RILMIZ_1-RILMJI_1-RILMPC_1-RILMPH_1
                              -RILMJS_1-RILMPD_1-RILMPI_1-RILMPE_1-RILMPJ_1
                              -RMEUBLE_1-RPROREP_1-RREPNPRO_1-RREPMEU_1-RILMIC_1
                              -RILMIB_1) , 0)
              * (1 - V_CNR) ;

RILMIA = max(0 , RILMIA_1 * (1 - ART1731BIS) 
                 + min(RILMIA_1 , RILMIA_2) * ART1731BIS
            ) ;

REPMEUIA = (DILMIA - RILMIA) * (1 - V_CNR) ;
  
regle 401700:
application : iliad , batch ;


RILMJY_1 = max(min(DILMJY , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1
                              -RILMPG_1-RILMIZ_1-RILMJI_1-RILMPC_1-RILMPH_1
                              -RILMJS_1-RILMPD_1-RILMPI_1-RILMPE_1-RILMPJ_1
                              -RMEUBLE_1-RPROREP_1-RREPNPRO_1-RREPMEU_1-RILMIC_1
                              -RILMIB_1-RILMIA_1) , 0)
              * (1 - V_CNR) ;

RILMJY = max(0 , RILMJY_1 * (1 - ART1731BIS) 
                 + min(RILMJY_1 , RILMJY_2) * ART1731BIS
            ) ;

REPMEUJY = (DILMJY - RILMJY) * (1 - V_CNR) ;

regle 401710:
application : iliad , batch ;


RILMJX_1 = max(min(DILMJX , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1
                              -RILMPG_1-RILMIZ_1-RILMJI_1-RILMPC_1-RILMPH_1
                              -RILMJS_1-RILMPD_1-RILMPI_1-RILMPE_1-RILMPJ_1
                              -RMEUBLE_1-RPROREP_1-RREPNPRO_1-RREPMEU_1-RILMIC_1
                              -RILMIB_1-RILMIA_1-RILMJY_1) , 0)
                   * (1 - V_CNR) ;

RILMJX = max(0 , RILMJX_1 * (1 - ART1731BIS) 
                 + min(RILMJX_1 , RILMJX_2) * ART1731BIS 
            ) ;

REPMEUJX = (DILMJX - RILMJX) * (1 - V_CNR) ;

regle 401720:
application : iliad , batch ;


RILMJW_1 = max(min(DILMJW , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1
                              -RILMPG_1-RILMIZ_1-RILMJI_1-RILMPC_1-RILMPH_1
                              -RILMJS_1-RILMPD_1-RILMPI_1-RILMPE_1-RILMPJ_1
                              -RMEUBLE_1-RPROREP_1-RREPNPRO_1-RREPMEU_1-RILMIC_1
                              -RILMIB_1-RILMIA_1-RILMJY_1-RILMJX_1) , 0)
              * (1 - V_CNR) ;

RILMJW = max(0 , RILMJW_1 * (1 - ART1731BIS) 
                 + min(RILMJW_1 , RILMJW_2) * ART1731BIS
            ) ;

REPMEUJW = (DILMJW - RILMJW) * (1 - V_CNR) ;

regle 401730:
application : iliad , batch ;

RILMJV_1 = max(min(DILMJV , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1 
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1
                              -RILMPG_1-RILMIZ_1-RILMJI_1-RILMPC_1-RILMPH_1
                              -RILMJS_1-RILMPD_1-RILMPI_1-RILMPE_1-RILMPJ_1
                              -RMEUBLE_1-RPROREP_1-RREPNPRO_1-RREPMEU_1-RILMIC_1
                              -RILMIB_1-RILMIA_1-RILMJY_1-RILMJX_1-RILMJW_1) , 0)
              * (1 - V_CNR) ;


RILMJV = max(0 , RILMJV_1 * (1 - ART1731BIS) 
                 + min(RILMJV_1 , RILMJV_2) * ART1731BIS
            ) ;

REPMEUJV = (DILMJV - RILMJV) * (1 - V_CNR) ;

regle 401740:
application : iliad , batch ;

RILMOE_1 = max(min(DILMOE , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1
                              -RILMPG_1-RILMIZ_1-RILMJI_1-RILMPC_1-RILMPH_1
                              -RILMJS_1-RILMPD_1-RILMPI_1-RILMPE_1-RILMPJ_1
                              -RMEUBLE_1-RPROREP_1-RREPNPRO_1-RREPMEU_1-RILMIC_1
                              -RILMIB_1-RILMIA_1-RILMJY_1-RILMJX_1-RILMJW_1
                              -RILMJV_1) , 0)
              * (1 - V_CNR) ;

RILMOE = max(0 , RILMOE_1 * (1 - ART1731BIS) 
                 + min(RILMOE_1 , RILMOE_2) * ART1731BIS
            ) ;

REPMEUOE = (DILMOE - RILMOE) * (1 - V_CNR) ;

RILMOD_1 = max(min(DILMOD , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1
                              -RILMPG_1-RILMIZ_1-RILMJI_1-RILMPC_1-RILMPH_1
                              -RILMJS_1-RILMPD_1-RILMPI_1-RILMPE_1-RILMPJ_1
                              -RMEUBLE_1-RPROREP_1-RREPNPRO_1-RREPMEU_1-RILMIC_1
                              -RILMIB_1-RILMIA_1-RILMJY_1-RILMJX_1-RILMJW_1
                              -RILMJV_1-RILMOE_1) , 0)
              * (1 - V_CNR) ;

RILMOD = max(0 , RILMOD_1 * (1 - ART1731BIS) 
                 + min(RILMOD_1 , RILMOD_2) * ART1731BIS
            ) ;

REPMEUOD = (DILMOD - RILMOD) * (1 - V_CNR) ;

RILMOC_1 = max(min(DILMOC , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1
                              -RILMPG_1-RILMIZ_1-RILMJI_1-RILMPC_1-RILMPH_1
                              -RILMJS_1-RILMPD_1-RILMPI_1-RILMPE_1-RILMPJ_1
                              -RMEUBLE_1-RPROREP_1-RREPNPRO_1-RREPMEU_1-RILMIC_1
                              -RILMIB_1-RILMIA_1-RILMJY_1-RILMJX_1-RILMJW_1
                              -RILMJV_1-RILMOE_1-RILMOD_1) , 0)
              * (1 - V_CNR) ;

RILMOC = max(0 , RILMOC_1 * (1 - ART1731BIS) 
                 + min(RILMOC_1 , RILMOC_2) * ART1731BIS
            ) ;

REPMEUOC = (DILMOC - RILMOC) * (1 - V_CNR) ;

RILMOB_1 = max(min(DILMOB , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1
                              -RILMPG_1-RILMIZ_1-RILMJI_1-RILMPC_1-RILMPH_1
                              -RILMJS_1-RILMPD_1-RILMPI_1-RILMPE_1-RILMPJ_1
                              -RMEUBLE_1-RPROREP_1-RREPNPRO_1-RREPMEU_1-RILMIC_1
                              -RILMIB_1-RILMIA_1-RILMJY_1-RILMJX_1-RILMJW_1
                              -RILMJV_1-RILMOE_1-RILMOD_1-RILMOC_1) , 0)
              * (1 - V_CNR) ;


RILMOB = max(0 , RILMOB_1 * (1 - ART1731BIS) 
                 + min(RILMOB_1 , RILMOB_2) * ART1731BIS
            ) ;

REPMEUOB = (DILMOB - RILMOB) * (1 - V_CNR) ;

RILMOA_1 = max(min(DILMOA , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1
                              -RILMPG_1-RILMIZ_1-RILMJI_1-RILMPC_1-RILMPH_1
                              -RILMJS_1-RILMPD_1-RILMPI_1-RILMPE_1-RILMPJ_1
                              -RMEUBLE_1-RPROREP_1-RREPNPRO_1-RREPMEU_1-RILMIC_1
                              -RILMIB_1-RILMIA_1-RILMJY_1-RILMJX_1-RILMJW_1
                              -RILMJV_1-RILMOE_1-RILMOD_1-RILMOC_1-RILMOB_1) , 0)
              * (1 - V_CNR) ;

RILMOA = max(0 , RILMOA_1 * (1 - ART1731BIS) 
                 + min(RILMOA_1 , RILMOA_2) * ART1731BIS
            ) ;

REPMEUOA = (DILMOA - RILMOA) * (1 - V_CNR) ;

RILMOJ_1 = max(min(DILMOJ , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1
                              -RILMPG_1-RILMIZ_1-RILMJI_1-RILMPC_1-RILMPH_1
                              -RILMJS_1-RILMPD_1-RILMPI_1-RILMPE_1-RILMPJ_1
                              -RMEUBLE_1-RPROREP_1-RREPNPRO_1-RREPMEU_1-RILMIC_1
                              -RILMIB_1-RILMIA_1-RILMJY_1-RILMJX_1-RILMJW_1
                              -RILMJV_1-RILMOE_1-RILMOD_1-RILMOC_1-RILMOB_1
                              -RILMOA_1) , 0)
              * (1 - V_CNR) ;

RILMOJ = max(0 , RILMOJ_1 * (1 - ART1731BIS) 
                 + min(RILMOJ_1 , RILMOJ_2) * ART1731BIS
            ) ;

REPMEUOJ = (DILMOJ - RILMOJ) * (1 - V_CNR) ;

RILMOI_1 = max(min(DILMOI , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1
                              -RILMPG_1-RILMIZ_1-RILMJI_1-RILMPC_1-RILMPH_1
                              -RILMJS_1-RILMPD_1-RILMPI_1-RILMPE_1-RILMPJ_1
                              -RMEUBLE_1-RPROREP_1-RREPNPRO_1-RREPMEU_1-RILMIC_1
                              -RILMIB_1-RILMIA_1-RILMJY_1-RILMJX_1-RILMJW_1
                              -RILMJV_1-RILMOE_1-RILMOD_1-RILMOC_1-RILMOB_1
                              -RILMOA_1-RILMOJ_1) , 0)
              * (1 - V_CNR) ;

RILMOI = max(0 , RILMOI_1 * (1 - ART1731BIS) 
                 + min(RILMOI_1 , RILMOI_2) * ART1731BIS
            ) ;

REPMEUOI = (DILMOI - RILMOI) * (1 - V_CNR) ;

RILMOH_1 = max(min(DILMOH , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1
                              -RILMPG_1-RILMIZ_1-RILMJI_1-RILMPC_1-RILMPH_1
                              -RILMJS_1-RILMPD_1-RILMPI_1-RILMPE_1-RILMPJ_1
                              -RMEUBLE_1-RPROREP_1-RREPNPRO_1-RREPMEU_1-RILMIC_1
                              -RILMIB_1-RILMIA_1-RILMJY_1-RILMJX_1-RILMJW_1
                              -RILMJV_1-RILMOE_1-RILMOD_1-RILMOC_1-RILMOB_1
                              -RILMOA_1-RILMOJ_1-RILMOI_1) , 0)
              * (1 - V_CNR) ;

RILMOH = max(0 , RILMOH_1 * (1 - ART1731BIS) 
                 + min(RILMOH_1 , RILMOH_2) * ART1731BIS
            ) ;

REPMEUOH = (DILMOH - RILMOH) * (1 - V_CNR) ;

RILMOG_1 = max(min(DILMOG , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1
                              -RILMPG_1-RILMIZ_1-RILMJI_1-RILMPC_1-RILMPH_1
                              -RILMJS_1-RILMPD_1-RILMPI_1-RILMPE_1-RILMPJ_1
                              -RMEUBLE_1-RPROREP_1-RREPNPRO_1-RREPMEU_1-RILMIC_1
                              -RILMIB_1-RILMIA_1-RILMJY_1-RILMJX_1-RILMJW_1
                              -RILMJV_1-RILMOE_1-RILMOD_1-RILMOC_1-RILMOB_1
                              -RILMOA_1-RILMOJ_1-RILMOI_1-RILMOH_1) , 0)
              * (1 - V_CNR) ;

RILMOG = max(0 , RILMOG_1 * (1 - ART1731BIS) 
                 + min(RILMOG_1 , RILMOG_2) * ART1731BIS
            ) ;

REPMEUOG = (DILMOG - RILMOG) * (1 - V_CNR) ;

RILMOF_1 = max(min(DILMOF , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1
                              -RILMPG_1-RILMIZ_1-RILMJI_1-RILMPC_1-RILMPH_1
                              -RILMJS_1-RILMPD_1-RILMPI_1-RILMPE_1-RILMPJ_1
                              -RMEUBLE_1-RPROREP_1-RREPNPRO_1-RREPMEU_1-RILMIC_1
                              -RILMIB_1-RILMIA_1-RILMJY_1-RILMJX_1-RILMJW_1
                              -RILMJV_1-RILMOE_1-RILMOD_1-RILMOC_1-RILMOB_1
                              -RILMOA_1-RILMOJ_1-RILMOI_1-RILMOH_1-RILMOG_1) , 0)
              * (1 - V_CNR) ;

RILMOF = max(0 , RILMOF_1 * (1 - ART1731BIS) 
                 + min(RILMOF_1 , RILMOF_2) * ART1731BIS
            ) ;

REPMEUOF = (DILMOF - RILMOF) * (1 - V_CNR) ;

regle 401750:
application : iliad , batch ;


DRESIMEUB = VIEUMEUB ;

DRESIVIEU = RESIVIEU + RESIVIANT ;

DRESINEUV = LOCRESINEUV + MEUBLENP + INVNPROF1 + INVNPROF2 ;

DLOCIDEFG = LOCMEUBID + LOCMEUBIE + LOCMEUBIF + LOCMEUBIG ;

DCODJTJU = LOCMEUBJT + LOCMEUBJU ;

DCODOU = COD7OU ;

DCODOV = COD7OV ;


ACODOV_1 = arr(min(PLAF_RESINEUV , COD7OV) / 9) * (1 - V_CNR) ;
ACODOV = ACODOV_1 * (1 -ART1731BIS)
         + min( ACODOV_1 , ACODOV_2) * ART1731BIS ;

ACODOU_1 = arr(min(PLAF_RESINEUV , COD7OU) / 9) * (1 - V_CNR) ;
ACODOU = ACODOU_1 * (1 -ART1731BIS)
         + min( ACODOU_1 , ACODOU_2) * ART1731BIS ;


ACODJT = min(PLAF_RESINEUV , LOCMEUBJT) * (1 - V_CNR) ;
ACODJU = min(PLAF_RESINEUV - ACODJT , LOCMEUBJU) * (1 - V_CNR) ;

ACODJTJU_1 = arr(ACODJT / 9) + arr(ACODJU / 9) ;
ACODJTJU = ACODJTJU_1 * (1 -ART1731BIS)
            + min(ACODJTJU_1 , ACODJTJU_2)* ART1731BIS ; 

ACODIE_1 = min(PLAF_RESINEUV , LOCMEUBIE) * (1 - V_CNR) ;
ACODIE = ( ACODIE_1 * (1-ART1731BIS)
          + min( ACODIE_1 , ACODIE_2) * ART1731BIS 
         ) * (1 - V_CNR) ;

ACODIF_1 = min(PLAF_RESINEUV - ACODIE_1 , LOCMEUBIF) * (1 - V_CNR) ;
ACODIF = ( ACODIF_1 * (1-ART1731BIS)
          + min( ACODIF_1 , ACODIF_2) * ART1731BIS 
         ) * (1 - V_CNR) ;


ACODID_1 = min(PLAF_RESINEUV - ACODIE - ACODIF , LOCMEUBID) * (1 - V_CNR) ;
ACODID = ( ACODID_1 * (1-ART1731BIS)
          + min( ACODID_1 , ACODID_2) * ART1731BIS 
         ) * (1 - V_CNR) ;

ACODIG_1 = min(PLAF_RESINEUV - ACODIE - ACODIF - ACODID , LOCMEUBIG) * (1 - V_CNR) ;
ACODIG = ( ACODIG_1 * (1-ART1731BIS)
          + min( ACODIG_1 , ACODIG_2) * ART1731BIS 
         ) * (1 - V_CNR) ;

ALOCIDEFG_1 = arr(ACODIE / 9) + arr(ACODIF / 9) + arr(ACODID / 9) + arr(ACODIG / 9) ; 
ALOCIDEFG = ALOCIDEFG_1 * (1 - ART1731BIS)
            + min( ALOCIDEFG_1 , ALOCIDEFG_2 ) * ART1731BIS ;

ACODIL = min(PLAF_RESINEUV , MEUBLENP) * (1 - V_CNR) ;
ACODIN = min(PLAF_RESINEUV - ACODIL , INVNPROF1) * (1 - V_CNR) ;
ACODIJ = min(PLAF_RESINEUV - ACODIL - ACODIN , LOCRESINEUV) * (1 - V_CNR) ;
ACODIV = min(PLAF_RESINEUV - ACODIL - ACODIN - ACODIJ , INVNPROF2) * (1 - V_CNR) ;

ARESINEUV_1 = arr(ACODIL / 9) + arr(ACODIN / 9) + arr(ACODIJ / 9) + arr(ACODIV / 9) ; 
ARESINEUV = ARESINEUV_1 * (1 - ART1731BIS)
            + min(ARESINEUV_1 , ARESINEUV_2) * ART1731BIS ;

ACODIM = min(PLAF_RESINEUV , RESIVIEU) * (1 - V_CNR) ;
ACODIW = min(PLAF_RESINEUV - ACODIM , RESIVIANT) * (1 - V_CNR) ;

ARESIVIEU_1 = arr(ACODIM / 9) + arr(ACODIW / 9) ;
ARESIVIEU = ARESIVIEU_1 * (1-ART1731BIS)
           + min( ARESIVIEU_1 , ARESIVIEU_2 ) * ART1731BIS ;


ARESIMEUB_1 = arr(min(PLAF_RESINEUV , VIEUMEUB) / 9) * (1 - V_CNR) ;
ARESIMEUB = ARESIMEUB_1 * (1-ART1731BIS)
            + min( ARESIMEUB_1 , ARESIMEUB_2 ) * ART1731BIS ;


RETCODOV = arr(ACODOV_1 * TX11 / 100) ;

RETCODOU = arr(ACODOU_1 * TX11 / 100) ;

RETCODJT = arr(arr(ACODJT / 9) * TX11 / 100) ;
RETCODJU = arr(arr(ACODJU / 9) * TX11 / 100) ;

RETCODIE = arr(arr(ACODIE_1/ 9) * TX18 / 100) ;
RETCODIF = arr(arr(ACODIF_1 / 9) * TX18 / 100) ;
RETCODID = arr(arr(ACODID_1 / 9) * TX11 / 100) ;
RETCODIG = arr(arr(ACODIG_1 / 9) * TX11 / 100) ;
 

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

regle 401760:
application : iliad , batch ;
 
RRESIMEUB_1 = max(min(RETRESIMEUB_1 , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1
                              -RILMPG_1-RILMIZ_1-RILMJI_1-RILMPC_1-RILMPH_1
                              -RILMJS_1-RILMPD_1-RILMPI_1-RILMPE_1-RILMPJ_1
                              -RMEUBLE_1-RPROREP_1-RREPNPRO_1-RREPMEU_1-RILMIC_1
                              -RILMIB_1-RILMIA_1-RILMJY_1-RILMJX_1-RILMJW_1
                              -RILMJV_1-RILMOE_1-RILMOD_1-RILMOC_1-RILMOB_1
                              -RILMOA_1-RILMOJ_1-RILMOI_1-RILMOH_1-RILMOG_1
                              -RILMOF_1) , 0) ;

RRESIMEUB = max( 0 , RRESIMEUB_1 * (1-ART1731BIS) 
                     + min( RRESIMEUB_1 , RRESIMEUB_2) * ART1731BIS
               ) ;

REPLOCIO = (RETRESIMEUB_1 - RRESIMEUB) * positif(VIEUMEUB + 0) * (1 - V_CNR) ;

regle 401770:
application : iliad , batch ;


RCODIW_1 = max(min(RETCODIW , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1
                              -RILMPG_1-RILMIZ_1-RILMJI_1-RILMPC_1-RILMPH_1
                              -RILMJS_1-RILMPD_1-RILMPI_1-RILMPE_1-RILMPJ_1
                              -RMEUBLE_1-RPROREP_1-RREPNPRO_1-RREPMEU_1-RILMIC_1
                              -RILMIB_1-RILMIA_1-RILMJY_1-RILMJX_1-RILMJW_1
                              -RILMJV_1-RILMOE_1-RILMOD_1-RILMOC_1-RILMOB_1
                              -RILMOA_1-RILMOJ_1-RILMOI_1-RILMOH_1-RILMOG_1
                              -RILMOF_1-RRESIMEUB_1) , 0) ;

RCODIW = max( 0 , RCODIW_1 * (1-ART1731BIS) 
                  + min( RCODIW_1 , RCODIW_2 ) * ART1731BIS
            ) ;

REPLOCIW = (RETCODIW - RCODIW) * positif(RESIVIANT + 0) * (1 - V_CNR) ;

RCODIM_1 = max(min(RETCODIM , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1
                              -RILMPG_1-RILMIZ_1-RILMJI_1-RILMPC_1-RILMPH_1
                              -RILMJS_1-RILMPD_1-RILMPI_1-RILMPE_1-RILMPJ_1
                              -RMEUBLE_1-RPROREP_1-RREPNPRO_1-RREPMEU_1-RILMIC_1
                              -RILMIB_1-RILMIA_1-RILMJY_1-RILMJX_1-RILMJW_1
                              -RILMJV_1-RILMOE_1-RILMOD_1-RILMOC_1-RILMOB_1
                              -RILMOA_1-RILMOJ_1-RILMOI_1-RILMOH_1-RILMOG_1
                              -RILMOF_1-RRESIMEUB_1-RCODIW_1) , 0) ;

RCODIM = max( 0 , RCODIM_1 * (1-ART1731BIS) 
                  + min( RCODIM_1 , RCODIM_2 ) * ART1731BIS
            ) ;

REPLOCIM = (RETCODIM - RCODIM) * positif(RESIVIEU + 0) * (1 - V_CNR) ;

RRESIVIEU_1 = RCODIW_1 + RCODIM_1 ;
RRESIVIEU = RCODIW + RCODIM ;

regle 401780:
application : iliad , batch ;


RCODIL_1 = max(min(RETCODIL , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1
                              -RILMPG_1-RILMIZ_1-RILMJI_1-RILMPC_1-RILMPH_1
                              -RILMJS_1-RILMPD_1-RILMPI_1-RILMPE_1-RILMPJ_1
                              -RMEUBLE_1-RPROREP_1-RREPNPRO_1-RREPMEU_1-RILMIC_1
                              -RILMIB_1-RILMIA_1-RILMJY_1-RILMJX_1-RILMJW_1
                              -RILMJV_1-RILMOE_1-RILMOD_1-RILMOC_1-RILMOB_1
                              -RILMOA_1-RILMOJ_1-RILMOI_1-RILMOH_1-RILMOG_1
                              -RILMOF_1-RRESIMEUB_1-RRESIVIEU_1) , 0) ;

RCODIL = RCODIL_1 * ( 1-ART1731BIS) 
         + min( RCODIL_1 , RCODIL_2 ) * ART1731BIS ;

REPLOCIL = (RETCODIL - RCODIL) * positif(MEUBLENP + 0) * (1 - V_CNR) ;

RCODIN_1 = max(min(RETCODIN , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1
                              -RILMPG_1-RILMIZ_1-RILMJI_1-RILMPC_1-RILMPH_1
                              -RILMJS_1-RILMPD_1-RILMPI_1-RILMPE_1-RILMPJ_1
                              -RMEUBLE_1-RPROREP_1-RREPNPRO_1-RREPMEU_1-RILMIC_1
                              -RILMIB_1-RILMIA_1-RILMJY_1-RILMJX_1-RILMJW_1
                              -RILMJV_1-RILMOE_1-RILMOD_1-RILMOC_1-RILMOB_1
                              -RILMOA_1-RILMOJ_1-RILMOI_1-RILMOH_1-RILMOG_1
                              -RILMOF_1-RRESIMEUB_1-RRESIVIEU_1-RCODIL_1) , 0) ;

RCODIN = RCODIN_1 * ( 1-ART1731BIS) 
         + min( RCODIN_1 , RCODIN_2 ) * ART1731BIS ;

REPLOCIN = (RETCODIN - RCODIN) * positif(INVNPROF1 + 0) * (1 - V_CNR) ;

RCODIV_1 = max(min(RETCODIV , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1
                              -RILMPG_1-RILMIZ_1-RILMJI_1-RILMPC_1-RILMPH_1
                              -RILMJS_1-RILMPD_1-RILMPI_1-RILMPE_1-RILMPJ_1
                              -RMEUBLE_1-RPROREP_1-RREPNPRO_1-RREPMEU_1-RILMIC_1
                              -RILMIB_1-RILMIA_1-RILMJY_1-RILMJX_1-RILMJW_1
                              -RILMJV_1-RILMOE_1-RILMOD_1-RILMOC_1-RILMOB_1
                              -RILMOA_1-RILMOJ_1-RILMOI_1-RILMOH_1-RILMOG_1
                              -RILMOF_1-RRESIMEUB_1-RRESIVIEU_1-RCODIL_1-RCODIN_1) , 0) ;

RCODIV = RCODIV_1 * ( 1-ART1731BIS) 
         + min( RCODIV_1 , RCODIV_2 ) * ART1731BIS ;

REPLOCIV = (RETCODIV - RCODIV) * positif(INVNPROF2 + 0) * (1 - V_CNR) ;

RCODIJ_1 = max(min(RETCODIJ , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1
                              -RILMPG_1-RILMIZ_1-RILMJI_1-RILMPC_1-RILMPH_1
                              -RILMJS_1-RILMPD_1-RILMPI_1-RILMPE_1-RILMPJ_1
                              -RMEUBLE_1-RPROREP_1-RREPNPRO_1-RREPMEU_1-RILMIC_1
                              -RILMIB_1-RILMIA_1-RILMJY_1-RILMJX_1-RILMJW_1
                              -RILMJV_1-RILMOE_1-RILMOD_1-RILMOC_1-RILMOB_1
                              -RILMOA_1-RILMOJ_1-RILMOI_1-RILMOH_1-RILMOG_1
                              -RILMOF_1-RRESIMEUB_1-RRESIVIEU_1-RCODIL_1-RCODIN_1-RCODIV_1) , 0) ;

RCODIJ = RCODIJ_1 * ( 1-ART1731BIS) 
         + min( RCODIJ_1 , RCODIJ_2 )* ART1731BIS ;

REPLOCIJ = (RETCODIJ - RCODIJ) * positif(LOCRESINEUV + 0) * (1 - V_CNR) ;

RRESINEUV_1 = RCODIL_1 + RCODIN_1 + RCODIV_1 + RCODIJ_1 ;
RRESINEUV = RCODIL + RCODIN + RCODIV + RCODIJ ;

regle 401790:
application : iliad , batch ;


RCODIE_1 = max(min(RETCODIE , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1
                              -RILMPG_1-RILMIZ_1-RILMJI_1-RILMPC_1-RILMPH_1
                              -RILMJS_1-RILMPD_1-RILMPI_1-RILMPE_1-RILMPJ_1
                              -RMEUBLE_1-RPROREP_1-RREPNPRO_1-RREPMEU_1-RILMIC_1
                              -RILMIB_1-RILMIA_1-RILMJY_1-RILMJX_1-RILMJW_1
                              -RILMJV_1-RILMOE_1-RILMOD_1-RILMOC_1-RILMOB_1
                              -RILMOA_1-RILMOJ_1-RILMOI_1-RILMOH_1-RILMOG_1
                              -RILMOF_1-RRESIMEUB_1-RRESIVIEU_1-RRESINEUV_1) , 0) ;

RCODIE = RCODIE_1 * ( 1- ART1731BIS ) 
          + min( RCODIE_1 , RCODIE_2 ) * ART1731BIS ;

REPLOC7IE = (RETCODIE - RCODIE) * positif(LOCMEUBIE + 0) * (1 - V_CNR) ;

RCODIF_1 = max(min(RETCODIF , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1
                              -RILMPG_1-RILMIZ_1-RILMJI_1-RILMPC_1-RILMPH_1
                              -RILMJS_1-RILMPD_1-RILMPI_1-RILMPE_1-RILMPJ_1
                              -RMEUBLE_1-RPROREP_1-RREPNPRO_1-RREPMEU_1-RILMIC_1
                              -RILMIB_1-RILMIA_1-RILMJY_1-RILMJX_1-RILMJW_1
                              -RILMJV_1-RILMOE_1-RILMOD_1-RILMOC_1-RILMOB_1
                              -RILMOA_1-RILMOJ_1-RILMOI_1-RILMOH_1-RILMOG_1
                              -RILMOF_1-RRESIMEUB_1-RRESIVIEU_1-RRESINEUV_1-RCODIE_1) , 0) ;

RCODIF = RCODIF_1 * ( 1- ART1731BIS )
         + min( RCODIF_1 , RCODIF_2 ) * ART1731BIS ;

REPLOCIF = (RETCODIF - RCODIF) * positif(LOCMEUBIF + 0) * (1 - V_CNR) ;

RCODIG_1 = max(min(RETCODIG , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1
                              -RILMPG_1-RILMIZ_1-RILMJI_1-RILMPC_1-RILMPH_1
                              -RILMJS_1-RILMPD_1-RILMPI_1-RILMPE_1-RILMPJ_1
                              -RMEUBLE_1-RPROREP_1-RREPNPRO_1-RREPMEU_1-RILMIC_1
                              -RILMIB_1-RILMIA_1-RILMJY_1-RILMJX_1-RILMJW_1
                              -RILMJV_1-RILMOE_1-RILMOD_1-RILMOC_1-RILMOB_1
                              -RILMOA_1-RILMOJ_1-RILMOI_1-RILMOH_1-RILMOG_1
                              -RILMOF_1-RRESIMEUB_1-RRESIVIEU_1-RRESINEUV_1-RCODIE_1
                              -RCODIF_1) , 0) ;

RCODIG = RCODIG_1 * ( 1- ART1731BIS ) 
         + min( RCODIG_1 , RCODIG_2 ) * ART1731BIS ;

REPLOCIG = (RETCODIG - RCODIG) * positif(LOCMEUBIG + 0) * (1 - V_CNR) ;

RCODID_1 = max(min(RETCODID , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1
                              -RILMPG_1-RILMIZ_1-RILMJI_1-RILMPC_1-RILMPH_1
                              -RILMJS_1-RILMPD_1-RILMPI_1-RILMPE_1-RILMPJ_1
                              -RMEUBLE_1-RPROREP_1-RREPNPRO_1-RREPMEU_1-RILMIC_1
                              -RILMIB_1-RILMIA_1-RILMJY_1-RILMJX_1-RILMJW_1
                              -RILMJV_1-RILMOE_1-RILMOD_1-RILMOC_1-RILMOB_1
                              -RILMOA_1-RILMOJ_1-RILMOI_1-RILMOH_1-RILMOG_1
                              -RILMOF_1-RRESIMEUB_1-RRESIVIEU_1-RRESINEUV_1-RCODIE_1
                              -RCODIF_1-RCODIG_1) , 0) ;

RCODID = RCODID_1 * ( 1- ART1731BIS )
         + min( RCODID_1 , RCODID_2 ) * ART1731BIS ;  

REPLOCID = (RETCODID - RCODID) * positif(LOCMEUBID + 0) * (1 - V_CNR) ;

RLOCIDEFG_1 = RCODIE_1 + RCODIF_1 + RCODIG_1 + RCODID_1 ;
RLOCIDEFG = RCODIE + RCODIF + RCODIG + RCODID ;

regle 401800:
application : iliad , batch ;


RCODJU_1 = max(min(RETCODJU , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1
                              -RILMPG_1-RILMIZ_1-RILMJI_1-RILMPC_1-RILMPH_1
                              -RILMJS_1-RILMPD_1-RILMPI_1-RILMPE_1-RILMPJ_1
                              -RMEUBLE_1-RPROREP_1-RREPNPRO_1-RREPMEU_1-RILMIC_1
                              -RILMIB_1-RILMIA_1-RILMJY_1-RILMJX_1-RILMJW_1
                              -RILMJV_1-RILMOE_1-RILMOD_1-RILMOC_1-RILMOB_1
                              -RILMOA_1-RILMOJ_1-RILMOI_1-RILMOH_1-RILMOG_1
                              -RILMOF_1-RRESIMEUB_1-RRESIVIEU_1-RRESINEUV_1-RLOCIDEFG_1) , 0) ;

RCODJU = max(0 , RCODJU_1 * ( 1 - ART1731BIS) 
                 + min(RCODJU_1 , RCODJU_2 ) * ART1731BIS
            ) ;

REPLOCJU = (RETCODJU - RCODJU) * positif(LOCMEUBJU + 0) * (1 - V_CNR) ;


RCODJT_1 = max(min(RETCODJT , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1
                              -RILMPG_1-RILMIZ_1-RILMJI_1-RILMPC_1-RILMPH_1
                              -RILMJS_1-RILMPD_1-RILMPI_1-RILMPE_1-RILMPJ_1
                              -RMEUBLE_1-RPROREP_1-RREPNPRO_1-RREPMEU_1-RILMIC_1
                              -RILMIB_1-RILMIA_1-RILMJY_1-RILMJX_1-RILMJW_1
                              -RILMJV_1-RILMOE_1-RILMOD_1-RILMOC_1-RILMOB_1
                              -RILMOA_1-RILMOJ_1-RILMOI_1-RILMOH_1-RILMOG_1
                              -RILMOF_1-RRESIMEUB_1-RRESIVIEU_1-RRESINEUV_1-RLOCIDEFG_1
                              -RCODJU_1) , 0) ;

RCODJT = max(0 , RCODJT_1 * ( 1 - ART1731BIS) 
                 + min(RCODJT_1 , RCODJT_2 ) * ART1731BIS
            ) ;

RCODJTJU_1 = RCODJU_1 + RCODJT_1 ;
RCODJTJU = RCODJU + RCODJT ;

REPLOCJT = (RETCODJT - RCODJT) * positif(LOCMEUBJT + 0) * (1 - V_CNR) ;

RCODOU_1 = max(min(RETCODOU , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1
                              -RILMPG_1-RILMIZ_1-RILMJI_1-RILMPC_1-RILMPH_1
                              -RILMJS_1-RILMPD_1-RILMPI_1-RILMPE_1-RILMPJ_1
                              -RMEUBLE_1-RPROREP_1-RREPNPRO_1-RREPMEU_1-RILMIC_1
                              -RILMIB_1-RILMIA_1-RILMJY_1-RILMJX_1-RILMJW_1
                              -RILMJV_1-RILMOE_1-RILMOD_1-RILMOC_1-RILMOB_1
                              -RILMOA_1-RILMOJ_1-RILMOI_1-RILMOH_1-RILMOG_1
                              -RILMOF_1-RRESIMEUB_1-RRESIVIEU_1-RRESINEUV_1-RLOCIDEFG_1
                              -RCODJTJU_1) , 0) ;

RCODOU = RCODOU_1 * ( 1 - ART1731BIS)
         + min(RCODOU_1 , RCODOU_2) * ART1731BIS ;

REPMEUOU = (RETCODOU - RCODOU) * positif(COD7OU + 0) * (1 - V_CNR) ;

RCODOV_1 = max(min(RETCODOV , IDOM11-DEC11-REDUCAVTCEL_1-RCELTOT_1
                              -RREDMEUB_1-RREDREP_1-RILMIX_1-RILMIY_1-RILMPA_1 
                              -RILMPF_1-RINVRED_1-RILMIH_1-RILMJC_1-RILMPB_1
                              -RILMPG_1-RILMIZ_1-RILMJI_1-RILMPC_1-RILMPH_1
                              -RILMJS_1-RILMPD_1-RILMPI_1-RILMPE_1-RILMPJ_1
                              -RMEUBLE_1-RPROREP_1-RREPNPRO_1-RREPMEU_1-RILMIC_1
                              -RILMIB_1-RILMIA_1-RILMJY_1-RILMJX_1-RILMJW_1
                              -RILMJV_1-RILMOE_1-RILMOD_1-RILMOC_1-RILMOB_1
                              -RILMOA_1-RILMOJ_1-RILMOI_1-RILMOH_1-RILMOG_1
                              -RILMOF_1-RRESIMEUB_1-RRESIVIEU_1-RRESINEUV_1-RLOCIDEFG_1
                              -RCODJTJU_1-RCODOU_1) , 0) ;

RCODOV = RCODOV_1 * ( 1 - ART1731BIS)
         + min(RCODOV_1 , RCODOV_2) * ART1731BIS ;

REPMEUOV = (RETCODOV - RCODOV) * positif(COD7OV + 0) * (1 - V_CNR) ;

RLOCNPRO = RREDMEUB + RREDREP + RILMIX + RILMIY + RILMPA + RILMPF + RINVRED + RILMIH + RILMJC + RILMPB 
           + RILMPG + RILMIZ + RILMJI + RILMPC + RILMPH + RILMJS + RILMPD + RILMPI + RILMPE + RILMPJ
           + RMEUBLE + RPROREP + RREPNPRO + RREPMEU + RILMIC + RILMIB + RILMIA + RILMJY + RILMJX + RILMJW
           + RILMJV + RILMOE + RILMOD + RILMOC + RILMOB + RILMOA + RILMOJ + RILMOI + RILMOH + RILMOG
           + RILMOF + RRESIMEUB + RRESIVIEU + RRESINEUV + RLOCIDEFG + RCODJTJU + RCODOU + RCODOV ;

RLOCNPRO_1 = RREDMEUB_1 + RREDREP_1 + RILMIX_1 + RILMIY_1 + RILMPA_1 + RILMPF_1 + RINVRED_1 + RILMIH_1 + RILMJC_1 + RILMPB_1
             + RILMPG   + RILMIZ_1 + RILMJI_1 + RILMPC_1 + RILMPH_1 + RILMJS_1 + RILMPD_1 + RILMPI_1 + RILMPE_1 + RILMPJ_1
             + RMEUBLE_1 + RPROREP_1 + RREPNPRO_1 +RREPMEU_1 + RILMIC_1 + RILMIB_1 + RILMIA_1 + RILMJY_1 + RILMJX_1 + RILMJW_1
             + RILMJV_1 + RILMOE_1 + RILMOD_1 + RILMOC_1 + RILMOB_1 + RILMOA_1 + RILMOJ_1 + RILMOI_1 + RILMOH_1 + RILMOG_1 
             + RILMOF_1 + RRESIMEUB_1 + RRESIVIEU_1 + RRESINEUV_1 + RLOCIDEFG_1 + RCODJTJU_1 + RCODOU_1 + RCODOV_1 ;

regle 401810:
application : iliad , batch ;


REPMEU15 = REPLOCJT + REPMEUOA + REPMEUOU + REPMEUOV + REPMEUOF ;

REP12MEU15 = REPMEUJV + REPLOCIG + REPLOCIF + REPLOCID + REPLOCJU 
           + REPMEUOB + REPMEUOG ; 

REP11MEU15 = REPMEUIA + REPMEUJW + REPLOCIV + REPLOCIN + REPLOCIJ
           + REPLOC7IE + REPMEUOC + REPMEUOH ;


REP10MEU15 = REPMEUIP + REPMEUIB + REPMEUJX + REPLOCIM + REPLOCIL 
           + REPMEUOD + REPMEUOI ;


REP9MEU15 = REPMEUIK + REPMEUIR + REPMEUIQ + REPMEUIC + REPMEUJY
          + REPLOCIO + REPLOCIW + REPMEUOE + REPMEUOJ ; 
           




regle 401820:
application : iliad , batch ;

RCODOV1 = arr(ACODOV_1 * TX11/100) ;
RCODOV8 = arr(min(PLAF_RESINEUV , COD7OV) * TX11/100) - 8 * RCODOV1 ;
REPLOCOV = (RCODOV8 + RCODOV1 * 7) ;

RCODOU1 = arr(ACODOU_1 * TX11/100) ;
RCODOU8 = arr(min(PLAF_RESINEUV , COD7OU) * TX11/100) - 8 * RCODOU1 ;
REPLOCOU = (RCODOU8 + RCODOU1 * 7) * (1-null(2-V_REGCO)) * (1-null(4-V_REGCO)) ;

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

RLOCIDFG1 = arr(arr(ACODID_1 / 9) * TX11/100) + arr(arr(ACODIF_1 / 9) * TX18/100) + arr(arr(ACODIG_1 / 9) * TX11/100) ;
RLOCIDFG2 = arr(arr(ACODID_1 / 9) * TX11/100) + arr(arr(ACODIF_1 / 9) * TX18/100) + arr(arr(ACODIG_1 / 9) * TX11/100) ; 
RLOCIDFG3 = arr(arr(ACODID_1 / 9) * TX11/100) + arr(arr(ACODIF_1 / 9) * TX18/100) + arr(arr(ACODIG_1 / 9) * TX11/100) ;
RLOCIDFG4 = arr(arr(ACODID_1 / 9) * TX11/100) + arr(arr(ACODIF_1 / 9) * TX18/100) + arr(arr(ACODIG_1 / 9) * TX11/100) ;
RLOCIDFG5 = arr(arr(ACODID_1 / 9) * TX11/100) + arr(arr(ACODIF_1 / 9) * TX18/100) + arr(arr(ACODIG_1 / 9) * TX11/100) ;
RLOCIDFG6 = arr(arr(ACODID_1 / 9) * TX11/100) + arr(arr(ACODIF_1 / 9) * TX18/100) + arr(arr(ACODIG_1 / 9) * TX11/100) ;
RLOCIDFG7 = arr(arr(ACODID_1 / 9) * TX11/100) + arr(arr(ACODIF_1 / 9) * TX18/100) + arr(arr(ACODIG_1 / 9) * TX11/100) ;
RLOCIDFG8 = arr(ACODID_1 * TX11/100) + arr(ACODIF_1 * TX18/100) + arr(ACODIG_1 * TX11/100)
	     - RLOCIDFG1 - RLOCIDFG2 - RLOCIDFG3 - RLOCIDFG4 - RLOCIDFG5 - RLOCIDFG6 - RLOCIDFG7 - RLOCIDFG7 ;
REPLOCIDFG = RLOCIDFG1 + RLOCIDFG2 + RLOCIDFG3 + RLOCIDFG4 + RLOCIDFG5 + RLOCIDFG6 + RLOCIDFG7 + RLOCIDFG8 ;

REPLOCIE1 = arr(arr(ACODIE_1 / 9) * TX18/100) ; 
REPLOCIE2 = arr(arr(ACODIE_1 / 9) * TX18/100) ; 
REPLOCIE3 = arr(arr(ACODIE_1 / 9) * TX18/100) ; 
REPLOCIE4 = arr(arr(ACODIE_1 / 9) * TX18/100) ; 
REPLOCIE5 = arr(arr(ACODIE_1 / 9) * TX18/100) ; 
REPLOCIE6 = arr(arr(ACODIE_1 / 9) * TX18/100) ; 
REPLOCIE7 = arr(arr(ACODIE_1 / 9) * TX18/100) ; 
REPLOCIE8 = arr(ACODIE_1 * TX18/100) - REPLOCIE1 - REPLOCIE2 - REPLOCIE3 - REPLOCIE4 - REPLOCIE5 - REPLOCIE6 - REPLOCIE7 - REPLOCIE7 ;
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

RESIMEUB1 = arr(arr(min(DRESIMEUB , PLAF_RESINEUV) / 9) * TX25/100) * (1-positif(null(2-V_REGCO) + null(4-V_REGCO))) ;
RESIMEUB2 = arr(arr(min(DRESIMEUB , PLAF_RESINEUV) / 9) * TX25/100) * (1-positif(null(2-V_REGCO) + null(4-V_REGCO))) ;
RESIMEUB3 = arr(arr(min(DRESIMEUB , PLAF_RESINEUV) / 9) * TX25/100) * (1-positif(null(2-V_REGCO) + null(4-V_REGCO))) ;
RESIMEUB4 = arr(arr(min(DRESIMEUB , PLAF_RESINEUV) / 9) * TX25/100) * (1-positif(null(2-V_REGCO) + null(4-V_REGCO))) ;
RESIMEUB5 = arr(arr(min(DRESIMEUB , PLAF_RESINEUV) / 9) * TX25/100) * (1-positif(null(2-V_REGCO) + null(4-V_REGCO))) ;
RESIMEUB6 = arr(arr(min(DRESIMEUB , PLAF_RESINEUV) / 9) * TX25/100) * (1-positif(null(2-V_REGCO) + null(4-V_REGCO))) ;
RESIMEUB7 = arr(arr(min(DRESIMEUB , PLAF_RESINEUV) / 9) * TX25/100) * (1-positif(null(2-V_REGCO) + null(4-V_REGCO))) ;
RESIMEUB8 = arr(min(DRESIMEUB , PLAF_RESINEUV) * TX25/100) * (1-positif(null(2-V_REGCO) + null(4-V_REGCO))) 
            - RESIMEUB1 - RESIMEUB2 - RESIMEUB3 - RESIMEUB4 - RESIMEUB5 - RESIMEUB6 - RESIMEUB7 - RESIMEUB7 ;

REPMEUB = (RESIMEUB1 + RESIMEUB2 + RESIMEUB3 + RESIMEUB4 + RESIMEUB5 + RESIMEUB6 + RESIMEUB7 + RESIMEUB8) ;

regle 401830:
application : iliad , batch ;


BSOCREP = min(RSOCREPRISE , LIM_SOCREPR * ( 1 + BOOL_0AM)) ;

RSOCREP = arr ( TX_SOCREPR/100 * BSOCREP ) * (1 - V_CNR);

DSOCREPR = RSOCREPRISE;

ASOCREPR = (BSOCREP * (1 - ART1731BIS) 
             + min( BSOCREP , ASOCREPR_2) * ART1731BIS
           ) * (1-V_CNR)  ;

RSOCREPR_1 = max( min( RSOCREP , IDOM11-DEC11-RCOTFOR_1-RREPA_1-RAIDE_1-RDIFAGRI_1-RPRESSE_1-RFORET_1-RFIPDOM_1-RFIPC_1-RCINE_1-RRESTIMO_1) , 0 );

RSOCREPR = max( 0, RSOCREPR_1 * (1-ART1731BIS) 
                    + min( RSOCREPR_1 , RSOCREPR_2 ) * ART1731BIS
              ) ;

regle 401840:
application : iliad , batch ;


DRESTIMO = RIMOSAUVANT + RIMOPPAUANT + RESTIMOPPAU + RESTIMOSAUV + RIMOPPAURE + RIMOSAUVRF + COD7SY + COD7SX ;

RESTIMOD = min(RIMOSAUVANT , LIM_RESTIMO) ;
RRESTIMOD = max (min (RESTIMOD * TX40/100 , IDOM11-DEC11-RCOTFOR_1-RREPA_1-RFIPDOM_1-RAIDE_1-RDIFAGRI_1-RPRESSE_1-RFORET_1
                                            -RFIPC_1-RCINE_1) , 0) ;

RESTIMOB = min (RESTIMOSAUV , LIM_RESTIMO - RESTIMOD) ;
RRESTIMOB = max (min (RESTIMOB * TX36/100 , IDOM11-DEC11-RCOTFOR_1-RREPA_1-RFIPDOM_1-RAIDE_1-RDIFAGRI_1-RPRESSE_1-RFORET_1
                                            -RFIPC_1-RCINE_1-RRESTIMOD) , 0) ;

RESTIMOC = min(RIMOPPAUANT , LIM_RESTIMO - RESTIMOD - RESTIMOB) ;
RRESTIMOC = max (min (RESTIMOC * TX30/100 , IDOM11-DEC11-RCOTFOR_1-RREPA_1-RFIPDOM_1-RAIDE_1-RDIFAGRI_1-RPRESSE_1-RFORET_1
                                            -RFIPC_1-RCINE_1-RRESTIMOD-RRESTIMOB) , 0) ;

RESTIMOF = min(RIMOSAUVRF , LIM_RESTIMO - RESTIMOD - RESTIMOB - RESTIMOC) ;
RRESTIMOF = max (min (RESTIMOF * TX30/100 , IDOM11-DEC11-RCOTFOR_1-RREPA_1-RFIPDOM_1-RAIDE_1-RDIFAGRI_1-RPRESSE_1-RFORET_1
                                            -RFIPC_1-RCINE_1-RRESTIMOD-RRESTIMOB-RRESTIMOC) , 0) ;

RESTIMOY = min(COD7SY , LIM_RESTIMO - RESTIMOD - RESTIMOB - RESTIMOC - RESTIMOF) ;
RRESTIMOY = max (min (RESTIMOY * TX30/100 , IDOM11-DEC11-RCOTFOR_1-RREPA_1-RFIPDOM_1-RAIDE_1-RDIFAGRI_1-RPRESSE_1-RFORET_1
                                            -RFIPC_1-RCINE_1-RRESTIMOD-RRESTIMOB-RRESTIMOC-RRESTIMOF) , 0) ;

RESTIMOA = min(RESTIMOPPAU , LIM_RESTIMO - RESTIMOD - RESTIMOB - RESTIMOC - RESTIMOF - RESTIMOY) ;
RRESTIMOA = max (min (RESTIMOA * TX_RESTIMO1/100 , IDOM11-DEC11-RCOTFOR_1-RREPA_1-RFIPDOM_1-RAIDE_1-RDIFAGRI_1-RPRESSE_1-RFORET_1
                                                   -RFIPC_1-RCINE_1-RRESTIMOD-RRESTIMOB-RRESTIMOC-RRESTIMOF
                                                   -RRESTIMOY) , 0) ;

RESTIMOE = min(RIMOPPAURE , LIM_RESTIMO - RESTIMOD - RESTIMOB - RESTIMOC - RESTIMOF - RESTIMOY - RESTIMOA) ;
RRESTIMOE = max (min (RESTIMOE * TX22/100 , IDOM11-DEC11-RCOTFOR_1-RREPA_1-RFIPDOM_1-RAIDE_1-RDIFAGRI_1-RPRESSE_1-RFORET_1
                                            -RFIPC_1-RCINE_1-RRESTIMOD-RRESTIMOB-RRESTIMOC-RRESTIMOF
                                            -RRESTIMOY-RRESTIMOA) , 0) ;


RESTIMOX = min(COD7SX , LIM_RESTIMO - RESTIMOD - RESTIMOB - RESTIMOC - RESTIMOF - RESTIMOY - RESTIMOA - RESTIMOE) ;
RRESTIMOX = max (min (RESTIMOX * TX22/100 , IDOM11-DEC11-RCOTFOR_1-RREPA_1-RFIPDOM_1-RAIDE_1-RDIFAGRI_1-RPRESSE_1-RFORET_1
                                            -RFIPC_1-RCINE_1-RRESTIMOD-RRESTIMOB-RRESTIMOC-RRESTIMOF
                                            -RRESTIMOY-RRESTIMOA-RRESTIMOE ) , 0) ;

ARESTIMO_1 = (RESTIMOD + RESTIMOB + RESTIMOC + RESTIMOF + RESTIMOA + RESTIMOE + RESTIMOY + RESTIMOX) * (1 - V_CNR) ;

ARESTIMO = ( ARESTIMO_1 * (1-ART1731BIS)
              + min( ARESTIMO_1, ARESTIMO_2) * ART1731BIS
           ) * (1 - V_CNR) ;

RETRESTIMO = arr((RESTIMOD * TX40/100) + (RESTIMOB * TX36/100)
		 + (RESTIMOC * TX30/100) + (RESTIMOA * TX_RESTIMO1/100)
		 + (RESTIMOE * TX22/100) + (RESTIMOF * TX30/100)
                 + (RESTIMOY * TX30/100) + (RESTIMOX * TX22/100)) * (1 - V_CNR) ;

RRESTIMO_1 = max (min (RETRESTIMO , IDOM11-DEC11-RCOTFOR_1-RREPA_1-RFIPDOM_1-RAIDE_1-RDIFAGRI_1-RPRESSE_1-RFORET_1-RFIPC_1-RCINE_1) , 0) ;

RRESTIMO = max ( 0 , RRESTIMO_1 * (1-ART1731BIS)
                     + min( RRESTIMO_1 , RRESTIMO_2 ) * ART1731BIS
               ) ;

A12RRESTIMO_1 = arr(max (min(RRESTIMO_1 , RRESTIMOD+RRESTIMOB+RRESTIMOC+RRESTIMOF
                                         +RRESTIMOA+RRESTIMOE),0)) * (1 - V_CNR) ;

A12RRESTIMO_2 = max(A12RRESTIMO_P + A12RRESTIMOP2 , A12RRESTIMO1731)*(1-PREM8_11)*ART1731BIS ;

A12RRESTIMO = max ( 0 , A12RRESTIMO_1 * (1-ART1731BIS)
                     + min( A12RRESTIMO_1 , A12RRESTIMO_2 ) * ART1731BIS
               ) * (1 - V_CNR) ;


RRESTIMOXY  = max( RRESTIMO - A12RRESTIMO , 0) * (1 - V_CNR) ;

regle 401850:
application : iliad , batch ;

REVDON = max(0,RBL+TOTALQUOHT-SDD-SDC1) ;
BDON7UH = min(LIM15000,COD7UH);
BASEDONB = REPDON03 + REPDON04 + REPDON05 + REPDON06 + REPDON07 + RDDOUP + COD7UH + DONAUTRE;
BASEDONP = RDDOUP + BDON7UH + DONAUTRE + EXCEDANTA;
BON = arr (min (REPDON03+REPDON04+REPDON05+REPDON06+REPDON07+RDDOUP+BDON7UH+DONAUTRE+EXCEDANTA,REVDON *(TX_BASEDUP)/100));


regle 401860:
application : iliad , batch ;

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

regle 401870:
application : iliad , batch ;


RON = arr( BON *(TX_REDDON)/100 ) * (1 - V_CNR) ;

DDONS = RDDOUP + DONAUTRE + REPDON03 + REPDON04 + REPDON05 + REPDON06 + REPDON07 + COD7UH;

ADONS = ( BON * (1-ART1731BIS) 
          + min( BON , ADONS_2 ) * ART1731BIS
        ) * (1 - V_CNR) ;

regle 401880:
application : iliad , batch ;

RDONS_1 = max( min( RON , RRI1_1-RLOGDOM_1-RCOMP_1-RRETU_1) , 0 ) ;

RDONS = max( 0, RDONS_1 * (1-ART1731BIS) 
                + min( RDONS_1 , RDONS_2 ) * ART1731BIS
           ) ;

regle 401885:
application : iliad , batch ;

CRCFA_1 = arr(IPQ1 * REGCI / (RB018XR + TONEQUO)) * (1 - positif(RE168 + TAX1649)) ;

CRCFA =  max(0, CRCFA_1 * (1-ART1731BIS) 
                + min(CRCFA_1 , CRCFA_2) * ART1731BIS) ;

regle 401887:
application : iliad , batch ;

CRDIE_1 = max( min( CRCFA , RRI1_1-RLOGDOM_1-RCOMP_1-RRETU_1-RDONS_1) , 0 ) ;

CRDIE =  max(0, CRDIE_1 * (1-ART1731BIS) 
                + min(CRDIE_1 , CRDIE_2) * ART1731BIS) ;

regle 401890:
application : iliad , batch ;


SEUILRED1 = arr((arr(RI1)+REVQUO) / NBPT) ;

regle 401900:
application : iliad , batch ;

RETUD = (1 - V_CNR) * arr((RDENS * MTRC) + (RDENL * MTRL) + (RDENU * MTRS) 
                           + (RDENSQAR * MTRC /2) + (RDENLQAR * MTRL /2) + (RDENUQAR * MTRS /2));
DNBE = RDENS + RDENL + RDENU + RDENSQAR + RDENLQAR + RDENUQAR ;

RNBE_1 = RDENS + RDENL + RDENU + RDENSQAR + RDENLQAR + RDENUQAR ;

RNBE = RNBE_1 * (1-ART1731BIS)
       + min( RNBE_1 , RNBE_2 ) * ART1731BIS ;

regle 401910:
application : iliad , batch ;

RRETU_1 = max(min( RETUD , RRI1-RLOGDOM_1-RCOMP_1) , 0) ;

RRETU = max( 0 , RRETU_1 * (1-ART1731BIS)
                 + min( RRETU_1 , RRETU_2 ) * ART1731BIS
           ) ; 

regle 401920:
application : iliad , batch ;


BFCPI_1 = ( positif(BOOL_0AM) * min (FCPI,PLAF_FCPI*2) + positif(1-BOOL_0AM) * min (FCPI,PLAF_FCPI) ) * (1-V_CNR);

BFCPI = BFCPI_1 * (1-ART1731BIS) 
         + min(BFCPI_1 , BFCPI_2 ) * ART1731BIS ;


RFCPI = arr (BFCPI_1  * TX_FCPI /100) ; 

RINNO_1 = max( min( RFCPI , IDOM11-DEC11-RCOTFOR_1-RREPA_1-RFIPDOM_1-RAIDE_1-RDIFAGRI_1-RPRESSE_1-RFORET_1-RFIPC_1
			  -RCINE_1-RRESTIMO_1-RSOCREPR_1-RRPRESCOMP_1-RHEBE-RSURV_1) , 0 );

RINNO = max( 0, RINNO_1 * (1-ART1731BIS)
                + min (RINNO_1 , RINNO_2) * ART1731BIS
           ) ;

regle 401930:
application : iliad , batch ;


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
              + min( BPRESCOMP , APRESCOMP_2 ) * ART1731BIS
            ) * (1 - V_CNR) ;

RRPRESCOMP_1 = max( min( RPRESCOMP , IDOM11-DEC11-RCOTFOR_1-RREPA_1-RFIPDOM_1-RAIDE_1-RDIFAGRI_1-RPRESSE_1-RFORET_1
                                                 -RFIPC_1-RCINE_1-RRESTIMO_1-RSOCREPR_1) , 0) ;

RRPRESCOMP = max( 0 , RRPRESCOMP_1 * (1-ART1731BIS) 
                       + min( RRPRESCOMP_1 , RRPRESCOMP_2 ) * ART1731BIS ) ;

RPRESCOMPREP = max( min( RPRESCOMP , IDOM11-DEC11-RCOTFOR-RREPA-RFIPDOM-RAIDE-RDIFAGRI-RPRESSE-RFORET
				      -RFIPC-RCINE-RRESTIMO-RSOCREPR) , 0) * positif(RDPRESREPORT) ;

RPRESCOMPAN = RRPRESCOMP * (1-positif(RDPRESREPORT)) ;

regle 401940:
application : iliad , batch ;

DCOTFOR = COTFORET ;

ACOTFOR_R = min(DCOTFOR , PLAF_FOREST1 * (1 + BOOL_0AM)) * (1 - V_CNR) ;

ACOTFOR = (ACOTFOR_R * (1-ART1731BIS)
           + min( ACOTFOR_R, ACOTFOR_2 ) * ART1731BIS
          ) * (1 - V_CNR);

RCOTFOR_1 = max( min( arr(ACOTFOR_R * TX76/100) , IDOM11-DEC11) , 0) ;

RCOTFOR = RCOTFOR_1 * (1-ART1731BIS)
          + min( RCOTFOR_1, RCOTFOR_2 ) * ART1731BIS ;


regle 401950:
application : iliad , batch ;


FORTRA = REPFOR + REPSINFOR + REPFOR1 + REPSINFOR1 + REPFOR2 + REPSINFOR2 + REPSINFOR3 + REPSINFOR4 ;

DFOREST = FORTRA + RDFOREST;


AFOREST_1 = min (FORTRA, max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR)) * (1 - V_CNR) 
             + min (RDFOREST, PLAF_FOREST * (1 + BOOL_0AM));

AFOREST = ( AFOREST_1 * (1-ART1731BIS) 
            + min( AFOREST_1 , AFOREST_2 ) * ART1731BIS
          ) * (1 - V_CNR) ;


RFOREST1 = min( REPSINFOR + REPSINFOR1 , max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR)) ;

RFOREST2 = min( REPFOR + REPSINFOR2 , max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR - RFOREST1)) ;

RFOREST3 = min( REPFOR1 + REPSINFOR3 +REPFOR2+REPSINFOR4, max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR - RFOREST1 - RFOREST2)) ;

RFOREST = (arr(RFOREST1 * TX25/100) + arr(RFOREST2 * TX22/100) + arr(RFOREST3 * TX18/100)
	  + arr( max(0 , AFOREST - RFOREST1 - RFOREST2 - RFOREST3) * TX18/100)) * (1 - V_CNR) ;

regle 401960:
application : iliad , batch ;

RFOR_1 = max(min(RFOREST , IDOM11-DEC11-RCOTFOR_1-RREPA_1-RAIDE_1-RDIFAGRI_1-RPRESSE_1-RFORET_1
                           -RFIPDOM_1-RFIPC_1-RCINE_1-RRESTIMO_1-RSOCREPR_1
			   -RRPRESCOMP_1-RHEBE_1-RSURV_1-RINNO_1-RSOUFIP_1-RRIRENOV_1 
                           -RLOGDOM_1-RCOMP_1-RRETU_1-RDONS_1-CRDIE_1-RDUFLOTOT_1
                           -RPINELTOT_1-RNOUV_1-RPLAFREPME4_1-RPENTDY_1) , 0) ;

RFOR = max( 0 , RFOR_1 * (1-ART1731BIS) 
                 + min( RFOR_1 , RFOR_2 ) * ART1731BIS
          ) ;

regle 401970:
application : iliad , batch ;

VARD = max(0,min(REPFOR,max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR_R)-REPSINFOR-REPSINFOR1));

REPSIN = max(0 , REPSINFOR - max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR_R)) * (1 - V_CNR) ; 


REPFORSIN = (positif_ou_nul(REPSINFOR+VARD- max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR_R)) * REPSINFOR1
            + (1-positif_ou_nul(REPSINFOR+VARD- max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR_R))) *
              max(0,REPSINFOR1 - max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR_R - REPSINFOR-VARD))) * (1 - V_CNR); 
REPFORSIN2 = (positif_ou_nul(REPSINFOR+VARD- max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR_R)) * REPSINFOR2 
           + (1-positif_ou_nul(REPSINFOR+VARD- max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR_R)))
              * max(0,REPSINFOR2 - max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR_R - REPSINFOR-VARD))) * (1 - V_CNR); 
            

REPFOREST3 =  (positif_ou_nul(REPSINFOR+VARD+REPSINFOR1+REPSINFOR2- max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR_R)) * REPFOR1
           + (1-positif_ou_nul(REPSINFOR+VARD+REPSINFOR1+REPSINFOR2- max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR_R)))
              * max(0,REPFOR1 - max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR_R - REPSINFOR-VARD-REPSINFOR1-REPSINFOR2))) * (1 - V_CNR); 

REPFORSIN3 = (positif_ou_nul(REPSINFOR+VARD+REPSINFOR1+REPSINFOR2- max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR_R)) * REPSINFOR3
           + (1-positif_ou_nul(REPSINFOR+VARD+REPSINFOR1+REPSINFOR2- max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR_R)))
              * max(0,REPSINFOR3 - max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR_R - REPSINFOR-VARD-REPSINFOR1-REPSINFOR2))) * (1 - V_CNR); 
REPEST =  (positif_ou_nul(REPSINFOR+VARD+REPSINFOR1+REPFOR1+REPSINFOR2+REPSINFOR3- max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR_R)) * REPFOR2
           + (1-positif_ou_nul(REPSINFOR+VARD+REPSINFOR1+REPFOR1+REPSINFOR2+REPSINFOR3- max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR_R)))
              * max(0,REPFOR2 - max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR_R - REPSINFOR-VARD-REPSINFOR1-REPFOR1-REPSINFOR2
                                                                 -REPSINFOR3))) * (1 - V_CNR); 

REPNIS = (positif_ou_nul(REPSINFOR+VARD+REPSINFOR1+REPFOR1+REPSINFOR2+REPSINFOR3- max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR_R)) * REPSINFOR4
           + (1-positif_ou_nul(REPSINFOR+VARD+REPSINFOR1+REPFOR1+REPSINFOR2+REPSINFOR3- max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR_R)))
              * max(0,REPSINFOR4 - max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR_R - REPSINFOR-VARD-REPSINFOR1-REPFOR1-REPSINFOR2
                                                                 -REPSINFOR3))) * (1 - V_CNR); 

REP7UV = REPFOREST3 + REPEST ;

REP7TE = REPSIN + REPFORSIN + REPFORSIN2 + REPFORSIN3 + REPNIS ;

regle 401980:
application : iliad , batch ;


BDIFAGRI =   min ( INTDIFAGRI , LIM_DIFAGRI * ( 1 + BOOL_0AM)) * ( 1 - V_CNR) ;

DDIFAGRI = INTDIFAGRI ;

ADIFAGRI = BDIFAGRI * (1-ART1731BIS)
            + min( BDIFAGRI , ADIFAGRI_2) * ART1731BIS ;

RAGRI = arr (BDIFAGRI  * TX_DIFAGRI / 100 );

RDIFAGRI_1 = max( min(RAGRI , IDOM11-DEC11-RCOTFOR_1-RREPA_1-RAIDE_1),0);

RDIFAGRI =  RDIFAGRI_1 * (1-ART1731BIS)
            + min( RDIFAGRI_1 , RDIFAGRI_2) * ART1731BIS ;


regle 401990:
application : iliad , batch ;


ITRED = min( RED , IDOM11-DEC11) ;

regle 402000:
application : iliad , batch ;


NRCOMP = max(min( RFC , RRI1-NRLOGDOM) , 0) ;

NRRETU = max(min( RETUD , RRI1-NRLOGDOM-NRCOMP) , 0) ;

NRDONS = max(min( RON , RRI1-NRLOGDOM-NRCOMP-NRRETU) , 0) ;

NCRDIE = max(min( CRCFA , RRI1-NRLOGDOM-NRCOMP-NRRETU-NRDONS) , 0) ;

NRDUFREPFI = max(min( ADUFREPFI , RRI1-NRLOGDOM-NRCOMP-NRRETU-NRDONS-NCRDIE) , 0) ;

NRDUFREPFK = max(min( ADUFREPFK , RRI1-NRLOGDOM-NRCOMP-NRRETU-NRDONS-NCRDIE-NRDUFREPFI) , 0) ;

NRDUFLOGIH = max(min( RDUFLO_GIH , RRI1-NRLOGDOM-NRCOMP-NRRETU-NRDONS-NCRDIE-NRDUFREPFI-NRDUFREPFK) , 0) ;

NRDUFLOEKL = max(min( RDUFLO_EKL , RRI1-NRLOGDOM-NRCOMP-NRRETU-NRDONS-NCRDIE-NRDUFREPFI-NRDUFREPFK-NRDUFLOGIH) , 0) ;

NRPIREPAI = max(min( APIREPAI , RRI1-NRLOGDOM-NRCOMP-NRRETU-NRDONS-NCRDIE-NRDUFREPFI-NRDUFREPFK-NRDUFLOGIH-NRDUFLOEKL) , 0) ;

NRPIREPBI = max(min( APIREPBI , RRI1-NRLOGDOM-NRCOMP-NRRETU-NRDONS-NCRDIE-NRDUFREPFI-NRDUFREPFK-NRDUFLOGIH-NRDUFLOEKL-NRPIREPAI) , 0) ;

NRPIREPCI = max(min( APIREPCI , RRI1-NRLOGDOM-NRCOMP-NRRETU-NRDONS-NCRDIE-NRDUFREPFI-NRDUFREPFK-NRDUFLOGIH-NRDUFLOEKL-NRPIREPAI-NRPIREPBI) , 0) ;

NRPIREPDI = max(min( APIREPDI , RRI1-NRLOGDOM-NRCOMP-NRRETU-NRDONS-NCRDIE-NRDUFREPFI-NRDUFREPFK-NRDUFLOGIH-NRDUFLOEKL-NRPIREPAI-NRPIREPBI-NRPIREPCI) , 0) ;

NRPIGH = max(min( RPI_GH , RRI1-NRLOGDOM-NRCOMP-NRRETU-NRDONS-NCRDIE-NRDUFREPFI-NRDUFREPFK-NRDUFLOGIH-NRDUFLOEKL-NRPIREPAI-NRPIREPBI-NRPIREPCI-NRPIREPDI) , 0) ;

NRPIEF = max(min( RPI_EF , RRI1-NRLOGDOM-NRCOMP-NRRETU-NRDONS-NCRDIE-NRDUFREPFI-NRDUFREPFK-NRDUFLOGIH-NRDUFLOEKL-NRPIREPAI-NRPIREPBI-NRPIREPCI-NRPIREPDI-NRPIGH) , 0) ;

NRPICD = max(min( RPI_CD , RRI1-NRLOGDOM-NRCOMP-NRRETU-NRDONS-NCRDIE-NRDUFREPFI-NRDUFREPFK-NRDUFLOGIH-NRDUFLOEKL-NRPIREPAI-NRPIREPBI-NRPIREPCI-NRPIREPDI-NRPIGH-NRPIEF) , 0) ; 

NRPIAB = max(min( RPI_AB , RRI1-NRLOGDOM-NRCOMP-NRRETU-NRDONS-NCRDIE-NRDUFREPFI-NRDUFREPFK-NRDUFLOGIH-NRDUFLOEKL-NRPIREPAI-NRPIREPBI-NRPIREPCI-NRPIREPDI-NRPIGH-NRPIEF-NRPICD) , 0) ;

NRNOUV = max(min( RSN , RRI1-NRLOGDOM-NRCOMP-NRRETU-NRDONS-NCRDIE-NRDUFREPFI-NRDUFREPFK-NRDUFLOGIH-NRDUFLOEKL-NRPIREPAI-NRPIREPBI-NRPIREPCI-NRPIREPDI-NRPIGH-NRPIEF-NRPICD-NRPIAB) , 0 ) ;

NRPLAFPME = max(min( COD7CY , RRI1-NRLOGDOM-NRCOMP-NRRETU-NRDONS-NCRDIE-NRDUFREPFI-NRDUFREPFK-NRDUFLOGIH-NRDUFLOEKL-NRPIREPAI-NRPIREPBI-NRPIREPCI-NRPIREPDI-NRPIGH-NRPIEF-NRPICD-NRPIAB
                                   -NRNOUV) , 0 ) ;

NRPENTDY = max(min( COD7DY , RRI1-NRLOGDOM-NRCOMP-NRRETU-NRDONS-NCRDIE-NRDUFREPFI-NRDUFREPFK-NRDUFLOGIH-NRDUFLOEKL-NRPIREPAI-NRPIREPBI-NRPIREPCI-NRPIREPDI-NRPIGH-NRPIEF-NRPICD-NRPIAB
                                  -NRNOUV-NRPLAFPME) , 0 ) ;

NRFOR = max(min( RFOREST , RRI1-NRLOGDOM-NRCOMP-NRRETU-NRDONS-NCRDIE-NRDUFREPFI-NRDUFREPFK-NRDUFLOGIH-NRDUFLOEKL-NRPIREPAI-NRPIREPBI-NRPIREPCI-NRPIREPDI-NRPIGH-NRPIEF-NRPICD-NRPIAB
                                -NRNOUV-NRPLAFPME-NRPENTDY) , 0 ) ;

NRTOURREP = max(min( arr(ATOURREP * TX_REDIL25 / 100) , RRI1-NRLOGDOM-NRCOMP-NRRETU-NRDONS-NCRDIE-NRDUFREPFI-NRDUFREPFK-NRDUFLOGIH-NRDUFLOEKL-NRPIREPAI-NRPIREPBI-NRPIREPCI-NRPIREPDI
                                                             -NRPIGH-NRPIEF-NRPICD-NRPIAB-NRNOUV-NRPLAFPME-NRPENTDY-NRFOR) , 0 ) ;

NRTOUHOTR = max(min( RIHOTR , RRI1-NRLOGDOM-NRCOMP-NRRETU-NRDONS-NCRDIE-NRDUFREPFI-NRDUFREPFK-NRDUFLOGIH-NRDUFLOEKL-NRPIREPAI-NRPIREPBI-NRPIREPCI-NRPIREPDI-NRPIGH-NRPIEF-NRPICD-NRPIAB-NRNOUV
                                   -NRPLAFPME-NRPENTDY-NRFOR-NRTOURREP) , 0) * (1-positif(null(2-V_REGCO)+null(4-V_REGCO))) ;

NRTOUREPA = max(min( arr(ATOUREPA * TX_REDIL20 / 100) , RRI1-NRLOGDOM-NRCOMP-NRRETU-NRDONS-NCRDIE-NRDUFREPFI-NRDUFREPFK-NRDUFLOGIH-NRDUFLOEKL-NRPIREPAI-NRPIREPBI-NRPIREPCI-NRPIREPDI
                                                             -NRPIGH-NRPIEF-NRPICD-NRPIAB-NRNOUV-NRPLAFPME-NRPENTDY-NRFOR-NRTOURREP-NRTOUHOTR) , 0) ;

NRRI2 = NRCOMP + NRRETU + NRDONS + NCRDIE + NRDUFREPFI + NRDUFREPFK + NRDUFLOGIH + NRDUFLOEKL + NRPIREPAI + NRPIREPBI + NRPIREPCI 
        + NRPIREPDI + NRPIGH + NRPIEF + NRPICD + NRPIAB + NRNOUV + NRPLAFPME + NRPENTDY + NRFOR + NRTOURREP + NRTOUHOTR + NRTOUREPA ;


NRCELRREDLA = max( min(CELRREDLA , RRI1-NRLOGDOM-NRRI2) , 0) ;

NRCELRREDLB = max( min(CELRREDLB , RRI1-NRLOGDOM-NRRI2-NRCELRREDLA) , 0) ;

NRCELRREDLE = max( min(CELRREDLE , RRI1-NRLOGDOM-NRRI2-NRCELRREDLA-NRCELRREDLB) , 0) ;

NRCELRREDLM = max( min(CELRREDLM , RRI1-NRLOGDOM-NRRI2-NRCELRREDLA-NRCELRREDLB-NRCELRREDLE) , 0) ;

NRCELRREDLN = max( min(CELRREDLN , RRI1-NRLOGDOM-NRRI2 - somme(i=A,B,E,M : NRCELRREDLi)) , 0) ;

NRCELRREDLG = max( min(CELRREDLG , RRI1-NRLOGDOM-NRRI2 - somme(i=A,B,E,M,N : NRCELRREDLi)) , 0) ;

NRCELRREDLC = max( min(CELRREDLC , RRI1-NRLOGDOM-NRRI2 - somme(i=A,B,E,M,N,G : NRCELRREDLi)) , 0) ;

NRCELRREDLD = max( min(CELRREDLD , RRI1-NRLOGDOM-NRRI2 - somme(i=A,B,E,M,N,G,C : NRCELRREDLi)) , 0) ;

NRCELRREDLS = max( min(CELRREDLS , RRI1-NRLOGDOM-NRRI2 - somme(i=A,B,E,M,N,G,C,D : NRCELRREDLi)) , 0) ;

NRCELRREDLT = max( min(CELRREDLT , RRI1-NRLOGDOM-NRRI2 - somme(i=A,B,E,M,N,G,C,D,S : NRCELRREDLi)) , 0) ;

NRCELRREDLH = max( min(CELRREDLH , RRI1-NRLOGDOM-NRRI2 - somme(i=A,B,E,M,N,G,C,D,S,T : NRCELRREDLi)) , 0) ;

NRCELRREDLF = max( min(CELRREDLF , RRI1-NRLOGDOM-NRRI2 - somme(i=A,B,E,M,N,G,C,D,S,T,H : NRCELRREDLi)) , 0) ;

NRCELRREDLZ = max( min(CELRREDLZ , RRI1-NRLOGDOM-NRRI2 - somme(i=A,B,E,M,N,G,C,D,S,T,H,F : NRCELRREDLi)) , 0) ;

NRCELRREDLX = max( min(CELRREDLX , RRI1-NRLOGDOM-NRRI2 - somme(i=A,B,E,M,N,G,C,D,S,T,H,F,Z : NRCELRREDLi)) , 0) ;

NRCELRREDLI = max( min(CELRREDLI , RRI1-NRLOGDOM-NRRI2 - somme(i=A,B,E,M,N,G,C,D,S,T,H,F,Z,X : NRCELRREDLi)) , 0) ;

NRCEL1 = somme(i=A,B,E,M,N,G,C,D,S,T,H,F,Z,X,I : NRCELRREDLi) ;

NRCELRREDMG = max( min(CELRREDMG , RRI1-NRLOGDOM-NRRI2-NRCEL1) , 0) ;

NRCELRREDMH = max( min(CELRREDMH , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG) , 0) ;

NRCELRREDLJ = max( min(CELRREDLJ , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH) , 0) ;

NRCELREPHS = max( min(RCELREP_HS , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ) , 0) ;

NRCELREPHR = max( min(RCELREP_HR , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ -somme (i=S : NRCELREPHi )) , 0) ;

NRCELREPHU = max( min(RCELREP_HU , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ -somme (i=S,R : NRCELREPHi )) , 0) ;

NRCELREPHT = max( min(RCELREP_HT , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ -somme (i=S,R,U : NRCELREPHi )) , 0) ;

NRCELREPHZ = max( min(RCELREP_HZ , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ -somme (i=S,R,U,T : NRCELREPHi )) , 0) ;

NRCELREPHX = max( min(RCELREP_HX , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ -somme (i=S,R,U,T,Z : NRCELREPHi )) , 0) ;

NRCELREPHW = max( min(RCELREP_HW , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ -somme (i=S,R,U,T,Z,X : NRCELREPHi )) , 0) ;

NRCELREPHV = max( min(RCELREP_HV , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ -somme (i=S,R,U,T,Z,X,W : NRCELREPHi )) , 0) ;

NRCELREPHF = max( min(ACELREPHF , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ -somme (i=S,R,U,T,Z,X,W,V : NRCELREPHi )) , 0) ;

NRCELREPHD = max( min(ACELREPHD , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ -somme (i=S,R,U,T,Z,X,W,V,F : NRCELREPHi )) , 0) ;

NRCELREPHH = max( min(ACELREPHH , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ -somme (i=S,R,U,T,Z,X,W,V,F,D : NRCELREPHi )) , 0) ;

NRCELREPHG = max( min(ACELREPHG , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ -somme (i=S,R,U,T,Z,X,W,V,F,D,H : NRCELREPHi )) , 0) ;

NRCELREPHA = max( min(ACELREPHA , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ -somme (i=S,R,U,T,Z,X,W,V,F,D,H,G : NRCELREPHi )) , 0) ;

NRCEL2 = somme(i=S,R,U,T,Z,X,W,V,F,D,H,G,A : NRCELREPHi) ;

NRCELREPGU = max( min(ACELREPGU , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ-NRCEL2) , 0) ;

NRCELREPGX = max( min(ACELREPGX , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ-NRCEL2 -somme(i=U : NRCELREPGi )) , 0) ;

NRCELREPGS = max( min(ACELREPGS , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ-NRCEL2 -somme(i=U,X : NRCELREPGi )) , 0) ;

NRCELREPGW = max( min(ACELREPGW , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ-NRCEL2 -somme(i=U,X,S : NRCELREPGi )) , 0) ;

NRCELREPGL = max( min(ACELREPGL , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ-NRCEL2 -somme(i=U,X,S,W : NRCELREPGi )) , 0) ;

NRCELREPGV = max( min(ACELREPGV , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ-NRCEL2 -somme(i=U,X,S,W,L : NRCELREPGi )) , 0) ;

NRCELREPGJ = max( min(ACELREPGJ , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ-NRCEL2 -somme(i=U,X,S,W,L,V : NRCELREPGi )) , 0) ;

NRCEL3 = somme(i=U,X,S,W,L,V,J : NRCELREPGi) ;

NRCELREPYH = max( min(ACELREPYH , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ-NRCEL2-NRCEL3) , 0) ;

NRCELREPYL = max( min(ACELREPYL , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ-NRCEL2-NRCEL3 -somme(i=H : NRCELREPYi)) , 0) ;

NRCELREPYF = max( min(ACELREPYF , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ-NRCEL2-NRCEL3 -somme(i=H,L : NRCELREPYi)) , 0) ;

NRCELREPYK = max( min(ACELREPYK , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ-NRCEL2-NRCEL3 -somme(i=H,L,F : NRCELREPYi)) , 0) ;

NRCELREPYD = max( min(ACELREPYD , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ-NRCEL2-NRCEL3 -somme(i=H,L,F,K : NRCELREPYi)) , 0) ;

NRCELREPYJ = max( min(ACELREPYJ , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ-NRCEL2-NRCEL3 -somme(i=H,L,F,K,D : NRCELREPYi)) , 0) ;

NRCELREPYB = max( min(ACELREPYB , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ-NRCEL2-NRCEL3 -somme(i=H,L,F,K,D,J : NRCELREPYi)) , 0) ;

NRCELREPYP = max( min(ACELREPYP , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ-NRCEL2-NRCEL3 -somme(i=H,L,F,K,D,J,B : NRCELREPYi)) , 0) ;

NRCELREPYS = max( min(ACELREPYS , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ-NRCEL2-NRCEL3 -somme(i=H,L,F,K,D,J,B,P : NRCELREPYi)) , 0) ;

NRCELREPYO = max( min(ACELREPYO , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ-NRCEL2-NRCEL3 -somme(i=H,L,F,K,D,J,B,P,S : NRCELREPYi)) , 0) ;

NRCELREPYR = max( min(ACELREPYR , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ-NRCEL2-NRCEL3 -somme(i=H,L,F,K,D,J,B,P,S,O : NRCELREPYi)) , 0) ;

NRCELREPYN = max( min(ACELREPYN , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ-NRCEL2-NRCEL3 -somme(i=H,L,F,K,D,J,B,P,S,O,R : NRCELREPYi)) , 0) ;

NRCELREPYQ = max( min(ACELREPYQ , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ-NRCEL2-NRCEL3 -somme(i=H,L,F,K,D,J,B,P,S,O,R,N : NRCELREPYi)) , 0) ;

NRCELREPYM = max( min(ACELREPYM , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ-NRCEL2-NRCEL3 -somme(i=H,L,F,K,D,J,B,P,S,O,R,N,Q : NRCELREPYi)) , 0) ;

NRCEL4 = somme(i=H,L,F,K,D,J,B,P,S,O,R,N,Q,M : NRCELREPYi) ;

NRCELHM = max( min(RCEL_HM , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ-NRCEL2-NRCEL3-NRCEL4) , 0) ;

NRCELHL = max( min(RCEL_HL , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ-NRCEL2-NRCEL3-NRCEL4-NRCELHM) , 0) ;

NRCELHNO = max( min(RCEL_HNO , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ-NRCEL2-NRCEL3-NRCEL4-NRCELHM-NRCELHL) , 0) ;

NRCELHJK = max( min(RCEL_HJK , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ-NRCEL2-NRCEL3-NRCEL4-NRCELHM-NRCELHL-NRCELHNO ) , 0) ;

NRCELNQ = max( min(RCEL_NQ , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ-NRCEL2-NRCEL3-NRCEL4-NRCELHM-NRCELHL-NRCELHNO-NRCELHJK ) , 0) ;

NRCELNBGL = max( min(RCEL_NBGL , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ-NRCEL2-NRCEL3-NRCEL4-NRCELHM-NRCELHL-NRCELHNO-NRCELHJK-NRCELNQ ) , 0) ;

NRCELCOM = max( min(RCEL_COM , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ-NRCEL2-NRCEL3-NRCEL4-NRCELHM-NRCELHL-NRCELHNO-NRCELHJK-NRCELNQ-NRCELNBGL ) , 0) ;

NRCEL = max( min(RCEL_2011 , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ-NRCEL2-NRCEL3-NRCEL4-NRCELHM-NRCELHL-NRCELHNO-NRCELHJK-NRCELNQ-NRCELNBGL 
                                 -NRCELCOM) , 0) ;

NRCELJP = max( min(RCEL_JP , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ-NRCEL2-NRCEL3-NRCEL4-NRCELHM-NRCELHL-NRCELHNO-NRCELHJK-NRCELNQ-NRCELNBGL
                                 -NRCELCOM-NRCEL) , 0) ;

NRCELJBGL = max( min(RCEL_JBGL , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ-NRCEL2-NRCEL3-NRCEL4-NRCELHM-NRCELHL-NRCELHNO-NRCELHJK-NRCELNQ-NRCELNBGL
                                     -NRCELCOM-NRCEL-NRCELJP) , 0) ;

NRCELJOQR = max( min(RCEL_JOQR , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ-NRCEL2-NRCEL3-NRCEL4-NRCELHM-NRCELHL-NRCELHNO-NRCELHJK-NRCELNQ-NRCELNBGL
                                     -NRCELCOM-NRCEL-NRCELJP-NRCELJBGL) , 0) ;

NRCEL2012 = max( min(RCEL_2012 , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ-NRCEL2-NRCEL3-NRCEL4-NRCELHM-NRCELHL-NRCELHNO-NRCELHJK-NRCELNQ-NRCELNBGL
                                     -NRCELCOM-NRCEL-NRCELJP-NRCELJBGL-NRCELJOQR) , 0) ;

NRCELFD = max( min(RCEL_FD , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ-NRCEL2-NRCEL3-NRCEL4-NRCELHM-NRCELHL-NRCELHNO-NRCELHJK-NRCELNQ-NRCELNBGL
                                 -NRCELCOM-NRCEL-NRCELJP-NRCELJBGL-NRCELJOQR-NRCEL2012) , 0) ;

NRCELFABC = max( min(RCEL_FABC , RRI1-NRLOGDOM-NRRI2-NRCEL1-NRCELRREDMG-NRCELRREDMH-NRCELRREDLJ-NRCEL2-NRCEL3-NRCEL4-NRCELHM-NRCELHL-NRCELHNO-NRCELHJK-NRCELNQ-NRCELNBGL
                                     -NRCELCOM-NRCEL-NRCELJP-NRCELJBGL-NRCELJOQR-NRCEL2012-NRCELFD) , 0) ;

NRCELTOT = NRCEL1 + NRCELRREDMG + NRCELRREDMH + NRCELRREDLJ + NRCEL2 + NRCEL3 + NRCEL4 + NRCELHM + NRCELHL + NRCELHNO + NRCELHJK 
           + NRCELNQ + NRCELNBGL + NRCELCOM + NRCEL + NRCELJP + NRCELJBGL + NRCELJOQR + NRCEL2012 + NRCELFD + NRCELFABC ;


NRREDMEUB = max(min( AREDMEUB , RRI1-NRLOGDOM-NRRI2-NRCELTOT) , 0) ;

NRREDREP = max(min( AREDREP , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB) , 0) ;

NRILMIX = max(min( AILMIX , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP) , 0) ;

NRILMIY = max(min( AILMIY , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX) , 0) ;

NRILMPA = max(min( AILMPA , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY) , 0) ;

NRILMPF = max(min( AILMPF , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRILMPA) , 0) ;

NRINVRED = max(min( AINVRED , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRILMPA-NRILMPF) , 0) ;

NRILMIH = max(min( AILMIH , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRILMPA-NRILMPF-NRINVRED) , 0) ;

NRILMJC = max(min(AILMJC , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRILMPA-NRILMPF-NRINVRED-NRILMIH) , 0) ;

NRILMPB = max(min(AILMPB , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRILMPA-NRILMPF-NRINVRED-NRILMIH-NRILMJC) , 0) ;

NRILMPG = max(min(AILMPG , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRILMPA-NRILMPF-NRINVRED-NRILMIH-NRILMJC-NRILMPB) , 0) ;

NRILMIZ = max(min( AILMIZ , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRILMPA-NRILMPF-NRINVRED-NRILMIH-NRILMJC-NRILMPB-NRILMPG) , 0) ;

NRILMJI = max(min( AILMJI , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRILMPA-NRILMPF-NRINVRED-NRILMIH-NRILMJC-NRILMPB-NRILMPG-NRILMIZ) , 0) ;

NRILMPC = max(min( AILMPC , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRILMPA-NRILMPF-NRINVRED-NRILMIH-NRILMJC-NRILMPB-NRILMPG-NRILMIZ-NRILMJI) , 0) ;

NRILMPH = max(min( AILMPH , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRILMPA-NRILMPF-NRINVRED-NRILMIH-NRILMJC-NRILMPB-NRILMPG-NRILMIZ-NRILMJI-NRILMPC) , 0) ;

NRILMJS = max(min( AILMJS , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRILMPA-NRILMPF-NRINVRED-NRILMIH-NRILMJC-NRILMPB-NRILMPG-NRILMIZ-NRILMJI-NRILMPH
                                 -NRILMPC) , 0) ;

NRILMPD = max(min( AILMPD , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRILMPA-NRILMPF-NRINVRED-NRILMIH-NRILMJC-NRILMPB-NRILMPG-NRILMIZ-NRILMJI-NRILMPH
                                 -NRILMPC-NRILMJS) , 0) ;

NRILMPI = max(min( AILMPI , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRILMPA-NRILMPF-NRINVRED-NRILMIH-NRILMJC-NRILMPB-NRILMPG-NRILMIZ-NRILMJI-NRILMPH
                                 -NRILMPC-NRILMJS-NRILMPD) , 0) ;

NRILMPE = max(min( AILMPE , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRILMPA-NRILMPF-NRINVRED-NRILMIH-NRILMJC-NRILMPB-NRILMPG-NRILMIZ-NRILMJI-NRILMPH
                                 -NRILMPC-NRILMJS-NRILMPD-NRILMPI) , 0) ;

NRILMPJ = max(min( AILMPJ , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRILMPA-NRILMPF-NRINVRED-NRILMIH-NRILMJC-NRILMPB-NRILMPG-NRILMIZ-NRILMJI-NRILMPH
                                 -NRILMPC-NRILMJS-NRILMPD-NRILMPI-NRILMPE) , 0) ;

NRMEUBLE = max(min( MEUBLERET , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRILMPA-NRILMPF-NRINVRED-NRILMIH-NRILMJC-NRILMPB-NRILMPG-NRILMIZ-NRILMJI-NRILMPH
                                     -NRILMPC-NRILMJS-NRILMPD-NRILMPI-NRILMPE-NRILMPJ) , 0) ;

NRPROREP = max(min( RETPROREP , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRILMPA-NRILMPF-NRINVRED-NRILMIH-NRILMJC-NRILMPB-NRILMPG-NRILMIZ-NRILMJI-NRILMPH
                                     -NRILMPC-NRILMJS-NRILMPD-NRILMPI-NRILMPE-NRILMPJ-NRMEUBLE) , 0) ;

NRREPNPRO = max(min( RETREPNPRO , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRILMPA-NRILMPF-NRINVRED-NRILMIH-NRILMJC-NRILMPB-NRILMPG-NRILMIZ-NRILMJI-NRILMPH
                                       -NRILMPC-NRILMJS-NRILMPD-NRILMPI-NRILMPE-NRILMPJ-NRMEUBLE-NRPROREP) , 0) ;

NRREPMEU = max(min( RETREPMEU , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRILMPA-NRILMPF-NRINVRED-NRILMIH-NRILMJC-NRILMPB-NRILMPG-NRILMIZ-NRILMJI-NRILMPH
                                     -NRILMPC-NRILMJS-NRILMPD-NRILMPI-NRILMPE-NRILMPJ-NRMEUBLE-NRPROREP-NRREPNPRO) , 0) ;

NRILMIC = max(min( AILMIC , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRILMPA-NRILMPF-NRINVRED-NRILMIH-NRILMJC-NRILMPB-NRILMPG-NRILMIZ-NRILMJI-NRILMPH
                                 -NRILMPC-NRILMJS-NRILMPD-NRILMPI-NRILMPE-NRILMPJ-NRMEUBLE-NRPROREP-NRREPNPRO-NRREPMEU) , 0) ;

NRILMIB = max(min( AILMIB , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRILMPA-NRILMPF-NRINVRED-NRILMIH-NRILMJC-NRILMPB-NRILMPG-NRILMIZ-NRILMJI-NRILMPH
                                 -NRILMPC-NRILMJS-NRILMPD-NRILMPI-NRILMPE-NRILMPJ-NRMEUBLE-NRPROREP-NRREPNPRO-NRREPMEU-NRILMIC) , 0) ;

NRILMIA = max(min( AILMIA , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRILMPA-NRILMPF-NRINVRED-NRILMIH-NRILMJC-NRILMPB-NRILMPG-NRILMIZ-NRILMJI-NRILMPH
                                 -NRILMPC-NRILMJS-NRILMPD-NRILMPI-NRILMPE-NRILMPJ-NRMEUBLE-NRPROREP-NRREPNPRO-NRREPMEU-NRILMIC-NRILMIB) , 0) ;

NRILMJY = max(min( AILMJY , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRILMPA-NRILMPF-NRINVRED-NRILMIH-NRILMJC-NRILMPB-NRILMPG-NRILMIZ-NRILMJI-NRILMPH
                                 -NRILMPC-NRILMJS-NRILMPD-NRILMPI-NRILMPE-NRILMPJ-NRMEUBLE-NRPROREP-NRREPNPRO-NRREPMEU-NRILMIC-NRILMIB-NRILMIA) , 0) ;

NRILMJX = max(min( AILMJX , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRILMPA-NRILMPF-NRINVRED-NRILMIH-NRILMJC-NRILMPB-NRILMPG-NRILMIZ-NRILMJI-NRILMPH
                                 -NRILMPC-NRILMJS-NRILMPD-NRILMPI-NRILMPE-NRILMPJ-NRMEUBLE-NRPROREP-NRREPNPRO-NRREPMEU-NRILMIC-NRILMIB-NRILMIA-NRILMJY) , 0) ;

NRILMJW = max(min( AILMJW , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRILMPA-NRILMPF-NRINVRED-NRILMIH-NRILMJC-NRILMPB-NRILMPG-NRILMIZ-NRILMJI-NRILMPH
                                 -NRILMPC-NRILMJS-NRILMPD-NRILMPI-NRILMPE-NRILMPJ-NRMEUBLE-NRPROREP-NRREPNPRO-NRREPMEU-NRILMIC-NRILMIB-NRILMIA-NRILMJY-NRILMJX) , 0) ;

NRILMJV = max(min( AILMJV , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRILMPA-NRILMPF-NRINVRED-NRILMIH-NRILMJC-NRILMPB-NRILMPG-NRILMIZ-NRILMJI-NRILMPH
                                 -NRILMPC-NRILMJS-NRILMPD-NRILMPI-NRILMPE-NRILMPJ-NRMEUBLE-NRPROREP-NRREPNPRO-NRREPMEU-NRILMIC-NRILMIB-NRILMIA-NRILMJY-NRILMJX-NRILMJW) , 0) ;

NRILMOE = max(min( AILMOE , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRILMPA-NRILMPF-NRINVRED-NRILMIH-NRILMJC-NRILMPB-NRILMPG-NRILMIZ-NRILMJI-NRILMPH
                                 -NRILMPC-NRILMJS-NRILMPD-NRILMPI-NRILMPE-NRILMPJ-NRMEUBLE-NRPROREP-NRREPNPRO-NRREPMEU-NRILMIC-NRILMIB-NRILMIA-NRILMJY-NRILMJX-NRILMJW
                                 -NRILMJV) , 0) ;

NRILMOD = max(min( AILMOD , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRILMPA-NRILMPF-NRINVRED-NRILMIH-NRILMJC-NRILMPB-NRILMPG-NRILMIZ-NRILMJI-NRILMPH
                                 -NRILMPC-NRILMJS-NRILMPD-NRILMPI-NRILMPE-NRILMPJ-NRMEUBLE-NRPROREP-NRREPNPRO-NRREPMEU-NRILMIC-NRILMIB-NRILMIA-NRILMJY-NRILMJX-NRILMJW
                                 -NRILMJV-NRILMOE) , 0) ;

NRILMOC = max(min( AILMOC , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRILMPA-NRILMPF-NRINVRED-NRILMIH-NRILMJC-NRILMPB-NRILMPG-NRILMIZ-NRILMJI-NRILMPH
                                 -NRILMPC-NRILMJS-NRILMPD-NRILMPI-NRILMPE-NRILMPJ-NRMEUBLE-NRPROREP-NRREPNPRO-NRREPMEU-NRILMIC-NRILMIB-NRILMIA-NRILMJY-NRILMJX-NRILMJW
                                 -NRILMJV-NRILMOE-NRILMOD) , 0) ;

NRILMOB = max(min( AILMOB , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRILMPA-NRILMPF-NRINVRED-NRILMIH-NRILMJC-NRILMPB-NRILMPG-NRILMIZ-NRILMJI-NRILMPH
                                 -NRILMPC-NRILMJS-NRILMPD-NRILMPI-NRILMPE-NRILMPJ-NRMEUBLE-NRPROREP-NRREPNPRO-NRREPMEU-NRILMIC-NRILMIB-NRILMIA-NRILMJY-NRILMJX-NRILMJW
                                 -NRILMJV-NRILMOE-NRILMOD-NRILMOC) , 0) ;

NRILMOA = max(min( AILMOA , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRILMPA-NRILMPF-NRINVRED-NRILMIH-NRILMJC-NRILMPB-NRILMPG-NRILMIZ-NRILMJI-NRILMPH
                                 -NRILMPC-NRILMJS-NRILMPD-NRILMPI-NRILMPE-NRILMPJ-NRMEUBLE-NRPROREP-NRREPNPRO-NRREPMEU-NRILMIC-NRILMIB-NRILMIA-NRILMJY-NRILMJX-NRILMJW
                                 -NRILMJV-NRILMOE-NRILMOD-NRILMOC-NRILMOB) , 0) ;

NRILMOJ = max(min( AILMOJ , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRILMPA-NRILMPF-NRINVRED-NRILMIH-NRILMJC-NRILMPB-NRILMPG-NRILMIZ-NRILMJI-NRILMPH
                                 -NRILMPC-NRILMJS-NRILMPD-NRILMPI-NRILMPE-NRILMPJ-NRMEUBLE-NRPROREP-NRREPNPRO-NRREPMEU-NRILMIC-NRILMIB-NRILMIA-NRILMJY-NRILMJX-NRILMJW
                                 -NRILMJV-NRILMOE-NRILMOD-NRILMOC-NRILMOB-NRILMOA) , 0) ;

NRILMOI = max(min( AILMOI , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRILMPA-NRILMPF-NRINVRED-NRILMIH-NRILMJC-NRILMPB-NRILMPG-NRILMIZ-NRILMJI-NRILMPH
                                 -NRILMPC-NRILMJS-NRILMPD-NRILMPI-NRILMPE-NRILMPJ-NRMEUBLE-NRPROREP-NRREPNPRO-NRREPMEU-NRILMIC-NRILMIB-NRILMIA-NRILMJY-NRILMJX-NRILMJW
                                 -NRILMJV-NRILMOE-NRILMOD-NRILMOC-NRILMOB-NRILMOA-NRILMOJ) , 0) ;

NRILMOH = max(min( AILMOH , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRILMPA-NRILMPF-NRINVRED-NRILMIH-NRILMJC-NRILMPB-NRILMPG-NRILMIZ-NRILMJI-NRILMPH
                                 -NRILMPC-NRILMJS-NRILMPD-NRILMPI-NRILMPE-NRILMPJ-NRMEUBLE-NRPROREP-NRREPNPRO-NRREPMEU-NRILMIC-NRILMIB-NRILMIA-NRILMJY-NRILMJX-NRILMJW
                                 -NRILMJV-NRILMOE-NRILMOD-NRILMOC-NRILMOB-NRILMOA-NRILMOJ-NRILMOI) , 0) ;

NRILMOG = max(min( AILMOG , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRILMPA-NRILMPF-NRINVRED-NRILMIH-NRILMJC-NRILMPB-NRILMPG-NRILMIZ-NRILMJI-NRILMPH
                                 -NRILMPC-NRILMJS-NRILMPD-NRILMPI-NRILMPE-NRILMPJ-NRMEUBLE-NRPROREP-NRREPNPRO-NRREPMEU-NRILMIC-NRILMIB-NRILMIA-NRILMJY-NRILMJX-NRILMJW
                                 -NRILMJV-NRILMOE-NRILMOD-NRILMOC-NRILMOB-NRILMOA-NRILMOJ-NRILMOI-NRILMOH) , 0) ;

NRILMOF = max(min( AILMOF , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRILMPA-NRILMPF-NRINVRED-NRILMIH-NRILMJC-NRILMPB-NRILMPG-NRILMIZ-NRILMJI-NRILMPH
                                 -NRILMPC-NRILMJS-NRILMPD-NRILMPI-NRILMPE-NRILMPJ-NRMEUBLE-NRPROREP-NRREPNPRO-NRREPMEU-NRILMIC-NRILMIB-NRILMIA-NRILMJY-NRILMJX-NRILMJW
                                 -NRILMJV-NRILMOE-NRILMOD-NRILMOC-NRILMOB-NRILMOA-NRILMOJ-NRILMOI-NRILMOH-NRILMOG) , 0) ;

NRILMO = NRILMOE + NRILMOD + NRILMOC + NRILMOB + NRILMOA + NRILMOJ + NRILMOI + NRILMOH + NRILMOG + NRILMOF ;

NRRESIMEUB = max(min( RETRESIMEUB , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRILMPA-NRILMPF-NRINVRED-NRILMIH-NRILMJC-NRILMPB-NRILMPG-NRILMIZ-NRILMJI-NRILMPH
                                        -NRILMPC-NRILMJS-NRILMPD-NRILMPI-NRILMPE-NRILMPJ-NRMEUBLE-NRPROREP-NRREPNPRO-NRREPMEU-NRILMIC-NRILMIB-NRILMIA-NRILMJY-NRILMJX-NRILMJW
                                        -NRILMJV-NRILMO) , 0) ;

NRRESIVIEU = max(min( RETRESIVIEU , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRILMPA-NRILMPF-NRINVRED-NRILMIH-NRILMJC-NRILMPB-NRILMPG-NRILMIZ-NRILMJI-NRILMPH
                                        -NRILMPC-NRILMJS-NRILMPD-NRILMPI-NRILMPE-NRILMPJ-NRMEUBLE-NRPROREP-NRREPNPRO-NRREPMEU-NRILMIC-NRILMIB-NRILMIA-NRILMJY-NRILMJX-NRILMJW
                                        -NRILMJV-NRILMO-NRRESIMEUB) , 0) ;

NRRESINEUV = max(min( RETRESINEUV , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRILMPA-NRILMPF-NRINVRED-NRILMIH-NRILMJC-NRILMPB-NRILMPG-NRILMIZ-NRILMJI-NRILMPH
                                        -NRILMPC-NRILMJS-NRILMPD-NRILMPI-NRILMPE-NRILMPJ-NRMEUBLE-NRPROREP-NRREPNPRO-NRREPMEU-NRILMIC-NRILMIB-NRILMIA-NRILMJY-NRILMJX-NRILMJW
                                        -NRILMJV-NRILMO-NRRESIMEUB-NRRESIMEUB) , 0) ;

NRLOCIDEFG = max(min( RETLOCIDEFG , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRILMPA-NRILMPF-NRINVRED-NRILMIH-NRILMJC-NRILMPB-NRILMPG-NRILMIZ-NRILMJI-NRILMPH
                                        -NRILMPC-NRILMJS-NRILMPD-NRILMPI-NRILMPE-NRILMPJ-NRMEUBLE-NRPROREP-NRREPNPRO-NRREPMEU-NRILMIC-NRILMIB-NRILMIA-NRILMJY-NRILMJX-NRILMJW
                                        -NRILMJV-NRILMO-NRRESIMEUB-NRRESIMEUB-NRRESINEUV) , 0) ;

NRCODJU = max(min( RETCODJU , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRILMPA-NRILMPF-NRINVRED-NRILMIH-NRILMJC-NRILMPB-NRILMPG-NRILMIZ-NRILMJI-NRILMPH
                                  -NRILMPC-NRILMJS-NRILMPD-NRILMPI-NRILMPE-NRILMPJ-NRMEUBLE-NRPROREP-NRREPNPRO-NRREPMEU-NRILMIC-NRILMIB-NRILMIA-NRILMJY-NRILMJX-NRILMJW
                                  -NRILMJV-NRILMO-NRRESIMEUB-NRRESIMEUB-NRRESINEUV-NRLOCIDEFG) , 0) ;

NRCODJT = max(min( RETCODJT , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRILMPA-NRILMPF-NRINVRED-NRILMIH-NRILMJC-NRILMPB-NRILMPG-NRILMIZ-NRILMJI-NRILMPH
                                  -NRILMPC-NRILMJS-NRILMPD-NRILMPI-NRILMPE-NRILMPJ-NRMEUBLE-NRPROREP-NRREPNPRO-NRREPMEU-NRILMIC-NRILMIB-NRILMIA-NRILMJY-NRILMJX-NRILMJW
                                  -NRILMJV-NRILMO-NRRESIMEUB-NRRESIMEUB-NRRESINEUV-NRLOCIDEFG-NRCODJU) , 0) ;

NRCODOU = max(min( RETCODOU , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRILMPA-NRILMPF-NRINVRED-NRILMIH-NRILMJC-NRILMPB-NRILMPG-NRILMIZ-NRILMJI-NRILMPH
                                  -NRILMPC-NRILMJS-NRILMPD-NRILMPI-NRILMPE-NRILMPJ-NRMEUBLE-NRPROREP-NRREPNPRO-NRREPMEU-NRILMIC-NRILMIB-NRILMIA-NRILMJY-NRILMJX-NRILMJW
                                  -NRILMJV-NRILMO-NRRESIMEUB-NRRESIMEUB-NRRESINEUV-NRLOCIDEFG-NRCODJU-NRCODJT) , 0) ;

NRCODOV = max(min( RETCODOV , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRILMIY-NRILMPA-NRILMPF-NRINVRED-NRILMIH-NRILMJC-NRILMPB-NRILMPG-NRILMIZ-NRILMJI-NRILMPH
                                  -NRILMPC-NRILMJS-NRILMPD-NRILMPI-NRILMPE-NRILMPJ-NRMEUBLE-NRPROREP-NRREPNPRO-NRREPMEU-NRILMIC-NRILMIB-NRILMIA-NRILMJY-NRILMJX-NRILMJW
                                  -NRILMJV-NRILMO-NRRESIMEUB-NRRESIMEUB-NRRESINEUV-NRLOCIDEFG-NRCODJU-NRCODJT-NRCODOU) , 0) ;

NRLOCNPRO = NRREDMEUB + NRREDREP + NRILMIX + NRILMIY + NRILMPA + NRILMPF + NRINVRED + NRILMIH + NRILMJC + NRILMPB + NRILMPG + NRILMIZ + NRILMJI + NRILMPC + NRILMPH + NRILMJS 
            + NRILMPD + NRILMPI + NRILMPE + NRILMPJ + NRMEUBLE + NRPROREP + NRREPNPRO + NRREPMEU + NRILMIC + NRILMIB + NRILMIA + NRILMJY + NRILMJX + NRILMJW + NRILMJV + NRILMOE 
            + NRILMOD + NRILMOC + NRILMOB + NRILMOA + NRILMOJ + NRILMOI + NRILMOH + NRILMOG + NRILMOF + NRRESIMEUB + NRRESIVIEU + NRRESINEUV + NRLOCIDEFG + NRCODJU + NRCODJT 
            + NRCODOU + NRCODOV ;


NRPATNAT1 = (max(min(APATNAT1 , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO) , 0 )) ;

NRPATNAT2 = (max(min(APATNAT2 , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT1) , 0 )) ;

NRPATNAT3 = (max(min(APATNAT3 , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT1-NRPATNAT2) , 0 )) ;

NRPATNAT = (max(min(APATNAT , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT1-NRPATNAT2-NRPATNAT3) , 0 )) ;

NRRI3 = NRCELTOT + NRLOCNPRO + NRPATNAT1 + NRPATNAT2 + NRPATNAT3 + NRPATNAT ;

regle 402010:
application : iliad, batch ;




DLOGDOM = INVLOG2008 + INVLGDEB2009 + INVLGDEB + INVLGAUTRE + INVLGDEB2010 + INVLOG2009 + INVOMLOGOA + INVOMLOGOB 
          + INVOMLOGOC + INVOMLOGOH + INVOMLOGOI + INVOMLOGOJ + INVOMLOGOK + INVOMLOGOL + INVOMLOGOM + INVOMLOGON 
          + INVOMLOGOO + INVOMLOGOP + INVOMLOGOQ + INVOMLOGOR + INVOMLOGOS + INVOMLOGOT + INVOMLOGOU + INVOMLOGOV 
          + INVOMLOGOW 
          + CODHOD + CODHOE + CODHOF + CODHOG + CODHOX + CODHOY + CODHOZ + CODHUA + CODHUB + CODHUC + CODHUD + CODHUE 
          + CODHUF + CODHUG + CODHUH + CODHUI + CODHUJ + CODHUK + CODHUL + CODHUM + CODHUN ;


DDOMSOC1 = INVOMSOCKH + INVOMSOCKI + INVSOC2010 + INVOMSOCQU + INVLOGSOC + INVOMSOCQJ + INVOMSOCQS + INVOMSOCQW + INVOMSOCQX 
           + CODHRA + CODHRB + CODHRC + CODHRD + CODHXA + CODHXB + CODHXC + CODHXE ;

DLOGSOC = CODHXF + CODHXG + CODHXH + CODHXI + CODHXK ;


DCOLENT = INVOMENTMN + RETROCOMLH + RETROCOMMB + INVOMENTKT + RETROCOMLI + RETROCOMMC + INVOMENTKU + INVOMQV + INVENDEB2009 
          + INVRETRO1 + INVRETRO2 + INVIMP + INVDOMRET50 + INVDOMRET60 + INVDIR2009 + INVOMRETPA + INVOMRETPB + INVOMRETPD 
          + INVOMRETPE + INVOMRETPF + INVOMRETPH + INVOMRETPI + INVOMRETPJ + INVOMRETPL + INVOMRETPM + INVOMRETPN + INVOMRETPO 
          + INVOMRETPP + INVOMRETPR + INVOMRETPS + INVOMRETPT + INVOMRETPU + INVOMRETPW + INVOMRETPX + INVOMRETPY + INVOMENTRG 
          + INVOMENTRI + INVOMENTRJ + INVOMENTRK + INVOMENTRL + INVOMENTRM + INVOMENTRO + INVOMENTRP + INVOMENTRQ + INVOMENTRR 
	  + INVOMENTRT + INVOMENTRU + INVOMENTRV + INVOMENTRW + INVOMENTRY + INVOMENTNU + INVOMENTNV + INVOMENTNW + INVOMENTNY 
          + CODHSA + CODHSB + CODHSC + CODHSE + CODHSF + CODHSG + CODHSH + CODHSJ + CODHSK + CODHSL + CODHSM + CODHSO + CODHSP 
          + CODHSQ + CODHSR + CODHST + CODHSU + CODHSV + CODHSW + CODHSY + CODHSZ + CODHTA + CODHTB + CODHTD 
          + CODHAA + CODHAB + CODHAC + CODHAE + CODHAF + CODHAG + CODHAH + CODHAJ + CODHAK + CODHAL + CODHAM + CODHAO + CODHAP 
          + CODHAQ + CODHAR + CODHAT + CODHAU + CODHAV + CODHAW + CODHAY + CODHBA + CODHBB + CODHBE + CODHBG ;

DLOCENT = CODHBI + CODHBJ + CODHBK + CODHBL + CODHBN + CODHBO + CODHBP + CODHBQ + CODHBS + CODHBT + CODHBU + CODHBV + CODHBX 
          + CODHBY + CODHBZ + CODHCA + CODHCC + CODHCD + CODHCE + CODHCF ;

regle 402020:
application : iliad , batch ;



TOTALPLAF1 = INVRETKH + INVRETKI + INVRETQN + INVRETQU + INVRETQK + INVRETQJ + INVRETQS + INVRETQW + INVRETQX + INVRETRA + INVRETRB 
             + INVRETRC + INVRETRD + INVRETXA + INVRETXB + INVRETXC + INVRETXE + INVRETXF + INVRETXG + INVRETXH + INVRETXI + INVRETXK
	     + INVRETMB + INVRETLH + INVRETMC + INVRETLI + INVRETQP + INVRETQG + INVRETQO + INVRETQF + INVRETPO + INVRETPT + INVRETPN 
             + INVRETPS + INVRETPP + INVRETPU + INVRETKT + INVRETKU + INVRETQR + INVRETQI + INVRETPR + INVRETPW + INVRETQL + INVRETQM 
             + INVRETQD + INVRETOB + INVRETOC + INVRETOM + INVRETON + INVRETOD + INVRETUA + INVRETUH
	     + INVRETKHR + INVRETKIR + INVRETQNR + INVRETQUR + INVRETQKR + INVRETQJR + INVRETQSR + INVRETQWR + INVRETQXR + INVRETRAR 
             + INVRETRBR + INVRETRCR + INVRETRDR + INVRETXAR + INVRETXBR + INVRETXCR + INVRETXER + INVRETXFR + INVRETXGR + INVRETXHR 
             + INVRETXIR + INVRETXKR + INVRETMBR + INVRETLHR + INVRETMCR + INVRETLIR + INVRETQPR + INVRETQGR + INVRETQOR + INVRETQFR 
             + INVRETPOR + INVRETPTR + INVRETPNR + INVRETPSR ;

TOTALPLAF2 = INVRETPB + INVRETPF + INVRETPJ + INVRETPA + INVRETPE + INVRETPI + INVRETPY + INVRETPX + INVRETRG + INVRETPD + INVRETPH 
             + INVRETPL + INVRETRI + INVRETSB + INVRETSG + INVRETSA + INVRETSF + INVRETSC + INVRETSH + INVRETSE + INVRETSJ + INVRETAB 
             + INVRETAG + INVRETAA + INVRETAF + INVRETAC + INVRETAH + INVRETAE + INVRETAJ + INVRETBJ + INVRETBO + INVRETBI + INVRETBN 
             + INVRETBK + INVRETBP + INVRETBM + INVRETBR + INVRETOI + INVRETOJ + INVRETOK + INVRETOP + INVRETOQ + INVRETOR + INVRETOE 
             + INVRETOF + INVRETUB + INVRETUC + INVRETUI + INVRETUJ
	     + INVRETPBR + INVRETPFR + INVRETPJR + INVRETPAR + INVRETPER + INVRETPIR + INVRETPYR + INVRETPXR + INVRETSBR + INVRETSGR 
             + INVRETSAR + INVRETSFR + INVRETABR + INVRETAGR + INVRETAAR + INVRETAFR + INVRETBJR + INVRETBOR + INVRETBIR + INVRETBNR ;

TOTALPLAF3 = INVRETRL + INVRETRQ + INVRETRV + INVRETNV + INVRETRK + INVRETRP + INVRETRU + INVRETNU + INVRETRM + INVRETRR + INVRETRW 
             + INVRETNW + INVRETRO + INVRETRT + INVRETRY + INVRETNY + INVRETSL + INVRETSQ + INVRETSV + INVRETTA + INVRETSK + INVRETSP 
             + INVRETSU + INVRETSZ + INVRETSM + INVRETSR + INVRETSW + INVRETTB + INVRETSO + INVRETST + INVRETSY + INVRETTD + INVRETAL 
             + INVRETAQ + INVRETAV + INVRETBB + INVRETAK + INVRETAP + INVRETAU + INVRETBA + INVRETAM + INVRETAR + INVRETAW + INVRETBE 
             + INVRETAO + INVRETAT + INVRETAY + INVRETBG + INVRETBT + INVRETBY + INVRETCD + INVRETBS + INVRETBX + INVRETCC + INVRETBU 
             + INVRETBZ + INVRETCE + INVRETBW + INVRETCB + INVRETCG + INVRETOT + INVRETOU + INVRETOV + INVRETOW + INVRETOG + INVRETOX 
             + INVRETOY + INVRETOZ + INVRETUD + INVRETUE + INVRETUF + INVRETUG + INVRETUK + INVRETUL + INVRETUM + INVRETUN
	     + INVRETRLR + INVRETRQR + INVRETRVR + INVRETNVR + INVRETRKR + INVRETRPR + INVRETRUR + INVRETNUR + INVRETSLR + INVRETSQR 
             + INVRETSVR + INVRETTAR + INVRETSKR + INVRETSPR + INVRETSUR + INVRETSZR + INVRETALR + INVRETAQR + INVRETAVR + INVRETBBR 
             + INVRETAKR + INVRETAPR + INVRETAUR + INVRETBAR + INVRETBTR + INVRETBYR + INVRETCDR + INVRETBSR + INVRETBXR + INVRETCCR ;

RNIDOM1 = arr((RNG + TTPVQ) * TX15/100) ;

RNIDOM2 = arr((RNG + TTPVQ) * TX13/100) ;

RNIDOM3 = arr((RNG + TTPVQ) * TX11/100) ;

INDPLAF1 = positif(RNIDOM1 - TOTALPLAF1) ;



INVRETKHA = min(arr(NINVRETKH * TX35 / 100) , max(0 , RNIDOM1)) * (1 - V_CNR) ;

INVRETKIA = min(arr(NINVRETKI * TX35 / 100) , max(0 , RNIDOM1 -INVRETKHA)) * (1 - V_CNR) ;

INVRETQNA = min(arr(NINVRETQN * TX35 / 100) , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA)) * (1 - V_CNR) ;

INVRETQUA = min(arr(NINVRETQU * TX35 / 100) , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA)) * (1 - V_CNR) ;

INVRETQKA = min(arr(NINVRETQK * TX35 / 100) , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA)) * (1 - V_CNR) ;

INVRETQJA = min(arr(NINVRETQJ * TX35 / 100) , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA)) * (1 - V_CNR) ;

INVRETQSA = min(arr(NINVRETQS * TX35 / 100) , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA)) * (1 - V_CNR) ;

INVRETQWA = min(arr(NINVRETQW * TX35 / 100) , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA)) * (1 - V_CNR) ;

INVRETQXA = min(arr(NINVRETQX * TX35 / 100) , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA)) * (1 - V_CNR) ;

INVRETRAA = min(arr(NINVRETRA * TX35 / 100) , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA)) * (1 - V_CNR) ;

INVRETRBA = min(arr(NINVRETRB * TX35 / 100) , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
                                                              -INVRETRAA)) * (1 - V_CNR) ;

INVRETRCA = min(arr(NINVRETRC * TX35 / 100) , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
                                                              -INVRETRAA-INVRETRBA)) * (1 - V_CNR) ;

INVRETRDA = min(arr(NINVRETRD * TX35 / 100) , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
                                                              -INVRETRAA-INVRETRBA-INVRETRCA)) * (1 - V_CNR) ;

INVRETXAA = min(arr(NINVRETXA * TX35 / 100) , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
                                                              -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA)) * (1 - V_CNR) ;

INVRETXBA = min(arr(NINVRETXB * TX35 / 100) , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
                                                              -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETXAA)) * (1 - V_CNR) ;

INVRETXCA = min(arr(NINVRETXC * TX35 / 100) , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
                                                              -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETXAA-INVRETXBA)) * (1 - V_CNR) ;

INVRETXEA = min(arr(NINVRETXE * TX35 / 100) , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
                                                              -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETXAA-INVRETXBA-INVRETXCA)) * (1 - V_CNR) ;

INVRETXFA = min(arr(NINVRETXF * TX35 / 100) , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
                                                              -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETXAA-INVRETXBA-INVRETXCA-INVRETXEA)) * (1 - V_CNR) ;

INVRETXGA = min(arr(NINVRETXG * TX35 / 100) , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
                                                              -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETXAA-INVRETXBA-INVRETXCA-INVRETXEA-INVRETXFA)) * (1 - V_CNR) ;

INVRETXHA = min(arr(NINVRETXH * TX35 / 100) , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
                                                              -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETXAA-INVRETXBA-INVRETXCA-INVRETXEA-INVRETXFA
                                                              -INVRETXGA)) * (1 - V_CNR) ;

INVRETXIA = min(arr(NINVRETXI * TX35 / 100) , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
                                                              -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETXAA-INVRETXBA-INVRETXCA-INVRETXEA-INVRETXFA
                                                              -INVRETXGA-INVRETXHA)) * (1 - V_CNR) ;

INVRETXKA = min(arr(NINVRETXK * TX30 / 100) , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
                                                              -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETXAA-INVRETXBA-INVRETXCA-INVRETXEA-INVRETXFA
                                                              -INVRETXGA-INVRETXHA-INVRETXIA)) * (1 - V_CNR) ;

INVRETMBA = min(arr(NINVRETMB * TX40 / 100) , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
                                                              -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETXAA-INVRETXBA-INVRETXCA-INVRETXEA-INVRETXFA
                                                              -INVRETXGA-INVRETXHA-INVRETXIA-INVRETXKA)) * (1 - V_CNR) ;

INVRETMCA = min(arr(NINVRETMC * TX40 / 100) , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
                                                              -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETXAA-INVRETXBA-INVRETXCA-INVRETXEA-INVRETXFA
                                                              -INVRETXGA-INVRETXHA-INVRETXIA-INVRETXKA-INVRETMBA)) * (1 - V_CNR) ;

INVRETLHA = min(arr(NINVRETLH * TX50 / 100) , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
                                                              -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETXAA-INVRETXBA-INVRETXCA-INVRETXEA-INVRETXFA
                                                              -INVRETXGA-INVRETXHA-INVRETXIA-INVRETXKA-INVRETMBA-INVRETMCA)) * (1 - V_CNR) ;

INVRETLIA = min(arr(NINVRETLI * TX50 / 100) , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
                                                              -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETXAA-INVRETXBA-INVRETXCA-INVRETXEA-INVRETXFA
                                                              -INVRETXGA-INVRETXHA-INVRETXIA-INVRETXKA-INVRETMBA-INVRETLHA-INVRETMCA)) * (1 - V_CNR) ;

INVRETKTA = min(NINVRETKT , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA-INVRETRAA-INVRETRBA
                                            -INVRETRCA-INVRETRDA-INVRETXAA-INVRETXBA-INVRETXCA-INVRETXEA-INVRETXFA-INVRETXGA-INVRETXHA-INVRETXIA-INVRETXKA
                                            -INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA)) * (1 - V_CNR) ;

INVRETKUA = min(NINVRETKU , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA-INVRETRAA-INVRETRBA
                                            -INVRETRCA-INVRETRDA-INVRETXAA-INVRETXBA-INVRETXCA-INVRETXEA-INVRETXFA-INVRETXGA-INVRETXHA-INVRETXIA-INVRETXKA
                                            -INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETKTA)) * (1 - V_CNR) ;

INVRETQPA = min(arr(NINVRETQP * TX40 / 100) , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
                                                              -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETXAA-INVRETXBA-INVRETXCA-INVRETXEA-INVRETXFA
                                                              -INVRETXGA-INVRETXHA-INVRETXIA-INVRETXKA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETKTA
                                                              -INVRETKUA)) * (1 - V_CNR) ;

INVRETQGA = min(arr(NINVRETQG * TX40 / 100) , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
                                                              -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETXAA-INVRETXBA-INVRETXCA-INVRETXEA-INVRETXFA
                                                              -INVRETXGA-INVRETXHA-INVRETXIA-INVRETXKA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETKTA
                                                              -INVRETKUA-INVRETQPA)) * (1 - V_CNR) ;

INVRETQOA = min(arr(NINVRETQO * TX50 / 100) , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
                                                              -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETXAA-INVRETXBA-INVRETXCA-INVRETXEA-INVRETXFA
                                                              -INVRETXGA-INVRETXHA-INVRETXIA-INVRETXKA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETKTA
                                                              -INVRETKUA-INVRETQPA-INVRETQGA)) * (1 - V_CNR) ;

INVRETQFA = min(arr(NINVRETQF * TX50 / 100) , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
                                                              -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETXAA-INVRETXBA-INVRETXCA-INVRETXEA-INVRETXFA
                                                              -INVRETXGA-INVRETXHA-INVRETXIA-INVRETXKA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETKTA
                                                              -INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA)) * (1 - V_CNR) ;

INVRETQRA = min(NINVRETQR , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA-INVRETRAA-INVRETRBA
                                            -INVRETRCA-INVRETRDA-INVRETXAA-INVRETXBA-INVRETXCA-INVRETXEA-INVRETXFA-INVRETXGA-INVRETXHA-INVRETXIA-INVRETXKA
                                            -INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA)) * (1 - V_CNR) ;

INVRETQIA = min(NINVRETQI , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA-INVRETRAA-INVRETRBA
                                            -INVRETRCA-INVRETRDA-INVRETXAA-INVRETXBA-INVRETXCA-INVRETXEA-INVRETXFA-INVRETXGA-INVRETXHA-INVRETXIA-INVRETXKA
                                            -INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA)) * (1 - V_CNR) ;

INVRETPOA = min(arr(NINVRETPO * TX40 / 100) , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
                                                              -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETXAA-INVRETXBA-INVRETXCA-INVRETXEA-INVRETXFA
                                                              -INVRETXGA-INVRETXHA-INVRETXIA-INVRETXKA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETKTA
                                                              -INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA)) * (1 - V_CNR) ;

INVRETPTA = min(arr(NINVRETPT * TX40 / 100) , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
                                                              -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETXAA-INVRETXBA-INVRETXCA-INVRETXEA-INVRETXFA
                                                              -INVRETXGA-INVRETXHA-INVRETXIA-INVRETXKA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETKTA
                                                              -INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA)) * (1 - V_CNR) ;

INVRETPNA = min(arr(NINVRETPN * TX50 / 100) , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
                                                              -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETXAA-INVRETXBA-INVRETXCA-INVRETXEA-INVRETXFA
                                                              -INVRETXGA-INVRETXHA-INVRETXIA-INVRETXKA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETKTA
                                                              -INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA-INVRETPTA)) * (1 - V_CNR) ;

INVRETPSA = min(arr(NINVRETPS * TX50 / 100) , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
                                                              -INVRETRAA-INVRETRBA-INVRETRCA-INVRETRDA-INVRETXAA-INVRETXBA-INVRETXCA-INVRETXEA-INVRETXFA
                                                              -INVRETXGA-INVRETXHA-INVRETXIA-INVRETXKA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETKTA
                                                              -INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA-INVRETQIA-INVRETPOA-INVRETPTA
                                                              -INVRETPNA)) * (1 - V_CNR) ;

INVRETPPA = min(NINVRETPP , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA-INVRETRAA-INVRETRBA
                                            -INVRETRCA-INVRETRDA-INVRETXAA-INVRETXBA-INVRETXCA-INVRETXEA-INVRETXFA-INVRETXGA-INVRETXHA-INVRETXIA-INVRETXKA
                                            -INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA
                                            -INVRETQIA-INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA)) * (1 - V_CNR) ;

INVRETPUA = min(NINVRETPU , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA-INVRETRAA-INVRETRBA
                                            -INVRETRCA-INVRETRDA-INVRETXAA-INVRETXBA-INVRETXCA-INVRETXEA-INVRETXFA-INVRETXGA-INVRETXHA-INVRETXIA-INVRETXKA
                                            -INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA
                                            -INVRETQIA-INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA)) * (1 - V_CNR) ;

INVRETPRA = min(NINVRETPR , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA-INVRETRAA-INVRETRBA
                                            -INVRETRCA-INVRETRDA-INVRETXAA-INVRETXBA-INVRETXCA-INVRETXEA-INVRETXFA-INVRETXGA-INVRETXHA-INVRETXIA-INVRETXKA
                                            -INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA
                                            -INVRETQIA-INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA)) * (1 - V_CNR) ;

INVRETPWA = min(NINVRETPW , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA-INVRETRAA-INVRETRBA
                                            -INVRETRCA-INVRETRDA-INVRETXAA-INVRETXBA-INVRETXCA-INVRETXEA-INVRETXFA-INVRETXGA-INVRETXHA-INVRETXIA-INVRETXKA
                                            -INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA
                                            -INVRETQIA-INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA)) * (1 - V_CNR) ;

INVRETQLA = min(NINVRETQL , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA-INVRETRAA-INVRETRBA
                                            -INVRETRCA-INVRETRDA-INVRETXAA-INVRETXBA-INVRETXCA-INVRETXEA-INVRETXFA-INVRETXGA-INVRETXHA-INVRETXIA-INVRETXKA
                                            -INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA
                                            -INVRETQIA-INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA)) * (1 - V_CNR) ;

INVRETQMA = min(NINVRETQM , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA-INVRETRAA-INVRETRBA
                                            -INVRETRCA-INVRETRDA-INVRETXAA-INVRETXBA-INVRETXCA-INVRETXEA-INVRETXFA-INVRETXGA-INVRETXHA-INVRETXIA-INVRETXKA
                                            -INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA
                                            -INVRETQIA-INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA-INVRETQLA)) * (1 - V_CNR) ;

INVRETQDA = min(NINVRETQD , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA-INVRETRAA-INVRETRBA
                                            -INVRETRCA-INVRETRDA-INVRETXAA-INVRETXBA-INVRETXCA-INVRETXEA-INVRETXFA-INVRETXGA-INVRETXHA-INVRETXIA-INVRETXKA
                                            -INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA
                                            -INVRETQIA-INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA)) * (1 - V_CNR) ;

INVRETOBA = min(NINVRETOB , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA-INVRETRAA-INVRETRBA
                                            -INVRETRCA-INVRETRDA-INVRETXAA-INVRETXBA-INVRETXCA-INVRETXEA-INVRETXFA-INVRETXGA-INVRETXHA-INVRETXIA-INVRETXKA
                                            -INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA
                                            -INVRETQIA-INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA
                                            -INVRETQDA)) * (1 - V_CNR) ;

INVRETOCA = min(NINVRETOC , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA-INVRETRAA-INVRETRBA
                                            -INVRETRCA-INVRETRDA-INVRETXAA-INVRETXBA-INVRETXCA-INVRETXEA-INVRETXFA-INVRETXGA-INVRETXHA-INVRETXIA-INVRETXKA
                                            -INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA
                                            -INVRETQIA-INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA
                                            -INVRETQDA-INVRETOBA)) * (1 - V_CNR) ;

INVRETOMA = min(NINVRETOM , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA-INVRETRAA-INVRETRBA
                                            -INVRETRCA-INVRETRDA-INVRETXAA-INVRETXBA-INVRETXCA-INVRETXEA-INVRETXFA-INVRETXGA-INVRETXHA-INVRETXIA-INVRETXKA
                                            -INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA
                                            -INVRETQIA-INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA
                                            -INVRETQDA-INVRETOBA-INVRETOCA)) * (1 - V_CNR) ;

INVRETONA = min(NINVRETON , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA-INVRETRAA-INVRETRBA
                                            -INVRETRCA-INVRETRDA-INVRETXAA-INVRETXBA-INVRETXCA-INVRETXEA-INVRETXFA-INVRETXGA-INVRETXHA-INVRETXIA-INVRETXKA
                                            -INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA
                                            -INVRETQIA-INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA
                                            -INVRETQDA-INVRETOBA-INVRETOCA-INVRETOMA)) * (1 - V_CNR) ;

INVRETODA = min(NINVRETOD , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA-INVRETRAA-INVRETRBA
                                            -INVRETRCA-INVRETRDA-INVRETXAA-INVRETXBA-INVRETXCA-INVRETXEA-INVRETXFA-INVRETXGA-INVRETXHA-INVRETXIA-INVRETXKA
                                            -INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA
                                            -INVRETQIA-INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA
                                            -INVRETQDA-INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA)) * (1 - V_CNR) ;

INVRETUAA = min(NINVRETUA , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA-INVRETRAA-INVRETRBA
                                            -INVRETRCA-INVRETRDA-INVRETXAA-INVRETXBA-INVRETXCA-INVRETXEA-INVRETXFA-INVRETXGA-INVRETXHA-INVRETXIA-INVRETXKA
                                            -INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA
                                            -INVRETQIA-INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA
                                            -INVRETQDA-INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA-INVRETODA)) * (1 - V_CNR) ;

INVRETUHA = min(NINVRETUH , max(0 , RNIDOM1 -INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA-INVRETRAA-INVRETRBA
                                            -INVRETRCA-INVRETRDA-INVRETXAA-INVRETXBA-INVRETXCA-INVRETXEA-INVRETXFA-INVRETXGA-INVRETXHA-INVRETXIA-INVRETXKA
                                            -INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETKTA-INVRETKUA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA-INVRETQRA
                                            -INVRETQIA-INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA
                                            -INVRETQDA-INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA-INVRETODA-INVRETUAA)) * (1 - V_CNR) ;

INVRET15A = INVRETKHA + INVRETKIA + INVRETQNA + INVRETQUA + INVRETQKA + INVRETQJA + INVRETQSA + INVRETQWA + INVRETQXA + INVRETRAA + INVRETRBA + INVRETRCA 
            + INVRETRDA + INVRETXAA + INVRETXBA + INVRETXCA + INVRETXEA + INVRETXFA + INVRETXGA + INVRETXHA + INVRETXIA + INVRETXKA + INVRETMBA + INVRETLHA 
            + INVRETMCA + INVRETLIA + INVRETKTA + INVRETKUA + INVRETQPA + INVRETQGA + INVRETQOA + INVRETQFA + INVRETQRA + INVRETQIA + INVRETPOA + INVRETPTA 
            + INVRETPNA + INVRETPSA + INVRETPPA + INVRETPUA + INVRETPRA + INVRETPWA + INVRETQLA + INVRETQMA + INVRETQDA + INVRETOBA + INVRETOCA + INVRETOMA 
            + INVRETONA + INVRETODA + INVRETUAA + INVRETUHA ;

INVRETKHRA = min(NINVRETKHR , max(0 , RNIDOM1 -INVRET15A)) * (1 - V_CNR) ;

INVRETKIRA = min(NINVRETKIR , max(0 , RNIDOM1 -INVRET15A-INVRETKHRA)) * (1 - V_CNR) ;

INVRETQNRA = min(NINVRETQNR , max(0 , RNIDOM1 -INVRET15A-INVRETKHRA-INVRETKIRA)) * (1 - V_CNR) ;

INVRETQURA = min(NINVRETQUR , max(0 , RNIDOM1 -INVRET15A-INVRETKHRA-INVRETKIRA-INVRETQNRA)) * (1 - V_CNR) ;

INVRETQKRA = min(NINVRETQKR , max(0 , RNIDOM1 -INVRET15A-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA)) * (1 - V_CNR) ;

INVRETQJRA = min(NINVRETQJR , max(0 , RNIDOM1 -INVRET15A-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA)) * (1 - V_CNR) ;

INVRETQSRA = min(NINVRETQSR , max(0 , RNIDOM1 -INVRET15A-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA-INVRETQJRA)) * (1 - V_CNR) ;

INVRETQWRA = min(NINVRETQWR , max(0 , RNIDOM1 -INVRET15A-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA-INVRETQJRA-INVRETQSRA)) * (1 - V_CNR) ;

INVRETQXRA = min(NINVRETQXR , max(0 , RNIDOM1 -INVRET15A-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA)) * (1 - V_CNR) ;

INVRETRARA = min(NINVRETRAR , max(0 , RNIDOM1 -INVRET15A-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA-INVRETQXRA)) * (1 - V_CNR) ;

INVRETRBRA = min(NINVRETRBR , max(0 , RNIDOM1 -INVRET15A-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA-INVRETQXRA
                                              -INVRETRARA)) * (1 - V_CNR) ;

INVRETRCRA = min(NINVRETRCR , max(0 , RNIDOM1 -INVRET15A-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA-INVRETQXRA
                                              -INVRETRARA-INVRETRBRA)) * (1 - V_CNR) ;

INVRETRDRA = min(NINVRETRDR , max(0 , RNIDOM1 -INVRET15A-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA-INVRETQXRA
                                              -INVRETRARA-INVRETRBRA-INVRETRCRA)) * (1 - V_CNR) ;

INVRETXARA = min(NINVRETXAR , max(0 , RNIDOM1 -INVRET15A-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA-INVRETQXRA
                                              -INVRETRARA-INVRETRBRA-INVRETRCRA-INVRETRDRA)) * (1 - V_CNR) ;

INVRETXBRA = min(NINVRETXBR , max(0 , RNIDOM1 -INVRET15A-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA-INVRETQXRA
                                              -INVRETRARA-INVRETRBRA-INVRETRCRA-INVRETRDRA-INVRETXARA)) * (1 - V_CNR) ;

INVRETXCRA = min(NINVRETXCR , max(0 , RNIDOM1 -INVRET15A-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA-INVRETQXRA
                                              -INVRETRARA-INVRETRBRA-INVRETRCRA-INVRETRDRA-INVRETXARA-INVRETXBRA)) * (1 - V_CNR) ;

INVRETXERA = min(NINVRETXER , max(0 , RNIDOM1 -INVRET15A-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA-INVRETQXRA
                                              -INVRETRARA-INVRETRBRA-INVRETRCRA-INVRETRDRA-INVRETXARA-INVRETXBRA-INVRETXCRA)) * (1 - V_CNR) ;

INVRETXFRA = min(NINVRETXFR , max(0 , RNIDOM1 -INVRET15A-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA-INVRETQXRA
                                              -INVRETRARA-INVRETRBRA-INVRETRCRA-INVRETRDRA-INVRETXARA-INVRETXBRA-INVRETXCRA-INVRETXERA)) * (1 - V_CNR) ;

INVRETXGRA = min(NINVRETXGR , max(0 , RNIDOM1 -INVRET15A-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA-INVRETQXRA
                                              -INVRETRARA-INVRETRBRA-INVRETRCRA-INVRETRDRA-INVRETXARA-INVRETXBRA-INVRETXCRA-INVRETXERA-INVRETXFRA)) * (1 - V_CNR) ;

INVRETXHRA = min(NINVRETXHR , max(0 , RNIDOM1 -INVRET15A-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA-INVRETQXRA
                                              -INVRETRARA-INVRETRBRA-INVRETRCRA-INVRETRDRA-INVRETXARA-INVRETXBRA-INVRETXCRA-INVRETXERA-INVRETXFRA-INVRETXGRA)) * (1 - V_CNR) ;

INVRETXIRA = min(NINVRETXIR , max(0 , RNIDOM1 -INVRET15A-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA-INVRETQXRA
                                              -INVRETRARA-INVRETRBRA-INVRETRCRA-INVRETRDRA-INVRETXARA-INVRETXBRA-INVRETXCRA-INVRETXERA-INVRETXFRA-INVRETXGRA
                                              -INVRETXHRA)) * (1 - V_CNR) ;

INVRETXKRA = min(NINVRETXKR , max(0 , RNIDOM1 -INVRET15A-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA-INVRETQXRA
                                              -INVRETRARA-INVRETRBRA-INVRETRCRA-INVRETRDRA-INVRETXARA-INVRETXBRA-INVRETXCRA-INVRETXERA-INVRETXFRA-INVRETXGRA
                                              -INVRETXHRA-INVRETXIRA)) * (1 - V_CNR) ;

INVRETMBRA = min(NINVRETMBR , max(0 , RNIDOM1 -INVRET15A-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA-INVRETQXRA
                                              -INVRETRARA-INVRETRBRA-INVRETRCRA-INVRETRDRA-INVRETXARA-INVRETXBRA-INVRETXCRA-INVRETXERA-INVRETXFRA-INVRETXGRA
                                              -INVRETXHRA-INVRETXIRA-INVRETXKRA)) * (1 - V_CNR) ;

INVRETMCRA = min(NINVRETMCR , max(0 , RNIDOM1 -INVRET15A-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA-INVRETQXRA
                                              -INVRETRARA-INVRETRBRA-INVRETRCRA-INVRETRDRA-INVRETXARA-INVRETXBRA-INVRETXCRA-INVRETXERA-INVRETXFRA-INVRETXGRA
                                              -INVRETXHRA-INVRETXIRA-INVRETXKRA-INVRETMBRA)) * (1 - V_CNR) ;

INVRETLHRA = min(NINVRETLHR , max(0 , RNIDOM1 -INVRET15A-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA-INVRETQXRA
                                              -INVRETRARA-INVRETRBRA-INVRETRCRA-INVRETRDRA-INVRETXARA-INVRETXBRA-INVRETXCRA-INVRETXERA-INVRETXFRA-INVRETXGRA
                                              -INVRETXHRA-INVRETXIRA-INVRETXKRA-INVRETMBRA-INVRETMCRA)) * (1 - V_CNR) ;

INVRETLIRA = min(NINVRETLIR , max(0 , RNIDOM1 -INVRET15A-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA-INVRETQXRA
                                              -INVRETRARA-INVRETRBRA-INVRETRCRA-INVRETRDRA-INVRETXARA-INVRETXBRA-INVRETXCRA-INVRETXERA-INVRETXFRA-INVRETXGRA
                                              -INVRETXHRA-INVRETXIRA-INVRETXKRA-INVRETMBRA-INVRETMCRA-INVRETLHRA)) * (1 - V_CNR) ;

INVRETQPRA = min(NINVRETQPR , max(0 , RNIDOM1 -INVRET15A-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA-INVRETQXRA
                                              -INVRETRARA-INVRETRBRA-INVRETRCRA-INVRETRDRA-INVRETXARA-INVRETXBRA-INVRETXCRA-INVRETXERA-INVRETXFRA-INVRETXGRA
                                              -INVRETXHRA-INVRETXIRA-INVRETXKRA-INVRETMBRA-INVRETMCRA-INVRETLHRA-INVRETLIRA)) * (1 - V_CNR) ;

INVRETQGRA = min(NINVRETQGR , max(0 , RNIDOM1 -INVRET15A-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA-INVRETQXRA
                                              -INVRETRARA-INVRETRBRA-INVRETRCRA-INVRETRDRA-INVRETXARA-INVRETXBRA-INVRETXCRA-INVRETXERA-INVRETXFRA-INVRETXGRA
                                              -INVRETXHRA-INVRETXIRA-INVRETXKRA-INVRETMBRA-INVRETMCRA-INVRETLHRA-INVRETLIRA-INVRETQPRA)) * (1 - V_CNR) ;

INVRETQORA = min(NINVRETQOR , max(0 , RNIDOM1 -INVRET15A-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA-INVRETQXRA
                                              -INVRETRARA-INVRETRBRA-INVRETRCRA-INVRETRDRA-INVRETXARA-INVRETXBRA-INVRETXCRA-INVRETXERA-INVRETXFRA-INVRETXGRA
                                              -INVRETXHRA-INVRETXIRA-INVRETXKRA-INVRETMBRA-INVRETMCRA-INVRETLHRA-INVRETLIRA-INVRETQPRA-INVRETQGRA)) * (1 - V_CNR) ;

INVRETQFRA = min(NINVRETQFR , max(0 , RNIDOM1 -INVRET15A-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA-INVRETQXRA
                                              -INVRETRARA-INVRETRBRA-INVRETRCRA-INVRETRDRA-INVRETXARA-INVRETXBRA-INVRETXCRA-INVRETXERA-INVRETXFRA-INVRETXGRA
                                              -INVRETXHRA-INVRETXIRA-INVRETXKRA-INVRETMBRA-INVRETMCRA-INVRETLHRA-INVRETLIRA-INVRETQPRA-INVRETQGRA-INVRETQORA)) * (1 - V_CNR) ;

INVRETPORA = min(NINVRETPOR , max(0 , RNIDOM1 -INVRET15A-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA-INVRETQXRA
                                              -INVRETRARA-INVRETRBRA-INVRETRCRA-INVRETRDRA-INVRETXARA-INVRETXBRA-INVRETXCRA-INVRETXERA-INVRETXFRA-INVRETXGRA
                                              -INVRETXHRA-INVRETXIRA-INVRETXKRA-INVRETMBRA-INVRETMCRA-INVRETLHRA-INVRETLIRA-INVRETQPRA-INVRETQGRA-INVRETQORA
                                              -INVRETQFRA)) * (1 - V_CNR) ;

INVRETPTRA = min(NINVRETPTR , max(0 , RNIDOM1 -INVRET15A-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA-INVRETQXRA
                                              -INVRETRARA-INVRETRBRA-INVRETRCRA-INVRETRDRA-INVRETXARA-INVRETXBRA-INVRETXCRA-INVRETXERA-INVRETXFRA-INVRETXGRA
                                              -INVRETXHRA-INVRETXIRA-INVRETXKRA-INVRETMBRA-INVRETMCRA-INVRETLHRA-INVRETLIRA-INVRETQPRA-INVRETQGRA-INVRETQORA
                                              -INVRETQFRA-INVRETPORA)) * (1 - V_CNR) ;

INVRETPNRA = min(NINVRETPNR , max(0 , RNIDOM1 -INVRET15A-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA-INVRETQXRA
                                              -INVRETRARA-INVRETRBRA-INVRETRCRA-INVRETRDRA-INVRETXARA-INVRETXBRA-INVRETXCRA-INVRETXERA-INVRETXFRA-INVRETXGRA
                                              -INVRETXHRA-INVRETXIRA-INVRETXKRA-INVRETMBRA-INVRETMCRA-INVRETLHRA-INVRETLIRA-INVRETQPRA-INVRETQGRA-INVRETQORA
                                              -INVRETQFRA-INVRETPORA-INVRETPTRA)) * (1 - V_CNR) ;

INVRETPSRA = min(NINVRETPSR , max(0 , RNIDOM1 -INVRET15A-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA-INVRETQXRA
                                              -INVRETRARA-INVRETRBRA-INVRETRCRA-INVRETRDRA-INVRETXARA-INVRETXBRA-INVRETXCRA-INVRETXERA-INVRETXFRA-INVRETXGRA
                                              -INVRETXHRA-INVRETXIRA-INVRETXKRA-INVRETMBRA-INVRETMCRA-INVRETLHRA-INVRETLIRA-INVRETQPRA-INVRETQGRA-INVRETQORA
                                              -INVRETQFRA-INVRETPORA-INVRETPTRA-INVRETPNRA)) * (1 - V_CNR) ;

TOTALPLAFA = INVRETKHA + INVRETKIA + INVRETQNA + INVRETQUA + INVRETQKA + INVRETQJA + INVRETQSA + INVRETQWA + INVRETQXA + INVRETRAA + INVRETRBA + INVRETRCA 
             + INVRETRDA + INVRETXAA + INVRETXBA + INVRETXCA + INVRETXEA + INVRETXFA + INVRETXGA + INVRETXHA + INVRETXIA + INVRETXKA + INVRETMBA + INVRETLHA 
             + INVRETMCA + INVRETLIA + INVRETKTA + INVRETKUA + INVRETQPA + INVRETQGA + INVRETQOA + INVRETQFA + INVRETQRA + INVRETQIA + INVRETPOA + INVRETPTA 
             + INVRETPNA + INVRETPSA + INVRETPPA + INVRETPUA + INVRETPRA + INVRETPWA + INVRETQLA + INVRETQMA + INVRETQDA + INVRETOBA + INVRETOCA + INVRETOMA 
             + INVRETONA + INVRETODA + INVRETUAA + INVRETUHA
             + INVRETKHRA + INVRETKIRA + INVRETQNRA + INVRETQURA + INVRETQKRA + INVRETQJRA + INVRETQSRA + INVRETQWRA + INVRETQXRA + INVRETRARA + INVRETRBRA 
             + INVRETRCRA + INVRETRDRA + INVRETXARA + INVRETXBRA + INVRETXCRA + INVRETXERA + INVRETXFRA + INVRETXGRA + INVRETXHRA + INVRETXIRA + INVRETXKRA
             + INVRETMBRA + INVRETLHRA + INVRETLIRA + INVRETMCRA + INVRETQPRA + INVRETQGRA + INVRETQORA + INVRETQFRA + INVRETPORA + INVRETPTRA + INVRETPNRA 
             + INVRETPSRA ; 

INDPLAF2 = positif(RNIDOM2 - TOTALPLAF2 - TOTALPLAFA) ;


MAXDOM2 = max(0,RNIDOM2 - TOTALPLAFA) ;

INVRETPBA = min(arr(NINVRETPB*TX375/100) , MAXDOM2) * (1 - V_CNR) ; 

INVRETPFA = min(arr(NINVRETPF*TX375/100) , max(0 , MAXDOM2 -INVRETPBA)) * (1 - V_CNR) ;

INVRETPJA = min(arr(NINVRETPJ*TX375/100) , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA)) * (1 - V_CNR) ;

INVRETPAA = min(arr(NINVRETPA*TX4737/100) , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA)) * (1 - V_CNR) ;

INVRETPEA = min(arr(NINVRETPE*TX4737/100) , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA- INVRETPAA)) * (1 - V_CNR) ;

INVRETPIA = min(arr(NINVRETPI*TX4737/100) , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA)) * (1 - V_CNR) ;

INVRETPDA = min(NINVRETPD , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA)) * (1 - V_CNR) ;

INVRETPHA = min(NINVRETPH , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA)) * (1 - V_CNR) ;

INVRETPLA = min(NINVRETPL , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA)) * (1 - V_CNR) ;

INVRETPYA = min(arr(NINVRETPY*TX375/100) , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA)) * (1 - V_CNR) ;

INVRETPXA = min(arr(NINVRETPX*TX4737/100) , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA
                                                            -INVRETPYA)) * (1 - V_CNR) ;

INVRETRGA = min(NINVRETRG , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA-INVRETPYA-INVRETPXA)) * (1 - V_CNR) ;

INVRETRIA = min(NINVRETRI , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA-INVRETPYA-INVRETPXA
                                            -INVRETRGA)) * (1 - V_CNR) ;

INVRETSBA = min(arr(NINVRETSB*TX375/100) , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA
                                                           -INVRETPYA-INVRETPXA-INVRETRGA-INVRETRIA)) * (1 - V_CNR) ;

INVRETSGA = min(arr(NINVRETSG*TX375/100) , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA
                                                           -INVRETPYA-INVRETPXA-INVRETRGA-INVRETRIA-INVRETSBA)) * (1 - V_CNR) ;

INVRETSAA = min(arr(NINVRETSA*TX4737/100) , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA
                                                            -INVRETPYA-INVRETPXA-INVRETRGA-INVRETRIA-INVRETSBA-INVRETSGA)) * (1 - V_CNR) ;

INVRETSFA = min(arr(NINVRETSF*TX4737/100) , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA
                                                            -INVRETPYA-INVRETPXA-INVRETRGA-INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA)) * (1 - V_CNR) ;

INVRETSCA = min(NINVRETSC , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA-INVRETPYA-INVRETPXA
                                            -INVRETRGA-INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA)) * (1 - V_CNR) ;

INVRETSHA = min(NINVRETSH , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA-INVRETPYA-INVRETPXA
                                            -INVRETRGA-INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA)) * (1 - V_CNR) ;

INVRETSEA = min(NINVRETSE , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA-INVRETPYA-INVRETPXA
                                            -INVRETRGA-INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA-INVRETSHA)) * (1 - V_CNR) ;

INVRETSJA = min(NINVRETSJ , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA-INVRETPYA-INVRETPXA
                                            -INVRETRGA-INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA-INVRETSHA-INVRETSEA)) * (1 - V_CNR) ;

INVRETABA = min(arr(NINVRETAB*TX375/100) , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA-INVRETPYA
                                                           -INVRETPXA-INVRETRGA-INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA-INVRETSHA-INVRETSEA
                                                           -INVRETSJA)) * (1 - V_CNR) ;

INVRETAGA = min(arr(NINVRETAG*TX375/100) , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA-INVRETPYA
                                                           -INVRETPXA-INVRETRGA-INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA-INVRETSHA-INVRETSEA
                                                           -INVRETSJA-INVRETABA)) * (1 - V_CNR) ;

INVRETAAA = min(arr(NINVRETAA*TX4737/100) , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA-INVRETPYA
                                                            -INVRETPXA-INVRETRGA-INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA-INVRETSHA-INVRETSEA
                                                            -INVRETSJA-INVRETABA-INVRETAGA)) * (1 - V_CNR) ;

INVRETAFA = min(arr(NINVRETAF*TX4737/100) , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA-INVRETPYA
                                                            -INVRETPXA-INVRETRGA-INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA-INVRETSHA-INVRETSEA
                                                            -INVRETSJA-INVRETABA-INVRETAGA-INVRETAAA)) * (1 - V_CNR) ;

INVRETACA = min(NINVRETAC , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA-INVRETPYA-INVRETPXA
                                            -INVRETRGA-INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA-INVRETSHA-INVRETSEA-INVRETSJA-INVRETABA
                                            -INVRETAGA-INVRETAAA-INVRETAFA)) * (1 - V_CNR) ;

INVRETAHA = min(NINVRETAH , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA-INVRETPYA-INVRETPXA
                                            -INVRETRGA-INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA-INVRETSHA-INVRETSEA-INVRETSJA-INVRETABA
                                            -INVRETAGA-INVRETAAA-INVRETAFA-INVRETACA)) * (1 - V_CNR) ;

INVRETAEA = min(NINVRETAE , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA-INVRETPYA-INVRETPXA
                                            -INVRETRGA-INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA-INVRETSHA-INVRETSEA-INVRETSJA-INVRETABA
                                            -INVRETAGA-INVRETAAA-INVRETAFA-INVRETACA-INVRETAHA)) * (1 - V_CNR) ;

INVRETAJA = min(NINVRETAJ , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA-INVRETPYA-INVRETPXA
                                            -INVRETRGA-INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA-INVRETSHA-INVRETSEA-INVRETSJA-INVRETABA
                                            -INVRETAGA-INVRETAAA-INVRETAFA-INVRETACA-INVRETAHA-INVRETAEA)) * (1 - V_CNR) ;

INVRETBJA = min(arr(NINVRETBJ*TX375/100) , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA-INVRETPYA-INVRETPXA
                                                           -INVRETRGA-INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA-INVRETSHA-INVRETSEA-INVRETSJA-INVRETABA
                                                           -INVRETAGA-INVRETAAA-INVRETAFA-INVRETACA-INVRETAHA-INVRETAEA-INVRETAJA)) * (1 - V_CNR) ;

INVRETBOA = min(arr(NINVRETBO*TX375/100) , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA-INVRETPYA-INVRETPXA
                                                           -INVRETRGA-INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA-INVRETSHA-INVRETSEA-INVRETSJA-INVRETABA
                                                           -INVRETAGA-INVRETAAA-INVRETAFA-INVRETACA-INVRETAHA-INVRETAEA-INVRETAJA-INVRETBJA)) * (1 - V_CNR) ;

INVRETBIA = min(arr(NINVRETBI*TX4737/100) , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA-INVRETPYA-INVRETPXA
                                                            -INVRETRGA-INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA-INVRETSHA-INVRETSEA-INVRETSJA-INVRETABA
                                                            -INVRETAGA-INVRETAAA-INVRETAFA-INVRETACA-INVRETAHA-INVRETAEA-INVRETAJA-INVRETBJA-INVRETBOA)) * (1 - V_CNR) ;

INVRETBNA = min(arr(NINVRETBN*TX4737/100) , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA-INVRETPYA-INVRETPXA
                                                            -INVRETRGA-INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA-INVRETSHA-INVRETSEA-INVRETSJA-INVRETABA
                                                            -INVRETAGA-INVRETAAA-INVRETAFA-INVRETACA-INVRETAHA-INVRETAEA-INVRETAJA-INVRETBJA-INVRETBOA-INVRETBIA)) * (1 - V_CNR) ;

INVRETBKA = min(NINVRETBK , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA-INVRETPYA-INVRETPXA-INVRETRGA
                                            -INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA-INVRETSHA-INVRETSEA-INVRETSJA-INVRETABA-INVRETAGA-INVRETAAA
                                            -INVRETAFA-INVRETACA-INVRETAHA-INVRETAEA-INVRETAJA-INVRETBJA-INVRETBOA-INVRETBIA-INVRETBNA)) * (1 - V_CNR) ;

INVRETBPA = min(NINVRETBP , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA-INVRETPYA-INVRETPXA-INVRETRGA
                                            -INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA-INVRETSHA-INVRETSEA-INVRETSJA-INVRETABA-INVRETAGA-INVRETAAA
                                            -INVRETAFA-INVRETACA-INVRETAHA-INVRETAEA-INVRETAJA-INVRETBJA-INVRETBOA-INVRETBIA-INVRETBNA-INVRETBKA)) * (1 - V_CNR) ;

INVRETBMA = min(NINVRETBM , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA-INVRETPYA-INVRETPXA-INVRETRGA
                                            -INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA-INVRETSHA-INVRETSEA-INVRETSJA-INVRETABA-INVRETAGA-INVRETAAA
                                            -INVRETAFA-INVRETACA-INVRETAHA-INVRETAEA-INVRETAJA-INVRETBJA-INVRETBOA-INVRETBIA-INVRETBNA-INVRETBKA-INVRETBPA)) * (1 - V_CNR) ;

INVRETBRA = min(NINVRETBR , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA-INVRETPYA-INVRETPXA-INVRETRGA
                                            -INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA-INVRETSHA-INVRETSEA-INVRETSJA-INVRETABA-INVRETAGA-INVRETAAA
                                            -INVRETAFA-INVRETACA-INVRETAHA-INVRETAEA-INVRETAJA-INVRETBJA-INVRETBOA-INVRETBIA-INVRETBNA-INVRETBKA-INVRETBPA-INVRETBMA)) * (1 - V_CNR) ;

INVRETOIA = min(NINVRETOI , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA-INVRETPYA-INVRETPXA-INVRETRGA
                                            -INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA-INVRETSHA-INVRETSEA-INVRETSJA-INVRETABA-INVRETAGA-INVRETAAA
                                            -INVRETAFA-INVRETACA-INVRETAHA-INVRETAEA-INVRETAJA-INVRETBJA-INVRETBOA-INVRETBIA-INVRETBNA-INVRETBKA-INVRETBPA-INVRETBMA
                                            -INVRETBRA)) * (1 - V_CNR) ;

INVRETOJA = min(NINVRETOJ , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA-INVRETPYA-INVRETPXA-INVRETRGA
                                            -INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA-INVRETSHA-INVRETSEA-INVRETSJA-INVRETABA-INVRETAGA-INVRETAAA
                                            -INVRETAFA-INVRETACA-INVRETAHA-INVRETAEA-INVRETAJA-INVRETBJA-INVRETBOA-INVRETBIA-INVRETBNA-INVRETBKA-INVRETBPA-INVRETBMA
                                            -INVRETBRA-INVRETOIA)) * (1 - V_CNR) ;

INVRETOKA = min(NINVRETOK , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA-INVRETPYA-INVRETPXA-INVRETRGA
                                            -INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA-INVRETSHA-INVRETSEA-INVRETSJA-INVRETABA-INVRETAGA-INVRETAAA
                                            -INVRETAFA-INVRETACA-INVRETAHA-INVRETAEA-INVRETAJA-INVRETBJA-INVRETBOA-INVRETBIA-INVRETBNA-INVRETBKA-INVRETBPA-INVRETBMA
                                            -INVRETBRA-INVRETOIA-INVRETOJA)) * (1 - V_CNR) ;

INVRETOPA = min(NINVRETOP , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA-INVRETPYA-INVRETPXA-INVRETRGA
                                            -INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA-INVRETSHA-INVRETSEA-INVRETSJA-INVRETABA-INVRETAGA-INVRETAAA
                                            -INVRETAFA-INVRETACA-INVRETAHA-INVRETAEA-INVRETAJA-INVRETBJA-INVRETBOA-INVRETBIA-INVRETBNA-INVRETBKA-INVRETBPA-INVRETBMA
                                            -INVRETBRA-INVRETOIA-INVRETOJA-INVRETOKA)) * (1 - V_CNR) ;

INVRETOQA = min(NINVRETOQ , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA-INVRETPYA-INVRETPXA-INVRETRGA
                                            -INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA-INVRETSHA-INVRETSEA-INVRETSJA-INVRETABA-INVRETAGA-INVRETAAA
                                            -INVRETAFA-INVRETACA-INVRETAHA-INVRETAEA-INVRETAJA-INVRETBJA-INVRETBOA-INVRETBIA-INVRETBNA-INVRETBKA-INVRETBPA-INVRETBMA
                                            -INVRETBRA-INVRETOIA-INVRETOJA-INVRETOKA-INVRETOPA)) * (1 - V_CNR) ;

INVRETORA = min(NINVRETOR , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA-INVRETPYA-INVRETPXA-INVRETRGA
                                            -INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA-INVRETSHA-INVRETSEA-INVRETSJA-INVRETABA-INVRETAGA-INVRETAAA
                                            -INVRETAFA-INVRETACA-INVRETAHA-INVRETAEA-INVRETAJA-INVRETBJA-INVRETBOA-INVRETBIA-INVRETBNA-INVRETBKA-INVRETBPA-INVRETBMA
                                            -INVRETBRA-INVRETOIA-INVRETOJA-INVRETOKA-INVRETOPA-INVRETOQA)) * (1 - V_CNR) ;

INVRETOEA = min(NINVRETOE , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA-INVRETPYA-INVRETPXA-INVRETRGA
                                            -INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA-INVRETSHA-INVRETSEA-INVRETSJA-INVRETABA-INVRETAGA-INVRETAAA
                                            -INVRETAFA-INVRETACA-INVRETAHA-INVRETAEA-INVRETAJA-INVRETBJA-INVRETBOA-INVRETBIA-INVRETBNA-INVRETBKA-INVRETBPA-INVRETBMA
                                            -INVRETBRA-INVRETOIA-INVRETOJA-INVRETOKA-INVRETOPA-INVRETOQA-INVRETORA)) * (1 - V_CNR) ;

INVRETOFA = min(NINVRETOF , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA-INVRETPYA-INVRETPXA-INVRETRGA
                                            -INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA-INVRETSHA-INVRETSEA-INVRETSJA-INVRETABA-INVRETAGA-INVRETAAA
                                            -INVRETAFA-INVRETACA-INVRETAHA-INVRETAEA-INVRETAJA-INVRETBJA-INVRETBOA-INVRETBIA-INVRETBNA-INVRETBKA-INVRETBPA-INVRETBMA
                                            -INVRETBRA-INVRETOIA-INVRETOJA-INVRETOKA-INVRETOPA-INVRETOQA-INVRETORA-INVRETOEA)) * (1 - V_CNR) ;

INVRETUBA = min(NINVRETUB , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA-INVRETPYA-INVRETPXA-INVRETRGA
                                            -INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA-INVRETSHA-INVRETSEA-INVRETSJA-INVRETABA-INVRETAGA-INVRETAAA
                                            -INVRETAFA-INVRETACA-INVRETAHA-INVRETAEA-INVRETAJA-INVRETBJA-INVRETBOA-INVRETBIA-INVRETBNA-INVRETBKA-INVRETBPA-INVRETBMA
                                            -INVRETBRA-INVRETOIA-INVRETOJA-INVRETOKA-INVRETOPA-INVRETOQA-INVRETORA-INVRETOEA-INVRETOFA)) * (1 - V_CNR) ;

INVRETUCA = min(NINVRETUC , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA-INVRETPYA-INVRETPXA-INVRETRGA
                                            -INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA-INVRETSHA-INVRETSEA-INVRETSJA-INVRETABA-INVRETAGA-INVRETAAA
                                            -INVRETAFA-INVRETACA-INVRETAHA-INVRETAEA-INVRETAJA-INVRETBJA-INVRETBOA-INVRETBIA-INVRETBNA-INVRETBKA-INVRETBPA-INVRETBMA
                                            -INVRETBRA-INVRETOIA-INVRETOJA-INVRETOKA-INVRETOPA-INVRETOQA-INVRETORA-INVRETOEA-INVRETOFA-INVRETUBA)) * (1 - V_CNR) ;

INVRETUIA = min(NINVRETUI , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA-INVRETPYA-INVRETPXA-INVRETRGA
                                            -INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA-INVRETSHA-INVRETSEA-INVRETSJA-INVRETABA-INVRETAGA-INVRETAAA
                                            -INVRETAFA-INVRETACA-INVRETAHA-INVRETAEA-INVRETAJA-INVRETBJA-INVRETBOA-INVRETBIA-INVRETBNA-INVRETBKA-INVRETBPA-INVRETBMA
                                            -INVRETBRA-INVRETOIA-INVRETOJA-INVRETOKA-INVRETOPA-INVRETOQA-INVRETORA-INVRETOEA-INVRETOFA-INVRETUBA-INVRETUCA)) * (1 - V_CNR) ;

INVRETUJA = min(NINVRETUJ , max(0 , MAXDOM2 -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPDA-INVRETPHA-INVRETPLA-INVRETPYA-INVRETPXA-INVRETRGA
                                            -INVRETRIA-INVRETSBA-INVRETSGA-INVRETSAA-INVRETSFA-INVRETSCA-INVRETSHA-INVRETSEA-INVRETSJA-INVRETABA-INVRETAGA-INVRETAAA
                                            -INVRETAFA-INVRETACA-INVRETAHA-INVRETAEA-INVRETAJA-INVRETBJA-INVRETBOA-INVRETBIA-INVRETBNA-INVRETBKA-INVRETBPA-INVRETBMA
                                            -INVRETBRA-INVRETOIA-INVRETOJA-INVRETOKA-INVRETOPA-INVRETOQA-INVRETORA-INVRETOEA-INVRETOFA-INVRETUBA-INVRETUCA-INVRETUIA)) * (1 - V_CNR) ;

INVRET13A = INVRETPBA + INVRETPFA + INVRETPJA + INVRETPAA + INVRETPEA + INVRETPIA + INVRETPDA + INVRETPHA + INVRETPLA + INVRETPYA + INVRETPXA + INVRETRGA + INVRETRIA 
            + INVRETSBA + INVRETSGA + INVRETSAA + INVRETSFA + INVRETSCA + INVRETSHA + INVRETSEA + INVRETSJA + INVRETABA + INVRETAGA + INVRETAAA + INVRETAFA + INVRETACA 
            + INVRETAHA + INVRETAEA + INVRETAJA + INVRETBJA + INVRETBOA + INVRETBIA + INVRETBNA + INVRETBKA + INVRETBPA + INVRETBMA + INVRETBRA + INVRETOIA + INVRETOJA 
            + INVRETOKA + INVRETOPA + INVRETOQA + INVRETORA + INVRETOEA + INVRETOFA + INVRETUBA + INVRETUCA + INVRETUIA + INVRETUJA ;

INVRETPBRA = min(NINVRETPBR , max(0 , MAXDOM2 -INVRET13A)) * (1 - V_CNR) ;

INVRETPFRA = min(NINVRETPFR , max(0 , MAXDOM2 -INVRET13A-INVRETPBRA)) * (1 - V_CNR) ;

INVRETPJRA = min(NINVRETPJR , max(0 , MAXDOM2 -INVRET13A-INVRETPBRA-INVRETPFRA)) * (1 - V_CNR) ;

INVRETPARA = min(NINVRETPAR , max(0 , MAXDOM2 -INVRET13A-INVRETPBRA-INVRETPFRA-INVRETPJRA)) * (1 - V_CNR) ;

INVRETPERA = min(NINVRETPER , max(0 , MAXDOM2 -INVRET13A-INVRETPBRA-INVRETPFRA-INVRETPJRA-INVRETPARA)) * (1 - V_CNR) ;

INVRETPIRA = min(NINVRETPIR , max(0 , MAXDOM2 -INVRET13A-INVRETPBRA-INVRETPFRA-INVRETPJRA-INVRETPARA-INVRETPERA)) * (1 - V_CNR) ;

INVRETPYRA = min(NINVRETPYR , max(0 , MAXDOM2 -INVRET13A-INVRETPBRA-INVRETPFRA-INVRETPJRA-INVRETPARA-INVRETPERA-INVRETPIRA)) * (1 - V_CNR) ;

INVRETPXRA = min(NINVRETPXR , max(0 , MAXDOM2 -INVRET13A-INVRETPBRA-INVRETPFRA-INVRETPJRA-INVRETPARA-INVRETPERA-INVRETPIRA-INVRETPYRA)) * (1 - V_CNR) ;

INVRETSBRA = min(NINVRETSBR , max(0 , MAXDOM2 -INVRET13A-INVRETPBRA-INVRETPFRA-INVRETPJRA-INVRETPARA-INVRETPERA-INVRETPIRA-INVRETPYRA-INVRETPXRA)) * (1 - V_CNR) ;

INVRETSGRA = min(NINVRETSGR , max(0 , MAXDOM2 -INVRET13A-INVRETPBRA-INVRETPFRA-INVRETPJRA-INVRETPARA-INVRETPERA-INVRETPIRA-INVRETPYRA-INVRETPXRA-INVRETSBRA)) * (1 - V_CNR) ;

INVRETSARA = min(NINVRETSAR , max(0 , MAXDOM2 -INVRET13A-INVRETPBRA-INVRETPFRA-INVRETPJRA-INVRETPARA-INVRETPERA-INVRETPIRA-INVRETPYRA-INVRETPXRA-INVRETSBRA-INVRETSGRA)) * (1 - V_CNR) ;

INVRETSFRA = min(NINVRETSFR , max(0 , MAXDOM2 -INVRET13A-INVRETPBRA-INVRETPFRA-INVRETPJRA-INVRETPARA-INVRETPERA-INVRETPIRA-INVRETPYRA-INVRETPXRA-INVRETSBRA-INVRETSGRA
                                              -INVRETSARA)) * (1 - V_CNR) ;

INVRETABRA = min(NINVRETABR , max(0 , MAXDOM2 -INVRET13A-INVRETPBRA-INVRETPFRA-INVRETPJRA-INVRETPARA-INVRETPERA-INVRETPIRA-INVRETPYRA-INVRETPXRA-INVRETSBRA-INVRETSGRA
                                              -INVRETSARA-INVRETSFRA)) * (1 - V_CNR) ;

INVRETAGRA = min(NINVRETAGR , max(0 , MAXDOM2 -INVRET13A-INVRETPBRA-INVRETPFRA-INVRETPJRA-INVRETPARA-INVRETPERA-INVRETPIRA-INVRETPYRA-INVRETPXRA-INVRETSBRA-INVRETSGRA
                                              -INVRETSARA-INVRETSFRA-INVRETABRA)) * (1 - V_CNR) ;

INVRETAARA = min(NINVRETAAR , max(0 , MAXDOM2 -INVRET13A-INVRETPBRA-INVRETPFRA-INVRETPJRA-INVRETPARA-INVRETPERA-INVRETPIRA-INVRETPYRA-INVRETPXRA-INVRETSBRA-INVRETSGRA
                                              -INVRETSARA-INVRETSFRA-INVRETABRA-INVRETAGRA)) * (1 - V_CNR) ;

INVRETAFRA = min(NINVRETAFR , max(0 , MAXDOM2 -INVRET13A-INVRETPBRA-INVRETPFRA-INVRETPJRA-INVRETPARA-INVRETPERA-INVRETPIRA-INVRETPYRA-INVRETPXRA-INVRETSBRA-INVRETSGRA
                                              -INVRETSARA-INVRETSFRA-INVRETABRA-INVRETAGRA-INVRETAARA)) * (1 - V_CNR) ;

INVRETBJRA = min(NINVRETBJR , max(0 , MAXDOM2 -INVRET13A-INVRETPBRA-INVRETPFRA-INVRETPJRA-INVRETPARA-INVRETPERA-INVRETPIRA-INVRETPYRA-INVRETPXRA-INVRETSBRA-INVRETSGRA
                                              -INVRETSARA-INVRETSFRA-INVRETABRA-INVRETAGRA-INVRETAARA-INVRETAFRA)) * (1 - V_CNR) ;

INVRETBORA = min(NINVRETBOR , max(0 , MAXDOM2 -INVRET13A-INVRETPBRA-INVRETPFRA-INVRETPJRA-INVRETPARA-INVRETPERA-INVRETPIRA-INVRETPYRA-INVRETPXRA-INVRETSBRA-INVRETSGRA
                                              -INVRETSARA-INVRETSFRA-INVRETABRA-INVRETAGRA-INVRETAARA-INVRETAFRA-INVRETBJRA)) * (1 - V_CNR) ;

INVRETBIRA = min(NINVRETBIR , max(0 , MAXDOM2 -INVRET13A-INVRETPBRA-INVRETPFRA-INVRETPJRA-INVRETPARA-INVRETPERA-INVRETPIRA-INVRETPYRA-INVRETPXRA-INVRETSBRA-INVRETSGRA
                                              -INVRETSARA-INVRETSFRA-INVRETABRA-INVRETAGRA-INVRETAARA-INVRETAFRA-INVRETBJRA-INVRETBORA)) * (1 - V_CNR) ;

INVRETBNRA = min(NINVRETBNR , max(0 , MAXDOM2 -INVRET13A-INVRETPBRA-INVRETPFRA-INVRETPJRA-INVRETPARA-INVRETPERA-INVRETPIRA-INVRETPYRA-INVRETPXRA-INVRETSBRA-INVRETSGRA
                                              -INVRETSARA-INVRETSFRA-INVRETABRA-INVRETAGRA-INVRETAARA-INVRETAFRA-INVRETBJRA-INVRETBORA-INVRETBIRA)) * (1 - V_CNR) ;

TOTALPLAFB = INVRETPBA + INVRETPFA + INVRETPJA + INVRETPAA + INVRETPEA + INVRETPIA + INVRETPDA + INVRETPHA + INVRETPLA + INVRETPYA + INVRETPXA + INVRETRGA 
             + INVRETRIA + INVRETSBA + INVRETSGA + INVRETSAA + INVRETSFA + INVRETSCA + INVRETSHA + INVRETSEA + INVRETSJA + INVRETABA + INVRETAGA + INVRETAAA 
             + INVRETAFA + INVRETACA + INVRETAHA + INVRETAEA + INVRETAJA + INVRETBJA + INVRETBOA + INVRETBIA + INVRETBNA + INVRETBKA + INVRETBPA + INVRETBMA 
             + INVRETBRA + INVRETOIA + INVRETOJA + INVRETOKA + INVRETOPA + INVRETOQA + INVRETORA + INVRETOEA + INVRETOFA + INVRETUBA + INVRETUCA + INVRETUIA
             + INVRETUJA
             + INVRETPBRA + INVRETPFRA + INVRETPJRA + INVRETPARA + INVRETPERA + INVRETPIRA + INVRETPYRA + INVRETPXRA + INVRETSBRA + INVRETSGRA + INVRETSARA 
             + INVRETSFRA + INVRETABRA + INVRETAGRA + INVRETAARA + INVRETAFRA + INVRETBJRA + INVRETBORA + INVRETBIRA + INVRETBNRA ;
 
INDPLAF3 = positif(RNIDOM3 - TOTALPLAF3 - TOTALPLAFA - TOTALPLAFB) ;


MAXDOM3 = max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) ;

INVRETRLA = min(arr(NINVRETRL*TX375/100) , MAXDOM3) * (1 - V_CNR) ; 

INVRETRQA = min(arr(NINVRETRQ*TX375/100) , max(0 , MAXDOM3 -INVRETRLA)) * (1 - V_CNR) ;

INVRETRVA = min(arr(NINVRETRV*TX375/100) , max(0 , MAXDOM3 -INVRETRLA-INVRETRQA)) * (1 - V_CNR) ;

INVRETNVA = min(arr(NINVRETNV*TX375/100) , max(0 , MAXDOM3 -INVRETRLA-INVRETRQA-INVRETRVA)) * (1 - V_CNR) ;

INVRETRKA = min(arr(NINVRETRK*TX4737/100) , max(0 , MAXDOM3 -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA)) * (1 - V_CNR) ;

INVRETRPA = min(arr(NINVRETRP*TX4737/100) , max(0 , MAXDOM3 -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA)) * (1 - V_CNR) ;

INVRETRUA = min(arr(NINVRETRU*TX4737/100) , max(0 , MAXDOM3 -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA)) * (1 - V_CNR) ;

INVRETNUA = min(arr(NINVRETNU*TX4737/100) , max(0 , MAXDOM3 -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA)) * (1 - V_CNR) ;

INVRETRMA = min(NINVRETRM , max(0 , MAXDOM3 -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA)) * (1 - V_CNR) ;

INVRETRRA = min(NINVRETRR , max(0 , MAXDOM3 -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA-INVRETRMA)) * (1 - V_CNR) ;

INVRETRWA = min(NINVRETRW , max(0 , MAXDOM3 -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA-INVRETRMA-INVRETRRA)) * (1 - V_CNR) ;

INVRETNWA = min(NINVRETNW , max(0 , MAXDOM3 -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA-INVRETRMA-INVRETRRA
                                            -INVRETRWA)) * (1 - V_CNR) ;

INVRETROA = min(NINVRETRO , max(0 , MAXDOM3 -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA-INVRETRMA-INVRETRRA
                                            -INVRETRWA-INVRETNWA)) * (1 - V_CNR) ;

INVRETRTA = min(NINVRETRT , max(0 , MAXDOM3 -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA-INVRETRMA-INVRETRRA
                                            -INVRETRWA-INVRETNWA-INVRETROA)) * (1 - V_CNR) ;

INVRETRYA = min(NINVRETRY , max(0 , MAXDOM3 -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA-INVRETRMA-INVRETRRA
                                            -INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA)) * (1 - V_CNR) ;

INVRETNYA = min(NINVRETNY , max(0 , MAXDOM3 -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA-INVRETRMA-INVRETRRA
                                            -INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA)) * (1 - V_CNR) ;

INVRETSLA = min(arr(NINVRETSL*TX375/100) , max(0 , MAXDOM3 -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA-INVRETRMA-INVRETRRA
                                                           -INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA)) * (1 - V_CNR) ;

INVRETSQA = min(arr(NINVRETSQ*TX375/100) , max(0 , MAXDOM3 -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA-INVRETRMA-INVRETRRA
                                                           -INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA-INVRETSLA)) * (1 - V_CNR) ;

INVRETSVA = min(arr(NINVRETSV*TX375/100) , max(0 , MAXDOM3 -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA-INVRETRMA-INVRETRRA
                                                           -INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA-INVRETSLA-INVRETSQA)) * (1 - V_CNR) ;

INVRETTAA = min(arr(NINVRETTA*TX375/100) , max(0 , MAXDOM3 -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA-INVRETRMA-INVRETRRA
                                                           -INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA-INVRETSLA-INVRETSQA-INVRETSVA)) * (1 - V_CNR) ;

INVRETSKA = min(arr(NINVRETSK*TX4737/100) , max(0 , MAXDOM3 -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA-INVRETRMA-INVRETRRA
                                                            -INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA-INVRETSLA-INVRETSQA-INVRETSVA-INVRETTAA)) * (1 - V_CNR) ;

INVRETSPA = min(arr(NINVRETSP*TX4737/100) , max(0 , MAXDOM3 -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA-INVRETRMA-INVRETRRA
                                                            -INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA-INVRETSLA-INVRETSQA-INVRETSVA-INVRETTAA
                                                            -INVRETSKA)) * (1 - V_CNR) ;

INVRETSUA = min(arr(NINVRETSU*TX4737/100) , max(0 , MAXDOM3 -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA-INVRETRMA-INVRETRRA
                                                            -INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA-INVRETSLA-INVRETSQA-INVRETSVA-INVRETTAA
                                                            -INVRETSKA-INVRETSPA)) * (1 - V_CNR) ;

INVRETSZA = min(arr(NINVRETSZ*TX4737/100) , max(0 , MAXDOM3 -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA-INVRETRMA-INVRETRRA
                                                            -INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA-INVRETSLA-INVRETSQA-INVRETSVA-INVRETTAA
                                                            -INVRETSKA-INVRETSPA-INVRETSUA)) * (1 - V_CNR) ;

INVRET111 = INVRETRLA + INVRETRQA + INVRETRVA + INVRETNVA + INVRETRKA + INVRETRPA + INVRETRUA + INVRETNUA + INVRETRMA + INVRETRRA + INVRETRWA + INVRETNWA
            + INVRETROA + INVRETRTA + INVRETRYA + INVRETNYA + INVRETSLA + INVRETSQA + INVRETSVA + INVRETTAA + INVRETSKA + INVRETSPA + INVRETSUA + INVRETSZA ;

INVRETSMA = min(NINVRETSM , max(0 , MAXDOM3 -INVRET111)) * (1 - V_CNR) ;

INVRETSRA = min(NINVRETSR , max(0 , MAXDOM3 -INVRET111-INVRETSMA)) * (1 - V_CNR) ;

INVRETSWA = min(NINVRETSW , max(0 , MAXDOM3 -INVRET111-INVRETSMA-INVRETSRA)) * (1 - V_CNR) ;

INVRETTBA = min(NINVRETTB , max(0 , MAXDOM3 -INVRET111-INVRETSMA-INVRETSRA-INVRETSWA)) * (1 - V_CNR) ;

INVRETSOA = min(NINVRETSO , max(0 , MAXDOM3 -INVRET111-INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA)) * (1 - V_CNR) ;

INVRETSTA = min(NINVRETST , max(0 , MAXDOM3 -INVRET111-INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA)) * (1 - V_CNR) ;

INVRETSYA = min(NINVRETSY , max(0 , MAXDOM3 -INVRET111-INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA-INVRETSTA)) * (1 - V_CNR) ;

INVRETTDA = min(NINVRETTD , max(0 , MAXDOM3 -INVRET111-INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA-INVRETSTA-INVRETSYA)) * (1 - V_CNR) ;

INVRETALA = min(arr(NINVRETAL*TX375/100) , max(0 , MAXDOM3 -INVRET111-INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA-INVRETSTA-INVRETSYA-INVRETTDA)) * (1 - V_CNR) ;

INVRETAQA = min(arr(NINVRETAQ*TX375/100) , max(0 , MAXDOM3 -INVRET111-INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA-INVRETSTA-INVRETSYA-INVRETTDA-INVRETALA)) * (1 - V_CNR) ;

INVRETAVA = min(arr(NINVRETAV*TX375/100) , max(0 , MAXDOM3 -INVRET111-INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA-INVRETSTA-INVRETSYA-INVRETTDA-INVRETALA
                                                           -INVRETAQA)) * (1 - V_CNR) ;

INVRETBBA = min(arr(NINVRETBB*TX375/100) , max(0 , MAXDOM3 -INVRET111-INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA-INVRETSTA-INVRETSYA-INVRETTDA-INVRETALA
                                                           -INVRETAQA-INVRETAVA)) * (1 - V_CNR) ;

INVRETAKA = min(arr(NINVRETAK*TX4737/100) , max(0 , MAXDOM3 -INVRET111-INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA-INVRETSTA-INVRETSYA-INVRETTDA-INVRETALA
                                                            -INVRETAQA-INVRETAVA-INVRETBBA)) * (1 - V_CNR) ;

INVRETAPA = min(arr(NINVRETAP*TX4737/100) , max(0 , MAXDOM3 -INVRET111-INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA-INVRETSTA-INVRETSYA-INVRETTDA-INVRETALA
                                                            -INVRETAQA-INVRETAVA-INVRETBBA-INVRETAKA)) * (1 - V_CNR) ;

INVRETAUA = min(arr(NINVRETAU*TX4737/100) , max(0 , MAXDOM3 -INVRET111-INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA-INVRETSTA-INVRETSYA-INVRETTDA-INVRETALA
                                                            -INVRETAQA-INVRETAVA-INVRETBBA-INVRETAKA-INVRETAPA)) * (1 - V_CNR) ;

INVRETBAA = min(arr(NINVRETBA*TX4737/100) , max(0 , MAXDOM3 -INVRET111-INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA-INVRETSTA-INVRETSYA-INVRETTDA-INVRETALA
                                                            -INVRETAQA-INVRETAVA-INVRETBBA-INVRETAKA-INVRETAPA-INVRETAUA)) * (1 - V_CNR) ;

INVRETAMA = min(NINVRETAM , max(0 , MAXDOM3 -INVRET111-INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA-INVRETSTA-INVRETSYA-INVRETTDA-INVRETALA-INVRETAQA-INVRETAVA
                                            -INVRETBBA-INVRETAKA-INVRETAPA-INVRETAUA-INVRETBAA)) * (1 - V_CNR) ;

INVRETARA = min(NINVRETAR , max(0 , MAXDOM3 -INVRET111-INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA-INVRETSTA-INVRETSYA-INVRETTDA-INVRETALA-INVRETAQA-INVRETAVA
                                            -INVRETBBA-INVRETAKA-INVRETAPA-INVRETAUA-INVRETBAA-INVRETAMA)) * (1 - V_CNR) ;

INVRETAWA = min(NINVRETAW , max(0 , MAXDOM3 -INVRET111-INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA-INVRETSTA-INVRETSYA-INVRETTDA-INVRETALA-INVRETAQA-INVRETAVA
                                            -INVRETBBA-INVRETAKA-INVRETAPA-INVRETAUA-INVRETBAA-INVRETAMA-INVRETARA)) * (1 - V_CNR) ;

INVRETBEA = min(NINVRETBE , max(0 , MAXDOM3 -INVRET111-INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA-INVRETSTA-INVRETSYA-INVRETTDA-INVRETALA-INVRETAQA-INVRETAVA
                                            -INVRETBBA-INVRETAKA-INVRETAPA-INVRETAUA-INVRETBAA-INVRETAMA-INVRETARA-INVRETAWA)) * (1 - V_CNR) ;

INVRETAOA = min(NINVRETAO , max(0 , MAXDOM3 -INVRET111-INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA-INVRETSTA-INVRETSYA-INVRETTDA-INVRETALA-INVRETAQA-INVRETAVA
                                            -INVRETBBA-INVRETAKA-INVRETAPA-INVRETAUA-INVRETBAA-INVRETAMA-INVRETARA-INVRETAWA-INVRETBEA)) * (1 - V_CNR) ;

INVRETATA = min(NINVRETAT , max(0 , MAXDOM3 -INVRET111-INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA-INVRETSTA-INVRETSYA-INVRETTDA-INVRETALA-INVRETAQA-INVRETAVA
                                            -INVRETBBA-INVRETAKA-INVRETAPA-INVRETAUA-INVRETBAA-INVRETAMA-INVRETARA-INVRETAWA-INVRETBEA-INVRETAOA)) * (1 - V_CNR) ;

INVRETAYA = min(NINVRETAY , max(0 , MAXDOM3 -INVRET111-INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA-INVRETSTA-INVRETSYA-INVRETTDA-INVRETALA-INVRETAQA-INVRETAVA
                                            -INVRETBBA-INVRETAKA-INVRETAPA-INVRETAUA-INVRETBAA-INVRETAMA-INVRETARA-INVRETAWA-INVRETBEA-INVRETAOA-INVRETATA)) * (1 - V_CNR) ;

INVRETBGA = min(NINVRETBG , max(0 , MAXDOM3 -INVRET111-INVRETSMA-INVRETSRA-INVRETSWA-INVRETTBA-INVRETSOA-INVRETSTA-INVRETSYA-INVRETTDA-INVRETALA-INVRETAQA-INVRETAVA
                                            -INVRETBBA-INVRETAKA-INVRETAPA-INVRETAUA-INVRETBAA-INVRETAMA-INVRETARA-INVRETAWA-INVRETBEA-INVRETAOA-INVRETATA-INVRETAYA)) * (1 - V_CNR) ;

INVRET112 = INVRETRLA + INVRETRQA + INVRETRVA + INVRETNVA + INVRETRKA + INVRETRPA + INVRETRUA + INVRETNUA + INVRETRMA + INVRETRRA + INVRETRWA + INVRETNWA 
            + INVRETROA + INVRETRTA + INVRETRYA + INVRETNYA + INVRETSLA + INVRETSQA + INVRETSVA + INVRETTAA + INVRETSKA + INVRETSPA + INVRETSUA + INVRETSZA 
            + INVRETSMA + INVRETSRA + INVRETSWA + INVRETTBA + INVRETSOA + INVRETSTA + INVRETSYA + INVRETTDA + INVRETALA + INVRETAQA + INVRETAVA + INVRETBBA 
            + INVRETAKA + INVRETAPA + INVRETAUA + INVRETBAA + INVRETAMA + INVRETARA + INVRETAWA + INVRETBEA + INVRETAOA + INVRETATA + INVRETAYA + INVRETBGA ;

INVRETBTA = min(arr(NINVRETBT*TX375/100) , max(0 , MAXDOM3 -INVRET112)) * (1 - V_CNR) ;

INVRETBYA = min(arr(NINVRETBY*TX375/100) , max(0 , MAXDOM3 -INVRET112-INVRETBTA)) * (1 - V_CNR) ;

INVRETCDA = min(arr(NINVRETCD*TX34/100) , max(0 , MAXDOM3 -INVRET112-INVRETBTA-INVRETBYA)) * (1 - V_CNR) ;

INVRETBSA = min(arr(NINVRETBS*TX4737/100) , max(0 , MAXDOM3 -INVRET112-INVRETBTA-INVRETBYA-INVRETCDA)) * (1 - V_CNR) ;

INVRETBXA = min(arr(NINVRETBX*TX4737/100) , max(0 , MAXDOM3 -INVRET112-INVRETBTA-INVRETBYA-INVRETCDA-INVRETBSA)) * (1 - V_CNR) ;

INVRETCCA = min(arr(NINVRETCC*TX44/100) , max(0 , MAXDOM3 -INVRET112-INVRETBTA-INVRETBYA-INVRETCDA-INVRETBSA-INVRETBXA)) * (1 - V_CNR) ;

INVRETBUA = min(NINVRETBU , max(0 , MAXDOM3 -INVRET112-INVRETBTA-INVRETBYA-INVRETCDA-INVRETBSA-INVRETBXA-INVRETCCA)) * (1 - V_CNR) ;

INVRETBZA = min(NINVRETBZ , max(0 , MAXDOM3 -INVRET112-INVRETBTA-INVRETBYA-INVRETCDA-INVRETBSA-INVRETBXA-INVRETCCA-INVRETBUA)) * (1 - V_CNR) ;

INVRETCEA = min(NINVRETCE , max(0 , MAXDOM3 -INVRET112-INVRETBTA-INVRETBYA-INVRETCDA-INVRETBSA-INVRETBXA-INVRETCCA-INVRETBUA-INVRETBZA)) * (1 - V_CNR) ;

INVRETBWA = min(NINVRETBW , max(0 , MAXDOM3 -INVRET112-INVRETBTA-INVRETBYA-INVRETCDA-INVRETBSA-INVRETBXA-INVRETCCA-INVRETBUA-INVRETBZA-INVRETCEA)) * (1 - V_CNR) ;

INVRETCBA = min(NINVRETCB , max(0 , MAXDOM3 -INVRET112-INVRETBTA-INVRETBYA-INVRETCDA-INVRETBSA-INVRETBXA-INVRETCCA-INVRETBUA-INVRETBZA-INVRETCEA-INVRETBWA)) * (1 - V_CNR) ;

INVRETCGA = min(NINVRETCG , max(0 , MAXDOM3 -INVRET112-INVRETBTA-INVRETBYA-INVRETCDA-INVRETBSA-INVRETBXA-INVRETCCA-INVRETBUA-INVRETBZA-INVRETCEA-INVRETBWA-INVRETCBA)) * (1 - V_CNR) ;

INVRETOTA = min(NINVRETOT , max(0 , MAXDOM3 -INVRET112-INVRETBTA-INVRETBYA-INVRETCDA-INVRETBSA-INVRETBXA-INVRETCCA-INVRETBUA-INVRETBZA-INVRETCEA-INVRETBWA-INVRETCBA-INVRETCGA)) * (1 - V_CNR) ;

INVRETOUA = min(NINVRETOU , max(0 , MAXDOM3 -INVRET112-INVRETBTA-INVRETBYA-INVRETCDA-INVRETBSA-INVRETBXA-INVRETCCA-INVRETBUA-INVRETBZA-INVRETCEA-INVRETBWA-INVRETCBA-INVRETCGA
                                            -INVRETOTA)) * (1 - V_CNR) ;

INVRETOVA = min(NINVRETOV , max(0 , MAXDOM3 -INVRET112-INVRETBTA-INVRETBYA-INVRETCDA-INVRETBSA-INVRETBXA-INVRETCCA-INVRETBUA-INVRETBZA-INVRETCEA-INVRETBWA-INVRETCBA-INVRETCGA
                                            -INVRETOTA-INVRETOUA)) * (1 - V_CNR) ;

INVRETOWA = min(NINVRETOW , max(0 , MAXDOM3 -INVRET112-INVRETBTA-INVRETBYA-INVRETCDA-INVRETBSA-INVRETBXA-INVRETCCA-INVRETBUA-INVRETBZA-INVRETCEA-INVRETBWA-INVRETCBA-INVRETCGA
                                            -INVRETOTA-INVRETOUA-INVRETOVA)) * (1 - V_CNR) ;

INVRETOGA = min(NINVRETOG , max(0 , MAXDOM3 -INVRET112-INVRETBTA-INVRETBYA-INVRETCDA-INVRETBSA-INVRETBXA-INVRETCCA-INVRETBUA-INVRETBZA-INVRETCEA-INVRETBWA-INVRETCBA-INVRETCGA
                                            -INVRETOTA-INVRETOUA-INVRETOVA-INVRETOWA)) * (1 - V_CNR) ;

INVRETOXA = min(NINVRETOX , max(0 , MAXDOM3 -INVRET112-INVRETBTA-INVRETBYA-INVRETCDA-INVRETBSA-INVRETBXA-INVRETCCA-INVRETBUA-INVRETBZA-INVRETCEA-INVRETBWA-INVRETCBA-INVRETCGA
                                            -INVRETOTA-INVRETOUA-INVRETOVA-INVRETOWA-INVRETOGA)) * (1 - V_CNR) ;

INVRETOYA = min(NINVRETOY , max(0 , MAXDOM3 -INVRET112-INVRETBTA-INVRETBYA-INVRETCDA-INVRETBSA-INVRETBXA-INVRETCCA-INVRETBUA-INVRETBZA-INVRETCEA-INVRETBWA-INVRETCBA-INVRETCGA
                                            -INVRETOTA-INVRETOUA-INVRETOVA-INVRETOWA-INVRETOGA-INVRETOXA)) * (1 - V_CNR) ;

INVRETOZA = min(NINVRETOZ , max(0 , MAXDOM3 -INVRET112-INVRETBTA-INVRETBYA-INVRETCDA-INVRETBSA-INVRETBXA-INVRETCCA-INVRETBUA-INVRETBZA-INVRETCEA-INVRETBWA-INVRETCBA-INVRETCGA
                                            -INVRETOTA-INVRETOUA-INVRETOVA-INVRETOWA-INVRETOGA-INVRETOXA-INVRETOYA)) * (1 - V_CNR) ;

INVRETUDA = min(NINVRETUD , max(0 , MAXDOM3 -INVRET112-INVRETBTA-INVRETBYA-INVRETCDA-INVRETBSA-INVRETBXA-INVRETCCA-INVRETBUA-INVRETBZA-INVRETCEA-INVRETBWA-INVRETCBA-INVRETCGA
                                            -INVRETOTA-INVRETOUA-INVRETOVA-INVRETOWA-INVRETOGA-INVRETOXA-INVRETOYA-INVRETOZA)) * (1 - V_CNR) ;

INVRETUEA = min(NINVRETUE , max(0 , MAXDOM3 -INVRET112-INVRETBTA-INVRETBYA-INVRETCDA-INVRETBSA-INVRETBXA-INVRETCCA-INVRETBUA-INVRETBZA-INVRETCEA-INVRETBWA-INVRETCBA-INVRETCGA
                                            -INVRETOTA-INVRETOUA-INVRETOVA-INVRETOWA-INVRETOGA-INVRETOXA-INVRETOYA-INVRETOZA-INVRETUDA)) * (1 - V_CNR) ;

INVRETUFA = min(NINVRETUF , max(0 , MAXDOM3 -INVRET112-INVRETBTA-INVRETBYA-INVRETCDA-INVRETBSA-INVRETBXA-INVRETCCA-INVRETBUA-INVRETBZA-INVRETCEA-INVRETBWA-INVRETCBA-INVRETCGA
                                            -INVRETOTA-INVRETOUA-INVRETOVA-INVRETOWA-INVRETOGA-INVRETOXA-INVRETOYA-INVRETOZA-INVRETUDA-INVRETUEA)) * (1 - V_CNR) ;

INVRETUGA = min(NINVRETUG , max(0 , MAXDOM3 -INVRET112-INVRETBTA-INVRETBYA-INVRETCDA-INVRETBSA-INVRETBXA-INVRETCCA-INVRETBUA-INVRETBZA-INVRETCEA-INVRETBWA-INVRETCBA-INVRETCGA
                                            -INVRETOTA-INVRETOUA-INVRETOVA-INVRETOWA-INVRETOGA-INVRETOXA-INVRETOYA-INVRETOZA-INVRETUDA-INVRETUEA-INVRETUFA)) * (1 - V_CNR) ;

INVRETUKA = min(NINVRETUK , max(0 , MAXDOM3 -INVRET112-INVRETBTA-INVRETBYA-INVRETCDA-INVRETBSA-INVRETBXA-INVRETCCA-INVRETBUA-INVRETBZA-INVRETCEA-INVRETBWA-INVRETCBA-INVRETCGA
                                            -INVRETOTA-INVRETOUA-INVRETOVA-INVRETOWA-INVRETOGA-INVRETOXA-INVRETOYA-INVRETOZA-INVRETUDA-INVRETUEA-INVRETUFA-INVRETUGA)) * (1 - V_CNR) ;

INVRETULA = min(NINVRETUL , max(0 , MAXDOM3 -INVRET112-INVRETBTA-INVRETBYA-INVRETCDA-INVRETBSA-INVRETBXA-INVRETCCA-INVRETBUA-INVRETBZA-INVRETCEA-INVRETBWA-INVRETCBA-INVRETCGA
                                            -INVRETOTA-INVRETOUA-INVRETOVA-INVRETOWA-INVRETOGA-INVRETOXA-INVRETOYA-INVRETOZA-INVRETUDA-INVRETUEA-INVRETUFA-INVRETUGA-INVRETUKA)) * (1 - V_CNR) ;

INVRETUMA = min(NINVRETUM , max(0 , MAXDOM3 -INVRET112-INVRETBTA-INVRETBYA-INVRETCDA-INVRETBSA-INVRETBXA-INVRETCCA-INVRETBUA-INVRETBZA-INVRETCEA-INVRETBWA-INVRETCBA-INVRETCGA
                                            -INVRETOTA-INVRETOUA-INVRETOVA-INVRETOWA-INVRETOGA-INVRETOXA-INVRETOYA-INVRETOZA-INVRETUDA-INVRETUEA-INVRETUFA-INVRETUGA-INVRETUKA
                                            -INVRETULA)) * (1 - V_CNR) ;

INVRETUNA = min(NINVRETUN , max(0 , MAXDOM3 -INVRET112-INVRETBTA-INVRETBYA-INVRETCDA-INVRETBSA-INVRETBXA-INVRETCCA-INVRETBUA-INVRETBZA-INVRETCEA-INVRETBWA-INVRETCBA-INVRETCGA
                                            -INVRETOTA-INVRETOUA-INVRETOVA-INVRETOWA-INVRETOGA-INVRETOXA-INVRETOYA-INVRETOZA-INVRETUDA-INVRETUEA-INVRETUFA-INVRETUGA-INVRETUKA
                                            -INVRETULA-INVRETUMA)) * (1 - V_CNR) ;

INVRET11A = INVRETRLA + INVRETRQA + INVRETRVA + INVRETNVA + INVRETRKA + INVRETRPA + INVRETRUA + INVRETNUA + INVRETRMA + INVRETRRA + INVRETRWA + INVRETNWA + INVRETROA 
            + INVRETRTA + INVRETRYA + INVRETNYA + INVRETSLA + INVRETSQA + INVRETSVA + INVRETTAA + INVRETSKA + INVRETSPA + INVRETSUA + INVRETSZA + INVRETSMA + INVRETSRA 
            + INVRETSWA + INVRETTBA + INVRETSOA + INVRETSTA + INVRETSYA + INVRETTDA + INVRETALA + INVRETAQA + INVRETAVA + INVRETBBA + INVRETAKA + INVRETAPA + INVRETAUA 
            + INVRETBAA + INVRETAMA + INVRETARA + INVRETAWA + INVRETBEA + INVRETAOA + INVRETATA + INVRETAYA + INVRETBGA + INVRETBTA + INVRETBYA + INVRETCDA + INVRETBSA 
            + INVRETBXA + INVRETCCA + INVRETBUA + INVRETBZA + INVRETCEA + INVRETBWA + INVRETCBA + INVRETCGA + INVRETOTA + INVRETOUA + INVRETOVA + INVRETOWA + INVRETOGA 
            + INVRETOXA + INVRETOYA + INVRETOZA + INVRETUDA + INVRETUEA + INVRETUFA + INVRETUGA + INVRETUKA + INVRETULA + INVRETUMA + INVRETUNA ;

INVRETRLRA = min(NINVRETRLR , max(0 , MAXDOM3 -INVRET11A)) * (1 - V_CNR) ;

INVRETRQRA = min(NINVRETRQR , max(0 , MAXDOM3 -INVRET11A-INVRETRLRA)) * (1 - V_CNR) ;

INVRETRVRA = min(NINVRETRVR , max(0 , MAXDOM3 -INVRET11A-INVRETRLRA-INVRETRQRA)) * (1 - V_CNR) ;

INVRETNVRA = min(NINVRETNVR , max(0 , MAXDOM3 -INVRET11A-INVRETRLRA-INVRETRQRA-INVRETRVRA)) * (1 - V_CNR) ;

INVRETRKRA = min(NINVRETRKR , max(0 , MAXDOM3 -INVRET11A-INVRETRLRA-INVRETRQRA-INVRETRVRA-INVRETNVRA)) * (1 - V_CNR) ;

INVRETRPRA = min(NINVRETRPR , max(0 , MAXDOM3 -INVRET11A-INVRETRLRA-INVRETRQRA-INVRETRVRA-INVRETNVRA-INVRETRKRA)) * (1 - V_CNR) ;

INVRETRURA = min(NINVRETRUR , max(0 , MAXDOM3 -INVRET11A-INVRETRLRA-INVRETRQRA-INVRETRVRA-INVRETNVRA-INVRETRKRA-INVRETRPRA)) * (1 - V_CNR) ;

INVRETNURA = min(NINVRETNUR , max(0 , MAXDOM3 -INVRET11A-INVRETRLRA-INVRETRQRA-INVRETRVRA-INVRETNVRA-INVRETRKRA-INVRETRPRA-INVRETRURA)) * (1 - V_CNR) ;

INVRETSLRA = min(NINVRETSLR , max(0 , MAXDOM3 -INVRET11A-INVRETRLRA-INVRETRQRA-INVRETRVRA-INVRETNVRA-INVRETRKRA-INVRETRPRA-INVRETRURA-INVRETNURA)) * (1 - V_CNR) ;

INVRETSQRA = min(NINVRETSQR , max(0 , MAXDOM3 -INVRET11A-INVRETRLRA-INVRETRQRA-INVRETRVRA-INVRETNVRA-INVRETRKRA-INVRETRPRA-INVRETRURA-INVRETNURA-INVRETSLRA)) * (1 - V_CNR) ;

INVRETSVRA = min(NINVRETSVR , max(0 , MAXDOM3 -INVRET11A-INVRETRLRA-INVRETRQRA-INVRETRVRA-INVRETNVRA-INVRETRKRA-INVRETRPRA-INVRETRURA-INVRETNURA-INVRETSLRA-INVRETSQRA)) * (1 - V_CNR) ;

INVRETTARA = min(NINVRETTAR , max(0 , MAXDOM3 -INVRET11A-INVRETRLRA-INVRETRQRA-INVRETRVRA-INVRETNVRA-INVRETRKRA-INVRETRPRA-INVRETRURA-INVRETNURA-INVRETSLRA-INVRETSQRA
                                              -INVRETSVRA)) * (1 - V_CNR) ;

INVRETSKRA = min(NINVRETSKR , max(0 , MAXDOM3 -INVRET11A-INVRETRLRA-INVRETRQRA-INVRETRVRA-INVRETNVRA-INVRETRKRA-INVRETRPRA-INVRETRURA-INVRETNURA-INVRETSLRA-INVRETSQRA
                                              -INVRETSVRA-INVRETTARA)) * (1 - V_CNR) ;

INVRETSPRA = min(NINVRETSPR , max(0 , MAXDOM3 -INVRET11A-INVRETRLRA-INVRETRQRA-INVRETRVRA-INVRETNVRA-INVRETRKRA-INVRETRPRA-INVRETRURA-INVRETNURA-INVRETSLRA-INVRETSQRA
                                              -INVRETSVRA-INVRETTARA-INVRETSKRA)) * (1 - V_CNR) ;

INVRETSURA = min(NINVRETSUR , max(0 , MAXDOM3 -INVRET11A-INVRETRLRA-INVRETRQRA-INVRETRVRA-INVRETNVRA-INVRETRKRA-INVRETRPRA-INVRETRURA-INVRETNURA-INVRETSLRA-INVRETSQRA
                                              -INVRETSVRA-INVRETTARA-INVRETSKRA-INVRETSPRA)) * (1 - V_CNR) ;
                                                                            
INVRETSZRA = min(NINVRETSZR , max(0 , MAXDOM3 -INVRET11A-INVRETRLRA-INVRETRQRA-INVRETRVRA-INVRETNVRA-INVRETRKRA-INVRETRPRA-INVRETRURA-INVRETNURA-INVRETSLRA-INVRETSQRA
                                              -INVRETSVRA-INVRETTARA-INVRETSKRA-INVRETSPRA-INVRETSURA)) * (1 - V_CNR) ;

INVRETALRA = min(NINVRETALR , max(0 , MAXDOM3 -INVRET11A-INVRETRLRA-INVRETRQRA-INVRETRVRA-INVRETNVRA-INVRETRKRA-INVRETRPRA-INVRETRURA-INVRETNURA-INVRETSLRA-INVRETSQRA
                                              -INVRETSVRA-INVRETTARA-INVRETSKRA-INVRETSPRA-INVRETSURA-INVRETSZRA)) * (1 - V_CNR) ;

INVRETAQRA = min(NINVRETAQR , max(0 , MAXDOM3 -INVRET11A-INVRETRLRA-INVRETRQRA-INVRETRVRA-INVRETNVRA-INVRETRKRA-INVRETRPRA-INVRETRURA-INVRETNURA-INVRETSLRA-INVRETSQRA
                                              -INVRETSVRA-INVRETTARA-INVRETSKRA-INVRETSPRA-INVRETSURA-INVRETSZRA-INVRETALRA)) * (1 - V_CNR) ;

INVRETAVRA = min(NINVRETAVR , max(0 , MAXDOM3 -INVRET11A-INVRETRLRA-INVRETRQRA-INVRETRVRA-INVRETNVRA-INVRETRKRA-INVRETRPRA-INVRETRURA-INVRETNURA-INVRETSLRA-INVRETSQRA
                                              -INVRETSVRA-INVRETTARA-INVRETSKRA-INVRETSPRA-INVRETSURA-INVRETSZRA-INVRETALRA-INVRETAQRA)) * (1 - V_CNR) ;

INVRETBBRA = min(NINVRETBBR , max(0 , MAXDOM3 -INVRET11A-INVRETRLRA-INVRETRQRA-INVRETRVRA-INVRETNVRA-INVRETRKRA-INVRETRPRA-INVRETRURA-INVRETNURA-INVRETSLRA-INVRETSQRA
                                              -INVRETSVRA-INVRETTARA-INVRETSKRA-INVRETSPRA-INVRETSURA-INVRETSZRA-INVRETALRA-INVRETAQRA-INVRETAVRA)) * (1 - V_CNR) ;

INVRETAKRA = min(NINVRETAKR , max(0 , MAXDOM3 -INVRET11A-INVRETRLRA-INVRETRQRA-INVRETRVRA-INVRETNVRA-INVRETRKRA-INVRETRPRA-INVRETRURA-INVRETNURA-INVRETSLRA-INVRETSQRA
                                              -INVRETSVRA-INVRETTARA-INVRETSKRA-INVRETSPRA-INVRETSURA-INVRETSZRA-INVRETALRA-INVRETAQRA-INVRETAVRA-INVRETBBRA)) * (1 - V_CNR) ;

INVRETAPRA = min(NINVRETAPR , max(0 , MAXDOM3 -INVRET11A-INVRETRLRA-INVRETRQRA-INVRETRVRA-INVRETNVRA-INVRETRKRA-INVRETRPRA-INVRETRURA-INVRETNURA-INVRETSLRA-INVRETSQRA
                                              -INVRETSVRA-INVRETTARA-INVRETSKRA-INVRETSPRA-INVRETSURA-INVRETSZRA-INVRETALRA-INVRETAQRA-INVRETAVRA-INVRETBBRA-INVRETAKRA)) * (1 - V_CNR) ;

INVRETAURA = min(NINVRETAUR , max(0 , MAXDOM3 -INVRET11A-INVRETRLRA-INVRETRQRA-INVRETRVRA-INVRETNVRA-INVRETRKRA-INVRETRPRA-INVRETRURA-INVRETNURA-INVRETSLRA-INVRETSQRA
                                              -INVRETSVRA-INVRETTARA-INVRETSKRA-INVRETSPRA-INVRETSURA-INVRETSZRA-INVRETALRA-INVRETAQRA-INVRETAVRA-INVRETBBRA-INVRETAKRA
                                              -INVRETAPRA)) * (1 - V_CNR) ;

INVRETBARA = min(NINVRETBAR , max(0 , MAXDOM3 -INVRET11A-INVRETRLRA-INVRETRQRA-INVRETRVRA-INVRETNVRA-INVRETRKRA-INVRETRPRA-INVRETRURA-INVRETNURA-INVRETSLRA-INVRETSQRA
                                              -INVRETSVRA-INVRETTARA-INVRETSKRA-INVRETSPRA-INVRETSURA-INVRETSZRA-INVRETALRA-INVRETAQRA-INVRETAVRA-INVRETBBRA-INVRETAKRA
                                              -INVRETAPRA-INVRETAURA)) * (1 - V_CNR) ;

INVRETBTRA = min(NINVRETBTR , max(0 , MAXDOM3 -INVRET11A-INVRETRLRA-INVRETRQRA-INVRETRVRA-INVRETNVRA-INVRETRKRA-INVRETRPRA-INVRETRURA-INVRETNURA-INVRETSLRA-INVRETSQRA
                                              -INVRETSVRA-INVRETTARA-INVRETSKRA-INVRETSPRA-INVRETSURA-INVRETSZRA-INVRETALRA-INVRETAQRA-INVRETAVRA-INVRETBBRA-INVRETAKRA
                                              -INVRETAPRA-INVRETAURA-INVRETBARA)) * (1 - V_CNR) ;

INVRETBYRA = min(NINVRETBYR , max(0 , MAXDOM3 -INVRET11A-INVRETRLRA-INVRETRQRA-INVRETRVRA-INVRETNVRA-INVRETRKRA-INVRETRPRA-INVRETRURA-INVRETNURA-INVRETSLRA-INVRETSQRA
                                              -INVRETSVRA-INVRETTARA-INVRETSKRA-INVRETSPRA-INVRETSURA-INVRETSZRA-INVRETALRA-INVRETAQRA-INVRETAVRA-INVRETBBRA-INVRETAKRA
                                              -INVRETAPRA-INVRETAURA-INVRETBARA-INVRETBTRA)) * (1 - V_CNR) ;

INVRETCDRA = min(NINVRETCDR , max(0 , MAXDOM3 -INVRET11A-INVRETRLRA-INVRETRQRA-INVRETRVRA-INVRETNVRA-INVRETRKRA-INVRETRPRA-INVRETRURA-INVRETNURA-INVRETSLRA-INVRETSQRA
                                              -INVRETSVRA-INVRETTARA-INVRETSKRA-INVRETSPRA-INVRETSURA-INVRETSZRA-INVRETALRA-INVRETAQRA-INVRETAVRA-INVRETBBRA-INVRETAKRA
                                              -INVRETAPRA-INVRETAURA-INVRETBARA-INVRETBTRA-INVRETBYRA)) * (1 - V_CNR) ;

INVRETBSRA = min(NINVRETBSR , max(0 , MAXDOM3 -INVRET11A-INVRETRLRA-INVRETRQRA-INVRETRVRA-INVRETNVRA-INVRETRKRA-INVRETRPRA-INVRETRURA-INVRETNURA-INVRETSLRA-INVRETSQRA
                                              -INVRETSVRA-INVRETTARA-INVRETSKRA-INVRETSPRA-INVRETSURA-INVRETSZRA-INVRETALRA-INVRETAQRA-INVRETAVRA-INVRETBBRA-INVRETAKRA
                                              -INVRETAPRA-INVRETAURA-INVRETBARA-INVRETBTRA-INVRETBYRA-INVRETCDRA)) * (1 - V_CNR) ;

INVRETBXRA = min(NINVRETBXR , max(0 , MAXDOM3 -INVRET11A-INVRETRLRA-INVRETRQRA-INVRETRVRA-INVRETNVRA-INVRETRKRA-INVRETRPRA-INVRETRURA-INVRETNURA-INVRETSLRA-INVRETSQRA
                                              -INVRETSVRA-INVRETTARA-INVRETSKRA-INVRETSPRA-INVRETSURA-INVRETSZRA-INVRETALRA-INVRETAQRA-INVRETAVRA-INVRETBBRA-INVRETAKRA
                                              -INVRETAPRA-INVRETAURA-INVRETBARA-INVRETBTRA-INVRETBYRA-INVRETCDRA-INVRETBSRA)) * (1 - V_CNR) ;

INVRETCCRA = min(NINVRETCCR , max(0 , MAXDOM3 -INVRET11A-INVRETRLRA-INVRETRQRA-INVRETRVRA-INVRETNVRA-INVRETRKRA-INVRETRPRA-INVRETRURA-INVRETNURA-INVRETSLRA-INVRETSQRA
                                              -INVRETSVRA-INVRETTARA-INVRETSKRA-INVRETSPRA-INVRETSURA-INVRETSZRA-INVRETALRA-INVRETAQRA-INVRETAVRA-INVRETBBRA-INVRETAKRA
                                              -INVRETAPRA-INVRETAURA-INVRETBARA-INVRETBTRA-INVRETBYRA-INVRETCDRA-INVRETBSRA-INVRETBXRA)) * (1 - V_CNR) ;

TOTALPLAFC = INVRETRLA + INVRETRQA + INVRETRVA + INVRETNVA + INVRETRKA + INVRETRPA + INVRETRUA + INVRETNUA + INVRETRMA + INVRETRRA + INVRETRWA + INVRETNWA 
             + INVRETROA + INVRETRTA + INVRETRYA + INVRETNYA + INVRETSLA + INVRETSQA + INVRETSVA + INVRETTAA + INVRETSKA + INVRETSPA + INVRETSUA + INVRETSZA
             + INVRETSMA + INVRETSRA + INVRETSWA + INVRETTBA + INVRETSOA + INVRETSTA + INVRETSYA + INVRETTDA + INVRETALA + INVRETAQA + INVRETAVA + INVRETBBA 
             + INVRETAKA + INVRETAPA + INVRETAUA + INVRETBAA + INVRETAMA + INVRETARA + INVRETAWA + INVRETBEA + INVRETAOA + INVRETATA + INVRETAYA + INVRETBGA
             + INVRETBTA + INVRETBYA + INVRETCDA + INVRETBSA + INVRETBXA + INVRETCCA + INVRETBUA + INVRETBZA + INVRETCEA + INVRETBWA + INVRETCBA + INVRETCGA
             + INVRETOTA + INVRETOUA + INVRETOVA + INVRETOWA + INVRETOGA + INVRETOXA + INVRETOYA + INVRETOZA + INVRETUDA + INVRETUEA + INVRETUFA + INVRETUGA 
             + INVRETUKA + INVRETULA + INVRETUMA + INVRETUNA
             + INVRETRLRA + INVRETRQRA + INVRETRVRA + INVRETNVRA + INVRETRKRA + INVRETRPRA + INVRETRURA + INVRETNURA + INVRETSLRA + INVRETSQRA + INVRETSVRA 
             + INVRETTARA + INVRETSKRA + INVRETSPRA + INVRETSURA + INVRETSZRA + INVRETALRA + INVRETAQRA + INVRETAVRA + INVRETBBRA + INVRETAKRA + INVRETAPRA 
             + INVRETAURA + INVRETBARA + INVRETBTRA + INVRETBYRA + INVRETCDRA + INVRETBSRA + INVRETBXRA + INVRETCCRA ;

INDPLAF = positif(TOTALPLAFA + TOTALPLAFB + TOTALPLAFC - TOTALPLAF1 - TOTALPLAF2 - TOTALPLAF3) * positif(INDPLAF1 + INDPLAF2 + INDPLAF3) * positif(OPTPLAF15) ;


ALOGDOM_1 = (INVLOG2008 + INVLGDEB2009 + INVLGDEB + INVOMLOGOA + INVOMLOGOH + INVOMLOGOL + INVOMLOGOO + INVOMLOGOS
                      + (INVRETQL + INVRETQM + INVRETQD + INVRETOB + INVRETOC + INVRETOM + INVRETON + INVRETOI + INVRETOJ + INVRETOK + INVRETOP 
			 + INVRETOQ + INVRETOR + INVRETOT + INVRETOU + INVRETOV + INVRETOW + INVRETOD + INVRETOE + INVRETOF + INVRETOG
                         + INVRETOX + INVRETOY + INVRETOZ + INVRETUA + INVRETUB + INVRETUC + INVRETUD + INVRETUE + INVRETUF + INVRETUG
                         + INVRETUH + INVRETUI + INVRETUJ + INVRETUK + INVRETUL + INVRETUM + INVRETUN) * (1 - INDPLAF)
		      + (INVRETQLA + INVRETQMA + INVRETQDA + INVRETOBA + INVRETOCA + INVRETOMA + INVRETONA + INVRETOIA + INVRETOJA + INVRETOKA 
			 + INVRETOPA + INVRETOQA + INVRETORA + INVRETOTA + INVRETOUA + INVRETOVA + INVRETOWA + INVRETODA + INVRETOEA + INVRETOFA + INVRETOGA
                         + INVRETOXA + INVRETOYA + INVRETOZA + INVRETUAA + INVRETUBA + INVRETUCA + INVRETUDA + INVRETUEA + INVRETUFA + INVRETUGA
                         + INVRETUHA + INVRETUIA + INVRETUJA + INVRETUKA + INVRETULA + INVRETUMA + INVRETUNA) * INDPLAF)
	     * (1 - V_CNR) ;

ALOGDOM = ALOGDOM_1 * (1 - ART1731BIS) 
           + min( ALOGDOM_1 , ALOGDOM_2 ) * ART1731BIS ;

ALOGSOC_1 = ((INVRETXF + INVRETXG + INVRETXH + INVRETXI + INVRETXK + INVRETXFR + INVRETXGR + INVRETXHR + INVRETXIR + INVRETXKR) * (1 - INDPLAF) 
	    + (INVRETXFA + INVRETXGA + INVRETXHA + INVRETXIA + INVRETXKA + INVRETXFRA + INVRETXGRA + INVRETXHRA + INVRETXIRA + INVRETXKRA) * INDPLAF) 
             * (1 - V_CNR) ;

ALOGSOC = ALOGSOC_1 * (1 - ART1731BIS) 
           + min(ALOGSOC_1 , ALOGSOC_2) * ART1731BIS ;

ADOMSOC1_1 = ((INVRETKH + INVRETKI + INVRETQN + INVRETQU + INVRETQK + INVRETQJ + INVRETQS + INVRETQW + INVRETQX 
               + INVRETRA + INVRETRB + INVRETRC + INVRETRD + INVRETXA + INVRETXB + INVRETXC + INVRETXE
               + INVRETKHR + INVRETKIR + INVRETQNR + INVRETQUR + INVRETQKR + INVRETQJR + INVRETQSR + INVRETQWR + INVRETQXR
               + INVRETRAR + INVRETRBR + INVRETRCR + INVRETRDR + INVRETXAR + INVRETXBR + INVRETXCR + INVRETXER) * (1 - INDPLAF) 
	     + (INVRETKHA + INVRETKIA + INVRETQNA + INVRETQUA + INVRETQKA + INVRETQJA + INVRETQSA + INVRETQWA + INVRETQXA
                + INVRETRAA + INVRETRBA + INVRETRCA + INVRETRDA + INVRETXAA + INVRETXBA + INVRETXCA + INVRETXEA
                + INVRETKHRA + INVRETKIRA + INVRETQNRA + INVRETQURA + INVRETQKRA + INVRETQJRA + INVRETQSRA + INVRETQWRA + INVRETQXRA
                + INVRETRARA + INVRETRBRA + INVRETRCRA + INVRETRDRA + INVRETXARA + INVRETXBRA + INVRETXCRA + INVRETXERA) * INDPLAF) 
              * (1 - V_CNR) ;

ADOMSOC1 = (ADOMSOC1_1 * (1 - ART1731BIS) 
            + min(ADOMSOC1_1 , ADOMSOC1_2) * ART1731BIS 
           );

ALOCENT_1 = ((INVRETBJ + INVRETBO + INVRETBT + INVRETBY + INVRETCD + INVRETBI + INVRETBN + INVRETBS + INVRETBX + INVRETCC 
              + INVRETBK + INVRETBP + INVRETBU + INVRETBZ + INVRETCE + INVRETBM + INVRETBR + INVRETBW + INVRETCB + INVRETCG  
              + INVRETBJR + INVRETBOR + INVRETBTR + INVRETBYR + INVRETCDR + INVRETBIR + INVRETBNR + INVRETBSR + INVRETBXR + INVRETCCR) * (1 - INDPLAF)
            + (INVRETBJA + INVRETBOA + INVRETBTA + INVRETBYA + INVRETCDA + INVRETBIA + INVRETBNA + INVRETBSA + INVRETBXA + INVRETCCA
              + INVRETBKA + INVRETBPA + INVRETBUA + INVRETBZA + INVRETCEA + INVRETBMA + INVRETBRA + INVRETBWA + INVRETCBA + INVRETCGA
              + INVRETBJRA + INVRETBORA + INVRETBTRA + INVRETBYRA + INVRETCDRA + INVRETBIRA + INVRETBNRA + INVRETBSRA + INVRETBXRA + INVRETCCRA) * INDPLAF)
            * (1 - V_CNR) ;

ALOCENT = (ALOCENT_1 * (1 - ART1731BIS) 
           + min(ALOCENT_1 , ALOCENT_2) * ART1731BIS 
          );

ACOLENT_1 = (INVOMENTMN + INVENDEB2009 + INVOMQV + INVOMRETPM + INVOMENTRJ
		 + (INVRETMB + INVRETLH + INVRETMC + INVRETLI + INVRETQP + INVRETQG + INVRETPB + INVRETPF + INVRETPJ + INVRETQO + INVRETQF 
                    + INVRETPA + INVRETPE + INVRETPI + INVRETKT + INVRETKU + INVRETQR + INVRETQI + INVRETPD + INVRETPH + INVRETPL + INVRETPO + INVRETPT 
                    + INVRETPY + INVRETRL + INVRETRQ + INVRETRV + INVRETNV + INVRETPN + INVRETPS + INVRETPX + INVRETRK + INVRETRP + INVRETRU + INVRETNU + INVRETPP 
                    + INVRETPU + INVRETRG + INVRETRM + INVRETRR + INVRETRW + INVRETNW + INVRETPR + INVRETPW + INVRETRI + INVRETRO + INVRETRT + INVRETRY + INVRETNY
                    + INVRETSB + INVRETSG + INVRETSA + INVRETSF + INVRETSC + INVRETSH + INVRETSE + INVRETSJ + INVRETSL + INVRETSQ + INVRETSV + INVRETTA + INVRETSK
                    + INVRETSP + INVRETSU + INVRETSZ + INVRETSM + INVRETSR + INVRETSW + INVRETTB + INVRETSO + INVRETST + INVRETSY + INVRETTD + INVRETAB + INVRETAG 
                    + INVRETAA + INVRETAF + INVRETAC + INVRETAH + INVRETAE + INVRETAJ + INVRETAL + INVRETAQ + INVRETAV + INVRETBB + INVRETAK + INVRETAP + INVRETAU 
                    + INVRETBA + INVRETAM + INVRETAR + INVRETAW + INVRETBE + INVRETAO + INVRETAT + INVRETAY + INVRETBG
                    + INVRETMBR + INVRETLHR + INVRETMCR + INVRETLIR + INVRETQPR + INVRETQGR + INVRETPBR + INVRETPFR + INVRETPJR + INVRETQOR 
                    + INVRETQFR + INVRETPAR + INVRETPER + INVRETPIR + INVRETPOR + INVRETPTR + INVRETPYR + INVRETRLR + INVRETRQR + INVRETRVR + INVRETNVR + INVRETPNR 
                    + INVRETPSR + INVRETPXR + INVRETRKR + INVRETRPR + INVRETRUR + INVRETNUR + INVRETSBR + INVRETSGR + INVRETSAR + INVRETSFR + INVRETSLR + INVRETSQR 
                    + INVRETSVR + INVRETTAR + INVRETSKR + INVRETSPR + INVRETSUR + INVRETSZR + INVRETABR + INVRETAGR + INVRETAAR + INVRETAFR + INVRETALR + INVRETAQR 
                    + INVRETAVR + INVRETBBR + INVRETAKR + INVRETAPR + INVRETAUR + INVRETBAR) * (1 - INDPLAF) 
		 + (INVRETMBA + INVRETLHA + INVRETMCA + INVRETLIA + INVRETQPA + INVRETQGA + INVRETPBA + INVRETPFA + INVRETPJA + INVRETQOA + INVRETQFA
                    + INVRETPAA + INVRETPEA + INVRETPIA + INVRETKTA + INVRETKUA + INVRETQRA + INVRETQIA + INVRETPDA + INVRETPHA + INVRETPLA + INVRETPOA + INVRETPTA
                    + INVRETPYA + INVRETRLA + INVRETRQA + INVRETRVA + INVRETNVA + INVRETPNA + INVRETPSA + INVRETPXA + INVRETRKA + INVRETRPA + INVRETRUA + INVRETNUA + INVRETPPA
                    + INVRETPUA + INVRETRGA + INVRETRMA + INVRETRRA + INVRETRWA + INVRETNWA + INVRETPRA + INVRETPWA + INVRETRIA + INVRETROA + INVRETRTA + INVRETRYA + INVRETNYA
                    + INVRETSBA + INVRETSGA + INVRETSAA + INVRETSFA + INVRETSCA + INVRETSHA + INVRETSEA + INVRETSJA + INVRETSLA + INVRETSQA + INVRETSVA + INVRETTAA + INVRETSKA
                    + INVRETSPA + INVRETSUA + INVRETSZA + INVRETSMA + INVRETSRA + INVRETSWA + INVRETTBA + INVRETSOA + INVRETSTA + INVRETSYA + INVRETTDA + INVRETABA + INVRETAGA 
                    + INVRETAAA + INVRETAFA + INVRETACA + INVRETAHA + INVRETAEA + INVRETAJA + INVRETALA + INVRETAQA + INVRETAVA + INVRETBBA + INVRETAKA + INVRETAPA + INVRETAUA 
                    + INVRETBAA + INVRETAMA + INVRETARA + INVRETAWA + INVRETBEA + INVRETAOA + INVRETATA + INVRETAYA + INVRETBGA
                    + INVRETMBRA + INVRETLHRA + INVRETMCRA + INVRETLIRA + INVRETQPRA + INVRETQGRA + INVRETPBRA + INVRETPFRA + INVRETPJRA + INVRETQORA
                    + INVRETQFRA + INVRETPARA + INVRETPERA + INVRETPIRA + INVRETPORA + INVRETPTRA + INVRETPYRA + INVRETRLRA + INVRETRQRA + INVRETRVRA + INVRETNVRA + INVRETPNRA
                    + INVRETPSRA + INVRETPXRA + INVRETRKRA + INVRETRPRA + INVRETRURA + INVRETNURA + INVRETSBRA + INVRETSGRA + INVRETSARA + INVRETSFRA + INVRETSLRA + INVRETSQRA 
                    + INVRETSVRA + INVRETTARA + INVRETSKRA + INVRETSPRA + INVRETSURA + INVRETSZRA + INVRETABRA + INVRETAGRA + INVRETAARA + INVRETAFRA + INVRETALRA + INVRETAQRA 
                    + INVRETAVRA + INVRETBBRA + INVRETAKRA + INVRETAPRA + INVRETAURA + INVRETBARA) * INDPLAF) 
	   * (1 - V_CNR) ;

ACOLENT = (ACOLENT_1 * (1 - ART1731BIS) 
           + min(ACOLENT_1 , ACOLENT_2) * ART1731BIS 
          ) ;         

regle 402030:
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

NINVRETUA = max(min(CODHUA , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB-INVOMLOGOA-INVOMLOGOH-INVOMLOGOL-INVOMLOGOO-INVOMLOGOS-NINVRETQL-NINVRETQM
				 -NINVRETQD-NINVRETOB-NINVRETOC-NINVRETOI-NINVRETOJ-NINVRETOK-NINVRETOM-NINVRETON-NINVRETOP-NINVRETOQ-NINVRETOR
				 -NINVRETOT-NINVRETOU-NINVRETOV-NINVRETOW-NINVRETOD-NINVRETOE-NINVRETOF-NINVRETOG-NINVRETOX-NINVRETOY-NINVRETOZ) , 0) * (1 - V_CNR) ;

NINVRETUB = max(min(CODHUB , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB-INVOMLOGOA-INVOMLOGOH-INVOMLOGOL-INVOMLOGOO-INVOMLOGOS-NINVRETQL-NINVRETQM
				 -NINVRETQD-NINVRETOB-NINVRETOC-NINVRETOI-NINVRETOJ-NINVRETOK-NINVRETOM-NINVRETON-NINVRETOP-NINVRETOQ-NINVRETOR
				 -NINVRETOT-NINVRETOU-NINVRETOV-NINVRETOW-NINVRETOD-NINVRETOE-NINVRETOF-NINVRETOG-NINVRETOX-NINVRETOY-NINVRETOZ
                                 -NINVRETUA) , 0) * (1 - V_CNR) ;

NINVRETUC = max(min(CODHUC , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB-INVOMLOGOA-INVOMLOGOH-INVOMLOGOL-INVOMLOGOO-INVOMLOGOS-NINVRETQL-NINVRETQM
				 -NINVRETQD-NINVRETOB-NINVRETOC-NINVRETOI-NINVRETOJ-NINVRETOK-NINVRETOM-NINVRETON-NINVRETOP-NINVRETOQ-NINVRETOR
				 -NINVRETOT-NINVRETOU-NINVRETOV-NINVRETOW-NINVRETOD-NINVRETOE-NINVRETOF-NINVRETOG-NINVRETOX-NINVRETOY-NINVRETOZ
                                 -NINVRETUA-NINVRETUB) , 0) * (1 - V_CNR) ;

NINVRETUD = max(min(CODHUD , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB-INVOMLOGOA-INVOMLOGOH-INVOMLOGOL-INVOMLOGOO-INVOMLOGOS-NINVRETQL-NINVRETQM
				 -NINVRETQD-NINVRETOB-NINVRETOC-NINVRETOI-NINVRETOJ-NINVRETOK-NINVRETOM-NINVRETON-NINVRETOP-NINVRETOQ-NINVRETOR
				 -NINVRETOT-NINVRETOU-NINVRETOV-NINVRETOW-NINVRETOD-NINVRETOE-NINVRETOF-NINVRETOG-NINVRETOX-NINVRETOY-NINVRETOZ
                                 -NINVRETUA-NINVRETUB-NINVRETUC) , 0) * (1 - V_CNR) ;

NINVRETUE = max(min(CODHUE , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB-INVOMLOGOA-INVOMLOGOH-INVOMLOGOL-INVOMLOGOO-INVOMLOGOS-NINVRETQL-NINVRETQM
				 -NINVRETQD-NINVRETOB-NINVRETOC-NINVRETOI-NINVRETOJ-NINVRETOK-NINVRETOM-NINVRETON-NINVRETOP-NINVRETOQ-NINVRETOR
				 -NINVRETOT-NINVRETOU-NINVRETOV-NINVRETOW-NINVRETOD-NINVRETOE-NINVRETOF-NINVRETOG-NINVRETOX-NINVRETOY-NINVRETOZ
                                 -NINVRETUA-NINVRETUB-NINVRETUC-NINVRETUD) , 0) * (1 - V_CNR) ;

NINVRETUF = max(min(CODHUF , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB-INVOMLOGOA-INVOMLOGOH-INVOMLOGOL-INVOMLOGOO-INVOMLOGOS-NINVRETQL-NINVRETQM
				 -NINVRETQD-NINVRETOB-NINVRETOC-NINVRETOI-NINVRETOJ-NINVRETOK-NINVRETOM-NINVRETON-NINVRETOP-NINVRETOQ-NINVRETOR
				 -NINVRETOT-NINVRETOU-NINVRETOV-NINVRETOW-NINVRETOD-NINVRETOE-NINVRETOF-NINVRETOG-NINVRETOX-NINVRETOY-NINVRETOZ
                                 -NINVRETUA-NINVRETUB-NINVRETUC-NINVRETUD-NINVRETUE) , 0) * (1 - V_CNR) ;

NINVRETUG = max(min(CODHUG , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB-INVOMLOGOA-INVOMLOGOH-INVOMLOGOL-INVOMLOGOO-INVOMLOGOS-NINVRETQL-NINVRETQM
				 -NINVRETQD-NINVRETOB-NINVRETOC-NINVRETOI-NINVRETOJ-NINVRETOK-NINVRETOM-NINVRETON-NINVRETOP-NINVRETOQ-NINVRETOR
				 -NINVRETOT-NINVRETOU-NINVRETOV-NINVRETOW-NINVRETOD-NINVRETOE-NINVRETOF-NINVRETOG-NINVRETOX-NINVRETOY-NINVRETOZ
                                 -NINVRETUA-NINVRETUB-NINVRETUC-NINVRETUD-NINVRETUE-NINVRETUF) , 0) * (1 - V_CNR) ;

NINVRETUH = max(min(CODHUH , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB-INVOMLOGOA-INVOMLOGOH-INVOMLOGOL-INVOMLOGOO-INVOMLOGOS-NINVRETQL-NINVRETQM
				 -NINVRETQD-NINVRETOB-NINVRETOC-NINVRETOI-NINVRETOJ-NINVRETOK-NINVRETOM-NINVRETON-NINVRETOP-NINVRETOQ-NINVRETOR
				 -NINVRETOT-NINVRETOU-NINVRETOV-NINVRETOW-NINVRETOD-NINVRETOE-NINVRETOF-NINVRETOG-NINVRETOX-NINVRETOY-NINVRETOZ
                                 -NINVRETUA-NINVRETUB-NINVRETUC-NINVRETUD-NINVRETUE-NINVRETUF-NINVRETUG) , 0) * (1 - V_CNR) ;

NINVRETUI = max(min(CODHUI , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB-INVOMLOGOA-INVOMLOGOH-INVOMLOGOL-INVOMLOGOO-INVOMLOGOS-NINVRETQL-NINVRETQM
				 -NINVRETQD-NINVRETOB-NINVRETOC-NINVRETOI-NINVRETOJ-NINVRETOK-NINVRETOM-NINVRETON-NINVRETOP-NINVRETOQ-NINVRETOR
				 -NINVRETOT-NINVRETOU-NINVRETOV-NINVRETOW-NINVRETOD-NINVRETOE-NINVRETOF-NINVRETOG-NINVRETOX-NINVRETOY-NINVRETOZ
                                 -NINVRETUA-NINVRETUB-NINVRETUC-NINVRETUD-NINVRETUE-NINVRETUF-NINVRETUG-NINVRETUH) , 0) * (1 - V_CNR) ;

NINVRETUJ = max(min(CODHUJ , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB-INVOMLOGOA-INVOMLOGOH-INVOMLOGOL-INVOMLOGOO-INVOMLOGOS-NINVRETQL-NINVRETQM
				 -NINVRETQD-NINVRETOB-NINVRETOC-NINVRETOI-NINVRETOJ-NINVRETOK-NINVRETOM-NINVRETON-NINVRETOP-NINVRETOQ-NINVRETOR
				 -NINVRETOT-NINVRETOU-NINVRETOV-NINVRETOW-NINVRETOD-NINVRETOE-NINVRETOF-NINVRETOG-NINVRETOX-NINVRETOY-NINVRETOZ
                                 -NINVRETUA-NINVRETUB-NINVRETUC-NINVRETUD-NINVRETUE-NINVRETUF-NINVRETUG-NINVRETUH-NINVRETUI) , 0) * (1 - V_CNR) ;

NINVRETUK = max(min(CODHUK , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB-INVOMLOGOA-INVOMLOGOH-INVOMLOGOL-INVOMLOGOO-INVOMLOGOS-NINVRETQL-NINVRETQM
				 -NINVRETQD-NINVRETOB-NINVRETOC-NINVRETOI-NINVRETOJ-NINVRETOK-NINVRETOM-NINVRETON-NINVRETOP-NINVRETOQ-NINVRETOR
				 -NINVRETOT-NINVRETOU-NINVRETOV-NINVRETOW-NINVRETOD-NINVRETOE-NINVRETOF-NINVRETOG-NINVRETOX-NINVRETOY-NINVRETOZ
                                 -NINVRETUA-NINVRETUB-NINVRETUC-NINVRETUD-NINVRETUE-NINVRETUF-NINVRETUG-NINVRETUH-NINVRETUI-NINVRETUJ) , 0) * (1 - V_CNR) ;

NINVRETUL = max(min(CODHUL , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB-INVOMLOGOA-INVOMLOGOH-INVOMLOGOL-INVOMLOGOO-INVOMLOGOS-NINVRETQL-NINVRETQM
				 -NINVRETQD-NINVRETOB-NINVRETOC-NINVRETOI-NINVRETOJ-NINVRETOK-NINVRETOM-NINVRETON-NINVRETOP-NINVRETOQ-NINVRETOR
				 -NINVRETOT-NINVRETOU-NINVRETOV-NINVRETOW-NINVRETOD-NINVRETOE-NINVRETOF-NINVRETOG-NINVRETOX-NINVRETOY-NINVRETOZ
                                 -NINVRETUA-NINVRETUB-NINVRETUC-NINVRETUD-NINVRETUE-NINVRETUF-NINVRETUG-NINVRETUH-NINVRETUI-NINVRETUJ-NINVRETUK) , 0) * (1 - V_CNR) ;

NINVRETUM = max(min(CODHUM , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB-INVOMLOGOA-INVOMLOGOH-INVOMLOGOL-INVOMLOGOO-INVOMLOGOS-NINVRETQL-NINVRETQM
				 -NINVRETQD-NINVRETOB-NINVRETOC-NINVRETOI-NINVRETOJ-NINVRETOK-NINVRETOM-NINVRETON-NINVRETOP-NINVRETOQ-NINVRETOR
				 -NINVRETOT-NINVRETOU-NINVRETOV-NINVRETOW-NINVRETOD-NINVRETOE-NINVRETOF-NINVRETOG-NINVRETOX-NINVRETOY-NINVRETOZ
                                 -NINVRETUA-NINVRETUB-NINVRETUC-NINVRETUD-NINVRETUE-NINVRETUF-NINVRETUG-NINVRETUH-NINVRETUI-NINVRETUJ-NINVRETUK
                                 -NINVRETUL) , 0) * (1 - V_CNR) ;

NINVRETUN = max(min(CODHUN , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB-INVOMLOGOA-INVOMLOGOH-INVOMLOGOL-INVOMLOGOO-INVOMLOGOS-NINVRETQL-NINVRETQM
				 -NINVRETQD-NINVRETOB-NINVRETOC-NINVRETOI-NINVRETOJ-NINVRETOK-NINVRETOM-NINVRETON-NINVRETOP-NINVRETOQ-NINVRETOR
				 -NINVRETOT-NINVRETOU-NINVRETOV-NINVRETOW-NINVRETOD-NINVRETOE-NINVRETOF-NINVRETOG-NINVRETOX-NINVRETOY-NINVRETOZ
                                 -NINVRETUA-NINVRETUB-NINVRETUC-NINVRETUD-NINVRETUE-NINVRETUF-NINVRETUG-NINVRETUH-NINVRETUI-NINVRETUJ-NINVRETUK
                                 -NINVRETUL-NINVRETUM) , 0) * (1 - V_CNR) ;

NRLOGDOM = (INVLOG2008 + INVLGDEB2009 + INVLGDEB + INVOMLOGOA + INVOMLOGOH + INVOMLOGOL + INVOMLOGOO + INVOMLOGOS
	    + NINVRETQL + NINVRETQM + NINVRETQD + NINVRETOB + NINVRETOC + NINVRETOI + NINVRETOJ + NINVRETOK + NINVRETOM + NINVRETON 
            + NINVRETOP + NINVRETOQ + NINVRETOR + NINVRETOT + NINVRETOU + NINVRETOV + NINVRETOW + NINVRETOD + NINVRETOE + NINVRETOF 
            + NINVRETOG + NINVRETOX + NINVRETOY + NINVRETOZ + NINVRETUA + NINVRETUB + NINVRETUC + NINVRETUD + NINVRETUE + NINVRETUF 
            + NINVRETUG + NINVRETUH + NINVRETUI + NINVRETUJ + NINVRETUK + NINVRETUL + NINVRETUM + NINVRETUN) 
	    * (1 - V_CNR) ;

regle 402040:
application : iliad, batch ;


NINVRETKH = max(min(INVOMSOCKH , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT3-NRPATNAT2-NRPATNAT1-NRPATNAT) , 0) * (1 - V_CNR) ;

NINVRETKI = max(min(INVOMSOCKI , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT3-NRPATNAT2-NRPATNAT1-NRPATNAT-NINVRETKH) , 0) * (1 - V_CNR) ;

NINVRETQN = max(min(INVSOC2010 , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT3-NRPATNAT2-NRPATNAT1-NRPATNAT-NINVRETKH-NINVRETKI) , 0) * (1 - V_CNR) ;

NINVRETQU = max(min(INVOMSOCQU , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT3-NRPATNAT2-NRPATNAT1-NRPATNAT-NINVRETKH-NINVRETKI-NINVRETQN) , 0) * (1 - V_CNR) ;

NINVRETQK = max(min(INVLOGSOC , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT3-NRPATNAT2-NRPATNAT1-NRPATNAT-NINVRETKH-NINVRETKI-NINVRETQN-NINVRETQU) , 0) * (1 - V_CNR) ;

NINVRETQJ = max(min(INVOMSOCQJ , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT3-NRPATNAT2-NRPATNAT1-NRPATNAT-NINVRETKH-NINVRETKI-NINVRETQN-NINVRETQU
				     -NINVRETQK) , 0) * (1 - V_CNR) ;

NINVRETQS = max(min(INVOMSOCQS , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT3-NRPATNAT2-NRPATNAT1-NRPATNAT-NINVRETKH-NINVRETKI-NINVRETQN-NINVRETQU
				     -NINVRETQK-NINVRETQJ) , 0) * (1 - V_CNR) ;

NINVRETQW = max(min(INVOMSOCQW , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT3-NRPATNAT2-NRPATNAT1-NRPATNAT-NINVRETKH-NINVRETKI-NINVRETQN-NINVRETQU
				     -NINVRETQK-NINVRETQJ-NINVRETQS) , 0) * (1 - V_CNR) ;

NINVRETQX = max(min(INVOMSOCQX , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT3-NRPATNAT2-NRPATNAT1-NRPATNAT-NINVRETKH-NINVRETKI-NINVRETQN-NINVRETQU
				     -NINVRETQK-NINVRETQJ-NINVRETQS-NINVRETQW) , 0) * (1 - V_CNR) ;

NINVRETRA = max(min(CODHRA , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT3-NRPATNAT2-NRPATNAT1-NRPATNAT-NINVRETKH-NINVRETKI-NINVRETQN-NINVRETQU
				 -NINVRETQK-NINVRETQJ-NINVRETQS-NINVRETQW-NINVRETQX) , 0) * (1 - V_CNR) ;

NINVRETRB = max(min(CODHRB , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT3-NRPATNAT2-NRPATNAT1-NRPATNAT-NINVRETKH-NINVRETKI-NINVRETQN-NINVRETQU
				 -NINVRETQK-NINVRETQJ-NINVRETQS-NINVRETQW-NINVRETQX-NINVRETRA) , 0) * (1 - V_CNR) ;

NINVRETRC = max(min(CODHRC , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT3-NRPATNAT2-NRPATNAT1-NRPATNAT-NINVRETKH-NINVRETKI-NINVRETQN-NINVRETQU
				 -NINVRETQK-NINVRETQJ-NINVRETQS-NINVRETQW-NINVRETQX-NINVRETRA-NINVRETRB) , 0) * (1 - V_CNR) ;

NINVRETRD = max(min(CODHRD , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT3-NRPATNAT2-NRPATNAT1-NRPATNAT-NINVRETKH-NINVRETKI-NINVRETQN-NINVRETQU
				 -NINVRETQK-NINVRETQJ-NINVRETQS-NINVRETQW-NINVRETQX-NINVRETRA-NINVRETRB-NINVRETRC) , 0) * (1 - V_CNR) ;

NINVRETXA = max(min(CODHXA , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT3-NRPATNAT2-NRPATNAT1-NRPATNAT-NINVRETKH-NINVRETKI-NINVRETQN-NINVRETQU
				 -NINVRETQK-NINVRETQJ-NINVRETQS-NINVRETQW-NINVRETQX-NINVRETRA-NINVRETRB-NINVRETRC-NINVRETRD) , 0) * (1 - V_CNR) ;

NINVRETXB = max(min(CODHXB , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT3-NRPATNAT2-NRPATNAT1-NRPATNAT-NINVRETKH-NINVRETKI-NINVRETQN-NINVRETQU
				 -NINVRETQK-NINVRETQJ-NINVRETQS-NINVRETQW-NINVRETQX-NINVRETRA-NINVRETRB-NINVRETRC-NINVRETRD-NINVRETXA) , 0) * (1 - V_CNR) ;

NINVRETXC = max(min(CODHXC , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT3-NRPATNAT2-NRPATNAT1-NRPATNAT-NINVRETKH-NINVRETKI-NINVRETQN-NINVRETQU
				 -NINVRETQK-NINVRETQJ-NINVRETQS-NINVRETQW-NINVRETQX-NINVRETRA-NINVRETRB-NINVRETRC-NINVRETRD-NINVRETXA-NINVRETXB) , 0) * (1 - V_CNR) ;

NINVRETXE = max(min(CODHXE , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT3-NRPATNAT2-NRPATNAT1-NRPATNAT-NINVRETKH-NINVRETKI-NINVRETQN-NINVRETQU
				 -NINVRETQK-NINVRETQJ-NINVRETQS-NINVRETQW-NINVRETQX-NINVRETRA-NINVRETRB-NINVRETRC-NINVRETRD-NINVRETXA-NINVRETXB-NINVRETXC) , 0) * (1 - V_CNR) ;

NINVRETXF = max(min(CODHXF , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT3-NRPATNAT2-NRPATNAT1-NRPATNAT-NINVRETKH-NINVRETKI-NINVRETQN-NINVRETQU
				 -NINVRETQK-NINVRETQJ-NINVRETQS-NINVRETQW-NINVRETQX-NINVRETRA-NINVRETRB-NINVRETRC-NINVRETRD-NINVRETXA-NINVRETXB-NINVRETXC
                                 -NINVRETXE) , 0) * (1 - V_CNR) ;

NINVRETXG = max(min(CODHXG , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT3-NRPATNAT2-NRPATNAT1-NRPATNAT-NINVRETKH-NINVRETKI-NINVRETQN-NINVRETQU
				 -NINVRETQK-NINVRETQJ-NINVRETQS-NINVRETQW-NINVRETQX-NINVRETRA-NINVRETRB-NINVRETRC-NINVRETRD-NINVRETXA-NINVRETXB-NINVRETXC
                                 -NINVRETXE-NINVRETXF) , 0) * (1 - V_CNR) ;

NINVRETXH = max(min(CODHXH , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT3-NRPATNAT2-NRPATNAT1-NRPATNAT-NINVRETKH-NINVRETKI-NINVRETQN-NINVRETQU
				 -NINVRETQK-NINVRETQJ-NINVRETQS-NINVRETQW-NINVRETQX-NINVRETRA-NINVRETRB-NINVRETRC-NINVRETRD-NINVRETXA-NINVRETXB-NINVRETXC
                                 -NINVRETXE-NINVRETXF-NINVRETXG) , 0) * (1 - V_CNR) ;

NINVRETXI = max(min(CODHXI , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT3-NRPATNAT2-NRPATNAT1-NRPATNAT-NINVRETKH-NINVRETKI-NINVRETQN-NINVRETQU
				 -NINVRETQK-NINVRETQJ-NINVRETQS-NINVRETQW-NINVRETQX-NINVRETRA-NINVRETRB-NINVRETRC-NINVRETRD-NINVRETXA-NINVRETXB-NINVRETXC
                                 -NINVRETXE-NINVRETXF-NINVRETXG-NINVRETXH) , 0) * (1 - V_CNR) ;

NINVRETXK = max(min(CODHXK , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT3-NRPATNAT2-NRPATNAT1-NRPATNAT-NINVRETKH-NINVRETKI-NINVRETQN-NINVRETQU
				 -NINVRETQK-NINVRETQJ-NINVRETQS-NINVRETQW-NINVRETQX-NINVRETRA-NINVRETRB-NINVRETRC-NINVRETRD-NINVRETXA-NINVRETXB-NINVRETXC
                                 -NINVRETXE-NINVRETXF-NINVRETXG-NINVRETXH-NINVRETXI) , 0) * (1 - V_CNR) ;

NRDOMSOC1 = NINVRETKH + NINVRETKI + NINVRETQN + NINVRETQU + NINVRETQK + NINVRETQJ + NINVRETQS + NINVRETQW + NINVRETQX 
            + NINVRETRA + NINVRETRB + NINVRETRC + NINVRETRD + NINVRETXA + NINVRETXB + NINVRETXC + NINVRETXE ;

NRLOGSOC = NINVRETXF + NINVRETXG + NINVRETXH + NINVRETXI + NINVRETXK ;


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

NINVRETXAR = (NINVRETXA - arr(NINVRETXA * TX35 / 100)) * (1 - V_CNR) ;

NINVRETXBR = (NINVRETXB - arr(NINVRETXB * TX35 / 100)) * (1 - V_CNR) ;

NINVRETXCR = (NINVRETXC - arr(NINVRETXC * TX35 / 100)) * (1 - V_CNR) ;

NINVRETXER = (NINVRETXE - arr(NINVRETXE * TX35 / 100)) * (1 - V_CNR) ;

NINVRETXFR = (NINVRETXF - arr(NINVRETXF * TX35 / 100)) * (1 - V_CNR) ;

NINVRETXGR = (NINVRETXG - arr(NINVRETXG * TX35 / 100)) * (1 - V_CNR) ;

NINVRETXHR = (NINVRETXH - arr(NINVRETXH * TX35 / 100)) * (1 - V_CNR) ;

NINVRETXIR = (NINVRETXI - arr(NINVRETXI * TX35 / 100)) * (1 - V_CNR) ;

NINVRETXKR = (NINVRETXK - arr(NINVRETXK * TX30 / 100)) * (1 - V_CNR) ;

regle 402050:
application : iliad, batch ;


INVRETKH = min(arr(NINVRETKH * TX35 / 100) , max(0 , PLAF_INVDOM)) * (1 - V_CNR) ; 

INVRETKI = min(arr(NINVRETKI * TX35 / 100) , max(0 , PLAF_INVDOM -INVRETKH)) * (1 - V_CNR) ; 

INVRETQN = min(arr(NINVRETQN * TX35 / 100) , max(0 , PLAF_INVDOM -INVRETKH-INVRETKI)) * (1 - V_CNR) ; 

INVRETQU = min(arr(NINVRETQU * TX35 / 100) , max(0 , PLAF_INVDOM -INVRETKH-INVRETKI-INVRETQN)) * (1 - V_CNR) ; 

INVRETQK = min(arr(NINVRETQK * TX35 / 100) , max(0 , PLAF_INVDOM -INVRETKH-INVRETKI-INVRETQN-INVRETQU)) * (1 - V_CNR) ;

INVRETQJ = min(arr(NINVRETQJ * TX35 / 100) , max(0 , PLAF_INVDOM -INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK)) * (1 - V_CNR) ;

INVRETQS = min(arr(NINVRETQS * TX35 / 100) , max(0 , PLAF_INVDOM -INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ)) * (1 - V_CNR) ;

INVRETQW = min(arr(NINVRETQW * TX35 / 100) , max(0 , PLAF_INVDOM -INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS)) * (1 - V_CNR) ;

INVRETQX = min(arr(NINVRETQX * TX35 / 100) , max(0 , PLAF_INVDOM -INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW)) * (1 - V_CNR) ;

INVRETRA = min(arr(NINVRETRA * TX35 / 100) , max(0 , PLAF_INVDOM -INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX)) * (1 - V_CNR) ;

INVRETRB = min(arr(NINVRETRB * TX35 / 100) , max(0 , PLAF_INVDOM -INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX
                                                                 -INVRETRA)) * (1 - V_CNR) ;

INVRETRC = min(arr(NINVRETRC * TX35 / 100) , max(0 , PLAF_INVDOM -INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX
                                                                 -INVRETRA-INVRETRB)) * (1 - V_CNR) ;

INVRETRD = min(arr(NINVRETRD * TX35 / 100) , max(0 , PLAF_INVDOM -INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX
                                                                 -INVRETRA-INVRETRB-INVRETRC)) * (1 - V_CNR) ;

INVRETXA = min(arr(NINVRETXA * TX35 / 100) , max(0 , PLAF_INVDOM -INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX
                                                                 -INVRETRA-INVRETRB-INVRETRC-INVRETRD)) * (1 - V_CNR) ;

INVRETXB = min(arr(NINVRETXB * TX35 / 100) , max(0 , PLAF_INVDOM -INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX
                                                                 -INVRETRA-INVRETRB-INVRETRC-INVRETRD-INVRETXA)) * (1 - V_CNR) ;

INVRETXC = min(arr(NINVRETXC * TX35 / 100) , max(0 , PLAF_INVDOM -INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX
                                                                 -INVRETRA-INVRETRB-INVRETRC-INVRETRD-INVRETXA-INVRETXB)) * (1 - V_CNR) ;

INVRETXE = min(arr(NINVRETXE * TX35 / 100) , max(0 , PLAF_INVDOM -INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX
                                                                 -INVRETRA-INVRETRB-INVRETRC-INVRETRD-INVRETXA-INVRETXB-INVRETXC)) * (1 - V_CNR) ;

INVRETXF = min(arr(NINVRETXF * TX35 / 100) , max(0 , PLAF_INVDOM -INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX
                                                                 -INVRETRA-INVRETRB-INVRETRC-INVRETRD-INVRETXA-INVRETXB-INVRETXC-INVRETXE)) * (1 - V_CNR) ;

INVRETXG = min(arr(NINVRETXG * TX35 / 100) , max(0 , PLAF_INVDOM -INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX
                                                                 -INVRETRA-INVRETRB-INVRETRC-INVRETRD-INVRETXA-INVRETXB-INVRETXC-INVRETXE-INVRETXF)) * (1 - V_CNR) ;

INVRETXH = min(arr(NINVRETXH * TX35 / 100) , max(0 , PLAF_INVDOM -INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX
                                                                 -INVRETRA-INVRETRB-INVRETRC-INVRETRD-INVRETXA-INVRETXB-INVRETXC-INVRETXE-INVRETXF
                                                                 -INVRETXG)) * (1 - V_CNR) ;

INVRETXI = min(arr(NINVRETXI * TX35 / 100) , max(0 , PLAF_INVDOM -INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX
                                                                 -INVRETRA-INVRETRB-INVRETRC-INVRETRD-INVRETXA-INVRETXB-INVRETXC-INVRETXE-INVRETXF
                                                                 -INVRETXG-INVRETXH)) * (1 - V_CNR) ;

INVRETXK = min(arr(NINVRETXK * TX30 / 100) , max(0 , PLAF_INVDOM -INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX
                                                                 -INVRETRA-INVRETRB-INVRETRC-INVRETRD-INVRETXA-INVRETXB-INVRETXC-INVRETXE-INVRETXF
                                                                 -INVRETXG-INVRETXH-INVRETXI)) * (1 - V_CNR) ;

INVRETSOC = INVRETKH + INVRETKI + INVRETQN + INVRETQU + INVRETQK + INVRETQJ + INVRETQS + INVRETQW + INVRETQX 
            + INVRETRA + INVRETRB + INVRETRC + INVRETRD + INVRETXA + INVRETXB + INVRETXC + INVRETXE + INVRETXF + INVRETXG
            + INVRETXH + INVRETXI + INVRETXK ;


INVRETKHR = min(max(min(arr(INVRETKH * 13 / 7) , NINVRETKH - INVRETKH) , NINVRETKH - INVRETKH) , 
		max(0 , PLAF_INVDOM1)) * (1 - V_CNR) ;

INVRETKIR = min(max(min(arr(INVRETKI * 13 / 7) , NINVRETKI - INVRETKI) , NINVRETKI - INVRETKI) , 
		max(0 , PLAF_INVDOM1 -INVRETKHR)) * (1 - V_CNR) ;

INVRETQNR = min(max(min(arr(INVRETQN * 13 / 7) , NINVRETQN - INVRETQN) , NINVRETQN - INVRETQN) , 
		max(0 , PLAF_INVDOM1 -INVRETKHR-INVRETKIR)) * (1 - V_CNR) ;

INVRETQUR = min(max(min(arr(INVRETQU * 13 / 7) , NINVRETQU - INVRETQU) , NINVRETQU - INVRETQU) , 
                max(0 , PLAF_INVDOM1 -INVRETKHR-INVRETKIR-INVRETQNR)) * (1 - V_CNR) ;

INVRETQKR = min(max(min(arr(INVRETQK * 13 / 7) , NINVRETQK - INVRETQK) , NINVRETQK - INVRETQK) , 
		max(0 , PLAF_INVDOM1 -INVRETKHR-INVRETKIR-INVRETQNR-INVRETQUR)) * (1 - V_CNR) ;

INVRETQJR = min(max(min(arr(INVRETQJ * 13 / 7) , NINVRETQJ - INVRETQJ) , NINVRETQJ - INVRETQJ) , 
		max(0 , PLAF_INVDOM1 -INVRETKHR-INVRETKIR-INVRETQNR-INVRETQUR-INVRETQKR)) * (1 - V_CNR) ;

INVRETQSR = min(max(min(arr(INVRETQS * 13 / 7) , NINVRETQS - INVRETQS) , NINVRETQS - INVRETQS) , 
		max(0 , PLAF_INVDOM1 -INVRETKHR-INVRETKIR-INVRETQNR-INVRETQUR-INVRETQKR-INVRETQJR)) * (1 - V_CNR) ;

INVRETQWR = min(max(min(arr(INVRETQW * 13 / 7) , NINVRETQW - INVRETQW) , NINVRETQW - INVRETQW) , 
		max(0 , PLAF_INVDOM1 -INVRETKHR-INVRETKIR-INVRETQNR-INVRETQUR-INVRETQKR-INVRETQJR-INVRETQSR)) * (1 - V_CNR) ;

INVRETQXR = min(max(min(arr(INVRETQX * 13 / 7) , NINVRETQX - INVRETQX) , NINVRETQX - INVRETQX) , 
		max(0 , PLAF_INVDOM1 -INVRETKHR-INVRETKIR-INVRETQNR-INVRETQUR-INVRETQKR-INVRETQJR-INVRETQSR-INVRETQWR)) * (1 - V_CNR) ;

INVRETRAR = min(max(min(arr(INVRETRA * 13 / 7) , NINVRETRA - INVRETRA) , NINVRETRA - INVRETRA) , 
		max(0 , PLAF_INVDOM1 -INVRETKHR-INVRETKIR-INVRETQNR-INVRETQUR-INVRETQKR-INVRETQJR-INVRETQSR-INVRETQWR-INVRETQXR)) * (1 - V_CNR) ;

INVRETRBR = min(max(min(arr(INVRETRB * 13 / 7) , NINVRETRB - INVRETRB) , NINVRETRB - INVRETRB) , 
		max(0 , PLAF_INVDOM1 -INVRETKHR-INVRETKIR-INVRETQNR-INVRETQUR-INVRETQKR-INVRETQJR-INVRETQSR-INVRETQWR-INVRETQXR
                                     -INVRETRAR)) * (1 - V_CNR) ;

INVRETRCR = min(max(min(arr(INVRETRC * 13 / 7) , NINVRETRC - INVRETRC) , NINVRETRC - INVRETRC) , 
		max(0 , PLAF_INVDOM1 -INVRETKHR-INVRETKIR-INVRETQNR-INVRETQUR-INVRETQKR-INVRETQJR-INVRETQSR-INVRETQWR-INVRETQXR
                                     -INVRETRAR-INVRETRBR)) * (1 - V_CNR) ;

INVRETRDR = min(max(min(arr(INVRETRD * 13 / 7) , NINVRETRD - INVRETRD) , NINVRETRD - INVRETRD) , 
		max(0 , PLAF_INVDOM1 -INVRETKHR-INVRETKIR-INVRETQNR-INVRETQUR-INVRETQKR-INVRETQJR-INVRETQSR-INVRETQWR-INVRETQXR
                                     -INVRETRAR-INVRETRBR-INVRETRCR)) * (1 - V_CNR) ;

INVRETXAR = min(max(min(arr(INVRETXA * 13 / 7) , NINVRETXA - INVRETXA) , NINVRETXA - INVRETXA) , 
		max(0 , PLAF_INVDOM1 -INVRETKHR-INVRETKIR-INVRETQNR-INVRETQUR-INVRETQKR-INVRETQJR-INVRETQSR-INVRETQWR-INVRETQXR
                                     -INVRETRAR-INVRETRBR-INVRETRCR-INVRETRDR)) * (1 - V_CNR) ;

INVRETXBR = min(max(min(arr(INVRETXB * 13 / 7) , NINVRETXB - INVRETXB) , NINVRETXB - INVRETXB) , 
		max(0 , PLAF_INVDOM1 -INVRETKHR-INVRETKIR-INVRETQNR-INVRETQUR-INVRETQKR-INVRETQJR-INVRETQSR-INVRETQWR-INVRETQXR
                                     -INVRETRAR-INVRETRBR-INVRETRCR-INVRETRDR-INVRETXAR)) * (1 - V_CNR) ;

INVRETXCR = min(max(min(arr(INVRETXC * 13 / 7) , NINVRETXC - INVRETXC) , NINVRETXC - INVRETXC) , 
		max(0 , PLAF_INVDOM1 -INVRETKHR-INVRETKIR-INVRETQNR-INVRETQUR-INVRETQKR-INVRETQJR-INVRETQSR-INVRETQWR-INVRETQXR
                                     -INVRETRAR-INVRETRBR-INVRETRCR-INVRETRDR-INVRETXAR-INVRETXBR)) * (1 - V_CNR) ;

INVRETXER = min(max(min(arr(INVRETXE * 13 / 7) , NINVRETXE - INVRETXE) , NINVRETXE - INVRETXE) , 
		max(0 , PLAF_INVDOM1 -INVRETKHR-INVRETKIR-INVRETQNR-INVRETQUR-INVRETQKR-INVRETQJR-INVRETQSR-INVRETQWR-INVRETQXR
                                     -INVRETRAR-INVRETRBR-INVRETRCR-INVRETRDR-INVRETXAR-INVRETXBR-INVRETXCR)) * (1 - V_CNR) ;

INVRETXFR = min(max(min(arr(INVRETXF * 13 / 7) , NINVRETXF - INVRETXF) , NINVRETXF - INVRETXF) , 
		max(0 , PLAF_INVDOM1 -INVRETKHR-INVRETKIR-INVRETQNR-INVRETQUR-INVRETQKR-INVRETQJR-INVRETQSR-INVRETQWR-INVRETQXR
                                     -INVRETRAR-INVRETRBR-INVRETRCR-INVRETRDR-INVRETXAR-INVRETXBR-INVRETXCR-INVRETXER)) * (1 - V_CNR) ;

INVRETXGR = min(max(min(arr(INVRETXG * 13 / 7) , NINVRETXG - INVRETXG) , NINVRETXG - INVRETXG) , 
		max(0 , PLAF_INVDOM1 -INVRETKHR-INVRETKIR-INVRETQNR-INVRETQUR-INVRETQKR-INVRETQJR-INVRETQSR-INVRETQWR-INVRETQXR
                                     -INVRETRAR-INVRETRBR-INVRETRCR-INVRETRDR-INVRETXAR-INVRETXBR-INVRETXCR-INVRETXER-INVRETXFR)) * (1 - V_CNR) ;

INVRETXHR = min(max(min(arr(INVRETXH * 13 / 7) , NINVRETXH - INVRETXH) , NINVRETXH - INVRETXH) , 
		max(0 , PLAF_INVDOM1 -INVRETKHR-INVRETKIR-INVRETQNR-INVRETQUR-INVRETQKR-INVRETQJR-INVRETQSR-INVRETQWR-INVRETQXR
                                     -INVRETRAR-INVRETRBR-INVRETRCR-INVRETRDR-INVRETXAR-INVRETXBR-INVRETXCR-INVRETXER-INVRETXFR
                                     -INVRETXGR)) * (1 - V_CNR) ;

INVRETXIR = min(max(min(arr(INVRETXI * 13 / 7) , NINVRETXI - INVRETXI) , NINVRETXI - INVRETXI) , 
		max(0 , PLAF_INVDOM1 -INVRETKHR-INVRETKIR-INVRETQNR-INVRETQUR-INVRETQKR-INVRETQJR-INVRETQSR-INVRETQWR-INVRETQXR
                                     -INVRETRAR-INVRETRBR-INVRETRCR-INVRETRDR-INVRETXAR-INVRETXBR-INVRETXCR-INVRETXER-INVRETXFR
                                     -INVRETXGR-INVRETXHR)) * (1 - V_CNR) ;

INVRETXKR = min(max(min(arr(INVRETXK * 7 / 3) , NINVRETXK - INVRETXK) , NINVRETXK - INVRETXK) , 
		max(0 , PLAF_INVDOM7 -INVRETKHR-INVRETKIR-INVRETQNR-INVRETQUR-INVRETQKR-INVRETQJR-INVRETQSR-INVRETQWR-INVRETQXR
                                     -INVRETRAR-INVRETRBR-INVRETRCR-INVRETRDR-INVRETXAR-INVRETXBR-INVRETXCR-INVRETXER-INVRETXFR
                                     -INVRETXGR-INVRETXHR-INVRETXIR) * positif(INVRETXK)) * (1 - V_CNR) ;

regle 402060:
application : iliad, batch ;

RRISUP = RRI1 - RLOGDOM - RTOURREP - RTOUHOTR - RTOUREPA - RCOMP - RRETU - RDONS - CRDIE - RCELTOT - RLOCNPRO 
              - RDUFLOTOT - RPINELTOT - RNOUV - RPLAFREPME4 - RPENTDY - RFOR - RPATNATOT ; 

RRISUP_1 = RRI1_1 - RLOGDOM_1 - RTOURREP_1 - RTOUHOTR_1 - RTOUREPA_1 - RCOMP_1 - RRETU_1 - RDONS_1 - CRDIE_1 - RCELTOT_1 - RLOCNPRO_1 
                  - RDUFLOTOT_1 - RPINELTOT_1 - RNOUV_1 - RPLAFREPME4_1 - RPENTDY_1 - RFOR_1 - RPATNAT_1 - RPATNAT1_1 - RPATNAT2_1 - RPATNAT3_1 ; 


RSOC13_1 = arr(max(min((INVRETKH * (1 - INDPLAF) + INVRETKHA * INDPLAF) , RRISUP) , 0)) * (1 - V_CNR) ;
RSOC13 = RSOC13_1 * (1-ART1731BIS) + min( RSOC13_1 , RSOC13_2 ) *  ART1731BIS ;

RSOC14_1 = arr(max(min((INVRETKI * (1 - INDPLAF) + INVRETKIA * INDPLAF) , RRISUP -RSOC13) , 0)) * (1 - V_CNR) ;
RSOC14 = RSOC14_1 * (1-ART1731BIS) + min( RSOC14_1 , RSOC14_2 ) *  ART1731BIS ;

RSOC15_1 = arr(max(min((INVRETKHR * (1 - INDPLAF) + INVRETKHRA * INDPLAF) , RRISUP -somme(i=13..14 : RSOCi)) , 0)) * (1 - V_CNR) ;
RSOC15 = RSOC15_1 * (1-ART1731BIS) + min( RSOC15_1 , RSOC15_2 ) *  ART1731BIS ;

RSOC16_1 = arr(max(min((INVRETKIR * (1 - INDPLAF) + INVRETKIRA * INDPLAF) , RRISUP -somme(i=13..15 : RSOCi)) , 0)) * (1 - V_CNR) ;
RSOC16 = RSOC16_1 * (1-ART1731BIS) + min( RSOC16_1 , RSOC16_2 ) *  ART1731BIS ;

RSOC17_1 = arr(max(min((INVRETQN * (1 - INDPLAF) + INVRETQNA * INDPLAF) , RRISUP -somme(i=13..16 : RSOCi)) , 0)) * (1 - V_CNR) ;
RSOC17 = RSOC17_1 * (1-ART1731BIS) + min( RSOC17_1 , RSOC17_2 ) *  ART1731BIS ;

RSOC18_1 = arr(max(min((INVRETQU * (1 - INDPLAF) + INVRETQUA * INDPLAF) , RRISUP -somme(i=13..17 : RSOCi)) , 0)) * (1 - V_CNR) ;
RSOC18 = RSOC18_1 * (1-ART1731BIS) + min( RSOC18_1 , RSOC18_2 ) *  ART1731BIS ;

RSOC19_1 = arr(max(min((INVRETQK * (1 - INDPLAF) + INVRETQKA * INDPLAF) , RRISUP -somme(i=13..18 : RSOCi)) , 0)) * (1 - V_CNR) ;
RSOC19 = RSOC19_1 * (1-ART1731BIS) + min( RSOC19_1 , RSOC19_2 ) *  ART1731BIS ;

RSOC20_1 = arr(max(min((INVRETQNR * (1 - INDPLAF) + INVRETQNRA * INDPLAF) , RRISUP -somme(i=13..19 : RSOCi)) , 0)) * (1 - V_CNR) ;
RSOC20 = RSOC20_1 * (1-ART1731BIS) + min( RSOC20_1 , RSOC20_2 ) *  ART1731BIS ;

RSOC21_1 = arr(max(min((INVRETQUR * (1 - INDPLAF) + INVRETQURA * INDPLAF) , RRISUP -somme(i=13..20 : RSOCi)) , 0)) * (1 - V_CNR) ;
RSOC21 = RSOC21_1 * (1-ART1731BIS) + min( RSOC21_1 , RSOC21_2 ) *  ART1731BIS ;

RSOC22_1 = arr(max(min((INVRETQKR * (1 - INDPLAF) + INVRETQKRA * INDPLAF) , RRISUP -somme(i=13..21 : RSOCi)) , 0)) * (1 - V_CNR) ;
RSOC22 = RSOC22_1 * (1-ART1731BIS) + min( RSOC22_1 , RSOC22_2 ) *  ART1731BIS ;

RSOC23_1 = arr(max(min((INVRETQJ * (1 - INDPLAF) + INVRETQJA * INDPLAF) , RRISUP -somme(i=13..22 : RSOCi)) , 0)) * (1 - V_CNR) ;
RSOC23 = RSOC23_1 * (1-ART1731BIS) + min( RSOC23_1 , RSOC23_2 ) *  ART1731BIS ;

RSOC24_1 = arr(max(min((INVRETQS * (1 - INDPLAF) + INVRETQSA * INDPLAF) , RRISUP -somme(i=13..23 : RSOCi)) , 0)) * (1 - V_CNR) ;
RSOC24 = RSOC24_1 * (1-ART1731BIS) + min( RSOC24_1 , RSOC24_2 ) *  ART1731BIS ;

RSOC25_1 = arr(max(min((INVRETQW * (1 - INDPLAF) + INVRETQWA * INDPLAF) , RRISUP -somme(i=13..24 : RSOCi)) , 0)) * (1 - V_CNR) ;
RSOC25 = RSOC25_1 * (1-ART1731BIS) + min( RSOC25_1 , RSOC25_2 ) *  ART1731BIS ;

RSOC26_1 = arr(max(min((INVRETQX * (1 - INDPLAF) + INVRETQXA * INDPLAF) , RRISUP -somme(i=13..25 : RSOCi)) , 0)) * (1 - V_CNR) ;
RSOC26 = RSOC26_1 * (1-ART1731BIS) + min( RSOC26_1 , RSOC26_2 ) *  ART1731BIS ;

RSOC27_1 = arr(max(min((INVRETQJR * (1 - INDPLAF) + INVRETQJRA * INDPLAF) , RRISUP -somme(i=13..26 : RSOCi)) , 0)) * (1 - V_CNR) ;
RSOC27 = RSOC27_1 * (1-ART1731BIS) + min( RSOC27_1 , RSOC27_2 ) *  ART1731BIS ;

RSOC28_1 = arr(max(min((INVRETQSR * (1 - INDPLAF) + INVRETQSRA * INDPLAF) , RRISUP -somme(i=13..27 : RSOCi)) , 0)) * (1 - V_CNR) ;
RSOC28 = RSOC28_1 * (1-ART1731BIS) + min( RSOC28_1 , RSOC28_2 ) *  ART1731BIS ;

RSOC29_1 = arr(max(min((INVRETQWR * (1 - INDPLAF) + INVRETQWRA * INDPLAF) , RRISUP -somme(i=13..28 : RSOCi)) , 0)) * (1 - V_CNR) ;
RSOC29 = RSOC29_1 * (1-ART1731BIS) + min( RSOC29_1 , RSOC29_2 ) *  ART1731BIS ;

RSOC30_1 = arr(max(min((INVRETQXR * (1 - INDPLAF) + INVRETQXRA * INDPLAF) , RRISUP -somme(i=13..29 : RSOCi)) , 0)) * (1 - V_CNR) ;
RSOC30 = RSOC30_1 * (1-ART1731BIS) + min( RSOC30_1 , RSOC30_2 ) *  ART1731BIS ;

RSOC31_1 = arr(max(min((INVRETRA * (1 - INDPLAF) + INVRETRAA * INDPLAF) , RRISUP -somme(i=13..30 : RSOCi)) , 0)) * (1 - V_CNR) ;
RSOC31 = RSOC31_1 * (1-ART1731BIS) + min( RSOC31_1 , RSOC31_2 ) *  ART1731BIS ;

RSOC32_1 = arr(max(min((INVRETRB * (1 - INDPLAF) + INVRETRBA * INDPLAF) , RRISUP -somme(i=13..31 : RSOCi)) , 0)) * (1 - V_CNR) ;
RSOC32 = RSOC32_1 * (1-ART1731BIS) + min( RSOC32_1 , RSOC32_2 ) *  ART1731BIS ;

RSOC33_1 = arr(max(min((INVRETRC * (1 - INDPLAF) + INVRETRCA * INDPLAF) , RRISUP -somme(i=13..32 : RSOCi)) , 0)) * (1 - V_CNR) ;
RSOC33 = RSOC33_1 * (1-ART1731BIS) + min( RSOC33_1 , RSOC33_2 ) *  ART1731BIS ;

RSOC34_1 = arr(max(min((INVRETRD * (1 - INDPLAF) + INVRETRDA * INDPLAF) , RRISUP -somme(i=13..33 : RSOCi)) , 0)) * (1 - V_CNR) ;
RSOC34 = RSOC34_1 * (1-ART1731BIS) + min( RSOC34_1 , RSOC34_2 ) *  ART1731BIS ;

RSOC35_1 = arr(max(min((INVRETRAR * (1 - INDPLAF) + INVRETRARA * INDPLAF) , RRISUP -somme(i=13..34 : RSOCi)) , 0)) * (1 - V_CNR) ;
RSOC35 = RSOC35_1 * (1-ART1731BIS) + min( RSOC35_1 , RSOC35_2 ) *  ART1731BIS ;

RSOC36_1 = arr(max(min((INVRETRBR * (1 - INDPLAF) + INVRETRBRA * INDPLAF) , RRISUP -somme(i=13..35 : RSOCi)) , 0)) * (1 - V_CNR) ;
RSOC36 = RSOC36_1 * (1-ART1731BIS) + min( RSOC36_1 , RSOC36_2 ) *  ART1731BIS ;

RSOC37_1 = arr(max(min((INVRETRCR * (1 - INDPLAF) + INVRETRCRA * INDPLAF) , RRISUP -somme(i=13..36 : RSOCi)) , 0)) * (1 - V_CNR) ;
RSOC37 = RSOC37_1 * (1-ART1731BIS) + min( RSOC37_1 , RSOC37_2 ) *  ART1731BIS ;

RSOC38_1 = arr(max(min((INVRETRDR * (1 - INDPLAF) + INVRETRDRA * INDPLAF) , RRISUP -somme(i=13..37 : RSOCi)) , 0)) * (1 - V_CNR) ;
RSOC38 = RSOC38_1 * (1-ART1731BIS) + min( RSOC38_1 , RSOC38_2 ) *  ART1731BIS ;

RSOC39_1 = arr(max(min((INVRETXA * (1 - INDPLAF) + INVRETXAA * INDPLAF) , RRISUP -somme(i=13..38 : RSOCi)) , 0)) * (1 - V_CNR) ;
RSOC39 = RSOC39_1 * (1-ART1731BIS) + min( RSOC39_1 , RSOC39_2 ) *  ART1731BIS ;

RSOC40_1 = arr(max(min((INVRETXB * (1 - INDPLAF) + INVRETXBA * INDPLAF) , RRISUP -somme(i=13..39 : RSOCi)) , 0)) * (1 - V_CNR) ;
RSOC40 = RSOC40_1 * (1-ART1731BIS) + min( RSOC40_1 , RSOC40_2 ) *  ART1731BIS ;

RSOC41_1 = arr(max(min((INVRETXC * (1 - INDPLAF) + INVRETXCA * INDPLAF) , RRISUP -somme(i=13..40 : RSOCi)) , 0)) * (1 - V_CNR) ;
RSOC41 = RSOC41_1 * (1-ART1731BIS) + min( RSOC41_1 , RSOC41_2 ) *  ART1731BIS ;

RSOC42_1 = arr(max(min((INVRETXE * (1 - INDPLAF) + INVRETXEA * INDPLAF) , RRISUP -somme(i=13..41 : RSOCi)) , 0)) * (1 - V_CNR) ;
RSOC42 = RSOC42_1 * (1-ART1731BIS) + min( RSOC42_1 , RSOC42_2 ) *  ART1731BIS ;

RSOC43_1 = arr(max(min((INVRETXAR * (1 - INDPLAF) + INVRETXARA * INDPLAF) , RRISUP -somme(i=13..42 : RSOCi)) , 0)) * (1 - V_CNR) ;
RSOC43 = RSOC43_1 * (1-ART1731BIS) + min( RSOC43_1 , RSOC43_2 ) *  ART1731BIS ;

RSOC44_1 = arr(max(min((INVRETXBR * (1 - INDPLAF) + INVRETXBRA * INDPLAF) , RRISUP -somme(i=13..43 : RSOCi)) , 0)) * (1 - V_CNR) ;
RSOC44 = RSOC44_1 * (1-ART1731BIS) + min( RSOC44_1 , RSOC44_2 ) *  ART1731BIS ;

RSOC45_1 = arr(max(min((INVRETXCR * (1 - INDPLAF) + INVRETXCRA * INDPLAF) , RRISUP -somme(i=13..44 : RSOCi)) , 0)) * (1 - V_CNR) ;
RSOC45 = RSOC45_1 * (1-ART1731BIS) + min( RSOC45_1 , RSOC45_2 ) *  ART1731BIS ;

RSOC46_1 = arr(max(min((INVRETXER * (1 - INDPLAF) + INVRETXERA * INDPLAF) , RRISUP -somme(i=13..45 : RSOCi)) , 0)) * (1 - V_CNR) ;
RSOC46 = RSOC46_1 * (1-ART1731BIS) + min( RSOC46_1 , RSOC46_2 ) *  ART1731BIS ;

RDOMSOC1_1 =  (1 - V_CNR) * ((1 - V_INDTEO) * (somme(i=13..46 : RSOCi_1))

              + V_INDTEO * (arr(( V_RSOC13+V_RSOC15 + V_RSOC17+V_RSOC20 + V_RSOC23+V_RSOC27
                                + V_RSOC14+V_RSOC16 + V_RSOC18+V_RSOC21 + V_RSOC24+V_RSOC28 + V_RSOC31+V_RSOC35 + V_RSOC39+V_RSOC43
                                + V_RSOC19+V_RSOC22 + V_RSOC25+V_RSOC29 + V_RSOC32+V_RSOC36 + V_RSOC40+V_RSOC44
                                + V_RSOC26+V_RSOC30 + V_RSOC33+V_RSOC37 + V_RSOC41+V_RSOC45
                                + V_RSOC34+V_RSOC38 + V_RSOC42+V_RSOC46 
                                ) * (TX65/100)
                               )
                           )
                            ) ;

RDOMSOC1 = RDOMSOC1_1 * (1 - ART1731BIS) 
            + min(RDOMSOC1_1 , RDOMSOC1_2) * ART1731BIS ;


RSOC1_1 = arr(max(min((INVRETXF * (1 - INDPLAF) + INVRETXFA * INDPLAF) , RRISUP_1 -RDOMSOC1_1) , 0)) * (1 - V_CNR) ;
RSOC1 = RSOC1_1 * (1-ART1731BIS) + min( RSOC1_1 , RSOC1_2 ) *  ART1731BIS ;

RSOC2_1 = arr(max(min((INVRETXG * (1 - INDPLAF) + INVRETXGA * INDPLAF) , RRISUP_1 -RDOMSOC1_1-RSOC1_1) , 0)) * (1 - V_CNR) ;
RSOC2 = RSOC2_1 * (1-ART1731BIS) + min( RSOC2_1 , RSOC2_2 ) *  ART1731BIS ;

RSOC3_1 = arr(max(min((INVRETXH * (1 - INDPLAF) + INVRETXHA * INDPLAF) , RRISUP_1 -RDOMSOC1_1-RSOC1_1-RSOC2_1) , 0)) * (1 - V_CNR) ;
RSOC3 = RSOC3_1 * (1-ART1731BIS) + min( RSOC3_1 , RSOC3_2 ) *  ART1731BIS ;

RSOC4_1 = arr(max(min((INVRETXI * (1 - INDPLAF) + INVRETXIA * INDPLAF) , RRISUP_1 -RDOMSOC1_1-RSOC1_1-RSOC2_1-RSOC3_1) , 0)) * (1 - V_CNR) ;
RSOC4 = RSOC4_1 * (1-ART1731BIS) + min( RSOC4_1 , RSOC4_2 ) *  ART1731BIS ;

RSOC5_1 = arr(max(min((INVRETXK * (1 - INDPLAF) + INVRETXKA * INDPLAF) , RRISUP_1 -RDOMSOC1_1-RSOC1_1-RSOC2_1-RSOC3_1-RSOC4_1) , 0)) * (1 - V_CNR) ;
RSOC5 = RSOC5_1 * (1-ART1731BIS) + min( RSOC5_1 , RSOC5_2 ) *  ART1731BIS ;

RSOC6_1 = arr(max(min((INVRETXFR * (1 - INDPLAF) + INVRETXFRA * INDPLAF) , RRISUP_1 -RDOMSOC1_1-RSOC1_1-RSOC2_1-RSOC3_1-RSOC4_1-RSOC5_1) , 0)) * (1 - V_CNR) ;
RSOC6 = RSOC6_1 * (1-ART1731BIS) + min( RSOC6_1 , RSOC6_2 ) *  ART1731BIS ;

RSOC7_1 = arr(max(min((INVRETXGR * (1 - INDPLAF) + INVRETXGRA * INDPLAF) , RRISUP_1 -RDOMSOC1_1-RSOC1_1-RSOC2_1-RSOC3_1-RSOC4_1-RSOC5_1-RSOC6_1) , 0)) * (1 - V_CNR) ;
RSOC7 = RSOC7_1 * (1-ART1731BIS) + min( RSOC7_1 , RSOC7_2 ) *  ART1731BIS ;

RSOC8_1 = arr(max(min((INVRETXHR * (1 - INDPLAF) + INVRETXHRA * INDPLAF) , RRISUP_1 -RDOMSOC1_1-RSOC1_1-RSOC2_1-RSOC3_1-RSOC4_1-RSOC5_1-RSOC6_1-RSOC7_1) , 0)) * (1 - V_CNR) ;
RSOC8 = RSOC8_1 * (1-ART1731BIS) + min( RSOC8_1 , RSOC8_2 ) * ART1731BIS ;

RSOC9_1 = arr(max(min((INVRETXIR * (1 - INDPLAF) + INVRETXIRA * INDPLAF) , RRISUP_1 -RDOMSOC1_1-RSOC1_1-RSOC2_1-RSOC3_1-RSOC4_1-RSOC5_1-RSOC6_1-RSOC7_1-RSOC8_1) , 0)) * (1 - V_CNR) ;
RSOC9 = RSOC9_1 * (1-ART1731BIS) + min( RSOC9_1 , RSOC9_2 ) * ART1731BIS ;

RSOC10_1 = arr(max(min((INVRETXKR * (1 - INDPLAF) + INVRETXKRA * INDPLAF) , RRISUP_1 -RDOMSOC1_1-RSOC1_1-RSOC2_1-RSOC3_1-RSOC4_1-RSOC5_1-RSOC6_1-RSOC7_1-RSOC8_1-RSOC9_1) , 0)) * (1 - V_CNR) ;
RSOC10 = RSOC10_1 * (1-ART1731BIS) + min( RSOC10_1 , RSOC10_2 ) * ART1731BIS ;

RLOGSOC_1 = ((1 - V_INDTEO) * (RSOC1_1 + RSOC2_1 + RSOC3_1 + RSOC4_1 + RSOC5_1 + RSOC6_1 + RSOC7_1 + RSOC8_1 + RSOC9_1 + RSOC10_1) 

             + V_INDTEO * ( arr(( V_RSOC1+V_RSOC6 + V_RSOC2+V_RSOC7 + V_RSOC3+V_RSOC8 + V_RSOC4+V_RSOC9 ) * (TX65/100) +
                                ( V_RSOC5+V_RSOC10 ) * (TX70/100)
                               )
                          )
            )  * (1 - V_CNR);

RLOGSOC = RLOGSOC_1 * (1 - ART1731BIS)
           + min(RLOGSOC_1 , RLOGSOC_2) * ART1731BIS ;

regle 402070:
application : iliad, batch ;


NINVRETMN = max(min(INVOMENTMN , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3) , 0) 
	     * (1 - V_CNR) ;

NINVRETQE = max(min(INVENDEB2009 , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMENTMN) , 0) 
	     * (1 - V_CNR) ;

NINVRETQV = max(min(INVOMQV , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMENTMN-INVENDEB2009) , 0) 
	     * (1 - V_CNR) ;

NINVRETPM = max(min(INVOMRETPM , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMENTMN-INVOMQV-INVENDEB2009) , 0) * (1 - V_CNR) ;

NINVRETRJ = max(min(INVOMENTRJ , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM) , 0) * (1 - V_CNR) ;

NINVRETMB = max(min(RETROCOMMB , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ) , 0) * (1 - V_CNR) ;

NINVRETMC = max(min(RETROCOMMC , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ
                                     -NINVRETMB) , 0) * (1 - V_CNR) ;

NINVRETLH = max(min(RETROCOMLH , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ
                                     -NINVRETMB-NINVRETMC) , 0) * (1 - V_CNR) ;

NINVRETLI = max(min(RETROCOMLI , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ
                                     -NINVRETMB-NINVRETMC-NINVRETLH) , 0) * (1 - V_CNR) ;

NINVRETKT = max(min(INVOMENTKT , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ
                                     -NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI) , 0) * (1 - V_CNR) ;

NINVRETKU = max(min(INVOMENTKU , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ
                                     -NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT) , 0) * (1 - V_CNR) ;

NINVRETQP = max(min(INVRETRO2 , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ
                                    -NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU) , 0) * (1 - V_CNR) ;

NINVRETQG = max(min(INVDOMRET60 , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ
                                      -NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP) , 0) * (1 - V_CNR) ;

NINVRETPB = max(min(INVOMRETPB , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ
                                     -NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG) , 0) * (1 - V_CNR) ;

NINVRETPF = max(min(INVOMRETPF , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ
                                     -NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETPB) , 0) * (1 - V_CNR) ;

NINVRETPJ = max(min(INVOMRETPJ , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ
                                     -NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETPB-NINVRETPF) , 0) * (1 - V_CNR) ;

NINVRETQO = max(min(INVRETRO1 , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ
                                    -NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETPB-NINVRETPF-NINVRETPJ) , 0) * (1 - V_CNR) ;

NINVRETQF = max(min(INVDOMRET50 , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ
                                      -NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETPB-NINVRETPF-NINVRETPJ
                                      -NINVRETQO) , 0) * (1 - V_CNR) ;

NINVRETPA = max(min(INVOMRETPA , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ
                                     -NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETPB-NINVRETPF-NINVRETPJ
                                     -NINVRETQO-NINVRETQF) , 0) * (1 - V_CNR) ;

NINVRETPE = max(min(INVOMRETPE , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ
                                     -NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETPB-NINVRETPF-NINVRETPJ
                                     -NINVRETQO-NINVRETQF-NINVRETPA) , 0) * (1 - V_CNR) ;

NINVRETPI = max(min(INVOMRETPI , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ
                                     -NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETPB-NINVRETPF-NINVRETPJ
                                     -NINVRETQO-NINVRETQF-NINVRETPA-NINVRETPE) , 0) * (1 - V_CNR) ;

NINVRETQR = max(min(INVIMP , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ
                                 -NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETPB-NINVRETPF-NINVRETPJ
                                 -NINVRETQO-NINVRETQF-NINVRETPA-NINVRETPE-NINVRETPI) , 0) * (1 - V_CNR) ;

NINVRETQI = max(min(INVDIR2009 , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ
                                     -NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETPB-NINVRETPF-NINVRETPJ
                                     -NINVRETQO-NINVRETQF-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETQR) , 0) * (1 - V_CNR) ;

NINVRETPD = max(min(INVOMRETPD , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ
                                     -NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                     -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI) , 0) * (1 - V_CNR) ;

NINVRETPH = max(min(INVOMRETPH , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ
                                     -NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                     -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD) , 0) * (1 - V_CNR) ;

NINVRETPL = max(min(INVOMRETPL , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETPM-NINVRETRJ
                                     -NINVRETMB-NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR
                                     -NINVRETQI-NINVRETPB-NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH) , 0) * (1 - V_CNR) ;

NINVENT12 = NRLOGDOM + NRRI2 + NRLOGSOC + NRDOMSOC1 + NRRI3 + INVOMENTMN + INVOMQV + INVENDEB2009 + NINVRETPM + NINVRETRJ 
            + NINVRETMB + NINVRETMC + NINVRETLH + NINVRETLI + NINVRETKT + NINVRETKU + NINVRETQP + NINVRETQG + NINVRETQO + NINVRETQF 
            + NINVRETQR + NINVRETQI + NINVRETPB + NINVRETPF + NINVRETPJ + NINVRETPA + NINVRETPE + NINVRETPI + NINVRETPD + NINVRETPH + NINVRETPL ;


NINVRETPO = max(min(INVOMRETPO , RRI1-NINVENT12) , 0) * (1 - V_CNR) ;

NINVRETPT = max(min(INVOMRETPT , RRI1-NINVENT12-NINVRETPO) , 0) * (1 - V_CNR) ;

NINVRETPY = max(min(INVOMRETPY , RRI1-NINVENT12-NINVRETPO-NINVRETPT) , 0) * (1 - V_CNR) ;

NINVRETRL = max(min(INVOMENTRL , RRI1-NINVENT12-NINVRETPO-NINVRETPT-NINVRETPY) , 0) * (1 - V_CNR) ;

NINVRETRQ = max(min(INVOMENTRQ , RRI1-NINVENT12-NINVRETPO-NINVRETPT-NINVRETPY-NINVRETRL) , 0) * (1 - V_CNR) ;

NINVRETRV = max(min(INVOMENTRV , RRI1-NINVENT12-NINVRETPO-NINVRETPT-NINVRETPY-NINVRETRL-NINVRETRQ) , 0) * (1 - V_CNR) ;

NINVRETNV = max(min(INVOMENTNV , RRI1-NINVENT12-NINVRETPO-NINVRETPT-NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV) , 0) * (1 - V_CNR) ;

NINVRETPN = max(min(INVOMRETPN , RRI1-NINVENT12-NINVRETPO-NINVRETPT-NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV) , 0) * (1 - V_CNR) ;

NINVRETPS = max(min(INVOMRETPS , RRI1-NINVENT12-NINVRETPO-NINVRETPT-NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN) , 0) * (1 - V_CNR) ;

NINVRETPX = max(min(INVOMRETPX , RRI1-NINVENT12-NINVRETPO-NINVRETPT-NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS) , 0) * (1 - V_CNR) ;

NINVRETRK = max(min(INVOMENTRK , RRI1-NINVENT12-NINVRETPO-NINVRETPT-NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX) , 0) * (1 - V_CNR) ;

NINVRETRP = max(min(INVOMENTRP , RRI1-NINVENT12-NINVRETPO-NINVRETPT-NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX
                                     -NINVRETRK) , 0) * (1 - V_CNR) ;

NINVRETRU = max(min(INVOMENTRU , RRI1-NINVENT12-NINVRETPO-NINVRETPT-NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX
                                     -NINVRETRK-NINVRETRP) , 0) * (1 - V_CNR) ;

NINVRETNU = max(min(INVOMENTNU , RRI1-NINVENT12-NINVRETPO-NINVRETPT-NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX
                                     -NINVRETRK-NINVRETRP-NINVRETRU) , 0) * (1 - V_CNR) ;

NINVRETPP = max(min(INVOMRETPP , RRI1-NINVENT12-NINVRETPO-NINVRETPT-NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX
                                     -NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU) , 0) * (1 - V_CNR) ;

NINVRETPU = max(min(INVOMRETPU , RRI1-NINVENT12-NINVRETPO-NINVRETPT-NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX
                                     -NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU-NINVRETPP) , 0) * (1 - V_CNR) ;

NINVRETRG = max(min(INVOMENTRG , RRI1-NINVENT12-NINVRETPO-NINVRETPT-NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX
                                     -NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU-NINVRETPP-NINVRETPU) , 0) * (1 - V_CNR) ;

NINVRETRM = max(min(INVOMENTRM , RRI1-NINVENT12-NINVRETPO-NINVRETPT-NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX
                                     -NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU-NINVRETPP-NINVRETPU-NINVRETRG) , 0) * (1 - V_CNR) ;

NINVRETRR = max(min(INVOMENTRR , RRI1-NINVENT12-NINVRETPO-NINVRETPT-NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX
                                     -NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU-NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM) , 0) * (1 - V_CNR) ;

NINVRETRW = max(min(INVOMENTRW , RRI1-NINVENT12-NINVRETPO-NINVRETPT-NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX
                                     -NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU-NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR) , 0) * (1 - V_CNR) ;

NINVRETNW = max(min(INVOMENTNW , RRI1-NINVENT12-NINVRETPO-NINVRETPT-NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX
                                     -NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU-NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW) , 0) * (1 - V_CNR) ;

NINVRETPR = max(min(INVOMRETPR , RRI1-NINVENT12-NINVRETPO-NINVRETPT-NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX
                                     -NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU-NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW-NINVRETNW) , 0) * (1 - V_CNR) ;

NINVRETPW = max(min(INVOMRETPW , RRI1-NINVENT12-NINVRETPO-NINVRETPT-NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX
                                     -NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU-NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW-NINVRETNW
                                     -NINVRETPR) , 0) * (1 - V_CNR) ;

NINVRETRI = max(min(INVOMENTRI , RRI1-NINVENT12-NINVRETPO-NINVRETPT-NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX
                                     -NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU-NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW-NINVRETNW
                                     -NINVRETPR-NINVRETPW) , 0) * (1 - V_CNR) ;

NINVRETRO = max(min(INVOMENTRO , RRI1-NINVENT12-NINVRETPO-NINVRETPT-NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX
                                     -NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU-NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW-NINVRETNW
                                     -NINVRETPR-NINVRETPW-NINVRETRI) , 0) * (1 - V_CNR) ;

NINVRETRT = max(min(INVOMENTRT , RRI1-NINVENT12-NINVRETPO-NINVRETPT-NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX
                                     -NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU-NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW-NINVRETNW
                                     -NINVRETPR-NINVRETPW-NINVRETRI-NINVRETRO) , 0) * (1 - V_CNR) ;

NINVRETRY = max(min(INVOMENTRY , RRI1-NINVENT12-NINVRETPO-NINVRETPT-NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX
                                     -NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU-NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW-NINVRETNW
                                     -NINVRETPR-NINVRETPW-NINVRETRI-NINVRETRO-NINVRETRT) , 0) * (1 - V_CNR) ;

NINVRETNY = max(min(INVOMENTNY , RRI1-NINVENT12-NINVRETPO-NINVRETPT-NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX
                                     -NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU-NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW-NINVRETNW
                                     -NINVRETPR-NINVRETPW-NINVRETRI-NINVRETRO-NINVRETRT-NINVRETRY) , 0) * (1 - V_CNR) ;

NINVENT13 = NINVENT12 + NINVRETPO + NINVRETPT + NINVRETPY + NINVRETRL + NINVRETRQ + NINVRETRV + NINVRETNV + NINVRETPN + NINVRETPS + NINVRETPX + NINVRETRK 
            + NINVRETRP + NINVRETRU + NINVRETNU + NINVRETPP + NINVRETPU + NINVRETRG + NINVRETRM + NINVRETRR + NINVRETRW + NINVRETNW + NINVRETPR + NINVRETPW 
            + NINVRETRI + NINVRETRO + NINVRETRT + NINVRETRY + NINVRETNY ;


NINVRETSB = max(min(CODHSB , RRI1-NINVENT13) , 0) * (1 - V_CNR) ;

NINVRETSG = max(min(CODHSG , RRI1-NINVENT13-NINVRETSB) , 0) * (1 - V_CNR) ;

NINVRETSL = max(min(CODHSL , RRI1-NINVENT13-NINVRETSB-NINVRETSG) , 0) * (1 - V_CNR) ;

NINVRETSQ = max(min(CODHSQ , RRI1-NINVENT13-NINVRETSB-NINVRETSG-NINVRETSL) , 0) * (1 - V_CNR) ;

NINVRETSV = max(min(CODHSV , RRI1-NINVENT13-NINVRETSB-NINVRETSG-NINVRETSL-NINVRETSQ) , 0) * (1 - V_CNR) ;

NINVRETTA = max(min(CODHTA , RRI1-NINVENT13-NINVRETSB-NINVRETSG-NINVRETSL-NINVRETSQ-NINVRETSV) , 0) * (1 - V_CNR) ;

NINVRETSA = max(min(CODHSA , RRI1-NINVENT13-NINVRETSB-NINVRETSG-NINVRETSL-NINVRETSQ-NINVRETSV-NINVRETTA) , 0) * (1 - V_CNR) ;

NINVRETSF = max(min(CODHSF , RRI1-NINVENT13-NINVRETSB-NINVRETSG-NINVRETSL-NINVRETSQ-NINVRETSV-NINVRETTA-NINVRETSA) , 0) * (1 - V_CNR) ;

NINVRETSK = max(min(CODHSK , RRI1-NINVENT13-NINVRETSB-NINVRETSG-NINVRETSL-NINVRETSQ-NINVRETSV-NINVRETTA-NINVRETSA-NINVRETSF) , 0) * (1 - V_CNR) ;

NINVRETSP = max(min(CODHSP , RRI1-NINVENT13-NINVRETSB-NINVRETSG-NINVRETSL-NINVRETSQ-NINVRETSV-NINVRETTA-NINVRETSA-NINVRETSF-NINVRETSK) , 0) * (1 - V_CNR) ;

NINVRETSU = max(min(CODHSU , RRI1-NINVENT13-NINVRETSB-NINVRETSG-NINVRETSL-NINVRETSQ-NINVRETSV-NINVRETTA-NINVRETSA-NINVRETSF-NINVRETSK-NINVRETSP) , 0) * (1 - V_CNR) ;

NINVRETSZ = max(min(CODHSZ , RRI1-NINVENT13-NINVRETSB-NINVRETSG-NINVRETSL-NINVRETSQ-NINVRETSV-NINVRETTA-NINVRETSA-NINVRETSF-NINVRETSK-NINVRETSP
                                 -NINVRETSU) , 0) * (1 - V_CNR) ;

NINVRETSC = max(min(CODHSC , RRI1-NINVENT13-NINVRETSB-NINVRETSG-NINVRETSL-NINVRETSQ-NINVRETSV-NINVRETTA-NINVRETSA-NINVRETSF-NINVRETSK-NINVRETSP
                                 -NINVRETSU-NINVRETSZ) , 0) * (1 - V_CNR) ;

NINVRETSH = max(min(CODHSH , RRI1-NINVENT13-NINVRETSB-NINVRETSG-NINVRETSL-NINVRETSQ-NINVRETSV-NINVRETTA-NINVRETSA-NINVRETSF-NINVRETSK-NINVRETSP
                                 -NINVRETSU-NINVRETSZ-NINVRETSC) , 0) * (1 - V_CNR) ;

NINVRETSM = max(min(CODHSM , RRI1-NINVENT13-NINVRETSB-NINVRETSG-NINVRETSL-NINVRETSQ-NINVRETSV-NINVRETTA-NINVRETSA-NINVRETSF-NINVRETSK-NINVRETSP
                                 -NINVRETSU-NINVRETSZ-NINVRETSC-NINVRETSH) , 0) * (1 - V_CNR) ;

NINVRETSR = max(min(CODHSR , RRI1-NINVENT13-NINVRETSB-NINVRETSG-NINVRETSL-NINVRETSQ-NINVRETSV-NINVRETTA-NINVRETSA-NINVRETSF-NINVRETSK-NINVRETSP
                                 -NINVRETSU-NINVRETSZ-NINVRETSC-NINVRETSH-NINVRETSM) , 0) * (1 - V_CNR) ;

NINVRETSW = max(min(CODHSW , RRI1-NINVENT13-NINVRETSB-NINVRETSG-NINVRETSL-NINVRETSQ-NINVRETSV-NINVRETTA-NINVRETSA-NINVRETSF-NINVRETSK-NINVRETSP
                                 -NINVRETSU-NINVRETSZ-NINVRETSC-NINVRETSH-NINVRETSM-NINVRETSR) , 0) * (1 - V_CNR) ;

NINVRETTB = max(min(CODHTB , RRI1-NINVENT13-NINVRETSB-NINVRETSG-NINVRETSL-NINVRETSQ-NINVRETSV-NINVRETTA-NINVRETSA-NINVRETSF-NINVRETSK-NINVRETSP
                                 -NINVRETSU-NINVRETSZ-NINVRETSC-NINVRETSH-NINVRETSM-NINVRETSR-NINVRETSW) , 0) * (1 - V_CNR) ;

NINVRETSE = max(min(CODHSE , RRI1-NINVENT13-NINVRETSB-NINVRETSG-NINVRETSL-NINVRETSQ-NINVRETSV-NINVRETTA-NINVRETSA-NINVRETSF-NINVRETSK-NINVRETSP
                                 -NINVRETSU-NINVRETSZ-NINVRETSC-NINVRETSH-NINVRETSM-NINVRETSR-NINVRETSW-NINVRETTB) , 0) * (1 - V_CNR) ;

NINVRETSJ = max(min(CODHSJ , RRI1-NINVENT13-NINVRETSB-NINVRETSG-NINVRETSL-NINVRETSQ-NINVRETSV-NINVRETTA-NINVRETSA-NINVRETSF-NINVRETSK-NINVRETSP
                                 -NINVRETSU-NINVRETSZ-NINVRETSC-NINVRETSH-NINVRETSM-NINVRETSR-NINVRETSW-NINVRETTB-NINVRETSE) , 0) * (1 - V_CNR) ;

NINVRETSO = max(min(CODHSO , RRI1-NINVENT13-NINVRETSB-NINVRETSG-NINVRETSL-NINVRETSQ-NINVRETSV-NINVRETTA-NINVRETSA-NINVRETSF-NINVRETSK-NINVRETSP
                                 -NINVRETSU-NINVRETSZ-NINVRETSC-NINVRETSH-NINVRETSM-NINVRETSR-NINVRETSW-NINVRETTB-NINVRETSE-NINVRETSJ) , 0) * (1 - V_CNR) ;

NINVRETST = max(min(CODHST , RRI1-NINVENT13-NINVRETSB-NINVRETSG-NINVRETSL-NINVRETSQ-NINVRETSV-NINVRETTA-NINVRETSA-NINVRETSF-NINVRETSK-NINVRETSP
                                 -NINVRETSU-NINVRETSZ-NINVRETSC-NINVRETSH-NINVRETSM-NINVRETSR-NINVRETSW-NINVRETTB-NINVRETSE-NINVRETSJ-NINVRETSO) , 0) * (1 - V_CNR) ;

NINVRETSY = max(min(CODHSY , RRI1-NINVENT13-NINVRETSB-NINVRETSG-NINVRETSL-NINVRETSQ-NINVRETSV-NINVRETTA-NINVRETSA-NINVRETSF-NINVRETSK-NINVRETSP
                                 -NINVRETSU-NINVRETSZ-NINVRETSC-NINVRETSH-NINVRETSM-NINVRETSR-NINVRETSW-NINVRETTB-NINVRETSE-NINVRETSJ-NINVRETSO
                                 -NINVRETST) , 0) * (1 - V_CNR) ;

NINVRETTD = max(min(CODHTD , RRI1-NINVENT13-NINVRETSB-NINVRETSG-NINVRETSL-NINVRETSQ-NINVRETSV-NINVRETTA-NINVRETSA-NINVRETSF-NINVRETSK-NINVRETSP
                                 -NINVRETSU-NINVRETSZ-NINVRETSC-NINVRETSH-NINVRETSM-NINVRETSR-NINVRETSW-NINVRETTB-NINVRETSE-NINVRETSJ-NINVRETSO
                                 -NINVRETST-NINVRETSY) , 0) * (1 - V_CNR) ;

NINVENT14 = NINVENT13 + NINVRETSB + NINVRETSG + NINVRETSL + NINVRETSQ + NINVRETSV + NINVRETTA + NINVRETSA + NINVRETSF + NINVRETSK + NINVRETSP
            + NINVRETSU + NINVRETSZ + NINVRETSC + NINVRETSH + NINVRETSM + NINVRETSR + NINVRETSW + NINVRETTB + NINVRETSE + NINVRETSJ + NINVRETSO 
            + NINVRETST + NINVRETSY + NINVRETTD ;


NINVRETAB = max(min(CODHAB , RRI1-NINVENT14) , 0) * (1 - V_CNR) ;

NINVRETAG = max(min(CODHAG , RRI1-NINVENT14-NINVRETAB) , 0) * (1 - V_CNR) ;

NINVRETAL = max(min(CODHAL , RRI1-NINVENT14-NINVRETAB-NINVRETAG) , 0) * (1 - V_CNR) ;

NINVRETAQ = max(min(CODHAQ , RRI1-NINVENT14-NINVRETAB-NINVRETAG-NINVRETAL) , 0) * (1 - V_CNR) ;

NINVRETAV = max(min(CODHAV , RRI1-NINVENT14-NINVRETAB-NINVRETAG-NINVRETAL-NINVRETAQ) , 0) * (1 - V_CNR) ;

NINVRETBB = max(min(CODHBB , RRI1-NINVENT14-NINVRETAB-NINVRETAG-NINVRETAL-NINVRETAQ-NINVRETAV) , 0) * (1 - V_CNR) ;

NINVRETAA = max(min(CODHAA , RRI1-NINVENT14-NINVRETAB-NINVRETAG-NINVRETAL-NINVRETAQ-NINVRETAV-NINVRETBB) , 0) * (1 - V_CNR) ;

NINVRETAF = max(min(CODHAF , RRI1-NINVENT14-NINVRETAB-NINVRETAG-NINVRETAL-NINVRETAQ-NINVRETAV-NINVRETBB-NINVRETAA) , 0) * (1 - V_CNR) ;

NINVRETAK = max(min(CODHAK , RRI1-NINVENT14-NINVRETAB-NINVRETAG-NINVRETAL-NINVRETAQ-NINVRETAV-NINVRETBB-NINVRETAA-NINVRETAF) , 0) * (1 - V_CNR) ;

NINVRETAP = max(min(CODHAP , RRI1-NINVENT14-NINVRETAB-NINVRETAG-NINVRETAL-NINVRETAQ-NINVRETAV-NINVRETBB-NINVRETAA-NINVRETAF-NINVRETAK) , 0) * (1 - V_CNR) ;

NINVRETAU = max(min(CODHAU , RRI1-NINVENT14-NINVRETAB-NINVRETAG-NINVRETAL-NINVRETAQ-NINVRETAV-NINVRETBB-NINVRETAA-NINVRETAF-NINVRETAK-NINVRETAP) , 0) * (1 - V_CNR) ;

NINVRETBA = max(min(CODHBA , RRI1-NINVENT14-NINVRETAB-NINVRETAG-NINVRETAL-NINVRETAQ-NINVRETAV-NINVRETBB-NINVRETAA-NINVRETAF-NINVRETAK-NINVRETAP
                                 -NINVRETAU) , 0) * (1 - V_CNR) ;

NINVRETAC = max(min(CODHAC , RRI1-NINVENT14-NINVRETAB-NINVRETAG-NINVRETAL-NINVRETAQ-NINVRETAV-NINVRETBB-NINVRETAA-NINVRETAF-NINVRETAK-NINVRETAP
                                 -NINVRETAU-NINVRETBA) , 0) * (1 - V_CNR) ;

NINVRETAH = max(min(CODHAH , RRI1-NINVENT14-NINVRETAB-NINVRETAG-NINVRETAL-NINVRETAQ-NINVRETAV-NINVRETBB-NINVRETAA-NINVRETAF-NINVRETAK-NINVRETAP
                                 -NINVRETAU-NINVRETBA-NINVRETAC) , 0) * (1 - V_CNR) ;

NINVRETAM = max(min(CODHAM , RRI1-NINVENT14-NINVRETAB-NINVRETAG-NINVRETAL-NINVRETAQ-NINVRETAV-NINVRETBB-NINVRETAA-NINVRETAF-NINVRETAK-NINVRETAP
                                 -NINVRETAU-NINVRETBA-NINVRETAC-NINVRETAH) , 0) * (1 - V_CNR) ;

NINVRETAR = max(min(CODHAR , RRI1-NINVENT14-NINVRETAB-NINVRETAG-NINVRETAL-NINVRETAQ-NINVRETAV-NINVRETBB-NINVRETAA-NINVRETAF-NINVRETAK-NINVRETAP
                                 -NINVRETAU-NINVRETBA-NINVRETAC-NINVRETAH-NINVRETAM) , 0) * (1 - V_CNR) ;

NINVRETAW = max(min(CODHAW , RRI1-NINVENT14-NINVRETAB-NINVRETAG-NINVRETAL-NINVRETAQ-NINVRETAV-NINVRETBB-NINVRETAA-NINVRETAF-NINVRETAK-NINVRETAP
                                 -NINVRETAU-NINVRETBA-NINVRETAC-NINVRETAH-NINVRETAM-NINVRETAR) , 0) * (1 - V_CNR) ;

NINVRETBE = max(min(CODHBE , RRI1-NINVENT14-NINVRETAB-NINVRETAG-NINVRETAL-NINVRETAQ-NINVRETAV-NINVRETBB-NINVRETAA-NINVRETAF-NINVRETAK-NINVRETAP
                                 -NINVRETAU-NINVRETBA-NINVRETAC-NINVRETAH-NINVRETAM-NINVRETAR-NINVRETAW) , 0) * (1 - V_CNR) ;

NINVRETAE = max(min(CODHAE , RRI1-NINVENT14-NINVRETAB-NINVRETAG-NINVRETAL-NINVRETAQ-NINVRETAV-NINVRETBB-NINVRETAA-NINVRETAF-NINVRETAK-NINVRETAP
                                 -NINVRETAU-NINVRETBA-NINVRETAC-NINVRETAH-NINVRETAM-NINVRETAR-NINVRETAW-NINVRETBE) , 0) * (1 - V_CNR) ;

NINVRETAJ = max(min(CODHAJ , RRI1-NINVENT14-NINVRETAB-NINVRETAG-NINVRETAL-NINVRETAQ-NINVRETAV-NINVRETBB-NINVRETAA-NINVRETAF-NINVRETAK-NINVRETAP
                                 -NINVRETAU-NINVRETBA-NINVRETAC-NINVRETAH-NINVRETAM-NINVRETAR-NINVRETAW-NINVRETBE-NINVRETAE) , 0) * (1 - V_CNR) ;

NINVRETAO = max(min(CODHAO , RRI1-NINVENT14-NINVRETAB-NINVRETAG-NINVRETAL-NINVRETAQ-NINVRETAV-NINVRETBB-NINVRETAA-NINVRETAF-NINVRETAK-NINVRETAP
                                 -NINVRETAU-NINVRETBA-NINVRETAC-NINVRETAH-NINVRETAM-NINVRETAR-NINVRETAW-NINVRETBE-NINVRETAE-NINVRETAJ) , 0) * (1 - V_CNR) ;

NINVRETAT = max(min(CODHAT , RRI1-NINVENT14-NINVRETAB-NINVRETAG-NINVRETAL-NINVRETAQ-NINVRETAV-NINVRETBB-NINVRETAA-NINVRETAF-NINVRETAK-NINVRETAP
                                 -NINVRETAU-NINVRETBA-NINVRETAC-NINVRETAH-NINVRETAM-NINVRETAR-NINVRETAW-NINVRETBE-NINVRETAE-NINVRETAJ-NINVRETAO) , 0) * (1 - V_CNR) ;

NINVRETAY = max(min(CODHAY , RRI1-NINVENT14-NINVRETAB-NINVRETAG-NINVRETAL-NINVRETAQ-NINVRETAV-NINVRETBB-NINVRETAA-NINVRETAF-NINVRETAK-NINVRETAP
                                 -NINVRETAU-NINVRETBA-NINVRETAC-NINVRETAH-NINVRETAM-NINVRETAR-NINVRETAW-NINVRETBE-NINVRETAE-NINVRETAJ-NINVRETAO
                                 -NINVRETAT) , 0) * (1 - V_CNR) ;

NINVRETBG = max(min(CODHBG , RRI1-NINVENT14-NINVRETAB-NINVRETAG-NINVRETAL-NINVRETAQ-NINVRETAV-NINVRETBB-NINVRETAA-NINVRETAF-NINVRETAK-NINVRETAP
                                 -NINVRETAU-NINVRETBA-NINVRETAC-NINVRETAH-NINVRETAM-NINVRETAR-NINVRETAW-NINVRETBE-NINVRETAE-NINVRETAJ-NINVRETAO
                                 -NINVRETAT-NINVRETAY) , 0) * (1 - V_CNR) ;

NINVENT15 = NINVENT14 + NINVRETAB + NINVRETAG + NINVRETAL + NINVRETAQ + NINVRETAV + NINVRETBB + NINVRETAA + NINVRETAF + NINVRETAK + NINVRETAP
            + NINVRETAU + NINVRETBA + NINVRETAC + NINVRETAH + NINVRETAM + NINVRETAR + NINVRETAW + NINVRETBE + NINVRETAE + NINVRETAJ + NINVRETAO 
            + NINVRETAT + NINVRETAY + NINVRETBG ;


NINVRETBJ = max(min(CODHBJ , RRI1-NINVENT15) , 0) * (1 - V_CNR) ;

NINVRETBO = max(min(CODHBO , RRI1-NINVENT15-NINVRETBJ) , 0) * (1 - V_CNR) ;

NINVRETBT = max(min(CODHBT , RRI1-NINVENT15-NINVRETBJ-NINVRETBO) , 0) * (1 - V_CNR) ;

NINVRETBY = max(min(CODHBY , RRI1-NINVENT15-NINVRETBJ-NINVRETBO-NINVRETBT) , 0) * (1 - V_CNR) ;

NINVRETCD = max(min(CODHCD , RRI1-NINVENT15-NINVRETBJ-NINVRETBO-NINVRETBT-NINVRETBY) , 0) * (1 - V_CNR) ;

NINVRETBI = max(min(CODHBI , RRI1-NINVENT15-NINVRETBJ-NINVRETBO-NINVRETBT-NINVRETBY-NINVRETCD) , 0) * (1 - V_CNR) ;

NINVRETBN = max(min(CODHBN , RRI1-NINVENT15-NINVRETBJ-NINVRETBO-NINVRETBT-NINVRETBY-NINVRETCD-NINVRETBI) , 0) * (1 - V_CNR) ;

NINVRETBS = max(min(CODHBS , RRI1-NINVENT15-NINVRETBJ-NINVRETBO-NINVRETBT-NINVRETBY-NINVRETCD-NINVRETBI-NINVRETBN) , 0) * (1 - V_CNR) ;

NINVRETBX = max(min(CODHBX , RRI1-NINVENT15-NINVRETBJ-NINVRETBO-NINVRETBT-NINVRETBY-NINVRETCD-NINVRETBI-NINVRETBN-NINVRETBS) , 0) * (1 - V_CNR) ;

NINVRETCC = max(min(CODHCC , RRI1-NINVENT15-NINVRETBJ-NINVRETBO-NINVRETBT-NINVRETBY-NINVRETCD-NINVRETBI-NINVRETBN-NINVRETBS-NINVRETBX) , 0) * (1 - V_CNR) ;

NINVRETBK = max(min(CODHBK , RRI1-NINVENT15-NINVRETBJ-NINVRETBO-NINVRETBT-NINVRETBY-NINVRETCD-NINVRETBI-NINVRETBN-NINVRETBS-NINVRETBX
                                 -NINVRETCC) , 0) * (1 - V_CNR) ;

NINVRETBP = max(min(CODHBP , RRI1-NINVENT15-NINVRETBJ-NINVRETBO-NINVRETBT-NINVRETBY-NINVRETCD-NINVRETBI-NINVRETBN-NINVRETBS-NINVRETBX
                                 -NINVRETCC-NINVRETBK) , 0) * (1 - V_CNR) ;

NINVRETBU = max(min(CODHBU , RRI1-NINVENT15-NINVRETBJ-NINVRETBO-NINVRETBT-NINVRETBY-NINVRETCD-NINVRETBI-NINVRETBN-NINVRETBS-NINVRETBX
                                 -NINVRETCC-NINVRETBK-NINVRETBP) , 0) * (1 - V_CNR) ;

NINVRETBZ = max(min(CODHBZ , RRI1-NINVENT15-NINVRETBJ-NINVRETBO-NINVRETBT-NINVRETBY-NINVRETCD-NINVRETBI-NINVRETBN-NINVRETBS-NINVRETBX
                                 -NINVRETCC-NINVRETBK-NINVRETBP-NINVRETBU) , 0) * (1 - V_CNR) ;

NINVRETCE = max(min(CODHCE , RRI1-NINVENT15-NINVRETBJ-NINVRETBO-NINVRETBT-NINVRETBY-NINVRETCD-NINVRETBI-NINVRETBN-NINVRETBS-NINVRETBX
                                 -NINVRETCC-NINVRETBK-NINVRETBP-NINVRETBU-NINVRETBZ) , 0) * (1 - V_CNR) ;

NINVRETBM = max(min(CODHBM , RRI1-NINVENT15-NINVRETBJ-NINVRETBO-NINVRETBT-NINVRETBY-NINVRETCD-NINVRETBI-NINVRETBN-NINVRETBS-NINVRETBX
                                 -NINVRETCC-NINVRETBK-NINVRETBP-NINVRETBU-NINVRETBZ-NINVRETCE) , 0) * (1 - V_CNR) ;

NINVRETBR = max(min(CODHBR , RRI1-NINVENT15-NINVRETBJ-NINVRETBO-NINVRETBT-NINVRETBY-NINVRETCD-NINVRETBI-NINVRETBN-NINVRETBS-NINVRETBX
                                 -NINVRETCC-NINVRETBK-NINVRETBP-NINVRETBU-NINVRETBZ-NINVRETCE-NINVRETBM) , 0) * (1 - V_CNR) ;

NINVRETBW = max(min(CODHBW , RRI1-NINVENT15-NINVRETBJ-NINVRETBO-NINVRETBT-NINVRETBY-NINVRETCD-NINVRETBI-NINVRETBN-NINVRETBS-NINVRETBX
                                 -NINVRETCC-NINVRETBK-NINVRETBP-NINVRETBU-NINVRETBZ-NINVRETCE-NINVRETBM-NINVRETBR) , 0) * (1 - V_CNR) ;

NINVRETCB = max(min(CODHCB , RRI1-NINVENT15-NINVRETBJ-NINVRETBO-NINVRETBT-NINVRETBY-NINVRETCD-NINVRETBI-NINVRETBN-NINVRETBS-NINVRETBX
                                 -NINVRETCC-NINVRETBK-NINVRETBP-NINVRETBU-NINVRETBZ-NINVRETCE-NINVRETBM-NINVRETBR-NINVRETBW) , 0) * (1 - V_CNR) ;

NINVRETCG = max(min(CODHCG , RRI1-NINVENT15-NINVRETBJ-NINVRETBO-NINVRETBT-NINVRETBY-NINVRETCD-NINVRETBI-NINVRETBN-NINVRETBS-NINVRETBX
                                 -NINVRETCC-NINVRETBK-NINVRETBP-NINVRETBU-NINVRETBZ-NINVRETCE-NINVRETBM-NINVRETBR-NINVRETBW-NINVRETCB) , 0) * (1 - V_CNR) ;

NINVENT16 = NINVENT15 + NINVRETBJ + NINVRETBO + NINVRETBT + NINVRETBY + NINVRETCD + NINVRETBI + NINVRETBN + NINVRETBS + NINVRETBX + NINVRETCC 
            + NINVRETBK + NINVRETBP + NINVRETBU + NINVRETBZ + NINVRETCE + NINVRETBM + NINVRETBR + NINVRETBW + NINVRETCB + NINVRETCG ;


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

NINVRETABR = (NINVRETAB - arr(NINVRETAB * TX375/100)) * (1 - V_CNR) ;

NINVRETAGR = (NINVRETAG - arr(NINVRETAG * TX375/100)) * (1 - V_CNR) ;

NINVRETAAR = (NINVRETAA - arr(NINVRETAA * TX4737/100)) * (1 - V_CNR) ;

NINVRETAFR = (NINVRETAF - arr(NINVRETAF * TX4737/100)) * (1 - V_CNR) ;

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

NINVRETALR = (NINVRETAL - arr(NINVRETAL * TX375/100)) * (1 - V_CNR) ;

NINVRETAQR = (NINVRETAQ - arr(NINVRETAQ * TX375/100)) * (1 - V_CNR) ;

NINVRETAVR = (NINVRETAV - arr(NINVRETAV * TX375/100)) * (1 - V_CNR) ;

NINVRETBBR = (NINVRETBB - arr(NINVRETBB * TX375/100)) * (1 - V_CNR) ;

NINVRETAKR = (NINVRETAK - arr(NINVRETAK * TX4737/100)) * (1 - V_CNR) ;

NINVRETAPR = (NINVRETAP - arr(NINVRETAP * TX4737/100)) * (1 - V_CNR) ;

NINVRETAUR = (NINVRETAU - arr(NINVRETAU * TX4737/100)) * (1 - V_CNR) ;

NINVRETBAR = (NINVRETBA - arr(NINVRETBA * TX4737/100)) * (1 - V_CNR) ;

NINVRETBJR = (NINVRETBJ - arr(NINVRETBJ * TX375/100)) * (1 - V_CNR) ;

NINVRETBOR = (NINVRETBO - arr(NINVRETBO * TX375/100)) * (1 - V_CNR) ;

NINVRETBIR = (NINVRETBI - arr(NINVRETBI * TX4737/100)) * (1 - V_CNR) ;

NINVRETBNR = (NINVRETBN - arr(NINVRETBN * TX4737/100)) * (1 - V_CNR) ;

NINVRETBTR = (NINVRETBT - arr(NINVRETBT * TX375/100)) * (1 - V_CNR) ;

NINVRETBYR = (NINVRETBY - arr(NINVRETBY * TX375/100)) * (1 - V_CNR) ;

NINVRETCDR = (NINVRETCD - arr(NINVRETCD * TX34/100)) * (1 - V_CNR) ;

NINVRETBSR = (NINVRETBS - arr(NINVRETBS * TX4737/100)) * (1 - V_CNR) ;

NINVRETBXR = (NINVRETBX - arr(NINVRETBX * TX4737/100)) * (1 - V_CNR) ;

NINVRETCCR = (NINVRETCC - arr(NINVRETCC * TX44/100)) * (1 - V_CNR) ;

regle 402080:
application : iliad, batch ;


INVRETMN = NINVRETMN * (1 - V_CNR) ;

INVRETQE = NINVRETQE * (1 - V_CNR) ;

INVRETQV = NINVRETQV * (1 - V_CNR) ;

INVRETMB = min(arr(NINVRETMB * TX40 / 100) , max(0 , PLAF_INVDOM -INVRETSOC)) * (1 - V_CNR) ;

INVRETMC = min(arr(NINVRETMC * TX40 / 100) , max(0 , PLAF_INVDOM -INVRETSOC-INVRETMB)) * (1 - V_CNR) ;

INVRETLH = min(arr(NINVRETLH * TX50 / 100) , max(0 , PLAF_INVDOM -INVRETSOC-INVRETMB-INVRETMC)) * (1 - V_CNR) ;

INVRETLI = min(arr(NINVRETLI * TX50 / 100) , max(0 , PLAF_INVDOM -INVRETSOC-INVRETMB-INVRETMC-INVRETLH)) * (1 - V_CNR) ;

INVRETQP = min(arr(NINVRETQP * TX40 / 100) , max(0 , PLAF_INVDOM -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI)) * (1 - V_CNR) ;

INVRETQG = min(arr(NINVRETQG * TX40 / 100) , max(0 , PLAF_INVDOM -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP)) * (1 - V_CNR) ;

INVRETQO = min(arr(NINVRETQO * TX50 / 100) , max(0 , PLAF_INVDOM -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG)) * (1 - V_CNR) ;

INVRETQF = min(arr(NINVRETQF * TX50 / 100) , max(0 , PLAF_INVDOM -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO)) * (1 - V_CNR) ;

INVRETPB = min(arr(NINVRETPB * TX375/ 100) , max(0 , PLAF_INVDOM3 -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF)) * (1 - V_CNR) ;

INVRETPF = min(arr(NINVRETPF * TX375/ 100) , max(0 , PLAF_INVDOM3 -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF
                                                                  -INVRETPB)) * (1 - V_CNR) ;

INVRETPJ = min(arr(NINVRETPJ * TX375/ 100) , max(0 , PLAF_INVDOM3 -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF
                                                                  -INVRETPB-INVRETPF)) * (1 - V_CNR) ;

INVRETPA = min(arr(NINVRETPA * TX4737/100) , max(0 , PLAF_INVDOM3 -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF
                                                                  -INVRETPB-INVRETPF-INVRETPJ)) * (1 - V_CNR) ;

INVRETPE = min(arr(NINVRETPE * TX4737/100) , max(0 , PLAF_INVDOM3 -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF
                                                                  -INVRETPB-INVRETPF-INVRETPJ-INVRETPA)) * (1 - V_CNR) ;

INVRETPI = min(arr(NINVRETPI * TX4737/100) , max(0 , PLAF_INVDOM3 -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF
                                                                  -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE)) * (1 - V_CNR) ;

INVRETPO = min(arr(NINVRETPO * TX40/100) , max(0 , PLAF_INVDOM -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF
                                                               -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI)) * (1 - V_CNR) ;

INVRETPT = min(arr(NINVRETPT * TX40/100) , max(0 , PLAF_INVDOM -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF
                                                               -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO)) * (1 - V_CNR) ;

INVRETPY = min(arr(NINVRETPY * TX375/100) , max(0 , PLAF_INVDOM3 -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF
                                                                 -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT)) * (1 - V_CNR) ;

INVRETRL = min(arr(NINVRETRL * TX375/100) , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF
                                                                 -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY)) * (1 - V_CNR) ;

INVRETRQ = min(arr(NINVRETRQ * TX375/100) , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF
                                                                 -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                 -INVRETRL)) * (1 - V_CNR) ;

INVRETRV = min(arr(NINVRETRV * TX375/100) , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF
                                                                 -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                 -INVRETRL-INVRETRQ)) * (1 - V_CNR) ;

INVRETNV = min(arr(NINVRETNV * TX375/100) , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF
                                                                 -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                 -INVRETRL-INVRETRQ-INVRETRV)) * (1 - V_CNR) ;

INVRETPN = min(arr(NINVRETPN * TX50/100) , max(0 , PLAF_INVDOM -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF
                                                               -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                               -INVRETRL-INVRETRQ-INVRETRV-INVRETNV)) * (1 - V_CNR) ;

INVRETPS = min(arr(NINVRETPS * TX50/100) , max(0 , PLAF_INVDOM -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF
                                                               -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                               -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN)) * (1 - V_CNR) ;

INVRETPX = min(arr(NINVRETPX * TX4737/100) , max(0 , PLAF_INVDOM3 -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF
                                                                  -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                  -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS)) * (1 - V_CNR) ;

INVRETRK = min(arr(NINVRETRK * TX4737/100) , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF
                                                                  -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                  -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX)) * (1 - V_CNR) ;

INVRETRP = min(arr(NINVRETRP * TX4737/100) , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF
                                                                  -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                  -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK)) * (1 - V_CNR) ;

INVRETRU = min(arr(NINVRETRU * TX4737/100) , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF
                                                                  -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                  -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP)) * (1 - V_CNR) ;

INVRETNU = min(arr(NINVRETNU * TX4737/100) , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF
                                                                  -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                  -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP
                                                                  -INVRETRU)) * (1 - V_CNR) ;

INVRETSB = min(arr(NINVRETSB * TX375/100) , max(0 , PLAF_INVDOM3 -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF
                                                                 -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                 -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP
                                                                 -INVRETRU-INVRETNU)) * (1 - V_CNR) ;

INVRETSG = min(arr(NINVRETSG * TX375/100) , max(0 , PLAF_INVDOM3 -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF
                                                                 -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                 -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP
                                                                 -INVRETRU-INVRETNU-INVRETSB)) * (1 - V_CNR) ;

INVRETSL = min(arr(NINVRETSL * TX375/100) , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF
                                                                 -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                 -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP
                                                                 -INVRETRU-INVRETNU-INVRETSB-INVRETSG)) * (1 - V_CNR) ;

INVRETSQ = min(arr(NINVRETSQ * TX375/100) , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF
                                                                 -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                 -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP
                                                                 -INVRETRU-INVRETNU-INVRETSB-INVRETSG-INVRETSL)) * (1 - V_CNR) ;

INVRETSV = min(arr(NINVRETSV * TX375/100) , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF
                                                                 -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                 -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP
                                                                 -INVRETRU-INVRETNU-INVRETSB-INVRETSG-INVRETSL-INVRETSQ)) * (1 - V_CNR) ;

INVRETTA = min(arr(NINVRETTA * TX375/100) , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF
                                                                 -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                 -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP
                                                                 -INVRETRU-INVRETNU-INVRETSB-INVRETSG-INVRETSL-INVRETSQ-INVRETSV)) * (1 - V_CNR) ;

INVRETSA = min(arr(NINVRETSA * TX4737/100) , max(0 , PLAF_INVDOM3 -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF
                                                                  -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                  -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP
                                                                  -INVRETRU-INVRETNU-INVRETSB-INVRETSG-INVRETSL-INVRETSQ-INVRETSV-INVRETTA)) * (1 - V_CNR) ;

INVRETSF = min(arr(NINVRETSF * TX4737/100) , max(0 , PLAF_INVDOM3 -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF
                                                                  -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                  -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP
                                                                  -INVRETRU-INVRETNU-INVRETSB-INVRETSG-INVRETSL-INVRETSQ-INVRETSV-INVRETTA-INVRETSA)) * (1 - V_CNR) ;

INVRETSK = min(arr(NINVRETSK * TX4737/100) , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF
                                                                  -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                  -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP
                                                                  -INVRETRU-INVRETNU-INVRETSB-INVRETSG-INVRETSL-INVRETSQ-INVRETSV-INVRETTA-INVRETSA
                                                                  -INVRETSF)) * (1 - V_CNR) ;

INVRETSP = min(arr(NINVRETSP * TX4737/100) , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF
                                                                  -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                  -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP
                                                                  -INVRETRU-INVRETNU-INVRETSB-INVRETSG-INVRETSL-INVRETSQ-INVRETSV-INVRETTA-INVRETSA
                                                                  -INVRETSF-INVRETSK)) * (1 - V_CNR) ;

INVRETSU = min(arr(NINVRETSU * TX4737/100) , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF
                                                                  -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                  -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP
                                                                  -INVRETRU-INVRETNU-INVRETSB-INVRETSG-INVRETSL-INVRETSQ-INVRETSV-INVRETTA-INVRETSA
                                                                  -INVRETSF-INVRETSK-INVRETSP)) * (1 - V_CNR) ;

INVRETSZ = min(arr(NINVRETSZ * TX4737/100) , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF
                                                                  -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                  -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP
                                                                  -INVRETRU-INVRETNU-INVRETSB-INVRETSG-INVRETSL-INVRETSQ-INVRETSV-INVRETTA-INVRETSA
                                                                  -INVRETSF-INVRETSK-INVRETSP-INVRETSU)) * (1 - V_CNR) ;

INVRETAB = min(arr(NINVRETAB * TX375/100) , max(0 , PLAF_INVDOM3 -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF
                                                                 -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                 -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP
                                                                 -INVRETRU-INVRETNU-INVRETSB-INVRETSG-INVRETSL-INVRETSQ-INVRETSV-INVRETTA-INVRETSA
                                                                 -INVRETSF-INVRETSK-INVRETSP-INVRETSU-INVRETSZ)) * (1 - V_CNR) ;

INVRETAG = min(arr(NINVRETAG * TX375/100) , max(0 , PLAF_INVDOM3 -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF
                                                                 -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                 -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP
                                                                 -INVRETRU-INVRETNU-INVRETSB-INVRETSG-INVRETSL-INVRETSQ-INVRETSV-INVRETTA-INVRETSA
                                                                 -INVRETSF-INVRETSK-INVRETSP-INVRETSU-INVRETSZ-INVRETAB)) * (1 - V_CNR) ;

INVRETAL = min(arr(NINVRETAL * TX375/100) , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF
                                                                 -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                 -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP
                                                                 -INVRETRU-INVRETNU-INVRETSB-INVRETSG-INVRETSL-INVRETSQ-INVRETSV-INVRETTA-INVRETSA
                                                                 -INVRETSF-INVRETSK-INVRETSP-INVRETSU-INVRETSZ-INVRETAB-INVRETAG)) * (1 - V_CNR) ;

INVRETAQ = min(arr(NINVRETAQ * TX375/100) , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF
                                                                 -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                 -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP
                                                                 -INVRETRU-INVRETNU-INVRETSB-INVRETSG-INVRETSL-INVRETSQ-INVRETSV-INVRETTA-INVRETSA
                                                                 -INVRETSF-INVRETSK-INVRETSP-INVRETSU-INVRETSZ-INVRETAB-INVRETAG-INVRETAL)) * (1 - V_CNR) ;

INVRETAV = min(arr(NINVRETAV * TX375/100) , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF
                                                                 -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                 -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP
                                                                 -INVRETRU-INVRETNU-INVRETSB-INVRETSG-INVRETSL-INVRETSQ-INVRETSV-INVRETTA-INVRETSA
                                                                 -INVRETSF-INVRETSK-INVRETSP-INVRETSU-INVRETSZ-INVRETAB-INVRETAG-INVRETAL-INVRETAQ)) * (1 - V_CNR) ;

INVRETBB = min(arr(NINVRETBB * TX375/100) , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF
                                                                 -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                 -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP
                                                                 -INVRETRU-INVRETNU-INVRETSB-INVRETSG-INVRETSL-INVRETSQ-INVRETSV-INVRETTA-INVRETSA
                                                                 -INVRETSF-INVRETSK-INVRETSP-INVRETSU-INVRETSZ-INVRETAB-INVRETAG-INVRETAL-INVRETAQ
                                                                 -INVRETAV)) * (1 - V_CNR) ;

INVRETAA = min(arr(NINVRETAA * TX4737/100) , max(0 , PLAF_INVDOM3 -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF
                                                                  -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                  -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP
                                                                  -INVRETRU-INVRETNU-INVRETSB-INVRETSG-INVRETSL-INVRETSQ-INVRETSV-INVRETTA-INVRETSA
                                                                  -INVRETSF-INVRETSK-INVRETSP-INVRETSU-INVRETSZ-INVRETAB-INVRETAG-INVRETAL-INVRETAQ
                                                                  -INVRETAV-INVRETBB)) * (1 - V_CNR) ;

INVRETAF = min(arr(NINVRETAF * TX4737/100) , max(0 , PLAF_INVDOM3 -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF
                                                                  -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                  -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP
                                                                  -INVRETRU-INVRETNU-INVRETSB-INVRETSG-INVRETSL-INVRETSQ-INVRETSV-INVRETTA-INVRETSA
                                                                  -INVRETSF-INVRETSK-INVRETSP-INVRETSU-INVRETSZ-INVRETAB-INVRETAG-INVRETAL-INVRETAQ
                                                                  -INVRETAV-INVRETBB-INVRETAA)) * (1 - V_CNR) ;

INVRETAK = min(arr(NINVRETAK * TX4737/100) , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF
                                                                  -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                  -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP
                                                                  -INVRETRU-INVRETNU-INVRETSB-INVRETSG-INVRETSL-INVRETSQ-INVRETSV-INVRETTA-INVRETSA
                                                                  -INVRETSF-INVRETSK-INVRETSP-INVRETSU-INVRETSZ-INVRETAB-INVRETAG-INVRETAL-INVRETAQ
                                                                  -INVRETAV-INVRETBB-INVRETAA-INVRETAF)) * (1 - V_CNR) ;

INVRETAP = min(arr(NINVRETAP * TX4737/100) , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF
                                                                  -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                  -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP
                                                                  -INVRETRU-INVRETNU-INVRETSB-INVRETSG-INVRETSL-INVRETSQ-INVRETSV-INVRETTA-INVRETSA
                                                                  -INVRETSF-INVRETSK-INVRETSP-INVRETSU-INVRETSZ-INVRETAB-INVRETAG-INVRETAL-INVRETAQ
                                                                  -INVRETAV-INVRETBB-INVRETAA-INVRETAF-INVRETAK)) * (1 - V_CNR) ;

INVRETAU = min(arr(NINVRETAU * TX4737/100) , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF
                                                                  -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                  -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP
                                                                  -INVRETRU-INVRETNU-INVRETSB-INVRETSG-INVRETSL-INVRETSQ-INVRETSV-INVRETTA-INVRETSA
                                                                  -INVRETSF-INVRETSK-INVRETSP-INVRETSU-INVRETSZ-INVRETAB-INVRETAG-INVRETAL-INVRETAQ
                                                                  -INVRETAV-INVRETBB-INVRETAA-INVRETAF-INVRETAK-INVRETAP)) * (1 - V_CNR) ;

INVRETBA = min(arr(NINVRETBA * TX4737/100) , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF
                                                                  -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY
                                                                  -INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP
                                                                  -INVRETRU-INVRETNU-INVRETSB-INVRETSG-INVRETSL-INVRETSQ-INVRETSV-INVRETTA-INVRETSA
                                                                  -INVRETSF-INVRETSK-INVRETSP-INVRETSU-INVRETSZ-INVRETAB-INVRETAG-INVRETAL-INVRETAQ
                                                                  -INVRETAV-INVRETBB-INVRETAA-INVRETAF-INVRETAK-INVRETAP-INVRETAU)) * (1 - V_CNR) ;

INVENT15 = INVRETSOC + INVRETMB + INVRETMC + INVRETLH + INVRETLI + INVRETQP + INVRETQG + INVRETQO + INVRETQF + INVRETPB + INVRETPF 
           + INVRETPJ + INVRETPA + INVRETPE + INVRETPI + INVRETPO + INVRETPT + INVRETPY + INVRETRL + INVRETRQ + INVRETRV + INVRETNV + INVRETPN + INVRETPS 
           + INVRETPX + INVRETRK + INVRETRP + INVRETRU + INVRETNU + INVRETSB + INVRETSG + INVRETSL + INVRETSQ + INVRETSV + INVRETTA + INVRETSA + INVRETSF 
           + INVRETSK + INVRETSP + INVRETSU + INVRETSZ + INVRETAB + INVRETAG + INVRETAL + INVRETAQ + INVRETAV + INVRETBB + INVRETAA + INVRETAF + INVRETAK 
           + INVRETAP + INVRETAU + INVRETBA ;

INVRETBJ = min(arr(NINVRETBJ * TX375/100) , max(0 , PLAF_INVDOM4 -INVENT15)) * (1 - V_CNR) ;

INVRETBO = min(arr(NINVRETBO * TX375/100) , max(0 , PLAF_INVDOM4 -INVENT15-INVRETBJ)) * (1 - V_CNR) ;

INVRETBT = min(arr(NINVRETBT * TX375/100) , max(0 , PLAF_INVDOM4 -INVENT15-INVRETBJ-INVRETBO)) * (1 - V_CNR) ;

INVRETBY = min(arr(NINVRETBY * TX375/100) , max(0 , PLAF_INVDOM4 -INVENT15-INVRETBJ-INVRETBO-INVRETBT)) * (1 - V_CNR) ;

INVRETCD = min(arr(NINVRETCD * TX34/100) , max(0 , PLAF_INVDOM4 -INVENT15-INVRETBJ-INVRETBO-INVRETBT-INVRETBY)) * (1 - V_CNR) ;

INVRETBI = min(arr(NINVRETBI * TX4737/100) , max(0 , PLAF_INVDOM4 -INVENT15-INVRETBJ-INVRETBO-INVRETBT-INVRETBY-INVRETCD)) * (1 - V_CNR) ;

INVRETBN = min(arr(NINVRETBN * TX4737/100) , max(0 , PLAF_INVDOM4 -INVENT15-INVRETBJ-INVRETBO-INVRETBT-INVRETBY-INVRETCD-INVRETBI)) * (1 - V_CNR) ;

INVRETBS = min(arr(NINVRETBS * TX4737/100) , max(0 , PLAF_INVDOM4 -INVENT15-INVRETBJ-INVRETBO-INVRETBT-INVRETBY-INVRETCD-INVRETBI-INVRETBN)) * (1 - V_CNR) ;

INVRETBX = min(arr(NINVRETBX * TX4737/100) , max(0 , PLAF_INVDOM4 -INVENT15-INVRETBJ-INVRETBO-INVRETBT-INVRETBY-INVRETCD-INVRETBI-INVRETBN-INVRETBS)) * (1 - V_CNR) ;

INVRETCC = min(arr(NINVRETCC * TX44/100) , max(0 , PLAF_INVDOM4 -INVENT15-INVRETBJ-INVRETBO-INVRETBT-INVRETBY-INVRETCD-INVRETBI-INVRETBN-INVRETBS-INVRETBX)) * (1 - V_CNR) ;

INVRETPP = min(NINVRETPP , max(0 , PLAF_INVDOM -INVENT15-INVRETBJ-INVRETBO-INVRETBT-INVRETBY-INVRETCD-INVRETBI-INVRETBN-INVRETBS-INVRETBX-INVRETCC)) * (1 - V_CNR) ;

INVRETPU = min(NINVRETPU , max(0 , PLAF_INVDOM -INVENT15-INVRETBJ-INVRETBO-INVRETBT-INVRETBY-INVRETCD-INVRETBI-INVRETBN-INVRETBS-INVRETBX-INVRETCC-INVRETPP)) * (1 - V_CNR) ;

INVRETRG = min(NINVRETRG , max(0 , PLAF_INVDOM3 -INVENT15-INVRETBJ-INVRETBO-INVRETBT-INVRETBY-INVRETCD-INVRETBI-INVRETBN-INVRETBS-INVRETBX-INVRETCC-INVRETPP
                                                -INVRETPU)) * (1 - V_CNR) ;

INVRETRM = min(NINVRETRM , max(0 , PLAF_INVDOM4 -INVENT15-INVRETBJ-INVRETBO-INVRETBT-INVRETBY-INVRETCD-INVRETBI-INVRETBN-INVRETBS-INVRETBX-INVRETCC-INVRETPP
                                                -INVRETPU-INVRETRG)) * (1 - V_CNR) ;

INVRETRR = min(NINVRETRR , max(0 , PLAF_INVDOM4 -INVENT15-INVRETBJ-INVRETBO-INVRETBT-INVRETBY-INVRETCD-INVRETBI-INVRETBN-INVRETBS-INVRETBX-INVRETCC-INVRETPP
                                                -INVRETPU-INVRETRG-INVRETRM)) * (1 - V_CNR) ;

INVRETRW = min(NINVRETRW , max(0 , PLAF_INVDOM4 -INVENT15-INVRETBJ-INVRETBO-INVRETBT-INVRETBY-INVRETCD-INVRETBI-INVRETBN-INVRETBS-INVRETBX-INVRETCC-INVRETPP
                                                -INVRETPU-INVRETRG-INVRETRM-INVRETRR)) * (1 - V_CNR) ;

INVRETNW = min(NINVRETNW , max(0 , PLAF_INVDOM4 -INVENT15-INVRETBJ-INVRETBO-INVRETBT-INVRETBY-INVRETCD-INVRETBI-INVRETBN-INVRETBS-INVRETBX-INVRETCC-INVRETPP
                                                -INVRETPU-INVRETRG-INVRETRM-INVRETRR-INVRETRW)) * (1 - V_CNR) ;

INVRETSC = min(NINVRETSC , max(0 , PLAF_INVDOM3 -INVENT15-INVRETBJ-INVRETBO-INVRETBT-INVRETBY-INVRETCD-INVRETBI-INVRETBN-INVRETBS-INVRETBX-INVRETCC-INVRETPP
                                                -INVRETPU-INVRETRG-INVRETRM-INVRETRR-INVRETRW-INVRETNW)) * (1 - V_CNR) ;

INVRETSH = min(NINVRETSH , max(0 , PLAF_INVDOM3 -INVENT15-INVRETBJ-INVRETBO-INVRETBT-INVRETBY-INVRETCD-INVRETBI-INVRETBN-INVRETBS-INVRETBX-INVRETCC-INVRETPP
                                                -INVRETPU-INVRETRG-INVRETRM-INVRETRR-INVRETRW-INVRETNW-INVRETSC)) * (1 - V_CNR) ;

INVRETSM = min(NINVRETSM , max(0 , PLAF_INVDOM4 -INVENT15-INVRETBJ-INVRETBO-INVRETBT-INVRETBY-INVRETCD-INVRETBI-INVRETBN-INVRETBS-INVRETBX-INVRETCC-INVRETPP
                                                -INVRETPU-INVRETRG-INVRETRM-INVRETRR-INVRETRW-INVRETNW-INVRETSC-INVRETSH)) * (1 - V_CNR) ;

INVRETSR = min(NINVRETSR , max(0 , PLAF_INVDOM4 -INVENT15-INVRETBJ-INVRETBO-INVRETBT-INVRETBY-INVRETCD-INVRETBI-INVRETBN-INVRETBS-INVRETBX-INVRETCC-INVRETPP
                                                -INVRETPU-INVRETRG-INVRETRM-INVRETRR-INVRETRW-INVRETNW-INVRETSC-INVRETSH-INVRETSM)) * (1 - V_CNR) ;

INVRETSW = min(NINVRETSW , max(0 , PLAF_INVDOM4 -INVENT15-INVRETBJ-INVRETBO-INVRETBT-INVRETBY-INVRETCD-INVRETBI-INVRETBN-INVRETBS-INVRETBX-INVRETCC-INVRETPP
                                                -INVRETPU-INVRETRG-INVRETRM-INVRETRR-INVRETRW-INVRETNW-INVRETSC-INVRETSH-INVRETSM-INVRETSR)) * (1 - V_CNR) ;

INVRETTB = min(NINVRETTB , max(0 , PLAF_INVDOM4 -INVENT15-INVRETBJ-INVRETBO-INVRETBT-INVRETBY-INVRETCD-INVRETBI-INVRETBN-INVRETBS-INVRETBX-INVRETCC-INVRETPP
                                                -INVRETPU-INVRETRG-INVRETRM-INVRETRR-INVRETRW-INVRETNW-INVRETSC-INVRETSH-INVRETSM-INVRETSR-INVRETSW)) * (1 - V_CNR) ;

INVRETAC = min(NINVRETAC , max(0 , PLAF_INVDOM3 -INVENT15-INVRETBJ-INVRETBO-INVRETBT-INVRETBY-INVRETCD-INVRETBI-INVRETBN-INVRETBS-INVRETBX-INVRETCC-INVRETPP
                                                -INVRETPU-INVRETRG-INVRETRM-INVRETRR-INVRETRW-INVRETNW-INVRETSC-INVRETSH-INVRETSM-INVRETSR-INVRETSW-INVRETTB)) * (1 - V_CNR) ;

INVRETAH = min(NINVRETAH , max(0 , PLAF_INVDOM3 -INVENT15-INVRETBJ-INVRETBO-INVRETBT-INVRETBY-INVRETCD-INVRETBI-INVRETBN-INVRETBS-INVRETBX-INVRETCC-INVRETPP
                                                -INVRETPU-INVRETRG-INVRETRM-INVRETRR-INVRETRW-INVRETNW-INVRETSC-INVRETSH-INVRETSM-INVRETSR-INVRETSW-INVRETTB
                                                -INVRETAC)) * (1 - V_CNR) ;

INVRETAM = min(NINVRETAM , max(0 , PLAF_INVDOM4 -INVENT15-INVRETBJ-INVRETBO-INVRETBT-INVRETBY-INVRETCD-INVRETBI-INVRETBN-INVRETBS-INVRETBX-INVRETCC-INVRETPP
                                                -INVRETPU-INVRETRG-INVRETRM-INVRETRR-INVRETRW-INVRETNW-INVRETSC-INVRETSH-INVRETSM-INVRETSR-INVRETSW-INVRETTB
                                                -INVRETAC-INVRETAH)) * (1 - V_CNR) ;

INVRETAR = min(NINVRETAR , max(0 , PLAF_INVDOM4 -INVENT15-INVRETBJ-INVRETBO-INVRETBT-INVRETBY-INVRETCD-INVRETBI-INVRETBN-INVRETBS-INVRETBX-INVRETCC-INVRETPP
                                                -INVRETPU-INVRETRG-INVRETRM-INVRETRR-INVRETRW-INVRETNW-INVRETSC-INVRETSH-INVRETSM-INVRETSR-INVRETSW-INVRETTB
                                                -INVRETAC-INVRETAH-INVRETAM)) * (1 - V_CNR) ;

INVRETAW = min(NINVRETAW , max(0 , PLAF_INVDOM4 -INVENT15-INVRETBJ-INVRETBO-INVRETBT-INVRETBY-INVRETCD-INVRETBI-INVRETBN-INVRETBS-INVRETBX-INVRETCC-INVRETPP
                                                -INVRETPU-INVRETRG-INVRETRM-INVRETRR-INVRETRW-INVRETNW-INVRETSC-INVRETSH-INVRETSM-INVRETSR-INVRETSW-INVRETTB
                                                -INVRETAC-INVRETAH-INVRETAM-INVRETAR)) * (1 - V_CNR) ;

INVRETBE = min(NINVRETBE , max(0 , PLAF_INVDOM4 -INVENT15-INVRETBJ-INVRETBO-INVRETBT-INVRETBY-INVRETCD-INVRETBI-INVRETBN-INVRETBS-INVRETBX-INVRETCC-INVRETPP
                                                -INVRETPU-INVRETRG-INVRETRM-INVRETRR-INVRETRW-INVRETNW-INVRETSC-INVRETSH-INVRETSM-INVRETSR-INVRETSW-INVRETTB
                                                -INVRETAC-INVRETAH-INVRETAM-INVRETAR-INVRETAW)) * (1 - V_CNR) ;

INVRETBK = min(NINVRETBK , max(0 , PLAF_INVDOM4 -INVENT15-INVRETBJ-INVRETBO-INVRETBT-INVRETBY-INVRETCD-INVRETBI-INVRETBN-INVRETBS-INVRETBX-INVRETCC-INVRETPP
                                                -INVRETPU-INVRETRG-INVRETRM-INVRETRR-INVRETRW-INVRETNW-INVRETSC-INVRETSH-INVRETSM-INVRETSR-INVRETSW-INVRETTB
                                                -INVRETAC-INVRETAH-INVRETAM-INVRETAR-INVRETAW-INVRETBE)) * (1 - V_CNR) ;

INVRETBP = min(NINVRETBP , max(0 , PLAF_INVDOM4 -INVENT15-INVRETBJ-INVRETBO-INVRETBT-INVRETBY-INVRETCD-INVRETBI-INVRETBN-INVRETBS-INVRETBX-INVRETCC-INVRETPP
                                                -INVRETPU-INVRETRG-INVRETRM-INVRETRR-INVRETRW-INVRETNW-INVRETSC-INVRETSH-INVRETSM-INVRETSR-INVRETSW-INVRETTB
                                                -INVRETAC-INVRETAH-INVRETAM-INVRETAR-INVRETAW-INVRETBE-INVRETBK)) * (1 - V_CNR) ;

INVRETBU = min(NINVRETBU , max(0 , PLAF_INVDOM4 -INVENT15-INVRETBJ-INVRETBO-INVRETBT-INVRETBY-INVRETCD-INVRETBI-INVRETBN-INVRETBS-INVRETBX-INVRETCC-INVRETPP
                                                -INVRETPU-INVRETRG-INVRETRM-INVRETRR-INVRETRW-INVRETNW-INVRETSC-INVRETSH-INVRETSM-INVRETSR-INVRETSW-INVRETTB
                                                -INVRETAC-INVRETAH-INVRETAM-INVRETAR-INVRETAW-INVRETBE-INVRETBK-INVRETBP)) * (1 - V_CNR) ;

INVRETBZ = min(NINVRETBZ , max(0 , PLAF_INVDOM4 -INVENT15-INVRETBJ-INVRETBO-INVRETBT-INVRETBY-INVRETCD-INVRETBI-INVRETBN-INVRETBS-INVRETBX-INVRETCC-INVRETPP
                                                -INVRETPU-INVRETRG-INVRETRM-INVRETRR-INVRETRW-INVRETNW-INVRETSC-INVRETSH-INVRETSM-INVRETSR-INVRETSW-INVRETTB
                                                -INVRETAC-INVRETAH-INVRETAM-INVRETAR-INVRETAW-INVRETBE-INVRETBK-INVRETBP-INVRETBU)) * (1 - V_CNR) ;

INVRETCE = min(NINVRETCE , max(0 , PLAF_INVDOM4 -INVENT15-INVRETBJ-INVRETBO-INVRETBT-INVRETBY-INVRETCD-INVRETBI-INVRETBN-INVRETBS-INVRETBX-INVRETCC-INVRETPP
                                                -INVRETPU-INVRETRG-INVRETRM-INVRETRR-INVRETRW-INVRETNW-INVRETSC-INVRETSH-INVRETSM-INVRETSR-INVRETSW-INVRETTB
                                                -INVRETAC-INVRETAH-INVRETAM-INVRETAR-INVRETAW-INVRETBE-INVRETBK-INVRETBP-INVRETBU-INVRETBZ)) * (1 - V_CNR) ;

INVRETENT = INVRETMB + INVRETMC + INVRETLH + INVRETLI + INVRETQP + INVRETQG + INVRETQO + INVRETQF + INVRETPB + INVRETPF + INVRETPJ 
            + INVRETPA + INVRETPE + INVRETPI + INVRETPO + INVRETPT + INVRETPY + INVRETRL + INVRETRQ + INVRETRV + INVRETNV + INVRETPN + INVRETPS + INVRETPX 
            + INVRETRK + INVRETRP + INVRETRU + INVRETNU + INVRETSB + INVRETSG + INVRETSL + INVRETSQ + INVRETSV + INVRETTA + INVRETSA + INVRETSF + INVRETSK 
            + INVRETSP + INVRETSU + INVRETSZ + INVRETAB + INVRETAG + INVRETAL + INVRETAQ + INVRETAV + INVRETBB + INVRETAA + INVRETAF + INVRETAK + INVRETAP 
            + INVRETAU + INVRETBA + INVRETBJ + INVRETBO + INVRETBT + INVRETBY + INVRETCD + INVRETBI + INVRETBN + INVRETBS + INVRETBX + INVRETCC + INVRETPP 
            + INVRETPU + INVRETRG + INVRETRM + INVRETRR + INVRETRW + INVRETNW + INVRETSC + INVRETSH + INVRETSM + INVRETSR + INVRETSW + INVRETTB + INVRETAC 
            + INVRETAH + INVRETAM + INVRETAR + INVRETAW + INVRETBE + INVRETBK + INVRETBP + INVRETBU + INVRETBZ + INVRETCE ;

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

INVRETAE = NINVRETAE * (1 - V_CNR) ;

INVRETAJ = NINVRETAJ * (1 - V_CNR) ;

INVRETAO = NINVRETAO * (1 - V_CNR) ;

INVRETAT = NINVRETAT * (1 - V_CNR) ;

INVRETAY = NINVRETAY * (1 - V_CNR) ;

INVRETBG = NINVRETBG * (1 - V_CNR) ;

INVRETBM = NINVRETBM * (1 - V_CNR) ;

INVRETBR = NINVRETBR * (1 - V_CNR) ;

INVRETBW = NINVRETBW * (1 - V_CNR) ;

INVRETCB = NINVRETCB * (1 - V_CNR) ;

INVRETCG = NINVRETCG * (1 - V_CNR) ;


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

INVRETABR = (min(arr(INVRETAB * 5/3) , NINVRETAB - INVRETAB) * (1 - null(1 - abs(arr(INVRETAB * 5/3) - (NINVRETAB - INVRETAB))))
             + (NINVRETAB - INVRETAB) * null(1 - abs(arr(INVRETAB * 5/3) - (NINVRETAB - INVRETAB))))
            * (1 - V_CNR) ; 

INVRETAGR = (min(arr(INVRETAG * 5/3) , NINVRETAG - INVRETAG) * (1 - null(1 - abs(arr(INVRETAG * 5/3) - (NINVRETAG - INVRETAG))))
             + (NINVRETAG - INVRETAG) * null(1 - abs(arr(INVRETAG * 5/3) - (NINVRETAG - INVRETAG))))
            * (1 - V_CNR) ; 

INVRETALR = (min(arr(INVRETAL * 5/3) , NINVRETAL - INVRETAL) * (1 - null(1 - abs(arr(INVRETAL * 5/3) - (NINVRETAL - INVRETAL))))
             + (NINVRETAL - INVRETAL) * null(1 - abs(arr(INVRETAL * 5/3) - (NINVRETAL - INVRETAL))))
            * (1 - V_CNR) ; 

INVRETAQR = (min(arr(INVRETAQ * 5/3) , NINVRETAQ - INVRETAQ) * (1 - null(1 - abs(arr(INVRETAQ * 5/3) - (NINVRETAQ - INVRETAQ))))
             + (NINVRETAQ - INVRETAQ) * null(1 - abs(arr(INVRETAQ * 5/3) - (NINVRETAQ - INVRETAQ))))
            * (1 - V_CNR) ; 

INVRETAVR = (min(arr(INVRETAV * 5/3) , NINVRETAV - INVRETAV) * (1 - null(1 - abs(arr(INVRETAV * 5/3) - (NINVRETAV - INVRETAV))))
             + (NINVRETAV - INVRETAV) * null(1 - abs(arr(INVRETAV * 5/3) - (NINVRETAV - INVRETAV))))
            * (1 - V_CNR) ; 

INVRETBBR = (min(arr(INVRETBB * 5/3) , NINVRETBB - INVRETBB) * (1 - null(1 - abs(arr(INVRETBB * 5/3) - (NINVRETBB - INVRETBB))))
             + (NINVRETBB - INVRETBB) * null(1 - abs(arr(INVRETBB * 5/3) - (NINVRETBB - INVRETBB))))
            * (1 - V_CNR) ; 

INVRETAAR = (min(arr(INVRETAA * 10/9) , NINVRETAA - INVRETAA) * (1 - null(1 - abs(arr(INVRETAA * 10/9) - (NINVRETAA - INVRETAA))))
             + (NINVRETAA - INVRETAA) * null(1 - abs(arr(INVRETAA * 10/9) - (NINVRETAA - INVRETAA))))
            * (1 - V_CNR) ; 

INVRETAFR = (min(arr(INVRETAF * 10/9) , NINVRETAF - INVRETAF) * (1 - null(1 - abs(arr(INVRETAF * 10/9) - (NINVRETAF - INVRETAF))))
             + (NINVRETAF - INVRETAF) * null(1 - abs(arr(INVRETAF * 10/9) - (NINVRETAF - INVRETAF))))
            * (1 - V_CNR) ; 

INVRETAKR = (min(arr(INVRETAK * 10/9) , NINVRETAK - INVRETAK) * (1 - null(1 - abs(arr(INVRETAK * 10/9) - (NINVRETAK - INVRETAK))))
             + (NINVRETAK - INVRETAK) * null(1 - abs(arr(INVRETAK * 10/9) - (NINVRETAK - INVRETAK))))
            * (1 - V_CNR) ; 

INVRETAPR = (min(arr(INVRETAP * 10/9) , NINVRETAP - INVRETAP) * (1 - null(1 - abs(arr(INVRETAP * 10/9) - (NINVRETAP - INVRETAP))))
             + (NINVRETAP - INVRETAP) * null(1 - abs(arr(INVRETAP * 10/9) - (NINVRETAP - INVRETAP))))
            * (1 - V_CNR) ; 

INVRETAUR = (min(arr(INVRETAU * 10/9) , NINVRETAU - INVRETAU) * (1 - null(1 - abs(arr(INVRETAU * 10/9) - (NINVRETAU - INVRETAU))))
             + (NINVRETAU - INVRETAU) * null(1 - abs(arr(INVRETAU * 10/9) - (NINVRETAU - INVRETAU))))
            * (1 - V_CNR) ; 

INVRETBAR = (min(arr(INVRETBA * 10/9) , NINVRETBA - INVRETBA) * (1 - null(1 - abs(arr(INVRETBA * 10/9) - (NINVRETBA - INVRETBA))))
             + (NINVRETBA - INVRETBA) * null(1 - abs(arr(INVRETBA * 10/9) - (NINVRETBA - INVRETBA))))
            * (1 - V_CNR) ; 

INVRETBJR = (min(arr(INVRETBJ * 5/3) , NINVRETBJ - INVRETBJ) * (1 - null(1 - abs(arr(INVRETBJ * 5/3) - (NINVRETBJ - INVRETBJ))))
             + (NINVRETBJ - INVRETBJ) * null(1 - abs(arr(INVRETBJ * 5/3) - (NINVRETBJ - INVRETBJ))))
            * (1 - V_CNR) ; 

INVRETBOR = (min(arr(INVRETBO * 5/3) , NINVRETBO - INVRETBO) * (1 - null(1 - abs(arr(INVRETBO * 5/3) - (NINVRETBO - INVRETBO))))
             + (NINVRETBO - INVRETBO) * null(1 - abs(arr(INVRETBO * 5/3) - (NINVRETBO - INVRETBO))))
            * (1 - V_CNR) ; 

INVRETBTR = (min(arr(INVRETBT * 5/3) , NINVRETBT - INVRETBT) * (1 - null(1 - abs(arr(INVRETBT * 5/3) - (NINVRETBT - INVRETBT))))
             + (NINVRETBT - INVRETBT) * null(1 - abs(arr(INVRETBT * 5/3) - (NINVRETBT - INVRETBT))))
            * (1 - V_CNR) ; 

INVRETBYR = (min(arr(INVRETBY * 5/3) , NINVRETBY - INVRETBY) * (1 - null(1 - abs(arr(INVRETBY * 5/3) - (NINVRETBY - INVRETBY))))
             + (NINVRETBY - INVRETBY) * null(1 - abs(arr(INVRETBY * 5/3) - (NINVRETBY - INVRETBY))))
            * (1 - V_CNR) ; 

INVRETCDR = (min(arr(INVRETCD * 33/17) , NINVRETCD - INVRETCD) * (1 - null(1 - abs(arr(INVRETCD * 33/17) - (NINVRETCD - INVRETCD))))
             + (NINVRETCD - INVRETCD) * null(1 - abs(arr(INVRETCD * 33/17) - (NINVRETCD - INVRETCD))))
            * (1 - V_CNR) ; 

INVRETBIR = (min(arr(INVRETBI * 10/9) , NINVRETBI - INVRETBI) * (1 - null(1 - abs(arr(INVRETBI * 10/9) - (NINVRETBI - INVRETBI))))
             + (NINVRETBI - INVRETBI) * null(1 - abs(arr(INVRETBI * 10/9) - (NINVRETBI - INVRETBI))))
            * (1 - V_CNR) ; 

INVRETBNR = (min(arr(INVRETBN * 10/9) , NINVRETBN - INVRETBN) * (1 - null(1 - abs(arr(INVRETBN * 10/9) - (NINVRETBN - INVRETBN))))
             + (NINVRETBN - INVRETBN) * null(1 - abs(arr(INVRETBN * 10/9) - (NINVRETBN - INVRETBN))))
            * (1 - V_CNR) ; 

INVRETBSR = (min(arr(INVRETBS * 10/9) , NINVRETBS - INVRETBS) * (1 - null(1 - abs(arr(INVRETBS * 10/9) - (NINVRETBS - INVRETBS))))
             + (NINVRETBS - INVRETBS) * null(1 - abs(arr(INVRETBS * 10/9) - (NINVRETBS - INVRETBS))))
            * (1 - V_CNR) ; 

INVRETBXR = (min(arr(INVRETBX * 10/9) , NINVRETBX - INVRETBX) * (1 - null(1 - abs(arr(INVRETBX * 10/9) - (NINVRETBX - INVRETBX))))
             + (NINVRETBX - INVRETBX) * null(1 - abs(arr(INVRETBX * 10/9) - (NINVRETBX - INVRETBX))))
            * (1 - V_CNR) ; 

INVRETCCR = (min(arr(INVRETCC * 14/11) , NINVRETCC - INVRETCC) * (1 - null(1 - abs(arr(INVRETCC * 14/11) - (NINVRETCC - INVRETCC))))
             + (NINVRETCC - INVRETCC) * null(1 - abs(arr(INVRETCC * 14/11) - (NINVRETCC - INVRETCC))))
            * (1 - V_CNR) ; 

regle 402090:
application : iliad, batch ;

RRIRENT = RRISUP - RLOGSOC - RDOMSOC1 - RCOLENT ;
RRIRENT_1 = RRISUP_1 - RLOGSOC_1 - RDOMSOC1_1 - RCOLENT_1 ;

RENT01_1 = max(min((INVRETBJ * (1 - INDPLAF) + INVRETBJA * INDPLAF) , RRIRENT_1) , 0) * (1 - V_CNR) ;
RENT01 = RENT01_1 * (1-ART1731BIS) + min( RENT01_1 , RENT01_2 ) * ART1731BIS ;

RENT02_1 = max(min((INVRETBO * (1 - INDPLAF) + INVRETBOA * INDPLAF) , RRIRENT_1 - RENT01_1) , 0) * (1 - V_CNR) ;
RENT02 = RENT02_1 * (1-ART1731BIS) + min( RENT02_1 , RENT02_2 ) * ART1731BIS ;

RENT03_1 = max(min((INVRETBT * (1 - INDPLAF) + INVRETBTA * INDPLAF) , RRIRENT_1 - RENT01_1 - RENT02_1) , 0) * (1 - V_CNR) ;
RENT03 = RENT03_1 * (1-ART1731BIS) + min( RENT03_1 , RENT03_2 ) * ART1731BIS ;

RENT04_1 = max(min((INVRETBY * (1 - INDPLAF) + INVRETBYA * INDPLAF) , RRIRENT_1 - RENT01_1 - RENT02_1 - RENT03_1) , 0) * (1 - V_CNR) ;
RENT04 = RENT04_1 * (1-ART1731BIS) + min( RENT04_1 , RENT04_2 ) * ART1731BIS ;

RENT05_1 = max(min((INVRETCD * (1 - INDPLAF) + INVRETCDA * INDPLAF) , RRIRENT_1 - RENT01_1 - RENT02_1 - RENT03_1 - RENT04_1) , 0) * (1 - V_CNR) ;
RENT05 = RENT05_1 * (1-ART1731BIS) + min( RENT05_1 , RENT05_2 ) * ART1731BIS ;

RENT06_1 = max(min((INVRETBI * (1 - INDPLAF) + INVRETBIA * INDPLAF) , RRIRENT_1 - somme(i=1..5 : RENT0i_1)) , 0) * (1 - V_CNR) ;
RENT06 = RENT06_1 * (1-ART1731BIS) + min( RENT06_1 , RENT06_2 ) * ART1731BIS ;

RENT07_1 = max(min((INVRETBN * (1 - INDPLAF) + INVRETBNA * INDPLAF) , RRIRENT_1 - somme(i=1..6 : RENT0i_1)) , 0) * (1 - V_CNR) ;
RENT07 = RENT07_1 * (1-ART1731BIS) + min( RENT07_1 , RENT07_2 ) * ART1731BIS ;

RENT08_1 = max(min((INVRETBS * (1 - INDPLAF) + INVRETBSA * INDPLAF) , RRIRENT_1 - somme(i=1..7 : RENT0i_1)) , 0) * (1 - V_CNR) ;
RENT08 = RENT08_1 * (1-ART1731BIS) + min( RENT08_1 , RENT08_2 ) * ART1731BIS ;

RENT09_1 = max(min((INVRETBX * (1 - INDPLAF) + INVRETBXA * INDPLAF) , RRIRENT_1 - somme(i=1..8 : RENT0i_1)) , 0) * (1 - V_CNR) ;
RENT09 = RENT09_1 * (1-ART1731BIS) + min( RENT09_1 , RENT09_2 ) * ART1731BIS ;

RENT10_1 = max(min((INVRETCC * (1 - INDPLAF) + INVRETCCA * INDPLAF) , RRIRENT_1 - somme(i=1..9 : RENT0i_1)) , 0) * (1 - V_CNR) ;
RENT10 = RENT10_1 * (1-ART1731BIS) + min( RENT10_1 , RENT10_2 ) * ART1731BIS ;

RENT11_1 = max(min((INVRETBK * (1 - INDPLAF) + INVRETBKA * INDPLAF) , RRIRENT_1 - somme(i=1..10 : RENTi_1)) , 0) * (1 - V_CNR) ;
RENT11 = RENT11_1 * (1-ART1731BIS) + min( RENT11_1 , RENT11_2 ) * ART1731BIS ;

RENT12_1 = max(min((INVRETBP * (1 - INDPLAF) + INVRETBPA * INDPLAF) , RRIRENT_1 - somme(i=1..11 : RENTi_1)) , 0) * (1 - V_CNR) ;
RENT12 = RENT12_1 * (1-ART1731BIS) + min( RENT12_1 , RENT12_2 ) * ART1731BIS ;

RENT13_1 = max(min((INVRETBU * (1 - INDPLAF) + INVRETBUA * INDPLAF) , RRIRENT_1 - somme(i=1..12 : RENTi_1)) , 0) * (1 - V_CNR) ;
RENT13 = RENT13_1 * (1-ART1731BIS) + min( RENT13_1 , RENT13_2 ) * ART1731BIS ;

RENT14_1 = max(min((INVRETBZ * (1 - INDPLAF) + INVRETBZA * INDPLAF) , RRIRENT_1 - somme(i=1..13 : RENTi_1)) , 0) * (1 - V_CNR) ;
RENT14 = RENT14_1 * (1-ART1731BIS) + min( RENT14_1 , RENT14_2 ) * ART1731BIS ;

RENT15_1 = max(min((INVRETCE * (1 - INDPLAF) + INVRETCEA * INDPLAF) , RRIRENT_1 - somme(i=1..14 : RENTi_1)) , 0) * (1 - V_CNR) ;
RENT15 = RENT15_1 * (1-ART1731BIS) + min( RENT15_1 , RENT15_2 ) * ART1731BIS ;

RENT16_1 = max(min((INVRETBM * (1 - INDPLAF) + INVRETBMA * INDPLAF) , RRIRENT_1 - somme(i=1..15 : RENTi_1)) , 0) * (1 - V_CNR) ;
RENT16 = RENT16_1 * (1-ART1731BIS) + min( RENT16_1 , RENT16_2 ) * ART1731BIS ;

RENT17_1 = max(min((INVRETBR * (1 - INDPLAF) + INVRETBRA * INDPLAF) , RRIRENT_1 - somme(i=1..16 : RENTi_1)) , 0) * (1 - V_CNR) ;
RENT17 = RENT17_1 * (1-ART1731BIS) + min( RENT17_1 , RENT17_2 ) * ART1731BIS ;

RENT18_1 = max(min((INVRETBW * (1 - INDPLAF) + INVRETBWA * INDPLAF) , RRIRENT_1 - somme(i=1..17 : RENTi_1)) , 0) * (1 - V_CNR) ;
RENT18 = RENT18_1 * (1-ART1731BIS) + min( RENT18_1 , RENT18_2 ) * ART1731BIS ;

RENT19_1 = max(min((INVRETCB * (1 - INDPLAF) + INVRETCBA * INDPLAF) , RRIRENT_1 - somme(i=1..18 : RENTi_1)) , 0) * (1 - V_CNR) ;
RENT19 = RENT19_1 * (1-ART1731BIS) + min( RENT19_1 , RENT19_2 ) * ART1731BIS ;

RENT20_1 = max(min((INVRETCG * (1 - INDPLAF) + INVRETCGA * INDPLAF) , RRIRENT_1 - somme(i=1..19 : RENTi_1)) , 0) * (1 - V_CNR) ;
RENT20 = RENT20_1 * (1-ART1731BIS) + min( RENT20_1 , RENT20_2 ) * ART1731BIS ;

RENT21_1 = max(min((INVRETBJR * (1 - INDPLAF) + INVRETBJRA * INDPLAF) , RRIRENT_1 - somme(i=1..20 : RENTi_1)) , 0) * (1 - V_CNR) ;
RENT21 = RENT21_1 * (1-ART1731BIS) + min( RENT21_1 , RENT21_2 ) * ART1731BIS ;

RENT22_1 = max(min((INVRETBOR * (1 - INDPLAF) + INVRETBORA * INDPLAF) , RRIRENT_1 - somme(i=1..21 : RENTi_1)) , 0) * (1 - V_CNR) ;
RENT22 = RENT22_1 * (1-ART1731BIS) + min( RENT22_1 , RENT22_2 ) * ART1731BIS ;

RENT23_1 = max(min((INVRETBTR * (1 - INDPLAF) + INVRETBTRA * INDPLAF) , RRIRENT_1 - somme(i=1..22 : RENTi_1)) , 0) * (1 - V_CNR) ;
RENT23 = RENT23_1 * (1-ART1731BIS) + min( RENT23_1 , RENT23_2 ) * ART1731BIS ;

RENT24_1 = max(min((INVRETBYR * (1 - INDPLAF) + INVRETBYRA * INDPLAF) , RRIRENT_1 - somme(i=1..23 : RENTi_1)) , 0) * (1 - V_CNR) ;
RENT24 = RENT24_1 * (1-ART1731BIS) + min( RENT24_1 , RENT24_2 ) * ART1731BIS ;

RENT25_1 = max(min((INVRETCDR * (1 - INDPLAF) + INVRETCDRA * INDPLAF) , RRIRENT_1 - somme(i=1..24 : RENTi_1)) , 0) * (1 - V_CNR) ;
RENT25 = RENT25_1 * (1-ART1731BIS) + min( RENT25_1 , RENT25_2 ) * ART1731BIS ;

RENT26_1 = max(min((INVRETBIR * (1 - INDPLAF) + INVRETBIRA * INDPLAF) , RRIRENT_1 - somme(i=1..25 : RENTi_1)) , 0) * (1 - V_CNR) ;
RENT26 = RENT26_1 * (1-ART1731BIS) + min( RENT26_1 , RENT26_2 ) * ART1731BIS ;

RENT27_1 = max(min((INVRETBNR * (1 - INDPLAF) + INVRETBNRA * INDPLAF) , RRIRENT_1 - somme(i=1..26 : RENTi_1)) , 0) * (1 - V_CNR) ;
RENT27 = RENT27_1 * (1-ART1731BIS) + min( RENT27_1 , RENT27_2 ) * ART1731BIS ;

RENT28_1 = max(min((INVRETBSR * (1 - INDPLAF) + INVRETBSRA * INDPLAF) , RRIRENT_1 - somme(i=1..27 : RENTi_1)) , 0) * (1 - V_CNR) ;
RENT28 = RENT28_1 * (1-ART1731BIS) + min( RENT28_1 , RENT28_2 ) * ART1731BIS ;

RENT29_1 = max(min((INVRETBXR * (1 - INDPLAF) + INVRETBXRA * INDPLAF) , RRIRENT_1 - somme(i=1..28 : RENTi_1)) , 0) * (1 - V_CNR) ;
RENT29 = RENT29_1 * (1-ART1731BIS) + min( RENT29_1 , RENT29_2 ) * ART1731BIS ;

RENT30_1 = max(min((INVRETCCR * (1 - INDPLAF) + INVRETCCRA * INDPLAF) , RRIRENT_1 - somme(i=1..29 : RENTi_1)) , 0) * (1 - V_CNR) ;
RENT30 = RENT30_1 * (1-ART1731BIS) + min( RENT30_1 , RENT30_2 ) * ART1731BIS ;


RLOCENT_1 = ((1 - V_INDTEO) * somme(i=1..30 : RENTi_1)
           + V_INDTEO * (
             arr((V_RENT06+V_RENT26)*(5263/10000))
           + arr((V_RENT01+V_RENT21)*(625/1000))
           + arr((V_RENT07+V_RENT27)*(5263/10000))
           + arr((V_RENT02+V_RENT22)*(625/1000))
           + arr((V_RENT08+V_RENT28)*(5263/10000))
           + arr((V_RENT03+V_RENT23)*(625/1000))
           + arr((V_RENT09+V_RENT29)*(5263/10000))
           + arr((V_RENT04+V_RENT24)*(625/1000))
           + arr((V_RENT10+V_RENT30)*(56/100))
           + arr((V_RENT05+V_RENT25)*(66/100))

                          )) * (1 - V_CNR) ;

RLOCENT = RLOCENT_1 * (1 - ART1731BIS) 
          + min(RLOCENT_1 , RLOCENT_2) * ART1731BIS ;

RIDOMENT = RLOCENT ;

regle 402100:
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

INVRETUA = min(NINVRETUA , max(0 , PLAF_INVDOM -INVRETSOC-INVRETENT-INVRETQL-INVRETQM-INVRETQD-INVRETOB-INVRETOC-INVRETOI-INVRETOJ-INVRETOK-INVRETOM
                                               -INVRETON-INVRETOP-INVRETOQ-INVRETOR-INVRETOT-INVRETOU-INVRETOV-INVRETOW-INVRETOD-INVRETOE-INVRETOF
                                               -INVRETOG-INVRETOX-INVRETOY-INVRETOZ)) * (1 - V_CNR) ;

INVRETUB = min(NINVRETUB , max(0 , PLAF_INVDOM3 -INVRETSOC-INVRETENT-INVRETQL-INVRETQM-INVRETQD-INVRETOB-INVRETOC-INVRETOI-INVRETOJ-INVRETOK-INVRETOM
                                                -INVRETON-INVRETOP-INVRETOQ-INVRETOR-INVRETOT-INVRETOU-INVRETOV-INVRETOW-INVRETOD-INVRETOE-INVRETOF
                                                -INVRETOG-INVRETOX-INVRETOY-INVRETOZ-INVRETUA)) * (1 - V_CNR) ;

INVRETUC = min(NINVRETUC , max(0 , PLAF_INVDOM3 -INVRETSOC-INVRETENT-INVRETQL-INVRETQM-INVRETQD-INVRETOB-INVRETOC-INVRETOI-INVRETOJ-INVRETOK-INVRETOM
                                                -INVRETON-INVRETOP-INVRETOQ-INVRETOR-INVRETOT-INVRETOU-INVRETOV-INVRETOW-INVRETOD-INVRETOE-INVRETOF
                                                -INVRETOG-INVRETOX-INVRETOY-INVRETOZ-INVRETUA-INVRETUB)) * (1 - V_CNR) ;

INVRETUD = min(NINVRETUD , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETENT-INVRETQL-INVRETQM-INVRETQD-INVRETOB-INVRETOC-INVRETOI-INVRETOJ-INVRETOK-INVRETOM
                                                -INVRETON-INVRETOP-INVRETOQ-INVRETOR-INVRETOT-INVRETOU-INVRETOV-INVRETOW-INVRETOD-INVRETOE-INVRETOF
                                                -INVRETOG-INVRETOX-INVRETOY-INVRETOZ-INVRETUA-INVRETUB-INVRETUC)) * (1 - V_CNR) ;

INVRETUE = min(NINVRETUE , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETENT-INVRETQL-INVRETQM-INVRETQD-INVRETOB-INVRETOC-INVRETOI-INVRETOJ-INVRETOK-INVRETOM
                                                -INVRETON-INVRETOP-INVRETOQ-INVRETOR-INVRETOT-INVRETOU-INVRETOV-INVRETOW-INVRETOD-INVRETOE-INVRETOF
                                                -INVRETOG-INVRETOX-INVRETOY-INVRETOZ-INVRETUA-INVRETUB-INVRETUC-INVRETUD)) * (1 - V_CNR) ;

INVRETUF = min(NINVRETUF , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETENT-INVRETQL-INVRETQM-INVRETQD-INVRETOB-INVRETOC-INVRETOI-INVRETOJ-INVRETOK-INVRETOM
                                                -INVRETON-INVRETOP-INVRETOQ-INVRETOR-INVRETOT-INVRETOU-INVRETOV-INVRETOW-INVRETOD-INVRETOE-INVRETOF
                                                -INVRETOG-INVRETOX-INVRETOY-INVRETOZ-INVRETUA-INVRETUB-INVRETUC-INVRETUD-INVRETUE)) * (1 - V_CNR) ;

INVRETUG = min(NINVRETUG , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETENT-INVRETQL-INVRETQM-INVRETQD-INVRETOB-INVRETOC-INVRETOI-INVRETOJ-INVRETOK-INVRETOM
                                                -INVRETON-INVRETOP-INVRETOQ-INVRETOR-INVRETOT-INVRETOU-INVRETOV-INVRETOW-INVRETOD-INVRETOE-INVRETOF
                                                -INVRETOG-INVRETOX-INVRETOY-INVRETOZ-INVRETUA-INVRETUB-INVRETUC-INVRETUD-INVRETUE-INVRETUF)) * (1 - V_CNR) ;

INVRETUH = min(NINVRETUH , max(0 , PLAF_INVDOM -INVRETSOC-INVRETENT-INVRETQL-INVRETQM-INVRETQD-INVRETOB-INVRETOC-INVRETOI-INVRETOJ-INVRETOK-INVRETOM
                                               -INVRETON-INVRETOP-INVRETOQ-INVRETOR-INVRETOT-INVRETOU-INVRETOV-INVRETOW-INVRETOD-INVRETOE-INVRETOF
                                               -INVRETOG-INVRETOX-INVRETOY-INVRETOZ-INVRETUA-INVRETUB-INVRETUC-INVRETUD-INVRETUE-INVRETUF-INVRETUG)) * (1 - V_CNR) ;

INVRETUI = min(NINVRETUI , max(0 , PLAF_INVDOM3 -INVRETSOC-INVRETENT-INVRETQL-INVRETQM-INVRETQD-INVRETOB-INVRETOC-INVRETOI-INVRETOJ-INVRETOK-INVRETOM
                                                -INVRETON-INVRETOP-INVRETOQ-INVRETOR-INVRETOT-INVRETOU-INVRETOV-INVRETOW-INVRETOD-INVRETOE-INVRETOF
                                                -INVRETOG-INVRETOX-INVRETOY-INVRETOZ-INVRETUA-INVRETUB-INVRETUC-INVRETUD-INVRETUE-INVRETUF-INVRETUG
                                                -INVRETUH)) * (1 - V_CNR) ;

INVRETUJ = min(NINVRETUJ , max(0 , PLAF_INVDOM3 -INVRETSOC-INVRETENT-INVRETQL-INVRETQM-INVRETQD-INVRETOB-INVRETOC-INVRETOI-INVRETOJ-INVRETOK-INVRETOM
                                                -INVRETON-INVRETOP-INVRETOQ-INVRETOR-INVRETOT-INVRETOU-INVRETOV-INVRETOW-INVRETOD-INVRETOE-INVRETOF
                                                -INVRETOG-INVRETOX-INVRETOY-INVRETOZ-INVRETUA-INVRETUB-INVRETUC-INVRETUD-INVRETUE-INVRETUF-INVRETUG
                                                -INVRETUH-INVRETUI)) * (1 - V_CNR) ;

INVRETUK = min(NINVRETUK , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETENT-INVRETQL-INVRETQM-INVRETQD-INVRETOB-INVRETOC-INVRETOI-INVRETOJ-INVRETOK-INVRETOM
                                                -INVRETON-INVRETOP-INVRETOQ-INVRETOR-INVRETOT-INVRETOU-INVRETOV-INVRETOW-INVRETOD-INVRETOE-INVRETOF
                                                -INVRETOG-INVRETOX-INVRETOY-INVRETOZ-INVRETUA-INVRETUB-INVRETUC-INVRETUD-INVRETUE-INVRETUF-INVRETUG
                                                -INVRETUH-INVRETUI-INVRETUJ)) * (1 - V_CNR) ;

INVRETUL = min(NINVRETUL , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETENT-INVRETQL-INVRETQM-INVRETQD-INVRETOB-INVRETOC-INVRETOI-INVRETOJ-INVRETOK-INVRETOM
                                                -INVRETON-INVRETOP-INVRETOQ-INVRETOR-INVRETOT-INVRETOU-INVRETOV-INVRETOW-INVRETOD-INVRETOE-INVRETOF
                                                -INVRETOG-INVRETOX-INVRETOY-INVRETOZ-INVRETUA-INVRETUB-INVRETUC-INVRETUD-INVRETUE-INVRETUF-INVRETUG
                                                -INVRETUH-INVRETUI-INVRETUJ-INVRETUK)) * (1 - V_CNR) ;

INVRETUM = min(NINVRETUM , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETENT-INVRETQL-INVRETQM-INVRETQD-INVRETOB-INVRETOC-INVRETOI-INVRETOJ-INVRETOK-INVRETOM
                                                -INVRETON-INVRETOP-INVRETOQ-INVRETOR-INVRETOT-INVRETOU-INVRETOV-INVRETOW-INVRETOD-INVRETOE-INVRETOF
                                                -INVRETOG-INVRETOX-INVRETOY-INVRETOZ-INVRETUA-INVRETUB-INVRETUC-INVRETUD-INVRETUE-INVRETUF-INVRETUG
                                                -INVRETUH-INVRETUI-INVRETUJ-INVRETUK-INVRETUL)) * (1 - V_CNR) ;

INVRETUN = min(NINVRETUN , max(0 , PLAF_INVDOM4 -INVRETSOC-INVRETENT-INVRETQL-INVRETQM-INVRETQD-INVRETOB-INVRETOC-INVRETOI-INVRETOJ-INVRETOK-INVRETOM
                                                -INVRETON-INVRETOP-INVRETOQ-INVRETOR-INVRETOT-INVRETOU-INVRETOV-INVRETOW-INVRETOD-INVRETOE-INVRETOF
                                                -INVRETOG-INVRETOX-INVRETOY-INVRETOZ-INVRETUA-INVRETUB-INVRETUC-INVRETUD-INVRETUE-INVRETUF-INVRETUG
                                                -INVRETUH-INVRETUI-INVRETUJ-INVRETUK-INVRETUL-INVRETUM)) * (1 - V_CNR) ;

INVRETLOG = INVRETQL + INVRETQM + INVRETQD + INVRETOB + INVRETOC + INVRETOI + INVRETOJ + INVRETOK + INVRETOM + INVRETON + INVRETOP + INVRETOQ 
            + INVRETOR + INVRETOT + INVRETOU + INVRETOV + INVRETOW + INVRETOD + INVRETOE + INVRETOF + INVRETOG + INVRETOX + INVRETOY + INVRETOZ 
            + INVRETUA + INVRETUB + INVRETUC + INVRETUD + INVRETUE + INVRETUF + INVRETUG + INVRETUH + INVRETUI + INVRETUJ + INVRETUK + INVRETUL
            + INVRETUM + INVRETUN ;

regle 402110:
application : iliad, batch ;


RLOG01_1 = max(min(INVLOG2008 , RRI1_1) , 0) * (1 - V_CNR) ;
RLOG01 = RLOG01_1 * (1-ART1731BIS) + min( RLOG01_1 , RLOG01_2 ) * ART1731BIS ;

RLOG02_1 = max(min(INVLGDEB2009 , RRI1_1-RLOG01_1) , 0) * (1 - V_CNR) ;
RLOG02 = RLOG02_1 * (1-ART1731BIS) + min( RLOG02_1 , RLOG02_2 ) * ART1731BIS ;

RLOG03_1 = max(min(INVLGDEB , RRI1_1-RLOG01_1-RLOG02_1) , 0) * (1 - V_CNR) ;
RLOG03 = RLOG03_1 * (1-ART1731BIS) + min( RLOG03_1 , RLOG03_2 ) * ART1731BIS ;

RLOG04_1 = max(min(INVOMLOGOA , RRI1_1-RLOG01_1-RLOG02_1-RLOG03_1) , 0) * (1 - V_CNR) ;
RLOG04 = RLOG04_1 * (1-ART1731BIS) + min( RLOG04_1 , RLOG04_2 ) * ART1731BIS ;

RLOG05_1 = max(min(INVOMLOGOH , RRI1_1-RLOG01_1-RLOG02_1-RLOG03_1-RLOG04_1) , 0) * (1 - V_CNR) ;
RLOG05 = RLOG05_1 * (1-ART1731BIS) + min( RLOG05_1 , RLOG05_2 ) * ART1731BIS ;

RLOG06_1 = max(min(INVOMLOGOL , RRI1_1-RLOG01_1-RLOG02_1-RLOG03_1-RLOG04_1-RLOG05_1) , 0) * (1 - V_CNR) ;
RLOG06 = RLOG06_1 * (1-ART1731BIS) + min( RLOG06_1 , RLOG06_2 ) * ART1731BIS ;

RLOG07_1 = max(min(INVOMLOGOO , RRI1_1-RLOG01_1-RLOG02_1-RLOG03_1-RLOG04_1-RLOG05_1-RLOG06_1) , 0) * (1 - V_CNR) ;
RLOG07 = RLOG07_1 * (1-ART1731BIS) + min( RLOG07_1 , RLOG07_2 ) * ART1731BIS ;

RLOG08_1 = max(min(INVOMLOGOS , RRI1_1-RLOG01_1-RLOG02_1-RLOG03_1-RLOG04_1-RLOG05_1-RLOG06_1-RLOG07_1) , 0) * (1 - V_CNR) ;
RLOG08 = RLOG08_1 * (1-ART1731BIS) + min( RLOG08_1 , RLOG08_2 ) * ART1731BIS ;

RLOG09_1 = max(min((INVRETQL * (1 - INDPLAF) + INVRETQLA * INDPLAF) , RRI1_1-RLOG01_1-RLOG02_1-RLOG03_1-RLOG04_1-RLOG05_1
                                                                    -RLOG06_1-RLOG07_1-RLOG08_1) , 0) * (1 - V_CNR) ;
RLOG09 = RLOG09_1 * (1-ART1731BIS) + min( RLOG09_1 , RLOG09_2 ) * ART1731BIS ;

RLOG10_1 = max(min((INVRETQM * (1 - INDPLAF) + INVRETQMA * INDPLAF) , RRI1_1-RLOG01_1-RLOG02_1-RLOG03_1-RLOG04_1-RLOG05_1
                                                                     -RLOG06_1-RLOG07_1-RLOG08_1-RLOG09_1) , 0) * (1 - V_CNR) ;
RLOG10 = RLOG10_1 * (1-ART1731BIS) + min( RLOG10_1 , RLOG10_2 ) * ART1731BIS ;

RLOG11_1 = max(min((INVRETQD * (1 - INDPLAF) + INVRETQDA * INDPLAF) , RRI1_1 - somme(i=1..10 : RLOGi_1)) , 0) * (1 - V_CNR) ;
RLOG11 = RLOG11_1 * (1-ART1731BIS) + min( RLOG11_1 , RLOG11_2 ) * ART1731BIS ;

RLOG12_1 = max(min((INVRETOB * (1 - INDPLAF) + INVRETOBA * INDPLAF) , RRI1_1 - somme(i=1..11 : RLOGi_1)) , 0) * (1 - V_CNR) ;
RLOG12 = RLOG12_1 * (1-ART1731BIS) + min( RLOG12_1 , RLOG12_2 ) * ART1731BIS ;

RLOG13_1 = max(min((INVRETOC * (1 - INDPLAF) + INVRETOCA * INDPLAF) , RRI1_1 - somme(i=1..12 : RLOGi_1)) , 0) * (1 - V_CNR) ;
RLOG13 = RLOG13_1 * (1-ART1731BIS) + min( RLOG13_1 , RLOG13_2 ) * ART1731BIS ;

RLOG14_1 = max(min((INVRETOI * (1 - INDPLAF) + INVRETOIA * INDPLAF) , RRI1_1 - somme(i=1..13 : RLOGi_1)) , 0) * (1 - V_CNR) ;
RLOG14 = RLOG14_1 * (1-ART1731BIS) + min( RLOG14_1 , RLOG14_2 ) * ART1731BIS ;

RLOG15_1 = max(min((INVRETOJ * (1 - INDPLAF) + INVRETOJA * INDPLAF) , RRI1_1 - somme(i=1..14 : RLOGi_1)) , 0) * (1 - V_CNR) ;
RLOG15 = RLOG15_1 * (1-ART1731BIS) + min( RLOG15_1 , RLOG15_2 ) * ART1731BIS ;

RLOG16_1 = max(min((INVRETOK * (1 - INDPLAF) + INVRETOKA * INDPLAF) , RRI1_1 - somme(i=1..15 : RLOGi_1)) , 0) * (1 - V_CNR) ;
RLOG16 = RLOG16_1 * (1-ART1731BIS) + min( RLOG16_1 , RLOG16_2 ) * ART1731BIS ;

RLOG17_1 = max(min((INVRETOM * (1 - INDPLAF) + INVRETOMA * INDPLAF) , RRI1_1 - somme(i=1..16 : RLOGi_1)) , 0) * (1 - V_CNR) ;
RLOG17 = RLOG17_1 * (1-ART1731BIS) + min( RLOG17_1 , RLOG17_2 ) * ART1731BIS ;

RLOG18_1 = max(min((INVRETON * (1 - INDPLAF) + INVRETONA * INDPLAF) , RRI1_1 - somme(i=1..17 : RLOGi_1)) , 0) * (1 - V_CNR) ;
RLOG18 = RLOG18_1 * (1-ART1731BIS) + min( RLOG18_1 , RLOG18_2 ) * ART1731BIS ;

RLOG19_1 = max(min((INVRETOP * (1 - INDPLAF) + INVRETOPA * INDPLAF) , RRI1_1 - somme(i=1..18 : RLOGi_1)) , 0) * (1 - V_CNR) ;
RLOG19 = RLOG19_1 * (1-ART1731BIS) + min( RLOG19_1 , RLOG19_2 ) * ART1731BIS ;

RLOG20_1 = max(min((INVRETOQ * (1 - INDPLAF) + INVRETOQA * INDPLAF) , RRI1_1 - somme(i=1..19 : RLOGi_1)) , 0) * (1 - V_CNR) ;
RLOG20 = RLOG20_1 * (1-ART1731BIS) + min( RLOG20_1 , RLOG20_2 ) * ART1731BIS ;

RLOG21_1 = max(min((INVRETOR * (1 - INDPLAF) + INVRETORA * INDPLAF) , RRI1_1 - somme(i=1..20 : RLOGi_1)) , 0) * (1 - V_CNR) ;
RLOG21 = RLOG21_1 * (1-ART1731BIS) + min( RLOG21_1 , RLOG21_2 ) * ART1731BIS ;

RLOG22_1 = max(min((INVRETOT * (1 - INDPLAF) + INVRETOTA * INDPLAF) , RRI1_1 - somme(i=1..21 : RLOGi_1)) , 0) * (1 - V_CNR) ;
RLOG22 = RLOG22_1 * (1-ART1731BIS) + min( RLOG22_1 , RLOG22_2 ) * ART1731BIS ;

RLOG23_1 = max(min((INVRETOU * (1 - INDPLAF) + INVRETOUA * INDPLAF) , RRI1_1 - somme(i=1..22 : RLOGi_1)) , 0) * (1 - V_CNR) ;
RLOG23 = RLOG23_1 * (1-ART1731BIS) + min( RLOG23_1 , RLOG23_2 ) * ART1731BIS ;

RLOG24_1 = max(min((INVRETOV * (1 - INDPLAF) + INVRETOVA * INDPLAF) , RRI1_1 - somme(i=1..23 : RLOGi_1)) , 0) * (1 - V_CNR) ;
RLOG24 = RLOG24_1 * (1-ART1731BIS) + min( RLOG24_1 , RLOG24_2 ) * ART1731BIS ;

RLOG25_1 = max(min((INVRETOW * (1 - INDPLAF) + INVRETOWA * INDPLAF) , RRI1_1 - somme(i=1..24 : RLOGi_1)) , 0) * (1 - V_CNR) ;
RLOG25 = RLOG25_1 * (1-ART1731BIS) + min( RLOG25_1 , RLOG25_2 ) * ART1731BIS ;

RLOG26_1 = max(min((INVRETOD * (1 - INDPLAF) + INVRETODA * INDPLAF) , RRI1_1 - somme(i=1..25 : RLOGi_1)) , 0) * (1 - V_CNR) ;
RLOG26 = RLOG26_1 * (1-ART1731BIS) + min( RLOG26_1 , RLOG26_2 ) * ART1731BIS ;

RLOG27_1 = max(min((INVRETOE * (1 - INDPLAF) + INVRETOEA * INDPLAF) , RRI1_1 - somme(i=1..26 : RLOGi_1)) , 0) * (1 - V_CNR) ;
RLOG27 = RLOG27_1 * (1-ART1731BIS) + min( RLOG27_1 , RLOG27_2 ) * ART1731BIS ;

RLOG28_1 = max(min((INVRETOF * (1 - INDPLAF) + INVRETOFA * INDPLAF) , RRI1_1 - somme(i=1..27 : RLOGi_1)) , 0) * (1 - V_CNR) ;
RLOG28 = RLOG28_1 * (1-ART1731BIS) + min( RLOG28_1 , RLOG28_2 ) * ART1731BIS ;

RLOG29_1 = max(min((INVRETOG * (1 - INDPLAF) + INVRETOGA * INDPLAF) , RRI1_1 - somme(i=1..28 : RLOGi_1)) , 0) * (1 - V_CNR) ;
RLOG29 = RLOG29_1 * (1-ART1731BIS) + min( RLOG29_1 , RLOG29_2 ) * ART1731BIS ;

RLOG30_1 = max(min((INVRETOX * (1 - INDPLAF) + INVRETOXA * INDPLAF) , RRI1_1 - somme(i=1..29 : RLOGi_1)) , 0) * (1 - V_CNR) ;
RLOG30 = RLOG30_1 * (1-ART1731BIS) + min( RLOG30_1 , RLOG30_2 ) * ART1731BIS ;

RLOG31_1 = max(min((INVRETOY * (1 - INDPLAF) + INVRETOYA * INDPLAF) , RRI1_1 - somme(i=1..30 : RLOGi_1)) , 0) * (1 - V_CNR) ;
RLOG31 = RLOG31_1 * (1-ART1731BIS) + min( RLOG31_1 , RLOG31_2 ) * ART1731BIS ;

RLOG32_1 = max(min((INVRETOZ * (1 - INDPLAF) + INVRETOZA * INDPLAF) , RRI1_1 - somme(i=1..31 : RLOGi_1)) , 0) * (1 - V_CNR) ;
RLOG32 = RLOG32_1 * (1-ART1731BIS) + min( RLOG32_1 , RLOG32_2 ) * ART1731BIS ;

RLOG33_1 = max(min((INVRETUA * (1 - INDPLAF) + INVRETUAA * INDPLAF) , RRI1_1 - somme(i=1..32 : RLOGi_1)) , 0) * (1 - V_CNR) ;
RLOG33 = RLOG33_1 * (1-ART1731BIS) + min( RLOG33_1 , RLOG33_2 ) * ART1731BIS ;

RLOG34_1 = max(min((INVRETUB * (1 - INDPLAF) + INVRETUBA * INDPLAF) , RRI1_1 - somme(i=1..33 : RLOGi_1)) , 0) * (1 - V_CNR) ;
RLOG34 = RLOG34_1 * (1-ART1731BIS) + min( RLOG34_1 , RLOG34_2 ) * ART1731BIS ;

RLOG35_1 = max(min((INVRETUC * (1 - INDPLAF) + INVRETUCA * INDPLAF) , RRI1_1 - somme(i=1..34 : RLOGi_1)) , 0) * (1 - V_CNR) ;
RLOG35 = RLOG35_1 * (1-ART1731BIS) + min( RLOG35_1 , RLOG35_2 ) * ART1731BIS ;

RLOG36_1 = max(min((INVRETUD * (1 - INDPLAF) + INVRETUDA * INDPLAF) , RRI1_1 - somme(i=1..35 : RLOGi_1)) , 0) * (1 - V_CNR) ;
RLOG36 = RLOG36_1 * (1-ART1731BIS) + min( RLOG36_1 , RLOG36_2 ) * ART1731BIS ;

RLOG37_1 = max(min((INVRETUE * (1 - INDPLAF) + INVRETUEA * INDPLAF) , RRI1_1 - somme(i=1..36 : RLOGi_1)) , 0) * (1 - V_CNR) ;
RLOG37 = RLOG37_1 * (1-ART1731BIS) + min( RLOG37_1 , RLOG37_2 ) * ART1731BIS ;

RLOG38_1 = max(min((INVRETUF * (1 - INDPLAF) + INVRETUFA * INDPLAF) , RRI1_1 - somme(i=1..37 : RLOGi_1)) , 0) * (1 - V_CNR) ;
RLOG38 = RLOG38_1 * (1-ART1731BIS) + min( RLOG38_1 , RLOG38_2 ) * ART1731BIS ;

RLOG39_1 = max(min((INVRETUG * (1 - INDPLAF) + INVRETUGA * INDPLAF) , RRI1_1 - somme(i=1..38 : RLOGi_1)) , 0) * (1 - V_CNR) ;
RLOG39 = RLOG39_1 * (1-ART1731BIS) + min( RLOG39_1 , RLOG39_2 ) * ART1731BIS ;

RLOG40_1 = max(min((INVRETUH * (1 - INDPLAF) + INVRETUHA * INDPLAF) , RRI1_1 - somme(i=1..39 : RLOGi_1)) , 0) * (1 - V_CNR) ;
RLOG40 = RLOG40_1 * (1-ART1731BIS) + min( RLOG40_1 , RLOG40_2 ) * ART1731BIS ;

RLOG41_1 = max(min((INVRETUI * (1 - INDPLAF) + INVRETUIA * INDPLAF) , RRI1_1 - somme(i=1..40 : RLOGi_1)) , 0) * (1 - V_CNR) ;
RLOG41 = RLOG41_1 * (1-ART1731BIS) + min( RLOG41_1 , RLOG41_2 ) * ART1731BIS ;

RLOG42_1 = max(min((INVRETUJ * (1 - INDPLAF) + INVRETUJA * INDPLAF) , RRI1_1 - somme(i=1..41 : RLOGi_1)) , 0) * (1 - V_CNR) ;
RLOG42 = RLOG42_1 * (1-ART1731BIS) + min( RLOG42_1 , RLOG42_2 ) * ART1731BIS ;

RLOG43_1 = max(min((INVRETUK * (1 - INDPLAF) + INVRETUKA * INDPLAF) , RRI1_1 - somme(i=1..42 : RLOGi_1)) , 0) * (1 - V_CNR) ;
RLOG43 = RLOG43_1 * (1-ART1731BIS) + min( RLOG43_1 , RLOG43_2 ) * ART1731BIS ;

RLOG44_1 = max(min((INVRETUL * (1 - INDPLAF) + INVRETULA * INDPLAF) , RRI1_1 - somme(i=1..43 : RLOGi_1)) , 0) * (1 - V_CNR) ;
RLOG44 = RLOG44_1 * (1-ART1731BIS) + min( RLOG44_1 , RLOG44_2 ) * ART1731BIS ;

RLOG45_1 = max(min((INVRETUM * (1 - INDPLAF) + INVRETUMA * INDPLAF) , RRI1_1 - somme(i=1..44 : RLOGi_1)) , 0) * (1 - V_CNR) ;
RLOG45 = RLOG45_1 * (1-ART1731BIS) + min( RLOG45_1 , RLOG45_2 ) * ART1731BIS ;

RLOG46_1 = max(min((INVRETUN * (1 - INDPLAF) + INVRETUNA * INDPLAF) , RRI1_1 - somme(i=1..45 : RLOGi_1)) , 0) * (1 - V_CNR) ;
RLOG46 = RLOG46_1 * (1-ART1731BIS) + min( RLOG46_1 , RLOG46_2 ) * ART1731BIS ;

RLOGDOM_1 = (1 - V_INDTEO) * somme(i=1..46: RLOGi_1)

         + V_INDTEO * (RLOG01_1 + RLOG02_1 + RLOG03_1 + RLOG04_1 + RLOG05_1 + RLOG06_1 + RLOG07_1 + RLOG08_1) ;

RLOGDOM = RLOGDOM_1 * (1-ART1731BIS) 
           + min( RLOGDOM_1 , RLOGDOM_2 ) * ART1731BIS ; 

RINVDOMTOMLG = RLOGDOM ;

regle 402120:
application : iliad , batch ;

RRILOC = RRISUP - RLOGSOC - RDOMSOC1 ;
RRILOC_1 = RRISUP_1 - RLOGSOC_1 - RDOMSOC1_1 ;

RLOC07_1 = max(min(INVOMENTMN , RRILOC_1) , 0) * (1 - V_CNR) ;
RLOC07 = RLOC07_1 * (1-ART1731BIS) + min( RLOC07_1 , RLOC07_2 ) * ART1731BIS ;

RLOC08_1 = max(min((INVRETMB * (1 - INDPLAF) + INVRETMBA * INDPLAF) , RRILOC_1 - RLOC07_1) , 0) * (1 - V_CNR) ;
RLOC08 = RLOC08_1 * (1-ART1731BIS) + min( RLOC08_1 , RLOC08_2 ) * ART1731BIS ;

RLOC09_1 = max(min((INVRETMC * (1 - INDPLAF) + INVRETMCA * INDPLAF) , RRILOC_1 - RLOC07_1 - RLOC08_1) , 0) * (1 - V_CNR) ;
RLOC09 = RLOC09_1 * (1-ART1731BIS) + min( RLOC09_1 , RLOC09_2 ) * ART1731BIS ;

RLOC10_1 = max(min((INVRETLH * (1 - INDPLAF) + INVRETLHA * INDPLAF) , RRILOC_1 - RLOC07_1 - RLOC08_1 - RLOC09_1) , 0) * (1 - V_CNR) ;
RLOC10 = RLOC10_1 * (1-ART1731BIS) + min( RLOC10_1 , RLOC10_2 ) * ART1731BIS ;

RLOC11_1 = max(min((INVRETLI * (1 - INDPLAF) + INVRETLIA * INDPLAF) , RRILOC_1 - somme(i=7..10 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC11 = RLOC11_1 * (1-ART1731BIS) + min( RLOC11_1 , RLOC11_2 ) * ART1731BIS ;

RLOC12_1 = max(min((INVRETKT * (1 - INDPLAF) + INVRETKTA * INDPLAF) , RRILOC_1 - somme(i=7..11 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC12 = RLOC12_1 * (1-ART1731BIS) + min( RLOC12_1 , RLOC12_2 ) * ART1731BIS ;

RLOC13_1 = max(min((INVRETKU * (1 - INDPLAF) + INVRETKUA * INDPLAF) , RRILOC_1 - somme(i=7..12 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC13 = RLOC13_1 * (1-ART1731BIS) + min( RLOC13_1 , RLOC13_2 ) * ART1731BIS ;

RLOC14_1 = max(min((INVRETMBR * (1 - INDPLAF) + INVRETMBRA * INDPLAF) , RRILOC_1 - somme(i=7..13 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC14 = RLOC14_1 * (1-ART1731BIS) + min( RLOC14_1 , RLOC14_2 ) * ART1731BIS ;

RLOC15_1 = max(min((INVRETMCR * (1 - INDPLAF) + INVRETMCRA * INDPLAF) , RRILOC_1 - somme(i=7..14 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC15 = RLOC15_1 * (1-ART1731BIS) + min( RLOC15_1 , RLOC15_2 ) * ART1731BIS ;

RLOC16_1 = max(min((INVRETLHR * (1 - INDPLAF) + INVRETLHRA * INDPLAF) , RRILOC_1 - somme(i=7..15 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC16 = RLOC16_1 * (1-ART1731BIS) + min( RLOC16_1 , RLOC16_2 ) * ART1731BIS ;

RLOC17_1 = max(min((INVRETLIR * (1 - INDPLAF) + INVRETLIRA * INDPLAF) , RRILOC_1 - somme(i=7..16 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC17 = RLOC17_1 * (1-ART1731BIS) + min( RLOC17_1 , RLOC17_2 ) * ART1731BIS ;

RLOC18_1 = max(min(INVOMQV , RRILOC_1 - somme(i=7..17 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC18 = RLOC18_1 * (1-ART1731BIS) + min( RLOC18_1 , RLOC18_2 ) * ART1731BIS ;

RLOC19_1 = max(min(INVENDEB2009 , RRILOC_1 - somme(i=7..18 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC19 = RLOC19_1 * (1-ART1731BIS) + min( RLOC19_1 , RLOC19_2 ) * ART1731BIS ;

RLOC20_1 = max(min((INVRETQP * (1 - INDPLAF) + INVRETQPA * INDPLAF) , RRILOC_1 - somme(i=7..19 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC20 = RLOC20_1 * (1-ART1731BIS) + min( RLOC20_1 , RLOC20_2 ) * ART1731BIS ;

RLOC21_1 = max(min((INVRETQG * (1 - INDPLAF) + INVRETQGA * INDPLAF) , RRILOC_1 - somme(i=7..20 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC21 = RLOC21_1 * (1-ART1731BIS) + min( RLOC21_1 , RLOC21_2 ) * ART1731BIS ;

RLOC22_1 = max(min((INVRETPB * (1 - INDPLAF) + INVRETPBA * INDPLAF) , RRILOC_1 - somme(i=7..21 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC22 = RLOC22_1 * (1-ART1731BIS) + min( RLOC22_1 , RLOC22_2 ) * ART1731BIS ;

RLOC23_1 = max(min((INVRETPF * (1 - INDPLAF) + INVRETPFA * INDPLAF) , RRILOC_1 - somme(i=7..22 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC23 = RLOC23_1 * (1-ART1731BIS) + min( RLOC23_1 , RLOC23_2 ) * ART1731BIS ;

RLOC24_1 = max(min((INVRETPJ * (1 - INDPLAF) + INVRETPJA * INDPLAF) , RRILOC_1 - somme(i=7..23 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC24 = RLOC24_1 * (1-ART1731BIS) + min( RLOC24_1 , RLOC24_2 ) * ART1731BIS ;

RLOC25_1 = max(min((INVRETQO * (1 - INDPLAF) + INVRETQOA * INDPLAF) , RRILOC_1 - somme(i=7..24 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC25 = RLOC25_1 * (1-ART1731BIS) + min( RLOC25_1 , RLOC25_2 ) * ART1731BIS ;

RLOC26_1 = max(min((INVRETQF * (1 - INDPLAF) + INVRETQFA * INDPLAF) , RRILOC_1 - somme(i=7..25 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC26 = RLOC26_1 * (1-ART1731BIS) + min( RLOC26_1 , RLOC26_2 ) * ART1731BIS ;

RLOC27_1 = max(min((INVRETPA * (1 - INDPLAF) + INVRETPAA * INDPLAF) , RRILOC_1 - somme(i=7..26 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC27 = RLOC27_1 * (1-ART1731BIS) + min( RLOC27_1 , RLOC27_2 ) * ART1731BIS ;

RLOC28_1 = max(min((INVRETPE * (1 - INDPLAF) + INVRETPEA * INDPLAF) , RRILOC_1 - somme(i=7..27 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC28 = RLOC28_1 * (1-ART1731BIS) + min( RLOC28_1 , RLOC28_2 ) * ART1731BIS ;

RLOC29_1 = max(min((INVRETPI * (1 - INDPLAF) + INVRETPIA * INDPLAF) , RRILOC_1 - somme(i=7..28 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC29 = RLOC29_1 * (1-ART1731BIS) + min( RLOC29_1 , RLOC29_2 ) * ART1731BIS ;

RLOC30_1 = max(min((INVRETQR * (1 - INDPLAF) + INVRETQRA * INDPLAF) , RRILOC_1 - somme(i=7..29 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC30 = RLOC30_1 * (1-ART1731BIS) + min( RLOC30_1 , RLOC30_2 ) * ART1731BIS ;

RLOC31_1 = max(min((INVRETQI * (1 - INDPLAF) + INVRETQIA * INDPLAF) , RRILOC_1 - somme(i=7..30 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC31 = RLOC31_1 * (1-ART1731BIS) + min( RLOC31_1 , RLOC31_2 ) * ART1731BIS ;

RLOC32_1 = max(min((INVRETPD * (1 - INDPLAF) + INVRETPDA * INDPLAF) , RRILOC_1 - somme(i=7..31 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC32 = RLOC32_1 * (1-ART1731BIS) + min( RLOC32_1 , RLOC32_2 ) * ART1731BIS ;

RLOC33_1 = max(min((INVRETPH * (1 - INDPLAF) + INVRETPHA * INDPLAF) , RRILOC_1 - somme(i=7..32 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC33 = RLOC33_1 * (1-ART1731BIS) + min( RLOC33_1 , RLOC33_2 ) * ART1731BIS ;

RLOC34_1 = max(min((INVRETPL * (1 - INDPLAF) + INVRETPLA * INDPLAF) , RRILOC_1 - somme(i=7..33 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC34 = RLOC34_1 * (1-ART1731BIS) + min( RLOC34_1 , RLOC34_2 ) * ART1731BIS ;

RLOC35_1 = max(min((INVRETQPR * (1 - INDPLAF) + INVRETQPRA * INDPLAF) , RRILOC_1 - somme(i=7..34 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC35 = RLOC35_1 * (1-ART1731BIS) + min( RLOC35_1 , RLOC35_2 ) * ART1731BIS ;

RLOC36_1 = max(min((INVRETQGR * (1 - INDPLAF) + INVRETQGRA * INDPLAF) , RRILOC_1 - somme(i=7..35 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC36 = RLOC36_1 * (1-ART1731BIS) + min( RLOC36_1 , RLOC36_2 ) * ART1731BIS ;

RLOC37_1 = max(min((INVRETPBR * (1 - INDPLAF) + INVRETPBRA * INDPLAF) , RRILOC_1 - somme(i=7..36 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC37 = RLOC37_1 * (1-ART1731BIS) + min( RLOC37_1 , RLOC37_2 ) * ART1731BIS ;

RLOC38_1 = max(min((INVRETPFR * (1 - INDPLAF) + INVRETPFRA * INDPLAF) , RRILOC_1 - somme(i=7..37 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC38 = RLOC38_1 * (1-ART1731BIS) + min( RLOC38_1 , RLOC38_2 ) * ART1731BIS ;

RLOC39_1 = max(min((INVRETPJR * (1 - INDPLAF) + INVRETPJRA * INDPLAF) , RRILOC_1 - somme(i=7..38 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC39 = RLOC39_1 * (1-ART1731BIS) + min( RLOC39_1 , RLOC39_2 ) * ART1731BIS ;

RLOC40_1 = max(min((INVRETQOR * (1 - INDPLAF) + INVRETQORA * INDPLAF) , RRILOC_1 - somme(i=7..39 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC40 = RLOC40_1 * (1-ART1731BIS) + min( RLOC40_1 , RLOC40_2 ) * ART1731BIS ;

RLOC41_1 = max(min((INVRETQFR * (1 - INDPLAF) + INVRETQFRA * INDPLAF) , RRILOC_1 - somme(i=7..40 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC41 = RLOC41_1 * (1-ART1731BIS) + min( RLOC41_1 , RLOC41_2 ) * ART1731BIS ;

RLOC42_1 = max(min((INVRETPAR * (1 - INDPLAF) + INVRETPARA * INDPLAF) , RRILOC_1 - somme(i=7..41 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC42 = RLOC42_1 * (1-ART1731BIS) + min( RLOC42_1 , RLOC42_2 ) * ART1731BIS ;

RLOC43_1 = max(min((INVRETPER * (1 - INDPLAF) + INVRETPERA * INDPLAF) , RRILOC_1 - somme(i=7..42 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC43 = RLOC43_1 * (1-ART1731BIS) + min( RLOC43_1 , RLOC43_2 ) * ART1731BIS ;

RLOC44_1 = max(min((INVRETPIR * (1 - INDPLAF) + INVRETPIRA * INDPLAF) , RRILOC_1 - somme(i=7..43 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC44 = RLOC44_1 * (1-ART1731BIS) + min( RLOC44_1 , RLOC44_2 ) * ART1731BIS ;

RLOC45_1 = max(min(INVOMRETPM , RRILOC_1 - somme(i=7..44 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC45 = RLOC45_1 * (1-ART1731BIS) + min( RLOC45_1 , RLOC45_2 ) * ART1731BIS ;

RLOC46_1 = max(min(INVOMENTRJ , RRILOC_1 - somme(i=7..45 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC46 = RLOC46_1 * (1-ART1731BIS) + min( RLOC46_1 , RLOC46_2 ) * ART1731BIS ;

RLOC47_1 = max(min((INVRETPO * (1 - INDPLAF) + INVRETPOA * INDPLAF) , RRILOC_1 - somme(i=7..46 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC47 = RLOC47_1 * (1-ART1731BIS) + min( RLOC47_1 , RLOC47_2 ) * ART1731BIS ;

RLOC48_1 = max(min((INVRETPT * (1 - INDPLAF) + INVRETPTA * INDPLAF) , RRILOC_1 - somme(i=7..47 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC48 = RLOC48_1 * (1-ART1731BIS) + min( RLOC48_1 , RLOC48_2 ) * ART1731BIS ;

RLOC49_1 = max(min((INVRETPY * (1 - INDPLAF) + INVRETPYA * INDPLAF) , RRILOC_1 - somme(i=7..48 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC49 = RLOC49_1 * (1-ART1731BIS) + min( RLOC49_1 , RLOC49_2 ) * ART1731BIS ;

RLOC50_1 = max(min((INVRETRL * (1 - INDPLAF) + INVRETRLA * INDPLAF) , RRILOC_1 - somme(i=7..49 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC50 = RLOC50_1 * (1-ART1731BIS) + min( RLOC50_1 , RLOC50_2 ) * ART1731BIS ;

RLOC7A50_1 =  somme(i=7..50 : RLOCi_1) ;

RLOC51_1 = max(min((INVRETRQ * (1 - INDPLAF) + INVRETRQA * INDPLAF) , RRILOC_1 - RLOC7A50_1) , 0) * (1 - V_CNR) ;
RLOC51 = RLOC51_1 * (1-ART1731BIS) + min( RLOC51_1 , RLOC51_2 ) * ART1731BIS ;

RLOC52_1 = max(min((INVRETRV * (1 - INDPLAF) + INVRETRVA * INDPLAF) , RRILOC_1 - RLOC7A50_1 - RLOC51_1) , 0) * (1 - V_CNR) ;
RLOC52 = RLOC52_1 * (1-ART1731BIS) + min( RLOC52_1 , RLOC52_2 ) * ART1731BIS ;

RLOC53_1 = max(min((INVRETNV * (1 - INDPLAF) + INVRETNVA * INDPLAF) , RRILOC_1 - RLOC7A50_1 - RLOC51_1 - RLOC52_1) , 0) * (1 - V_CNR) ;
RLOC53 = RLOC53_1 * (1-ART1731BIS) + min( RLOC53_1 , RLOC53_2 ) * ART1731BIS ;

RLOC54_1 = max(min((INVRETPN * (1 - INDPLAF) + INVRETPNA * INDPLAF) , RRILOC_1 - RLOC7A50_1 - somme(i=51..53 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC54 = RLOC54_1 * (1-ART1731BIS) + min( RLOC54_1 , RLOC54_2 ) * ART1731BIS ;

RLOC55_1 = max(min((INVRETPS * (1 - INDPLAF) + INVRETPSA * INDPLAF) , RRILOC_1 - RLOC7A50_1 - somme(i=51..54 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC55 = RLOC55_1 * (1-ART1731BIS) + min( RLOC55_1 , RLOC55_2 ) * ART1731BIS ;

RLOC56_1 = max(min((INVRETPX * (1 - INDPLAF) + INVRETPXA * INDPLAF) , RRILOC_1 - RLOC7A50_1 -somme(i=51..55 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC56 = RLOC56_1 * (1-ART1731BIS) + min( RLOC56_1 , RLOC56_2 ) * ART1731BIS ;

RLOC57_1 = max(min((INVRETRK * (1 - INDPLAF) + INVRETRKA * INDPLAF) , RRILOC_1 - RLOC7A50_1 -somme(i=51..56 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC57 = RLOC57_1 * (1-ART1731BIS) + min( RLOC57_1 , RLOC57_2 ) * ART1731BIS ;

RLOC58_1 = max(min((INVRETRP * (1 - INDPLAF) + INVRETRPA * INDPLAF) , RRILOC_1 - RLOC7A50_1 -somme(i=51..57 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC58 = RLOC58_1 * (1-ART1731BIS) + min( RLOC58_1 , RLOC58_2 ) * ART1731BIS ;

RLOC59_1 = max(min((INVRETRU * (1 - INDPLAF) + INVRETRUA * INDPLAF) , RRILOC_1 - RLOC7A50_1 -somme(i=51..58 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC59 = RLOC59_1 * (1-ART1731BIS) + min( RLOC59_1 , RLOC59_2 ) * ART1731BIS ;

RLOC60_1 = max(min((INVRETNU * (1 - INDPLAF) + INVRETNUA * INDPLAF) , RRILOC_1 - RLOC7A50_1 -somme(i=51..59 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC60 = RLOC60_1 * (1-ART1731BIS) + min( RLOC60_1 , RLOC60_2 ) * ART1731BIS ;

RLOC61_1 = max(min((INVRETPP * (1 - INDPLAF) + INVRETPPA * INDPLAF) , RRILOC_1 - RLOC7A50_1 -somme(i=51..60 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC61 = RLOC61_1 * (1-ART1731BIS) + min( RLOC61_1 , RLOC61_2 ) * ART1731BIS ;

RLOC62_1 = max(min((INVRETPU * (1 - INDPLAF) + INVRETPUA * INDPLAF) , RRILOC_1 - RLOC7A50_1 -somme(i=51..61 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC62 = RLOC62_1 * (1-ART1731BIS) + min( RLOC62_1 , RLOC62_2 ) * ART1731BIS ;

RLOC63_1 = max(min((INVRETRG * (1 - INDPLAF) + INVRETRGA * INDPLAF) , RRILOC_1 - RLOC7A50_1 -somme(i=51..62 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC63 = RLOC63_1 * (1-ART1731BIS) + min( RLOC63_1 , RLOC63_2 ) * ART1731BIS ;

RLOC64_1 = max(min((INVRETRM * (1 - INDPLAF) + INVRETRMA * INDPLAF) , RRILOC_1 - RLOC7A50_1 -somme(i=51..63 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC64 = RLOC64_1 * (1-ART1731BIS) + min( RLOC64_1 , RLOC64_2 ) * ART1731BIS ;

RLOC65_1 = max(min((INVRETRR * (1 - INDPLAF) + INVRETRRA * INDPLAF) , RRILOC_1 - RLOC7A50_1 -somme(i=51..64 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC65 = RLOC65_1 * (1-ART1731BIS) + min( RLOC65_1 , RLOC65_2 ) * ART1731BIS ;

RLOC66_1 = max(min((INVRETRW * (1 - INDPLAF) + INVRETRWA * INDPLAF) , RRILOC_1 - RLOC7A50_1 -somme(i=51..65 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC66 = RLOC66_1 * (1-ART1731BIS) + min( RLOC66_1 , RLOC66_2 ) * ART1731BIS ;

RLOC67_1 = max(min((INVRETNW * (1 - INDPLAF) + INVRETNWA * INDPLAF) , RRILOC_1 - RLOC7A50_1 -somme(i=51..66 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC67 = RLOC67_1 * (1-ART1731BIS) + min( RLOC67_1 , RLOC67_2 ) * ART1731BIS ;

RLOC68_1 = max(min((INVRETPR * (1 - INDPLAF) + INVRETPRA * INDPLAF) , RRILOC_1 - RLOC7A50_1 -somme(i=51..67 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC68 = RLOC68_1 * (1-ART1731BIS) + min( RLOC68_1 , RLOC68_2 ) * ART1731BIS ;

RLOC69_1 = max(min((INVRETPW * (1 - INDPLAF) + INVRETPWA * INDPLAF) , RRILOC_1 - RLOC7A50_1 -somme(i=51..68 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC69 = RLOC69_1 * (1-ART1731BIS) + min( RLOC69_1 , RLOC69_2 ) * ART1731BIS ;

RLOC70_1 = max(min((INVRETRI * (1 - INDPLAF) + INVRETRIA * INDPLAF) , RRILOC_1 - RLOC7A50_1 -somme(i=51..69 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC70 = RLOC70_1 * (1-ART1731BIS) + min( RLOC70_1 , RLOC70_2 ) * ART1731BIS ;

RLOC71_1 = max(min((INVRETRO * (1 - INDPLAF) + INVRETROA * INDPLAF) , RRILOC_1 - RLOC7A50_1 -somme(i=51..70 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC71 = RLOC71_1 * (1-ART1731BIS) + min( RLOC71_1 , RLOC71_2 ) * ART1731BIS ;

RLOC72_1 = max(min((INVRETRT * (1 - INDPLAF) + INVRETRTA * INDPLAF) , RRILOC_1 - RLOC7A50_1 -somme(i=51..71 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC72 = RLOC72_1 * (1-ART1731BIS) + min( RLOC72_1 , RLOC72_2 ) * ART1731BIS ;

RLOC73_1 = max(min((INVRETRY * (1 - INDPLAF) + INVRETRYA * INDPLAF) , RRILOC_1 - RLOC7A50_1 -somme(i=51..72 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC73 = RLOC73_1 * (1-ART1731BIS) + min( RLOC73_1 , RLOC73_2 ) * ART1731BIS ;

RLOC74_1 = max(min((INVRETNY * (1 - INDPLAF) + INVRETNYA * INDPLAF) , RRILOC_1 - RLOC7A50_1 -somme(i=51..73 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC74 = RLOC74_1 * (1-ART1731BIS) + min( RLOC74_1 , RLOC74_2 ) * ART1731BIS ;

RLOC75_1 = max(min((INVRETPOR * (1 - INDPLAF) + INVRETPORA * INDPLAF) , RRILOC_1 - RLOC7A50_1 -somme(i=51..74 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC75 = RLOC75_1 * (1-ART1731BIS) + min( RLOC75_1 , RLOC75_2 ) * ART1731BIS ;

RLOC76_1 = max(min((INVRETPTR * (1 - INDPLAF) + INVRETPTRA * INDPLAF) , RRILOC_1 - RLOC7A50_1 -somme(i=51..75 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC76 = RLOC76_1 * (1-ART1731BIS) + min( RLOC76_1 , RLOC76_2 ) * ART1731BIS ;

RLOC77_1 = max(min((INVRETPYR * (1 - INDPLAF) + INVRETPYRA * INDPLAF) , RRILOC_1 - RLOC7A50_1 -somme(i=51..76 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC77 = RLOC77_1 * (1-ART1731BIS) + min( RLOC77_1 , RLOC77_2 ) * ART1731BIS ;

RLOC78_1 = max(min((INVRETRLR * (1 - INDPLAF) + INVRETRLRA * INDPLAF) , RRILOC_1 - RLOC7A50_1 -somme(i=51..77 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC78 = RLOC78_1 * (1-ART1731BIS) + min( RLOC78_1 , RLOC78_2 ) * ART1731BIS ;

RLOC79_1 = max(min((INVRETRQR * (1 - INDPLAF) + INVRETRQRA * INDPLAF) , RRILOC_1 - RLOC7A50_1 -somme(i=51..78 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC79 = RLOC79_1 * (1-ART1731BIS) + min( RLOC79_1 , RLOC79_2 ) * ART1731BIS ;

RLOC80_1 = max(min((INVRETRVR * (1 - INDPLAF) + INVRETRVRA * INDPLAF) , RRILOC_1 - RLOC7A50_1 -somme(i=51..79 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC80 = RLOC80_1 * (1-ART1731BIS) + min( RLOC80_1 , RLOC80_2 ) * ART1731BIS ;

RLOC81_1 = max(min((INVRETNVR * (1 - INDPLAF) + INVRETNVRA * INDPLAF) , RRILOC_1 - RLOC7A50_1 -somme(i=51..80 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC81 = RLOC81_1 * (1-ART1731BIS) + min( RLOC81_1 , RLOC81_2 ) * ART1731BIS ;

RLOC82_1 = max(min((INVRETPNR * (1 - INDPLAF) + INVRETPNRA * INDPLAF) , RRILOC_1 - RLOC7A50_1 -somme(i=51..81 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC82 = RLOC82_1 * (1-ART1731BIS) + min( RLOC82_1 , RLOC82_2 ) * ART1731BIS ;

RLOC83_1 = max(min((INVRETPSR * (1 - INDPLAF) + INVRETPSRA * INDPLAF) , RRILOC_1 - RLOC7A50_1 -somme(i=51..82 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC83 = RLOC83_1 * (1-ART1731BIS) + min( RLOC83_1 , RLOC83_2 ) * ART1731BIS ;

RLOC84_1 = max(min((INVRETPXR * (1 - INDPLAF) + INVRETPXRA * INDPLAF) , RRILOC_1 - RLOC7A50_1 -somme(i=51..83 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC84 = RLOC84_1 * (1-ART1731BIS) + min( RLOC84_1 , RLOC84_2 ) * ART1731BIS ;

RLOC85_1 = max(min((INVRETRKR * (1 - INDPLAF) + INVRETRKRA * INDPLAF) , RRILOC_1 - RLOC7A50_1 -somme(i=51..84 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC85 = RLOC85_1 * (1-ART1731BIS) + min( RLOC85_1 , RLOC85_2 ) * ART1731BIS ;

RLOC86_1 = max(min((INVRETRPR * (1 - INDPLAF) + INVRETRPRA * INDPLAF) , RRILOC_1 - RLOC7A50_1 -somme(i=51..85 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC86 = RLOC86_1 * (1-ART1731BIS) + min( RLOC86_1 , RLOC86_2 ) * ART1731BIS ;

RLOC87_1 = max(min((INVRETRUR * (1 - INDPLAF) + INVRETRURA * INDPLAF) , RRILOC_1 - RLOC7A50_1 -somme(i=51..86 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC87 = RLOC87_1 * (1-ART1731BIS) + min( RLOC87_1 , RLOC87_2 ) * ART1731BIS ;

RLOC88_1 = max(min((INVRETNUR * (1 - INDPLAF) + INVRETNURA * INDPLAF) , RRILOC_1 - RLOC7A50_1 -somme(i=51..87 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC88 = RLOC88_1 * (1-ART1731BIS) + min( RLOC88_1 , RLOC88_2 ) * ART1731BIS ;

RLOC89_1 = max(min((INVRETSB * (1 - INDPLAF) + INVRETSBA * INDPLAF) , RRILOC_1 - RLOC7A50_1 -somme(i=51..88 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC89 = RLOC89_1 * (1-ART1731BIS) + min( RLOC89_1 , RLOC89_2 ) * ART1731BIS ;

RLOC90_1 = max(min((INVRETSG * (1 - INDPLAF) + INVRETSGA * INDPLAF) , RRILOC_1 - RLOC7A50_1 -somme(i=51..89 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC90 = RLOC90_1 * (1-ART1731BIS) + min( RLOC90_1 , RLOC90_2 ) * ART1731BIS ;

RLOC91_1 = max(min((INVRETSL * (1 - INDPLAF) + INVRETSLA * INDPLAF) , RRILOC_1 - RLOC7A50_1 -somme(i=51..90 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC91 = RLOC91_1 * (1-ART1731BIS) + min( RLOC91_1 , RLOC91_2 ) * ART1731BIS ;

RLOC92_1 = max(min((INVRETSQ * (1 - INDPLAF) + INVRETSQA * INDPLAF) , RRILOC_1 - RLOC7A50_1 -somme(i=51..91 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC92 = RLOC92_1 * (1-ART1731BIS) + min( RLOC92_1 , RLOC92_2 ) * ART1731BIS ;

RLOC93_1 = max(min((INVRETSV * (1 - INDPLAF) + INVRETSVA * INDPLAF) , RRILOC_1 - RLOC7A50_1 -somme(i=51..92 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC93 = RLOC93_1 * (1-ART1731BIS) + min( RLOC93_1 , RLOC93_2 ) * ART1731BIS ;

RLOC94_1 = max(min((INVRETTA * (1 - INDPLAF) + INVRETTAA * INDPLAF) , RRILOC_1 - RLOC7A50_1 -somme(i=51..93 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC94 = RLOC94_1 * (1-ART1731BIS) + min( RLOC94_1 , RLOC94_2 ) * ART1731BIS ;

RLOC95_1 = max(min((INVRETSA * (1 - INDPLAF) + INVRETSAA * INDPLAF) , RRILOC_1 - RLOC7A50_1 -somme(i=51..94 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC95 = RLOC95_1 * (1-ART1731BIS) + min( RLOC95_1 , RLOC95_2 ) * ART1731BIS ;

RLOC96_1 = max(min((INVRETSF * (1 - INDPLAF) + INVRETSFA * INDPLAF) , RRILOC_1 - RLOC7A50_1 -somme(i=51..95 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC96 = RLOC96_1 * (1-ART1731BIS) + min( RLOC96_1 , RLOC96_2 ) * ART1731BIS ;

RLOC97_1 = max(min((INVRETSK * (1 - INDPLAF) + INVRETSKA * INDPLAF) , RRILOC_1 - RLOC7A50_1 -somme(i=51..96 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC97 = RLOC97_1 * (1-ART1731BIS) + min( RLOC97_1 , RLOC97_2 ) * ART1731BIS ;

RLOC98_1 = max(min((INVRETSP * (1 - INDPLAF) + INVRETSPA * INDPLAF) , RRILOC_1 - RLOC7A50_1 -somme(i=51..97 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC98 = RLOC98_1 * (1-ART1731BIS) + min( RLOC98_1 , RLOC98_2 ) * ART1731BIS ;

RLOC99_1 = max(min((INVRETSU * (1 - INDPLAF) + INVRETSUA * INDPLAF) , RRILOC_1 - RLOC7A50_1 -somme(i=51..98 : RLOCi_1)) , 0) * (1 - V_CNR) ;
RLOC99 = RLOC99_1 * (1-ART1731BIS) + min( RLOC99_1 , RLOC99_2 ) * ART1731BIS ;

RLOC7A99_1 =  RLOC7A50_1 + somme(i=51..99 : RLOCi_1) ;

RLOC100_1 = max(min((INVRETSZ * (1 - INDPLAF) + INVRETSZA * INDPLAF) , RRILOC_1 - RLOC7A99_1) , 0) * (1 - V_CNR) ;
RLOC100 = RLOC100_1 * (1-ART1731BIS) + min( RLOC100_1 , RLOC100_2 ) * ART1731BIS ;

RLOC101_1 = max(min((INVRETSC * (1 - INDPLAF) + INVRETSCA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - RLOC100_1) , 0) * (1 - V_CNR) ;
RLOC101 = RLOC101_1 * (1-ART1731BIS) + min( RLOC101_1 , RLOC101_2 ) * ART1731BIS ;

RLOC102_1 = max(min((INVRETSH * (1 - INDPLAF) + INVRETSHA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - RLOC100_1 -RLOC101_1) , 0) * (1 - V_CNR) ;
RLOC102 = RLOC102_1 * (1-ART1731BIS) + min( RLOC102_1 , RLOC102_2 ) * ART1731BIS ;

RLOC103_1 = max(min((INVRETSM * (1 - INDPLAF) + INVRETSMA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..2 : RLOC10i_1)) , 0) * (1 - V_CNR) ;
RLOC103 = RLOC103_1 * (1-ART1731BIS) + min( RLOC103_1 , RLOC103_2 ) * ART1731BIS ;

RLOC104_1 = max(min((INVRETSR * (1 - INDPLAF) + INVRETSRA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..3 : RLOC10i_1)) , 0) * (1 - V_CNR) ;
RLOC104 = RLOC104_1 * (1-ART1731BIS) + min( RLOC104_1 , RLOC104_2 ) * ART1731BIS ;

RLOC105_1 = max(min((INVRETSW * (1 - INDPLAF) + INVRETSWA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..4 : RLOC10i_1)) , 0) * (1 - V_CNR) ;
RLOC105 = RLOC105_1 * (1-ART1731BIS) + min( RLOC105_1 , RLOC105_2 ) * ART1731BIS ;

RLOC106_1 = max(min((INVRETTB * (1 - INDPLAF) + INVRETTBA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..5 : RLOC10i_1)) , 0) * (1 - V_CNR) ;
RLOC106 = RLOC106_1 * (1-ART1731BIS) + min( RLOC106_1 , RLOC106_2 ) * ART1731BIS ;

RLOC107_1 = max(min((INVRETSE * (1 - INDPLAF) + INVRETSEA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..6 : RLOC10i_1)) , 0) * (1 - V_CNR) ;
RLOC107 = RLOC107_1 * (1-ART1731BIS) + min( RLOC107_1 , RLOC107_2 ) * ART1731BIS ;

RLOC108_1 = max(min((INVRETSJ * (1 - INDPLAF) + INVRETSJA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..7 : RLOC10i_1)) , 0) * (1 - V_CNR) ;
RLOC108 = RLOC108_1 * (1-ART1731BIS) + min( RLOC108_1 , RLOC108_2 ) * ART1731BIS ;

RLOC109_1 = max(min((INVRETSO * (1 - INDPLAF) + INVRETSOA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..8 : RLOC10i_1)) , 0) * (1 - V_CNR) ;
RLOC109 = RLOC109_1 * (1-ART1731BIS) + min( RLOC109_1 , RLOC109_2 ) * ART1731BIS ;

RLOC110_1 = max(min((INVRETST * (1 - INDPLAF) + INVRETSTA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..9 : RLOC10i_1)) , 0) * (1 - V_CNR) ;
RLOC110 = RLOC110_1 * (1-ART1731BIS) + min( RLOC110_1 , RLOC110_2 ) * ART1731BIS ;

RLOC111_1 = max(min((INVRETSY * (1 - INDPLAF) + INVRETSYA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..10 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC111 = RLOC111_1 * (1-ART1731BIS) + min( RLOC111_1 , RLOC111_2 ) * ART1731BIS ;

RLOC112_1 = max(min((INVRETTD * (1 - INDPLAF) + INVRETTDA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..11 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC112 = RLOC112_1 * (1-ART1731BIS) + min( RLOC112_1 , RLOC112_2 ) * ART1731BIS ;

RLOC113_1 = max(min((INVRETSBR * (1 - INDPLAF) + INVRETSBRA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..12 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC113 = RLOC113_1 * (1-ART1731BIS) + min( RLOC113_1 , RLOC113_2 ) * ART1731BIS ;

RLOC114_1 = max(min((INVRETSGR * (1 - INDPLAF) + INVRETSGRA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..13 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC114 = RLOC114_1 * (1-ART1731BIS) + min( RLOC114_1 , RLOC114_2 ) * ART1731BIS ;

RLOC115_1 = max(min((INVRETSAR * (1 - INDPLAF) + INVRETSARA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..14 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC115 = RLOC115_1 * (1-ART1731BIS) + min( RLOC115_1 , RLOC115_2 ) * ART1731BIS ;

RLOC116_1 = max(min((INVRETSFR * (1 - INDPLAF) + INVRETSFRA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..15 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC116 = RLOC116_1 * (1-ART1731BIS) + min( RLOC116_1 , RLOC116_2 ) * ART1731BIS ;

RLOC117_1 = max(min((INVRETSLR * (1 - INDPLAF) + INVRETSLRA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..16 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC117 = RLOC117_1 * (1-ART1731BIS) + min( RLOC117_1 , RLOC117_2 ) * ART1731BIS ;

RLOC118_1 = max(min((INVRETSQR * (1 - INDPLAF) + INVRETSQRA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..17 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC118 = RLOC118_1 * (1-ART1731BIS) + min( RLOC118_1 , RLOC118_2 ) * ART1731BIS ;

RLOC119_1 = max(min((INVRETSVR * (1 - INDPLAF) + INVRETSVRA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..18 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC119 = RLOC119_1 * (1-ART1731BIS) + min( RLOC119_1 , RLOC119_2 ) * ART1731BIS ;

RLOC120_1 = max(min((INVRETTAR * (1 - INDPLAF) + INVRETTARA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..19 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC120 = RLOC120_1 * (1-ART1731BIS) + min( RLOC120_1 , RLOC120_2 ) * ART1731BIS ;

RLOC121_1 = max(min((INVRETSKR * (1 - INDPLAF) + INVRETSKRA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..20 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC121 = RLOC121_1 * (1-ART1731BIS) + min( RLOC121_1 , RLOC121_2 ) * ART1731BIS ;

RLOC122_1 = max(min((INVRETSPR * (1 - INDPLAF) + INVRETSPRA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..21 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC122 = RLOC122_1 * (1-ART1731BIS) + min( RLOC122_1 , RLOC122_2 ) * ART1731BIS ;

RLOC123_1 = max(min((INVRETSUR * (1 - INDPLAF) + INVRETSURA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..22 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC123 = RLOC123_1 * (1-ART1731BIS) + min( RLOC123_1 , RLOC123_2 ) * ART1731BIS ;

RLOC124_1 = max(min((INVRETSZR * (1 - INDPLAF) + INVRETSZRA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..23 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC124 = RLOC124_1 * (1-ART1731BIS) + min( RLOC124_1 , RLOC124_2 ) * ART1731BIS ;

RLOC125_1 = max(min((INVRETAB * (1 - INDPLAF) + INVRETABA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..24 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC125 = RLOC125_1 * (1-ART1731BIS) + min( RLOC125_1 , RLOC125_2 ) * ART1731BIS ;

RLOC126_1 = max(min((INVRETAG * (1 - INDPLAF) + INVRETAGA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..25 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC126 = RLOC126_1 * (1-ART1731BIS) + min( RLOC126_1 , RLOC126_2 ) * ART1731BIS ;

RLOC127_1 = max(min((INVRETAL * (1 - INDPLAF) + INVRETALA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..26 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC127 = RLOC127_1 * (1-ART1731BIS) + min( RLOC127_1 , RLOC127_2 ) * ART1731BIS ;

RLOC128_1 = max(min((INVRETAQ * (1 - INDPLAF) + INVRETAQA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..27 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC128 = RLOC128_1 * (1-ART1731BIS) + min( RLOC128_1 , RLOC128_2 ) * ART1731BIS ;

RLOC129_1 = max(min((INVRETAV * (1 - INDPLAF) + INVRETAVA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..28 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC129 = RLOC129_1 * (1-ART1731BIS) + min( RLOC129_1 , RLOC129_2 ) * ART1731BIS ;

RLOC130_1 = max(min((INVRETBB * (1 - INDPLAF) + INVRETBBA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..29 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC130 = RLOC130_1 * (1-ART1731BIS) + min( RLOC130_1 , RLOC130_2 ) * ART1731BIS ;

RLOC131_1 = max(min((INVRETAA * (1 - INDPLAF) + INVRETAAA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..30 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC131 = RLOC131_1 * (1-ART1731BIS) + min( RLOC131_1 , RLOC131_2 ) * ART1731BIS ;

RLOC132_1 = max(min((INVRETAF * (1 - INDPLAF) + INVRETAFA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..31 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC132 = RLOC132_1 * (1-ART1731BIS) + min( RLOC132_1 , RLOC132_2 ) * ART1731BIS ;

RLOC133_1 = max(min((INVRETAK * (1 - INDPLAF) + INVRETAKA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..32 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC133 = RLOC133_1 * (1-ART1731BIS) + min( RLOC133_1 , RLOC133_2 ) * ART1731BIS ;

RLOC134_1 = max(min((INVRETAP * (1 - INDPLAF) + INVRETAPA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..33 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC134 = RLOC134_1 * (1-ART1731BIS) + min( RLOC134_1 , RLOC134_2 ) * ART1731BIS ;

RLOC135_1 = max(min((INVRETAU * (1 - INDPLAF) + INVRETAUA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..34 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC135 = RLOC135_1 * (1-ART1731BIS) + min( RLOC135_1 , RLOC135_2 ) * ART1731BIS ;

RLOC136_1 = max(min((INVRETBA * (1 - INDPLAF) + INVRETBAA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..35 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC136 = RLOC136_1 * (1-ART1731BIS) + min( RLOC136_1 , RLOC136_2 ) * ART1731BIS ;

RLOC137_1 = max(min((INVRETAC * (1 - INDPLAF) + INVRETACA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..36 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC137 = RLOC137_1 * (1-ART1731BIS) + min( RLOC137_1 , RLOC137_2 ) * ART1731BIS ;

RLOC138_1 = max(min((INVRETAH * (1 - INDPLAF) + INVRETAHA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..37 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC138 = RLOC138_1 * (1-ART1731BIS) + min( RLOC138_1 , RLOC138_2 ) * ART1731BIS ;

RLOC139_1 = max(min((INVRETAM * (1 - INDPLAF) + INVRETAMA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..38 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC139 = RLOC139_1 * (1-ART1731BIS) + min( RLOC139_1 , RLOC139_2 ) * ART1731BIS ;

RLOC140_1 = max(min((INVRETAR * (1 - INDPLAF) + INVRETARA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..39 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC140 = RLOC140_1 * (1-ART1731BIS) + min( RLOC140_1 , RLOC140_2 ) * ART1731BIS ;

RLOC141_1 = max(min((INVRETAW * (1 - INDPLAF) + INVRETAWA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..40 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC141 = RLOC141_1 * (1-ART1731BIS) + min( RLOC141_1 , RLOC141_2 ) * ART1731BIS ;

RLOC142_1 = max(min((INVRETBE * (1 - INDPLAF) + INVRETBEA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..41 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC142 = RLOC142_1 * (1-ART1731BIS) + min( RLOC142_1 , RLOC142_2 ) * ART1731BIS ;

RLOC143_1 = max(min((INVRETAE * (1 - INDPLAF) + INVRETAEA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..42 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC143 = RLOC143_1 * (1-ART1731BIS) + min( RLOC143_1 , RLOC143_2 ) * ART1731BIS ;

RLOC144_1 = max(min((INVRETAJ * (1 - INDPLAF) + INVRETAJA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..43 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC144 = RLOC144_1 * (1-ART1731BIS) + min( RLOC144_1 , RLOC144_2 ) * ART1731BIS ;

RLOC145_1 = max(min((INVRETAO * (1 - INDPLAF) + INVRETAOA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..44 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC145 = RLOC145_1 * (1-ART1731BIS) + min( RLOC145_1 , RLOC145_2 ) * ART1731BIS ;

RLOC146_1 = max(min((INVRETAT * (1 - INDPLAF) + INVRETATA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..45 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC146 = RLOC146_1 * (1-ART1731BIS) + min( RLOC146_1 , RLOC146_2 ) * ART1731BIS ;

RLOC147_1 = max(min((INVRETAY * (1 - INDPLAF) + INVRETAYA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..46 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC147 = RLOC147_1 * (1-ART1731BIS) + min( RLOC147_1 , RLOC147_2 ) * ART1731BIS ;

RLOC148_1 = max(min((INVRETBG * (1 - INDPLAF) + INVRETBGA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..47 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC148 = RLOC148_1 * (1-ART1731BIS) + min( RLOC148_1 , RLOC148_2 ) * ART1731BIS ;

RLOC149_1 = max(min((INVRETABR * (1 - INDPLAF) + INVRETABRA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..48 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC149 = RLOC149_1 * (1-ART1731BIS) + min( RLOC149_1 , RLOC149_2 ) * ART1731BIS ;

RLOC150_1 = max(min((INVRETAGR * (1 - INDPLAF) + INVRETAGRA * INDPLAF) , RRILOC_1 - RLOC7A99_1 - somme(i=0..49 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC150 = RLOC150_1 * (1-ART1731BIS) + min( RLOC150_1 , RLOC150_2 ) * ART1731BIS ;

RLOC7A150_1 = RLOC7A99_1 + somme(i=0..50 : RLOC1i_1) ;

RLOC151_1 = max(min((INVRETALR * (1 - INDPLAF) + INVRETALRA * INDPLAF) , RRILOC_1 - RLOC7A150_1) , 0) * (1 - V_CNR) ;
RLOC151 = RLOC151_1 * (1-ART1731BIS) + min( RLOC151_1 , RLOC151_2 ) * ART1731BIS ;

RLOC152_1 = max(min((INVRETAQR * (1 - INDPLAF) + INVRETAQRA * INDPLAF) , RRILOC_1 - RLOC7A150_1 - RLOC151_1) , 0) * (1 - V_CNR) ;
RLOC152 = RLOC152_1 * (1-ART1731BIS) + min( RLOC152_1 , RLOC152_2 ) * ART1731BIS ;

RLOC153_1 = max(min((INVRETAVR * (1 - INDPLAF) + INVRETAVRA * INDPLAF) , RRILOC_1 - RLOC7A150_1 - somme(i=51..52 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC153 = RLOC153_1 * (1-ART1731BIS) + min( RLOC153_1 , RLOC153_2 ) * ART1731BIS ;

RLOC154_1 = max(min((INVRETBBR * (1 - INDPLAF) + INVRETBBRA * INDPLAF) , RRILOC_1 - RLOC7A150_1 - somme(i=51..53 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC154 = RLOC154_1 * (1-ART1731BIS) + min( RLOC154_1 , RLOC154_2 ) * ART1731BIS ;

RLOC155_1 = max(min((INVRETAAR * (1 - INDPLAF) + INVRETAARA * INDPLAF) , RRILOC_1 - RLOC7A150_1 - somme(i=51..54 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC155 = RLOC155_1 * (1-ART1731BIS) + min( RLOC155_1 , RLOC155_2 ) * ART1731BIS ;

RLOC156_1 = max(min((INVRETAFR * (1 - INDPLAF) + INVRETAFRA * INDPLAF) , RRILOC_1 - RLOC7A150_1 - somme(i=51..55 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC156 = RLOC156_1 * (1-ART1731BIS) + min( RLOC156_1 , RLOC156_2 ) * ART1731BIS ;

RLOC157_1 = max(min((INVRETAKR * (1 - INDPLAF) + INVRETAKRA * INDPLAF) , RRILOC_1 - RLOC7A150_1 - somme(i=51..56 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC157 = RLOC157_1 * (1-ART1731BIS) + min( RLOC157_1 , RLOC157_2 ) * ART1731BIS ;

RLOC158_1 = max(min((INVRETAPR * (1 - INDPLAF) + INVRETAPRA * INDPLAF) , RRILOC_1 - RLOC7A150_1 - somme(i=51..57 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC158 = RLOC158_1 * (1-ART1731BIS) + min( RLOC158_1 , RLOC158_2 ) * ART1731BIS ;

RLOC159_1 = max(min((INVRETAUR * (1 - INDPLAF) + INVRETAURA * INDPLAF) , RRILOC_1 - RLOC7A150_1 - somme(i=51..58 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC159 = RLOC159_1 * (1-ART1731BIS) + min( RLOC159_1 , RLOC159_2 ) * ART1731BIS ;

RLOC160_1 = max(min((INVRETBAR * (1 - INDPLAF) + INVRETBARA * INDPLAF) , RRILOC_1 - RLOC7A150_1 - somme(i=51..59 : RLOC1i_1)) , 0) * (1 - V_CNR) ;
RLOC160 = RLOC160_1 * (1-ART1731BIS) + min( RLOC160_1 , RLOC160_2 ) * ART1731BIS ;


RCOLENT_1 = ((1-V_INDTEO) * (somme(i=7..99 : RLOCi_1) + somme(i=0..60 : RLOC1i_1))
          + (V_INDTEO) * ( RLOC07_1 + RLOC18_1 + RLOC19_1 +RLOC45_1 + RLOC46_1
                        + arr((V_RLOC10+V_RLOC16)*(TX50/100))
			+ arr((V_RLOC08+V_RLOC14)*(TX60/100))
			+ arr((V_RLOC25+V_RLOC40)*(TX50/100))
			+ arr((V_RLOC20+V_RLOC35)*(TX60/100))
			+ arr((V_RLOC54+V_RLOC82)*(TX50/100))
			+ arr((V_RLOC47+V_RLOC75)*(TX60/100))
			+ arr((V_RLOC27+V_RLOC42)*(5263/10000))
			+ arr((V_RLOC22+V_RLOC37)*(625/1000))
			+ arr((V_RLOC57+V_RLOC85)*(5263/10000))
			+ arr((V_RLOC50+V_RLOC78)*(625/1000))
  #HAK - 2010
                     + arr((V_RLOC133+V_RLOC157)*(5263/10000))
                        + arr((V_RLOC127+V_RLOC151)*(625/1000))
                        + arr((V_RLOC131+V_RLOC155)*(5263/10000))
                        + arr((V_RLOC125+V_RLOC149)*(625/1000))
                        + arr((V_RLOC11+V_RLOC17)*(TX50/100))
                        + arr((V_RLOC09+V_RLOC15)*(60/100))
                        + arr((V_RLOC26+V_RLOC41)*(50/100))
                        + arr((V_RLOC21+V_RLOC36)*(60/100))
                        + arr((V_RLOC55+V_RLOC83)*(50/100))
                        + arr((V_RLOC48+V_RLOC76)*(60/100))
                        + arr((V_RLOC28+V_RLOC43)*(5263/10000))
                        + arr((V_RLOC23+V_RLOC38)*(625/1000))
                        + arr((V_RLOC58+V_RLOC86)*(5263/10000))
                        + arr((V_RLOC51+V_RLOC79)*(625/1000))
                        + arr((V_RLOC95+V_RLOC115)*(5263/10000))
                        + arr((V_RLOC89+V_RLOC113)*(625/1000))
                        + arr((V_RLOC97+V_RLOC121)*(5263/10000))
                        + arr((V_RLOC91+V_RLOC117)*(625/1000))
   #HAP - 2011 
		+ arr((V_RLOC134+V_RLOC158)*(5263/10000))
                        + arr((V_RLOC128+V_RLOC152)*(625/1000))
                        + arr((V_RLOC132+V_RLOC156)*(5263/10000))
                        + arr((V_RLOC126+V_RLOC150)*(625/1000))
         		+ arr((V_RLOC29+V_RLOC44)*(5263/10000))
			+ arr((V_RLOC24+V_RLOC39)*(625/1000))
                        + arr((V_RLOC56+V_RLOC84)*(5263/10000))
                        + arr((V_RLOC49+V_RLOC77)*(625/1000))
                        + arr((V_RLOC59+V_RLOC87)*(5263/10000))
                        + arr((V_RLOC52+V_RLOC80)*(625/1000))
                        + arr((V_RLOC96+V_RLOC116)*(5263/10000))
                        + arr((V_RLOC90+V_RLOC114)*(625/1000))
                        + arr((V_RLOC98+V_RLOC122)*(5263/10000))
                        + arr((V_RLOC92+V_RLOC118)*(625/1000))

   #HAU - 2012
                + arr((V_RLOC135+V_RLOC159)*(5263/10000))
                        + arr((V_RLOC129+V_RLOC153)*(625/1000))
                        + arr((V_RLOC60+V_RLOC88)*(5263/10000))
                        + arr((V_RLOC53+V_RLOC81)*(625/1000))
                        + arr((V_RLOC99+V_RLOC123)*(5263/10000))
                        + arr((V_RLOC93+V_RLOC119)*(625/1000))

   #HBA - 2013-2015 pour A1b
                + arr((V_RLOC136+V_RLOC160)*(5263/10000))
                        + arr((V_RLOC130+V_RLOC154)*(625/1000))
                        + arr((V_RLOC100+V_RLOC124)*(5263/10000))
                        + arr((V_RLOC94+V_RLOC120)*(625/1000))
			
			)) * (1 - V_CNR) ;

RCOLENT = RCOLENT_1 * (1-ART1731BIS) 
          + min( RCOLENT_1 , RCOLENT_2) * ART1731BIS ;

regle 402130:
application : iliad, batch ;


RRIREP_1 = RRI1_1 - DLOGDOM - RTOURES_1 - RTOURREP_1 - RTOUHOTR_1 - RTOUREPA_1 - RCOMP_1 - RRETU_1 
              - RDONS_1 - CRDIE_1 - RCELTOT_1 - RLOCNPRO_1 - RDUFLOTOT_1 - RPINELTOT_1 - RNOUV_1 - RPLAFREPME4_1 - RPENTDY_1 - RFOR_1 
              - RPATNAT_1 - RPATNAT1_1 - RPATNAT2_1 - RPATNAT3_1 ;


RRIREP = RRI1 - DLOGDOM - RTOURES - RTOURREP - RTOUHOTR - RTOUREPA - RCOMP - RRETU - RDONS - CRDIE - RCELTOT 
              - RLOCNPRO - RDUFLOTOT - RPINELTOT - RNOUV - RPLAFREPME4 - RPENTDY - RFOR - RPATNATOT ;


REPQN =  max(0 , INVSOC2010 - max(0 , RRIREP -INVOMSOCKH-INVOMSOCKI)) * (1 - V_CNR) ;

REPQU = max(0 , INVOMSOCQU - max(0 , RRIREP -INVOMSOCKH-INVOMSOCKI-INVSOC2010)) * (1 - V_CNR) ;

REPQK = max(0 , INVLOGSOC - max(0 , RRIREP -INVOMSOCKH-INVOMSOCKI-INVSOC2010-INVOMSOCQU)) * (1 - V_CNR) ;

REPDOMSOC4 = REPQN + REPQU + REPQK ;


REPQJ = max(0 , INVOMSOCQJ - max(0 , RRIREP -INVOMSOCKH-INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC)) * (1 - V_CNR) ;

REPQS = max(0 , INVOMSOCQS - max(0 , RRIREP -INVOMSOCKH-INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-INVOMSOCQJ)) * (1 - V_CNR) ;

REPQW = max(0 , INVOMSOCQW - max(0 , RRIREP -INVOMSOCKH-INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-INVOMSOCQJ-INVOMSOCQS))  * (1 - V_CNR) ;

REPQX = max(0 , INVOMSOCQX - max(0 , RRIREP -INVOMSOCKH-INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW)) * (1 - V_CNR) ;

REPDOMSOC3 = REPQJ + REPQS + REPQW + REPQX ;


REPRA = max(0 , CODHRA - max(0 , RRIREP -INVOMSOCKH-INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW
                                        -INVOMSOCQX)) * (1 - V_CNR) ;

REPRB = max(0 , CODHRB - max(0 , RRIREP -INVOMSOCKH-INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW
                                        -INVOMSOCQX-CODHRA)) * (1 - V_CNR) ;

REPRC = max(0 , CODHRC - max(0 , RRIREP -INVOMSOCKH-INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW
                                        -INVOMSOCQX-CODHRA-CODHRB)) * (1 - V_CNR) ;


REPRD = max(0 , CODHRD - max(0 , RRIREP -INVOMSOCKH-INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW
                                        -INVOMSOCQX-CODHRA-CODHRB-CODHRC)) * (1 - V_CNR) ;

REPDOMSOC2 = REPRA + REPRB + REPRC + REPRD ;


REPXA = max(0 , CODHXA - max(0 , RRIREP -INVOMSOCKH-INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW
                                        -INVOMSOCQX-CODHRA-CODHRB-CODHRC-CODHRD)) * (1 - V_CNR) ;

REPXB = max(0 , CODHXB - max(0 , RRIREP -INVOMSOCKH-INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW
                                        -INVOMSOCQX-CODHRA-CODHRB-CODHRC-CODHRD-CODHXA)) * (1 - V_CNR) ;

REPXC = max(0 , CODHXC - max(0 , RRIREP -INVOMSOCKH-INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW
                                        -INVOMSOCQX-CODHRA-CODHRB-CODHRC-CODHRD-CODHXA-CODHXB)) * (1 - V_CNR) ;

REPXE = max(0 , CODHXE - max(0 , RRIREP -INVOMSOCKH-INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW
                                        -INVOMSOCQX-CODHRA-CODHRB-CODHRC-CODHRD-CODHXA-CODHXB-CODHXC)) * (1 - V_CNR) ;

REPDOMSOC1 = REPXA + REPXB + REPXC + REPXE ;


REPXF = max(0 , CODHXF - max(0 , RRIREP -INVOMSOCKH-INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW
                                        -INVOMSOCQX-CODHRA-CODHRB-CODHRC-CODHRD-CODHXA-CODHXB-CODHXC-CODHXE)) * (1 - V_CNR) ;

REPXG = max(0 , CODHXG - max(0 , RRIREP -INVOMSOCKH-INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW
                                        -INVOMSOCQX-CODHRA-CODHRB-CODHRC-CODHRD-CODHXA-CODHXB-CODHXC-CODHXE-CODHXF)) * (1 - V_CNR) ;

REPXH = max(0 , CODHXH - max(0 , RRIREP -INVOMSOCKH-INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW
                                        -INVOMSOCQX-CODHRA-CODHRB-CODHRC-CODHRD-CODHXA-CODHXB-CODHXC-CODHXE-CODHXF-CODHXG)) * (1 - V_CNR) ;

REPXI = max(0 , CODHXI - max(0 , RRIREP -INVOMSOCKH-INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW
                                        -INVOMSOCQX-CODHRA-CODHRB-CODHRC-CODHRD-CODHXA-CODHXB-CODHXC-CODHXE-CODHXF-CODHXG-CODHXH)) * (1 - V_CNR) ;

REPXK = max(0 , CODHXK - max(0 , RRIREP -INVOMSOCKH-INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW
                                        -INVOMSOCQX-CODHRA-CODHRB-CODHRC-CODHRD-CODHXA-CODHXB-CODHXC-CODHXE-CODHXF-CODHXG-CODHXH
                                        -CODHXI)) * (1 - V_CNR) ;

REPDOMSOC = REPXF + REPXG + REPXH + REPXI + REPXK ;

REPSOC = INVOMSOCKH + INVOMSOCKI + INVSOC2010 + INVOMSOCQU + INVLOGSOC + INVOMSOCQJ + INVOMSOCQS + INVOMSOCQW + INVOMSOCQX 
         + CODHRA + CODHRB + CODHRC + CODHRD + CODHXA + CODHXB + CODHXC + CODHXE + CODHXF + CODHXG + CODHXH + CODHXI + CODHXK ;


REPKT = (max(0 , INVOMENTKT - max(0 , RRIREP -REPSOC-INVOMENTMN-RETROCOMMB-RETROCOMMC-RETROCOMLH-RETROCOMLI)) * (1-ART1731BIS)
         + max(0 , INVOMENTKT - max(0,RCOLENT-INVOMENTMN-RETROCOMMB-RETROCOMMC-RETROCOMLH-RETROCOMLI)) * ART1731BIS
        ) * (1 - V_CNR) ;

REPKU = (max(0 , INVOMENTKU - max(0 , RRIREP -REPSOC-INVOMENTMN-RETROCOMMB-RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT)) * (1-ART1731BIS)
         + max(0 , INVOMENTKU - max(0,RCOLENT-INVOMENTMN-RETROCOMMB-RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT)) * ART1731BIS
        ) * (1 - V_CNR) ;

REPENTD = REPKT + REPKU ;

REPENT5 = INVOMENTMN + RETROCOMMB + RETROCOMMC + RETROCOMLH + RETROCOMLI + INVOMENTKT + INVOMENTKU ;


REPQV = max(0 , INVOMQV - max(0 , RRIREP -REPSOC-REPENT5)) * (1 - V_CNR) ;

REPQE = max(0 , INVENDEB2009 - max(0 , RRIREP -REPSOC-REPENT5-INVOMQV)) * (1 - V_CNR) ;

REPQP = max(0 , INVRETRO2 - max(0 , RRIREP -REPSOC-REPENT5-INVOMQV-INVENDEB2009)) * (1 - V_CNR) ;

REPQG = max(0 , INVDOMRET60 - max(0 , RRIREP -REPSOC-REPENT5-INVOMQV-INVENDEB2009-INVRETRO2)) * (1 - V_CNR) ;

REPPB = max(0 , INVOMRETPB - max(0 , RRIREP -REPSOC-REPENT5-INVOMQV-INVENDEB2009-INVRETRO2-INVDOMRET60)) * (1 - V_CNR) ;

REPPF = max(0 , INVOMRETPF - max(0 , RRIREP -REPSOC-REPENT5-INVOMQV-INVENDEB2009-INVRETRO2-INVDOMRET60-INVOMRETPB)) * (1 - V_CNR) ;

REPPJ = max(0 , INVOMRETPJ - max(0 , RRIREP -REPSOC-REPENT5-INVOMQV-INVENDEB2009-INVRETRO2-INVDOMRET60-INVOMRETPB-INVOMRETPF)) * (1 - V_CNR) ;

REPQO = max(0 , INVRETRO1 - max(0 , RRIREP -REPSOC-REPENT5-INVOMQV-INVENDEB2009-INVRETRO2-INVDOMRET60-INVOMRETPB-INVOMRETPF-INVOMRETPJ)) * (1 - V_CNR) ;

REPQF = max(0 , INVDOMRET50 - max(0 , RRIREP -REPSOC-REPENT5-INVOMQV-INVENDEB2009-INVRETRO2-INVDOMRET60-INVOMRETPB-INVOMRETPF-INVOMRETPJ
                                             -INVRETRO1)) * (1 - V_CNR) ;

REPPA = max(0 , INVOMRETPA - max(0 , RRIREP -REPSOC-REPENT5-INVOMQV-INVENDEB2009-INVRETRO2-INVDOMRET60-INVOMRETPB-INVOMRETPF-INVOMRETPJ
                                            -INVRETRO1-INVDOMRET50)) * (1 - V_CNR) ;

REPPE = max(0 , INVOMRETPE - max(0 , RRIREP -REPSOC-REPENT5-INVOMQV-INVENDEB2009-INVRETRO2-INVDOMRET60-INVOMRETPB-INVOMRETPF-INVOMRETPJ
                                            -INVRETRO1-INVDOMRET50-INVOMRETPA)) * (1 - V_CNR) ;

REPPI = max(0 , INVOMRETPI - max(0 , RRIREP -REPSOC-REPENT5-INVOMQV-INVENDEB2009-INVRETRO2-INVDOMRET60-INVOMRETPB-INVOMRETPF-INVOMRETPJ
                                            -INVRETRO1-INVDOMRET50-INVOMRETPA-INVOMRETPE)) * (1 - V_CNR) ;

REPQR = max(0 , INVIMP - max(0 , RRIREP -REPSOC-REPENT5-INVOMQV-INVENDEB2009-INVRETRO2-INVDOMRET60-INVOMRETPB-INVOMRETPF-INVOMRETPJ
                                        -INVRETRO1-INVDOMRET50-INVOMRETPA-INVOMRETPE-INVOMRETPI)) * (1 - V_CNR) ;

REPQI = max(0 , INVDIR2009 - max(0 , RRIREP -REPSOC-REPENT5-INVOMQV-INVENDEB2009-INVRETRO2-INVDOMRET60-INVOMRETPB-INVOMRETPF-INVOMRETPJ
                                            -INVRETRO1-INVDOMRET50-INVOMRETPA-INVOMRETPE-INVOMRETPI-INVIMP)) * (1 - V_CNR) ;

REPPD = max(0 , INVOMRETPD - max(0 , RRIREP -REPSOC-REPENT5-INVOMQV-INVENDEB2009-INVRETRO2-INVDOMRET60-INVOMRETPB-INVOMRETPF-INVOMRETPJ
                                            -INVRETRO1-INVDOMRET50-INVOMRETPA-INVOMRETPE-INVOMRETPI-INVIMP-INVDIR2009)) * (1 - V_CNR) ;

REPPH = max(0 , INVOMRETPH - max(0 , RRIREP -REPSOC-REPENT5-INVOMQV-INVENDEB2009-INVRETRO2-INVDOMRET60-INVOMRETPB-INVOMRETPF-INVOMRETPJ
                                            -INVRETRO1-INVDOMRET50-INVOMRETPA-INVOMRETPE-INVOMRETPI-INVIMP-INVDIR2009-INVOMRETPD)) * (1 - V_CNR) ;

REPPL = max(0 , INVOMRETPL - max(0 , RRIREP -REPSOC-REPENT5-INVOMQV-INVENDEB2009-INVRETRO2-INVDOMRET60-INVOMRETPB-INVOMRETPF-INVOMRETPJ
                                            -INVRETRO1-INVDOMRET50-INVOMRETPA-INVOMRETPE-INVOMRETPI-INVIMP-INVDIR2009-INVOMRETPD-INVOMRETPH)) * (1 - V_CNR) ;


REPDOMENTR4 = REPQE + REPQV + REPQP + REPQG + REPQO + REPQF + REPQR + REPQI + REPPB + REPPF + REPPJ + REPPA + REPPE + REPPI + REPPD + REPPH + REPPL ;

REPENT4 = INVOMQV + INVENDEB2009 + INVRETRO2 + INVDOMRET60 + INVOMRETPB + INVOMRETPF + INVOMRETPJ + INVRETRO1 + INVDOMRET50 
          + INVOMRETPA + INVOMRETPE + INVOMRETPI + INVIMP + INVDIR2009 + INVOMRETPD + INVOMRETPH + INVOMRETPL ;


REPPM = max(0 , INVOMRETPM - max(0 , RRIREP -REPSOC-REPENT5-REPENT4)) * (1 - V_CNR) ;

REPRJ = max(0 , INVOMENTRJ - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-INVOMRETPM)) * (1 - V_CNR) ;

REPPO = max(0 , INVOMRETPO - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-INVOMRETPM-INVOMENTRJ)) * (1 - V_CNR) ;

REPPT = max(0 , INVOMRETPT - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-INVOMRETPM-INVOMENTRJ-INVOMRETPO)) * (1 - V_CNR) ;

REPPY = max(0 , INVOMRETPY - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT)) * (1 - V_CNR) ;

REPRL = max(0 , INVOMENTRL - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY)) * (1 - V_CNR) ;

REPRQ = max(0 , INVOMENTRQ - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL)) * (1 - V_CNR) ;

REPRV = max(0 , INVOMENTRV - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ)) * (1 - V_CNR) ;

REPNV = max(0 , INVOMENTNV - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ
                                            -INVOMENTRV)) * (1 - V_CNR) ;

REPPN = max(0 , INVOMRETPN - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ
                                            -INVOMENTRV-INVOMENTNV)) * (1 - V_CNR) ;

REPPS = max(0 , INVOMRETPS - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ
                                            -INVOMENTRV-INVOMENTNV-INVOMRETPN)) * (1 - V_CNR) ;

REPPX = max(0 , INVOMRETPX - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ
                                            -INVOMENTRV-INVOMENTNV-INVOMRETPN-INVOMRETPS)) * (1 - V_CNR) ;

REPRK = max(0 , INVOMENTRK - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ
                                            -INVOMENTRV-INVOMENTNV-INVOMRETPN-INVOMRETPS-INVOMRETPX)) * (1 - V_CNR) ;

REPRP = max(0 , INVOMENTRP - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ
                                            -INVOMENTRV-INVOMENTNV-INVOMRETPN-INVOMRETPS-INVOMRETPX-INVOMENTRK)) * (1 - V_CNR) ;

REPRU = max(0 , INVOMENTRU - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ
                                            -INVOMENTRV-INVOMENTNV-INVOMRETPN-INVOMRETPS-INVOMRETPX-INVOMENTRK-INVOMENTRP)) * (1 - V_CNR) ;

REPNU = max(0 , INVOMENTNU - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ
                                            -INVOMENTRV-INVOMENTNV-INVOMRETPN-INVOMRETPS-INVOMRETPX-INVOMENTRK-INVOMENTRP-INVOMENTRU)) * (1 - V_CNR) ;

REPPP = max(0 , INVOMRETPP - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ
                                            -INVOMENTRV-INVOMENTNV-INVOMRETPN-INVOMRETPS-INVOMRETPX-INVOMENTRK-INVOMENTRP-INVOMENTRU-INVOMENTNU)) * (1 - V_CNR) ;

REPPU = max(0 , INVOMRETPU - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ
                                            -INVOMENTRV-INVOMENTNV-INVOMRETPN-INVOMRETPS-INVOMRETPX-INVOMENTRK-INVOMENTRP-INVOMENTRU-INVOMENTNU
                                            -INVOMRETPP)) * (1 - V_CNR) ;

REPRG = max(0 , INVOMENTRG - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ
                                            -INVOMENTRV-INVOMENTNV-INVOMRETPN-INVOMRETPS-INVOMRETPX-INVOMENTRK-INVOMENTRP-INVOMENTRU-INVOMENTNU
                                            -INVOMRETPP-INVOMRETPU)) * (1 - V_CNR) ;

REPRM = max(0 , INVOMENTRM - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ
                                            -INVOMENTRV-INVOMENTNV-INVOMRETPN-INVOMRETPS-INVOMRETPX-INVOMENTRK-INVOMENTRP-INVOMENTRU-INVOMENTNU
                                            -INVOMRETPP-INVOMRETPU-INVOMENTRG)) * (1 - V_CNR) ;

REPRR = max(0 , INVOMENTRR - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ
                                            -INVOMENTRV-INVOMENTNV-INVOMRETPN-INVOMRETPS-INVOMRETPX-INVOMENTRK-INVOMENTRP-INVOMENTRU-INVOMENTNU
                                            -INVOMRETPP-INVOMRETPU-INVOMENTRG-INVOMENTRM)) * (1 - V_CNR) ;

REPRW = max(0 , INVOMENTRW - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ
                                            -INVOMENTRV-INVOMENTNV-INVOMRETPN-INVOMRETPS-INVOMRETPX-INVOMENTRK-INVOMENTRP-INVOMENTRU-INVOMENTNU
                                            -INVOMRETPP-INVOMRETPU-INVOMENTRG-INVOMENTRM-INVOMENTRR)) * (1 - V_CNR) ;

REPNW = max(0 , INVOMENTNW - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ
                                            -INVOMENTRV-INVOMENTNV-INVOMRETPN-INVOMRETPS-INVOMRETPX-INVOMENTRK-INVOMENTRP-INVOMENTRU-INVOMENTNU
                                            -INVOMRETPP-INVOMRETPU-INVOMENTRG-INVOMENTRM-INVOMENTRR-INVOMENTRW)) * (1 - V_CNR) ;

REPPR = max(0 , INVOMRETPR - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ
                                            -INVOMENTRV-INVOMENTNV-INVOMRETPN-INVOMRETPS-INVOMRETPX-INVOMENTRK-INVOMENTRP-INVOMENTRU-INVOMENTNU
                                            -INVOMRETPP-INVOMRETPU-INVOMENTRG-INVOMENTRM-INVOMENTRR-INVOMENTRW-INVOMENTNW)) * (1 - V_CNR) ;

REPPW = max(0 , INVOMRETPW - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ
                                            -INVOMENTRV-INVOMENTNV-INVOMRETPN-INVOMRETPS-INVOMRETPX-INVOMENTRK-INVOMENTRP-INVOMENTRU-INVOMENTNU
                                            -INVOMRETPP-INVOMRETPU-INVOMENTRG-INVOMENTRM-INVOMENTRR-INVOMENTRW-INVOMENTNW-INVOMRETPR)) * (1 - V_CNR) ;

REPRI = max(0 , INVOMENTRI - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ
                                            -INVOMENTRV-INVOMENTNV-INVOMRETPN-INVOMRETPS-INVOMRETPX-INVOMENTRK-INVOMENTRP-INVOMENTRU-INVOMENTNU
                                            -INVOMRETPP-INVOMRETPU-INVOMENTRG-INVOMENTRM-INVOMENTRR-INVOMENTRW-INVOMENTNW-INVOMRETPR-INVOMRETPW)) * (1 - V_CNR) ;

REPRO = max(0 , INVOMENTRO - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ
                                            -INVOMENTRV-INVOMENTNV-INVOMRETPN-INVOMRETPS-INVOMRETPX-INVOMENTRK-INVOMENTRP-INVOMENTRU-INVOMENTNU
                                            -INVOMRETPP-INVOMRETPU-INVOMENTRG-INVOMENTRM-INVOMENTRR-INVOMENTRW-INVOMENTNW-INVOMRETPR-INVOMRETPW
                                            -INVOMENTRI)) * (1 - V_CNR) ;

REPRT = max(0 , INVOMENTRT - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ
                                            -INVOMENTRV-INVOMENTNV-INVOMRETPN-INVOMRETPS-INVOMRETPX-INVOMENTRK-INVOMENTRP-INVOMENTRU-INVOMENTNU
                                            -INVOMRETPP-INVOMRETPU-INVOMENTRG-INVOMENTRM-INVOMENTRR-INVOMENTRW-INVOMENTNW-INVOMRETPR-INVOMRETPW
                                            -INVOMENTRI-INVOMENTRO)) * (1 - V_CNR) ;

REPRY = max(0 , INVOMENTRY - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ
                                            -INVOMENTRV-INVOMENTNV-INVOMRETPN-INVOMRETPS-INVOMRETPX-INVOMENTRK-INVOMENTRP-INVOMENTRU-INVOMENTNU
                                            -INVOMRETPP-INVOMRETPU-INVOMENTRG-INVOMENTRM-INVOMENTRR-INVOMENTRW-INVOMENTNW-INVOMRETPR-INVOMRETPW
                                            -INVOMENTRI-INVOMENTRO-INVOMENTRT)) * (1 - V_CNR) ;

REPNY = max(0 , INVOMENTNY - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ
                                            -INVOMENTRV-INVOMENTNV-INVOMRETPN-INVOMRETPS-INVOMRETPX-INVOMENTRK-INVOMENTRP-INVOMENTRU-INVOMENTNU
                                            -INVOMRETPP-INVOMRETPU-INVOMENTRG-INVOMENTRM-INVOMENTRR-INVOMENTRW-INVOMENTNW-INVOMRETPR-INVOMRETPW
                                            -INVOMENTRI-INVOMENTRO-INVOMENTRT-INVOMENTRY)) * (1 - V_CNR) ;

REPDOMENTR3 = REPPM + REPRJ + REPPO + REPPT + REPPY + REPRL + REPRQ + REPRV + REPNV + REPPN + REPPS + REPPX + REPRK + REPRP + REPRU + REPNU 
	      + REPPP + REPPU + REPRG + REPRM + REPRR + REPRW + REPNW + REPPR + REPPW + REPRI + REPRO + REPRT + REPRY + REPNY ;

REPENT3 = INVOMRETPM + INVOMENTRJ + INVOMRETPO + INVOMRETPT + INVOMRETPY + INVOMENTRL + INVOMENTRQ + INVOMENTRV + INVOMENTNV + INVOMRETPN + INVOMRETPS 
          + INVOMRETPX + INVOMENTRK + INVOMENTRP + INVOMENTRU + INVOMENTNU + INVOMRETPP + INVOMRETPU + INVOMENTRG + INVOMENTRM + INVOMENTRR + INVOMENTRW 
          + INVOMENTNW + INVOMRETPR + INVOMRETPW + INVOMENTRI + INVOMENTRO + INVOMENTRT + INVOMENTRY + INVOMENTNY ;


REPSB = max(0 , CODHSB - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3)) * (1 - V_CNR) ;

REPSG = max(0 , CODHSG - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-CODHSB)) * (1 - V_CNR) ;

REPSL = max(0 , CODHSL - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-CODHSB-CODHSG)) * (1 - V_CNR) ;

REPSQ = max(0 , CODHSQ - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-CODHSB-CODHSG-CODHSL)) * (1 - V_CNR) ;

REPSV = max(0 , CODHSV - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-CODHSB-CODHSG-CODHSL-CODHSQ)) * (1 - V_CNR) ;

REPTA = max(0 , CODHTA - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-CODHSB-CODHSG-CODHSL-CODHSQ-CODHSV)) * (1 - V_CNR) ;

REPSA = max(0 , CODHSA - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-CODHSB-CODHSG-CODHSL-CODHSQ-CODHSV-CODHTA)) * (1 - V_CNR) ;

REPSF = max(0 , CODHSF - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-CODHSB-CODHSG-CODHSL-CODHSQ-CODHSV-CODHTA-CODHSA)) * (1 - V_CNR) ;

REPSK = max(0 , CODHSK - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-CODHSB-CODHSG-CODHSL-CODHSQ-CODHSV-CODHTA-CODHSA-CODHSF)) * (1 - V_CNR) ;

REPSP = max(0 , CODHSP - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-CODHSB-CODHSG-CODHSL-CODHSQ-CODHSV-CODHTA-CODHSA-CODHSF-CODHSK)) * (1 - V_CNR) ;

REPSU = max(0 , CODHSU - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-CODHSB-CODHSG-CODHSL-CODHSQ-CODHSV-CODHTA-CODHSA-CODHSF-CODHSK-CODHSP)) * (1 - V_CNR) ;

REPSZ = max(0 , CODHSZ - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-CODHSB-CODHSG-CODHSL-CODHSQ-CODHSV-CODHTA-CODHSA-CODHSF-CODHSK-CODHSP-CODHSU)) * (1 - V_CNR) ;

REPSC = max(0 , CODHSC - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-CODHSB-CODHSG-CODHSL-CODHSQ-CODHSV-CODHTA-CODHSA-CODHSF-CODHSK-CODHSP-CODHSU-CODHSZ)) * (1 - V_CNR) ; 

REPSH = max(0 , CODHSH - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-CODHSB-CODHSG-CODHSL-CODHSQ-CODHSV-CODHTA-CODHSA-CODHSF-CODHSK-CODHSP-CODHSU-CODHSZ
                                        -CODHSC)) * (1 - V_CNR) ; 

REPSM = max(0 , CODHSM - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-CODHSB-CODHSG-CODHSL-CODHSQ-CODHSV-CODHTA-CODHSA-CODHSF-CODHSK-CODHSP-CODHSU-CODHSZ
                                        -CODHSC-CODHSH)) * (1 - V_CNR) ; 

REPSR = max(0 , CODHSR - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-CODHSB-CODHSG-CODHSL-CODHSQ-CODHSV-CODHTA-CODHSA-CODHSF-CODHSK-CODHSP-CODHSU-CODHSZ
                                        -CODHSC-CODHSH-CODHSM)) * (1 - V_CNR) ;

REPSW = max(0 , CODHSW - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-CODHSB-CODHSG-CODHSL-CODHSQ-CODHSV-CODHTA-CODHSA-CODHSF-CODHSK-CODHSP-CODHSU-CODHSZ
                                        -CODHSC-CODHSH-CODHSM-CODHSR)) * (1 - V_CNR) ;

REPTB = max(0 , CODHTB - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-CODHSB-CODHSG-CODHSL-CODHSQ-CODHSV-CODHTA-CODHSA-CODHSF-CODHSK-CODHSP-CODHSU-CODHSZ
                                        -CODHSC-CODHSH-CODHSM-CODHSR-CODHSW)) * (1 - V_CNR) ;

REPSE = max(0 , CODHSE - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-CODHSB-CODHSG-CODHSL-CODHSQ-CODHSV-CODHTA-CODHSA-CODHSF-CODHSK-CODHSP-CODHSU-CODHSZ
                                        -CODHSC-CODHSH-CODHSM-CODHSR-CODHSW-CODHTB)) * (1 - V_CNR) ;

REPSJ = max(0 , CODHSJ - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-CODHSB-CODHSG-CODHSL-CODHSQ-CODHSV-CODHTA-CODHSA-CODHSF-CODHSK-CODHSP-CODHSU-CODHSZ
                                        -CODHSC-CODHSH-CODHSM-CODHSR-CODHSW-CODHTB-CODHSE)) * (1 - V_CNR) ;

REPSO = max(0 , CODHSO - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-CODHSB-CODHSG-CODHSL-CODHSQ-CODHSV-CODHTA-CODHSA-CODHSF-CODHSK-CODHSP-CODHSU-CODHSZ
                                        -CODHSC-CODHSH-CODHSM-CODHSR-CODHSW-CODHTB-CODHSE-CODHSJ)) * (1 - V_CNR) ;

REPST = max(0 , CODHST - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-CODHSB-CODHSG-CODHSL-CODHSQ-CODHSV-CODHTA-CODHSA-CODHSF-CODHSK-CODHSP-CODHSU-CODHSZ
                                        -CODHSC-CODHSH-CODHSM-CODHSR-CODHSW-CODHTB-CODHSE-CODHSJ-CODHSO)) * (1 - V_CNR) ;

REPSY = max(0 , CODHSY - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-CODHSB-CODHSG-CODHSL-CODHSQ-CODHSV-CODHTA-CODHSA-CODHSF-CODHSK-CODHSP-CODHSU-CODHSZ
                                        -CODHSC-CODHSH-CODHSM-CODHSR-CODHSW-CODHTB-CODHSE-CODHSJ-CODHSO-CODHST)) * (1 - V_CNR) ;

REPTD = max(0 , CODHTD - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-CODHSB-CODHSG-CODHSL-CODHSQ-CODHSV-CODHTA-CODHSA-CODHSF-CODHSK-CODHSP-CODHSU-CODHSZ
                                        -CODHSC-CODHSH-CODHSM-CODHSR-CODHSW-CODHTB-CODHSE-CODHSJ-CODHSO-CODHST-CODHSY)) * (1 - V_CNR) ;


REPDOMENTR2 = REPSB + REPSG + REPSL + REPSQ + REPSV + REPTA + REPSA + REPSF + REPSK + REPSP + REPSU + REPSZ + REPSC 
              + REPSH + REPSM + REPSR + REPSW + REPTB + REPSE + REPSJ + REPSO + REPST + REPSY + REPTD ;

REPENT2 = CODHSB + CODHSG + CODHSL + CODHSQ + CODHSV + CODHTA + CODHSA + CODHSF + CODHSK + CODHSP + CODHSU + CODHSZ 
          + CODHSC + CODHSH + CODHSM + CODHSR + CODHSW + CODHTB + CODHSE + CODHSJ + CODHSO + CODHST + CODHSY + CODHTD ;


REPAB = max(0 , CODHAB - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-REPENT2)) * (1 - V_CNR) ;

REPAG = max(0 , CODHAG - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-REPENT2-CODHAB)) * (1 - V_CNR) ;

REPAL = max(0 , CODHAL - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-REPENT2-CODHAB-CODHAG)) * (1 - V_CNR) ;

REPAQ = max(0 , CODHAQ - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-REPENT2-CODHAB-CODHAG-CODHAL)) * (1 - V_CNR) ;

REPAV = max(0 , CODHAV - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-REPENT2-CODHAB-CODHAG-CODHAL-CODHAQ)) * (1 - V_CNR) ;

REPBB = max(0 , CODHBB - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-REPENT2-CODHAB-CODHAG-CODHAL-CODHAQ-CODHAV)) * (1 - V_CNR) ;

REPAA = max(0 , CODHAA - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-REPENT2-CODHAB-CODHAG-CODHAL-CODHAQ-CODHAV-CODHBB)) * (1 - V_CNR) ;

REPAF = max(0 , CODHAF - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-REPENT2-CODHAB-CODHAG-CODHAL-CODHAQ-CODHAV-CODHBB-CODHAA)) * (1 - V_CNR) ;

REPAK = max(0 , CODHAK - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-REPENT2-CODHAB-CODHAG-CODHAL-CODHAQ-CODHAV-CODHBB-CODHAA-CODHAF)) * (1 - V_CNR) ;

REPAP = max(0 , CODHAP - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-REPENT2-CODHAB-CODHAG-CODHAL-CODHAQ-CODHAV-CODHBB-CODHAA-CODHAF-CODHAK)) * (1 - V_CNR) ;

REPAU = max(0 , CODHAU - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-REPENT2-CODHAB-CODHAG-CODHAL-CODHAQ-CODHAV-CODHBB-CODHAA-CODHAF-CODHAK
                                        -CODHAP)) * (1 - V_CNR) ;

REPBA = max(0 , CODHBA - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-REPENT2-CODHAB-CODHAG-CODHAL-CODHAQ-CODHAV-CODHBB-CODHAA-CODHAF-CODHAK
                                        -CODHAP-CODHAU)) * (1 - V_CNR) ;

REPAC = max(0 , CODHAC - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-REPENT2-CODHAB-CODHAG-CODHAL-CODHAQ-CODHAV-CODHBB-CODHAA-CODHAF-CODHAK
                                        -CODHAP-CODHAU-CODHBA)) * (1 - V_CNR) ;

REPAH = max(0 , CODHAH - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-REPENT2-CODHAB-CODHAG-CODHAL-CODHAQ-CODHAV-CODHBB-CODHAA-CODHAF-CODHAK
                                        -CODHAP-CODHAU-CODHBA-CODHAC)) * (1 - V_CNR) ;

REPAM = max(0 , CODHAM - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-REPENT2-CODHAB-CODHAG-CODHAL-CODHAQ-CODHAV-CODHBB-CODHAA-CODHAF-CODHAK
                                        -CODHAP-CODHAU-CODHBA-CODHAC-CODHAH)) * (1 - V_CNR) ;

REPHAR = max(0 , CODHAR - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-REPENT2-CODHAB-CODHAG-CODHAL-CODHAQ-CODHAV-CODHBB-CODHAA-CODHAF-CODHAK
                                         -CODHAP-CODHAU-CODHBA-CODHAC-CODHAH-CODHAM)) * (1 - V_CNR) ;

REPAW = max(0 , CODHAW - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-REPENT2-CODHAB-CODHAG-CODHAL-CODHAQ-CODHAV-CODHBB-CODHAA-CODHAF-CODHAK
                                        -CODHAP-CODHAU-CODHBA-CODHAC-CODHAH-CODHAM-CODHAR)) * (1 - V_CNR) ;

REPBE = max(0 , CODHBE - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-REPENT2-CODHAB-CODHAG-CODHAL-CODHAQ-CODHAV-CODHBB-CODHAA-CODHAF-CODHAK
                                        -CODHAP-CODHAU-CODHBA-CODHAC-CODHAH-CODHAM-CODHAR-CODHAW)) * (1 - V_CNR) ;

REPAE = max(0 , CODHAE - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-REPENT2-CODHAB-CODHAG-CODHAL-CODHAQ-CODHAV-CODHBB-CODHAA-CODHAF-CODHAK
                                        -CODHAP-CODHAU-CODHBA-CODHAC-CODHAH-CODHAM-CODHAR-CODHAW-CODHBE)) * (1 - V_CNR) ;

REPAJ = max(0 , CODHAJ - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-REPENT2-CODHAB-CODHAG-CODHAL-CODHAQ-CODHAV-CODHBB-CODHAA-CODHAF-CODHAK
                                        -CODHAP-CODHAU-CODHBA-CODHAC-CODHAH-CODHAM-CODHAR-CODHAW-CODHBE-CODHAE)) * (1 - V_CNR) ;

REPAO = max(0 , CODHAO - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-REPENT2-CODHAB-CODHAG-CODHAL-CODHAQ-CODHAV-CODHBB-CODHAA-CODHAF-CODHAK
                                        -CODHAP-CODHAU-CODHBA-CODHAC-CODHAH-CODHAM-CODHAR-CODHAW-CODHBE-CODHAE-CODHAJ)) * (1 - V_CNR) ;

REPAT = max(0 , CODHAT - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-REPENT2-CODHAB-CODHAG-CODHAL-CODHAQ-CODHAV-CODHBB-CODHAA-CODHAF-CODHAK
                                        -CODHAP-CODHAU-CODHBA-CODHAC-CODHAH-CODHAM-CODHAR-CODHAW-CODHBE-CODHAE-CODHAJ-CODHAO)) * (1 - V_CNR) ;

REPAY = max(0 , CODHAY - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-REPENT2-CODHAB-CODHAG-CODHAL-CODHAQ-CODHAV-CODHBB-CODHAA-CODHAF-CODHAK
                                        -CODHAP-CODHAU-CODHBA-CODHAC-CODHAH-CODHAM-CODHAR-CODHAW-CODHBE-CODHAE-CODHAJ-CODHAO-CODHAT)) * (1 - V_CNR) ;

REPBG = max(0 , CODHBG - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-REPENT2-CODHAB-CODHAG-CODHAL-CODHAQ-CODHAV-CODHBB-CODHAA-CODHAF-CODHAK
                                        -CODHAP-CODHAU-CODHBA-CODHAC-CODHAH-CODHAM-CODHAR-CODHAW-CODHBE-CODHAE-CODHAJ-CODHAO-CODHAT-CODHAY)) * (1 - V_CNR) ;

REPDOMENTR1 = REPAB + REPAG + REPAL + REPAQ + REPAV + REPBB + REPAA + REPAF + REPAK + REPAP + REPAU + REPBA 
             + REPAC + REPAH + REPAM + REPHAR + REPAW + REPBE + REPAE + REPAJ + REPAO + REPAT + REPAY + REPBG ;

REPENT1 = CODHAB + CODHAG + CODHAL + CODHAQ + CODHAV + CODHBB + CODHAA + CODHAF + CODHAK + CODHAP + CODHAU + CODHBA + CODHAC + CODHAH 
          + CODHAM + CODHAR + CODHAW + CODHBE + CODHAE + CODHAJ + CODHAO + CODHAT + CODHAY + CODHBG ;


REPBJ = max(0 , CODHBJ - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-REPENT2-REPENT1)) * (1 - V_CNR) ;

REPBO = max(0 , CODHBO - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-REPENT2-REPENT1-CODHBJ)) * (1 - V_CNR) ;

REPBT = max(0 , CODHBT - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-REPENT2-REPENT1-CODHBJ-CODHBO)) * (1 - V_CNR) ;

REPBY = max(0 , CODHBY - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-REPENT2-REPENT1-CODHBJ-CODHBO-CODHBT)) * (1 - V_CNR) ;

REPCD = max(0 , CODHCD - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-REPENT2-REPENT1-CODHBJ-CODHBO-CODHBT-CODHBY)) * (1 - V_CNR) ;

REPBI = max(0 , CODHBI - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-REPENT2-REPENT1-CODHBJ-CODHBO-CODHBT-CODHBY-CODHCD)) * (1 - V_CNR) ;

REPBN = max(0 , CODHBN - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-REPENT2-REPENT1-CODHBJ-CODHBO-CODHBT-CODHBY-CODHCD-CODHBI)) * (1 - V_CNR) ;

REPBS = max(0 , CODHBS - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-REPENT2-REPENT1-CODHBJ-CODHBO-CODHBT-CODHBY-CODHCD-CODHBI-CODHBN)) * (1 - V_CNR) ;

REPBX = max(0 , CODHBX - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-REPENT2-REPENT1-CODHBJ-CODHBO-CODHBT-CODHBY-CODHCD-CODHBI-CODHBN
                                        -CODHBS)) * (1 - V_CNR) ;

REPCC = max(0 , CODHCC - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-REPENT2-REPENT1-CODHBJ-CODHBO-CODHBT-CODHBY-CODHCD-CODHBI-CODHBN
                                        -CODHBS-CODHBX)) * (1 - V_CNR) ;

REPBK = max(0 , CODHBK - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-REPENT2-REPENT1-CODHBJ-CODHBO-CODHBT-CODHBY-CODHCD-CODHBI-CODHBN
                                        -CODHBS-CODHBX-CODHCC)) * (1 - V_CNR) ;

REPBP = max(0 , CODHBP - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-REPENT2-REPENT1-CODHBJ-CODHBO-CODHBT-CODHBY-CODHCD-CODHBI-CODHBN
                                        -CODHBS-CODHBX-CODHCC-CODHBK)) * (1 - V_CNR) ;

REPBU = max(0 , CODHBU - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-REPENT2-REPENT1-CODHBJ-CODHBO-CODHBT-CODHBY-CODHCD-CODHBI-CODHBN
                                        -CODHBS-CODHBX-CODHCC-CODHBK-CODHBP)) * (1 - V_CNR) ;

REPBZ = max(0 , CODHBZ - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-REPENT2-REPENT1-CODHBJ-CODHBO-CODHBT-CODHBY-CODHCD-CODHBI-CODHBN
                                        -CODHBS-CODHBX-CODHCC-CODHBK-CODHBP-CODHBU)) * (1 - V_CNR) ;

REPCE = max(0 , CODHCE - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-REPENT2-REPENT1-CODHBJ-CODHBO-CODHBT-CODHBY-CODHCD-CODHBI-CODHBN
                                        -CODHBS-CODHBX-CODHCC-CODHBK-CODHBP-CODHBU-CODHBZ)) * (1 - V_CNR) ;

REPBM = max(0 , CODHBM - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-REPENT2-REPENT1-CODHBJ-CODHBO-CODHBT-CODHBY-CODHCD-CODHBI-CODHBN
                                        -CODHBS-CODHBX-CODHCC-CODHBK-CODHBP-CODHBU-CODHBZ-CODHCE)) * (1 - V_CNR) ;

REPBR = max(0 , CODHBR - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-REPENT2-REPENT1-CODHBJ-CODHBO-CODHBT-CODHBY-CODHCD-CODHBI-CODHBN
                                        -CODHBS-CODHBX-CODHCC-CODHBK-CODHBP-CODHBU-CODHBZ-CODHCE-CODHBM)) * (1 - V_CNR) ;

REPBW = max(0 , CODHBW - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-REPENT2-REPENT1-CODHBJ-CODHBO-CODHBT-CODHBY-CODHCD-CODHBI-CODHBN
                                        -CODHBS-CODHBX-CODHCC-CODHBK-CODHBP-CODHBU-CODHBZ-CODHCE-CODHBM-CODHBR)) * (1 - V_CNR) ;

REPCB = max(0 , CODHCB - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-REPENT2-REPENT1-CODHBJ-CODHBO-CODHBT-CODHBY-CODHCD-CODHBI-CODHBN
                                        -CODHBS-CODHBX-CODHCC-CODHBK-CODHBP-CODHBU-CODHBZ-CODHCE-CODHBM-CODHBR-CODHBW)) * (1 - V_CNR) ;

REPCG = max(0 , CODHCG - max(0 , RRIREP -REPSOC-REPENT5-REPENT4-REPENT3-REPENT2-REPENT1-CODHBJ-CODHBO-CODHBT-CODHBY-CODHCD-CODHBI-CODHBN
                                        -CODHBS-CODHBX-CODHCC-CODHBK-CODHBP-CODHBU-CODHBZ-CODHCE-CODHBM-CODHBR-CODHBW-CODHCB)) * (1 - V_CNR) ;

REPDOMENTR = REPBJ + REPBO + REPBT + REPBY + REPCD + REPBI + REPBN + REPBS + REPBX + REPCC
             + REPBK + REPBP + REPBU + REPBZ + REPCE + REPBM + REPBR + REPBW + REPCB + REPCG ;

regle 402140:
application : iliad ;

ACOTFOR_2 = max( ACOTFOR_P + ACOTFORP2 , ACOTFOR1731) * (1-PREM8_11) * ART1731BIS ;
RCOTFOR_2 = max(RCOTFOR_P+RCOTFORP2 , RCOTFOR1731) * (1-PREM8_11) * ART1731BIS ;
AREPA_2 = max( AREPA_P + AREPAP2 , AREPA1731) * (1-PREM8_11) * ART1731BIS ;
RREPA_2 =  max(RREPA_P+RREPAP2 , RREPA1731) * (1-PREM8_11) * ART1731BIS ;
AAIDE_2 = max( AAIDE_P + AAIDEP2 , AAIDE1731) * (1-PREM8_11) * ART1731BIS ;
RAIDE_2 = max(RAIDE_P+RAIDEP2 , RAIDE1731) * (1-PREM8_11) * ART1731BIS ;
ADIFAGRI_2 = max(ADIFAGRI_P + ADIFAGRIP2 , ADIFAGRI1731) * (1-PREM8_11) * ART1731BIS ;
RDIFAGRI_2 = max(RDIFAGRI_P+RDIFAGRIP2 , RDIFAGRI1731) * (1-PREM8_11) * ART1731BIS ;
APRESSE_2 = max(APRESSE_P + APRESSEP2 , APRESSE1731) * (1-PREM8_11) * ART1731BIS ;
RPRESSE_2 = max(RPRESSE_P + RPRESSEP2 , RPRESSE1731) * (1-PREM8_11) * ART1731BIS ;
AFORET_2 = max(AFORET_P + AFORETP2 , AFORET1731) * (1-PREM8_11) * ART1731BIS ;
RFORET_2 = max( RFORET_P+RFORETP2 , RFORET1731) * (1-PREM8_11) * ART1731BIS ;
AFIPDOM_2 = max(AFIPDOM_P + AFIPDOMP2 , AFIPDOM1731) * (1-PREM8_11) * ART1731BIS ;
RFIPDOM_2 = max(RFIPDOM_P + RFIPDOMP2 , RFIPDOM1731) * (1-PREM8_11) * ART1731BIS ;
AFIPC_2 = max(AFIPC_P + AFIPCP2 , AFIPC1731) * (1-PREM8_11) * ART1731BIS ;
RFIPC_2 = max(RFIPC_P + RFIPCP2 , RFIPC1731) * (1-PREM8_11) * ART1731BIS ;
ACINE_2 = max(ACINE_P + ACINEP2 , ACINE1731) * (1-PREM8_11) * ART1731BIS ;
RCINE_2 = max(RCINE_P + RCINEP2 , RCINE1731) * (1-PREM8_11) * ART1731BIS ;
ARESTIMO_2 = max(ARESTIMO_P + ARESTIMOP2 , ARESTIMO1731) * (1-PREM8_11) * ART1731BIS ;
RRESTIMO_2 = max(RRESTIMO_P + RRESTIMOP2 , RRESTIMO1731) * (1-PREM8_11) * ART1731BIS ;
ASOCREPR_2 = max(ASOCREPR_P + ASOCREPRP2 , ASOCREPR1731) * (1-PREM8_11) * ART1731BIS ;
RSOCREPR_2 = max(RSOCREPR_P + RSOCREPRP2 , RSOCREPR1731) * (1-PREM8_11) * ART1731BIS ;
APRESCOMP_2 = max( APRESCOMP_P + APRESCOMPP2 , APRESCOMP1731) * (1-PREM8_11) * ART1731BIS ;
RRPRESCOMP_2 = max( RRPRESCOMP_P + RRPRESCOMPP2 , RRPRESCOMP1731) * (1-PREM8_11) * ART1731BIS ;
AHEBE_2 = max( AHEBE_P + AHEBEP2 , AHEBE1731) * (1-PREM8_11) * ART1731BIS ;
RHEBE_2 = max( RHEBE_P + RHEBEP2 , RHEBE1731) * (1-PREM8_11) * ART1731BIS ;
ASURV_2 = max( ASURV_P + ASURVP2 , ASURV1731) * (1-PREM8_11) * ART1731BIS ;
RSURV_2 = max( RSURV_P + RSURVP2 , RSURV1731) * (1-PREM8_11) * ART1731BIS ;
BFCPI_2 = max( BFCPI_P + BFCPIP2 , BFCPI1731) * (1-PREM8_11) * ART1731BIS ;
RINNO_2 = max( RINNO_P + RINNOP2 , RINNO1731) * (1-PREM8_11) * ART1731BIS ;
ASOUFIP_2 = max( ASOUFIP_P + ASOUFIPP2 , ASOUFIP1731) * (1-PREM8_11) * ART1731BIS ;
RSOUFIP_2 = max( RSOUFIP_P + RSOUFIPP2 , RSOUFIP1731) * (1-PREM8_11) * ART1731BIS ;
ARIRENOV_2 = max( ARIRENOV_P + ARIRENOVP2 , ARIRENOV1731) * (1-PREM8_11) * ART1731BIS ;
RRIRENOV_2 = max( RRIRENOV_P + RRIRENOVP2 , RRIRENOV1731) * (1-PREM8_11) * ART1731BIS ;
ALOGDOM_2 = max( ALOGDOM_P + ALOGDOMP2 , ALOGDOM1731) * (1-PREM8_11) * ART1731BIS ;
RLOGDOM_2 = max( RLOGDOM_P + RLOGDOMP2 , RLOGDOM1731) * (1-PREM8_11) * ART1731BIS ;
ACOMP_2 = max( ACOMP_P + ACOMPP2 , ACOMP1731) * (1-PREM8_11) * ART1731BIS ;
RCOMP_2 = max( RCOMP_P + RCOMPP2 , RCOMP1731) * (1-PREM8_11) * ART1731BIS ;
RNBE_2 = max( RNBE_P + RNBEP2 , RNBE1731) * (1-PREM8_11) * ART1731BIS ;
RRETU_2 = max( RRETU_P + RRETUP2 , RRETU1731) * (1-PREM8_11) * ART1731BIS ;
ADONS_2 = max( ADONS_P + ADONSP2 , ADONS1731) * (1-PREM8_11) * ART1731BIS ;
RDONS_2 = max( RDONS_P + RDONSP2 , RDONS1731) * (1-PREM8_11) * ART1731BIS ;
CRCFA_2 = max( CRCFA_P + CRCFAP2 , CRCFA1731) * (1-PREM8_11) * ART1731BIS ;
CRDIE_2 = max( CRDIE_P + CRDIEP2 , CRDIE1731) * (1-PREM8_11) * ART1731BIS ;
ADUFREPFI_2 = max( ADUFREPFI_P + ADUFREPFIP2 , ADUFREPFI1731) * (1-PREM8_11) * ART1731BIS ;
RDUFREPFI_2 = max( RDUFREPFI_P + RDUFREPFIP2 , RDUFREPFI1731) * (1-PREM8_11) * ART1731BIS ;
ADUFREPFK_2 = max( ADUFREPFK_P + ADUFREPFKP2 , ADUFREPFK1731) * (1-PREM8_11) * ART1731BIS ;
RDUFREPFK_2 = max( RDUFREPFK_P + RDUFREPFKP2 , RDUFREPFK1731) * (1-PREM8_11) * ART1731BIS ;
ADUFLOEKL_2 = max( ADUFLOEKL_P + ADUFLOEKLP2 , ADUFLOEKL1731) * (1-PREM8_11) * ART1731BIS ;
RDUFLOEKL_2 = max( RDUFLOEKL_P + RDUFLOEKLP2 , RDUFLOEKL1731) * (1-PREM8_11) * ART1731BIS ;
ADUFLOGIH_2 = max( ADUFLOGIH_P + ADUFLOGIHP2 , ADUFLOGIH1731) * (1-PREM8_11) * ART1731BIS ;
RDUFLOGIH_2 = max( RDUFLOGIH_P + RDUFLOGIHP2 , RDUFLOGIH1731) * (1-PREM8_11) * ART1731BIS ;
APIREPAI_2 = max( APIREPAI_P + APIREPAIP2 , APIREPAI1731) * (1-PREM8_11) * ART1731BIS ;
RPIREPAI_2 = max( RPIREPAI_P + RPIREPAIP2 , RPIREPAI1731) * (1-PREM8_11) * ART1731BIS ;
APIREPBI_2 = max( APIREPBI_P + APIREPBIP2 , APIREPBI1731) * (1-PREM8_11) * ART1731BIS ;
RPIREPBI_2 = max( RPIREPBI_P + RPIREPBIP2 , RPIREPBI1731) * (1-PREM8_11) * ART1731BIS ;
APIREPCI_2 = max( APIREPCI_P + APIREPCIP2 , APIREPCI1731) * (1-PREM8_11) * ART1731BIS ;
RPIREPCI_2 = max( RPIREPCI_P + RPIREPCIP2 , RPIREPCI1731) * (1-PREM8_11) * ART1731BIS ;
APIREPDI_2 = max( APIREPDI_P + APIREPDIP2 , APIREPDI1731) * (1-PREM8_11) * ART1731BIS ;
RPIREPDI_2 = max( RPIREPDI_P + RPIREPDIP2 , RPIREPDI1731) * (1-PREM8_11) * ART1731BIS ;
APIQGH_2   = max( APIQGH_P + APIQGHP2 , APIQGH1731) * (1-PREM8_11) * ART1731BIS ;
RPIQGH_2   = max( RPIQGH_P + RPIQGHP2 , RPIQGH1731) * (1-PREM8_11) * ART1731BIS ;
APIQEF_2   = max( APIQEF_P + APIQEFP2 , APIQEF1731) * (1-PREM8_11) * ART1731BIS ;
RPIQEF_2   = max( RPIQEF_P + RPIQEFP2 , RPIQEF1731) * (1-PREM8_11) * ART1731BIS ;
APIQCD_2   = max( APIQCD_P + APIQCDP2 , APIQCD1731) * (1-PREM8_11) * ART1731BIS ;
RPIQCD_2   = max( RPIQCD_P + RPIQCDP2 , RPIQCD1731) * (1-PREM8_11) * ART1731BIS ;
APIQAB_2   = max( APIQAB_P + APIQABP2 , APIQAB1731) * (1-PREM8_11) * ART1731BIS ;
RPIQAB_2   = max( RPIQAB_P + RPIQABP2 , RPIQAB1731) * (1-PREM8_11) * ART1731BIS ;
ANOUV_2 = max( ANOUV_P + ANOUVP2 , ANOUV1731) * (1-PREM8_11) * ART1731BIS ;
RNOUV_2 = max( RNOUV_P + RNOUVP2 , RNOUV1731) * (1-PREM8_11) * ART1731BIS ;
APLAFREPME4_2 = max( APLAFREPME4_P , APLAFREPME41731 ) * (1-PREM8_11) * ART1731BIS ;
RPLAFREPME4_2 = max( RPLAFREPME4_P + RPLAFREPME4P2 , RPLAFREPME41731 ) * (1-PREM8_11) * ART1731BIS ;
APENTDY_2 = max( APENTDY_P , APENTDY1731 ) * (1-PREM8_11) * ART1731BIS ;
RPENTDY_2 = max( RPENTDY_P + RPENTDYP2 , RPENTDY1731 ) * (1-PREM8_11) * ART1731BIS ;
AFOREST_2 = max( AFOREST_P + AFORESTP2 , AFOREST1731) * (1-PREM8_11) * ART1731BIS ;
RFOR_2 = max( RFOR_P + RFORP2 , RFOR1731) * (1-PREM8_11) * ART1731BIS ;
ATOURREP_2 = max( ATOURREP_P + ATOURREPP2 , ATOURREP1731) * (1-PREM8_11) * ART1731BIS ;
RTOURREP_2 = max( RTOURREP_P + RTOURREPP2 , RTOURREP1731) * (1-PREM8_11) * ART1731BIS ;
ATOUHOTR_2 = max( ATOUHOTR_P + ATOUHOTRP2 , ATOUHOTR1731) * (1-PREM8_11) * ART1731BIS ;
RTOUHOTR_2 = max( RTOUHOTR_P + RTOUHOTRP2 , RTOUHOTR1731) * (1-PREM8_11) * ART1731BIS ;
ATOUREPA_2 = max( ATOUREPA_P + ATOUREPAP2 , ATOUREPA1731) * (1-PREM8_11) * ART1731BIS ;
RTOUREPA_2 = max( RTOUREPA_P + RTOUREPAP2 , RTOUREPA1731) * (1-PREM8_11) * ART1731BIS ;
ACELRREDLA_2 = max(ACELRREDLA_P+ACELRREDLAP2 , ACELRREDLA1731) * (1-PREM8_11) * ART1731BIS ;
RCELRREDLA_2 = max(RCELRREDLA_P+RCELRREDLAP2 , RCELRREDLA1731) * (1-PREM8_11) * ART1731BIS ;
ACELRREDLB_2 = max(ACELRREDLB_P+ACELRREDLBP2 , ACELRREDLB1731) * (1-PREM8_11) * ART1731BIS ;
RCELRREDLB_2 = max(RCELRREDLB_P+RCELRREDLBP2 , RCELRREDLB1731) * (1-PREM8_11) * ART1731BIS ;
ACELRREDLE_2 = max(ACELRREDLE_P+ACELRREDLEP2 , ACELRREDLE1731) * (1-PREM8_11) * ART1731BIS ;
RCELRREDLE_2 = max(RCELRREDLE_P+RCELRREDLEP2 , RCELRREDLE1731) * (1-PREM8_11) * ART1731BIS ;
ACELRREDLM_2 = max(ACELRREDLM_P+ACELRREDLMP2 , ACELRREDLM1731) * (1-PREM8_11) * ART1731BIS ;
RCELRREDLM_2 = max(RCELRREDLM_P+RCELRREDLMP2 , RCELRREDLM1731) * (1-PREM8_11) * ART1731BIS ;
ACELRREDLN_2 = max(ACELRREDLN_P+ACELRREDLNP2 , ACELRREDLN1731) * (1-PREM8_11) * ART1731BIS ;
RCELRREDLN_2 = max(RCELRREDLN_P+RCELRREDLNP2 , RCELRREDLN1731) * (1-PREM8_11) * ART1731BIS ;
ACELRREDLG_2 = max(ACELRREDLG_P+ACELRREDLGP2 , ACELRREDLG1731) * (1-PREM8_11) * ART1731BIS ;
RCELRREDLG_2 = max(RCELRREDLG_P+RCELRREDLGP2 , RCELRREDLG1731) * (1-PREM8_11) * ART1731BIS ;
ACELRREDLC_2 = max(ACELRREDLC_P+ACELRREDLCP2 , ACELRREDLC1731) * (1-PREM8_11) * ART1731BIS ;
RCELRREDLC_2 = max(RCELRREDLC_P+RCELRREDLCP2 , RCELRREDLC1731) * (1-PREM8_11) * ART1731BIS ;
ACELRREDLD_2 = max(ACELRREDLD_P+ACELRREDLDP2 , ACELRREDLD1731) * (1-PREM8_11) * ART1731BIS ;
RCELRREDLD_2 = max(RCELRREDLD_P+RCELRREDLDP2 , RCELRREDLD1731) * (1-PREM8_11) * ART1731BIS ;
ACELRREDLS_2 = max(ACELRREDLS_P+ACELRREDLSP2 , ACELRREDLS1731) * (1-PREM8_11) * ART1731BIS ;
RCELRREDLS_2 = max(RCELRREDLS_P+RCELRREDLSP2 , RCELRREDLS1731) * (1-PREM8_11) * ART1731BIS ;
ACELRREDLT_2 = max(ACELRREDLT_P+ACELRREDLTP2 , ACELRREDLT1731) * (1-PREM8_11) * ART1731BIS ;
RCELRREDLT_2 = max(RCELRREDLT_P+RCELRREDLTP2 , RCELRREDLT1731) * (1-PREM8_11) * ART1731BIS ;
ACELRREDLH_2 = max(ACELRREDLH_P+ACELRREDLHP2 , ACELRREDLH1731) * (1-PREM8_11) * ART1731BIS ;
RCELRREDLH_2 = max(RCELRREDLH_P+RCELRREDLHP2 , RCELRREDLH1731) * (1-PREM8_11) * ART1731BIS ;
ACELRREDLF_2 = max(ACELRREDLF_P+ACELRREDLFP2 , ACELRREDLF1731) * (1-PREM8_11) * ART1731BIS ;
RCELRREDLF_2 = max(RCELRREDLF_P+RCELRREDLFP2 , RCELRREDLF1731) * (1-PREM8_11) * ART1731BIS ;
ACELRREDLZ_2 = max(ACELRREDLZ_P+ACELRREDLZP2 , ACELRREDLZ1731) * (1-PREM8_11) * ART1731BIS ;
RCELRREDLZ_2 = max(RCELRREDLZ_P+RCELRREDLZP2 , RCELRREDLZ1731) * (1-PREM8_11) * ART1731BIS ;
ACELRREDLX_2 = max(ACELRREDLX_P+ACELRREDLXP2 , ACELRREDLX1731) * (1-PREM8_11) * ART1731BIS ;
RCELRREDLX_2 = max(RCELRREDLX_P+RCELRREDLXP2 , RCELRREDLX1731) * (1-PREM8_11) * ART1731BIS ;
ACELRREDLI_2 = max(ACELRREDLI_P+ACELRREDLIP2 , ACELRREDLI1731) * (1-PREM8_11) * ART1731BIS ;
RCELRREDLI_2 = max(RCELRREDLI_P+RCELRREDLIP2 , RCELRREDLI1731) * (1-PREM8_11) * ART1731BIS ;
ACELRREDMG_2 = max(ACELRREDMG_P+ACELRREDMGP2 , ACELRREDMG1731) * (1-PREM8_11) * ART1731BIS ;
RCELRREDMG_2 = max(RCELRREDMG_P+RCELRREDMGP2 , RCELRREDMG1731) * (1-PREM8_11) * ART1731BIS ;
ACELRREDMH_2 = max(ACELRREDMH_P+ACELRREDMHP2 , ACELRREDMH1731) * (1-PREM8_11) * ART1731BIS ;
RCELRREDMH_2 = max(RCELRREDMH_P+RCELRREDMHP2 , RCELRREDMH1731) * (1-PREM8_11) * ART1731BIS ;
ACELRREDLJ_2 = max(ACELRREDLJ_P+ACELRREDLJP2 , ACELRREDLJ1731) * (1-PREM8_11) * ART1731BIS ;
RCELRREDLJ_2 = max(RCELRREDLJ_P+RCELRREDLJP2 , RCELRREDLJ1731) * (1-PREM8_11) * ART1731BIS ;
ACELREPHS_2 = max(ACELREPHS_P+ACELREPHSP2 , ACELREPHS1731) * (1-PREM8_11) * ART1731BIS ;
RCELREPHS_2 = max(RCELREPHS_P+RCELREPHSP2 , RCELREPHS1731) * (1-PREM8_11) * ART1731BIS ;
ACELREPHR_2 = max(ACELREPHR_P+ACELREPHRP2 , ACELREPHR1731) * (1-PREM8_11) * ART1731BIS ;
RCELREPHR_2 = max(RCELREPHR_P+RCELREPHRP2 , RCELREPHR1731) * (1-PREM8_11) * ART1731BIS ;
ACELREPHU_2 = max(ACELREPHU_P+ACELREPHUP2 , ACELREPHU1731) * (1-PREM8_11) * ART1731BIS ;
RCELREPHU_2 = max(RCELREPHU_P+RCELREPHUP2 , RCELREPHU1731) * (1-PREM8_11) * ART1731BIS ;
ACELREPHT_2 = max(ACELREPHT_P+ACELREPHTP2 , ACELREPHT1731) * (1-PREM8_11) * ART1731BIS ;
RCELREPHT_2 = max(RCELREPHT_P+RCELREPHTP2 , RCELREPHT1731) * (1-PREM8_11) * ART1731BIS ;
ACELREPHZ_2 = max(ACELREPHZ_P+ACELREPHZP2 , ACELREPHZ1731) * (1-PREM8_11) * ART1731BIS ;
RCELREPHZ_2 = max(RCELREPHZ_P+RCELREPHZP2 , RCELREPHZ1731) * (1-PREM8_11) * ART1731BIS ;
ACELREPHX_2 = max(ACELREPHX_P+ACELREPHXP2 , ACELREPHX1731) * (1-PREM8_11) * ART1731BIS ;
RCELREPHX_2 = max(RCELREPHX_P+RCELREPHXP2 , RCELREPHX1731) * (1-PREM8_11) * ART1731BIS ;
ACELREPHW_2 = max(ACELREPHW_P+ACELREPHWP2 , ACELREPHW1731) * (1-PREM8_11) * ART1731BIS ;
RCELREPHW_2 = max(RCELREPHW_P+RCELREPHWP2 , RCELREPHW1731) * (1-PREM8_11) * ART1731BIS ;
ACELREPHV_2 = max(ACELREPHV_P+ACELREPHVP2 , ACELREPHV1731) * (1-PREM8_11) * ART1731BIS ;
RCELREPHV_2 = max(RCELREPHV_P+RCELREPHVP2 , RCELREPHV1731) * (1-PREM8_11) * ART1731BIS ;
ACELREPHF_2 = max(ACELREPHF_P+ACELREPHFP2 , ACELREPHF1731) * (1-PREM8_11) * ART1731BIS ;
RCELREPHF_2 = max(RCELREPHF_P+RCELREPHFP2 , RCELREPHF1731) * (1-PREM8_11) * ART1731BIS ;
ACELREPHD_2 = max(ACELREPHD_P+ACELREPHDP2 , ACELREPHD1731) * (1-PREM8_11) * ART1731BIS ;
RCELREPHD_2 = max(RCELREPHD_P+RCELREPHDP2 , RCELREPHD1731) * (1-PREM8_11) * ART1731BIS ;
ACELREPHH_2 = max(ACELREPHH_P+ACELREPHHP2 , ACELREPHH1731) * (1-PREM8_11) * ART1731BIS ;
RCELREPHH_2 = max(RCELREPHH_P+RCELREPHHP2 , RCELREPHH1731) * (1-PREM8_11) * ART1731BIS ;
ACELREPHG_2 = max(ACELREPHG_P+ACELREPHGP2 , ACELREPHG1731) * (1-PREM8_11) * ART1731BIS ;
RCELREPHG_2 = max(RCELREPHG_P+RCELREPHGP2 , RCELREPHG1731) * (1-PREM8_11) * ART1731BIS ;
ACELREPHA_2 = max(ACELREPHA_P+ACELREPHAP2 , ACELREPHA1731) * (1-PREM8_11) * ART1731BIS ;
RCELREPHA_2 = max(RCELREPHA_P+RCELREPHAP2 , RCELREPHA1731) * (1-PREM8_11) * ART1731BIS ;
ACELREPGU_2 = max(ACELREPGU_P+ACELREPGUP2 , ACELREPGU1731) * (1-PREM8_11) * ART1731BIS ;
RCELREPGU_2 = max(RCELREPGU_P+RCELREPGUP2 , RCELREPGU1731) * (1-PREM8_11) * ART1731BIS ;
ACELREPGX_2 = max(ACELREPGX_P+ACELREPGXP2 , ACELREPGX1731) * (1-PREM8_11) * ART1731BIS ;
RCELREPGX_2 = max(RCELREPGX_P+RCELREPGXP2 , RCELREPGX1731) * (1-PREM8_11) * ART1731BIS ;
ACELREPGS_2 = max(ACELREPGS_P+ACELREPGSP2 , ACELREPGS1731) * (1-PREM8_11) * ART1731BIS ;
RCELREPGS_2 = max(RCELREPGS_P+RCELREPGSP2 , RCELREPGS1731) * (1-PREM8_11) * ART1731BIS ;
ACELREPGW_2 = max(ACELREPGW_P+ACELREPGWP2 , ACELREPGW1731) * (1-PREM8_11) * ART1731BIS ;
RCELREPGW_2 = max(RCELREPGW_P+RCELREPGWP2 , RCELREPGW1731) * (1-PREM8_11) * ART1731BIS ;
ACELREPGL_2 = max(ACELREPGL_P+ACELREPGLP2 , ACELREPGL1731) * (1-PREM8_11) * ART1731BIS ;
RCELREPGL_2 = max(RCELREPGL_P+RCELREPGLP2 , RCELREPGL1731) * (1-PREM8_11) * ART1731BIS ;
ACELREPGV_2 = max(ACELREPGV_P+ACELREPGVP2 , ACELREPGV1731) * (1-PREM8_11) * ART1731BIS ;
RCELREPGV_2 = max(RCELREPGV_P+RCELREPGVP2 , RCELREPGV1731) * (1-PREM8_11) * ART1731BIS ;
ACELREPGJ_2 = max(ACELREPGJ_P+ACELREPGJP2 , ACELREPGJ1731) * (1-PREM8_11) * ART1731BIS ;
RCELREPGJ_2 = max(RCELREPGJ_P+RCELREPGJP2 , RCELREPGJ1731) * (1-PREM8_11) * ART1731BIS ;
ACELREPYH_2 = max(ACELREPYH_P+ACELREPYHP2 , ACELREPYH1731) * (1-PREM8_11) * ART1731BIS ;
RCELREPYH_2 = max(RCELREPYH_P+RCELREPYHP2 , RCELREPYH1731) * (1-PREM8_11) * ART1731BIS ;
ACELREPYL_2 = max(ACELREPYL_P+ACELREPYLP2 , ACELREPYL1731) * (1-PREM8_11) * ART1731BIS ;
RCELREPYL_2 = max(RCELREPYL_P+RCELREPYLP2 , RCELREPYL1731) * (1-PREM8_11) * ART1731BIS ;
ACELREPYF_2 = max(ACELREPYF_P+ACELREPYFP2 , ACELREPYF1731) * (1-PREM8_11) * ART1731BIS ;
RCELREPYF_2 = max(RCELREPYF_P+RCELREPYFP2 , RCELREPYF1731) * (1-PREM8_11) * ART1731BIS ;
ACELREPYK_2 = max(ACELREPYK_P+ACELREPYKP2 , ACELREPYK1731) * (1-PREM8_11) * ART1731BIS ;
RCELREPYK_2 = max(RCELREPYK_P+RCELREPYKP2 , RCELREPYK1731) * (1-PREM8_11) * ART1731BIS ;
ACELREPYD_2 = max(ACELREPYD_P+ACELREPYDP2 , ACELREPYD1731) * (1-PREM8_11) * ART1731BIS ;
RCELREPYD_2 = max(RCELREPYD_P+RCELREPYDP2 , RCELREPYD1731) * (1-PREM8_11) * ART1731BIS ;
ACELREPYJ_2 = max(ACELREPYJ_P+ACELREPYJP2 , ACELREPYJ1731) * (1-PREM8_11) * ART1731BIS ;
RCELREPYJ_2 = max(RCELREPYJ_P+RCELREPYJP2 , RCELREPYJ1731) * (1-PREM8_11) * ART1731BIS ;
ACELREPYB_2 = max(ACELREPYB_P+ACELREPYBP2 , ACELREPYB1731) * (1-PREM8_11) * ART1731BIS ;
RCELREPYB_2 = max(RCELREPYB_P+RCELREPYBP2 , RCELREPYB1731) * (1-PREM8_11) * ART1731BIS ;
ACELREPYP_2 = max(ACELREPYP_P+ACELREPYPP2 , ACELREPYP1731) * (1-PREM8_11) * ART1731BIS ;
RCELREPYP_2 = max(RCELREPYP_P+RCELREPYPP2 , RCELREPYP1731) * (1-PREM8_11) * ART1731BIS ;
ACELREPYS_2 = max(ACELREPYS_P+ACELREPYSP2 , ACELREPYS1731) * (1-PREM8_11) * ART1731BIS ;
RCELREPYS_2 = max(RCELREPYS_P+RCELREPYSP2 , RCELREPYS1731) * (1-PREM8_11) * ART1731BIS ;
ACELREPYO_2 = max(ACELREPYO_P+ACELREPYOP2 , ACELREPYO1731) * (1-PREM8_11) * ART1731BIS ;
RCELREPYO_2 = max(RCELREPYO_P+RCELREPYOP2 , RCELREPYO1731) * (1-PREM8_11) * ART1731BIS ;
ACELREPYR_2 = max(ACELREPYR_P+ACELREPYRP2 , ACELREPYR1731) * (1-PREM8_11) * ART1731BIS ;
RCELREPYR_2 = max(RCELREPYR_P+RCELREPYRP2 , RCELREPYR1731) * (1-PREM8_11) * ART1731BIS ;
ACELREPYN_2 = max(ACELREPYN_P+ACELREPYNP2 , ACELREPYN1731) * (1-PREM8_11) * ART1731BIS ;
RCELREPYN_2 = max(RCELREPYN_P+RCELREPYNP2 , RCELREPYN1731) * (1-PREM8_11) * ART1731BIS ;
ACELREPYQ_2 = max(ACELREPYQ_P+ACELREPYQP2 , ACELREPYQ1731) * (1-PREM8_11) * ART1731BIS ;
RCELREPYQ_2 = max(RCELREPYQ_P+RCELREPYQP2 , RCELREPYQ1731) * (1-PREM8_11) * ART1731BIS ;
ACELREPYM_2 = max(ACELREPYM_P+ACELREPYMP2 , ACELREPYM1731) * (1-PREM8_11) * ART1731BIS ;
RCELREPYM_2 = max(RCELREPYM_P+RCELREPYMP2 , RCELREPYM1731) * (1-PREM8_11) * ART1731BIS ;
ACELHM_2 = max(ACELHM_P+ACELHMP2 , ACELHM1731) * (1-PREM8_11) * ART1731BIS ;
RCELHM_2 = max(RCELHM_P+RCELHMP2 , RCELHM1731) * (1-PREM8_11) * ART1731BIS ;
ACELHL_2 = max(ACELHL_P+ACELHLP2 , ACELHL1731) * (1-PREM8_11) * ART1731BIS ;
RCELHL_2 = max(RCELHL_P+RCELHLP2 , RCELHL1731) * (1-PREM8_11) * ART1731BIS ;
ACELHNO_2 = max(ACELHNO_P+ACELHNOP2 , ACELHNO1731) * (1-PREM8_11) * ART1731BIS ;
RCELHNO_2 = max(RCELHNO_P+RCELHNOP2 , RCELHNO1731) * (1-PREM8_11) * ART1731BIS ;
ACELHJK_2 = max(ACELHJK_P+ACELHJKP2 , ACELHJK1731) * (1-PREM8_11) * ART1731BIS ;
RCELHJK_2 = max(RCELHJK_P+RCELHJKP2 , RCELHJK1731) * (1-PREM8_11) * ART1731BIS ;
ACELNQ_2 = max(ACELNQ_P+ACELNQP2 , ACELNQ1731) * (1-PREM8_11) * ART1731BIS ;
RCELNQ_2 = max(RCELNQ_P+RCELNQP2 , RCELNQ1731) * (1-PREM8_11) * ART1731BIS ;
ACELNBGL_2 = max(ACELNBGL_P+ACELNBGLP2 , ACELNBGL1731) * (1-PREM8_11) * ART1731BIS ;
RCELNBGL_2 = max(RCELNBGL_P+RCELNBGLP2 , RCELNBGL1731) * (1-PREM8_11) * ART1731BIS ;
ACELCOM_2 = max(ACELCOM_P+ACELCOMP2 , ACELCOM1731) * (1-PREM8_11) * ART1731BIS ;
RCELCOM_2 = max(RCELCOM_P+RCELCOMP2 , RCELCOM1731) * (1-PREM8_11) * ART1731BIS ;
ACEL_2 = max(ACEL_P+ACELP2 , ACEL1731) * (1-PREM8_11) * ART1731BIS ;
RCEL_2 = max(RCEL_P+RCELP2 , RCEL1731) * (1-PREM8_11) * ART1731BIS ;
ACELJP_2 = max(ACELJP_P+ACELJPP2 , ACELJP1731) * (1-PREM8_11) * ART1731BIS ;
RCELJP_2 = max(RCELJP_P+RCELJPP2 , RCELJP1731) * (1-PREM8_11) * ART1731BIS ;
ACELJBGL_2 = max(ACELJBGL_P+ACELJBGLP2 , ACELJBGL1731) * (1-PREM8_11) * ART1731BIS ;
RCELJBGL_2 = max(RCELJBGL_P+RCELJBGLP2 , RCELJBGL1731) * (1-PREM8_11) * ART1731BIS ;
ACELJOQR_2 = max(ACELJOQR_P+ACELJOQRP2 , ACELJOQR1731) * (1-PREM8_11) * ART1731BIS ;
RCELJOQR_2 = max(RCELJOQR_P+RCELJOQRP2 , RCELJOQR1731) * (1-PREM8_11) * ART1731BIS ;
ACEL2012_2 = max(ACEL2012_P+ACEL2012P2 , ACEL20121731) * (1-PREM8_11) * ART1731BIS ;
RCEL2012_2 = max(RCEL2012_P+RCEL2012P2 , RCEL20121731) * (1-PREM8_11) * ART1731BIS ;
ACELFD_2 = max(ACELFD_P+ACELFDP2 , ACELFD1731) * (1-PREM8_11) * ART1731BIS ;
RCELFD_2 = max(RCELFD_P+RCELFDP2 , RCELFD1731) * (1-PREM8_11) * ART1731BIS ;
ACELFABC_2 = max(ACELFABC_P+ACELFABCP2 , ACELFABC1731) * (1-PREM8_11) * ART1731BIS ;
RCELFABC_2 = max(RCELFABC_P+RCELFABCP2 , RCELFABC1731) * (1-PREM8_11) * ART1731BIS ;
AREDMEUB_2 = max( AREDMEUB_P + AREDMEUBP2 , AREDMEUB1731) * (1-PREM8_11) * ART1731BIS ;
RREDMEUB_2 = max(RREDMEUB_P+RREDMEUBP2 , RREDMEUB1731) * (1-PREM8_11) * ART1731BIS ;
AREDREP_2 = max( AREDREP_P + AREDREPP2 , AREDREP1731) * (1-PREM8_11) * ART1731BIS ;
RREDREP_2 = max( RREDREP_P + RREDREPP2 , RREDREP1731) * (1-PREM8_11) * ART1731BIS ;
AILMIX_2 = max( AILMIX_P + AILMIXP2 , AILMIX1731) * (1-PREM8_11) * ART1731BIS ;
RILMIX_2 = max(RILMIX_P+RILMIXP2 , RILMIX1731) * (1-PREM8_11) * ART1731BIS ;
AILMIY_2 = max( AILMIY_P + AILMIYP2 , AILMIY1731) * (1-PREM8_11) * ART1731BIS ;
RILMIY_2 = max( RILMIY_P + RILMIYP2 , RILMIY1731) * (1-PREM8_11) * ART1731BIS ;
AILMPA_2 = max(AILMPA_P + AILMPAP2 , AILMPA1731) * (1-PREM8_11) * ART1731BIS ;
RILMPA_2 = max(RILMPA_P + RILMPAP2 , RILMPA1731) * (1-PREM8_11) * ART1731BIS ;
AILMPF_2 = max(AILMPF_P + AILMPFP2 , AILMPF1731) * (1-PREM8_11) * ART1731BIS ;
RILMPF_2 = max(RILMPF_P + RILMPFP2 , RILMPF1731) * (1-PREM8_11) * ART1731BIS ;
AINVRED_2 = max( AINVRED_P + AINVREDP2 , AINVRED1731) * (1-PREM8_11) * ART1731BIS ;
RINVRED_2 = max( RINVRED_P + RINVREDP2 , RINVRED1731) * (1-PREM8_11) * ART1731BIS ;
AILMIH_2 = max( AILMIH_P + AILMIHP2 , AILMIH1731) * (1-PREM8_11) * ART1731BIS ;
RILMIH_2 = max( RILMIH_P + RILMIHP2 , RILMIH1731) * (1-PREM8_11) * ART1731BIS ;
AILMJC_2 = max( AILMJC_P + AILMJCP2 , AILMJC1731) * (1-PREM8_11) * ART1731BIS ;
RILMJC_2 = max( RILMJC_P + RILMJCP2 , RILMJC1731) * (1-PREM8_11) * ART1731BIS ;
AILMPB_2 = max(AILMPB_P + AILMPBP2 , AILMPB1731) * (1-PREM8_11) * ART1731BIS ;
RILMPB_2 = max(RILMPB_P + RILMPBP2 , RILMPB1731) * (1-PREM8_11) * ART1731BIS ;
AILMPG_2 = max(AILMPG_P + AILMPGP2 , AILMPG1731) * (1-PREM8_11) * ART1731BIS ;
RILMPG_2 = max(RILMPG_P + RILMPGP2 , RILMPG1731) * (1-PREM8_11) * ART1731BIS ;
AILMIZ_2 = max( AILMIZ_P + AILMIZP2 , AILMIZ1731) * (1-PREM8_11) * ART1731BIS ;
RILMIZ_2 = max( RILMIZ_P + RILMIZP2 , RILMIZ1731) * (1-PREM8_11) * ART1731BIS ;
AILMJI_2 = max( AILMJI_P + AILMJIP2 , AILMJI1731) * (1-PREM8_11) * ART1731BIS ;
RILMJI_2 = max( RILMJI_P + RILMJIP2 , RILMJI1731) * (1-PREM8_11) * ART1731BIS ;
AILMPC_2 = max(AILMPC_P + AILMPCP2 , AILMPC1731) * (1-PREM8_11) * ART1731BIS ;
RILMPC_2 = max(RILMPC_P + RILMPCP2 , RILMPC1731) * (1-PREM8_11) * ART1731BIS ;
AILMPH_2 = max(AILMPH_P + AILMPHP2 , AILMPH1731) * (1-PREM8_11) * ART1731BIS ;
RILMPH_2 = max(RILMPH_P + RILMPHP2 , RILMPH1731) * (1-PREM8_11) * ART1731BIS ;
AILMJS_2 = max( AILMJS_P + AILMJSP2 , AILMJS1731) * (1-PREM8_11) * ART1731BIS ;
RILMJS_2 = max( RILMJS_P + RILMJSP2 , RILMJS1731) * (1-PREM8_11) * ART1731BIS ;
AILMPD_2 = max(AILMPD_P + AILMPDP2 , AILMPD1731) * (1-PREM8_11) * ART1731BIS ;
RILMPD_2 = max(RILMPD_P + RILMPDP2 , RILMPD1731) * (1-PREM8_11) * ART1731BIS ;
AILMPI_2 = max(AILMPI_P + AILMPIP2 , AILMPI1731) * (1-PREM8_11) * ART1731BIS ;
RILMPI_2 = max(RILMPI_P + RILMPIP2 , RILMPI1731) * (1-PREM8_11) * ART1731BIS ;
AILMPE_2 = max(AILMPE_P + AILMPEP2 , AILMPE1731) * (1-PREM8_11) * ART1731BIS ;
RILMPE_2 = max(RILMPE_P + RILMPEP2 , RILMPE1731) * (1-PREM8_11) * ART1731BIS ;
AILMPJ_2 = max(AILMPJ_P + AILMPJP2 , AILMPJ1731) * (1-PREM8_11) * ART1731BIS ;
RILMPJ_2 = max(RILMPJ_P + RILMPJP2 , RILMPJ1731) * (1-PREM8_11) * ART1731BIS ;
AMEUBLE_2 = max( AMEUBLE_P + AMEUBLEP2 , AMEUBLE1731) * (1-PREM8_11) * ART1731BIS ;
RMEUBLE_2 = max( RMEUBLE_P + RMEUBLEP2 , RMEUBLE1731) * (1-PREM8_11) * ART1731BIS ;
APROREP_2 = max( APROREP_P + APROREPP2 , APROREP1731) * (1-PREM8_11) * ART1731BIS ;
RPROREP_2 = max( RPROREP_P + RPROREPP2 , RPROREP1731) * (1-PREM8_11) * ART1731BIS ;
AREPNPRO_2 = max( AREPNPRO_P + AREPNPROP2 , AREPNPRO1731) * (1-PREM8_11) * ART1731BIS ;
RREPNPRO_2 = max( RREPNPRO_P + RREPNPROP2 , RREPNPRO1731) * (1-PREM8_11) * ART1731BIS ;
AREPMEU_2 = max( AREPMEU_P + AREPMEUP2 , AREPMEU1731) * (1-PREM8_11) * ART1731BIS ;
RREPMEU_2 = max(RREPMEU_P+RREPMEUP2 , RREPMEU1731) * (1-PREM8_11) * ART1731BIS ;
AILMIC_2 = max( AILMIC_P + AILMICP2 , AILMIC1731) * (1-PREM8_11) * ART1731BIS ;
RILMIC_2 = max(RILMIC_P+RILMICP2 , RILMIC1731) * (1-PREM8_11) * ART1731BIS ;
AILMIB_2 = max( AILMIB_P + AILMIBP2 , AILMIB1731) * (1-PREM8_11) * ART1731BIS ;
RILMIB_2 = max( RILMIB_P + RILMIBP2 , RILMIB1731) * (1-PREM8_11) * ART1731BIS ;
AILMIA_2 = max( AILMIA_P + AILMIAP2 , AILMIA1731) * (1-PREM8_11) * ART1731BIS ;
RILMIA_2 = max(RILMIA_P+RILMIAP2 , RILMIA1731) * (1-PREM8_11) * ART1731BIS ;
AILMJY_2 = max( AILMJY_P + AILMJYP2 , AILMJY1731) * (1-PREM8_11) * ART1731BIS ;
RILMJY_2 = max(RILMJY_P+RILMJYP2 , RILMJY1731) * (1-PREM8_11) * ART1731BIS ;
AILMJX_2 = max( AILMJX_P + AILMJXP2 , AILMJX1731) * (1-PREM8_11) * ART1731BIS ;
RILMJX_2 = max( RILMJX_P + RILMJXP2 , RILMJX1731) * (1-PREM8_11) * ART1731BIS ;
AILMJW_2 = max( AILMJW_P + AILMJWP2 , AILMJW1731) * (1-PREM8_11) * ART1731BIS ;
RILMJW_2 = max( RILMJW_P + RILMJWP2 , RILMJW1731) * (1-PREM8_11) * ART1731BIS ;
AILMJV_2 = max( AILMJV_P + AILMJVP2 , AILMJV1731) * (1-PREM8_11) * ART1731BIS ;
RILMJV_2 = max( RILMJV_P + RILMJVP2 , RILMJV1731) * (1-PREM8_11) * ART1731BIS ;
AILMOE_2 = max( AILMOE_P + AILMOEP2 , AILMOE1731) * (1-PREM8_11) * ART1731BIS ;
RILMOE_2 = max( RILMOE_P + RILMOEP2 , RILMOE1731) * (1-PREM8_11) * ART1731BIS ;
AILMOD_2 = max( AILMOD_P + AILMODP2 , AILMOD1731) * (1-PREM8_11) * ART1731BIS ;
RILMOD_2 = max( RILMOD_P + RILMODP2 , RILMOD1731) * (1-PREM8_11) * ART1731BIS ;
AILMOC_2 = max( AILMOC_P + AILMOCP2 , AILMOC1731) * (1-PREM8_11) * ART1731BIS ;
RILMOC_2 = max( RILMOC_P + RILMOCP2 , RILMOC1731) * (1-PREM8_11) * ART1731BIS ;
AILMOB_2 = max( AILMOB_P + AILMOBP2 , AILMOB1731) * (1-PREM8_11) * ART1731BIS ;
RILMOB_2 = max( RILMOB_P + RILMOBP2 , RILMOB1731) * (1-PREM8_11) * ART1731BIS ;
AILMOA_2 = max( AILMOA_P + AILMOAP2 , AILMOA1731) * (1-PREM8_11) * ART1731BIS ;
RILMOA_2 = max( RILMOA_P + RILMOAP2 , RILMOA1731) * (1-PREM8_11) * ART1731BIS ;
AILMOJ_2 = max( AILMOJ_P + AILMOJP2 , AILMOJ1731) * (1-PREM8_11) * ART1731BIS ;
RILMOJ_2 = max( RILMOJ_P + RILMOJP2 , RILMOJ1731) * (1-PREM8_11) * ART1731BIS ;
AILMOI_2 = max( AILMOI_P + AILMOIP2 , AILMOI1731) * (1-PREM8_11) * ART1731BIS ;
RILMOI_2 = max( RILMOI_P + RILMOIP2 , RILMOI1731) * (1-PREM8_11) * ART1731BIS ;
AILMOH_2 = max( AILMOH_P + AILMOHP2 , AILMOH1731) * (1-PREM8_11) * ART1731BIS ;
RILMOH_2 = max( RILMOH_P + RILMOHP2 , RILMOH1731) * (1-PREM8_11) * ART1731BIS ;
AILMOG_2 = max( AILMOG_P + AILMOGP2 , AILMOG1731) * (1-PREM8_11) * ART1731BIS ;
RILMOG_2 = max( RILMOG_P + RILMOGP2 , RILMOG1731) * (1-PREM8_11) * ART1731BIS ;
AILMOF_2 = max( AILMOF_P + AILMOFP2 , AILMOF1731) * (1-PREM8_11) * ART1731BIS ;
RILMOF_2 = max( RILMOF_P + RILMOFP2 , RILMOF1731) * (1-PREM8_11) * ART1731BIS ;
ARESIMEUB_2 = max( ARESIMEUB_P + ARESIMEUBP2 , ARESIMEUB1731) * (1-PREM8_11) * ART1731BIS ;
RRESIMEUB_2 = max( RRESIMEUB_P + RRESIMEUBP2 , RRESIMEUB1731) * (1-PREM8_11) * ART1731BIS ;
ARESIVIEU_2 = max( ARESIVIEU_P + ARESIVIEUP2 , ARESIVIEU1731) * (1-PREM8_11) * ART1731BIS ;
RCODIW_2 = max(RCODIW_P+ RCODIWP2 , RCODIW1731) * (1-PREM8_11) * ART1731BIS ;
RCODIM_2 = max(RCODIM_P+RCODIMP2 , RCODIM1731) * (1-PREM8_11) * ART1731BIS ;
ARESINEUV_2 = max( ARESINEUV_P + ARESINEUVP2 , ARESINEUV1731) * (1-PREM8_11) * ART1731BIS ;
RCODIL_2 = max(RCODIL_P+RCODILP2 , RCODIL1731) * (1-PREM8_11) * ART1731BIS ;
RCODIN_2 = max(RCODIN_P+RCODINP2 , RCODIN1731) * (1-PREM8_11) * ART1731BIS ;
RCODIV_2 = max(RCODIV_P+RCODIVP2 , RCODIV1731) * (1-PREM8_11) * ART1731BIS ;
RCODIJ_2 = max(RCODIJ_P+RCODIJP2 , RCODIJ1731+0 ) * (1-PREM8_11) * ART1731BIS ;
ALOCIDEFG_2 = max( ALOCIDEFG_P + ALOCIDEFGP2 , ALOCIDEFG1731) * (1-PREM8_11) * ART1731BIS ;
ACODIF_2 = max( ACODIF_P+ACODIFP2 , ACODIF1731) * (1-PREM8_11) * ART1731BIS ;
RCODIF_2 = max( RCODIF_P+RCODIFP2 , RCODIF1731) * (1-PREM8_11) * ART1731BIS ;
ACODIG_2 = max( ACODIG_P+ACODIGP2 , ACODIG1731) * (1-PREM8_11) * ART1731BIS ;
RCODIG_2 = max( RCODIG_P+RCODIGP2 , RCODIG1731) * (1-PREM8_11) * ART1731BIS ;
ACODID_2 = max( ACODID_P+ACODIDP2 , RCODID1731) * (1-PREM8_11) * ART1731BIS ;
RCODID_2 = max( RCODID_P+RCODIDP2 , RCODID1731) * (1-PREM8_11) * ART1731BIS ;
ACODIE_2 = max( ACODIE_P+ACODIEP2 , ACODIE1731 ) * (1-PREM8_11) * ART1731BIS ;
RCODIE_2 = max( RCODIE_P+RCODIEP2 , RCODIE1731 ) * (1-PREM8_11) * ART1731BIS ;
ACODJTJU_2 = max( ACODJTJU_P + ACODJTJUP2 , ACODJTJU1731) * (1-PREM8_11) * ART1731BIS ;
RCODJU_2 = max(RCODJU_P+RCODJUP2 , RCODJU1731) * (1-PREM8_11) * ART1731BIS ;
RCODJT_2 = max(RCODJT_P+RCODJTP2 , RCODJT1731) * (1-PREM8_11) * ART1731BIS ;
ACODOU_2 = max(ACODOU_P+ACODOUP2 , ACODOU1731) * (1-PREM8_11) * ART1731BIS ;
RCODOU_2 = max(RCODOU_P+RCODOUP2 , RCODOU1731) * (1-PREM8_11) * ART1731BIS ;
ACODOV_2 = max(ACODOV_P+ACODOVP2 , ACODOV1731) * (1-PREM8_11) * ART1731BIS ;
RCODOV_2 = max(RCODOV_P+RCODOVP2 , RCODOV1731) * (1-PREM8_11) * ART1731BIS ;
APATNAT1_2 = max( APATNAT1_P + APATNAT1P2 , APATNAT11731) * (1-PREM8_11) * ART1731BIS ;
RPATNAT1_2 = max(RPATNAT1_P+RPATNAT1P2 , RPATNAT11731) * (1-PREM8_11) * ART1731BIS ;
APATNAT2_2 = max( APATNAT2_P + APATNAT2P2 , APATNAT21731) * (1-PREM8_11) * ART1731BIS ;
RPATNAT2_2 = max(RPATNAT2_P+RPATNAT2P2 , RPATNAT21731) * (1-PREM8_11) * ART1731BIS ;
APATNAT3_2 = max( APATNAT3_P + APATNAT3P2 , APATNAT31731) * (1-PREM8_11) * ART1731BIS ;
RPATNAT3_2 = max(RPATNAT3_P +RPATNAT3P2 , RPATNAT31731) * (1-PREM8_11) * ART1731BIS ;
APATNAT_2 = max( APATNAT_P + APATNATP2 , APATNAT1731) * (1-PREM8_11) * ART1731BIS ;
RPATNAT_2 = max(RPATNAT_P+RPATNATP2 , RPATNAT1731) * (1-PREM8_11) * ART1731BIS ;
ADOMSOC1_2 = max( ADOMSOC1_P + ADOMSOC1P2 , ADOMSOC11731) * (1-PREM8_11) * ART1731BIS ;
RDOMSOC1_2 = max(RDOMSOC1_P+RDOMSOC1P2 , RDOMSOC11731) * (1-PREM8_11) * ART1731BIS ;
ALOGSOC_2 = max( ALOGSOC_P + ALOGSOCP2 , ALOGSOC1731) * (1-PREM8_11) * ART1731BIS ;
RLOGSOC_2 = max(RLOGSOC_P+RLOGSOCP2 , RLOGSOC1731) * (1-PREM8_11) * ART1731BIS ;
ACOLENT_2 = max( ACOLENT_P + ACOLENTP2 , ACOLENT1731) * (1-PREM8_11) * ART1731BIS ;
RCOLENT_2 = max(RCOLENT_P+RCOLENTP2 , RCOLENT1731) * (1-PREM8_11) * ART1731BIS ;
ALOCENT_2 = max( ALOCENT_P + ALOCENTP2 , ALOCENT1731) * (1-PREM8_11) * ART1731BIS ;
RLOCENT_2 = max(RLOCENT_P+RLOCENTP2 , RLOCENT1731) * (1-PREM8_11) * ART1731BIS ;
RRIREP_2 = max(RRIREP_P+RRIREPP2 , RRIREP1731) * (1-PREM8_11) * ART1731BIS ;

RLOG01_2 = max( RLOG01_P + RLOG01P2 , RLOG011731) * (1-PREM8_11) * ART1731BIS ;
RLOG02_2 = max( RLOG02_P + RLOG02P2 , RLOG021731) * (1-PREM8_11) * ART1731BIS ;
RLOG03_2 = max( RLOG03_P + RLOG03P2 , RLOG031731) * (1-PREM8_11) * ART1731BIS ;
RLOG04_2 = max( RLOG04_P + RLOG04P2 , RLOG041731) * (1-PREM8_11) * ART1731BIS ;
RLOG05_2 = max( RLOG05_P + RLOG05P2 , RLOG051731) * (1-PREM8_11) * ART1731BIS ;
RLOG06_2 = max( RLOG06_P + RLOG06P2 , RLOG061731) * (1-PREM8_11) * ART1731BIS ;
RLOG07_2 = max( RLOG07_P + RLOG07P2 , RLOG071731) * (1-PREM8_11) * ART1731BIS ;
RLOG08_2 = max( RLOG08_P + RLOG08P2 , RLOG081731) * (1-PREM8_11) * ART1731BIS ;
RLOG09_2 = max( RLOG09_P + RLOG09P2 , RLOG091731) * (1-PREM8_11) * ART1731BIS ;
RLOG10_2 = max( RLOG10_P + RLOG10P2 , RLOG101731) * (1-PREM8_11) * ART1731BIS ;
RLOG11_2 = max( RLOG11_P + RLOG11P2 , RLOG111731) * (1-PREM8_11) * ART1731BIS ;
RLOG12_2 = max( RLOG12_P + RLOG12P2 , RLOG121731) * (1-PREM8_11) * ART1731BIS ;
RLOG13_2 = max( RLOG13_P + RLOG13P2 , RLOG131731) * (1-PREM8_11) * ART1731BIS ;
RLOG14_2 = max( RLOG14_P + RLOG14P2 , RLOG141731) * (1-PREM8_11) * ART1731BIS ;
RLOG15_2 = max( RLOG15_P + RLOG15P2 , RLOG151731) * (1-PREM8_11) * ART1731BIS ;
RLOG16_2 = max( RLOG16_P + RLOG16P2 , RLOG161731) * (1-PREM8_11) * ART1731BIS ;
RLOG17_2 = max( RLOG17_P + RLOG17P2 , RLOG171731) * (1-PREM8_11) * ART1731BIS ;
RLOG18_2 = max( RLOG18_P + RLOG18P2 , RLOG181731) * (1-PREM8_11) * ART1731BIS ;
RLOG19_2 = max( RLOG19_P + RLOG19P2 , RLOG191731) * (1-PREM8_11) * ART1731BIS ;
RLOG20_2 = max( RLOG20_P + RLOG20P2 , RLOG201731) * (1-PREM8_11) * ART1731BIS ;
RLOG21_2 = max( RLOG21_P + RLOG21P2 , RLOG211731) * (1-PREM8_11) * ART1731BIS ;
RLOG22_2 = max( RLOG22_P + RLOG22P2 , RLOG221731) * (1-PREM8_11) * ART1731BIS ;
RLOG23_2 = max( RLOG23_P + RLOG23P2 , RLOG231731) * (1-PREM8_11) * ART1731BIS ;
RLOG24_2 = max( RLOG24_P + RLOG24P2 , RLOG241731) * (1-PREM8_11) * ART1731BIS ;
RLOG25_2 = max( RLOG25_P + RLOG25P2 , RLOG251731) * (1-PREM8_11) * ART1731BIS ;
RLOG26_2 = max( RLOG26_P + RLOG26P2 , RLOG261731) * (1-PREM8_11) * ART1731BIS ;
RLOG27_2 = max( RLOG27_P + RLOG27P2 , RLOG271731) * (1-PREM8_11) * ART1731BIS ;
RLOG28_2 = max( RLOG28_P + RLOG28P2 , RLOG281731) * (1-PREM8_11) * ART1731BIS ;
RLOG29_2 = max( RLOG29_P + RLOG29P2 , RLOG291731) * (1-PREM8_11) * ART1731BIS ;
RLOG30_2 = max( RLOG30_P + RLOG30P2 , RLOG301731) * (1-PREM8_11) * ART1731BIS ;
RLOG31_2 = max( RLOG31_P + RLOG31P2 , RLOG311731) * (1-PREM8_11) * ART1731BIS ;
RLOG32_2 = max( RLOG32_P + RLOG32P2 , RLOG321731) * (1-PREM8_11) * ART1731BIS ;
RLOG33_2 = max( RLOG33_P + RLOG33P2 , RLOG331731) * (1-PREM8_11) * ART1731BIS ;
RLOG34_2 = max( RLOG34_P + RLOG34P2 , RLOG341731) * (1-PREM8_11) * ART1731BIS ;
RLOG35_2 = max( RLOG35_P + RLOG35P2 , RLOG351731) * (1-PREM8_11) * ART1731BIS ;
RLOG36_2 = max( RLOG36_P + RLOG36P2 , RLOG361731) * (1-PREM8_11) * ART1731BIS ;
RLOG37_2 = max( RLOG37_P + RLOG37P2 , RLOG371731) * (1-PREM8_11) * ART1731BIS ;
RLOG38_2 = max( RLOG38_P + RLOG38P2 , RLOG381731) * (1-PREM8_11) * ART1731BIS ;
RLOG39_2 = max( RLOG39_P + RLOG39P2 , RLOG391731) * (1-PREM8_11) * ART1731BIS ;
RLOG40_2 = max( RLOG40_P + RLOG40P2 , RLOG401731) * (1-PREM8_11) * ART1731BIS ;
RLOG41_2 = max( RLOG41_P + RLOG41P2 , RLOG411731) * (1-PREM8_11) * ART1731BIS ;
RLOG42_2 = max( RLOG42_P + RLOG42P2 , RLOG421731) * (1-PREM8_11) * ART1731BIS ;
RLOG43_2 = max( RLOG43_P + RLOG43P2 , RLOG431731) * (1-PREM8_11) * ART1731BIS ;
RLOG44_2 = max( RLOG44_P + RLOG44P2 , RLOG441731) * (1-PREM8_11) * ART1731BIS ;
RLOG45_2 = max( RLOG45_P + RLOG45P2 , RLOG451731) * (1-PREM8_11) * ART1731BIS ;
RLOG46_2 = max( RLOG46_P + RLOG46P2 , RLOG461731) * (1-PREM8_11) * ART1731BIS ;
RSOC1_2 = max( RSOC1_P + RSOC1P2 , RSOC11731 ) * (1-PREM8_11) * ART1731BIS ;
RSOC2_2 = max( RSOC2_P + RSOC2P2 , RSOC21731 ) * (1-PREM8_11) * ART1731BIS ;
RSOC3_2 = max( RSOC3_P + RSOC3P2 , RSOC31731 ) * (1-PREM8_11) * ART1731BIS ;
RSOC4_2 = max( RSOC4_P + RSOC4P2 , RSOC41731 ) * (1-PREM8_11) * ART1731BIS ;
RSOC5_2 = max( RSOC5_P + RSOC5P2 , RSOC51731 ) * (1-PREM8_11) * ART1731BIS ;
RSOC6_2 = max( RSOC6_P + RSOC6P2 , RSOC61731 ) * (1-PREM8_11) * ART1731BIS ;
RSOC7_2 = max( RSOC7_P + RSOC7P2 , RSOC71731 ) * (1-PREM8_11) * ART1731BIS ;
RSOC8_2 = max( RSOC8_P + RSOC8P2 , RSOC81731 ) * (1-PREM8_11) * ART1731BIS ;
RSOC9_2 = max( RSOC9_P + RSOC9P2 , RSOC91731 ) * (1-PREM8_11) * ART1731BIS ;
RSOC10_2 = max( RSOC10_P + RSOC10P2 , RSOC101731 ) * (1-PREM8_11) * ART1731BIS ;
RSOC11_2 = max( RSOC11_P + RSOC11P2 , RSOC111731 ) * (1-PREM8_11) * ART1731BIS ;
RSOC12_2 = max( RSOC12_P + RSOC12P2 , RSOC121731 ) * (1-PREM8_11) * ART1731BIS ;
RSOC13_2 = max( RSOC13_P + RSOC13P2 , RSOC131731 ) * (1-PREM8_11) * ART1731BIS ;
RSOC14_2 = max( RSOC14_P + RSOC14P2 , RSOC141731 ) * (1-PREM8_11) * ART1731BIS ;
RSOC15_2 = max( RSOC15_P + RSOC15P2 , RSOC151731 ) * (1-PREM8_11) * ART1731BIS ;
RSOC16_2 = max( RSOC16_P + RSOC16P2 , RSOC161731 ) * (1-PREM8_11) * ART1731BIS ;
RSOC17_2 = max( RSOC17_P + RSOC17P2 , RSOC171731 ) * (1-PREM8_11) * ART1731BIS ;
RSOC18_2 = max( RSOC18_P + RSOC18P2 , RSOC181731 ) * (1-PREM8_11) * ART1731BIS ;
RSOC19_2 = max( RSOC19_P + RSOC19P2 , RSOC191731 ) * (1-PREM8_11) * ART1731BIS ;
RSOC20_2 = max( RSOC20_P + RSOC20P2 , RSOC201731 ) * (1-PREM8_11) * ART1731BIS ;
RSOC21_2 = max( RSOC21_P + RSOC21P2 , RSOC211731 ) * (1-PREM8_11) * ART1731BIS ;
RSOC22_2 = max( RSOC22_P + RSOC22P2 , RSOC221731 ) * (1-PREM8_11) * ART1731BIS ;
RSOC23_2 = max( RSOC23_P + RSOC23P2 , RSOC231731 ) * (1-PREM8_11) * ART1731BIS ;
RSOC24_2 = max( RSOC24_P + RSOC24P2 , RSOC241731 ) * (1-PREM8_11) * ART1731BIS ;
RSOC25_2 = max( RSOC25_P + RSOC25P2 , RSOC251731 ) * (1-PREM8_11) * ART1731BIS ;
RSOC26_2 = max( RSOC26_P + RSOC26P2 , RSOC261731 ) * (1-PREM8_11) * ART1731BIS ;
RSOC27_2 = max( RSOC27_P + RSOC27P2 , RSOC271731 ) * (1-PREM8_11) * ART1731BIS ;
RSOC28_2 = max( RSOC28_P + RSOC28P2 , RSOC281731 ) * (1-PREM8_11) * ART1731BIS ;
RSOC29_2 = max( RSOC29_P + RSOC29P2 , RSOC291731 ) * (1-PREM8_11) * ART1731BIS ;
RSOC30_2 = max( RSOC30_P + RSOC30P2 , RSOC301731 ) * (1-PREM8_11) * ART1731BIS ;
RSOC31_2 = max( RSOC31_P + RSOC31P2 , RSOC311731 ) * (1-PREM8_11) * ART1731BIS ;
RSOC32_2 = max( RSOC32_P + RSOC32P2 , RSOC321731 ) * (1-PREM8_11) * ART1731BIS ;
RSOC33_2 = max( RSOC33_P + RSOC33P2 , RSOC331731 ) * (1-PREM8_11) * ART1731BIS ;
RSOC34_2 = max( RSOC34_P + RSOC34P2 , RSOC341731 ) * (1-PREM8_11) * ART1731BIS ;
RSOC35_2 = max( RSOC35_P + RSOC35P2 , RSOC351731 ) * (1-PREM8_11) * ART1731BIS ;
RSOC36_2 = max( RSOC36_P + RSOC36P2 , RSOC361731 ) * (1-PREM8_11) * ART1731BIS ;
RSOC37_2 = max( RSOC37_P + RSOC37P2 , RSOC371731 ) * (1-PREM8_11) * ART1731BIS ;
RSOC38_2 = max( RSOC38_P + RSOC38P2 , RSOC381731 ) * (1-PREM8_11) * ART1731BIS ;
RSOC39_2 = max( RSOC39_P + RSOC39P2 , RSOC391731 ) * (1-PREM8_11) * ART1731BIS ;
RSOC40_2 = max( RSOC40_P + RSOC40P2 , RSOC401731 ) * (1-PREM8_11) * ART1731BIS ;
RSOC41_2 = max( RSOC41_P + RSOC41P2 , RSOC411731 ) * (1-PREM8_11) * ART1731BIS ;
RSOC42_2 = max( RSOC42_P + RSOC42P2 , RSOC421731 ) * (1-PREM8_11) * ART1731BIS ;
RSOC43_2 = max( RSOC43_P + RSOC43P2 , RSOC431731 ) * (1-PREM8_11) * ART1731BIS ;
RSOC44_2 = max( RSOC44_P + RSOC44P2 , RSOC441731 ) * (1-PREM8_11) * ART1731BIS ;
RSOC45_2 = max( RSOC45_P + RSOC45P2 , RSOC451731 ) * (1-PREM8_11) * ART1731BIS ;
RSOC46_2 = max( RSOC46_P + RSOC46P2 , RSOC461731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC07_2 = max( RLOC07_P + RLOC07P2 , RLOC071731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC08_2 = max( RLOC08_P + RLOC08P2 , RLOC081731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC09_2 = max( RLOC09_P + RLOC09P2 , RLOC091731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC10_2 = max( RLOC10_P + RLOC10P2 , RLOC101731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC11_2 = max( RLOC11_P + RLOC11P2 , RLOC111731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC12_2 = max( RLOC12_P + RLOC12P2 , RLOC121731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC13_2 = max( RLOC13_P + RLOC13P2 , RLOC131731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC14_2 = max( RLOC14_P + RLOC14P2 , RLOC141731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC15_2 = max( RLOC15_P + RLOC15P2 , RLOC151731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC16_2 = max( RLOC16_P + RLOC16P2 , RLOC161731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC17_2 = max( RLOC17_P + RLOC17P2 , RLOC171731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC18_2 = max( RLOC18_P + RLOC18P2 , RLOC181731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC19_2 = max( RLOC19_P + RLOC19P2 , RLOC191731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC20_2 = max( RLOC20_P + RLOC20P2 , RLOC201731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC21_2 = max( RLOC21_P + RLOC21P2 , RLOC211731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC22_2 = max( RLOC22_P + RLOC22P2 , RLOC221731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC23_2 = max( RLOC23_P + RLOC23P2 , RLOC231731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC24_2 = max( RLOC24_P + RLOC24P2 , RLOC241731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC25_2 = max( RLOC25_P + RLOC25P2 , RLOC251731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC26_2 = max( RLOC26_P + RLOC26P2 , RLOC261731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC27_2 = max( RLOC27_P + RLOC27P2 , RLOC271731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC28_2 = max( RLOC28_P + RLOC28P2 , RLOC281731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC29_2 = max( RLOC29_P + RLOC29P2 , RLOC291731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC30_2 = max( RLOC30_P + RLOC30P2 , RLOC301731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC31_2 = max( RLOC31_P + RLOC31P2 , RLOC311731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC32_2 = max( RLOC32_P + RLOC32P2 , RLOC321731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC33_2 = max( RLOC33_P + RLOC33P2 , RLOC331731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC34_2 = max( RLOC34_P + RLOC34P2 , RLOC341731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC35_2 = max( RLOC35_P + RLOC35P2 , RLOC351731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC36_2 = max( RLOC36_P + RLOC36P2 , RLOC361731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC37_2 = max( RLOC37_P + RLOC37P2 , RLOC371731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC38_2 = max( RLOC38_P + RLOC38P2 , RLOC381731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC39_2 = max( RLOC39_P + RLOC39P2 , RLOC391731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC40_2 = max( RLOC40_P + RLOC40P2 , RLOC401731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC41_2 = max( RLOC41_P + RLOC41P2 , RLOC411731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC42_2 = max( RLOC42_P + RLOC42P2 , RLOC421731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC43_2 = max( RLOC43_P + RLOC43P2 , RLOC431731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC44_2 = max( RLOC44_P + RLOC44P2 , RLOC441731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC45_2 = max( RLOC45_P + RLOC45P2 , RLOC451731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC46_2 = max( RLOC46_P + RLOC46P2 , RLOC461731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC47_2 = max( RLOC47_P + RLOC47P2 , RLOC471731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC48_2 = max( RLOC48_P + RLOC48P2 , RLOC481731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC49_2 = max( RLOC49_P + RLOC49P2 , RLOC491731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC50_2 = max( RLOC50_P + RLOC50P2 , RLOC501731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC51_2 = max( RLOC51_P + RLOC51P2 , RLOC511731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC52_2 = max( RLOC52_P + RLOC52P2 , RLOC521731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC53_2 = max( RLOC53_P + RLOC53P2 , RLOC531731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC54_2 = max( RLOC54_P + RLOC54P2 , RLOC541731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC55_2 = max( RLOC55_P + RLOC55P2 , RLOC551731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC56_2 = max( RLOC56_P + RLOC56P2 , RLOC561731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC57_2 = max( RLOC57_P + RLOC57P2 , RLOC571731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC58_2 = max( RLOC58_P + RLOC58P2 , RLOC581731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC59_2 = max( RLOC59_P + RLOC59P2 , RLOC591731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC60_2 = max( RLOC60_P + RLOC60P2 , RLOC601731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC61_2 = max( RLOC61_P + RLOC61P2 , RLOC611731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC62_2 = max( RLOC62_P + RLOC62P2 , RLOC621731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC63_2 = max( RLOC63_P + RLOC63P2 , RLOC631731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC64_2 = max( RLOC64_P + RLOC64P2 , RLOC641731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC65_2 = max( RLOC65_P + RLOC65P2 , RLOC651731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC66_2 = max( RLOC66_P + RLOC66P2 , RLOC661731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC67_2 = max( RLOC67_P + RLOC67P2 , RLOC671731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC68_2 = max( RLOC68_P + RLOC68P2 , RLOC681731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC69_2 = max( RLOC69_P + RLOC69P2 , RLOC691731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC70_2 = max( RLOC70_P + RLOC70P2 , RLOC701731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC71_2 = max( RLOC71_P + RLOC71P2 , RLOC711731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC72_2 = max( RLOC72_P + RLOC72P2 , RLOC721731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC73_2 = max( RLOC73_P + RLOC73P2 , RLOC731731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC74_2 = max( RLOC74_P + RLOC74P2 , RLOC741731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC75_2 = max( RLOC75_P + RLOC75P2 , RLOC751731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC76_2 = max( RLOC76_P + RLOC76P2 , RLOC761731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC77_2 = max( RLOC77_P + RLOC77P2 , RLOC771731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC78_2 = max( RLOC78_P + RLOC78P2 , RLOC781731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC79_2 = max( RLOC79_P + RLOC79P2 , RLOC791731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC80_2 = max( RLOC80_P + RLOC80P2 , RLOC801731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC81_2 = max( RLOC81_P + RLOC81P2 , RLOC811731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC82_2 = max( RLOC82_P + RLOC82P2 , RLOC821731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC83_2 = max( RLOC83_P + RLOC83P2 , RLOC831731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC84_2 = max( RLOC84_P + RLOC84P2 , RLOC841731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC85_2 = max( RLOC85_P + RLOC85P2 , RLOC851731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC86_2 = max( RLOC86_P + RLOC86P2 , RLOC861731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC87_2 = max( RLOC87_P + RLOC87P2 , RLOC871731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC88_2 = max( RLOC88_P + RLOC88P2 , RLOC881731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC89_2 = max( RLOC89_P + RLOC89P2 , RLOC891731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC90_2 = max( RLOC90_P + RLOC90P2 , RLOC901731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC91_2 = max( RLOC91_P + RLOC91P2 , RLOC911731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC92_2 = max( RLOC92_P + RLOC92P2 , RLOC921731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC93_2 = max( RLOC93_P + RLOC93P2 , RLOC931731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC94_2 = max( RLOC94_P + RLOC94P2 , RLOC941731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC95_2 = max( RLOC95_P + RLOC95P2 , RLOC951731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC96_2 = max( RLOC96_P + RLOC96P2 , RLOC961731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC97_2 = max( RLOC97_P + RLOC97P2 , RLOC971731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC98_2 = max( RLOC98_P + RLOC98P2 , RLOC981731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC99_2 = max( RLOC99_P + RLOC99P2 , RLOC991731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC100_2 = max( RLOC100_P + RLOC100P2 , RLOC1001731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC101_2 = max( RLOC101_P + RLOC101P2 , RLOC1011731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC102_2 = max( RLOC102_P + RLOC102P2 , RLOC1021731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC103_2 = max( RLOC103_P + RLOC103P2 , RLOC1031731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC104_2 = max( RLOC104_P + RLOC104P2 , RLOC1041731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC105_2 = max( RLOC105_P + RLOC105P2 , RLOC1051731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC106_2 = max( RLOC106_P + RLOC106P2 , RLOC1061731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC107_2 = max( RLOC107_P + RLOC107P2 , RLOC1071731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC108_2 = max( RLOC108_P + RLOC108P2 , RLOC1081731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC109_2 = max( RLOC109_P + RLOC109P2 , RLOC1091731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC110_2 = max( RLOC110_P + RLOC110P2 , RLOC1101731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC111_2 = max( RLOC111_P + RLOC111P2 , RLOC1111731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC112_2 = max( RLOC112_P + RLOC112P2 , RLOC1121731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC113_2 = max( RLOC113_P + RLOC113P2 , RLOC1131731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC114_2 = max( RLOC114_P + RLOC114P2 , RLOC1141731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC115_2 = max( RLOC115_P + RLOC115P2 , RLOC1151731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC116_2 = max( RLOC116_P + RLOC116P2 , RLOC1161731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC117_2 = max( RLOC117_P + RLOC117P2 , RLOC1171731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC118_2 = max( RLOC118_P + RLOC118P2 , RLOC1181731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC119_2 = max( RLOC119_P + RLOC119P2 , RLOC1191731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC120_2 = max( RLOC120_P + RLOC120P2 , RLOC1201731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC121_2 = max( RLOC121_P + RLOC121P2 , RLOC1211731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC122_2 = max( RLOC122_P + RLOC122P2 , RLOC1221731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC123_2 = max( RLOC123_P + RLOC123P2 , RLOC1231731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC124_2 = max( RLOC124_P + RLOC124P2 , RLOC1241731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC125_2 = max( RLOC125_P + RLOC125P2 , RLOC1251731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC126_2 = max( RLOC126_P + RLOC126P2 , RLOC1261731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC127_2 = max( RLOC127_P + RLOC127P2 , RLOC1271731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC128_2 = max( RLOC128_P + RLOC128P2 , RLOC1281731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC129_2 = max( RLOC129_P + RLOC129P2 , RLOC1291731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC130_2 = max( RLOC130_P + RLOC130P2 , RLOC1301731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC131_2 = max( RLOC131_P + RLOC131P2 , RLOC1311731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC132_2 = max( RLOC132_P + RLOC132P2 , RLOC1321731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC133_2 = max( RLOC133_P + RLOC133P2 , RLOC1331731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC134_2 = max( RLOC134_P + RLOC134P2 , RLOC1341731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC135_2 = max( RLOC135_P + RLOC135P2 , RLOC1351731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC136_2 = max( RLOC136_P + RLOC136P2 , RLOC1361731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC137_2 = max( RLOC137_P + RLOC137P2 , RLOC1371731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC138_2 = max( RLOC138_P + RLOC138P2 , RLOC1381731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC139_2 = max( RLOC139_P + RLOC139P2 , RLOC1391731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC140_2 = max( RLOC140_P + RLOC140P2 , RLOC1401731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC141_2 = max( RLOC141_P + RLOC141P2 , RLOC1411731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC142_2 = max( RLOC142_P + RLOC142P2 , RLOC1421731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC143_2 = max( RLOC143_P + RLOC143P2 , RLOC1431731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC144_2 = max( RLOC144_P + RLOC144P2 , RLOC1441731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC145_2 = max( RLOC145_P + RLOC145P2 , RLOC1451731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC146_2 = max( RLOC146_P + RLOC146P2 , RLOC1461731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC147_2 = max( RLOC147_P + RLOC147P2 , RLOC1471731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC148_2 = max( RLOC148_P + RLOC148P2 , RLOC1481731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC149_2 = max( RLOC149_P + RLOC149P2 , RLOC1491731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC150_2 = max( RLOC150_P + RLOC150P2 , RLOC1501731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC151_2 = max( RLOC151_P + RLOC151P2 , RLOC1511731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC152_2 = max( RLOC152_P + RLOC152P2 , RLOC1521731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC153_2 = max( RLOC153_P + RLOC153P2 , RLOC1531731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC154_2 = max( RLOC154_P + RLOC154P2 , RLOC1541731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC155_2 = max( RLOC155_P + RLOC155P2 , RLOC1551731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC156_2 = max( RLOC156_P + RLOC156P2 , RLOC1561731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC157_2 = max( RLOC157_P + RLOC157P2 , RLOC1571731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC158_2 = max( RLOC158_P + RLOC158P2 , RLOC1581731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC159_2 = max( RLOC159_P + RLOC159P2 , RLOC1591731 ) * (1-PREM8_11) * ART1731BIS ;
RLOC160_2 = max( RLOC160_P + RLOC160P2 , RLOC1601731 ) * (1-PREM8_11) * ART1731BIS ;
RENT01_2 = max( RENT01_P + RENT01P2 , RENT011731 ) * (1-PREM8_11) * ART1731BIS ;
RENT02_2 = max( RENT02_P + RENT02P2 , RENT021731 ) * (1-PREM8_11) * ART1731BIS ;
RENT03_2 = max( RENT03_P + RENT03P2 , RENT031731 ) * (1-PREM8_11) * ART1731BIS ;
RENT04_2 = max( RENT04_P + RENT04P2 , RENT041731 ) * (1-PREM8_11) * ART1731BIS ;
RENT05_2 = max( RENT05_P + RENT05P2 , RENT051731 ) * (1-PREM8_11) * ART1731BIS ;
RENT06_2 = max( RENT06_P + RENT06P2 , RENT061731 ) * (1-PREM8_11) * ART1731BIS ;
RENT07_2 = max( RENT07_P + RENT07P2 , RENT071731 ) * (1-PREM8_11) * ART1731BIS ;
RENT08_2 = max( RENT08_P + RENT08P2 , RENT081731 ) * (1-PREM8_11) * ART1731BIS ;
RENT09_2 = max( RENT09_P + RENT09P2 , RENT091731 ) * (1-PREM8_11) * ART1731BIS ;
RENT10_2 = max( RENT10_P + RENT10P2 , RENT101731 ) * (1-PREM8_11) * ART1731BIS ;
RENT11_2 = max( RENT11_P + RENT11P2 , RENT111731 ) * (1-PREM8_11) * ART1731BIS ;
RENT12_2 = max( RENT12_P + RENT12P2 , RENT121731 ) * (1-PREM8_11) * ART1731BIS ;
RENT13_2 = max( RENT13_P + RENT13P2 , RENT131731 ) * (1-PREM8_11) * ART1731BIS ;
RENT14_2 = max( RENT14_P + RENT14P2 , RENT141731 ) * (1-PREM8_11) * ART1731BIS ;
RENT15_2 = max( RENT15_P + RENT15P2 , RENT151731 ) * (1-PREM8_11) * ART1731BIS ;
RENT16_2 = max( RENT16_P + RENT16P2 , RENT161731 ) * (1-PREM8_11) * ART1731BIS ;
RENT17_2 = max( RENT17_P + RENT17P2 , RENT171731 ) * (1-PREM8_11) * ART1731BIS ;
RENT18_2 = max( RENT18_P + RENT18P2 , RENT181731 ) * (1-PREM8_11) * ART1731BIS ;
RENT19_2 = max( RENT19_P + RENT19P2 , RENT191731 ) * (1-PREM8_11) * ART1731BIS ;
RENT20_2 = max( RENT20_P + RENT20P2 , RENT201731 ) * (1-PREM8_11) * ART1731BIS ;
RENT21_2 = max( RENT21_P + RENT21P2 , RENT211731 ) * (1-PREM8_11) * ART1731BIS ;
RENT22_2 = max( RENT22_P + RENT22P2 , RENT221731 ) * (1-PREM8_11) * ART1731BIS ;
RENT23_2 = max( RENT23_P + RENT23P2 , RENT231731 ) * (1-PREM8_11) * ART1731BIS ;
RENT24_2 = max( RENT24_P + RENT24P2 , RENT241731 ) * (1-PREM8_11) * ART1731BIS ;
RENT25_2 = max( RENT25_P + RENT25P2 , RENT251731 ) * (1-PREM8_11) * ART1731BIS ;
RENT26_2 = max( RENT26_P + RENT26P2 , RENT261731 ) * (1-PREM8_11) * ART1731BIS ;
RENT27_2 = max( RENT27_P + RENT27P2 , RENT271731 ) * (1-PREM8_11) * ART1731BIS ;
RENT28_2 = max( RENT28_P + RENT28P2 , RENT281731 ) * (1-PREM8_11) * ART1731BIS ;
RENT29_2 = max( RENT29_P + RENT29P2 , RENT291731 ) * (1-PREM8_11) * ART1731BIS ;
RENT30_2 = max( RENT30_P + RENT30P2 , RENT301731 ) * (1-PREM8_11) * ART1731BIS ;

regle 402150:
application : iliad , batch ;



RIDEFRI = ART1731BIS * positif(
              positif(RCOTFOR_1 - RCOTFOR_2) + positif(RREPA_1 - RREPA_2) +
              positif(RAIDE_1 - RAIDE_2) + positif(RDIFAGRI_1 - RDIFAGRI_2) +
              positif(RPRESSE_1 - RPRESSE_2) +
              positif(RFORET_1 - RFORET_2) + positif(RFIPDOM_1 - RFIPDOM_2) +
              positif(RFIPC_1 - RFIPC_2) + positif(RCINE_1 - RCINE_2) +
              positif(RRESTIMO_1 - RRESTIMO_2) + positif(RSOCREPR_1 - RSOCREPR_2) +
              positif(RRPRESCOMP_1 - RRPRESCOMP_2) + positif(RHEBE_1 - RHEBE_2) +
              positif(RSURV_1 - RSURV_2) + positif(RINNO_1 - RINNO_2) +
              positif(RSOUFIP_1 - RSOUFIP_2) + positif(RRIRENOV_1 - RRIRENOV_2) +
              positif(RLOGDOM_1 - RLOGDOM_2) +
              positif(RCOMP_1 - RCOMP_2) + positif(RRETU_1 - RRETU_2) +
              positif(RDONS_1 - RDONS_2) + positif(CRDIE_1 - CRDIE_2) + 
              positif(RDUFREPFI_1 - RDUFREPFI_2) +  positif(RDUFREPFK_1 - RDUFREPFK_2) + 
              positif(RDUFLOEKL_1 - RDUFLOEKL_2) +  positif(RDUFLOGIH_1 - RDUFLOGIH_2) +
              positif(RPIREPAI_1 - RPIREPAI_2) + positif(RPIREPBI_1 - RPIREPBI_2) +
              positif(RPIREPCI_1 - RPIREPCI_2) + positif(RPIREPDI_1 - RPIREPDI_2) +
              positif(RPIQGH_1 - RPIQGH_2) + positif(RPIQEF_1 - RPIQEF_2) +
              positif(RPIQCD_1 - RPIQCD_2) + positif(RPIQAB_1 - RPIQAB_2) +
              positif(RNOUV_1 - RNOUV_2) + positif(RPLAFREPME4_1 - RPLAFREPME4_2) +
              positif(RPENTDY_1 - RPENTDY_2) + positif(RFOR_1 - RFOR_2) +
              positif(RTOURREP_1 - RTOURREP_2) + positif(RTOUHOTR_1 - RTOUHOTR_2) +
              positif(RTOUREPA_1 - RTOUREPA_2) + positif(RCELRREDLA_1 - RCELRREDLA_2) +
              positif(RCELRREDLB_1 - RCELRREDLB_2) + positif(RCELRREDLE_1 - RCELRREDLE_2) +
              positif(RCELRREDLM_1 - RCELRREDLM_2) + positif(RCELRREDLN_1 - RCELRREDLN_2) +
              positif(RCELRREDLG_1 - RCELRREDLG_2) + positif(RCELRREDLC_1 - RCELRREDLC_2) +
              positif(RCELRREDLD_1 - RCELRREDLD_2) + positif(RCELRREDLS_1 - RCELRREDLS_2) +
              positif(RCELRREDLT_1 - RCELRREDLT_2) + positif(RCELRREDLH_1 - RCELRREDLH_2) +
              positif(RCELRREDLF_1 - RCELRREDLF_2) + positif(RCELRREDLZ_1 - RCELRREDLZ_2) +
              positif(RCELRREDLX_1 - RCELRREDLX_2) + positif(RCELRREDLI_1 - RCELRREDLI_2) +
              positif(RCELRREDMG_1 - RCELRREDMG_2) + positif(RCELRREDMH_1 - RCELRREDMH_2) +
              positif(RCELRREDLJ_1 - RCELRREDLJ_2) + positif(RCELREPHS_1 - RCELREPHS_2) +
              positif(RCELREPHR_1 - RCELREPHR_2) + positif(RCELREPHU_1 - RCELREPHU_2) +
              positif(RCELREPHT_1 - RCELREPHT_2) + positif(RCELREPHZ_1 - RCELREPHZ_2) +
              positif(RCELREPHX_1 - RCELREPHX_2) + positif(RCELREPHW_1 - RCELREPHW_2) +
              positif(RCELREPHV_1 - RCELREPHV_2) + positif(RCELREPHF_1 - RCELREPHF_2) +
              positif(RCELREPHD_1 - RCELREPHD_2) + positif(RCELREPHH_1 - RCELREPHH_2) +
              positif(RCELREPHG_1 - RCELREPHG_2) + positif(RCELREPHA_1 - RCELREPHA_2) +
              positif(RCELREPGU_1 - RCELREPGU_2) + positif(RCELREPGX_1 - RCELREPGX_2) +
              positif(RCELREPGS_1 - RCELREPGS_2) + positif(RCELREPGW_1 - RCELREPGW_2) +
              positif(RCELREPGL_1 - RCELREPGL_2) + positif(RCELREPGV_1 - RCELREPGV_2) +
              positif(RCELREPGJ_1 - RCELREPGJ_2) + positif(RCELREPYH_1 - RCELREPYH_2) +
              positif(RCELREPYL_1 - RCELREPYL_2) + positif(RCELREPYF_1 - RCELREPYF_2) +
              positif(RCELREPYK_1 - RCELREPYK_2) + positif(RCELREPYD_1 - RCELREPYD_2) +
              positif(RCELREPYJ_1 - RCELREPYJ_2) + positif(RCELREPYB_1 - RCELREPYB_2) +
              positif(RCELREPYP_1 - RCELREPYP_2) + positif(RCELREPYS_1 - RCELREPYS_2) + 
              positif(RCELREPYO_1 - RCELREPYO_2) + positif(RCELREPYR_1 - RCELREPYR_2) +
              positif(RCELREPYN_1 - RCELREPYN_2) + positif(RCELREPYQ_1 - RCELREPYQ_2) +
              positif(RCELREPYM_1 - RCELREPYM_2) + positif(RCELHM_1 - RCELHM_2) +
              positif(RCELHL_1 - RCELHL_2) + positif(RCELHNO_1 - RCELHNO_2) +
              positif(RCELHJK_1 - RCELHJK_2) + positif(RCELNQ_1 - RCELNQ_2) +
              positif(RCELNBGL_1 - RCELNBGL_2) + positif(RCELCOM_1 - RCELCOM_2) +
              positif(RCEL_1 - RCEL_2) + positif(RCELJP_1 - RCELJP_2) +
              positif(RCELJBGL_1 - RCELJBGL_2) + positif(RCELJOQR_1 - RCELJOQR_2) +
              positif(RCEL2012_1 - RCEL2012_2) + positif(RCELFD_1 - RCELFD_2) +
              positif(RCELFABC_1 - RCELFABC_2) + positif(RREDMEUB_1 - RREDMEUB_2) +
              positif(RREDREP_1 - RREDREP_2) + positif(RILMIX_1 - RILMIX_2) +
              positif(RILMIY_1 - RILMIY_2) + positif(RILMPA_1 - RILMPA_2) +
              positif(RILMPF_1 - RILMPF_2) + positif(RINVRED_1 - RINVRED_2) +
              positif(RILMIH_1 - RILMIH_2) + positif(RILMJC_1 - RILMJC_2) +
              positif(RILMPB_1 - RILMPB_2) + positif(RILMPG_1- RILMPG_2) +
              positif(RILMIZ_1 - RILMIZ_2) + positif(RILMJI_1 - RILMJI_2) +
              positif(RILMPC_1 - RILMPC_2) + positif(RILMPH_1 - RILMPH_2) +
              positif(RILMJS_1 - RILMJS_2) + positif(RILMPD_1 - RILMPD_2) +
              positif(RILMPI_1 - RILMPI_2) + positif(RILMPE_1 - RILMPE_2) +
              positif(RILMPJ_1 - RILMPJ_2) + positif(RMEUBLE_1 - RMEUBLE_2) +
              positif(RPROREP_1 - RPROREP_2) + positif(RREPNPRO_1 - RREPNPRO_2) +
              positif(RREPMEU_1 - RREPMEU_2) + positif(RILMIC_1 - RILMIC_2) +
              positif(RILMIB_1 - RILMIB_2) + positif(RILMIA_1 - RILMIA_2) +
              positif(RILMJY_1 - RILMJY_2) + positif(RILMJX_1 - RILMJX_2) +
              positif(RILMJW_1 - RILMJW_2) + positif(RILMJV_1 - RILMJV_2) +
              positif(RILMOE_1 - RILMOE_2) + positif(RILMOD_1 - RILMOD_2) +
              positif(RILMOC_1 - RILMOC_2) + positif(RILMOB_1 - RILMOB_2) +
              positif(RILMOA_1 - RILMOA_2) + positif(RILMOJ_1 - RILMOJ_2) +
              positif(RILMOI_1 - RILMOI_2) + positif(RILMOH_1 - RILMOH_2) +
              positif(RILMOG_1 - RILMOG_2) + positif(RILMOF_1 - RILMOF_2) +
              positif(RRESIMEUB_1 - RRESIMEUB_2) +
              positif(RCODIW_1 - RCODIW_2) + positif(RCODIM_1 - RCODIM_2) +
              positif(RCODIL_1 - RCODIL_2) + positif(RCODIN_1 - RCODIN_2) +
              positif(RCODIV_1 - RCODIV_2) + positif(RCODIJ_1 - RCODIJ_2) +
              positif(RCODIE_1 - RCODIE_2) + positif(RCODIF_1 - RCODIF_2) +
              positif(RCODIG_1 - RCODIG_2) + positif(RCODID_1 - RCODID_2) +
              positif(RCODJT_1 - RCODJT_2) + positif(RCODJU_1 - RCODJU_2) +
              positif(RCODOU_1 - RCODOU_2) + positif(ACODOV_1 - ACODOV_2) +
              positif(RPATNAT1_1 - RPATNAT1_2) +
              positif(RPATNAT2_1 - RPATNAT2_2) + positif(RPATNAT3_1 - RPATNAT3_2) +
              positif(RPATNAT_1 - RPATNAT_2) + positif(RDOMSOC1_1 - RDOMSOC1_2) +
              positif(RLOGSOC_1 - RLOGSOC_2) + positif(RCOLENT_1 - RCOLENT_2) +
              positif(RLOCENT_1 - RLOCENT_2) 
           ) ;             
         
