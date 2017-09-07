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

 #
                                                                
  ####   #    #    ##    #####      #     #####  #####   ######      #    
 #    #  #    #   #  #   #    #     #       #    #    #  #           #    #
 #       ######  #    #  #    #     #       #    #    #  #####       #    #
 #       #    #  ######  #####      #       #    #####   #           ######
 #    #  #    #  #    #  #          #       #    #   #   #                #
  ####   #    #  #    #  #          #       #    #    #  ######           #
 #
 #
 #
 #
 #
 #
 #                      CALCUL DE L'IMPOT BRUT
 #
 #
 #
 #
 #
 #
 #
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
TX_RED0 =  inf ( (100 - ((TX_RABGUY * V_EAG) + (TX_RABDOM * V_EAD))
	     ) * TX16  / 100 * positif(V_EAD + V_EAG)
	   );
TX_RED1 =  inf ( (100 - ((TX_RABGUY * V_EAG) + (TX_RABDOM * V_EAD))
	     ) * TX19 / 100 * positif(V_EAD + V_EAG)
	   );
DOMAVTO = arr(BN1 + SPEPV + BI12F + BA1) * ((TX16 - TX_RED0)/100) * positif(V_EAD)
          + arr(BN1 + SPEPV + BI12F + BA1) * ((TX16 - TX_RED0)/100) * positif(V_EAG);
DOMABDB = max(PLAF_RABDOM - ABADO , 0) * positif(V_EAD)
          + max(PLAF_RABGUY - ABAGU , 0) * positif(V_EAG);
DOMDOM = max(DOMAVTO - DOMABDB , 0) * positif(V_EAD + V_EAG);

ITP = arr((BPTP2 * TX225/100) 
       + (BPTPVT * TX19/100) 
       + (BPTP4 * TX30/100) 
       + ((BPTPD + BPTPG) * TX_RED0/100) 
       + (BPTP3 * TX16/100) 
       + (BPTP40 * TX41/100)
       + DOMDOM * positif(V_EAD + V_EAG)
       + (BPTP18 * TX18/100)
       + (BTP3G * TX24/100)
       + (BTP3N * TX24/100)
       + (BPTP5 * TX24/100)
       + (BPTPSJ * TX19/100)
       + (BPTPSA * TX19/100)
       + (BPTPSB * TX24/100)
       + (BPTPSC * TX19/100)
       + (BPTPWG * TX19/100)
	  )
       * (1-positif(IPVLOC)) * (1 - positif(present(TAX1649)+present(RE168))); 
regle 40412:
application : iliad , batch  ;
PTP = BTP3A + BTP3N + BTP3G+ BPTP2 +BPTPVT+BPTP18 +BPTP4+BPTPSK+BPTP40
	 + BPTP5+BPTPWG +BPTPSA +BPTPSB +BPTPSC;
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
BTPSK = BPVSK * (1 - positif( IPVLOC ));
BPTPSK = BTPSK * (1-positif(present(TAX1649)+present(RE168))) ;

BTP40 = (BPV40V + BPV40C) * (1 - positif( IPVLOC )) ;
BPTP40 = BTP40 * (1-positif(present(TAX1649)+present(RE168))) ;

BTP5 = PVIMPOS * (1 - positif( IPVLOC ));
BPTP5 = BTP5 * (1-positif(present(TAX1649)+present(RE168))) ;
BPTPWG = PVSURSIWG * (1 - positif( IPVLOC ))* (1-positif(present(TAX1649)+present(RE168)));
BTPSJ = BPVSJ * (1 - positif( IPVLOC ));
BPTPSJ = BTPSJ * (1-positif(present(TAX1649)+present(RE168))) ;
BTPSA = PVDIRTAX * (1 - positif( IPVLOC ));
BPTPSA = BTPSA * (1-positif(present(TAX1649)+present(RE168))) ;
BTPSB = PVTAXSB * (1 - positif( IPVLOC ));
BPTPSB = BTPSB * (1-positif(present(TAX1649)+present(RE168))) ;
BTPSC = PVTAXSC * (1 - positif( IPVLOC ));
BPTPSC = BTPSC * (1-positif(present(TAX1649)+present(RE168))) ;
BPTP19 = (BPVSJ + PVDIRTAX + PVTAXSC + GAINPEA + PVSURSIWG) * (1 - positif( IPVLOC )) * (1 - positif(present(TAX1649) + present(RE168))) ;

BPTP24 = (BTP3G + BTPSB + BTP3N + BTP5*(1-positif(null(5-V_REGCO)+null(6-V_REGCO)))) * (1 - positif(present(TAX1649) + present(RE168))) ;

BPTPDIV = ((PVTAXSB + PVTAXSC) * (1-positif(IPVLOC)) + BTP5) * (1-positif(present(TAX1649)+present(RE168))) ;

regle 4042:
application : iliad , batch  ;


REI = IPREP+IPPRICORSE;

regle 40421:
application : iliad , batch  ;


PPERSATOT = RSAFOYER + RSAPAC1 + RSAPAC2 ;

PPERSA = min(PPETOT,PPERSATOT) * (1 - V_CNR) ;

PPEFINAL = PPETOT - PPERSA ;

regle 405:
application : bareme , iliad , batch  ;


IAD11 = ( max(0,IDOM11-DEC11-RED) *(1-positif(V_CR2+IPVLOC))
        + positif(V_CR2+IPVLOC) *max(0 , IDOM11 - RED) )
                                * (1-positif(RE168+TAX1649))
        + positif(RE168+TAX1649) * IDOM16;

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

regle 4066:
application : iliad   , batch ;
ART1731BIS = positif ( null (CODE_2042 - 3)
	                 +null (CODE_2042 - 4)
	                 +null (CODE_2042 - 5)
	                 +null (CODE_2042 - 6)
	                 +null ((CODE_2042 + CMAJ)- 8)
	                 +null ((CODE_2042 + CMAJ) - 11)
	                 +null (CODE_2042 - 31)
	                 +null (CODE_2042 - 55));
      
regle 407:
application : iliad   , batch ;
      
RED =  RCOTFOR + RSURV + RCOMP + RHEBE + RREPA + RDIFAGRI + RDONS
       + RCELTOT
       + RRESTIMO  
       + RFIPC + RFIPDOM + RAIDE + RNOUV 
       + RTOURNEUF + RTOURTRA + RTOURREP 
       + RTOUREPA + RTOURES + RTOUHOTR  
       + RLOGDOM + RLOGSOC + RDOMSOC1 + RLOCENT + RCOLENT
       + RRETU + RINNO + RRPRESCOMP + RFOR 
       + RSOUFIP + RRIRENOV + RSOCREPR + RRESIMEUB + RRESINEUV + RRESIVIEU + RLOCIDEFG
       + RREDMEUB + RREDREP + RILMIX + RINVRED + RILMIH + RILMIZ + RMEUBLE 
       + RPROREP + RREPNPRO + RREPMEU + RILMIC + RILMIB + RILMIA 
       + RIDOMPROE3 + RIDOMPROE4 
       + RPATNAT2 + RPATNAT1 + RPATNAT
       + RFORET + RCREAT + RCINE  ;

REDTL = ASURV + ACOMP ;

CIMPTL = ATEC + ADEVDUR + TOTBGE ;

regle 4070:
application : bareme ;
RED = V_9UY;
regle 4025:
application : iliad , batch  ;

PLAFDOMPRO1 = max(0 , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU
		          -RDONS-RNOUV-RLOGSOC-RDOMSOC1-RCELTOT-RLOCNPRO-RPATNAT2-RPATNAT1-RPATNAT) ;


RIDOMPROE4 = min(REPINVDOMPRO2 , PLAFDOMPRO1) * (1 - V_CNR) * (1 - ART1731BIS) ;
              
REPDOMENTR4 = positif(REPINVDOMPRO2 - PLAFDOMPRO1) * (REPINVDOMPRO2 - PLAFDOMPRO1)* (1 - V_CNR) ;


PLAFDOMPRO3 = positif(PLAFDOMPRO1 - REPINVDOMPRO2) * (PLAFDOMPRO1 - REPINVDOMPRO2) * (1 - V_CNR) ; 

RIDOMPROE3 = min(REPINVDOMPRO3 , PLAFDOMPRO3) * (1 - V_CNR) * (1 - ART1731BIS) ;
                  
REPOMENTR3 = positif(REPINVDOMPRO3 - PLAFDOMPRO3) * (REPINVDOMPRO3 - PLAFDOMPRO3) * (1 - V_CNR) ;


RIDOMPROTOT = RIDOMPROE3 + RIDOMPROE4 ;


RINVEST = RIDOMPROE3  + RIDOMPROE4 ;

RIDOMPRO = REPINVDOMPRO2 + REPINVDOMPRO3 ;

DIDOMPRO = RIDOMPRO * (1 - V_CNR) * (1 - ART1731BIS) ;

regle 40749:
application : iliad , batch  ;

DFORET = FORET ;

AFORET = max(min(DFORET,LIM_FORET),0) * (1-V_CNR) * (1 - ART1731BIS) ;

RAFORET = arr(AFORET*TX_FORET/100) * (1-V_CNR) ;

RFORET =  max( min( RAFORET , IDOM11-DEC11-RCOTFOR-RREPA-RFIPDOM-RAIDE-RDIFAGRI) , 0 ) ;

regle 4075:
application : iliad , batch ;

DFIPC = FIPCORSE ;

AFIPC = max( min(DFIPC , LIM_FIPCORSE * (1 + BOOL_0AM)) , 0) * (1 - V_CNR) * (1 - ART1731BIS) ;

RFIPCORSE = arr(AFIPC * TX_FIPCORSE/100) * (1 - V_CNR) ;

RFIPC = max( min( RFIPCORSE , IDOM11-DEC11-RCOTFOR-RREPA-RFIPDOM-RAIDE-RDIFAGRI-RFORET) , 0) ;

regle 40751:
application : iliad , batch ;

DFIPDOM = FIPDOMCOM ;

AFIPDOM = max( min(DFIPDOM , LIMFIPDOM * (1 + BOOL_0AM)) , 0) * (1 - V_CNR) * (1 - ART1731BIS) ;

RFIPDOMCOM = arr(AFIPDOM * TXFIPDOM/100) * (1 - V_CNR) ;

RFIPDOM = max( min( RFIPDOMCOM , IDOM11-DEC11-RCOTFOR-RREPA) , 0) ;

regle 4076:
application : iliad , batch  ;
BSURV = min( RDRESU , PLAF_RSURV + PLAF_COMPSURV * (EAC + V_0DN) + PLAF_COMPSURVQAR * (V_0CH + V_0DP) );
RRS = arr( BSURV * TX_REDSURV / 100 ) * (1 - V_CNR);
DSURV = RDRESU;
ASURV = BSURV * (1-V_CNR) * ( 1 - ART1731BIS);
RSURV = max( min( RRS , IDOM11-DEC11-RCOTFOR-RREPA-RFIPDOM-RAIDE-RDIFAGRI-RFORET-RFIPC
			-RCINE-RRESTIMO-RSOCREPR-RRPRESCOMP-RHEBE ) , 0 ) * ( 1 - ART1731BIS);

regle 4100:
application : iliad , batch ;

RRCN = arr(  min( CINE1 , min( max(SOFIRNG,RNG) * TX_CINE3/100 , PLAF_CINE )) * TX_CINE1/100
        + min( CINE2 , max( min( max(SOFIRNG,RNG) * TX_CINE3/100 , PLAF_CINE ) - CINE1 , 0)) * TX_CINE2/100 
       ) * (1 - V_CNR) ;

DCINE = CINE1 + CINE2 ;

ACINE = max(0,min( CINE1 + CINE2 , min( arr(SOFIRNG * TX_CINE3/100) , PLAF_CINE ))) * (1 - V_CNR) * (1 - ART1731BIS) ;

RCINE = max( min( RRCN , IDOM11-DEC11-RCOTFOR-RREPA-RFIPDOM-RAIDE-RDIFAGRI-RFORET-RFIPC) , 0 ) * (1 - ART1731BIS) ;
regle 4176:
application : iliad , batch  ;
BSOUFIP = min( FFIP , LIM_SOUFIP * (1 + BOOL_0AM)) * (1 - ART1731BIS);
RFIP = arr( BSOUFIP * TX_REDFIP / 100 ) * (1 - V_CNR);
DSOUFIP = FFIP;
ASOUFIP = BSOUFIP * (1-V_CNR) ;
RSOUFIP = max( min( RFIP , IDOM11-DEC11-RCOTFOR-RREPA-RFIPDOM-RAIDE-RDIFAGRI-RFORET-RFIPC
			   -RCINE-RRESTIMO-RSOCREPR-RRPRESCOMP-RHEBE-RSURV-RINNO) , 0 );

regle 4200:
application : iliad , batch  ;

BRENOV = min(RIRENOV,PLAF_RENOV) * (1 - ART1731BIS) ;
RENOV = arr( BRENOV * TX_RENOV / 100 ) * (1 - V_CNR) ;

DRIRENOV = RIRENOV ;
ARIRENOV = BRENOV * (1 - V_CNR) ;
RRIRENOV = max( min( RENOV , IDOM11-DEC11-RCOTFOR-RREPA-RFIPDOM-RAIDE-RDIFAGRI-RFORET-RFIPC-RCINE
			     -RRESTIMO-RSOCREPR-RRPRESCOMP-RHEBE-RSURV-RINNO-RSOUFIP) , 0 );

regle 40771:
application : iliad , batch  ;
RFC = min(RDCOM,PLAF_FRCOMPTA * max(1,NBACT)) * present(RDCOM)*(1-V_CNR) * (1-ART1731BIS);
NCOMP = max(1,NBACT)* present(RDCOM) * (1-V_CNR);
DCOMP = RDCOM;
ACOMP = RFC;
regle 10040771:
application :  iliad , batch  ;
RCOMP = max(min( RFC , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCREAT) , 0) ;

regle 4078:
application : iliad , batch  ;


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
ACELRREDLA = CELRREDLA * ((V_REGCO+0) dans (1,3,5,6)) * (1 - ART1731BIS);

DCELRREDLB = CELRREDLB;
ACELRREDLB = CELRREDLB * ((V_REGCO+0) dans (1,3,5,6)) * (1 - ART1731BIS); 

DCELRREDLE = CELRREDLE;
ACELRREDLE = CELRREDLE * ((V_REGCO+0) dans (1,3,5,6)) * (1 - ART1731BIS);

DCELRREDLC = CELRREDLC;
ACELRREDLC = CELRREDLC * ((V_REGCO+0) dans (1,3,5,6)) * (1 - ART1731BIS);

DCELRREDLD = CELRREDLD;
ACELRREDLD = CELRREDLD * ((V_REGCO+0) dans (1,3,5,6)) * (1 - ART1731BIS);

DCELRREDLF = CELRREDLF;
ACELRREDLF = CELRREDLF * ((V_REGCO+0) dans (1,3,5,6)) * (1 - ART1731BIS);

DCELREPHS = CELREPHS; 
ACELREPHS = DCELREPHS * ((V_REGCO+0) dans (1,3,5,6)) * (1 - ART1731BIS); 


DCELREPHR = CELREPHR ;    
ACELREPHR = DCELREPHR * ((V_REGCO+0) dans (1,3,5,6)) * (1 - ART1731BIS);


DCELREPHU = CELREPHU; 
ACELREPHU = DCELREPHU * ((V_REGCO+0) dans (1,3,5,6)) * (1 - ART1731BIS); 


DCELREPHT = CELREPHT; 
ACELREPHT = DCELREPHT * ((V_REGCO+0) dans (1,3,5,6)) * (1 - ART1731BIS); 


DCELREPHZ = CELREPHZ; 
ACELREPHZ = DCELREPHZ * ((V_REGCO+0) dans (1,3,5,6)) * (1 - ART1731BIS); 


DCELREPHX = CELREPHX; 
ACELREPHX = DCELREPHX * ((V_REGCO+0) dans (1,3,5,6)) * (1 - ART1731BIS); 


DCELREPHW = CELREPHW; 
ACELREPHW = DCELREPHW * ((V_REGCO+0) dans (1,3,5,6)) * (1 - ART1731BIS); 


DCELREPHV = CELREPHV; 
ACELREPHV = DCELREPHV * ((V_REGCO+0) dans (1,3,5,6)) * (1 - ART1731BIS); 


DCELREPHF = CELREPHF; 
ACELREPHF = DCELREPHF * ((V_REGCO+0) dans (1,3,5,6)) * (1 - ART1731BIS); 


DCELREPHE = CELREPHE ;    
ACELREPHE = DCELREPHE * ((V_REGCO+0) dans (1,3,5,6)) * (1 - ART1731BIS);


DCELREPHD = CELREPHD; 
ACELREPHD = DCELREPHD * ((V_REGCO+0) dans (1,3,5,6)) * (1 - ART1731BIS); 


DCELREPHH = CELREPHH; 
ACELREPHH = DCELREPHH * ((V_REGCO+0) dans (1,3,5,6)) * (1 - ART1731BIS); 


DCELREPHG = CELREPHG; 
ACELREPHG = DCELREPHG * ((V_REGCO+0) dans (1,3,5,6)) * (1 - ART1731BIS); 


DCELREPHB = CELREPHB; 
ACELREPHB = DCELREPHB * ((V_REGCO+0) dans (1,3,5,6)) * (1 - ART1731BIS); 


DCELREPHA = CELREPHA; 
ACELREPHA = DCELREPHA * ((V_REGCO+0) dans (1,3,5,6)) * (1 - ART1731BIS); 


DCELHM = CELLIERHM ; 
ACELHM = (positif_ou_nul( CELLIERHM) * BCEL_HM) * ((V_REGCO+0) dans (1,3,5,6)) * (1 - ART1731BIS); 


DCELHL = CELLIERHL ;    
ACELHL = (positif_ou_nul( CELLIERHL) * BCEL_HL) * ((V_REGCO+0) dans (1,3,5,6)) * (1 - ART1731BIS); 


DCELHNO = CELLIERHN + CELLIERHO ;
ACELHNO = (positif_ou_nul( CELLIERHN + CELLIERHO ) * BCEL_HNO) * ((V_REGCO+0) dans (1,3,5,6)) * (1 - ART1731BIS);


DCELHJK = CELLIERHJ + CELLIERHK ;
ACELHJK = (positif_ou_nul( CELLIERHJ + CELLIERHK ) * BCEL_HJK) * ((V_REGCO+0) dans (1,3,5,6)) * (1 - ART1731BIS);


DCELNQ = CELLIERNQ;
ACELNQ = (positif_ou_nul( CELLIERNQ) * BCEL_NQ) * ((V_REGCO+0) dans (1,3,5,6)) * (1 - ART1731BIS);

DCELNBGL =   CELLIERNB + CELLIERNG + CELLIERNL;
ACELNBGL = (positif_ou_nul( CELLIERNB + CELLIERNG + CELLIERNL ) * BCEL_NBGL) * ((V_REGCO+0) dans (1,3,5,6))
									     * (1 - ART1731BIS);

DCELCOM =   CELLIERNP + CELLIERNR + CELLIERNS + CELLIERNT;
ACELCOM = (positif_ou_nul(CELLIERNP + CELLIERNR + CELLIERNS + CELLIERNT) * BCELCOM2011) * ((V_REGCO+0) dans (1,3,5,6))
											* (1 - ART1731BIS);

CELSOMN = CELLIERNA+CELLIERNC+CELLIERND+CELLIERNE+CELLIERNF+CELLIERNH
	 +CELLIERNI+CELLIERNJ+CELLIERNK+CELLIERNM+CELLIERNN+CELLIERNO;  

DCEL = CELSOMN ; 

ACEL = (positif_ou_nul( CELSOMN ) * BCEL_2011) * ((V_REGCO+0) dans (1,3,5,6)) * (1 - ART1731BIS);

DCELJP = CELLIERJP;
ACELJP = (positif_ou_nul( CELLIERJP) * BCEL_JP) * ((V_REGCO+0) dans (1,3,5,6)) * (1 - ART1731BIS);

DCELJBGL =   CELLIERJB + CELLIERJG + CELLIERJL;
ACELJBGL = (positif_ou_nul( CELLIERJB + CELLIERJG + CELLIERJL ) * BCEL_JBGL) * ((V_REGCO+0) dans (1,3,5,6))
									     * (1 - ART1731BIS);

DCELJOQR =   CELLIERJO + CELLIERJQ + CELLIERJR;
ACELJOQR = (positif_ou_nul(CELLIERJO + CELLIERJQ + CELLIERJR) * BCEL_JOQR) * ((V_REGCO+0) dans (1,3,5,6))
									   * (1 - ART1731BIS);

CELSOMJ = CELLIERJA + CELLIERJD + CELLIERJE + CELLIERJF + CELLIERJH 
	  + CELLIERJJ + CELLIERJK + CELLIERJM + CELLIERJN;
 	   

DCEL2012 = CELSOMJ ; 

ACEL2012 = (positif_ou_nul( CELSOMJ ) * BCEL_2012) * ((V_REGCO+0) dans (1,3,5,6))
						   * (1 - ART1731BIS);


RCEL_2011 = (  positif(CELLIERNA + CELLIERNE) * arr (ACEL * (TX22/100))
            + positif(CELLIERNC + CELLIERND + CELLIERNH) * arr (ACEL * (TX25/100))
            + positif(CELLIERNF + CELLIERNJ) * arr (ACEL * (TX13/100))
            + positif(CELLIERNI) * arr (ACEL * (TX15/100))
	    + positif(CELLIERNM + CELLIERNN) * arr (ACEL * (TX40/100))
	    + positif(CELLIERNK + CELLIERNO) * arr (ACEL * (TX36/100))
            ) * ((V_REGCO+0) dans (1,3,5,6));

RCEL_2012 = (  positif(CELLIERJA + CELLIERJE + CELLIERJH) * arr (ACEL2012 * (TX13/100))
            + positif(CELLIERJD) * arr (ACEL2012 * (TX22/100))
            + positif(CELLIERJF + CELLIERJJ) * arr (ACEL2012 * (TX6/100))
            + positif(CELLIERJK + CELLIERJN) * arr (ACEL2012 * (TX24/100))
	    + positif(CELLIERJM) * arr (ACEL2012 * (TX36/100))
            ) * ((V_REGCO+0) dans (1,3,5,6));

RCEL_COM = (  positif(CELLIERNP + CELLIERNT) * arr (ACELCOM * (TX36/100))
               + positif(CELLIERNR + CELLIERNS) * arr (ACELCOM * (TX40/100)) 
              ) * ((V_REGCO+0) dans (1,3,5,6));

RCEL_JOQR = (  positif(CELLIERJQ) * arr (ACELJOQR * (TX36/100))
               + positif(CELLIERJO + CELLIERJR) * arr (ACELJOQR * (TX24/100)) 
              ) * ((V_REGCO+0) dans (1,3,5,6));

RCEL_NBGL = (  positif(CELLIERNB) * arr(ACELNBGL * (TX25/100))
	       + positif(CELLIERNG) * arr(ACELNBGL * (TX15/100))
	       + positif(CELLIERNL) * arr(ACELNBGL * (TX40/100))
              ) * ((V_REGCO+0) dans (1,3,5,6));

RCEL_JBGL = (  positif(CELLIERJB) * arr(ACELJBGL * (TX22/100))
	       + positif(CELLIERJG) * arr(ACELJBGL * (TX13/100))
	       + positif(CELLIERJL) * arr(ACELJBGL * (TX36/100))
              ) * ((V_REGCO+0) dans (1,3,5,6));

RCEL_NQ = ( positif(CELLIERNQ) * arr(ACELNQ * (TX40/100)) ) * ((V_REGCO+0) dans (1,3,5,6));

RCEL_JP = ( positif(CELLIERJP) * arr(ACELJP * (TX36/100)) ) * ((V_REGCO+0) dans (1,3,5,6));


RCEL_HNO = (  positif(CELLIERHN) * arr(ACELHNO * (TX25/100))
	       + positif(CELLIERHO) * arr(ACELHNO * (TX40/100))
              ) * ((V_REGCO+0) dans (1,3,5,6));

RCEL_HJK = (  positif(CELLIERHJ) * arr(ACELHJK * (TX25/100))
	      + positif(CELLIERHK) * arr(ACELHJK * (TX40/100))
             ) * ((V_REGCO+0) dans (1,3,5,6));


RCELDOM = (positif(CELLIERHK + CELLIERHO) * arr (ACELDO * (TX40/100))) 
             * ((V_REGCO+0) dans (1,3,5,6));                           

RCELM = (positif( CELLIERHJ + CELLIERHN ) * arr (ACELMET * (TX25/100)))
             * ((V_REGCO+0) dans (1,3,5,6));                           


RCEL_HM = positif(CELLIERHM) * arr (ACELHM * (TX40/100)) 
             * ((V_REGCO+0) dans (1,3,5,6));                           

RCEL_HL = positif( CELLIERHL ) * arr (ACELHL * (TX25/100))
             * ((V_REGCO+0) dans (1,3,5,6));                           
RCELREP_HS = positif(CELREPHS) * arr (ACELREPHS * (TX40/100)) * ((V_REGCO+0) dans (1,3,5,6));

RCELREP_HR = positif( CELREPHR ) * arr (ACELREPHR * (TX25/100)) * ((V_REGCO+0) dans (1,3,5,6));

RCELREP_HU = positif( CELREPHU ) * arr (ACELREPHU * (TX40/100)) * ((V_REGCO+0) dans (1,3,5,6));

RCELREP_HT = positif( CELREPHT ) * arr (ACELREPHT * (TX25/100)) * ((V_REGCO+0) dans (1,3,5,6));

RCELREP_HZ = positif( CELREPHZ ) * arr (ACELREPHZ * (TX40/100)) * ((V_REGCO+0) dans (1,3,5,6));

RCELREP_HX = positif( CELREPHX ) * arr (ACELREPHX * (TX25/100)) * ((V_REGCO+0) dans (1,3,5,6));

RCELREP_HW = positif( CELREPHW ) * arr (ACELREPHW * (TX40/100)) * ((V_REGCO+0) dans (1,3,5,6));

RCELREP_HV = positif( CELREPHV ) * arr (ACELREPHV * (TX25/100)) * ((V_REGCO+0) dans (1,3,5,6));

regle 2004078:
application : iliad , batch  ;

REDUCAVTCEL =RCOTFOR+RREPA+RRESTIMO+RFIPC+RFIPDOM+RAIDE+RDIFAGRI+RFORET
	     +RCINE+RSOCREPR+RRPRESCOMP+RINNO+RSOUFIP+RRIRENOV+RFOR+RHEBE+
	     RSURV+RLOGDOM+RTOURNEUF+RTOURTRA+RTOURES+RTOURREP+RTOUHOTR+RTOUREPA+
	     RCOMP+RCREAT+RRETU+RDONS+RNOUV;

RCELRREDLA = (max( min( ACELRREDLA , IDOM11-DEC11 - REDUCAVTCEL ) , 0 ))
	    * ((V_REGCO+0) dans (1,3,5,6));

RCELRREDLB = (max( min( ACELRREDLB , IDOM11-DEC11 - REDUCAVTCEL
	      - RCELRREDLA ) , 0 ))
	    * ((V_REGCO+0) dans (1,3,5,6));

RCELRREDLE = (max( min( ACELRREDLE , IDOM11-DEC11 - REDUCAVTCEL
	      - RCELRREDLA-RCELRREDLB ) , 0 ))
	    * ((V_REGCO+0) dans (1,3,5,6));

RCELRREDLC = (max( min( ACELRREDLC , IDOM11-DEC11 - REDUCAVTCEL
	      - RCELRREDLA-RCELRREDLB-RCELRREDLE ) , 0 ))
	    * ((V_REGCO+0) dans (1,3,5,6));

RCELRREDLD = (max( min( ACELRREDLD , IDOM11-DEC11 - REDUCAVTCEL
	      - RCELRREDLA-RCELRREDLB-RCELRREDLE-RCELRREDLC ) , 0 ))
	    * ((V_REGCO+0) dans (1,3,5,6));

RCELRREDLF = (max( min( ACELRREDLF , IDOM11-DEC11 - REDUCAVTCEL
	      - RCELRREDLA-RCELRREDLB-RCELRREDLE-RCELRREDLC-RCELRREDLD ) , 0 ))
	    * ((V_REGCO+0) dans (1,3,5,6));

RCELREPHS = (max( min( RCELREP_HS , IDOM11-DEC11 - REDUCAVTCEL
              - somme (i=A,B,E,C,D,F : RCELRREDLi) ) , 0))
	    * ((V_REGCO+0) dans (1,3,5,6));

RCELREPHR = (max( min( RCELREP_HR , IDOM11-DEC11 - REDUCAVTCEL
              - somme (i=A,B,E,C,D,F : RCELRREDLi) 
	      - RCELREPHS ) , 0))
	    * ((V_REGCO+0) dans (1,3,5,6));

RCELREPHU = (max( min( RCELREP_HU, IDOM11-DEC11 - REDUCAVTCEL
              - somme (i=A,B,E,C,D,F : RCELRREDLi) 
	      - RCELREPHS-RCELREPHR ) , 0))
            * ((V_REGCO+0) dans (1,3,5,6));

RCELREPHT = (max( min( RCELREP_HT, IDOM11-DEC11 - REDUCAVTCEL
              - somme (i=A,B,E,C,D,F : RCELRREDLi) 
	      - RCELREPHS-RCELREPHR-RCELREPHU ) , 0))
            * ((V_REGCO+0) dans (1,3,5,6));

RCELREPHZ = (max( min( RCELREP_HZ, IDOM11-DEC11 - REDUCAVTCEL
              - somme (i=A,B,E,C,D,F : RCELRREDLi) 
	      - RCELREPHS-RCELREPHR-RCELREPHU-RCELREPHT ) , 0))
            * ((V_REGCO+0) dans (1,3,5,6));

RCELREPHX = (max( min( RCELREP_HX, IDOM11-DEC11 - REDUCAVTCEL
              - somme (i=A,B,E,C,D,F : RCELRREDLi) 
	      - RCELREPHS-RCELREPHR-RCELREPHU-RCELREPHT-RCELREPHZ ) , 0))
            * ((V_REGCO+0) dans (1,3,5,6));

RCELREPHW = (max( min( RCELREP_HW, IDOM11-DEC11 - REDUCAVTCEL
              - somme (i=A,B,E,C,D,F : RCELRREDLi) 
	      - RCELREPHS-RCELREPHR-RCELREPHU-RCELREPHT-RCELREPHZ-RCELREPHX ) , 0))
            * ((V_REGCO+0) dans (1,3,5,6));

RCELREPHV = (max( min( RCELREP_HV, IDOM11-DEC11 - REDUCAVTCEL
              - somme (i=A,B,E,C,D,F : RCELRREDLi) 
	      - RCELREPHS-RCELREPHR-RCELREPHU-RCELREPHT-RCELREPHZ-RCELREPHX-RCELREPHW ) , 0))
            * ((V_REGCO+0) dans (1,3,5,6));

RCELREPHF = (max( min( ACELREPHF , IDOM11-DEC11 - REDUCAVTCEL
              - somme (i=A,B,E,C,D,F : RCELRREDLi) 
	      -somme (i=S,R,U,T,Z,X,W,V : RCELREPHi) ) , 0))
	    * ((V_REGCO+0) dans (1,3,5,6));

RCELREPHE = (max( min( ACELREPHE , IDOM11-DEC11 - REDUCAVTCEL
              - somme (i=A,B,E,C,D,F : RCELRREDLi) 
	      -somme (i=S,R,U,T,Z,X,W,V,F : RCELREPHi) ) , 0))
	    * ((V_REGCO+0) dans (1,3,5,6));

RCELREPHD = (max( min( ACELREPHD , IDOM11-DEC11 - REDUCAVTCEL
              - somme (i=A,B,E,C,D,F : RCELRREDLi) 
	      -somme (i=S,R,U,T,Z,X,W,V,F,E : RCELREPHi) ) , 0))
	    * ((V_REGCO+0) dans (1,3,5,6));

RCELREPHH = (max( min( ACELREPHH , IDOM11-DEC11 - REDUCAVTCEL
              - somme (i=A,B,E,C,D,F : RCELRREDLi) 
	      -somme (i=S,R,U,T,Z,X,W,V,F,E,D : RCELREPHi) ) , 0))
	    * ((V_REGCO+0) dans (1,3,5,6));

RCELREPHG = (max( min( ACELREPHG , IDOM11-DEC11 - REDUCAVTCEL
              - somme (i=A,B,E,C,D,F : RCELRREDLi) 
	      -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H : RCELREPHi) ) , 0))
	    * ((V_REGCO+0) dans (1,3,5,6));

RCELREPHB = (max( min( ACELREPHB , IDOM11-DEC11 - REDUCAVTCEL
              - somme (i=A,B,E,C,D,F : RCELRREDLi) 
	      -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G : RCELREPHi) ) , 0))
	    * ((V_REGCO+0) dans (1,3,5,6));

RCELREPHA = (max( min( ACELREPHA , IDOM11-DEC11 - REDUCAVTCEL
              - somme (i=A,B,E,C,D,F : RCELRREDLi) 
	      -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B : RCELREPHi) ) , 0))
	    * ((V_REGCO+0) dans (1,3,5,6));


RCELHM = (max( min( RCEL_HM, IDOM11-DEC11 - REDUCAVTCEL
              - somme (i=A,B,E,C,D,F : RCELRREDLi) 
	      -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : RCELREPHi) ) , 0))
	  * ((V_REGCO+0) dans (1,3,5,6));

RCELHL = (max( min( RCEL_HL , IDOM11-DEC11 - REDUCAVTCEL
              - somme (i=A,B,E,C,D,F : RCELRREDLi) 
	      -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : RCELREPHi) 
	      -RCELHM) , 0 ))
	   * ((V_REGCO+0) dans (1,3,5,6));

RCELHNO = (max( min( RCEL_HNO, IDOM11-DEC11 - REDUCAVTCEL
              - somme (i=A,B,E,C,D,F : RCELRREDLi) 
	      -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : RCELREPHi) 
	      -RCELHM-RCELHL) , 0 ))
	   * ((V_REGCO+0) dans (1,3,5,6));

RCELHJK = (max( min( RCEL_HJK , IDOM11-DEC11 - REDUCAVTCEL
              - somme (i=A,B,E,C,D,F : RCELRREDLi) 
	      -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : RCELREPHi) 
	      -RCELHM-RCELHL-RCELHNO) , 0 ))
	   * ((V_REGCO+0) dans (1,3,5,6));

