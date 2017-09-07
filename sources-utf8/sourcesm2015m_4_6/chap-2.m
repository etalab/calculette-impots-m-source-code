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
#************************************************************************************************************************** #
 #     CHAPITRE 2. CALCUL DU NET A PAYER
 #
 #
 #
regle 201000:
application : batch , iliad ;

NAPINI = ( IRN + PIR - IRANT )* (1 - INDTXMIN) *(1 - INDTXMOY)
       + min(0, IRN + PIR - IRANT) * (INDTXMIN + INDTXMOY)
       + max(0, IRN + PIR - IRANT) * 
                                (INDTXMIN*positif((IAVIMBIS-NAPCRPAVIM)-SEUIL_61 )
			       + INDTXMOY* positif((IAVIMO-NAPCRPAVIM)-SEUIL_61))
                      + RASAR * V_CNR;

RC1INI = positif( NAPINI + 1 - SEUIL_12 ) ;

regle 201010:
application : batch , iliad ;


NAPTOT = IRCUM + TAXACUM + PCAPCUM + TAXLOYCUM + HAUTREVCUM - RECUMIR ;

regle 201020:
application : iliad , batch ;


NAPTOTA = V_IRPSANT - V_ANTRE ;
NAPTOTAIR = V_TOTIRANT - V_ANTREIR ;
TOTCRA = V_ANTCR ;
TOTIRPSANT = V_IRPSANT - V_NONMERANT + V_NONRESTANT - V_ANTRE ;

regle 201030:
application : iliad ;

OCEDIMP = IRNIN ;

regle 201040:
application : batch , iliad ;

IRNIN = (IRN - IRANT) * positif(IRN - IRANT) ;

regle isf 201050:
application : batch , iliad ;

ISF4BASE = ISF4BIS * positif_ou_nul(ISF4BIS - SEUIL_12) ;  

ISFIN = ISF4BASE ;

regle 201060:
application : batch , iliad ;

IRNIN_INR = max(0,min( 0, IAN + AVFISCOPTER - IRE ) + max( 0, IAN + AVFISCOPTER - IRE )  * positif( IAMD1 + 1 + V_ANTREIR - SEUIL_61)  - IRANT - IR9YI) 
                                 * positif(min( 0, IAN + AVFISCOPTER - IRE ) + max( 0, IAN + AVFISCOPTER - IRE ) * positif( IAMD1 + 1 + V_ANTREIR - SEUIL_61) - IRANT);
CSBASE_INR = max(0,CSG - CSGIM  - CS9YP);
RDBASE_INR = max(0,RDSN - CRDSIM  - RD9YP);
PSBASE_INR = max(0,PRS - PRSPROV  - PS9YP);
CVNBASE_INR = max(0,CVNN - COD8YT  - CVN9YP);
CDISBASE_INR = max(0,CDIS - CDISPROV  - CDIS9YP);
GLOBASE_INR = max(0,CGLOA - COD8YL  - GLO9YP);
RSE1BASE_INR = max(0,RSE1N - CSPROVYD - RSE19YP);
RSE2BASE_INR = max(0, max(0, RSE8TV - CIRSE8TV - CSPROVYF) + max(0, RSE8SA -CIRSE8SA - CSPROVYN) - RSE29YP);
RSE3BASE_INR = max(0,RSE3N - CSPROVYG - RSE39YP);
RSE4BASE_INR = max(0, RSE4N  - CSPROVYH - CSPROVYP - RSE49YP);
RSE5BASE_INR = max(0,RSE5N - CSPROVYE - RSE59YP);
RSE6BASE_INR = max(0,RSE6N - RSE69YP);
TAXABASE_INR = arr(max(TAXASSUR - TAXA9YI + min(0,min( 0, IAN + AVFISCOPTER - IRE ) + max( 0, IAN + AVFISCOPTER - IRE )  * positif( IAMD1 + 1 + V_ANTREIR - SEUIL_61)  
                                      - IRANT),0)) * positif(IAMD1 + 1 + V_ANTREIR - SEUIL_61);
PCAPBASE_INR = arr(max(IPCAPTAXT - CAP9YI + min(0,min( 0, IAN + AVFISCOPTER - IRE ) + max( 0, IAN + AVFISCOPTER - IRE )  * positif( IAMD1 + 1 + V_ANTREIR - SEUIL_61)  
                                      - IRANT + TAXASSUR),0)) * positif(IAMD1 + 1 + V_ANTREIR - SEUIL_61);
