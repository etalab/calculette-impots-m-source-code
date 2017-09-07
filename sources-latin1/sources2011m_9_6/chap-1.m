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
                                                                           #
  ####   #    #    ##    #####      #     #####  #####   ######           ##
 #    #  #    #   #  #   #    #     #       #    #    #  #               # #
 #       ######  #    #  #    #     #       #    #    #  #####             #
 #       #    #  ######  #####      #       #    #####   #                 #
 #    #  #    #  #    #  #          #       #    #   #   #                 #
  ####   #    #  #    #  #          #       #    #    #  ###### #######  #####
 #
 #
 #
 #
 #
 #                         CALCUL DU NET A PAYER
 #
 #
 #
 #
 #
 #
regle 101:
application : oceans , bareme  ;
RC1 = positif( NAPI + 1 - SEUIL_REC_CP ) +0 ;
regle 1010:
application : batch, pro , iliad , oceans ;

NAPT = ( NAPTOT - NAPTOTA - IRANT)* 
      positif_ou_nul (NAPTOT - NAPTOTA - IRANT - SEUIL_REC_CP)
      - IREST * positif(SEUIL_REMBCP-IREST)
      + min (0,NAPTOT - NAPTOTA - IRANT);
regle 10111:
application : iliad ;
RC1 = si ( NAPINI - V_ANTIR + RECUMBIS >= SEUIL_REC_CP )
      alors (1)
      sinon (0)
      finsi;
regle 10112:
application : batch ;
RC1 = si ( NAPINI - IRCUM_A + RECUMBIS >= SEUIL_REC_CP )
      alors (1)
      sinon (0)
      finsi;
regle 1013 :
application : pro , oceans , iliad , batch ;
IAVIMBIS = IRB + PIR ;
IAVIMO = (max(0,max(ID11-ADO1,IMI)-RED) + ITP + REI + PIR)
                 * V_CR2;
regle 1012:
application : pro , bareme , oceans , iliad , batch ;
NAPI = ( IRD + PIRD - IRANT ) * (1 - INDTXMIN) * (1 - INDTXMOY)
         + min(0, IRD + PIRD - IRANT ) * (INDTXMIN + INDTXMOY) 
         + max(0, IRD + PIRD - IRANT ) * 
                           (INDTXMIN * positif(IAVIMBIS-SEUIL_TXMIN)
                          + INDTXMOY * positif(IAVIMO- SEUIL_TXMIN))
       + TAXASSUR
       + IPCAPTAXT
       + IHAUTREVT
       + RASAR * V_CR2 ;
regle 104114:
application : pro , oceans , iliad , batch ;
INTMS = inf( MOISAN / 10000 );
INTAN = (( MOISAN/10000 - INTMS )*10000)  * present(MOISAN) ;
TXINT = (positif(2006-arr(INTAN))*max(0, (INTAN - (V_ANREV+1) )* 12 + INTMS - 6 ) * TXMOISRETARD 
         + positif_ou_nul(V_ANREV-2006)*max(0, (INTAN - (V_ANREV+1) )* 12 + INTMS - 6 ) * TXMOISRETARD2 
         + (1-positif(2006-arr(INTAN)))*(1-positif_ou_nul(V_ANREV-2006))
	   * (((2006 - (V_ANREV+1))*12 - 6) * (TXMOISRETARD * positif(2006 - (V_ANREV+1)) + TXMOISRETARD2 * null(2006-(V_ANREV+1)))
	      + ((INTAN - 2006)*12 + INTMS) * TXMOISRETARD2)
          ) 
            * present(MOISAN);
COPETO = si (CMAJ = 7 ou CMAJ = 10 ou CMAJ = 17 ou CMAJ = 18)
         alors (10)
         sinon
              ( si (CMAJ = 8 ou CMAJ = 11)
                alors (40)
                sinon (80)
                finsi )
         finsi;
regle 1041140:
application : pro , iliad , batch , oceans ;
PTOIR = arr(BTO * COPETO / 100)                
	 + arr(BTO * COPETO /100) * positif(null(CMAJ-10)+null(CMAJ-17))
         + arr((BTOINR) * TXINT / 100) ;
