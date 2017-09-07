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

regle 8200:
application : iliad , batch  ;
LIMIT12 = 18000 + max(0, arr( max(0, RI1 + TONEQUO1) * (4/100))) 
		     * (1 - positif((VARRMOND * positif(ART1731BIS) + RMOND * (1 - ART1731BIS))))
	        + max(0, 
		      arr( max(0, 
				(VARRMOND * positif(ART1731BIS) + RMOND * (1 - ART1731BIS)) 
				 + TONEQUOM1
			      )* (4/100))
		      ) 
		      * positif( (VARRMOND * positif(ART1731BIS) + RMOND * (1 - ART1731BIS)) );
LIMIT11 = 18000 + max(0, arr( max(0, RI1 + TONEQUO1) * (6/100))) 
		     * (1 - positif( (VARRMOND * positif(ART1731BIS) + RMOND * (1 - ART1731BIS))))
	        + max(0, 
		      arr( max(0, 
			        (VARRMOND * positif(ART1731BIS) + RMOND * (1 - ART1731BIS)) 
				  + TONEQUOM1
			      ) * (6/100))
		      ) 
		      * positif( (VARRMOND * positif(ART1731BIS) + RMOND * (1 - ART1731BIS)) );
LIMIT10 = 20000 + max(0, arr( max(0, RI1 + TONEQUO1) * (8/100))) 
		     * (1 - positif( (VARRMOND * positif(ART1731BIS) + RMOND * (1 - ART1731BIS))))
	        + max(0, 
		      arr( max(0,
				(VARRMOND * positif(ART1731BIS) + RMOND * (1 - ART1731BIS))
				  + TONEQUOM1
			      ) * (8/100))
		     ) 
		     * positif( (VARRMOND * positif(ART1731BIS) + RMOND * (1 - ART1731BIS)));
LIMIT9 = 25000 + max(0, arr( max(0, RI1 + TONEQUO1) * (10/100))) 
		    * (1 - positif( (VARRMOND * positif(ART1731BIS) + RMOND * (1 - ART1731BIS))))
               + max(0, 
		     arr( max(0,
			       (VARRMOND * positif(ART1731BIS) + RMOND * (1 - ART1731BIS))
				 + TONEQUOM1
			     ) * (10/100))
		    ) 
		    * positif( (VARRMOND * positif(ART1731BIS) + RMOND * (1 - ART1731BIS)));
		     
regle 8201:
application : iliad , batch  ;
NAPSANSPENA = NAPTIR - (PIR+PTAXA+PPCAP+PHAUTREV+PTAXLOY) * positif(abs(NAPTIR)) ; 
AVFISCO = V_NAPTEO * (1 - 2 * V_NEGTEO) - NAPSANSPENA ;

regle 8202:
application : iliad , batch  ;
AVFISCOPTER = AVPLAF9 + AVPLAF10 + AVPLAF11 + AVPLAF12 + AVPLAF13 ;
regle 82463:
application : iliad , batch  ;


A13RSOC = max(0, arr( RSOC4+RSOC8 - (( RSOC4+RSOC8 )*(TX65/100)))) * (1 - V_CNR);
regle 82462:
application : iliad , batch  ;


A12RSOC = max(0, arr( RSOC3+RSOC7  + RSOC24+RSOC28 - (( RSOC3+RSOC7 + RSOC24+RSOC28 )*(TX65/100)))) * (1 - V_CNR); 

regle 82461:
application : iliad , batch  ;


A11RSOC = max(0, arr( RSOC2+RSOC6 + RSOC17+RSOC20 + RSOC24+RSOC27 - ((RSOC2+RSOC6 + RSOC17+RSOC20 + RSOC24+RSOC27)*(TX65/100)))*(1-ART1731BIS)
             ) * (1 - V_CNR);

regle 8246:
application :  iliad , batch  ;


A10RSOC = max(0, arr( RSOC1+RSOC5 + RSOC12+RSOC14 + RSOC16+RSOC19 + RSOC22+RSOC26 
                      - ((RSOC1+RSOC5 + RSOC12+RSOC14 + RSOC16+RSOC19 + RSOC22+RSOC26)*(TX65/100)))*(1-ART1731BIS)
             ) * (1 - V_CNR);

