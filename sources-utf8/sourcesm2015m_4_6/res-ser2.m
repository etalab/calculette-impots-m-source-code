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
 #
 #
 #
 # #####   ######   ####    #####     #     #####  
 # #    #  #       #          #       #       #   
 # #    #  #####    ####      #       #       #  
 # #####   #            #     #       #       # 
 # #   #   #       #    #     #       #       # 
 # #    #  ######   ####      #       #       # 
 #
 #      #####   #####   #####   #
 #          #   #   #   #   #   #
 #      #####   #   #   #   #   #
 #      #       #   #   #   #   #
 #      #####   #####   #####   #
 #
 #
 #
 #
 #                     RES-SER2.m
 #                    =============
 #
 #
 #                      zones restituees par l'application
 #
 #
regle 221000:
application : iliad , batch ;


IDRS = INDTXMIN*IMI + 
       INDTXMOY*IMO + 
       (1-INDTXMIN) * (1-INDTXMOY) * max(0,IPHQ2 - ADO1) ;

regle 221010:
application : iliad , batch , bareme ;


RECOMP = max(0 ,( IPHQANT2 - IPHQ2 )*(1-INDTXMIN) * (1-INDTXMOY)) 
         * (1 - positif(IPMOND+INDTEFF)) ;

regle 221020:
application : iliad , batch ;


IDRSANT = INDTXMIN*IMI + INDTXMOY*IMO 
         + (1-INDTXMIN) * (1-INDTXMOY) * max(0,IPHQANT2 - ADO1) ;


IDRS2 = (1 - positif(IPMOND+INDTEFF))  * 
        ( 
         ((IDRSANT + ( positif(ABADO)*ABADO + positif(ABAGU)*ABAGU ))
                  * positif(IDRSANT)
         + IPHQANT2 * (1 - positif(IDRSANT))) * (1-positif(RE168+TAX1649))
         + positif(RE168+TAX1649) * IAMD2
        )
   + positif(IPMOND+INDTEFF) 
         * ( IDRS*(1-positif(IPHQ2)) + IPHQ2 * positif(IPHQ2) );

IDRS3 = IDRT ;

regle 221030:
application : iliad , batch ;


PLAFQF = positif(IS521 - PLANT - IS511) * ( positif(abs(TEFF)) * positif(IN51) + (1 - positif(abs(TEFF))) );

regle 221040:
application : iliad , batch ;

REVMETRO = max(0,RG - PRODOM - PROGUY);

regle 221050:
application : iliad , batch ;


RGPAR =   positif(positif(PRODOM)+positif(CODDAJ)+positif(CODDBJ)) * 1 
       +  positif(positif(PROGUY)+positif(CODEAJ)+positif(CODEBJ)) * 2
       +  positif(positif(PROGUY)+positif(CODEAJ)+positif(CODEBJ))*positif(positif(PRODOM)+positif(CODDAJ)+positif(CODDBJ)) 
       ;

regle 221060:
application : iliad , batch ;


IBAEX = (IPQT2) * (1 - INDTXMIN) * (1 - INDTXMOY) ;

regle 221070:
application : iliad , batch ;


PRELIB = PPLIB + RCMLIB ;

regle 221080:
application : iliad , batch ;


IDEC = DEC11 * (1 - positif(V_CNR)) ;

IDECA = min(max( arr((SEUIL_DECOTE1A * (1 - BOOL_0AM)) + (SEUIL_DECOTE2A * BOOL_0AM) - IDOM11),0),IDOM11) * (1 - V_CNR) ;

regle 221090:
application : iliad , batch ;


IPROP = ITP ;

regle 221100:
application : iliad , batch ;


IREP = REI ;

regle 221110:
application : batch , iliad ;


RETIR = RETIR2 + arr(BTOINR * TXINT/100) ;

RETTAXA = RETTAXA2 + arr(max(0,TAXASSUR-TAXA9YI- min(TAXASSUR+0,max(0,INE-IRB+AVFISCOPTER))+min(0,IRN - IRANT)) * TXINT/100) ;

RETPCAP = RETPCAP2+arr(max(0,IPCAPTAXT-CAP9YI- min(IPCAPTAXT+0,max(0,INE-IRB+AVFISCOPTER-TAXASSUR))+min(0,IRN - IRANT+TAXASSUR)) * TXINT/100) ;

RETLOY = RETLOY2+arr(max(0,TAXLOY-LOY9YI- min(TAXLOY+0,max(0,INE-IRB+AVFISCOPTER-TAXASSUR-IPCAPTAXT))
                           +min(0,IRN - IRANT+TAXASSUR+IPCAPTAXT)) * TXINT/100) ;
RETHAUTREV = RETCHR2 + arr(max(0,IHAUTREVT-CHR9YI+min(0,IRN - IRANT+TAXASSUR+IPCAPTAXT+TAXLOY)) * TXINT/100) ;

RETCS = RETCS2 + arr(max(0, CSG-CS9YP-CSGIM) * TXINT/100)* positif_ou_nul(CSTOTSSPENA - SEUIL_61) ;

RETRD = RETRD2 + arr(max(0, RDSN-RD9YP-CRDSIM) * TXINT/100) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);

RETPS = RETPS2 + arr(max(0, PRS-PS9YP-PRSPROV) * TXINT/100) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);

RETCVN = RETCVN2 + arr(max(0, CVNN-CVN9YP - COD8YT) * TXINT/100) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);


RETCDIS = RETCDIS2 + arr(max(0, CDIS-CDIS9YP - CDISPROV) * TXINT/100) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);

RETGLOA = RETGLOA2 + arr(max(0, CGLOA-GLO9YP-COD8YL) * TXINT/100) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);

RETRSE1 = RETRSE12 + arr(max(0, RSE1N-RSE19YP-CSPROVYD) * TXINT/100) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);

RETRSE2 = RETRSE22 + arr((max(0, max(0, RSE8TV - CIRSE8TV - CSPROVYF) + max(0, RSE8SA -CIRSE8SA - CSPROVYN) - RSE29YP)) * TXINT/100
                        ) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);

RETRSE3 = RETRSE32 + arr(max(0, RSE3N-RSE39YP-CSPROVYG) * TXINT/100) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);

RETRSE4 = RETRSE42 + arr((max(0, RSE4N - CSPROVYH - CSPROVYP - RSE49YP)) * TXINT/100
                        ) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);

RETRSE5 = RETRSE52 + arr(max(0, RSE5N-RSE59YP-CSPROVYE) * TXINT/100) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);

RETRSE6 = RETRSE62 + arr(max(0, RSE6N-RSE69YP) * TXINT/100) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);

regle 221120:
application : batch , iliad ;

MAJOIRTARDIF_A1 = MAJOIRTARDIF_A - MAJOIR17_2TARDIF_A;
MAJOTAXATARDIF_A1 = MAJOTAXATARDIF_A - MAJOTA17_2TARDIF_A;
MAJOCAPTARDIF_A1 = MAJOCAPTARDIF_A - MAJOCP17_2TARDIF_A;
MAJOLOYTARDIF_A1 = MAJOLOYTARDIF_A - MAJOLO17_2TARDIF_A;
MAJOHRTARDIF_A1 = MAJOHRTARDIF_A - MAJOHR17_2TARDIF_A;
MAJOIRTARDIF_D1 = MAJOIRTARDIF_D - MAJOIR17_2TARDIF_D;
MAJOTAXATARDIF_D1 = MAJOTAXATARDIF_D - MAJOTA17_2TARDIF_D;
MAJOCAPTARDIF_D1 = MAJOCAPTARDIF_D - MAJOCP17_2TARDIF_D;
MAJOLOYTARDIF_D1 = MAJOLOYTARDIF_D - MAJOLO17_2TARDIF_D;
MAJOHRTARDIF_D1 = MAJOHRTARDIF_D - MAJOHR17_2TARDIF_D;
MAJOIRTARDIF_P1 = MAJOIRTARDIF_P - MAJOIR17_2TARDIF_P;
MAJOLOYTARDIF_P1 = MAJOLOYTARDIF_P - MAJOLO17_2TARDIF_P;
MAJOHRTARDIF_P1 = MAJOHRTARDIF_P - MAJOHR17_2TARDIF_P;
MAJOIRTARDIF_R1 = MAJOIRTARDIF_R - MAJOIR17_2TARDIF_R;
MAJOTAXATARDIF_R1 = MAJOTAXATARDIF_R - MAJOTA17_2TARDIF_R;
MAJOCAPTARDIF_R1 = MAJOCAPTARDIF_R - MAJOCP17_2TARDIF_R;
MAJOLOYTARDIF_R1 = MAJOLOYTARDIF_R - MAJOLO17_2TARDIF_R;
MAJOHRTARDIF_R1 = MAJOHRTARDIF_R - MAJOHR17_2TARDIF_R;
NMAJ1 = max(0,MAJO1728IR + arr(BTO * COPETO/100)  
		+ FLAG_TRTARDIF * MAJOIRTARDIF_D1
		+ FLAG_TRTARDIF_F 
		* (positif(PROPIR_A) * MAJOIRTARDIF_P1
		  + (1 - positif(PROPIR_A) ) * MAJOIRTARDIF_D1)
		- FLAG_TRTARDIF_F * (1 - positif(PROPIR_A))
				    * ( positif(FLAG_RECTIF) * MAJOIRTARDIF_R1
				     + (1 - positif(FLAG_RECTIF)) * MAJOIRTARDIF_A1)
		);
NMAJTAXA1 = max(0,MAJO1728TAXA + arr(max(0,TAXASSUR- min(TAXASSUR+0,max(0,INE-IRB+AVFISCOPTER))+min(0,IRN-IRANT)) * COPETO/100)  
		+ FLAG_TRTARDIF * MAJOTAXATARDIF_D1
		+ FLAG_TRTARDIF_F * MAJOTAXATARDIF_D1
        	- FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * MAJOTAXATARDIF_R1
				     + (1 - positif(FLAG_RECTIF)) * MAJOTAXATARDIF_A1)
		);
NMAJPCAP1 = max(0,MAJO1728PCAP + arr(max(0,IPCAPTAXT- min(IPCAPTAXT+0,max(0,INE-IRB+AVFISCOPTER-TAXASSUR))+min(0,IRN-IRANT+TAXASSUR)) * COPETO/100)
                + FLAG_TRTARDIF * MAJOCAPTARDIF_D1
                + FLAG_TRTARDIF_F * MAJOCAPTARDIF_D1
                - FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * MAJOCAPTARDIF_R1
                + (1 - positif(FLAG_RECTIF)) * MAJOCAPTARDIF_A1)
                );
NMAJLOY1 = max(0,MAJO1728LOY + arr(max(0,TAXLOY- min(TAXLOY+0,max(0,INE-IRB+AVFISCOPTER-TAXASSUR-IPCAPTAXT))+min(0,IRN-IRANT+TAXASSUR+IPCAPTAXT)) * COPETO/100)
                + FLAG_TRTARDIF * MAJOLOYTARDIF_D1
		+ FLAG_TRTARDIF_F 
		* (positif(PROPLOY_A) * MAJOLOYTARDIF_P1
		  + (1 - positif(PROPLOY_A) ) * MAJOLOYTARDIF_D1)
		- FLAG_TRTARDIF_F * (1 - positif(PROPLOY_A))
				    * ( positif(FLAG_RECTIF) * MAJOLOYTARDIF_R1
				     + (1 - positif(FLAG_RECTIF)) * MAJOLOYTARDIF_A1)

                );
NMAJCHR1 = max(0,MAJO1728CHR + arr(max(0,IHAUTREVT+min(0,IRN-IRANT+TAXASSUR+IPCAPTAXT+TAXLOY)) * COPETO/100)
                + FLAG_TRTARDIF * MAJOHRTARDIF_D1
		+ FLAG_TRTARDIF_F 
		* (positif(PROPIR_A) * MAJOHRTARDIF_P1
		  + (1 - positif(PROPIR_A) ) * MAJOHRTARDIF_D1)
		- FLAG_TRTARDIF_F * (1 - positif(PROPIR_A))
				    * ( positif(FLAG_RECTIF) * MAJOHRTARDIF_R1
				     + (1 - positif(FLAG_RECTIF)) * MAJOHRTARDIF_A1)
                );
NMAJC1 = max(0,MAJO1728CS + arr((CSG - CSGIM) * COPETO/100)  
		+ FLAG_TRTARDIF * MAJOCSTARDIF_D
		+ FLAG_TRTARDIF_F 
		* (positif(PROPCS_A) * MAJOCSTARDIF_P 
		  + (1 - positif(PROPCS_A) ) * MAJOCSTARDIF_D)
		- FLAG_TRTARDIF_F * (1 - positif(PROPCS_A))
				    * ( positif(FLAG_RECTIF) * MAJOCSTARDIF_R
				     + (1 - positif(FLAG_RECTIF)) * MAJOCSTARDIF_A)
		) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);
NMAJR1 = max(0,MAJO1728RD + arr((RDSN - CRDSIM) * COPETO/100) 
		+ FLAG_TRTARDIF * MAJORDTARDIF_D
		+ FLAG_TRTARDIF_F 
		* (positif(PROPRD_A) * MAJORDTARDIF_P 
		  + (1 - positif(PROPRD_A) ) * MAJORDTARDIF_D)
		- FLAG_TRTARDIF_F * (1 - positif(PROPCS_A))
				    * ( positif(FLAG_RECTIF) * MAJORDTARDIF_R
				     + (1 - positif(FLAG_RECTIF)) * MAJORDTARDIF_A)
		) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);
NMAJP1 = max(0,MAJO1728PS + arr((PRS - PRSPROV) * COPETO/100)  
		+ FLAG_TRTARDIF * MAJOPSTARDIF_D
		+ FLAG_TRTARDIF_F 
		* (positif(PROPPS_A) * MAJOPSTARDIF_P 
		  + (1 - positif(PROPPS_A) ) * MAJOPSTARDIF_D)
		- FLAG_TRTARDIF_F * (1 - positif(PROPPS_A))
				    * ( positif(FLAG_RECTIF) * MAJOPSTARDIF_R
				     + (1 - positif(FLAG_RECTIF)) * MAJOPSTARDIF_A)
		) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);

NMAJCVN1 = max(0,MAJO1728CVN + arr((CVNN - COD8YT) * COPETO/100)
		+ FLAG_TRTARDIF * MAJOCVNTARDIF_D
		+ FLAG_TRTARDIF_F  * MAJOCVNTARDIF_D
		- FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * MAJOCVNTARDIF_R
				     + (1 - positif(FLAG_RECTIF)) * MAJOCVNTARDIF_A)
		) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);

NMAJCDIS1 = max(0,MAJO1728CDIS + arr((CDIS - CDISPROV) * COPETO/100)  * (1 - V_CNR)
		+ FLAG_TRTARDIF * MAJOCDISTARDIF_D
		+ FLAG_TRTARDIF_F  * MAJOCDISTARDIF_D
		- FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * MAJOCDISTARDIF_R
				     + (1 - positif(FLAG_RECTIF)) * MAJOCDISTARDIF_A)
		) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);

NMAJGLO1 = max(0,MAJO1728GLO + arr((CGLOA-COD8YL) * COPETO/100)
                + FLAG_TRTARDIF * MAJOGLOTARDIF_D
                + FLAG_TRTARDIF_F  * MAJOGLOTARDIF_D
                - FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * MAJOGLOTARDIF_R
                                     + (1 - positif(FLAG_RECTIF)) * MAJOGLOTARDIF_A)
              ) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);

NMAJRSE11 = max(0,MAJO1728RSE1 + arr((RSE1N - CSPROVYD) * COPETO/100)  
		+ FLAG_TRTARDIF * MAJORSE1TARDIF_D
		+ FLAG_TRTARDIF_F  * MAJORSE1TARDIF_D
		- FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * MAJORSE1TARDIF_R
				     + (1 - positif(FLAG_RECTIF)) * MAJORSE1TARDIF_A)
		) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);

NMAJRSE21 = max(0,MAJO1728RSE2 + arr(( max(0, RSE8TV - CIRSE8TV - CSPROVYF) + max(0, RSE8SA -CIRSE8SA - CSPROVYN )) * COPETO/100) * (1 - V_CNR)
		+ FLAG_TRTARDIF * MAJORSE2TARDIF_D
		+ FLAG_TRTARDIF_F  * MAJORSE2TARDIF_D
		- FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * MAJORSE2TARDIF_R
				     + (1 - positif(FLAG_RECTIF)) * MAJORSE2TARDIF_A)
		) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);

NMAJRSE31 = max(0,MAJO1728RSE3 + arr((RSE3N - CSPROVYG)* COPETO/100) 
		+ FLAG_TRTARDIF * MAJORSE3TARDIF_D
		+ FLAG_TRTARDIF_F  * MAJORSE3TARDIF_D
		- FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * MAJORSE3TARDIF_R
				     + (1 - positif(FLAG_RECTIF)) * MAJORSE3TARDIF_A)
		) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);

NMAJRSE41 = max(0,MAJO1728RSE4 + arr((RSE4N - CSPROVYH - CSPROVYP) * COPETO/100) 
		+ FLAG_TRTARDIF * MAJORSE4TARDIF_D
		+ FLAG_TRTARDIF_F  * MAJORSE4TARDIF_D
		- FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * MAJORSE4TARDIF_R
				     + (1 - positif(FLAG_RECTIF)) * MAJORSE4TARDIF_A)
		) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);

NMAJRSE51 = max(0,MAJO1728RSE5 + arr((RSE5N - CSPROVYE) * COPETO/100) 
		+ FLAG_TRTARDIF * MAJORSE5TARDIF_D
		+ FLAG_TRTARDIF_F  * MAJORSE5TARDIF_D
		- FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * MAJORSE5TARDIF_R
				     + (1 - positif(FLAG_RECTIF)) * MAJORSE5TARDIF_A)
		) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);

NMAJRSE61 = max(0,MAJO1728RSE6 + arr(RSE6N * COPETO/100) 
		+ FLAG_TRTARDIF * MAJORSE6TARDIF_D
		+ FLAG_TRTARDIF_F  * MAJORSE6TARDIF_D
		- FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * MAJORSE6TARDIF_R
				     + (1 - positif(FLAG_RECTIF)) * MAJORSE6TARDIF_A)
		) * positif_ou_nul(CSTOTSSPENA - SEUIL_61) ;

NMAJ3 = max(0,MAJO1758AIR + arr(BTO * COPETO/100) * positif(null(CMAJ-10)+null(CMAJ-17)) 
		+ FLAG_TRTARDIF * MAJOIR17_2TARDIF_D
		+ FLAG_TRTARDIF_F 
		* (positif(PROPIR_A) * MAJOIR17_2TARDIF_P 
		  + (1 - positif(PROPIR_A) ) * MAJOIR17_2TARDIF_D)
		- FLAG_TRTARDIF_F * (1 - positif(PROPIR_A))
				    * ( positif(FLAG_RECTIF) * MAJOIR17_2TARDIF_R
				     + (1 - positif(FLAG_RECTIF)) * MAJOIR17_2TARDIF_A)
		);
NMAJTAXA3 = max(0,MAJO1758ATAXA + arr(max(0,TAXASSUR+min(0,IRN-IRANT)) * COPETO/100)
					* positif(null(CMAJ-10)+null(CMAJ-17)) 
		+ FLAG_TRTARDIF * MAJOTA17_2TARDIF_D
		);
NMAJPCAP3 = max(0,MAJO1758APCAP + arr(max(0,IPCAPTAXT+min(0,IRN-IRANT+TAXASSUR)) * COPETO/100)
                * positif(null(CMAJ-10)+null(CMAJ-17))
                + FLAG_TRTARDIF * MAJOCP17_2TARDIF_D
		);
NMAJLOY3 = max(0,MAJO1758ALOY + arr(max(0,TAXLOY+min(0,IRN-IRANT+TAXASSUR+IPCAPTAXT)) * COPETO/100) * positif(null(CMAJ-10)+null(CMAJ-17)) 
		+ FLAG_TRTARDIF * MAJOLO17_2TARDIF_D
		+ FLAG_TRTARDIF_F 
		* (positif(PROPLOY_A) * MAJOLO17_2TARDIF_P 
		  + (1 - positif(PROPLOY_A) ) * MAJOLO17_2TARDIF_D)
		- FLAG_TRTARDIF_F * (1 - positif(PROPLOY_A))
				    * ( positif(FLAG_RECTIF) * MAJOLO17_2TARDIF_R
				     + (1 - positif(FLAG_RECTIF)) * MAJOLO17_2TARDIF_A)
		);

NMAJCHR3 = max(0,MAJO1758ACHR + arr(max(0,IHAUTREVT+min(0,IRN-IRANT+TAXASSUR+IPCAPTAXT+TAXLOY)) * COPETO/100) * positif(null(CMAJ-10)+null(CMAJ-17)) 
		+ FLAG_TRTARDIF * MAJOHR17_2TARDIF_D
		+ FLAG_TRTARDIF_F 
		* (positif(PROPHR_A) * MAJOHR17_2TARDIF_P 
		  + (1 - positif(PROPHR_A) ) * MAJOHR17_2TARDIF_D)
		- FLAG_TRTARDIF_F * (1 - positif(PROPHR_A))
				    * ( positif(FLAG_RECTIF) * MAJOHR17_2TARDIF_R
				     + (1 - positif(FLAG_RECTIF)) * MAJOHR17_2TARDIF_A)
		);

NMAJ4    =      somme (i=03..06,30,32,55: MAJOIRi);
NMAJTAXA4  =    somme (i=03..06,55: MAJOTAXAi);
NMAJPCAP4 =  somme(i=03..06,55:MAJOCAPi);
NMAJLOY4 = somme(i=03..06,55:MAJOLOYi);
NMAJCHR4 =  somme(i=03..06,30,32,55:MAJOHRi);

NMAJC4 =  somme(i=03..06,30,32,55:MAJOCSi) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);
NMAJR4 =  somme(i=03..06,30,32,55:MAJORDi) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);
NMAJP4 =  somme(i=03..06,30,32,55:MAJOPSi) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);
NMAJCVN4 =  somme(i=03..06,55:MAJOCVNi) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);
NMAJCDIS4 =  somme(i=03..06,55:MAJOCDISi) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);
NMAJGLO4 =  somme(i=03..06,55:MAJOGLOi) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);
NMAJRSE14 =  somme(i=03..06,55:MAJORSE1i) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);
NMAJRSE24 =  somme(i=03..06,55:MAJORSE2i) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);
NMAJRSE34 =  somme(i=03..06,55:MAJORSE3i) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);
NMAJRSE44 =  somme(i=03..06,55:MAJORSE4i) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);
NMAJRSE54 =  somme(i=03..06,55:MAJORSE5i) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);
NMAJRSE64 =  somme(i=03..06,55:MAJORSE6i) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);

regle isf 221130:
application : batch , iliad ;

MAJOISFTARDIF_A1 = MAJOISFTARDIF_A - MAJOISF17TARDIF_A;
MAJOISFTARDIF_D1 = MAJOISFTARDIF_D - MAJOISF17TARDIF_D;
MAJOISFTARDIF_R1 = MAJOISFTARDIF_R - MAJOISF17TARDIF_R;
NMAJISF1BIS = max(0,MAJO1728ISF + arr(ISF4BASE * COPETO/100)
                   + FLAG_TRTARDIF * MAJOISFTARDIF_D
                   + FLAG_TRTARDIF_F * MAJOISFTARDIF_D
                   - FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * MAJOISFTARDIF_R
					 + (1 - positif(FLAG_RECTIF)) * MAJOISFTARDIF_A)
                 );

regle 221140:
application : iliad , batch ;


IAVIM = IRB + PTOT + TAXASSUR + PTAXA + IPCAPTAXTOT + PPCAP + TAXLOY + PTAXLOY + CHRAPRES + PHAUTREV ;

regle 221150:
application : iliad , batch ;


CDBA = positif_ou_nul(SEUIL_IMPDEFBA-SHBA-(REVTP-BA1)
      -REVQTOTQHT);
AGRBG = SHBA + (REVTP-BA1) + REVQTOTQHT ;

regle 221170:
application : iliad , batch ;

RBAT = max (0 , BANOR+DEFBANIF-DEFNIBAQ);
regle 221175:
application : iliad , batch ;

SFRBAT = max (0 , SFBANOR+SFDEFBANIF-SFDEFNIBAQ + SFDFANTIMPU);
regle 221180:
application : iliad , batch ;


DEFIBA = (min(max(1+SEUIL_IMPDEFBA-SHBA-(REVTP-BA1)
      -REVQTOTQHT,0),1)) * min( 0 , BANOR ) ;

regle 221190:
application : iliad , batch ;

IINET = max(0, NAPTEMPCX- TOTIRPSANT);
IINETIR = max(0 , NAPTIR) ;

regle 221200:
application : bareme ;

IINET = IRNET * positif ( IRNET - SEUIL_61 ) ;

regle 221210:
application : bareme , iliad , batch ;

IRNET2 =  (IAR + PIR - IRANT+ NRINET + IMPRET + (RASAR * V_CNR)) * (1 - INDTXMIN)  * (1 - INDTXMOY)
         + min(0, IAR + PIR - IRANT+ NRINET + IMPRET + (RASAR * V_CNR)) * (INDTXMIN + INDTXMOY)
         + max(0, IAR + PIR - IRANT+ NRINET + IMPRET + (RASAR * V_CNR)) *
                                   (INDTXMIN * positif_ou_nul(IAVIMBIS - SEUIL_TXMIN)
                                  + INDTXMOY * positif_ou_nul(IAVIMO - SEUIL_TXMIN))
         ;

regle 221220:
application : iliad , batch ;

IRNETTER = max ( 0 ,   IRNET2
                       + (TAXASSUR + PTAXA - min(TAXASSUR+PTAXA+0,max(0,INE-IRB+AVFISCOPTER))
                        - max(0,TAXASSUR + PTAXA  - min(TAXASSUR + PTAXA + 0,max(0,INE-IRB+AVFISCOPTER))+ min(0,IRNET2)))
                       + (IPCAPTAXT + PPCAP - min(IPCAPTAXT + PPCAP,max(0,INE-IRB+AVFISCOPTER -TAXASSUR-PTAXA))
                        - max(0,IPCAPTAXT+PPCAP -min(IPCAPTAXT+PPCAP,max(0,INE-IRB+AVFISCOPTER- TAXASSUR - PTAXA ))+ min(0,TAXANEG)))
                       + (TAXLOY + PTAXLOY - min(TAXLOY + PTAXLOY,max(0,INE-IRB+AVFISCOPTER -TAXASSUR-PTAXA-IPCAPTAXT-PPCAP))
                        - max(0,TAXLOY+PTAXLOY -min(TAXLOY+PTAXLOY,max(0,INE-IRB+AVFISCOPTER- TAXASSUR - PTAXA-IPCAPTAXT-PPCAP ))+ min(0,PCAPNEG)))
                       + (IHAUTREVT + PHAUTREV - max(0,IHAUTREVT+PHAUTREV + min(0,LOYELEVNEG)))
                       )
                       ;
IRNETBIS = max(0 , IRNETTER - PIR * positif(SEUIL_12 - IRNETTER + PIR) 
				  * positif(SEUIL_12 - PIR) 
          			  * positif_ou_nul(IRNETTER - SEUIL_12)) ;

regle 221230:
application : iliad , batch ;

IRNET =  IRNETBIS * positif_ou_nul(IRB - min(max(0,IRB-AVFISCOPTER),INE));
regle 221240:
application : iliad , batch ;


TOTNET = max (0,NAPTIR) ;

regle 221250:
application : iliad , batch ;

TAXANEG = min(0 , TAXASSUR + PTAXA - min(TAXASSUR + PTAXA + 0 , max(0,INE-IRB+AVFISCOPTER)) + min(0 , IRNET2)) ;
TAXNET = positif(TAXASSUR)
	  * max(0 , TAXASSUR + PTAXA  - min(TAXASSUR + PTAXA + 0,max(0,INE-IRB+AVFISCOPTER)) + min(0 , IRNET2)) ;
TAXANET = null(NRINET + IMPRET + (RASAR * V_CNR) + 0) * TAXNET
	   + positif(NRINET + IMPRET + (RASAR * V_CNR) + 0)
             * (positif_ou_nul(IAMD1 - SEUIL_61) * TAXNET + (1 - positif_ou_nul(IAMD1  - SEUIL_61)) * 0) ;

regle 221260:
application : iliad , batch ;