PTOPRS =( arr((PRS-PRSPROV) * COPETO / 100)                
         + arr((PRS-PRSPROV) * TXINT / 100) )* (1 - V_CNR) ;
PTOCSG =( arr((CSG-CSGIM) * COPETO / 100)                
         + arr((CSG-CSGIM) * TXINT / 100) )* (1 - V_CNR) ;

PTORSE1 = (arr(RSE1 * COPETO / 100) + arr(RSE1 * TXINT / 100)) * (1 - V_CNR) ;

PTORSE2 = (arr(RSE2 * COPETO / 100) + arr(RSE2 * TXINT / 100)) * (1 - V_CNR) ;

PTORSE3 = (arr(RSE3 * COPETO / 100) + arr(RSE3 * TXINT / 100)) * (1 - V_CNR) ;

PTORSE4 = (arr(RSE4 * COPETO / 100) + arr(RSE4 * TXINT / 100)) * (1 - V_CNR) ;
PTORDS =( arr((RDSN-CRDSIM) * COPETO / 100)                
         + arr((RDSN-CRDSIM) * TXINT / 100) )* (1 - V_CNR) ;
PTOTAXA= arr(max(0,TAXASSUR- min(TAXASSUR+0,max(0,INE-IRB+AVFISCOPTER))+min(0,IRN - IRANT)) * COPETO / 100)
	 + arr(max(0,TAXASSUR- min(TAXASSUR+0,max(0,INE-IRB+AVFISCOPTER))+min(0,IRN - IRANT)) * COPETO /100) * positif(null(CMAJ-10)+null(CMAJ-17))
         + arr(max(0,TAXASSUR- min(TAXASSUR+0,max(0,INE-IRB+AVFISCOPTER))+min(0,IRN - IRANT)) * TXINT / 100) ;
PTOTPCAP= arr(max(0,IPCAPTAXT- min(IPCAPTAXT+0,max(0,INE-IRB+AVFISCOPTER-TAXASSUR))+min(0,IRN - IRANT+TAXASSUR)) * COPETO / 100)
	 + arr(max(0,IPCAPTAXT- min(IPCAPTAXT+0,max(0,INE-IRB+AVFISCOPTER-TAXASSUR))+min(0,IRN - IRANT+TAXASSUR)) * COPETO /100) * positif(null(CMAJ-10)+null(CMAJ-17))
         + arr(max(0,IPCAPTAXT- min(IPCAPTAXT+0,max(0,INE-IRB+AVFISCOPTER-TAXASSUR))+min(0,IRN - IRANT+TAXASSUR)) * TXINT / 100) ;
PTOTCHR= arr(max(0,IHAUTREVT- min(IHAUTREVT+0,max(0,INE-IRB+AVFISCOPTER-TAXASSUR-IPCAPTAXT))+min(0,IRN - IRANT+TAXASSUR+IPCAPTAXT)) * COPETO / 100)
	 + arr(max(0,IHAUTREVT- min(IHAUTREVT+0,max(0,INE-IRB+AVFISCOPTER-TAXASSUR-IPCAPTAXT))+min(0,IRN - IRANT+TAXASSUR+IPCAPTAXT)) * COPETO /100) * positif(null(CMAJ-10)+null(CMAJ-17))
         + arr(max(0,IHAUTREVT- min(IHAUTREVT+0,max(0,INE-IRB+AVFISCOPTER-TAXASSUR-IPCAPTAXT))+min(0,IRN - IRANT+TAXASSUR+IPCAPTAXT)) * TXINT / 100) ;
PTOGAIN = arr((CGAINSAL - GAINPROV) * COPETO / 100)
	 + arr((CGAINSAL - GAINPROV) * TXINT / 100) ;

PTOCSAL = arr((CSAL - PROVCSAL) * COPETO / 100)                
         + arr((CSAL - PROVCSAL) * TXINT / 100) ;

PTOCDIS = (arr((CDIS-CDISPROV) * COPETO / 100) + arr((CDISC-CDISPROV) * TXINT / 100)) * (1 - V_CNR) ;

regle 1041141:
application : pro , oceans , iliad , batch ;
BTO = max( 0 , IRN - IRANT )
           * positif( IAMD1 + 1 - SEUIL_PERCEP );
