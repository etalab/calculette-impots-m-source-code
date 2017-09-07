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
 #
 #
 #
regle 9071 :
application : iliad , batch ;
IDRS = INDTXMIN*IMI + 
       INDTXMOY*IMO + 
       (1-INDTXMIN) * (1-INDTXMOY) * max(0,IPHQ2 - ADO1) ;
regle 907100 :
application : iliad , batch, bareme ;
RECOMP = max(0 ,( IPHQANT2 - IPHQ2 )*(1-INDTXMIN) * (1-INDTXMOY)) 
         * (1 - positif(IPMOND+INDTEFF));
regle 907101 :
application : iliad , batch ;
IDRSANT = INDTXMIN*IMI + INDTXMOY*IMO 
         + (1-INDTXMIN) * (1-INDTXMOY) * max(0,IPHQANT2 - ADO1) ;
IDRS2 = (1 - positif(IPMOND+INDTEFF))  * 
        ( 
         IDRSANT + ( positif(ABADO)*ABADO + positif(ABAGU)*ABAGU )
                  * positif(IDRSANT)
         + IPHQANT2 * (1 - positif(IDRSANT))
         + positif(RE168+TAX1649) * IAMD2
        )
   + positif(IPMOND+INDTEFF) 
         * ( IDRS*(1-positif(IPHQ2)) + IPHQ2 * positif(IPHQ2) );

IDRS3 = IDRT ;
regle 90710 :
application : iliad , batch ;
PLAFQF = positif(IS521 - PLANT - IS511) * (1-positif(V_CR2+IPVLOC))
           * ( positif(abs(TEFF)) * positif(IDRS) + (1 - positif(abs(TEFF))) );
regle 907105 :
application : iliad , batch ;
ABADO = arr(min(ID11 * (TX_RABDOM / 100)
             * ((PRODOM * max(0,1 - V_EAD - V_EAG) / RG ) + V_EAD),PLAF_RABDOM)
	    );
ABAGU = arr(min(ID11 * (TX_RABGUY / 100)
	     * ((PROGUY * max(0,1 - V_EAD - V_EAG) / RG ) + V_EAG),PLAF_RABGUY)
	    );
regle 90711 :
application : iliad , batch ;

RGPAR =   positif(PRODOM) * 1 
       +  positif(PROGUY) * 2
       +  positif(PROGUY)*positif(PRODOM) 
       ;

regle 9074 :
application : iliad , batch ;
IBAEX = (IPQT2) * (1 - INDTXMIN) * (1 - INDTXMOY);
regle 9080 :
application : iliad , batch ;

PRELIB = PPLIB + RCMLIB ;

regle 9091 :
application : iliad , batch ;
IDEC = DEC11 * (1 - positif(V_CR2 + V_CNR + IPVLOC));
regle 9092 :
application : iliad , batch ;
IPROP = ITP ;
regle 9093 :
application : iliad , batch ;

IREP = REI ;

regle 90981 :
application : batch, iliad ;
RETIR = RETIR2 + arr(BTOINR * TXINT/100) ;
RETCS = RETCS2 + arr((CSG-CSGIM) * TXINT/100) ;
RETRD = RETRD2 + arr((RDSN-CRDSIM) * TXINT/100) ;
RETPS = RETPS2 + arr((PRS-PRSPROV) * TXINT/100) ;
RETGAIN = RETGAIN2 + arr((CGAINSAL - GAINPROV) * TXINT/100) ;
RETCSAL = RETCSAL2 + arr((CSAL - CSALPROV) * TXINT/100) ;
RETCVN = RETCVN2 + arr((CVNSALC - PROVCVNSAL) * TXINT/100) ;
RETCDIS = RETCDIS2 + arr((CDIS - CDISPROV) * TXINT/100) ;
RETGLOA = RETGLOA2 + arr(CGLOA * TXINT/100) ;
RETRSE1 = RETRSE12 + arr(RSE1 * TXINT/100) ;
RETRSE2 = RETRSE22 + arr(RSE2 * TXINT/100) ;
RETRSE3 = RETRSE32 + arr(RSE3 * TXINT/100) ;
RETRSE4 = RETRSE42 + arr(RSE4 * TXINT/100) ;
RETRSE5 = RETRSE52 + arr(RSE5 * TXINT/100) ;
RETTAXA = RETTAXA2 + arr(max(0,TAXASSUR- min(TAXASSUR+0,max(0,INE-IRB+AVFISCOPTER))+min(0,IRN - IRANT)) * TXINT/100) ;
RETPCAP = RETPCAP2+arr(max(0,IPCAPTAXT- min(IPCAPTAXT+0,max(0,INE-IRB+AVFISCOPTER-TAXASSUR))+min(0,IRN - IRANT+TAXASSUR)) * TXINT/100) ;
RETLOY = RETLOY2+arr(max(0,TAXLOY- min(TAXLOY+0,max(0,INE-IRB+AVFISCOPTER-TAXASSUR-IPCAPTAXT))+min(0,IRN - IRANT+TAXASSUR+IPCAPTAXT)) * TXINT/100) ;
RETHAUTREV = RETCHR2 + arr(max(0,IHAUTREVT+min(0,IRN - IRANT+TAXASSUR+IPCAPTAXT+TAXLOY)) * TXINT/100) ;

regle 90984 :
application : batch, iliad ;
MAJOIRTARDIF_A1 = MAJOIRTARDIF_A - MAJOIR17_2TARDIF_A;
MAJOTAXATARDIF_A1 = MAJOTAXATARDIF_A - MAJOTA17_2TARDIF_A;
MAJOCAPTARDIF_A1 = MAJOCAPTARDIF_A - MAJOCP17_2TARDIF_A;
MAJOLOYTARDIF_A1 = MAJOLOYTARDIF_A - MAJOLO17_2TARDIF_A;
MAJOHRTARDIF_A1 = MAJOHRTARDIF_A - MAJOHR17_2TARDIF_A;
MAJOTHTARDIF_A1 = MAJOTHTARDIF_A - MAJOTH17_2TARDIF_A;
MAJOIRTARDIF_D1 = MAJOIRTARDIF_D - MAJOIR17_2TARDIF_D;
MAJOTAXATARDIF_D1 = MAJOTAXATARDIF_D - MAJOTA17_2TARDIF_D;
MAJOCAPTARDIF_D1 = MAJOCAPTARDIF_D - MAJOCP17_2TARDIF_D;
MAJOLOYTARDIF_D1 = MAJOLOYTARDIF_D - MAJOLO17_2TARDIF_D;
MAJOHRTARDIF_D1 = MAJOHRTARDIF_D - MAJOHR17_2TARDIF_D;
MAJOTHTARDIF_D1 = MAJOTHTARDIF_D - MAJOTH17_2TARDIF_D;
MAJOIRTARDIF_P1 = MAJOIRTARDIF_P - MAJOIR17_2TARDIF_P;
MAJOIRTARDIF_R1 = MAJOIRTARDIF_R - MAJOIR17_2TARDIF_R;
MAJOTAXATARDIF_R1 = MAJOTAXATARDIF_R - MAJOTA17_2TARDIF_R;
MAJOCAPTARDIF_R1 = MAJOCAPTARDIF_R - MAJOCP17_2TARDIF_R;
MAJOLOYTARDIF_R1 = MAJOLOYTARDIF_R - MAJOLO17_2TARDIF_R;
MAJOHRTARDIF_R1 = MAJOHRTARDIF_R - MAJOHR17_2TARDIF_R;
MAJOTHTARDIF_R1 = MAJOTHTARDIF_R - MAJOTH17_2TARDIF_R;
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
                + FLAG_TRTARDIF_F * MAJOLOYTARDIF_D1
                - FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * MAJOLOYTARDIF_R1
                + (1 - positif(FLAG_RECTIF)) * MAJOLOYTARDIF_A1)
                );
NMAJCHR1 = max(0,MAJO1728CHR + arr(max(0,IHAUTREVT+min(0,IRN-IRANT+TAXASSUR+IPCAPTAXT+TAXLOY)) * COPETO/100)
                + FLAG_TRTARDIF * MAJOHRTARDIF_D1
                + FLAG_TRTARDIF_F * MAJOHRTARDIF_D1
                - FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * MAJOHRTARDIF_R1
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
		);
NMAJR1 = max(0,MAJO1728RD + arr((RDSN - CRDSIM) * COPETO/100) 
		+ FLAG_TRTARDIF * MAJORDTARDIF_D
		+ FLAG_TRTARDIF_F 
		* (positif(PROPRD_A) * MAJORDTARDIF_P 
		  + (1 - positif(PROPRD_A) ) * MAJORDTARDIF_D)
		- FLAG_TRTARDIF_F * (1 - positif(PROPCS_A))
				    * ( positif(FLAG_RECTIF) * MAJORDTARDIF_R
				     + (1 - positif(FLAG_RECTIF)) * MAJORDTARDIF_A)
		);
NMAJP1 = max(0,MAJO1728PS + arr((PRS - PRSPROV) * COPETO/100)  
		+ FLAG_TRTARDIF * MAJOPSTARDIF_D
		+ FLAG_TRTARDIF_F 
		* (positif(PROPPS_A) * MAJOPSTARDIF_P 
		  + (1 - positif(PROPPS_A) ) * MAJOPSTARDIF_D)
		- FLAG_TRTARDIF_F * (1 - positif(PROPPS_A))
				    * ( positif(FLAG_RECTIF) * MAJOPSTARDIF_R
				     + (1 - positif(FLAG_RECTIF)) * MAJOPSTARDIF_A)
		);
NMAJGAIN1 = max(0,MAJO1728GAIN + arr((CGAINSAL - GAINPROV) * COPETO/100)
		+ FLAG_TRTARDIF * MAJOGAINTARDIF_D
		+ FLAG_TRTARDIF_F  * MAJOGAINTARDIF_D
		- FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * MAJOGAINTARDIF_R
				     + (1 - positif(FLAG_RECTIF)) * MAJOGAINTARDIF_A)
		);
NMAJCSAL1 = max(0,MAJO1728CSAL + arr((CSAL - CSALPROV) * COPETO/100)
		+ FLAG_TRTARDIF * MAJOCSALTARDIF_D
		+ FLAG_TRTARDIF_F  * MAJOCSALTARDIF_D
		- FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * MAJOCSALTARDIF_R
				     + (1 - positif(FLAG_RECTIF)) * MAJOCSALTARDIF_A)
		);
NMAJCVN1 = max(0,MAJO1728CVN + arr((CVNSALC - PROVCVNSAL) * COPETO/100)
		+ FLAG_TRTARDIF * MAJOCVNTARDIF_D
		+ FLAG_TRTARDIF_F  * MAJOCVNTARDIF_D
		- FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * MAJOCVNTARDIF_R
				     + (1 - positif(FLAG_RECTIF)) * MAJOCVNTARDIF_A)
		);
NMAJCDIS1 = max(0,MAJO1728CDIS + arr((CDIS - CDISPROV) * COPETO/100)  * (1 - V_CNR)
		+ FLAG_TRTARDIF * MAJOCDISTARDIF_D
		+ FLAG_TRTARDIF_F  * MAJOCDISTARDIF_D
		- FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * MAJOCDISTARDIF_R
				     + (1 - positif(FLAG_RECTIF)) * MAJOCDISTARDIF_A)
		);
NMAJGLO1 = max(0,MAJO1728GLO + arr(CGLOA * COPETO/100)
                + FLAG_TRTARDIF * MAJOGLOTARDIF_D
                + FLAG_TRTARDIF_F  * MAJOGLOTARDIF_D
                - FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * MAJOGLOTARDIF_R
                                     + (1 - positif(FLAG_RECTIF)) * MAJOGLOTARDIF_A)
);
NMAJRSE11 = max(0,MAJO1728RSE1 + arr((RSE1N - CSPROVYD) * COPETO/100)  
		+ FLAG_TRTARDIF * MAJORSE1TARDIF_D
		+ FLAG_TRTARDIF_F  * MAJORSE1TARDIF_D
		- FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * MAJORSE1TARDIF_R
				     + (1 - positif(FLAG_RECTIF)) * MAJORSE1TARDIF_A)
		);
NMAJRSE21 = max(0,MAJO1728RSE2 + arr((RSE2N- CSPROVYF) * COPETO/100)  
		+ FLAG_TRTARDIF * MAJORSE2TARDIF_D
		+ FLAG_TRTARDIF_F  * MAJORSE2TARDIF_D
		- FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * MAJORSE2TARDIF_R
				     + (1 - positif(FLAG_RECTIF)) * MAJORSE2TARDIF_A)
		);
NMAJRSE31 = max(0,MAJO1728RSE3 + arr((RSE3N - CSPROVYG)* COPETO/100) 
		+ FLAG_TRTARDIF * MAJORSE3TARDIF_D
		+ FLAG_TRTARDIF_F  * MAJORSE3TARDIF_D
		- FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * MAJORSE3TARDIF_R
				     + (1 - positif(FLAG_RECTIF)) * MAJORSE3TARDIF_A)
		);
NMAJRSE41 = max(0,MAJO1728RSE4 + arr((RSE4N - CSPROVYH) * COPETO/100) 
		+ FLAG_TRTARDIF * MAJORSE4TARDIF_D
		+ FLAG_TRTARDIF_F  * MAJORSE4TARDIF_D
		- FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * MAJORSE4TARDIF_R
				     + (1 - positif(FLAG_RECTIF)) * MAJORSE4TARDIF_A)
		);
NMAJRSE51 = max(0,MAJO1728RSE5 + arr((RSE5N - CSPROVYE) * COPETO/100) 
		+ FLAG_TRTARDIF * MAJORSE5TARDIF_D
		+ FLAG_TRTARDIF_F  * MAJORSE5TARDIF_D
		- FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * MAJORSE5TARDIF_R
				     + (1 - positif(FLAG_RECTIF)) * MAJORSE5TARDIF_A)
		);
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
NMAJLOY3 = max(0,MAJO1758ALOY + arr(max(0,TAXLOY+min(0,IRN-IRANT+TAXASSUR+IPCAPTAXT)) * COPETO/100)
                * positif(null(CMAJ-10)+null(CMAJ-17))
                + FLAG_TRTARDIF * MAJOLO17_2TARDIF_D
		);
NMAJCHR3 = max(0,MAJO1758ACHR + arr(max(0,IHAUTREVT+min(0,IRN-IRANT+TAXASSUR+IPCAPTAXT+TAXLOY)) * COPETO/100)
                * positif(null(CMAJ-10)+null(CMAJ-17))
                + FLAG_TRTARDIF * MAJOHR17_2TARDIF_D
		);
NMAJ4    =      somme (i=03..06,30,32,55: MAJOIRi);
NMAJTAXA4  =    somme (i=03..06,30,55: MAJOTAXAi);
NMAJC4 =  somme(i=03..06,30,32,55:MAJOCSi);
NMAJR4 =  somme(i=03..06,30,32,55:MAJORDi);
NMAJP4 =  somme(i=03..06,30,55:MAJOPSi);
NMAJCSAL4 =  somme(i=03..06,30,55:MAJOCSALi);
NMAJCDIS4 =  somme(i=03..06,30,55:MAJOCDISi);
NMAJPCAP4 =  somme(i=03..06,30,55:MAJOCAPi);
NMAJCHR4 =  somme(i=03..06,30,32,55:MAJOHRi);
NMAJRSE14 =  somme(i=03..06,55:MAJORSE1i);
NMAJRSE24 =  somme(i=03..06,55:MAJORSE2i);
NMAJRSE34 =  somme(i=03..06,55:MAJORSE3i);
NMAJRSE44 =  somme(i=03..06,55:MAJORSE4i);
NMAJGAIN4 =  somme(i=03..06,55:MAJOGAINi);
regle isf 9094 :
application : batch, iliad ;
MAJOISFTARDIF_A1 = MAJOISFTARDIF_A - MAJOISF17TARDIF_A;
MAJOISFTARDIF_D1 = MAJOISFTARDIF_D - MAJOISF17TARDIF_D;
MAJOISFTARDIF_R1 = MAJOISFTARDIF_R - MAJOISF17TARDIF_R;
NMAJISF1BIS = max(0,MAJO1728ISF + arr(ISF4BASE * COPETO/100)
                   + FLAG_TRTARDIF * MAJOISFTARDIF_D
                   + FLAG_TRTARDIF_F * MAJOISFTARDIF_D
                   - FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * MAJOISFTARDIF_R
					 + (1 - positif(FLAG_RECTIF)) * MAJOISFTARDIF_A)
                 );
regle 90101 :
application : iliad , batch ;

IAVIM = IRB + PTOT + TAXASSUR + PTAXA + IPCAPTAXTOT + PPCAP + TAXLOY + PTAXLOY + CHRAPRES + PHAUTREV ;

