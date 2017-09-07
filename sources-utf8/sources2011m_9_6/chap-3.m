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
                                   * (1 - positif(RE168 + TAX1649)))
                  + min(TAXASSUR+0 , max(0,INE-IRB+AVFISCOPTER)) 
                  + min(IPCAPTAXT+0 , max(0,INE-IRB+AVFISCOPTER - min(TAXASSUR+0,max(0,INE-IRB+AVFISCOPTER))))
                  + min(IHAUTREVT+0 , max(0,INE-IRB+AVFISCOPTER - min(IPCAPTAXT+0 , max(0,INE-IRB+AVFISCOPTER - min(TAXASSUR+0,max(0,INE-IRB+AVFISCOPTER))))
			   				        - min(TAXASSUR+0 , max(0,INE-IRB+AVFISCOPTER))))
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
	     + AUTOVERSLIB + CITEC
	      )

        sinon ( EPAV + CRICH
             + CICA +  CIGE  + IPELUS + CREFAM + CREAPP + PPETOT - PPERSA
	     + DIREPARGNE + CIDEVDUR + CIDEDUBAIL + CIPRETUD + CILOYIMP + CIGARD
	     + CREAGRIBIO + CREPROSP + CREFORMCHENT + CREARTS + CICONGAGRI 
	     + CRERESTAU + CIHABPRIN + CIADCRE + CIDEBITTABAC + CREINTERESSE 
	     + AUTOVERSLIB + CITEC
	      )
	     
        finsi)
       finsi;
IRE2 = IRE + (BCIGA * (1 - positif(RE168+TAX1649))); 
regle 3022:
application : pro , oceans , iliad , batch  ;

CRICH =  IPRECH * (1 - positif(RE168+TAX1649));
regle 30221:
application : pro , oceans , iliad , batch  ;
CIRCMAVFT = max(0,min(IRB + TAXASSUR + IPCAPTAXT +IHAUTREVT - AVFISCOPTER , RCMAVFT * (1 - null(2 - V_REGCO))));
regle 30222:
application : pro , oceans , iliad , batch  ;
CIDIREPARGNE = DIREPARGNE * (1 - positif(RE168 + TAX1649)) * (1 - null(2 - V_REGCO));
regle 30226:
application : pro , batch, oceans, iliad;
CICA =  arr(BAILOC98 * TX_BAIL / 100) * (1 - positif(RE168 + TAX1649)) ;
regle 3023:
application : pro , oceans , iliad , batch  ;
CRCFA = (arr(IPQ1 * REGCI / (RB01 + TONEQUO + CHTOT + RDCSG + ABMAR + ABVIE)) * (1 - positif(RE168+TAX1649)));
regle 30231:
application : pro , oceans , iliad , batch  ;
IRETS = max(0,min(IRB+TAXASSUR+IPCAPTAXT+IHAUTREVT -AVFISCOPTER-CIRCMAVFT , (IPSOUR * (1 - positif(RE168+TAX1649))))) ;
regle 3023101:
application : pro , oceans , iliad , batch  ;
CRDIE = max(0,min(IRB-REI-AVFISCOPTER-CIRCMAVFT-IRETS,(min(IAD11,CRCFA) * (1 - positif(RE168+TAX1649)))));
CRDIE2 = -CRDIE+0;
regle 3023102:
application : pro , oceans , iliad , batch  ;
BCIAQCUL = arr(CIAQCUL * TX_CIAQCUL / 100);
CICULTUR = max(0,min(IRB+TAXASSUR+IPCAPTAXT+IHAUTREVT -AVFISCOPTER-CIRCMAVFT-REI-IRETS-CRDIE-ICREREVET,min(IAD11+ITP+TAXASSUR+IPCAPTAXT+IHAUTREVT ,BCIAQCUL)));
regle 3023103:
application : pro , oceans , iliad , batch  ;
BCIGA = CRIGA;
CIGPA = max(0,min(IRB+TAXASSUR+IPCAPTAXT+IHAUTREVT -AVFISCOPTER-CIRCMAVFT-IRETS-CRDIE-ICREREVET-CICULTUR,BCIGA));
regle 3023104:
application : pro , oceans , iliad , batch  ;
BCIDONENTR = RDMECENAT * (1-V_CNR) ;
CIDONENTR = max(0,min(IRB+TAXASSUR+IPCAPTAXT+IHAUTREVT -AVFISCOPTER-CIRCMAVFT-REI-IRETS-CRDIE-ICREREVET-CICULTUR-CIGPA,BCIDONENTR));
regle 3023105:
application : pro , oceans , iliad , batch  ;
CICORSE = max(0,min(IRB+TAXASSUR+IPCAPTAXT+IHAUTREVT -AVFISCOPTER-CIRCMAVFT-IPPRICORSE-IRETS-CRDIE-ICREREVET-CICULTUR-CIGPA-CIDONENTR,CIINVCORSE+IPREPCORSE));
TOTCORSE = CIINVCORSE + IPREPCORSE ;
REPCORSE = abs(CIINVCORSE+IPREPCORSE-CICORSE) ;
regle 3023106:
application : pro , oceans , iliad , batch  ;
CIRECH = max(0,min(IRB+TAXASSUR+IPCAPTAXT+IHAUTREVT -AVFISCOPTER-CIRCMAVFT-IPPRICORSE-IRETS-CRDIE-ICREREVET-CICULTUR-CIGPA-CIDONENTR-CIINVCORSE-IPREPCORSE,IPCHER));
REPRECH = abs(IPCHER - CIRECH) ;
IRECR = abs(min(0 ,IRB+TAXASSUR+IPCAPTAXT+IHAUTREVT -AVFISCOPTER-CIRCMAVFT-IRETS-CRDIE-ICREREVET-CICULTUR-CIGPA-CIDONENTR-CICORSE));
regle 3023107:
application : pro , oceans , iliad , batch  ;
CICONGAGRI = CRECONGAGRI * (1-V_CNR) ;
regle 3023108:
application : pro , oceans , iliad , batch  ;
IRECT = max(0,min(IRB,IPSOUR + min(IAD11 , CRCFA) + CICORSE + CICULTUR + CIDONENTR + ICREREVET + CIRCMAVFT));