regle 82473:
application : iliad , batch  ;


A13RENT1 = ( RENT18 + RENT24  
           + max (0 , RENT12+RENT36 + RENT6+RENT32
                    - ( arr((RENT12+RENT36)*(5263/10000)) + arr((RENT6+RENT32)*(625/1000))))
            ) * (1 - V_CNR);

A13RENT = max(0, A13RENT1 * (1-ART1731BIS) + min( A13RENT1731+0 , A13RENT1 ) *ART1731BIS ) * (1 - V_CNR);


regle 82472:
application : iliad , batch  ;



A12RENT1 = ( RENT17 + RENT23 + RLOC67 + RLOC74 
           + max (0 , RENT11+RENT35 + RENT5+RENT31
                    + RLOC60+RLOC88 + RLOC53+RLOC81
                    - (arr((RENT11+RENT35)*(5263/10000)) + arr((RENT5+RENT31)*(625/1000)) +
                       arr((RLOC60+RLOC88)*(5263/10000)) + arr((RLOC53+RLOC81)*(625/1000))))
            ) * (1 - V_CNR);

A12RENT = max(0, A12RENT1 * (1-ART1731BIS) + min( A12RENT1731+0 , A12RENT1 ) *ART1731BIS ) * (1 - V_CNR);

regle 82471:
application : iliad , batch  ;






A11RENT1 = ( RENT14+RENT20+RENT16+RENT22+RLOC34+RLOC63+RLOC70+RLOC66+RLOC73 
           + max (0 , RLOC29+RLOC44 + RLOC24+RLOC39 + RLOC56+RLOC84 + RLOC49+RLOC77
                    + RLOC59+RLOC87 + RLOC52+RLOC80
                    + RENT8+RENT28 + RENT2+RENT26 + RENT10+RENT34 + RENT4+RENT30

                    - (arr((RENT8+RENT28)*(5263/10000)) + arr((RENT2+RENT26)*(625/1000)) +
                       arr((RENT10+RENT34)*(5263/10000)) + arr((RENT4+RENT30)*(625/1000)) +
                       arr((RLOC29+RLOC44)*(5263/10000)) + arr((RLOC24+RLOC39)*(625/1000)) +
                       arr((RLOC56+RLOC84)*(5263/10000)) + arr((RLOC49+RLOC77)*(625/1000)) +
                       arr((RLOC59+RLOC87)*(5263/10000)) + arr((RLOC52+RLOC80)*(625/1000))))
            ) * (1 - V_CNR);

A11RENT = max(0, A11RENT1 * (1-ART1731BIS) + min( A11RENT1731+0 , A11RENT1 ) *ART1731BIS ) * (1 - V_CNR);

regle 8247:
application : iliad , batch  ;

A10RENT1 = ( RENT13+RENT19+RENT15+RENT21+RLOC13+RLOC31+RLOC33+RLOC62+RLOC69+RLOC65+RLOC72 
           + max (0 , RLOC11+RLOC17 + RLOC9+RLOC15 + RLOC26+RLOC41 + RLOC21+RLOC36 + RLOC28+RLOC43 
                    + RLOC55+RLOC83 + RLOC48+RLOC76 + RLOC58+RLOC86 + RLOC51+RLOC79 + RLOC23+RLOC38
                    + RENT7+RENT27 + RENT1+RENT25 + RENT9+RENT33 + RENT3+RENT29

                    - (arr((RLOC11+RLOC17)*(50/100)) + arr((RLOC9+RLOC15)*(60/100)) +
                       arr((RLOC26+RLOC41)*(50/100)) + arr((RLOC21+RLOC36)*(60/100)) +
                       arr((RLOC55+RLOC83)*(50/100)) + arr((RLOC48+RLOC76)*(60/100)) +
                       arr((RLOC28+RLOC43)*(5263/10000)) + arr((RLOC23+RLOC38)*(625/1000)) +
                       arr((RLOC58+RLOC86)*(5263/10000)) + arr((RLOC51+RLOC79)*(625/1000)) +
                       arr((RENT7+RENT27)*(5263/10000)) + arr((RENT1+RENT25)*(625/1000)) +
                       arr((RENT9+RENT33)*(5263/10000)) + arr((RENT3+RENT29)*(625/1000))))
            ) * (1 - V_CNR);

