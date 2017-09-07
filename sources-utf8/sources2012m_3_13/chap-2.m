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
 #     CHAPITRE 2. CALCUL DU NET A PAYER
 #
 #
 #
regle 20100:
application : batch, iliad ;
NAPINI = ( IRN + PIR - IRANT )* (1 - INDTXMIN) *(1 - INDTXMOY)
       + min(0, IRN + PIR - IRANT) * (INDTXMIN + INDTXMOY)
       + max(0, IRN + PIR - IRANT) * 
                                (INDTXMIN*positif((IAVIMBIS-NAPCRPAVIM)-SEUIL_61 )
			       + INDTXMOY* positif((IAVIMO-NAPCRPAVIM)-SEUIL_61))
                      + RASAR * V_CR2;
RC1INI = positif( NAPINI + 1 - SEUIL_12 ) ;
regle 20101:
application : batch, iliad ;
NAPTOT = IRCUM + TAXACUM + PCAPCUM + TAXLOYCUM + HAUTREVCUM  - RECUMIR;
regle 20103:
application : iliad ,batch;
NAPTOTA = V_IRPSANT - V_ANTRE;
NAPTOTAIR = V_TOTIRANT - V_ANTREIR;
TOTCRA = V_ANTCR ;
TOTIRPSANT = V_IRPSANT + V_NONRESTANT - V_ANTRE;
regle 20104:
application : iliad ;
OCEDIMP = IRNIN ;
regle 20105:
application : batch, iliad ;
IRNIN = (IRN - IRANT) * positif(IRN - IRANT) ;
regle isf 201050:
application : batch, iliad ;
ISF4BASE = ISF4BIS * positif_ou_nul(ISF4BIS - SEUIL_12);  
ISFIN = ISF4BASE ;
regle 201051:
application : batch, iliad;
IRNIN_INR = (IRN - IRANT - ACODELAISINR) * positif(IRN - IRANT) ;
CSBASE = CSG - CSGIM ;
RDBASE = RDSN - CRDSIM ;
PSBASE = PRS - PRSPROV ;
GAINBASE = CGAINSAL - GAINPROV ;
CSALBASE = CSAL - CSALPROV ;
CVNBASE = CVNSALC - PROVCVNSAL ;
CDISBASE = CDIS - CDISPROV ;
GLOBASE = CGLOA ;
RSE1BASE = RSE1N - CSPROVYD;
RSE2BASE = RSE2N - CSPROVYF;
RSE3BASE = RSE3N - CSPROVYG;
RSE4BASE = RSE4N - CSPROVYH;
RSE5BASE = RSE5N - CSPROVYE;
TAXABASE = arr(max(TAXASSUR + min(0,IRN - IRANT),0)) * positif(IAMD1 + NAPCRPIAMD1+ 1 - SEUIL_61);
PCAPBASE = arr(max(IPCAPTAXT + min(0,IRN - IRANT + TAXASSUR),0)) * positif(IAMD1 + NAPCRPIAMD1+ 1 - SEUIL_61);
LOYBASE = arr(max(TAXLOY + min(0,IRN - IRANT + TAXASSUR+IPCAPTAXT),0)) * positif(IAMD1 + NAPCRPIAMD1+ 1 - SEUIL_61);
CHRBASE = arr(max(IHAUTREVT + min(0,IRN - IRANT + TAXASSUR+IPCAPTAXT+TAXLOY),0)) * positif(IAMD1 + NAPCRPIAMD1+ 1 - SEUIL_61);

IRBASE_I = (IRN -IRANT)*positif(IRN+1+NAPCRPIAMD1-SEUIL_12);

IRBASE_N = (IRN - IRANT)*(1 - positif (IRN-IRANT + TAXABASE_IRECT+CAPBASE_IRECT+HRBASE_IRECT))
           + (IAN - min( IAN , IRE )) * positif (IRN-IRANT + TAXABASE_IRECT+CAPBASE_IRECT+HRBASE_IRECT);