IAVF = IRE - EPAV + CICORSE + CICULTUR + CIGPA + CIRCMAVFT ;


DIAVF2 = (BCIGA + IPRECH + IPCHER + IPELUS + RCMAVFT + DIREPARGNE) * (1 - positif(RE168+TAX1649)) + CIRCMAVFT * positif(RE168+TAX1649);


IAVF2 = (CIDIREPARGNE + IPRECH + CIRECH + IPELUS + CIRCMAVFT + CIGPA + 0) * (1-positif(RE168+TAX1649))
+ CIRCMAVFT * positif(RE168+TAX1649);

IAVFGP = IAVF2 + CREFAM + CREAPP;
regle 3023109:
application : pro , oceans , iliad , batch  ;
I2DH = EPAV;
regle 30231011:
application : pro , oceans , iliad , batch  ;
BTANTGECUM = (V_BTGECUM * (1 - present(DEPMOBIL)) + DEPMOBIL);
P2GE = max( (   PLAF_GE2 * (1 + BOOL_0AM)

             + PLAF_GE2_PACQAR * (V_0CH + V_0DP)

             + PLAF_GE2_PAC * (V_0CR + V_0CF + V_0DJ + V_0DN)  

            ) - BTANTGECUM

             , 0
          ) ;
BGEDECL = RDTECH + RDEQPAHA + RDGEQ ;
BGERET = min(RDTECH + RDEQPAHA + RDGEQ , P2GE) * (1 - V_CNR);
BGTECH = min(RDTECH , P2GE) * (1 - V_CNR) ;
BGEPAHA = min(RDEQPAHA , max(P2GE - BGTECH,0)) * (1 - V_CNR) ;
BGEAUTRE = min(RDGEQ , max(P2GE - BGTECH - BGEPAHA,0)) * (1 - V_CNR) ;
TOTBGE = BGTECH + BGEPAHA + BGEAUTRE ;
RGTECH = (BGTECH * TX_RGTECH / 100 ) * (1 - V_CNR) ;
RGEPAHA =  (BGEPAHA * TX_RGEPAHA / 100 ) * (1 - V_CNR) ;
RGEAUTRE = (BGEAUTRE * TX_RGEAUTRE / 100 ) * (1 - V_CNR) ;
CIGE = arr (RGTECH + RGEPAHA + RGEAUTRE) * (1 - positif(RE168 + TAX1649)) * (1 - V_CNR) ;
GECUM = BGTECH + BGEPAHA + BGEAUTRE + BTANTGECUM ;
DAIDC = CREAIDE ;
AAIDC = BADCRE * (1-V_CNR) ;
CIADCRE = arr (BADCRE * TX_AIDOMI /100) * (1 - positif(RE168 + TAX1649)) * (1 - V_CNR) ;
regle 30231012:
application : pro , oceans , iliad , batch  ;
DLOYIMP = LOYIMP ;
ALOYIMP = DLOYIMP;
CILOYIMP = arr(ALOYIMP*TX_LOYIMP/100) * (1 - positif(RE168 + TAX1649)) ;
regle 30231013:
application : pro , oceans , iliad , batch  ;
DDEVDUR = CRENRJ + CRENRJRNOUV + CRECHOBOI + CRECHOCON2 + CRECHOBAS ;

