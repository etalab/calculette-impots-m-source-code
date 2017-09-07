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
application : pro, batch , iliad,oceans ;

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
application : pro , oceans , iliad , batch  ;
AME = AME2;
PIRAME = PIR + AME;
IAVIMBIS = IRB + PIR + AME ;
IAVIMO = (max(0,max(ID11-ADO1,IMI)-RED) + ITP + REI + PIR + AME)
                 * V_CR2;
regle 1012:
application : pro , bareme , oceans , iliad , batch  ;
NAPI = ( IRD + PIRD + AMED - IRANT ) * (1 - INDTXMIN) * (1 - INDTXMOY)
         + min(0, IRD + PIRD + AMED - IRANT ) * (INDTXMIN + INDTXMOY) 
         + max(0, IRD + PIRD + AMED - IRANT ) * 
                           (INDTXMIN * positif(IAVIMBIS-SEUIL_TXMIN)
                          + INDTXMOY * positif(IAVIMO- SEUIL_TXMIN))
       + TAXASSUR
       + RASAR * V_CR2 ;
regle 104114:
application : pro , oceans, iliad , batch  ;
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
PTORDS =( arr((RDSN-CRDSIM) * COPETO / 100)                
         + arr((RDSN-CRDSIM) * TXINT / 100) )* (1 - V_CNR) ;
PTOTAXA= arr(max(0,TAXASSUR+min(0,IRN - IRANT)) * COPETO / 100)
	 + arr(max(0,TAXASSUR+min(0,IRN - IRANT)) * COPETO /100) * positif(null(CMAJ-10)+null(CMAJ-17))
         + arr(max(0,TAXASSUR+min(0,IRN - IRANT)) * TXINT / 100) ;
PTOCSAL =( arr((CSAL - CSALPROV) * COPETO / 100)                
         + arr((CSAL - CSALPROV) * TXINT / 100) ) ;

PTOCDIS = (arr(CDIS * COPETO / 100) + arr(CDISC * TXINT / 100)) * (1 - V_CNR) ;

regle 1041141:
application : pro , oceans , iliad , batch  ;
BTO = max( 0 , IRN - IRANT )
           * positif( IAMD1 + RPPEACO + 1 - SEUIL_PERCEP );
BTOINR = max( 0 , IRN - ACODELAISINR - IRANT )
           * positif( IAMD1 + RPPEACO + 1 - SEUIL_PERCEP );
regle 1021:
application : pro ,  bareme ;
IRD = IRN ;
regle 10210:
application : pro ;
PRSD = PRS ;
CSGD = CSG ;
RDSD = RDSN ;
CSALD = CSAL ;
CDISD = CDIS ;
regle 10211:
application : batch,  oceans, iliad ;
IRD = IRN * (positif(5 - V_IND_TRAIT)
              +
              (1-positif(5-V_IND_TRAIT)) * (
              positif_ou_nul(IRN+PIR+AME-SEUIL_REC_CP) 
             + (1 - positif(IRN + PIR + AME))
             ));
regle 102112:
application : oceans ;
PIRD = positif_ou_nul(IRN+PIR+AME-SEUIL_REC_CP) * PIR -
       PIR_A * ( positif_ou_nul(PIR_A+AME_A-SEUIL_REC_CP));
PTAXAD = positif_ou_nul(IRN+PIR+AME+TAXANET+PTAXA-SEUIL_REC_CP) * PTAXA -
       PTAXA_A * ( positif_ou_nul(PIR_A+AME_A+TAXANET+PTAXA-SEUIL_REC_CP));
PPRSD = PPRS * CSREC ;
PCSGD = PCSG* CSREC  ;
PRDSD = PRDS * CSREC ;
PCSALD = PCSAL * CSREC ;
PCDISD = PCDIS * CSREC ;
PTOTD = PIRD  ;
regle 10212:
application : batch;
PRSD = PRS * CSREC ;
CSGD = CSG * CSREC ;
RDSD = RDSN * CSREC ;
CSALD = CSAL * CSREC ;
CDISD = CDIS * CSREC ;
regle 10213:
application : iliad ;
PRSD = NAPPS - V_PSANT ;
CSGD = NAPCS - V_CSANT ;
RDSD = NAPRD - V_RDANT ;
CSALD = NAPCSAL - V_CSALANT ;
CDISD = NAPCDIS - V_CDISANT ;
regle 102131:
application : oceans ;
PRSD =  PRS * CSREC ;