IAVIM2 = IRB + PTOT ;

regle 90113 :
application : iliad , batch ;
CDBA = positif_ou_nul(SEUIL_IMPDEFBA-SHBA-(REVTP-BA1)
      -GLN1-REV2-REV3-REV4-REVRF);
AGRBG = SHBA + (REVTP-BA1) + GLN1 + REV2 + REV3 + REV4 + REVRF ;

regle 901130 :
application : iliad , batch ;

DBAIP =  abs(min(BAHQT + BAQT , DAGRI6 + DAGRI5 + DAGRI4 + DAGRI3 + DAGRI2 + DAGRI1)
	     * positif(DAGRI6 + DAGRI5 + DAGRI4 + DAGRI3 + DAGRI2 + DAGRI1) * positif(BAHQT + BAQT)) ;

regle 901131 :
application : iliad , batch ;

RBAT = max (0 , BANOR) ;

regle 901132 :
application : iliad , batch ;
DEFIBA = (min(max(1+SEUIL_IMPDEFBA-SHBA-(REVTP-BA1)
      -GLN1-REV2-REV3-REV4-REVRF,0),1)) * min( 0 , BANOR ) ;
regle 901133 :
application :  iliad, batch ;
NAPALEG = abs(NAPT) ;

INDNAP = 1 - positif_ou_nul(NAPT) ;

GAINDBLELIQ = max(0,V_ANC_NAP*(1-2*V_IND_NAP) - NAPT) * (1-positif(V_0AN)) * (1 - V_CNR2) 
	       * (1 - null(V_REGCO - 2)) * (1 - null(V_REGCO - 4)) * (1 - positif(IPTEFP+IPTEFN+IRANT));

GAINPOURCLIQ = (1 - null(V_ANC_NAP*(1-2*V_IND_NAP))) * (V_ANC_NAP*(1-2*V_IND_NAP) - NAPT)/ V_ANC_NAP*(1-2*V_IND_NAP)  * (1 - V_CNR2);

ANCNAP = V_ANC_NAP * (1-2*V_IND_NAP) ;


INDPPEMENS = positif( ( positif(IRESTIT - 180) 
		       + positif((-1)*ANCNAP - 180) 
                       + positif(IRESTIT - IRNET - 180) * null(V_IND_TRAIT-5)
		      ) * positif(PPETOT - PPERSA - 180) )
	           * (1 - V_CNR) ;

BASPPEMENS = INDPPEMENS * min(max(IREST,(-1)*ANCNAP*positif((-1)*ANCNAP)),PPETOT-PPERSA) * null(V_IND_TRAIT-4) 
            + INDPPEMENS * max(0,min(IRESTIT-IRNET,PPETOT-PPERSA)) * null(V_IND_TRAIT-5) ;

regle 90114 :
application : iliad , batch ;
IINET = max(0 , null(4 - V_IND_TRAIT) * (( NAPTOT - IRANT + NAPCR)* positif_ou_nul (NAPTOT - IRANT + NAPCR - SEUIL_12))
	      + null (5 - V_IND_TRAIT) *  (TOTIRPS - TOTIRPSANT));
IINETIR = max(0 , NAPTIR) ;

regle 901140 :
application : bareme  ;

IINET = IRNET * positif ( IRNET - SEUIL_61 ) ;

regle 9011410 :
application : bareme , iliad , batch ;
IRNET2 =  (IAR + PIR - IRANT) ;

regle 901141 :
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

regle 901143 :
application : iliad , batch ;
IRNET =  null(NRINET + IMPRET + (RASAR * V_CR2) + 0) * IRNETBIS * positif_ou_nul(IRB - min(max(0,IRB-AVFISCOPTER),INE))
          + positif(NRINET + IMPRET + (RASAR * V_CR2) + 0)
                    *
                    (
                    ((positif(IRE) + positif_ou_nul(IAVIM + NAPCRPAVIM - SEUIL_61) * (1 - positif(IRE)))
                    *
                    max(0, CHRNEG + NRINET + IMPRET + (RASAR * V_CR2) + (IRNETBIS * positif(positif_ou_nul(IAVIM + NAPCRPAVIM- SEUIL_61)) 
		                                                                  * positif_ou_nul(IRB - min(max(0,IRB-AVFISCOPTER),INE)))     
                      ) * (1 - positif(IRESTIT)))
                    + ((1 - positif_ou_nul(IAVIM + NAPCRPAVIM - SEUIL_61)) * (1 - positif(IRE)) * max(0, CHRNEG + NRINET + IMPRET + (RASAR * V_CR2)))
                    ) ;
regle 901144 :
application : iliad , batch ;
TOTNET = max (0,NAPTIR + NAPCRP);
regle 9011411 :
application : iliad , batch ;
TAXANEG = min(0 , TAXASSUR + PTAXA - min(TAXASSUR + PTAXA + 0 , max(0,INE-IRB+AVFISCOPTER)) + min(0 , IRNET2)) ;
TAXNET = positif(TAXASSUR)
	  * max(0 , TAXASSUR + PTAXA  - min(TAXASSUR + PTAXA + 0,max(0,INE-IRB+AVFISCOPTER)) + min(0 , IRNET2)) ;
TAXANET = null(NRINET + IMPRET + (RASAR * V_CR2) + 0) * TAXNET
	   + positif(NRINET + IMPRET + (RASAR * V_CR2) + 0)
             * (positif_ou_nul(IAMD1 +NAPCRPIAMD1- SEUIL_61) * TAXNET + (1 - positif_ou_nul(IAMD1 +NAPCRPIAMD1 - SEUIL_61)) * 0) ;

regle 90114111 :
application : iliad , batch ;
PCAPNEG =  min(0,IPCAPTAXT+PPCAP -min(IPCAPTAXT+PPCAP,max(0,INE-IRB+AVFISCOPTER- TAXASSUR - PTAXA ))+ min(0,TAXANEG)) ;
PCAPTAXNET = positif(IPCAPTAXT)
                * max(0,IPCAPTAXT+PPCAP -min(IPCAPTAXT+PPCAP,max(0,INE-IRB+AVFISCOPTER- TAXASSUR - PTAXA ))+ min(0,TAXANEG)) ;
PCAPNET = null(NRINET + IMPRET + (RASAR * V_CR2) + 0) * PCAPTAXNET
	   + positif(NRINET + IMPRET + (RASAR * V_CR2) + 0)
			* ( positif_ou_nul(IAMD1+NAPCRPIAMD1  - SEUIL_61) * PCAPTAXNET + (1 - positif_ou_nul(IAMD1 +NAPCRPIAMD1 - SEUIL_61)) * 0 ) ;
regle 90114112 :
application : iliad , batch ;
LOYELEVNEG =  min(0,TAXLOY + PTAXLOY -min(TAXLOY + PTAXLOY,max(0,INE-IRB+AVFISCOPTER- TAXASSUR - PTAXA-IPCAPTAXT-PPCAP ))+ min(0,PCAPNEG)) ;
LOYELEVNET = positif(LOYELEV)
                * max(0,TAXLOY+PTAXLOY -min(TAXLOY+PTAXLOY,max(0,INE-IRB+AVFISCOPTER- TAXASSUR - PTAXA-IPCAPTAXT-PPCAP ))+ min(0,PCAPNEG)) ;
TAXLOYNET = null(NRINET + IMPRET + (RASAR * V_CR2) + 0) * LOYELEVNET
                + positif(NRINET + IMPRET + (RASAR * V_CR2) + 0)
                * ( positif_ou_nul(IAMD1 +NAPCRPIAMD1 - SEUIL_61) * LOYELEVNET + (1 - positif_ou_nul(IAMD1 +NAPCRPIAMD1 - SEUIL_61)) * 0 ) ;
regle 901141111 :
application : iliad , batch ;
CHRNEG = min(0 , IHAUTREVT + PHAUTREV + min(0 , LOYELEVNEG)) ;
CHRNET = positif(IHAUTREVT)
                * max(0,IHAUTREVT+PHAUTREV + min(0,LOYELEVNEG))
               ;
HAUTREVNET = (null(NRINET + IMPRET + (RASAR * V_CR2) + 0) * CHRNET
              +
              positif(NRINET + IMPRET + (RASAR * V_CR2) + 0)
              * ( positif_ou_nul(IAMD1 +NAPCRPIAMD1 - SEUIL_61) * CHRNET
              + (1 - positif_ou_nul(IAMD1 +NAPCRPIAMD1 - SEUIL_61)) * 0 )
              ) * (1-null(1-FLAG_ACO))
              ;
regle 9011412 :
application : bareme ;

IRNET = max(0 , IRNET2 + RECOMP) ;

regle 9011413 :
application : iliad , batch ;

IRPROV = min (IRANT , IAR + PIR) * positif(IRANT) ;

regle 9012401 :
application : batch , iliad ;
NAPPSAVIM = (PRS + PPRS ) ;
NAPCSAVIM = (CSG + PCSG ) ;
NAPRDAVIM = (RDSN + PRDS) ;
NAPGAINAVIM = (CGAINSAL + PGAIN) ;
NAPCSALAVIM = (CSAL + PCSAL) ;
NAPCVNAVIM = (CVNSALC + PCVN) ;
NAPCDISAVIM = (CDIS + PCDIS) ;
NAPGLOAVIM = (CGLOA + PGLOA) ;
NAPRSE1AVIM = (RSE1N + PRSE1) ;
NAPRSE2AVIM = (RSE2N + PRSE2) ;
NAPRSE3AVIM = (RSE3N + PRSE3) ;
NAPRSE4AVIM = (RSE4N + PRSE4) ;
NAPRSE5AVIM = (RSE5N + PRSE5) ;
NAPCRPAVIM = max(0 , NAPPSAVIM + NAPCSAVIM + NAPRDAVIM + NAPGAINAVIM + NAPCSALAVIM + NAPCVNAVIM + NAPCDISAVIM + NAPGLOAVIM
                    + NAPRSE1AVIM + NAPRSE2AVIM + NAPRSE3AVIM + NAPRSE4AVIM + NAPRSE5AVIM);
regle 90114010 :
application : batch , iliad ;
NAPCRPIAMD1 = PRS+CSG+RDSN +CGAINSAL + CSAL +CVNSALC + CDIS + CGLOA + RSE1N + RSE2N + RSE3N + RSE4N + RSE5N ;
regle 9011402 :
application : batch , iliad ;
NAPPS   = PRSNET   * positif_ou_nul(IAMD1 +NAPCRPIAMD1- SEUIL_61);
NAPCS   = CSNET    * positif_ou_nul(IAMD1 +NAPCRPIAMD1- SEUIL_61);
NAPRD   = RDNET    * positif_ou_nul(IAMD1 +NAPCRPIAMD1- SEUIL_61);
NAPGAIN = GAINNET  * positif_ou_nul(IAMD1 +NAPCRPIAMD1- SEUIL_61);
NAPCSAL = CSALNET  * positif_ou_nul(IAMD1 +NAPCRPIAMD1- SEUIL_61);
NAPCVN  = CVNNET   * positif_ou_nul(IAMD1 +NAPCRPIAMD1- SEUIL_61);
NAPCDIS = CDISNET  * positif_ou_nul(IAMD1 +NAPCRPIAMD1- SEUIL_61);
NAPGLOA = CGLOANET * positif_ou_nul(IAMD1 +NAPCRPIAMD1- SEUIL_61);
NAPRSE1 = RSE1NET  * positif_ou_nul(IAMD1 +NAPCRPIAMD1- SEUIL_61);
NAPRSE2 = RSE2NET  * positif_ou_nul(IAMD1 +NAPCRPIAMD1- SEUIL_61);
NAPRSE3 = RSE3NET  * positif_ou_nul(IAMD1 +NAPCRPIAMD1- SEUIL_61);
NAPRSE4 = RSE4NET  * positif_ou_nul(IAMD1 +NAPCRPIAMD1- SEUIL_61);
NAPRSE5 = RSE5NET  * positif_ou_nul(IAMD1 +NAPCRPIAMD1- SEUIL_61);
NAPCRP2 = max(0 , NAPPS + NAPCS + NAPRD + NAPGAIN + NAPCSAL + NAPCVN + NAPCDIS + NAPGLOA + NAPRSE1 + NAPRSE2 + NAPRSE3 + NAPRSE4 + NAPRSE5);
regle 9011407 :
application : iliad , batch ;
IKIRN = KIR ;

IMPTHNET = max(0 , (IRB * positif_ou_nul(IRB-SEUIL_61)-INE-IRE)
		       * positif_ou_nul((IRB*positif_ou_nul(IRB-SEUIL_61)-INE-IRE)-SEUIL_12)) 
	     * (1 - V_CNR) ;

regle 90115 :
application : iliad , batch ;
IRESTIT = abs(min(0 , IRN + PIR + NRINET + IMPRET + RASAR
                    + (TAXASSUR + PTAXA - min(TAXASSUR+PTAXA+0,max(0,INE-IRB+AVFISCOPTER)))
                    + (IPCAPTAXT + PPCAP - min(IPCAPTAXT + PPCAP,max(0,INE-IRB+AVFISCOPTER -TAXASSUR-PTAXA)))
                    + (TAXLOY + PTAXLOY - min(TAXLOY + PTAXLOY,max(0,INE-IRB+AVFISCOPTER -TAXASSUR-PTAXA-IPCAPTAXT-PPCAP)))
                    + (IHAUTREVT + PHAUTREV) * (1-null(1-FLAG_ACO))                                                   
                 + NAPCRPAVIM-(CSGIM+CRDSIM+PRSPROV+CSALPROV+GAINPROV+PROVCVNSAL+CDISPROV+CSPROVYD+CSPROVYF+CSPROVYG+CSPROVYH+CSPROVYE))
                 ) * positif_ou_nul(IAVIM+NAPCRPAVIM - SEUIL_61)
         + abs(min(0 , IRN + PIR + NRINET + IMPRET + RASAR
                  + (TAXASSUR + PTAXA - min(TAXASSUR+PTAXA+0,max(0,INE-IRB+AVFISCOPTER)))
                  + (IPCAPTAXT + PPCAP - min(IPCAPTAXT + PPCAP,max(0,INE-IRB+AVFISCOPTER -TAXASSUR-PTAXA)))
                  + (TAXLOY + PTAXLOY - min(TAXLOY + PTAXLOY,max(0,INE-IRB+AVFISCOPTER -TAXASSUR-PTAXA-IPCAPTAXT-PPCAP)))
                  + (IHAUTREVT + PHAUTREV) * (1-null(1-FLAG_ACO))))
		  * (1 - positif_ou_nul(IAVIM+NAPCRPAVIM - SEUIL_61))
		 ;
regle 90115001 :
application : iliad , batch ;
IRESTITIR = abs(min(0 , IRN + PIR + NRINET + IMPRET + RASAR
                    + (TAXASSUR + PTAXA - min(TAXASSUR+PTAXA+0,max(0,INE-IRB+AVFISCOPTER)))
                    + (IPCAPTAXT + PPCAP - min(IPCAPTAXT + PPCAP,max(0,INE-IRB+AVFISCOPTER -TAXASSUR-PTAXA)))
                    + (TAXLOY + PTAXLOY - min(TAXLOY + PTAXLOY,max(0,INE-IRB+AVFISCOPTER -TAXASSUR-PTAXA-IPCAPTAXT-PPCAP)))
                    + (IHAUTREVT + PHAUTREV) * (1-null(1-FLAG_ACO))
                 )
	     ) ;
regle 901151 :
application : iliad , batch ;
IREST = null(4 - V_IND_TRAIT) * max(0 , IRESTIT - RECUMBIS)
       + null(5- V_IND_TRAIT) * max(0,V_NONRESTANT - V_ANTRE - min(0,NAPTEMP));
regle 9011511 :
application : iliad , batch ;
IRESTIR = max(0 , IRESTITIR - RECUMBISIR);
IINETCALC = max(0,NAPTEMP - TOTIRPSANT);
NONREST  =  (null(V_IND_TRAIT -4) * positif(SEUIL_8 - IRESTIT) * IRESTIT)
   + (null(5-V_IND_TRAIT) * max(NONRESTEMP,min(7,(IDEGR+IREST)*positif(IRESTIT))));

regle 901160 :
application : batch , iliad ;
TOTREC = positif_ou_nul(IRN + TAXANET + PIR + PCAPNET + TAXLOYNET + HAUTREVNET + NAPCRP - SEUIL_12) ;
regle 90116011 :
application :  batch , iliad ;

CSREC = positif(NAPCRP) * positif_ou_nul((IAVIM +NAPCRPAVIM) - SEUIL_61);

CSRECINR = positif(NAPCRINR) ;

regle 90116 :
application : batch , iliad ;

