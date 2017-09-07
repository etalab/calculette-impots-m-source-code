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

regle 8200:
application : iliad , batch  ;
LIMIT12 = 18000 + max(0, arr( max(0, RI1 + TONEQUO1) * (4/100))) * (1 - positif( RMOND ))
	             + max(0, arr( max(0, RMOND + TONEQUOM1) * (4/100))) * positif( RMOND );
LIMIT11 = 18000 + max(0, arr( max(0, RI1 + TONEQUO1) * (6/100))) * (1 - positif( RMOND ))
	             + max(0, arr( max(0, RMOND + TONEQUOM1) * (6/100))) * positif( RMOND );
LIMIT10 = 20000 + max(0, arr( max(0, RI1 + TONEQUO1) * (8/100))) * (1 - positif( RMOND ))
	             + max(0, arr( max(0, RMOND + TONEQUOM1) * (8/100))) * positif( RMOND );
LIMIT9 = 25000 + max(0, arr( max(0, RI1 + TONEQUO1) * (10/100))) * (1 - positif( RMOND ))
                     + max(0, arr( max(0, RMOND + TONEQUOM1) * (10/100))) * positif( RMOND );
		     
regle 8201:
application : iliad , batch  ;
NAPSANSPENA = NAPTIR - (PIR+PTAXA+PPCAP+PHAUTREV+PTAXLOY) * positif(abs(NAPTIR)) ; 
AVFISCO = V_NAPTEO * (1 - 2 * V_NEGTEO) - NAPSANSPENA ;
regle 8202:
application : iliad , batch  ;
AVFISCOPTER = AVPLAF9 + AVPLAF10 + AVPLAF11 + AVPLAF12;
regle 82462:
application : iliad , batch  ;

A12RSOC = max(0, arr( RSOC4+RSOC8 - (( RSOC4+RSOC8 )*(TX65/100)))) 
	    * (1 - V_CNR);
regle 82461:
application : iliad , batch  ;

A11RSOC = max(0, arr( RSOC3+RSOC7 + RSOC14+RSOC20
		      - ((RSOC3+RSOC7 + RSOC14+RSOC20)*(TX65/100))))
	    * (1 - V_CNR);
regle 8246:
application :  iliad , batch  ;

A10RSOC = max(0, arr( RSOC2+RSOC6 + RSOC11+RSOC17 + RSOC13+RSOC19 
		      - (( RSOC2+RSOC6 + RSOC11+RSOC17 + RSOC13+RSOC19 )*(TX65/100))))
	    * (1 - V_CNR);
regle 82472:
application : iliad , batch  ;

A12RENT = (RENT21 + RENT28 + max(0 , RENT14+RENT42 + RENT7+RENT35 
                                     - (arr((RENT14+RENT42)*(5263/10000)) + arr((RENT7+RENT35)*(625/1000)))))
	    * (1 - V_CNR);
regle 82471:
application : iliad , batch  ;

A11RENT = ( RENT17 + RENT24 + RENT20 + RENT27 + RLOC34

       + max(0, RENT10+RENT38 + RENT3+RENT31 + RENT13+RENT41 + RENT6+RENT34 + RLOC29+RLOC44 + RLOC24+RLOC39
                
            - (arr((RENT10+RENT38)*(5263/10000))+arr((RENT3+RENT31)*(625/1000))+arr((RENT13+RENT41)*(5263/10000))
	       +arr((RENT6+RENT34)*(625/1000))+arr((RLOC29+RLOC44)*(5263/10000))+arr((RLOC24+RLOC39)*(625/1000)))))
           * (1 - V_CNR);

regle 8247:
application : iliad , batch  ;

A10RENT = ( RENT16 + RENT23 + RLOC13 + RLOC31 + RENT19 + RENT26 + RLOC33
             + arr(( RENT9+RENT37 + RLOC12+RLOC17 + RLOC26+RLOC41 )*(TX50/100))
             + arr(( RENT2+RENT30 + RLOC11+RLOC16 + RLOC21+RLOC36 )*(TX40/100))
             + arr(( RENT12+RENT40 + RLOC28+RLOC43 )*(4737/10000))
             + arr(( RENT5+RENT33 + RLOC23+RLOC38 )*(375/1000)))
                                                                  * (1 - V_CNR);

regle 82482:
application : iliad , batch  ;