A10RENT = max(0, A10RENT1 * (1-ART1731BIS) + min( A10RENT1731+0 , A10RENT1 ) *ART1731BIS ) * (1 - V_CNR);

regle 82483:
application : iliad , batch  ;
BA13RNOUV = arr(
                (TX18/100) * ( max(0 , ( min(RDSNO , LIM_TITPRISE * (1 + BOOL_0AM)) - COD7CQ)
                                     - ( min(REPSNO1+REPSNO2+REPSNO3+REPSNON , LIM_SOCNOUV2 * (1+BOOL_0AM))))
                             ) 
               ) * (1 - V_CNR); 

A13RNOUV = max(0,
	       min( BA13RNOUV , RRI1_1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH) * (1-ART1731BIS)
	       + min( A13RNOUV1731+0,  min( BA13RNOUV , RRI1_1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH)) * ART1731BIS
              ) ;
regle 82482:
application : iliad , batch  ;


BA12RNOUV  = arr(
                   (    max(0 , ( min(REPSNO1+REPSNO2+REPSNO3+REPSNON , LIM_SOCNOUV2 * (1+BOOL_0AM))
		              - (REPSNO1+REPSNO2+REPSNO3)))
                      + max(0 , ( min(COD7CQ , LIM_TITPRISE * (1 + BOOL_0AM)) - RDSNO)
		              - ( min(REPSNO1+REPSNO2+REPSNO3+REPSNON , LIM_SOCNOUV2 * (1+BOOL_0AM))))
                   ) * (TX18/100)
                ) * (1 - V_CNR);

A12RNOUV = max(0,
	       min( BA12RNOUV , RRI1_1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH) * (1-ART1731BIS)
	       + min( A12RNOUV1731+0,  min( BA12RNOUV , RRI1_1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH)) * ART1731BIS
              ) ;

regle 82481:
application : iliad , batch  ;

BA11RNOUV  = arr(max(0 , (min (REPSNO1+REPSNO2+REPSNO3+REPSNON , LIM_SOCNOUV2 * (1+BOOL_0AM))
		           - (REPSNON+REPSNO2+REPSNO3)))
	    * (TX22/100)) * (1 - V_CNR);

A11RNOUV = max(0,
	       min( BA11RNOUV , RRI1_1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH) * (1-ART1731BIS)
               + min( A11RNOUV1731+0, min( BA11RNOUV , RRI1_1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH)) * ART1731BIS
              ) ;

regle 8248:
application :  iliad , batch  ;

BA10RNOUV  = arr(max(0 , (min ( REPSNO1+REPSNO2+REPSNO3+REPSNON, LIM_SOCNOUV2 * (1+BOOL_0AM)) 
                                - (REPSNO1+REPSNO3+REPSNON))) * (TX25/100)) * (1 - V_CNR);

A10RNOUV = max(0,
	       min( BA10RNOUV , RRI1_1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH) * (1-ART1731BIS)
	       + min( A10RNOUV1731+0,  min( BA10RNOUV , RRI1_1-RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH)) * ART1731BIS
              ) ;

regle 82492:
application : iliad , batch  ;
BASE7UN = (min (RDFOREST, PLAF_FOREST * (1 + BOOL_0AM))) * (1 - V_CNR) ;

PLAFRED_FORTRA = max( 0, PLAF_FOREST1 * (1 + BOOL_0AM) - ACOTFOR); 

BASE7UP = max(0, min (FORTRA, PLAFRED_FORTRA)
		    - (REPFOR+REPSINFOR + REPFOR1+REPSINFOR1 + REPFOR2+REPSINFOR2 + REPFOR3+REPSINFOR3))
									    * (1 - V_CNR) ;

BASE7UQ = (min (RDFORESTGES, PLAF_FOREST2 * (1 + BOOL_0AM)) ) * (1 - V_CNR) ; 

BA13RFOR  = arr((BASE7UN + BASE7UP + BASE7UQ) * TX18 / 100 ) ;



