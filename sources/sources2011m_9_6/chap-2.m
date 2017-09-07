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
 #
 #     CHAPITRE 2. CALCUL DU NET A PAYER
 #
 #
 #
regle 20100:
application : batch , oceans, iliad ;
NAPINI = ( IRN + PIR - IRANT )* (1 - INDTXMIN) *(1 - INDTXMOY)
       + min(0, IRN + PIR - IRANT) * (INDTXMIN + INDTXMOY)
       + max(0, IRN + PIR - IRANT) * 
                                (INDTXMIN*positif(IAVIMBIS-SEUIL_TXMIN )
                               + INDTXMOY* positif(IAVIMO-SEUIL_TXMIN))
                      + RASAR * V_CR2;
RC1INI = positif( NAPINI + 1 - SEUIL_REC_CP ) ;
regle 20101:
application : batch, iliad , pro,oceans ;
NAPTOT = IRCUM + TAXACUM + PCAPCUM + HAUTREVCUM - RECUM;
regle 20102:
application : batch ;
NAPTOTA = IRCUM_A + TAXACUM_A + PCAPCUM_A + HAUTREVCUM_A - RECUM_A;
regle 20103:
application : iliad ,oceans;
NAPTOTA = V_ANTIR + V_TAXANT + V_PCAPANT + V_CHRANT - RECUMBIS ;
TOTCRA = V_ANTCR ;
regle 20104:
application : oceans ;
OCEDIMP = IRNIN ;
regle 20105:
application : oceans , batch, iliad ;
IRNIN = (IRN - IRANT) * positif(IRN - IRANT) ;
regle isf 201050:
application : oceans , batch, iliad ;
ISF4BASE = ISF4 * positif_ou_nul(ISF4 - SEUIL_REC_CP);  
ISFIN = ISF4 ;
regle 201051:
application : oceans , batch, iliad;
IRNIN_INR = (IRN - IRANT - ACODELAISINR) * positif(IRN - IRANT) ;
CSBASE = CSG - CSGIM ;
RDBASE = RDSN - CRDSIM ;
PSBASE = PRS - PRSPROV ;
GAINBASE = CGAINSAL - GAINPROV ;
CSALBASE = CSAL - PROVCSAL ;
CDISBASE = CDIS - CDISPROV ;
RSE1BASE = RSE1 ;
RSE2BASE = RSE2 ;
RSE3BASE = RSE3 ;
RSE4BASE = RSE4 ;
TAXABASE = arr(max(TAXASSUR + min(0,IRN - IRANT),0)) * positif(IAMD1 + 1 - SEUIL_PERCEP);
PCAPBASE = arr(max(IPCAPTAXT + min(0,IRN - IRANT + TAXASSUR),0)) * positif(IAMD1 + 1 - SEUIL_PERCEP);
CHRBASE = arr(max(IHAUTREVT + min(0,IRN - IRANT + TAXASSUR+IPCAPTAXT),0)) * positif(IAMD1 + 1 - SEUIL_PERCEP);

IRBASE_I = (IRN -IRANT)*positif(IRN+1-SEUIL_REC_CP); 
	  
IRBASE_N = (IRN - IRANT)*(1 - positif (IRN-IRANT + TAXABASE_IRECT+CAPBASE_IRECT+HRBASE_IRECT))
	   + (IAN - min( IAN , IRE )) * positif (IRN-IRANT + TAXABASE_IRECT+CAPBASE_IRECT+HRBASE_IRECT); 
TAXABASE_I = TAXASSUR * positif(IAMD1 + 1 - SEUIL_PERCEP);
TAXABASE_N = arr(max(TAXASSUR + min(0,IRN - IRANT),0)) * positif(IAMD1 + 1 - SEUIL_PERCEP);
CAPBASE_I = IPCAPTAXT * positif(IAMD1 + 1 - SEUIL_PERCEP);
CAPBASE_N = arr(max(IPCAPTAXT + min(0,IRN - IRANT + TAXASSUR),0)) * positif(IAMD1 + 1 - SEUIL_PERCEP);
HRBASE_I = IHAUTREVT * positif(IAMD1 + 1 - SEUIL_PERCEP);
HRBASE_N = arr(max(IHAUTREVT + min(0,IRN - IRANT + TAXASSUR+IPCAPTAXT),0)) * positif(IAMD1 + 1 - SEUIL_PERCEP);