PCAPNEG =  min(0,IPCAPTAXT+PPCAP -min(IPCAPTAXT+PPCAP,max(0,INE-IRB+AVFISCOPTER- TAXASSUR - PTAXA ))+ min(0,TAXANEG)) ;
PCAPTAXNET = positif(IPCAPTAXT)
                * max(0,IPCAPTAXT+PPCAP -min(IPCAPTAXT+PPCAP,max(0,INE-IRB+AVFISCOPTER- TAXASSUR - PTAXA ))+ min(0,TAXANEG)) ;
PCAPNET = null(NRINET + IMPRET + (RASAR * V_CNR) + 0) * PCAPTAXNET
	   + positif(NRINET + IMPRET + (RASAR * V_CNR) + 0)
			* ( positif_ou_nul(IAMD1  - SEUIL_61) * PCAPTAXNET + (1 - positif_ou_nul(IAMD1 - SEUIL_61)) * 0 ) ;

regle 221270:
application : iliad , batch ;

LOYELEVNEG =  min(0,TAXLOY + PTAXLOY -min(TAXLOY + PTAXLOY,max(0,INE-IRB+AVFISCOPTER- TAXASSUR - PTAXA-IPCAPTAXT-PPCAP ))+ min(0,PCAPNEG)) ;
LOYELEVNET = positif(LOYELEV)
                * max(0,TAXLOY+PTAXLOY -min(TAXLOY+PTAXLOY,max(0,INE-IRB+AVFISCOPTER- TAXASSUR - PTAXA-IPCAPTAXT-PPCAP ))+ min(0,PCAPNEG)) ;
TAXLOYNET = null(NRINET + IMPRET + (RASAR * V_CNR) + 0) * LOYELEVNET
                + positif(NRINET + IMPRET + (RASAR * V_CNR) + 0)
                * ( positif_ou_nul(IAMD1 - SEUIL_61) * LOYELEVNET + (1 - positif_ou_nul(IAMD1 - SEUIL_61)) * 0 ) ;

regle 221280:
application : iliad , batch ;

CHRNEG = min(0 , IHAUTREVT + PHAUTREV + min(0 , LOYELEVNEG)) ;
CHRNET = positif(IHAUTREVT)
                * max(0,IHAUTREVT+PHAUTREV + min(0,LOYELEVNEG))
               ;
HAUTREVNET = (null(NRINET + IMPRET + (RASAR * V_CNR) + 0) * CHRNET
              +
              positif(NRINET + IMPRET + (RASAR * V_CNR) + 0)
              * ( positif_ou_nul(IAMD1 - SEUIL_61) * CHRNET
              + (1 - positif_ou_nul(IAMD1 - SEUIL_61)) * 0 )
              ) 
              ;

regle 221290:
application : bareme ;


IRNET = max(0 , IRNET2 + RECOMP) ;

regle 221300:
application : iliad , batch ;


IRPROV = min (IRANT , IAR + PIR) * positif(IRANT) ;

regle 221310:
application : batch , iliad ;

NAPPSAVIM = (PRS + PPRS ) ;
NAPCSAVIM = (CSG + PCSG ) ;
NAPRDAVIM = (RDSN + PRDS) ;
NAPCVNAVIM = (CVNN + PCVN) ;
NAPCDISAVIM = (CDIS + PCDIS) ;
NAPGLOAVIM = (CGLOA + PGLOA-COD8YL) ;
NAPRSE1AVIM = (RSE1N + PRSE1) ;
NAPRSE2AVIM = (RSE2N + PRSE2) ;
NAPRSE3AVIM = (RSE3N + PRSE3) ;
NAPRSE4AVIM = (RSE4N + PRSE4) ;
NAPRSE5AVIM = (RSE5N + PRSE5) ;
NAPRSE6AVIM = (RSE6N + PRSE6) ;
NAPCRPAVIM = max(0 , NAPPSAVIM + NAPCSAVIM + NAPRDAVIM + NAPCVNAVIM + NAPCDISAVIM 
                     + NAPGLOAVIM + NAPRSE1AVIM + NAPRSE2AVIM + NAPRSE3AVIM + NAPRSE4AVIM 
                     + NAPRSE5AVIM + NAPRSE6AVIM);

regle 221320:
application : batch , iliad ;

NAPCRPIAMD1 = PRS+CSG+RDSN +CVNN + CDIS + CGLOA + RSE1N + RSE2N + RSE3N + RSE4N + RSE5N + RSE6N ;

regle 221330:
application : batch , iliad ;

NAPCS      =  positif(SEUIL_61 - VARPS61) * 0 +  (1- positif(SEUIL_61 - VARPS61)) *  CSNET  ;
NAPRD      =  positif(SEUIL_61 - VARPS61) * 0 +  (1- positif(SEUIL_61 - VARPS61)) *  RDNET  ;
NAPPS      =  positif(SEUIL_61 - VARPS61) * 0 +  (1- positif(SEUIL_61 - VARPS61)) *  PRSNET  ;
NAPCVN     =  positif(SEUIL_61 - VARPS61) * 0 +  (1- positif(SEUIL_61 - VARPS61)) *  CVNNET  ;
NAPCDIS    =  positif(SEUIL_61 - VARPS61) * 0 +  (1- positif(SEUIL_61 - VARPS61)) *  CDISNET  ;
NAPGLOA    =  positif(SEUIL_61 - VARPS61) * 0 +  (1- positif(SEUIL_61 - VARPS61)) *  CGLOANET  ;
NAPRSE1    =  positif(SEUIL_61 - VARPS61) * 0 +  (1- positif(SEUIL_61 - VARPS61)) *  RSE1NET  ;
NAPRSE2    =  positif(SEUIL_61 - VARPS61) * 0 +  (1- positif(SEUIL_61 - VARPS61)) *  RSE2NET  ;
NAPRSE3    =  positif(SEUIL_61 - VARPS61) * 0 +  (1- positif(SEUIL_61 - VARPS61)) *  RSE3NET  ;
NAPRSE4    =  positif(SEUIL_61 - VARPS61) * 0 +  (1- positif(SEUIL_61 - VARPS61)) *  RSE4NET  ;
NAPRSE5    =  positif(SEUIL_61 - VARPS61) * 0 +  (1- positif(SEUIL_61 - VARPS61)) *  RSE5NET  ;
NAPRSE6    =  positif(SEUIL_61 - VARPS61) * 0 +  (1- positif(SEUIL_61 - VARPS61)) *  RSE6NET  ;
NAPCRP2 = max(0 , NAPPS + NAPCS + NAPRD + NAPCVN + NAPCDIS + NAPGLOA + NAPRSE1 + NAPRSE2 + NAPRSE3 + NAPRSE4 + 
                  NAPRSE5  + NAPRSE6 );

regle 221340:
application : iliad , batch ;


IKIRN = KIR ;

IMPTHNET = max(0 , (IRB * positif_ou_nul(IRB-SEUIL_61)-INE-IRE)
		       * positif_ou_nul((IRB*positif_ou_nul(IRB-SEUIL_61)-INE-IRE)-SEUIL_12)) 
	     * (1 - V_CNR) ;

regle 221350:
application : iliad , batch ;

IRESTIT = abs(min(0 , IRN + PIR + NRINET + IMPRET + RASAR
                    + (TAXASSUR + PTAXA - min(TAXASSUR+PTAXA+0,max(0,INE-IRB+AVFISCOPTER)))
                    + (IPCAPTAXT + PPCAP - min(IPCAPTAXT + PPCAP,max(0,INE-IRB+AVFISCOPTER -TAXASSUR-PTAXA)))
                    + (TAXLOY + PTAXLOY - min(TAXLOY + PTAXLOY,max(0,INE-IRB+AVFISCOPTER -TAXASSUR-PTAXA-IPCAPTAXT-PPCAP)))
                    + ((IHAUTREVT + PHAUTREV) 
                      -min((IHAUTREVT + PHAUTREV),max(0,INE-IRB+AVFISCOPTER-TAXASSUR-PTAXA-IPCAPTAXT-PPCAP-TAXLOY - PTAXLOY)))
                    + null(4-V_IND_TRAIT)* max(0 ,  TOTCR - CSGIM - CRDSIM - PRSPROV - COD8YT - CDISPROV -COD8YL-CSPROVYD
                                                          -CSPROVYE - CSPROVYF - CSPROVYN - CSPROVYG - CSPROVYH - CSPROVYP )
                             * positif_ou_nul((TOTCR - CSGIM - CRDSIM - PRSPROV - COD8YT - CDISPROV -COD8YL-CSPROVYD
                                                     - CSPROVYE-CSPROVYF- CSPROVYN-CSPROVYG-CSPROVYH - CSPROVYP) - SEUIL_61) 
                    + null(5-V_IND_TRAIT) * max(0 , (TOTCR - CSGIM - CRDSIM - PRSPROV - COD8YT - CDISPROV -COD8YL-CSPROVYD
                                                           - CSPROVYE-CSPROVYF- CSPROVYN -CSPROVYG-CSPROVYH- CSPROVYP))
                          * positif_ou_nul((TOTCR - CSGIM - CRDSIM - PRSPROV - COD8YT - CDISPROV -COD8YL-CSPROVYD
                                                  -CSPROVYE-CSPROVYF- CSPROVYN-CSPROVYG-CSPROVYH- CSPROVYP) - SEUIL_61) 
                 )
             ) ;

regle 221360:
application : iliad , batch ;

IRESTITIR = abs(min(0 , IRN + PIR + NRINET + IMPRET + RASAR
                    + (TAXASSUR + PTAXA - min(TAXASSUR+PTAXA+0,max(0,INE-IRB+AVFISCOPTER)))
                    + (IPCAPTAXT + PPCAP - min(IPCAPTAXT + PPCAP,max(0,INE-IRB+AVFISCOPTER -TAXASSUR-PTAXA)))
                    + (TAXLOY + PTAXLOY - min(TAXLOY + PTAXLOY,max(0,INE-IRB+AVFISCOPTER -TAXASSUR-PTAXA-IPCAPTAXT-PPCAP)))
                    + ((IHAUTREVT + PHAUTREV) -min((IHAUTREVT + PHAUTREV),max(0,INE-IRB+AVFISCOPTER-TAXASSUR-PTAXA-IPCAPTAXT-PPCAP-TAXLOY - PTAXLOY)))
                 )
             ) ;

regle 221370:
application : iliad , batch ;

IREST = max(0,max(0,-(NAPTEMPCX)) - max(0,-(TOTIRPSANT))) ;

regle 221380:
application : iliad , batch ;

IRESTIR = max(0 , IRESTITIR - RECUMBISIR);
IINETCALC = max(0,NAPTEMP - TOTIRPSANT);
VARNON = IRPSCUM -RECUM - TOTIRPSANT;
NONMER  =  positif(20 - V_NOTRAIT) * (
                                           positif(SEUIL_8 - RECUM) * positif(SEUIL_12 - IRPSCUM) * IRPSCUM
                                          + (1-positif(SEUIL_8 - RECUM) * positif(SEUIL_12 - IRPSCUM)) * 0
                                     )
        + (1-positif(20-V_NOTRAIT)) * (
                          positif(SEUIL_8 - RECUM) * positif(SEUIL_12 - IRPSCUM) * (
                                                                                              positif(SEUIL_12 - abs(TOTIRPSANT))* max(0,IRPSCUM-RECUM-TOTIRPSANT)
                                                                                            + (1-positif(SEUIL_12 - abs(TOTIRPSANT))) * IRPSCUM
                                                                                   )
                   + (1-positif(SEUIL_8 - RECUM) * positif(SEUIL_12 - IRPSCUM)) * (
                                                                                           positif(positif(SEUIL_12-VARNON) * positif(VARNON)
                                                                                                  + positif(SEUIL_8-abs(VARNON)) * (1-positif(VARNON)))
                                                                                                    * max(0,IRPSCUM-RECUM-TOTIRPSANT)
                                                                                       +(1-positif(positif(SEUIL_12-VARNON) * positif(VARNON)
                                                                                                 + positif(SEUIL_8-abs(VARNON)) * (1-positif(VARNON))))
                                                                                                    * 0
                                                                                  )
                                      );


NONREST  =  positif(20 - V_NOTRAIT) * (
                                           positif(SEUIL_8 - RECUM) * positif(SEUIL_12 - IRPSCUM) * RECUM
                                        + (1-positif(SEUIL_8 - RECUM) * positif(SEUIL_12 - IRPSCUM)) * 0 
                                      )
        + (1-positif(20-V_NOTRAIT)) * (
                          positif(SEUIL_8 - RECUM) * positif(SEUIL_12 - IRPSCUM) * (
                                                                                              positif(SEUIL_12 - abs(TOTIRPSANT))* max(0,TOTIRPSANT - (IRPSCUM-RECUM))
                                                                                            + (1-positif(SEUIL_12 - abs(TOTIRPSANT))) * RECUM
                                                                                   )
                   + (1-positif(SEUIL_8 - RECUM) * positif(SEUIL_12 - IRPSCUM)) * (
                                                                                           positif(positif(SEUIL_12-VARNON) * positif(VARNON)
                                                                                                  + positif(SEUIL_8-abs(VARNON)) * (1-positif(VARNON)))
                                                                                                      * max(0,TOTIRPSANT - (IRPSCUM-RECUM))
                                                                                       +(1-positif(positif(SEUIL_12-VARNON) * positif(VARNON)
                                                                                                 + positif(SEUIL_8-abs(VARNON)) * (1-positif(VARNON))))
                                                                                                      * 0
                                                                                  )
                                     );


regle 221390:
application : batch , iliad ;


TOTREC = positif_ou_nul(IRN + TAXANET + PIR + PCAPNET + TAXLOYNET + HAUTREVNET - SEUIL_12) ;

regle 221400:
application : batch , iliad ;

CSREC = positif(NAPCRP) * positif_ou_nul(NAPCRPAVIM - SEUIL_61);

CSRECINR = positif(NAPCRINR) ;

regle 221410:
application : batch , iliad ;

RSEREC = positif(max(0 , NAPRSE1 + NAPRSE2 + NAPRSE3 + NAPRSE4 + NAPRSE5 + NAPRSE6)
                 * positif_ou_nul(NAPCRP- SEUIL_12)) ;

regle 221420:
application : batch , iliad ;

CSRECA = positif_ou_nul(PRS_A + PPRS_A + CSG_A + RDS_A + PCSG_A + PRDS_A
                       + CVN_A+PCVN_A + CDIS_A +PCDIS_A+ CGLOA_A +PGLOA_A
                       + RSE1BASE_A + PRSE1_A + RSE2BASE_A + PRSE2_A 
                       + RSE3BASE_A + PRSE3_A + RSE4BASE_A + PRSE4_A
                       + RSE5BASE_A + PRSE5_A + RSE6BASE_A + PRSE6_A 
                       + IRNIN_A + PIR_A + TAXABASE_A + PTAXA_A + CHRBASE_A + PCHR_A 
                       + PCAPBASE_A + PPCAP_A + LOYBASE_A + PLOY_A - SEUIL_12) ;

regle isf 221430:
application : iliad ;

ISFDEGR = max(0,(ANTISFAFF  - ISF4BIS * positif_ou_nul (ISF4BIS - SEUIL_12)) 
	   * (1-positif_ou_nul (ISF4BIS - SEUIL_12))
          + (ANTISFAFF  - ISFNET * positif_ou_nul (ISFNET - SEUIL_12))
	   * positif_ou_nul(ISF4BIS - SEUIL_12)) ;


ISFDEG = ISFDEGR * positif_ou_nul(ISFDEGR - SEUIL_8) ;

regle corrective 221440:
application : iliad ;

IDEGR = max(0,max(0,TOTIRPSANT) - max(0,NAPTEMPCX));

IRDEG = positif(NAPTOTAIR - IRNET) * positif(NAPTOTAIR) * max(0 , V_ANTIR - max(0,IRNET))
	* positif_ou_nul(IDEGR - SEUIL_8) ;                   

TAXDEG = positif(NAPTOTAIR - TAXANET) * positif(NAPTOTAIR) * max(0 , V_TAXANT - max(0,TAXANET)) ;                    

TAXADEG = positif(TAXDEG) * positif(V_TAXANT) * max(0 , V_TAXANT - max(0,TOTAXAGA))
          * positif_ou_nul(IDEGR - SEUIL_8) ;

PCAPTAXDEG = positif(NAPTOTAIR - PCAPNET) * positif(NAPTOTAIR) * max(0 , V_PCAPANT- max(0,PCAPNET)) ;

PCAPDEG = positif(PCAPTAXDEG) * positif (V_PCAPANT) * max(0 , V_PCAPANT - max(0,PCAPTOT)) 
          * positif_ou_nul(IDEGR - SEUIL_8) ;

TAXLOYERDEG = positif(NAPTOTAIR - TAXLOYNET) * positif(NAPTOTAIR) * max(0 , V_TAXLOYANT- max(0,TAXLOYNET)) ;

TAXLOYDEG = positif(TAXLOYERDEG) * positif (V_TAXLOYANT) * max(0 , V_TAXLOYANT - max(0,TAXLOYTOT)) 
          * positif_ou_nul(IDEGR - SEUIL_8) ;

HAUTREVTAXDEG =  positif(NAPTOTAIR - HAUTREVNET) * positif(NAPTOTAIR) * max(0 , V_CHRANT - max(0,HAUTREVNET)) ;

HAUTREVDEG = positif(HAUTREVTAXDEG) * positif(V_CHRANT) * max(0 , V_CHRANT - max(0,HAUTREVTOT)) 
             * positif_ou_nul(IDEGR - SEUIL_8) ;

regle 221450:
application : batch , iliad ;


ABSRE = ABMAR + ABVIE ;

regle 221460:
application : batch , iliad ;


RPEN = PTOTD * positif(APPLI_ILIAD + APPLI_COLBERT) ;

regle isf 221470:
application : iliad ;

ANTISFAFF = V_ANTISF * (1-positif(APPLI_OCEANS));    

regle 221480:
application : iliad ;

ANTIRAFF = V_ANTIR  * APPLI_ILIAD   
            + IRNET_A * APPLI_OCEANS
	    + 0 ;

TAXANTAFF = V_TAXANT * APPLI_ILIAD * (1- APPLI_OCEANS)
            + TAXANET_A * APPLI_OCEANS
	    + 0 ;

PCAPANTAFF = V_PCAPANT * APPLI_ILIAD * (1- APPLI_OCEANS)
            + PCAPNET_A * APPLI_OCEANS
	    + 0 ;
TAXLOYANTAFF = V_TAXLOYANT * APPLI_ILIAD * (1- APPLI_OCEANS)
            + TAXLOYNET_A * APPLI_OCEANS
	    + 0 ;

HAUTREVANTAF = V_CHRANT * APPLI_ILIAD * (1- APPLI_OCEANS)
            + CHRNET_A * APPLI_OCEANS
	    + 0 ;
regle 221490:
application : iliad , batch ;


IDRT = IDOM11 ;

regle 221500:
application : iliad , batch ;


IAVT = IRE - EPAV - CICA + 
          min( IRB , IPSOUR + CRCFA ) +
          min( max(0,IAN - IRE) , (BCIGA * (1 - positif(RE168+TAX1649))));

IAVT2 = IAVT + CICA ;

regle 221510:
application : iliad , batch ;

INDTXMOY = positif(TX_MIN_MET - TMOY) * positif( (present(RMOND) 
                             + present(DMOND)) ) * V_CNR ;

INDTXMIN = positif_ou_nul( IMI - IPQ1 ) 
           * positif(1 - INDTXMOY) * V_CNR ;

regle 221520:
application : batch , iliad ;

IND_REST = positif(IRESTIT) ;

regle 221530:
application : iliad , batch ;

IND_NI =  null(NAPT) * (null (IRNET)) ;

regle 221540:
application : iliad , batch ;

IND_IMP = positif(NAPT) ;

INDNMR =  null(NAPT) * null(NAT1BIS) * (positif (IRNET + TAXANET + PCAPNET + TAXLOYNET + HAUTREVNET )) ;



IND61IR =  (positif_ou_nul(IAMD1 - SEUIL_61)* 2
            + (1-positif_ou_nul(IAMD1 - SEUIL_61))*positif(IAMD1) * 1) * (1 - positif(INDTXMIN))
        +  (positif_ou_nul(IAMD1 - SEUIL_TXMIN)* 2
            + (1-positif_ou_nul(IAMD1 - SEUIL_TXMIN))*positif(IAMD1) * 1) * positif(INDTXMIN)  
        + null(IAMD1) * 3;

IND61PS =  (positif_ou_nul((TOTCR - CSGIM - CRDSIM - PRSPROV - CDISPROV -COD8YL-CSPROVYD-CSPROVYE-CSPROVYF- CSPROVYN-CSPROVYG-CSPROVYH-CSPROVYP-COD8YT) - SEUIL_61) * 2)
	+ ((1-positif_ou_nul((TOTCR - CSGIM - CRDSIM - PRSPROV - CDISPROV -COD8YL-CSPROVYD-CSPROVYE-CSPROVYF- CSPROVYN-CSPROVYG-CSPROVYH-CSPROVYP-COD8YT) - SEUIL_61))*positif(TOTCR) * 1)
	+ (null(TOTCR) * 3) ;

regle 221550:
application : iliad , batch ;

INDCEX = null(1 - NATIMP) * 1
         + positif(null(11 - NATIMP) + null(21 - NATIMP) + null(81 - NATIMP) + null(91 - NATIMP)) * 2
         + null(0 - NATIMP) * 3 ;

INDNMRI = INDNMR * positif(RED) ;

INDNIRI = positif(IDOM11 - DEC11) * null(IAD11) ;
INDRFR = positif_ou_nul(REVKIRE - LIMRFR);

regle 221560:
application : batch , iliad ;

IND_REST50 = positif(SEUIL_8 - IREST) * positif(IREST) * (1-positif(APPLI_OCEANS));
IND08 = positif(NAPT*(-1)) * (positif(SEUIL_8 - abs(NAPT)) * 1 
                          + (1-positif(SEUIL_8 - abs(NAPT))) * 2 );

regle 221570:
application : iliad , batch ;


INDMAJREV = positif(
 positif(BIHNOV)
+ positif(BIHNOC)
+ positif(BIHNOP)
+ positif(BICHREV)
+ positif(BICHREC)
+ positif(BICHREP)
+ positif(BNHREV)
+ positif(BNHREC)
+ positif(BNHREP)
+ positif(ANOCEP)
+ positif(ANOVEP)
+ positif(ANOPEP)
+ positif(BAFV)
+ positif(BAFC)
+ positif(BAFP)
+ positif(BAHREV)
+ positif(BAHREC)
+ positif(BAHREP)
+ positif(4BAHREV)
+ positif(4BAHREC)
+ positif(4BAHREP)
+ positif(REGPRIV)
);

regle 221580:
application : iliad , batch ;


INDNMR1 = (1 - positif(IAMD1 + 1 - SEUIL_61)) 
	   * null(NAPT) * positif(IAMD1) ;

INDNMR2 = positif(INDNMR) * (1 - positif(INDNMR1)) ;
IND12 = (positif(SEUIL_12 - (NAPCR +IRNET+TAXANET+TAXLOYNET+PCAPNET+HAUTREVNET-IRESTITIR))*
			   positif(NAPCR +IRNET+TAXANET+TAXLOYNET+PCAPNET+HAUTREVNET-IRESTITIR)* 1 )
	+ ((1 - positif(SEUIL_12 - (NAPCR +IRNET+TAXANET+TAXLOYNET+PCAPNET+HAUTREVNET-IRESTITIR))) * 2 )
	+ (null(NAPCR +IRNET+TAXANET+TAXLOYNET+PCAPNET+HAUTREVNET-IRESTITIR) * 3);

regle 221590:
application : batch , iliad ;


INDV = positif_ou_nul ( 
  positif( ALLOV ) 
 + positif( REMPLAV ) + positif( REMPLANBV )
 + positif( BACDEV ) + positif( BACREV )
 + positif( 4BACREV ) + positif( 4BAHREV )
 + positif( BAFPVV )
 + positif( BAFV ) + positif(BAHDEV) + positif( BAHREV )
 + positif (BICDEV) + positif (BICDNV) + positif (BICHDEV)
 + positif( BICHREV ) + positif( BICNOV ) + positif( BICREV ) 
 + positif (BIHDNV) + positif( BIHNOV )
 + positif (BNCAADV) + positif( BNCAABV ) 
 + positif (BNCDEV) + positif( BNCNPPVV )
 + positif( BNCNPV ) + positif( BNCPROPVV ) + positif( BNCPROV )
 + positif( BNCREV ) + positif(BNHDEV) + positif( BNHREV )
 + positif( BPCOSAV ) + positif( CARPENBAV ) + positif( CARPEV )
 + positif( CARTSNBAV ) + positif( CARTSV ) + positif( COTFV )
 + positif( DETSV ) + positif( FRNV ) + positif( GLD1V )
 + positif( GLDGRATV )
 + positif( GLD2V ) + positif( GLD3V ) + positif( ANOCEP )
 + positif( MIBNPPRESV ) + positif( MIBNPPVV ) + positif( MIBNPVENV )
 + positif( MIBPRESV ) + positif( MIBPVV ) + positif( MIBVENV )
 + positif( PALIV ) + positif( PENSALV ) + positif( PENSALNBV ) 
 + positif( PEBFV ) + positif( PRBRV )
 + positif( TSHALLOV ) + positif( DNOCEP ) + positif(BAFORESTV)
 + positif( LOCPROCGAV ) + positif( LOCPROV ) + positif( LOCNPCGAV )
 + positif( LOCNPV ) + positif(LOCDEFNPCGAV) 
 + positif (LOCDEFNPV)
 + positif( MIBMEUV ) + positif( MIBGITEV ) + positif( BICPMVCTV )
 + positif( BNCPMVCTV ) + positif( LOCGITV )
 + positif( PENINV ) + positif( CODRAZ )
 + positif( CODDAJ ) + positif( CODEAJ )
);
INDC = positif_ou_nul ( 
  positif( ALLOC ) 
 + positif( REMPLAC ) + positif( REMPLANBC )
 + positif( BACDEC) + positif( BACREC )
 + positif( 4BACREC ) + positif( 4BAHREC )
 + positif( BAFC ) + positif( ANOVEP ) + positif( DNOCEPC )
 + positif( BAFPVC ) + positif(BAHDEC) + positif( BAHREC )
 + positif( BICDEC) + positif( BICDNC) + positif( BICHDEC) 
 + positif( BICHREC ) + positif( BICNOC ) + positif( BICREC )  
 + positif( BIHDNC) + positif( BIHNOC )
 + positif( BNCAADC) + positif( BNCAABC ) 
 + positif( BNCDEC) + positif( BNCNPC )
 + positif( BNCNPPVC ) + positif( BNCPROC ) + positif( BNCPROPVC )
 + positif( BNCREC ) + positif(BNHDEC) + positif( BNHREC )
 + positif( BPCOSAC ) + positif( CARPEC ) + positif( CARPENBAC )
 + positif( CARTSC ) + positif( CARTSNBAC ) + positif( COTFC )
 + positif( DETSC ) + positif( FRNC ) + positif( GLD1C )
 + positif( GLD2C ) + positif( GLD3C )
 + positif( GLDGRATC )
 + positif( MIBNPPRESC ) + positif( MIBNPPVC ) + positif( MIBNPVENC )
 + positif( MIBPRESC ) + positif( MIBPVC ) + positif( MIBVENC )
 + positif( PALIC ) + positif( PENSALC ) + positif( PENSALNBC )
 + positif( PEBFC ) 
 + positif( PRBRC ) + positif( TSHALLOC ) + positif(BAFORESTC)
 + positif( LOCPROCGAC ) + positif( LOCPROC ) + positif( LOCNPCGAC )
 + positif( LOCNPC ) + positif(LOCDEFNPCGAC) 
 + positif( LOCDEFNPC)
 + positif( MIBMEUC ) + positif( MIBGITEC ) + positif( BICPMVCTC )
 + positif( BNCPMVCTC ) + positif( LOCGITC )
 + positif( PENINC ) + positif( CODRBZ )
 + positif( CODDBJ ) + positif( CODEBJ )
 );