PDEVDUR = max( (   PLAF_DEVDUR * (1 + BOOL_0AM)
                  + PLAF_GE2_PACQAR * (V_0CH+V_0DP)
	          + PLAF_GE2_PAC * (V_0CR+V_0CF+V_0DJ+V_0DN) 
		 ) - (V_BTDEVDUR*(1-present(DEPCHOBAS))+DEPCHOBAS) , 0 );

ADEVDUR = max (0 , min (DDEVDUR,PDEVDUR)) * (1 - V_CNR);
R1DEVDUR = min (ADEVDUR , CRENRJ) ;
R2DEVDUR = min (max(0 , ADEVDUR-R1DEVDUR) , CRENRJRNOUV) ;
R3DEVDUR = min (max(0 , ADEVDUR-R1DEVDUR-R2DEVDUR) , CRECHOBOI) ;
R4DEVDUR = min (max(0 , ADEVDUR-R1DEVDUR-R2DEVDUR-R3DEVDUR) , CRECHOCON2) ;
R5DEVDUR = min (max(0 , ADEVDUR-R1DEVDUR-R2DEVDUR-R3DEVDUR-R4DEVDUR) , CRECHOBAS) ;
CIDEVDUR = arr (R1DEVDUR * TX50/100 + R2DEVDUR * TX45/100 + R3DEVDUR * TX36/100  
		 + R4DEVDUR * TX22/100 + R5DEVDUR * TX13/100) 
	    * (1 - positif(RE168 + TAX1649)) * (1 - V_CNR) ;  

DEVDURCUM = ADEVDUR + (V_BTDEVDUR*(1-present(DEPCHOBAS))+DEPCHOBAS);
regle 30231014:
application : pro , oceans , iliad , batch  ;
DEVDURBAIL = CINRJ + CINRJBAIL + CIBOIBAIL + CICHO2BAIL + CIDEP15 ;
ADEVDUBAIL = DEVDURBAIL * ((V_REGCO+0) dans (1,3,5,6));
R1DEDUBAIL = CINRJ ;
R2DEDUBAIL = CINRJBAIL ;
R3DEDUBAIL = CIBOIBAIL ;
R4DEDUBAIL = CICHO2BAIL ;
R5DEDUBAIL = CIDEP15 ;

CIDEDUBAIL = arr (R1DEDUBAIL * TX50/100 + R2DEDUBAIL * TX45/100 + R3DEDUBAIL * TX36/100
		 + R4DEDUBAIL * TX22/100 + R5DEDUBAIL * TX13/100)
		  * (1 - positif(RE168 + TAX1649)) * ((V_REGCO+0) dans (1,3,5,6)) ;
DEVCUMBAIL = ADEVDUBAIL;
regle 30231015:
application : pro , oceans , iliad , batch  ;
DTEC = RISKTEC;
ATEC = positif(DTEC) * DTEC;
CITEC = arr (ATEC * TX30/100);
regle 30231016:
application : pro , oceans , iliad , batch  ;
DPRETUD = PRETUD + PRETUDANT ;
APRETUD = max(min(PRETUD,LIM_PRETUD) + min(PRETUDANT,LIM_PRETUD*CASEPRETUD),0) * (1-V_CNR) ;

CIPRETUD = arr(APRETUD*TX_PRETUD/100) * (1 - positif(RE168 + TAX1649)) * (1-V_CNR) ;
regle 30231017:
application : pro , oceans , iliad , batch  ;