BTOINR = max( 0 , IRN - ACODELAISINR - IRANT )
           * positif( IAMD1 + 1 - SEUIL_PERCEP );

regle 10211:
application : pro , bareme , batch , oceans , iliad ;
IRD = IRN * (positif(5 - V_IND_TRAIT)
              +
              (1-positif(5-V_IND_TRAIT)) * (
              positif_ou_nul(IRN+PIR-SEUIL_REC_CP) 
             + (1 - positif(IRN + PIR))
             ));
regle 102112:
application : oceans ;
PIRD = positif_ou_nul(IRN+PIR-SEUIL_REC_CP) * PIR -
       PIR_A * ( positif_ou_nul(PIR_A-SEUIL_REC_CP));
PTAXAD = positif_ou_nul(IRN+PIR+TAXANET+PTAXA-SEUIL_REC_CP) * PTAXA -
       PTAXA_A * ( positif_ou_nul(IRN_A-PIR_A+TAXANET_A+PTAXA_A-SEUIL_REC_CP));
PPCAPD = positif_ou_nul(IRN+PIR+TAXANET+PTAXA+PCAPNET+PPCAP-SEUIL_REC_CP) * PPCAP -
       PPCAP_A * ( positif_ou_nul(IRN_A-PIR_A+TAXANET_A+PTAXA_A+PCAPNET_A+PPCAP_A-SEUIL_REC_CP));
PHAUTREVD = positif_ou_nul(IRN+PIR+TAXANET+PTAXA+PCAPNET+PPCAP+HAUTREVNET+PHAUTREV-SEUIL_REC_CP) * PHAUTREV -
       PHAUTREV_A * ( positif_ou_nul(IRN_A-PIR_A+TAXANET_A+PTAXA_A+PCAPNET_A+PPCAP_A+HAUTREVNET_A+PHAUTREV_A-SEUIL_REC_CP));
PPRSD = PPRS * CSREC ;
PCSGD = PCSG* CSREC  ;
PRDSD = PRDS * CSREC ;
PCSALD = PCSAL * CSREC ;
PCDISD = PCDIS * CSREC ;
PTOTD = PIRD  ;
regle 10213:
application : pro , iliad , batch, oceans;

PRSD = NAPPS - V_PSANT ;

CSGD = NAPCS - V_CSANT ;

RDSD = NAPRD - V_RDANT ;

CSALD = NAPCSAL - V_CSALANT ;

CDISD = NAPCDIS - V_CDISANT ;
CGAIND = NAPGAIN - V_GAINSALANT ;
CRSE1D = NAPRSE1 - V_RSE1ANT ;
CRSE2D = NAPRSE2 - V_RSE2ANT ;
CRSE3D = NAPRSE3 - V_RSE3ANT ;
CRSE4D = NAPRSE4 - V_RSE4ANT ;

regle 10214:
application : pro , oceans , iliad ;
CSNET = (CSGC + PCSG - CICSG - CSGIM) - V_CSANT ;
RDNET = (RDSC + PRDS - CIRDS - CRDSIM) - V_RDANT ;
PRSNET = (PRSC + PPRS - CIPRS - PRSPROV) - V_PSANT ;
GAINNET = (CGAINSALC + PGAIN - GAINPROV) - V_GAINSALANT ;
CSALNET = (CSALC + PCSAL - PROVCSAL) - V_CSALANT ;
CDISNET = (CDISC + PCDIS - CDISPROV) - V_CDISANT ;
RSE1NET = (RSE1 + PRSE1) - V_RSE1ANT ;
RSE2NET = (RSE2 + PRSE2) - V_RSE2ANT ;
RSE3NET = (RSE3 + PRSE3) - V_RSE3ANT ;
RSE4NET = (RSE4 + PRSE4) - V_RSE4ANT ;
regle 102141:
application : batch ;
CSNET = (CSGC + PCSG - CICSG - CSGIM) * (1 - positif(4-V_IND_TRAIT)) ;
RDNET = (RDSC + PRDS - CIRDS - CRDSIM) * (1 - positif(4-V_IND_TRAIT)) ;
PRSNET = (PRSC + PPRS - CIPRS - PRSPROV) * (1 - positif(4-V_IND_TRAIT)) ;
GAINNET = (CGAINSALC + PGAIN - GAINPROV) * (1 - positif(4-V_IND_TRAIT)) ;
CSALNET = (CSALC + PCSAL - PROVCSAL) * (1 - positif(4-V_IND_TRAIT)) ;
CDISNET = (CDISC + PCDIS - CDISPROV) * (1 - positif(4-V_IND_TRAIT)) ;
RSE1NET = (RSE1 + PRSE1) * (1 - positif(4-V_IND_TRAIT)) ;
RSE2NET = (RSE2 + PRSE2) * (1 - positif(4-V_IND_TRAIT)) ;
RSE3NET = (RSE3 + PRSE3) * (1 - positif(4-V_IND_TRAIT)) ;
RSE4NET = (RSE4 + PRSE4) * (1 - positif(4-V_IND_TRAIT)) ;
regle 10201:
application : pro , batch , iliad ;