INDP = positif_ou_nul (
  positif( ALLO1 ) + positif( ALLO2 ) + positif( ALLO3 ) + positif( ALLO4 ) 
 + positif( CARTSP1 ) + positif( CARTSP2 ) + positif( CARTSP3 ) + positif( CARTSP4 )
 + positif( CARTSNBAP1 ) + positif( CARTSNBAP2 ) + positif( CARTSNBAP3 ) + positif( CARTSNBAP4 )
 + positif( REMPLAP1 ) + positif( REMPLAP2 ) + positif( REMPLAP3 ) + positif( REMPLAP4 )
 + positif( REMPLANBP1 ) + positif( REMPLANBP2 ) + positif( REMPLANBP3 ) + positif( REMPLANBP4 )
 + positif( BACDEP) + positif( BACREP )
 + positif( 4BACREP ) + positif( 4BAHREP )
 + positif( BAFP ) + positif( ANOPEP ) + positif( DNOCEPP )
 + positif( BAFPVP ) + positif( BAHDEP) + positif( BAHREP )
 + positif( BICDEP) 
 + positif( BICDNP)
 + positif( BICHDEP) 
 + positif( BICHREP ) + positif( BICNOP )
 + positif( BICREP )  
 + positif( BIHDNP) + positif( BIHNOP )
 + positif( BNCAADP) + positif( BNCAABP ) 
 + positif( BNCDEP) + positif( BNCNPP )
 + positif( BNCNPPVP ) + positif( BNCPROP ) + positif( BNCPROPVP )
 + positif( BNCREP ) + positif( BNHDEP) + positif( BNHREP )
 + positif( COTF1 ) + positif( COTF2 ) + positif( COTF3 ) + positif( COTF4 ) 
 + positif( DETS1 ) + positif( DETS2 ) + positif( DETS3 ) + positif( DETS4 ) 
 + positif( FRN1 ) + positif( FRN2 ) + positif( FRN3 ) + positif( FRN4 )
 + positif( MIBNPPRESP ) + positif( MIBNPPVP ) + positif( MIBNPVENP )
 + positif( MIBPRESP ) + positif( MIBPVP ) + positif( MIBVENP )
 + positif( PALI1 ) + positif( PALI2 ) + positif( PALI3 ) + positif( PALI4 ) 
 + positif( PENSALP1 ) + positif( PENSALP2 ) + positif( PENSALP3 ) + positif( PENSALP4 )
 + positif( PENSALNBP1 ) + positif( PENSALNBP2 ) + positif( PENSALNBP3 ) + positif( PENSALNBP4 )
 + positif( PEBF1 ) + positif( PEBF2 ) + positif( PEBF3 ) + positif( PEBF4 ) 
 + positif( PRBR1 ) + positif( PRBR2 ) + positif( PRBR3 ) + positif( PRBR4 ) 
 + positif( CARPEP1 ) + positif( CARPEP2 ) + positif( CARPEP3 ) + positif( CARPEP4 )
 + positif( CARPENBAP1 ) + positif( CARPENBAP2 ) + positif( CARPENBAP3 ) + positif( CARPENBAP4 )
 + positif( TSHALLO1 ) + positif( TSHALLO2 ) + positif( TSHALLO3 ) + positif( TSHALLO4 ) 
 + positif( BAFORESTP )
 + positif( LOCPROCGAP ) + positif( LOCPROP ) + positif( LOCNPCGAPAC )
 + positif( LOCNPPAC ) + positif( LOCDEFNPCGAPAC)
 + positif( LOCDEFNPPAC)
 + positif( LOCDEFPROCGAP) 
 + positif( LOCDEFPROP)
 + positif( MIBMEUP ) + positif( MIBGITEP )  + positif( BICPMVCTP )
 + positif( BNCPMVCTP ) + positif( LOCGITP )
 + positif( PENIN1 ) + positif( PENIN2 ) + positif( PENIN3 ) + positif( PENIN4 )
 + positif( CODRCZ ) + positif( CODRDZ ) + positif( CODREZ ) + positif( CODRFZ )
 );

regle 221600:
application : iliad , batch ;



INDREV1A8IR = positif (
  positif( 4BACREC )
 + positif( 4BACREP ) + positif( 4BACREV ) + positif( 4BAHREC )
 + positif( 4BAHREP ) + positif( 4BAHREV ) 
 + positif( ABDETPLUS ) 
 + positif( ALLO1 ) + positif( ALLO2 ) + positif( ALLO3 ) + positif( ALLO4 )
 + positif( ALLOC ) + positif( ALLOV ) + positif( ANOCEP )
 + positif( ANOPEP ) + positif( ANOVEP ) 
 + positif( AUTOBICPC )
 + positif( AUTOBICPP ) + positif( AUTOBICPV ) + positif( AUTOBICVC )
 + positif( AUTOBICVP ) + positif( AUTOBICVV ) + positif( AUTOBNCC )
 + positif( AUTOBNCP ) + positif( AUTOBNCV ) + positif( BA1AC )
 + positif( BA1AP ) + positif( BA1AV ) + positif( BACDEC)
 + positif( BACDEP) 
 + positif( BACDEV) 
 + positif( BACREC )
 + positif( BACREP ) + positif( BACREV ) + positif( BAEXC )
 + positif( BAEXP ) + positif( BAEXV ) + positif( BAF1AC )
 + positif( BAF1AP ) + positif( BAF1AV ) + positif( BAFC )
 + positif( BAFORESTC ) + positif( BAFORESTP ) + positif( BAFORESTV )
 + positif( BAFP ) + positif( BAFPVC ) + positif( BAFPVP )
 + positif( BAFPVV ) + positif( BAFV ) + positif(BAHDEC)
 + positif( BAHDEP) 
 + positif( BAHDEV) + positif( BAHEXC )
 + positif( BAHEXP ) + positif( BAHEXV ) + positif( BAHREC )
 + positif( BAHREP ) + positif( BAHREV ) + positif( BAILOC98 )
 + positif( BAPERPC ) + positif( BAPERPP ) + positif( BAPERPV )
 + positif( BI1AC ) + positif( BI1AP ) + positif( BI1AV )
 + positif( BI2AC ) + positif( BI2AP ) + positif( BI2AV )
 + positif( BICDEC ) + positif( BICDEP ) + positif( BICDEV )
 + positif( BICDNC ) + positif( BICDNP ) + positif( BICDNV )
 + positif( BICEXC ) + positif( BICEXP ) + positif( BICEXV )
 + positif( BICHDEC ) + positif( BICHDEP ) + positif( BICHDEV ) 
 + positif( BICHREC ) + positif( BICHREP ) 
 + positif( BICHREV )
 + positif( BICNOC ) + positif( BICNOP ) + positif( BICNOV )
 + positif( BICNPEXC ) + positif( BICNPEXP ) + positif( BICNPEXV )
 + positif( BICNPHEXC ) + positif( BICNPHEXP ) + positif( BICNPHEXV )
 + positif( BICREC ) + positif( BICREP ) 
 + positif( BICREV )
 + positif( BIHDNC)
 + positif( BIHDNP) 
 + positif( BIHDNV)
 + positif( BIHEXC ) + positif( BIHEXP ) + positif( BIHEXV )
 + positif( BIHNOC ) + positif( BIHNOP ) + positif( BIHNOV )
 + positif( BIPERPC ) + positif( BIPERPP ) + positif( BIPERPV )
 + positif( BN1AC ) + positif( BN1AP ) + positif( BN1AV )
 + positif( BNCAABC ) + positif( BNCAABP ) + positif( BNCAABV )
 + positif( BNCAADC) 
 + positif( BNCAADP) 
 + positif( BNCAADV)
 + positif( BNCCRC ) + positif( BNCCRFC ) + positif( BNCCRFP )
 + positif( BNCCRFV ) + positif( BNCCRP ) + positif( BNCCRV )
 + positif( BNCDEC)
 + positif( BNCDEP) 
 + positif( BNCDEV)
 + positif( BNCEXC ) + positif( BNCEXP ) + positif( BNCEXV )
 + positif( BNCNP1AC ) + positif( BNCNP1AP ) + positif( BNCNP1AV )
 + positif( BNCNPC ) + positif( BNCNPDCT ) + positif( BNCNPDEC )
 + positif( BNCNPDEP ) + positif( BNCNPDEV ) + positif( BNCNPP )
 + positif( BNCNPPVC ) + positif( BNCNPPVP ) + positif( BNCNPPVV )
 + positif( BNCNPREXAAC ) + positif( BNCNPREXAAP ) + positif( BNCNPREXAAV )
 + positif( BNCNPREXC ) + positif( BNCNPREXP ) + positif( BNCNPREXV )
 + positif( BNCNPV ) + positif( BNCPRO1AC ) + positif( BNCPRO1AP )
 + positif( BNCPRO1AV ) + positif( BNCPROC ) 
 + positif( BNCPMVCTV ) + positif( BNCPMVCTC ) + positif( BNCPMVCTP )
 + positif( BNCPRODEC ) + positif( BNCPRODEP ) + positif( BNCPRODEV )
 + positif( BNCPROEXC ) + positif( BNCPROEXP ) + positif( BNCPROEXV )
 + positif( BNCPROP ) + positif( BNCPROPVC ) + positif( BNCPROPVP )
 + positif( BNCPROPVV ) + positif( BNCPROV ) + positif( BNCREC )
 + positif( BNCREP ) + positif( BNCREV ) 
 + positif( BNHDEC)
 + positif( BNHDEP) 
 + positif( BNHDEV) 
 + positif( BNHEXC )
 + positif( BNHEXP ) + positif( BNHEXV ) + positif( BNHREC )
 + positif( BNHREP ) + positif( BNHREV ) + positif( BPCOPTV )
 + positif( BPCOSAC ) + positif( BPCOSAV ) 
 + positif( BPV18V ) + positif( BPV40V )
 + positif( BPVRCM ) + positif( CARPEC ) + positif( CARPENBAC )
 + positif( CARPENBAV ) + positif( CARPEV ) + positif( CARPEP1 ) 
 + positif( CARPEP2 ) + positif( CARPEP3 ) + positif( CARPEP4 )
 + positif( CARPENBAP1 ) + positif( CARPENBAP2 ) + positif( CARPENBAP3 )
 + positif( CARPENBAP4 )
 + positif( CARTSC ) + positif( CARTSNBAC ) + positif( CARTSNBAV ) 
 + positif( CARTSV ) + positif( CARTSP1 ) + positif( CARTSP2 ) 
 + positif( CARTSP3 ) + positif( CARTSP4 ) + positif( CARTSNBAP1 )
 + positif( CARTSNBAP2 ) + positif( CARTSNBAP3 ) + positif( CARTSNBAP4 )
 + positif( REMPLAV ) + positif( REMPLAC ) + positif( REMPLAP1 )
 + positif( REMPLAP2 ) + positif( REMPLAP3 ) + positif( REMPLAP4 )
 + positif( REMPLANBV ) + positif( REMPLANBC ) + positif( REMPLANBP1 )
 + positif( REMPLANBP2 ) + positif( REMPLANBP3 ) + positif( REMPLANBP4 )
 + positif( PENSALV ) + positif( PENSALC ) + positif( PENSALP1 )
 + positif( PENSALP2 ) + positif( PENSALP3 ) + positif( PENSALP4 )
 + positif( PENSALNBV ) + positif( PENSALNBC ) + positif( PENSALNBP1 )
 + positif( PENSALNBP2 ) + positif( PENSALNBP3 ) + positif( PENSALNBP4 )
 + positif( RENTAX ) + positif( RENTAX5 ) + positif( RENTAX6 ) + positif( RENTAX7 ) 
 + positif( RENTAXNB ) + positif( RENTAXNB5 ) + positif( RENTAXNB6 ) + positif( RENTAXNB7 ) 
 + positif( REVACT ) + positif( REVPEA ) + positif( PROVIE ) + positif( DISQUO )
 + positif( RESTUC ) + positif( INTERE ) + positif( REVACTNB ) + positif( REVPEANB )
 + positif( PROVIENB ) + positif( DISQUONB ) + positif( RESTUCNB ) + positif( INTERENB )
 + positif( CESSASSC ) + positif( CESSASSV ) + positif( COTF1 )
 + positif( COTF2 ) + positif( COTF3 ) + positif( COTF4 )
 + positif( COTFC ) + positif( COTFV ) 
 + positif( DABNCNP1 ) + positif( DABNCNP2 ) + positif( DABNCNP3 )
 + positif( DABNCNP4 ) + positif( DABNCNP5 ) + positif( DABNCNP6 )
 + positif( DAGRI1 ) + positif( DAGRI2 ) + positif( DAGRI3 )
 + positif( DAGRI4 ) + positif( DAGRI5 ) + positif( DAGRI6 )
 + positif( DEFBIC1 ) + positif( DEFBIC2 ) + positif( DEFBIC3 ) 
 + positif( DEFBIC4 ) + positif( DEFBIC5 ) + positif( DEFBIC6 ) 
 + positif( DETS1 ) + positif( DETS2 )
 + positif( DETS3 ) + positif( DETS4 ) + positif( DETSC )
 + positif( DETSV ) + positif( DIREPARGNE ) + positif( DNOCEP )
 + positif( DNOCEPC ) + positif( DNOCEPP ) + positif( DPVRCM )
 + positif( FEXC ) + positif( FEXP ) + positif( FEXV )
 + positif( FRN1 ) + positif( FRN2 ) + positif( FRN3 )
 + positif( FRN4 ) + positif( FRNC ) + positif( FRNV )
 + positif( GAINABDET ) 
 + positif( GLDGRATV ) + positif( GLDGRATC)
 + positif( GLD1C ) + positif( GLD1V )
 + positif( GLD2C ) + positif( GLD2V ) + positif( GLD3C )
 + positif( GLD3V ) 
 + positif (LOCDEFNPC) + positif( LOCDEFNPCGAC) + positif( LOCDEFNPCGAPAC) 
 + positif( LOCDEFNPCGAV) + positif( LOCDEFNPPAC) + positif( LOCDEFNPV) 
 + positif( LOCDEFPROC) 
 + positif( LOCDEFPROCGAC)
 + positif( LOCDEFPROCGAP) 
 + positif( LOCDEFPROCGAV) 
 + positif( LOCDEFPROP)
 + positif( LOCDEFPROV) 
 + positif( LOCNPC ) + positif( LOCNPCGAC )
 + positif( LOCNPCGAPAC ) + positif( LOCNPCGAV ) + positif( LOCNPPAC )
 + positif( LOCNPV ) + positif( LOCPROC ) + positif( LOCPROCGAC )
 + positif( LOCPROCGAP ) + positif( LOCPROCGAV ) + positif( LOCPROP )
 + positif( LOCPROV ) + positif( LOYIMP ) + positif( MIB1AC )
 + positif( MIB1AP ) + positif( MIB1AV ) 
 + positif( BICPMVCTV )+ positif( BICPMVCTC )+ positif( BICPMVCTP )
 + positif( MIBDEC ) + positif( MIBDEP ) + positif( MIBDEV )
 + positif( MIBEXC ) + positif( MIBEXP ) + positif( MIBEXV )
 + positif( MIBNP1AC ) + positif( MIBNP1AP ) + positif( MIBNP1AV )
 + positif( MIBNPDCT ) + positif( MIBNPDEC ) + positif( MIBNPDEP )
 + positif( MIBNPDEV ) + positif( MIBNPEXC ) + positif( MIBNPEXP )
 + positif( MIBNPEXV ) + positif( MIBNPPRESC ) + positif( MIBNPPRESP )
 + positif( MIBNPPRESV ) + positif( MIBNPPVC ) + positif( MIBNPPVP )
 + positif( MIBNPPVV ) + positif( MIBNPVENC ) + positif( MIBNPVENP )
 + positif( MIBNPVENV ) + positif( MIBPRESC ) + positif( MIBPRESP )
 + positif( MIBPRESV ) + positif( MIBPVC ) + positif( MIBPVP )
 + positif( MIBPVV ) + positif( MIBVENC ) + positif( MIBVENP )
 + positif( MIBVENV ) + positif( PALI1 ) + positif( PALI2 )
 + positif( PALI3 ) + positif( PALI4 ) + positif( PALIC )
 + positif( PALIV ) + positif( PEA ) + positif( PEBF1 )
 + positif( PEBF2 ) + positif( PEBF3 ) + positif( PEBF4 )
 + positif( PEBFC ) + positif( PEBFV ) 
 + positif( PPEACC ) + positif( PPEACP ) + positif( PPEACV ) + positif( PPENHC )
 + positif( PPENHP1 ) + positif( PPENHP2 ) + positif( PPENHP3 )
 + positif( PPENHP4 ) + positif( PPENHV ) + positif( PPENJC )
 + positif( PPENJP ) + positif( PPENJV ) + positif( PPETPC )
 + positif( PPETPP1 ) + positif( PPETPP2 ) + positif( PPETPP3 )
 + positif( PPETPP4 ) + positif( PPETPV )
 + positif( PPLIB )
 + positif( PRBR1 ) + positif( PRBR2 ) + positif( PRBR3 )
 + positif( PRBR4 ) + positif( PRBRC ) + positif( PRBRV )
 + positif( PVINCE ) + positif( PVINPE ) + positif( PVINVE )
 + positif( PVREP8 ) + positif( PVSOCC )
 + positif( PVSOCV ) + positif( RCMABD ) 
 + positif( RCMAV ) + positif( RCMAVFT ) + positif( RCMFR )
 + positif( RCMHAB ) + positif( RCMHAD ) + positif( RCMLIB )
 + positif( RCMRDS ) + positif( RCMSOC )
 + positif( RCMTNC ) + positif( RCSC ) + positif( RCSP )
 + positif( RCSV ) + positif( REGPRIV ) + positif(RFDANT)
 + positif( RFDHIS) 
 + positif( RFDORD) + positif( RFMIC )
 + positif( RFORDI ) + positif( RFROBOR ) + positif( RVB1 )
 + positif( RVB2 ) + positif( RVB3 ) + positif( RVB4 )
 + positif( TSASSUC ) + positif( TSASSUV ) 
 + positif( TSHALLO1 ) + positif( TSHALLO2 )
 + positif( TSHALLO3 ) + positif( TSHALLO4 ) + positif( TSHALLOC )
 + positif( TSHALLOV ) + positif( XETRANC ) + positif( XETRANV )
 + positif( XHONOAAC ) + positif( XHONOAAP ) + positif( XHONOAAV )
 + positif( XHONOC ) + positif( XHONOP ) + positif( XHONOV )
 + positif( XSPENPC ) + positif( XSPENPP ) + positif( XSPENPV )
 + positif( GSALV ) + positif( GSALC ) 
 + positif( LNPRODEF1) + positif( LNPRODEF2) + positif( LNPRODEF3) + positif( LNPRODEF4) + positif( LNPRODEF5) 
 + positif( LNPRODEF6) + positif( LNPRODEF7) + positif( LNPRODEF8) + positif( LNPRODEF9) + positif( LNPRODEF10) 
 + positif( FONCI ) + positif( REAMOR ) + positif( FONCINB ) + positif( REAMORNB )
 + positif( MIBMEUV ) + positif( MIBMEUC ) + positif( MIBMEUP )
 + positif( MIBGITEV ) + positif( MIBGITEC ) + positif( MIBGITEP )
 + positif( PCAPTAXV ) + positif( PCAPTAXC )
 + positif( PVIMMO ) + positif( PVSURSI ) + positif( PVIMPOS )
 + positif( BANOCGAV ) + positif( BANOCGAC ) + positif( BANOCGAP )
 + positif( INVENTV ) + positif( INVENTC ) + positif( INVENTP )
 + positif( LOCGITV ) + positif( LOCGITC ) + positif( LOCGITP )
 + positif( LOCGITCV ) + positif( LOCGITCC ) + positif( LOCGITCP )
 + positif( LOCGITHCV ) + positif( LOCGITHCC ) + positif( LOCGITHCP )
 + positif( PVTAXSB ) 
 + positif( PVMOBNR ) 
 + positif( BPVSJ ) + positif( BPVSK )
 + positif( CVNSALAV ) + positif( GAINPEA ) 
 + positif( PVEXOSEC ) + positif( ABPVNOSURSIS )
 + positif( PVREPORT )
 + positif( LOYELEV )
 + positif(SALEXTV) + positif(SALEXTC) + positif(SALEXT1) 
 + positif(SALEXT2) + positif(SALEXT3) + positif(SALEXT4)
 + positif(CODDAJ) + positif(CODEAJ) + positif(CODDBJ) + positif(CODEBJ) 
 + positif( COD1AE ) + positif( COD1BE ) + positif( COD1CE )
 + positif( COD1DE ) + positif( COD1EE ) + positif( COD1FE )
 + positif( PPEXTV ) + positif( PPEXTC ) + positif( PPEXT1 )
 + positif( PPEXT2 ) + positif( PPEXT3 ) + positif( PPEXT4 )
 + positif( COD1AH ) + positif( COD1BH ) + positif( COD1CH )
 + positif( COD1DH ) + positif( COD1EH ) + positif( COD1FH )
 + positif( COD1TZ ) + positif( PVTITRESOC )
 + positif( COD2CK ) + positif( COD2FA )
 + positif( COD3SL ) + positif( COD3VE ) 
 + positif( PENIN1 ) + positif( PENIN2 ) + positif( PENIN3 )
 + positif( PENIN4 ) + positif( PENINC ) + positif( PENINV )
 + positif( CODNAZ ) + positif( CODNBZ ) + positif( CODNCZ )
 + positif( CODNDZ ) + positif( CODNEZ ) + positif( CODNFZ )
 + positif( CODRAZ ) + positif( CODRBZ ) + positif( CODRCZ )
 + positif( CODRDZ ) + positif( CODREZ ) + positif( CODRFZ )
 + positif( COD3UA ) + positif( COD3UL ) + positif( COD3UV ) + positif( COD3WM )
 + positif( CODNVG ) + positif( CODRVG )
 + positif( COD3SC ) + positif( COD3UB ) + positif( COD3VB ) + positif( COD3SG )
 + positif( COD5XT ) + positif( COD5XU ) + positif( COD5XV ) + positif( COD5XW ) 

 + present( ANNUL2042 )
 + present( ASCAPA ) + present( AUTOVERSLIB ) 
 + present( BRAS ) + present( BULLRET ) + present( CASEPRETUD )
 + present( CELLIERHK ) + present( CELLIERHJ ) + present( CELLIERHL )
 + present( CELLIERHM ) + present( CELLIERHN ) + present( CELLIERHO )
 + present( CELLIERNA ) + present( CELLIERNB ) + present( CELLIERNC )
 + present( CELLIERND ) + present( CELLIERNE ) + present( CELLIERNF )
 + present( CELLIERNG ) + present( CELLIERNH ) + present( CELLIERNI )
 + present( CELLIERNJ ) + present( CELLIERNK ) + present( CELLIERNL )
 + present( CELLIERNM ) + present( CELLIERNN ) + present( CELLIERNO )
 + present( CELLIERNP ) + present( CELLIERNQ ) + present( CELLIERNR )
 + present( CELLIERNS ) + present( CELLIERNT ) 
 + present( CELLIERJA ) + present( CELLIERJB ) + present( CELLIERJD )
 + present( CELLIERJE ) + present( CELLIERJF ) + present( CELLIERJG )
 + present( CELLIERJH ) + present( CELLIERJJ ) + present( CELLIERJK )
 + present( CELLIERJL ) + present( CELLIERJM ) + present( CELLIERJN )
 + present( CELLIERJO ) + present( CELLIERJP ) + present( CELLIERJQ ) + present( CELLIERJR )
 + present( CELLIERFA ) + present( CELLIERFB ) + present( CELLIERFC ) + present( CELLIERFD )
 + present( DUFLOGH ) + present( DUFLOGI ) + present( DUFLOFI ) + present( DUFLOGH ) 
 + present( DUFLOGI ) + present( DUFLOEK ) + present( DUFLOEL ) + present( DUFLOFK )
 + present( PINELQA ) + present( PINELQB ) + present( PINELQC ) + present( PINELQD )
 + present( PINELAI ) + present( PINELBI ) + present( PINELCI ) + present( PINELDI )
 + present( PINELQE ) + present( PINELQF ) + present( PINELQG ) + present( PINELQH )
 + present( CELREPGJ ) + present( CELREPGL ) + present( CELREPGS ) + present( CELREPGU ) 
 + present( CELREPGV ) + present( CELREPGW ) + present( CELREPGX ) + present( CELREPHR ) 
 + present( CELREPHS ) + present( CELREPHT ) + present( CELREPHU ) + present( CELREPHV )
 + present( CELREPHW ) + present( CELREPHX ) + present( CELREPHZ ) + present( CELREPHA ) 
 + present( CELREPHD ) + present( CELREPHF ) + present( CELREPHG ) + present( CELREPHH )
 + present( CELREPYB ) + present( CELREPYD ) + present( CELREPYF ) + present( CELREPYH )
 + present( CELREPYJ ) + present( CELREPYK ) + present( CELREPYL ) + present( CELREPYM )
 + present( CELREPYN ) + present( CELREPYO ) + present( CELREPYP ) + present( CELREPYQ )
 + present( CELREPYR ) + present( CELREPYS )
 + present( CHENF1 ) + present( CHENF2 ) + present( CHENF3 ) + present( CHENF4 )
 + present( INVNPROF1 ) + present( VIEUMEUB ) + present( INVREPMEU )
 + present( INVREPNPRO ) + present( INVNPROREP ) + present( INVREDMEU )
 + present( REDREPNPRO ) + present( INVNPROF2  ) + present( RESIVIANT )
 + present( CHNFAC ) + present( CHRDED ) + present( CHRFAC )
 + present( CIAQCUL ) + present( CIBOIBAIL ) 
 + present( CIIMPPRO )
 + present( CIIMPPRO2 ) + present( CIINVCORSE ) + present( CINE1 )
 + present( CINE2 ) + present( CINRJBAIL ) + present( CIDEP15 )
 + present( CO35 ) + present( RISKTEC ) + present( CINRJ )
 + present( CRDSIM ) + present( CREAGRIBIO )
 + present( CREAIDE ) + present( CREAPP ) + present( CREARTS )
 + present( CRECONGAGRI ) + present( CREDPVREP )
 + present( CREFAM ) + present( CREFORMCHENT ) 
 + present( CREINTERESSE ) + present( CREPROSP )
 + present( CRERESTAU ) + present( CRIGA ) + present( CRENRJ )
 + present( COD8YT ) + present( CDISPROV) + present( CSGIM ) + present (COD8YL)
 + present( DCSG ) + present( DCSGIM )
 + present( DEFAA0 ) + present( DEFAA1 ) + present( DEFAA2 )
 + present( DEFAA3 ) + present( DEFAA4 ) + present( DEFAA5 )
 + present( DMOND )
 + present( ELURASC ) + present( ELURASV ) + present( ESFP )
 + present( FCPI )
 + present( FFIP ) + present( FIPCORSE ) + present( FORET )
 + present( INAIDE ) 
 + present( INTDIFAGRI ) + present( INVDIR2009 )
 + present( INVDOMRET50 ) + present( INVDOMRET60 )
 + present( INVLGDEB2009 ) + present( INVLOCXN )
 + present( INVLOCXV ) + present( COD7UY ) + present( COD7UZ )
 + present( INVLOG2008 )
 + present( INVLOG2009 ) + present( INVLOGSOC ) + present( INVLGAUTRE ) 
 + present( INVLGDEB2010 ) + present( INVSOC2010 ) + present( INVRETRO1 )
 + present( INVRETRO2 ) + present( INVIMP )
 + present( INVLGDEB ) + present( INVENDEB2009 )
 + present( PATNAT1 ) + present( PATNAT2 ) + present( PATNAT3 )
 + present( PATNAT4 )
 + present( CELRREDLA ) + present( CELRREDLB ) + present( CELRREDLC ) + present( CELRREDLD ) 
 + present( CELRREDLE ) + present( CELRREDLF ) + present( CELRREDLM ) + present( CELRREDLS ) 
 + present( CELRREDLZ ) + present( CELRREDMG ) + present( CELRREDLN ) + present( CELRREDLX ) 
 + present( CELRREDLZ ) + present( CELRREDMH ) + present( CELRREDLG ) + present( CELRREDLH )
 + present( CELRREDLI ) + present( CELRREDLJ )
 + present( RETROCOMMB ) + present( RETROCOMMC )
 + present( RETROCOMLH ) + present( RETROCOMLI )
 + present( INVOMSOCQU ) + present( INVOMQV )
 + present( INVOMSOCKH ) + present( INVOMSOCKI ) 
 + present( INVOMSOCQJ ) + present( INVOMSOCQS )
 + present( INVOMSOCQW ) + present( INVOMSOCQX )
 + present( INVOMENTRG ) + present( INVOMENTRI )
 + present( INVOMENTRJ ) + present( INVOMENTRK ) + present( INVOMENTRL )
 + present( INVOMENTRM ) + present( INVOMENTRO )
 + present( INVOMENTRP ) + present( INVOMENTRQ ) + present( INVOMENTRR )
 + present( INVOMENTRT ) + present( INVOMENTRU )
 + present( INVOMENTRV ) + present( INVOMENTRW ) + present( INVOMENTRY )
 + present( INVOMENTKT ) + present( INVOMENTKU ) + present( INVOMENTMN )
 + present( INVOMENTNU ) + present( INVOMENTNV ) + present( INVOMENTNW )
 + present( INVOMENTNY )
 + present( INVOMRETPA ) + present( INVOMRETPB ) + present( INVOMRETPD ) 
 + present( INVOMRETPE ) + present( INVOMRETPF ) + present( INVOMRETPH ) 
 + present( INVOMRETPI ) + present( INVOMRETPJ ) + present( INVOMRETPL )
 + present( INVOMRETPM ) + present( INVOMRETPN ) + present( INVOMRETPO )
 + present( INVOMRETPP ) + present( INVOMRETPR )
 + present( INVOMRETPS ) + present( INVOMRETPT ) + present( INVOMRETPU )
 + present( INVOMRETPW ) + present( INVOMRETPX ) + present( INVOMRETPY )
 + present( INVOMLOGOA ) + present( INVOMLOGOB ) + present( INVOMLOGOC )
 + present( INVOMLOGOH ) + present( INVOMLOGOI ) + present( INVOMLOGOJ ) + present( INVOMLOGOK )
 + present( INVOMLOGOL ) + present( INVOMLOGOM ) + present( INVOMLOGON )
 + present( INVOMLOGOO ) + present( INVOMLOGOP ) + present( INVOMLOGOQ )
 + present( INVOMLOGOR ) + present( INVOMLOGOS ) + present( INVOMLOGOT )
 + present( INVOMLOGOU ) + present( INVOMLOGOV ) + present( INVOMLOGOW )
 + present( CODHOD ) + present( CODHOE ) + present( CODHOF ) + present( CODHOG )
 + present( CODHOX ) + present( CODHOY ) + present( CODHOZ )
 + present( CODHRA ) + present( CODHRB ) + present( CODHRC ) + present( CODHRD )
 + present( CODHSA ) + present( CODHSB ) + present( CODHSC ) + present( CODHSE )
 + present( CODHSF ) + present( CODHSG ) + present( CODHSH ) + present( CODHSJ )
 + present( CODHSK ) + present( CODHSL ) + present( CODHSM ) + present( CODHSO )
 + present( CODHSP ) + present( CODHSQ ) + present( CODHSR ) + present( CODHST )
 + present( CODHSU ) + present( CODHSV ) + present( CODHSW ) + present( CODHSY )
 + present( CODHSZ ) + present( CODHTA ) + present( CODHTB ) + present( CODHTD ) 
 + present( LOCMEUBIA ) + present( LOCMEUBIB ) + present( LOCMEUBIC )
 + present( LOCMEUBID ) + present( LOCMEUBIE ) + present( LOCMEUBIF )
 + present( LOCMEUBIG ) + present( LOCMEUBIH ) + present( LOCMEUBII )
 + present( LOCMEUBIX ) + present( LOCMEUBIY ) + present( LOCMEUBIZ )
 + present( LOCMEUBJC ) + present( LOCMEUBJI ) + present( LOCMEUBJS ) + present( LOCMEUBJT )
 + present( LOCMEUBJU ) + present( LOCMEUBJV ) + present( LOCMEUBJW ) + present( LOCMEUBJX ) + present( LOCMEUBJY )
 + present( IPBOCH ) + present( IPELUS ) + present( IPMOND ) + present( SALECS )
 + present( SALECSG ) + present( CICORSENOW ) + present( PRESINTER )
 + present( IPPNCS ) + present( IPPRICORSE ) + present( IPRECH ) + present( IPCHER )
 + present( IPREP ) + present( IPREPCORSE ) + present( IPSOUR )
 + present( IPSUIS ) + present( IPSUISC ) + present( IPSURSI )
 + present( IPSURV ) + present( IPTEFN ) + present( IPTEFP )
 + present( IPTXMO ) + present( IRANT )
 + present( LOCRESINEUV ) + present( REPMEUBLE ) + present( MEUBLENP ) 
 + present( RESIVIEU ) + present( REDMEUBLE ) + present( NBACT )
 + present( NCHENF1 ) + present( NCHENF2 ) + present( NCHENF3 )
 + present( NCHENF4 ) + present( NRBASE ) + present( NRINET ) 
 + present( IMPRET ) + present( BASRET )
 + present( NUPROP ) + present( REPGROREP1 ) + present( REPGROREP2) 
 + present( REPGROREP11 ) + present( REPGROREP12 )
 + present( REPGROREP13 ) + present( REPGROREP14 )
 + present( OPTPLAF15 ) + present( PAAP ) + present( PAAV ) 
 + present( PERPC ) + present( PERPP ) + present( PERPV )
 + present( PERP_COTC ) + present( PERP_COTP ) + present( PERP_COTV )
 + present( PLAF_PERPC ) + present( PLAF_PERPP ) + present( PLAF_PERPV ) 
 + present( PREHABT ) + present( PREHABTN1 ) + present( PREHABTN2 ) + present( PREHABTVT )
 + present( PREHABT2 ) + present( PREHABTN ) + present( PREMAIDE )
 + present( PRESCOMP2000 ) + present( PRESCOMPJUGE ) + present( PRETUD )
 + present( PRETUDANT ) + present( PRODOM ) + present( PROGUY )
 + present( PRSPROV ) + present( PTZDEVDUR ) + present( R1649 )
 + present( PTZDEVDURN ) + present( PREREV )
 + present( RCCURE ) + present( RDCOM ) + present( RDDOUP )
 + present( RDENL ) + present( RDENLQAR ) + present( RDENS )
 + present( RDENSQAR ) + present( RDENU ) + present( RDENUQAR )
 + present( RDEQPAHA ) + present( RDDOUP ) + present( RDFOREST )
 + present( RDFORESTGES ) + present( RDFORESTRA ) + present( RDREP ) + present( COTFORET )
 + present( REPFOR ) + present( REPFOR1 ) + present( REPFOR2 ) + present( REPFOR3 )
 + present( REPSINFOR ) + present( REPSINFOR1 ) + present( REPSINFOR2 ) 
 + present( REPSINFOR3 ) + present( REPSINFOR4 ) + present( REPSINFOR5 )
 + present( RDGARD1 ) + present( RDGARD1QAR ) + present( RDGARD2 )
 + present( RDGARD2QAR ) + present( RDGARD3 ) + present( RDGARD3QAR )
 + present( RDGARD4 ) + present( RDGARD4QAR ) + present( RDTECH )
 + present( RDMECENAT ) + present( RDPRESREPORT ) + present( RDREP )
 + present( RDRESU ) + present( RDSNO ) + present( RDSYCJ )
 + present( RDSYPP ) + present( RDSYVO ) + present( RE168 ) 
 + present( TAX1649 ) 
 + present( REGCI ) + present( REPDON03 ) + present( REPDON04 )
 + present( REPDON05 ) + present( REPDON06 ) + present( REPDON07 )
 + present( RINVLOCINV )
 + present( RINVLOCREA ) + present( REPSNO1 ) + present( REPSNO2 )
 + present( REPINVTOU ) + present( INVLOGREHA ) + present( INVLOGHOT )
 + present( REPSNO3 ) + present( REPSNON ) + present( REPSOF ) 
 + present( RESTIMOPPAU ) + present( RIMOPPAUANT ) + present( RIMOSAUVANT )
 + present( RESTIMOSAUV ) + present( RIMOPPAURE ) + present( RIMOSAUVRF ) 
 + present( COD7SY ) + present( COD7SX ) + present( COD7UH ) 
 + present( REVMAR1 ) + present( REVMAR2 )
 + present( REVMAR3 ) 
 + present( PETIPRISE )
 + present( RMOND ) + present( RSOCREPRISE )
 + present( RVAIDE ) + present( RVAIDAS ) + present( RVCURE ) + present( SINISFORET )
 + present( SUBSTITRENTE ) + present( FIPDOMCOM )
 + present( ALLECS ) + present( INDECS ) + present( PENECS )
 + present( DONETRAN ) + present( DONAUTRE )
 + present( MATISOSI ) + present( MATISOSJ ) + present( VOLISO )
 + present( PORENT ) + present( CHAUBOISN )
 + present( POMPESP ) + present( POMPESQ )
 + present( POMPESR ) + present( CHAUFSOL ) + present( ENERGIEST )
 + present( DIAGPERF ) + present( RESCHAL )
 + present( TRATOIVG )
 + present( TRAMURWC ) + present( TRAVITWT ) 
 + present( RFRN2 ) + present( RFRN3 ) + present( RFRH1 ) + present( RFRH2 )
 + present( COD8TL ) + present( COD8UW )
 + present( V_8ZT ) 
 + present( COD7CR ) + present( COD7CV ) + present( COD7CY ) + present( COD7OA ) + present( COD7OB ) 
 + present( COD7OC ) + present( COD7OD ) + present( COD7OE ) + present( COD7OU ) + present( COD7PA ) 
 + present( COD7PB ) + present( COD7PC ) + present( COD7PD ) + present( COD7PE ) + present( COD7RG ) 
 + present( COD7RH ) + present( COD7RI ) + present( COD7RJ ) + present( COD7RK ) + present( COD7RL ) 
 + present( COD7RN ) + present( COD7RP ) + present( COD7RQ ) + present( COD7RR ) + present( COD7RS ) 
 + present( COD7RT ) + present( COD7RV ) + present( COD7RW ) + present( COD7RZ ) + present( COD7SA ) 
 + present( COD7SB ) + present( COD7SC ) + present( COD7TV ) + present( COD7TW ) + present( COD7UA ) 
 + present( COD7UB ) + present( COD7UI ) + present( COD7VH ) + present( COD7WB ) + present( COD7WU ) 
 + present( COD7AA ) + present( COD7AD ) + present( COD7AF ) + present( COD7AH ) + present( COD7AK ) 
 + present( COD7AL ) + present( COD7AM ) + present( COD7AN ) + present( COD7AQ ) + present( COD7AR ) 
 + present( COD7AV ) + present( COD7AX ) + present( COD7AY ) + present( COD7AZ ) + present( COD7BB ) 
 + present( COD7BC ) + present( COD7BD ) + present( COD7BE ) + present( COD7BF ) + present( COD7BH ) 
 + present( COD7BK ) + present( COD7BL ) + present( COD7BX ) + present( COD7BY ) + present( COD7CV )
 + present( COD7DY ) + present( COD7OF ) + present( COD7OG ) + present( COD7OH ) + present( COD7OI )
 + present( COD7OJ ) + present( COD7OV ) + present( COD7PF ) + present( COD7PG ) + present( COD7PH )
 + present( COD7PI ) + present( COD7PJ ) + present( COD7RM ) + present( COD7RO ) + present( COD7RU )
 + present( COD7SM ) + present( COD7SO ) + present( COD7SU ) + present( COD7SZ ) + present( COD7TA )
 + present( COD7TB ) + present( COD7TC ) + present( COD7TK ) + present( COD7TN ) + present( COD7TP )
 + present( COD7TR ) + present( COD7TS ) + present( COD7TQ ) + present( COD7TT ) + present( COD7TX )
 + present( COD7TY ) + present( COD7VI ) + present( COD7VK ) + present( COD7VL ) + present( COD7VP )
 + present( COD7WH ) + present( COD7WI ) + present( COD7WV ) + present( COD7WW ) + present( COD7XB )
 + present( COD7XC ) 
 + present( CODHAA ) + present( CODHAB ) + present( CODHAC ) + present( CODHAE ) + present( CODHAF ) 
 + present( CODHAG ) + present( CODHAH ) + present( CODHAJ ) + present( CODHAK ) + present( CODHAL )
 + present( CODHAM ) + present( CODHAO ) + present( CODHAP ) + present( CODHAQ ) + present( CODHAR ) 
 + present( CODHAT ) + present( CODHAU ) + present( CODHAV ) + present( CODHAW ) + present( CODHAY )
 + present( CODHBA ) + present( CODHBB ) + present( CODHBE ) + present( CODHBG ) + present( CODHUA ) 
 + present( CODHUB ) + present( CODHUC ) + present( CODHUD ) + present( CODHUE ) + present( CODHUF ) 
 + present( CODHUG ) + present( CODHXA ) + present( CODHXB ) + present( CODHXC ) + present( CODHXE ) 
 + present( CODHBI ) + present( CODHBJ ) + present( CODHBK ) + present( CODHBL ) + present( CODHBM )
 + present( CODHBN ) + present( CODHBO ) + present( CODHBP ) + present( CODHBQ ) + present( CODHBR )
 + present( CODHBS ) + present( CODHBT ) + present( CODHBU ) + present( CODHBV ) + present( CODHBW )
 + present( CODHBX ) + present( CODHBY ) + present( CODHBZ ) + present( CODHCA ) + present( CODHCB )
 + present( CODHCC ) + present( CODHCD ) + present( CODHCE ) + present( CODHCF ) + present( CODHCG )
 + present( CODHJA ) + present( CODHUH ) + present( CODHUI ) + present( CODHUJ ) + present( CODHUK )
 + present( CODHUL ) + present( CODHUM ) + present( CODHUN ) + present( CODHXF ) + present( CODHXG )
 + present( CODHXH ) + present( CODHXI ) + present( CODHXK )
 + present( CSPROVYN ) + present( CSPROVYP )
 + present( COD8SA ) + present( COD8SB ) + present( COD8XI ) + present( COD8XJ )
 + present( COD8XY ) + present( COD8YM ) + present( COD8RU )
 + present( COD8SC ) + present( COD8SW ) + present( COD8SX )
 + present( RFRN3 )
 
 );