EM7 = somme (i=0..7: min (1 , max(0 , V_0Fi + AG_LIMFG - V_ANREV)))
      + (1 - positif(somme(i=0..7:V_0Fi) + 0)) * V_0CF ;

EM7QAR = somme (i=0..5: min (1 , max(0 , V_0Hi + AG_LIMFG - V_ANREV)))
         + somme (j=0..3: min (1 , max(0 , V_0Pj + AG_LIMFG - V_ANREV)))
         + (1 - positif(somme(i=0..5: V_0Hi) + somme(j=0..3: V_0Pj) + 0)) * (V_0CH + V_0DP) ;

BRFG = min(RDGARD1,PLAF_REDGARD) + min(RDGARD2,PLAF_REDGARD)
       + min(RDGARD3,PLAF_REDGARD) + min(RDGARD4,PLAF_REDGARD)
       + min(RDGARD1QAR,PLAF_REDGARDQAR) + min(RDGARD2QAR,PLAF_REDGARDQAR)
       + min(RDGARD3QAR,PLAF_REDGARDQAR) + min(RDGARD4QAR,PLAF_REDGARDQAR)
       ;
RFG = arr ( (BRFG) * TX_REDGARD /100 ) * (1 -V_CNR);
DGARD = somme(i=1..4:RDGARDi)+somme(i=1..4:RDGARDiQAR);
AGARD = (BRFG) * (1-V_CNR) ;
CIGARD = RFG * (1 - positif(RE168 + TAX1649)) ;
regle 30231018:
application : pro , oceans , iliad , batch  ;

PREHAB = PREHABT + PREHABTN + PREHABTN1 + PREHABT1 + PREHABT2 + PREHABTN2 ;

BCIHP = max(( PLAFHABPRIN * (1 + BOOL_0AM) * (1+positif(V_0AP+V_0AF+V_0CG+V_0CI+V_0CR))
	         + (PLAFHABPRINENF/2) * (V_0CH + V_0DP)
         	 + PLAFHABPRINENF * (V_0CR + V_0CF + V_0DJ + V_0DN)
	          ) 
	     ,0);

BCIHABPRIN1 = min(BCIHP , PREHABT) * (1 - V_CNR) ;
BCIHABPRIN2 = min(max(0,BCIHP-BCIHABPRIN1),PREHABT1) * (1 - V_CNR);
BCIHABPRIN3 = min(max(0,BCIHP-BCIHABPRIN1-BCIHABPRIN2),PREHABTN) * (1 - V_CNR);
BCIHABPRIN4 = min(max(0,BCIHP-BCIHABPRIN1-BCIHABPRIN2-BCIHABPRIN3),PREHABTN1) * (1 - V_CNR);
BCIHABPRIN5 = min(max(0,BCIHP-BCIHABPRIN1-BCIHABPRIN2-BCIHABPRIN3-BCIHABPRIN4),PREHABT2) * (1 - V_CNR);
BCIHABPRIN6 = min(max(0,BCIHP-BCIHABPRIN1-BCIHABPRIN2-BCIHABPRIN3-BCIHABPRIN4-BCIHABPRIN5),PREHABTN2) * (1 - V_CNR);

BCIHABPRIN = BCIHABPRIN1 + BCIHABPRIN2 + BCIHABPRIN3 + BCIHABPRIN4 + BCIHABPRIN5 + BCIHABPRIN6 ;
CIHABPRIN = arr((BCIHABPRIN1 * TX40/100)
		+ (BCIHABPRIN2 * TX40/100)
		+ (BCIHABPRIN3 * TX30/100)
                + (BCIHABPRIN4 * TX25/100)
                + (BCIHABPRIN5 * TX20/100)
		+ (BCIHABPRIN6 * TX15/100))
		* (1 - positif(RE168 + TAX1649)) * (1 - V_CNR);
regle 302311:
application : pro , oceans , iliad , batch ;
CICSG = min( CSGC , arr( IPPNCS * T_CSG/100 ));
CIRDS = min( RDSC , arr( IPPNCS * T_RDS/100 ));
CIPRS = min( PRSC , arr( IPPNCS * T_PREL_SOC/100 ));


