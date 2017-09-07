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
 #
 #     CHAPITRE 2. CALCUL DU NET A PAYER
 #
 #
 #
regle 20100:
application : batch , oceans, iliad ;
NAPINI = ( IRN + PIR + AME - IRANT )* (1 - INDTXMIN) *(1 - INDTXMOY)
       + min(0, IRN + PIR + AME - IRANT) * (INDTXMIN + INDTXMOY)
       + max(0, IRN + PIR + AME - IRANT) * 
                                (INDTXMIN*positif(IAVIMBIS-SEUIL_TXMIN )
                               + INDTXMOY* positif(IAVIMO-SEUIL_TXMIN))
                      + RASAR * V_CR2;
RC1INI = positif( NAPINI + 1 - SEUIL_REC_CP ) ;
regle 20101:
application : batch, iliad , pro,oceans ;
NAPTOT = IRCUM + TAXACUM - RECUM;
regle 20102:
application : batch ;
NAPTOTA = IRCUM_A + TAXACUM_A - RECUM_A;
regle 20103:
application : iliad ,oceans;
NAPTOTA = V_ANTIR + V_TAXANT - RECUMBIS ;
TOTCRA = V_ANTCR ;
regle 20104:
application : oceans ;
OCEDIMP = IRNIN + AME ;
regle 20105:
application : oceans , batch, iliad ;
IRNIN = (IRN+RPPEACO -IRANT) * positif(IRN+RPPEACO-IRANT) ;
regle 201051:
application : oceans , batch, iliad;
IRNIN_INR = (IRN - IRANT - ACODELAISINR) * positif(IRN - IRANT) ;
CSBASE = (CSG - CSGIM);
RDBASE = (RDSN - CRDSIM);
PSBASE = (PRS - PRSPROV);
CSALBASE = (CSAL - CSALPROV) ;
CDISBASE = CDIS ;
TAXABASE = arr(max(TAXASSUR + min(0,IRN - IRANT),0)) * positif(IAMD1 + 1 - SEUIL_PERCEP);
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
         + arr(max(0,TAXASSUR+min(0,IRN - IRANT)) * TXINT / 100)* (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) ;
PCSAL = (
       INCCSAL_NET
       + NMAJCSAL1 + NMAJCSAL4
         + arr((CSAL - CSALPROV) * TXINT / 100) * (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) ;
PCDIS = (
       INCCDIS_NET
       + NMAJCDIS1 + NMAJCDIS4
         + arr(CDIS * TXINT / 100) * (1 - V_CNR)* (1-positif(FLAG_PRIM+FLAG_RETARD+FLAG_DEFAUT))) ;

PDEG = max(0,PIR_A + PTAXA_A - PIR - PTAXA);
regle 20107:
application : pro,batch  ;
PIR = PTOIR * positif_ou_nul(IAMD1 + RPPEACO - SEUIL_PERCEP) ;
PPRS = PTOPRS ;
PCSG = PTOCSG ;
PRDS = PTORDS ;
PTAXA = PTOTAXA ;
PCSAL = PTOCSAL ;
PCDIS = PTOCDIS ;
regle 20109:
application : pro , oceans , iliad , batch ;
PTOT = PIR ;
regle 20110:
application : iliad ,oceans ;
ILI_SYNT_TAXA = positif(RECUM) * 0
		+ (1 - positif(RECUM)) * max(0, TAXACUM - PTAXA);
NOTRAIT2 = inf(V_NOTRAIT/10)*10;
NOTRAIT3 = V_NOTRAIT - NOTRAIT2;
ILI_SYNT_IR = positif(RECUM) * (
                     -1 * (RECUM + PIR + AME + PTAXA)*(1-positif(positif(SEUIL_REMBCP-(IDEGR-IREST)) * positif(SEUIL_REMBCP-RECUM) * null(NOTRAIT3 - 3)))
                     + positif(SEUIL_REMBCP-(IDEGR-IREST)) * positif(SEUIL_REMBCP-RECUM) * null(NOTRAIT3 - 3) * (max(V_ANTIR - PIR_A - AME_A,0) - V_ANTRE) 
                               )
                     + (1 - positif(RECUM)) * (
                     (IRCUM - PIR - AME + min(0,TAXACUM - PTAXA))* (1-positif( positif(SEUIL_REC_CP-abs(NAPT)) * null(NOTRAIT3 - 6)))
                     + positif(SEUIL_REC_CP-abs(NAPT)) * null(NOTRAIT3 - 6) * (max(V_ANTIR - positif_ou_nul(IINET)*PIR_A - AME_A,0) - V_ANTRE) 
                                              );
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