CSGD =  CSG * CSREC ;
RDSD =  RDSN * CSREC ;
CSALD =  CSAL * CSREC ;
CDISD =  CDIS * CSREC ;
regle 102136:
application : iliad , oceans;
PRSD2 = PRS * CSREC;
CSGD2 = CSG * CSREC;
RDSD2 = RDSN * CSREC;
CSALD2 = CSAL * CSREC;
CDISD2 = CDIS * CSREC;
regle 10214:
application : pro, oceans , iliad ;
CSNET = (CSGC + PCSG - CICSG - CSGIM) - V_CSANT ;
RDNET = (RDSC + PRDS - CIRDS - CRDSIM) - V_RDANT ;
PRSNET = (PRSC + PPRS - CIPRS - PRSPROV) - V_PSANT ;
CSALNET = (CSALC + PCSAL - CSALPROV) - V_CSALANT ;
CDISNET = (CDISC + PCDIS) - V_CDISANT ;
regle 102141:
application : batch ;
CSNET = (CSGC + PCSG - CICSG - CSGIM) * (1 - positif(4-V_IND_TRAIT));
RDNET = (RDSC + PRDS - CIRDS - CRDSIM) * (1 - positif(4-V_IND_TRAIT));
PRSNET = (PRSC + PPRS - CIPRS - PRSPROV) * (1 - positif(4-V_IND_TRAIT));
CSALNET = (CSALC + PCSAL - CSALPROV) * (1 - positif(4-V_IND_TRAIT));
CDISNET = (CDISC + PCDIS) * (1 - positif(4-V_IND_TRAIT)) ;
regle 1020:
application : oceans, batch, iliad ;
AMED = AME - AME_A ;
regle 10201:
application : batch, iliad ;
IARD = IAR - IAR_A ;
regle 10202:
application : pro , bareme ;
AMED = AME  ;
regle 10203:
application : pro ;
IARD = IAR ;
regle 1041:
application :  iliad, batch ;
PIRD = PIR * (positif(5 - V_IND_TRAIT)
              +
              (1-positif(5-V_IND_TRAIT)) * (
              positif_ou_nul(IRN+PIR+AME-SEUIL_REC_CP) 
              + 
              (1-positif(IRN+PIR+AME)) 
             ))
    - 
              PIR_A * ( positif_ou_nul(PIR_A+AME_A-SEUIL_REC_CP) 
               + 
              (1-positif(PIR_A+AME_A))  
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
application : pro , oceans , iliad , batch  ;
PTP = BTP2 + BTP3A + BPVCESDOM * positif(V_EAG+V_EAD) + BTP3N + BTP3G + BPTP4 + BTP40+BTP18;
regle 114:
application : pro , oceans , iliad , batch  ;
BPRS1 = (arr (RDRF + RDRV + RDRCM + RDNP + RDPTP + ESFP + R1649) * (1 - present(RE168)) + RE168) * (1-V_CNR);

BPRS2 = REVSUIS * (1 - present(RE168)) * (1 - V_CNR) ;

BPRS = BPRS1 + BPRS2 ;
regle 113:
application : pro  , oceans , iliad , batch  ;
PRSC1 = arr( BPRS1 * T_PREL_SOC /100 ) * (1 - positif(ANNUL2042)) ;

PRSC2 = arr( BPRS2 * T_PREL_SUI /100 ) * (1 - positif(ANNUL2042)) ;

PRSC = (arr( BPRS1 * T_PREL_SOC /100 ) + arr( BPRS2 * T_PREL_SUI /100 )) 
        * (1 - positif(ANNUL2042)) ;
regle 103103 :
application : pro , oceans , iliad , batch  ;
PRS = PRSC - CIPRS;
regle 1031 :
application : pro , oceans , iliad , batch  ;

CSGC1 = arr( BCSG1 * T_CSG / 100) * (1 - positif(ANNUL2042)) ;

CSGC2 = arr( BCSG2 * T_CSG / 100) * (1 - positif(ANNUL2042)) ;

CSGC = (arr( BCSG1 * T_CSG / 100) + arr( BCSG2 * T_CSG / 100)) * (1 - positif(ANNUL2042)) ;

regle 103101 :
application : pro , oceans , iliad , batch  ;
CSG = CSGC - CICSG;
regle 10311:
application : pro , oceans , iliad , batch  ;
RDRF = max(0 , RFCF + RFMIC - MICFR - RFDANT);
RDRV = RVBCSG ;
RDNP = 
   RCSV  
 + RCSC  
 + RCSP
   ;

RDNCP = (BPCOSAC + BPCOSAV) * (1 - positif(IPVLOC)) ;

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
       + CESSASSV + CESSASSC
       + PVSOCV + PVSOCC
       + PVSOCG
       ;

BCSG1 = (arr(RDRF + RDRV + RDRCM + RDNP + RDPTP + ESFP + R1649 + PREREV) * (1 - positif(present(RE168) + present(TAX1649))) + RE168 + TAX1649) * (1-V_CNR);

BCSG2 = REVSUIS * (1 - positif(present(RE168) + present(TAX1649))) * (1-V_CNR) ;

BCSG = BCSG1 + BCSG2 ;
regle 103111:
application : pro , oceans , iliad , batch ;
BDCSG = min (arr(RDRF+RDRV+RDRCM+RDNP+RDPTP+REVSUIS+ESFP) * (1-V_CNR), 
              max( 0, arr (RDRF + RDRV + RDRCM + RDNP + REVSUIS
                           - IPPNCS) ) * (1-V_CNR) )  * (1 - positif(present(RE168)+present(TAX1649)));
regle 103112 :
application : pro ;
DCSGD = CSREC * (arr(BDCSG * T_IDCSG / 100) - DCSGIM);
IDCSG = min ( CSG - CSGIM , 
        (arr( BDCSG * T_IDCSG / 100 ) - DCSGIM) * positif(NAPCR) );
regle 1031121 :
application : batch ;
IDCSG = si (V_IND_TRAIT = 4) 
        alors ((arr(BDCSG * T_IDCSG / 100)-DCSGIM) * positif(NAPCR))
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
		- REVSUIS
                  -  positif(RCMRDS)
		       * min(RCMRDS ,  
			 RCMABD 
                       + RCMAV 
                       + RCMHAD 
                       + RCMHAB ))
		       ;