IRNN = IRNIN;
regle 20106:
application : oceans, iliad;
PIR = (
       INCIR_NET
       + NMAJ1 + NMAJ3 + NMAJ4 
       + arr((BTOINR) * TXINT / 100)* (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT)))
       ;
PPRS = (
       INCPS_NET
       + NMAJP1 + NMAJP4
       + arr((PRS-PRSPROV) * TXINT / 100)* (1 - V_CNR)* (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) ;
PCSG = (
       INCCS_NET
       + NMAJC1 + NMAJC4
         + arr((CSG-CSGIM) * TXINT / 100) * (1 - V_CNR)* (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) ;
PRDS = (
       INCRD_NET
       + NMAJR1 + NMAJR4
         + arr((RDSN-CRDSIM) * TXINT / 100) * (1 - V_CNR)* (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) ;
PTAXA = (
       INCTAXA_NET
       + NMAJTAXA1 + NMAJTAXA3 + NMAJTAXA4
         + arr(max(0,TAXASSUR- min(TAXASSUR+0,max(0,INE-IRB+AVFISCOPTER))+min(0,IRN - IRANT)) * TXINT / 100)* (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) ;
PPCAP = (
       INCPCAP_NET
       + NMAJPCAP1 + NMAJPCAP3 + NMAJPCAP4
         + arr(max(0,IPCAPTAXT- min(IPCAPTAXT+0,max(0,INE-IRB+AVFISCOPTER-TAXASSUR))+min(0,IRN - IRANT+TAXASSUR)) * TXINT / 100)* (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) ;
PHAUTREV  = (
       INCCHR_NET
       + NMAJCHR1 + NMAJCHR3 + NMAJCHR4
         + arr(max(0,IHAUTREVT- min(IHAUTREVT+0,max(0,INE-IRB+AVFISCOPTER-TAXASSUR-IPCAPTAXT))+min(0,IRN - IRANT+TAXASSUR+IPCAPTAXT)) * TXINT / 100)* (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) ;
PCSAL = (
       INCCSAL_NET
       + NMAJCSAL1 + NMAJCSAL4
         + arr(max(0,(CSAL - PROVCSAL)) * TXINT / 100) * (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) ;
PGAIN = (
       INCGAIN_NET
       + NMAJGAIN1 + NMAJGAIN4
         + arr(max(0,(CGAINSAL - GAINPROV)) * TXINT / 100) * (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) ;
PRSE1 = (
       INCRSE1_NET
       + NMAJRSE11 + NMAJRSE14
         + arr(RSE1 * TXINT / 100) * (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) ;
PRSE2 = (
       INCRSE2_NET
       + NMAJRSE21 + NMAJRSE24
         + arr(RSE2 * TXINT / 100) * (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) ;
PRSE3 = (
       INCRSE3_NET
       + NMAJRSE31 + NMAJRSE34
         + arr(RSE3 * TXINT / 100) * (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) ;
PRSE4 = (
       INCRSE4_NET
       + NMAJRSE41 + NMAJRSE44
         + arr(RSE4 * TXINT / 100) * (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) ;
PCDIS = (
       INCCDIS_NET
       + NMAJCDIS1 + NMAJCDIS4
         + arr((CDIS-CDISPROV) * TXINT / 100) * (1 - V_CNR)* (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) ;

PDEG = max(0,PIR_A + PTAXA_A + PPCAP_A - PIR - PTAXA - PPCAP);
regle 20107:
application : pro,batch  ;
PIR = PTOIR * positif_ou_nul(IAMD1 - SEUIL_PERCEP) ;
PPRS = PTOPRS ;
PCSG = PTOCSG ;
PRSE1 = PTORSE1 ;
PRSE2 = PTORSE2 ;
PRSE3 = PTORSE3 ;
PRSE4 = PTORSE4 ;
PRDS = PTORDS ;
PTAXA = PTOTAXA ;
PPCAP = PTOTPCAP ;
PHAUTREV = PTOTCHR ;
PGAIN = PTOGAIN ;
PCSAL = PTOCSAL ;
PCDIS = PTOCDIS ;

regle 20109:
application : pro , oceans , iliad , batch ;
PTOT = PIR ;
regle 20110:
application : iliad ,oceans ;
ILI_SYNT_IR =  positif_ou_nul(IRCUM -RECUM +TAXACUM + PCAPCUM + HAUTREVCUM-PIR-PTAXA-PPCAP-PHAUTREV) * (
                     null(IRCUM - V_ANTIR) *( IRCUM - PIR_A * positif(PIR))
                     + (1-null(IRCUM - V_ANTIR)) *  (IRCUM - PIR))
		  +  (1-positif_ou_nul(IRCUM -RECUM +TAXACUM + PCAPCUM + HAUTREVCUM-PIR-PTAXA-PPCAP-PHAUTREV)) * (
		    null(IRCUM -RECUM +TAXACUM + PCAPCUM + HAUTREVCUM-PIR-PTAXA-PPCAP-PHAUTREV - V_ANTRE)*
		    (IRCUM-RECUM+TAXACUM+PCAPCUM+HAUTREVCUM-PIR_A*positif(PIR)-PTAXA_A*positif(PTAXA)-PPCAP_A*positif(PPCAP)-PHAUTREV_A*positif(PHAUTREV))
		   + (1-null(IRCUM -RECUM +TAXACUM + PCAPCUM + HAUTREVCUM-PIR-PTAXA-PPCAP-PHAUTREV - V_ANTRE)) *
		    (IRCUM-RECUM+TAXACUM+PCAPCUM+HAUTREVCUM-PIR-PTAXA-PPCAP-PHAUTREV)
		                                                                                                  );
PIRNEG =  (1-positif(IAR - IRANT)) * PIR 
	 + positif_ou_nul(IAR - IRANT) * positif_ou_nul(PIR - (IRCUM - IRANT)) * (PIR - (IRCUM - IRANT))
	 + 0;
ILI_SYNT_TAXA = positif_ou_nul(IRCUM -RECUM +TAXACUM + PCAPCUM + HAUTREVCUM-PIR-PTAXA-PPCAP-PHAUTREV) * (
			                null(TAXACUM - V_TAXANT) * ( TAXACUM - PTAXA_A*positif(PTAXA))
                                      + (1-null(TAXACUM - V_TAXANT)) * max(0,(TAXACUM - PTAXA - PIRNEG))
                                       + 0                                                            );
PTAXANEG =  (1-positif(IAR - IRANT+TAXASSUR-PIR)) * max(0,(PTAXA + PIRNEG - TAXACUM))
	 + positif_ou_nul(IAR - IRANT+TAXASSUR-PIR) * positif_ou_nul(PTAXA - (IRCUM - IRANT)-TAXACUM-PIR) * (PTAXA - (IRCUM - IRANT)-TAXACUM-PIR)
	 + 0;
ILI_SYNT_CAP = positif_ou_nul(IRCUM -RECUM +TAXACUM + PCAPCUM + HAUTREVCUM-PIR-PTAXA-PPCAP-PHAUTREV) * ( 
		   null(PCAPCUM - V_PCAPANT) * ( PCAPCUM - PPCAP_A*positif(PPCAP))
                + (1-null(PCAPCUM - V_PCAPANT)) * max(0, PCAPCUM - PPCAP - PTAXANEG)
                                       + 0                                                            );
PPCAPNEG =  (1-positif(IAR - IRANT+TAXASSUR-PIR+IPCAPTAXT-PTAXA)) * max(0,(PPCAP+PTAXANEG-PCAPCUM)) 
	 + positif_ou_nul(IAR - IRANT+TAXASSUR-PIR+IPCAPTAXT-PTAXA) * positif_ou_nul(PPCAP - (IRCUM - IRANT)-TAXACUM-PIR-PCAPCUM-PTAXA) * (PPCAP - (IRCUM - IRANT)-TAXACUM-PIR-PCAPCUM-PTAXA)
	 + 0;
ILI_SYNT_CHR = positif_ou_nul(IRCUM -RECUM +TAXACUM + PCAPCUM + HAUTREVCUM-PIR-PTAXA-PPCAP-PHAUTREV) * ( 
		   null(HAUTREVCUM - V_CHRANT) * ( HAUTREVCUM - PCHR_A*positif(PHAUTREV))
                + (1-null(HAUTREVCUM - V_CHRANT)) * max(0, HAUTREVCUM - PHAUTREV - PPCAPNEG)
                                       + 0                                                            );
regle 20111:
application : oceans ;
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