A13RFOR = max(0,
	      min( BA13RFOR ,IDOM11-DEC11-RCOTFOR-RREPA-RFIPDOM-RAIDE-RDIFAGRI-RFORET-RFIPC-RCINE
                             -RRESTIMO-RSOCREPR-RRPRESCOMP-RHEBE-RSURV-RINNO-RSOUFIP-RRIRENOV
                             -RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV) * (1-ART1731BIS)
              + min( A13RFOR1731+0, min( BA13RFOR ,IDOM11-DEC11-RCOTFOR-RREPA-RFIPDOM-RAIDE-RDIFAGRI-RFORET-RFIPC-RCINE
                                                   -RRESTIMO-RSOCREPR-RRPRESCOMP-RHEBE-RSURV-RINNO-RSOUFIP-RRIRENOV
                                                   -RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV)) * ART1731BIS
             );
        
regle 824910:
application : iliad , batch  ;

BASE7UXH = max(0, min (REPFOR+REPSINFOR + REPFOR1+REPSINFOR1 + REPFOR2+REPSINFOR2 + REPFOR3+REPSINFOR3 , PLAFRED_FORTRA)
			   - (REPFOR+REPSINFOR + REPFOR1+REPSINFOR1 + REPFOR2+REPSINFOR2)) * (1 - V_CNR) ;

BA12RFOR  = arr(BASE7UXH * TX18 / 100 ) ;

A12RFOR = max(0,
	       min( BA12RFOR ,IDOM11-DEC11-RCOTFOR-RREPA-RFIPDOM-RAIDE-RDIFAGRI-RFORET-RFIPC-RCINE 
                              -RRESTIMO-RSOCREPR-RRPRESCOMP-RHEBE-RSURV-RINNO-RSOUFIP-RRIRENOV
                              -RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV) * (1-ART1731BIS)
               + min(A12RFOR1731+0 , min( BA12RFOR ,IDOM11-DEC11-RCOTFOR-RREPA-RFIPDOM-RAIDE-RDIFAGRI-RFORET-RFIPC-RCINE
                                                    -RRESTIMO-RSOCREPR-RRPRESCOMP-RHEBE-RSURV-RINNO-RSOUFIP-RRIRENOV
                                                    -RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV)) * ART1731BIS
	      );
regle 82491:
application : iliad , batch  ;

BASE7UWG = max(0, min (REPFOR + REPSINFOR + REPFOR1 + REPSINFOR1 + REPFOR2 + REPSINFOR2, PLAFRED_FORTRA)
			   - (REPFOR + REPSINFOR + REPFOR1 + REPSINFOR1)) * (1 - V_CNR) ;


BA11RFOR  = arr(BASE7UWG * TX22 / 100 ) ;


A11RFOR = max(0,
	       min( BA11RFOR ,IDOM11-DEC11-RCOTFOR-RREPA-RFIPDOM-RAIDE-RDIFAGRI-RFORET-RFIPC-RCINE 
                              -RRESTIMO-RSOCREPR-RRPRESCOMP-RHEBE-RSURV-RINNO-RSOUFIP-RRIRENOV
                              -RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV) * (1-ART1731BIS)
               + min(A11RFOR1731+0 , min( BA11RFOR ,IDOM11-DEC11-RCOTFOR-RREPA-RFIPDOM-RAIDE-RDIFAGRI-RFORET-RFIPC-RCINE
                                                    -RRESTIMO-RSOCREPR-RRPRESCOMP-RHEBE-RSURV-RINNO-RSOUFIP-RRIRENOV
                                                    -RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV)) * ART1731BIS
	      );

regle 8249:
application : iliad , batch  ;
BASE7UVF = max(0, min (REPFOR + REPSINFOR + REPFOR1 + REPSINFOR1, PLAFRED_FORTRA) - (REPFOR + REPSINFOR))
            * (1 - V_CNR) ;

BA10RFOR  = arr(BASE7UVF * TX25 / 100 ) ;

