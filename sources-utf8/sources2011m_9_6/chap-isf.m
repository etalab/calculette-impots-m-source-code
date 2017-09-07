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
regle isf 770001:
application : pro , iliad , batch  ;
DISFBASE =  ISFBASE * positif_ou_nul(ISFBASE - LIM_ISFINF) 
		    * positif(LIM_ISFSUP - ISFBASE); 

regle isf 77002:
application : pro , iliad , batch  ;
ISF1 = arr(DISFBASE * (TX_ISF/10000));
ISFDEC = (24500 - ( 7 * ISF1)) * positif( LIM_ISFDEC - 1 - ISFBASE )
                               * positif(LIM_ISFDEC - LIM_ISFINF)
	                       * positif(ISF1); 
DISFDEC = ISFDEC;

ISFBRUT = arr((ISF1 - ISFDEC) * positif( LIM_ISFDEC - 1 - ISFBASE )
	     + ISF1 * (1-positif(LIM_ISFDEC - 1 - ISFBASE))) ;

regle isf 77010:
application : pro , iliad , batch  ;
DISFPAC = ISFPAC ;
RISFPAC_1 = ISFPAC * PLAF_ISFPAC ;
RISFPAC = max( min(RISFPAC_1, ISFBRUT) , 0) ;

DISFALT = ISFALT ;
RISFALT_1 = ISFALT * PLAF_ISFALT ;
RISFALT = max( min(RISFALT_1, ISFBRUT - RISFPAC) , 0) ; 

regle isf 77020:
application : pro , iliad , batch  ;
DISFPMED = ISFPMEDI ;
DISFPMEI = ISFPMEIN ;
AISFPMED = arr(ISFPMEDI * (TX50/100)) ;
AISFPMEI = arr(ISFPMEIN * (TX50/100)) ;
RISFPMED_1 = min(45000, AISFPMED);
RISFPMEI_1 = max(0, min(45000 - RISFPMED_1, AISFPMEI));


DISFFIP = ISFFIP ;
DISFFCPI = ISFFCPI ;
AISFFIP = arr(ISFFIP * (TX50/100)) ;
AISFFCPI = arr(ISFFCPI * (TX50/100)) ;
RISFFIP_1 = min(18000, AISFFIP);
RISFFCPI_1 = max(0, min(18000 -  RISFFIP_1, AISFFCPI));

regle isf 77030:
application : pro , iliad , batch  ;
DISFDONS = ISFDONS ;
DISFDONCEE = ISFDONEURO ;
AISFDONS =arr(ISFDONS * (TX75/100)) ;
AISFDONCEE = arr(ISFDONEURO * (TX75/100)) ;
RISFDONS_1 = min(50000, AISFDONS);
RISFDONCEE_1 = max(0, min(50000 - RISFDONS_1, AISFDONCEE));

regle isf 77050:
application : pro , iliad , batch  ;
RISFDONS_2 = min(PLAF_ISFRED, RISFDONS_1);
RISFDONCEE_2 = max(0, min(PLAF_ISFRED - RISFDONS_1, RISFDONCEE_1));
RISFPMED_2 = max(0, min(PLAF_ISFRED - RISFDONS_1 - RISFDONCEE_1, RISFPMED_1));
RISFPMEI_2 = max(0, min(PLAF_ISFRED - RISFDONS_1 - RISFDONCEE_1 - RISFPMED_1, RISFPMEI_1));
RISFFIP_2 = max(0, min(PLAF_ISFRED - RISFDONS_1 - RISFDONCEE_1 - RISFPMED_1 - RISFPMEI_1, 
		     RISFFIP_1));
RISFFCPI_2 = max(0, min(PLAF_ISFRED - RISFDONS_1 - RISFDONCEE_1 - RISFPMED_1 - RISFPMEI_1 
		       - RISFDONS_1, RISFFCPI_1 ));

RISFDONS = max( min( RISFDONS_2, ISFBRUT - RISFPAC - RISFALT) , 0)
	      * ( 1 - null( CODE_2042 - 8 ));

RISFDONCEE = max( min( RISFDONCEE_2, ISFBRUT - RISFPAC - RISFALT - RISFDONS), 0)
	      * ( 1 - null( CODE_2042 - 8 ));


RISFPMED = max( min( RISFPMED_2, ISFBRUT - RISFPAC - RISFALT - RISFDONS - RISFDONCEE), 0)
              * ( 1 - null( CODE_2042 - 8 ));


RISFPMEI = max( min( RISFPMEI_2, ISFBRUT - RISFPAC - RISFALT - RISFDONS - RISFDONCEE 
					 - RISFPMED), 0)
              * ( 1 - null( CODE_2042 - 8 ));


RISFFIP = max( min( RISFFIP_2, ISFBRUT - RISFPAC - RISFALT - RISFDONS - RISFDONCEE
					- RISFPMED - RISFPMEI), 0)
              * ( 1 - null( CODE_2042 - 8 ));	


RISFFCPI = max( min( RISFFCPI_2, ISFBRUT - RISFPAC - RISFALT - RISFDONS - RISFDONCEE 
		                         - RISFPMED - RISFPMEI - RISFFIP ), 0)
	      * ( 1 - null( CODE_2042 - 8 )); 

regle isf 77066:
application : pro , iliad , batch  ;
REDISF =  RISFPAC + RISFALT + RISFDONS + RISFDONCEE + RISFPMED
         + RISFPMEI + RISFFIP + RISFFCPI ;