RCELNQ = (max( min(RCEL_NQ, IDOM11-DEC11 - REDUCAVTCEL
              - somme (i=A,B,E,C,D,F : RCELRREDLi) 
	      -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : RCELREPHi) 
	      -RCELHM-RCELHL-RCELHNO-RCELHJK ) , 0 ))
	 * ((V_REGCO+0) dans (1,3,5,6));

RCELNBGL = (max( min(RCEL_NBGL, IDOM11-DEC11 - REDUCAVTCEL
              - somme (i=A,B,E,C,D,F : RCELRREDLi) 
	      -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : RCELREPHi) 
	      -RCELHM-RCELHL-RCELHNO-RCELHJK-RCELNQ ) , 0 ))
	   * ((V_REGCO+0) dans (1,3,5,6));

RCELCOM = (max( min(RCEL_COM, IDOM11-DEC11 - REDUCAVTCEL
              - somme (i=A,B,E,C,D,F : RCELRREDLi) 
	      -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : RCELREPHi) 
	      -RCELHM-RCELHL-RCELHNO-RCELHJK-RCELNQ-RCELNBGL ) , 0 ))
	  * ((V_REGCO+0) dans (1,3,5,6));

RCEL = (max( min(RCEL_2011, IDOM11-DEC11 - REDUCAVTCEL
              - somme (i=A,B,E,C,D,F : RCELRREDLi) 
	      -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : RCELREPHi) 
	      -RCELHM-RCELHL-RCELHNO-RCELHJK-RCELNQ-RCELNBGL-RCELCOM ) , 0 ))
	     * ((V_REGCO+0) dans (1,3,5,6));

RCELJP = (max( min(RCEL_JP, IDOM11-DEC11 - REDUCAVTCEL
              - somme (i=A,B,E,C,D,F : RCELRREDLi) 
	      -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : RCELREPHi) 
	      -RCELHM-RCELHL-RCELHNO-RCELHJK-RCELNQ-RCELNBGL-RCELCOM-RCEL ) , 0 ))
	 * ((V_REGCO+0) dans (1,3,5,6));

RCELJBGL = (max( min(RCEL_JBGL, IDOM11-DEC11 - REDUCAVTCEL
              - somme (i=A,B,E,C,D,F : RCELRREDLi) 
	      -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : RCELREPHi) 
	      -RCELHM-RCELHL-RCELHNO-RCELHJK-RCELNQ-RCELNBGL-RCELCOM-RCEL-RCELJP ) , 0 ))
	   * ((V_REGCO+0) dans (1,3,5,6));

RCELJOQR = (max( min(RCEL_JOQR, IDOM11-DEC11 - REDUCAVTCEL
              - somme (i=A,B,E,C,D,F : RCELRREDLi) 
	      -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : RCELREPHi) 
	      -RCELHM-RCELHL-RCELHNO-RCELHJK-RCELNQ-RCELNBGL-RCELCOM-RCEL-RCELJP
	      -RCELJBGL) , 0 ))
	  * ((V_REGCO+0) dans (1,3,5,6));

RCEL2012 = (max( min(RCEL_2012, IDOM11-DEC11 - REDUCAVTCEL
              - somme (i=A,B,E,C,D,F : RCELRREDLi) 
	      -somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : RCELREPHi) 
	      -RCELHM-RCELHL-RCELHNO-RCELHJK-RCELNQ-RCELNBGL-RCELCOM-RCEL-RCELJP
	      -RCELJBGL-RCELJOQR) , 0 ))
	     * ((V_REGCO+0) dans (1,3,5,6));

RCELTOT = somme(i=A,B,E,C,D,F :  RCELRREDLi)
	  + somme (i=S,R,U,T,Z,X,W,V,F,E,D,H,G,B,A : RCELREPHi)  
	  + RCELHM + RCELHL + RCELHNO + RCELHJK + RCELNQ + RCELNBGL + RCELCOM
	  + RCEL + RCELJP + RCELJBGL + RCELJOQR + RCEL2012 ;

regle 2004079 :
application : iliad , batch  ;


RIVCEL1 =  RCEL_2011 * positif(ACEL); 

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
	  * ((V_REGCO+0) dans (1,3,5,6));
RIV2012CEL1 =  RCEL_2012 * positif(ACEL2012);
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


RIVCELNBGL1 =  RCEL_NBGL * positif(ACELNBGL); 
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

RIVCELJBGL1 =  RCEL_JBGL * positif(ACELJBGL); 
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


RIVCELCOM1 =  RCEL_COM * positif(ACELCOM); 

RIVCELCOM2 = RIVCELCOM1;

RIVCELCOM3 = RIVCELCOM1;

RIVCELCOM4 = (arr((min (CELLIERNP+CELLIERNR+CELLIERNS+CELLIERNT, LIMCELLIER) * positif(CELLIERNP+CELLIERNT) * (TX36/100))
          +(min (CELLIERNP+CELLIERNR+CELLIERNS+CELLIERNT,LIMCELLIER) * positif(CELLIERNR+CELLIERNS) * (TX40/100)))
	  -( 4 * RIVCELCOM1))
	  * (1 - V_CNR);

RIVCELJOQR1 =  RCEL_JOQR * positif(ACELJOQR); 
RIVCELJOQR2 = RIVCELJOQR1;
RIVCELJOQR3 = RIVCELJOQR1;
RIVCELJOQR4 = (arr((min (CELLIERJO + CELLIERJQ + CELLIERJR, LIMCELLIER) * positif(CELLIERJQ) * (TX36/100))
          +(min (CELLIERJO + CELLIERJQ + CELLIERJR, LIMCELLIER) * positif(CELLIERJO+CELLIERJR) * (TX24/100)))
	  -( 4 * RIVCELJOQR1))
	  * (1 - V_CNR);


RIVCELNQ1 =  RCEL_NQ * positif(ACELNQ); 

RIVCELNQ2 = RIVCELNQ1;

RIVCELNQ3 = RIVCELNQ1;

RIVCELNQ4 = (arr((min (CELLIERNQ, LIMCELLIER) * positif(CELLIERNQ) * (TX40/100)))
	  -( 4 * RIVCELNQ1))
	  * (1 - V_CNR);

RIVCELJP1 =  RCEL_JP * positif(ACELJP); 
RIVCELJP2 = RIVCELJP1;
RIVCELJP3 = RIVCELJP1;

RIVCELJP4 = (arr((min (CELLIERJP, LIMCELLIER) * positif(CELLIERJP) * (TX36/100)))
	  -( 4 * RIVCELJP1))
	  * (1 - V_CNR);


RIVCELHJK1 = RCEL_HJK * positif(ACELHJK) ; 

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

RIVCELHNO1 = RCEL_HNO * positif(ACELHNO) ; 

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

RIVCELHLM1 = RCEL_HL * positif(ACELHL) + RCEL_HM * positif(ACELHM); 

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


RRCELA2012 = (max(0, RCEL_2012 - RCEL2012)) * positif(CELSOMJ) * (1 - V_CNR)
        + (max(0, RCEL_JOQR - RCELJOQR)) * positif(somme(i=O,Q,R:CELLIERJi)) * (1 - V_CNR);

RRCEL = (max(0, RCEL_2011 - RCEL)) * positif(CELSOMN) * (1 - V_CNR)
        + (max(0, RCEL_COM - RCELCOM)) * positif(somme(i=P,R,S,T:CELLIERNi)) * (1 - V_CNR);

RRCELHH = (max(0, 
                   RCEL_HL+RCEL_HM+RCEL_HNO + somme(i=R,S,T,U,X,Z:RCELREP_Hi)
                 -(RCELHL +RCELHM +RCELHNO  + somme(i=R,S,T,U,X,Z:RCELREPHi))))
               * positif(somme(i=R,S,T,U,X,Z:CELREPHi)+somme(i=L,M,N,O:CELLIERHi))
	       * (1 - V_CNR);



RRCELLA = (max(0, ACELRREDLA - RCELRREDLA)) * positif(CELRREDLA) * (1 - V_CNR); 


RRCELLB = (max(0, ACELRREDLB - RCELRREDLB)) * positif(CELRREDLB) * (1 - V_CNR); 


RRCELLE = (max(0, ACELRREDLE - RCELRREDLE)) * positif(CELRREDLE) * ((V_REGCO+0) dans (1,3,5,6)); 


RRCELD2012 = (max(0,
	               ACELREPHF + ACELREPHE + RRCELHH
                     -(RCELREPHF + RCELREPHE)))
               * positif(somme (i=S,R,U,T,Z,X,F,E:CELREPHi) + somme(i=M,L,N,O:CELLIERHi))
               * ((V_REGCO+0) dans (1,3,5,6));


RRCELLF = (max(0, ACELRREDLF - RCELRREDLF)) * positif(CELRREDLF) * (1 - V_CNR); 

RRCELB2012 = (max(0,
	               ACELREPHG + ACELREPHA + RRCEL + RCEL_JBGL + RCEL_JP
                     -(RCELREPHG + RCELREPHA + RCELJBGL + RCELJP)))
               * positif(CELREPHG + CELREPHA + positif(CELSOMN)
			 +somme(i=P,R,S,T:CELLIERNi) + somme(i=B,G,L,P:CELLIERJi))   
               * ((V_REGCO+0) dans (1,3,5,6));


RRCELLC = (max(0, ACELRREDLC - RCELRREDLC)) * positif(CELRREDLC) * (1 - V_CNR);


RRCELLD = (max(0, ACELRREDLD - RCELRREDLD)) * positif(CELRREDLD) * (1 - V_CNR);

RRCELC2012 = (max(0,
	               ACELREPHH + ACELREPHD + ACELREPHB + RCELREP_HW + RCELREP_HV
                     + RCEL_NQ   + RCEL_NBGL + RCEL_HJK
                     -( RCELREPHH + RCELREPHD + RCELREPHB + RCELREPHW  + RCELREPHV
		       +RCELNQ    + RCELNBGL  + RCELHJK )))
               * positif(CELREPHH + CELREPHD + CELREPHB + CELREPHW + CELREPHV 
			 +somme(i=Q,B,G,L:CELLIERNi + CELLIERHJ + CELLIERHK))   
               * ((V_REGCO+0) dans (1,3,5,6));



	 
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

regle 4079:
application : iliad , batch  ;


BILNEUF= min (INVLOCNEUF , arr( LIMLOC * (1+BOOL_0AM) /6) ) * (1 - ART1731BIS) ;


BILLOCT1AV = min (INVLOCT1AV , LIMLOC * (1+BOOL_0AM)  ) * (1-positif(null(2-V_REGCO)+null(4-V_REGCO)));

BILLOCT1 = min (INVLOCT1 , max(0,LIMLOC * (1+BOOL_0AM)  - BILLOCT1AV) ) * (1-positif(null(2-V_REGCO)+null(4-V_REGCO)));

BILLOCXX = min(INVLOCXX , max((LIMLOC * (1 + BOOL_0AM) - BILLOCT1AV - BILLOCT1) , 0)) * (1 - positif(null(2 - V_REGCO) + null(4 - V_REGCO))) ;

BILLOCT2AV = min(INVLOCT2AV , max((LIMLOC * (1 + BOOL_0AM) - BILLOCT1AV - BILLOCT1 - BILLOCXX) , 0)) * (1 - positif(null(2 - V_REGCO) + null(4 - V_REGCO))) ;

BILLOCT2 = min(INVLOCT2 , max((LIMLOC * (1 + BOOL_0AM) - BILLOCT1AV - BILLOCT1 - BILLOCXX - BILLOCT2AV) , 0)) * (1 - positif(null(2 - V_REGCO) + null(4 - V_REGCO))) ;

BILLOCXZ = min(INVLOCXZ , max((LIMLOC * (1 + BOOL_0AM) - BILLOCT1AV - BILLOCT1 - BILLOCXX - BILLOCT2AV - BILLOCT2) , 0)) 
	    * (1 - positif(null(2 - V_REGCO) + null(4 - V_REGCO))) ;

BILRES = min (INVLOCRES , arr( LIMLOC * (1+BOOL_0AM) /6) ) * (1 - ART1731BIS) ;


regle 40791 :
application : iliad , batch  ;

RILNEUF = arr(BILNEUF * TX_REDIL25 / 100) ;

RILLOCT1 = (BILLOCT1 * TX_REDIL36 / 100) ;
RILLOCT2 = (BILLOCT2 * TX18/100) ;
RILLOCT1AV = (BILLOCT1AV * TX_REDIL40 / 100) ;
RILLOCT2AV = (BILLOCT2AV * TX20/100) ;
RILLOCXX = (BILLOCXX * TX30/100) ;
RILLOCXZ = (BILLOCXZ * TX15/100) ;

RILTRA = arr(RILLOCT1 + RILLOCT2 + RILLOCT1AV + RILLOCT2AV + RILLOCXX + RILLOCXZ) ;

RILRES = arr(BILRES * TX_REDIL20 / 100) ;

RITOUR = RILNEUF 
        + RILTRA
	+ RILRES
        + arr((REPINVLOCINV + RINVLOCINV + REPINVTOU + INVLOCXN) * TX_REDIL25 / 100)
        + arr((REPINVLOCREA + RINVLOCREA + INVLOGREHA + INVLOCXV)* TX_REDIL20 / 100) ;

RIHOTR = arr((INVLOCHOTR1 + INVLOCHOTR + INVLOGHOT) * TX_REDIL25 / 100) * (1-positif(null(2-V_REGCO)+null(4-V_REGCO)));



RIVL1 = (min( arr( max( 0 , min(INVLOCNEUF,LIMLOC*(1+BOOL_0AM)) - arr(LIMLOC*(1+BOOL_0AM)/6))/6) 
            , min(INVLOCNEUF,LIMLOC*(1+BOOL_0AM)))
        + min(arr ( max ( 0 , min(INVLOCRES,LIMLOC*(1+BOOL_0AM)) - arr(LIMLOC*(1+BOOL_0AM)/6))/6) 
            , min(INVLOCRES,LIMLOC*(1+BOOL_0AM))))
     * positif(INDLOCNEUF + INDLOCRES) ;

RIVL1RES = (min ( max ( 0 , INVLOCNEUF - arr(LIMLOC*(1+BOOL_0AM)/6)),
                        arr(LIMLOC * (1+BOOL_0AM) / 6 )) 
          + min ( max ( 0, INVLOCRES - arr(LIMLOC*(1+BOOL_0AM)/6)),
       	                arr(LIMLOC * (1+BOOL_0AM) / 6 )))
                * (1 - positif(INDLOCNEUF + INDLOCRES));

RIVL2 = (max(min( arr( max( 0 , min(INVLOCNEUF,LIMLOC*(1+BOOL_0AM)) - arr(LIMLOC*(1+BOOL_0AM)/6))/6)
              , min(INVLOCNEUF,LIMLOC*(1+BOOL_0AM)) - RIVL1), 0)
        + max(min(arr ( max ( 0 , min(INVLOCRES,LIMLOC*(1+BOOL_0AM)) - arr(LIMLOC*(1+BOOL_0AM)/6))/6) 
            , min(INVLOCRES,LIMLOC*(1+BOOL_0AM)) - RIVL1), 0))
     * positif(INDLOCNEUF + INDLOCRES);

RIVL2RES = (min ( max ( 0, INVLOCNEUF - arr(LIMLOC*(1+BOOL_0AM)/6) - RIVL1RES),
		       arr(LIMLOC * (1+BOOL_0AM) / 6 ))
           + min ( max ( 0, INVLOCRES - arr(LIMLOC*(1+BOOL_0AM)/6) - RIVL1RES),
		       arr(LIMLOC * (1+BOOL_0AM) / 6 )))
                * (1 - positif(INDLOCNEUF + INDLOCRES));

RIVL3 = (max(min(arr ( max ( 0 , min(INVLOCNEUF,LIMLOC*(1+BOOL_0AM)) - arr(LIMLOC*(1+BOOL_0AM)/6))/6)
              , min(INVLOCNEUF,LIMLOC*(1+BOOL_0AM)) - RIVL1 - RIVL2), 0)
        + max(min(arr ( max ( 0 , min(INVLOCRES,LIMLOC*(1+BOOL_0AM)) - arr(LIMLOC*(1+BOOL_0AM)/6))/6) 
            , min(INVLOCRES,LIMLOC*(1+BOOL_0AM)) - RIVL1 - RIVL2), 0))
     * positif(INDLOCNEUF + INDLOCRES);

RIVL3RES = (min ( max ( 0, INVLOCNEUF - arr(LIMLOC*(1+BOOL_0AM)/6) - RIVL1RES - RIVL2RES),
		       arr(LIMLOC * (1+BOOL_0AM) / 6 ))
           + min ( max ( 0, INVLOCRES - arr(LIMLOC*(1+BOOL_0AM)/6) - RIVL1RES - RIVL2RES),
		       arr(LIMLOC * (1+BOOL_0AM) / 6 )))
                * (1 - positif(INDLOCNEUF + INDLOCRES));

RIVL4 = (max(min(arr ( max ( 0 , min(INVLOCNEUF,LIMLOC*(1+BOOL_0AM)) - arr(LIMLOC*(1+BOOL_0AM)/6))/6)
              , min(INVLOCNEUF,LIMLOC*(1+BOOL_0AM)) - RIVL1 - RIVL2 - RIVL3), 0)
        + max(min(arr ( max ( 0 , min(INVLOCRES,LIMLOC*(1+BOOL_0AM)) - arr(LIMLOC*(1+BOOL_0AM)/6))/6) 
            , min(INVLOCRES,LIMLOC*(1+BOOL_0AM)) - RIVL1 - RIVL2 - RIVL3), 0))
     * positif(INDLOCNEUF + INDLOCRES);

RIVL4RES = (min ( max ( 0, INVLOCNEUF - arr(LIMLOC*(1+BOOL_0AM)/6) - RIVL1RES - RIVL2RES - RIVL3RES),
		       arr(LIMLOC * (1+BOOL_0AM) / 6 ))
           + min ( max ( 0, INVLOCRES - arr(LIMLOC*(1+BOOL_0AM)/6) - RIVL1RES - RIVL2RES - RIVL3RES),
		       arr(LIMLOC * (1+BOOL_0AM) / 6 )))
                * (1 - positif(INDLOCNEUF + INDLOCRES));

RIVL5 = (max(min(arr ( max ( 0 , min(INVLOCNEUF,LIMLOC*(1+BOOL_0AM)) - arr(LIMLOC*(1+BOOL_0AM)/6))/6)
              , min(INVLOCNEUF,LIMLOC*(1+BOOL_0AM)) - RIVL1 - RIVL2 - RIVL3 - RIVL4), 0)
        + max(min(arr ( max ( 0 , min(INVLOCRES,LIMLOC*(1+BOOL_0AM)) - arr(LIMLOC*(1+BOOL_0AM)/6))/6) 
            , min(INVLOCRES,LIMLOC*(1+BOOL_0AM)) - RIVL1 - RIVL2 - RIVL3 - RIVL4), 0))
     * positif(INDLOCNEUF + INDLOCRES);

RIVL5RES = (min ( max ( 0, INVLOCNEUF - arr(LIMLOC*(1+BOOL_0AM)/6) - RIVL1RES - RIVL2RES  - RIVL3RES - RIVL4RES),
		       LIMLOC*(1+BOOL_0AM)-arr(LIMLOC * (1+BOOL_0AM) / 6 ) - RIVL1RES - RIVL2RES - RIVL3RES - RIVL4RES)
           + min ( max ( 0, INVLOCRES - arr(LIMLOC*(1+BOOL_0AM)/6) - RIVL1RES - RIVL2RES  - RIVL3RES - RIVL4RES),
		       LIMLOC*(1+BOOL_0AM)-arr(LIMLOC * (1+BOOL_0AM) / 6 ) - RIVL1RES - RIVL2RES - RIVL3RES - RIVL4RES))
                * (1 - positif(INDLOCNEUF + INDLOCRES));

RIVL6 = (max(min ( max ( 0, INVLOCNEUF - arr(LIMLOC*(1+BOOL_0AM)/6) - RIVL1 - RIVL2 - RIVL3 - RIVL4 - RIVL5 ),
		     LIMLOC*(1+BOOL_0AM)-arr(LIMLOC * (1+BOOL_0AM) / 6 )-RIVL1-RIVL2-RIVL3-RIVL4 - RIVL5 ), 0)
        + max( min ( max ( 0, INVLOCRES - arr(LIMLOC*(1+BOOL_0AM)/6) - RIVL1 - RIVL2 - RIVL3 - RIVL4 - RIVL5),
		       LIMLOC*(1+BOOL_0AM)-arr(LIMLOC * (1+BOOL_0AM) / 6 ) - RIVL1 - RIVL2 - RIVL3 - RIVL4 - RIVL5), 0))
     * positif(INDLOCNEUF + INDLOCRES);

BREPNEUF = min (INVLOCNEUF , arr( LIMLOC * (1+BOOL_0AM)) ) * positif(INDLOCRES + INDLOCNEUF);
BRNEUF = max(0,BREPNEUF - BILNEUF)* positif(INDLOCRES + INDLOCNEUF);
REPNEUF = arr(BRNEUF /6) * positif(INDLOCNEUF + INDLOCRES);
BREPRES = min (INVLOCRES , arr( LIMLOC * (1+BOOL_0AM) ) ) * positif(INDLOCRES + INDLOCNEUF);
BRRES = max(0,BREPRES - BILRES)* positif(INDLOCRES + INDLOCNEUF);
REPRES = arr(BRRES /6) * positif(INDLOCNEUF + INDLOCRES);


DTOURNEUF = INVLOCNEUF ;
ATOURNEUF = BILNEUF  ;

DTOURTRA = INVLOCT1 + INVLOCT2 + INVLOCT1AV + INVLOCT2AV + INVLOCXX + INVLOCXZ ;
ATOURTRA = (BILLOCT1 + BILLOCT2 + BILLOCT1AV + BILLOCT2AV + BILLOCXX + BILLOCXZ) * (1 - ART1731BIS);

DTOURES = INVLOCRES;
ATOURES = BILRES ;

DTOURREP = REPINVLOCINV + RINVLOCINV + REPINVTOU + INVLOCXN ;
ATOURREP = DTOURREP * (1 - ART1731BIS) ;

DTOUHOTR = INVLOCHOTR1 + INVLOCHOTR + INVLOGHOT ;
ATOUHOTR = DTOUHOTR * (1-positif(null(2-V_REGCO)+null(4-V_REGCO))) * (1 - ART1731BIS);

DTOUREPA = REPINVLOCREA + RINVLOCREA + INVLOGREHA + INVLOCXV ;
ATOUREPA = DTOUREPA * (1 - ART1731BIS) ;

regle 10040791 :
application : iliad , batch  ;

RTOURNEUF = max(min( RILNEUF , RRI1-RLOGDOM) , 0) ;

RTOURTRA = max(min( RILTRA , RRI1-RLOGDOM-RTOURNEUF) , 0) * (1 - ART1731BIS) ;

RTOURES = max(min( RILRES , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA) , 0) ;

RTOURREP = max(min( arr(ATOURREP * TX_REDIL25 / 100) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES) , 0) ;


RTOUHOTR = max(min( RIHOTR , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP) , 0)
	    * (1 - positif(null(2-V_REGCO) + null(4-V_REGCO))) * (1 - ART1731BIS) ;


RTOUREPA = max(min( arr(ATOUREPA * TX_REDIL20 / 100) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR) , 0) ;


RTOUR = RTOURNEUF + RTOURREP ;

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

AAIDE = BAD * (1-V_CNR) * (1 - ART1731BIS) ;

RAIDE = max( min( RAD , IDOM11-DEC11-RCOTFOR-RREPA-RFIPDOM) , 0 ) * (1 - ART1731BIS);

regle 4071 :
application : iliad , batch  ;



DPATNAT1 = PATNAT1;
APATNAT1 = PATNAT1 * ((V_REGCO+0) dans (1,3,5,6)) * (1 - ART1731BIS) ;



DPATNAT2 = PATNAT2;
APATNAT2 = PATNAT2 * ((V_REGCO+0) dans (1,3,5,6)) * (1 - ART1731BIS) ;



BPATNAT = (min(PATNAT,LIM_PATNAT)) * ((V_REGCO+0) dans (1,3,5,6));
RAPATNAT = arr (BPATNAT * TX_PATNAT/100) ;

DPATNAT = PATNAT;
APATNAT = BPATNAT * (1 - ART1731BIS) ;

regle 20004071 :
application : iliad , batch  ;

 

RPATNAT1 = max( min( APATNAT1, RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA
			       -RCOMP-RCREAT-RRETU-RDONS-RNOUV-RCELTOT-RLOCNPRO) , 0 )
           * ((V_REGCO+0) dans (1,3,5,6)) * (1 - ART1731BIS) ;

RPATNAT2 = max( min( APATNAT2, RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA
			       -RCOMP-RCREAT-RRETU-RDONS-RNOUV-RCELTOT-RLOCNPRO-RPATNAT1) , 0 )
           * ((V_REGCO+0) dans (1,3,5,6)) * (1 - ART1731BIS) ;

RPATNAT = max( min( RAPATNAT , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA
			       -RCOMP-RCREAT-RRETU-RDONS-RNOUV-RCELTOT-RLOCNPRO-RPATNAT2-RPATNAT1 ) , 0 )
           * ((V_REGCO+0) dans (1,3,5,6)) * (1 - ART1731BIS) ;

RPATNATOT = RPATNAT + RPATNAT1 + RPATNAT2  ; 
 

REPNATR1 = max(APATNAT1 - RPATNAT1,0)*((V_REGCO+0) dans (1,3,5,6)); 

REPNATR2 = max(APATNAT2 - RPATNAT2,0)*((V_REGCO+0) dans (1,3,5,6)); 

REPNATR = max(RAPATNAT - RPATNAT,0)*((V_REGCO+0) dans (1,3,5,6)); 

regle 40704 :
application : iliad , batch  ;

RRI1 = IDOM11-DEC11-RCOTFOR-RREPA-RFIPDOM-RAIDE-RDIFAGRI-RFORET-RFIPC-RCINE-RRESTIMO
	     -RSOCREPR-RRPRESCOMP-RHEBE-RSURV-RINNO-RSOUFIP-RRIRENOV-RFOR ;

regle 40705 :
application : iliad , batch  ;

NRTOURNEUF = max( min( RILNEUF , RRI1-NRLOGDOM) , 0) ;

NRTOURTRA = max(min( RILTRA, RRI1-NRLOGDOM-NRTOURNEUF) , 0) ;

NRTOURES = max(min( RILRES , RRI1-NRLOGDOM-NRTOURNEUF-NRTOURTRA) , 0) ;

NRTOURREP = max(min( arr(ATOURREP * TX_REDIL25 / 100) , RRI1-NRLOGDOM-NRTOURNEUF-NRTOURTRA-NRTOURES) , 0) ;

NRTOUHOTR = max(min( RIHOTR , RRI1-NRLOGDOM-NRTOURNEUF-NRTOURTRA-NRTOURES-NRTOURREP) , 0)
	        * (1-positif(null(2-V_REGCO)+null(4-V_REGCO)));

NRTOUREPA = max(min( arr(ATOUREPA * TX_REDIL20 / 100) , RRI1-NRLOGDOM-NRTOURNEUF-NRTOURTRA-NRTOURES
							 -NRTOURREP-NRTOUHOTR) , 0) ;

NRCREAT = max(min( RCREATEUR + RCREATEURHANDI , RRI1-NRLOGDOM-NRTOURNEUF-NRTOURTRA-NRTOURES-NRTOURREP
						 -NRTOUHOTR-NRTOUREPA) , 0) ;

NRCOMP = max(min( RFC , RRI1-NRLOGDOM-NRTOURNEUF-NRTOURTRA-NRTOURES-NRTOURREP-NRTOUHOTR-NRTOUREPA
			   -NRCREAT) , 0) ;

NRRETU = max(min( RETUD , RRI1-NRLOGDOM-NRTOURNEUF-NRTOURTRA-NRTOURES-NRTOURREP-NRTOUHOTR-NRTOUREPA
			   -NRCOMP-NRCREAT) , 0) ;

NRDONS = max(min( RON , RRI1-NRLOGDOM-NRTOURNEUF-NRTOURTRA-NRTOURES-NRTOURREP-NRTOUHOTR-NRTOUREPA
                        -NRCOMP-NRCREAT-NRRETU) , 0) ;

NRNOUV = max(min( RSN , RRI1-NRLOGDOM-NRTOURNEUF-NRTOURTRA-NRTOURES-NRTOURREP-NRTOUHOTR-NRTOUREPA
			-NRCOMP-NRCREAT-NRRETU-NRDONS) , 0 );

NRRI2 = NRTOURNEUF + NRTOURTRA + NRTOURES + NRTOURREP + NRTOUHOTR + NRTOUREPA + NRCOMP + NRCREAT + NRRETU + NRDONS + NRNOUV ;

NRCELRREDLA = (max( min(CELRREDLA , RRI1-NRLOGDOM-NRRI2) , 0)) ;

NRCELRREDLB = (max( min(CELRREDLB , RRI1-NRLOGDOM-NRRI2-NRCELRREDLA) , 0)) ;

NRCELRREDLE = (max( min(CELRREDLE , RRI1-NRLOGDOM-NRRI2-NRCELRREDLA-NRCELRREDLB) , 0)) ;

NRCELRREDLC = (max( min(CELRREDLC , RRI1-NRLOGDOM-NRRI2-NRCELRREDLA-NRCELRREDLB-NRCELRREDLE) , 0)) ;

NRCELRREDLD = (max( min(CELRREDLD , RRI1-NRLOGDOM-NRRI2-NRCELRREDLA-NRCELRREDLB-NRCELRREDLE-NRCELRREDLC) , 0)) ;

NRCELRREDLF = (max( min(CELRREDLF , RRI1-NRLOGDOM-NRRI2-NRCELRREDLA-NRCELRREDLB-NRCELRREDLE-NRCELRREDLC-NRCELRREDLD) , 0)) ;

NRCELREPHS = (max( min(RCELREP_HS , RRI1-NRLOGDOM-NRRI2-NRCELRREDLA-NRCELRREDLB-NRCELRREDLE-NRCELRREDLC-NRCELRREDLD-NRCELRREDLF) , 0)) ;

NRCELREPHR = (max( min(RCELREP_HR , RRI1-NRLOGDOM-NRRI2-NRCELRREDLA-NRCELRREDLB-NRCELRREDLE-NRCELRREDLC-NRCELRREDLD-NRCELRREDLF-NRCELREPHS) , 0)) ;

NRCELREPHU = (max( min(RCELREP_HU , RRI1-NRLOGDOM-NRRI2-NRCELRREDLA-NRCELRREDLB-NRCELRREDLE-NRCELRREDLC-NRCELRREDLD-NRCELRREDLF-NRCELREPHS-NRCELREPHR) , 0)) ;

NRCELREPHT = (max( min(RCELREP_HT , RRI1-NRLOGDOM-NRRI2-NRCELRREDLA-NRCELRREDLB-NRCELRREDLE-NRCELRREDLC-NRCELRREDLD-NRCELRREDLF-NRCELREPHS-NRCELREPHR-NRCELREPHU) , 0)) ;

NRCELREPHZ = (max( min(RCELREP_HZ , RRI1-NRLOGDOM-NRRI2-NRCELRREDLA-NRCELRREDLB-NRCELRREDLE-NRCELRREDLC-NRCELRREDLD-NRCELRREDLF-NRCELREPHS-NRCELREPHR-NRCELREPHU
				    -NRCELREPHT) , 0)) ;

NRCELREPHX = (max( min(RCELREP_HX , RRI1-NRLOGDOM-NRRI2-NRCELRREDLA-NRCELRREDLB-NRCELRREDLE-NRCELRREDLC-NRCELRREDLD-NRCELRREDLF-NRCELREPHS-NRCELREPHR-NRCELREPHU
				    -NRCELREPHT-NRCELREPHZ) , 0)) ;

NRCELREPHW = (max( min(RCELREP_HW , RRI1-NRLOGDOM-NRRI2-NRCELRREDLA-NRCELRREDLB-NRCELRREDLE-NRCELRREDLC-NRCELRREDLD-NRCELRREDLF-NRCELREPHS-NRCELREPHR-NRCELREPHU
				    -NRCELREPHT-NRCELREPHZ-NRCELREPHX) , 0)) ;

NRCELREPHV = (max( min(RCELREP_HV , RRI1-NRLOGDOM-NRRI2-NRCELRREDLA-NRCELRREDLB-NRCELRREDLE-NRCELRREDLC-NRCELRREDLD-NRCELRREDLF-NRCELREPHS-NRCELREPHR-NRCELREPHU
				    -NRCELREPHT-NRCELREPHZ-NRCELREPHX-NRCELREPHW) , 0)) ;

NRCELREPHF = (max( min(ACELREPHF , RRI1-NRLOGDOM-NRRI2-NRCELRREDLA-NRCELRREDLB-NRCELRREDLE-NRCELRREDLC-NRCELRREDLD-NRCELRREDLF-NRCELREPHS-NRCELREPHR-NRCELREPHU
				    -NRCELREPHT-NRCELREPHZ-NRCELREPHX-NRCELREPHW-NRCELREPHV) , 0)) ;

NRCELREPHE = (max( min(ACELREPHE , RRI1-NRLOGDOM-NRRI2-NRCELRREDLA-NRCELRREDLB-NRCELRREDLE-NRCELRREDLC-NRCELRREDLD-NRCELRREDLF-NRCELREPHS-NRCELREPHR-NRCELREPHU
				    -NRCELREPHT-NRCELREPHZ-NRCELREPHX-NRCELREPHW-NRCELREPHV-NRCELREPHF) , 0)) ;

NRCELREPHD = (max( min(ACELREPHD , RRI1-NRLOGDOM-NRRI2-NRCELRREDLA-NRCELRREDLB-NRCELRREDLE-NRCELRREDLC-NRCELRREDLD-NRCELRREDLF-NRCELREPHS-NRCELREPHR-NRCELREPHU
				    -NRCELREPHT-NRCELREPHZ-NRCELREPHX-NRCELREPHW-NRCELREPHV-NRCELREPHF-NRCELREPHE) , 0)) ;

NRCELREPHH = (max( min(ACELREPHH , RRI1-NRLOGDOM-NRRI2-NRCELRREDLA-NRCELRREDLB-NRCELRREDLE-NRCELRREDLC-NRCELRREDLD-NRCELRREDLF-NRCELREPHS-NRCELREPHR-NRCELREPHU
				    -NRCELREPHT-NRCELREPHZ-NRCELREPHX-NRCELREPHW-NRCELREPHV-NRCELREPHF-NRCELREPHE-NRCELREPHD) , 0)) ;