A10RFOR = max(0,
	       min( BA10RFOR ,IDOM11-DEC11-RCOTFOR-RREPA-RFIPDOM-RAIDE-RDIFAGRI-RFORET-RFIPC-RCINE
			      -RRESTIMO-RSOCREPR-RRPRESCOMP-RHEBE-RSURV-RINNO-RSOUFIP-RRIRENOV
                              -RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV) * (1-ART1731BIS)
               + min(A10RFOR1731+0 , min( BA10RFOR ,IDOM11-DEC11-RCOTFOR-RREPA-RFIPDOM-RAIDE-RDIFAGRI-RFORET-RFIPC-RCINE
						  -RRESTIMO-RSOCREPR-RRPRESCOMP-RHEBE-RSURV-RINNO-RSOUFIP-RRIRENOV
                                                  -RLOGDOM-RCREAT-RCOMP-RRETU-RDONS-RDUFLOGIH-RNOUV)) * ART1731BIS
              );						  
regle 8252:
application : iliad , batch  ;
A10TOURSOC_1 = RTOURREP*positif(REPINVTOU)
             + RTOUHOTR*positif(INVLOGHOT) * (1-positif(null(2-V_REGCO)+null(4-V_REGCO)))
             + RTOUREPA*positif(INVLOGREHA);

A10TOURSOC = max(0, A10TOURSOC_1 * (1-ART1731BIS)
                  + min(A10TOURSOC1731+0 , A10TOURSOC_1) * ART1731BIS
                );

regle 8253:
application : iliad , batch  ;


A13REELA =  RCOTFOR

         + RFIPDOM + RAIDE

	 + RFIPC  

         + RINNO + RSOUFIP + RRIRENOV 

         + RDUFLOGIH

         + A13RFOR 

           + arr( RSNCF ) + arr( RSNCU )

	 + RCODJT

        + RPATNAT

           + CIDEVDUR + CIDEPENV + CIGARD + CIADCRE 

	   + CIHABPRIN + CILOYIMP ;



A13REELB = RCINE 

           + RLOG32

           + A13RSOC

           + A13RENT ;

regle 8254:
application : iliad , batch  ;


AUBAINE13A = max(0, min(V_A13REELA, V_DIFTEOREEL)) ;
AUBAINE13B = max(0, min(V_A13REELB, V_DIFTEOREEL - AUBAINE13A)) ;

regle 8255:
application : iliad , batch  ;

A12REEL = A12RFOR 

          + A12RRESTIMO

         + RLOG25 * (1-ART1731BIS) + min (RLOG251731+0 , RLOG25) * ART1731BIS
         + RLOG31 * (1-ART1731BIS)

         + RTOURREP * positif(COD7UY) + RTOUREPA * positif(COD7UZ)

          + arr( RSNCQ + RSNCC )

         + RCELRREDMG + RCELREPGV + RCELREPGJ
         + RCELJOQR + RCEL2012 + RCELFD + RCELFABC 

         + RCODIF + RCODIG + RCODID
         + RILMJV + RILMJS + RCODJU

        + RPATNAT3

        + A12RSOC   

        + A12RENT ;

regle 8256:
application : iliad , batch  ;

AUBAINE12 = max( 0, min( V_A12REEL , V_DIFTEOREEL - AUBAINE13A - AUBAINE13B ))   ;

regle 8260:
application : iliad , batch  ;
A11REEL = (RLOG16 + RLOG21 + RLOG24) * (1 - ART1731BIS)
	  + (min(RLOG161731+0,RLOG16) + min(RLOG211731+0,RLOG21) + min(RLOG241731+0, RLOG24)) * ART1731BIS
          + RLOG28 + RLOG30


        + A11RSOC

         + arr( RSNCN )

        + RCELRREDLF + RCELRREDLZ + RCELREPHG + RCELREPHA + RCELREPGW + RCELREPGL + RCELREPGK 
        + RCELCOM + RCEL + RCELJP + RCELJBGL

        + RCODIE
        + RILMIZ + RILMIA + RRESINEUV*positif(LOCRESINEUV+INVNPROF2+INVNPROF1)*(1-positif(MEUBLENP))
        + RILMJI + RILMJW

         + RTOURREP*positif(INVLOCXN) + RTOUREPA*positif(INVLOCXV)

        + RPATNAT2  

        + A11RENT

        + A11RFOR ;
regle 8261:
application : iliad , batch  ;