LOYBASE_INR = arr(max(TAXLOY - LOY9YI + min(0,min( 0, IAN + AVFISCOPTER - IRE ) + max( 0, IAN + AVFISCOPTER - IRE )  * positif( IAMD1 + 1 + V_ANTREIR - SEUIL_61)  
                                      - IRANT + TAXASSUR+IPCAPTAXT),0)) * positif(IAMD1 + 1 + V_ANTREIR - SEUIL_61);
CHRBASE_INR = arr(max(IHAUTREVT - CHR9YI + min(0,min( 0, IAN + AVFISCOPTER - IRE ) + max( 0, IAN + AVFISCOPTER - IRE )  * positif( IAMD1 + 1 + V_ANTREIR - SEUIL_61)  
                                          - IRANT + TAXASSUR+IPCAPTAXT+TAXLOY),0)) * positif(IAMD1 + 1 + V_ANTREIR - SEUIL_61);
CSBASE = CSG - CSGIM ;
RDBASE = RDSN - CRDSIM ;
PSBASE = PRS - PRSPROV ;
CVNBASE = CVNN - COD8YT ;
CDISBASE = CDIS - CDISPROV ;
GLOBASE = CGLOA - COD8YL ;
RSE1BASE = RSE1N - CSPROVYD;

RSE2BASE = max(0, RSE8TV - CIRSE8TV - CSPROVYF) 
         + max(0, RSE8SA - CIRSE8SA - CSPROVYN) ;

RSE3BASE = RSE3N - CSPROVYG;

RSE4BASE = max(0, RSE4N - CSPROVYH - CSPROVYP) ;

RSE5BASE = RSE5N - CSPROVYE ;

RSE6BASE = RSE6N ;
TAXABASE = arr(max(TAXASSUR + min(0,IRN - IRANT),0)) * positif(IAMD1 + 1 - SEUIL_61);
PCAPBASE = arr(max(IPCAPTAXT + min(0,IRN - IRANT + TAXASSUR),0)) * positif(IAMD1 + 1 - SEUIL_61);
LOYBASE = arr(max(TAXLOY + min(0,IRN - IRANT + TAXASSUR+IPCAPTAXT),0)) * positif(IAMD1 + 1 - SEUIL_61);
CHRBASE = arr(max(IHAUTREVT + min(0,IRN - IRANT + TAXASSUR+IPCAPTAXT+TAXLOY),0)) * positif(IAMD1 + 1 - SEUIL_61);

IRBASE_I = (IRN -IRANT)*positif(IRN+1-SEUIL_12);

IRBASE_N = (IRN - IRANT)*(1 - positif (IRN-IRANT + TAXABASE_IRECT+CAPBASE_IRECT+HRBASE_IRECT))
           + (IAN - min( IAN , IRE )) * positif (IRN-IRANT + TAXABASE_IRECT+CAPBASE_IRECT+HRBASE_IRECT);
TAXABASE_I = TAXASSUR * positif(IAMD1 + 1 - SEUIL_61);
TAXABASE_N = arr(max(TAXASSUR + min(0,IRN - IRANT),0)) * positif(IAMD1 + 1 - SEUIL_61);
CAPBASE_I = IPCAPTAXT * positif(IAMD1 + 1 - SEUIL_61);
CAPBASE_N = arr(max(IPCAPTAXT + min(0,IRN - IRANT + TAXASSUR),0)) * positif(IAMD1 + 1 - SEUIL_61);
LOYBASE_I = TAXLOY * positif(IAMD1 + 1 - SEUIL_61);
LOYBASE_N = arr(max(TAXLOY + min(0,IRN - IRANT + TAXASSUR+IPCAPTAXT),0)) * positif(IAMD1 + 1 - SEUIL_61);
HRBASE_I = IHAUTREVT * positif(IAMD1 + 1 - SEUIL_61);
HRBASE_N = arr(max(IHAUTREVT + min(0,IRN - IRANT + TAXASSUR+IPCAPTAXT+TAXLOY),0)) * positif(IAMD1 + 1 - SEUIL_61);


IRNN = IRNIN ;

regle 201070:
application : iliad ;

PIR = (
       INCIR_NET
       + NMAJ1 + NMAJ3 + NMAJ4 
       + arr((BTOINR) * TXINT / 100)* (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT)))
       ;