NRCELREPHG = (max( min(ACELREPHG , RRI1-NRLOGDOM-NRRI2-NRCELRREDLA-NRCELRREDLB-NRCELRREDLE-NRCELRREDLC-NRCELRREDLD-NRCELRREDLF-NRCELREPHS-NRCELREPHR-NRCELREPHU
				    -NRCELREPHT-NRCELREPHZ-NRCELREPHX-NRCELREPHW-NRCELREPHV-NRCELREPHF-NRCELREPHE-NRCELREPHD-NRCELREPHH) , 0)) ;

NRCELREPHB = (max( min(ACELREPHB , RRI1-NRLOGDOM-NRRI2-NRCELRREDLA-NRCELRREDLB-NRCELRREDLE-NRCELRREDLC-NRCELRREDLD-NRCELRREDLF-NRCELREPHS-NRCELREPHR-NRCELREPHU
				    -NRCELREPHT-NRCELREPHZ-NRCELREPHX-NRCELREPHW-NRCELREPHV-NRCELREPHF-NRCELREPHE-NRCELREPHD-NRCELREPHH-NRCELREPHG) , 0)) ;

NRCELREPHA = (max( min(ACELREPHA , RRI1-NRLOGDOM-NRRI2-NRCELRREDLA-NRCELRREDLB-NRCELRREDLE-NRCELRREDLC-NRCELRREDLD-NRCELRREDLF-NRCELREPHS-NRCELREPHR-NRCELREPHU
				    -NRCELREPHT-NRCELREPHZ-NRCELREPHX-NRCELREPHW-NRCELREPHV-NRCELREPHF-NRCELREPHE-NRCELREPHD-NRCELREPHH-NRCELREPHG-NRCELREPHB) , 0)) ;

NRCELHM = (max( min(RCEL_HM , RRI1-NRLOGDOM-NRRI2-NRCELRREDLA-NRCELRREDLB-NRCELRREDLE-NRCELRREDLC-NRCELRREDLD-NRCELRREDLF-NRCELREPHS-NRCELREPHR-NRCELREPHU
			      -NRCELREPHT-NRCELREPHZ-NRCELREPHX-NRCELREPHW-NRCELREPHV-NRCELREPHF-NRCELREPHE-NRCELREPHD-NRCELREPHH-NRCELREPHG-NRCELREPHB-NRCELREPHA) , 0)) ;

NRCELHL = (max( min(RCEL_HL , RRI1-NRLOGDOM-NRRI2-NRCELRREDLA-NRCELRREDLB-NRCELRREDLE-NRCELRREDLC-NRCELRREDLD-NRCELRREDLF-NRCELREPHS-NRCELREPHR-NRCELREPHU
			      -NRCELREPHT-NRCELREPHZ-NRCELREPHX-NRCELREPHW-NRCELREPHV-NRCELREPHF-NRCELREPHE-NRCELREPHD-NRCELREPHH-NRCELREPHG-NRCELREPHB-NRCELREPHA
			      -NRCELHM) , 0)) ;

NRCELHNO = (max( min(RCEL_HNO , RRI1-NRLOGDOM-NRRI2-NRCELRREDLA-NRCELRREDLB-NRCELRREDLE-NRCELRREDLC-NRCELRREDLD-NRCELRREDLF-NRCELREPHS-NRCELREPHR-NRCELREPHU
			        -NRCELREPHT-NRCELREPHZ-NRCELREPHX-NRCELREPHW-NRCELREPHV-NRCELREPHF-NRCELREPHE-NRCELREPHD-NRCELREPHH-NRCELREPHG-NRCELREPHB-NRCELREPHA
				-NRCELHM-NRCELHL) , 0)) ;

NRCELHJK = (max( min(RCEL_HJK , RRI1-NRLOGDOM-NRRI2-NRCELRREDLA-NRCELRREDLB-NRCELRREDLE-NRCELRREDLC-NRCELRREDLD-NRCELRREDLF-NRCELREPHS-NRCELREPHR-NRCELREPHU
			        -NRCELREPHT-NRCELREPHZ-NRCELREPHX-NRCELREPHW-NRCELREPHV-NRCELREPHF-NRCELREPHE-NRCELREPHD-NRCELREPHH-NRCELREPHG-NRCELREPHB-NRCELREPHA
				-NRCELHM-NRCELHL-NRCELHNO) , 0)) ;

NRCELNQ = (max( min(RCEL_NQ , RRI1-NRLOGDOM-NRRI2-NRCELRREDLA-NRCELRREDLB-NRCELRREDLE-NRCELRREDLC-NRCELRREDLD-NRCELRREDLF-NRCELREPHS-NRCELREPHR-NRCELREPHU
			      -NRCELREPHT-NRCELREPHZ-NRCELREPHX-NRCELREPHW-NRCELREPHV-NRCELREPHF-NRCELREPHE-NRCELREPHD-NRCELREPHH-NRCELREPHG-NRCELREPHB-NRCELREPHA
			      -NRCELHM-NRCELHL-NRCELHNO-NRCELHJK) , 0)) ;

NRCELNBGL = (max( min(RCEL_NBGL , RRI1-NRLOGDOM-NRRI2-NRCELRREDLA-NRCELRREDLB-NRCELRREDLE-NRCELRREDLC-NRCELRREDLD-NRCELRREDLF-NRCELREPHS-NRCELREPHR-NRCELREPHU
				  -NRCELREPHT-NRCELREPHZ-NRCELREPHX-NRCELREPHW-NRCELREPHV-NRCELREPHF-NRCELREPHE-NRCELREPHD-NRCELREPHH-NRCELREPHG-NRCELREPHB-NRCELREPHA
				  -NRCELHM-NRCELHL-NRCELHNO-NRCELHJK-NRCELNQ) , 0)) ;

NRCELCOM = (max( min(RCEL_COM , RRI1-NRLOGDOM-NRRI2-NRCELRREDLA-NRCELRREDLB-NRCELRREDLE-NRCELRREDLC-NRCELRREDLD-NRCELRREDLF-NRCELREPHS-NRCELREPHR-NRCELREPHU
			        -NRCELREPHT-NRCELREPHZ-NRCELREPHX-NRCELREPHW-NRCELREPHV-NRCELREPHF-NRCELREPHE-NRCELREPHD-NRCELREPHH-NRCELREPHG-NRCELREPHB-NRCELREPHA
				-NRCELHM-NRCELHL-NRCELHNO-NRCELHJK-NRCELNQ-NRCELNBGL) , 0)) ;

NRCEL = (max( min(RCEL_2011 , RRI1-NRLOGDOM-NRRI2-NRCELRREDLA-NRCELRREDLB-NRCELRREDLE-NRCELRREDLC-NRCELRREDLD-NRCELRREDLF-NRCELREPHS-NRCELREPHR-NRCELREPHU
			      -NRCELREPHT-NRCELREPHZ-NRCELREPHX-NRCELREPHW-NRCELREPHV-NRCELREPHF-NRCELREPHE-NRCELREPHD-NRCELREPHH-NRCELREPHG-NRCELREPHB-NRCELREPHA
			      -NRCELHM-NRCELHL-NRCELHNO-NRCELHJK-NRCELNQ-NRCELNBGL-NRCELCOM) , 0)) ;

NRCELJP = (max( min(RCEL_JP , RRI1-NRLOGDOM-NRRI2-NRCELRREDLA-NRCELRREDLB-NRCELRREDLE-NRCELRREDLC-NRCELRREDLD-NRCELRREDLF-NRCELREPHS-NRCELREPHR-NRCELREPHU
			      -NRCELREPHT-NRCELREPHZ-NRCELREPHX-NRCELREPHW-NRCELREPHV-NRCELREPHF-NRCELREPHE-NRCELREPHD-NRCELREPHH-NRCELREPHG-NRCELREPHB-NRCELREPHA
			      -NRCELHM-NRCELHL-NRCELHNO-NRCELHJK-NRCELNQ-NRCELNBGL-NRCELCOM-NRCEL) , 0)) ;

NRCELJBGL = (max( min(RCEL_JBGL , RRI1-NRLOGDOM-NRRI2-NRCELRREDLA-NRCELRREDLB-NRCELRREDLE-NRCELRREDLC-NRCELRREDLD-NRCELRREDLF-NRCELREPHS-NRCELREPHR-NRCELREPHU
			          -NRCELREPHT-NRCELREPHZ-NRCELREPHX-NRCELREPHW-NRCELREPHV-NRCELREPHF-NRCELREPHE-NRCELREPHD-NRCELREPHH-NRCELREPHG-NRCELREPHB-NRCELREPHA
			          -NRCELHM-NRCELHL-NRCELHNO-NRCELHJK-NRCELNQ-NRCELNBGL-NRCELCOM-NRCEL-NRCELJP) , 0)) ;

NRCELJOQR = (max( min(RCEL_JOQR , RRI1-NRLOGDOM-NRRI2-NRCELRREDLA-NRCELRREDLB-NRCELRREDLE-NRCELRREDLC-NRCELRREDLD-NRCELRREDLF-NRCELREPHS-NRCELREPHR-NRCELREPHU
			          -NRCELREPHT-NRCELREPHZ-NRCELREPHX-NRCELREPHW-NRCELREPHV-NRCELREPHF-NRCELREPHE-NRCELREPHD-NRCELREPHH-NRCELREPHG-NRCELREPHB-NRCELREPHA
			          -NRCELHM-NRCELHL-NRCELHNO-NRCELHJK-NRCELNQ-NRCELNBGL-NRCELCOM-NRCEL-NRCELJP-NRCELJBGL) , 0)) ;

NRCEL2012 = (max( min(RCEL_2012 , RRI1-NRLOGDOM-NRRI2-NRCELRREDLA-NRCELRREDLB-NRCELRREDLE-NRCELRREDLC-NRCELRREDLD-NRCELRREDLF-NRCELREPHS-NRCELREPHR-NRCELREPHU
			          -NRCELREPHT-NRCELREPHZ-NRCELREPHX-NRCELREPHW-NRCELREPHV-NRCELREPHF-NRCELREPHE-NRCELREPHD-NRCELREPHH-NRCELREPHG-NRCELREPHB-NRCELREPHA
			          -NRCELHM-NRCELHL-NRCELHNO-NRCELHJK-NRCELNQ-NRCELNBGL-NRCELCOM-NRCEL-NRCELJP-NRCELJBGL-NRCELJOQR) , 0)) ;

NRCELTOT = NRCELRREDLA + NRCELRREDLB + NRCELRREDLE + NRCELRREDLC + NRCELRREDLD + NRCELRREDLF + NRCELREPHS + NRCELREPHR + NRCELREPHU + NRCELREPHT + NRCELREPHZ 
	   + NRCELREPHX + NRCELREPHW + NRCELREPHV + NRCELREPHF + NRCELREPHE + NRCELREPHD + NRCELREPHH + NRCELREPHG + NRCELREPHB + NRCELREPHA + NRCELHM + NRCELHL 
	   + NRCELHNO + NRCELHJK + NRCELNQ + NRCELCOM + NRCELNBGL + NRCEL + NRCELJP + NRCELJBGL + NRCELJOQR + NRCEL2012 ;

NRREDMEUB = max(min( AREDMEUB , RRI1-NRLOGDOM-NRRI2-NRCELTOT) , 0) ;

NRREDREP = max(min( AREDREP , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB) , 0) ;

NRILMIX = max(min( AILMIX , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP) , 0) ;

NRINVRED = max(min( AINVRED , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX) , 0) ;

NRILMIH = max(min( AILMIH , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRINVRED) , 0) ;

NRILMIZ = max(min( AILMIZ , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRINVRED-NRILMIH) , 0) ;

NRMEUBLE = max(min( MEUBLERET , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRINVRED-NRILMIH-NRILMIZ) , 0) ;

NRPROREP = max(min( RETPROREP , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRINVRED-NRILMIH-NRILMIZ-NRMEUBLE) , 0) ;

NRREPNPRO = max(min( RETREPNPRO , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRINVRED-NRILMIH-NRILMIZ-NRMEUBLE-NRPROREP) , 0) ;

NRREPMEU = max(min( RETREPMEU , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRINVRED-NRILMIH-NRILMIZ-NRMEUBLE-NRPROREP-NRREPNPRO) , 0) ;

NRILMIC = max(min( AILMIC , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRINVRED-NRILMIH-NRILMIZ-NRMEUBLE-NRPROREP-NRREPNPRO-NRREPMEU) , 0) ;

NRILMIB = max(min( AILMIB , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRINVRED-NRILMIH-NRILMIZ-NRMEUBLE-NRPROREP-NRREPNPRO-NRREPMEU-NRILMIC) , 0) ;

NRILMIA = max(min( AILMIA , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRINVRED-NRILMIH-NRILMIZ-NRMEUBLE-NRPROREP-NRREPNPRO-NRREPMEU-NRILMIC-NRILMIB) , 0) ;

NRRESIMEUB = max(min( RETRESIMEUB , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRINVRED-NRILMIH-NRILMIZ-NRMEUBLE-NRPROREP-NRREPNPRO-NRREPMEU
				    -NRILMIC-NRILMIB-NRILMIA) , 0) ;

NRRESIVIEU = max(min( RETRESIVIEU , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRINVRED-NRILMIH-NRILMIZ-NRMEUBLE-NRPROREP-NRREPNPRO-NRREPMEU
				    -NRILMIC-NRILMIB-NRILMIA-NRRESIMEUB) , 0) ;

NRRESINEUV = max(min( RETRESINEUV , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRINVRED-NRILMIH-NRILMIZ-NRMEUBLE-NRPROREP-NRREPNPRO-NRREPMEU
				    -NRILMIC-NRILMIB-NRILMIA-NRRESIMEUB-NRRESIMEUB) , 0) ;

NRLOCIDEFG = max(min( RETLOCIDEFG , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRREDMEUB-NRREDREP-NRILMIX-NRINVRED-NRILMIH-NRILMIZ-NRMEUBLE-NRPROREP-NRREPNPRO-NRREPMEU
				    -NRILMIC-NRILMIB-NRILMIA-NRRESIMEUB-NRRESIMEUB-NRRESINEUV) , 0) ;

NRLOCNPRO = NRREDMEUB + NRREDREP + NRILMIX + NRINVRED + NRILMIH + NRILMIZ + NRMEUBLE + NRPROREP + NRREPNPRO + NRREPMEU 
	    + NRILMIC + NRILMIB + NRILMIA + NRRESIMEUB + NRRESIVIEU + NRRESINEUV + NRLOCIDEFG ;

NRPATNAT1 = max(min( APATNAT1 , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO) , 0 );

NRPATNAT2 = max(min( APATNAT2 , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT1) , 0 );

NRPATNAT = max(min( RAPATNAT , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT1-NRPATNAT2) , 0 );

regle 40706 :
application : iliad , batch  ;

NPLAFDOMPRO1 = max(0, RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRCELTOT-NRLOCNPRO-NRPATNAT1-NRPATNAT2-NRPATNAT) ;

NRIDOMPROE4 = min(REPINVDOMPRO2,NPLAFDOMPRO1) * (1 - V_CNR) ;
                  
NPLAFDOMPRO3 = positif(NPLAFDOMPRO1 - REPINVDOMPRO2) * (NPLAFDOMPRO1 - REPINVDOMPRO2) * (1 -V_CNR) ; 

NRIDOMPROE3 = min(REPINVDOMPRO3,NPLAFDOMPRO3) * (1 - V_CNR) ;

NRIDOMPROTOT = NRIDOMPROE3 + NRIDOMPROE4 ;

NRRI3 = NRCELTOT + NRLOCNPRO + NRPATNAT1 + NRPATNAT2 + NRPATNAT + NRIDOMPROTOT ;

regle 4070111 :
application : iliad , batch  ;
BAH = (min (RVCURE,LIM_CURE) + min(RCCURE,LIM_CURE)) * (1 - V_CNR) * (1 - ART1731BIS);
RAH = arr (BAH * TX_CURE /100) ;
DHEBE = RVCURE + RCCURE ;

AHEBE = BAH ;

RHEBE = max( min( RAH , IDOM11-DEC11-RCOTFOR-RREPA-RFIPDOM-RAIDE-RDIFAGRI-RFORET-RFIPC
			-RCINE-RRESTIMO-RSOCREPR-RRPRESCOMP) , 0 );

regle 4070121:
application : iliad , batch  ;
RP = somme (i=V,C: TSNNi + TSNN2i + BICIMPi + BICNPi + BNNi +  max(0,BANi) + BAEi)
           + (min (0,BANV) + min (0,BANC)) * 
    (1 - positif(1 + SEUIL_IMPDEFBA - SHBA - GLN1 - somme(i=2..4 : REVi) - REVRF
    - (REVTP - BA1)  ))
	   + max(0 , ANOCEP - (DNOCEP + DABNCNP6+DABNCNP5+DABNCNP4+DABNCNP3+DABNCNP2+DABNCNP1) ) + somme(i=1..3:GLNi) ;

regle 407013:
application : iliad , batch  ;

DREPA = RDREP + DONETRAN;

BAA = min( RDFREP + RDFDONETR, PLAF_REDREPAS ) * (1 - ART1731BIS);

RAA = arr( (TX_REDREPAS) / 100 * BAA ) * ((V_REGCO+0) dans (1,3,5,6)) ;

AREPA = BAA * ((V_REGCO+0) dans (1,3,5,6)) ;

RREPA = max(min( RAA , IDOM11-DEC11-RCOTFOR) , 0) ;

regle 407014:
application : iliad , batch  ;

BSN1 = min (REPSNO3 + REPSNO2 + REPSNO1 + REPSNON + PETIPRISE , LIM_SOCNOUV2 * (1 + BOOL_0AM)) ;
BSN2 = min (RDSNO , LIM_TITPRISE * (1 + BOOL_0AM) - BSN1) ;
RSN1 = min(REPSNO3 + REPSNO2 + REPSNO1 , LIM_SOCNOUV2 * (1 + BOOL_0AM)) ;

RSN2 = max(0 , min(REPSNON , LIM_SOCNOUV2 * (1 + BOOL_0AM) - RSN1)) ;

RSN3 = max(0 , min(PETIPRISE , LIM_SOCNOUV2 * (1 + BOOL_0AM) - RSN1 - RSN2)) ;

RSN4 = max(0 , min(RDSNO , LIM_TITPRISE * (1 + BOOL_0AM) - BSN1)) ;

RSN = arr(RSN1 * TX25/100 + RSN2 * TX22/100 + RSN3 * TX18/100 + RSN4 * TX18/100) * (1 - V_CNR)
										 * (1 - ART1731BIS) ;

DNOUV = REPSNO3 + REPSNO2 + REPSNO1 + REPSNON + PETIPRISE + RDSNO ;

ANOUV = (BSN1 + BSN2) * (1 - V_CNR) * (1 - ART1731BIS) ;

regle 200407014:
application : iliad , batch  ;
RNOUV = max( min( RSN , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP
			-RCREAT-RRETU-RDONS) , 0) ;

REPINVPME3 = max(0 , REPSNO2 - max(0 , (LIM_SOCNOUV2 * (1+BOOL_0AM)) - min(REPSNO3 , LIM_SOCNOUV2 * (1+BOOL_0AM)))) 
	      * (1 - V_CNR) ; 

REPINVPME2 = max(0 , REPSNO1 - max(0 , (LIM_SOCNOUV2 * (1+BOOL_0AM)) - (min(REPSNO3 , LIM_SOCNOUV2 * (1+BOOL_0AM)) + REPSNO2))) 
	      * (1 - V_CNR) ;

REPINVPME1 = max(0 , REPSNON - max(0 , (LIM_SOCNOUV2 * (1+BOOL_0AM)) - (min(REPSNO3 , LIM_SOCNOUV2 * (1+BOOL_0AM)) + REPSNO2 + REPSNO1)))
	      * (1 - V_CNR) ;

REPINVPMECU = max(0 , PETIPRISE - max(0 , (LIM_SOCNOUV2 * (1+BOOL_0AM)) - (min(REPSNO3 , LIM_SOCNOUV2 * (1+BOOL_0AM)) + REPSNO2 + REPSNO1 + REPSNON)))
	      * (1 - V_CNR) ;

REPINVPME = max(0 , RDSNO - max(0 , (LIM_TITPRISE * (1 + BOOL_0AM)) 
			     - min(LIM_SOCNOUV2 * (1 + BOOL_0AM) , min(REPSNO3 , LIM_SOCNOUV2 * (1+BOOL_0AM)) + REPSNO2 + REPSNO1 + REPSNON + PETIPRISE)))
	      * (1 - V_CNR) ;


regle 407010:
application : iliad , batch  ;


DLOCIDEFG = LOCMEUBID + LOCMEUBIE + LOCMEUBIF + LOCMEUBIG ;

DRESINEUV = LOCRESINEUV + MEUBLENP + INVNPROF1 + INVNPROF2 ;

DRESIVIEU = RESIVIEU + RESIVIANT ;

DRESIMEUB = VIEUMEUB ;


ALOCIDEFG = arr(min(PLAF_RESINEUV , DLOCIDEFG) / 9) * (1 - V_CNR) * (1 - ART1731BIS) ;

ARESINEUV = arr(min(PLAF_RESINEUV , DRESINEUV) / 9) * (1 - V_CNR) * (1 - ART1731BIS) ;

ARESIVIEU = arr(min(PLAF_RESINEUV , DRESIVIEU) / 9) * (1 - V_CNR) * (1 - ART1731BIS) ;

ARESIMEUB = arr(min(PLAF_RESINEUV , DRESIMEUB) / 9) * (1 - V_CNR) * (1 - ART1731BIS) ;

RETLOCIDEFG = arr( (TX11 * positif(LOCMEUBID + LOCMEUBIG) + TX18 * positif(LOCMEUBIE + LOCMEUBIF)) * ALOCIDEFG / 100 ) * (1-V_CNR) ;

RETRESINEUV = arr( (TX18 * positif(LOCRESINEUV + INVNPROF2) + TX20 * positif(MEUBLENP + INVNPROF1)) * ARESINEUV / 100 ) * (1-V_CNR) ;

RETRESIVIEU = arr( TX25 * ARESIVIEU / 100 ) * (1-V_CNR) ;

RETRESIMEUB = arr( TX25 * ARESIMEUB / 100 ) * (1-V_CNR) ;

regle 30407000:
application : iliad , batch  ;
 

RRESIMEUB = max(min( RETRESIMEUB , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
				   -RNOUV-RCELTOT-RREDMEUB-RREDREP-RILMIX-RINVRED-RILMIH-RILMIZ-RMEUBLE-RPROREP-RREPNPRO-RREPMEU
				   -RILMIC-RILMIB-RILMIA) , 0) * (1 - ART1731BIS) ;

regle 35407010:
application : iliad , batch  ;


RRESIVIEU = max(min( RETRESIVIEU , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
				   -RNOUV-RCELTOT-RREDMEUB-RREDREP-RILMIX-RINVRED-RILMIH-RILMIZ-RMEUBLE-RPROREP-RREPNPRO-RREPMEU
				   -RILMIC-RILMIB-RILMIA-RRESIMEUB) , 0)  * (1 - ART1731BIS) ;

regle 30407010:
application : iliad , batch  ;


RRESINEUV = max(min( RETRESINEUV , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
				   -RNOUV-RCELTOT-RREDMEUB-RREDREP-RILMIX-RINVRED-RILMIH-RILMIZ-RMEUBLE-RPROREP-RREPNPRO-RREPMEU
				   -RILMIC-RILMIB-RILMIA-RRESIMEUB-RRESIVIEU) , 0) * (1 - ART1731BIS) ;

regle 30407011:
application : iliad , batch  ;


RLOCIDEFG = max(min( RETLOCIDEFG , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
				   -RNOUV-RCELTOT-RREDMEUB-RREDREP-RILMIX-RINVRED-RILMIH-RILMIZ-RMEUBLE-RPROREP-RREPNPRO-RREPMEU
				   -RILMIC-RILMIB-RILMIA-RRESIMEUB-RRESIVIEU-RRESINEUV) , 0) * (1 - ART1731BIS) ;

RLOCNPRO = RREDMEUB + RREDREP + RILMIX + RINVRED + RILMIH + RILMIZ + RMEUBLE + RPROREP + RREPNPRO 
	   + RREPMEU + RILMIC + RILMIB + RILMIA + RRESIMEUB + RRESIVIEU + RRESINEUV + RLOCIDEFG ;

regle 36407010:
application : iliad , batch  ;


RLOCIDFG = (RETLOCIDEFG - RLOCIDEFG) * positif(LOCMEUBID + LOCMEUBIF + LOCMEUBIG) * ((V_REGCO+0) dans (1,3,5,6)) ;
REPLOCNT = RLOCIDFG ;

RLOCIE = (RETLOCIDEFG - RLOCIDEFG) * positif(LOCMEUBIE) ;

REPRESINEUV = ((RETRESINEUV - RRESINEUV) * positif(LOCRESINEUV + INVNPROF1 + INVNPROF2) + RLOCIE + REPMEUIA) * ((V_REGCO+0) dans (1,3,5,6)) ;

MEUBLEREP = (RETRESINEUV - RRESINEUV) * positif(MEUBLENP) ;

REPRESIVIEU = (RETRESIVIEU - RRESIVIEU) * positif(RESIVIEU) ;

RESIVIEUREP = (RETRESIVIEU - RRESIVIEU) * positif(RESIVIANT) ;

REPRESIMEUB = RETRESIMEUB - RRESIMEUB ;

RLOCIDFG1 = arr(arr(min (LOCMEUBID + LOCMEUBIF + LOCMEUBIG , PLAF_RESINEUV) / 9) * (TX18/100*positif(LOCMEUBIF) + TX11/100*positif(LOCMEUBID + LOCMEUBIG))) ;
RLOCIDFG2 = arr(arr(min (LOCMEUBID + LOCMEUBIF + LOCMEUBIG , PLAF_RESINEUV) / 9) * (TX18/100*positif(LOCMEUBIF) + TX11/100*positif(LOCMEUBID + LOCMEUBIG))) ;
RLOCIDFG3 = arr(arr(min (LOCMEUBID + LOCMEUBIF + LOCMEUBIG , PLAF_RESINEUV) / 9) * (TX18/100*positif(LOCMEUBIF) + TX11/100*positif(LOCMEUBID + LOCMEUBIG))) ;
RLOCIDFG4 = arr(arr(min (LOCMEUBID + LOCMEUBIF + LOCMEUBIG , PLAF_RESINEUV) / 9) * (TX18/100*positif(LOCMEUBIF) + TX11/100*positif(LOCMEUBID + LOCMEUBIG))) ;
RLOCIDFG5 = arr(arr(min (LOCMEUBID + LOCMEUBIF + LOCMEUBIG , PLAF_RESINEUV) / 9) * (TX18/100*positif(LOCMEUBIF) + TX11/100*positif(LOCMEUBID + LOCMEUBIG))) ;
RLOCIDFG6 = arr(arr(min (LOCMEUBID + LOCMEUBIF + LOCMEUBIG , PLAF_RESINEUV) / 9) * (TX18/100*positif(LOCMEUBIF) + TX11/100*positif(LOCMEUBID + LOCMEUBIG))) ;
RLOCIDFG7 = arr(arr(min (LOCMEUBID + LOCMEUBIF + LOCMEUBIG , PLAF_RESINEUV) / 9) * (TX18/100*positif(LOCMEUBIF) + TX11/100*positif(LOCMEUBID + LOCMEUBIG))) ;
RLOCIDFG8 = arr(min(LOCMEUBID + LOCMEUBIF + LOCMEUBIG , PLAF_RESINEUV) * (TX18/100*positif(LOCMEUBIF) + TX11/100*positif(LOCMEUBID + LOCMEUBIG)))
	     - RLOCIDFG1 - RLOCIDFG2 - RLOCIDFG3 - RLOCIDFG4 - RLOCIDFG5 - RLOCIDFG6 - RLOCIDFG7 - RLOCIDFG7 ;

REPLOCIDFG = RLOCIDFG1 + RLOCIDFG2 + RLOCIDFG3 + RLOCIDFG4 + RLOCIDFG5 + RLOCIDFG6 + RLOCIDFG7 + RLOCIDFG8 ;

REPLOCIE1 = arr(arr( min(LOCMEUBIE , PLAF_RESINEUV) / 9) * TX18/100) ; 
REPLOCIE2 = arr(arr( min(LOCMEUBIE , PLAF_RESINEUV) / 9) * TX18/100) ; 
REPLOCIE3 = arr(arr( min(LOCMEUBIE , PLAF_RESINEUV) / 9) * TX18/100) ; 
REPLOCIE4 = arr(arr( min(LOCMEUBIE , PLAF_RESINEUV) / 9) * TX18/100) ; 
REPLOCIE5 = arr(arr( min(LOCMEUBIE , PLAF_RESINEUV) / 9) * TX18/100) ; 
REPLOCIE6 = arr(arr( min(LOCMEUBIE , PLAF_RESINEUV) / 9) * TX18/100) ; 
REPLOCIE7 = arr(arr( min(LOCMEUBIE , PLAF_RESINEUV) / 9) * TX18/100) ; 
REPLOCIE8 = arr(min(LOCMEUBIE , PLAF_RESINEUV) * TX18/100) -REPLOCIE1-REPLOCIE2-REPLOCIE3-REPLOCIE4-REPLOCIE5-REPLOCIE6-REPLOCIE7-REPLOCIE7 ;

REPLOCIE = REPLOCIE1 + REPLOCIE2 + REPLOCIE3 + REPLOCIE4 + REPLOCIE5 + REPLOCIE6 + REPLOCIE7 + REPLOCIE8 ;

RESINEUV1 = arr(arr(min (LOCRESINEUV + INVNPROF1 + INVNPROF2 , PLAF_RESINEUV) / 9) * (TX20/100*positif(INVNPROF1) + TX18/100*positif(LOCRESINEUV + INVNPROF2))) ;
RESINEUV2 = arr(arr(min (LOCRESINEUV + INVNPROF1 + INVNPROF2 , PLAF_RESINEUV) / 9) * (TX20/100*positif(INVNPROF1) + TX18/100*positif(LOCRESINEUV + INVNPROF2))) ;
RESINEUV3 = arr(arr(min (LOCRESINEUV + INVNPROF1 + INVNPROF2 , PLAF_RESINEUV) / 9) * (TX20/100*positif(INVNPROF1) + TX18/100*positif(LOCRESINEUV + INVNPROF2))) ;
RESINEUV4 = arr(arr(min (LOCRESINEUV + INVNPROF1 + INVNPROF2 , PLAF_RESINEUV) / 9) * (TX20/100*positif(INVNPROF1) + TX18/100*positif(LOCRESINEUV + INVNPROF2))) ;
RESINEUV5 = arr(arr(min (LOCRESINEUV + INVNPROF1 + INVNPROF2 , PLAF_RESINEUV) / 9) * (TX20/100*positif(INVNPROF1) + TX18/100*positif(LOCRESINEUV + INVNPROF2))) ;
RESINEUV6 = arr(arr(min (LOCRESINEUV + INVNPROF1 + INVNPROF2 , PLAF_RESINEUV) / 9) * (TX20/100*positif(INVNPROF1) + TX18/100*positif(LOCRESINEUV + INVNPROF2))) ;
RESINEUV7 = arr(arr(min (LOCRESINEUV + INVNPROF1 + INVNPROF2 , PLAF_RESINEUV) / 9) * (TX20/100*positif(INVNPROF1) + TX18/100*positif(LOCRESINEUV + INVNPROF2))) ;
RESINEUV8 = arr(min(LOCRESINEUV + INVNPROF1 + INVNPROF2 , PLAF_RESINEUV) * (TX20/100*positif(INVNPROF1) + TX18/100*positif(LOCRESINEUV + INVNPROF2)))
	                 - RESINEUV1 - RESINEUV2 - RESINEUV3 - RESINEUV4 - RESINEUV5 - RESINEUV6 - RESINEUV7 - RESINEUV7 ;

REPINVLOCNP = RESINEUV1 + RESINEUV2 + RESINEUV3 + RESINEUV4 + RESINEUV5 + RESINEUV6 + RESINEUV7 + RESINEUV8 ;

RRESINEUV1 = arr(arr( min(MEUBLENP , PLAF_RESINEUV) / 9) * TX20/100) ;
RRESINEUV2 = arr(arr( min(MEUBLENP , PLAF_RESINEUV) / 9) * TX20/100) ;
RRESINEUV3 = arr(arr( min(MEUBLENP , PLAF_RESINEUV) / 9) * TX20/100) ;
RRESINEUV4 = arr(arr( min(MEUBLENP , PLAF_RESINEUV) / 9) * TX20/100) ;
RRESINEUV5 = arr(arr( min(MEUBLENP , PLAF_RESINEUV) / 9) * TX20/100) ;
RRESINEUV6 = arr(arr( min(MEUBLENP , PLAF_RESINEUV) / 9) * TX20/100) ;
RRESINEUV7 = arr(arr( min(MEUBLENP , PLAF_RESINEUV) / 9) * TX20/100) ;
RRESINEUV8 = arr(min(MEUBLENP , PLAF_RESINEUV) * TX20/100) -RRESINEUV1-RRESINEUV2-RRESINEUV3-RRESINEUV4-RRESINEUV5-RRESINEUV6-RRESINEUV7-RRESINEUV7 ;

REPINVMEUBLE = RRESINEUV1 + RRESINEUV2 + RRESINEUV3 + RRESINEUV4 + RRESINEUV5 + RRESINEUV6 + RRESINEUV7 + RRESINEUV8 ;

RESIVIEU1 = arr(arr( min(RESIVIEU , PLAF_RESINEUV) / 9) * TX25/100) ;
RESIVIEU2 = arr(arr( min(RESIVIEU , PLAF_RESINEUV) / 9) * TX25/100) ;
RESIVIEU3 = arr(arr( min(RESIVIEU , PLAF_RESINEUV) / 9) * TX25/100) ;
RESIVIEU4 = arr(arr( min(RESIVIEU , PLAF_RESINEUV) / 9) * TX25/100) ;
RESIVIEU5 = arr(arr( min(RESIVIEU , PLAF_RESINEUV) / 9) * TX25/100) ;
RESIVIEU6 = arr(arr( min(RESIVIEU , PLAF_RESINEUV) / 9) * TX25/100) ;
RESIVIEU7 = arr(arr( min(RESIVIEU , PLAF_RESINEUV) / 9) * TX25/100) ;
RESIVIEU8 = arr(min(RESIVIEU , PLAF_RESINEUV) * TX25/100) -RESIVIEU1-RESIVIEU2-RESIVIEU3-RESIVIEU4-RESIVIEU5-RESIVIEU6-RESIVIEU7-RESIVIEU7 ;

REPINVIEU = RESIVIEU1 + RESIVIEU2 + RESIVIEU3 + RESIVIEU4 + RESIVIEU5 + RESIVIEU6 + RESIVIEU7 + RESIVIEU8 ;

