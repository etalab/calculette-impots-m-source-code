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

regle 8200:
application : pro , oceans , iliad , batch  ;
LIMIT10 = LIMPLAF + max(0, arr( max(0, RI1 + TONEQUO1) * (TXPLAF/100))) * (1 - positif( RMOND ))
	             + max(0, arr( max(0, RMOND + TONEQUOM1) * (TXPLAF/100))) * positif( RMOND );
LIMIT9 = (LIM25000 + max(0, arr( max(0, RI1 + TONEQUO1) * (10/100))) * (1 - positif( RMOND ))
                     + max(0, arr( max(0, RMOND + TONEQUOM1) * (10/100))) * positif( RMOND ));
		     
regle 8201:
application : pro , oceans , iliad , batch  ;
NAPSANSPENA = NAPT - (PIRAME + PTAXA) * positif(abs(NAPT)) ; 
AVFISCO = V_NAPTEO * (1 - 2 * V_NEGTEO) - (NAPT - (PIRAME + PTAXA) * positif(abs(NAPT))) ;
regle 8202:
application : pro , oceans , iliad , batch  ;
AVFISCOPTER = AVPLAF9 + AVPLAF10 ;
regle 8246:
application : pro , oceans , iliad , batch  ;

A10RSOCQK = max(0, arr( RSOC2 + RSOC4 - ((RSOC2 + RSOC4)*(TX65/100))))
	    * (1 - V_CNR);
regle 8247:
application : pro , oceans , iliad , batch  ;

A10RENT = (RENT7 + RENT9 + max(0 , RENT4 + RENT13 + RENT2 + RENT11 - (arr((RENT4+RENT13)*(TX50/100)) + arr((RENT2+RENT11)*(TX60/100)))))
	    * (1 - V_CNR);
regle 8248:
application : pro , oceans , iliad , batch  ;

BA10RNOUV  = arr(max(0 , (min ( RDSNO +REPSNO1+REPSNO2+REPSNO3, LIM_SOCNOUV2 * (1+BOOL_0AM)) - (REPSNO1+REPSNO2+REPSNO3)))
	    * (TX25/100)) * (1 - V_CNR);

A10RNOUV = max( min( BA10RNOUV , IDOM11-DEC11-RREPA-RSYND-RRESTIMO-RPECHE-RFIPC-RAIDE-RDIFAGRI-RFORET-RTITPRISE
                              -RCINE-RSOCREPR-RRPRESCOMP-RINNO-RSOUFIP-RRIRENOV-RFOR-RHEBE-RSURV-RLOGDOM-RTOURNEUF-RTOURHOT
			      -RTOURTRA-RTOURES-RTOURREP-RTOUHOTR-RTOUREPA-RCOMP-RCREAT-RRETU-RDONS-RLOGSOC-RDOMSOC1
			      -RCELDO-RCELDOP-RCELREPDOP9-RCELMET-RCELNP-RCELREPNP9-RCELRRED09-RRESINEUV-RRESIVIEU-RMEUBLE-RREDMEUB) , 0 );

regle 8249:
application : pro , oceans , iliad , batch  ;

BASE7UN = (min (RDFOREST, PLAF_FOREST * (1 + BOOL_0AM))) * (1 - V_CNR) ;
BASE7UP = (max(0, min (FORTRA, PLAF_FOREST1 * (1 + BOOL_0AM)) - (REPFOR + REPSINFOR))) * (1 - V_CNR) ;
BASE7UQ = (min (RDFORESTGES, PLAF_FOREST2 * (1 + BOOL_0AM)) ) * (1 - V_CNR) ; 
BA10RFOR  = arr((BASE7UN + BASE7UP + BASE7UQ) * TX_FOREST / 100 ) ;

A10RFOR = max( min( BA10RFOR , IDOM11-DEC11-RREPA-RSYND-RRESTIMO-RPECHE-RFIPC-RAIDE-RDIFAGRI
			    -RFORET-RTITPRISE-RCINE-RSOCREPR-RRPRESCOMP-RINNO-RSOUFIP-RRIRENOV ) , 0 );

regle 8250:
application : pro , oceans , iliad , batch  ;
AUBAINE10 = RFIPC + RAIDE + RRESTIMO + RPECHE + RCINE
           + RTITPRISE + RINNO + RSOUFIP + RRIRENOV + A10RFOR + RPATNAT  
           + RTOURNEUF + RTOURHOT+ RTOURTRA + RTOURES
	   + RLOG6
	   + RCELDO*(1-positif(CELLIERD1))
	   + RCELMET*(1-positif(CELLIERM1))
	   + RRESINEUV*positif(LOCRESINEUV)*(1-positif(MEUBLENP))
	   + A10RNOUV
	   + A10RENT
           + A10RSOCQK
           + CIDEVDUR + CIDEDUBAIL + CIGARD + CIADCRE + CIHABPRIN
	   + CILOYIMP + CIPERT;
AUBAINE9 = max(0, V_DIFTEOREEL - AUBAINE10);
regle 8260:
application : pro , oceans , iliad , batch  ;
AVPLAF9 = (( V_DIFTEOREEL - LIMIT9) * positif( V_DIFTEOREEL - LIMIT9)
                                   * ( 1-positif( AUBAINE10 - LIMIT10 ))
          + ( LIMIT10 + AUBAINE9 - LIMIT9) * positif ( LIMIT10 + AUBAINE9 - LIMIT9)
	                                   * positif( AUBAINE10 - LIMIT10))
          * positif(V_DIFTEOREEL) ;
AVPLAF10 = ( AUBAINE10 - LIMIT10) * positif( AUBAINE10 - LIMIT10) * positif(V_DIFTEOREEL);

regle 8321:
application : pro , oceans , iliad , batch  ;
RFTEO = RFORDI + RFROBOR; 
regle 8331:
application : pro , oceans , iliad , batch  ;
RFNTEO = (max( 0, RFTEO - (RFDORD + RFDANT)) - RFDHIS) * present(RFROBOR) + RRFI * (1-present(RFROBOR));
regle 8341:
application : pro , oceans , iliad , batch  ;
RRFTEO = RFNTEO;
 