BA12RNOUV  = arr((  max(0 , ( BSN1 - (REPSNO1+REPSNO2+REPSNO3+REPSNON)))
                 + RSN4  
                       )
	    * (TX18/100)) * (1 - V_CNR);

A12RNOUV = max( min( BA12RNOUV , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR 
                                 -RTOUREPA-RCOMP-RCREAT-RRETU-RDONS) , 0) ;

regle 82481:
application : iliad , batch  ;

BA11RNOUV  = arr(max(0 , (min (REPSNO1+REPSNO2+REPSNO3+REPSNON , LIM_SOCNOUV2 * (1+BOOL_0AM))
		        - (REPSNO1+REPSNO2+REPSNO3)))
	    * (TX22/100)) * (1 - V_CNR);

A11RNOUV = max( min( BA11RNOUV , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR 
                                 -RTOUREPA-RCOMP-RCREAT-RRETU-RDONS) , 0) ;

regle 8248:
application :  iliad , batch  ;

BA10RNOUV  = arr(max(0 , (min ( REPSNO1+REPSNO2+REPSNO3, LIM_SOCNOUV2 * (1+BOOL_0AM))
		        - (REPSNO2+REPSNO3)))
	    * (TX25/100)) * (1 - V_CNR);

A10RNOUV = max( min( BA10RNOUV , RRI1-RLOGDOM-RTOURNEUF-RTOURTRA-RTOURES-RTOURREP-RTOUHOTR
				 -RTOUREPA-RCOMP-RCREAT-RRETU-RDONS) , 0) ;

regle 82492:
application : iliad , batch  ;
BASE7UN = (min (RDFOREST, PLAF_FOREST * (1 + BOOL_0AM))) * (1 - V_CNR) ;

PLAFRED_FORTRA = max( 0, PLAF_FOREST1 * (1 + BOOL_0AM) - ACOTFOR); 

BASE7UP = max(0, min (FORTRA, PLAFRED_FORTRA)
		    - (REPFOR + REPSINFOR + REPFOR1 + REPSINFOR1 + REPFOR2 + REPSINFOR2))
									    * (1 - V_CNR) ;

BASE7UQ = (min (RDFORESTGES, PLAF_FOREST2 * (1 + BOOL_0AM)) ) * (1 - V_CNR) ; 

BA12RFOR  = arr((BASE7UN + BASE7UP + BASE7UQ) * TX18 / 100 ) ;


A12RFOR = max( min( BA12RFOR ,IDOM11-DEC11-RCOTFOR-RREPA-RFIPDOM-RAIDE-RDIFAGRI-RFORET-RFIPC-RCINE 
                              -RRESTIMO-RSOCREPR-RRPRESCOMP-RHEBE-RSURV-RINNO-RSOUFIP-RRIRENOV ) , 0 );
regle 82491:
application : iliad , batch  ;

BASE7UWG = max(0, min (REPFOR + REPSINFOR + REPFOR1 + REPSINFOR1 + REPFOR2 + REPSINFOR2, PLAFRED_FORTRA)
			   - (REPFOR + REPSINFOR + REPFOR1 + REPSINFOR1)) * (1 - V_CNR) ;


BA11RFOR  = arr(BASE7UWG * TX22 / 100 ) ;

A11RFOR = max( min( BA11RFOR ,IDOM11-DEC11-RCOTFOR-RREPA-RFIPDOM-RAIDE-RDIFAGRI-RFORET-RFIPC-RCINE 
                              -RRESTIMO-RSOCREPR-RRPRESCOMP-RHEBE-RSURV-RINNO-RSOUFIP-RRIRENOV ) , 0 );
regle 8249:
application : iliad , batch  ;

BASE7UVF = max(0, min (REPFOR + REPSINFOR + REPFOR1 + REPSINFOR1, PLAFRED_FORTRA) - (REPFOR + REPSINFOR))
            * (1 - V_CNR) ;


BA10RFOR  = arr(BASE7UVF * TX25 / 100 ) ;

A10RFOR = max( min( BA10RFOR ,IDOM11-DEC11-RCOTFOR-RREPA-RFIPDOM-RAIDE-RDIFAGRI-RFORET-RFIPC-RCINE 
                              -RRESTIMO-RSOCREPR-RRPRESCOMP-RHEBE-RSURV-RINNO-RSOUFIP-RRIRENOV ) , 0 );
regle 8252:
application : iliad , batch  ;
          