IARD = IAR - IAR_A ;

regle 1041:
application :  iliad, batch ;
PIRD = PIR * (positif(5 - V_IND_TRAIT)
              +
              (1-positif(5-V_IND_TRAIT)) * (
              positif_ou_nul(IRN+PIR-SEUIL_REC_CP) 
              + 
              (1-positif(IRN+PIR)) 
             ))
    - 
              PIR_A * ( positif_ou_nul(PIR_A-SEUIL_REC_CP) 
               + 
              (1-positif(PIR_A))  
              );
PPRSD = PPRS * CSREC - PPRS_A * CSRECA ;
PCSGD = PCSG* CSREC - PCSG_A * CSRECA ;
PRDSD = PRDS * CSREC - PRDS_A * CSRECA;
PCSALD = PCSAL * CSREC - PCSAL_A * CSRECA;
PTOTD = PIRD  ;
regle 1044:
application : pro ;
PIRD = PIR ;
PPRSD = PPRS ;
PCSGD = PCSG ;
PRDSD = PRDS ;
PCSALD = PCSAL ;
PTOTD = PTOT ;
regle 1041133:
application : pro , oceans , iliad , batch ;
PTP = BTP2 + BTP3A + BPVCESDOM * positif(V_EAG+V_EAD) + BTP3N + BTP3G + BPTP4 + BTP40+BTP18 + BPTP5;
regle 114:
application : pro , oceans , iliad , batch ;
BPRS = (arr (RDRF + RDRV + RDRCM + RDNP + RDNCP + RDPTP + ESFP + R1649) * (1 - positif(present(RE168)+present(TAX1649))) + RE168) * (1-V_CNR);
regle 113:
application : pro , oceans , iliad , batch ;
PRSC = arr( BPRS * T_PREL_SOC /100 ) * (1 - positif(ANNUL2042)) ;
regle 103103 :
application : pro , oceans , iliad , batch ;
PRS = PRSC - CIPRS;
regle 1031 :
application : pro , oceans , iliad , batch ;
CSGC = arr( BCSG * T_CSG / 100) * (1 - positif(ANNUL2042)) ;
regle 103101 :
application : pro , oceans , iliad , batch ;
CSG = CSGC - CICSG ;

RSE1 = arr(BRSE1 * TXTQ/100) * (1 - positif(ANNUL2042)) ;

RSE2 = arr(BRSE2 * TXTV/100) * (1 - positif(ANNUL2042)) ;

RSE3 = arr(BRSE3 * TXTW/100) * (1 - positif(ANNUL2042)) ;

RSE4 = arr(BRSE4 * TXTX/100) * (1 - positif(ANNUL2042)) ;

RSETOT = RSE1 + RSE2 + RSE3 + RSE4;

regle 10311:
application : pro , oceans , iliad , batch ;
RDRF = max(0 , RFCF + RFMIC - MICFR - RFDANT);
RDRV = RVBCSG ;
RDNP = 
   RCSV  
 + RCSC  
 + RCSP
 + max(0,NPLOCNETF)
   ;