TAXABASE_I = TAXASSUR * positif(IAMD1 +NAPCRPIAMD1+ 1 - SEUIL_61);
TAXABASE_N = arr(max(TAXASSUR + min(0,IRN - IRANT),0)) * positif(IAMD1 +NAPCRPIAMD1+ 1 - SEUIL_61);
CAPBASE_I = IPCAPTAXT * positif(IAMD1 +NAPCRPIAMD1+ 1 - SEUIL_61);
CAPBASE_N = arr(max(IPCAPTAXT + min(0,IRN - IRANT + TAXASSUR),0)) * positif(IAMD1 +NAPCRPIAMD1+ 1 - SEUIL_61);
LOYBASE_I = TAXLOY * positif(IAMD1 +NAPCRPIAMD1+ 1 - SEUIL_61);
LOYBASE_N = arr(max(TAXLOY + min(0,IRN - IRANT + TAXASSUR+IPCAPTAXT),0)) * positif(IAMD1 +NAPCRPIAMD1+ 1 - SEUIL_61);
HRBASE_I = IHAUTREVT * positif(IAMD1 +NAPCRPIAMD1+ 1 - SEUIL_61);
HRBASE_N = arr(max(IHAUTREVT + min(0,IRN - IRANT + TAXASSUR+IPCAPTAXT+TAXLOY),0)) * positif(IAMD1 +NAPCRPIAMD1+ 1 - SEUIL_61);

IRNN = IRNIN;

regle 20106:
application : iliad;
PIR = (
       INCIR_NET
       + NMAJ1 + NMAJ3 + NMAJ4 
       + arr((BTOINR) * TXINT / 100)* (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT)))
       ;