RSEREC = positif(max(0 , NAPRSE1 + NAPRSE2 + NAPRSE3 + NAPRSE4 + NAPRSE5)
                 * positif_ou_nul(NAPTOT+NAPCRP- SEUIL_12)) ;

regle 9011603 :
application :  batch , iliad ;

CSRECA = positif_ou_nul(PRS_A + PPRS_A + CSG_A + RDS_A + PCSG_A + PRDS_A
                       + CSAL_A + CVN_A+ CDIS_A + CGLOA_A + GAINBASE_A + RSE1BASE_A + RSE2BASE_A + RSE3BASE_A + RSE4BASE_A + RSE5BASE_A + IRNIN_A
                       + TAXABASE_A + CHRBASE_A + PCAPBASE_A + LOYBASE_A
                       - SEUIL_12) ;
regle isf 90110 :
application : iliad ;
ISFDEGR = max(0,(ANTISFAFF  - ISF4BIS * positif_ou_nul (ISF4BIS - SEUIL_12)) 
	   * (1-positif_ou_nul (ISF4BIS - SEUIL_12))
          + (ANTISFAFF  - ISFNET * positif_ou_nul (ISFNET - SEUIL_12))
	   * positif_ou_nul(ISF4BIS - SEUIL_12)) ;


ISFDEG = ISFDEGR * positif_ou_nul(ISFDEGR - SEUIL_8) ;

regle corrective 9011602 :
application : iliad ;
IDEGR = max(0,V_IRPSANT + V_NONRESTANT - max(0,NAPTEMP));

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
regle 90504:
application : batch , iliad ;
ABSRE = ABMAR + ABVIE;
regle 90509:
application : iliad , batch ;

REVTP = PTP ;

regle 90522:
application : batch , iliad ;
RPEN = PTOTD * positif(APPLI_ILIAD + APPLI_COLBERT);
regle isf 905270:
application : iliad  ;
ANTISFAFF = V_ANTISF * (1-positif(APPLI_OCEANS));    

regle 90527:
application :  iliad  ;
ANTIRAFF = V_ANTIR  * APPLI_ILIAD   
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
regle 90514:
application : iliad , batch ;
IDRT = IDOM11;
regle 90525:
application : iliad , batch ;
IAVT = IRE - EPAV - CICA + 
          min( IRB , IPSOUR + CRCFA ) +
          min( max(0,IAN - IRE) , (BCIGA * (1 - positif(RE168+TAX1649))));
IAVT2 = IAVT + CICA;
regle 907001  :
application : iliad, batch ;
INDTXMOY = positif(TX_MIN_MET - TMOY) * positif( (present(RMOND) 
                             + present(DMOND)) ) * V_CR2 ;
INDTXMIN = positif_ou_nul( IMI - IPQ1 ) 
           * positif(1 - INDTXMOY) * V_CR2;
regle 907002  :
application : batch,  iliad ;
IND_REST = positif(IREST) ;
regle 907003  :
application :  iliad, batch ;
IND_NI =  null(NAPT) * (null (IRNET));
regle 9070030  :
application :  iliad, batch ;
IND_IMP = positif(NAPT);

INDNMR =  null(NAPT) * null(NAT1BIS) * (positif (IRNET + TAXANET + PCAPNET+ TAXLOYNET+ HAUTREVNET+NAPCRP));
IND61 =  (positif_ou_nul(IAMD1+NAPCRPIAMD1 - SEUIL_61) * 2)
	+ ((1-positif_ou_nul(IAMD1+NAPCRPIAMD1 - SEUIL_61))*positif(IAMD1+NAPCRPIAMD1) * 1)
	+ (null(IAMD1+NAPCRPIAMD1) * 3);
regle 9070031  :
application :  iliad, batch ;
INDCEX =  null(1-NATIMP) *1
+ positif(null(11-NATIMP)+null(21-NATIMP)+null(81-NATIMP)+null(91-NATIMP)) * 2
+ null(00 - NATIMP) * 3;

INDNMRI = INDNMR * positif ( RED ) ;

INDNIRI =   positif(IDOM11-DEC11) * null(IAD11);
regle 907004  :
application : batch , iliad ;

IND_REST50 = positif(SEUIL_8 - IREST) * positif(IREST) * (1-positif(APPLI_OCEANS));
IND08 = positif(NAPT*(-1)) * (positif(SEUIL_8 - abs(NAPT)) * 1 
                          + (1-positif(SEUIL_8 - abs(NAPT))) * 2 );

regle 9070041  :
application : iliad, batch;
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
regle 907005  :
application : iliad , batch ;
INDNMR1 = (1 - positif(IAMD1 + NAPCRPIAMD1 + 1 - SEUIL_61)) 
	   * null(NAPT) * positif(IAMD1 + NAPCRPIAMD1) ;

INDNMR2 = positif(INDNMR) * (1 - positif(INDNMR1)) ;
IND12 = (positif(SEUIL_12 - (CSTOT +IRNET+TAXANET+TAXLOYNET+PCAPNET+HAUTREVNET-IRESTITIR))*
			   positif(CSTOT +IRNET+TAXANET+TAXLOYNET+PCAPNET+HAUTREVNET-IRESTITIR)* 1 )
	+ ((1 - positif(SEUIL_12 - (CSTOT +IRNET+TAXANET+TAXLOYNET+PCAPNET+HAUTREVNET-IRESTITIR))) * 2 )
	+ (null(CSTOT +IRNET+TAXANET+TAXLOYNET+PCAPNET+HAUTREVNET-IRESTITIR) * 3);
regle 907006  :
application : batch,iliad ;


INDV = positif_ou_nul ( 
  positif( ALLOV ) 
 + positif( REMPLAV ) + positif( REMPLANBV )
 + positif( BACDEV ) + positif( BACREV )
 + positif( 4BACREV ) + positif( 4BAHREV )
 + positif( BAFPVV )
 + positif( BAFV ) + positif( BAHDEV ) + positif( BAHREV )
 + positif( BICDEV ) + positif( BICDNV )
 + positif( BICHDEV )
 + positif( BICHREV ) + positif( BICNOV )
 + positif( BICREV ) 
 + positif( BIHDNV ) + positif( BIHNOV )
 + positif( BNCAADV ) + positif( BNCAABV ) + positif( BNCDEV ) + positif( BNCNPPVV )
 + positif( BNCNPV ) + positif( BNCPROPVV ) + positif( BNCPROV )
 + positif( BNCREV ) + positif( BNHDEV ) + positif( BNHREV )
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
 + positif( LOCNPV ) + positif( LOCDEFNPCGAV ) + positif( LOCDEFNPV )
 + positif( MIBMEUV ) + positif( MIBGITEV ) + positif( BICPMVCTV )
 + positif( BNCPMVCTV ) + positif( LOCGITV )
);
INDC = positif_ou_nul ( 
  positif( ALLOC ) 
 + positif( REMPLAC ) + positif( REMPLANBC )
 + positif( BACDEC ) + positif( BACREC )
 + positif( 4BACREC ) + positif( 4BAHREC )
 + positif( BAFC ) + positif( ANOVEP ) + positif( DNOCEPC )
 + positif( BAFPVC ) + positif( BAHDEC ) + positif( BAHREC )
 + positif( BICDEC ) + positif( BICDNC )
 + positif( BICHDEC ) 
 + positif( BICHREC ) + positif( BICNOC )
 + positif( BICREC )  
 + positif( BIHDNC ) + positif( BIHNOC )
 + positif( BNCAADC ) + positif( BNCAABC ) + positif( BNCDEC ) + positif( BNCNPC )
 + positif( BNCNPPVC ) + positif( BNCPROC ) + positif( BNCPROPVC )
 + positif( BNCREC ) + positif( BNHDEC ) + positif( BNHREC )
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
 + positif( LOCNPC ) + positif( LOCDEFNPCGAC ) + positif( LOCDEFNPC )
 + positif( MIBMEUC ) + positif( MIBGITEC ) + positif( BICPMVCTC )
 + positif( BNCPMVCTC ) + positif( LOCGITC )
 );
INDP = positif_ou_nul (
  positif( ALLO1 ) + positif( ALLO2 ) + positif( ALLO3 ) + positif( ALLO4 ) 
 + positif( CARTSP1 ) + positif( CARTSP2 ) + positif( CARTSP3 ) + positif( CARTSP4 )
 + positif( CARTSNBAP1 ) + positif( CARTSNBAP2 ) + positif( CARTSNBAP3 ) + positif( CARTSNBAP4 )
 + positif( REMPLAP1 ) + positif( REMPLAP2 ) + positif( REMPLAP3 ) + positif( REMPLAP4 )
 + positif( REMPLANBP1 ) + positif( REMPLANBP2 ) + positif( REMPLANBP3 ) + positif( REMPLANBP4 )
 + positif( BACDEP ) + positif( BACREP )
 + positif( 4BACREP ) + positif( 4BAHREP )
 + positif( BAFP ) + positif( ANOPEP ) + positif( DNOCEPP )
 + positif( BAFPVP ) + positif( BAHDEP ) + positif( BAHREP )
 + positif( BICDEP ) + positif( BICDNP )
 + positif( BICHDEP ) 
 + positif( BICHREP ) + positif( BICNOP )
 + positif( BICREP )  
 + positif( BIHDNP ) + positif( BIHNOP )
 + positif( BNCAADP ) + positif( BNCAABP ) + positif( BNCDEP ) + positif( BNCNPP )
 + positif( BNCNPPVP ) + positif( BNCPROP ) + positif( BNCPROPVP )
 + positif( BNCREP ) + positif( BNHDEP ) + positif( BNHREP )
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
 + positif( LOCNPPAC ) + positif( LOCDEFNPCGAPAC ) + positif( LOCDEFNPPAC )
 + positif( LOCDEFPROCGAP ) + positif( LOCDEFPROP )
 + positif( MIBMEUP ) + positif( MIBGITEP )  + positif( BICPMVCTP )
 + positif( BNCPMVCTP ) + positif( LOCGITP )
 );

regle 907007  :
application : iliad , batch ;


