#*************************************************************************************************************************
#
#Copyright or © or Copr.[DGFIP][2017]
#
#Ce logiciel a été initialement développé par la Direction Générale des 
#Finances Publiques pour permettre le calcul de l'impôt sur le revenu 2012 
#au titre des revenus percus en 2011. La présente version a permis la 
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

regle 8200:
application : pro , oceans , iliad , batch  ;
LIMIT11 = 18000 + max(0, arr( max(0, RI1 + TONEQUO1) * (6/100))) * (1 - positif( RMOND ))
	             + max(0, arr( max(0, RMOND + TONEQUOM1) * (6/100))) * positif( RMOND );
LIMIT10 = 20000 + max(0, arr( max(0, RI1 + TONEQUO1) * (8/100))) * (1 - positif( RMOND ))
	             + max(0, arr( max(0, RMOND + TONEQUOM1) * (8/100))) * positif( RMOND );
LIMIT9 = 25000 + max(0, arr( max(0, RI1 + TONEQUO1) * (10/100))) * (1 - positif( RMOND ))
                     + max(0, arr( max(0, RMOND + TONEQUOM1) * (10/100))) * positif( RMOND );
		     
regle 8201:
application : pro , oceans , iliad , batch  ;
NAPSANSPENA = NAPT - (PIR+PTAXA+PPCAP+PHAUTREV) * positif(abs(NAPT)) ; 
AVFISCO = V_NAPTEO * (1 - 2 * V_NEGTEO) - NAPSANSPENA ;
regle 8202:
application : pro , oceans , iliad , batch  ;
AVFISCOPTER = AVPLAF9 + AVPLAF10 + AVPLAF11;
regle 824611:
application : pro , oceans , iliad , batch  ;

A11RSOC = max(0, arr( RSOC3 + RSOC6 - ((RSOC3 + RSOC6)*(TX65/100))))
	    * (1 - V_CNR);
regle 8246:
application : pro , oceans , iliad , batch  ;

A10RSOC = max(0, arr( RSOC2 + RSOC5 + RSOC9 + RSOC12  - ((RSOC2 + RSOC5 + RSOC9 + RSOC12)*(TX65/100))))
	    * (1 - V_CNR);
regle 824711:
application : pro , oceans , iliad , batch  ;

A11RENT = (RENT11 + max(0 , RENT17 + RENT27 + RENT14 + RENT24 - (arr((RENT17+RENT27)*(5263/10000)) + arr((RENT14+RENT24)*(625/1000)))))
	    * (1 - V_CNR);
regle 8247:
application : pro , oceans , iliad , batch  ;

A10RENT = (RENT8+RENT10+RLOC11 + max(0, RENT6+RENT21+RENT4+RENT19 + RLOC10+RLOC17+RLOC9+RLOC16 + RENT16+RENT26+RENT13+RENT23
					- (  arr((RENT6+RENT21)*(TX50/100)) + arr((RENT4+RENT19)*(TX60/100))
					   + arr((RLOC10+RLOC17)*(TX50/100))+ arr((RLOC9+RLOC16)*(TX60/100))
					   + arr((RENT16+RENT26)*(5263/10000)) + arr((RENT13+RENT23)*(625/1000)))))
	    * (1 - V_CNR);

regle 824811:
application : pro , oceans , iliad , batch  ;

BA11RNOUV  = arr(max(0 , (min (RDSNO+REPSNO1+REPSNO2+REPSNO3+REPSNON , LIM_SOCNOUV2 * (1+BOOL_0AM))
		        - (REPSNO1+REPSNO2+REPSNO3+REPSNON)))
	    * (TX22/100)) * (1 - V_CNR);

A11RNOUV = max( min( BA11RNOUV , IDOM11-DEC11-RREPA-RSYND-RRESTIMO-RPECHE-RFIPC-RAIDE-RDIFAGRI-RFORET-RTITPRISE
                              -RCINE-RSOCREPR-RRPRESCOMP-RINNO-RSOUFIP-RRIRENOV-RFOR-RHEBE-RSURV-RLOGDOM-RTOURNEUF
			      -RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC-RDOMSOC1
			      -RCELHNO-RCELHM-RCELREPHS-RCELHJK-RCELHL-RCELREPHR-RCELRREDLA-RRESINEUV-RRESIVIEU-RMEUBLE-RREDMEUB) , 0 );

regle 8248:
application : pro , oceans , iliad , batch  ;

BA10RNOUV  = arr(max(0 , (min ( REPSNO1+REPSNO2+REPSNO3+REPSNON , LIM_SOCNOUV2 * (1+BOOL_0AM))
		        - (REPSNO1+REPSNO2+REPSNO3)))
	    * (TX25/100)) * (1 - V_CNR);

A10RNOUV = max( min( BA10RNOUV , IDOM11-DEC11-RREPA-RSYND-RRESTIMO-RPECHE-RFIPC-RAIDE-RDIFAGRI-RFORET-RTITPRISE
                              -RCINE-RSOCREPR-RRPRESCOMP-RINNO-RSOUFIP-RRIRENOV-RFOR-RHEBE-RSURV-RLOGDOM-RTOURNEUF
			      -RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC-RDOMSOC1
			      -RCELHNO-RCELHM-RCELREPHS-RCELHJK-RCELHL-RCELREPHR-RCELRREDLA-RRESINEUV-RRESIVIEU-RMEUBLE-RREDMEUB) , 0 );