RESIVIAN1 = arr(arr( min(RESIVIANT , PLAF_RESINEUV) / 9) * TX25/100) ;
RESIVIAN2 = arr(arr( min(RESIVIANT , PLAF_RESINEUV) / 9) * TX25/100) ;
RESIVIAN3 = arr(arr( min(RESIVIANT , PLAF_RESINEUV) / 9) * TX25/100) ;
RESIVIAN4 = arr(arr( min(RESIVIANT , PLAF_RESINEUV) / 9) * TX25/100) ;
RESIVIAN5 = arr(arr( min(RESIVIANT , PLAF_RESINEUV) / 9) * TX25/100) ;
RESIVIAN6 = arr(arr( min(RESIVIANT , PLAF_RESINEUV) / 9) * TX25/100) ;
RESIVIAN7 = arr(arr( min(RESIVIANT , PLAF_RESINEUV) / 9) * TX25/100) ;
RESIVIAN8 = arr(min(RESIVIANT , PLAF_RESINEUV) * TX25/100) -RESIVIAN1-RESIVIAN2-RESIVIAN3-RESIVIAN4-RESIVIAN5-RESIVIAN6-RESIVIAN7-RESIVIAN7 ;

REPINVIAN = RESIVIAN1 + RESIVIAN2 + RESIVIAN3 + RESIVIAN4 + RESIVIAN5 + RESIVIAN6 + RESIVIAN7 + RESIVIAN8 ;

RESIMEUB1 = arr(arr(min(DRESIMEUB , PLAF_RESINEUV) / 9) * TX25/100) ;
RESIMEUB2 = arr(arr(min(DRESIMEUB , PLAF_RESINEUV) / 9) * TX25/100) ;
RESIMEUB3 = arr(arr(min(DRESIMEUB , PLAF_RESINEUV) / 9) * TX25/100) ;
RESIMEUB4 = arr(arr(min(DRESIMEUB , PLAF_RESINEUV) / 9) * TX25/100) ;
RESIMEUB5 = arr(arr(min(DRESIMEUB , PLAF_RESINEUV) / 9) * TX25/100) ;
RESIMEUB6 = arr(arr(min(DRESIMEUB , PLAF_RESINEUV) / 9) * TX25/100) ;
RESIMEUB7 = arr(arr(min(DRESIMEUB , PLAF_RESINEUV) / 9) * TX25/100) ;
RESIMEUB8 = arr(min(DRESIMEUB , PLAF_RESINEUV) * TX25/100) -RESIMEUB1-RESIMEUB2-RESIMEUB3-RESIMEUB4-RESIMEUB5-RESIMEUB6-RESIMEUB7-RESIMEUB7 ;

REPMEUB = RESIMEUB1 + RESIMEUB2 + RESIMEUB3 + RESIMEUB4 + RESIMEUB5 + RESIMEUB6 + RESIMEUB7 + RESIMEUB8 ;

MEUBLERED = (REDMEUBLE - RREDMEUB) * ((V_REGCO+0) dans (1,3,5,6)) ;

REPINVRED = (INVREDMEU - RINVRED) * ((V_REGCO+0) dans (1,3,5,6)) ; 

REPREDREP = (REDREPNPRO - RREDREP) * ((V_REGCO+0) dans (1,3,5,6)) ;

REPRETREP = REPRESIVIEU + MEUBLEREP + REPMEUIK ;

REPLOCN2 = (REPRESIMEUB + REPMEUIK + REPMEUIQ + REPMEUIR + RESIVIEUREP + REPMEUIC) * ((V_REGCO+0) dans (1,3,5,6)) ;

REPLOCN1 = (REPMEUIP + MEUBLEREP + REPRESIVIEU + REPMEUIB) * ((V_REGCO+0) dans (1,3,5,6)) ;

regle 467034:
application : iliad , batch  ;


DREDMEUB = REDMEUBLE ;

AREDMEUB = DREDMEUB * (1 - V_CNR) * (1 - ART1731BIS) ;


DREDREP = REDREPNPRO ;

AREDREP = DREDREP * (1 - V_CNR) * (1 - ART1731BIS) ;


DILMIX = LOCMEUBIX ;

AILMIX = DILMIX * (1 - V_CNR) * (1 - ART1731BIS) ;


DINVRED = INVREDMEU ;

AINVRED = DINVRED * (1 - V_CNR) * (1 - ART1731BIS) ;


DILMIH = LOCMEUBIH ;

AILMIH = DILMIH * (1 - V_CNR) * (1 - ART1731BIS) ;


DILMIZ = LOCMEUBIZ ;

AILMIZ = DILMIZ * (1 - V_CNR) * (1 - ART1731BIS) ;


DMEUBLE = REPMEUBLE ;

AMEUBLE = DMEUBLE * (1 - V_CNR) * (1 - ART1731BIS) ;

MEUBLERET = arr(DMEUBLE * TX25 / 100) * (1 - V_CNR) ;


DPROREP = INVNPROREP ;

APROREP = DPROREP * (1 - V_CNR) * (1 - ART1731BIS) ;

RETPROREP = arr(DPROREP * TX25 / 100) * (1 - V_CNR) ;


DREPNPRO = INVREPNPRO ;

AREPNPRO = DREPNPRO * (1 - V_CNR) * (1 - ART1731BIS) ;

RETREPNPRO = arr(DREPNPRO * TX25 / 100) * (1 - V_CNR) ;


DREPMEU = INVREPMEU ;

AREPMEU = DREPMEU * (1 - V_CNR) * (1 - ART1731BIS) ;

RETREPMEU = arr(DREPMEU * TX25 / 100) * (1 - V_CNR) ;


DILMIA = LOCMEUBIA ;

AILMIA = DILMIA * (1 - V_CNR) * (1 - ART1731BIS) ;


DILMIB = LOCMEUBIB ;

AILMIB = DILMIB * (1 - V_CNR) * (1 - ART1731BIS) ;


DILMIC = LOCMEUBIC ;

AILMIC = DILMIC * (1 - V_CNR) * (1 - ART1731BIS) ;

regle 497034:
application : iliad , batch  ;


RREDMEUB = max(min( AREDMEUB , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT
			       -RRETU-RDONS-RNOUV-RCELTOT) , 0) * (1 - ART1731BIS) ;

REPMEUIS = AREDMEUB - RREDMEUB ;

regle 477031:
application : iliad , batch  ;


RREDREP = max(min( AREDREP , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT
			     -RRETU-RDONS-RNOUV-RCELTOT-RREDMEUB) , 0) * (1 - ART1731BIS) ;

REPMEUIU = AREDREP - RREDREP ;

regle 477032:
application : iliad , batch  ;


RILMIX = max(min( AILMIX , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT
			      -RRETU-RDONS-RNOUV-RCELTOT-RREDMEUB-RREDREP) , 0) * (1 - ART1731BIS) ;

REPLOCIX = (AILMIX - RILMIX) * ((V_REGCO+0) dans (1,3,5,6)) ;

regle 477033:
application : iliad , batch  ;


RINVRED = max(min( AINVRED , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT
			     -RRETU-RDONS-RNOUV-RCELTOT-RREDMEUB-RREDREP-RILMIX) , 0) * (1 - ART1731BIS) ;

REPMEUIT = AINVRED - RINVRED ;

regle 477034:
application : iliad , batch  ;


RILMIH = max(min( AILMIH , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT
			      -RRETU-RDONS-RNOUV-RCELTOT-RREDMEUB-RREDREP-RILMIX-RINVRED) , 0) * (1 - ART1731BIS) ;

REPLOCIH = (AILMIH - RILMIH) * ((V_REGCO+0) dans (1,3,5,6)) ;

regle 477035:
application : iliad , batch  ;


RILMIZ = max(min( AILMIZ , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT
			      -RRETU-RDONS-RNOUV-RCELTOT-RREDMEUB-RREDREP-RILMIX-RINVRED-RILMIH) , 0) * (1 - ART1731BIS) ;

REPLOCIZ = (AILMIZ - RILMIZ) * ((V_REGCO+0) dans (1,3,5,6)) ;

regle 477036:
application : iliad , batch  ;


RMEUBLE = max(min( MEUBLERET , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT
			       -RRETU-RDONS-RNOUV-RCELTOT-RREDMEUB-RREDREP-RILMIX-RINVRED-RILMIH-RILMIZ) , 0) * (1 - ART1731BIS) ;

REPMEUIK = MEUBLERET - RMEUBLE ;

regle 477037:
application : iliad , batch  ;


RPROREP = max(min( RETPROREP , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT
			       -RRETU-RDONS-RNOUV-RCELTOT-RREDMEUB-RREDREP-RILMIX-RINVRED-RILMIH-RILMIZ-RMEUBLE) , 0) * (1 - ART1731BIS) ;

REPMEUIR = RETPROREP - RPROREP ;

regle 477038:
application : iliad , batch  ;


RREPNPRO = max(min( RETREPNPRO , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT
				 -RRETU-RDONS-RNOUV-RCELTOT-RREDMEUB-RREDREP-RILMIX-RINVRED-RILMIH-RILMIZ-RMEUBLE-RPROREP) , 0)
				 * (1 - ART1731BIS) ;

REPMEUIQ = RETREPNPRO - RREPNPRO ;

regle 477039:
application : iliad , batch  ;


RREPMEU = max(min( RETREPMEU , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT
			       -RRETU-RDONS-RNOUV-RCELTOT-RREDMEUB-RREDREP-RILMIX-RINVRED-RILMIH-RILMIZ-RMEUBLE-RPROREP-RREPNPRO) , 0) 
			       * (1 - ART1731BIS) ;

REPMEUIP = RETREPMEU - RREPMEU ;

regle 477040:
application : iliad , batch  ;


RILMIC = max(min( AILMIC , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RNOUV
			    -RCELTOT-RREDMEUB-RREDREP-RILMIX-RINVRED-RILMIH-RILMIZ-RMEUBLE-RPROREP-RREPNPRO) , 0)
			    * (1 - ART1731BIS) ;

REPMEUIC = AILMIC - RILMIC ;

regle 477041:
application : iliad , batch  ;


RILMIB = max(min( AILMIB , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RNOUV
			    -RCELTOT-RREDMEUB-RREDREP-RILMIX-RINVRED-RILMIH-RILMIZ-RMEUBLE-RPROREP-RREPNPRO-RILMIC) , 0) 
			   * (1 - ART1731BIS) ;

REPMEUIB = AILMIB - RILMIB ;

regle 477042:
application : iliad , batch  ;


RILMIA = max(min( AILMIA , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RNOUV
			    -RCELTOT-RREDMEUB-RREDREP-RILMIX-RINVRED-RILMIH-RILMIZ-RMEUBLE-RPROREP-RREPNPRO-RILMIC-RILMIB) , 0) 
			   * (1 - ART1731BIS) ;

REPMEUIA = AILMIA - RILMIA ;

regle 477050:
application : iliad , batch  ;

REPMEUTOT1 = REPRESIMEUB + REPMEUIK + REPMEUIQ + REPMEUIR + RESIVIEUREP ;

REPMEUTOT2 = REPMEUIP + MEUBLEREP + REPRESIVIEU ;

regle 407034:
application : iliad , batch  ;
BSOCREP = min ( RSOCREPRISE , LIM_SOCREPR *(1+BOOL_0AM) ) * (1 - ART1731BIS) ;
RSOCREP = arr ( TX_SOCREPR/100 * BSOCREP ) * (1 - V_CNR);
DSOCREPR = RSOCREPRISE;
ASOCREPR = BSOCREP * (1-V_CNR)  ;
RSOCREPR = max( min( RSOCREP , IDOM11-DEC11-RCOTFOR-RREPA-RFIPDOM-RAIDE-RDIFAGRI-RFORET-RFIPC-RCINE-RRESTIMO) , 0 );

regle 4070153:
application : iliad , batch  ;

DRESTIMO = RIMOSAUVANT + RIMOPPAUANT + RESTIMOPPAU + RESTIMOSAUV + RIMOPPAURE + RIMOSAUVRF ;

RESTIMOD = min(RIMOSAUVANT , LIM_RESTIMO) ;

RESTIMOB = min (RESTIMOSAUV , LIM_RESTIMO - RESTIMOD) ;

RESTIMOC = min(RIMOPPAUANT , LIM_RESTIMO - RESTIMOD - RESTIMOB) ;

RESTIMOF = min(RIMOSAUVRF , LIM_RESTIMO - RESTIMOD - RESTIMOB - RESTIMOC) ;

RESTIMOA = min(RESTIMOPPAU , LIM_RESTIMO - RESTIMOD - RESTIMOB - RESTIMOC - RESTIMOF) ;

RESTIMOE = min(RIMOPPAURE , LIM_RESTIMO - RESTIMOD - RESTIMOB - RESTIMOC - RESTIMOF - RESTIMOA) ;

ARESTIMO = (RESTIMOD + RESTIMOB + RESTIMOC + RESTIMOF + RESTIMOA + RESTIMOE) * (1 - V_CNR) 
									     * (1 - ART1731BIS);

RETRESTIMO = arr((RESTIMOD * TX40/100) + (RESTIMOB * TX36/100)
		 + (RESTIMOC * TX30/100) + (RESTIMOA * TX_RESTIMO1/100)
		 + (RESTIMOE * TX22/100) + (RESTIMOF * TX30/100)) * (1 - V_CNR) * (1 - ART1731BIS) ;

RRESTIMO = max (min (RETRESTIMO , IDOM11-DEC11-RCOTFOR-RREPA-RFIPDOM-RAIDE-RDIFAGRI-RFORET-RFIPC-RCINE) , 0) ;

regle 4070161:
application : iliad , batch  ;
REVDON = max(0,RBL+TOTALQUO-SDD-SDC1) ;
BON = arr (min (RDFDOU+RDFDAUTRE+REPDON03+REPDON04+REPDON05+REPDON06+REPDON07,REVDON *(TX_BASEDUP)/100));
REPDON = max(RDFDOU + RDFDAUTRE + REPDON03 + REPDON04 + REPDON05 + REPDON06 + REPDON07 
	      - arr(REVDON * (TX_BASEDUP)/100),0)*(1-V_CNR);

REPDONR5 = max(REPDON03 - arr(REVDON * (TX_BASEDUP)/100),0)*(1-V_CNR);

REPDONR4 = (positif_ou_nul(REPDON03 - arr(REVDON * (TX_BASEDUP)/100)) * REPDON04
	  + (1 - positif_ou_nul(REPDON03 - arr(REVDON * (TX_BASEDUP)/100))) 
	   * max(REPDON04 + (REPDON03 - arr(REVDON * (TX_BASEDUP)/100)),0))
	   * (1 - V_CNR);

REPDONR3 = (positif_ou_nul(REPDON03 + REPDON04 - arr(REVDON * (TX_BASEDUP)/100)) * REPDON05 
          + (1 - positif_ou_nul(REPDON03 + REPDON04 - arr(REVDON * (TX_BASEDUP)/100)))
	  * max(REPDON05 + (REPDON03 + REPDON04 - arr(REVDON * (TX_BASEDUP)/100)),0))
	   * (1 - V_CNR);

REPDONR2 = (positif_ou_nul(REPDON03 + REPDON04 + REPDON05 - arr(REVDON * (TX_BASEDUP)/100)) * REPDON06
	  + (1 - positif_ou_nul(REPDON03 + REPDON04 + REPDON05 - arr(REVDON * (TX_BASEDUP)/100)))
	  * max(REPDON06 + (REPDON03 + REPDON04 + REPDON05 - arr(REVDON * (TX_BASEDUP)/100)),0))
	   * (1 - V_CNR);

REPDONR1 = (positif_ou_nul(REPDON03 + REPDON04 + REPDON05 + REPDON06 - arr(REVDON * (TX_BASEDUP)/100)) * REPDON07
	  + (1 - positif_ou_nul(REPDON03 + REPDON04 + REPDON05 + REPDON06 - arr(REVDON * (TX_BASEDUP)/100)))
	  * max(REPDON07 + (REPDON03 + REPDON04 + REPDON05 + REPDON06 - arr(REVDON * (TX_BASEDUP)/100)),0))
	   * (1 - V_CNR);

REPDONR = max(REPDON - REPDONR1 - REPDONR2 - REPDONR3 - REPDONR4 - REPDONR5,0)*(1-V_CNR);

regle 407016:
application : iliad , batch  ;
RON = arr( BON *(TX_REDDON)/100 ) * ((V_REGCO+0) dans (1,3,5,6)) * (1 - ART1731BIS) ;

DDONS = RDDOUP + DONAUTRE + REPDON03 + REPDON04 + REPDON05 + REPDON06 + REPDON07 ;
ADONS = BON * ((V_REGCO+0) dans (1,3,5,6)) * (1 - ART1731BIS) ;
regle 33407016:
application : iliad , batch  ;

RDONS = max( min( RON , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP
			-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU) , 0 );

regle 4082 :
application : iliad, batch ;



DLOGDOM = INVLOG2008 + INVLGDEB2009 + INVLGDEB + INVLGAUTRE + INVLGDEB2010 + INVLOG2009 
	  + INVOMLOGOA + INVOMLOGOB + INVOMLOGOC + INVOMLOGOH + INVOMLOGOI + INVOMLOGOJ 
	  + INVOMLOGOK + INVOMLOGOL + INVOMLOGOM + INVOMLOGON + INVOMLOGOO + INVOMLOGOP
	  + INVOMLOGOQ + INVOMLOGOR + INVOMLOGOS + INVOMLOGOT + INVOMLOGOU + INVOMLOGOV + INVOMLOGOW ;


DDOMSOC1 = INVSOCNRET + INVOMSOCKH + INVOMSOCKI + INVSOC2010 + INVOMSOCQU + INVLOGSOC ;

DLOGSOC = INVOMSOCQJ + INVOMSOCQS + INVOMSOCQW + INVOMSOCQX ;


DCOLENT = INVOMREP + NRETROC50 + NRETROC40 + INVENDI + INVOMENTMN + RETROCOMLH + RETROCOMMB
	  + INVOMENTKT + RETROCOMLI + RETROCOMMC + INVOMENTKU + INVOMQV + INVENDEB2009 + INVRETRO1 
	  + INVRETRO2 + INVIMP + INVDOMRET50 + INVDOMRET60 + INVDIR2009 + INVOMRETPA + INVOMRETPB 
	  + INVOMRETPD + INVOMRETPE + INVOMRETPF + INVOMRETPH + INVOMRETPI + INVOMRETPJ + INVOMRETPL ;

DLOCENT = INVOMRETPM + INVOMRETPN + INVOMRETPO + INVOMRETPP + INVOMRETPQ + INVOMRETPS + INVOMRETPT
	  + INVOMRETPU + INVOMRETPV + INVOMRETPX + INVOMRETPY + INVOMENTRG + INVOMENTRH + INVOMENTRJ 
	  + INVOMENTRK + INVOMENTRL + INVOMENTRM + INVOMENTRN + INVOMENTRP + INVOMENTRQ + INVOMENTRR 
	  + INVOMENTRS + INVOMENTRU + INVOMENTRV + INVOMENTRW + INVOMENTRX + INVOMENTNU + INVOMENTNV 
	  + INVOMENTNW + INVOMENTNX ;

regle 4000 :
application : iliad, batch ;


TOTALPLAF1 = INVRETKG + INVRETKH + INVRETKI + INVRETQN + INVRETQU + INVRETQK + INVRETQJ + INVRETQS + INVRETQW + INVRETQX 
	    + INVRETMA + INVRETLG + INVRETMB + INVRETLH + INVRETMC + INVRETLI + INVRETQP + INVRETQG + INVRETQO + INVRETQF  
	    + INVRETPO + INVRETPT + INVRETPN + INVRETPS + INVRETPP + INVRETPU + INVRETKS + INVRETKT + INVRETKU + INVRETQR 
	    + INVRETQI + INVRETPR + INVRETPW + INVRETQL + INVRETQM + INVRETQD + INVRETOB + INVRETOC + INVRETOM + INVRETON  
	    + INVRETKGR + INVRETKHR + INVRETKIR + INVRETQNR + INVRETQUR + INVRETQKR + INVRETQJR + INVRETQSR + INVRETQWR
	    + INVRETQXR + INVRETMAR + INVRETLGR + INVRETMBR + INVRETLHR + INVRETMCR + INVRETLIR + INVRETQPR + INVRETQGR 
	    + INVRETQOR + INVRETQFR + INVRETPOR + INVRETPTR + INVRETPNR + INVRETPSR ;

TOTALPLAF2 = INVRETPB + INVRETPF + INVRETPJ + INVRETPA + INVRETPE + INVRETPI + INVRETPY + INVRETPX + INVRETRG + INVRETPD 
	     + INVRETPH + INVRETPL + INVRETRI + INVRETOI + INVRETOJ + INVRETOK + INVRETOP + INVRETOQ + INVRETOQ
	     + INVRETPBR + INVRETPFR + INVRETPJR + INVRETPAR + INVRETPER + INVRETPIR + INVRETPYR + INVRETPXR ;

TOTALPLAF3 = INVRETRL + INVRETRQ + INVRETRV + INVRETNV + INVRETRK + INVRETRP + INVRETRU + INVRETNU + INVRETRM + INVRETRR 
	     + INVRETRW + INVRETNW + INVRETRO + INVRETRT + INVRETRY + INVRETNY + INVRETOT + INVRETOU + INVRETOV + INVRETOW 
	     + INVRETRLR + INVRETRQR + INVRETRVR + INVRETNVR + INVRETRKR + INVRETRPR + INVRETRUR + INVRETNUR ;

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

INVRETMAA = min(arr(NINVRETMA * TX40 / 100) , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA
							      -INVRETQXA)) * (1 - V_CNR) ;

INVRETLGA = min(arr(NINVRETLG * TX50 / 100) , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA
						              -INVRETQXA-INVRETMAA)) * (1 - V_CNR) ;

INVRETMBA = min(arr(NINVRETMB * TX40 / 100) , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA
						              -INVRETQXA-INVRETMAA-INVRETLGA)) * (1 - V_CNR) ;

INVRETMCA = min(arr(NINVRETMC * TX40 / 100) , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA
						              -INVRETQXA-INVRETMAA-INVRETLGA-INVRETMBA)) * (1 - V_CNR) ;

INVRETLHA = min(arr(NINVRETLH * TX50 / 100) , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA
						              -INVRETQXA-INVRETMAA-INVRETLGA-INVRETMBA-INVRETMCA)) * (1 - V_CNR) ;

INVRETLIA = min(arr(NINVRETLI * TX50 / 100) , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA
						              -INVRETQXA-INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA)) * (1 - V_CNR) ;

INVRETQPA = min(arr(NINVRETQP * TX40 / 100) , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA
						              -INVRETQXA-INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA)) * (1 - V_CNR) ;

INVRETQGA = min(arr(NINVRETQG * TX40 / 100) , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA
						              -INVRETQXA-INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA)) * (1 - V_CNR) ;

INVRETQOA = min(arr(NINVRETQO * TX50 / 100) , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA
						              -INVRETQXA-INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA)) 
							      * (1 - V_CNR) ;

INVRETQFA = min(arr(NINVRETQF * TX50 / 100) , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA
						              -INVRETQXA-INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA 
							      -INVRETQOA)) * (1 - V_CNR) ;

INVRETPOA = min(arr(NINVRETPO * TX40 / 100) , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA
						              -INVRETQXA-INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA 
							      -INVRETQOA-INVRETQFA)) * (1 - V_CNR) ;

INVRETPTA = min(arr(NINVRETPT * TX40 / 100) , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA
						              -INVRETQXA-INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA 
							      -INVRETQOA-INVRETQFA-INVRETPOA)) * (1 - V_CNR) ;

INVRETPNA = min(arr(NINVRETPN * TX50 / 100) , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA
						              -INVRETQXA-INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA 
							      -INVRETQOA-INVRETQFA-INVRETPOA-INVRETPTA)) * (1 - V_CNR) ;

INVRETPSA = min(arr(NINVRETPS * TX50 / 100) , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA
						              -INVRETQXA-INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA 
							      -INVRETQOA-INVRETQFA-INVRETPOA-INVRETPTA-INVRETPNA)) * (1 - V_CNR) ;

INVRETPPA = min(NINVRETPP , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					    -INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA
					    -INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA)) * (1 - V_CNR) ;

INVRETPUA = min(NINVRETPU , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					    -INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA
					    -INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA)) * (1 - V_CNR) ;

INVRETKSA = min(NINVRETKS , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					    -INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA
					    -INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA)) * (1 - V_CNR) ;

INVRETKTA = min(NINVRETKT , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					    -INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA 
					    -INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETKSA)) * (1 - V_CNR) ;

INVRETKUA = min(NINVRETKU , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					    -INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA 
					    -INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETKSA-INVRETKTA)) * (1 - V_CNR) ;

INVRETQRA = min(NINVRETQR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					    -INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA 
					    -INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETKSA-INVRETKTA-INVRETKUA)) * (1 - V_CNR) ;

INVRETQIA = min(NINVRETQI , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					    -INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA 
					    -INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETKSA-INVRETKTA-INVRETKUA-INVRETQRA)) * (1 - V_CNR) ;

INVRETPRA = min(NINVRETPR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					    -INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA 
					    -INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETKSA-INVRETKTA-INVRETKUA-INVRETQRA
					    -INVRETQIA)) * (1 - V_CNR) ;

INVRETPWA = min(NINVRETPW , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					    -INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA 
					    -INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETKSA-INVRETKTA-INVRETKUA-INVRETQRA
					    -INVRETQIA-INVRETPRA)) * (1 - V_CNR) ;

INVRETQLA = min(NINVRETQL , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					    -INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA 
					    -INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETKSA-INVRETKTA-INVRETKUA-INVRETQRA
					    -INVRETQIA-INVRETPRA-INVRETPWA)) * (1 - V_CNR) ;

INVRETQMA = min(NINVRETQM , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					    -INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA 
					    -INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETKSA-INVRETKTA-INVRETKUA-INVRETQRA
					    -INVRETQIA-INVRETPRA-INVRETPWA-INVRETQLA)) * (1 - V_CNR) ;

INVRETQDA = min(NINVRETQD , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					    -INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA 
					    -INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETKSA-INVRETKTA-INVRETKUA-INVRETQRA
					    -INVRETQIA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA)) * (1 - V_CNR) ;

INVRETOBA = min(NINVRETOB , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA 
					    -INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA 
					    -INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETKSA-INVRETKTA-INVRETKUA-INVRETQRA
					    -INVRETQIA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA)) * (1 - V_CNR) ;

INVRETOCA = min(NINVRETOC , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					    -INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA 
					    -INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETKSA-INVRETKTA-INVRETKUA-INVRETQRA
					    -INVRETQIA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA-INVRETOBA)) * (1 - V_CNR) ;

INVRETOMA = min(NINVRETOM , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					    -INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA 
					    -INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETKSA-INVRETKTA-INVRETKUA-INVRETQRA
					    -INVRETQIA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA-INVRETOBA-INVRETOCA)) * (1 - V_CNR) ;

INVRETONA = min(NINVRETON , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					    -INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA 
					    -INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETKSA-INVRETKTA-INVRETKUA-INVRETQRA
					    -INVRETQIA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA-INVRETOBA-INVRETOCA-INVRETOMA)) * (1 - V_CNR) ;

INVRETKGRA = min(NINVRETKGR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA 
					      -INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA 
					      -INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETKSA-INVRETKTA-INVRETKUA-INVRETQRA
					      -INVRETQIA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA-INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA)) * (1 - V_CNR) ;

INVRETKHRA = min(NINVRETKHR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA 
					      -INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA 
					      -INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETKSA-INVRETKTA-INVRETKUA-INVRETQRA
					      -INVRETQIA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA-INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA
					      -INVRETKGRA)) * (1 - V_CNR) ;

INVRETKIRA = min(NINVRETKIR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA 
					      -INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA 
					      -INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETKSA-INVRETKTA-INVRETKUA-INVRETQRA
					      -INVRETQIA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA-INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA
					      -INVRETKGRA-INVRETKHRA)) * (1 - V_CNR) ;

INVRETQNRA = min(NINVRETQNR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					      -INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA 
					      -INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETKSA-INVRETKTA-INVRETKUA-INVRETQRA
					      -INVRETQIA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA-INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA
					      -INVRETKGRA-INVRETKHRA-INVRETKIRA)) * (1 - V_CNR) ;

INVRETQURA = min(NINVRETQUR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA 
					      -INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA 
					      -INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETKSA-INVRETKTA-INVRETKUA-INVRETQRA
					      -INVRETQIA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA-INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA
					      -INVRETKGRA-INVRETKHRA-INVRETKIRA-INVRETQNRA)) * (1 - V_CNR) ;

INVRETQKRA = min(NINVRETQKR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					      -INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA 
					      -INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETKSA-INVRETKTA-INVRETKUA-INVRETQRA
					      -INVRETQIA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA-INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA
					      -INVRETKGRA-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA)) * (1 - V_CNR) ;

INVRETQJRA = min(NINVRETQJR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					      -INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA 
					      -INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETKSA-INVRETKTA-INVRETKUA-INVRETQRA
					      -INVRETQIA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA-INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA
					      -INVRETKGRA-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA)) * (1 - V_CNR) ;

INVRETQSRA = min(NINVRETQSR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					      -INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA 
					      -INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETKSA-INVRETKTA-INVRETKUA-INVRETQRA
					      -INVRETQIA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA-INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA
					      -INVRETKGRA-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA-INVRETQJRA)) * (1 - V_CNR) ;

INVRETQWRA = min(NINVRETQWR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					      -INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA 
					      -INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETKSA-INVRETKTA-INVRETKUA-INVRETQRA
					      -INVRETQIA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA-INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA
					      -INVRETKGRA-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA-INVRETQJRA-INVRETQSRA)) * (1 - V_CNR) ;

INVRETQXRA = min(NINVRETQXR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					      -INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA 
					      -INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETKSA-INVRETKTA-INVRETKUA-INVRETQRA
					      -INVRETQIA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA-INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA
					      -INVRETKGRA-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA)) * (1 - V_CNR) ;

INVRETMARA = min(NINVRETMAR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA 
					      -INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA 
					      -INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETKSA-INVRETKTA-INVRETKUA-INVRETQRA
					      -INVRETQIA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA-INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA
					      -INVRETKGRA-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA
					      -INVRETQXRA)) * (1 - V_CNR) ;

INVRETLGRA = min(NINVRETLGR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					      -INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA 
					      -INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETKSA-INVRETKTA-INVRETKUA-INVRETQRA
					      -INVRETQIA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA-INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA
					      -INVRETKGRA-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA
					      -INVRETQXRA-INVRETMARA)) * (1 - V_CNR) ;

INVRETMBRA = min(NINVRETMBR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA 
					      -INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA 
					      -INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETKSA-INVRETKTA-INVRETKUA-INVRETQRA
					      -INVRETQIA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA-INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA
					      -INVRETKGRA-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA
					      -INVRETQXRA-INVRETMARA-INVRETLGRA)) * (1 - V_CNR) ;

INVRETMCRA = min(NINVRETMCR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA 
					      -INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA 
					      -INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETKSA-INVRETKTA-INVRETKUA-INVRETQRA
					      -INVRETQIA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA-INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA
					      -INVRETKGRA-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA
					      -INVRETQXRA-INVRETMARA-INVRETLGRA-INVRETMBRA)) * (1 - V_CNR) ;

INVRETLHRA = min(NINVRETLHR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					      -INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA 
					      -INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETKSA-INVRETKTA-INVRETKUA-INVRETQRA
					      -INVRETQIA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA-INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA
					      -INVRETKGRA-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA
					      -INVRETQXRA-INVRETMARA-INVRETLGRA-INVRETMBRA-INVRETMCRA)) * (1 - V_CNR) ;

INVRETLIRA = min(NINVRETLIR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA 
					      -INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA 
					      -INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETKSA-INVRETKTA-INVRETKUA-INVRETQRA
					      -INVRETQIA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA-INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA
					      -INVRETKGRA-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA
					      -INVRETQXRA-INVRETMARA-INVRETLGRA-INVRETMBRA-INVRETMCRA-INVRETLHRA)) * (1 - V_CNR) ;

INVRETQPRA = min(NINVRETQPR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					      -INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA 
					      -INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETKSA-INVRETKTA-INVRETKUA-INVRETQRA
					      -INVRETQIA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA-INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA
					      -INVRETKGRA-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA
					      -INVRETQXRA-INVRETMARA-INVRETLGRA-INVRETMBRA-INVRETLHRA-INVRETLIRA-INVRETMCRA)) * (1 - V_CNR) ;

INVRETQGRA = min(NINVRETQGR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					      -INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA 
					      -INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETKSA-INVRETKTA-INVRETKUA-INVRETQRA
					      -INVRETQIA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA-INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA
					      -INVRETKGRA-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA
					      -INVRETQXRA-INVRETMARA-INVRETLGRA-INVRETMBRA-INVRETLHRA-INVRETLIRA-INVRETMCRA-INVRETQPRA)) * (1 - V_CNR) ;

INVRETQORA = min(NINVRETQOR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					      -INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA 
					      -INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETKSA-INVRETKTA-INVRETKUA-INVRETQRA
					      -INVRETQIA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA-INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA
					      -INVRETKGRA-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA
					      -INVRETQXRA-INVRETMARA-INVRETLGRA-INVRETMBRA-INVRETLHRA-INVRETLIRA-INVRETMCRA-INVRETQPRA-INVRETQGRA)) * (1 - V_CNR) ;

INVRETQFRA = min(NINVRETQFR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					      -INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA 
					      -INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETKSA-INVRETKTA-INVRETKUA-INVRETQRA
					      -INVRETQIA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA-INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA
					      -INVRETKGRA-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA
					      -INVRETQXRA-INVRETMARA-INVRETLGRA-INVRETMBRA-INVRETLHRA-INVRETLIRA-INVRETMCRA-INVRETQPRA-INVRETQGRA
					      -INVRETQORA)) * (1 - V_CNR) ;