INDREV1A8 = positif(INDREV1A8IR);

IND_REV8FV = positif(INDREV1A8);

IND_REV = positif( IND_REV8FV + positif(REVFONC)) ;

regle 221610:
application : batch , iliad ;


IND_SPR = positif(  
            somme(i=V,C,1,2,3,4: present(PRBi) + present(TSBNi) + present(FRNi))
	    + somme(i=V,C ; j=1,2 : present(GLDji) ) 
	    + somme(i=2,3,4 ; j=V,C,1,2,3,4 : present(iTSNj) + present(iPRBj))
                 ) ;

regle 221620:
application : iliad , batch ;


INDPL = null(PLA - PLAF_CDPART) ;

regle 221630:
application : iliad , batch ;

INDTEFF = (1 - V_CNR)
        * (1 - positif(positif(VARIPTEFP)
			  +positif(VARIPTEFN))) * positif( 
   positif( AUTOBICVV ) 
 + positif( AUTOBICPV ) 
 + positif( AUTOBICVC ) 
 + positif( AUTOBICPC ) 
 + positif( AUTOBICVP ) 
 + positif( AUTOBICPP ) 
 + positif( AUTOBNCV ) 
 + positif( AUTOBNCC ) 
 + positif( AUTOBNCP ) 
 + positif( XHONOAAV ) 
 + positif( XHONOV ) 
 + positif( XHONOAAC ) 
 + positif( XHONOC ) 
 + positif( XHONOAAP ) 
 + positif( XHONOP )
 + positif( SALEXTV ) 
 + positif( COD1AE ) 
 + positif( COD1AH ) 
 + positif( SALEXTC ) 
 + positif( COD1BE ) 
 + positif( COD1BH ) 
 + positif( SALEXT1 ) 
 + positif( COD1CE ) 
 + positif( COD1CH ) 
 + positif( SALEXT2 ) 
 + positif( COD1DE ) 
 + positif( COD1DH ) 
 + positif( SALEXT3 ) 
 + positif( COD1EE ) 
 + positif( COD1EH ) 
 + positif( SALEXT4 ) 
 + positif( COD1FE ) 
 + positif( COD1FH ));

regle 221640:
application : batch ;


TXTO = COPETO + TXINT ;

regle 221650:
application : iliad ;


R_QUOTIENT = TONEQUO ;

regle 221660:
application : batch ;


NATMAJ = 1 ;
NATMAJC = 1 ;
NATMAJR = 1 ;
NATMAJP = 1 ;
NATMAJCVN  = 1 ;
NATMAJCDIS = 1 ;
NATMAJGLOA = 1 ;
NATMAJRSE1 = 1 ;
NATMAJRSE2 = 1 ;
NATMAJRSE3 = 1 ;
NATMAJRSE4 = 1 ;
NATMAJRSE5 = 1 ;
NATMAJRSE6 = 1 ;
RETX = TXINT;
MAJTXC = COPETO;
TXC = COPETO + TXINT;
MAJTXR = COPETO;
TXR = COPETO + TXINT;
MAJTXP = COPETO;
TXP = COPETO + TXINT;
MAJTXCVN = COPETO;
TXCVN = COPETO + TXINT;
MAJTXGLOA = COPETO;
TXGLOA = COPETO + TXINT;
MAJTXCDIS = COPETO;
TXCDIS = COPETO + TXINT;
MAJTXRSE1 = COPETO;
TXRSE1 = COPETO + TXINT;
MAJTXRSE2 = COPETO;
TXRSE2 = COPETO + TXINT;
MAJTXRSE3 = COPETO;
TXRSE3 = COPETO + TXINT;
MAJTXRSE4 = COPETO;
TXRSE4 = COPETO + TXINT;
MAJTXRSE5 = COPETO;
TXRSE5 = COPETO + TXINT;
MAJTXRSE6 = COPETO;
TXRSE6 = COPETO + TXINT;

regle 221670:
application : iliad ;


TXTO = TXINR * (1-positif(TXINR_A)) + (-1) * positif(TXINR_A) * positif(TXINR) * positif(TXINR - TXINR_A)
		+ TXINR * positif(TXINR_A) * null(TXINR - TXINR_A);

regle 221680:
application : iliad , batch ;


TXPFI = si (V_CODPFI=03 ou V_CODPFI=30 ou V_CODPFI=55)
	alors (40)
	sinon (
	  si (V_CODPFI=04 ou V_CODPFI=05 ou V_CODPFI=32)
          alors (80)
	  sinon (
	    si (V_CODPFI=06) alors (100)
	    finsi)
          finsi)
        finsi ;

TXPFITAXA = si (V_CODPFITAXA=03 ou V_CODPFITAXA=30 ou V_CODPFITAXA=55)
            alors (40)
	    sinon (
	      si (V_CODPFITAXA=04 ou V_CODPFITAXA=05)
	      alors (80)
              sinon (
                si (V_CODPFITAXA=06) alors (100)
	        finsi)
              finsi)
            finsi ;

TXPFICAP = si (V_CODPFICAP=03 ou V_CODPFICAP=30 ou V_CODPFICAP=55)
            alors (40)
	    sinon (
	      si (V_CODPFICAP=04 ou V_CODPFICAP=05)
	      alors (80)
              sinon (
                si (V_CODPFICAP=06) alors (100)
	        finsi)
              finsi)
            finsi ;

TXPFILOY = si (V_CODPFILOY=03 ou V_CODPFILOY=30 ou V_CODPFILOY=55)
            alors (40)
	    sinon (
	      si (V_CODPFILOY=04 ou V_CODPFILOY=05)
	      alors (80)
              sinon (
                si (V_CODPFILOY=06) alors (100)
	        finsi)
              finsi)
            finsi ;

TXPFICHR = si (V_CODPFICHR=03 ou V_CODPFICHR=30 ou V_CODPFICHR=55)
            alors (40)
	    sinon (
	      si (V_CODPFICHR=04 ou V_CODPFICHR=05 ou V_CODPFICHR=32)
	      alors (80)
              sinon (
                si (V_CODPFICHR=06) alors (100)
	        finsi)
              finsi)
            finsi ;


TXPFICRP = si (V_CODPFICRP=03 ou V_CODPFICRP=30 ou V_CODPFICRP=55)
	   alors (40)
	   sinon (
	     si (V_CODPFICRP=04 ou V_CODPFICRP=05 ou V_CODPFICRP=32)
	     alors (80)
	     sinon (
	       si (V_CODPFICRP=06) alors (100)
	       finsi)
             finsi)
           finsi ;

TXPFICVN = si (V_CODPFICVN=03 ou V_CODPFICVN=30 ou V_CODPFICVN=55) 
	    alors (40)
	    sinon (
	      si (V_CODPFICVN=04 ou V_CODPFICVN=05) alors (80)
	      sinon (
	        si (V_CODPFICVN=06) alors (100)
	        finsi)
              finsi)
	    finsi ;

TXPFICDIS = si (V_CODPFICDIS=03 ou V_CODPFICDIS=30 ou V_CODPFICDIS=55)
            alors (40)
            sinon (
	      si (V_CODPFICDIS=04 ou V_CODPFICDIS=05)
	      alors (80)
	      sinon (
		si (V_CODPFICDIS=06) alors (100)
	        finsi)
              finsi)
            finsi ;

TXPFIGLO = si (V_CODPFIGLO=03 ou V_CODPFIGLO=30 ou V_CODPFIGLO=55)
            alors (40)
            sinon (
	      si (V_CODPFIGLO=04 ou V_CODPFIGLO=05)
	      alors (80)
	      sinon (
		si (V_CODPFIGLO=06) alors (100)
	        finsi)
              finsi)
            finsi ;


TXPFIRSE1 = si (V_CODPFIRSE1=03 ou V_CODPFIRSE1=30 ou V_CODPFIRSE1=55)
            alors (40)
            sinon (
	      si (V_CODPFIRSE1=04 ou V_CODPFIRSE1=05)
	      alors (80)
	      sinon (
		si (V_CODPFIRSE1=06) alors (100)
	        finsi)
              finsi)
            finsi ;

TXPFIRSE5 = si (V_CODPFIRSE5=03 ou V_CODPFIRSE5=30 ou V_CODPFIRSE5=55)
            alors (40)
            sinon (
	      si (V_CODPFIRSE5=04 ou V_CODPFIRSE5=05)
	      alors (80)
	      sinon (
		si (V_CODPFIRSE5=06) alors (100)
	        finsi)
              finsi)
            finsi ;

TXPFIRSE2 = si (V_CODPFIRSE2=03 ou V_CODPFIRSE2=30 ou V_CODPFIRSE2=55)
            alors (40)
            sinon (
	      si (V_CODPFIRSE2=04 ou V_CODPFIRSE2=05)
	      alors (80)
	      sinon (
		si (V_CODPFIRSE2=06) alors (100)
	        finsi)
              finsi)
            finsi ;

TXPFIRSE3 = si (V_CODPFIRSE3=03 ou V_CODPFIRSE3=30 ou V_CODPFIRSE3=55)
            alors (40)
            sinon (
	      si (V_CODPFIRSE3=04 ou V_CODPFIRSE3=05)
	      alors (80)
	      sinon (
		si (V_CODPFIRSE3=06) alors (100)
	        finsi)
              finsi)
            finsi ;

TXPFIRSE4 = si (V_CODPFIRSE4=03 ou V_CODPFIRSE4=30 ou V_CODPFIRSE4=55)
            alors (40)
            sinon (
	      si (V_CODPFIRSE4=04 ou V_CODPFIRSE4=05)
	      alors (80)
	      sinon (
		si (V_CODPFIRSE4=06) alors (100)
	        finsi)
              finsi)
            finsi ;

TXPFIRSE6 = si (V_CODPFIRSE6=03 ou V_CODPFIRSE6=30 ou V_CODPFIRSE6=55)
            alors (40)
            sinon (
	      si (V_CODPFIRSE6=04 ou V_CODPFIRSE6=05)
	      alors (80)
	      sinon (
		si (V_CODPFIRSE6=06) alors (100)
	        finsi)
              finsi)
            finsi ;


TXPF1728 = si (V_CODPF1728=07 ou V_CODPF1728=10 ou V_CODPF1728=17 ou V_CODPF1728=18)
	   alors (10)
	   sinon (
	     si (V_CODPF1728=08 ou V_CODPF1728=11)
	     alors (40)
	     sinon (
	       si (V_CODPF1728=31)
	       alors (80)
	       finsi)
             finsi)
           finsi ;

TXPF1728CAP = si (V_CODPF1728CAP=07 ou V_CODPF1728CAP=10 ou V_CODPF1728CAP=17 ou V_CODPF1728CAP=18)
	      alors (10)
	      sinon (
		si (V_CODPF1728CAP=08 ou V_CODPF1728CAP=11)
	        alors (40)
	        sinon (
		  si (V_CODPF1728CAP=31) 
		  alors (80)
	          finsi)
		finsi)
	      finsi ;

TXPF1728LOY = si (V_CODPF1728LOY=07 ou V_CODPF1728LOY=10 ou V_CODPF1728LOY=17 ou V_CODPF1728LOY=18)
	      alors (10)
	      sinon (
		si (V_CODPF1728LOY=08 ou V_CODPF1728LOY=11)
	        alors (40)
	        sinon (
		  si (V_CODPF1728LOY=31) 
		  alors (80)
	          finsi)
		finsi)
	      finsi ;

TXPF1728CHR = si (V_CODPF1728CHR=07 ou V_CODPF1728CHR=10 ou V_CODPF1728CHR=17 ou V_CODPF1728CHR=18)
	      alors (10)
	      sinon (
		si (V_CODPF1728CHR=08 ou V_CODPF1728CHR=11)
	        alors (40)
	        sinon (
		  si (V_CODPF1728CRP=31) 
		  alors (80)
	          finsi)
		finsi)
	      finsi ;


TXPF1728CRP = si (V_CODPF1728CRP=07 ou V_CODPF1728CRP=10 ou V_CODPF1728CRP=17 ou V_CODPF1728CRP=18)
	      alors (10)
	      sinon (
		si (V_CODPF1728CRP=08 ou V_CODPF1728CRP=11)
	        alors (40)
	        sinon (
		  si (V_CODPF1728CRP=31) 
		  alors (80)
	          finsi)
		finsi)
	      finsi ;

TXPF1728CVN = si (V_CODPF1728CVN=07 ou V_CODPF1728CVN=10 ou V_CODPF1728CVN=17 ou V_CODPF1728CVN=18)
	       alors (10)
	       sinon (
		 si (V_CODPF1728CVN=08 ou V_CODPF1728CVN=11)
	         alors (40)
                 sinon (
		   si (V_CODPF1728CVN=31) 
		   alors (80)
		   finsi)
		 finsi)
	       finsi ;

TXPF1728CDIS = si (V_CODPF1728CDIS=07 ou V_CODPF1728CDIS=10 ou V_CODPF1728CDIS=17 ou V_CODPF1728CDIS=18)
	       alors (10)
	       sinon (
		 si (V_CODPF1728CDIS=08 ou V_CODPF1728CDIS=11)
	         alors (40)
	         sinon (
		   si (V_CODPF1728CDIS=31) alors (80)
		   finsi)
		 finsi)
               finsi ;

TXPF1728GLO = si (V_CODPF1728GLO=07 ou V_CODPF1728GLO=10 ou V_CODPF1728GLO=17 ou V_CODPF1728GLO=18)
	       alors (10)
	       sinon (
		 si (V_CODPF1728GLO=08 ou V_CODPF1728GLO=11)
	         alors (40)
	         sinon (
		   si (V_CODPF1728GLO=31) alors (80)
		   finsi)
		 finsi)
               finsi ;

TXPF1728RSE1 = si (V_CODPF1728RSE1=07 ou V_CODPF1728RSE1=10 ou V_CODPF1728RSE1=17 ou V_CODPF1728RSE1=18)
	       alors (10)
	       sinon (
		 si (V_CODPF1728RSE1=08 ou V_CODPF1728RSE1=11)
	         alors (40)
                 sinon (
		   si (V_CODPF1728RSE1=31) 
		   alors (80)
		   finsi)
		 finsi)
	       finsi ;

TXPF1728RSE5 = si (V_CODPF1728RSE5=07 ou V_CODPF1728RSE5=10 ou V_CODPF1728RSE5=17 ou V_CODPF1728RSE5=18)
	       alors (10)
	       sinon (
		 si (V_CODPF1728RSE5=08 ou V_CODPF1728RSE5=11)
	         alors (40)
                 sinon (
		   si (V_CODPF1728RSE5=31) 
		   alors (80)
		   finsi)
		 finsi)
	       finsi ;

TXPF1728RSE2 = si (V_CODPF1728RSE2=07 ou V_CODPF1728RSE2=10 ou V_CODPF1728RSE2=17 ou V_CODPF1728RSE2=18)
	       alors (10)
	       sinon (
		 si (V_CODPF1728RSE2=08 ou V_CODPF1728RSE2=11)
	         alors (40)
                 sinon (
		   si (V_CODPF1728RSE2=31) 
		   alors (80)
		   finsi)
		 finsi)
	       finsi ;

TXPF1728RSE3 = si (V_CODPF1728RSE3=07 ou V_CODPF1728RSE3=10 ou V_CODPF1728RSE3=17 ou V_CODPF1728RSE3=18)
	       alors (10)
	       sinon (
		 si (V_CODPF1728RSE3=08 ou V_CODPF1728RSE3=11)
	         alors (40)
                 sinon (
		   si (V_CODPF1728RSE3=31) 
		   alors (80)
		   finsi)
		 finsi)
	       finsi ;