RDNCP = (max( BPVRCM + ABDETPLUS + ABIMPPV + PVJEUNENT - DPVRCM - ABDETMOINS - ABIMPMV,0) +
             (BPCOSAC + BPCOSAV + BPVCESDOM + BPVKRI + PVPART + PEA+PVIMPOS + BPV18 + BPCOPT + BPV40+ PVTITRESOC)) * (1 - positif(IPVLOC)) ;

RDPTP = BAF1AV + BAF1AC + BAF1AP
       + BA1AV + BA1AC + BA1AP
       + max(0,MIB1AV - MIBDEV) + max(0,MIB1AC - MIBDEC) + max(0,MIB1AP - MIBDEP)
       + BI1AV + BI1AC + BI1AP
       + max(0,MIBNP1AV - MIBNPDEV) + max(0,MIBNP1AC - MIBNPDEC) + max(0,MIBNP1AP - MIBNPDEP)
       + BI2AV + BI2AC + BI2AP
       + max(0,BNCPRO1AV - BNCPRODEV) + max(0,BNCPRO1AC - BNCPRODEC) + max(0,BNCPRO1AP - BNCPRODEP)
       + BN1AV + BN1AC + BN1AP
       + max(0,BNCNP1AV - BNCNPDEV) + max(0,BNCNP1AC - BNCNPDEC) + max(0,BNCNP1AP - BNCNPDEP)
       + PVINVE + PVINCE + PVINPE
       + PVSOCV + PVSOCC
       ;

BCSG = (arr(RDRF + RDRV + RDRCM + RDNP + RDNCP + RDPTP + ESFP + R1649 + PREREV) * (1 - positif(present(RE168) + present(TAX1649))) 
	 + RE168 
	 + TAX1649) * (1-V_CNR);

BRSE1 = SALECS * (1 - positif(present(RE168) + present(TAX1649))) * (1-V_CNR) ;

BRSE2 = ALLECS * (1 - positif(present(RE168) + present(TAX1649))) * (1-V_CNR) ;

BRSE3 = INDECS * (1 - positif(present(RE168) + present(TAX1649))) * (1-V_CNR) ;

BRSE4 = PENECS * (1 - positif(present(RE168) + present(TAX1649))) * (1-V_CNR) ;

BRSETOT = BRSE1 + BRSE2 + BRSE3 + BRSE4 ;

regle 103111:
application : pro , oceans , iliad , batch ;
BDCSG = min (arr(RDRF+RDRV+RDRCM+RDNP+ESFP) * (1-V_CNR), 
              max( 0, arr (RDRF + RDRV + RDRCM + RDNP
                           - IPPNCS) ) * (1-V_CNR) )  * (1 - positif(present(RE168)+present(TAX1649)));
regle 103112 :
application : pro ;
DCSGD = CSREC * (arr(BDCSG * T_IDCSG / 100) - DCSGIM) ;

IDCSG = min ( CSG - CSGIM , 
        (arr( BDCSG * T_IDCSG / 100 ) - DCSGIM) * positif(NAPCRP)) ;
regle 103114 :
application : pro , batch , iliad , oceans ;
DRSED = RSEREC * (arr(BRSE1 * TXTQDED/100) + arr(BRSE2 * TXTVDED/100) + arr(BRSE3 * TXTWDED/100) + arr(BRSE4 * TXTXDED/100)) ;

IDRSE = arr(BRSE1 * TXTQDED/100) + arr(BRSE2 * TXTVDED/100) + arr(BRSE3 * TXTWDED/100) + arr(BRSE4 * TXTXDED/100) ; 

regle 1031121 :
application : batch ;
IDCSG = si (V_IND_TRAIT = 4) 
        alors ((arr(BDCSG * T_IDCSG / 100)-DCSGIM) * positif(NAPCRP))
        sinon (arr( BDCSG * T_IDCSG / 100)-DCSGIM)
        finsi ;
regle 1031122 :
application : oceans ;
IDCSG = si (CRDEG < SEUIL_REMBCP et NAPCR = 0)
        alors (CSREC * IDCSG_A)
        sinon (CSREC * (arr(BDCSG * T_IDCSG / 100)-DCSGIM + DCSGIM_A))
        finsi ;