regle 30400:
application : pro , oceans ,  iliad , batch  ;
PPE_DATE_DEB = positif(V_0AV+0) * positif(V_0AZ+0) * (V_0AZ+0)
              + positif(DATRETETR+0) * (DATRETETR+0) * null(V_0AZ+0) ;

PPE_DATE_FIN = positif(BOOL_0AM) * positif(V_0AZ+0) * (V_0AZ+0)
              + positif(DATDEPETR+0) * (DATDEPETR+0) * null(V_0AZ+0) ;
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
       * (1 - positif(V_PPEISF + PPEISFPIR+PPEREVPRO))    
       * (1 - positif(RE168 + TAX1649)) 
       * (1 -  V_CNR);

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

PPEREST2A = positif(IRE) * positif(IRESTIT) * max(0,min(PPETOT-PPERSA , IRESTIT)) ; 

PPEIMP2A = positif_ou_nul(PPEREST2A) * (PPETOT - PPERSA - PPEREST2A) ;



regle 30912:
application : iliad , batch,pro  ;

pour i=V,C,1,2,3,4,N,U:
PPETEMPSi = arr(1 / PPE_COEFFi * 100) ;




pour i=V,C,1,2,3,4,N,U:
PPECOEFFi= arr(PPE_COEFFCONDi * 100 );
regle 990:
application : iliad, batch, pro, oceans ;

REST = positif(IRE) * positif(IRESTIT) ;

LIBREST = positif(REST) * max(0,min(AUTOVERSLIB , IRESTIT-(PPETOT-PPERSA))) ;

LIBIMP = positif_ou_nul(LIBREST) * (AUTOVERSLIB - LIBREST) ;

LOIREST = positif(REST) * max(0,min(CILOYIMP , IRESTIT-(PPETOT-PPERSA)-AUTOVERSLIB)) ;

LOIIMP = positif_ou_nul(LOIREST) * (CILOYIMP - LOIREST) ;

TABREST = positif(REST) * max(0,min(CIDEBITTABAC , IRESTIT-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP)) ;

TABIMP = positif_ou_nul(TABREST) * (CIDEBITTABAC - TABREST) ;

TAUREST = positif(REST) * max(0,min(CRERESTAU , IRESTIT-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC)) ;

TAUIMP = positif_ou_nul(TAUREST) * (CRERESTAU - TAUREST) ;

AGRREST = positif(REST) * max(0,min(CICONGAGRI , IRESTIT-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU)) ;

AGRIMP = positif_ou_nul(AGRREST) * (CICONGAGRI - AGRREST) ;

ARTREST = positif(REST) * max(0,min(CREARTS , IRESTIT-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI)) ;

ARTIMP = positif_ou_nul(ARTREST) * (CREARTS - ARTREST) ;

INTREST = positif(REST) * max(0,min(CREINTERESSE , IRESTIT-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS)) ;

INTIMP = positif_ou_nul(INTREST) * (CREINTERESSE - INTREST) ;

FORREST = positif(REST) * max(0,min(CREFORMCHENT , IRESTIT-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE)) ;

FORIMP = positif_ou_nul(FORREST) * (CREFORMCHENT - FORREST) ;

PROREST = positif(REST) * max(0,min(CREPROSP , IRESTIT-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
						-CREFORMCHENT)) ;

PROIMP = positif_ou_nul(PROREST) * (CREPROSP - PROREST) ;

BIOREST = positif(REST) * max(0,min(CREAGRIBIO , IRESTIT-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
						 -CREFORMCHENT-CREPROSP)) ;

BIOIMP = positif_ou_nul(BIOREST) * (CREAGRIBIO - BIOREST) ;

APPREST = positif(REST) * max(0,min(CREAPP , IRESTIT-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
					     -CREFORMCHENT-CREPROSP-CREAGRIBIO)) ;

APPIMP = positif_ou_nul(APPREST) * (CREAPP - APPREST) ;

FAMREST = positif(REST) * max(0,min(CREFAM , IRESTIT-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
					     -CREFORMCHENT-CREPROSP-CREAGRIBIO-CREAPP)) ;

FAMIMP = positif_ou_nul(FAMREST) * (CREFAM - FAMREST) ;

HABREST = positif(REST) * max(0,min(CIHABPRIN , IRESTIT-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
						-CREFORMCHENT-CREPROSP-CREAGRIBIO-CREAPP-CREFAM)) ;