TXPF1728RSE4 = si (V_CODPF1728RSE4=07 ou V_CODPF1728RSE4=10 ou V_CODPF1728RSE4=17 ou V_CODPF1728RSE4=18)
	       alors (10)
	       sinon (
		 si (V_CODPF1728RSE4=08 ou V_CODPF1728RSE4=11)
	         alors (40)
                 sinon (
		   si (V_CODPF1728RSE4=31) 
		   alors (80)
		   finsi)
		 finsi)
	       finsi ;

TXPF1728RSE6 = si (V_CODPF1728RSE6=07 ou V_CODPF1728RSE6=10 ou V_CODPF1728RSE6=17 ou V_CODPF1728RSE6=18)
	       alors (10)
	       sinon (
		 si (V_CODPF1728RSE6=08 ou V_CODPF1728RSE6=11)
	         alors (40)
                 sinon (
		   si (V_CODPF1728RSE6=31) 
		   alors (80)
		   finsi)
		 finsi)
	       finsi ;

regle 221690:
application : iliad , batch ;


MAJTX1 = (1 - positif(V_NBCOD1728))
	  * ((1 - positif(CMAJ)) * positif(NMAJ1 + NMAJTAXA1 + NMAJPCAP1 + NMAJLOY1 +NMAJCHR1) * TXPF1728 
	     + positif(CMAJ) * COPETO)
	 + positif(V_NBCOD1728) * (-1) ;

MAJTXPCAP1 = (1 - positif(V_NBCOD1728CAP))
	      * ((1 - positif(CMAJ)) * positif(NMAJPCAP1) * TXPF1728CAP + positif(CMAJ) * COPETO)
	     + positif(V_NBCOD1728CAP) * (-1) ;

MAJTXLOY1 = (1 - positif(V_NBCOD1728LOY))
	      * ((1 - positif(CMAJ)) * positif(NMAJLOY1) * TXPF1728LOY + positif(CMAJ) * COPETO)
	     + positif(V_NBCOD1728LOY) * (-1) ;


MAJTXCHR1 = (1 - positif(V_NBCOD1728CHR))
	      * ((1 - positif(CMAJ)) * positif(NMAJCHR1) * TXPF1728 + positif(CMAJ) * COPETO)
	     + positif(V_NBCOD1728CHR) * (-1);



MAJTXC1 = (1 - positif(V_NBCOD1728CRP))
           * ((1 - positif(CMAJ)) * positif( NMAJC1 + NMAJR1 + NMAJP1) * TXPF1728CRP 
	      + positif(CMAJ) * COPETO)
	  + positif(V_NBCOD1728CRP) * (-1) ;

MAJTXR1 = MAJTXC1 ;

MAJTXP1 = MAJTXC1 ;

MAJTXCVN1 = (1 - positif(V_NBCOD1728CVN))
	      * ((1 - positif(CMAJ)) * positif(NMAJCVN1) * TXPF1728CVN + positif(CMAJ) * COPETO)
	     + positif(V_NBCOD1728CVN) * (-1) ;

MAJTXCDIS1 = (1 - positif(V_NBCOD1728CDIS))
	      * ((1 - positif(CMAJ)) * positif(NMAJCDIS1) * TXPF1728CDIS + positif(CMAJ) * COPETO)
	     + positif(V_NBCOD1728CDIS) * (-1) ;

MAJTXGLO1 = (1 - positif(V_NBCOD1728GLO))
              * ((1 - positif(CMAJ)) * positif(NMAJGLO1) * TXPF1728GLO + positif(CMAJ) * COPETO)
             + positif(V_NBCOD1728GLO) * (-1) ;

MAJTXRSE11 = (1 - positif(V_NBCOD1728RSE1))
	      * ((1 - positif(CMAJ)) * positif(NMAJRSE11) * TXPF1728RSE1 + positif(CMAJ) * COPETO)
	     + positif(V_NBCOD1728RSE1) * (-1) ;

MAJTXRSE51 = (1 - positif(V_NBCOD1728RSE5))
	      * ((1 - positif(CMAJ)) * positif(NMAJRSE51) * TXPF1728RSE5 + positif(CMAJ) * COPETO)
	     + positif(V_NBCOD1728RSE5) * (-1) ;

MAJTXRSE21 = (1 - positif(V_NBCOD1728RSE2))
	      * ((1 - positif(CMAJ)) * positif(NMAJRSE21) * TXPF1728RSE2 + positif(CMAJ) * COPETO)
	     + positif(V_NBCOD1728RSE2) * (-1) ;

MAJTXRSE31 = (1 - positif(V_NBCOD1728RSE3))
	      * ((1 - positif(CMAJ)) * positif(NMAJRSE31) * TXPF1728RSE3 + positif(CMAJ) * COPETO)
	     + positif(V_NBCOD1728RSE3) * (-1) ;

MAJTXRSE41 = (1 - positif(V_NBCOD1728RSE4))
              * ((1 - positif(CMAJ)) * positif(NMAJRSE41) * TXPF1728RSE4 + positif(CMAJ) * COPETO)
	     + positif(V_NBCOD1728RSE4) * (-1) ;

MAJTXRSE61 = (1 - positif(V_NBCOD1728RSE6))
              * ((1 - positif(CMAJ)) * positif(NMAJRSE61) * TXPF1728RSE6 + positif(CMAJ) * COPETO)
	     + positif(V_NBCOD1728RSE6) * (-1) ;


MAJTX3 = positif(NMAJ3) * 10; 

MAJTXTAXA3 = positif(NMAJTAXA3) * 10;

MAJTXPCAP3 = positif(NMAJPCAP3) * 10;

MAJTXLOY3 = positif(NMAJLOY3) * 10;

MAJTXCHR3 = positif(NMAJCHR3) * 10;



MAJTX4 = (1 - positif(V_NBCODI))
	  * ((1 - positif(CMAJ)) * positif(NMAJ4) * TXPFI + positif(CMAJ) * COPETO)
         + positif(V_NBCODI) * (-1) ;

MAJTXTAXA4 = (1 - positif(V_NBCODITAXA)) 
	      * ((1 - positif(CMAJ)) * positif(NMAJTAXA4) * TXPFITAXA + positif(CMAJ) * COPETO)
	     + positif(V_NBCODITAXA) * (-1) ;

MAJTXPCAP4 = (1 - positif(V_NBCODICAP)) 
	      * ((1 - positif(CMAJ)) * positif(NMAJPCAP4) * TXPFICAP + positif(CMAJ) * COPETO)
	     + positif(V_NBCODICAP) * (-1) ;


MAJTXLOY4 =  positif(positif(positif(MAJOLOY03)+positif(MAJOLOY55))* positif(positif(MAJOLOY04)+positif(MAJOLOY05))
		     + positif(positif(MAJOLOY03)+positif(MAJOLOY55))*positif(MAJOLOY06)
		     + positif(positif(MAJOLOY04)+positif(MAJOLOY05))* positif(MAJOLOY06)) * -1
	    + positif(positif(MAJOLOY03)+positif(MAJOLOY55))* (1-positif(positif(MAJOLOY04)+ positif(MAJOLOY05)+ positif(MAJOLOY06))) * 40
	    + positif(positif(MAJOLOY04)+positif(MAJOLOY05))* (1-positif(positif(MAJOLOY03)+ positif(MAJOLOY55)+positif(MAJOLOY06))) * 80
	    + positif(MAJOLOY06)*(1-positif(positif(MAJOLOY03)+positif(MAJOLOY04)+ positif(MAJOLOY05)+ positif(MAJOLOY55))) * 100;

MAJTXCHR4 =  positif(positif(positif(MAJOHR03)+positif(MAJOHR30)+positif(MAJOHR55))* positif(positif(MAJOHR04)+positif(MAJOHR05)+positif(MAJOHR32))
		     + positif(positif(MAJOHR03)+positif(MAJOHR30)+positif(MAJOHR55))*positif(MAJOHR06)
		     + positif(positif(MAJOHR04)+positif(MAJOHR05)+positif(MAJOHR32))* positif(MAJOHR06)) * -1
	    + positif(positif(MAJOHR03)+positif(MAJOHR30)+positif(MAJOHR55))* (1-positif(positif(MAJOHR04)+ positif(MAJOHR05)+ positif(MAJOHR06)+positif(MAJOHR32))) * 40
	    + positif(positif(MAJOHR04)+positif(MAJOHR05)+positif(MAJOHR32))* (1-positif(positif(MAJOHR03)+ positif(MAJOHR30)+ positif(MAJOHR55)+positif(MAJOHR06))) * 80
	    + positif(MAJOHR06)*(1-positif(positif(MAJOHR03)+positif(MAJOHR04)+ positif(MAJOHR05)+ positif(MAJOHR30)+positif(MAJOHR32)+positif(MAJOHR55))) * 100;
MAJTXC4 = (1 - positif(V_NBCODICRP))
	   * ((1 - positif(CMAJ)) * positif(NMAJC4+NMAJR4+NMAJP4) * TXPFICRP + positif(CMAJ) * COPETO)
	  + positif(V_NBCODICRP) * (-1) ;

MAJTXR4 = MAJTXC4 ;

MAJTXP4 = MAJTXC4 ;


MAJTXCVN4 =  positif(positif(positif(MAJOCVN03)+positif(MAJOCVN55))* positif(positif(MAJOCVN04)+positif(MAJOCVN05))
		     + positif(positif(MAJOCVN03)+positif(MAJOCVN55))*positif(MAJOCVN06)
		     + positif(positif(MAJOCVN04)+positif(MAJOCVN05))* positif(MAJOCVN06)) * -1
	    + positif(positif(MAJOCVN03)+positif(MAJOCVN55))* (1-positif(positif(MAJOCVN04)+ positif(MAJOCVN05)+ positif(MAJOCVN06))) * 40
	    + positif(positif(MAJOCVN04)+positif(MAJOCVN05))* (1-positif(positif(MAJOCVN03) + positif(MAJOCVN55)+positif(MAJOCVN06))) * 80
	    + positif(MAJOCVN06)*(1-positif(positif(MAJOCVN03)+positif(MAJOCVN04)+ positif(MAJOCVN05)+positif(MAJOCVN55))) * 100;
MAJTXCDIS4 = (1 - positif(V_NBCODICDIS))
	      * ((1 - positif(CMAJ)) * positif(NMAJCDIS4) * TXPFICDIS + positif(CMAJ) * COPETO)
	     + positif(V_NBCODICDIS) * (-1) ;


MAJTXGLO4 =  positif(positif(positif(MAJOGLO03)+positif(MAJOGLO55))* positif(positif(MAJOGLO04)+positif(MAJOGLO05))
		     + positif(positif(MAJOGLO03)+positif(MAJOGLO55))*positif(MAJOGLO06)
		     + positif(positif(MAJOGLO04)+positif(MAJOGLO05))* positif(MAJOGLO06)) * -1
	    + positif(positif(MAJOGLO03)+positif(MAJOGLO55))* (1-positif(positif(MAJOGLO04)+ positif(MAJOGLO05)+ positif(MAJOGLO06))) * 40
	    + positif(positif(MAJOGLO04)+positif(MAJOGLO05))* (1-positif(positif(MAJOGLO03)+ positif(MAJOGLO55)+positif(MAJOGLO06))) * 80
	    + positif(MAJOGLO06)*(1-positif(positif(MAJOGLO03)+positif(MAJOGLO04)+ positif(MAJOGLO05)+positif(MAJOGLO55))) * 100;

MAJTXRSE14 = (1 - positif(V_NBCODIRSE1))
	      * ((1 - positif(CMAJ)) * positif(NMAJRSE14) * TXPFIRSE1 + positif(CMAJ) * COPETO)
	     + positif(V_NBCODIRSE1) * (-1) ;


MAJTXRSE54 =  positif(positif(positif(MAJORSE503)+positif(MAJORSE555))* positif(positif(MAJORSE504)+positif(MAJORSE505))
		     + positif(positif(MAJORSE503)+positif(MAJORSE555))*positif(MAJORSE506)
		     + positif(positif(MAJORSE504)+positif(MAJORSE505))* positif(MAJORSE506)) * -1
	    + positif(positif(MAJORSE503)+positif(MAJORSE555))* (1-positif(positif(MAJORSE504)+ positif(MAJORSE505)+ positif(MAJORSE506))) * 40
	    + positif(positif(MAJORSE504)+positif(MAJORSE505))* (1-positif(positif(MAJORSE503)+ positif(MAJORSE555)+positif(MAJORSE506))) * 80
	    + positif(MAJORSE506)*(1-positif(positif(MAJORSE503)+positif(MAJORSE504)+ positif(MAJORSE505)+positif(MAJORSE555))) * 100;
MAJTXRSE24 = (1 - positif(V_NBCODIRSE2))
	      * ((1 - positif(CMAJ)) * positif(NMAJRSE24) * TXPFIRSE2 + positif(CMAJ) * COPETO)
	     + positif(V_NBCODIRSE2) * (-1) ;

MAJTXRSE34 = (1 - positif(V_NBCODIRSE3))
	      * ((1 - positif(CMAJ)) * positif(NMAJRSE34) * TXPFIRSE3 + positif(CMAJ) * COPETO)
	     + positif(V_NBCODIRSE3) * (-1) ;

MAJTXRSE44 = (1 - positif(V_NBCODIRSE4))
	      * ((1 - positif(CMAJ)) * positif(NMAJRSE44) * TXPFIRSE4 + positif(CMAJ) * COPETO)
	     + positif(V_NBCODIRSE4) * (-1) ;

MAJTXRSE64 = (1 - positif(V_NBCODIRSE6))
	      * ((1 - positif(CMAJ)) * positif(NMAJRSE64) * TXPFIRSE6 + positif(CMAJ) * COPETO)
	     + positif(V_NBCODIRSE6) * (-1) ;

regle 221700:
application : iliad ;

RETX = positif(CMAJ) * TXINT
       + (TXINR * (1-positif(TXINR_A)) + (-1) * positif(TXINR_A) * positif(TXINR) * (1-null(TXINR - TXINR_A))
       + TXINR * positif(TXINR_A) * null(TXINR - TXINR_A)) * (1-positif(TINR_1)
               * positif(INRIR_NET_1+INRCSG_NET_1+INRRDS_NET_1+INRPRS_NET_1+INRCDIS_NET_1
                         +INRCGLOA_NET_1+INRTAXA_NET_1
                         +INRRSE1_NET_1+INRRSE2_NET_1+INRRSE3_NET_1+INRRSE4_NET_1+INRRSE5_NET_1+INRRSE6_NET_1
                                                              ))
       + (-1) * positif(TINR_1) * positif(INRIR_NET_1+INRCSG_NET_1+INRRDS_NET_1+INRPRS_NET_1+INRCDIS_NET_1
                         +INRCGLOA_NET_1+INRTAXA_NET_1
                         +INRRSE1_NET_1+INRRSE2_NET_1+INRRSE3_NET_1+INRRSE4_NET_1+INRRSE5_NET_1+INRRSE6_NET_1
                                                              )
    ;
TXPFC = si (V_CODPFC=01 ou V_CODPFC=02) alors (0)
        sinon (
	  si (V_CODPFC=07 ou V_CODPFC=10 ou V_CODPFC=17 ou V_CODPFC=18) alors (10)
	  sinon (
	    si (V_CODPFC=03 ou V_CODPFC=08 ou V_CODPFC=11 ou V_CODPFC=30) alors (40)
	    sinon (
	      si (V_CODPFC=04 ou V_CODPFC=05 ou V_CODPFC=09 ou V_CODPFC=12 ou V_CODPFC=31) alors (80)
	      sinon (
                si (V_CODPFI=06) alors (100)
                finsi)
	      finsi)
            finsi)
	  finsi)
        finsi ;
TXPFR = si (V_CODPFR=01 ou V_CODPFR=02) alors (0)
        sinon (
	  si (V_CODPFR=07 ou V_CODPFR=10 ou V_CODPFR=17 ou V_CODPFR=18) alors (10)
	  sinon (
	    si (V_CODPFR=03 ou V_CODPFR=08 ou V_CODPFR=11 ou V_CODPFR=30) alors (40)
	    sinon (
	      si (V_CODPFR=04 ou V_CODPFR=05 ou V_CODPFR=09 ou V_CODPFR=12 ou V_CODPFR=31) alors (80)
	      sinon (
	        si (V_CODPFI=06) alors (100)
	      finsi)
	    finsi)
	  finsi)
	finsi)
      finsi ;
TXPFP = si (V_CODPFP=01 ou V_CODPFP=02) alors (0)
        sinon (
          si (V_CODPFP=07 ou V_CODPFP=10 ou V_CODPFP=17 ou V_CODPFP=18) alors (10)
	  sinon (
	    si (V_CODPFP=03 ou V_CODPFP=08 ou V_CODPFP=11 ou V_CODPFP=30) alors (40)
	    sinon (
	      si (V_CODPFP=04 ou V_CODPFP=05 ou V_CODPFP=09 ou V_CODPFP=12 ou V_CODPFP=31) alors (80)
	      sinon (
	        si (V_CODPFI=06) alors (100)
	        finsi)
	      finsi)
            finsi)
          finsi)
        finsi ;
NATMAJI = present(CMAJ) +
	 si (V_CODPFI =01) alors (1) sinon (
	   si (V_CODPFI =02 ou V_CODPFI=22) alors (2)
	   sinon (
	     si (V_CODPFI=03  ou V_CODPFI=04 ou V_CODPFI=05 ou V_CODPFI=06
	         ou V_CODPFI=30 ou V_CODPFI=32 ou V_CODPFI=55) 
	     alors (4)
             sinon (
               si (V_CODPF1728=07 ou V_CODPF1728=08 ou V_CODPF1728=10 ou V_CODPF1728=11 
                   ou V_CODPF1728=17 ou V_CODPF1728=18 ou V_CODPF1728=31) 
	       alors (1)
	       finsi)
             finsi)
           finsi)
         finsi ;
NATMAJ = NATMAJI * (1 - positif(V_NBCODI+V_NBCOD1728)) + 9 * positif(V_NBCODI+V_NBCOD1728) ;
NATMAJCI = present(CMAJ) +
           si (V_CODPFC=01) alors (1) sinon (
	     si (V_CODPFC=02) alors (2)
	     sinon (
	       si (V_CODPFC=03  ou V_CODPFC=04 ou V_CODPFC=05 ou V_CODPFC=06
		   ou V_CODPFC=22 ou V_CODPFC=32 ou V_CODPFC=30 ou V_CODPFC=55) 
	       alors (4)
	       sinon (
                 si (V_CODPFC=07 ou V_CODPFC=08 ou V_CODPFC=09 ou V_CODPFC=10 ou V_CODPFC=11
		     ou V_CODPFC=12 ou V_CODPFC=17 ou V_CODPFC=18 ou V_CODPFC=31) 
		 alors (1)
	         finsi)
	       finsi)
	     finsi)
           finsi ;
NATMAJC = NATMAJCI * (1 - positif(V_NBCODC)) + 9 * positif(V_NBCODC) ;
NATMAJRI = present(CMAJ) +
	   si (V_CODPFR=01) alors (1) sinon (
	     si (V_CODPFR=02) alors (2)
	     sinon (
	       si (V_CODPFR=03  ou V_CODPFR=04 ou V_CODPFR=05 ou V_CODPFR=06
	           ou V_CODPFR=22 ou V_CODPFR=32 ou V_CODPFR=30 ou V_CODPFR=55) 
	       alors (4)
	       sinon (
	         si (V_CODPFR=07 ou V_CODPFR=08 ou V_CODPFR=09 ou V_CODPFR=10 ou V_CODPFR=11
	             ou V_CODPFR=12 ou V_CODPFR=17 ou V_CODPFR=18 ou V_CODPFR=31) 
	         alors (1)
	         finsi)
               finsi)
             finsi)
           finsi ;
NATMAJR = NATMAJRI * (1 - positif(V_NBCODR)) + 9 * positif(V_NBCODR) ;
NATMAJPI = present(CMAJ) +
	   si (V_CODPFP=01) alors (1) sinon (
	     si (V_CODPFP=02) alors (2)
	     sinon (
	       si (V_CODPFP=03 ou V_CODPFP=04 ou V_CODPFP=05 ou V_CODPFP=06
	           ou V_CODPFP=22 ou V_CODPFP=32 ou V_CODPFP=30 ou V_CODPFP=55) 
	       alors (4)
	       sinon (
	         si (V_CODPFP=07 ou V_CODPFP=08 ou V_CODPFP=09 ou V_CODPFP=10 ou V_CODPFP=11 
		     ou V_CODPFP=12 ou V_CODPFP=17  ou V_CODPFP=18 ou V_CODPFP=31) 
		 alors (1)
	         finsi)
               finsi)
             finsi)
           finsi ;
NATMAJP = NATMAJPI * (1 - positif(V_NBCODP)) + 9 * positif(V_NBCODP) ;
NATMAJCAPI = present(CMAJ) +
	      si (V_CODPFICAP=01) alors (1) sinon (
		si (V_CODPFICAP=02) alors (2)
		sinon (
		  si (V_CODPFICAP=03 ou V_CODPFICAP=04 ou V_CODPFICAP=05 ou V_CODPFICAP=06
		      ou V_CODPFICAP=22 ou V_CODPFICAP=30 ou V_CODPFICAP=30 ou V_CODPFICAP=55)
                  alors (4)
		  sinon (
		    si (V_CODPFICAP=07 ou V_CODPFICAP=08 ou V_CODPFICAP=09 ou V_CODPFICAP=10
			ou V_CODPFICAP=11 ou V_CODPFICAP=12 ou V_CODPFICAP=17  ou V_CODPFICAP=18
			ou V_CODPFICAP=31)
	            alors (1)
	            finsi)
                  finsi)
                finsi)
              finsi ;
NATMAJCAP = NATMAJCAPI * (1 - positif(V_NBCODICAP)) + 9 * positif(V_NBCODICAP) ;
NATMAJCHRI = present(CMAJ) +
	      si (V_CODPFICHR=01) alors (1) sinon (
		si (V_CODPFICHR=02) alors (2)
		sinon (
		  si (V_CODPFICHR=03 ou V_CODPFICHR=04 ou V_CODPFICHR=05 ou V_CODPFICHR=06
		      ou V_CODPFICHR=22 ou V_CODPFICHR=30 ou V_CODPFICHR=30 ou V_CODPFICHR=55)
                  alors (4)
		  sinon (
		    si (V_CODPFICHR=07 ou V_CODPFICHR=08 ou V_CODPFICHR=09 ou V_CODPFICHR=10
			ou V_CODPFICHR=11 ou V_CODPFICHR=12 ou V_CODPFICHR=17  ou V_CODPFICHR=18
			ou V_CODPFICHR=31)
	            alors (1)
	            finsi)
                  finsi)
                finsi)
              finsi ;
NATMAJCHR = NATMAJCHRI * (1 - positif(V_NBCODICHR)) + 9 * positif(V_NBCODICHR) ;
NATMAJCDISI = present(CMAJ) +
	      si (V_CODPFCDIS=01) alors (1) sinon (
	        si (V_CODPFCDIS=02) alors (2)
	        sinon (
	          si (V_CODPFCDIS=03  ou V_CODPFCDIS=04 ou V_CODPFCDIS=05 ou V_CODPFCDIS=06
	              ou V_CODPFCDIS=22 ou V_CODPFCDIS=30 ou V_CODPFCDIS=55)
		  alors (4)
                  sinon (
                    si (V_CODPFCDIS=07 ou V_CODPFCDIS=08 ou V_CODPFCDIS=09 ou V_CODPFCDIS=10 
			ou V_CODPFCDIS=11 ou V_CODPFCDIS=12 ou V_CODPFCDIS=17 ou V_CODPFCDIS=18 
			ou V_CODPFCDIS=31) 
		    alors (1)
	            finsi)
	          finsi)
	        finsi)
	      finsi ;
NATMAJCDIS = NATMAJCDISI * (1 - positif(V_NBCODCDIS)) + 9 * positif(V_NBCODCDIS) ;
NATMAJGLOAI = present(CMAJ) +
	      si (V_CODPFGLO=01) alors (1) sinon (
	        si (V_CODPFGLO=02) alors (2)
	        sinon (
	          si (V_CODPFGLO=03  ou V_CODPFGLO=04 ou V_CODPFGLO=05 ou V_CODPFGLO=06
	              ou V_CODPFGLO=22 ou V_CODPFGLO=30 ou V_CODPFGLO=55)
		  alors (4)
                  sinon (
                    si (V_CODPFGLO=07 ou V_CODPFGLO=08 ou V_CODPFGLO=09 ou V_CODPFGLO=10 
			ou V_CODPFGLO=11 ou V_CODPFGLO=12 ou V_CODPFGLO=17 ou V_CODPFGLO=18 
			ou V_CODPFGLO=31) 
		    alors (1)
	            finsi)
	          finsi)
	        finsi)
	      finsi ;
NATMAJGLOA = NATMAJGLOAI * (1 - positif(V_NBCODGLO)) + 9 * positif(V_NBCODGLO) ;
NATMAJCVNI = present(CMAJ) +
	      si (V_CODPFCVN=01) alors (1) sinon (
	        si (V_CODPFCVN=02) alors (2)
	        sinon (
		  si (V_CODPFCVN=03  ou V_CODPFCVN=04 ou V_CODPFCVN=05 ou V_CODPFCVN=06
	              ou V_CODPFCVN=22 ou V_CODPFCVN=30 ou V_CODPFCVN=55)
		  alors (4)
		  sinon (
	            si (V_CODPFCVN=07 ou V_CODPFCVN=08 ou V_CODPFCVN=09 ou V_CODPFCVN=10
	                ou V_CODPFCVN=11 ou V_CODPFCVN=12 ou V_CODPFCVN=17 ou V_CODPFCVN=18
	                ou V_CODPFCVN=31)
	            alors (1)
                    finsi)
	          finsi)
	        finsi)
	      finsi ;
NATMAJCVN = NATMAJCVNI * (1 - positif(V_NBCODCVN)) + 9 * positif(V_NBCODCVN) ;
NATMAJRSE1I = present(CMAJ) +
	      si (V_CODPFRSE1=01) alors (1) sinon (
	        si (V_CODPFRSE1=02) alors (2)
	        sinon (
	 	  si (V_CODPFRSE1=03 ou V_CODPFRSE1=04 ou V_CODPFRSE1=05 ou V_CODPFRSE1=06
		      ou V_CODPFRSE1=22 ou V_CODPFRSE1=30 ou V_CODPFRSE1=55)
                  alors (4)
		  sinon (
		    si (V_CODPFRSE1=07 ou V_CODPFRSE1=08 ou V_CODPFRSE1=09 ou V_CODPFRSE1=10
		        ou V_CODPFRSE1=11 ou V_CODPFRSE1=12 ou V_CODPFRSE1=17 ou V_CODPFRSE1=18
		        ou V_CODPFRSE1=31)
		    alors (1)
	            finsi)
	          finsi)
	        finsi)
	      finsi ;
NATMAJRSE1 = NATMAJRSE1I * (1 - positif(V_NBCODRSE1)) + 9 * positif(V_NBCODRSE1) ;
NATMAJRSE2I = present(CMAJ) +
	      si (V_CODPFRSE2=01) alors (1) sinon (
	        si (V_CODPFRSE2=02) alors (2)
	        sinon (
	 	  si (V_CODPFRSE2=03 ou V_CODPFRSE2=04 ou V_CODPFRSE2=05 ou V_CODPFRSE2=06
		      ou V_CODPFRSE2=22 ou V_CODPFRSE2=30 ou V_CODPFRSE2=55)
                  alors (4)
		  sinon (
		    si (V_CODPFRSE2=07 ou V_CODPFRSE2=08 ou V_CODPFRSE2=09 ou V_CODPFRSE2=10
		        ou V_CODPFRSE2=11 ou V_CODPFRSE2=12 ou V_CODPFRSE2=17 ou V_CODPFRSE2=18
		        ou V_CODPFRSE2=31)
		    alors (1)
	            finsi)
	          finsi)
	        finsi)
	      finsi ;