regle 824911:
application : pro , oceans , iliad , batch  ;
BASE7UN = (min (RDFOREST, PLAF_FOREST * (1 + BOOL_0AM))) * (1 - V_CNR) ;

PLAFRED_FORTRA = max( 0, PLAF_FOREST1 * (1 + BOOL_0AM) - ACOTFOR); 

BASE7UP = (max(0, min (FORTRA, PLAFRED_FORTRA))
		    - (REPFOR + REPSINFOR + REPFOR1 + REPSINFOR1)) * (1 - V_CNR) ;
BASE7UQ = (min (RDFORESTGES, PLAF_FOREST2 * (1 + BOOL_0AM)) ) * (1 - V_CNR) ; 
BA11RFOR  = arr((BASE7UN + BASE7UP + BASE7UQ) * TX_FOREST2 / 100 ) ;

A11RFOR = max( min( BA11RFOR ,IDOM11-DEC11-RCOTFOR-RREPA-RSYND-RFIPDOM-RAIDE-RDIFAGRI-RFORET-RFIPC-RCINE 
                              -RRESTIMO-RPECHE-RSOCREPR-RRPRESCOMP-RHEBE-RSURV-RTITPRISE-RINNO-RSOUFIP-RRIRENOV ) , 0 );
regle 8249:
application : pro , oceans , iliad , batch  ;

BASE7UVF = (max(0, min (REPFOR + REPSINFOR + REPFOR1 + REPSINFOR1, PLAFRED_FORTRA)) - (REPFOR + REPSINFOR)) * (1 - V_CNR) ;

BA10RFOR  = arr((BASE7UVF) * TX_FOREST / 100 ) ;

A10RFOR = max( min( BA10RFOR ,IDOM11-DEC11-RCOTFOR-RREPA-RSYND-RFIPDOM-RAIDE-RDIFAGRI-RFORET-RFIPC-RCINE 
                              -RRESTIMO-RPECHE-RSOCREPR-RRPRESCOMP-RHEBE-RSURV-RTITPRISE-RINNO-RSOUFIP-RRIRENOV ) , 0 );
regle 8250:
application : pro , oceans , iliad , batch  ;
A11TOURSOC = RTOURNEUF 
            +RTOURTRA
            +RTOURES;

regle 8251:
application : pro , oceans , iliad , batch  ;
A10TOURSOC = RTOURREP*positif(REPINVTOU) 
            +max(0,(RTOUHOTR-arr((INVLOCHOTR1 + INVLOCHOTR)* TX_REDIL25 / 100)* (1-positif(null(2-V_REGCO)+null(4-V_REGCO)))))
            +RTOUREPA*positif(INVLOGREHA);

regle 8260:
application : pro , oceans , iliad , batch  ;
A11REEL = RFIPC + RAIDE + RRESTIMO + RPECHE + RCINE
           + RTITPRISE + RINNO + RSOUFIP + RRIRENOV + RPATNAT  
           + RTOURNEUF + RTOURTRA + RTOURES
	   + RLOG13
           + RCEL + RCELCOM
	   + RRESINEUV*positif(LOCRESINEUV+INVNPROF2+INVNPROF1)*(1-positif(MEUBLENP))
	   + A11RNOUV
	   + A11RFOR
	   + RCOTFOR
	   + A11RENT
           + A11RSOC
           + CIDEVDUR + CIDEDUBAIL + CIGARD + CIADCRE + CIHABPRIN
	   + CILOYIMP ;

regle 8261:
application : pro , oceans , iliad , batch  ;

AUBAINE11 = V_A11REEL;

regle 8262:
application : pro , oceans , iliad , batch  ;

A10REEL =  RLOG8 + RLOG10 + RLOG12 
           + RCELRREDLB+RCELRREDLC+RCELREPHW+RCELREPHV+RCELHJK+RCELNQ+RCELNBGL
	   + RINVRED + RREPMEU
	   + RRESIVIEU*positif(RESIVIEU)*(1-positif(RESIVIANT))
	   + RRESINEUV*positif(MEUBLENP)*(1-positif(LOCRESINEUV + INVNPROF2 + INVNPROF1))
	   + A10RNOUV
	   + RPATNAT1
	   + A10RENT
	   + A10TOURSOC
	   + A10RFOR
           + A10RSOC;

regle 8263:
application : pro , oceans , iliad , batch  ;

AUBAINE10 = V_A10REEL;

regle 8280:
application : pro , oceans , iliad , batch  ;

AUBAINE9 = max(0, V_DIFTEOREEL - AUBAINE11 - AUBAINE10);
regle 8290:
application : pro , oceans , iliad , batch  ;
AVPLAF11 = ( AUBAINE11 - LIMIT11) * positif( AUBAINE11 - LIMIT11) * positif(V_DIFTEOREEL);

AVPLAF10 = max(0, AUBAINE11 + AUBAINE10 - AVPLAF11 - LIMIT10) * positif(V_DIFTEOREEL);

AVPLAF9  = max(0, AUBAINE11 + AUBAINE10 + AUBAINE9 - AVPLAF11 - AVPLAF10 - LIMIT9) * positif(V_DIFTEOREEL);


regle 8321:
application : pro , oceans , iliad , batch  ;
RFTEO = RFORDI + RFROBOR; 
regle 8331:
application : pro , oceans , iliad , batch  ;
RFNTEO = (max( 0, RFTEO - (RFDORD + RFDANT)) - RFDHIS) * present(RFROBOR) + RRFI * (1-present(RFROBOR));
regle 8341:
application : pro , oceans , iliad , batch  ;
RRFTEO = RFNTEO;
 