HABIMP = positif_ou_nul(HABREST) * (CIHABPRIN - HABREST) ;

SALREST = positif(REST) * max(0,min(CIADCRE , IRESTIT-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
                                              -CREFORMCHENT-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN)) ;

SALIMP = positif_ou_nul(SALREST) * (CIADCRE - SALREST) ;

PREREST = positif(REST) * max(0,min(CIPRETUD , IRESTIT-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
					       -CREFORMCHENT-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIADCRE)) ;

PREIMP = positif_ou_nul(PREREST) * (CIPRETUD - PREREST) ;

GARREST = positif(REST) * max(0,min(CIGARD , IRESTIT-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
					     -CREFORMCHENT-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIADCRE-CIPRETUD)) ;

GARIMP = positif_ou_nul(GARREST) * (CIGARD - GARREST) ;

BAIREST = positif(REST) * max(0,min(CICA , IRESTIT-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
					   -CREFORMCHENT-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIADCRE-CIPRETUD-CIGARD)) ;
 
BAIIMP = positif_ou_nul(BAIREST) * (CICA - BAIREST) ;

ELUREST = positif(REST) * max(0,min(IPELUS , IRESTIT-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
					     -CREFORMCHENT-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIADCRE-CIPRETUD-CIGARD-CICA)) ;
 
ELUIMP = positif_ou_nul(ELUREST) * (IPELUS - ELUREST) ;

TECREST = positif(REST) * max(0,min(CITEC , IRESTIT-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
					    -CREFORMCHENT-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIADCRE-CIPRETUD-CIGARD-CICA-IPELUS)) ;

TECIMP = positif_ou_nul(TECREST) * (CITEC - TECREST) ;

DELREST = positif(REST) * max(0,min(CIDEDUBAIL , IRESTIT-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
						 -CREFORMCHENT-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIADCRE-CIPRETUD-CIGARD-CICA-IPELUS-CITEC)) ;

DELIMP = positif_ou_nul(DELREST) * (CIDEDUBAIL - DELREST) ;

DEPREST = positif(REST) * max(0,min(CIDEVDUR , IRESTIT-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
					       -CREFORMCHENT-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIADCRE-CIPRETUD-CIGARD-CICA-IPELUS-CITEC
					       -CIDEDUBAIL)) ;

DEPIMP = positif_ou_nul(DEPREST) * (CIDEVDUR - DEPREST) ;

AIDREST = positif(REST) * max(0,min(CIGE , IRESTIT-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
					   -CREFORMCHENT-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIADCRE-CIPRETUD-CIGARD-CICA-IPELUS-CITEC
					   -CIDEDUBAIL-CIDEVDUR)) ;

AIDIMP = positif_ou_nul(AIDREST) * (CIGE - AIDREST) ;

ASSREST = positif(REST) * max(0,min(I2DH , IRESTIT-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
					   -CREFORMCHENT-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIADCRE-CIPRETUD-CIGARD-CICA-IPELUS-CITEC
					   -CIDEDUBAIL-CIDEVDUR-CIGE)) ;

ASSIMP = positif_ou_nul(ASSREST) * (I2DH - ASSREST) ;

EPAREST = positif(REST) * max(0,min(CIDIREPARGNE , IRESTIT-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
						 -CREFORMCHENT-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIADCRE-CIPRETUD-CIGARD-CICA-IPELUS-CITEC
						 -CIDEDUBAIL-CIDEVDUR-CIGE-I2DH)) ;

EPAIMP = positif_ou_nul(EPAREST) * (CIDIREPARGNE - EPAREST) ;

RECREST = positif(REST) * max(0,min(IPRECH , IRESTIT-(PPETOT-PPERSA)-AUTOVERSLIB-CILOYIMP-CIDEBITTABAC-CRERESTAU-CICONGAGRI-CREARTS-CREINTERESSE
					     -CREFORMCHENT-CREPROSP-CREAGRIBIO-CREAPP-CREFAM-CIHABPRIN-CIADCRE-CIPRETUD-CIGARD-CICA-IPELUS-CITEC
					     -CIDEDUBAIL-CIDEVDUR-CIGE-I2DH-CIDIREPARGNE)) ;

RECIMP = positif_ou_nul(RECREST) * (IPRECH - RECREST) ;