TXTOISF = RETXISF + COPETOISF ;

regle isf 77065:
application : pro , iliad , batch  ;
ISFTRED =  RISFPAC + RISFALT + RISFDONS + RISFDONCEE + RISFPMED
         + RISFPMEI + RISFFIP + RISFFCPI + RISFE ;

regle isf 77070:
application : pro , iliad , batch  ;
ISFNETRED = max(0, ISFBRUT - RISFPAC  - RISFALT
		           - RISFDONS - RISFDONCEE - RISFPMED - RISFPMEI - RISFFIP - RISFFCPI) ;

regle isf 77080:
application : pro , iliad , batch  ;
DISFE = ISFETRANG ;

RISFE = positif(DISFBASE)*positif(ISFETRANG)*( min(ISFNETRED, ISFETRANG));

regle isf 77090:
application : pro , iliad , batch  ;
ISF4 = max(0, ISFNETRED - RISFE) ;

regle isf 77200:
application : pro , iliad , batch  ;

COPETOISF = si (CMAJ_ISF = 7 ou CMAJ_ISF = 17 ou CMAJ_ISF = 18)
            alors (10)
	    sinon
		 ( si (CMAJ_ISF = 8)
		       alors (40)
		       finsi )
            finsi;

NMAJISF1 = max (0, MAJO1728ISF + arr(ISF4 * COPETOISF/100) * positif_ou_nul(ISF4 - SEUIL_REC_CP)
                + FLAG_TRTARDIF * MAJOISFTARDIF_D 
               + FLAG_TRTARDIF_F * MAJOISFTARDIF_D
	       - FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * MAJOISFTARDIF_R
				    + (1 - positif(FLAG_RECTIF)) * MAJOISFTARDIF_A)
	       );



TXPF1728ISF =si (V_CODPF1728ISF=07 ou V_CODPF1728ISF=17 ou V_CODPF1728ISF=18)
	     alors (10)
	     sinon
	          (si (V_CODPF1728ISF=08)
	           alors (40)
		   finsi)
	     finsi ;


MAJTXISF1 = (1 - positif(V_NBCOD1728ISF))
             * ((1 - positif(CMAJ)) * positif(NMAJISF1) * TXPF1728ISF + positif(CMAJ_ISF) * COPETOISF)
             + positif(V_NBCOD1728ISF) * (-1) ;
regle isf 77210:
application : pro , iliad , batch  ;
INTMSISF = inf( MOISAN_ISF / 10000 );
INTANISF = (( MOISAN_ISF/10000 - INTMSISF )*10000)  * present(MOISAN_ISF) ;
TXINTISF =  (max(0, (INTANISF - (V_ANREV+1) )* 12 + INTMSISF - 6 ) * TXMOISRETARD2)
	    * present(MOISAN_ISF);
PTOISF = arr(ISF4 * COPETOISF / 100) + arr(ISF4 * TXINTISF / 100) ;
RETISF = (RETISF2 + arr(ISF4 * TXINTISF/100))* positif_ou_nul(ISF4 - SEUIL_REC_CP) ;
RETXISF = positif(CMAJ_ISF) * TXINTISF
               + (TXINRISF * (1-positif(TXINRISF_A)) + (-1) * positif(TXINRISF_A) * positif(TXINRISF) 
		   * positif(positif(TXINRISF - TXINRISF_A)+positif(TXINRISF_A-TXINRISF)))
               + (TXINRISF * positif(TXINRISF_A) * null(TXINRISF - TXINRISF_A))
               ;


NATMAJISF = positif(RETISF) * positif(NMAJISF1)
	    + 2 * positif(RETISF) * (1-positif(NMAJISF1)); 

regle isf 77215:
application : pro , iliad , batch  ;



PISF = ( INCISF_NET 
	 + NMAJISF1 
         + arr(ISF4 * TXINTISF / 100) * (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) ;

regle isf 77219 :
application : pro , iliad , batch ;

NAPISFTOT = ISF4 + CEF2 + PISF ;

regle isf 77220:
application : pro , iliad , batch ;

ISFNET = NAPISFTOT ; 





regle isf 77221:
application : pro , iliad , batch ;
ISFNAP = ISFCUM - V_ANTISF ;

regle isf 77230:
application : iliad, batch ;

ILI_SYNT_ISF = positif_ou_nul(ISF4BIS - SEUIL_REC_CP) * ISF4BIS
	      + (1 - positif_ou_nul(ISF4BIS - SEUIL_REC_CP)) * 0;


regle isf 77250:
application : pro , iliad, batch ;
TR2_ISF = arr( max(0, min( DISFBASE , LIM_TR2_ISF ) - (LIM_TR1_ISF)) * (TX_TR2_ISF/10000)) ;
TR3_ISF = arr( max(0, min( DISFBASE , LIM_TR3_ISF ) - (LIM_TR2_ISF)) * (TX_TR3_ISF/10000)) ;
TR4_ISF = arr( max(0, min( DISFBASE , LIM_ISFSUP  ) - (LIM_TR3_ISF)) * (TX_TR4_ISF/100)) ;

CEF1 = TR2_ISF + TR3_ISF + TR4_ISF ;

regle isf 77260:
application : pro , iliad, batch ;
CEF2 = max( 0, CEF1 - ISFBRUT ) ;

regle isf 77270:
application : pro , iliad, batch ;
ISF4BIS= max( 0, CEF2 + ISF4 ) ; 