regle 10312 :
application : pro , oceans , iliad , batch  ;
BRDS1 = (arr ( RDRF + RDRV + RDRCM + RDNP + RDPTP + ESFP
           + IPECO + R1649 + PREREV) * (1 - positif(present(RE168) + present(TAX1649))) + RE168 + TAX1649) * (1-V_CNR) ;

BRDS2 = REVSUIS * (1 - positif(present(RE168)+present(TAX1649))) * (1-V_CNR) ;

BRDS = BRDS1 + BRDS2 ;
regle 10313 :
application : pro  , oceans , iliad , batch  ;
RDSC1 = arr( BRDS1 * T_RDS / 100 ) * (1 - positif(ANNUL2042));

RDSC2 = arr( BRDS2 * T_RDS / 100 ) * (1 - positif(ANNUL2042));

RDSC = (arr( BRDS1 * T_RDS / 100 ) + arr( BRDS2 * T_RDS / 100 )) * (1 - positif(ANNUL2042));
regle 103102 :
application : pro , oceans , iliad , batch  ;
RDSN = RDSC - CIRDS;
regle 117180:                                                             
application : pro  , oceans, iliad , batch;                               
                                                                          
CSRTF = (RDPTP + PVINVE+PVINCE+PVINPE 
         + somme(i=V,C,P:BN1Ai + BI1Ai                          
         + BI2Ai + BA1Ai )) * (1 - positif(IPVLOC)); 
RDRTF = CSRTF  ;                                                          
PSRTF = CSRTF  ;                                                          
regle 119:
application : pro, iliad, batch, oceans;
BASSURV3 = max(0,CESSASSV - LIM_ASSUR3);
BASSURV2 = max(0,CESSASSV - BASSURV3 - LIM_ASSUR2);
BASSURV1 = max(0,CESSASSV - BASSURV3 - BASSURV2 - LIM_ASSUR1);
BASSURC3 = max(0,CESSASSC - LIM_ASSUR3);
BASSURC2 = max(0,(CESSASSC -BASSURC3) - LIM_ASSUR2);
BASSURC1 = max(0,(CESSASSC - BASSURC3 -BASSURC2) - LIM_ASSUR1);
BASSURV = CESSASSV;
BASSURC = CESSASSC;
TAXASSURV = arr(BASSURV1 * TX_ASSUR1/100 + BASSURV2 * TX_ASSUR2/100 + BASSURV3 * TX_ASSUR3/100);
TAXASSURC = arr(BASSURC1 * TX_ASSUR1/100 + BASSURC2 * TX_ASSUR2/100 + BASSURC3 * TX_ASSUR3/100);
TAXASSUR = TAXASSURV + TAXASSURC;
regle 1120 :
application : pro , oceans , iliad , batch ;
BCSAL = BPVOPTCS ;
CSALC = arr( BCSAL * T_CSAL / 100 ) * (1 - positif(ANNUL2042));
regle 1121 :
application : pro , oceans , iliad , batch ;
CSAL = CSALC ;
regle 1125 :
application : pro , oceans , iliad , batch ;

BCDIS = (GSALV + GSALC) * (1 - V_CNR) ;

CDISC = arr(BCDIS * TCDIS / 100) * (1 - positif(ANNUL2042)) ;

CDIS = CDISC ;