PPRS = (
       INCPS_NET
       + NMAJP1 + NMAJP4
       + arr((PRS-PRSPROV) * TXINT / 100)* (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) ;
PCSG = (
       INCCS_NET
       + NMAJC1 + NMAJC4
         + arr((CSG-CSGIM) * TXINT / 100) * (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) ;
PRDS = (
       INCRD_NET
       + NMAJR1 + NMAJR4
         + arr((RDSN-CRDSIM) * TXINT / 100) * (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) ;

PTAXA = (
       INCTAXA_NET
       + NMAJTAXA1 + NMAJTAXA3 + NMAJTAXA4
         + arr(max(0,TAXASSUR- min(TAXASSUR+0,max(0,INE-IRB+AVFISCOPTER))+min(0,IRN - IRANT)) * TXINT / 100)* (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) ;
PPCAP = (
       INCPCAP_NET
       + NMAJPCAP1 + NMAJPCAP3 + NMAJPCAP4
         + arr(max(0,IPCAPTAXT- min(IPCAPTAXT+0,max(0,INE-IRB+AVFISCOPTER-TAXASSUR))+min(0,IRN - IRANT+TAXASSUR)) * TXINT / 100)* (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) ;
PTAXLOY = (
       INCLOY_NET
       + NMAJLOY1 + NMAJLOY3 + NMAJLOY4
         + arr(max(0,LOYELEV- min(LOYELEV+0,max(0,INE-IRB+AVFISCOPTER-TAXASSUR-IPCAPTAXT))+min(0,IRN - IRANT+TAXASSUR+IPCAPTAXT)) * TXINT / 100)* (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) ;
PHAUTREV  = (
       INCCHR_NET
       + NMAJCHR1 + NMAJCHR3 + NMAJCHR4
         + arr(max(0,IHAUTREVT+min(0,IRN - IRANT+TAXASSUR+IPCAPTAXT+LOYELEV)) * TXINT / 100)* (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) ;
PCSAL = (
       INCCSAL_NET
       + NMAJCSAL1 + NMAJCSAL4
         + arr(max(0,(CSAL - CSALPROV)) * TXINT / 100) * (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) ;
PGAIN = (
       INCGAIN_NET
       + NMAJGAIN1 + NMAJGAIN4
         + arr(max(0,(CGAINSAL - GAINPROV)) * TXINT / 100) * (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) ;
PCVN = (
       INCCVN_NET
       + NMAJCVN1 + NMAJCVN4
         + arr(max(0,(CVNSALC - PROVCVNSAL)) * TXINT / 100) * (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) ;
PGLOA = (
       INCGLOA_NET
       + NMAJGLO1 + NMAJGLO4
         + arr((CGLOA * TXINT / 100) * (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT)))) ;
PRSE1 = (
       INCRSE1_NET
       + NMAJRSE11 + NMAJRSE14
         + arr(max(0,RSE1 -CIRSE1 -CSPROVYD)* TXINT / 100) * (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) ;
PRSE2 = (
       INCRSE2_NET
       + NMAJRSE21 + NMAJRSE24
         + arr(max(0,RSE2 -CIRSE2 -CSPROVYF)* TXINT / 100) * (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) ;
PRSE3 = (
       INCRSE3_NET
       + NMAJRSE31 + NMAJRSE34
         + arr(max(0,RSE3 -CIRSE3 -CSPROVYG)* TXINT / 100) * (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) ;
PRSE4 = (
       INCRSE4_NET
       + NMAJRSE41 + NMAJRSE44
         + arr(max(0,RSE4 -CIRSE4 -CSPROVYH)* TXINT / 100) * (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) ;
PRSE5 = (
       INCRSE5_NET
       + NMAJRSE51 + NMAJRSE54
         + arr(max(0,RSE5 -CIRSE5 -CSPROVYE)* TXINT / 100) * (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) ;
PCDIS = (
       INCCDIS_NET
       + NMAJCDIS1 + NMAJCDIS4
         + arr((CDIS-CDISPROV) * TXINT / 100) * (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) ;

PDEG = max(0,PIR_A + PTAXA_A + PPCAP_A - PTAXLOY_A - PCHR_A - PIR - PTAXA - PPCAP - PTAXLOY - PHAUTREV);

regle 201061:
application : batch , iliad  ;

PTOTIRCS = PIR + PPRS + PCSG + PRDS + PTAXA + PTAXLOY + PHAUTREV + PPCAP + PCDIS + PCSAL + PGAIN + PCVN 
	   + PGLOA + PRSE1 + PRSE2 + PRSE3 + PRSE4 + PRSE5;

TOTPENIR = PIR + PTAXA + PTAXLOY + PHAUTREV + PPCAP ;

TOTPENCS = PPRS+ PCSG + PRDS + PGAIN + PCSAL + PCVN + PCDIS + PGLOA + PRSE1 + PRSE2 + PRSE3 + PRSE4 + PRSE5;

regle 20107:
application : batch  ;
PIR = PTOIR * positif_ou_nul(IAMD1 +NAPCRPIAMD1- SEUIL_61) ;
PPRS = PTOPRS ;
PCSG = PTOCSG ;
PRSE1 = PTORSE1 ;
PRSE2 = PTORSE2 ;
PRSE3 = PTORSE3 ;
PRSE4 = PTORSE4 ;
PRSE5 = PTORSE5 ;
PRDS = PTORDS ;
PTAXA = PTOTAXA ;
PPCAP = PTOTPCAP ;
PTAXLOY = PTOTLOY ;
PHAUTREV = PTOTCHR ;
PCSAL = PTOCSAL ;
PGAIN = PTOGAIN ;
PCVN = PTOCVN ;
PCDIS = PTOCDIS ;
PGLOA = PTOGLOA ;

regle 20109:
application : iliad , batch ;
PTOT = PIR ;
regle 20110:
application : iliad ;
ILI_SYNT_IR =  positif_ou_nul(IRCUM -RECUM +TAXACUM + PCAPCUM +TAXLOYCUM+ HAUTREVCUM-PIR-PTAXA-PPCAP-PTAXLOY-PHAUTREV) * (
                     null(IRCUM - V_ANTIR) *( IRCUM - PIR_A * positif(PIR))
                     + (1-null(IRCUM - V_ANTIR)) *  (IRCUM - PIR))
		  +  (1-positif_ou_nul(IRCUM -RECUM +TAXACUM + PCAPCUM +TAXLOYCUM+ HAUTREVCUM-PIR-PTAXA-PPCAP-PTAXLOY-PHAUTREV)) * (
		    null(IRCUM -RECUM +TAXACUM + PCAPCUM +TAXLOYCUM+ HAUTREVCUM-PIR-PTAXA-PPCAP-PTAXLOY-PHAUTREV - V_ANTRE)*
		    (IRCUM-RECUM+TAXACUM+PCAPCUM+TAXLOYCUM+HAUTREVCUM-PIR_A*positif(PIR)-PTAXA_A*positif(PTAXA)-PPCAP_A*positif(PPCAP)-PTAXLOY_A*positif(PTAXLOY)
											       -PHAUTREV_A*positif(PHAUTREV))
		   + (1-null(IRCUM -RECUM +TAXACUM + PCAPCUM +TAXLOYCUM+ HAUTREVCUM-PIR-PTAXA-PPCAP-PTAXLOY-PHAUTREV - V_ANTRE)) *
		    (IRCUM-RECUM+TAXACUM+PCAPCUM+TAXLOYCUM+HAUTREVCUM-PIR-PTAXA-PPCAP-PTAXLOY-PHAUTREV)
		                                                                                                  );
PIRNEG =  (1-positif(IAR - IRANT)) * PIR 
	 + positif_ou_nul(IAR - IRANT) * positif_ou_nul(PIR - (IRCUM - IRANT)) * (PIR - (IRCUM - IRANT))
	 + 0;
ILI_SYNT_TAXA = positif_ou_nul(IRCUM -RECUM +TAXACUM + PCAPCUM +TAXLOYCUM+ HAUTREVCUM-PIR-PTAXA-PPCAP-PTAXLOY-PHAUTREV) * (
			                null(TAXACUM - V_TAXANT) * ( TAXACUM - PTAXA_A*positif(PTAXA))
                                      + (1-null(TAXACUM - V_TAXANT)) * max(0,(TAXACUM - PTAXA - PIRNEG))
                                       + 0                                                            );
PTAXANEG =  (1-positif(IAR - IRANT+TAXASSUR-PIR)) * max(0,(PTAXA + PIRNEG - TAXACUM))
	 + positif_ou_nul(IAR - IRANT+TAXASSUR-PIR) * positif_ou_nul(PTAXA - (IRCUM - IRANT)-TAXACUM-PIR) * (PTAXA - (IRCUM - IRANT)-TAXACUM-PIR)
	 + 0;
ILI_SYNT_CAP = positif_ou_nul(IRCUM -RECUM +TAXACUM + PCAPCUM +TAXLOYCUM+ HAUTREVCUM-PIR-PTAXA-PPCAP-PHAUTREV) * ( 
		   null(PCAPCUM - V_PCAPANT) * ( PCAPCUM - PPCAP_A*positif(PPCAP))
                + (1-null(PCAPCUM - V_PCAPANT)) * max(0, PCAPCUM - PPCAP - PTAXANEG)
                                       + 0                                                            );
PPCAPNEG =  (1-positif(IAR - IRANT+TAXASSUR-PIR+IPCAPTAXT-PTAXA)) * max(0,(PPCAP+PTAXANEG-PCAPCUM)) 
	 + positif_ou_nul(IAR - IRANT+TAXASSUR-PIR+IPCAPTAXT-PTAXA) * positif_ou_nul(PPCAP - (IRCUM - IRANT)-TAXACUM-PIR-PCAPCUM-PTAXA) * (PPCAP - (IRCUM - IRANT)-TAXACUM-PIR-PCAPCUM-PTAXA)
	 + 0;
ILI_SYNT_LOY = positif_ou_nul(IRCUM -RECUM +TAXACUM + PCAPCUM +TAXLOYCUM+ HAUTREVCUM-PIR-PTAXA-PPCAP-PTAXLOY-PHAUTREV) * ( 
		   null(TAXLOYCUM - V_TAXLOYANT) * ( TAXLOYCUM - PTAXLOY_A*positif(PTAXLOY))
                + (1-null(TAXLOYCUM - V_TAXLOYANT)) * max(0, TAXLOYCUM - PTAXLOY - PPCAPNEG)
                                       + 0                                                            );
PTAXLOYNEG =  (1-positif(IAR - IRANT+TAXASSUR-PIR+IPCAPTAXT-PTAXA+TAXLOY-PTAXLOY)) * max(0,(PTAXLOY+PPCAPNEG-TAXLOYCUM)) 
	 + positif_ou_nul(IAR - IRANT+TAXASSUR-PIR+IPCAPTAXT-PTAXA+TAXLOY-PTAXLOY) * positif_ou_nul(PTAXLOY - (IRCUM - IRANT)-TAXACUM-PIR-PCAPCUM-PTAXA) * (PTAXLOY - (IRCUM - IRANT)-TAXACUM-PIR-PCAPCUM-PTAXA-PPCAP-TAXLOYCUM)
	 + 0;
ILI_SYNT_CHR = positif_ou_nul(IRCUM -RECUM +TAXACUM + PCAPCUM +TAXLOYCUM+ HAUTREVCUM-PIR-PTAXA-PPCAP-PTAXLOY-PHAUTREV) * ( 
		   null(HAUTREVCUM - V_CHRANT) * ( HAUTREVCUM - PCHR_A*positif(PHAUTREV))
                + (1-null(HAUTREVCUM - V_CHRANT)) * max(0, HAUTREVCUM - PHAUTREV - PTAXLOYNEG)
                                       + 0                                                            );
PCHRNEG =  (1-positif(IAR - IRANT+TAXASSUR-PIR+IPCAPTAXT-PTAXA+TAXLOY-PTAXLOY)) * max(0,(PTAXLOY+PPCAPNEG-TAXLOYCUM)) 
	 + positif_ou_nul(IAR - IRANT+TAXASSUR-PIR+IPCAPTAXT-PTAXA+TAXLOY-PTAXLOY) * positif_ou_nul(PTAXLOY - (IRCUM - IRANT)-TAXACUM-PIR-PCAPCUM-PTAXA) * (PTAXLOY - (IRCUM - IRANT)-TAXACUM-PIR-PCAPCUM-PTAXA-PPCAP-TAXLOYCUM)
	 + 0;
regle 20111:
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
	    + arr(SUPREV * max(0,BAHREV - BAHDEV))
            + arr(SUPREV * max(0,BAHREC - BAHDEC))
            + arr(SUPREV * max(0,BAHREP - BAHDEP))
            + arr(SUPREV * max(0,BIHNOV - BIHDNV ))
            + arr(SUPREV * max(0,BIHNOC - BIHDNC ))
            + arr(SUPREV * max(0,BIHNOP - BIHDNP ))
            + arr(SUPREV * max(0,BICHREV - BICHDEV ))
            + arr(SUPREV * max(0,BICHREC - BICHDEC ))
            + arr(SUPREV * max(0,BICHREP - BICHDEP ))
            + arr(SUPREV * max(0,BNHREV - BNHDEV))
            + arr(SUPREV * max(0,BNHREC - BNHDEC))
            + arr(SUPREV * max(0,BNHREP - BNHDEP))
            + arr(SUPREV * max(0,ANOCEP - DNOCEP))
            + arr(SUPREV * max(0,ANOVEP - DNOCEPC))
            + arr(SUPREV * max(0,ANOPEP - DNOCEPP))
	    ;
TOT_CGA_AGA = DEC_CGA_AGA + MAJ_CGA_AGA;