A10TOURSOC = RTOURREP*positif(REPINVTOU) 
            +max(0,(RTOUHOTR-arr((INVLOCHOTR1 + INVLOCHOTR)* TX_REDIL25 / 100)* (1-positif(null(2-V_REGCO)+null(4-V_REGCO)))))
            +RTOUREPA*positif(INVLOGREHA);

regle 8255:
application : iliad , batch  ;

A12REEL =  RCOTFOR

         + RFIPDOM + RAIDE

	 + RFIPC +  RCINE 

         + RRESTIMO

         + RINNO + RSOUFIP + RRIRENOV 

         + A12RFOR

	 + RLOG25

         + RTOURNEUF + RTOURTRA + RTOURES

         + A12RNOUV

         + RCELJOQR + RCEL2012 

	 + RLOCIDEFG *(1-positif( LOCMEUBIE ))*positif(LOCMEUBID + LOCMEUBIF + LOCMEUBIG)

        + RPATNAT

        + A12RSOC   

        + A12RENT

           + CIDEVDUR + CIDEPENV + CIGARD + CIADCRE 

	   + CIHABPRIN + CILOYIMP ;

regle 8256:
application : iliad , batch  ;


AUBAINE12 = V_A12REEL;

regle 8260:
application : iliad , batch  ;

A11REEL = RLOG16 + RLOG21 + RLOG24

        + A11RSOC

        + A11RNOUV

        + RCELRREDLF + RCELREPHG + RCELREPHA + RCELCOM + RCEL + RCELJP + RCELJBGL

        + RILMIZ + RILMIA + RRESINEUV*positif(LOCRESINEUV+INVNPROF2+INVNPROF1)*(1-positif(MEUBLENP))
	+ RLOCIDEFG * positif( LOCMEUBIE )*(1-positif(LOCMEUBID + LOCMEUBIF + LOCMEUBIG))

         + RTOURREP*positif(INVLOCXN) + RTOUREPA*positif(INVLOCXV)

        + RPATNAT2  

        + A11RENT

        + A11RFOR ;
regle 8261:
application : iliad , batch  ;

AUBAINE11 = V_A11REEL;

regle 8262:
application : iliad , batch  ;


A10REEL =  RLOG11 + RLOG13 + RLOG15 + RLOG18 + RLOG20 + RLOG23

         + A10RSOC  

         + A10RNOUV 

         + A10RENT 

         + RCELRREDLC + RCELRREDLD + RCELREPHW + RCELREPHV + RCELREPHD + RCELREPHH + RCELREPHB
	 + RCELHJK + RCELNQ + RCELNBGL

         + RINVRED + RREPMEU + RRESIVIEU*positif(RESIVIEU)*(1-positif(RESIVIANT)) 
	 + RRESINEUV*positif(MEUBLENP)*(1-positif(LOCRESINEUV + INVNPROF2 + INVNPROF1))
	 + RILMIH + RILMIB 

         + A10TOURSOC

	 + RPATNAT1

         + A10RFOR ;

regle 8263:
application : iliad , batch  ;

AUBAINE10 = V_A10REEL;

regle 8280:
application : iliad , batch  ;

AUBAINE9 = max(0, V_DIFTEOREEL - AUBAINE12 - AUBAINE11 - AUBAINE10);
regle 8290:
application : iliad , batch  ;
AVPLAF12 = ( AUBAINE12 - LIMIT12) * positif( AUBAINE12 - LIMIT12) * positif(V_DIFTEOREEL);

AVPLAF11 = max(0, AUBAINE12 + AUBAINE11 - AVPLAF12 - LIMIT11) * positif(V_DIFTEOREEL);

AVPLAF10 = max(0, AUBAINE12 + AUBAINE11 + AUBAINE10 - AVPLAF12 - AVPLAF11 - LIMIT10) * positif(V_DIFTEOREEL);

AVPLAF9  = max(0, AUBAINE12 + AUBAINE11 + AUBAINE10 + AUBAINE9 - AVPLAF12 - AVPLAF11 - AVPLAF10 - LIMIT9)
	   * positif(V_DIFTEOREEL);

regle 8321:
application : iliad , batch  ;
RFTEO = RFORDI + RFROBOR; 
regle 8331:
application : iliad , batch  ;
RFNTEO = (max( 0, RFTEO - (RFDORD + RFDANT)) - RFDHIS) * present(RFROBOR) + RRFI * (1-present(RFROBOR));
regle 8341:
application : iliad , batch  ;
RRFTEO = RFNTEO;
 