NATMAJRSE2 = NATMAJRSE2I * (1 - positif(V_NBCODRSE2)) + 9 * positif(V_NBCODRSE2) ;
NATMAJRSE3I = present(CMAJ) +
	      si (V_CODPFRSE3=01) alors (1) sinon (
	        si (V_CODPFRSE3=02) alors (2)
	        sinon (
	 	  si (V_CODPFRSE3=03 ou V_CODPFRSE3=04 ou V_CODPFRSE3=05 ou V_CODPFRSE3=06
		      ou V_CODPFRSE3=22 ou V_CODPFRSE3=30 ou V_CODPFRSE3=55)
                  alors (4)
		  sinon (
		    si (V_CODPFRSE3=07 ou V_CODPFRSE3=08 ou V_CODPFRSE3=09 ou V_CODPFRSE3=10
		        ou V_CODPFRSE3=11 ou V_CODPFRSE3=12 ou V_CODPFRSE3=17 ou V_CODPFRSE3=18
		        ou V_CODPFRSE3=31)
		    alors (1)
	            finsi)
	          finsi)
	        finsi)
	      finsi ;
NATMAJRSE3 = NATMAJRSE3I * (1 - positif(V_NBCODRSE3)) + 9 * positif(V_NBCODRSE3) ;
NATMAJRSE4I = present(CMAJ) +
	      si (V_CODPFRSE4=01) alors (1) sinon (
	        si (V_CODPFRSE4=02) alors (2)
	        sinon (
	 	  si (V_CODPFRSE4=03 ou V_CODPFRSE4=04 ou V_CODPFRSE4=05 ou V_CODPFRSE4=06
		      ou V_CODPFRSE4=22 ou V_CODPFRSE4=30 ou V_CODPFRSE4=55)
                  alors (4)
		  sinon (
		    si (V_CODPFRSE4=07 ou V_CODPFRSE4=08 ou V_CODPFRSE4=09 ou V_CODPFRSE4=10
		        ou V_CODPFRSE4=11 ou V_CODPFRSE4=12 ou V_CODPFRSE4=17 ou V_CODPFRSE4=18
		        ou V_CODPFRSE4=31)
		    alors (1)
	            finsi)
	          finsi)
	        finsi)
	      finsi ;
NATMAJRSE4 = NATMAJRSE4I * (1 - positif(V_NBCODRSE4)) + 9 * positif(V_NBCODRSE4) ;
NATMAJRSE5I = present(CMAJ) +
	      si (V_CODPFRSE5=01) alors (1) sinon (
	        si (V_CODPFRSE5=02) alors (2)
	        sinon (
	 	  si (V_CODPFRSE5=03 ou V_CODPFRSE5=04 ou V_CODPFRSE5=05 ou V_CODPFRSE5=06
		      ou V_CODPFRSE5=22 ou V_CODPFRSE5=30 ou V_CODPFRSE5=55)
                  alors (4)
		  sinon (
		    si (V_CODPFRSE5=07 ou V_CODPFRSE5=08 ou V_CODPFRSE5=09 ou V_CODPFRSE5=10
		        ou V_CODPFRSE5=11 ou V_CODPFRSE5=12 ou V_CODPFRSE5=17 ou V_CODPFRSE5=18
		        ou V_CODPFRSE5=31)
		    alors (1)
	            finsi)
	          finsi)
	        finsi)
	      finsi ;
NATMAJRSE5 = NATMAJRSE5I * (1 - positif(V_NBCODRSE5)) + 9 * positif(V_NBCODRSE5) ;
NATMAJRSE6I = present(CMAJ) +
	      si (V_CODPFRSE6=01) alors (1) sinon (
	        si (V_CODPFRSE6=02) alors (2)
	        sinon (
	 	  si (V_CODPFRSE6=03 ou V_CODPFRSE6=04 ou V_CODPFRSE6=05 ou V_CODPFRSE6=06
		      ou V_CODPFRSE6=22 ou V_CODPFRSE6=30 ou V_CODPFRSE6=55)
                  alors (4)
		  sinon (
		    si (V_CODPFRSE6=07 ou V_CODPFRSE6=08 ou V_CODPFRSE6=09 ou V_CODPFRSE6=10
		        ou V_CODPFRSE6=11 ou V_CODPFRSE6=12 ou V_CODPFRSE6=17 ou V_CODPFRSE6=18
		        ou V_CODPFRSE6=31)
		    alors (1)
	            finsi)
	          finsi)
	        finsi)
	      finsi ;
NATMAJRSE6 = NATMAJRSE6I * (1 - positif(V_NBCODRSE6)) + 9 * positif(V_NBCODRSE6) ;
MAJTXC = (1-positif(V_NBCODC)) * ( positif(CMAJ)*COPETO + TXPFC )
         + positif(V_NBCODC) * (-1) ;
MAJTXR = (1-positif(V_NBCODR)) * ( positif(CMAJ)*COPETO + TXPFR )
         + positif(V_NBCODR) * (-1) ;
MAJTXP = (1-positif(V_NBCODP)) * ( positif(CMAJ)*COPETO + TXPFP)
         + positif(V_NBCODP) * (-1) ;
MAJTXCVN = (1-positif(V_NBCODCVN)) * ( positif(CMAJ)*COPETO + TXPFCVN)
	    + positif(V_NBCODCVN) * (-1) ;
MAJTXCDIS = (1-positif(V_NBCODCDIS)) * ( positif(CMAJ)*COPETO + TXPFCDIS)
            + positif(V_NBCODCDIS) * (-1) ;
MAJTXGLOA = (1-positif(V_NBCODGLO)) * ( positif(CMAJ)*COPETO + TXPFGLO)
            + positif(V_NBCODGLO) * (-1) ;
MAJTXRSE5 = (1-positif(V_NBCODRSE5)) * ( positif(CMAJ)*COPETO + TXPFRSE5)
            + positif(V_NBCODRSE5) * (-1) ;
MAJTXRSE1 = (1-positif(V_NBCODRSE1)) * ( positif(CMAJ)*COPETO + TXPFRSE1)
            + positif(V_NBCODRSE1) * (-1) ;
MAJTXRSE2 = (1-positif(V_NBCODRSE2)) * ( positif(CMAJ)*COPETO + TXPFRSE2)
            + positif(V_NBCODRSE2) * (-1) ;
MAJTXRSE3 = (1-positif(V_NBCODRSE3)) * ( positif(CMAJ)*COPETO + TXPFRSE3)
            + positif(V_NBCODRSE3) * (-1) ;
MAJTXRSE4 = (1-positif(V_NBCODRSE4)) * ( positif(CMAJ)*COPETO + TXPFRSE4)
            + positif(V_NBCODRSE4) * (-1) ;
MAJTXRSE6 = (1-positif(V_NBCODRSE6)) * ( positif(CMAJ)*COPETO + TXPFRSE6)
            + positif(V_NBCODRSE6) * (-1) ;
TXC = (   RETX * positif_ou_nul(RETX) * positif(RETCS)
        + MAJTXC * positif_ou_nul(MAJTXC)* positif(NMAJC1)*null(1-NATMAJC)
        + MAJTXC1 * positif_ou_nul(MAJTXC1)* positif(NMAJC1)*(1-positif(MAJTXC))
        + MAJTXC4 * positif_ou_nul(MAJTXC4)*positif(NMAJC4)
      ) * positif_ou_nul (TXTO) * (1-positif(null(1+RETX)+null(1+MAJTXC)+null(1+MAJTXC1)+null(1+MAJTXC4)))
      + (-1) * positif (TXTO) * positif(null(1+RETX)+null(1+MAJTXC)+null(1+MAJTXC1)+null(1+MAJTXC4))
             * positif(RETCS+NMAJC1+NMAJC4)
      + (-1) * (1 - positif_ou_nul(TXTO)) * positif(TXTO * (-1));
TXR = (   RETX * positif_ou_nul(RETX) * positif(RETRD)
        + MAJTXR * positif_ou_nul(MAJTXR)* positif(NMAJR1)*null(1-NATMAJR)
        + MAJTXR1 * positif_ou_nul(MAJTXR1)* positif(NMAJR1)*(1-positif(MAJTXR))
        + MAJTXR4 * positif_ou_nul(MAJTXR4)*positif(NMAJR4)
      ) * positif_ou_nul (TXTO) * (1-positif(null(1+RETX)+null(1+MAJTXR)+null(1+MAJTXR1)+null(1+MAJTXR4)))
      + (-1) * positif (TXTO) * positif(null(1+RETX)+null(1+MAJTXR)+null(1+MAJTXR1)+null(1+MAJTXR4))
             * positif(RETRD+NMAJR1+NMAJR4)
      + (-1) * (1 - positif_ou_nul(TXTO)) * positif(TXTO * (-1));
TXP = (   RETX * positif_ou_nul(RETX) * positif(RETPS)
        + MAJTXP * positif_ou_nul(MAJTXP)* positif(NMAJP1)*null(1-NATMAJP)
        + MAJTXP1 * positif_ou_nul(MAJTXP1)* positif(NMAJP1)*(1-positif(MAJTXP))
        + MAJTXP4 * positif_ou_nul(MAJTXP4)*positif(NMAJP4)
      ) * positif_ou_nul (TXTO) * (1-positif(null(1+RETX)+null(1+MAJTXP)+null(1+MAJTXP1)+null(1+MAJTXP4)))
      + (-1) * positif (TXTO) * positif(null(1+RETX)+null(1+MAJTXP)+null(1+MAJTXP1)+null(1+MAJTXP4))
             * positif(RETPS+NMAJP1+NMAJP4)
      + (-1) * (1 - positif_ou_nul(TXTO)) * positif(TXTO * (-1));
TXCVN = (   RETX * positif_ou_nul(RETX) * positif(RETCVN)
        + MAJTXCVN * positif_ou_nul(MAJTXCVN)* positif(NMAJCVN1)*null(1-NATMAJCVN)
        + MAJTXCVN1 * positif_ou_nul(MAJTXCVN1)* positif(NMAJCVN1)*(1-positif(MAJTXCVN))
        + MAJTXCVN4 * positif_ou_nul(MAJTXCVN4)*positif(NMAJCVN4)
      ) * positif_ou_nul (TXTO) * (1-positif(null(1+RETX)+null(1+MAJTXCVN)+null(1+MAJTXCVN1)+null(1+MAJTXCVN4)))
      + (-1) * positif (TXTO) * positif(null(1+RETX)+null(1+MAJTXCVN)+null(1+MAJTXCVN1)+null(1+MAJTXCVN4))
             * positif(RETCVN+NMAJCVN1+NMAJCVN4)
      + (-1) * (1 - positif_ou_nul(TXTO)) * positif(TXTO * (-1));
TXCDIS = (   RETX * positif_ou_nul(RETX) * positif(RETCDIS)
        + MAJTXCDIS * positif_ou_nul(MAJTXCDIS)* positif(NMAJCDIS1)*null(1-NATMAJCDIS)
        + MAJTXCDIS1 * positif_ou_nul(MAJTXCDIS1)* positif(NMAJCDIS1)*(1-positif(MAJTXCDIS))
        + MAJTXCDIS4 * positif_ou_nul(MAJTXCDIS4)*positif(NMAJCDIS4)
      ) * positif_ou_nul (TXTO) * (1-positif(null(1+RETX)+null(1+MAJTXCDIS)+null(1+MAJTXCDIS1)+null(1+MAJTXCDIS4)))
      + (-1) * positif (TXTO) * positif(null(1+RETX)+null(1+MAJTXCDIS)+null(1+MAJTXCDIS1)+null(1+MAJTXCDIS4))
             * positif(RETCDIS+NMAJCDIS1+NMAJCDIS4)
      + (-1) * (1 - positif_ou_nul(TXTO)) * positif(TXTO * (-1));
TXGLOA = (   RETX * positif_ou_nul(RETX) * positif(RETGLOA)
        + MAJTXGLOA * positif_ou_nul(MAJTXGLOA)* positif(NMAJGLO1)*null(1-NATMAJGLOA)
        + MAJTXGLO1 * positif_ou_nul(MAJTXGLO1)* positif(NMAJGLO1)*(1-positif(MAJTXGLOA))
        + MAJTXGLO4 * positif_ou_nul(MAJTXGLO4)*positif(NMAJGLO4)
      ) * positif_ou_nul (TXTO) * (1-positif(null(1+RETX)+null(1+MAJTXGLOA)+null(1+MAJTXGLO1)+null(1+MAJTXGLO4)))
      + (-1) * positif (TXTO) * positif(null(1+RETX)+null(1+MAJTXGLOA)+null(1+MAJTXGLO1)+null(1+MAJTXGLO4))
             * positif(RETGLOA+NMAJGLO1+NMAJGLO4)
      + (-1) * (1 - positif_ou_nul(TXTO)) * positif(TXTO * (-1));
TXRSE1 = (   RETX * positif_ou_nul(RETX) * positif(RETRSE1)
        + MAJTXRSE1 * positif_ou_nul(MAJTXRSE1)* positif(NMAJRSE11)*null(1-NATMAJRSE1)
        + MAJTXRSE11 * positif_ou_nul(MAJTXRSE11)* positif(NMAJRSE11)*(1-positif(MAJTXRSE1))
        + MAJTXRSE14 * positif_ou_nul(MAJTXRSE14)*positif(NMAJRSE14)
      ) * positif_ou_nul (TXTO) * (1-positif(null(1+RETX)+null(1+MAJTXRSE1)+null(1+MAJTXRSE11)+null(1+MAJTXRSE14)))
      + (-1) * positif (TXTO) * positif(null(1+RETX)+null(1+MAJTXRSE1)+null(1+MAJTXRSE11)+null(1+MAJTXRSE14))
             * positif(RETRSE1+NMAJRSE11+NMAJRSE14)
      + (-1) * (1 - positif_ou_nul(TXTO)) * positif(TXTO * (-1));
TXRSE2 = (   RETX * positif_ou_nul(RETX) * positif(RETRSE2)
        + MAJTXRSE2 * positif_ou_nul(MAJTXRSE2)* positif(NMAJRSE21)*null(1-NATMAJRSE2)
        + MAJTXRSE21 * positif_ou_nul(MAJTXRSE21)* positif(NMAJRSE21)*(1-positif(MAJTXRSE2))
        + MAJTXRSE24 * positif_ou_nul(MAJTXRSE24)*positif(NMAJRSE24)
      ) * positif_ou_nul (TXTO) * (1-positif(null(1+RETX)+null(1+MAJTXRSE2)+null(1+MAJTXRSE21)+null(1+MAJTXRSE24)))
      + (-1) * positif (TXTO) * positif(null(1+RETX)+null(1+MAJTXRSE2)+null(1+MAJTXRSE21)+null(1+MAJTXRSE24))
             * positif(RETRSE2+NMAJRSE21+NMAJRSE24)
      + (-1) * (1 - positif_ou_nul(TXTO)) * positif(TXTO * (-1));
TXRSE3 = (   RETX * positif_ou_nul(RETX) * positif(RETRSE3)
        + MAJTXRSE3 * positif_ou_nul(MAJTXRSE3)* positif(NMAJRSE31)*null(1-NATMAJRSE3)
        + MAJTXRSE31 * positif_ou_nul(MAJTXRSE31)* positif(NMAJRSE31)*(1-positif(MAJTXRSE3))
        + MAJTXRSE34 * positif_ou_nul(MAJTXRSE34)*positif(NMAJRSE34)
      ) * positif_ou_nul (TXTO) * (1-positif(null(1+RETX)+null(1+MAJTXRSE3)+null(1+MAJTXRSE31)+null(1+MAJTXRSE34)))
      + (-1) * positif (TXTO) * positif(null(1+RETX)+null(1+MAJTXRSE3)+null(1+MAJTXRSE31)+null(1+MAJTXRSE34))
             * positif(RETRSE3+NMAJRSE31+NMAJRSE34)
      + (-1) * (1 - positif_ou_nul(TXTO)) * positif(TXTO * (-1));
TXRSE4 = (   RETX * positif_ou_nul(RETX) * positif(RETRSE4)
        + MAJTXRSE4 * positif_ou_nul(MAJTXRSE4)* positif(NMAJRSE41)*null(1-NATMAJRSE4)
        + MAJTXRSE41 * positif_ou_nul(MAJTXRSE41)* positif(NMAJRSE41)*(1-positif(MAJTXRSE4))
        + MAJTXRSE44 * positif_ou_nul(MAJTXRSE44)*positif(NMAJRSE44)
      ) * positif_ou_nul (TXTO) * (1-positif(null(1+RETX)+null(1+MAJTXRSE4)+null(1+MAJTXRSE41)+null(1+MAJTXRSE44)))
      + (-1) * positif (TXTO) * positif(null(1+RETX)+null(1+MAJTXRSE4)+null(1+MAJTXRSE41)+null(1+MAJTXRSE44))
             * positif(RETRSE4+NMAJRSE41+NMAJRSE44)
      + (-1) * (1 - positif_ou_nul(TXTO)) * positif(TXTO * (-1));
TXRSE5 = (   RETX * positif_ou_nul(RETX) * positif(RETRSE5)
        + MAJTXRSE5 * positif_ou_nul(MAJTXRSE5)* positif(NMAJRSE51)*null(1-NATMAJRSE5)
        + MAJTXRSE51 * positif_ou_nul(MAJTXRSE51)* positif(NMAJRSE51)*(1-positif(MAJTXRSE5))
        + MAJTXRSE54 * positif_ou_nul(MAJTXRSE54)*positif(NMAJRSE54)
      ) * positif_ou_nul (TXTO) * (1-positif(null(1+RETX)+null(1+MAJTXRSE5)+null(1+MAJTXRSE51)+null(1+MAJTXRSE54)))
      + (-1) * positif (TXTO) * positif(null(1+RETX)+null(1+MAJTXRSE5)+null(1+MAJTXRSE51)+null(1+MAJTXRSE54))
             * positif(RETRSE5+NMAJRSE51+NMAJRSE54)
      + (-1) * (1 - positif_ou_nul(TXTO)) * positif(TXTO * (-1));
TXRSE6 = (   RETX * positif_ou_nul(RETX) * positif(RETRSE6)
        + MAJTXRSE6 * positif_ou_nul(MAJTXRSE6)* positif(NMAJRSE61)*null(1-NATMAJRSE6)
        + MAJTXRSE61 * positif_ou_nul(MAJTXRSE61)* positif(NMAJRSE61)*(1-positif(MAJTXRSE6))
        + MAJTXRSE64 * positif_ou_nul(MAJTXRSE64)*positif(NMAJRSE64)
      ) * positif_ou_nul (TXTO) * (1-positif(null(1+RETX)+null(1+MAJTXRSE6)+null(1+MAJTXRSE61)+null(1+MAJTXRSE64)))
      + (-1) * positif (TXTO) * positif(null(1+RETX)+null(1+MAJTXRSE6)+null(1+MAJTXRSE61)+null(1+MAJTXRSE64))
             * positif(RETRSE6+NMAJRSE61+NMAJRSE64)
      + (-1) * (1 - positif_ou_nul(TXTO)) * positif(TXTO * (-1));
regle 221710:
application : batch , iliad ;

WMTAP =  (1 - positif(V_ZDC+0)) * positif(NAT1 + NAT71)* max(0,IINET-max(0,IHAUTREVT+ min(0,LOYELEVNEG))-PTOTIRCS);
MTAP = max(0, (V_ACO_MTAP * null(2-FLAG_ACO) + WMTAP * (1-null(2-FLAG_ACO))) * (1 - INDTXMIN) * (1 - INDTXMOY )
                       +
                              (
                                 (V_ACO_MTAP * null(2-FLAG_ACO) + WMTAP * (1-null(2-FLAG_ACO)))  * positif(INDTXMIN+INDTXMOY)
                              ) * positif(V_ACO_MTAP* null(2-FLAG_ACO) + WMTAP * (1-null(2-FLAG_ACO)) - SEUIL_ACOMPTE)
           );
sortie(V_CALCUL_ACO);
regle 221720:
application : iliad ;

pour x=01..12,30,31,55:
RAP_UTIx = NUTOTx_D * positif(APPLI_OCEANS) ;

regle 221730:
application : iliad ;

pour x=02..12,30,31,55;i=RF,BA,LO,NC,CO:
RAPi_REPx = NViDx_D * positif(APPLI_OCEANS) ;

regle 221740:
application : iliad ;

pour i=01..12,30,31,55:
RAPCO_Ni = NCCOi_D * positif(APPLI_OCEANS) ;

regle 221750:
application : iliad ;

FPV = FPTV - DEDSV* positif(APPLI_OCEANS);
FPC = FPTC - DEDSC* positif(APPLI_OCEANS);
FPP = somme(i=1..4: FPTi) - DEDSP* positif(APPLI_OCEANS);
DIMBA = (positif(DEFIBA) * abs(BANOR) + present(DAGRI6) * DAGRI6
                                      + present(DAGRI5) * DAGRI5
                                      + present(DAGRI4) * DAGRI4
                                      + present(DAGRI3) * DAGRI3
                                      + present(DAGRI2) * DAGRI2
                                      + present(DAGRI1) * DAGRI1) * positif(APPLI_OCEANS) ;

regle 221760:
application : batch , iliad ;

IMPNET = null(4 - V_IND_TRAIT) * (IINET + IREST * (-1))
	 + null(5 - V_IND_TRAIT) * 
		(positif(IDEGR) * positif(IREST) * positif(SEUIL_8 - IREST) * IDEGR * (-1)
		+ (1 - positif(positif(IDEGR) * positif(IREST) * positif(SEUIL_8 - IREST))) * (IINET - IREST - IDEGR))
		;
IMPNETIR = (NAPTIR - V_ANTIR-V_PCAPANT-V_TAXANT-V_TAXLOYANT-V_CHRANT) * null(4 - V_IND_TRAIT)
	    + (IMPNET - IMPNETPS) * null(5-V_IND_TRAIT);
IMPNETCS =  NAPCS - V_CSANT;
IMPNETRD = NAPRD - V_RDANT ;
IMPNETPRS = NAPPS - V_PSANT ;
IMPNETCSAL = NAPCVN - V_CVNANT ;
IMPNETCDIS = NAPCDIS - V_CDISANT ;
IMPNETGLO = NAPGLOA - V_GLOANT ;
IMPNETRSE = NAPRSE1 + NAPRSE2 + NAPRSE3 + NAPRSE4 + NAPRSE5 
          - V_RSE1ANT- V_RSE2ANT- V_RSE3ANT- V_RSE4ANT- V_RSE5ANT ;
IMPNETRSE6 =  NAPRSE6 - V_RSE6ANT ;

BASEXOGEN = (1-present(IPTEFP)) * 
            max(0,( RG+ TOTALQUO))*(1-positif(APPLI_COLBERT));
MONTNETCS = (PRS + PTOPRS)*(1-positif(APPLI_COLBERT));
DBACT = si ((APPLI_COLBERT=0) et ( present(RDCOM)=1 et present(NBACT)=0 ))
        alors (0)
        sinon (NBACT)
        finsi;

regle 221770:
application : iliad , batch ;

IMPNETPS = NAPCR61 - V_ANTCR ;

regle 221780:
application : iliad , batch ;

RECUMBIS = si (V_NIMPA+0 = 1)
           alors (V_ANTRE+RECUM_A)
           sinon ((V_ANTRE+RECUM_A) * positif_ou_nul((V_ANTRE+RECUM_A) - SEUIL_8))
           finsi;
RECUMBISIR = si (V_NIMPAIR+0 = 1)
                alors (V_ANTREIR)
                sinon (V_ANTREIR * positif_ou_nul(V_ANTREIR - SEUIL_8))
             finsi;

regle 221790:
application : iliad , batch ;

IRCUMBIS = si
               (( (V_ANTIR + IRCUM_A - (IRNET+IRANT) * positif(IRNET+IRANT) - TAXANET - PCAPNET - TAXLOYNET - HAUTREVNET 
	          + (V_ANTCR-CSTOT)) > 0 et
                 (V_ANTIR + IRCUM_A - (IRNET+IRANT) * positif(IRNET+IRANT) - TAXANET - PCAPNET - TAXLOYNET - HAUTREVNET  
		 + (V_ANTCR-CSTOT)) < SEUIL_8 )
                 ou
                  ( (TAXANET + PCAPNET + TAXLOYNET + HAUTREVNET + (IRNET+IRANT) * positif(IRNET+IRANT) - V_ANTIR- IRCUM_A
		  + (CSTOT-V_ANTCR)) > 0 et
                    (TAXANET + PCAPNET+ TAXLOYNET  + HAUTREVNET + (IRNET+IRANT) * positif(IRNET+IRANT) - V_ANTIR- IRCUM_A 
		    + (CSTOT-V_ANTCR)) < SEUIL_12 ) )
                 alors
                      (V_ANTIR + IRCUM_A + 0)
                 sinon
                      (IRNET + IRANT)
                 finsi ;

regle 221800:
application : iliad , batch ;


TOTAXAGA = si ((APPLI_COLBERT=0) et  (IRNET - V_ANTIR + TAXANET - V_TAXANT + PCAPNET - V_PCAPANT+TAXLOYNET-V_TAXLOYANT+ HAUTREVNET - V_CHRANT >= SEUIL_12)
                ou ( (-IRNET + V_ANTIR - TAXANET + V_TAXANT  - PCAPNET + V_PCAPANT-TAXLOYNET+V_TAXLOYANT- HAUTREVNET + V_CHRANT ) >= SEUIL_8) )
                alors(TAXANET * positif(TAXACUM))
                sinon(V_TAXANT * positif(TAXACUM) + 0 )
                finsi;
PCAPTOT = si ((APPLI_COLBERT=0) et ( (IRNET - V_ANTIR + TAXANET - V_TAXANT + PCAPNET - V_PCAPANT +TAXLOYNET-V_TAXLOYANT+ HAUTREVNET - V_CHRANT>= SEUIL_12)
                ou ( (-IRNET + V_ANTIR - TAXANET + V_TAXANT - PCAPNET + V_PCAPANT  -TAXLOYNET+V_TAXLOYANT- HAUTREVNET + V_CHRANT) >= SEUIL_8) ))
                alors(PCAPNET * positif(PCAPCUM))
                sinon(V_PCAPANT * positif(PCAPCUM) + 0 )
                finsi;
TAXLOYTOT = si ((APPLI_COLBERT=0) et ( (IRNET - V_ANTIR + TAXANET - V_TAXANT + PCAPNET - V_PCAPANT +TAXLOYNET-V_TAXLOYANT+ HAUTREVNET - V_CHRANT>= SEUIL_12)
                ou ( (-IRNET + V_ANTIR - TAXANET + V_TAXANT - PCAPNET + V_PCAPANT  -TAXLOYNET+V_TAXLOYANT- HAUTREVNET + V_CHRANT) >= SEUIL_8) ))
                alors(TAXLOYNET * positif(TAXLOYCUM))
                sinon(V_TAXLOYANT * positif(TAXLOYCUM) + 0 )
                finsi;
HAUTREVTOT = si ((APPLI_COLBERT=0) et ( (IRNET - V_ANTIR + TAXANET - V_TAXANT + PCAPNET - V_PCAPANT +TAXLOYNET-V_TAXLOYANT+ HAUTREVNET - V_CHRANT >= SEUIL_12)
                ou ( (-IRNET + V_ANTIR - TAXANET + V_TAXANT - PCAPNET + V_PCAPANT  -TAXLOYNET+V_TAXLOYANT- HAUTREVNET + V_CHRANT ) >= SEUIL_8) ))
                alors(HAUTREVNET * positif(HAUTREVCUM))
                sinon(V_CHRANT * positif(HAUTREVCUM) + 0 )
                finsi;

regle isf 221810:
application : iliad , batch ;
  
ISFCUM = null (4 - V_IND_TRAIT) *
                                (ISFNET * positif_ou_nul (ISFNET - SEUIL_12)
	                                + min( 0, ISFNET) * positif( SEUIL_12 - ISFNET )
	                        )

	 + null(5 - V_IND_TRAIT)*
				(positif(SEUIL_12 - ISF4BIS) * 0 
	                         + (1-positif(SEUIL_12 - ISF4BIS)) * 
				     (
	                                 positif(positif_ou_nul(-ISFNET + V_ANTISF - SEUIL_8) 
				                 + positif_ou_nul(ISFNET - V_ANTISF - SEUIL_12)
				                ) * ISFNET
	                              + (1-positif(positif_ou_nul(-ISFNET + V_ANTISF - SEUIL_8) 
						   + positif_ou_nul(ISFNET - V_ANTISF - SEUIL_12)
						  )
					) * V_ANTISF
			             )
                                )* (1-positif(APPLI_OCEANS));

regle 221820:
application : iliad , batch ;

INDSEUIL61 = positif_ou_nul(IAMD1 - SEUIL_61);
INDSEUIL12 = positif_ou_nul(max(0 , CSNET+RDNET+PRSNET+CVNNET+CDISNET
                                   +CGLOANET+RSE1NET+RSE2NET+RSE3NET+RSE4NET
                                   +RSE5NET+RSE6NET )- SEUIL_12);