regle 1031123 :
application : iliad ;
DCSGD =   positif(CSREC+V_IDANT)
        * (arr(BDCSG * T_IDCSG / 100) - DCSGIM + DCSGIM_A);
IDCSG = si (CRDEG = 0 et NAPCR = 0)
        alors (0)
        sinon (abs(DCSGD - V_IDANT ))
        finsi ;
regle 103113:
application : pro , oceans, iliad , batch ;
RDRCM = max( 0 , 
		TRCMABD + DRTNC + RAVC + RCMNAB + RTCAR + RCMPRIVM
		+ RCMIMPAT
		- RCMSOC
                  -  positif(RCMRDS)
		       * min(RCMRDS ,  
			 RCMABD 
                       + RCMAV 
                       + RCMHAD 
                       + RCMHAB ))
		       ;
regle 10312 :
application : pro , oceans , iliad , batch ;
BRDS = (arr ( RDRF + RDRV + RDRCM + RDNP + RDNCP + RDPTP + ESFP
           + IPECO + R1649 + PREREV) * (1 - positif(present(RE168) + present(TAX1649))) + RE168 + TAX1649) * (1-V_CNR) ;
regle 10313 :
application : pro , oceans , iliad , batch ;
RDSC = arr( BRDS * T_RDS / 100 ) * (1 - positif(ANNUL2042));
regle 103102 :
application : pro , oceans , iliad , batch ;
RDSN = RDSC - CIRDS;
regle 117180:                                                             
application : pro , oceans , iliad , batch ;                               
                                                                          
CSRTF = (RDPTP + PVINVE+PVINCE+PVINPE 
         + somme(i=V,C,P:BN1Ai + BI1Ai                          
         + BI2Ai + BA1Ai )) * (1 - positif(IPVLOC)); 
RDRTF = CSRTF  ;                                                          
PSRTF = CSRTF  ;                                                          
regle 119:
application : pro , iliad , batch , oceans ;
BASSURV3 = max(0,CESSASSV - LIM_ASSUR3);
BASSURV2 = max(0,CESSASSV - BASSURV3 - LIM_ASSUR2);
BASSURV1 = max(0,CESSASSV - BASSURV3 - BASSURV2 - LIM_ASSUR1);
BASSURC3 = max(0,CESSASSC - LIM_ASSUR3);
BASSURC2 = max(0,(CESSASSC -BASSURC3) - LIM_ASSUR2);
BASSURC1 = max(0,(CESSASSC - BASSURC3 -BASSURC2) - LIM_ASSUR1);
BASSURV = CESSASSV;
BASSURC = CESSASSC;
TAXASSURV = arr(BASSURV1 * TX_ASSUR1/100 + BASSURV2 * TX_ASSUR2/100 + BASSURV3 * TX_ASSUR3/100) * (1 - positif(RE168 + TAX1649));
TAXASSURC = arr(BASSURC1 * TX_ASSUR1/100 + BASSURC2 * TX_ASSUR2/100 + BASSURC3 * TX_ASSUR3/100) * (1 - positif(RE168 + TAX1649));
TAXASSUR = TAXASSURV + TAXASSURC;
regle 1120 :
application : pro , oceans , iliad , batch ;
BCSAL = BPVOPTCS * (1-positif(present(TAX1649)+present(RE168)));
CSALC = arr( BCSAL * T_CSAL / 100 ) * (1 - positif(ANNUL2042));
CSAL = CSALC ;

BGAINSAL = GAINSAL * (1-positif(present(TAX1649)+present(RE168)));
CGAINSALC = arr( BGAINSAL * T_GAINSAL / 100 ) * (1 - positif(ANNUL2042));
CGAINSAL = CGAINSALC ;

GAINPROV = max(0 , min(CGAINSAL , CSALPROV)) ;

PROVCSAL = CSALPROV - max(0 , min(CGAINSAL , CSALPROV)) ;
regle 1125 :
application : pro , oceans , iliad , batch ;

BCDIS = (GSALV + GSALC) * (1 - V_CNR)* (1-positif(present(TAX1649)+present(RE168))) ;

CDISC = arr(BCDIS * TCDIS / 100) * (1 - positif(ANNUL2042)) ;

CDIS = CDISC ;