INVRETPORA = min(NINVRETPOR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					      -INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA 
					      -INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETKSA-INVRETKTA-INVRETKUA-INVRETQRA
					      -INVRETQIA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA-INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA
					      -INVRETKGRA-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA
					      -INVRETQXRA-INVRETMARA-INVRETLGRA-INVRETMBRA-INVRETLHRA-INVRETLIRA-INVRETMCRA-INVRETQPRA-INVRETQGRA
					      -INVRETQORA-INVRETQFRA)) * (1 - V_CNR) ;

INVRETPTRA = min(NINVRETPTR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					      -INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA 
					      -INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETKSA-INVRETKTA-INVRETKUA-INVRETQRA
					      -INVRETQIA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA-INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA
					      -INVRETKGRA-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA
					      -INVRETQXRA-INVRETMARA-INVRETLGRA-INVRETMBRA-INVRETLHRA-INVRETLIRA-INVRETMCRA-INVRETQPRA-INVRETQGRA
					      -INVRETQORA-INVRETQFRA-INVRETPORA)) * (1 - V_CNR) ;

INVRETPNRA = min(NINVRETPNR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					      -INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA 
					      -INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETKSA-INVRETKTA-INVRETKUA-INVRETQRA
					      -INVRETQIA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA-INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA
					      -INVRETKGRA-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA
					      -INVRETQXRA-INVRETMARA-INVRETLGRA-INVRETMBRA-INVRETLHRA-INVRETLIRA-INVRETMCRA-INVRETQPRA-INVRETQGRA
					      -INVRETQORA-INVRETQFRA-INVRETPORA-INVRETPTRA)) * (1 - V_CNR) ;

INVRETPSRA = min(NINVRETPSR , max(0 , RNIDOM1 -INVRETKGA-INVRETKHA-INVRETKIA-INVRETQNA-INVRETQUA-INVRETQKA-INVRETQJA-INVRETQSA-INVRETQWA-INVRETQXA
					      -INVRETMAA-INVRETLGA-INVRETMBA-INVRETLHA-INVRETMCA-INVRETLIA-INVRETQPA-INVRETQGA-INVRETQOA-INVRETQFA 
					      -INVRETPOA-INVRETPTA-INVRETPNA-INVRETPSA-INVRETPPA-INVRETPUA-INVRETKSA-INVRETKTA-INVRETKUA-INVRETQRA
					      -INVRETQIA-INVRETPRA-INVRETPWA-INVRETQLA-INVRETQMA-INVRETQDA-INVRETOBA-INVRETOCA-INVRETOMA-INVRETONA
					      -INVRETKGRA-INVRETKHRA-INVRETKIRA-INVRETQNRA-INVRETQURA-INVRETQKRA-INVRETQJRA-INVRETQSRA-INVRETQWRA
					      -INVRETQXRA-INVRETMARA-INVRETLGRA-INVRETMBRA-INVRETLHRA-INVRETLIRA-INVRETMCRA-INVRETQPRA-INVRETQGRA
					      -INVRETQORA-INVRETQFRA-INVRETPORA-INVRETPTRA-INVRETPNRA)) * (1 - V_CNR) ;

TOTALPLAFA = INVRETKGA + INVRETKHA + INVRETKIA + INVRETQNA + INVRETQUA + INVRETQKA + INVRETQJA + INVRETQSA + INVRETQWA + INVRETQXA + INVRETMAA + INVRETLGA 
	     + INVRETMBA + INVRETLHA + INVRETMCA + INVRETLIA + INVRETQPA + INVRETQGA + INVRETQOA + INVRETQFA + INVRETPOA + INVRETPTA + INVRETPNA + INVRETPSA 
	     + INVRETPPA + INVRETPUA + INVRETKSA + INVRETKTA + INVRETKUA + INVRETQRA + INVRETQIA + INVRETPRA + INVRETPWA + INVRETQLA + INVRETQMA + INVRETQDA 
	     + INVRETOBA + INVRETOCA + INVRETOMA + INVRETONA + INVRETKGRA + INVRETKHRA + INVRETKIRA + INVRETQNRA + INVRETQURA + INVRETQKRA + INVRETQJRA 
	     + INVRETQSRA + INVRETQWRA + INVRETQXRA + INVRETMARA + INVRETLGRA + INVRETMBRA + INVRETLHRA + INVRETLIRA + INVRETMCRA + INVRETQPRA + INVRETQGRA 
	     + INVRETQORA + INVRETQFRA + INVRETPORA + INVRETPTRA + INVRETPNRA + INVRETPSRA ;

INDPLAF2 = positif(RNIDOM2 - TOTALPLAF2 - TOTALPLAFA) ;


INVRETPBA = min(arr(NINVRETPB*TX375/100) , max(0,RNIDOM2 - TOTALPLAFA)) * (1 - V_CNR) ; 

INVRETPFA = min(arr(NINVRETPF*TX375/100) , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA)) * (1 - V_CNR) ;

INVRETPJA = min(arr(NINVRETPJ*TX375/100) , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA)) * (1 - V_CNR) ;

INVRETPAA = min(arr(NINVRETPA*TX4737/100) , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA)) * (1 - V_CNR) ;

INVRETPEA = min(arr(NINVRETPE*TX4737/100) , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA- INVRETPAA)) * (1 - V_CNR) ;

INVRETPIA = min(arr(NINVRETPI*TX4737/100) , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA)) * (1 - V_CNR) ;

INVRETPYA = min(arr(NINVRETPY*TX375/100) , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA)) * (1 - V_CNR) ;

INVRETPXA = min(arr(NINVRETPX*TX4737/100) , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPYA)) * (1 - V_CNR) ;

INVRETRGA = min(NINVRETRG , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPYA-INVRETPXA)) * (1 - V_CNR) ;

INVRETPDA = min(NINVRETPD , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPYA-INVRETPXA-INVRETRGA)) * (1 - V_CNR) ;

INVRETPHA = min(NINVRETPH , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPYA-INVRETPXA-INVRETRGA 
								-INVRETPDA)) * (1 - V_CNR) ;

INVRETPLA = min(NINVRETPL , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPYA-INVRETPXA-INVRETRGA 
								-INVRETPDA-INVRETPHA)) * (1 - V_CNR) ;

INVRETRIA = min(NINVRETRI , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPYA-INVRETPXA-INVRETRGA 
								-INVRETPDA-INVRETPHA-INVRETPLA)) * (1 - V_CNR) ;

INVRETOIA = min(NINVRETOI , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPYA-INVRETPXA-INVRETRGA 
								-INVRETPDA-INVRETPHA-INVRETPLA-INVRETRIA)) * (1 - V_CNR) ;

INVRETOJA = min(NINVRETOJ , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPYA-INVRETPXA-INVRETRGA 
								-INVRETPDA-INVRETPHA-INVRETPLA-INVRETRIA-INVRETOIA)) * (1 - V_CNR) ;

INVRETOKA = min(NINVRETOK , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPYA-INVRETPXA-INVRETRGA 
								-INVRETPDA-INVRETPHA-INVRETPLA-INVRETRIA-INVRETOIA-INVRETOJA)) * (1 - V_CNR) ;

INVRETOPA = min(NINVRETOP , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPYA-INVRETPXA-INVRETRGA 
								-INVRETPDA-INVRETPHA-INVRETPLA-INVRETRIA-INVRETOIA-INVRETOJA-INVRETOKA)) * (1 - V_CNR) ;

INVRETOQA = min(NINVRETOQ , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPYA-INVRETPXA-INVRETRGA 
								-INVRETPDA-INVRETPHA-INVRETPLA-INVRETRIA-INVRETOIA-INVRETOJA-INVRETOKA-INVRETOPA)) * (1 - V_CNR) ;

INVRETORA = min(NINVRETOR , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPYA-INVRETPXA-INVRETRGA 
								-INVRETPDA-INVRETPHA-INVRETPLA-INVRETRIA-INVRETOIA-INVRETOJA-INVRETOKA-INVRETOPA-INVRETOQA)) * (1 - V_CNR) ;

INVRETPBRA = min(NINVRETPBR , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPYA-INVRETPXA-INVRETRGA 
								  -INVRETPDA-INVRETPHA-INVRETPLA-INVRETRIA-INVRETOIA-INVRETOJA-INVRETOKA-INVRETOPA-INVRETOQA
								  -INVRETORA)) * (1 - V_CNR) ;

INVRETPFRA = min(NINVRETPFR , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPYA-INVRETPXA-INVRETRGA 
								  -INVRETPDA-INVRETPHA-INVRETPLA-INVRETRIA-INVRETOIA-INVRETOJA-INVRETOKA-INVRETOPA-INVRETOQA
								  -INVRETORA-INVRETPBRA)) * (1 - V_CNR) ;

INVRETPJRA = min(NINVRETPJR , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPYA-INVRETPXA-INVRETRGA 
								  -INVRETPDA-INVRETPHA-INVRETPLA-INVRETRIA-INVRETOIA-INVRETOJA-INVRETOKA-INVRETOPA-INVRETOQA
								  -INVRETORA-INVRETPBRA-INVRETPFRA)) * (1 - V_CNR) ;

INVRETPARA = min(NINVRETPAR , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPYA-INVRETPXA-INVRETRGA 
								  -INVRETPDA-INVRETPHA-INVRETPLA-INVRETRIA-INVRETOIA-INVRETOJA-INVRETOKA-INVRETOPA-INVRETOQA
								  -INVRETORA-INVRETPBRA-INVRETPFRA-INVRETPJRA)) * (1 - V_CNR) ;

INVRETPERA = min(NINVRETPER , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPYA-INVRETPXA-INVRETRGA 
								  -INVRETPDA-INVRETPHA-INVRETPLA-INVRETRIA-INVRETOIA-INVRETOJA-INVRETOKA-INVRETOPA-INVRETOQA
								  -INVRETORA-INVRETPBRA-INVRETPFRA-INVRETPJRA-INVRETPARA)) * (1 - V_CNR) ;

INVRETPIRA = min(NINVRETPIR , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPYA-INVRETPXA-INVRETRGA 
								  -INVRETPDA-INVRETPHA-INVRETPLA-INVRETRIA-INVRETOIA-INVRETOJA-INVRETOKA-INVRETOPA-INVRETOQA
								  -INVRETORA-INVRETPBRA-INVRETPFRA-INVRETPJRA-INVRETPARA-INVRETPERA)) * (1 - V_CNR) ;

INVRETPYRA = min(NINVRETPYR , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPYA-INVRETPXA-INVRETRGA 
								  -INVRETPDA-INVRETPHA-INVRETPLA-INVRETRIA-INVRETOIA-INVRETOJA-INVRETOKA-INVRETOPA-INVRETOQA
								  -INVRETORA-INVRETPBRA-INVRETPFRA-INVRETPJRA-INVRETPARA-INVRETPERA-INVRETPIRA)) * (1 - V_CNR) ;

INVRETPXRA = min(NINVRETPXR , max(0 , max(0,RNIDOM2 - TOTALPLAFA) -INVRETPBA-INVRETPFA-INVRETPJA-INVRETPAA-INVRETPEA-INVRETPIA-INVRETPYA-INVRETPXA-INVRETRGA 
								  -INVRETPDA-INVRETPHA-INVRETPLA-INVRETRIA-INVRETOIA-INVRETOJA-INVRETOKA-INVRETOPA-INVRETOQA
								  -INVRETORA-INVRETPBRA-INVRETPFRA-INVRETPJRA-INVRETPARA-INVRETPERA-INVRETPIRA-INVRETPYRA)) * (1 - V_CNR) ;

TOTALPLAFB = INVRETPBA + INVRETPFA + INVRETPJA + INVRETPAA + INVRETPEA + INVRETPIA + INVRETPYA + INVRETPXA + INVRETRGA + INVRETPDA + INVRETPHA 
	     + INVRETPLA + INVRETRIA + INVRETOIA + INVRETOJA + INVRETOKA + INVRETOPA + INVRETOQA + INVRETORA + INVRETPBRA + INVRETPFRA + INVRETPJRA 
	     + INVRETPARA + INVRETPERA + INVRETPIRA + INVRETPYRA + INVRETPXRA ;

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

INVRETOTA = min(NINVRETOT , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									  -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA)) * (1 - V_CNR) ;

INVRETOUA = min(NINVRETOU , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									  -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
									  -INVRETOTA)) * (1 - V_CNR) ;

INVRETOVA = min(NINVRETOV , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									  -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
									  -INVRETOTA-INVRETOUA)) * (1 - V_CNR) ;

INVRETOWA = min(NINVRETOW , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									  -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
									  -INVRETOTA-INVRETOUA-INVRETOVA)) * (1 - V_CNR) ;

INVRETRLRA = min(NINVRETRLR , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									    -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
									    -INVRETOTA-INVRETOUA-INVRETOVA-INVRETOWA)) * (1 - V_CNR) ;

INVRETRQRA = min(NINVRETRQR , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									    -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
									    -INVRETOTA-INVRETOUA-INVRETOVA-INVRETOWA-INVRETRLRA)) * (1 - V_CNR) ;

INVRETRVRA = min(NINVRETRVR , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									    -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
									    -INVRETOTA-INVRETOUA-INVRETOVA-INVRETOWA-INVRETRLRA-INVRETRQRA)) * (1 - V_CNR) ;

INVRETNVRA = min(NINVRETNVR , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									    -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
									    -INVRETOTA-INVRETOUA-INVRETOVA-INVRETOWA-INVRETRLRA-INVRETRQRA-INVRETRVRA)) * (1 - V_CNR) ;

INVRETRKRA = min(NINVRETRKR , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									    -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
									    -INVRETOTA-INVRETOUA-INVRETOVA-INVRETOWA-INVRETRLRA-INVRETRQRA-INVRETRVRA
									    -INVRETNVRA)) * (1 - V_CNR) ;

INVRETRPRA = min(NINVRETRPR , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									    -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
									    -INVRETOTA-INVRETOUA-INVRETOVA-INVRETOWA-INVRETRLRA-INVRETRQRA-INVRETRVRA
									    -INVRETNVRA-INVRETRKRA)) * (1 - V_CNR) ;

INVRETRURA = min(NINVRETRUR , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									    -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
									    -INVRETOTA-INVRETOUA-INVRETOVA-INVRETOWA-INVRETRLRA-INVRETRQRA-INVRETRVRA
									    -INVRETNVRA-INVRETRKRA-INVRETRPRA)) * (1 - V_CNR) ;

INVRETNURA = min(NINVRETNUR , max(0 , max(0,RNIDOM3 -TOTALPLAFA-TOTALPLAFB) -INVRETRLA-INVRETRQA-INVRETRVA-INVRETNVA-INVRETRKA-INVRETRPA-INVRETRUA-INVRETNUA
									    -INVRETRMA-INVRETRRA-INVRETRWA-INVRETNWA-INVRETROA-INVRETRTA-INVRETRYA-INVRETNYA
									    -INVRETOTA-INVRETOUA-INVRETOVA-INVRETOWA-INVRETRLRA-INVRETRQRA-INVRETRVRA
									    -INVRETNVRA-INVRETRKRA-INVRETRPRA-INVRETRURA)) * (1 - V_CNR) ;

TOTALPLAFC = INVRETRLA + INVRETRQA + INVRETRVA + INVRETNVA + INVRETRKA + INVRETRPA + INVRETRUA + INVRETNUA + INVRETRMA + INVRETRRA + INVRETRWA + INVRETNWA 
	     + INVRETROA + INVRETRTA + INVRETRYA + INVRETNYA + INVRETOTA + INVRETOUA + INVRETOVA + INVRETOWA + INVRETRLRA + INVRETRQRA + INVRETRVRA 
	     + INVRETNVRA + INVRETRKRA + INVRETRPRA + INVRETRURA + INVRETNURA ;

INDPLAF = positif(TOTALPLAFA + TOTALPLAFB + TOTALPLAFC - TOTALPLAF1 - TOTALPLAF2 - TOTALPLAF3) * positif(INDPLAF1 + INDPLAF2 + INDPLAF3) * positif(OPTPLAF15) ;


ALOGDOM = (INVLOG2008 + INVLGDEB2009 + INVLGDEB + INVOMLOGOA + INVOMLOGOH + INVOMLOGOL + INVOMLOGOO + INVOMLOGOS
                      + (INVRETQL + INVRETQM + INVRETQD + INVRETOB + INVRETOC + INVRETOM + INVRETON + INVRETOI + INVRETOJ + INVRETOK + INVRETOP 
			 + INVRETOQ + INVRETOR + INVRETOT + INVRETOU + INVRETOV + INVRETOW) * (1 - INDPLAF)
		      + (INVRETQLA + INVRETQMA + INVRETQDA + INVRETOBA + INVRETOCA + INVRETOMA + INVRETONA + INVRETOIA + INVRETOJA + INVRETOKA 
			 + INVRETOPA + INVRETOQA + INVRETORA + INVRETOTA + INVRETOUA + INVRETOVA + INVRETOWA) * INDPLAF)
	   * (1 - V_CNR) * (1 - ART1731BIS);

ALOGSOC = ((INVRETQJ + INVRETQS + INVRETQW + INVRETQX + INVRETQJR + INVRETQSR + INVRETQWR + INVRETQXR) * (1 - INDPLAF) 
	   + (INVRETQJA + INVRETQSA + INVRETQWA + INVRETQXA + INVRETQJRA + INVRETQSRA + INVRETQWRA + INVRETQXRA) * INDPLAF) 
           * (1 - V_CNR) * (1 - ART1731BIS);

ADOMSOC1 = ((INVRETKG + INVRETKH + INVRETKI + INVRETQN + INVRETQU + INVRETQK + INVRETKGR + INVRETKHR + INVRETKIR + INVRETQNR + INVRETQUR + INVRETQKR) * (1 - INDPLAF) 
	     + (INVRETKGA + INVRETKHA + INVRETKIA + INVRETQNA + INVRETQUA + INVRETQKA + INVRETKGRA + INVRETKHRA + INVRETKIRA + INVRETQNRA + INVRETQURA + INVRETQKRA) * INDPLAF) 
           * (1 - V_CNR) * (1 - ART1731BIS);

ALOCENT = (INVOMRETPM + INVOMENTRJ 
	    + (INVRETPO + INVRETPT + INVRETPY + INVRETRL + INVRETRQ + INVRETRV + INVRETNV + INVRETPN + INVRETPS + INVRETPX + INVRETRK + INVRETRP + INVRETRU
	       + INVRETNU + INVRETPP + INVRETPU + INVRETRG + INVRETRM + INVRETRR + INVRETRW + INVRETNW + INVRETPR + INVRETPW + INVRETRI + INVRETRO + INVRETRT 
	       + INVRETRY + INVRETNY + INVRETPOR + INVRETPTR + INVRETPYR + INVRETRLR + INVRETRQR + INVRETRVR + INVRETNVR + INVRETPNR + INVRETPSR + INVRETPXR 
	       + INVRETRKR + INVRETRPR + INVRETRUR + INVRETNUR) * (1 - INDPLAF)  
	    + (INVRETPOA + INVRETPTA + INVRETPYA + INVRETRLA + INVRETRQA + INVRETRVA + INVRETNVA + INVRETPNA + INVRETPSA + INVRETPXA + INVRETRKA + INVRETRPA 
	       + INVRETRUA + INVRETNUA + INVRETPPA + INVRETPUA + INVRETRGA + INVRETRMA + INVRETRRA + INVRETRWA + INVRETNWA + INVRETPRA + INVRETPWA + INVRETRIA 
	       + INVRETROA + INVRETRTA + INVRETRYA + INVRETNYA + INVRETPORA + INVRETPTRA + INVRETPYRA + INVRETRLRA + INVRETRQRA + INVRETRVRA + INVRETNVRA 
	       + INVRETPNRA + INVRETPSRA + INVRETPXRA + INVRETRKRA + INVRETRPRA + INVRETRURA + INVRETNURA) * INDPLAF)
           * (1 - V_CNR) * (1 - ART1731BIS);

ACOLENT = (INVOMREP + INVOMENTMN + INVENDEB2009 + INVOMQV
				 + (INVRETLG + INVRETMA + INVRETMB + INVRETLH + INVRETMC + INVRETLI + INVRETQP + INVRETQG + INVRETPB + INVRETPF + INVRETPJ 
				    + INVRETQO + INVRETQF + INVRETPA + INVRETPE + INVRETPI + INVRETKS + INVRETKT + INVRETKU + INVRETQR + INVRETQI + INVRETPD 
				    + INVRETPH + INVRETPL + INVRETMAR + INVRETLGR + INVRETMBR + INVRETLHR + INVRETMCR + INVRETLIR + INVRETQPR + INVRETQGR 
				    + INVRETPBR + INVRETPFR + INVRETPJR + INVRETQO + INVRETQF + INVRETPAR + INVRETPER + INVRETPIR) * (1 - INDPLAF) 
				 + (INVRETLGA + INVRETMAA + INVRETMBA + INVRETLHA + INVRETMCA + INVRETLIA + INVRETQPA + INVRETQGA + INVRETPBA + INVRETPFA 
				    + INVRETPJA + INVRETQOA + INVRETQFA + INVRETPAA + INVRETPEA + INVRETPIA + INVRETKSA + INVRETKTA + INVRETKUA + INVRETQRA 
				    + INVRETQIA + INVRETPDA + INVRETPHA + INVRETPLA + INVRETMARA + INVRETLGRA + INVRETMBRA + INVRETLHRA + INVRETMCRA + INVRETLIRA 
				    + INVRETQPRA + INVRETQGRA + INVRETPBRA + INVRETPFRA + INVRETPJRA + INVRETQOA + INVRETQFA + INVRETPARA + INVRETPERA + INVRETPIRA) * INDPLAF)
	   * (1 - V_CNR) * (1 - ART1731BIS);

regle 4083:
application : iliad, batch ;

NINVRETQB = max(min(INVLOG2008 , RRI1) , 0) * (1 - V_CNR) ;

NINVRETQC = max(min(INVLGDEB2009 , RRI1-INVLOG2008) , 0) * (1 - V_CNR) ;

NINVRETQT = max(min(INVLGDEB , RRI1-INVLOG2008-INVLGDEB2009) , 0) * (1 - V_CNR) ;

NINVRETOA = max(min(INVOMLOGOA , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB) , 0) * (1 - V_CNR) ;

NINVRETOH = max(min(INVOMLOGOH , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB-INVOMLOGOA) , 0) * (1 - V_CNR) ;

NINVRETOL = max(min(INVOMLOGOL , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB-INVOMLOGOA-INVOMLOGOH) , 0) * (1 - V_CNR) ;

NINVRETOO = max(min(INVOMLOGOO , RRI1-INVLOG2008-INVLGDEB2009-INVLGDEB-INVOMLOGOA-INVOMLOGOH-INVOMLOGOL) , 0) * (1 - V_CNR) ;

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

NRLOGDOM = (INVLOG2008 + INVLGDEB2009 + INVLGDEB + INVOMLOGOA + INVOMLOGOH + INVOMLOGOL + INVOMLOGOO + INVOMLOGOS
	    + NINVRETQL + NINVRETQM + NINVRETQD + NINVRETOB + NINVRETOC + NINVRETOI + NINVRETOJ + NINVRETOK
	    + NINVRETOM + NINVRETON + NINVRETOP + NINVRETOQ + NINVRETOR + NINVRETOT + NINVRETOU + NINVRETOV + NINVRETOW) 
	    * (1 - V_CNR) ;

regle 14084:
application : iliad, batch ;

NINVRETKG = max(min(INVSOCNRET , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT2-NRPATNAT1-NRPATNAT) , 0) * (1 - V_CNR) ;

NINVRETKH = max(min(INVOMSOCKH , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT2-NRPATNAT1-NRPATNAT-NINVRETKG) , 0) * (1 - V_CNR) ;

NINVRETKI = max(min(INVOMSOCKI , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT2-NRPATNAT1-NRPATNAT-NINVRETKG-NINVRETKH) , 0) * (1 - V_CNR) ;

NINVRETQN = max(min(INVSOC2010 , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT2-NRPATNAT1-NRPATNAT-NINVRETKG-NINVRETKH-NINVRETKI) , 0) * (1 - V_CNR) ;

NINVRETQU = max(min(INVOMSOCQU , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT2-NRPATNAT1-NRPATNAT-NINVRETKG-NINVRETKH-NINVRETKI-NINVRETQN) , 0) * (1 - V_CNR) ;

NINVRETQK = max(min(INVLOGSOC , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT2-NRPATNAT1-NRPATNAT-NINVRETKG-NINVRETKH-NINVRETKI-NINVRETQN-NINVRETQU) , 0) * (1 - V_CNR) ;

NINVRETQJ = max(min(INVOMSOCQJ , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT2-NRPATNAT1-NRPATNAT-NINVRETKG-NINVRETKH-NINVRETKI-NINVRETQN-NINVRETQU
				     -NINVRETQK) , 0) * (1 - V_CNR) ;

NINVRETQS = max(min(INVOMSOCQS , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT2-NRPATNAT1-NRPATNAT-NINVRETKG-NINVRETKH-NINVRETKI-NINVRETQN-NINVRETQU
				     -NINVRETQK-NINVRETQJ) , 0) * (1 - V_CNR) ;

NINVRETQW = max(min(INVOMSOCQW , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT2-NRPATNAT1-NRPATNAT-NINVRETKG-NINVRETKH-NINVRETKI-NINVRETQN-NINVRETQU
				     -NINVRETQK-NINVRETQJ-NINVRETQS) , 0) * (1 - V_CNR) ;

NINVRETQX = max(min(INVOMSOCQX , RRI1-NRLOGDOM-NRRI2-NRCELTOT-NRLOCNPRO-NRPATNAT2-NRPATNAT1-NRPATNAT-NINVRETKG-NINVRETKH-NINVRETKI-NINVRETQN-NINVRETQU
				     -NINVRETQK-NINVRETQJ-NINVRETQS-NINVRETQW) , 0) * (1 - V_CNR) ;

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

NRDOMSOC1 = NINVRETKG + NINVRETKH + NINVRETKI + NINVRETQN + NINVRETQU + NINVRETQK ;

NRLOGSOC = NINVRETQJ + NINVRETQS + NINVRETQW + NINVRETQX ;

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


INVRETKGR = max(min(arr(INVRETKG * 13 / 7) , max(0 , NINVRETKG - INVRETKG)) , max(0 , NINVRETKG - INVRETKG)) * (1 - V_CNR) ;

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

regle 4084111:
application : iliad, batch ;