INDREV1A8IR = positif (
  positif( 4BACREC )
 + positif( 4BACREP ) + positif( 4BACREV ) + positif( 4BAHREC )
 + positif( 4BAHREP ) + positif( 4BAHREV ) 
 + positif( ABDETMOINS ) + positif( ABDETPLUS ) 
 + positif( ALLO1 ) + positif( ALLO2 ) + positif( ALLO3 ) + positif( ALLO4 )
 + positif( ALLOC ) + positif( ALLOV ) + positif( ANOCEP )
 + positif( ANOPEP ) + positif( ANOVEP ) 
 + positif( AUTOBICPC )
 + positif( AUTOBICPP ) + positif( AUTOBICPV ) + positif( AUTOBICVC )
 + positif( AUTOBICVP ) + positif( AUTOBICVV ) + positif( AUTOBNCC )
 + positif( AUTOBNCP ) + positif( AUTOBNCV ) + positif( BA1AC )
 + positif( BA1AP ) + positif( BA1AV ) + positif( BACDEC )
 + positif( BACDEP ) + positif( BACDEV ) + positif( BACREC )
 + positif( BACREP ) + positif( BACREV ) + positif( BAEXC )
 + positif( BAEXP ) + positif( BAEXV ) + positif( BAF1AC )
 + positif( BAF1AP ) + positif( BAF1AV ) + positif( BAFC )
 + positif( BAFORESTC ) + positif( BAFORESTP ) + positif( BAFORESTV )
 + positif( BAFP ) + positif( BAFPVC ) + positif( BAFPVP )
 + positif( BAFPVV ) + positif( BAFV ) + positif( BAHDEC )
 + positif( BAHDEP ) + positif( BAHDEV ) + positif( BAHEXC )
 + positif( BAHEXP ) + positif( BAHEXV ) + positif( BAHREC )
 + positif( BAHREP ) + positif( BAHREV ) + positif( BAILOC98 )
 + positif( BAPERPC ) + positif( BAPERPP ) + positif( BAPERPV )
 + positif( BI1AC ) + positif( BI1AP ) + positif( BI1AV )
 + positif( BI2AC ) + positif( BI2AP ) + positif( BI2AV )
 + positif( BICDEC ) + positif( BICDEP ) 
 + positif( BICDEV )
 + positif( BICDNC ) + positif( BICDNP ) + positif( BICDNV )
 + positif( BICEXC ) + positif( BICEXP ) + positif( BICEXV )
 + positif( BICHDEC ) + positif( BICHDEP ) 
 + positif( BICHDEV ) + positif( BICHREC ) + positif( BICHREP ) 
 + positif( BICHREV )
 + positif( BICNOC ) + positif( BICNOP ) + positif( BICNOV )
 + positif( BICNPEXC ) + positif( BICNPEXP ) + positif( BICNPEXV )
 + positif( BICNPHEXC ) + positif( BICNPHEXP ) + positif( BICNPHEXV )
 + positif( BICREC ) + positif( BICREP ) 
 + positif( BICREV )
 + positif( BIHDNC ) + positif( BIHDNP ) + positif( BIHDNV )
 + positif( BIHEXC ) + positif( BIHEXP ) + positif( BIHEXV )
 + positif( BIHNOC ) + positif( BIHNOP ) + positif( BIHNOV )
 + positif( BIPERPC ) + positif( BIPERPP ) + positif( BIPERPV )
 + positif( BN1AC ) + positif( BN1AP ) + positif( BN1AV )
 + positif( BNCAABC ) + positif( BNCAABP ) + positif( BNCAABV )
 + positif( BNCAADC ) + positif( BNCAADP ) + positif( BNCAADV )
 + positif( BNCCRC ) + positif( BNCCRFC ) + positif( BNCCRFP )
 + positif( BNCCRFV ) + positif( BNCCRP ) + positif( BNCCRV )
 + positif( BNCDEC ) + positif( BNCDEP ) + positif( BNCDEV )
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
 + positif( BNCREP ) + positif( BNCREV ) + positif( BNHDEC )
 + positif( BNHDEP ) + positif( BNHDEV ) + positif( BNHEXC )
 + positif( BNHEXP ) + positif( BNHEXV ) + positif( BNHREC )
 + positif( BNHREP ) + positif( BNHREV ) + positif( BPCOPTV )
 + positif( BPCOSAC ) + positif( BPCOSAV ) 
 + positif( BPV18V ) + positif( BPV40V )
 + positif( BPVKRI ) + positif( BPVOPTCSV ) + positif( BPVOPTCSC )
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
 + positif( GAINABDET ) + positif( GAINSALAV ) + positif( GAINSALAC )
 + positif( GLDGRATV ) + positif( GLDGRATC)
 + positif( GLD1C ) + positif( GLD1V )
 + positif( GLD2C ) + positif( GLD2V ) + positif( GLD3C )
 + positif( GLD3V ) + positif( HEURESUPC ) + positif( HEURESUPP1 )
 + positif( HEURESUPP2 ) + positif( HEURESUPP3 ) + positif( HEURESUPP4 )
 + positif( HEURESUPV ) + positif( LOCDEFNPC ) + positif( LOCDEFNPCGAC )
 + positif( LOCDEFNPCGAPAC ) + positif( LOCDEFNPCGAV ) + positif( LOCDEFNPPAC )
 + positif( LOCDEFNPV ) + positif( LOCDEFPROC ) + positif( LOCDEFPROCGAC )
 + positif( LOCDEFPROCGAP ) + positif( LOCDEFPROCGAV ) + positif( LOCDEFPROP )
 + positif( LOCDEFPROV ) + positif( LOCNPC ) + positif( LOCNPCGAC )
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
 + positif( PPETPP4 ) + positif( PPETPV ) + positif( PPLIB )
 + positif( PRBR1 ) + positif( PRBR2 ) + positif( PRBR3 )
 + positif( PRBR4 ) + positif( PRBRC ) + positif( PRBRV )
 + positif( PVINCE ) + positif( PVINPE ) + positif( PVINVE )
 + positif( PVJEUNENT ) + positif( PVREP8 ) + positif( PVSOCC )
 + positif( PVSOCV ) + positif( RCMABD ) 
 + positif( RCMAV ) + positif( RCMAVFT ) + positif( RCMFR )
 + positif( RCMHAB ) + positif( RCMHAD ) + positif( RCMLIB )
 + positif( RCMLIBDIV ) + positif( RCMRDS ) + positif( RCMSOC )
 + positif( RCMTNC ) + positif( RCSC ) + positif( RCSP )
 + positif( RCSV ) + positif( REGPRIV ) + positif( RFDANT )
 + positif( RFDHIS ) + positif( RFDORD ) + positif( RFMIC )
 + positif( RFORDI ) + positif( RFROBOR ) + positif( RSAFOYER )
 + positif( RSAPAC1 ) + positif( RSAPAC2 ) + positif( RVB1 )
 + positif( RVB2 ) + positif( RVB3 ) + positif( RVB4 )
 + positif( TSASSUC ) + positif( TSASSUV ) + positif( TSELUPPEC )
 + positif( TSELUPPEV ) + positif( TSHALLO1 ) + positif( TSHALLO2 )
 + positif( TSHALLO3 ) + positif( TSHALLO4 ) + positif( TSHALLOC )
 + positif( TSHALLOV ) + positif( XETRANC ) + positif( XETRANV )
 + positif( XHONOAAC ) + positif( XHONOAAP ) + positif( XHONOAAV )
 + positif( XHONOC ) + positif( XHONOP ) + positif( XHONOV )
 + positif( XSPENPC ) + positif( XSPENPP ) + positif( XSPENPV )
 + positif( GSALV ) + positif( GSALC ) 
 + positif( LNPRODEF1 ) + positif( LNPRODEF2 ) + positif( LNPRODEF3 ) + positif( LNPRODEF4 ) 
 + positif( LNPRODEF5 ) + positif( LNPRODEF6 ) + positif( LNPRODEF7 ) + positif( LNPRODEF8 ) 
 + positif( LNPRODEF9 ) + positif( LNPRODEF10 ) 
 + positif( FONCI ) + positif( REAMOR ) + positif( FONCINB ) + positif( REAMORNB )
 + positif( MIBMEUV ) + positif( MIBMEUC ) + positif( MIBMEUP )
 + positif( MIBGITEV ) + positif( MIBGITEC ) + positif( MIBGITEP )
 + positif( PCAPTAXV ) + positif( PCAPTAXC )
 + positif( PVPART ) + positif( PVIMMO ) + positif( PVSURSI ) + positif( PVIMPOS )
 + positif( BANOCGAV ) + positif( BANOCGAC ) + positif( BANOCGAP )
 + positif( INVENTV ) + positif( INVENTC ) + positif( INVENTP )
 + positif( LOCGITV ) + positif( LOCGITC ) + positif( LOCGITP )
 + positif( LOCGITCV ) + positif( LOCGITCC ) + positif( LOCGITCP )
 + positif( LOCGITHCV ) + positif( LOCGITHCC ) + positif( LOCGITHCP )
 + positif( SALINTV ) + positif( SALINTC )
 + positif( PVDIRTAX ) + positif( PVTAXSB ) + positif( PVTAXSC )
 + positif( BPV18C ) + positif( PVMOBNR ) + positif( BPV40C )
 + positif( BPCOPTC ) + positif( BPVSJ ) + positif( BPVSK )
 + positif( CVNSALAC ) + positif( BPVOPTCSC ) + positif( GAINSALAC )
 + positif( CVNSALAV ) + positif( GAINPEA ) 
 + positif( PVEXOSEC ) + positif( ABPVSURSIS ) + positif( ABPVNOSURSIS )
 + positif( PVSURSIWF ) + positif( PVSURSIWG ) + positif( PVREPORT )
 + positif( LOYELEV )

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
 + present( CELREPHR ) + present( CELREPHS ) + present( CHENF1 )
 + present( CELREPHT ) + present( CELREPHU ) + present( CELREPHV )
 + present( CELREPHW ) + present( CELREPHX ) + present( CELREPHZ )
 + present( CELREPHA ) + present( CELREPHB ) + present( CELREPHD )
 + present( CELREPHE ) + present( CELREPHF ) + present( CELREPHG ) + present( CELREPHH )
 + present( INVNPROF1 ) + present( VIEUMEUB ) + present( INVREPMEU )
 + present( INVREPNPRO ) + present( INVNPROREP ) + present( INVREDMEU )
 + present( REDREPNPRO ) + present( INVNPROF2  ) + present( RESIVIANT )
 + present( CHENF2 ) + present( CHENF3 ) + present( CHENF4 )
 + present( CHNFAC ) + present( CHRDED ) + present( CHRFAC )
 + present( CIAQCUL ) + present( CIBOIBAIL ) 
 + present( CIDEBITTABAC ) + present( CIIMPPRO )
 + present( CIIMPPRO2 ) + present( CIINVCORSE ) + present( CINE1 )
 + present( CINE2 ) + present( CINRJBAIL ) + present( CIDEP15 )
 + present( CO35 ) + present( RISKTEC ) + present( CINRJ )
 + present( COSBC ) + present( COSBP )
 + present( COSBV ) + present( CRDSIM ) + present( CREAGRIBIO )
 + present( CREAIDE ) + present( CREAPP ) + present( CREARTS )
 + present( CRECHOBAS ) + present( CRECHOBOI ) 
 + present( CRECHOCON2 ) + present( CRECONGAGRI ) + present( CREDPVREP )
 + present( CREFAM ) + present( CREFORMCHENT ) 
 + present( CREINTERESSE ) + present( CRENRJRNOUV ) + present( CREPROSP )
 + present( CRERESTAU ) + present( CRIGA ) + present( CRENRJ )
 + present( CSALPROV ) + present( CDISPROV) + present( CSGIM ) 
 + present( DCSG ) + present( DCSGIM )
 + present( DEFAA0 ) + present( DEFAA1 ) + present( DEFAA2 )
 + present( DEFAA3 ) + present( DEFAA4 ) + present( DEFAA5 )
 + present( DEPCHOBAS ) + present( DEPMOBIL ) + present( DMOND )
 + present( ELURASC ) + present( ELURASV ) + present( ESFP )
 + present( FCPI )
 + present( FFIP ) + present( FIPCORSE ) + present( FORET )
 + present( INAIDE ) + present( INDLOCNEUF ) + present( INDLOCRES )
 + present( INTDIFAGRI ) + present( INVDIR2009 )
 + present( INVDOMRET50 ) + present( INVDOMRET60 )
 + present( INVLGDEB2009 ) + present( INVLOCHOTR ) + present( INVLOCXN )
 + present( INVLOCXV ) + present( INVLOCXX ) + present( INVLOCXZ )
 + present( INVLOCHOTR1 ) + present( INVLOCNEUF ) + present( INVLOCRES )
 + present( INVLOCT1 ) + present( INVLOCT2 ) + present( INVLOG2008 )
 + present( INVLOCT1AV ) + present( INVLOCT2AV )
 + present( INVLOG2009 ) + present( INVLOGSOC ) + present( INVLGAUTRE ) 
 + present( INVLGDEB2010 ) + present( INVSOC2010 ) + present( INVRETRO1 )
 + present( INVRETRO2 ) + present( INVIMP )
 + present( INVLGDEB ) + present( INVENDEB2009 )
 + present( PATNAT ) + present( PATNAT1 ) + present( PATNAT2 ) 
 + present( INVSOCNRET ) + present( INVENDI )
 + present( CELRREDLA ) + present( CELRREDLB ) + present( CELRREDLC ) 
 + present( CELRREDLD ) + present( CELRREDLE ) + present( CELRREDLF )
 + present( NRETROC50 ) + present( NRETROC40 ) + present( INVOMREP ) 
 + present( RETROCOMMB ) + present( RETROCOMMC )
 + present( RETROCOMLH ) + present( RETROCOMLI )
 + present( INVOMSOCQU ) + present( INVOMQV )
 + present( INVOMSOCKH ) + present( INVOMSOCKI ) 
 + present( INVOMSOCQJ ) + present( INVOMSOCQS )
 + present( INVOMSOCQW ) + present( INVOMSOCQX )
 + present( INVOMENTRG ) + present( INVOMENTRH ) + present( INVOMENTRI )
 + present( INVOMENTRJ ) + present( INVOMENTRK ) + present( INVOMENTRL )
 + present( INVOMENTRM ) + present( INVOMENTRN ) + present( INVOMENTRO )
 + present( INVOMENTRP ) + present( INVOMENTRQ ) + present( INVOMENTRR )
 + present( INVOMENTRS ) + present( INVOMENTRT ) + present( INVOMENTRU )
 + present( INVOMENTRV ) + present( INVOMENTRW ) + present( INVOMENTRX ) + present( INVOMENTRY )
 + present( INVOMENTKT ) + present( INVOMENTKU ) + present( INVOMENTMN )
 + present( INVOMENTNU ) + present( INVOMENTNV ) + present( INVOMENTNW )
 + present( INVOMENTNX ) + present( INVOMENTNY )
 + present( INVOMRETPA ) + present( INVOMRETPB ) + present( INVOMRETPD ) 
 + present( INVOMRETPE ) + present( INVOMRETPF ) + present( INVOMRETPH ) 
 + present( INVOMRETPI ) + present( INVOMRETPJ ) + present( INVOMRETPL )
 + present( INVOMRETPM ) + present( INVOMRETPN ) + present( INVOMRETPO )
 + present( INVOMRETPP ) + present( INVOMRETPQ ) + present( INVOMRETPR )
 + present( INVOMRETPS ) + present( INVOMRETPT ) + present( INVOMRETPU )
 + present( INVOMRETPV ) + present( INVOMRETPW ) + present( INVOMRETPX ) + present( INVOMRETPY )
 + present( INVOMLOGOA ) + present( INVOMLOGOB ) + present( INVOMLOGOC )
 + present( INVOMLOGOH ) + present( INVOMLOGOI ) + present( INVOMLOGOJ ) + present( INVOMLOGOK )
 + present( INVOMLOGOL ) + present( INVOMLOGOM ) + present( INVOMLOGON )
 + present( INVOMLOGOO ) + present( INVOMLOGOP ) + present( INVOMLOGOQ )
 + present( INVOMLOGOR ) + present( INVOMLOGOS ) + present( INVOMLOGOT )
 + present( INVOMLOGOU ) + present( INVOMLOGOV ) + present( INVOMLOGOW )
 + present( LOCMEUBIA ) + present( LOCMEUBIB ) + present( LOCMEUBIC )
 + present( LOCMEUBID ) + present( LOCMEUBIE ) + present( LOCMEUBIF )
 + present( LOCMEUBIG ) + present( LOCMEUBIH ) + present( LOCMEUBII )
 + present( LOCMEUBIX ) + present( LOCMEUBIZ )
 + present( IPBOCH ) + present( IPELUS ) + present( IPMOND ) + present( SALECS )
 + present( SALECSG ) + present( CICORSENOW ) + present( PRESINTER )
 + present( IPPNCS ) + present( IPPRICORSE ) + present( IPRECH ) + present( IPCHER )
 + present( IPREP ) + present( IPREPCORSE ) + present( IPSOUR )
 + present( IPSUIS ) + present( IPSUISC ) + present( IPSURSI )
 + present( IPSURV ) + present( IPTEFN ) + present( IPTEFP )
 + present( IPTXMO ) + present( IPVLOC ) + present( IRANT )
 + present( LOCRESINEUV ) + present( REPMEUBLE ) + present( MEUBLENP ) 
 + present( RESIVIEU ) + present( REDMEUBLE ) + present( NBACT )
 + present( CONVCREA ) + present( CONVHAND )
 + present( NCHENF1 ) + present( NCHENF2 ) + present( NCHENF3 )
 + present( NCHENF4 ) + present( NRBASE ) + present( NRINET ) 
 + present( IMPRET ) + present( BASRET )
 + present( NUPROP ) + present( REPGROREP1 ) + present( REPGROREP2) + present( REPGROREP11 ) 
 + present( OPTPLAF15 ) + present( PAAP ) + present( PAAV ) 
 + present( PERPC ) + present( PERPP ) + present( PERPV )
 + present( PERP_COTC ) + present( PERP_COTP ) + present( PERP_COTV )
 + present( PETIPRISE ) + present( PLAF_PERPC ) + present( PLAF_PERPP ) + present( PLAF_PERPV ) 
 + present( PREHABT ) + present( PREHABTN1 ) + present( PREHABTN2 ) + present( PREHABTVT )
 + present( PREHABT1 ) + present( PREHABT2 ) + present( PREHABTN ) + present( PREMAIDE )
 + present( PRESCOMP2000 ) + present( PRESCOMPJUGE ) + present( PRETUD )
 + present( PRETUDANT ) + present( PRODOM ) + present( PROGUY )
 + present( PRSPROV ) + present( PTZDEVDUR ) + present( R1649 )
 + present( PTZDEVDURN ) + present( PREREV )
 + present( RACCOTC ) + present( RACCOTP ) + present( RACCOTV )
 + present( RCCURE ) + present( RDCOM ) + present( RDDOUP )
 + present( RDENL ) + present( RDENLQAR ) + present( RDENS )
 + present( RDENSQAR ) + present( RDENU ) + present( RDENUQAR )
 + present( RDEQPAHA ) + present( RDFDOU ) + present( RDFOREST )
 + present( RDFORESTGES ) + present( RDFORESTRA ) + present( RDFREP ) + present( COTFORET )
 + present( REPFOR ) + present( REPSINFOR ) + present( REPSINFOR1 ) 
 + present( REPSINFOR2 ) + present( REPFOR1 ) + present( REPFOR2 )
 + present( RDGARD1 ) + present( RDGARD1QAR ) + present( RDGARD2 )
 + present( RDGARD2QAR ) + present( RDGARD3 ) + present( RDGARD3QAR )
 + present( RDGARD4 ) + present( RDGARD4QAR ) + present( RDGEQ ) + present( RDTECH )
 + present( RDMECENAT ) + present( RDPRESREPORT ) + present( RDREP )
 + present( RDRESU ) + present( RDSNO ) + present( RDSYCJ )
 + present( RDSYPP ) + present( RDSYVO ) + present( RE168 ) 
 + present( TAX1649 ) 
 + present( REGCI ) + present( REPDON03 ) + present( REPDON04 )
 + present( REPDON05 ) + present( REPDON06 ) + present( REPDON07 )
 + present( REPINVDOMPRO2 ) + present( REPINVDOMPRO3 )
 + present( REPINVLOCINV ) + present( RINVLOCINV )
 + present( REPINVLOCREA ) + present( RINVLOCREA ) + present( REPSNO1 ) + present( REPSNO2 )
 + present( REPINVTOU ) + present( INVLOGREHA ) + present( INVLOGHOT )
 + present( REPSNO3 ) + present( REPSNON ) + present( REPSOF ) 
 + present( RESTIMOPPAU ) + present( RIMOPPAUANT ) + present( RIMOSAUVANT )
 + present( RESTIMOSAUV ) + present( RIMOPPAURE ) + present( RIMOSAUVRF ) 
 + present( REVMAR1 ) + present( REVMAR2 )
 + present( REVMAR3 ) + present( RIRENOV )
 + present( RMOND ) + present( RSOCREPRISE )
 + present( RVAIDE ) + present( RVAIDAS ) + present( RVCURE ) + present( SINISFORET )
 + present( SUBSTITRENTE ) + present( FIPDOMCOM )
 + present( ALLECS ) + present( INDECS ) + present( PENECS )
 + present( DONETRAN ) + present( RDFDONETR ) + present( DONAUTRE ) + present( RDFDAUTRE )
 + present( MATISOSI ) + present( MATISOSJ ) + present( VOLISO )
 + present( PORENT ) + present( ELESOL ) + present( CHAUBOISN )
 + present( CHAUBOISO ) + present( POMPESP ) + present( POMPESQ )
 + present( POMPESR ) + present( CHAUFSOL ) + present( ENERGIEST )
 + present( EAUPLUV ) + present( DIAGPERF ) + present( RESCHAL )
 + present( DEPENV ) + present( ISOTOIVE ) + present( ISOTOIVF ) + present( TRATOIVG )
 + present( ISOMURWA ) + present( ISOMURWB ) + present( TRAMURWC )
 + present( PARVITWS ) + present( TRAVITWT ) + present( VOLISOWU )
 + present( VOLISOWV ) + present( PORTEWW ) + present( PORTEWX )
 + present( RFRN2 ) + present( RFRN3 ) + present( RFRH1 ) + present( RFRH2 )
 + present( V_8ZT ) + present( ZONEANTEK )
 );


INDREV1A8 = positif(INDREV1A8IR);

IND_REV8FV = positif(INDREV1A8);

IND_REV = positif( IND_REV8FV + positif(REVFONC));
regle 907008  :
application : batch,iliad ;

IND_SPR = positif(  
            somme(i=V,C,1,2,3,4: present(PRBi) + present(TSBNi) + present(FRNi))
	    + somme(i=V,C ; j=1,2 : present(GLDji) ) 
	    + somme(i=2,3,4 ; j=V,C,1,2,3,4 : present(iTSNj) + present(iPRBj))
                 ) ;

regle 907009  :
application : iliad, batch;
INDPL = null(PLA - PLAF_CDPART);
regle 907099  :
application : iliad, batch;
INDTEFF = (1 - positif(null(2 - V_REGCO) + null(4 - V_REGCO)))
        * (1 - positif(positif(IPTEFP)+positif(IPTEFN))) * positif( 
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
 + positif( XHONOP ))+0 ;