AUBAINE11 = max( 0, min( V_A11REEL , V_DIFTEOREEL - AUBAINE13A-AUBAINE13B-AUBAINE12 ));
regle 8262:
application : iliad , batch  ;


A10REEL = (RLOG11 + RLOG13 + RLOG15 + RLOG18 + RLOG20 + RLOG23 + RLOG26 + RLOG27 + RLOG29) * (1-ART1731BIS)
	  + (min(RLOG111731+0, RLOG11) + min(RLOG131731+0 , RLOG13) + min(RLOG151731+0, RLOG15)
	    + min(RLOG181731+0, RLOG18) + min(RLOG201731+0, RLOG20) + min(RLOG231731+0, RLOG23)) * ART1731BIS
          

         + A10RSOC  

          + arr( RSNCM ) 

         + A10RENT 

         + RCELRREDLC + RCELRREDLD + RCELRREDLS
         + RCELREPHW + RCELREPHV + RCELREPHD + RCELREPHH + RCELREPHB
         + RCELREPGX + RCELREPGS + RCELREPGP
	 + RCELHJK + RCELNQ + RCELNBGL

         + RINVRED + RREPMEU + RRESIVIEU*positif(RESIVIEU)*(1-positif(RESIVIANT)) 
	 + RRESINEUV*positif(MEUBLENP)*(1-positif(LOCRESINEUV + INVNPROF2 + INVNPROF1))
	 + RILMIH + RILMIB + RILMJC +RILMJX 

         + A10TOURSOC

	 + RPATNAT1

         + A10RFOR ;

regle 8263:
application : iliad , batch  ;
 
AUBAINE10 = max( 0, min( V_A10REEL , V_DIFTEOREEL - AUBAINE13A-AUBAINE13B-AUBAINE12-AUBAINE11 ));

regle 8280:
application : iliad , batch  ;

AUBAINE9 = max(0, V_DIFTEOREEL - AUBAINE13A - AUBAINE13B - AUBAINE12 - AUBAINE11 - AUBAINE10);
regle 8290:
application : iliad , batch  ;
AVPLAF13A = max(0, AUBAINE13A - LIMIT13A ) * positif(V_DIFTEOREEL) ;

AVPLAF13B = max(0, min(AUBAINE13A , LIMIT13A) + AUBAINE13B - LIMIT13B ) * positif(V_DIFTEOREEL) ;

AVPLAF13 = AVPLAF13A + AVPLAF13B;

AVPLAF12 = max(0, AUBAINE13A + AUBAINE13B + AUBAINE12 
                  - AVPLAF13 - LIMIT12) * positif(V_DIFTEOREEL);

AVPLAF11 = max(0, AUBAINE13A + AUBAINE13B + AUBAINE12 + AUBAINE11 
                  - AVPLAF13 - AVPLAF12 - LIMIT11) * positif(V_DIFTEOREEL);

AVPLAF10 = max(0, AUBAINE13A + AUBAINE13B + AUBAINE12 + AUBAINE11 + AUBAINE10 
                  - AVPLAF13 - AVPLAF12 - AVPLAF11 - LIMIT10) * positif(V_DIFTEOREEL);

AVPLAF9  = max(0, AUBAINE13A + AUBAINE13B + AUBAINE12 + AUBAINE11 + AUBAINE10 + AUBAINE9 
                  - AVPLAF13 - AVPLAF12 - AVPLAF11 - AVPLAF10 - LIMIT9) * positif(V_DIFTEOREEL);

regle 8321:
application : iliad , batch  ;
RFTEO = RFORDI + RFROBOR; 
regle 8331:
application : iliad , batch  ;
RFNTEO = (max( 0, RFTEO - (min(RFDORD,RFDORD1731+0) * positif(ART1731BIS) + RFDORD * (1 - ART1731BIS))
			  -(min(RFDANT,RFDANT1731+0) * positif(ART1731BIS) + RFDANT * (1 - ART1731BIS))) 
			 - (RFDHIS * (1 - positif(ART1731BIS) ))) * present(RFROBOR) + RRFI * (1-present(RFROBOR));
regle 8341:
application : iliad , batch  ;
RRFTEO = RFNTEO;
 