RSOC9 = arr(max(min((INVRETKG * (1 - INDPLAF) + INVRETKGA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
							                   -RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT) , 0)) * (1 - V_CNR) ;

RSOC10 = arr(max(min((INVRETKH * (1 - INDPLAF) + INVRETKHA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
							                    -RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RSOC9) , 0)) * (1 - V_CNR) ;

RSOC11 = arr(max(min((INVRETKI * (1 - INDPLAF) + INVRETKIA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
							                    -RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RSOC9-RSOC10) , 0)) * (1 - V_CNR) ;

RSOC12 = arr(max(min((INVRETQN * (1 - INDPLAF) + INVRETQNA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
							                    -RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RSOC9-RSOC10-RSOC11) , 0)) * (1 - V_CNR) ;

RSOC13 = arr(max(min((INVRETQU * (1 - INDPLAF) + INVRETQUA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
							                    -RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RSOC9-RSOC10-RSOC11-RSOC12) , 0)) * (1 - V_CNR) ;

RSOC14 = arr(max(min((INVRETQK * (1 - INDPLAF) + INVRETQKA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
							                    -RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RSOC9-RSOC10-RSOC11-RSOC12-RSOC13) , 0)) 
									    * (1 - V_CNR) ;

RSOC15 = arr(max(min((INVRETKGR * (1 - INDPLAF) + INVRETKGRA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
								              -RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RSOC9-RSOC10-RSOC11-RSOC12-RSOC13-RSOC14) , 0)) 
								              * (1 - V_CNR) ;

RSOC16 = arr(max(min((INVRETKHR * (1 - INDPLAF) + INVRETKHRA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
								              -RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RSOC9-RSOC10-RSOC11-RSOC12-RSOC13-RSOC14
								              -RSOC15) , 0)) * (1 - V_CNR) ;

RSOC17 = arr(max(min((INVRETKIR * (1 - INDPLAF) + INVRETKIRA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
								              -RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RSOC9-RSOC10-RSOC11-RSOC12-RSOC13-RSOC14
								              -RSOC15-RSOC16) , 0)) * (1 - V_CNR) ;

RSOC18 = arr(max(min((INVRETQNR * (1 - INDPLAF) + INVRETQNRA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
								              -RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RSOC9-RSOC10-RSOC11-RSOC12-RSOC13-RSOC14
								              -RSOC15-RSOC16-RSOC17) , 0)) * (1 - V_CNR) ;

RSOC19 = arr(max(min((INVRETQUR * (1 - INDPLAF) + INVRETQURA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
								              -RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RSOC9-RSOC10-RSOC11-RSOC12-RSOC13-RSOC14
								              -RSOC15-RSOC16-RSOC17-RSOC18) , 0)) * (1 - V_CNR) ;

RSOC20 = arr(max(min((INVRETQKR * (1 - INDPLAF) + INVRETQKRA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
								              -RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RSOC9-RSOC10-RSOC11-RSOC12-RSOC13-RSOC14
								              -RSOC15-RSOC16-RSOC17-RSOC18-RSOC19) , 0)) * (1 - V_CNR) ;

RDOMSOC1 =  (1 - V_CNR) * (1 - ART1731BIS) * ((1 - V_INDTEO) * (RSOC9 + RSOC10 + RSOC11 + RSOC12 + RSOC13 + RSOC14 + RSOC15 + RSOC16 + RSOC17 + RSOC18 + RSOC19 + RSOC20)

             + V_INDTEO * (arr((V_RSOC9+V_RSOC15 + V_RSOC10+V_RSOC16 + V_RSOC12+V_RSOC18 + V_RSOC11+V_RSOC17 + V_RSOC13+V_RSOC19  + V_RSOC14+V_RSOC20 ) * (TX65/100)))) ;


RSOC1 = arr(max(min((INVRETQJ * (1 - INDPLAF) + INVRETQJA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RCELTOT
							                   -RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RDOMSOC1) , 0)) * (1 - V_CNR) ;

RSOC2 = arr(max(min((INVRETQS * (1 - INDPLAF) + INVRETQSA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RCELTOT
							                   -RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RDOMSOC1-RSOC1) , 0)) * (1 - V_CNR) ;

RSOC3 = arr(max(min((INVRETQW * (1 - INDPLAF) + INVRETQWA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RCELTOT
							                   -RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RDOMSOC1-RSOC1-RSOC2) , 0)) * (1 - V_CNR) ;

RSOC4 = arr(max(min((INVRETQX * (1 - INDPLAF) + INVRETQXA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RCELTOT
							                   -RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RDOMSOC1-RSOC1-RSOC2-RSOC3) , 0)) * (1 - V_CNR) ;

RSOC5 = arr(max(min((INVRETQJR * (1 - INDPLAF) + INVRETQJRA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RCELTOT
							                     -RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RDOMSOC1-RSOC1-RSOC2-RSOC3-RSOC4) , 0)) * (1 - V_CNR) ;

RSOC6 = arr(max(min((INVRETQSR * (1 - INDPLAF) + INVRETQSRA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RCELTOT
							                     -RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RDOMSOC1-RSOC1-RSOC2-RSOC3-RSOC4-RSOC5) , 0)) * (1 - V_CNR) ;

RSOC7 = arr(max(min((INVRETQWR * (1 - INDPLAF) + INVRETQWRA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RCELTOT
							                     -RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RDOMSOC1-RSOC1-RSOC2-RSOC3-RSOC4-RSOC5-RSOC6) , 0)) 
									     * (1 - V_CNR) ;

RSOC8 = arr(max(min((INVRETQXR * (1 - INDPLAF) + INVRETQXRA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RCELTOT
							                     -RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RDOMSOC1-RSOC1-RSOC2-RSOC3-RSOC4-RSOC5-RSOC6-RSOC7) , 0)) 
									     * (1 - V_CNR) ;

RLOGSOC = ((1 - V_INDTEO) * (RSOC1 + RSOC2 + RSOC3 + RSOC4 + RSOC5 + RSOC6 + RSOC7 + RSOC8) 


            + V_INDTEO * ( arr(( V_RSOC1+V_RSOC5 + V_RSOC2 + V_RSOC6 + V_RSOC3 + V_RSOC7 + V_RSOC4 + V_RSOC8 ) * (TX65/100))))  * (1 - V_CNR)*(1-ART1731BIS);
			      
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

NINVRETMA = max(min(NRETROC40 , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009) , 0) 
	     * (1 - V_CNR) ;

NINVRETLG = max(min(NRETROC50 , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA) , 0) * (1 - V_CNR) ;

NINVRETKS = max(min(INVENDI , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG) , 0) * (1 - V_CNR) ;

NINVRETMB = max(min(RETROCOMMB , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS) , 0) * (1 - V_CNR) ;

NINVRETMC = max(min(RETROCOMMC , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB) , 0) 
				     * (1 - V_CNR) ;

NINVRETLH = max(min(RETROCOMLH , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				     -NINVRETMC) , 0) * (1 - V_CNR) ;

NINVRETLI = max(min(RETROCOMLI , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				     -NINVRETMC-NINVRETLH) , 0) * (1 - V_CNR) ;

NINVRETKT = max(min(INVOMENTKT , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				     -NINVRETMC-NINVRETLH-NINVRETLI) , 0) * (1 - V_CNR) ;

NINVRETKU = max(min(INVOMENTKU , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				     -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT) , 0) * (1 - V_CNR) ;

NINVRETQP = max(min(INVRETRO2 , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				    -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU) , 0) * (1 - V_CNR) ;

NINVRETQG = max(min(INVDOMRET60 , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				      -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP) , 0) * (1 - V_CNR) ;

NINVRETQO = max(min(INVRETRO1 , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				    -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG) , 0) * (1 - V_CNR) ;

NINVRETQF = max(min(INVDOMRET50 , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				      -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO) , 0) * (1 - V_CNR) ;

NINVRETQR = max(min(INVIMP , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				 -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF) , 0) * (1 - V_CNR) ;

NINVRETQI = max(min(INVDIR2009 , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				     -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR) , 0) * (1 - V_CNR) ;

NINVRETPB = max(min(INVOMRETPB , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				     -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR-NINVRETQI) , 0) * (1 - V_CNR) ;

NINVRETPF = max(min(INVOMRETPF , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				     -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR-NINVRETQI-NINVRETPB) , 0) 
				     * (1 - V_CNR) ;

NINVRETPJ = max(min(INVOMRETPJ , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				     -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR-NINVRETQI-NINVRETPB
				     -NINVRETPF) , 0) * (1 - V_CNR) ;

NINVRETPA = max(min(INVOMRETPA , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				     -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR-NINVRETQI-NINVRETPB
				     -NINVRETPF-NINVRETPJ) , 0) * (1 - V_CNR) ;

NINVRETPE = max(min(INVOMRETPE , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				     -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR-NINVRETQI-NINVRETPB
				     -NINVRETPF-NINVRETPJ-NINVRETPA) , 0) * (1 - V_CNR) ;

NINVRETPI = max(min(INVOMRETPI , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				     -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR-NINVRETQI-NINVRETPB
				     -NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE) , 0) * (1 - V_CNR) ;

NINVRETPD = max(min(INVOMRETPD , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				     -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR-NINVRETQI-NINVRETPB
				     -NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI) , 0) * (1 - V_CNR) ;

NINVRETPH = max(min(INVOMRETPH , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				     -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR-NINVRETQI-NINVRETPB
				     -NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD) , 0) * (1 - V_CNR) ;

NINVRETPL = max(min(INVOMRETPL , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				     -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR-NINVRETQI-NINVRETPB
				     -NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH) , 0) * (1 - V_CNR) ;

NINVRETPM = max(min(INVOMRETPM , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				     -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR-NINVRETQI-NINVRETPB
				     -NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL) , 0) * (1 - V_CNR) ;

NINVRETRJ = max(min(INVOMENTRJ , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				     -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR-NINVRETQI-NINVRETPB
				     -NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-INVOMRETPM) , 0) * (1 - V_CNR) ;

NINVRETPO = max(min(INVOMRETPO , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				     -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR-NINVRETQI-NINVRETPB
				     -NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-INVOMRETPM-INVOMENTRJ) , 0) * (1 - V_CNR) ;

NINVRETPT = max(min(INVOMRETPT , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				     -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR-NINVRETQI-NINVRETPB
				     -NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-INVOMRETPM-INVOMENTRJ-NINVRETPO) , 0) * (1 - V_CNR) ;

NINVRETPY = max(min(INVOMRETPY , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				     -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR-NINVRETQI-NINVRETPB
				     -NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-INVOMRETPM-INVOMENTRJ-NINVRETPO-NINVRETPT) , 0) 
				     * (1 - V_CNR) ;

NINVRETRL = max(min(INVOMENTRL , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				     -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR-NINVRETQI-NINVRETPB
				     -NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-INVOMRETPM-INVOMENTRJ-NINVRETPO-NINVRETPT
				     -NINVRETPY) , 0) * (1 - V_CNR) ;

NINVRETRQ = max(min(INVOMENTRQ , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				     -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR-NINVRETQI-NINVRETPB
				     -NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-INVOMRETPM-INVOMENTRJ-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL) , 0) * (1 - V_CNR) ;

NINVRETRV = max(min(INVOMENTRV , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				     -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR-NINVRETQI-NINVRETPB
				     -NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-INVOMRETPM-INVOMENTRJ-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ) , 0) * (1 - V_CNR) ;

NINVRETNV = max(min(INVOMENTNV , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				     -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR-NINVRETQI-NINVRETPB
				     -NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-INVOMRETPM-INVOMENTRJ-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV) , 0) * (1 - V_CNR) ;

NINVRETPN = max(min(INVOMRETPN , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				     -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR-NINVRETQI-NINVRETPB
				     -NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-INVOMRETPM-INVOMENTRJ-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV) , 0) * (1 - V_CNR) ;

NINVRETPS = max(min(INVOMRETPS , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				     -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR-NINVRETQI-NINVRETPB
				     -NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-INVOMRETPM-INVOMENTRJ-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN) , 0) * (1 - V_CNR) ;

NINVRETPX = max(min(INVOMRETPX , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				     -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR-NINVRETQI-NINVRETPB
				     -NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-INVOMRETPM-INVOMENTRJ-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS) , 0) * (1 - V_CNR) ;

NINVRETRK = max(min(INVOMENTRK , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				     -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR-NINVRETQI-NINVRETPB
				     -NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-INVOMRETPM-INVOMENTRJ-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX) , 0) * (1 - V_CNR) ;

NINVRETRP = max(min(INVOMENTRP , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				     -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR-NINVRETQI-NINVRETPB
				     -NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-INVOMRETPM-INVOMENTRJ-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK) , 0) * (1 - V_CNR) ;

NINVRETRU = max(min(INVOMENTRU , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				     -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR-NINVRETQI-NINVRETPB
				     -NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-INVOMRETPM-INVOMENTRJ-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP) , 0) * (1 - V_CNR) ;

NINVRETNU = max(min(INVOMENTNU , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				     -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR-NINVRETQI-NINVRETPB
				     -NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-INVOMRETPM-INVOMENTRJ-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU) , 0) * (1 - V_CNR) ;

NINVRETPP = max(min(INVOMRETPP , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				     -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR-NINVRETQI-NINVRETPB
				     -NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-INVOMRETPM-INVOMENTRJ-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU) , 0) 
				     * (1 - V_CNR) ;

NINVRETPU = max(min(INVOMRETPU , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				     -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR-NINVRETQI-NINVRETPB
				     -NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-INVOMRETPM-INVOMENTRJ-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				     -NINVRETPP) , 0) * (1 - V_CNR) ;

NINVRETRG = max(min(INVOMENTRG , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				     -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR-NINVRETQI-NINVRETPB
				     -NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-INVOMRETPM-INVOMENTRJ-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				     -NINVRETPP-NINVRETPU) , 0) * (1 - V_CNR) ;

NINVRETRM = max(min(INVOMENTRM , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				     -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR-NINVRETQI-NINVRETPB
				     -NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-INVOMRETPM-INVOMENTRJ-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				     -NINVRETPP-NINVRETPU-NINVRETRG) , 0) * (1 - V_CNR) ;

NINVRETRR = max(min(INVOMENTRR , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				     -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR-NINVRETQI-NINVRETPB
				     -NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-INVOMRETPM-INVOMENTRJ-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				     -NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM) , 0) * (1 - V_CNR) ;

NINVRETRW = max(min(INVOMENTRW , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				     -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR-NINVRETQI-NINVRETPB
				     -NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-INVOMRETPM-INVOMENTRJ-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				     -NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR) , 0) * (1 - V_CNR) ;

NINVRETNW = max(min(INVOMENTNW , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				     -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR-NINVRETQI-NINVRETPB
				     -NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-INVOMRETPM-INVOMENTRJ-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				     -NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW) , 0) * (1 - V_CNR) ;

NINVRETPR = max(min(INVOMRETPR , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				     -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR-NINVRETQI-NINVRETPB
				     -NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-INVOMRETPM-INVOMENTRJ-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				     -NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW-NINVRETNW) , 0) * (1 - V_CNR) ;

NINVRETPW = max(min(INVOMRETPW , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				     -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR-NINVRETQI-NINVRETPB
				     -NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-INVOMRETPM-INVOMENTRJ-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				     -NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW-NINVRETNW-NINVRETPR) , 0) * (1 - V_CNR) ;

NINVRETRI = max(min(INVOMENTRI , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				     -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR-NINVRETQI-NINVRETPB
				     -NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-INVOMRETPM-INVOMENTRJ-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				     -NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW-NINVRETNW-NINVRETPR-NINVRETPW) , 0) * (1 - V_CNR) ;

NINVRETRO = max(min(INVOMENTRO , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				     -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR-NINVRETQI-NINVRETPB
				     -NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-INVOMRETPM-INVOMENTRJ-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				     -NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW-NINVRETNW-NINVRETPR-NINVRETPW-NINVRETRI) , 0) * (1 - V_CNR) ;

NINVRETRT = max(min(INVOMENTRT , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				     -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR-NINVRETQI-NINVRETPB
				     -NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-INVOMRETPM-INVOMENTRJ-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				     -NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW-NINVRETNW-NINVRETPR-NINVRETPW-NINVRETRI-NINVRETRO) , 0) * (1 - V_CNR) ;

NINVRETRY = max(min(INVOMENTRY , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				     -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR-NINVRETQI-NINVRETPB
				     -NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-INVOMRETPM-INVOMENTRJ-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				     -NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW-NINVRETNW-NINVRETPR-NINVRETPW-NINVRETRI-NINVRETRO-NINVRETRT) , 0) 
				     * (1 - V_CNR) ;

NINVRETNY = max(min(INVOMENTNY , RRI1-NRLOGDOM-NRRI2-NRLOGSOC-NRDOMSOC1-NRRI3-INVOMREP-INVOMENTMN-INVOMQV-INVENDEB2009-NINVRETMA-NINVRETLG-NINVRETKS-NINVRETMB
				     -NINVRETMC-NINVRETLH-NINVRETLI-NINVRETKT-NINVRETKU-NINVRETQP-NINVRETQG-NINVRETQO-NINVRETQF-NINVRETQR-NINVRETQI-NINVRETPB
				     -NINVRETPF-NINVRETPJ-NINVRETPA-NINVRETPE-NINVRETPI-NINVRETPD-NINVRETPH-NINVRETPL-INVOMRETPM-INVOMENTRJ-NINVRETPO-NINVRETPT
				     -NINVRETPY-NINVRETRL-NINVRETRQ-NINVRETRV-NINVRETNV-NINVRETPN-NINVRETPS-NINVRETPX-NINVRETRK-NINVRETRP-NINVRETRU-NINVRETNU
				     -NINVRETPP-NINVRETPU-NINVRETRG-NINVRETRM-NINVRETRR-NINVRETRW-NINVRETNW-NINVRETPR-NINVRETPW-NINVRETRI-NINVRETRO-NINVRETRT
				     -NINVRETRY) , 0) * (1 - V_CNR) ;

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

NINVRETRLR = (NINVRETRL - arr(NINVRETRL * TX375/100)) * (1 - V_CNR) ;

NINVRETRQR = (NINVRETRQ - arr(NINVRETRQ * TX375/100)) * (1 - V_CNR) ;

NINVRETRVR = (NINVRETRV - arr(NINVRETRV * TX375/100)) * (1 - V_CNR) ;

NINVRETNVR = (NINVRETNV - arr(NINVRETNV * TX375/100)) * (1 - V_CNR) ;

NINVRETRKR = (NINVRETRK - arr(NINVRETRK * TX4737/100)) * (1 - V_CNR) ;

NINVRETRPR = (NINVRETRP - arr(NINVRETRP * TX4737/100)) * (1 - V_CNR) ;

NINVRETRUR = (NINVRETRU - arr(NINVRETRU * TX4737/100)) * (1 - V_CNR) ;

NINVRETNUR = (NINVRETNU - arr(NINVRETNU * TX4737/100)) * (1 - V_CNR) ;

regle 14083:
application : iliad, batch ;

INVRETMM = NINVRETMM * (1 - V_CNR) ;

INVRETMN = NINVRETMN * (1 - V_CNR) ;

INVRETQE = NINVRETQE * (1 - V_CNR) ;

INVRETQV = NINVRETQV * (1 - V_CNR) ;

INVRETMA = min(arr(NINVRETMA * TX40 / 100) , max(0 , PLAF_INVDOM -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX
						                 )) * (1 - V_CNR) ;

INVRETLG = min(arr(NINVRETLG * TX50 / 100) , max(0 , PLAF_INVDOM -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX 
						                 -INVRETMA)) * (1 - V_CNR) ;

INVRETMB = min(arr(NINVRETMB * TX40 / 100) , max(0 , PLAF_INVDOM -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX 
						                 -INVRETMA-INVRETLG)) * (1 - V_CNR) ;

INVRETMC = min(arr(NINVRETMC * TX40 / 100) , max(0 , PLAF_INVDOM -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX 
						                 -INVRETMA-INVRETLG-INVRETMB)) * (1 - V_CNR) ;

INVRETLH = min(arr(NINVRETLH * TX50 / 100) , max(0 , PLAF_INVDOM -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX 
						                 -INVRETMA-INVRETLG-INVRETMB-INVRETMC)) * (1 - V_CNR) ;

INVRETLI = min(arr(NINVRETLI * TX50 / 100) , max(0 , PLAF_INVDOM -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX 
						                 -INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH)) * (1 - V_CNR) ;

INVRETQP = min(arr(NINVRETQP * TX40 / 100) , max(0 , PLAF_INVDOM -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX 
						                 -INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI)) * (1 - V_CNR) ;

INVRETQG = min(arr(NINVRETQG * TX40 / 100) , max(0 , PLAF_INVDOM -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX 
						                 -INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP)) * (1 - V_CNR) ;

INVRETQO = min(arr(NINVRETQO * TX50 / 100) , max(0 , PLAF_INVDOM -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX 
						                 -INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG)) * (1 - V_CNR) ;

INVRETQF = min(arr(NINVRETQF * TX50 / 100) , max(0 , PLAF_INVDOM -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX 
						                 -INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO)) * (1 - V_CNR) ;

INVRETPB = min(arr(NINVRETPB * TX375/ 100) , max(0 , PLAF_INVDOM3 -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX 
						                  -INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF)) 
								  * (1 - V_CNR) ;

INVRETPF = min(arr(NINVRETPF * TX375/ 100) , max(0 , PLAF_INVDOM3 -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX 
						                  -INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF 
								  -INVRETPB)) * (1 - V_CNR) ;

INVRETPJ = min(arr(NINVRETPJ * TX375/ 100) , max(0 , PLAF_INVDOM3 -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX 
						                  -INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF 
								  -INVRETPB-INVRETPF)) * (1 - V_CNR) ;

INVRETPA = min(arr(NINVRETPA * TX4737/100) , max(0 , PLAF_INVDOM3 -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX 
						                  -INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF 
								  -INVRETPB-INVRETPF-INVRETPJ)) * (1 - V_CNR) ;

INVRETPE = min(arr(NINVRETPE * TX4737/100) , max(0 , PLAF_INVDOM3 -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX 
						                  -INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF 
								  -INVRETPB-INVRETPF-INVRETPJ-INVRETPA)) * (1 - V_CNR) ;

INVRETPI = min(arr(NINVRETPI * TX4737/100) , max(0 , PLAF_INVDOM3 -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX 
						                  -INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF 
								  -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE)) * (1 - V_CNR) ;

INVRETPO = min(arr(NINVRETPO * TX40/100) , max(0 , PLAF_INVDOM -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX 
						               -INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF 
							       -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI)) * (1 - V_CNR) ;

INVRETPT = min(arr(NINVRETPT * TX40/100) , max(0 , PLAF_INVDOM -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX 
						               -INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF 
							       -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO)) * (1 - V_CNR) ;

INVRETPY = min(arr(NINVRETPY * TX375/100) , max(0 , PLAF_INVDOM3 -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX 
						                 -INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF 
								 -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT)) * (1 - V_CNR) ;

INVRETRL = min(arr(NINVRETRL * TX375/100) , max(0 , PLAF_INVDOM4 -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX 
						                 -INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF 
								 -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY)) * (1 - V_CNR) ;

INVRETRQ = min(arr(NINVRETRQ * TX375/100) , max(0 , PLAF_INVDOM4 -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX 
						                 -INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF 
								 -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY-INVRETRL)) * (1 - V_CNR) ;

INVRETRV = min(arr(NINVRETRV * TX375/100) , max(0 , PLAF_INVDOM4 -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX 
						                 -INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF 
								 -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY-INVRETRL 
								 -INVRETRQ)) * (1 - V_CNR) ;

INVRETNV = min(arr(NINVRETNV * TX375/100) , max(0 , PLAF_INVDOM4 -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX 
						                 -INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF 
								 -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY-INVRETRL 
								 -INVRETRQ-INVRETRV)) * (1 - V_CNR) ;

INVRETPN = min(arr(NINVRETPN * TX50/100) , max(0 , PLAF_INVDOM -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX 
						               -INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF 
							       -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY-INVRETRL 
							       -INVRETRQ-INVRETRV-INVRETNV)) * (1 - V_CNR) ;

INVRETPS = min(arr(NINVRETPS * TX50/100) , max(0 , PLAF_INVDOM -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX 
						               -INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF 
							       -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY-INVRETRL 
							       -INVRETRQ-INVRETRV-INVRETNV-INVRETPN)) * (1 - V_CNR) ;

INVRETPX = min(arr(NINVRETPX * TX4737/100) , max(0 , PLAF_INVDOM3 -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX 
						                  -INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF 
								  -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY-INVRETRL 
								  -INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS)) * (1 - V_CNR) ;

INVRETRK = min(arr(NINVRETRK * TX4737/100) , max(0 , PLAF_INVDOM4 -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX 
						                  -INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF 
								  -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY-INVRETRL 
								  -INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX)) * (1 - V_CNR) ;

INVRETRP = min(arr(NINVRETRP * TX4737/100) , max(0 , PLAF_INVDOM4 -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX 
						                  -INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF 
								  -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY-INVRETRL 
								  -INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK)) * (1 - V_CNR) ;

INVRETRU = min(arr(NINVRETRU * TX4737/100) , max(0 , PLAF_INVDOM4 -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX 
						                  -INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF 
								  -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY-INVRETRL 
								  -INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP)) * (1 - V_CNR) ;

INVRETNU = min(arr(NINVRETNU * TX4737/100) , max(0 , PLAF_INVDOM4 -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX 
						                  -INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF 
								  -INVRETPB-INVRETPF-INVRETPJ-INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY-INVRETRL 
								  -INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX-INVRETRK-INVRETRP-INVRETRU)) * (1 - V_CNR) ;

INVRETPP = min(NINVRETPP , max(0 , PLAF_INVDOM -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX-INVRETMA-INVRETLG 
					       -INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA 
					       -INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY-INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX 
					       -INVRETRK-INVRETRP-INVRETRU-INVRETNU)) * (1 - V_CNR) ;

INVRETPU = min(NINVRETPU , max(0 , PLAF_INVDOM -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX-INVRETMA-INVRETLG 
					       -INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA 
					       -INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY-INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX 
					       -INVRETRK-INVRETRP-INVRETRU-INVRETNU-INVRETPP)) * (1 - V_CNR) ;

INVRETRG = min(NINVRETRG , max(0 , PLAF_INVDOM3 -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX-INVRETMA-INVRETLG 
						-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA 
						-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY-INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX 
						-INVRETRK-INVRETRP-INVRETRU-INVRETNU-INVRETPP-INVRETPU)) * (1 - V_CNR) ;

INVRETRM = min(NINVRETRM , max(0 , PLAF_INVDOM4 -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX-INVRETMA-INVRETLG 
						-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA 
						-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY-INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX 
						-INVRETRK-INVRETRP-INVRETRU-INVRETNU-INVRETPP-INVRETPU-INVRETRG)) * (1 - V_CNR) ;

INVRETRR = min(NINVRETRR , max(0 , PLAF_INVDOM4 -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX-INVRETMA-INVRETLG 
						-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA 
						-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY-INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX 
						-INVRETRK-INVRETRP-INVRETRU-INVRETNU-INVRETPP-INVRETPU-INVRETRG-INVRETRM)) * (1 - V_CNR) ;

INVRETRW = min(NINVRETRW , max(0 , PLAF_INVDOM4 -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX-INVRETMA-INVRETLG 
						-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA 
						-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY-INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX 
						-INVRETRK-INVRETRP-INVRETRU-INVRETNU-INVRETPP-INVRETPU-INVRETRG-INVRETRM-INVRETRR)) * (1 - V_CNR) ;

INVRETNW = min(NINVRETNW , max(0 , PLAF_INVDOM4 -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX-INVRETMA-INVRETLG 
						-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF-INVRETPB-INVRETPF-INVRETPJ-INVRETPA 
						-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY-INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS-INVRETPX 
						-INVRETRK-INVRETRP-INVRETRU-INVRETNU-INVRETPP-INVRETPU-INVRETRG-INVRETRM-INVRETRR-INVRETRW)) * (1 - V_CNR) ;

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


INVRETMAR = min(arr(INVRETMA * 3 / 2) , max(0 , NINVRETMA - INVRETMA)) * (1 - V_CNR) ;

INVRETLGR = min(INVRETLG , max(0 , NINVRETLG - INVRETLG)) * (1 - V_CNR) ;

INVRETMBR = min(arr(INVRETMB * 3 / 2) , max(0 , NINVRETMB - INVRETMB)) * (1 - V_CNR) ;

INVRETMCR = min(arr(INVRETMC * 3 / 2) , max(0 , NINVRETMC - INVRETMC)) * (1 - V_CNR) ;

INVRETLHR = min(INVRETLH , max(0 , NINVRETLH - INVRETLH)) * (1 - V_CNR) ;

INVRETLIR = min(INVRETLI , max(0 , NINVRETLI - INVRETLI)) * (1 - V_CNR) ;

INVRETQPR = min(arr(INVRETQP * 3 / 2) , max(0 , NINVRETQP - INVRETQP)) * (1 - V_CNR) ;

INVRETQGR = min(arr(INVRETQG * 3 / 2) , max(0 , NINVRETQG - INVRETQG)) * (1 - V_CNR) ;

INVRETQOR = min(INVRETQO , max(0 , NINVRETQO - INVRETQO)) * (1 - V_CNR) ;

INVRETQFR = min(INVRETQF , max(0 , NINVRETQF - INVRETQF)) * (1 - V_CNR) ;

INVRETPBR = min(arr(INVRETPB * 5 / 3) , max(0 , NINVRETPB - INVRETPB)) * (1 - V_CNR) ;

INVRETPFR = min(arr(INVRETPF * 5 / 3) , max(0 , NINVRETPF - INVRETPF)) * (1 - V_CNR) ;

INVRETPJR = min(arr(INVRETPJ * 5 / 3) , max(0 , NINVRETPJ - INVRETPJ)) * (1 - V_CNR) ;

INVRETPAR = min(arr(INVRETPA * 10/ 9) , max(0 , NINVRETPA - INVRETPA)) * (1 - V_CNR) ;

INVRETPER = min(arr(INVRETPE * 10/ 9) , max(0 , NINVRETPE - INVRETPE)) * (1 - V_CNR) ;

INVRETPIR = min(arr(INVRETPI * 10/ 9) , max(0 , NINVRETPI - INVRETPI)) * (1 - V_CNR) ;

INVRETPOR = min(arr(INVRETPO * 3 / 2) , max(0 , NINVRETPO - INVRETPO)) * (1 - V_CNR) ;

INVRETPTR = min(arr(INVRETPT * 3 / 2) , max(0 , NINVRETPT - INVRETPT)) * (1 - V_CNR) ;

INVRETPYR = min(arr(INVRETPY * 5 / 3) , max(0 , NINVRETPY - INVRETPY)) * (1 - V_CNR) ;

INVRETRLR = min(arr(INVRETRL * 5 / 3) , max(0 , NINVRETRL - INVRETRL)) * (1 - V_CNR) ;

INVRETRQR = min(arr(INVRETRQ * 5 / 3) , max(0 , NINVRETRQ - INVRETRQ)) * (1 - V_CNR) ;

INVRETRVR = min(arr(INVRETRV * 5 / 3) , max(0 , NINVRETRV - INVRETRV)) * (1 - V_CNR) ;

INVRETNVR = min(arr(INVRETNV * 5 / 3) , max(0 , NINVRETNV - INVRETNV)) * (1 - V_CNR) ;

INVRETPNR = min(INVRETPN , max(0 , NINVRETPN - INVRETPN)) * (1 - V_CNR) ;

INVRETPSR = min(INVRETPS , max(0 , NINVRETPS - INVRETPS)) * (1 - V_CNR) ;

INVRETPXR = min(arr(INVRETPX * 10/ 9) , max(0 , NINVRETPX - INVRETPX)) * (1 - V_CNR) ;

INVRETRKR = min(arr(INVRETRK * 10/ 9) , max(0 , NINVRETRK - INVRETRK)) * (1 - V_CNR) ;

INVRETRPR = min(arr(INVRETRP * 10/ 9) , max(0 , NINVRETRP - INVRETRP)) * (1 - V_CNR) ;

INVRETRUR = min(arr(INVRETRU * 10/ 9) , max(0 , NINVRETRU - INVRETRU)) * (1 - V_CNR) ;

INVRETNUR = min(arr(INVRETNU * 10/ 9) , max(0 , NINVRETNU - INVRETNU)) * (1 - V_CNR) ;

regle 7714083:
application : iliad, batch ;

RENTM = max(min(INVOMRETPM , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC-RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV
				  -RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RCOLENT) , 0) * (1 - V_CNR) ;

RENTJ = max(min(INVOMENTRJ , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC-RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV
				  -RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RCOLENT-RENTM) , 0) * (1 - V_CNR) ;

RENT1 = max(min((INVRETPO * (1 - INDPLAF) + INVRETPOA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC
				                                       -RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RCOLENT-RENTM-RENTJ) , 0) 
								       * (1 - V_CNR) ;

RENT2 = max(min((INVRETPT * (1 - INDPLAF) + INVRETPTA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC
							               -RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RCOLENT-RENTM-RENTJ-RENT1) , 0) 
								       * (1 - V_CNR) ;

RENT3 = max(min((INVRETPY * (1 - INDPLAF) + INVRETPYA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC
							               -RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RCOLENT-RENTM-RENTJ-RENT1
								       -RENT2) , 0) * (1 - V_CNR) ;

RENT4 = max(min((INVRETRL * (1 - INDPLAF) + INVRETRLA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC
							               -RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RCOLENT-RENTM-RENTJ-RENT1
								       -RENT2-RENT3) , 0) * (1 - V_CNR) ;

RENT5 = max(min((INVRETRQ * (1 - INDPLAF) + INVRETRQA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC
							               -RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RCOLENT-RENTM-RENTJ-RENT1
								       -RENT2-RENT3-RENT4) , 0) * (1 - V_CNR) ;

RENT6 = max(min((INVRETRV * (1 - INDPLAF) + INVRETRVA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC
							               -RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RCOLENT-RENTM-RENTJ-RENT1
								       -RENT2-RENT3-RENT4-RENT5) , 0) * (1 - V_CNR) ;

RENT7 = max(min((INVRETNV * (1 - INDPLAF) + INVRETNVA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC
							               -RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RCOLENT-RENTM-RENTJ-RENT1
								       -RENT2-RENT3-RENT4-RENT5-RENT6) , 0) * (1 - V_CNR) ;

RENT8 = max(min((INVRETPN * (1 - INDPLAF) + INVRETPNA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC
							               -RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RCOLENT-RENTM-RENTJ-RENT1
								       -RENT2-RENT3-RENT4-RENT5-RENT6-RENT7) , 0) * (1 - V_CNR) ;

RENT9 = max(min((INVRETPS * (1 - INDPLAF) + INVRETPSA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC
							               -RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RCOLENT-RENTM-RENTJ-RENT1
								       -RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8) , 0) * (1 - V_CNR) ;

RENT10 = max(min((INVRETPX * (1 - INDPLAF) + INVRETPXA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC
							                -RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RCOLENT-RENTM-RENTJ-RENT1
									-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9) , 0) * (1 - V_CNR) ;

RENT11 = max(min((INVRETRK * (1 - INDPLAF) + INVRETRKA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC
							                -RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RCOLENT-RENTM-RENTJ-RENT1
									-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9-RENT10) , 0) * (1 - V_CNR) ;

RENT12 = max(min((INVRETRP * (1 - INDPLAF) + INVRETRPA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC
							                -RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RCOLENT-RENTM-RENTJ-RENT1
									-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9-RENT10-RENT11) , 0) * (1 - V_CNR) ;

RENT13 = max(min((INVRETRU * (1 - INDPLAF) + INVRETRUA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC
							                -RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RCOLENT-RENTM-RENTJ-RENT1
									-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9-RENT10-RENT11-RENT12) , 0) * (1 - V_CNR) ;

RENT14 = max(min((INVRETNU * (1 - INDPLAF) + INVRETNUA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC
							                -RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RCOLENT-RENTM-RENTJ-RENT1
									-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9-RENT10-RENT11-RENT12-RENT13) , 0) * (1 - V_CNR) ;

RENT15 = max(min((INVRETPP * (1 - INDPLAF) + INVRETPPA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC
							                -RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RCOLENT-RENTM-RENTJ-RENT1
									-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9-RENT10-RENT11-RENT12-RENT13-RENT14) , 0) * (1 - V_CNR) ;

RENT16 = max(min((INVRETPU * (1 - INDPLAF) + INVRETPUA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC
							                -RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RCOLENT-RENTM-RENTJ-RENT1
									-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9-RENT10-RENT11-RENT12-RENT13-RENT14-RENT15) , 0) 
									* (1 - V_CNR) ;

RENT17 = max(min((INVRETRG * (1 - INDPLAF) + INVRETRGA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC
							                -RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RCOLENT-RENTM-RENTJ-RENT1
									-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9-RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16) , 0) 
									* (1 - V_CNR) ;

RENT18 = max(min((INVRETRM * (1 - INDPLAF) + INVRETRMA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC
							                -RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RCOLENT-RENTM-RENTJ-RENT1
									-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9-RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16
									-RENT17) , 0) * (1 - V_CNR) ;

RENT19 = max(min((INVRETRR * (1 - INDPLAF) + INVRETRRA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC
							                -RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RCOLENT-RENTM-RENTJ-RENT1
									-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9-RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16
									-RENT17-RENT18) , 0) * (1 - V_CNR) ;

RENT20 = max(min((INVRETRW * (1 - INDPLAF) + INVRETRWA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC
							                -RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RCOLENT-RENTM-RENTJ-RENT1
									-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9-RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16
									-RENT17-RENT18-RENT19) , 0) * (1 - V_CNR) ;

RENT21 = max(min((INVRETNW * (1 - INDPLAF) + INVRETNWA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC
							                -RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RCOLENT-RENTM-RENTJ-RENT1
									-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9-RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16
									-RENT17-RENT18-RENT19-RENT20) , 0) * (1 - V_CNR) ;

RENT22 = max(min((INVRETPR * (1 - INDPLAF) + INVRETPRA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC
							                -RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RCOLENT-RENTM-RENTJ-RENT1
									-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9-RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16
									-RENT17-RENT18-RENT19-RENT20-RENT21) , 0) * (1 - V_CNR) ;

RENT23 = max(min((INVRETPW * (1 - INDPLAF) + INVRETPWA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC
							                -RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RCOLENT-RENTM-RENTJ-RENT1
									-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9-RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16
									-RENT17-RENT18-RENT19-RENT20-RENT21-RENT22) , 0) * (1 - V_CNR) ;

RENT24 = max(min((INVRETRI * (1 - INDPLAF) + INVRETRIA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC
							                -RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RCOLENT-RENTM-RENTJ-RENT1
									-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9-RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16
									-RENT17-RENT18-RENT19-RENT20-RENT21-RENT22-RENT23) , 0) * (1 - V_CNR) ;

RENT25 = max(min((INVRETRO * (1 - INDPLAF) + INVRETROA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC
							                -RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RCOLENT-RENTM-RENTJ-RENT1
									-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9-RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16
									-RENT17-RENT18-RENT19-RENT20-RENT21-RENT22-RENT23-RENT24) , 0) * (1 - V_CNR) ;

RENT26 = max(min((INVRETRT * (1 - INDPLAF) + INVRETRTA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC
							                -RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RCOLENT-RENTM-RENTJ-RENT1
									-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9-RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16
									-RENT17-RENT18-RENT19-RENT20-RENT21-RENT22-RENT23-RENT24-RENT25) , 0) * (1 - V_CNR) ;

RENT27 = max(min((INVRETRY * (1 - INDPLAF) + INVRETRYA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC
							                -RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RCOLENT-RENTM-RENTJ-RENT1
									-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9-RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16
									-RENT17-RENT18-RENT19-RENT20-RENT21-RENT22-RENT23-RENT24-RENT25-RENT26) , 0) * (1 - V_CNR) ;

RENT28 = max(min((INVRETNY * (1 - INDPLAF) + INVRETNYA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC
							                -RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RCOLENT-RENTM-RENTJ-RENT1
									-RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9-RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16
									-RENT17-RENT18-RENT19-RENT20-RENT21-RENT22-RENT23-RENT24-RENT25-RENT26-RENT27) , 0) * (1 - V_CNR) ;

RENT29 = max(min((INVRETPOR * (1 - INDPLAF) + INVRETPORA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC
							                  -RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RCOLENT-RENTM-RENTJ-RENT1
									  -RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9-RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16
									  -RENT17-RENT18-RENT19-RENT20-RENT21-RENT22-RENT23-RENT24-RENT25-RENT26-RENT27-RENT28) , 0) * (1 - V_CNR) ;

RENT30 = max(min((INVRETPTR * (1 - INDPLAF) + INVRETPTRA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC
							                  -RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RCOLENT-RENTM-RENTJ-RENT1
									  -RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9-RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16
									  -RENT17-RENT18-RENT19-RENT20-RENT21-RENT22-RENT23-RENT24-RENT25-RENT26-RENT27-RENT28-RENT29) , 0) 
									  * (1 - V_CNR) ;

RENT31 = max(min((INVRETPYR * (1 - INDPLAF) + INVRETPYRA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC
							                  -RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RCOLENT-RENTM-RENTJ-RENT1
									  -RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9-RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16
									  -RENT17-RENT18-RENT19-RENT20-RENT21-RENT22-RENT23-RENT24-RENT25-RENT26-RENT27-RENT28-RENT29-RENT30) , 0) 
									  * (1 - V_CNR) ;

RENT32 = max(min((INVRETRLR * (1 - INDPLAF) + INVRETRLRA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC
							                  -RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RCOLENT-RENTM-RENTJ-RENT1
									  -RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9-RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16
									  -RENT17-RENT18-RENT19-RENT20-RENT21-RENT22-RENT23-RENT24-RENT25-RENT26-RENT27-RENT28-RENT29-RENT30
									  -RENT31) , 0) * (1 - V_CNR) ;

RENT33 = max(min((INVRETRQR * (1 - INDPLAF) + INVRETRQRA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC
							                  -RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RCOLENT-RENTM-RENTJ-RENT1
									  -RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9-RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16
									  -RENT17-RENT18-RENT19-RENT20-RENT21-RENT22-RENT23-RENT24-RENT25-RENT26-RENT27-RENT28-RENT29-RENT30
									  -RENT31-RENT32) , 0) * (1 - V_CNR) ;

RENT34 = max(min((INVRETRVR * (1 - INDPLAF) + INVRETRVRA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC
							                  -RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RCOLENT-RENTM-RENTJ-RENT1
									  -RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9-RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16
									  -RENT17-RENT18-RENT19-RENT20-RENT21-RENT22-RENT23-RENT24-RENT25-RENT26-RENT27-RENT28-RENT29-RENT30
									  -RENT31-RENT32-RENT33) , 0) * (1 - V_CNR) ;

RENT35 = max(min((INVRETNVR * (1 - INDPLAF) + INVRETNVRA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC
							                  -RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RCOLENT-RENTM-RENTJ-RENT1
									  -RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9-RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16
									  -RENT17-RENT18-RENT19-RENT20-RENT21-RENT22-RENT23-RENT24-RENT25-RENT26-RENT27-RENT28-RENT29-RENT30
									  -RENT31-RENT32-RENT33-RENT34) , 0) * (1 - V_CNR) ;

RENT36 = max(min((INVRETPNR * (1 - INDPLAF) + INVRETPNRA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC
							                  -RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RCOLENT-RENTM-RENTJ-RENT1
									  -RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9-RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16
									  -RENT17-RENT18-RENT19-RENT20-RENT21-RENT22-RENT23-RENT24-RENT25-RENT26-RENT27-RENT28-RENT29-RENT30
									  -RENT31-RENT32-RENT33-RENT34-RENT35) , 0) * (1 - V_CNR) ;

RENT37 = max(min((INVRETPSR * (1 - INDPLAF) + INVRETPSRA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC
							                  -RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RCOLENT-RENTM-RENTJ-RENT1
									  -RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9-RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16
									  -RENT17-RENT18-RENT19-RENT20-RENT21-RENT22-RENT23-RENT24-RENT25-RENT26-RENT27-RENT28-RENT29-RENT30
									  -RENT31-RENT32-RENT33-RENT34-RENT35-RENT36) , 0) * (1 - V_CNR) ;

RENT38 = max(min((INVRETPXR * (1 - INDPLAF) + INVRETPXRA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC
							                  -RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RCOLENT-RENTM-RENTJ-RENT1
									  -RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9-RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16
									  -RENT17-RENT18-RENT19-RENT20-RENT21-RENT22-RENT23-RENT24-RENT25-RENT26-RENT27-RENT28-RENT29-RENT30
									  -RENT31-RENT32-RENT33-RENT34-RENT35-RENT36-RENT37) , 0) * (1 - V_CNR) ;

RENT39 = max(min((INVRETRKR * (1 - INDPLAF) + INVRETRKRA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC
							                  -RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RCOLENT-RENTM-RENTJ-RENT1
									  -RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9-RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16
									  -RENT17-RENT18-RENT19-RENT20-RENT21-RENT22-RENT23-RENT24-RENT25-RENT26-RENT27-RENT28-RENT29-RENT30
									  -RENT31-RENT32-RENT33-RENT34-RENT35-RENT36-RENT37-RENT38) , 0) * (1 - V_CNR) ;

RENT40 = max(min((INVRETRPR * (1 - INDPLAF) + INVRETRPRA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC
							                  -RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RCOLENT-RENTM-RENTJ-RENT1
									  -RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9-RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16
									  -RENT17-RENT18-RENT19-RENT20-RENT21-RENT22-RENT23-RENT24-RENT25-RENT26-RENT27-RENT28-RENT29-RENT30
									  -RENT31-RENT32-RENT33-RENT34-RENT35-RENT36-RENT37-RENT38-RENT39) , 0) * (1 - V_CNR) ;

RENT41 = max(min((INVRETRUR * (1 - INDPLAF) + INVRETRURA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC
							                  -RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RCOLENT-RENTM-RENTJ-RENT1
									  -RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9-RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16
									  -RENT17-RENT18-RENT19-RENT20-RENT21-RENT22-RENT23-RENT24-RENT25-RENT26-RENT27-RENT28-RENT29-RENT30
									  -RENT31-RENT32-RENT33-RENT34-RENT35-RENT36-RENT37-RENT38-RENT39-RENT40) , 0) * (1 - V_CNR) ;

RENT42 = max(min((INVRETNUR * (1 - INDPLAF) + INVRETNURA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC
							                  -RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RCOLENT-RENTM-RENTJ-RENT1
									  -RENT2-RENT3-RENT4-RENT5-RENT6-RENT7-RENT8-RENT9-RENT10-RENT11-RENT12-RENT13-RENT14-RENT15-RENT16
									  -RENT17-RENT18-RENT19-RENT20-RENT21-RENT22-RENT23-RENT24-RENT25-RENT26-RENT27-RENT28-RENT29-RENT30
									  -RENT31-RENT32-RENT33-RENT34-RENT35-RENT36-RENT37-RENT38-RENT39-RENT40-RENT41) , 0) * (1 - V_CNR) ;

RLOCENT = ((1 - V_INDTEO) * (RENTM + RENTJ + RENT1 + RENT2 + RENT3 + RENT4 + RENT5 + RENT6 + RENT7 + RENT8 + RENT9 + RENT10 + RENT11 + RENT12 + RENT13 + RENT14 + RENT15 
			     + RENT16 + RENT17 + RENT18 + RENT19 + RENT20 + RENT21 + RENT22 + RENT23 + RENT24 + RENT25 + RENT26 + RENT27 + RENT28 + RENT29 + RENT30 + RENT31
			     + RENT32 + RENT33 + RENT34 + RENT35 + RENT36 + RENT37 + RENT38 + RENT39 + RENT40 + RENT41 + RENT42) 
           + V_INDTEO * max(min (
             RENTM + RENTJ
           + arr((V_RENT8+V_RENT36)*(TX50/100))
           + arr((V_RENT1+V_RENT29)*(TX60/100))
           + arr((V_RENT11+V_RENT39)*(5263/10000))
           + arr((V_RENT4+V_RENT32)*(625/1000))
	   + arr((V_RENT9 + V_RENT37)*(TX50/100))
	   + arr((V_RENT2 + V_RENT30)*(TX60/100))
	   + arr((V_RENT12 + V_RENT40)*(5263/10000))
	   + arr((V_RENT5 + V_RENT33)*(625/1000))
	   + arr((V_RENT10 + V_RENT38)*(5263/10000))
	   + arr((V_RENT3 + V_RENT31)*(625/1000))
	   + arr((V_RENT13 + V_RENT41)*(5263/10000))
	   + arr((V_RENT6 + V_RENT34)*(625/1000))
	   + arr((V_RENT14 + V_RENT42)*(5263/10000))
	   + arr((V_RENT7 + V_RENT35)*(625/1000)),
	                                   RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC
					   -RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RCOLENT) , 0))
          * (1 - V_CNR) * (1 - ART1731BIS);


RIDOMENT = RLOCENT ;

regle 14085:
application : iliad, batch ;

INVRETQB = NINVRETQB * (1 - V_CNR) ; 

INVRETQC = NINVRETQC * (1 - V_CNR) ; 

INVRETQT = NINVRETQT * (1 - V_CNR) ; 

INVRETQL = min(NINVRETQL , max(0 , PLAF_INVDOM -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX
					       -INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF-INVRETPB-INVRETPF-INVRETPJ
					       -INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY-INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS
					       -INVRETPX-INVRETRK-INVRETRP-INVRETRU-INVRETNU-INVRETPP-INVRETPU-INVRETRG-INVRETRM-INVRETRR-INVRETRW-INVRETNW)) * (1 - V_CNR) ;

INVRETQM = min(NINVRETQM , max(0 , PLAF_INVDOM -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX 
					       -INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF-INVRETPB-INVRETPF-INVRETPJ
					       -INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY-INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS
					       -INVRETPX-INVRETRK-INVRETRP-INVRETRU-INVRETNU-INVRETPP-INVRETPU-INVRETRG-INVRETRM-INVRETRR-INVRETRW-INVRETNW
					       - INVRETQL)) * (1 - V_CNR) ;

INVRETQD = min(NINVRETQD , max(0 , PLAF_INVDOM -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX 
					       -INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF-INVRETPB-INVRETPF-INVRETPJ
					       -INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY-INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS
					       -INVRETPX-INVRETRK-INVRETRP-INVRETRU-INVRETNU-INVRETPP-INVRETPU-INVRETRG-INVRETRM-INVRETRR-INVRETRW-INVRETNW
					       - INVRETQL - INVRETQM)) * (1 - V_CNR) ;

INVRETOB = min(NINVRETOB , max(0 , PLAF_INVDOM -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX 
					       -INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF-INVRETPB-INVRETPF-INVRETPJ
					       -INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY-INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS
					       -INVRETPX-INVRETRK-INVRETRP-INVRETRU-INVRETNU-INVRETPP-INVRETPU-INVRETRG-INVRETRM-INVRETRR-INVRETRW-INVRETNW
					       - INVRETQL - INVRETQM - INVRETQD)) * (1 - V_CNR) ;

INVRETOC = min(NINVRETOC , max(0 , PLAF_INVDOM -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX 
					       -INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF-INVRETPB-INVRETPF-INVRETPJ
					       -INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY-INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS
					       -INVRETPX-INVRETRK-INVRETRP-INVRETRU-INVRETNU-INVRETPP-INVRETPU-INVRETRG-INVRETRM-INVRETRR-INVRETRW-INVRETNW
					       - INVRETQL - INVRETQM - INVRETQD - INVRETOB)) * (1 - V_CNR) ;

INVRETOI = min(NINVRETOI , max(0 , PLAF_INVDOM3 -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX 
					        -INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF-INVRETPB-INVRETPF-INVRETPJ
					        -INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY-INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS
					        -INVRETPX-INVRETRK-INVRETRP-INVRETRU-INVRETNU-INVRETPP-INVRETPU-INVRETRG-INVRETRM-INVRETRR-INVRETRW-INVRETNW
					        - INVRETQL - INVRETQM - INVRETQD - INVRETOB - INVRETOC)) * (1 - V_CNR) ;

INVRETOJ = min(NINVRETOJ , max(0 , PLAF_INVDOM3 -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX 
					        -INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF-INVRETPB-INVRETPF-INVRETPJ
					        -INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY-INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS
					        -INVRETPX-INVRETRK-INVRETRP-INVRETRU-INVRETNU-INVRETPP-INVRETPU-INVRETRG-INVRETRM-INVRETRR-INVRETRW-INVRETNW
					        - INVRETQL - INVRETQM - INVRETQD - INVRETOB - INVRETOC - INVRETOI)) * (1 - V_CNR) ;

INVRETOK = min(NINVRETOK , max(0 , PLAF_INVDOM3 -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX 
					        -INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF-INVRETPB-INVRETPF-INVRETPJ
					        -INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY-INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS
					        -INVRETPX-INVRETRK-INVRETRP-INVRETRU-INVRETNU-INVRETPP-INVRETPU-INVRETRG-INVRETRM-INVRETRR-INVRETRW-INVRETNW
					        - INVRETQL - INVRETQM - INVRETQD - INVRETOB - INVRETOC - INVRETOI - INVRETOJ)) * (1 - V_CNR) ;

INVRETOM = min(NINVRETOM , max(0 , PLAF_INVDOM -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX 
					       -INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF-INVRETPB-INVRETPF-INVRETPJ
					       -INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY-INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS
					       -INVRETPX-INVRETRK-INVRETRP-INVRETRU-INVRETNU-INVRETPP-INVRETPU-INVRETRG-INVRETRM-INVRETRR-INVRETRW-INVRETNW
					       - INVRETQL - INVRETQM - INVRETQD - INVRETOB - INVRETOC - INVRETOI - INVRETOJ - INVRETOK)) * (1 - V_CNR) ;

INVRETON = min(NINVRETON , max(0 , PLAF_INVDOM -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX 
					       -INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF-INVRETPB-INVRETPF-INVRETPJ
					       -INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY-INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS
					       -INVRETPX-INVRETRK-INVRETRP-INVRETRU-INVRETNU-INVRETPP-INVRETPU-INVRETRG-INVRETRM-INVRETRR-INVRETRW-INVRETNW
					       - INVRETQL - INVRETQM - INVRETQD - INVRETOB - INVRETOC - INVRETOI - INVRETOJ - INVRETOK - INVRETOM)) * (1 - V_CNR) ;

INVRETOP = min(NINVRETOP , max(0 , PLAF_INVDOM3 -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX 
					        -INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF-INVRETPB-INVRETPF-INVRETPJ
					        -INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY-INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS
					        -INVRETPX-INVRETRK-INVRETRP-INVRETRU-INVRETNU-INVRETPP-INVRETPU-INVRETRG-INVRETRM-INVRETRR-INVRETRW-INVRETNW
					        - INVRETQL - INVRETQM - INVRETQD - INVRETOB - INVRETOC - INVRETOI - INVRETOJ - INVRETOK - INVRETOM - INVRETON)) * (1 - V_CNR) ;

INVRETOQ = min(NINVRETOQ , max(0 , PLAF_INVDOM3 -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX 
					        -INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF-INVRETPB-INVRETPF-INVRETPJ
					        -INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY-INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS
					        -INVRETPX-INVRETRK-INVRETRP-INVRETRU-INVRETNU-INVRETPP-INVRETPU-INVRETRG-INVRETRM-INVRETRR-INVRETRW-INVRETNW
					        - INVRETQL - INVRETQM - INVRETQD - INVRETOB - INVRETOC - INVRETOI - INVRETOJ - INVRETOK - INVRETOM - INVRETON
						- INVRETOP)) * (1 - V_CNR) ;

INVRETOR = min(NINVRETOR , max(0 , PLAF_INVDOM3 -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX 
					        -INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF-INVRETPB-INVRETPF-INVRETPJ
					        -INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY-INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS
					        -INVRETPX-INVRETRK-INVRETRP-INVRETRU-INVRETNU-INVRETPP-INVRETPU-INVRETRG-INVRETRM-INVRETRR-INVRETRW-INVRETNW
					        - INVRETQL - INVRETQM - INVRETQD - INVRETOB - INVRETOC - INVRETOI - INVRETOJ - INVRETOK - INVRETOM - INVRETON
						- INVRETOP - INVRETOQ)) * (1 - V_CNR) ;

INVRETOT = min(NINVRETOT , max(0 , PLAF_INVDOM4 -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX 
					        -INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF-INVRETPB-INVRETPF-INVRETPJ
					        -INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY-INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS
					        -INVRETPX-INVRETRK-INVRETRP-INVRETRU-INVRETNU-INVRETPP-INVRETPU-INVRETRG-INVRETRM-INVRETRR-INVRETRW-INVRETNW
					        - INVRETQL - INVRETQM - INVRETQD - INVRETOB - INVRETOC - INVRETOI - INVRETOJ - INVRETOK - INVRETOM - INVRETON
						- INVRETOP - INVRETOQ - INVRETOR)) * (1 - V_CNR) ;

INVRETOU = min(NINVRETOU , max(0 , PLAF_INVDOM4 -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX 
					        -INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF-INVRETPB-INVRETPF-INVRETPJ
					        -INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY-INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS
					        -INVRETPX-INVRETRK-INVRETRP-INVRETRU-INVRETNU-INVRETPP-INVRETPU-INVRETRG-INVRETRM-INVRETRR-INVRETRW-INVRETNW
					        - INVRETQL - INVRETQM - INVRETQD - INVRETOB - INVRETOC - INVRETOI - INVRETOJ - INVRETOK - INVRETOM - INVRETON
						- INVRETOP - INVRETOQ - INVRETOR - INVRETOT)) * (1 - V_CNR) ;

INVRETOV = min(NINVRETOV , max(0 , PLAF_INVDOM4 -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX 
					        -INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF-INVRETPB-INVRETPF-INVRETPJ
					        -INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY-INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS
					        -INVRETPX-INVRETRK-INVRETRP-INVRETRU-INVRETNU-INVRETPP-INVRETPU-INVRETRG-INVRETRM-INVRETRR-INVRETRW-INVRETNW
					        - INVRETQL - INVRETQM - INVRETQD - INVRETOB - INVRETOC - INVRETOI - INVRETOJ - INVRETOK - INVRETOM - INVRETON
						- INVRETOP - INVRETOQ - INVRETOR - INVRETOT - INVRETOU)) * (1 - V_CNR) ;

INVRETOW = min(NINVRETOW , max(0 , PLAF_INVDOM4 -INVRETKG-INVRETKH-INVRETKI-INVRETQN-INVRETQU-INVRETQK-INVRETQJ-INVRETQS-INVRETQW-INVRETQX 
					        -INVRETMA-INVRETLG-INVRETMB-INVRETMC-INVRETLH-INVRETLI-INVRETQP-INVRETQG-INVRETQO-INVRETQF-INVRETPB-INVRETPF-INVRETPJ
					        -INVRETPA-INVRETPE-INVRETPI-INVRETPO-INVRETPT-INVRETPY-INVRETRL-INVRETRQ-INVRETRV-INVRETNV-INVRETPN-INVRETPS
					        -INVRETPX-INVRETRK-INVRETRP-INVRETRU-INVRETNU-INVRETPP-INVRETPU-INVRETRG-INVRETRM-INVRETRR-INVRETRW-INVRETNW
					        - INVRETQL - INVRETQM - INVRETQD - INVRETOB - INVRETOC - INVRETOI - INVRETOJ - INVRETOK - INVRETOM - INVRETON
						- INVRETOP - INVRETOQ - INVRETOR - INVRETOT - INVRETOU - INVRETOV)) * (1 - V_CNR) ;

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

RLOGDOM =((1 - V_INDTEO) * (RLOG1 + RLOG2 + RLOG3 + RLOG4 + RLOG5 + RLOG6 + RLOG7 + RLOG8 + RLOG9 + RLOG10 + RLOG11 + RLOG12 + RLOG13 + RLOG14 + RLOG15 + RLOG16
			   + RLOG17 + RLOG18 + RLOG19 + RLOG20 + RLOG21 + RLOG22 + RLOG23 + RLOG24 + RLOG25) * (1 - V_CNR) 

         + V_INDTEO * (RLOG1 + RLOG2 + RLOG3 + RLOG4 + RLOG5 + RLOG6 + RLOG7 + RLOG8) * (1 - V_CNR)) * ( 1-ART1731BIS );

RINVDOMTOMLG = RLOGDOM ;

regle 4087:
application : iliad, batch ;
RLOC1 = max(min(INVOMREP , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC-RDOMSOC1-RCELTOT
			       -RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT) , 0) * (1 - V_CNR) ;

RLOC2 = max(min((INVRETMA * (1 - INDPLAF) + INVRETMAA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
					      		               -RLOGSOC-RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RLOC1) , 0)
							               * (1 - V_CNR) ;

RLOC3 = max(min((INVRETLG * (1 - INDPLAF) + INVRETLGA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
							               -RLOGSOC-RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RLOC1-RLOC2) , 0) 
							               * (1 - V_CNR) ;

RLOC4 = max(min((INVRETKS * (1 - INDPLAF) + INVRETKSA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
							               -RLOGSOC-RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RLOC1-RLOC2
							               -RLOC3) , 0) * (1 - V_CNR) ;

RLOC5 = max(min((INVRETMAR * (1 - INDPLAF) + INVRETMARA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
							                 -RLOGSOC-RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RLOC1-RLOC2
							                 -RLOC3-RLOC4) , 0) * (1 - V_CNR) ;

RLOC6 = max(min((INVRETLGR * (1 - INDPLAF) + INVRETLGRA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
							                 -RLOGSOC-RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RLOC1-RLOC2
							                 -RLOC3-RLOC4-RLOC5) , 0) * (1 - V_CNR) ;

RLOC7 = max(min(INVOMENTMN , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC-RDOMSOC1-RCELTOT
				 -RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6) , 0) * (1 - V_CNR) ;

RLOC8 = max(min((INVRETMB * (1 - INDPLAF) + INVRETMBA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
							               -RLOGSOC-RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RLOC1-RLOC2
							               -RLOC3-RLOC4-RLOC5-RLOC6-RLOC7) , 0) * (1 - V_CNR) ;

RLOC9 = max(min((INVRETLH * (1 - INDPLAF) + INVRETLHA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
							               -RLOGSOC-RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RLOC1-RLOC2
							               -RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8) , 0) * (1 - V_CNR) ;

RLOC10 = max(min((INVRETKT * (1 - INDPLAF) + INVRETKTA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
							                -RLOGSOC-RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RLOC1-RLOC2
							                -RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9) , 0) * (1 - V_CNR) ;

RLOC11 = max(min((INVRETMC * (1 - INDPLAF) + INVRETMCA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
							                -RLOGSOC-RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RLOC1-RLOC2
							                -RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9-RLOC10) , 0) * (1 - V_CNR) ;

RLOC12 = max(min((INVRETLI * (1 - INDPLAF) + INVRETLIA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
							                -RLOGSOC-RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RLOC1-RLOC2
							                -RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9-RLOC10-RLOC11) , 0) * (1 - V_CNR) ;

RLOC13 = max(min((INVRETKU * (1 - INDPLAF) + INVRETKUA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
							                -RLOGSOC-RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RLOC1-RLOC2
							                -RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9-RLOC10-RLOC11-RLOC12) , 0) * (1 - V_CNR) ;

RLOC14 = max(min((INVRETMBR * (1 - INDPLAF) + INVRETMBRA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
							                  -RLOGSOC-RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RLOC1-RLOC2
							                  -RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9-RLOC10-RLOC11-RLOC12-RLOC13) , 0) * (1 - V_CNR) ;

RLOC15 = max(min((INVRETLHR * (1 - INDPLAF) + INVRETLHRA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
							                  -RLOGSOC-RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RLOC1-RLOC2
							                  -RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9-RLOC10-RLOC11-RLOC12-RLOC13-RLOC14) , 0) * (1 - V_CNR) ;

RLOC16 = max(min((INVRETMCR * (1 - INDPLAF) + INVRETMCRA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
							                  -RLOGSOC-RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RLOC1-RLOC2
							                  -RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9-RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15) , 0) * (1 - V_CNR) ;

RLOC17 = max(min((INVRETLIR * (1 - INDPLAF) + INVRETLIRA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
							                  -RLOGSOC-RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RLOC1-RLOC2
							                  -RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9-RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16) , 0) 
							                  * (1 - V_CNR) ;

RLOC18 = max(min(INVOMQV , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC-RDOMSOC1-RCELTOT-RLOCNPRO
			       -RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9-RLOC10-RLOC11-RLOC12
			       -RLOC13-RLOC14-RLOC15-RLOC16-RLOC17) , 0) * (1 - V_CNR) ;

RLOC19 = max(min(INVENDEB2009 , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC-RDOMSOC1-RCELTOT-RLOCNPRO
			            -RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RLOC1-RLOC2-RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9-RLOC10-RLOC11-RLOC12
			            -RLOC13-RLOC14-RLOC15-RLOC16-RLOC17-RLOC18) , 0) * (1 - V_CNR) ;

RLOC20 = max(min((INVRETQP * (1 - INDPLAF) + INVRETQPA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
							                -RLOGSOC-RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RLOC1-RLOC2
							                -RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9-RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16
							                -RLOC17-RLOC18-RLOC19) , 0) * (1 - V_CNR) ;

RLOC21 = max(min((INVRETQG * (1 - INDPLAF) + INVRETQGA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
							                -RLOGSOC-RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RLOC1-RLOC2
							                -RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9-RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16
							                -RLOC17-RLOC18-RLOC19-RLOC20) , 0) * (1 - V_CNR) ;

RLOC22 = max(min((INVRETPB * (1 - INDPLAF) + INVRETPBA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
							                -RLOGSOC-RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RLOC1-RLOC2
							                -RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9-RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16
							                -RLOC17-RLOC18-RLOC19-RLOC20-RLOC21) , 0) * (1 - V_CNR) ;

RLOC23 = max(min((INVRETPF * (1 - INDPLAF) + INVRETPFA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
							                -RLOGSOC-RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RLOC1-RLOC2
							                -RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9-RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16
							                -RLOC17-RLOC18-RLOC19-RLOC20-RLOC21-RLOC22) , 0) * (1 - V_CNR) ;

RLOC24 = max(min((INVRETPJ * (1 - INDPLAF) + INVRETPJA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
							                -RLOGSOC-RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RLOC1-RLOC2
							                -RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9-RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16
							                -RLOC17-RLOC18-RLOC19-RLOC20-RLOC21-RLOC22-RLOC23) , 0) * (1 - V_CNR) ;

RLOC25 = max(min((INVRETQO * (1 - INDPLAF) + INVRETQOA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
							                -RLOGSOC-RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RLOC1-RLOC2
							                -RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9-RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16
							                -RLOC17-RLOC18-RLOC19-RLOC20-RLOC21-RLOC22-RLOC23-RLOC24) , 0) * (1 - V_CNR) ;

RLOC26 = max(min((INVRETQF * (1 - INDPLAF) + INVRETQFA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
							                -RLOGSOC-RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RLOC1-RLOC2
							                -RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9-RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16
							                -RLOC17-RLOC18-RLOC19-RLOC20-RLOC21-RLOC22-RLOC23-RLOC24-RLOC25) , 0) * (1 - V_CNR) ;

RLOC27 = max(min((INVRETPA * (1 - INDPLAF) + INVRETPAA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
							                -RLOGSOC-RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RLOC1-RLOC2
							                -RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9-RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16
							                -RLOC17-RLOC18-RLOC19-RLOC20-RLOC21-RLOC22-RLOC23-RLOC24-RLOC25-RLOC26) , 0) * (1 - V_CNR) ;

RLOC28 = max(min((INVRETPE * (1 - INDPLAF) + INVRETPEA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
							                -RLOGSOC-RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RLOC1-RLOC2
							                -RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9-RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16
							                -RLOC17-RLOC18-RLOC19-RLOC20-RLOC21-RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27) , 0) * (1 - V_CNR) ;

RLOC29 = max(min((INVRETPI * (1 - INDPLAF) + INVRETPIA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
							                -RLOGSOC-RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RLOC1-RLOC2
							                -RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9-RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16
							                -RLOC17-RLOC18-RLOC19-RLOC20-RLOC21-RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28) , 0) * (1 - V_CNR) ;

RLOC30 = max(min((INVRETQR * (1 - INDPLAF) + INVRETQRA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
							                -RLOGSOC-RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RLOC1-RLOC2
							                -RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9-RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16
							                -RLOC17-RLOC18-RLOC19-RLOC20-RLOC21-RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29) , 0) 
									* (1 - V_CNR) ;

RLOC31 = max(min((INVRETQI * (1 - INDPLAF) + INVRETQIA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
							                -RLOGSOC-RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RLOC1-RLOC2
							                -RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9-RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16
							                -RLOC17-RLOC18-RLOC19-RLOC20-RLOC21-RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29
							                -RLOC30) , 0) * (1 - V_CNR) ;

RLOC32 = max(min((INVRETPD * (1 - INDPLAF) + INVRETPDA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
							                -RLOGSOC-RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RLOC1-RLOC2
							                -RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9-RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16
							                -RLOC17-RLOC18-RLOC19-RLOC20-RLOC21-RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29
							                -RLOC30-RLOC31) , 0) * (1 - V_CNR) ;

RLOC33 = max(min((INVRETPH * (1 - INDPLAF) + INVRETPHA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
							                -RLOGSOC-RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RLOC1-RLOC2
							                -RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9-RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16
							                -RLOC17-RLOC18-RLOC19-RLOC20-RLOC21-RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29
							                -RLOC30-RLOC31-RLOC32) , 0) * (1 - V_CNR) ;

RLOC34 = max(min((INVRETPL * (1 - INDPLAF) + INVRETPLA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
							                -RLOGSOC-RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RLOC1-RLOC2
							                -RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9-RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16
							                -RLOC17-RLOC18-RLOC19-RLOC20-RLOC21-RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29
							                -RLOC30-RLOC31-RLOC32-RLOC33) , 0) * (1 - V_CNR) ;

RLOC35 = max(min((INVRETQPR * (1 - INDPLAF) + INVRETQPRA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
							                  -RLOGSOC-RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RLOC1-RLOC2
							                  -RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9-RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16
							                  -RLOC17-RLOC18-RLOC19-RLOC20-RLOC21-RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29
							                  -RLOC30-RLOC31-RLOC32-RLOC33-RLOC34) , 0) * (1 - V_CNR) ;

RLOC36 = max(min((INVRETQGR * (1 - INDPLAF) + INVRETQGRA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
							                  -RLOGSOC-RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RLOC1-RLOC2
							                  -RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9-RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16
							                  -RLOC17-RLOC18-RLOC19-RLOC20-RLOC21-RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29
							                  -RLOC30-RLOC31-RLOC32-RLOC33-RLOC34-RLOC35) , 0) * (1 - V_CNR) ;

RLOC37 = max(min((INVRETPBR * (1 - INDPLAF) + INVRETPBRA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
							                  -RLOGSOC-RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RLOC1-RLOC2
							                  -RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9-RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16
							                  -RLOC17-RLOC18-RLOC19-RLOC20-RLOC21-RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29
							                  -RLOC30-RLOC31-RLOC32-RLOC33-RLOC34-RLOC35-RLOC36) , 0) * (1 - V_CNR) ;

RLOC38 = max(min((INVRETPFR * (1 - INDPLAF) + INVRETPFRA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
							                  -RLOGSOC-RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RLOC1-RLOC2
							                  -RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9-RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16
							                  -RLOC17-RLOC18-RLOC19-RLOC20-RLOC21-RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29
							                  -RLOC30-RLOC31-RLOC32-RLOC33-RLOC34-RLOC35-RLOC36-RLOC37) , 0) * (1 - V_CNR) ;

RLOC39 = max(min((INVRETPJR * (1 - INDPLAF) + INVRETPJRA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
							                  -RLOGSOC-RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RLOC1-RLOC2
							                  -RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9-RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16
							                  -RLOC17-RLOC18-RLOC19-RLOC20-RLOC21-RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29
							                  -RLOC30-RLOC31-RLOC32-RLOC33-RLOC34-RLOC35-RLOC36-RLOC37-RLOC38) , 0) * (1 - V_CNR) ;

RLOC40 = max(min((INVRETQOR * (1 - INDPLAF) + INVRETQORA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
							                  -RLOGSOC-RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RLOC1-RLOC2
							                  -RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9-RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16
							                  -RLOC17-RLOC18-RLOC19-RLOC20-RLOC21-RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29
							                  -RLOC30-RLOC31-RLOC32-RLOC33-RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39) , 0) * (1 - V_CNR) ;

RLOC41 = max(min((INVRETQFR * (1 - INDPLAF) + INVRETQFRA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
							                  -RLOGSOC-RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RLOC1-RLOC2
							                  -RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9-RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16
							                  -RLOC17-RLOC18-RLOC19-RLOC20-RLOC21-RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29
							                  -RLOC30-RLOC31-RLOC32-RLOC33-RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40) , 0) * (1 - V_CNR) ;

RLOC42 = max(min((INVRETPAR * (1 - INDPLAF) + INVRETPARA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
							                  -RLOGSOC-RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RLOC1-RLOC2
							                  -RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9-RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16
							                  -RLOC17-RLOC18-RLOC19-RLOC20-RLOC21-RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29
							                  -RLOC30-RLOC31-RLOC32-RLOC33-RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41) , 0) * (1 - V_CNR) ;

RLOC43 = max(min((INVRETPER * (1 - INDPLAF) + INVRETPERA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
							                  -RLOGSOC-RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RLOC1-RLOC2
							                  -RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9-RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16
							                  -RLOC17-RLOC18-RLOC19-RLOC20-RLOC21-RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29
							                  -RLOC30-RLOC31-RLOC32-RLOC33-RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42) , 0) 
									  * (1 - V_CNR) ;

RLOC44 = max(min((INVRETPIR * (1 - INDPLAF) + INVRETPIRA * INDPLAF) , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
							                  -RLOGSOC-RDOMSOC1-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT-RLOC1-RLOC2
							                  -RLOC3-RLOC4-RLOC5-RLOC6-RLOC7-RLOC8-RLOC9-RLOC10-RLOC11-RLOC12-RLOC13-RLOC14-RLOC15-RLOC16
							                  -RLOC17-RLOC18-RLOC19-RLOC20-RLOC21-RLOC22-RLOC23-RLOC24-RLOC25-RLOC26-RLOC27-RLOC28-RLOC29
							                  -RLOC30-RLOC31-RLOC32-RLOC33-RLOC34-RLOC35-RLOC36-RLOC37-RLOC38-RLOC39-RLOC40-RLOC41-RLOC42
							                  -RLOC43) , 0) * (1 - V_CNR) ;

RCOLENT = ((1-V_INDTEO) * (RLOC1 + RLOC2 + RLOC3 + RLOC4 + RLOC5 + RLOC6 + RLOC7 + RLOC8 + RLOC9 + RLOC10 + RLOC11 + RLOC12 + RLOC13 + RLOC14 + RLOC15 
			   + RLOC16 + RLOC17 + RLOC18 + RLOC19 + RLOC20 + RLOC21 + RLOC22 + RLOC23 + RLOC24 + RLOC25 + RLOC26 + RLOC27 + RLOC28 + RLOC29 
			   + RLOC30 + RLOC31 + RLOC32 + RLOC33 + RLOC34 + RLOC35 + RLOC36 + RLOC37 + RLOC38 + RLOC39 + RLOC40 + RLOC41 + RLOC42 + RLOC43 + RLOC44)
          + (V_INDTEO) * (RLOC1 + RLOC7 + RLOC18 + RLOC19 
                        + arr((V_RLOC3+V_RLOC6)*(TX50/100)) 
	                + arr((V_RLOC2+V_RLOC5)*(TX60/100)) 
                        + arr((V_RLOC9+V_RLOC15)*(TX50/100))
			+ arr((V_RLOC8+V_RLOC14)*(TX60/100))
			+ arr((V_RLOC25+V_RLOC40)*(TX60/100))
			+ arr((V_RLOC20+V_RLOC35)*(TX60/100))
			+ arr((V_RLOC27+V_RLOC42)*(5263/10000))
			+ arr((V_RLOC22+V_RLOC37)*(625/1000))
			+ arr((V_RLOC12+V_RLOC17)*(TX50/100))
			+ arr((V_RLOC11+V_RLOC16)*(60/100))
			+ arr((V_RLOC26+V_RLOC41)*(50/100))
			+ arr((V_RLOC21+V_RLOC36)*(60/100))
			+ arr((V_RLOC28+V_RLOC43)*(5263/10000))
			+ arr((V_RLOC23+V_RLOC38)*(625/1000))
			+ arr((V_RLOC29+V_RLOC44)*(5263/10000))
			+ arr((V_RLOC24+V_RLOC39)*(625/1000))
			
			)) * (1 - V_CNR) * (1 - ART1731BIS);

regle 4086:
application : iliad, batch ;

REPKG = max(0 , INVSOCNRET - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
				     -RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT)) * (1 - V_CNR) ;

REPDOMSOC3 = REPKG * (1 - V_CNR) ;


REPKH = max(0 , INVOMSOCKH - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
				     -RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-INVSOCNRET)) * (1 - V_CNR) ;

REPKI = max(0 , INVOMSOCKI - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS
				     -RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-INVSOCNRET-INVOMSOCKH)) * (1 - V_CNR) ;

REPDOMSOC2 = (REPKH + REPKI) * (1 - V_CNR) ;


REPQN = max(0 , INVSOC2010 - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RCELTOT-RLOCNPRO
					 -RNOUV-RPATNAT2-RPATNAT1-RPATNAT-INVSOCNRET-INVOMSOCKH-INVOMSOCKI)) * (1 - V_CNR) ;

REPQU = max(0 , INVOMSOCQU - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RCELTOT-RLOCNPRO
					 -RNOUV-RPATNAT2-RPATNAT1-RPATNAT-INVSOCNRET-INVOMSOCKH-INVOMSOCKI-INVSOC2010)) * (1 - V_CNR) ;

REPQK = max(0 , INVLOGSOC - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RCELTOT-RLOCNPRO
					-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-INVSOCNRET-INVOMSOCKH-INVOMSOCKI-INVSOC2010-INVOMSOCQU)) * (1 - V_CNR) ;

REPDOMSOC1 = (REPQN + REPQU + REPQK) * (1 - V_CNR) ;


REPQJ = max(0 , INVOMSOCQJ - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RCELTOT-RLOCNPRO
					 -RNOUV-RPATNAT2-RPATNAT1-RPATNAT-INVSOCNRET-INVOMSOCKH-INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC)) * (1 - V_CNR) ;

REPQS = max(0 , INVOMSOCQS - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RCELTOT-RLOCNPRO
					 -RNOUV-RPATNAT2-RPATNAT1-RPATNAT-INVSOCNRET-INVOMSOCKH-INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-INVOMSOCQJ)) * (1 - V_CNR) ;

REPQW = max(0 , INVOMSOCQW - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RCELTOT-RLOCNPRO
					 -RNOUV-RPATNAT2-RPATNAT1-RPATNAT-INVSOCNRET-INVOMSOCKH-INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-INVOMSOCQJ
					 -INVOMSOCQS)) * (1 - V_CNR) ;

REPQX = max(0 , INVOMSOCQX - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RCELTOT-RLOCNPRO
					 -RNOUV-RPATNAT2-RPATNAT1-RPATNAT-INVSOCNRET-INVOMSOCKH-INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-INVOMSOCQJ
					 -INVOMSOCQS-INVOMSOCQW)) * (1 - V_CNR) ;

REPDOMSOC = (REPQJ + REPQS + REPQW + REPQX) * (1 - V_CNR) ;


REPMM = max(0 , INVOMREP - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
				       -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				       -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX)) * (1 - V_CNR) ;

REPMA = max(0 , NRETROC40 - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					-INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				        -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP)) * (1 - V_CNR) ;

REPLG = max(0 , NRETROC50 - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					-INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT1-RPATNAT2-RPATNAT-RIDOMPROTOT
				        -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40)) * (1 - V_CNR) ;

REPKS = max(0 , INVENDI - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
				      -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				      -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50)) * (1 - V_CNR) ;

REPDOMENTR3 = (REPMM + REPMA + REPLG + REPKS) * (1 - V_CNR) ;


REPMN = max(0 , INVOMENTMN - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI)) * (1 - V_CNR) ;

REPMB = max(0 , RETROCOMMB - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN)) * (1 - V_CNR) ;

REPMC = max(0 , RETROCOMMC - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB)) * (1 - V_CNR) ;

REPLH = max(0 , RETROCOMLH - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					 -RETROCOMMC)) * (1 - V_CNR) ;

REPLI = max(0 , RETROCOMLI - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					 -RETROCOMMC-RETROCOMLH)) * (1 - V_CNR) ;

REPKT = max(0 , INVOMENTKT - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					 -RETROCOMMC-RETROCOMLH-RETROCOMLI)) * (1 - V_CNR) ;

REPKU = max(0 , INVOMENTKU - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					 -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT)) * (1 - V_CNR) ;

REPDOMENTR2 = (REPMN + REPMB + REPMC + REPLH + REPLI + REPKT + REPKU) * (1 - V_CNR) ;


REPQV = max(0 , INVOMQV - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
				      -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				      -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
				      -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU)) * (1 - V_CNR) ;

REPQE = max(0 , INVENDEB2009 - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					   -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				           -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					   -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVOMQV)) * (1 - V_CNR) ;

REPQP = max(0 , INVRETRO2 - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					-INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				        -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					-RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVENDEB2009-INVOMQV)) * (1 - V_CNR) ;

REPQG = max(0 , INVDOMRET60 - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					  -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				          -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					  -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVENDEB2009-INVOMQV-INVRETRO2)) * (1 - V_CNR) ;

REPPB = max(0 , INVOMRETPB - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					 -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVENDEB2009-INVOMQV-INVRETRO2-INVDOMRET60)) * (1 - V_CNR) ;

REPPF = max(0 , INVOMRETPF - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					 -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVENDEB2009-INVOMQV-INVRETRO2-INVDOMRET60-INVOMRETPB)) 
					 * (1 - V_CNR) ;

REPPJ = max(0 , INVOMRETPJ - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					 -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVENDEB2009-INVOMQV-INVRETRO2-INVDOMRET60-INVOMRETPB
					 -INVOMRETPF)) * (1 - V_CNR) ;

REPQO = max(0 , INVRETRO1 - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					-INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				        -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					-RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVENDEB2009-INVOMQV-INVRETRO2-INVDOMRET60-INVOMRETPB
					-INVOMRETPF-INVOMRETPJ)) * (1 - V_CNR) ;

REPQF = max(0 , INVDOMRET50 - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					  -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				          -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					  -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVENDEB2009-INVOMQV-INVRETRO2-INVDOMRET60-INVOMRETPB
					  -INVOMRETPF-INVOMRETPJ-INVRETRO1)) * (1 - V_CNR) ;

REPPA = max(0 , INVOMRETPA - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					 -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVENDEB2009-INVOMQV-INVRETRO2-INVDOMRET60-INVOMRETPB
					 -INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50)) * (1 - V_CNR) ;

REPPE = max(0 , INVOMRETPE - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					 -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVENDEB2009-INVOMQV-INVRETRO2-INVDOMRET60-INVOMRETPB
					 -INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50-INVOMRETPA)) * (1 - V_CNR) ;

REPPI = max(0 , INVOMRETPI - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					 -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVENDEB2009-INVOMQV-INVRETRO2-INVDOMRET60-INVOMRETPB
					 -INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50-INVOMRETPA-INVOMRETPE)) * (1 - V_CNR) ;

REPQR = max(0 , INVIMP - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
				     -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				     -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
				     -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVENDEB2009-INVOMQV-INVRETRO2-INVDOMRET60-INVOMRETPB
				     -INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50-INVOMRETPA-INVOMRETPE-INVOMRETPI)) * (1 - V_CNR) ;

REPQI = max(0 , INVDIR2009 - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					 -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVENDEB2009-INVOMQV-INVRETRO2-INVDOMRET60-INVOMRETPB
					 -INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50-INVOMRETPA-INVOMRETPE-INVOMRETPI-INVIMP)) * (1 - V_CNR) ;

REPPD = max(0 , INVOMRETPD - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					 -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVENDEB2009-INVOMQV-INVRETRO2-INVDOMRET60-INVOMRETPB
					 -INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50-INVOMRETPA-INVOMRETPE-INVOMRETPI-INVIMP-INVDIR2009)) * (1 - V_CNR) ;

REPPH = max(0 , INVOMRETPH - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					 -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVENDEB2009-INVOMQV-INVRETRO2-INVDOMRET60-INVOMRETPB
					 -INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50-INVOMRETPA-INVOMRETPE-INVOMRETPI-INVIMP-INVDIR2009-INVOMRETPD)) 
					 * (1 - V_CNR) ;

REPPL = max(0 , INVOMRETPL - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					 -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVENDEB2009-INVOMQV-INVRETRO2-INVDOMRET60-INVOMRETPB
					 -INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50-INVOMRETPA-INVOMRETPE-INVOMRETPI-INVIMP-INVDIR2009-INVOMRETPD
					 -INVOMRETPH)) * (1 - V_CNR) ;

REPDOMENTR1 = (REPQE + REPQV + REPQP + REPQG + REPQO + REPQF + REPQR + REPQI + REPPB + REPPF + REPPJ + REPPA + REPPE + REPPI + REPPD + REPPH + REPPL) * (1 - V_CNR) ;


REPPM = max(0 , INVOMRETPM - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					 -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVENDEB2009-INVOMQV-INVRETRO2-INVDOMRET60-INVOMRETPB
					 -INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50-INVOMRETPA-INVOMRETPE-INVOMRETPI-INVIMP-INVDIR2009-INVOMRETPD
					 -INVOMRETPH-INVOMRETPL)) * (1 - V_CNR) ;

REPRJ = max(0 , INVOMENTRJ - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					 -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVENDEB2009-INVOMQV-INVRETRO2-INVDOMRET60-INVOMRETPB
					 -INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50-INVOMRETPA-INVOMRETPE-INVOMRETPI-INVIMP-INVDIR2009-INVOMRETPD
					 -INVOMRETPH-INVOMRETPL-INVOMRETPM)) * (1 - V_CNR) ;

REPPO = max(0 , INVOMRETPO - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					 -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVENDEB2009-INVOMQV-INVRETRO2-INVDOMRET60-INVOMRETPB
					 -INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50-INVOMRETPA-INVOMRETPE-INVOMRETPI-INVIMP-INVDIR2009-INVOMRETPD
					 -INVOMRETPH-INVOMRETPL-INVOMRETPM-INVOMENTRJ)) * (1 - V_CNR) ;

REPPT = max(0 , INVOMRETPT - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					 -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVENDEB2009-INVOMQV-INVRETRO2-INVDOMRET60-INVOMRETPB
					 -INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50-INVOMRETPA-INVOMRETPE-INVOMRETPI-INVIMP-INVDIR2009-INVOMRETPD
					 -INVOMRETPH-INVOMRETPL-INVOMRETPM-INVOMENTRJ-INVOMRETPO)) * (1 - V_CNR) ;

REPPY = max(0 , INVOMRETPY - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					 -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVENDEB2009-INVOMQV-INVRETRO2-INVDOMRET60-INVOMRETPB
					 -INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50-INVOMRETPA-INVOMRETPE-INVOMRETPI-INVIMP-INVDIR2009-INVOMRETPD
					 -INVOMRETPH-INVOMRETPL-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT)) * (1 - V_CNR) ;

REPRL = max(0 , INVOMENTRL - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					 -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVENDEB2009-INVOMQV-INVRETRO2-INVDOMRET60-INVOMRETPB
					 -INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50-INVOMRETPA-INVOMRETPE-INVOMRETPI-INVIMP-INVDIR2009-INVOMRETPD
					 -INVOMRETPH-INVOMRETPL-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY)) * (1 - V_CNR) ;

REPRQ = max(0 , INVOMENTRQ - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					 -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVENDEB2009-INVOMQV-INVRETRO2-INVDOMRET60-INVOMRETPB
					 -INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50-INVOMRETPA-INVOMRETPE-INVOMRETPI-INVIMP-INVDIR2009-INVOMRETPD
					 -INVOMRETPH-INVOMRETPL-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL)) * (1 - V_CNR) ;

REPRV = max(0 , INVOMENTRV - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					 -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVENDEB2009-INVOMQV-INVRETRO2-INVDOMRET60-INVOMRETPB
					 -INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50-INVOMRETPA-INVOMRETPE-INVOMRETPI-INVIMP-INVDIR2009-INVOMRETPD
					 -INVOMRETPH-INVOMRETPL-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ)) * (1 - V_CNR) ;

REPNV = max(0 , INVOMENTNV - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					 -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVENDEB2009-INVOMQV-INVRETRO2-INVDOMRET60-INVOMRETPB
					 -INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50-INVOMRETPA-INVOMRETPE-INVOMRETPI-INVIMP-INVDIR2009-INVOMRETPD
					 -INVOMRETPH-INVOMRETPL-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ-INVOMENTRV)) 
					 * (1 - V_CNR) ;

REPPN = max(0 , INVOMRETPN - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					 -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVENDEB2009-INVOMQV-INVRETRO2-INVDOMRET60-INVOMRETPB
					 -INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50-INVOMRETPA-INVOMRETPE-INVOMRETPI-INVIMP-INVDIR2009-INVOMRETPD
					 -INVOMRETPH-INVOMRETPL-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ-INVOMENTRV
					 -INVOMENTNV)) * (1 - V_CNR) ;

REPPS = max(0 , INVOMRETPS - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					 -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVENDEB2009-INVOMQV-INVRETRO2-INVDOMRET60-INVOMRETPB
					 -INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50-INVOMRETPA-INVOMRETPE-INVOMRETPI-INVIMP-INVDIR2009-INVOMRETPD
					 -INVOMRETPH-INVOMRETPL-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ-INVOMENTRV
					 -INVOMENTNV-INVOMRETPN)) * (1 - V_CNR) ;

REPPX = max(0 , INVOMRETPX - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					 -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVENDEB2009-INVOMQV-INVRETRO2-INVDOMRET60-INVOMRETPB
					 -INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50-INVOMRETPA-INVOMRETPE-INVOMRETPI-INVIMP-INVDIR2009-INVOMRETPD
					 -INVOMRETPH-INVOMRETPL-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ-INVOMENTRV
					 -INVOMENTNV-INVOMRETPN-INVOMRETPS)) * (1 - V_CNR) ;

REPRK = max(0 , INVOMENTRK - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					 -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVENDEB2009-INVOMQV-INVRETRO2-INVDOMRET60-INVOMRETPB
					 -INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50-INVOMRETPA-INVOMRETPE-INVOMRETPI-INVIMP-INVDIR2009-INVOMRETPD
					 -INVOMRETPH-INVOMRETPL-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ-INVOMENTRV
					 -INVOMENTNV-INVOMRETPN-INVOMRETPS-INVOMRETPX)) * (1 - V_CNR) ;

REPRP = max(0 , INVOMENTRP - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					 -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVENDEB2009-INVOMQV-INVRETRO2-INVDOMRET60-INVOMRETPB
					 -INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50-INVOMRETPA-INVOMRETPE-INVOMRETPI-INVIMP-INVDIR2009-INVOMRETPD
					 -INVOMRETPH-INVOMRETPL-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ-INVOMENTRV
					 -INVOMENTNV-INVOMRETPN-INVOMRETPS-INVOMRETPX-INVOMENTRK)) * (1 - V_CNR) ;

REPRU = max(0 , INVOMENTRU - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					 -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVENDEB2009-INVOMQV-INVRETRO2-INVDOMRET60-INVOMRETPB
					 -INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50-INVOMRETPA-INVOMRETPE-INVOMRETPI-INVIMP-INVDIR2009-INVOMRETPD
					 -INVOMRETPH-INVOMRETPL-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ-INVOMENTRV
					 -INVOMENTNV-INVOMRETPN-INVOMRETPS-INVOMRETPX-INVOMENTRK-INVOMENTRP)) * (1 - V_CNR) ;

REPNU = max(0 , INVOMENTNU - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					 -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVENDEB2009-INVOMQV-INVRETRO2-INVDOMRET60-INVOMRETPB
					 -INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50-INVOMRETPA-INVOMRETPE-INVOMRETPI-INVIMP-INVDIR2009-INVOMRETPD
					 -INVOMRETPH-INVOMRETPL-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ-INVOMENTRV
					 -INVOMENTNV-INVOMRETPN-INVOMRETPS-INVOMRETPX-INVOMENTRK-INVOMENTRP-INVOMENTRU)) * (1 - V_CNR) ;

REPPP = max(0 , INVOMRETPP - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					 -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVENDEB2009-INVOMQV-INVRETRO2-INVDOMRET60-INVOMRETPB
					 -INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50-INVOMRETPA-INVOMRETPE-INVOMRETPI-INVIMP-INVDIR2009-INVOMRETPD
					 -INVOMRETPH-INVOMRETPL-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ-INVOMENTRV
					 -INVOMENTNV-INVOMRETPN-INVOMRETPS-INVOMRETPX-INVOMENTRK-INVOMENTRP-INVOMENTRU-INVOMENTNU)) * (1 - V_CNR) ;

REPPU = max(0 , INVOMRETPU - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					 -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVENDEB2009-INVOMQV-INVRETRO2-INVDOMRET60-INVOMRETPB
					 -INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50-INVOMRETPA-INVOMRETPE-INVOMRETPI-INVIMP-INVDIR2009-INVOMRETPD
					 -INVOMRETPH-INVOMRETPL-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ-INVOMENTRV
					 -INVOMENTNV-INVOMRETPN-INVOMRETPS-INVOMRETPX-INVOMENTRK-INVOMENTRP-INVOMENTRU-INVOMENTNU-INVOMRETPP)) * (1 - V_CNR) ;

REPRG = max(0 , INVOMENTRG - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					 -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVENDEB2009-INVOMQV-INVRETRO2-INVDOMRET60-INVOMRETPB
					 -INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50-INVOMRETPA-INVOMRETPE-INVOMRETPI-INVIMP-INVDIR2009-INVOMRETPD
					 -INVOMRETPH-INVOMRETPL-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ-INVOMENTRV
					 -INVOMENTNV-INVOMRETPN-INVOMRETPS-INVOMRETPX-INVOMENTRK-INVOMENTRP-INVOMENTRU-INVOMENTNU-INVOMRETPP-INVOMRETPU)) 
					 * (1 - V_CNR) ;

REPRM = max(0 , INVOMENTRM - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					 -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVENDEB2009-INVOMQV-INVRETRO2-INVDOMRET60-INVOMRETPB
					 -INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50-INVOMRETPA-INVOMRETPE-INVOMRETPI-INVIMP-INVDIR2009-INVOMRETPD
					 -INVOMRETPH-INVOMRETPL-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ-INVOMENTRV
					 -INVOMENTNV-INVOMRETPN-INVOMRETPS-INVOMRETPX-INVOMENTRK-INVOMENTRP-INVOMENTRU-INVOMENTNU-INVOMRETPP-INVOMRETPU
					 -INVOMENTRG)) * (1 - V_CNR) ;

REPRR = max(0 , INVOMENTRR - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					 -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVENDEB2009-INVOMQV-INVRETRO2-INVDOMRET60-INVOMRETPB
					 -INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50-INVOMRETPA-INVOMRETPE-INVOMRETPI-INVIMP-INVDIR2009-INVOMRETPD
					 -INVOMRETPH-INVOMRETPL-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ-INVOMENTRV
					 -INVOMENTNV-INVOMRETPN-INVOMRETPS-INVOMRETPX-INVOMENTRK-INVOMENTRP-INVOMENTRU-INVOMENTNU-INVOMRETPP-INVOMRETPU
					 -INVOMENTRG-INVOMENTRM)) * (1 - V_CNR) ;

REPRW = max(0 , INVOMENTRW - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					 -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVENDEB2009-INVOMQV-INVRETRO2-INVDOMRET60-INVOMRETPB
					 -INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50-INVOMRETPA-INVOMRETPE-INVOMRETPI-INVIMP-INVDIR2009-INVOMRETPD
					 -INVOMRETPH-INVOMRETPL-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ-INVOMENTRV
					 -INVOMENTNV-INVOMRETPN-INVOMRETPS-INVOMRETPX-INVOMENTRK-INVOMENTRP-INVOMENTRU-INVOMENTNU-INVOMRETPP-INVOMRETPU
					 -INVOMENTRG-INVOMENTRM-INVOMENTRR)) * (1 - V_CNR) ;

REPNW = max(0 , INVOMENTNW - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					 -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVENDEB2009-INVOMQV-INVRETRO2-INVDOMRET60-INVOMRETPB
					 -INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50-INVOMRETPA-INVOMRETPE-INVOMRETPI-INVIMP-INVDIR2009-INVOMRETPD
					 -INVOMRETPH-INVOMRETPL-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ-INVOMENTRV
					 -INVOMENTNV-INVOMRETPN-INVOMRETPS-INVOMRETPX-INVOMENTRK-INVOMENTRP-INVOMENTRU-INVOMENTNU-INVOMRETPP-INVOMRETPU
					 -INVOMENTRG-INVOMENTRM-INVOMENTRR-INVOMENTRW)) * (1 - V_CNR) ;

REPPR = max(0 , INVOMRETPR - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					 -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVENDEB2009-INVOMQV-INVRETRO2-INVDOMRET60-INVOMRETPB
					 -INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50-INVOMRETPA-INVOMRETPE-INVOMRETPI-INVIMP-INVDIR2009-INVOMRETPD
					 -INVOMRETPH-INVOMRETPL-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ-INVOMENTRV
					 -INVOMENTNV-INVOMRETPN-INVOMRETPS-INVOMRETPX-INVOMENTRK-INVOMENTRP-INVOMENTRU-INVOMENTNU-INVOMRETPP-INVOMRETPU
					 -INVOMENTRG-INVOMENTRM-INVOMENTRR-INVOMENTRW-INVOMENTNW)) * (1 - V_CNR) ;

REPPW = max(0 , INVOMRETPW - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					 -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVENDEB2009-INVOMQV-INVRETRO2-INVDOMRET60-INVOMRETPB
					 -INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50-INVOMRETPA-INVOMRETPE-INVOMRETPI-INVIMP-INVDIR2009-INVOMRETPD
					 -INVOMRETPH-INVOMRETPL-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ-INVOMENTRV
					 -INVOMENTNV-INVOMRETPN-INVOMRETPS-INVOMRETPX-INVOMENTRK-INVOMENTRP-INVOMENTRU-INVOMENTNU-INVOMRETPP-INVOMRETPU
					 -INVOMENTRG-INVOMENTRM-INVOMENTRR-INVOMENTRW-INVOMENTNW-INVOMRETPR)) * (1 - V_CNR) ;

REPRI = max(0 , INVOMENTRI - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					 -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVENDEB2009-INVOMQV-INVRETRO2-INVDOMRET60-INVOMRETPB
					 -INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50-INVOMRETPA-INVOMRETPE-INVOMRETPI-INVIMP-INVDIR2009-INVOMRETPD
					 -INVOMRETPH-INVOMRETPL-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ-INVOMENTRV
					 -INVOMENTNV-INVOMRETPN-INVOMRETPS-INVOMRETPX-INVOMENTRK-INVOMENTRP-INVOMENTRU-INVOMENTNU-INVOMRETPP-INVOMRETPU
					 -INVOMENTRG-INVOMENTRM-INVOMENTRR-INVOMENTRW-INVOMENTNW-INVOMRETPR-INVOMRETPW)) * (1 - V_CNR) ;

REPRO = max(0 , INVOMENTRO - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					 -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVENDEB2009-INVOMQV-INVRETRO2-INVDOMRET60-INVOMRETPB
					 -INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50-INVOMRETPA-INVOMRETPE-INVOMRETPI-INVIMP-INVDIR2009-INVOMRETPD
					 -INVOMRETPH-INVOMRETPL-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ-INVOMENTRV
					 -INVOMENTNV-INVOMRETPN-INVOMRETPS-INVOMRETPX-INVOMENTRK-INVOMENTRP-INVOMENTRU-INVOMENTNU-INVOMRETPP-INVOMRETPU
					 -INVOMENTRG-INVOMENTRM-INVOMENTRR-INVOMENTRW-INVOMENTNW-INVOMRETPR-INVOMRETPW-INVOMENTRI)) * (1 - V_CNR) ;

REPRT = max(0 , INVOMENTRT - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					 -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVENDEB2009-INVOMQV-INVRETRO2-INVDOMRET60-INVOMRETPB
					 -INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50-INVOMRETPA-INVOMRETPE-INVOMRETPI-INVIMP-INVDIR2009-INVOMRETPD
					 -INVOMRETPH-INVOMRETPL-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ-INVOMENTRV
					 -INVOMENTNV-INVOMRETPN-INVOMRETPS-INVOMRETPX-INVOMENTRK-INVOMENTRP-INVOMENTRU-INVOMENTNU-INVOMRETPP-INVOMRETPU
					 -INVOMENTRG-INVOMENTRM-INVOMENTRR-INVOMENTRW-INVOMENTNW-INVOMRETPR-INVOMRETPW-INVOMENTRI-INVOMENTRO)) * (1 - V_CNR) ;

REPRY = max(0 , INVOMENTRY - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					 -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVENDEB2009-INVOMQV-INVRETRO2-INVDOMRET60-INVOMRETPB
					 -INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50-INVOMRETPA-INVOMRETPE-INVOMRETPI-INVIMP-INVDIR2009-INVOMRETPD
					 -INVOMRETPH-INVOMRETPL-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ-INVOMENTRV
					 -INVOMENTNV-INVOMRETPN-INVOMRETPS-INVOMRETPX-INVOMENTRK-INVOMENTRP-INVOMENTRU-INVOMENTNU-INVOMRETPP-INVOMRETPU
					 -INVOMENTRG-INVOMENTRM-INVOMENTRR-INVOMENTRW-INVOMENTNW-INVOMRETPR-INVOMRETPW-INVOMENTRI-INVOMENTRO-INVOMENTRT)) 
					 * (1 - V_CNR) ;

REPNY = max(0 , INVOMENTNY - max(0 , RRI1-DLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-INVSOCNRET-INVOMSOCKH
					 -INVOMSOCKI-INVSOC2010-INVOMSOCQU-INVLOGSOC-RCELTOT-RLOCNPRO-RNOUV-RPATNAT2-RPATNAT1-RPATNAT-RIDOMPROTOT
				         -INVOMSOCQJ-INVOMSOCQS-INVOMSOCQW-INVOMSOCQX-INVOMREP-NRETROC40-NRETROC50-INVENDI-INVOMENTMN-RETROCOMMB
					 -RETROCOMMC-RETROCOMLH-RETROCOMLI-INVOMENTKT-INVOMENTKU-INVENDEB2009-INVOMQV-INVRETRO2-INVDOMRET60-INVOMRETPB
					 -INVOMRETPF-INVOMRETPJ-INVRETRO1-INVDOMRET50-INVOMRETPA-INVOMRETPE-INVOMRETPI-INVIMP-INVDIR2009-INVOMRETPD
					 -INVOMRETPH-INVOMRETPL-INVOMRETPM-INVOMENTRJ-INVOMRETPO-INVOMRETPT-INVOMRETPY-INVOMENTRL-INVOMENTRQ-INVOMENTRV
					 -INVOMENTNV-INVOMRETPN-INVOMRETPS-INVOMRETPX-INVOMENTRK-INVOMENTRP-INVOMENTRU-INVOMENTNU-INVOMRETPP-INVOMRETPU
					 -INVOMENTRG-INVOMENTRM-INVOMENTRR-INVOMENTRW-INVOMENTNW-INVOMRETPR-INVOMRETPW-INVOMENTRI-INVOMENTRO-INVOMENTRT
					 -INVOMENTRY)) * (1 - V_CNR) ;

REPDOMENTR = (REPPM + REPRJ + REPPO + REPPT + REPPY + REPRL + REPRQ + REPRV + REPNV + REPPN + REPPS + REPPX + REPRK + REPRP + REPRU + REPNU 
	      + REPPP + REPPU + REPRG + REPRM + REPRR + REPRW + REPNW + REPPR + REPPW + REPRI + REPRO + REPRT + REPRY + REPNY) * (1 - V_CNR) ;
regle 407018:
application : iliad , batch  ;
SEUILRED1=arr((arr(RI1)+REVQUO) / NBPT);
regle 407020:
application:iliad, batch;
RETUD = (1 - V_CNR) * (1-ART1731BIS) * arr((RDENS * MTRC) + (RDENL * MTRL) + (RDENU * MTRS) + (RDENSQAR * MTRC /2) + (RDENLQAR * MTRL /2) + (RDENUQAR * MTRS /2));
RNBE = (RDENS + RDENL + RDENU + RDENSQAR + RDENLQAR + RDENUQAR) * (1-ART1731BIS) ;
DNBE = RDENS + RDENL + RDENU + RDENSQAR + RDENLQAR + RDENUQAR ;
regle 100407020:
application:iliad, batch;
RRETU = max(min( RETUD , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT) , 0) ;

regle 407022 :
application : iliad , batch  ;
BFCPI = ( positif(BOOL_0AM) * min ( FCPI,PLAF_FCPI*2)
        + positif(1 - BOOL_0AM) * min ( FCPI,PLAF_FCPI) )
        * (1 - V_CNR) * (1 - ART1731BIS);
RFCPI = arr (BFCPI * TX_FCPI /100) ;
RINNO = max( min( RFCPI , IDOM11-DEC11-RCOTFOR-RREPA-RFIPDOM-RAIDE-RDIFAGRI-RFORET-RFIPC
			  -RCINE-RRESTIMO-RSOCREPR-RRPRESCOMP-RHEBE-RSURV) , 0 );
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

APRESCOMP = BPRESCOMP * (1 - V_CNR) * (1 - ART1731BIS) ;

RRPRESCOMP = max( min( RPRESCOMP , IDOM11-DEC11-RCOTFOR-RREPA-RFIPDOM-RAIDE-RDIFAGRI-RFORET-RFIPC-RCINE-RRESTIMO-RSOCREPR) , 0) * (1 - ART1731BIS) ;

RPRESCOMPREP =  max( min( RPRESCOMP , IDOM11-DEC11-RCOTFOR-RREPA-RFIPDOM-RAIDE-RDIFAGRI-RFORET
				      -RFIPC-RCINE-RRESTIMO-RSOCREPR) , 0) * positif(RDPRESREPORT) ;

RPRESCOMPAN =  RRPRESCOMP * (1-positif(RDPRESREPORT)) ;
regle 4081 :
application : iliad , batch  ;

DCOTFOR = COTFORET ;

ACOTFOR = min(DCOTFOR , PLAF_FOREST1 * (1 + BOOL_0AM)) * (1 - V_CNR) * (1 - ART1731BIS) ;

RCOTFOR = max( min( arr (ACOTFOR * TX76/100) , IDOM11-DEC11) , 0) ;

regle 408 :
application : iliad , batch  ;


FORTRA = RDFORESTRA + REPFOR + REPSINFOR + REPFOR1 + REPSINFOR1 + REPFOR2 + REPSINFOR2 ;

DFOREST = RDFOREST + FORTRA + RDFORESTGES ;


AFOREST = ( min (RDFOREST, PLAF_FOREST * (1 + BOOL_0AM)) 
	   + min (FORTRA, max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR)) 
	    + min (RDFORESTGES, PLAF_FOREST2 * (1 + BOOL_0AM)) ) * (1 - V_CNR) * (1 - ART1731BIS) ;


RFOREST1 = min( REPFOR + REPSINFOR + REPFOR1 + REPSINFOR1 , max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR)) ;

RFOREST2 = min( REPFOR2 + REPSINFOR2 , max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR - RFOREST1)) ;

RFOREST = (arr(RFOREST1 * TX25/100) + arr(RFOREST2 * TX22/100)
	  + arr( max(0 , AFOREST - RFOREST1 - RFOREST2) * TX18/100)) * (1 - V_CNR) * (1 - ART1731BIS) ;

RFOR = max( min( RFOREST , IDOM11-DEC11-RCOTFOR-RREPA-RFIPDOM-RAIDE-RDIFAGRI-RFORET-RFIPC-RCINE
			   -RRESTIMO-RSOCREPR-RRPRESCOMP-RHEBE-RSURV-RINNO-RSOUFIP-RRIRENOV ) , 0 );


REPBON = max(0 , REPFOR - max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR)) * (1 - V_CNR) ;

REPSIN = max(0 , REPSINFOR - max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR)) * (1 - V_CNR) ; 

REPFOREST = max(0 , REPFOR1 - max(0 , max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR) - REPFOR - REPSINFOR)) * (1 - V_CNR) ;

REPFORSIN = max(0 , REPSINFOR1 - max(0 , max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR) - REPFOR - REPSINFOR)) * (1 - V_CNR) ; 

REPFOREST2 = max(0 , REPFOR2 - max(0 , max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR) - REPFOR - REPSINFOR - REPFOR1 - REPSINFOR1)) * (1 - V_CNR) ;

REPFORSIN2 = max(0 , REPSINFOR2 - max(0 , max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR) - REPFOR - REPSINFOR - REPFOR1 - REPSINFOR1)) * (1 - V_CNR) ; 

REPEST = max(0 , max(0 , FORTRA - max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR)) - (REPBON + REPSIN + REPFOREST + REPFORSIN + REPFOREST2 + REPFORSIN2)) 
	  * (1 - positif(SINISFORET)) * (1 - V_CNR) ; 

REPNIS = max(0 , max(0 , FORTRA - max(0 , (PLAF_FOREST1 * (1 + BOOL_0AM)) - ACOTFOR)) - (REPBON + REPSIN + REPFOREST + REPFORSIN + REPFOREST2 + REPFORSIN2)) 
	  * positif(SINISFORET) * (1 - V_CNR) ;

REPFORTOT = REPBON + REPFOREST + REPFOREST2 + REPEST ;

REPFORESTA = REPSIN + REPFORSIN + REPFORSIN2 + REPNIS ;
regle 4096:
application : iliad , batch  ;


DCREAT = CONVCREA ;

DCREATHANDI = CONVHAND ;


ACREAT = DCREAT * (1 - V_CNR) * (1 - ART1731BIS) ;

ACREATHANDI = DCREATHANDI * (1 - V_CNR) * (1 - ART1731BIS) ;


RCREATEUR = CONVCREA/2 * PLAF_CRENTR * (1 - V_CNR) * (1 - ART1731BIS) ;

RCREATEURHANDI = CONVHAND/2 * PLAF_CRENTRH * (1 - V_CNR) * (1 - ART1731BIS) ;

regle 1004096:
application : iliad , batch  ;

RCREAT = max(min( RCREATEUR + RCREATEURHANDI , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA) , 0) ;

regle 4095:
application : iliad , batch  ;
BDIFAGRI =   min ( INTDIFAGRI , LIM_DIFAGRI * ( 1 + BOOL_0AM))
           * ( 1 - V_CNR) * (1 - ART1731BIS);
DDIFAGRI = INTDIFAGRI ;
ADIFAGRI = BDIFAGRI ;

RAGRI = arr (BDIFAGRI  * TX_DIFAGRI / 100 );
RDIFAGRI = max( min( RAGRI , IDOM11-DEC11-RCOTFOR-RREPA-RFIPDOM-RAIDE) , 0 );

regle 430 :
application : iliad , batch  ;

ITRED = min( RED , IDOM11-DEC11) ;