regle  90714 :
application : batch ;
TXTO = COPETO + TXINT;
regle  907140 :
application : iliad ;
R_QUOTIENT = TONEQUO ;
regle  907141 :
application : batch ;
NATMAJ = 1 ;
NATMAJC = 1 ;
NATMAJR = 1 ;
NATMAJP = 1 ;
NATMAJGAIN = 1 ;
NATMAJCSAL = 1 ;
NATMAJCDIS = 1 ;
NATMAJGLOA = 1 ;
NATMAJCVN  = 1 ;
NATMAJRSE1 = 1 ;
NATMAJRSE2 = 1 ;
NATMAJRSE3 = 1 ;
NATMAJRSE4 = 1 ;
NATMAJRSE5 = 1 ;
RETX = TXINT;
MAJTXC = COPETO;
TXC = COPETO + TXINT;
MAJTXR = COPETO;
TXR = COPETO + TXINT;
MAJTXP = COPETO;
TXP = COPETO + TXINT;
MAJTXGAIN = COPETO ;
TXGAIN = COPETO + TXINT ;
MAJTXCSAL = COPETO;
TXCSAL = COPETO + TXINT;
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
regle  9071421 :
application : iliad ;

TXTO = TXINR * (1-positif(TXINR_A)) + (-1) * positif(TXINR_A) * positif(TXINR) * positif(TXINR - TXINR_A)
		+ TXINR * positif(TXINR_A) * null(TXINR - TXINR_A);
regle  907142 :
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

TXPFICSAL = si (V_CODPFICSAL=03 ou V_CODPFICSAL=30 ou V_CODPFICSAL=55) 
	    alors (40)
	    sinon (
	      si (V_CODPFICSAL=04 ou V_CODPFICSAL=05) alors (80)
	      sinon (
	        si (V_CODPFICSAL=06) alors (100)
	        finsi)
              finsi)
	    finsi ;