INDSEUIL12IR = positif_ou_nul(IRNET+TAXANET+PCAPNET+TAXLOYNET+HAUTREVNET - SEUIL_12);

regle 221830:
application : iliad , batch ;

NONRESTEMP2 = (IDEGR + max(0,V_NONRESTANT - V_ANTRE - min(0,NAPTEMP))) * positif(SEUIL_8 - IDEGR - max(0,V_NONRESTANT - V_ANTRE - min(0,NAPTEMP))) * positif(NAPCRTEMP - V_ANTCR); 

regle 221840:
application : iliad , batch ;


NAPTEMP = positif(positif(SEUIL_8 - abs(IRPSCUM - RECUM)) * (1-positif(IRPSCUM-RECUM))+ positif(SEUIL_12 - IRPSCUM - RECUM)*positif(IRPSCUM-RECUM)) * 0 
        + (1-positif(positif(SEUIL_8 - abs(IRPSCUM - RECUM)) * (1-positif(IRPSCUM-RECUM))+ positif(SEUIL_12 - IRPSCUM - RECUM)*positif(IRPSCUM-RECUM)))*(IRPSCUM - RECUM) ;

regle 221850:
application : iliad , batch ;


NAPTEMPCX = IRPSCUM - NONMER - RECUM + (NONREST * positif(IRPSCUM - RECUM - TOTIRPSANT + 0)) ; 

regle 221860:
application : iliad , batch ;

VARPS61 =  CSG + RDSN + PRS + PCSG + PRDS + PPRS + CVNN + PCVN + CDIS + PCDIS  
           + CGLOA + PGLOA + RSE1N + PRSE1 + RSE2N + PRSE2 + RSE3N + PRSE3 + RSE4N + PRSE4 
           + RSE5N + PRSE5 + RSE6N + PRSE6
           - CSGIM - CRDSIM - PRSPROV - COD8YT - CDISPROV -COD8YL-CSPROVYD-CSPROVYE-CSPROVYF-CSPROVYN
           -CSPROVYG-CSPROVYH-CSPROVYP+0 ;
VARIR61 = IAMD1 +V_ANTREIR+0;
VARIR12 = RASAR + NRINET + IMPRET+0;

regle 221870:
application : iliad , batch ;

TAXACUM    =   (1-positif(IRESTITIR)) * (
              positif( positif(SEUIL_61-VARIR61) * positif(SEUIL_61-VARIRDROIT) * (1-INDTXMIN) * null(TOTPENIR)
                       + positif_ou_nul(SEUIL_TXMIN - IAMD1) * positif(SEUIL_TXMIN-VARIR61) * positif(SEUIL_TXMIN-VARIRDROIT) * INDTXMIN * null(TOTPENIR)
                     ) * 0

          + (1-positif( positif(SEUIL_61-VARIR61) * positif(SEUIL_61-VARIRDROIT) * (1-INDTXMIN) * null(TOTPENIR)
             + positif_ou_nul(SEUIL_TXMIN - IAMD1) * positif(SEUIL_TXMIN-VARIR61) * positif(SEUIL_TXMIN-VARIRDROIT) * INDTXMIN * null(TOTPENIR))
            ) * TAXANET
                                         );

PCAPCUM    =   (1-positif(IRESTITIR)) * (
              positif( positif(SEUIL_61-VARIR61) * positif(SEUIL_61-VARIRDROIT) * (1-INDTXMIN) * null(TOTPENIR)
                       + positif_ou_nul(SEUIL_TXMIN - IAMD1) * positif(SEUIL_TXMIN-VARIR61) * positif(SEUIL_TXMIN-VARIRDROIT) * INDTXMIN * null(TOTPENIR)
                     ) * 0

          + (1-positif( positif(SEUIL_61-VARIR61) * positif(SEUIL_61-VARIRDROIT) * (1-INDTXMIN)* null(TOTPENIR)
             + positif_ou_nul(SEUIL_TXMIN - IAMD1) * positif(SEUIL_TXMIN-VARIR61) * positif(SEUIL_TXMIN-VARIRDROIT) * INDTXMIN * null(TOTPENIR))
            ) * PCAPNET
                                         );

TAXLOYCUM  =   (1-positif(IRESTITIR)) * (
              positif( positif(SEUIL_61-VARIR61) * positif(SEUIL_61-VARIRDROIT) * (1-INDTXMIN) * null(TOTPENIR)
                       + positif_ou_nul(SEUIL_TXMIN - IAMD1) * positif(SEUIL_TXMIN-VARIR61) * positif(SEUIL_TXMIN-VARIRDROIT) * INDTXMIN * null(TOTPENIR)
                     ) * 0

          + (1-positif( positif(SEUIL_61-VARIR61) * positif(SEUIL_61-VARIRDROIT) * (1-INDTXMIN)* null(TOTPENIR)
             + positif_ou_nul(SEUIL_TXMIN - IAMD1) * positif(SEUIL_TXMIN-VARIR61) * positif(SEUIL_TXMIN-VARIRDROIT) * positif(SEUIL_TXMIN-VARIRDROIT) * INDTXMIN * null(TOTPENIR))
            ) * TAXLOYNET
                                         );

HAUTREVCUM =   (1-positif(IRESTITIR)) * (
              positif( positif(SEUIL_61-VARIR61) * positif(SEUIL_61-VARIRDROIT) * (1-INDTXMIN) * null(TOTPENIR)
                       + positif_ou_nul(SEUIL_TXMIN - IAMD1) * positif(SEUIL_TXMIN-VARIR61) * positif(SEUIL_TXMIN-VARIRDROIT) * INDTXMIN * null(TOTPENIR)
                     ) * 0

          + (1-positif( positif(SEUIL_61-VARIR61) * positif(SEUIL_61-VARIRDROIT) * (1-INDTXMIN)* null(TOTPENIR)
             + positif_ou_nul(SEUIL_TXMIN - IAMD1) * positif(SEUIL_TXMIN-VARIR61) * positif(SEUIL_TXMIN-VARIRDROIT) * INDTXMIN * null(TOTPENIR))
            ) * HAUTREVNET
                                         );

IRCUM    =   (1-positif(IRESTITIR)) * (
              positif( positif(SEUIL_61-VARIR61) * positif(SEUIL_61-VARIRDROIT) * (1-INDTXMIN) * null(TOTPENIR)
                       + positif_ou_nul(SEUIL_TXMIN - IAMD1) * positif(SEUIL_TXMIN-VARIR61) * positif(SEUIL_TXMIN-VARIRDROIT) * INDTXMIN * null(TOTPENIR)
                     ) * 0

          + (1-positif( positif(SEUIL_61-VARIR61) * positif(SEUIL_61-VARIRDROIT) * (1-INDTXMIN)* null(TOTPENIR)
             + positif_ou_nul(SEUIL_TXMIN - IAMD1) * positif(SEUIL_TXMIN-VARIR61) * positif(SEUIL_TXMIN-VARIRDROIT) * INDTXMIN * null(TOTPENIR))
            ) * IRNET
                                         );

TOTIRCUM = IRCUM + TAXACUM + PCAPCUM +TAXLOYCUM +HAUTREVCUM; 
RECUM =    max(0,-(TOTIRCUM - RECUMIR + NAPCR61));
IRPSCUM =  max(0,TOTIRCUM - RECUMIR + NAPCR61);

regle 221880:
application : iliad , batch ;


RECUMIR = positif(IRESTITIR) * IRESTITIR ;

regle 221890:
application : iliad , batch ;


TOTIRPS = (IRPSCUM - NONMER + NONREST - RECUM) ;

regle 221900:
application : batch , iliad ;

CSTOT = max(0,CSG + RDSN + PRS + PCSG + PRDS + PPRS + CVNN + PCVN + CDIS + PCDIS
              + CGLOA + PGLOA + RSE1N + PRSE1 + RSE2N + PRSE2 + RSE3N + PRSE3 + RSE4N + PRSE4
              + RSE5N + PRSE5 + RSE6N + PRSE6);

regle 221910:
application : iliad , batch ;

TOTCRBIS = si (
               ( (V_ANTCR-CSTOT>0) et (V_ANTCR-CSTOT<SEUIL_8)
                 et (CSTOT >= SEUIL_61) )
               ou (
                   (CSTOT-V_ANTCR>0) et (CSTOT-V_ANTCR<SEUIL_61)
                   et (V_IND_TRAIT=4)
                  )
               ou (
                   (CSTOT-V_ANTCR>0) et (CSTOT-V_ANTCR<SEUIL_12)
                   et (V_IND_TRAIT>4)
                  )
              )
           alors (V_ANTCR + 0)
           sinon (CSTOT * positif_ou_nul(CSTOT - SEUIL_61))
           finsi;
TOTCR = si ( (TOTCRBIS - CSGIM - CRDSIM - PRSPROV - COD8YT - CDISPROV -COD8YL-CSPROVYD-CSPROVYE-CSPROVYF-CSPROVYN-CSPROVYG-CSPROVYH-CSPROVYP < SEUIL_61)
             et (CSGIM + CRDSIM + PRSPROV + COD8YT + CDISPROV +COD8YL+CSPROVYD+CSPROVYE+CSPROVYF+CSPROVYG+CSPROVYH+0>0) )
        alors (CSGIM + CRDSIM + PRSPROV + COD8YT + CDISPROV +COD8YL+CSPROVYD+CSPROVYE+CSPROVYF+CSPROVYN+CSPROVYG+CSPROVYH+CSPROVYP+0)
        sinon (TOTCRBIS+0)
        finsi;


regle 221920:
application : iliad , batch ;

CSNETEMP = CSNET * INDSEUIL61;
PSNETEMP = PRSNET * INDSEUIL61;
RDNETEMP = RDNET * INDSEUIL61;
CVNNETEMP = CVNNET * INDSEUIL61;
CDISNETEMP = CDISNET * INDSEUIL61;
GLONETEMP = CGLOANET * INDSEUIL61;
RSE1NETEMP = RSE1NET * INDSEUIL61;
RSE2NETEMP = RSE2NET * INDSEUIL61;
RSE3NETEMP = RSE3NET * INDSEUIL61;
RSE4NETEMP = RSE4NET * INDSEUIL61;
RSE5NETEMP = RSE5NET * INDSEUIL61;
RSE6NETEMP = RSE6NET * INDSEUIL61;

regle 221930:
application : iliad , batch ;

NAPCRP = max(0 , CSNET+RDNET+PRSNET+CVNNET+CDISNET+CGLOANET+RSE1NET+RSE2NET+RSE3NET+RSE4NET
                 +RSE5NET+RSE6NET );
NAPCRTOT = NAPCRP;

regle 221940:
application : iliad , batch ;


NAPCR = null(4-V_IND_TRAIT)
               * max(0 ,  TOTCR - CSGIM - CRDSIM - PRSPROV - CDISPROV -COD8YL
                                -CSPROVYD-CSPROVYE-CSPROVYF-CSPROVYN-CSPROVYG-CSPROVYH-CSPROVYP-COD8YT)
               * positif_ou_nul((TOTCR - CSGIM - CRDSIM - PRSPROV - CDISPROV -COD8YL
                                       -CSPROVYD-CSPROVYE-CSPROVYF-CSPROVYN-CSPROVYG-CSPROVYH-CSPROVYP-COD8YT) - SEUIL_61)
        + null(5-V_IND_TRAIT)
               * max(0 , (TOTCR - CSGIM - CRDSIM - PRSPROV - CDISPROV -COD8YL
                                -CSPROVYD-CSPROVYE-CSPROVYF-CSPROVYN-CSPROVYG-CSPROVYH-CSPROVYP-COD8YT) - TOTCRA )
               * positif_ou_nul((TOTCR - CSGIM - CRDSIM - PRSPROV - CDISPROV -COD8YL
                                       -CSPROVYD-CSPROVYE-CSPROVYF-CSPROVYN-CSPROVYG-CSPROVYH-CSPROVYP-COD8YT) -
                         TOTCRA - SEUIL_12);
NAPCRBIS = null(4-V_IND_TRAIT)
               * max(0 ,  TOTCR - CSGIM - CRDSIM - PRSPROV - CDISPROV -COD8YL-CSPROVYD-CSPROVYE-CSPROVYF-CSPROVYG-CSPROVYH-COD8YT)
        * positif_ou_nul((TOTCR - CSGIM - CRDSIM - PRSPROV - CDISPROV -COD8YL-CSPROVYD-CSPROVYE-CSPROVYF-CSPROVYG-CSPROVYH-COD8YT) - SEUIL_61)
        + null(5-V_IND_TRAIT)
               * max(0 , (TOTCR - CSGIM - CRDSIM - PRSPROV - CDISPROV -COD8YL-CSPROVYD-CSPROVYE-CSPROVYF-CSPROVYG-CSPROVYH-COD8YT) - TOTCRA )
        * positif_ou_nul((TOTCR - CSGIM - CRDSIM - PRSPROV - CDISPROV -COD8YL-CSPROVYD-CSPROVYE-CSPROVYF-CSPROVYG-CSPROVYH-COD8YT) -
                         TOTCRA - SEUIL_12);
NAPCRINR = null(4-V_IND_TRAIT)
               * max(0 ,  CSTOT - CSGIM - CRDSIM - PRSPROV - CDISPROV -COD8YL-CSPROVYD-CSPROVYE-CSPROVYF-CSPROVYG-CSPROVYH-COD8YT)
        + null(5-V_IND_TRAIT)
               * max(0 , (CSTOT - CSGIM - CRDSIM - PRSPROV - CDISPROV -COD8YL-CSPROVYD-CSPROVYE-CSPROVYF-CSPROVYG-CSPROVYH-COD8YT) );
NAPCR61 = NAPCS + NAPRD +NAPPS +NAPCVN + NAPCDIS +NAPGLOA + NAPRSE1 + NAPRSE2 + NAPRSE3 + NAPRSE4 
        + NAPRSE5 +NAPRSE6 ;

regle 221950:
application : iliad , batch ;


CRDEG = max(0 , TOTCRA - TOTCR) * positif_ou_nul(TOTCRA - (TOTCR - SEUIL_8)) ;

regle 221960:
application : iliad ;


CS_DEG = max(0 , TOTCRA - CSTOT * positif_ou_nul(CSTOT - SEUIL_61)) * ( 1-positif(APPLI_OCEANS));

ECS_DEG = arr((CS_DEG / TAUX_CONV) * 100) / 100 * ( 1-positif(APPLI_OCEANS));

regle 221970:
application: batch , iliad ;


ABSPE = (1-positif(NDA)) * 9
        +
        positif(NAB) * (1-positif(NAB-1)) * (1-positif(NDA-1)) * positif (NDA)
        +
        positif(NAB-1) * (1-positif(NDA-1)) * positif(NDA) * 2
        +
        positif(NAB) * (1-positif(NAB-1)) * positif(NDA-1) * 3
        +
        positif(NAB-1) * positif(NDA-1) * 6;

INDDG =  positif(DAR - RG - TOTALQUO) * positif(DAR) ;

INDEXOGEN = 1 - EXO1 ;

regle 221980:
application : batch , iliad ;

CODINI =  99 * positif(NATIMP)
        + 0 * null(NATIMP)
        ;

regle 221990:
application :batch , iliad ;

NAT1 =            (1-positif(V_IND_TRAIT - 4)) * positif(NAPT)
                  +
                   positif(V_IND_TRAIT - 4) * positif(positif_ou_nul(IRPSCUM-SEUIL_12) *  null(NAPT) + positif(NAPT));
NAT1BIS = (positif (IRANT)) * (1 - positif (NAT1) )
          * (1 - positif(IDEGR))+0;
NAT11 = (11 * IND_REST * (1 - positif(IDEGR)) * positif(IRE-IRESTIT)) * (1-positif(V_IND_TRAIT - 4))
        + (11*positif(V_IND_TRAIT - 4) * positif(SEUIL_12 - V_IRPSANT) * positif(IRESTIT) * positif(IRE - IRESTIT)) * (1-positif_ou_nul(NAPT))     ;
NAT21 = (21 * IND_REST * (1 - positif(IDEGR)) * (1 - positif(IRE-IRESTIT))) * (1-positif(V_IND_TRAIT - 4))
        + (21*positif(V_IND_TRAIT - 4) * positif(SEUIL_12 - V_IRPSANT) * positif(IRESTIT) * null(IRE - IRESTIT))* (1-positif_ou_nul(NAPT));
NAT70 = 70 * null(NAPTEMPCX)* (1-positif_ou_nul(NAPT));
NAT71 = 71 * positif(NAPTEMPCX) * (1-positif_ou_nul(NAPT));
NAT81 = 81 * positif_ou_nul(V_IRPSANT-SEUIL_12) * positif(IRESTIT) * positif(IRE - IRESTIT)* (1-positif_ou_nul(NAPT));
NAT91 = 91 * positif_ou_nul(V_IRPSANT-SEUIL_12) * positif(IRESTIT) * null(IRE - IRESTIT)* (1-positif_ou_nul(NAPT));
NATIMP = ( NAT1 + NAT1BIS +
             (1-positif(NAT1+NAT1BIS))*(NAT11 + NAT21 + NAT70 + NAT71 + NAT81 + NAT91) );

regle 222000:
application : batch , iliad ;

NATIMPIR = null(V_IND_TRAIT - 4) 
	    * positif (positif(NAPTOT - NAPTOTAIR - IRANT) * positif_ou_nul(IAMD1 - SEUIL_61)
                       * positif_ou_nul(IRNET + TAXANET + TAXLOYNET + PCAPNET + HAUTREVNET - SEUIL_12)
                       + positif(IRE - IRESTITIR) * positif(IRESTITIR))

           + null(V_IND_TRAIT - 5) * positif(positif_ou_nul(IAMD1 - SEUIL_61) + positif_ou_nul(RASAR + NRINET + IMPRET - SEUIL_12)) ;


regle 222010:
application : iliad , batch ;

NATCRP = si (NAPCR > 0) 
         alors (1)
         sinon (si (NAPCRP + 0 > 0)
                alors (2)
                sinon (si (CRDEG+0>0)
                       alors (3)
                       sinon (0)
                       finsi
                      )
                finsi
               )
         finsi;

regle isf 222020:
application : iliad , batch ;

NATIMPISF = max (0, (1 * positif(ISFCUM)

	          + 2 * (1 - positif(ISFCUM)) * (1 - null(ISFNET))

                  + 3 *  null(ISFNET) * positif(ISFBASE) 
	                
                  + 0 * (null(INDCTX23) * null(5-V_IND_TRAIT) * null(ISFBASE)
                         + positif_ou_nul(ISF_LIMINF + ISF_LIMSUP) * null(4-V_IND_TRAIT)))
		 );
		  

regle 222030:
application : iliad , batch  ;


IFG = positif(min(PLAF_REDGARD,RDGARD1) + min(PLAF_REDGARD,RDGARD2)
            + min(PLAF_REDGARD,RDGARD3) + min(PLAF_REDGARD,RDGARD4) 
            - max(0,RP)) * positif(somme(i=1..4:RDGARDi));

regle 222040:
application : batch , iliad ;


INDGARD = IFG + 9 * (1 - positif(IFG)) ;

regle 222050:
application : batch , iliad ;

DEFTS = (1 - positif(somme(i=V,C,1..4:TSNTi + PRNNi) -  somme(i=1..3:GLNi)) ) *
      abs( somme(i=V,C,1..4:TSNTi + PRNNi) - somme(i=1..3:GLNi) )*(1-positif(APPLI_COLBERT)) ;
PRN = (1 - positif(DEFTS)) * 
       ( somme(i=V,C,1..4:PRNi) + min(0,somme(i=V,C,1..4:TSNi)))*(1-positif(APPLI_COLBERT));
TSN = (1 - positif(DEFTS)) * ( somme(i=V,C,1..4:TPRi) - PRN )*(1-positif(APPLI_COLBERT));

regle 222060:
application : batch , iliad ;


REVDECTAX = (
   TSHALLOV
 + ALLOV
 + TSHALLOC
 + ALLOC
 + TSHALLO1
 + ALLO1
 + TSHALLO2
 + ALLO2
 + TSHALLO3
 + ALLO3
 + TSHALLO4
 + ALLO4
 + PALIV
 + PALIC
 + PALI1
 + PALI2
 + PALI3
 + PALI4
 + PRBRV
 + PRBRC 
 + PRBR1 
 + PRBR2 
 + PRBR3 
 + PRBR4 
 + RVB1 
 + RVB2 
 + RVB3 
 + RVB4 
 + GLDGRATV 
 + GLDGRATC 

 + REGPRIV
 + BICREP
 + RCMABD
 + RCMTNC 
 + RCMAV 
 + RCMHAD
 + RCMHAB
 + PPLIB
 + RCMLIB
 + BPV40V
 + BPVRCM
 - DPVRCM
 + BPCOPTV
 + BPCOSAV 
 + BPCOSAC 
 + PEA
 + GLD1V 
 + GLD1C 
 + GLD2V 
 + GLD2C 
 + GLD3V 
 + GLD3C 
 + RFORDI
 - RFDORD
 - RFDHIS
 - RFDANT
 + RFMIC 
 + BNCPRO1AV  
 + BNCPRO1AC  
 + BNCPRO1AP  
 + BACREV 
 + BACREC 
 + BACREP 
 + BAHREV 
 + BAHREC 
 + BAHREP 
 + BAFV 
 + BAFC 
 + BAFP 
 - BACDEV
 - BACDEC
 - BACDEP
 - BAHDEV
 - BAHDEC
 - BAHDEP
 - DAGRI6
 - DAGRI5
 - DAGRI4
 - DAGRI3
 - DAGRI2
 - DAGRI1
 + BICNOV 
 + BICNOC
 + BICNOP
 + BIHNOV 
 + BIHNOC 
 + BIHNOP 
 - BICDNV 
 - BICDNC
 - BICDNP
 - BIHDNV
 - BIHDNC
 - BIHDNP
 + BICREV 
 + BICREC 
 + BICHREV 
 + BICHREC 
 + BICHREP 
 - BICDEV
 - BICDEC
 - BICDEP
 - BICHDEV
 - BICHDEC
 - BICHDEP
 + BNCREV 
 + BNCREC 
 + BNCREP 
 + BNHREV 
 + BNHREC 
 + BNHREP 
 - BNCDEV
 - BNCDEC
 - BNCDEP
 - BNHDEV
 - BNHDEC
 - BNHDEP
 + ANOCEP 
 - DNOCEP
 + BAFPVV 
 + BAFPVC 
 + BAFPVP 
 + BAF1AV 
 + BAF1AC 
 + BAF1AP 
 + MIBVENV 
 + MIBVENC 
 + MIBVENP 
 + MIBPRESV 
 + MIBPRESC 
 + MIBPRESP 
 + MIBPVV 
 + MIBPVC 
 + MIBPVP 
 - BICPMVCTV
 - BICPMVCTC
 - BICPMVCTP
 + MIBNPVENV 
 + MIBNPVENC 
 + MIBNPVENP 
 + MIBNPPRESV 
 + MIBNPPRESC 
 + MIBNPPRESP 
 + MIBNPPVV 
 + MIBNPPVC 
 + MIBNPPVP 
 - MIBNPDCT
 - DEFBIC6
 - DEFBIC5
 - DEFBIC4
 - DEFBIC3
 - DEFBIC2
 - DEFBIC1
 + BNCPROV 
 + BNCPROC 
 + BNCPROP 
 + BNCPROPVV 
 + BNCPROPVC 
 + BNCPROPVP 
 - BNCPMVCTV
 + BNCNPV 
 + BNCNPC 
 + BNCNPP 
 + BNCNPPVV 
 + BNCNPPVC 
 + BNCNPPVP 
 + PVINVE
 - BNCNPDCT
 + BA1AV 
 + BA1AC 
 + BA1AP 
 + BI1AV 
 + BI1AC 
 + BI1AP 
 + MIB1AV 
 + MIB1AC 
 + MIB1AP 
 - MIBDEV 
 - MIBDEC 
 - MIBDEP 
 + BI2AV 
 + BI2AC 
 + BI2AP 
 + MIBNP1AV 
 + MIBNP1AC 
 + MIBNP1AP 
 - MIBNPDEV 
 - MIBNPDEC 
 - MIBNPDEP 
 - BNCPRODEV 
 - BNCPRODEC 
 - BNCPRODEP 
 + BN1AV 
 + BN1AC 
 + BN1AP 
 + BNCNP1AV 
 + BNCNP1AC 
 + BNCNP1AP 
 - BNCNPDEV 
 - BNCNPDEC 
 - BNCNPDEP) * (1-positif(APPLI_COLBERT+APPLI_OCEANS));

REVDECEXO =(
   FEXV 
 + FEXC 
 + FEXP 
 + BAEXV 
 + BAEXC 
 + BAEXP 
 + BAHEXV 
 + BAHEXC 
 + BAHEXP 
 + MIBEXV 
 + MIBEXC 
 + MIBEXP 
 + BICEXV 
 + BICEXC 
 + BICEXP 
 + BIHEXV 
 + BIHEXC 
 + BIHEXP 
 + MIBNPEXV 
 + MIBNPEXC 
 + MIBNPEXP 
 + BICNPEXV 
 + BICNPEXC 
 + BICNPEXP 
 + BICNPHEXV 
 + BICNPHEXC 
 + BICNPHEXP 
 + BNCPROEXV 
 + BNCPROEXC 
 + BNCPROEXP 
 + BNCEXV 
 + BNCEXC 
 + BNCEXP 
 + BNHEXV 
 + BNHEXC 
 + BNHEXP) * (1-positif(APPLI_COLBERT+APPLI_OCEANS));

regle 222070:
application : batch , iliad ;

AGRIV = (BAPERPV + BANOCGAV) * (1-positif(APPLI_OCEANS)) ; 
AGRIC = (BAPERPC + BANOCGAC) * (1-positif(APPLI_OCEANS)) ;  
AGRIP = (BAPERPP + BANOCGAP) * (1-positif(APPLI_OCEANS)) ; 

regle 222080:
application : batch , iliad ;


XBA = somme (i=V,C,P: XBAi) ;

XBI = somme (i=V,C,P: XBIPi + XBINPi) ;
XBICPRO = somme (i=V,C,P: XBIPi) ;
XBICNPRO = somme (i=V,C,P: XBINPi) ;

XBIMN = somme (i=V,C,P: MIBEXi + MIBNPEXi) ;
XBICMPRO = somme (i=V,C,P: MIBEXi) ;
XBICMNPRO = somme (i=V,C,P: MIBNPEXi) ;

XBNCMPRO = somme (i=V,C,P: BNCPROEXi) ;
XBNCMNPRO = somme (i=V,C,P: XSPENPi) ;
XBNCPRO = somme (i=V,C,P: XBNi) ;
XBNCNPRO = somme (i=V,C,P: XBNNPi) ;

XTSNN = somme (i=V,C: XTSNNi) ;
DEFBA = DEFBA1 + DEFBA2 + DEFBA3 + DEFBA4 + DEFBA5 + DEFBA6 ; 
BNCDF = BNCDF1 + BNCDF2 + BNCDF3 + BNCDF4 + BNCDF5 + BNCDF6 ;
DLMRNT = DLMRN1 + DLMRN2 + DLMRN3 + DLMRN4 + DLMRN5 + DLMRN6 ;
DEFLOC = DEFLOC1 + DEFLOC2 + DEFLOC3 + DEFLOC4 + DEFLOC5 + DEFLOC6 ;
AGRI = somme(i=V,C,P : AGRIi) ;
PECHEM = somme(i=V,C,P : BIPERPi) ;
JEUNART = somme(i=V,C,P : BNCCREAi) ;

regle 222090:
application : batch , iliad ;

REPINV = RIVL1 + RIVL2 + RIVL3 + RIVL4 + RIVL5 + RIVL6 ;

REPINVRES = RIVL1RES + RIVL2RES + RIVL3RES + RIVL4RES + RIVL5RES ;
REPINVTOT = REPINV + REPINVRES ;

regle 222100:
application : batch , iliad ;

pour i = V,C,P:
MIBDREPi =(     (MIBDEi - MIB1Ai ) * positif(MIBDEi - MIB1Ai) 
              - (MIBNP1Ai - MIBNPDEi) * positif(MIBNP1Ai - MIBNPDEi) 
          )
         *( positif( (MIBDEi - MIB1Ai ) * positif(MIBDEi - MIB1Ai)
                      - (MIBNP1Ai - MIBNPDEi) * positif(MIBNP1Ai - MIBNPDEi)
                    )
          );