PPRS = (
       INCPS_NET
       + NMAJP1 + NMAJP4
       + arr(max(0,PRS-PRSPROV-PS9YP) * TXINT / 100)* (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);
PCSG = (
       INCCS_NET
       + NMAJC1 + NMAJC4
         + arr(max(0,CSG-CSGIM-CS9YP) * TXINT / 100) * (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);
PRDS = (
       INCRD_NET
       + NMAJR1 + NMAJR4
         + arr(max(0,RDSN-CRDSIM-RD9YP) * TXINT / 100) * (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);
PCVN = (
       INCCVN_NET
       + NMAJCVN1 + NMAJCVN4
         + arr(max(0,CVNN - COD8YT-CVN9YP) * TXINT / 100) * (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);

PTAXA = (
       INCTAXA_NET
       + NMAJTAXA1 + NMAJTAXA3 + NMAJTAXA4
         + arr(max(0,TAXASSUR- min(TAXASSUR+0,max(0,INE-IRB+AVFISCOPTER))+min(0,IRN - IRANT)-TAXA9YI) * TXINT / 100)* (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) ;
PPCAP = (
       INCPCAP_NET
       + NMAJPCAP1 + NMAJPCAP3 + NMAJPCAP4
         + arr(max(0,IPCAPTAXT- min(IPCAPTAXT+0,max(0,INE-IRB+AVFISCOPTER-TAXASSUR))+min(0,IRN - IRANT+TAXASSUR)-CAP9YI) * TXINT / 100)* (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) ;
PTAXLOY = (
       INCLOY_NET
       + NMAJLOY1 + NMAJLOY3 + NMAJLOY4
         + arr(max(0,LOYELEV- min(LOYELEV+0,max(0,INE-IRB+AVFISCOPTER-TAXASSUR-IPCAPTAXT))+min(0,IRN - IRANT+TAXASSUR+IPCAPTAXT)-LOY9YI) * TXINT / 100)* (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) ;
PHAUTREV  = (
       INCCHR_NET
       + NMAJCHR1 + NMAJCHR3 + NMAJCHR4
         + arr(max(0,IHAUTREVT+min(0,IRN - IRANT+TAXASSUR+IPCAPTAXT+LOYELEV)-CHR9YI) * TXINT / 100)* (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) ;
PGLOA = (
       INCGLOA_NET
       + NMAJGLO1 + NMAJGLO4
         + arr((max(0,CGLOA  - COD8YL-GLO9YP)* TXINT / 100) * (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT)))) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);
PRSE1 = (
       INCRSE1_NET
       + NMAJRSE11 + NMAJRSE14
         + arr(max(0,RSE1 -CIRSE1 -CSPROVYD-RSE19YP)* TXINT / 100) * (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);
PRSE2 = (
      		  INCRSE2_NET
       		+ NMAJRSE21 + NMAJRSE24
        	+ arr(max(0,(max(0,RSE8TV -CIRSE8TV -CSPROVYF)+ max(0, RSE8SA -CIRSE8SA - CSPROVYN)-RSE29YP)) * TXINT / 100
                     ) * (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))
        ) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);
PRSE3 = (
       INCRSE3_NET
       + NMAJRSE31 + NMAJRSE34
         + arr(max(0,RSE3 -CIRSE3 -CSPROVYG-RSE39YP)* TXINT / 100) * (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);
PRSE4 = (
      	          INCRSE4_NET
       		+ NMAJRSE41 + NMAJRSE44
                + arr(max(0,RSE4 - CIRSE4 - CSPROVRSE4 - RSE49YP)* TXINT / 100) * (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))
        ) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);

PRSE5 = (
       INCRSE5_NET
       + NMAJRSE51 + NMAJRSE54
         + arr(max(0,RSE5 -CIRSE5 -CSPROVYE-RSE59YP)* TXINT / 100) * (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);
PRSE6 = (
       INCRSE6_NET
       + NMAJRSE61 + NMAJRSE64
         + arr(max(0,RSE6 -CIRSE6 -RSE69YP)* TXINT / 100) * (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);
PCDIS = (
       INCCDIS_NET
       + NMAJCDIS1 + NMAJCDIS4
         + arr(max(0,CDIS-CDISPROV-CDIS9YP) * TXINT / 100) * (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) * positif_ou_nul(CSTOTSSPENA - SEUIL_61);

PDEG = max(0,PIR_A + PTAXA_A + PPCAP_A - PTAXLOY_A - PCHR_A - PIR - PTAXA - PPCAP - PTAXLOY - PHAUTREV);

regle 201080:
application : batch , iliad ;
PTOTIRCS = PIR + PTAXA + PTAXLOY + PHAUTREV + PPCAP +
           PPRS + PCSG + PRDS + PCDIS + PCVN +
	   PGLOA + PRSE1 + PRSE2 + PRSE3 + PRSE4 + 
           PRSE5 + PRSE6 ;

TOTPENIR = (PIR + PTAXA + PTAXLOY + PHAUTREV + PPCAP)
             * positif ( positif_ou_nul(VARIR61-SEUIL_61)
                         + positif_ou_nul(VARIRDROIT-SEUIL_61)
                       ) ;

TOTPENCS = (PPRS+ PCSG + PRDS + PCVN + PCDIS + PGLOA + PRSE1 + PRSE2 + PRSE3 + PRSE4 + PRSE5 + PRSE6) * positif_ou_nul(VARPS61-SEUIL_61);

INCTOTIR = RETIR + RETTAXA + RETPCAP + RETLOY + RETHAUTREV ;

INCTOTCS = RETCS+RETRD+RETPS+RETCVN+RETCDIS+RETGLOA
           +RETRSE1+RETRSE2+RETRSE3+RETRSE4
           +RETRSE5+RETRSE6;
RETIRCSTOT = INCTOTIR + INCTOTCS ;

regle 201090:
application : batch ;

PIR = PTOIR * positif_ou_nul(IAMD1 - SEUIL_61) ;
PPRS = PTOPRS ;
PCSG = PTOCSG ;
PRSE1 = PTORSE1 ;
PRSE2 = PTORSE2 ;
PRSE3 = PTORSE3 ;
PRSE4 = PTORSE4 ;
PRSE5 = PTORSE5 ;
PRSE6 = PTORSE6 ;
PRDS = PTORDS ;
PTAXA = PTOTAXA ;
PPCAP = PTOTPCAP ;
PTAXLOY = PTOTLOY ;
PHAUTREV = PTOTCHR ;
PCVN = PTOCVN ;
PCDIS = PTOCDIS ;
PGLOA = PTOGLOA ;


regle 201100:
application : iliad , batch ;


PTOT = PIR ;

regle 201110:
application : iliad ;


ILI_SYNT_IR =  positif(TOTIRCUM - NONMER - RECUMIR + NONREST - TOTPENIR) * max(0 , IRCUM - NONMER + NONREST - PIR)
              + (1 - positif(TOTIRCUM - NONMER - RECUMIR + NONREST - TOTPENIR)) * (TOTIRCUM - NONMER - RECUMIR + NONREST - TOTPENIR) ;

PIRNEG = abs(min(0 , IRCUM - NONMER + NONREST - PIR)) ;

ILI_SYNT_TAXA = positif(TOTIRCUM - NONMER - RECUMIR + NONREST - TOTPENIR) * max(0,TAXACUM - PTAXA - PIRNEG)
               + (1 - positif(TOTIRCUM - NONMER - RECUMIR + NONREST - TOTPENIR)) * 0 ;

PTAXANEG = abs(min(0 , TAXACUM - PTAXA - PIRNEG)) ;

ILI_SYNT_CAP = positif(TOTIRCUM - NONMER - RECUMIR + NONREST - TOTPENIR) * max(0 , PCAPCUM - PPCAP - PTAXANEG)
               + (1 - positif(TOTIRCUM - NONMER - RECUMIR + NONREST - TOTPENIR)) * 0 ;

PPCAPNEG = abs(min(0 , PCAPCUM - PPCAP - PTAXANEG)) ;

ILI_SYNT_LOY = positif(TOTIRCUM - NONMER - RECUMIR + NONREST - TOTPENIR) * max(0 , TAXLOYCUM - PTAXLOY - PPCAPNEG)
               + (1 - positif(TOTIRCUM - NONMER - RECUMIR + NONREST - TOTPENIR)) * 0 ;

PTAXLOYNEG = abs(min(0 , TAXLOYCUM - PTAXLOY - PPCAPNEG)) ;

ILI_SYNT_CHR = positif(TOTIRCUM - NONMER - RECUMIR + NONREST - TOTPENIR) * max(0 , HAUTREVCUM - PHAUTREV - PTAXLOYNEG)
               + (1 - positif(TOTIRCUM - NONMER - RECUMIR + NONREST - TOTPENIR)) * 0 ;

ILI_SYNT_TOTIR = ILI_SYNT_IR + ILI_SYNT_TAXA + ILI_SYNT_CAP + ILI_SYNT_LOY + ILI_SYNT_CHR ;

regle 201120:
application : iliad , batch ;


ILIIRNET =  positif_ou_nul(TOTIRCUM - RECUMIR - TOTPENIR) * max(0,IRCUM-PIR)
	      + (1 - positif_ou_nul(TOTIRCUM - RECUMIR - TOTPENIR)) * (TOTIRCUM - RECUMIR - TOTPENIR);

PIRNETNEG =  max(0,PIR-IRCUM);

ILITAXANET = positif_ou_nul(TOTIRCUM - RECUMIR - TOTPENIR) * max(0,TAXACUM - PTAXA - PIRNETNEG)
	       + (1 - positif_ou_nul(TOTIRCUM - RECUMIR - TOTPENIR)) * 0;

PTAXANETNEG =  max(0,PIR+PTAXA-IRCUM-TAXACUM);

ILICAPNET = positif_ou_nul(TOTIRCUM - RECUMIR - TOTPENIR) * max(0,PCAPCUM -PPCAP-PTAXANETNEG)
	       + (1 - positif_ou_nul(TOTIRCUM - RECUMIR - TOTPENIR)) * 0;

PPCAPNETNEG =  max(0,PIR+PTAXA+PPCAP-IRCUM-TAXACUM-PCAPCUM);

ILILOYNET = positif_ou_nul(TOTIRCUM - RECUMIR - TOTPENIR) * max(0,TAXLOYCUM-PTAXLOY-PPCAPNETNEG)
	       + (1 - positif_ou_nul(TOTIRCUM - RECUMIR - TOTPENIR)) * 0;

PTAXLOYNETNEG =  max(0,PIR+PTAXA+PPCAP+PTAXLOY-IRCUM-TAXACUM-PCAPCUM-TAXLOYCUM);

ILICHRNET = positif_ou_nul(TOTIRCUM - RECUMIR - TOTPENIR) * max(0,HAUTREVCUM-PHAUTREV-PTAXLOYNETNEG) 
	       + (1 - positif_ou_nul(TOTIRCUM - RECUMIR - TOTPENIR)) * 0;

ILITOTIRNET = ILIIRNET + ILITAXANET + ILICAPNET + ILILOYNET + ILICHRNET;

ILITOTPSNET = max(0, NAPCR61 - TOTPENCS) ;

TOTIRE = IREP - ITRED - IRE - INE ;

TOTTP = TTPVQ + REVTP ;

regle 201130:
application : batch ;


MAJOTOT28IR = NMAJ1     +
               NMAJTAXA1 +
               NMAJPCAP1 +
               NMAJLOY1  +
               NMAJCHR1 ;

MAJOTOT28PS = NMAJC1 +
               NMAJR1    +
                NMAJP1    +
                NMAJCVN1  +
                NMAJCDIS1 +
                NMAJGLO1  +
                NMAJRSE11 +
                NMAJRSE21 +
                NMAJRSE31 +
                NMAJRSE41 +
                NMAJRSE51 +
                NMAJRSE61 ;

MAJO1728TOT = MAJOTOT28IR + MAJOTOT28PS ;

regle 201140:
application : iliad ;


DEC_CGA_AGA = BAFV + BAFC + BAFP
            + BAHREV - BAHDEV
            + BAHREC - BAHDEC
            + BAHREP - BAHDEP
            + BIHNOV - BIHDNV
            + BIHNOC - BIHDNC
            + BIHNOP - BIHDNP
            + BICHREV - BICHDEV
            + BICHREC - BICHDEC
            + BICHREP - BICHDEP
            + BNHREV - BNHDEV
            + BNHREC - BNHDEC
            + BNHREP - BNHDEP
            + ANOCEP - DNOCEP
            + ANOVEP - DNOCEPC
            + ANOPEP - DNOCEPP
            ;
MAJ_CGA_AGA =  arr(SUPREV * (BAFV + BAFC + BAFP))
            + arr(SUPREV * max(0,BAHREV - BAHDEV ))
            + arr(SUPREV * max(0,BAHREC - BAHDEC ))
            + arr(SUPREV * max(0,BAHREP - BAHDEP ))
            + arr(SUPREV * max(0,BIHNOV - BIHDNV ))
            + arr(SUPREV * max(0,BIHNOC - BIHDNC ))
            + arr(SUPREV * max(0,BIHNOP - BIHDNP ))
            + arr(SUPREV * max(0,BICHREV - BICHDEV ))
            + arr(SUPREV * max(0,BICHREC - BICHDEC ))
            + arr(SUPREV * max(0,BICHREP - BICHDEP ))
            + arr(SUPREV * max(0,BNHREV - BNHDEV ))
            + arr(SUPREV * max(0,BNHREC - BNHDEC ))
            + arr(SUPREV * max(0,BNHREP - BNHDEP ))
            + arr(SUPREV * max(0,ANOCEP - DNOCEP ))
            + arr(SUPREV * max(0,ANOVEP - DNOCEPC ))
            + arr(SUPREV * max(0,ANOPEP - DNOCEPP ))
            ;
TOT_CGA_AGA = DEC_CGA_AGA + MAJ_CGA_AGA ;