TXPFIGAIN = si (V_CODPFIGAIN=03 ou V_CODPFIGAIN=30 ou V_CODPFIGAIN=55) 
	    alors (40)
	    sinon (
	      si (V_CODPFIGAIN=04 ou V_CODPFIGAIN=05) alors (80)
	      sinon (
	        si (V_CODPFIGAIN=06) alors (100)
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

TXPF1728CSAL = si (V_CODPF1728CSAL=07 ou V_CODPF1728CSAL=10 ou V_CODPF1728CSAL=17 ou V_CODPF1728CSAL=18)
	       alors (10)
	       sinon (
		 si (V_CODPF1728CSAL=08 ou V_CODPF1728CSAL=11)
	         alors (40)
                 sinon (
		   si (V_CODPF1728CSAL=31) 
		   alors (80)
		   finsi)
		 finsi)
	       finsi ;

TXPF1728GAIN = si (V_CODPF1728GAIN=07 ou V_CODPF1728GAIN=10 ou V_CODPF1728GAIN=17 ou V_CODPF1728GAIN=18)
	       alors (10)
	       sinon (
		 si (V_CODPF1728GAIN=08 ou V_CODPF1728GAIN=11)
	         alors (40)
                 sinon (
		   si (V_CODPF1728GAIN=31) 
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

regle  9071420 :
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
	      * ((1 - positif(CMAJ)) * positif(NMAJCHR1) * TXPF1728CHR + positif(CMAJ) * COPETO)
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

MAJTXCSAL1 = (1 - positif(V_NBCOD1728CSAL))
	      * ((1 - positif(CMAJ)) * positif(NMAJCSAL1) * TXPF1728CSAL + positif(CMAJ) * COPETO)
	     + positif(V_NBCOD1728CSAL) * (-1) ;

MAJTXGAIN1 = (1 - positif(V_NBCOD1728GAIN))
	      * ((1 - positif(CMAJ)) * positif(NMAJGAIN1) * TXPF1728GAIN + positif(CMAJ) * COPETO)
	     + positif(V_NBCOD1728GAIN) * (-1) ;

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

MAJTXLOY4 = (1 - positif(V_NBCODILOY)) 
	      * ((1 - positif(CMAJ)) * positif(NMAJLOY4) * TXPFILOY + positif(CMAJ) * COPETO)
	     + positif(V_NBCODILOY) * (-1) ;

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

MAJTXCVN4 = (1 - positif(V_NBCODICVN))
	      * ((1 - positif(CMAJ)) * positif(NMAJCVN4) * TXPFICVN + positif(CMAJ) * COPETO)
	     + positif(V_NBCODICVN) * (-1) ;

MAJTXCSAL4 = (1 - positif(V_NBCODICSAL))
	      * ((1 - positif(CMAJ)) * positif(NMAJCSAL4) * TXPFICSAL + positif(CMAJ) * COPETO)
	     + positif(V_NBCODICSAL) * (-1) ;

MAJTXGAIN4 = (1 - positif(V_NBCODIGAIN))
	      * ((1 - positif(CMAJ)) * positif(NMAJGAIN4) * TXPFIGAIN + positif(CMAJ) * COPETO)
	     + positif(V_NBCODIGAIN) * (-1) ;

MAJTXCDIS4 = (1 - positif(V_NBCODICDIS))
	      * ((1 - positif(CMAJ)) * positif(NMAJCDIS4) * TXPFICDIS + positif(CMAJ) * COPETO)
	     + positif(V_NBCODICDIS) * (-1) ;

MAJTXRSE14 = (1 - positif(V_NBCODIRSE1))
	      * ((1 - positif(CMAJ)) * positif(NMAJRSE14) * TXPFIRSE1 + positif(CMAJ) * COPETO)
	     + positif(V_NBCODIRSE1) * (-1) ;

MAJTXRSE54 = (1 - positif(V_NBCODIRSE5))
	      * ((1 - positif(CMAJ)) * positif(NMAJRSE54) * TXPFIRSE5 + positif(CMAJ) * COPETO)
	     + positif(V_NBCODIRSE5) * (-1) ;

MAJTXRSE24 = (1 - positif(V_NBCODIRSE2))
	      * ((1 - positif(CMAJ)) * positif(NMAJRSE24) * TXPFIRSE2 + positif(CMAJ) * COPETO)
	     + positif(V_NBCODIRSE2) * (-1) ;

MAJTXRSE34 = (1 - positif(V_NBCODIRSE3))
	      * ((1 - positif(CMAJ)) * positif(NMAJRSE34) * TXPFIRSE3 + positif(CMAJ) * COPETO)
	     + positif(V_NBCODIRSE3) * (-1) ;

MAJTXRSE44 = (1 - positif(V_NBCODIRSE4))
	      * ((1 - positif(CMAJ)) * positif(NMAJRSE44) * TXPFIRSE4 + positif(CMAJ) * COPETO)
	     + positif(V_NBCODIRSE4) * (-1) ;

regle  907143 :
application : iliad ;
RETX = positif(CMAJ) * TXINT
       + (TXINR * (1-positif(TXINR_A)) + (-1) * positif(TXINR_A) * positif(TXINR) * (1-null(TXINR - TXINR_A))
       + TXINR * positif(TXINR_A) * null(TXINR - TXINR_A)) * (1-positif(TINR_1)
               * positif(INRIR_NET_1+INRCSG_NET_1+INRRDS_NET_1+INRPRS_NET_1+INRCSAL_NET_1+INRCDIS_NET_1
                                                                          +INRCGLOA_NET_1+INRTAXA_NET_1))
       + (-1) * positif(TINR_1) * positif(INRIR_NET_1+INRCSG_NET_1+INRRDS_NET_1+INRPRS_NET_1+INRCSAL_NET_1+INRCDIS_NET_1+INRTAXA_NET_1
                                                                  +INRCGLOA_NET_1)
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
NATMAJ = present(CMAJ) +
	 si (V_CODPFI =01) alors (1) sinon (
	   si (V_CODPFI =02) alors (2)
	   sinon (
	     si (V_CODPFI=03  ou V_CODPFI=04 ou V_CODPFI=05 ou V_CODPFI=06
	         ou V_CODPFI=22 ou V_CODPFI=30) 
	     alors (4)
             sinon (
               si (V_CODPFI=07 ou V_CODPFI=08 ou V_CODPFI=09 ou V_CODPFI=10 ou V_CODPFI=11 
                   ou V_CODPFI=12 ou V_CODPFI=17 ou V_CODPFI=18 ou V_CODPFI=31) 
	       alors (1)
	       finsi)
             finsi)
           finsi)
         finsi ;
NATMAJCI = present(CMAJ) +
           si (V_CODPFC=01) alors (1) sinon (
	     si (V_CODPFC=02) alors (2)
	     sinon (
	       si (V_CODPFC=03  ou V_CODPFC=04 ou V_CODPFC=05 ou V_CODPFC=06
		   ou V_CODPFC=22 ou V_CODPFC=30) 
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
	           ou V_CODPFR=22 ou V_CODPFR=30) 
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
	           ou V_CODPFP=22 ou V_CODPFP=30) 
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
		      ou V_CODPFICAP=22 ou V_CODPFICAP=30)
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
		      ou V_CODPFICHR=22 ou V_CODPFICHR=30)
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
NATMAJGAINI = present(CMAJ) +
	      si (V_CODPFGAIN=01) alors (1) sinon (
		si (V_CODPFGAIN=02) alors (2)
		sinon (
		  si (V_CODPFGAIN=03 ou V_CODPFGAIN=04 ou V_CODPFGAIN=05 ou V_CODPFGAIN=06
		      ou V_CODPFGAIN=22 ou V_CODPFGAIN=30)
                  alors (4)
		  sinon (
		    si (V_CODPFGAIN=07 ou V_CODPFGAIN=08 ou V_CODPFGAIN=09 ou V_CODPFGAIN=10
			ou V_CODPFGAIN=11 ou V_CODPFGAIN=12 ou V_CODPFGAIN=17  ou V_CODPFGAIN=18
			ou V_CODPFGAIN=31)
	            alors (1)
	            finsi)
                  finsi)
                finsi)
              finsi ;
NATMAJGAIN = NATMAJGAINI * (1 - positif(V_NBCODGAIN)) + 9 * positif(V_NBCODGAIN) ;
NATMAJCSALI = present(CMAJ) +
	      si (V_CODPFCSAL=01) alors (1) sinon (
	        si (V_CODPFCSAL=02) alors (2)
		sinon (
		  si (V_CODPFCSAL=03 ou V_CODPFCSAL=04 ou V_CODPFCSAL=05 ou V_CODPFCSAL=06
		      ou V_CODPFCSAL=22 ou V_CODPFCSAL=30) 
		  alors (4)
	          sinon (
		    si (V_CODPFCSAL=07 ou V_CODPFCSAL=08 ou V_CODPFCSAL=09 ou V_CODPFCSAL=10
	                ou V_CODPFCSAL=11 ou V_CODPFCSAL=12 ou V_CODPFCSAL=17  ou V_CODPFCSAL=18 
		        ou V_CODPFCSAL=31) 
	            alors (1)
	            finsi)
                  finsi)
                finsi)
              finsi ;
NATMAJCSAL = NATMAJCSALI * (1 - positif(V_NBCODCSAL)) + 9 * positif(V_NBCODCSAL) ;
NATMAJCDISI = present(CMAJ) +
	      si (V_CODPFCDIS=01) alors (1) sinon (
	        si (V_CODPFCDIS=02) alors (2)
	        sinon (
	          si (V_CODPFCDIS=03  ou V_CODPFCDIS=04 ou V_CODPFCDIS=05 ou V_CODPFCDIS=06
	              ou V_CODPFCDIS=22 ou V_CODPFCDIS=30)
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
NATMAJRSE1I = present(CMAJ) +
	      si (V_CODPFRSE1=01) alors (1) sinon (
	        si (V_CODPFRSE1=02) alors (2)
	        sinon (
	 	  si (V_CODPFRSE1=03 ou V_CODPFRSE1=04 ou V_CODPFRSE1=05 ou V_CODPFRSE1=06
		      ou V_CODPFRSE1=22 ou V_CODPFRSE1=30)
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
		      ou V_CODPFRSE2=22 ou V_CODPFRSE2=30)
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
		      ou V_CODPFRSE3=22 ou V_CODPFRSE3=30)
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
		      ou V_CODPFRSE4=22 ou V_CODPFRSE4=30)
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
MAJTXC = (1-positif(V_NBCODC)) * ( positif(CMAJ)*COPETO + TXPFC )
         + positif(V_NBCODC) * (-1) ;
MAJTXR = (1-positif(V_NBCODR)) * ( positif(CMAJ)*COPETO + TXPFR )
         + positif(V_NBCODR) * (-1) ;
MAJTXP = (1-positif(V_NBCODP)) * ( positif(CMAJ)*COPETO + TXPFP)
         + positif(V_NBCODP) * (-1) ;
MAJTXGAIN = (1-positif(V_NBCODGAIN)) * ( positif(CMAJ)*COPETO + TXPFGAIN)
	    + positif(V_NBCODGAIN) * (-1) ;
MAJTXCSAL = (1-positif(V_NBCODCSAL)) * ( positif(CMAJ)*COPETO + TXPFCSAL)
            + positif(V_NBCODCSAL) * (-1) ;
MAJTXCDIS = (1-positif(V_NBCODCDIS)) * ( positif(CMAJ)*COPETO + TXPFCDIS)
            + positif(V_NBCODCDIS) * (-1) ;
MAJTXRSE1 = (1-positif(V_NBCODRSE1)) * ( positif(CMAJ)*COPETO + TXPFRSE1)
            + positif(V_NBCODRSE1) * (-1) ;
MAJTXRSE2 = (1-positif(V_NBCODRSE2)) * ( positif(CMAJ)*COPETO + TXPFRSE2)
            + positif(V_NBCODRSE2) * (-1) ;
MAJTXRSE3 = (1-positif(V_NBCODRSE3)) * ( positif(CMAJ)*COPETO + TXPFRSE3)
            + positif(V_NBCODRSE3) * (-1) ;
MAJTXRSE4 = (1-positif(V_NBCODRSE4)) * ( positif(CMAJ)*COPETO + TXPFRSE4)
            + positif(V_NBCODRSE4) * (-1) ;
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
TXCSAL = (   RETX * positif_ou_nul(RETX) * positif(RETCSAL)
        + MAJTXCSAL * positif_ou_nul(MAJTXCSAL)* positif(NMAJCSAL1)*null(1-NATMAJCSAL)
        + MAJTXCSAL1 * positif_ou_nul(MAJTXCSAL1)* positif(NMAJCSAL1)*(1-positif(MAJTXCSAL))
        + MAJTXCSAL4 * positif_ou_nul(MAJTXCSAL4)*positif(NMAJCSAL4)
      ) * positif_ou_nul (TXTO) * (1-positif(null(1+RETX)+null(1+MAJTXCSAL)+null(1+MAJTXCSAL1)+null(1+MAJTXCSAL4)))
      + (-1) * positif (TXTO) * positif(null(1+RETX)+null(1+MAJTXCSAL)+null(1+MAJTXCSAL1)+null(1+MAJTXCSAL4))
             * positif(RETCSAL+NMAJCSAL1+NMAJCSAL4)
      + (-1) * (1 - positif_ou_nul(TXTO)) * positif(TXTO * (-1));
TXCDIS = (   RETX * positif_ou_nul(RETX) * positif(RETCDIS)
        + MAJTXCDIS * positif_ou_nul(MAJTXCDIS)* positif(NMAJCDIS1)*null(1-NATMAJCDIS)
        + MAJTXCDIS1 * positif_ou_nul(MAJTXCDIS1)* positif(NMAJCDIS1)*(1-positif(MAJTXCDIS))
        + MAJTXCDIS4 * positif_ou_nul(MAJTXCDIS4)*positif(NMAJCDIS4)
      ) * positif_ou_nul (TXTO) * (1-positif(null(1+RETX)+null(1+MAJTXCDIS)+null(1+MAJTXCDIS1)+null(1+MAJTXCDIS4)))
      + (-1) * positif (TXTO) * positif(null(1+RETX)+null(1+MAJTXCDIS)+null(1+MAJTXCDIS1)+null(1+MAJTXCDIS4))
             * positif(RETCDIS+NMAJCDIS1+NMAJCDIS4)
      + (-1) * (1 - positif_ou_nul(TXTO)) * positif(TXTO * (-1));
TXGAIN = (   RETX * positif_ou_nul(RETX) * positif(RETGAIN)
        + MAJTXGAIN * positif_ou_nul(MAJTXGAIN)* positif(NMAJGAIN1)*null(1-NATMAJGAIN)
        + MAJTXGAIN1 * positif_ou_nul(MAJTXGAIN1)* positif(NMAJGAIN1)*(1-positif(MAJTXGAIN))
        + MAJTXGAIN4 * positif_ou_nul(MAJTXGAIN4)*positif(NMAJGAIN4)
      ) * positif_ou_nul (TXTO) * (1-positif(null(1+RETX)+null(1+MAJTXGAIN)+null(1+MAJTXGAIN1)+null(1+MAJTXGAIN4)))
      + (-1) * positif (TXTO) * positif(null(1+RETX)+null(1+MAJTXGAIN)+null(1+MAJTXGAIN1)+null(1+MAJTXGAIN4))
             * positif(RETGAIN+NMAJGAIN1+NMAJGAIN4)
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
regle  90716 :
application: batch , iliad ;
WMTAP =  (1 - positif(V_ZDC+0)) * positif(NAT1 + NAT71)* max(0,IINET
								- HAUTREVNET) * null (4 - V_IND_TRAIT)
                                +   min(max(0,NAPTOT+NAPCR-PTOTIRCS-HAUTREVNET)
                                ,
                                ( (1 - positif(V_ZDC+0)) * positif(NAT1 + NAT71)*
                                max(0, (present(IPTEFP)*(IRB-IPROP-IAVF-I2DH-IPSOUR-CRDIE) +
                                (1-present(IPTEFP))*(IDRS-IDEC-ITRED-IAVF-I2DH-IPSOUR-CRDIE + AVFISCOPTER)
                                       )
                                   )
                                )
                                       ) * null(5 - V_IND_TRAIT);
MTAP = ( (V_ACO_MTAP + WMTAP * (null(FLAG_ACO-1)*(1-present(V_ACO_MTAP))+null(FLAG_ACO))) * (1 - INDTXMIN) * (1 - INDTXMOY )
                       +
                              (
                                 (V_ACO_MTAP + WMTAP * (null(FLAG_ACO-1)*(1-present(V_ACO_MTAP))+null(FLAG_ACO)) ) * INDTXMIN
                                +
                                (V_ACO_MTAP + WMTAP * (null(FLAG_ACO-1)*(1-present(V_ACO_MTAP))+null(FLAG_ACO)) ) * INDTXMOY
                              ) * positif(WMTAP - SEUIL_ACOMPTE)
        )* null (4 - V_IND_TRAIT)
          + max(0,(
                                WMTAP  * (1 - INDTXMIN) * (1 - INDTXMOY )
                                +
                                WMTAP * INDTXMIN * positif((IAVIMBIS+NAPCRPAVIM) - SEUIL_ACOMPTE)
                                +
                                WMTAP * INDTXMOY * positif((IAVIMO+NAPCRPAVIM) - SEUIL_ACOMPTE)
                 )) * null (5 - V_IND_TRAIT)
                                ;
regle 907215  :
application : iliad ;
pour x=01..12,30,31,55:
RAP_UTIx = NUTOTx_D * positif(APPLI_OCEANS);
regle 907216  :
application : iliad ;
pour x=02..12,30,31,55;i=RF,BA,LO,NC,CO:
RAPi_REPx = NViDx_D * positif(APPLI_OCEANS);
regle 907217  :
application : iliad ;
pour i=01..12,30,31,55:
RAPCO_Ni = NCCOi_D * positif(APPLI_OCEANS);
regle 91  :
application : iliad ;
FPV = FPTV - DEDSV* positif(APPLI_OCEANS);
FPC = FPTC - DEDSC* positif(APPLI_OCEANS);
FPP = somme(i=1..4: FPTi) - DEDSP* positif(APPLI_OCEANS);
DIMBA = (positif(DEFIBA) * abs(BANOR) + present(DAGRI6) * DAGRI6 + present(DAGRI5) * DAGRI5 
         + present(DAGRI4) * DAGRI4 + present(DAGRI3) * DAGRI3 + present(DAGRI2) * DAGRI2 + present(DAGRI1) * DAGRI1) * positif(APPLI_OCEANS);

regle 910  :
application : batch, iliad ;
IMPNET = IINET + IREST * (-1);
IMPNETIR = NAPTIR - V_ANTIR-V_PCAPANT-V_TAXANT-V_TAXLOYANT-V_CHRANT;
IMPNETCS = NAPCRP - TOTCRA ;
IMPCSP = si ((APPLI_COLBERT=0) et ( (IAMD1+NAPCRPIAMD1)<SEUIL_61 et (IRB2 -IAVT-I2DH)>= 0 ))
		alors (0)
         sinon (IMPBRU - IAVT-I2DH)
         finsi;

BASEXOGEN = (1-present(IPTEFP)) * 
            max(0,( RG+ TOTALQUO +(AB*(1-present(IPVLOC))) ))*(1-positif(APPLI_COLBERT));
MONTNETCS = (PRS + PTOPRS)*(1-positif(APPLI_COLBERT));
DBACT = si ((APPLI_COLBERT=0) et ( present(RDCOM)=1 et present(NBACT)=0 ))
        alors (0)
        sinon (NBACT)
        finsi;
regle 91011:
application : iliad , batch;
RECUMBIS = si (V_NIMPA+0 = 1)
           alors (V_ANTRE+RECUM_A)
           sinon ((V_ANTRE+RECUM_A) * positif_ou_nul((V_ANTRE+RECUM_A) - SEUIL_8))
           finsi;
RECUMBISIR = si (V_NIMPAIR+0 = 1)
                alors (V_ANTREIR)
                sinon (V_ANTREIR * positif_ou_nul(V_ANTREIR - SEUIL_8))
             finsi;

regle 9101:
application : iliad ,batch;
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
regle 910130:
application : iliad, batch;


TOTAXAGA = si ((APPLI_COLBERT=0) et  (IRNET - V_ANTIR + TAXANET - V_TAXANT + PCAPNET - V_PCAPANT+TAXLOYNET-V_TAXLOYANT+ HAUTREVNET - V_CHRANT+NAPCR -V_ANTCR >= SEUIL_12)
                ou ( (-IRNET + V_ANTIR - TAXANET + V_TAXANT  - PCAPNET + V_PCAPANT-TAXLOYNET+V_TAXLOYANT- HAUTREVNET + V_CHRANT -NAPCR +V_ANTCR) >= SEUIL_8) )
                alors(TAXANET * positif(TAXACUM))
                sinon(V_TAXANT * positif(TAXACUM) + 0 )
                finsi;
PCAPTOT = si ((APPLI_COLBERT=0) et ( (IRNET - V_ANTIR + TAXANET - V_TAXANT + PCAPNET - V_PCAPANT +TAXLOYNET-V_TAXLOYANT+ HAUTREVNET - V_CHRANT+NAPCR -V_ANTCR>= SEUIL_12)
                ou ( (-IRNET + V_ANTIR - TAXANET + V_TAXANT - PCAPNET + V_PCAPANT  -TAXLOYNET+V_TAXLOYANT- HAUTREVNET + V_CHRANT-NAPCR +V_ANTCR) >= SEUIL_8) ))
                alors(PCAPNET * positif(PCAPCUM))
                sinon(V_PCAPANT * positif(PCAPCUM) + 0 )
                finsi;
TAXLOYTOT = si ((APPLI_COLBERT=0) et ( (IRNET - V_ANTIR + TAXANET - V_TAXANT + PCAPNET - V_PCAPANT +TAXLOYNET-V_TAXLOYANT+ HAUTREVNET - V_CHRANT+NAPCR -V_ANTCR>= SEUIL_12)
                ou ( (-IRNET + V_ANTIR - TAXANET + V_TAXANT - PCAPNET + V_PCAPANT  -TAXLOYNET+V_TAXLOYANT- HAUTREVNET + V_CHRANT-NAPCR +V_ANTCR) >= SEUIL_8) ))
                alors(TAXLOYNET * positif(TAXLOYCUM))
                sinon(V_TAXLOYANT * positif(TAXLOYCUM) + 0 )
                finsi;
HAUTREVTOT = si ((APPLI_COLBERT=0) et ( (IRNET - V_ANTIR + TAXANET - V_TAXANT + PCAPNET - V_PCAPANT +TAXLOYNET-V_TAXLOYANT+ HAUTREVNET - V_CHRANT+NAPCR -V_ANTCR >= SEUIL_12)
                ou ( (-IRNET + V_ANTIR - TAXANET + V_TAXANT - PCAPNET + V_PCAPANT  -TAXLOYNET+V_TAXLOYANT- HAUTREVNET + V_CHRANT-NAPCR +V_ANTCR ) >= SEUIL_8) ))
                alors(HAUTREVNET * positif(HAUTREVCUM))
                sinon(V_CHRANT * positif(HAUTREVCUM) + 0 )
                finsi;
regle isf 9100:
application : iliad, batch;
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
regle 9101350:
application : iliad ,batch;
INDSEUIL61 = positif_ou_nul(IAMD1 + NAPCRPIAMD1 - SEUIL_61);
INDSEUIL12 = positif_ou_nul(IRNET+TAXANET+PCAPNET+TAXLOYNET+HAUTREVNET + NAPCRP - SEUIL_12);
INDSEUIL12IR = positif_ou_nul(IRNET+TAXANET+PCAPNET+TAXLOYNET+HAUTREVNET - SEUIL_12);
regle 9101351:
application : iliad ,batch;
IRESTITIRTEMP= IRESTITIR * positif_ou_nul(IAMD1 + NAPCRPIAMD1 - SEUIL_61);
IRNETEMP = INDSEUIL61 * ((0 * (1-INDSEUIL12IR) * (1-INDSEUIL12))
                     + (IRNET * (1 - (1-INDSEUIL12IR) * (1-INDSEUIL12))))
                     + (1-positif(INDSEUIL61)) 
		     * positif_ou_nul(TAXANET + IRNET + PCAPNET +TAXLOYNET + HAUTREVNET+IRANT+NAPCRP-SEUIL_12) 
		     * (positif_ou_nul(RASAR + NRINET + IMPRET + PIR - SEUIL_12) * (RASAR+NRINET + IMPRET+PIR)
                     + 0 * (1 - positif_ou_nul(RASAR + NRINET + IMPRET + PIR - SEUIL_12)));
TAXANETEMP = INDSEUIL61 * ((0 * (1-INDSEUIL12IR) * (1-INDSEUIL12))
                       + (TAXANET * (1 - (1-INDSEUIL12IR) * (1-INDSEUIL12))))
          + (1-positif(INDSEUIL61)) *0 ;
PCAPNETEMP = INDSEUIL61 * ((0 * (1-INDSEUIL12IR) * (1-INDSEUIL12))
                       + (PCAPNET * (1 - (1-INDSEUIL12IR) * (1-INDSEUIL12))))
          + (1-positif(INDSEUIL61)) *0 ;
TAXLOYNETEMP = INDSEUIL61 * ((0 * (1-INDSEUIL12IR) * (1-INDSEUIL12))
                       + (TAXLOYNET * (1 - (1-INDSEUIL12IR) * (1-INDSEUIL12))))
             + (1-positif(INDSEUIL61)) *0 ;
HAUTREVNETEMP = INDSEUIL61 * ((0 * (1-INDSEUIL12IR) * (1-INDSEUIL12))
                       + (HAUTREVNET * (1 - (1-INDSEUIL12IR) * (1-INDSEUIL12))))
              + (1-positif(INDSEUIL61)) *0 ;
NONRESTEMP = IRESTIT * positif(SEUIL_8 - IRESTIT); 
TOTIRNETEMP = IRNETEMP +TAXANETEMP +TAXLOYNETEMP +PCAPNETEMP +HAUTREVNETEMP;
NAPCR61TEMP = CSNETEMP +  PSNETEMP+ RDNETEMP + CVNNETEMP + CSALNETEMP + GAINNETEMP + CDISNETEMP + GLONETEMP 
	     + RSE1NETEMP + RSE2NETEMP+ RSE3NETEMP+ RSE4NETEMP+ RSE5NETEMP;
NAPCRTEMP =CSNET+RDNET+PRSNET+CVNNET+CSALNET+GAINNET+CDISNET+CGLOANET+RSE1NET+RSE2NET+RSE3NET+RSE4NET+RSE5NET;
IRPSNETEMP = max(0,TOTIRNETEMP - IRESTITIRTEMP + NAPCRTEMP);
IRESTITEMP = max(0,-(TOTIRNETEMP - IRESTITIRTEMP + NAPCRTEMP));
NAPTEMP = IRPSNETEMP + NONRESTEMP - IRESTITEMP; 
regle 9101352:
application : iliad ,batch;
TAXACUM    =     null(V_IND_TRAIT - 4) * (positif_ou_nul(IAVIM +NAPCRPAVIM - SEUIL_61 )* ( 
                                   (1-positif(positif(SEUIL_12- (TAXANET + IRNET + PCAPNET +TAXLOYNET + HAUTREVNET))
                                              * positif(SEUIL_12- (TAXANET + IRNET + PCAPNET +TAXLOYNET + HAUTREVNET +NAPCRP))))
                                                                                  * (TAXANET)
										  +
                                   positif(SEUIL_12- (TAXANET + IRNET + PCAPNET +TAXLOYNET + HAUTREVNET))
                                              * positif(SEUIL_12- (TAXANET + IRNET + PCAPNET +TAXLOYNET + HAUTREVNET +NAPCRP))
                                                                                  * 0) 
                                       + positif(SEUIL_61 - IAVIM -NAPCRPAVIM) * 0)
               + null(V_IND_TRAIT - 5) * (
	                               (positif(positif_ou_nul(NAPTEMP - TOTIRPSANT -SEUIL_12)
				             + positif(TOTIRPSANT - NAPTEMP) * positif_ou_nul(TOTIRPSANT-NAPTEMP -SEUIL_8)) * TAXANETEMP )
				       + positif(positif(SEUIL_12 - NAPTEMP - TOTIRPSANT)+positif(SEUIL_8 - (TOTIRPSANT - NAPTEMP))) 
						    *( positif_ou_nul(V_ANTCR - NAPCR61TEMP) * V_TAXANT
						    + (1-positif_ou_nul(V_ANTCR - NAPCR61TEMP)) * TAXANETEMP));
PCAPCUM    =     null(V_IND_TRAIT - 4) * (positif_ou_nul(IAVIM +NAPCRPAVIM - SEUIL_61 )* ( 
                                   (1-positif(positif(SEUIL_12- (TAXANET + IRNET + PCAPNET +TAXLOYNET + HAUTREVNET))
                                              * positif(SEUIL_12- (TAXANET + IRNET + PCAPNET +TAXLOYNET + HAUTREVNET +NAPCRP))))
                                                                                  * (PCAPNET)
										  +
                                   positif(SEUIL_12- (TAXANET + IRNET + PCAPNET +TAXLOYNET + HAUTREVNET))
                                              * positif(SEUIL_12- (TAXANET + IRNET + PCAPNET +TAXLOYNET + HAUTREVNET +NAPCRP))
                                                                                  * 0) 
                                       + positif(SEUIL_61 - IAVIM -NAPCRPAVIM) * 0)
               + null(V_IND_TRAIT - 5) * (
	                               (positif(positif_ou_nul(NAPTEMP - TOTIRPSANT -SEUIL_12)
				             + positif(TOTIRPSANT - NAPTEMP) * positif_ou_nul(TOTIRPSANT-NAPTEMP -SEUIL_8)) * PCAPNETEMP )
				       + positif(positif(SEUIL_12 - NAPTEMP - TOTIRPSANT)+positif(SEUIL_8 - (TOTIRPSANT - NAPTEMP))) 
						    *( positif_ou_nul(V_ANTCR - NAPCR61TEMP) * V_PCAPANT
						    + (1-positif_ou_nul(V_ANTCR - NAPCR61TEMP)) * PCAPNETEMP));
TAXLOYCUM    =      null(V_IND_TRAIT - 4) * (positif_ou_nul(IAVIM +NAPCRPAVIM - SEUIL_61 )* ( 
                                   (1-positif(positif(SEUIL_12- (TAXANET + IRNET + PCAPNET +TAXLOYNET + HAUTREVNET))
                                              * positif(SEUIL_12- (TAXANET + IRNET + PCAPNET +TAXLOYNET + HAUTREVNET +NAPCRP))))
                                                                                  * (TAXLOYNET)
										  +
                                   positif(SEUIL_12- (TAXANET + IRNET + PCAPNET +TAXLOYNET + HAUTREVNET))
                                              * positif(SEUIL_12- (TAXANET + IRNET + PCAPNET +TAXLOYNET + HAUTREVNET +NAPCRP))
                                                                                  * 0) 
                                       + positif(SEUIL_61 - IAVIM -NAPCRPAVIM) * 0)
               + null(V_IND_TRAIT - 5) * (
	                               (positif(positif_ou_nul(NAPTEMP - TOTIRPSANT -SEUIL_12)
				             + positif(TOTIRPSANT - NAPTEMP) * positif_ou_nul(TOTIRPSANT-NAPTEMP -SEUIL_8)) * TAXLOYNETEMP )
				       + positif(positif(SEUIL_12 - NAPTEMP - TOTIRPSANT)+positif(SEUIL_8 - (TOTIRPSANT - NAPTEMP))) 
						    *( positif_ou_nul(V_ANTCR - NAPCR61TEMP) * V_TAXLOYANT
						    + (1-positif_ou_nul(V_ANTCR - NAPCR61TEMP)) * TAXLOYNETEMP));
HAUTREVCUM    =    null(V_IND_TRAIT - 4) * (positif_ou_nul(IAVIM +NAPCRPAVIM - SEUIL_61 )* ( 
                                   (1-positif(positif(SEUIL_12- (TAXANET + IRNET + PCAPNET +TAXLOYNET + HAUTREVNET))
                                              * positif(SEUIL_12- (TAXANET + IRNET + PCAPNET +TAXLOYNET + HAUTREVNET +NAPCRP))))
                                                                                  * (HAUTREVNET)
										  +
                                   positif(SEUIL_12- (TAXANET + IRNET + PCAPNET +TAXLOYNET + HAUTREVNET))
                                              * positif(SEUIL_12- (TAXANET + IRNET + PCAPNET +TAXLOYNET + HAUTREVNET +NAPCRP))
                                                                                  * 0) 
                                       + positif(SEUIL_61 - IAVIM -NAPCRPAVIM) * 0)
               + null(V_IND_TRAIT - 5) * (
	                               (positif(positif_ou_nul(NAPTEMP - TOTIRPSANT -SEUIL_12)
				             + positif(TOTIRPSANT - NAPTEMP) * positif_ou_nul(TOTIRPSANT-NAPTEMP -SEUIL_8)) * HAUTREVNETEMP )
				       + positif(positif(SEUIL_12 - NAPTEMP - TOTIRPSANT)+positif(SEUIL_8 - (TOTIRPSANT - NAPTEMP))) 
						    *( positif_ou_nul(V_ANTCR - NAPCR61TEMP) * V_CHRANT
						    + (1-positif_ou_nul(V_ANTCR - NAPCR61TEMP)) * HAUTREVNETEMP));
IRCUM =          null(V_IND_TRAIT - 4) * (positif_ou_nul(IAVIM +NAPCRPAVIM - SEUIL_61 )*( 
                                   (1-positif(positif(SEUIL_12- (TAXANET + IRNET + PCAPNET +TAXLOYNET + HAUTREVNET))
                                              * positif(SEUIL_12- (TAXANET + IRNET + PCAPNET +TAXLOYNET + HAUTREVNET +NAPCRP))))
                                                                                  * (IRNET+IRANT)
										  +
                                   positif(SEUIL_12- (TAXANET + IRNET + PCAPNET +TAXLOYNET + HAUTREVNET))
                                              * positif(SEUIL_12- (TAXANET + IRNET + PCAPNET +TAXLOYNET + HAUTREVNET +NAPCRP))
                                                                                  * IRANT) 
                                       + positif(SEUIL_61 - IAVIM - NAPCRPAVIM) * (positif_ou_nul(RASAR + NRINET + IMPRET - SEUIL_12) 
						       * max(0,(RASAR + NRINET + IMPRET + (IAVIM - IRE) * positif(IRE - IAVIM)))
				                       * positif_ou_nul(TAXANET + IRNET + PCAPNET +TAXLOYNET + HAUTREVNET + IRANT + NAPCRP - SEUIL_12)
									          + (1 - positif_ou_nul(RASAR + NRINET + IMPRET - SEUIL_12)) * IRANT))
               + null(V_IND_TRAIT - 5) * (
	                               (positif(positif_ou_nul(NAPTEMP - TOTIRPSANT -SEUIL_12)
				             + positif(TOTIRPSANT - NAPTEMP) * positif_ou_nul(TOTIRPSANT-NAPTEMP -SEUIL_8)) * IRNETEMP )
				       + positif(positif(SEUIL_12 - NAPTEMP - TOTIRPSANT)+positif(SEUIL_8 - (TOTIRPSANT - NAPTEMP))) 
						    *( positif_ou_nul(V_ANTCR - NAPCR61TEMP) * V_ANTIR
						    + (1-positif_ou_nul(V_ANTCR - NAPCR61TEMP)) * IRNETEMP));
TOTIRCUM = IRCUM + TAXACUM + PCAPCUM +TAXLOYCUM +HAUTREVCUM; 
RECUM =    ( null(V_IND_TRAIT -4) * positif(IRESTIT) * IRESTIT + 0)
           + null(V_IND_TRAIT - 5) * max(0,-(TOTIRCUM - RECUMIR + NAPCR61));
IRPSCUM =  max(0,TOTIRCUM - RECUMIR + NAPCR61);
regle 9101354:
application : iliad ,batch;
RECUMIR =      IRESTITIR;
regle 9101355:
application : iliad ,batch;
TOTIRPS =  TOTIRCUM - RECUMIR + NAPCR + NONREST;

regle 90516:
application : batch , iliad ;
CSTOT = max(0,CSG + RDSN + PRS + PCSG + PRDS + PPRS + CSAL + PCSAL + CGAINSAL + PGAIN + CVNSALC + PCVN
		  + CDIS + PCDIS + CGLOA + PGLOA + RSE1N + PRSE1 + RSE2N + PRSE2 + RSE3N + PRSE3 + RSE4N + PRSE4 + RSE5N + PRSE5);
regle 905162 :
application : iliad,batch ;
CSNETEMP = CSNET * INDSEUIL61;
PSNETEMP = PRSNET * INDSEUIL61;
RDNETEMP = RDNET * INDSEUIL61;
CVNNETEMP = CVNNET * INDSEUIL61;
CSALNETEMP = CSALNET * INDSEUIL61;
GAINNETEMP = GAINNET * INDSEUIL61;
CDISNETEMP = CDISNET * INDSEUIL61;
GLONETEMP = CGLOANET * INDSEUIL61;
RSE1NETEMP = RSE1NET * INDSEUIL61;
RSE2NETEMP = RSE2NET * INDSEUIL61;
RSE3NETEMP = RSE3NET * INDSEUIL61;
RSE4NETEMP = RSE4NET * INDSEUIL61;
RSE5NETEMP = RSE5NET * INDSEUIL61;
regle 905163 :
application : iliad,batch ;
NAPCRP = max(0 , CSNET+RDNET+PRSNET+CVNNET+CSALNET+GAINNET+CDISNET+CGLOANET+RSE1NET+RSE2NET+RSE3NET+RSE4NET+RSE5NET );
NAPCR = null(4-V_IND_TRAIT)
               * max(0 ,  CSTOT - CSGIM - CRDSIM - PRSPROV - CSALPROV - CDISPROV -CSALPIRATE-CSPROVYD-CSPROVYE-CSPROVYF-CSPROVYG-CSPROVYH)
	       * positif_ou_nul((CSTOT +IRNET+TAXANET+TAXLOYNET+PCAPNET+HAUTREVNET-IRESTITIR )- SEUIL_12) * positif_ou_nul((IAVIM +NAPCRPAVIM) - SEUIL_61 )
        + null(5-V_IND_TRAIT)
               * max(0 , CSTOT - CSGIM - CRDSIM - PRSPROV - CSALPROV - CDISPROV -CSALPIRATE-CSPROVYD-CSPROVYE-CSPROVYF-CSPROVYG-CSPROVYH)
	       * positif_ou_nul((CSTOT +IRNET+TAXANET+TAXLOYNET+PCAPNET+HAUTREVNET-IRESTITIR)- SEUIL_12) * positif_ou_nul((IAVIM +NAPCRPAVIM) - SEUIL_61 );
NAPCRINR = null(4-V_IND_TRAIT)
               * max(0 ,  CSTOT - CSGIM - CRDSIM - PRSPROV - CSALPROV - CDISPROV -CSALPIRATE-CSPROVYD-CSPROVYE-CSPROVYF-CSPROVYG-CSPROVYH)
        + null(5-V_IND_TRAIT)
               * max(0 , (CSTOT - CSGIM - CRDSIM - PRSPROV - CSALPROV - CDISPROV -CSALPIRATE-CSPROVYD-CSPROVYE-CSPROVYF-CSPROVYG-CSPROVYH) );
NAPCR61 = NAPCS + NAPRD +NAPPS +NAPCVN +NAPCSAL +NAPGAIN +NAPCDIS +NAPGLOA +NAPRSE1 +NAPRSE2 +NAPRSE3 +NAPRSE4  +NAPRSE5;
regle 905165 :
application : iliad,batch ;
CRDEG = max(0 , TOTCRA - TOTCR) * positif_ou_nul(TOTCRA - (TOTCR - SEUIL_8)) ;

regle 90517:
application : iliad ;

CS_DEG = max(0 , TOTCRA - CSTOT * positif_ou_nul(CSTOT - SEUIL_61)) * ( 1-positif(APPLI_OCEANS));

ECS_DEG = arr((CS_DEG / TAUX_CONV) * 100) / 100 * ( 1-positif(APPLI_OCEANS));

regle 907411:
application:  batch, iliad ;
INDCRDRECH = positif(abs(IMPNET) - CRICH);
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



regle 911  :
application :   batch, iliad ;
INI6 = 6 * present(IND_TDR);
INI99 = 99 * (1-positif(INI6)) *
        (
        positif(PTP) 
        +
        (1-positif(PTP)) * (1-positif(IPTEFN)) * (1-positif(INDDG)) * 
        (1-positif(INDEXOGEN))
        );
INI11 = 11 * (1-positif(INI6)) *
        ((1-positif(PTP)) * positif(IPTEFN)
        +
        (1-positif(PTP)) * (1-positif(IPTEFN)) * positif(INDDG)); 
INI1 = (1-positif(INI6))*
       (1-positif(PTP)) * (1-positif(IPTEFN)) * (1-positif(INDDG)) * 
        positif(INDEXOGEN) * (1-positif(TOTALQUO)) * (1-positif(REI));
INI2 = 2 * positif(INI99) * 
       (1 - positif(IDOM11)) * (1 - positif(IRB));
INI4 = 4 * positif(INI99) * (1 - positif(INI2)) * (1 - positif(IDOM11-DEC11)) * (1 - positif(IRB));
INI3 = 3 * positif(INI99) * (1 - positif(INI2+INI4)) * (1 - positif(IAD11))  * (1 - positif(IRB)); 
INI8 = 8 * positif(INI99) *
      (1 - positif(INI2+INI3+INI4)) * (1 - positif(ITRED)) *
      (1 - positif_ou_nul(IAMD1 - SEUIL_61)) * positif(IRB);
INI13 = (10 * positif(INI3)
       + 
        (13 * positif(positif(INI99) 
            * (1 - positif(INI2+INI3+INI4))
            * (1 - positif(IRB))))
        )
         ;
INI10 = min(10,
            ( 10 * positif(INI99) * INDNMR1 * (1 - positif(TAXANET+PCAPNET+TAXLOYNET+HAUTREVNET))
            +10 * positif(INI99) 
                * (1 - positif(INI2+INI3+INI4+INI8+INI13)) 
                * ((1 - positif(RC1)) * (1-positif(V_IND_TRAIT - 4))
                   + positif(V_IND_TRAIT - 4) * 
                   ( (1-positif(IDEGR)) * (1-positif(NAPINI + 1 - SEUIL_12))
                     + positif(IDEGR) * (1-positif(RC1INI))
                   )
                  )
             )
            ) ;
INI12 = 12 * positif(INI99) *
      (1 - positif(INI2+INI3+INI4+INI10)) *
      (1 - positif_ou_nul(IAMD1 - SEUIL_61)) * 
      positif(ITRED) *
      positif_ou_nul(IRB);
INI9 = 9 * positif(INI99)  
       * (1 - positif(INI2+INI3+INI4+INI8+INI10+INI12)) 
       * ((1 - positif(RC1)) * (1-positif(V_IND_TRAIT - 4))
           +
           positif(V_IND_TRAIT - 4) * 
            ((1-positif(IDEGR)) * (1-positif(NAPINI + 1 - SEUIL_12))
             +
             positif(IDEGR) * (1-positif(RC1INI)))) 
       * positif(IRB) ;
CODINI =  (min (13,
              somme(i=1,2,3,4,6,8,9:INIi)
            + INI10 +  INI12 + INI13 
            + INI11 
             )
            + INI99 * (1-positif(somme(i=1..4,6,8,9:INIi)
                              +INI10+INI11+INI12+INI13))
           )
            * (1 - positif(NATIMPIR)) 
        +
        99 * positif(NATIMPIR)
        ;
INDCS = positif(SEUIL_61 - IAMD2) * positif_ou_nul(IKIRN - SEUIL_61)
      + positif_ou_nul(IAMD2 - SEUIL_61)*2 ;
regle 912  :
application :  batch, iliad ;
NAT1 = (1-positif(V_IND_TRAIT - 4)) * positif(NAPT)
                  +
                   positif(V_IND_TRAIT - 4) * 
                   ( positif(NAPT) * positif_ou_nul(NAPT-SEUIL_12));
NAT1BIS = (positif (IRANT)) * (1 - positif (NAT1) )
          * (1 - positif(IDEGR))+0;
NAT11 = 11 * IND_REST * (1 - positif(IDEGR)) * positif(IRE-IRESTIT);
NAT21 = 21 * IND_REST * (1 - positif(IDEGR)) * (1 - positif(IRE-IRESTIT));
NAT70 = 70 * (1 - IND_REST) * positif(IDEGR)
        * (1 - TOTREC) ;
NAT71 = 71 * (1 - IND_REST) * positif(IDEGR) 
        * TOTREC ;
NAT81 = 81 * IND_REST *  positif(IDEGR) * positif(IAMD1+NAPCRPIAMD1);
NAT91 = 91 * IND_REST *  positif(IDEGR) * (1 - positif(IAMD1+NAPCRPIAMD1));
NATIMP = ( NAT1 + NAT1BIS +
             (1-positif(NAT1+NAT1BIS))*(NAT11 + NAT21 + NAT70 + NAT71 + NAT81 + NAT91) );
regle 9120  :
application : batch, iliad ;
NATIMPIR =  positif (
                 positif(NAPTOT - NAPTOTAIR - IRANT) * positif_ou_nul(IAVIM - SEUIL_61)
                 * positif_ou_nul(IRNET+TAXANET+TAXLOYNET+PCAPNET+HAUTREVNET - SEUIL_12)
                 + positif (IRE - IRESTITIR) * positif(IRESTITIR)
                 + positif (IRDEG) * (positif_ou_nul(NAPTOT - NAPTOTAIR - IRANT - SEUIL_12))
                      ) * (1-positif(APPLI_OCEANS))
                 ;
regle 9125 :
application : iliad , batch ;
NATCRP = si (NAPCR > 0) 
         alors (1)
         sinon (si (CSNET+RDNET+PRSNET+GAINNET+CSALNET+CVNNET+CDISNET+CGLOANET+RSE1NET+RSE2NET+RSE3NET+RSE4NET+ RSE5NET+ 0 > 0)
                alors (2)
                sinon (si (CRDEG+0>0)
                       alors (3)
                       sinon (0)
                       finsi
                      )
                finsi
               )
         finsi;
regle isf 9130 :
application : iliad , batch ;
NATIMPISF = max (0, (1 * positif(ISFCUM)

	          + 2 * (1 - positif(ISFCUM)) * (1 - null(ISFNET))

	          + 3 *  null(ISFNET) * positif(ISFBASE) * positif (ISFTRED) 
	                
                  + 0 * (null(INDCTX23) * null(5-V_IND_TRAIT) * null(ISFBASE)
                         + positif_ou_nul(ISF_LIMINF + ISF_LIMSUP) * null(4-V_IND_TRAIT)))
		 );
		  


regle 90811 :
application : iliad , batch  ;
IFG = positif(min(PLAF_REDGARD,RDGARD1) + min(PLAF_REDGARD,RDGARD2)
            + min(PLAF_REDGARD,RDGARD3) + min(PLAF_REDGARD,RDGARD4) 
            - max(0,RP)) * positif(somme(i=1..4:RDGARDi));
regle 913  :
application : batch, iliad;
INDGARD = IFG + 9 * (1 - positif(IFG));
regle 914  :
application :  batch, iliad;
DEFTS = (1 - positif(somme(i=V,C,1..4:TSNTi + PRNNi) -  somme(i=1..3:GLNi)) ) *
      abs( somme(i=V,C,1..4:TSNTi + PRNNi) - somme(i=1..3:GLNi) )*(1-positif(APPLI_COLBERT)) ;
PRN = (1 - positif(DEFTS)) * 
       ( somme(i=V,C,1..4:PRNi) + min(0,somme(i=V,C,1..4:TSNi)))*(1-positif(APPLI_COLBERT));
TSN = (1 - positif(DEFTS)) * ( somme(i=V,C,1..4:TPRi) - PRN )*(1-positif(APPLI_COLBERT));
IMPBRU = si ((APPLI_COLBERT=0) et ( (IAMD1+NAPCRPIAMD1) < SEUIL_61 ))
           alors (IRB)
           sinon (IRB + PIR)
          finsi;
regle 916  :
application :  batch, iliad;
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
 + BPVKRI
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

regle 9165 :
application : batch , iliad;
AGRIV = (BAPERPV + BANOCGAV) * (1-positif(APPLI_OCEANS)) ; 
AGRIC = (BAPERPC + BANOCGAC) * (1-positif(APPLI_OCEANS)); 
AGRIP = (BAPERPP + BANOCGAP) * (1-positif(APPLI_OCEANS)); 

regle 917  :
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
AGRI = somme(i=V,C,P : AGRIi) ;
PECHEM = somme(i=V,C,P : BIPERPi) ;
JEUNART = somme(i=V,C,P : BNCCREAi) ;
DTSELUPPE = DTSELUPPEV + DTSELUPPEC ;

regle 918  :
application : batch, iliad ;
REPINV = RIVL1 + RIVL2 + RIVL3 + RIVL4 + RIVL5 + RIVL6 ;

REPINVRES = RIVL1RES + RIVL2RES + RIVL3RES + RIVL4RES + RIVL5RES ;
REPINVTOT = REPINV + REPINVRES;


regle 920  :
application : batch, iliad ;
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
regle 930  :
application : batch, iliad ;

R8ZT = min(RBG2 + TOTALQUO , V_8ZT) ;

regle 931  :
application : batch, iliad ;

TXMOYIMPC = arr(TXMOYIMPNUM/TXMOYIMPDEN*100)/100;

TXMOYIMP = max(0, positif(IRCUM+TAXACUM+PCAPCUM+TAXLOYCUM+HAUTREVCUM-RECUM)
                 * positif((4500/100) - TXMOYIMPC)
                 * TXMOYIMPC
               )
	     ;

regle 933  :
application : batch, iliad;

TXMOYIMPNUM = positif(IRCUM+TAXACUM+PCAPCUM+TAXLOYCUM+HAUTREVCUM-RECUM-PIR-PTAXA-PPCAP-PTAXLOY-PHAUTREV) * 
               (max(0,(IRCUM+TAXACUM+PCAPCUM+TAXLOYCUM+HAUTREVCUM-RECUM-PIR-PTAXA-PPCAP-PTAXLOY-PHAUTREV)
                    * positif_ou_nul((IRNET2+TAXASSUR+IPCAPTAXT+TAXLOY+IHAUTREVT)-SEUIL_12) 
                 + (IRNET2 + TAXASSUR +IPCAPTAXT+TAXLOY+IHAUTREVT+ IRANT)
                    * positif(SEUIL_12 - (IRNET2+TAXASSUR+IPCAPTAXT+TAXLOY+IHAUTREVT)) 

                 + arr(PPLIB  * TX24 / 100) 
		 + arr(RCMLIBDIV * TX21/100)
                 + arr(RCMLIB * TX_PREVLIB / 100) - IPREP-IPPRICORSE
                   )) * positif_ou_nul(IAMD1 - SEUIL_61) * 100;

regle 936  :
application : batch, iliad;

TXMOYIMPDEN =  max(0,TXMOYIMPDEN1 - TXMOYIMPDEN2 + TXMOYIMPDEN3 
               + TXMOYIMPDEN4 + TXMOYIMPDEN5 + TXMOYIMPDEN6) ;

regle 937  :
application : batch, iliad;
TXMOYIMPDEN1 =   somme (i=V,C,1,2,3,4: TSNTi) * (1-positif(abs(DRBG)))
        + somme (i=V,C,1,2,3,4: PALIi + PRBRi) * (1-positif(abs(DRBG)))
        + RVTOT + T2RV 
	+ max(0,TRCMABD + DRTNC + RCMNAB + RAVC + RTCAR + RCMPRIVM 
                - max(0,RCMFR - DFRCMN) * (1-positif(abs(DRBG)))
		- RCM_I * positif(REPRCM - RCM_I)
		- REPRCM * positif_ou_nul(RCM_I - REPRCM)) * (1-positif(abs(DRBG)))
         + RMFN * (1-positif(abs(DRBG)))
        + (RFCG + DRCF) * (1-positif(abs(DRBG)))
	+ PLOCNETF + max(0,NPLOCNETF)
        + (MIBNETPTOT + SPENETPF ) * (1-positif(abs(DRBG)))
                                   + (SPENETNPF + NOCEPIMP) * null(DALNP) * (1-positif(abs(DRBG)))
	  + (BAHQTOT * positif(BAHQTOT) + BAHQTOT * (1-positif(BAHQTOT))* (1-positif(BAQTOT))) * (1-positif(abs(DRBG)))
                                  * null(DEFBA6+DEFBA5+DEFBA4+DEFBA3+DEFBA2+DEFBA1)
         + somme(i=V,C,P: BIPTAi+ BIHTAi + BNNSi + BNNAi)  * (1-positif(abs(DRBG)))
               + BICNPF * (1-positif(abs(DRBG)))
         + REPSOF * (1-positif(abs(DRBG)))
         - ((DABNCNP6*positif(BNCDF6) + min(DABNCNP6,NOCEPIMP+SPENETNPF)*null(BNCDF6)*positif(DABNCNP6))+DABNCNP5+DABNCNP4+DABNCNP3+DABNCNP2+DABNCNP1) 
	 * null(BNCDF1 + BNCDF2 +BNCDF3 +BNCDF4 +BNCDF5 +BNCDF6) * (1-positif(abs(DRBG)))
                ;
TXMOYIMPDEN2 =  somme (i=0,1,2,3,4,5: DEFAAi) * (1-positif(RNIDF))
         + DDCSG
         + DPA
         + APERPV + APERPC + APERPP
         + DRFRP  * positif(RRFI);
TXMOYIMPDEN3 = (
               (
                BTP3N + BTP3G + BTP2 + BPTP4 + BTP40 + BTP18 + BPTP5
                + somme(i=V,C,P: BN1Ai + BIH1i + BI1Ai 
                        + BI2Ai + BA1Ai ) + MIB_1AF + BA1AF
                + SPEPV + PVINVE+PVINCE+PVINPE
		+ INVENTV + INVENTC + INVENTP
		+ BPTPVT +PVSURSIWG+BPTPSJ+BPTPSA+BPTPSB+BPTPSC
               )
               * (1 - positif(IPVLOC)));
TXMOYIMPDEN4 = 2PRBV + 2PRBC + 2PRB1 + 2PRB2 + 2PRB3 + 2PRB4 + max(0,BAQTOT) * (1-positif(DEFBA6+DEFBA5+DEFBA4+DEFBA3+DEFBA2+DEFBA1))
							     + somme(i=V,C,1..4:PEBFi)
	       ;
TXMOYIMPDEN5 = PPLIB + RCMLIB + RCMLIBDIV;
TXMOYIMPDEN6 = CESSASSV+CESSASSC + BPCAPTAXV+BPCAPTAXC;
regle 940  :
application :  iliad, batch ;
GGIRSEUL =  IAD11 + ITP + REI + AVFISCOPTER ;
regle 942  :
application :  iliad, batch ;
GGIDRS =  IDOM11 + ITP + REI + PIR ;
regle 943  :
application :  iliad, batch;
GGIAIMP =  IAD11 ;
regle 944  :
application :  iliad, batch ;
GGINET = si ( positif(RE168+TAX1649+0) = 0)
      alors
       (si    ( V_REGCO = 2 )
        alors (GGIAIMP - 0 + EPAV + CICA + CIGE )
        sinon (max(0,GGIAIMP - CIRCMAVFT + EPAV + CICA + CIGE ))
        finsi)
       sinon (max(0,GGIAIMP - CIRCMAVFT))
       finsi;

regle 945  :
application :  iliad, batch;
REPCT = (min(0,MIB_NETNPCT) * positif(MIBNPDCT) * positif(DLMRN1)
	+ min(0,SPENETNPCT) * positif(BNCNPDCT) * positif(BNCDF1)) * (-1);

regle 950  :
application : iliad, batch ;

PPENHPTOT = PPENHP1 + PPENHP2 + PPENHP3+ PPENHP4;
PPEPRIMEVT = (PPEPRIMEV + PPEPRIMETTEV) * ( 1 - V_CNR);
PPEPRIMECT = (PPEPRIMEC + PPEPRIMETTEC) * ( 1 - V_CNR);
PPEPRIMEPT = (somme( i=1,2,3,4,U,N:PPEPRIMEi)) * ( 1 - V_CNR);
PPESALVTOT = PPE_SALAVDEFV;
PPESALCTOT = PPE_SALAVDEFC;
PPESALPTOT = PPE_SALAVDEF1 + PPE_SALAVDEF2 + PPE_SALAVDEF3 + PPE_SALAVDEF4;

PPERPROV = PPE_RPROV * positif(PPETOT
                               + positif(PPESALVTOT)
                               + present(PPEACV)
                               + present(PPENJV));

PPERPROC = PPE_RPROC * positif(PPETOT
                               + positif(PPESALCTOT)
                               + present(PPEACC)
                               + present(PPENJC));
PPERPROP = PPE_RPROP * positif(PPETOT
                               + positif(PPESALPTOT)
                               + present(PPEACP)
                               + present(PPENJP));
regle 960  :
application : iliad, batch ;

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
 + HEURESUPV  
 + HEURESUPC  
 + HEURESUPP1  
 + HEURESUPP2  
 + TSASSUV  
 + TSASSUC  
 + XETRANV  
 + XETRANC  
 + HEURESUPP3  
 + HEURESUPP4  
 + SALINTV
 + SALINTC
 + TSELUPPEV
 + TSELUPPEC
 + ELURASV
 + ELURASC
 + IPMOND
 + PRBRV  
 + PRBRC  
 + PRBR1  
 + PRBR2  
 + PRBR3  
 + PRBR4  
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
 + RCMLIBDIV  
 + RCMABD  
 + RCMTNC  
 + RCMAV  
 + RCMHAD  
 + REGPRIV  
 + RCMHAB  
 + PPLIB  
 + RCMIMPAT
 + RCMLIB
 + BPV40V  
 + BPVRCM  
 + BPCOPTV  
 + BPCOSAV  
 + BPCOSAC  
 + BPVKRI
 + PEA  
 + GAINABDET  
 + PVJEUNENT  
 + BPV18V  
 + ABIMPPV
 + BPV18C
 + BPCOPTC
 + BPV40C
 + BPVSJ
 + BPVSK
 + GAINPEA
 + PVDIRTAX
 + PVSURSIWF
 + PVSURSIWG
 + PVPART
 + PVSURSI
 + PVIMPOS
 + PVIMMO
 + ABDETPLUS
 + ABPVSURSIS
 + ABPVNOSURSIS
 + PVEXOSEC
 + PVREPORT
 + PVTITRESOC
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
      ;
regle 968  :
application : iliad, batch ;

XETRAN = XETSNNV + XETSNNC;

regle 970  :
application :  iliad;

TLIR  = TL_IR *positif(APPLI_OCEANS);
TLTAXAGA = TL_TAXAGA *positif(APPLI_OCEANS);

regle 980  :
application : iliad, batch ;

pour i = V,C,P :
INDRNSi = positif (present( ANOCEP ) + present( BA1Ai ) 
 + present( BACDEi ) 
 + present( BACREi ) 
 + present( BAEXi ) 
 + present( BAF1Ai ) 
 + present( BAFi ) 
 + present( BAFPVi ) 
 + present( BAHDEi )
 + present( BAHEXi ) 
 + present( BAHREi ) 
 + present( BAPERPi ) 
 + present( BI1Ai ) 
 + present( BI2Ai ) 
 + present( BICDEi ) 
 + present( BICDNi ) 
 + present( BICEXi ) 
 + present( BICHDEi ) 
 + present( BICNOi ) 
 + present( BIHDNi ) 
 + present( BIHEXi ) 
 + present( BIHNOi )
 + present( BIPERPi ) 
 + present( BN1Ai ) 
 + present( BNCDEi ) 
 + present( BNCEXi )
 + present( BNCPRO1Ai )
 + present( BNCPROi )
 + present( BNCPMVCTV ) + present( BNCPRODEi ) 
 + present( BNCPROEXi ) 
 + present( BNCPROPVi )
 + present( BNCREi ) 
 + present( BNHDEi ) 
 + present( BNHEXi ) 
 + present( BNHREi ) 
 + present( DAGRI6 ) 
 + present( DAGRI5 ) 
 + present( DAGRI4 ) 
 + present( DAGRI3 ) 
 + present( DAGRI2 ) 
 + present( DAGRI1 ) 
 + present( DEFBIC1 ) + present( DEFBIC2 ) + present( DEFBIC3 ) 
 + present( DEFBIC4 ) + present( DEFBIC5 ) + present( DEFBIC6 ) 
 + present( DNOCEP )
 + present( FEXi ) 
 + present( MIB1Ai ) 
 + present( BICPMVCTV) 
 + present( BICPMVCTC)
 + present( BICPMVCTP) 
 + present( MIBDEi ) 
 + present( MIBEXi )
 + present( MIBPRESi )
 + present( MIBPVi )
 + present( MIBVENi )
 + present( PVINVE )
 + present( RCSi ) 


 + 0
)
;
regle 9800  :
application : iliad, batch ;
TAXLOY = LOYELEV ;
regle 9801  :
application : iliad, batch ;
COMPENSACI = positif(NAPCRP) *  positif_ou_nul((IAMD1 + NAPCRPIAMD1)-SEUIL_61) * 
             (positif(IRE) * null(PPETOT) *
                (  positif(IRESTITIR-IRE) * min(NAPCRP,max(0,IRESTITIR - IRE))
                 + null(IRESTITIR - IRE) * min(NAPCRP,IRE)
                 + positif(IRE - IRESTITIR) * min(NAPCRP,IRESTITIR))
             + positif(PPETOT)* positif(IRE) *
		(  positif(IRESTITIR - IRE - PPETOT) * min(NAPCRP,(IRESTITIR - IRE - PPETOT))
		 + null(IRESTITIR - IRE - PPETOT) * min(NAPCRP,IRE)
		 + positif(PPETOT + IRE - IRESTITIR) * 
                                   (positif_ou_nul(PPETOT - IRESTITIR)) * 0
                                  + positif(IRESTITIR - PPETOT) * min(NAPCRP,(IRESTITIR-PPETOT)))
	      ) ;

COMPENSPPE = positif(NAPCRP) *  positif_ou_nul((IAMD1 + NAPCRPIAMD1)-SEUIL_61) * 
	     (positif(PPETOT) * null(IRE) *
		(  positif(IRESTITIR-PPETOT) * min(NAPCRP,max(0,IRESTITIR - PPETOT))
		 + null(IRESTITIR - PPETOT) * min(NAPCRP,PPETOT)
		 + positif(PPETOT - IRESTITIR) * min(NAPCRP,IRESTITIR))
             + positif(PPETOT)* positif(IRE) *
		(  positif(IRESTITIR - IRE - PPETOT) * min(max(0,NAPCRP-COMPENSACI),PPETOT)
		 + null(IRESTITIR -IRE - PPETOT) * min(max(0,NAPCRP-COMPENSACI),PPETOT)
		 + positif(PPETOT + IRE - IRESTITIR) * 
		                  (positif_ou_nul(PPETOT - IRESTITIR)) * min(max(0,NAPCRP-COMPENSACI),IRESTITIR)
			         + positif(IRESTITIR - PPETOT) * min(max(0,NAPCRP-COMPENSACI),PPETOT))
		)       ;
COMPENSANV =  null(4-V_IND_TRAIT) * (positif_ou_nul((IAMD1 + NAPCRPIAMD1)-SEUIL_61) * positif(SEUIL_12 - (CSTOT +IRNET+TAXANET+TAXLOYNET+PCAPNET+HAUTREVNET-IRESTITIR))
						      * max(0,NAPCRP - IRESTITIR))
            + null(5-V_IND_TRAIT) *(1- positif(positif_ou_nul(TOTIRPS - TOTIRPSANT -SEUIL_12)
				    + (1-positif(SEUIL_8 - (TOTIRPS - TOTIRPSANT))))) * (IINETCALC - IINET); 
regle 9820  :
application : iliad, batch ;
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