pour i = V,C,P:
MIBDREPNPi =(  (MIBNPDEi -MIBNP1Ai )*positif(MIBNPDEi - MIBNP1Ai) 
             - (MIB1Ai-MIBDEi)*positif(MIB1Ai-MIBDEi) 
            )
           *(positif( (MIBNPDEi -MIBNP1Ai )*positif(MIBNPDEi - MIBNP1Ai) 
                       - (MIB1Ai-MIBDEi)*positif(MIB1Ai-MIBDEi) 
                    )
            );

MIBNETPTOT = MIBNETVF + MIBNETPF + MIB_NETCT ;

MIBNETNPTOT = MIBNETNPVF + MIBNETNPPF + MIB_NETNPCT ;
pour i = V,C,P:
SPEDREPi = (     (BNCPRODEi - BNCPRO1Ai) * positif(BNCPRODEi - BNCPRO1Ai)
              -  (BNCNP1Ai - BNCNPDEi)   * positif (BNCNP1Ai - BNCNPDEi)
           )
          *( positif((BNCPRODEi - BNCPRO1Ai) * positif(BNCPRODEi - BNCPRO1Ai)
                       -(BNCNP1Ai - BNCNPDEi)   * positif (BNCNP1Ai - BNCNPDEi)
                     )
           );


pour i = V,C,P:
SPEDREPNPi = ( (BNCNPDEi -BNCNP1Ai )*positif(BNCNPDEi - BNCNP1Ai) 
              -(BNCPRO1Ai-BNCPRODEi)*positif(BNCPRO1Ai-BNCPRODEi) 
             )
             *( positif( (BNCNPDEi -BNCNP1Ai )*positif(BNCNPDEi - BNCNP1Ai) 
                          -(BNCPRO1Ai-BNCPRODEi)*positif(BNCPRO1Ai-BNCPRODEi) 
                       )
              );

regle 222110:
application : batch , iliad ;


R8ZT = min(RBG2 + TOTALQUO , V_8ZT) ;

regle 222120:
application : batch , iliad ;


TXMOYIMPC = arr(TXMOYIMPNUM/TXMOYIMPDEN*100)/100;

TXMOYIMP = max(0, positif(IRPSCUM + IRANT - NONMER)
                 * positif((4500/100) - TXMOYIMPC)
                 * TXMOYIMPC
               )
	     ;

regle 222130:
application : batch , iliad ;


TXMOYIMPNUM = positif(IRCUM+IRANT+TAXACUM+PCAPCUM+TAXLOYCUM+HAUTREVCUM-RECUM-PIR-PTAXA-PPCAP-PTAXLOY-PHAUTREV) * 
               (max(0,(IRCUM+IRANT+TAXACUM+PCAPCUM+TAXLOYCUM+HAUTREVCUM-RECUM-PIR-PTAXA-PPCAP-PTAXLOY-PHAUTREV)
                    * positif_ou_nul((IRNET2+TAXASSUR+IPCAPTAXT+TAXLOY+IHAUTREVT)-SEUIL_12) 
                 + (IRNET2 + TAXASSUR +IPCAPTAXT+TAXLOY+IHAUTREVT+ IRANT)
                    * positif(SEUIL_12 - (IRNET2+TAXASSUR+IPCAPTAXT+TAXLOY+IHAUTREVT)) 

                 + arr(RCMLIB * TX_PREVLIB / 100) + COD2CK - IPREP-IPPRICORSE
                   )) * positif_ou_nul(IAMD1 - SEUIL_61) * 100;

regle 222140:
application : batch , iliad ;

TXMOYIMPDEN =  max(0,TXMOYIMPDEN1 - TXMOYIMPDEN2 + TXMOYIMPDEN3 
               + TXMOYIMPDEN4 + TXMOYIMPDEN5 + TXMOYIMPDEN6) ;

regle 222150:
application : batch , iliad ;

TXMOYIMPDEN1 =   somme (i=V,C,1,2,3,4: TSNTi) * (1-positif(abs(DRBG)))
        + somme (i=V,C,1,2,3,4: PALIi + PRBRi + PENINi) * (1-positif(abs(DRBG)))
        + RVTOT + T2RV 
	+ max(0,TRCMABD + DRTNC + RCMNAB + RAVC + RTCAR + RCMPRIVM 
                - max(0,(RCMFR* null(V_IND_TRAIT-4)+RCMFRART1731*  null(V_IND_TRAIT-5)) - DFRCMNBIS) * (1-positif(abs(DRBG)))
		- RCM_I * positif(REPRCM - RCM_I)
		- REPRCM * positif_ou_nul(RCM_I - REPRCM)) * (1-positif(abs(DRBG)))
         + RMFN * (1-positif(abs(DRBG)))
        + (RFCG + DRCF) * (1-positif(abs(DRBG)))
	+ PLOCNETF + max(0,NPLOCNETF)
        + (MIBNETPTOT + SPENETPF ) * (1-positif(abs(DRBG)))
                                   + (SPENETNPF + NOCEPIMP) * null(DALNP) * (1-positif(abs(DRBG)))
	  + max(0,BAHQTOT) + min(0,BAHQTOT) * (1-positif(SHBA - SEUIL_IMPDEFBA))
          + max(0,BATMARGTOT)
         + somme(i=V,C,P: BIPTAi+ BIHTAi + BNNSi + BNNAi)  * (1-positif(abs(DRBG)))
               + BICNPF * (1-positif(abs(DRBG)))
         + REPSOF * (1-positif(abs(DRBG)))
         - ((DABNCNP6*positif(BNCDF6) 
	 + min(DABNCNP6,NOCEPIMP+SPENETNPF)
			*null(BNCDF6)*positif(DABNCNP6))
	 +DABNCNP5 +DABNCNP4 +DABNCNP3 +DABNCNP2 +DABNCNP1) 
	 * null(BNCDF1 + BNCDF2 +BNCDF3 +BNCDF4 +BNCDF5 +BNCDF6) * (1-positif(abs(DRBG)))
         + (BPVRCM + PVTAXSB) * (1-positif(present(TAX1649)+present(RE168)))
         + COD1TZ
                ;
TXMOYIMPDEN2 =  somme (i=0,1,2,3,4,5: (DEFAAi * (1 - positif(DEFRI) ))) * (1-positif(RNIDF))
         + RDCSG
         + DDPA
         + APERPV + APERPC + APERPP
         + DRFRP  * positif(RRFI);
TXMOYIMPDEN3 = ( somme(i=V,C,P: BN1Ai + BIH1i + BI1Ai + BI2Ai + BA1Ai ) + MIB_1AF + BA1AF
                + SPEPV + PVINVE+PVINCE+PVINPE
		+ INVENTV + INVENTC + INVENTP
		+ (BPTPVT + BPTPSJ)* (1-positif(present(TAX1649)+present(RE168)))
                + (BTP2 + BPTP4    + BTP40 + BTP18)* (1-positif(present(TAX1649)+present(RE168)))
                + RCM2FA);
TXMOYIMPDEN4 = 2PRBV + 2PRBC + 2PRB1 + 2PRB2 + 2PRB3 + 2PRB4 + CODRVG + max(0,BAQTOT) * (1-positif(DEFBA6+DEFBA5+DEFBA4+DEFBA3+DEFBA2+DEFBA1))
							     + somme(i=V,C,1..4:PEBFi)
	       ;
TXMOYIMPDEN5 =  RCMLIB ;
TXMOYIMPDEN6 = CESSASSV+CESSASSC + BPCAPTAXV+BPCAPTAXC;

regle 222160:
application : iliad , batch ;


GGIRSEUL =  IAD11 + ITP + REI + AVFISCOPTER ;

regle 222170:
application : iliad , batch ;


GGIDRS =  IDOM11 + ITP + REI + PIR ;

regle 222180:
application : iliad , batch ;


GGIAIMP =  IAD11 ;

regle 222190:
application : iliad , batch ;


GGINET = si ( positif(RE168+TAX1649+0) = 0)
      alors
       (si    ( V_REGCO = 2 )
        alors (GGIAIMP - 0 + EPAV + CICA + CIGE )
        sinon (max(0,GGIAIMP - CIRCMAVFT + EPAV + CICA + CIGE ))
        finsi)
       sinon (max(0,GGIAIMP - CIRCMAVFT))
       finsi;

regle 222200:
application : iliad , batch ;

SEUILCIRIRF = arr( 
              (10676 + (2850 * (NBPT - 1) * 2 )
              ) * (1-null(V_REGCO - 5)) * (1-null(V_REGCO - 6)) * (1-null(V_REGCO - 7))
            + (12632 + (3135 * ( min(NBPT , 1.5) - 1) * 2)
                     + (2850 * ( max(0 , NBPT - 1.5)) * 2)
              ) * null(V_REGCO - 5)
            + (13209 + (3278 * ( min(NBPT , 1.5) - 1) * 2)
                     + (2850 * ( max(0 , NBPT - 1.5)) * 2)
              ) * positif( null(V_REGCO - 6) + null(V_REGCO - 7)) 
                ) ;

CIRIRF = null( (1-null( IND_TDR)) +  positif_ou_nul( SEUILCIRIRF - REVKIRE ) - 2)
         + 2 * (1 - null( (1- null( IND_TDR)) +  positif_ou_nul( SEUILCIRIRF - REVKIRE ) - 2)) ;

regle 222210:
application : iliad , batch ;

SEUILCIIMSI = arr(
              (13956 + (3726 * (NBPT - 1) * 2 )
              ) * (1-null(V_REGCO - 5)) * (1-null(V_REGCO - 6)) * (1-null(V_REGCO - 7))
            + (15268 + (4098 * ( min(NBPT , 1.5) - 1) * 2)
                     + (3726 * ( max(0 , NBPT - 1.5)) * 2)
              ) * null(V_REGCO - 5)
            + (15994 + (4285 * ( min(NBPT , 1.5) - 1) * 2)
                     + (3726 * ( max(0 , NBPT - 1.5)) * 2)
              ) * positif( null(V_REGCO - 6) + null(V_REGCO - 7))
                ) ;

CIIMSI = null( (1-null( IND_TDR)) +  positif( SEUILCIIMSI - REVKIRE ) - 2) 
         + 2 * (1 - null( (1-null( IND_TDR)) +  positif( SEUILCIIMSI - REVKIRE ) - 2)) ;

regle 222220:
application : iliad , batch ;

REPCT = (min(0,MIB_NETNPCT) * positif(MIBNPDCT) * positif(DLMRN1)
	+ min(0,SPENETNPCT) * positif(BNCNPDCT) * positif(BNCDF1)) * (-1);

regle 222225:
application : iliad , batch ;

PPENHPTOT = PPENBH1 + PPENBH2 + PPENBH3 + PPENBH4 ;

PPEPRIMEVT = (PPEPRIMEV + PPEPRIMETTEV) * ( 1 - V_CNR);
PPEPRIMECT = (PPEPRIMEC + PPEPRIMETTEC) * ( 1 - V_CNR);
PPEPRIMEPT = (somme( i=1,2,3,4,U,N:PPEPRIMEi)) * ( 1 - V_CNR);
PPESALVTOT = PPE_SALAVDEFV;
PPESALCTOT = PPE_SALAVDEFC;
PPESALPTOT = PPE_SALAVDEF1 + PPE_SALAVDEF2 + PPE_SALAVDEF3 + PPE_SALAVDEF4;

PPERPROV = PPE_RPROV * positif(PPETOTX
                               + positif(PPESALVTOT)
                               + present(PPEACV)
                               + present(PPENJV));

PPERPROC = PPE_RPROC * positif(PPETOTX
                               + positif(PPESALCTOT)
                               + present(PPEACC)
                               + present(PPENJC));

PPERPROP = PPE_RPROP * positif(PPETOTX
                               + positif(PPESALPTOT)
                               + present(PPEACP)
                               + present(PPENJP));

regle 222230:
application : iliad , batch ;

RBGTH = 
   TSHALLOV  
 + TSHALLOC  
 + TSHALLO1  
 + TSHALLO2  
 + TSHALLO3  
 + TSHALLO4  
 + ALLOV  
 + ALLOC  
 + ALLO1  
 + ALLO2  
 + ALLO3  
 + ALLO4  
 + SALEXTV
 + SALEXTC
 + SALEXT1
 + SALEXT2
 + SALEXT3
 + SALEXT4 
 + TSASSUV  
 + TSASSUC  
 + XETRANV  
 + XETRANC  
 + ELURASV
 + ELURASC
 + IPMOND
 + PRBRV  
 + PRBRC  
 + PRBR1  
 + PRBR2  
 + PRBR3  
 + PRBR4  
 + COD1AH
 + COD1BH
 + COD1CH
 + COD1DH
 + COD1EH
 + COD1FH 
 + PCAPTAXV
 + PCAPTAXC
 + PALIV
 + PALIC
 + PALI1
 + PALI2
 + PALI3
 + PALI4
 + RVB1  
 + RVB2  
 + RVB3  
 + RVB4  
 + GLD1V
 + GLD2V  
 + GLD3V  
 + GLD1C
 + GLD2C  
 + GLD3C  
 + GLDGRATV  
 + GLDGRATC  
 + PENINV
 + PENINC
 + PENIN1
 + PENIN2
 + PENIN3
 + PENIN4
 + RCMABD  
 + RCMTNC  
 + RCMAV  
 + RCMHAD  
 + REGPRIV  
 + RCMHAB  
 + PPLIB  
 + RCMIMPAT
 + RCMLIB
 + COD2FA
 + BPV40V
 + BPVRCM  
 + BPCOPTV  
 + BPCOSAV  
 + BPCOSAC  
 + PEA  
 + GAINABDET  
 + BPV18V  
 + ABIMPPV
 + BPVSJ
 + BPVSK
 + GAINPEA
 + PVSURSI
 + PVIMPOS
 + PVIMMO
 + ABDETPLUS
 + PVEXOSEC
 + PVREPORT
 + COD3SL
 + COD3UA
 + RFMIC  
 + RFORDI  
 + FEXV  
 + FEXC  
 + FEXP  
 + BAFPVV  
 + BAFPVC  
 + BAFPVP  
 + BAF1AV  
 + BAF1AC  
 + BAF1AP  
 + BAEXV  
 + BAEXC  
 + BAEXP  
 + BACREV  
 + BACREC  
 + BACREP  
 + BA1AV  
 + BA1AC  
 + BA1AP  
 + BAHEXV  
 + BAHEXC  
 + BAHEXP  
 + BAHREV  
 + BAHREC  
 + BAHREP  
 + BAFV  
 + BAFC  
 + BAFP  
 + BAFORESTV  
 + BAFORESTC  
 + BAFORESTP  
 + BAPERPV
 + BANOCGAV
 + BAPERPC
 + BANOCGAC
 + BAPERPP
 + BANOCGAP
 + MIBEXV  
 + MIBEXC  
 + MIBEXP  
 + MIBVENV  
 + MIBVENC  
 + MIBVENP  
 + MIBPRESV  
 + MIBPRESC  
 + MIBPRESP  
 + MIBPVV  
 + MIBPVC  
 + MIBPVP  
 + MIB1AV  
 + MIB1AC  
 + MIB1AP  
 + BICEXV  
 + BICEXC  
 + BICEXP  
 + BICNOV  
 + BICNOC  
 + BICNOP  
 + BI1AV  
 + BI1AC  
 + BI1AP  
 + BIHEXV  
 + BIHEXC  
 + BIHEXP  
 + BIHNOV  
 + BIHNOC  
 + BIHNOP  
 + MIBNPEXV  
 + MIBNPEXC  
 + MIBNPEXP  
 + MIBNPVENV  
 + MIBNPVENC  
 + MIBNPVENP  
 + MIBNPPRESV  
 + MIBNPPRESC  
 + MIBNPPRESP  
 + MIBNPPVV  
 + MIBNPPVC  
 + MIBNPPVP  
 + MIBNP1AV  
 + MIBNP1AC  
 + MIBNP1AP  
 + BICNPEXV  
 + BICNPEXC  
 + BICNPEXP  
 + BICREV  
 + BICREC  
 + BICREP  
 + BI2AV  
 + BI2AC  
 + BI2AP  
 + BICNPHEXV  
 + BICNPHEXC  
 + BICNPHEXP  
 + BICHREV  
 + BICHREC  
 + BICHREP  
 + LOCNPCGAV
 + LOCNPV
 + LOCNPCGAC
 + LOCNPC
 + LOCNPCGAPAC
 + LOCNPPAC
 + LOCPROCGAV
 + LOCPROV
 + LOCPROCGAC
 + LOCPROC
 + LOCPROCGAP
 + LOCPROP
 + MIBMEUV
 + MIBMEUC
 + MIBMEUP
 + MIBGITEV
 + MIBGITEC
 + MIBGITEP
 + LOCGITCV
 + LOCGITHCV
 + LOCGITCC
 + LOCGITHCC
 + LOCGITCP
 + LOCGITHCP
 + LOCGITV
 + LOCGITC
 + LOCGITP
 + AUTOBICVV
 + AUTOBICPV
 + AUTOBICVC
 + AUTOBICPC
 + AUTOBICVP
 + AUTOBICPP
 + BIPERPV
 + BIPERPC
 + BIPERPP
 + BNCPROEXV  
 + BNCPROEXC  
 + BNCPROC  
 + BNCPROP  
 + BNCPROPVV  
 + BNCPROPVC  
 + BNCPROPVP  
 + BNCPRO1AV  
 + BNCPRO1AC  
 + BNCPRO1AP  
 + BNCEXV  
 + BNCEXC  
 + BNCEXP  
 + BNCREV  
 + BNCREC  
 + BNCREP  
 + BN1AV  
 + BN1AC  
 + BN1AP  
 + BNHEXV  
 + BNHEXC  
 + BNHEXP  
 + BNHREV  
 + BNHREC  
 + BNHREP  
 + BNCCRV  
 + BNCCRC  
 + BNCCRP  
 + BNCNPV  
 + BNCNPC  
 + BNCNPP  
 + BNCNPPVV  
 + BNCNPPVC  
 + BNCNPPVP  
 + BNCNP1AV  
 + BNCNP1AC  
 + BNCNP1AP  
 + ANOCEP  
 + PVINVE  
 + BNCCRFV  
 + ANOVEP  
 + PVINCE  
 + BNCCRFC  
 + ANOPEP  
 + PVINPE  
 + BNCCRFP  
 + BNCAABV  
 + BNCAABC  
 + BNCAABP  
 + BNCNPREXAAV  
 + BNCNPREXV  
 + BNCNPREXAAC  
 + BNCNPREXC  
 + BNCNPREXAAP  
 + BNCNPREXP  
 + BNCPROEXP
 + BNCPROV
 + XHONOAAV
 + XHONOV
 + XHONOAAC
 + XHONOC
 + XHONOAAP
 + XHONOP
 + CESSASSV
 + CESSASSC
 + INVENTV
 + INVENTC
 + INVENTP
 + AUTOBNCV
 + AUTOBNCC
 + AUTOBNCP
 + XSPENPV
 + XSPENPC
 + XSPENPP
 + REPSOF
      ;

regle 222240:
application : iliad , batch ;


XETRAN = XETSNNV + XETSNNC ;

regle 222250:
application : iliad ;


TLIR  = TL_IR * positif(APPLI_OCEANS) ;
TLTAXAGA = TL_TAXAGA * positif(APPLI_OCEANS) ;

regle 222260:
application : iliad , batch ;


TAXLOY = LOYELEV * (1 - positif(RE168 + TAX1649)) ;

regle 222270:
application : iliad , batch ;


VARPS = max(0, NAPCS - V_CSANT)
      + max(0,NAPRD - V_RDANT)
      + max(0,NAPPS - V_PSANT)
      + max(0,NAPCVN - V_CVNANT)
      + max(0,NAPCDIS - V_CDISANT)
      + max(0,NAPGLOA - V_GLOANT)
      + max(0,NAPRSE1 - V_RSE1ANT)
      + max(0,NAPRSE2 - V_RSE2ANT)
      + max(0,NAPRSE3 - V_RSE3ANT)
      + max(0,NAPRSE4 - V_RSE4ANT)
      + max(0,NAPRSE5 - V_RSE5ANT) 
      + max(0,NAPRSE6 - V_RSE6ANT) ;

regle 222275:
application : iliad , batch ;


COMPENSPPE = positif(NAPCRP) *  null(IND61PS - 2) *
             (positif(PPETOTX) * null(IRE) *
                (  positif(IRESTITIR-PPETOTX) * min(NAPCRP,max(0,IRESTITIR - PPETOTX))
                 + null(IRESTITIR - PPETOTX) * min(NAPCRP,PPETOTX)
                 + positif(PPETOTX - IRESTITIR) * min(NAPCRP,IRESTITIR))
             + positif(PPETOTX)* positif(IRE) *
                (  positif(IRESTITIR - IRE - PPETOTX) * min(max(0,NAPCRP-COMPENSACI),PPETOTX)
                 + null(IRESTITIR -IRE - PPETOTX) * min(max(0,NAPCRP-COMPENSACI),PPETOTX)
                 + positif(PPETOTX + IRE - IRESTITIR) *
                                  (positif_ou_nul(PPETOTX - IRESTITIR)) * min(max(0,NAPCRP-COMPENSACI),IRESTITIR)
                                 + positif(IRESTITIR - PPETOTX) * min(max(0,NAPCRP-COMPENSACI),PPETOTX))
                ) * positif(20 - V_NOTRAIT)

             + positif(null(V_NOTRAIT - 26) + null(V_NOTRAIT - 36) + null(V_NOTRAIT - 46) + null(V_NOTRAIT - 56) + null(V_NOTRAIT - 66))
               * max(0 , min(0 , TOTIRPSANT - V_ANTCR) - min(0 , TOTIRPS - NAPCR61 + NONMER) - COMPENSACI) ;

regle 222280:
application : iliad , batch ;




COMPENSACI = positif(NAPCRP) *  null(IND61PS - 2) *
             (positif(IRE) * 
                (  positif(IRESTITIR-IRE) * min(NAPCRP,max(0,IRESTITIR - IRE))
                 + null(IRESTITIR - IRE) * min(NAPCRP,IRE)
                 + positif(IRE - IRESTITIR) * min(NAPCRP,IRESTITIR))
              ) * positif(20 - V_NOTRAIT) 
             + positif(null(V_NOTRAIT - 26) + null(V_NOTRAIT - 36) + null(V_NOTRAIT - 46) + null(V_NOTRAIT - 56) + null(V_NOTRAIT - 66))
               * max(0 , min(min(0 , TOTIRPSANT - V_ANTCR) - min(0 , TOTIRPS - NAPCR61 + NONMER) , RECUMIR - PPEREST2A)) ;

COMPENSANV = positif(20 - V_NOTRAIT) * (null(IND61PS - 2) * positif(SEUIL_12 - (CSTOT +IRNET+TAXANET+TAXLOYNET+PCAPNET+HAUTREVNET-IRESTITIR))
                                                      * max(0,NAPCRP - IRESTITIR))
             + positif(null(V_NOTRAIT - 26) + null(V_NOTRAIT - 36) + null(V_NOTRAIT - 46) + null(V_NOTRAIT - 56) + null(V_NOTRAIT - 66))
               * positif(VARPS - NAPT) * max(0 , min(NONMER , min(VARPS,NAPCR61-V_ANTCR))) ;

COMPENSIR = (1 - INDCTX) * max(0 , max(0 , TOTIRPSANT - V_ANTCR) - max(0 , TOTIRPS - NAPCR61 + NONMER)) ;

COMPENSPS = (1 - INDCTX) * (
                            max(0 , V_CSANT - NAPCS)
                          + max(0 , V_RDANT - NAPRD)
                          + max(0 , V_PSANT - NAPPS)
                          + max(0 , V_CVNANT - NAPCVN)
                          + max(0 , V_CDISANT - NAPCDIS)
                          + max(0 , V_GLOANT - NAPGLOA)
                          + max(0 , V_RSE1ANT - NAPRSE1)
                          + max(0 , V_RSE2ANT - NAPRSE2)
                          + max(0 , V_RSE3ANT - NAPRSE3)
                          + max(0 , V_RSE4ANT - NAPRSE4)
                          + max(0 , V_RSE5ANT - NAPRSE5)
                          + max(0 , V_RSE6ANT - NAPRSE6)) * positif(positif(NAPT) + positif(VARPS));

regle 222290:
application : iliad , batch ;

B1507INR = IRNIN_INR +TAXABASE +PCAPBASE +LOYBASE +CHRBASE;
B1507MAJO1 = IRNIN * positif(NMAJ1)
	    + TAXASSUR * positif(NMAJTAXA1) 
	    + IPCAPTAXT * positif(NMAJPCAP1) 
	    + TAXLOY * positif(NMAJLOY1)
	    + IHAUTREVT * positif(NMAJCHR1) ;

B1507MAJO3 = IRNIN * positif(NMAJ3)
	    + TAXASSUR * positif(NMAJTAXA3) 
	    + IPCAPTAXT * positif(NMAJPCAP3) 
	    + TAXLOY * positif(NMAJLOY3)
	    + IHAUTREVT * positif(NMAJCHR3) ;

B1507MAJO4 = IRNIN * positif(NMAJ4)
	    + TAXASSUR * positif(NMAJTAXA4) 
	    + IPCAPTAXT * positif(NMAJPCAP4) 
	    + TAXLOY * positif(NMAJLOY4)
	    + IHAUTREVT * positif(NMAJCHR4) ;

regle 223010 :
application :  iliad, batch ;

INDEFCAP = positif(present( DEFRCM ) 
 + present( DEFRCM2 ) 
 + present( DEFRCM3 ) 
 + present( DEFRCM4 ) 
 + present( DEFRCM5 ) 
 + present( DEFRCM6 ) 
 + present( RFDORD ) 
 + present( RFDHIS ) 
 + present( RFDANT ) 
 + present( LNPRODEF10 ) 
 + present( LNPRODEF9 ) 
 + present( LNPRODEF8 ) 
 + present( LNPRODEF7 ) 
 + present( LNPRODEF6 ) 
 + present( LNPRODEF5 ) 
 + present( LNPRODEF4 ) 
 + present( LNPRODEF3 ) 
 + present( LNPRODEF2 ) 
 + present( LNPRODEF1 ) 
 + present( BACDEV ) 
 + present( BAHDEV ) 
 + present( DABNCNP6 ) 
 + present( BACDEC ) 
 + present( BAHDEC ) 
 + present( DABNCNP5 ) 
 + present( BACDEP ) 
 + present( BNCAADV ) 
 + present( BAHDEP ) 
 + present( DABNCNP4 ) 
 + present( BICDNV ) 
 + present( BIHDNV ) 
 + present( DABNCNP3 ) 
 + present( BICDNC ) 
 + present( BIHDNC ) 
 + present( DABNCNP2 ) 
 + present( BICDNP ) 
 + present( BIHDNP ) 
 + present( DABNCNP1 ) 
 + present( BICDEV ) 
 + present( BICHDEV ) 
 + present( DNOCEPC ) 
 + present( LOCDEFNPCGAV ) 
 + present( LOCDEFNPV ) 
 + present( BICDEC ) 
 + present( BICHDEC ) 
 + present( DNOCEPP ) 
 + present( LOCDEFNPCGAC ) 
 + present( LOCDEFNPC ) 
 + present( BICDEP ) 
 + present( BICHDEP ) 
 + present( LOCDEFNPCGAPAC ) 
 + present( LOCDEFNPPAC ) 
 + present( LOCDEFPROCGAV ) 
 + present( BNCDEV ) 
 + present( DAGRI6 ) 
 + present( DAGRI5 ) 
 + present( LOCDEFPROV ) 
 + present( BNHDEV ) 
 + present( DAGRI4 ) 
 + present( DAGRI3 ) 
 + present( DAGRI2 ) 
 + present( DAGRI1 ) 
 + present( LOCDEFPROCGAC ) 
 + present( BNCDEC ) 
 + present( BNCAADC ) 
 + present( LOCDEFPROC ) 
 + present( BNHDEC ) 
 + present( DEFBIC6 ) 
 + present( DEFBIC5 ) 
 + present( DEFBIC4 ) 
 + present( DEFBIC3 ) 
 + present( DEFBIC2 ) 
 + present( DEFBIC1 ) 
 + present( LOCDEFPROCGAP ) 
 + present( BNCDEP ) 
 + present( BNCAADP ) 
 + present( LOCDEFPROP ) 
 + present( BNHDEP ) 
 + present( DNOCEP ) 
 + present( DEFAA5 ) 
 + present( DEFAA4 ) 
 + present( DEFAA3 ) 
 + present( DEFAA2 ) 
 + present( DEFAA1 ) 
 + present( DEFAA0 ) 
 + present( COD8YJ ) 
 + present( IPTEFN ) 
 + present( DMOND )) + 0;
