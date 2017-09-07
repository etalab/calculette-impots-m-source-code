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
regle corrective 10801:
application : oceans, iliad;

TXINR = max(0,(NBMOIS * TXMOISRETARD2) + max(0,(NBMOIS2 * TXMOISRETARD2)));

TXINRRED = max(0,(NBMOIS * TXMOISRETARD2*TXMOISRED*2) + max(0,(NBMOIS2 * TXMOISRETARD2 * TXMOISRED * 2)));

regle corrective 1081:
application : oceans, iliad ;
IND_PASSAGE = positif(FLAG_DEFAUT + FLAG_RETARD) + IND_PASSAGE_A;
IND_PASSR9901 = 1 + IND_PASSR9901_A;
IRNIN_PA = IRNIN_INR * null(1 - IND_PASSAGE) + IRNIN_PA_A;
TXINR_PA = TXINR * null(1 - IND_PASSAGE) + TXINR_PA_A;
INRIR_RETDEF = (1 - IND_RJLJ) * FLAG_DEFAUT * ( 
             arr(IRNIN_INR * TXINR / 100) * positif(IRNIN_INR) * null(1 - IND_PASSAGE) 
             + INRIR_RETDEF_A* (1-positif(ACODELAISINR))
		  + arr(max(0,IRNIN_PA - ACODELAISINR) * TXINR_PA/100) * positif(IND_PASSAGE -1)* positif(ACODELAISINR)
                                );
INR_IR_TARDIF = ((arr(IRNIN_INR * TXINR/100) * positif(IRNIN_INR) * null(1-IND_PASSAGE)+ INR_IR_TARDIF_A*(1-positif(ACODELAISINR)))
		  + arr(max(0,IRNIN_PA - ACODELAISINR) * TXINR_PA/100) * positif(IND_PASSAGE -1)* positif(ACODELAISINR)) * FLAG_RETARD * (1-IND_RJLJ);
CSG_PA = CSG * null(1 - IND_PASSAGE) + CSG_PA_A;
INRCSG_RETDEF = (1 - IND_RJLJ) * (
                arr((CSG-CSGIM) * TXINR / 100) * FLAG_DEFAUT * null(IND_PASSAGE - 1)
                                )
             + INRCSG_RETDEF_A;
INR_CSG_TARDIF = (arr((CSG-CSGIM) * TXINR/100) * FLAG_RETARD * null(1-IND_PASSAGE)+INR_CSG_TARDIF_A) * (1-IND_RJLJ);
PRS_PA = PRS * null(1 - IND_PASSAGE) + PRS_PA_A;
INRPRS_RETDEF = (1 - IND_RJLJ) * (
             arr((PRS-PRSPROV) * TXINR / 100) * FLAG_DEFAUT * null(IND_PASSAGE - 1)
                                )
             + INRPRS_RETDEF_A;
INR_PS_TARDIF = (arr((PRS-PRSPROV) * TXINR/100) * FLAG_RETARD * null(1-IND_PASSAGE)+INR_PS_TARDIF_A) * (1-IND_RJLJ);
CRDS_PA = RDSN * null(1 - IND_PASSAGE) + CRDS_PA_A;
INRCRDS_RETDEF = (1 - IND_RJLJ) * (
             arr((RDSN-CRDSIM) * TXINR / 100) * FLAG_DEFAUT * null(IND_PASSAGE - 1)
                                )
             + INRCRDS_RETDEF_A;
INR_CRDS_TARDIF = (arr((RDSN-CRDSIM) * TXINR/100) * FLAG_RETARD * null(1-IND_PASSAGE)+INR_CRDS_TARDIF_A) * (1-IND_RJLJ);
TAXA_PA = TAXABASE * null(1 - IND_PASSAGE) + TAXA_PA_A;
INRTAXA_RETDEF = (1 - IND_RJLJ) * (
               arr(TAXABASE * TXINR / 100) * FLAG_DEFAUT * null(IND_PASSAGE - 1)
                                )
             + INRTAXA_RETDEF_A;
INR_TAXAGA_TARDIF = (arr(TAXABASE * TXINR/100) * FLAG_RETARD * null(1-IND_PASSAGE)+INR_TAXA_TARDIF_A) * (1-IND_RJLJ);
CSAL_PA = CSALBASE * null(1 - IND_PASSAGE) + CSAL_PA_A;
INRCSAL_RETDEF = (1 - IND_RJLJ) * (
               arr(CSALBASE * TXINR / 100) * FLAG_DEFAUT * null(IND_PASSAGE - 1)
                                )
             + INRCSAL_RETDEF_A;
INR_CSAL_TARDIF = (arr(CSALBASE * TXINR/100) * FLAG_RETARD * null(1-IND_PASSAGE)+INR_CSAL_TARDIF_A) * (1-IND_RJLJ);
CDIS_PA = CDISBASE * null(1 - IND_PASSAGE) + CDIS_PA_A;
INRCDIS_RETDEF = (1 - IND_RJLJ) * (
               arr(CDISBASE * TXINR / 100) * FLAG_DEFAUT * null(IND_PASSAGE - 1)
                                )
             + INRCDIS_RETDEF_A;
INR_CDIS_TARDIF = (arr(CDISBASE * TXINR/100) * FLAG_RETARD * null(1-IND_PASSAGE)+INR_CDIS_TARDIF_A) * (1-IND_RJLJ);
regle corrective 10811:
application : oceans, iliad ;
IRNIN_TLDEC_1=IRNIN_INR;
CSG_TLDEC_1=CSG;
PRS_TLDEC_1=PRS;
RDS_TLDEC_1=RDSN;
TAXA_TLDEC_1=TAXASSUR;
CSAL_TLDEC_1=CSAL;
CDIS_TLDEC_1=CDIS;
INRIR_NTL = (1 - IND_RJLJ) * (1-FLAG_NINR) * (
			 null(2-FLAG_INR) * (positif(IRNIN_INR - IRNIN_R99R)
                       * (
            (positif(IRNIN_INR - IRNIN_REF+0)
            * arr((IRNIN_INR - IRNIN_REF) * (TXINR / 100))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(IRNIN_INR - IRNIN_REF+0)
            * positif(IRNIN_INR-IRNIN_RECT)
            * arr((IRNIN_INR - IRNIN_REF) * (TXINR / 100))
            * positif(FLAG_DEFAUT+FLAG_RETARD) * positif(IND_PASSAGE - 1))
                             )
            + INRIR_RETDEF * null(IND_PASSAGE - 1)
                            )
            + null(3 - FLAG_INR) * (positif(IRNIN_INR - IRNIN_REF)
                       * (
            (arr((min(IRNIN_INR,IRNIN_TLDEC_1) - IRNIN_REF) * (TXINR / 100))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(IRNIN_INR-IRNIN_RECT)
            * arr((min(IRNIN_INR,IRNIN_TLDEC_1) - IRNIN_REF) * (TXINR / 100))
            * positif(FLAG_DEFAUT+FLAG_RETARD) * positif(IND_PASSAGE - 1))
                             )
            + INRIR_RETDEF * null(IND_PASSAGE - 1)
                         )   )
             ;
INRCSG_NTL = (1 - IND_RJLJ) * (1-FLAG_NINR) * (
		      null(2-FLAG_INR) * (positif(CSG-CSG_R99R) * (
            (positif(CSG * positif(CSG+PRS+RDSN-SEUIL_REC_CP2) - CSG_REF+0) 
            * arr((CSG - CSG_REF-CSGIM) * (TXINR / 100))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(CSG* positif(CSG+PRS+RDSN-SEUIL_REC_CP2)  - CSG_REF+0)
            * arr((CSG - CSG_REF-CSGIM) * (TXINR / 100))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                              )
            + INRCSG_RETDEF * null(IND_PASSAGE - 1)
                            )
            + null(3 - FLAG_INR) * (positif(CSG* positif(CSG+PRS+RDSN-SEUIL_REC_CP2) - CSG_REF)
                       * (
            (arr((min(CSG* positif(CSG+PRS+RDSN-SEUIL_REC_CP2),CSG_TLDEC_1) - CSG_REF) * (TXINR / 100))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(CSG* positif(CSG+PRS+RDSN-SEUIL_REC_CP2)-CSG_RECT)
            * arr((min(CSG* positif(CSG+PRS+RDSN-SEUIL_REC_CP2),CSG_TLDEC_1) - CSG_REF) * (TXINR / 100))
            * positif(FLAG_DEFAUT+FLAG_RETARD) * positif(IND_PASSAGE - 1))
                             )
            + INRCSG_RETDEF * null(IND_PASSAGE - 1)
                         )   )
             ;
INRPRS_NTL = (1 - IND_RJLJ) * (1-FLAG_NINR) * (
		      null(2-FLAG_INR) * (positif(PRS-PRS_R99R) * (
            (positif(PRS * positif(CSG+PRS+RDSN-SEUIL_REC_CP2) - PRS_REF+0)
            * arr((PRS - PRS_REF-PRSPROV) * (TXINR / 100))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(PRS* positif(CSG+PRS+RDSN-SEUIL_REC_CP2)  - PRS_REF+0) * null(2 - FLAG_INR)
            * arr((PRS - PRS_REF-PRSPROV) * (TXINR / 100))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                              )
            + INRPRS_RETDEF * null(IND_PASSAGE - 1)
                            )
            + null(3 - FLAG_INR) * (positif(PRS* positif(CSG+PRS+RDSN-SEUIL_REC_CP2) - PRS_REF)
                       * (
            (arr((min(PRS* positif(CSG+PRS+RDSN-SEUIL_REC_CP2),PRS_TLDEC_1) - PRS_REF) * (TXINR / 100))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(PRS* positif(CSG+PRS+RDSN-SEUIL_REC_CP2)-PS_RECT)
            * arr((min(PRS* positif(CSG+PRS+RDSN-SEUIL_REC_CP2),PRS_TLDEC_1) - PRS_REF) * (TXINR / 100))
            * positif(FLAG_DEFAUT+FLAG_RETARD) * positif(IND_PASSAGE - 1))
                             )
            + INRPRS_RETDEF * null(IND_PASSAGE - 1)
                         )   )
             ;

INRCRDS_NTL = (1 - IND_RJLJ) * (1-FLAG_NINR) * (
		      null(2-FLAG_INR) * (positif(RDSN-RDS_R99R) * (
            (positif(RDSN * positif(CSG+PRS+RDSN-SEUIL_REC_CP2) - RDS_REF+0)
            * arr((RDSN - RDS_REF-CRDSIM) * (TXINR / 100))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(RDSN* positif(CSG+PRS+RDSN-SEUIL_REC_CP2)  - RDS_REF+0)
            * arr((RDSN - RDS_REF-CRDSIM) * (TXINR / 100))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                              )
            + INRCRDS_RETDEF * null(IND_PASSAGE - 1)
                            )
            + null(3 - FLAG_INR) * (positif(RDSN* positif(CSG+PRS+RDSN-SEUIL_REC_CP2) - RDS_REF)
                       * (
            (arr((min(RDSN* positif(CSG+PRS+RDSN-SEUIL_REC_CP2),RDS_TLDEC_1) - RDS_REF) * (TXINR / 100))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(RDSN* positif(CSG+PRS+RDSN-SEUIL_REC_CP2)-CRDS_RECT)
            * arr((min(RDSN* positif(CSG+PRS+RDSN-SEUIL_REC_CP2),RDS_TLDEC_1) - RDS_REF) * (TXINR / 100))
            * positif(FLAG_DEFAUT+FLAG_RETARD) * positif(IND_PASSAGE - 1))
                             )
            + INRCRDS_RETDEF * null(IND_PASSAGE - 1)
                         )   )
             ;
INRTAXA_NTL = (1 - IND_RJLJ)  * (1-FLAG_NINR)* 
	           ( 
		   null(2-FLAG_INR) * (positif(TAXABASE - TAXA_R99R) 
		 * (
             (positif(TAXABASE - TAXA_REF+0) * null(2 - FLAG_INR)
            * arr((TAXABASE - TAXA_REF) * (TXINR / 100))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(TAXABASE - TAXA_REF+0) * null(2 - FLAG_INR)
            * arr((TAXABASE - TAXA_REF) * (TXINR / 100))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
            + INRTAXA_RETDEF * null(IND_PASSAGE - 1)
                            )
	    +        null(3-FLAG_INR) * (positif(TAXABASE - TAXA_R99R) 
		 * (
             (positif(TAXABASE - TAXA_REF+0) * null(2 - FLAG_INR)
            * arr((min(TAXABASE,TAXA_TLDEC) - TAXA_REF) * (TXINR / 100))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(TAXABASE - TAXA_REF+0) * null(2 - FLAG_INR)
            * arr((min(TAXABASE,TAXA_TLDEC) - TAXA_REF) * (TXINR / 100))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                             )
            + INRTAXA_RETDEF * null(IND_PASSAGE - 1)
                            )
			    )
             ;
INRCSAL_NTL = (1 - IND_RJLJ) * (1-FLAG_NINR) * (
		      null(2-FLAG_INR) * (positif(CSAL-CSAL_R99R) * (
            (positif(CSAL - CSAL_REF-CSALPROV+0)
            * arr((CSAL - CSAL_REF-CSALPROV) * (TXINR / 100))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(CSAL - CSAL_REF-CSALPROV+0)
            * arr((CSAL - CSAL_REF-CSALPROV) * (TXINR / 100))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                              )
            + INRCSAL_RETDEF * null(IND_PASSAGE - 1)
                            )
            + null(3 - FLAG_INR) * (positif(CSAL - CSAL_REF)
                       * (
            (arr((min(CSAL,CSAL_TLDEC_1) - CSAL_REF) * (TXINR / 100))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(CSAL-CSAL_RECT)
            * arr((min(CSAL,CSAL_TLDEC_1) - CSAL_REF) * (TXINR / 100))
            * positif(FLAG_DEFAUT+FLAG_RETARD) * positif(IND_PASSAGE - 1))
                             )
            + INRCSAL_RETDEF * null(IND_PASSAGE - 1)
                         )   )
             ;
INRCDIS_NTL = (1 - IND_RJLJ) * (1-FLAG_NINR) * (
		      null(2-FLAG_INR) * (positif(CDIS-CDIS_R99R) * (
            (positif(CDIS - CDIS_REF+0)
            * arr((CDIS - CDIS_REF) * (TXINR / 100))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(CDIS - CDIS_REF-CSALPROV+0)
            * arr((CDIS - CDIS_REF) * (TXINR / 100))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                              )
            + INRCDIS_RETDEF * null(IND_PASSAGE - 1)
                            )
            + null(3 - FLAG_INR) * (positif(CDIS - CDIS_REF)
                       * (
            (arr((min(CDIS,CDIS_TLDEC_1) - CDIS_REF) * (TXINR / 100))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(CDIS-CDIS_RECT)
            * arr((min(CDIS,CDIS_TLDEC_1) - CDIS_REF) * (TXINR / 100))
            * positif(FLAG_DEFAUT+FLAG_RETARD) * positif(IND_PASSAGE - 1))
                             )
            + INRCDIS_RETDEF * null(IND_PASSAGE - 1)
                         )   )
             ;
regle corrective 108111:
application : oceans, iliad ;
INRIR_NTL_1 = (1 - IND_RJLJ) * (1-FLAG_NINR) * (
			 null(2-FLAG_INR) * positif(IRNIN_INR - IRNIN_R99R)
                       * (
            (positif(IRNIN_INR - max(IRNIN_REF+0,IRNIN_NTLDEC)) 
            * arr((IRNIN_INR - max(IRNIN_REF,IRNIN_NTLDEC)) * (TXINRRED / 200))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(IRNIN_INR - max(IRNIN_NTLDEC,IRNIN_REF+0))
            * positif(IRNIN_INR-max(IRNIN_NTLDEC,IRNIN_RECT))
            * arr((IRNIN_INR - max(IRNIN_NTLDEC,IRNIN_REF)) * (TXINRRED / 200))
            * positif(FLAG_DEFAUT+FLAG_RETARD) * positif(IND_PASSAGE - 1))
                             )
                   +  null(3-FLAG_INR) * positif(IRNIN_INR - IRNIN_REF)
                       * (
            (positif(IRNIN_INR - max(IRNIN_REF+0,IRNIN_NTLDEC)) 
            * arr((min(IRNIN_INR,IRNIN_TLDEC_1) - max(IRNIN_REF,IRNIN_NTLDEC)) * (TXINRRED / 200))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(IRNIN_INR - max(IRNIN_NTLDEC,IRNIN_REF+0))
            * positif(IRNIN_INR-max(IRNIN_NTLDEC,IRNIN_RECT))
            * arr((min(IRNIN_INR,IRNIN_TLDEC_1) - max(IRNIN_NTLDEC,IRNIN_REF)) * (TXINRRED / 200))
            * positif(FLAG_DEFAUT+FLAG_RETARD) * positif(IND_PASSAGE - 1))
                             )
                                                )
                                               ;
INRCSG_NTL_1 = (1 - IND_RJLJ) * (1-FLAG_NINR) * (
			 null(2 - FLAG_INR) * positif(CSG-CSG_R99R) 
			* (
            (positif(CSG * positif(CSG+PRS+RDSN-SEUIL_REC_CP2) - max(CSG_NTLDEC,CSG_REF+0))
            * arr((CSG - max(CSG_NTLDEC,CSG_REF-CSGIM)) * (TXINRRED / 200))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(CSG* positif(CSG+PRS+RDSN-SEUIL_REC_CP2)  - max(CSG_NTLDEC,CSG_REF+0))
            * arr((CSG - max(CSG_NTLDEC,CSG_REF)-CSGIM) * (TXINRRED / 200))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                              )
                      + null(3 - FLAG_INR) * positif(CSG-CSG_REF) 
			* (
            (positif(CSG * positif(CSG+PRS+RDSN-SEUIL_REC_CP2) - max(CSG_NTLDEC,CSG_REF+0))
            * arr((min(CSG,CSG_TLDEC_1) - max(CSG_NTLDEC,CSG_REF-CSGIM)) * (TXINRRED / 200))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(CSG* positif(CSG+PRS+RDSN-SEUIL_REC_CP2)  - max(CSG_NTLDEC,CSG_REF+0))
            * arr((min(CSG,CSG_TLDEC_1) - max(CSG_NTLDEC,CSG_REF)-CSGIM) * (TXINRRED / 200))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                              )
                            )
             ;
INRPRS_NTL_1 = (1 - IND_RJLJ) * (1-FLAG_NINR) * (
			   null(2 - FLAG_INR) * positif(PRS-PRS_R99R) 
			   * (
            (positif(PRS* positif(CSG+PRS+RDSN-SEUIL_REC_CP2)  - max(PRS_NTLDEC,PRS_REF+0)) 
            * arr((PRS  - max(PRS_NTLDEC,PRS_REF-PRSPROV)) * (TXINRRED / 200))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(PRS * positif(CSG+PRS+RDSN-SEUIL_REC_CP2) - max(PRS_NTLDEC,PRS_REF+0))
            * arr((PRS - max(PRS_NTLDEC,PRS_REF)-PRSPROV) * (TXINRRED / 200))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                        )
                        + null(3 - FLAG_INR) * positif(PRS-PRS_REF) 
			   * (
            (positif(PRS* positif(CSG+PRS+RDSN-SEUIL_REC_CP2)  - max(PRS_NTLDEC,PRS_REF+0)) 
            * arr((min(PRS,PRS_TLDEC_1)  - max(PRS_NTLDEC,PRS_REF-PRSPROV)) * (TXINRRED / 200))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(PRS * positif(CSG+PRS+RDSN-SEUIL_REC_CP2) - max(PRS_NTLDEC,PRS_REF+0))
            * arr((min(PRS,PRS_TLDEC_1) - max(PRS_NTLDEC,PRS_REF)-PRSPROV) * (TXINRRED / 200))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                        )
                            )
             ;
INRCRDS_NTL_1 = (1 - IND_RJLJ) * (1-FLAG_NINR) * (
		       null(2 - FLAG_INR) * positif(RDSN - RDS_R99R) 
		      * (
            (positif(RDSN * positif(CSG+PRS+RDSN-SEUIL_REC_CP2) - max(CRDS_NTLDEC,RDS_REF+0))
            * arr((RDSN - max(CRDS_NTLDEC,RDS_REF)-CRDSIM) * (TXINRRED / 200))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(RDSN * positif(CSG+PRS+RDSN-SEUIL_REC_CP2) - max(CRDS_NTLDEC,RDS_REF+0))
            * arr((RDSN -max(CRDS_NTLDEC,RDS_REF)-CRDSIM) * (TXINRRED / 200))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                         )
                    +  null(3 - FLAG_INR) * positif(RDSN - RDS_REF) 
		      * (
            (positif(RDSN * positif(CSG+PRS+RDSN-SEUIL_REC_CP2) - max(CRDS_NTLDEC,RDS_REF+0))
            * arr((min(RDSN,RDS_TLDEC_1) - max(CRDS_NTLDEC,RDS_REF)-CRDSIM) * (TXINRRED / 200))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(RDSN * positif(CSG+PRS+RDSN-SEUIL_REC_CP2) - max(CRDS_NTLDEC,RDS_REF+0))
            * arr((min(RDSN,RDS_TLDEC_1) -max(CRDS_NTLDEC,RDS_REF)-CRDSIM) * (TXINRRED / 200))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                         )
                            )
             ;
INRTAXA_NTL_1 = (1 - IND_RJLJ) * (1-FLAG_NINR) * (
		     null(2 - FLAG_INR) * positif(TAXABASE - TAXA_R99R) 
		     * (
             (positif(TAXABASE - max(TAXA_NTLDEC,TAXA_REF+0))
            * arr((TAXABASE - max(TAXA_NTLDEC,TAXA_REF)) * (TXINRRED / 200))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(TAXABASE - max(TAXA_NTLDEC,TAXA_REF+0))
            * arr((TAXABASE - max(TAXA_NTLDEC,TAXA_REF)) * (TXINRRED / 200))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
		     + null(3 - FLAG_INR) * positif(TAXABASE - TAXA_REF) 
		     * (
             (positif(TAXABASE - max(TAXA_NTLDEC,TAXA_REF+0))
            * arr((min(TAXABASE,TAXA_TLDEC_1) - max(TAXA_NTLDEC,TAXA_REF)) * (TXINRRED / 200))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(TAXABASE - max(TAXA_NTLDEC,TAXA_REF+0))
            * arr((min(TAXABASE,TAXA_TLDEC_1) - max(TAXA_NTLDEC,TAXA_REF)) * (TXINRRED / 200))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
                            )
	     ; 
INRCSAL_NTL_1 = (1 - IND_RJLJ) * (1-FLAG_NINR) * (
		       null(2 - FLAG_INR) * positif(CSALBASE - CSAL_R99R) 
		       * (
             (positif(CSALBASE - max(CSAL_NTLDEC,CSAL_REF+0))
            * arr((CSALBASE - max(CSAL_NTLDEC,CSAL_REF)-CSALPROV) * (TXINRRED / 200))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(CSALBASE - max(CSAL_NTLDEC,CSAL_REF+0)) 
            * arr((CSALBASE - max(CSAL_NTLDEC,CSAL_REF)-CSALPROV) * (TXINRRED / 200))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
		       + null(3 - FLAG_INR) * positif(CSALBASE - CSAL_REF) 
		       * (
             (positif(CSALBASE - max(CSAL_NTLDEC,CSAL_REF+0)-CSALPROV)
            * arr((min(CSALBASE,CSAL_TLDEC_1) - max(CSAL_NTLDEC,CSAL_REF)-CSALPROV) * (TXINRRED / 200))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(CSALBASE - max(CSAL_NTLDEC,CSAL_REF-CSALPROV+0))
            * arr((min(CSALBASE,CSAL_TLDEC_1) - max(CSAL_NTLDEC,CSAL_REF)-CSALPROV) * (TXINRRED / 200))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
                            )
	     ; 
INRCDIS_NTL_1 = (1 - IND_RJLJ) * (1-FLAG_NINR) * (
		       null(2 - FLAG_INR) * positif(CDISBASE - CDIS_R99R) 
		       * (
             (positif(CDISBASE - max(CDIS_NTLDEC,CDIS_REF+0))
            * arr((CDISBASE - max(CDIS_NTLDEC,CDIS_REF)) * (TXINRRED / 200))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(CDISBASE - max(CDIS_NTLDEC,CDIS_REF+0)) 
            * arr((CDISBASE - max(CDIS_NTLDEC,CDIS_REF)) * (TXINRRED / 200))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
		       + null(3 - FLAG_INR) * positif(CDISBASE - CDIS_REF) 
		       * (
             (positif(CDISBASE - max(CDIS_NTLDEC,CDIS_REF+0))
            * arr((min(CDISBASE,CDIS_TLDEC_1) - max(CDIS_NTLDEC,CDIS_REF)) * (TXINRRED / 200))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(CDISBASE - max(CDIS_NTLDEC,CDIS_REF+0))
            * arr((min(CDISBASE,CDIS_TLDEC_1) - max(CDIS_NTLDEC,CDIS_REF)) * (TXINRRED / 200))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
                            )
	     ; 
regle corrective 1082:
application : oceans, iliad ;
INRIR_TLACQ = positif(IRNIN_INR - max(max(IRNIN_REF,IRNIN_RECT),IRNIN_NTLDEC_1+0)) * null(3-FLAG_INR)
            * arr((IRNIN_INR - max(max(IRNIN_REF,IRNIN_RECT),IRNIN_NTLDEC_1)) * (TXINR / 100));
INRIR_TLA = (1 - IND_RJLJ) * (1-FLAG_NINR) * INRIR_TLACQ;
INRCSG_TLACQ = positif(CSG - max(CSG_REF,CSG_NTLDEC_1+0)) * null(3 - FLAG_INR)
            * arr((CSG - max(CSG_REF,CSG_NTLDEC_1)-CSGIM*(1-positif(CSG_A))) * (TXINR / 100));
INRCSG_TLA = (1 - IND_RJLJ) * (1-FLAG_NINR) * INRCSG_TLACQ;
INRPRS_TLACQ = positif(PRS - max(PRS_REF,PRS_NTLDEC_1+0)) * null(3 - FLAG_INR)
            * arr((PRS - max(PRS_REF,PRS_NTLDEC_1)-PRSPROV*(1-positif(PRS_A))) * (TXINR / 100))  ;
INRPRS_TLA = (1 - IND_RJLJ) * (1-FLAG_NINR) * INRPRS_TLACQ;
INRCRDS_TLACQ = positif(RDSN - max(RDS_REF,CRDS_NTLDEC_1+0)) * null(3 - FLAG_INR)
            * arr((RDSN - max(RDS_REF,CRDS_NTLDEC_1)-CRDSIM*(1-positif(RDS_A))) * (TXINR / 100))  ;
INRCRDS_TLA = (1 - IND_RJLJ) * (1-FLAG_NINR) * INRCRDS_TLACQ;
INRTAXA_TLACQ = positif(TAXABASE - max(TAXA_REF,TAXA_NTLDEC_1+0))*null(3- FLAG_INR)
            * arr((TAXABASE - max(TAXA_REF,TAXA_NTLDEC_1)) * (TXINR / 100))  ;
INRTAXA_TLA = (1 - IND_RJLJ) * (1-FLAG_NINR) * INRTAXA_TLACQ;
INRCSAL_TLACQ = positif(CSALBASE - max(CSAL_REF,CSAL_NTLDEC_1+0))*null(3- FLAG_INR)
            * arr((CSALBASE - max(CSAL_REF,CSAL_NTLDEC_1)-CSALPROV*(1-positif(CSAL_A))) * (TXINR / 100))  ;
INRCSAL_TLA = (1 - IND_RJLJ) * (1-FLAG_NINR) * INRCSAL_TLACQ;
INRCDIS_TLACQ = positif(CDISBASE - max(CDIS_REF,CDIS_NTLDEC_1+0))*null(3- FLAG_INR)
            * arr((CDISBASE - max(CDIS_REF,CDIS_NTLDEC_1)) * (TXINR / 100))  ;
INRCDIS_TLA = (1 - IND_RJLJ) * (1-FLAG_NINR) * INRCDIS_TLACQ;
regle corrective 10821:
application : oceans, iliad ;
INRIR_TLACQ_1 = positif(IRNIN_INR - max(max(IRNIN_REF,IRNIN_RECT),IRNIN_TLDEC+0)) * null(3-FLAG_INR)
            * arr((IRNIN_INR - max(max(IRNIN_REF,IRNIN_RECT),IRNIN_TLDEC)) * (TXINRRED / 200)) * (1-positif(FLAG_C22+FLAG_C02))
	    +
               positif(IRNIN_INR - IRNIN_TLDEC) * null(3-FLAG_INR)
            * arr((IRNIN_INR - IRNIN_TLDEC) * (TXINRRED / 200)) * positif(FLAG_C22+FLAG_C02);
INRIR_TLA_1 = (1 - IND_RJLJ) * (1-FLAG_NINR) * INRIR_TLACQ_1;
INRCSG_TLACQ_1 = positif(CSG - max(CSG_REF,CSG_TLDEC+0)) * null(3 - FLAG_INR)
            * arr((CSG - max(CSG_REF,CSG_TLDEC)-CSGIM*(1-positif(CSG_A))) * (TXINRRED / 200)) * (1 - positif(FLAG_C22+FLAG_C02))
	    +
               positif(CSG - CSG_TLDEC) * null(3-FLAG_INR)
            * arr((CSG - CSG_TLDEC) * (TXINRRED / 200)) * positif(FLAG_C22+FLAG_C02);
INRCSG_TLA_1 = (1 - IND_RJLJ) * (1-FLAG_NINR) * INRCSG_TLACQ_1;
INRPRS_TLACQ_1 = positif(PRS - max(PRS_REF,PRS_TLDEC+0)) * null(3 - FLAG_INR)
            * arr((PRS - max(PRS_REF,PRS_TLDEC)-PRSPROV*(1-positif(PRS_A))) * (TXINRRED / 200))*(1-positif(FLAG_C22+FLAG_C02))
	    +
               positif(PRS - PRS_TLDEC) * null(3-FLAG_INR)
            * arr((PRS - PRS_TLDEC) * (TXINRRED / 200)) * positif(FLAG_C22+FLAG_C02);
INRPRS_TLA_1 = (1 - IND_RJLJ) * (1-FLAG_NINR) * INRPRS_TLACQ_1;
INRCRDS_TLACQ_1 = positif(RDSN - max(RDS_REF,RDS_TLDEC+0)) * null(3 - FLAG_INR)
            * arr((RDSN - max(RDS_REF,RDS_TLDEC)-CRDSIM*(1-positif(RDS_A))) * (TXINRRED / 200))* (1-positif(FLAG_C22+FLAG_C02))
	    +
               positif(RDSN - RDS_TLDEC) * null(3-FLAG_INR)
            * arr((RDSN - RDS_TLDEC) * (TXINRRED / 200)) * positif(FLAG_C22+FLAG_C02);
INRCRDS_TLA_1 = (1 - IND_RJLJ) * (1-FLAG_NINR) * INRCRDS_TLACQ_1;
INRTAXA_TLACQ_1 = positif(TAXABASE - max(TAXA_REF*null(TAXABASE-TAXABASE_A),TAXA_TLDEC+0))*null(3- FLAG_INR)
            * arr((TAXABASE - max(TAXA_REF*null(TAXABASE-TAXABASE_A),TAXA_TLDEC)) * (TXINRRED / 200))
	    +
               positif(TAXABASE - TAXA_TLDEC) * null(3-FLAG_INR)
            * arr((TAXABASE - TAXA_TLDEC) * (TXINRRED / 200)) * positif(FLAG_C22+FLAG_C02);
INRTAXA_TLA_1 = (1 - IND_RJLJ) * (1-FLAG_NINR) * INRTAXA_TLACQ_1;
INRCSAL_TLACQ_1 = positif(CSALBASE - max(CSAL_REF*null(CSALBASE-CSALBASE_A),CSAL_TLDEC+0))*null(3- FLAG_INR)
            * arr((CSALBASE - max(CSAL_REF*null(CSALBASE-CSALBASE_A),CSAL_TLDEC)-CSALPROV*(1-positif(CSAL_A))) * (TXINRRED / 200))
	    +
               positif(CSALBASE - CSAL_TLDEC) * null(3-FLAG_INR)
            * arr((CSALBASE - CSAL_TLDEC) * (TXINRRED / 200)) * positif(FLAG_C22+FLAG_C02);
INRCSAL_TLA_1 = (1 - IND_RJLJ) * (1-FLAG_NINR) * INRCSAL_TLACQ_1;
INRCDIS_TLACQ_1 = positif(CDISBASE - max(CDIS_REF*null(CDISBASE-CDISBASE_A),CDIS_TLDEC+0))*null(3- FLAG_INR)
            * arr((CDISBASE - max(CDIS_REF*null(CDISBASE-CDISBASE_A),CDIS_TLDEC)) * (TXINRRED / 200))
	    +
               positif(CDISBASE - CDIS_TLDEC) * null(3-FLAG_INR)
            * arr((CDISBASE - CDIS_TLDEC) * (TXINRRED / 200)) * positif(FLAG_C22+FLAG_C02);
INRCDIS_TLA_1 = (1 - IND_RJLJ) * (1-FLAG_NINR) * INRCDIS_TLACQ_1;
regle corrective 1083:
application : oceans, iliad ;
INRIR_TLADEC_1 = INRIR_TLACQ_1;
INRIR_TL_1_AD=INRIR_TL_1_A;
INRCSG_TLADEC_1 = INRCSG_TLACQ_1;
INRCSG_TL_1_AD = INRCSG_TL_1_A;
INRPRS_TLADEC_1 = INRPRS_TLACQ_1;
INRPRS_TL_1_AD = INRPRS_TL_1_A;
INRCRDS_TLADEC_1 = INRCRDS_TLACQ_1;
INRCRDS_TL_1_AD = INRCRDS_TL_1_A;
INRTAXA_TLADEC_1 = INRTAXA_TLACQ_1;
INRTAXA_TL_1_AD = INRTAXA_TL_1_A;
INRCSAL_TLADEC_1 = INRCSAL_TLACQ_1;
INRCSAL_TL_1_AD = INRCSAL_TL_1_A;
INRCDIS_TLADEC_1 = INRCDIS_TLACQ_1;
INRCDIS_TL_1_AD = INRCDIS_TL_1_A;
INRIR_TLDEC_1 = INRIR_TLA_1+INRIR_RETDEF*null(INRIR_RETDEF_A);
INRCSG_TLDEC_1 = INRCSG_TLA_1 + INRCSG_RETDEF * null(INRCSG_RETDEF_A);
INRPRS_TLDEC_1 = INRPRS_TLA_1 + INRPRS_RETDEF * null(INRPRS_RETDEF_A);
INRCRDS_TLDEC_1 = INRCRDS_TLA_1 + INRCRDS_RETDEF * null(INRCRDS_RETDEF_A);
INRTAXA_TLDEC_1 = INRTAXA_TLA_1 + INRTAXA_RETDEF * null(INRTAXA_RETDEF_A);
INRCSAL_TLDEC_1 = INRCSAL_TLA_1 + INRCSAL_RETDEF * null(INRCSAL_RETDEF_A);
INRCDIS_TLDEC_1 = INRCDIS_TLA_1 + INRCDIS_RETDEF * null(INRCDIS_RETDEF_A);
INRIR_NTLDECD = INRIR_NTLDEC * positif_ou_nul(IRNIN_TLDEC_1 - IRNIN_NTLDEC) + INRIR_NTL *positif(IRNIN_NTLDEC-IRNIN_TLDEC_1);
INRCSG_NTLDECD = INRCSG_NTLDEC * positif_ou_nul(CSG_TLDEC_1 - CSG_NTLDEC) + INRCSG_NTL *positif(CSG_NTLDEC-CSG_TLDEC_1);
INRCRDS_NTLDECD = INRCRDS_NTLDEC * positif_ou_nul(RDS_TLDEC_1 - CRDS_NTLDEC) + INRCRDS_NTL *positif(CRDS_NTLDEC-RDS_TLDEC_1);
INRPRS_NTLDECD = INRPRS_NTLDEC * positif_ou_nul(PRS_TLDEC_1 - PRS_NTLDEC) + INRPRS_NTL *positif(PRS_NTLDEC-PRS_TLDEC_1);
INRCSAL_NTLDECD = INRCSAL_NTLDEC * positif_ou_nul(CSAL_TLDEC_1 - CSAL_NTLDEC) + INRCSAL_NTL *positif(CSAL_NTLDEC-CSAL_TLDEC_1);
INRCDIS_NTLDECD = INRCDIS_NTLDEC * positif_ou_nul(CDIS_TLDEC_1 - CDIS_NTLDEC) + INRCDIS_NTL *positif(CDIS_NTLDEC-CDIS_TLDEC_1);
INRTAXA_NTLDECD = INRTAXA_NTLDEC * positif_ou_nul(TAXA_TLDEC_1 - TAXA_NTLDEC) + INRTAXA_NTL *positif(TAXA_NTLDEC-TAXA_TLDEC_1);
INRIR_NTLDECD_1 = INRIR_NTLDEC_1 * positif_ou_nul(IRNIN_TLDEC_1 - IRNIN_NTLDEC_1) + INRIR_NTL_1 *positif(IRNIN_NTLDEC_1-IRNIN_TLDEC_1);
INRCSG_NTLDECD_1 = INRCSG_NTLDEC_1 * positif_ou_nul(CSG_TLDEC_1 - CSG_NTLDEC_1) + INRCSG_NTL_1 *positif(CSG_NTLDEC_1-CSG_TLDEC_1);
INRCRDS_NTLDECD_1 = INRCRDS_NTLDEC_1 * positif_ou_nul(RDS_TLDEC_1 - CRDS_NTLDEC_1) + INRCRDS_NTL_1 *positif(CRDS_NTLDEC_1-RDS_TLDEC_1);
INRPRS_NTLDECD_1 = INRPRS_NTLDEC_1 * positif_ou_nul(PRS_TLDEC_1 - PRS_NTLDEC_1) + INRPRS_NTL_1 *positif(PRS_NTLDEC_1-PRS_TLDEC_1);
INRCSAL_NTLDECD_1 = INRCSAL_NTLDEC_1 * positif_ou_nul(CSAL_TLDEC_1 - CSAL_NTLDEC_1) + INRCSAL_NTL_1 *positif(CSAL_NTLDEC_1-CSAL_TLDEC_1);
INRCDIS_NTLDECD_1 = INRCDIS_NTLDEC_1 * positif_ou_nul(CDIS_TLDEC_1 - CDIS_NTLDEC_1) + INRCDIS_NTL_1 *positif(CDIS_NTLDEC_1-CDIS_TLDEC_1);
INRTAXA_NTLDECD_1 = INRTAXA_NTLDEC_1 * positif_ou_nul(TAXA_TLDEC_1 - TAXA_NTLDEC_1) + INRTAXA_NTL_1 *positif(TAXA_NTLDEC_1-TAXA_TLDEC_1);
INRIR_TLDECD = INRIR_TLDEC * positif_ou_nul(IRNIN_TLDEC_1 - IRNIN_TLDEC) + INRIR_TLA *positif(IRNIN_TLDEC-IRNIN_TLDEC_1);
INRCSG_TLDECD = INRCSG_TLDEC * positif_ou_nul(CSG_TLDEC_1 - CSG_TLDEC) + INRCSG_TLA *positif(CSG_TLDEC-CSG_TLDEC_1);
INRCRDS_TLDECD = INRCRDS_TLDEC * positif_ou_nul(RDS_TLDEC_1 - RDS_TLDEC) + INRCRDS_TLA *positif(RDS_TLDEC-RDS_TLDEC_1);
INRPRS_TLDECD = INRPRS_TLDEC * positif_ou_nul(PRS_TLDEC_1 - PRS_TLDEC) + INRPRS_TLA *positif(PRS_TLDEC-PRS_TLDEC_1);
INRCSAL_TLDECD = INRCSAL_TLDEC * positif_ou_nul(CSAL_TLDEC_1 - CSAL_TLDEC) + INRCSAL_TLA *positif(CSAL_TLDEC-CSAL_TLDEC_1);
INRCDIS_TLDECD = INRCDIS_TLDEC * positif_ou_nul(CDIS_TLDEC_1 - CDIS_TLDEC) + INRCDIS_TLA *positif(CDIS_TLDEC-CDIS_TLDEC_1);
INRTAXA_TLDECD = INRTAXA_TLDEC * positif_ou_nul(TAXA_TLDEC_1 - TAXA_TLDEC) + INRTAXA_TLA *positif(TAXA_TLDEC-TAXA_TLDEC_1);

INRIR_R99RA = INRIR_R99R_A;
INRIR_R99R = arr(IRNIN_R99R * (TXINR_PA/100)-INCIR_NET_A) * positif(IRNIN_R99R- IRNIN_R99R_A)
             * positif(IND_PASSAGE-1) * positif(IRNIN_TLDEC-IRNIN_PA-ACODELAISINR);
INRIR_R9901A = INRIR_R9901_A;
INRIR_R9901 = arr(IRNIN_R9901 * (TXINR_PA/100)-INCIR_NET_A) * positif(IRNIN_R9901- IRNIN_R9901_A)
              * positif(IND_PASSAGE-1) * positif(IRNIN_TLDEC-IRNIN_R9901) * positif(IRNIN_R9901_A)
             + (arr(IRNIN_R9901 * (TXINR_PA/100))-INCIR_NET_A) * positif(IRNIN_R9901- IRNIN_INR_A)
              * positif(IND_PASSAGE-1) * positif(IRNIN_TLDEC-IRNIN_R9901) * (1-positif(IRNIN_R9901_A))
             + (INCIR_NET_A - arr(IRNIN_R9901 * (TXINR_PA/100))) * positif(IRNIN_INR_A- IRNIN_R9901)
              * positif(IND_PASSAGE-1) * positif(IRNIN_TLDEC-IRNIN_R9901) * (1-positif(IRNIN_R9901_A)) * positif(IRNIN_R9901)
	     ;
DO_INR_IRC=DO_INR_IR_A;
INR_NTL_GLOB_IR2 = INRIR_NTLDECD+ INRIR_NTL_A+ INRIR_NTLDECD_1 + INRIR_NTL_1_A ;
INR_TL_GLOB_IR2 = INRIR_TLDECD + INRIR_TL_A + INRIR_TLDEC_1 + INRIR_TL_1_A;
INR_TOT_GLOB_IR2 = (INR_NTL_GLOB_IR2 + INR_TL_GLOB_IR2*TL_IR+INRIR_R99R+INRIR_R99R_A) * (1-IND_RJLJ) ;
INR_TOT_GLOB_IRC = (INRIR_NTLDECD+ INRIR_NTL_A+ (INRIR_TLDECD + INRIR_TL_A)*TL_IR +INRIR_R99R+INRIR_R99R_A) * (1-IND_RJLJ) ;
DO_INR_IR2 = max(0,
          arr(((INRIR_TL_A+INRIR_TL_1_A)*TL_IR_A *TL_IR+ INRIR_NTL_A+INRIR_NTL_1_A) 
            * min(1,((IRNIN_REF - IRNIN_TLDEC_1)/(IRNIN_REF-max(0,IRNIN_R9901))))) * (1-positif(FLAG_RETARD + FLAG_DEFAUT))
            *positif(IRNIN_REF - IRNIN_TLDEC_1) * (1 - positif(FLAG_C02+FLAG_C22))
            *(1-positif_ou_nul(IRNIN_TLDEC_1 - IRNIN_INR_A))
        + arr(((INRIR_TL_A+INRIR_TL_1_A)*TL_IR_A *TL_IR) 
            * min(1,((IRNIN_REF - IRNIN_TLDEC_1)/(IRNIN_REF-max(0,IRNIN_R9901))))) * (1-positif(FLAG_RETARD + FLAG_DEFAUT))
            *positif(IRNIN_REF - IRNIN_TLDEC_1) * positif(FLAG_C02+FLAG_C22)
            *(1-positif_ou_nul(IRNIN_TLDEC_1 - IRNIN_INR_A))
            * (1-positif(INRIR_NTL_A + INRIR_NTL_1_A))
         + (INRIR_NTL_A*FLAG_C02+INRIR_NTL_1_A*FLAG_C22) 
            *positif(IRNIN_REF - IRNIN_TLDEC_1) * positif(FLAG_C02+FLAG_C22)
            *positif(INRIR_NTL_A)*positif(INRIR_NTL_1_A)
         + arr((INRIR_NTL_A*FLAG_C02+INRIR_NTL_1_A*FLAG_C22) 
            *positif(IRNIN_REF - IRNIN_TLDEC_1) * positif(FLAG_C02+FLAG_C22)
            * min(1,((IRNIN_REF - IRNIN_TLDEC_1)/(IRNIN_REF-max(0,IRNIN_R9901)))))
            * (1-positif(positif(INRIR_NTL_A)*positif(INRIR_NTL_1_A)))
         + ((INRIR_TL_A+INRIR_TL_1_A)*null(TL_IR) * TL_IR_A
            * (1- FLAG_DEFAUT)
             *positif(IRNIN_REF - IRNIN_TLDEC_1)* positif(IRNIN_REF - (max(0,IRNIN_R9901))))
         + (arr((INRIR_TL_A*TL_IR_A *TL_IR+(INRIR_NTL_A +INRIR_R99R+INRIR_R9901-INRIR_RETDEF-INR_IR_TARDIF) 
            * ((IRNIN_REF - IRNIN_TLDEC)/(IRNIN_REF-max(0,IRNIN_REF_A)))))
            * positif(IRNIN_REF - IRNIN_TLDEC)  * positif(IRNIN_TLDEC - IRNIN_R9901) 
            * positif(FLAG_RETARD + FLAG_DEFAUT))
            * (1-positif(ACODELAISINR+0))
            * positif(INRIR_R99R_A+INRIR_R9901_A+0)
         + (arr((INRIR_TL_A*TL_IR_A *TL_IR+(INRIR_NTL_A -INRIR_RETDEF-(INR_IR_TARDIF-INRIR_R9901)) 
	    * ((IRNIN_REF - IRNIN_TLDEC)/(IRNIN_REF-max(0,IRNIN_R9901)))))
            * positif(IRNIN_REF - IRNIN_TLDEC)  * positif(IRNIN_TLDEC - IRNIN_R9901) 
            * positif(FLAG_RETARD + FLAG_DEFAUT))
            * (1-positif(ACODELAISINR+0))
            * (1-positif(INRIR_R99R_A+INRIR_R9901_A+0))
         + ((INR_TOT_GLOB_IRC - DO_INR_IR_A - arr(IRNIN_TLDEC * TXINR_PA/100))
            * positif(IRNIN_REF - IRNIN_TLDEC)  * positif(IRNIN_R9901 - IRNIN_TLDEC) 
            * positif(FLAG_RETARD + FLAG_DEFAUT))
            * (1-positif(ACODELAISINR+0))
         + ((INRIR_R99R_A+INRIR_NTL_A - arr(IRNIN_R9901 * TXINR_PA/100)) * null(IRNIN_TLDEC - IRNIN_R9901)
                       * positif(IRNIN_REF - IRNIN_TLDEC)
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR))
         + ((INRIR_TL_A + INRIR_R99R_A+INRIR_NTL_A - max(0,arr(IRNIN_TLDEC * TXINR_PA/100))) * positif(IRNIN_R9901 - IRNIN_TLDEC)
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
		       * positif(ACODELAISINR)
         + ((INRIR_R99R_A+INRIR_NTL_A - max(0,arr(IRNIN_R9901 * TXINR_PA/100))) * positif(IRNIN_TLDEC-(IRNIN_R9901))
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
		       * positif(ACODELAISINR)
         + ((INRIR_TL_A + INRIR_R99R_A+INRIR_NTL_A - max(0,arr(IRNIN_R9901 * TXINR_PA/100))) * null(IRNIN_TLDEC-(IRNIN_R9901))
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
		       * positif(ACODELAISINR)
            );
RECUP_INR_IR = (min(DO_INR_IR_A,arr(DO_INR_IR_A * (IRNIN_TLDEC - IRNIN_INR_A)/DO_IR_A))
                      *positif(IRNIN_TLDEC-IRNIN_INR_A)*positif(IRNIN_REF-IRNIN_INR_A)
                      * positif(IRNIN_INR_A - IRNIN_PA-ACODELAISINR))
                      *positif(FLAG_RETARD + FLAG_DEFAUT)
		    + min(DO_INR_IR_A,arr((IRNIN_PA-ACODELAISINR - IRNIN_INR_A) * TXINR_PA/100))
                      * positif(IRNIN_PA-ACODELAISINR-IRNIN_INR_A)*positif(IRNIN_TLDEC-IRNIN_A)
                      * positif(DO_INR_IR_A)
                      *positif(FLAG_RETARD + FLAG_DEFAUT);
DO_IR2 = (IRNIN_REF - IRNIN_TLDEC_1) * positif(IRNIN_REF - IRNIN_TLDEC_1)* positif(IRNIN_INR_A);
SUP_IR_MAX2 = (IRNIN_REF - max(0,IRNIN_R9901)) * positif(IRNIN_REF - max(0,IRNIN_R9901))* positif(IRNIN_INR_A);
INRIR_RECT= arr(IRNIN_RECT * (TXINR_PA/100)) * positif(IRNIN_RECT) * FLAG_RECTIF;
INR_IR_TOT = max(INRIR_NTLDECD_1+INRIR_NTLDECD + (INRIR_TLDECD+INRIR_TLDEC_1)*TL_IR-INR_IR_TARDIF*null(1-IND_PASSAGE)+INRIR_R99R+RECUP_INR_IR,0)* (1-IND_RJLJ);
INCIR_TL2 = INRIR_TLDECD;
INCIR_TL_12 = INRIR_TLDEC_1;
INRIR_NET2 = max(INRIR_NTLDECD +INRIR_TLDECD*TL_IR+INRIR_R99R+RECUP_INR_IR,0)* (1-IND_RJLJ)* (1-FLAG_NINR)+DO_INR_IR2 * (-1);
INRIR_NET_12 = max(INRIR_NTLDECD_1 +INRIR_TLDEC_1*TL_IR,0)*(1-FLAG_NINR)* (1-IND_RJLJ);
INIR_TL2 = INRIR_TLA * TL_IR;
INIR_TL_12 = INRIR_TLA_1 * TL_IR;
INCIR_NET2 = (INRIR_NET2 +INRIR_NET_12
                  + (INCIR_NET_A-(INR_IR_TARDIF_A+INRIR_RETDEF_A)*positif(INRIR_NET2+INRIR_NET_12-INR_IR_TARDIF_A-INRIR_RETDEF_A)
									       *positif(ACODELAISINR)*(1-positif(INDACOINR_A)))
                  + ((INRIR_TL_A+INRIR_TL_1_A)*(1-null(TL_IR_A-TL_IR))*TL_IR)) *positif(IRNIN_INR)* (1-IND_RJLJ) ;
IR_PRI2=IRNIN_R9901;
IR_ANT2=IRNIN_INR_A;
IR_NTL2=IRNIN_NTLDEC;
IR_TL2=IRNIN_TLDEC;
IR_NTL_12=IRNIN_NTLDEC_1;
IR_TL_12=IRNIN_TLDEC_1;
IR_REF_INR=IRNIN_REF;
INRCSG_R99RA = INRCSG_R99R_A;
INRCSG_R99R = arr((CSG_R99R-CSGIM) * (TXINR_PA/100)-INCCS_NET_A) * positif(CSG_R99R-CSG_R99R_A)*positif(IND_PASSAGE-1);
INRCSG_R9901A = INRCSG_R9901_A;
INRCSG_R9901 = arr(CSG_R9901 * (TXINR_PA/100)-INCCS_NET_A) * positif(CSG_R9901- CSG_R9901_A)
              * positif(IND_PASSAGE-1) * positif(CSG_TLDEC-CSG_R9901) * positif(CSG_R9901_A)
             + (arr(CSG_R9901 * (TXINR_PA/100))-INCCS_NET_A) * positif(CSG_R9901- CSG_A)
              * positif(IND_PASSAGE-1) * positif(CSG_TLDEC-CSG_R9901) * (1-positif(CSG_R9901_A))
             + (INCCS_NET_A - arr(CSG_R9901 * (TXINR_PA/100))) * positif(CSG_A- CSG_R9901) * positif(CSG_R9901)
              * positif(IND_PASSAGE-1) * positif(CSG_TLDEC-CSG_R9901) * (1-positif(CSG_R9901_A))
	     ;
DO_INR_CSGC=DO_INR_CSG_A;
INR_NTL_GLOB_CSG2 = INRCSG_NTLDECD + INRCSG_NTL_A+ INRCSG_NTLDECD_1 + INRCSG_NTL_1_A;
INR_TL_GLOB_CSG2 = INRCSG_TLDECD + INRCSG_TL_A+INRCSG_TLDEC_1 + INRCSG_TL_1_A;
INR_TOT_GLOB_CSG2 = (INR_NTL_GLOB_CSG2 + INR_TL_GLOB_CSG2*TL_CS+INRCSG_R99R+INRCSG_R99R_A) * (1-IND_RJLJ);
INR_TOT_GLOB_CSGC = (INRCSG_NTLDECD+ INRCSG_NTL_A+ (INRCSG_TLDECD + INRCSG_TL_A)*TL_CS +INRCSG_R99R+INRCSG_R99R_A) * (1-IND_RJLJ) ;
DO_INR_CSG2 = max(0,
           (arr(((INRCSG_TL_A+INRCSG_TL_1_A)*TL_CS_A*TL_CS + INRCSG_NTL_A+INRCSG_NTL_1_A)
              * min(1,((CSG_REF - CSG_TLDEC_1)/(CSG_REF-max(0,CSG_R9901))))) * (1-positif(FLAG_RETARD + FLAG_DEFAUT))
              * positif(CSG_REF - CSG_TLDEC_1)* positif(CSG_REF - (max(0,CSG_R9901+CSG_PA)))) * (1-positif(FLAG_C02+FLAG_C22))
	     *(1-positif_ou_nul(CSG_TLDEC_1 - CSG_A))
          + arr(((INRCSG_TL_A+INRCSG_TL_1_A)*TL_CS_A*TL_CS)
	     * min(1,((CSG_REF - CSG_TLDEC_1)/(CSG_REF-max(0,CSG_R9901))))) * (1-positif(FLAG_RETARD + FLAG_DEFAUT))
	     * positif(CSG_REF - CSG_TLDEC_1)* positif(CSG_REF - (max(0,CSG_R9901))) * positif(FLAG_C02+FLAG_C22)
	     *(1-positif_ou_nul(CSG_TLDEC_1 - CSG_A))
	     * (1-positif(INRCSG_NTL_A+INRCSG_NTL_1_A))
          + (INRCSG_NTL_A*FLAG_C02+INRCSG_NTL_1_A*FLAG_C22) 
             *positif(CSG_REF - CSG_TLDEC_1)* positif(CSG_REF - (max(0,CSG_R9901))) * positif(FLAG_C02+FLAG_C22)
             * positif(INRCSG_NTL_A)*positif(INRCSG_NTL_1_A) 
          + (INRCSG_NTL_A*FLAG_C02+INRCSG_NTL_1_A*FLAG_C22) 
             *positif(CSG_REF - CSG_TLDEC_1)* positif(CSG_REF - (max(0,CSG_R9901))) * positif(FLAG_C02+FLAG_C22)
	     * min(1,((CSG_REF - CSG_TLDEC_1)/(CSG_REF-max(0,CSG_R9901))))
             * (1-positif(INRCSG_NTL_A)*positif(INRCSG_NTL_1_A))
          + ((INRCSG_TL_A+INRCSG_TL_1_A)*null(TL_CS) * TL_CS_A
          * (1- FLAG_DEFAUT)
             *positif(CSG_REF - CSG_TLDEC_1)* positif(CSG_REF - (max(0,CSG_R9901))))
         + ((INRCSG_TL_A + INRCSG_R99R_A+INRCSG_NTL_A - max(0,arr(CSG_TLDEC * TXINR_PA/100))) * positif(CSG_R9901 - CSG_TLDEC)
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * positif(ACODELAISINR)
         + ((INRCSG_R99R_A+INRCSG_NTL_A - max(0,arr(CSG_R9901 * TXINR_PA/100))) * positif(CSG_TLDEC-(CSG_R9901))
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
		       * positif(ACODELAISINR)
         + ((INRCSG_TL_A + INRCSG_R99R_A+INRCSG_NTL_A - max(0,arr(CSG_R9901 * TXINR_PA/100))) * null(CSG_TLDEC-(CSG_R9901))
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
		       * positif(ACODELAISINR)
         + (arr((INRCSG_TL_A*TL_CS_A *TL_CS+(INRCSG_NTL_A +INRCSG_R99R+INRCSG_R9901-INRCSG_RETDEF-INR_CSG_TARDIF) 
                       * ((CSG_REF - CSG_TLDEC)/(CSG_REF-max(0,CSG_REF_A)))))
                       * positif(CSG_REF - CSG_TLDEC)  * positif(CSG_TLDEC - CSG_R9901) 
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR+0))
                       * positif(INRCSG_R99R_A+INRCSG_R9901_A+0)
         + (arr((INRCSG_TL_A*TL_CS_A*TL_CS +(INRCSG_NTL_A+INRCSG_RETDEF-(INR_CSG_TARDIF-INRCSG_R9901))
	               *(CSG_REF - CSG_TLDEC)/(CSG_REF-max(0,CSG_R9901))))
                       * positif(CSG_REF - CSG_TLDEC) * positif(CSG_TLDEC - CSG_R9901) 
	               * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR+0))
                       * (1-positif(INRCSG_R99R_A+INRCSG_R9901_A+0))
         + ((INR_TOT_GLOB_CSG - DO_INR_CSG_A - arr(CSG_TLDEC * TXINR_PA/100))
                       * positif(CSG_R9901 - CSG_TLDEC) 
                       * positif(CSG_REF - CSG_TLDEC)
	               * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR+0))
         + ((INRCSG_R99R_A + INRCSG_NTL_A- arr(CSG_R9901 * TXINR_PA/100)) * null(CSG_TLDEC - CSG_R9901)
                       * positif(CSG_REF - CSG_TLDEC)
		       * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR))
            );

RECUP_INR_CSG = (min(DO_INR_CSG_A,arr(DO_INR_CSG_A * (CSG_TLDEC - CSG_A)/DO_CSG_A))
                    *positif(CSG_TLDEC-CSG_A)*positif(CSG_REF-CSG_A)
                    * positif(CSG_A - CSG_R9901)
                    *positif(FLAG_RETARD + FLAG_DEFAUT))
		+ min(DO_INR_CSG_A,arr((CSG_R9901 - CSG_A) * TXINR_PA/100))
                    * positif(CSG_R9901-CSG_A)*positif(CSG_TLDEC - CSG_A)
                    * positif(DO_INR_CSG_A)
		    *positif(FLAG_RETARD + FLAG_DEFAUT);
DO_CSG2 = (CSG_REF - CSG_TLDEC_1) * positif(CSG_REF - CSG_TLDEC_1)* positif(CSG_A);
SUP_CSG_MAX2 = (CSG_REF - max(0,CSG_R9901)) * positif(CSG_REF - max(0,CSG_R9901))* positif(CSG_A);
INRCSG_RECT= arr((CSG_RECT-CSGIM) * (TXINR_PA/100)) * positif(CSG_RECT) * FLAG_RECTIF;
INR_CSG_TOT = max(INRCSG_NTLDECD+INRCSG_NTLDECD_1+(INRCSG_TLDECD+INRCSG_TLDEC_1)*TL_CS-INR_CSG_TARDIF*null(1-IND_PASSAGE)+INRCSG_R99R+RECUP_INR_CSG,0)*(1-IND_RJLJ);
INRCSG_NET2 = max(INRCSG_NTLDECD+INRCSG_TLDECD*TL_CS+INRCSG_R99R+RECUP_INR_CSG,0)*(1-IND_RJLJ)+DO_INR_CSG2 * (-1);
INRCSG_NET_12 = max(INRCSG_NTLDECD_1+INRCSG_TLDEC_1*TL_CS,0)*(1-IND_RJLJ);
INCCS_NET2 = (INRCSG_NET2 +INRCSG_NET_12+ INCCS_NET_A+(INRCSG_TL_A+INRCSG_TL_1_A)*(1-null(TL_CS_A-TL_CS))*positif(TL_CS)) * positif(CSG)* (1-IND_RJLJ);
INCS_TL2 = INRCSG_TLA * TL_CS;
INCS_TL_12 = INRCSG_TLA_1 * TL_CS;
INCCS_TL2 = INRCSG_TLDECD;
INCCS_TL_12 = INRCSG_TLDEC_1;
CSG_PRI2=CSG_R9901;
CSG_ANT2=CSG_A;
CSG_NTL2=CSG_NTLDEC;
CSG_NTL_12=CSG_NTLDEC_1;
CSG_TL2=CSG_TLDEC;
CSG_TL_12=CSG_TLDEC_1;
CSG_REF_INR=CSG_REF;
INRCRDS_R99RA = INRCRDS_R99R_A;
INRCRDS_R99R = arr((RDS_R99R - CRDSIM) * (TXINR_PA/100)-INCRD_NET_A)
                  * positif(RDS_R99R-RDS_R99R_A)*positif(IND_PASSAGE-1);
INRCRDS_R9901A = INRCRDS_R9901_A;
INRCRDS_R9901 = arr(RDS_R9901 * (TXINR_PA/100)-INCRD_NET_A) * positif(RDS_R9901- RDS_R9901_A)
              * positif(IND_PASSAGE-1) * positif(RDS_TLDEC-RDS_R9901) * positif(RDS_R9901_A)
             + (arr(RDS_R9901 * (TXINR_PA/100))-INCRD_NET_A) * positif(RDS_R9901- RDS_A)
              * positif(IND_PASSAGE-1) * positif(RDS_TLDEC-RDS_R9901) * (1-positif(RDS_R9901_A))
             + (INCRD_NET_A - arr(RDS_R9901 * (TXINR_PA/100))) * positif(RDS_A- RDS_R9901)
              * positif(IND_PASSAGE-1) * positif(RDS_TLDEC-RDS_R9901) * (1-positif(RDS_R9901_A)) * positif(RDS_R9901)
	     ;
DO_INR_CRDSC=DO_INR_CRDS_A;
INR_NTL_GLOB_CRDS2 = INRCRDS_NTLDECD + INRCRDS_NTL_A+INRCRDS_NTLDECD_1+INRCRDS_NTL_1_A;
INR_TL_GLOB_CRDS2 = INRCRDS_TLDECD + INRCRDS_TL_A+INRCRDS_TLDEC_1+INRCRDS_TL_1_A;
INR_TOT_GLOB_CRDS2 = (INR_NTL_GLOB_CRDS2 + INR_TL_GLOB_CRDS2*TL_CS+INRCRDS_R99R+INRCRDS_R99R_A) * (1-IND_RJLJ);
INR_TOT_GLOB_CRDSC= (INRCRDS_NTLDECD+INRCRDS_NTL_A+(INRCRDS_TLDECD+INRCRDS_TL_A)*TL_CS +INRCRDS_R99R+INRCRDS_R99R_A) * (1-IND_RJLJ) ;
DO_INR_CRDS2 = max(0,
           (arr(((INRCRDS_TL_A+INRCRDS_TL_1_A)*TL_CS_A*TL_CS + INRCRDS_NTL_A+INRCRDS_NTL_1_A)
           * min(1,((RDS_REF - RDS_TLDEC_1)/(RDS_REF-max(0,RDS_R9901)))))
              * (1-positif(FLAG_RETARD + FLAG_DEFAUT))
              * positif(RDS_REF - RDS_TLDEC_1)* positif(RDS_REF - (max(0,RDS_R9901))))
              * (1-positif(FLAG_C02+FLAG_C22))
	     *(1-positif_ou_nul(RDS_TLDEC_1 - RDS_A))
           +arr(((INRCRDS_TL_A+INRCRDS_TL_1_A)*TL_CS_A*TL_CS)
             * min(1,((RDS_REF - RDS_TLDEC_1)/(RDS_REF-max(0,RDS_R9901)))))
             * (1-positif(FLAG_RETARD + FLAG_DEFAUT))
             * positif(RDS_REF - RDS_TLDEC_1)* positif(RDS_REF - (max(0,RDS_R9901)))
             *  positif(FLAG_C02+FLAG_C22)
             *(1-positif_ou_nul(RDS_TLDEC_1 - RDS_A))
             * (1-positif(INRCRDS_NTL_A+INRCRDS_NTL_1_A))
          + (INRCRDS_NTL_A*FLAG_C02+INRCRDS_NTL_1_A*FLAG_C22) 
             *positif(RDS_REF - RDS_TLDEC_1)* positif(RDS_REF - (max(0,RDS_R9901))) * positif(FLAG_C02+FLAG_C22)
             * positif(INRCRDS_NTL_A)*positif(INRCRDS_NTL_1_A)
          + (INRCRDS_NTL_A*FLAG_C02+INRCRDS_NTL_1_A*FLAG_C22) 
             *positif(RDS_REF - RDS_TLDEC_1)* positif(RDS_REF - (max(0,RDS_R9901))) * positif(FLAG_C02+FLAG_C22)
             * min(1,((RDS_REF - RDS_TLDEC_1)/(RDS_REF-max(0,RDS_R9901))))
             * (1-positif(positif(INRCRDS_NTL_A)*positif(INRCRDS_NTL_1_A)))
          + ((INRCRDS_TL_A+INRCRDS_TL_1_A)*null(TL_CS) * TL_CS_A
          * (1- FLAG_DEFAUT)
             *positif(RDS_REF - RDS_TLDEC_1)* positif(RDS_REF - (max(0,RDS_R9901))))
         + ((INRCRDS_TL_A + INRCRDS_R99R_A+INRCRDS_NTL_A - max(0,arr(RDS_TLDEC * TXINR_PA/100))) * positif(RDS_R9901 - RDS_TLDEC)
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * positif(ACODELAISINR)
         + ((INRCRDS_R99R_A+INRCRDS_NTL_A - max(0,arr(RDS_R9901 * TXINR_PA/100))) * positif(RDS_TLDEC-(RDS_R9901))
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
		       * positif(ACODELAISINR)
         + ((INRCRDS_TL_A + INRCRDS_R99R_A+INRCRDS_NTL_A - max(0,arr(RDS_R9901 * TXINR_PA/100))) * null(RDS_TLDEC-(RDS_R9901))
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
		       * positif(ACODELAISINR)
         + (arr((INRCRDS_TL_A*TL_CS_A *TL_CS+(INRCRDS_NTL_A +INRCRDS_R99R+INRCRDS_R9901-INRCRDS_RETDEF-INR_CRDS_TARDIF) 
                       * ((RDS_REF - RDS_TLDEC)/(RDS_REF-max(0,RDS_REF_A)))))
                       * positif(RDS_REF - RDS_TLDEC)  * positif(RDS_TLDEC - RDS_R9901) 
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR+0))
                       * positif(INRCRDS_R99R_A+INRCRDS_R9901_A+0)
         + (arr((INRCRDS_TL_A*TL_CS_A*TL_CS +(INRCRDS_NTL_A+INRCRDS_RETDEF-(INR_CRDS_TARDIF-INRCRDS_R9901))
	               *(RDS_REF - RDS_TLDEC)/(RDS_REF-max(0,RDS_R9901))))
                       * positif(RDS_REF - RDS_TLDEC) * positif(RDS_TLDEC - RDS_R9901) 
	               * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR+0))
                       * (1-positif(INRCRDS_R99R_A+INRCRDS_R9901_A+0))
         + ((INR_TOT_GLOB_CRDS - DO_INR_CRDS_A - arr(RDS_TLDEC * TXINR_PA/100))
                       * positif(RDS_R9901 - RDS_TLDEC) 
                       * positif(RDS_REF - RDS_TLDEC)
	               * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR+0))
         + ((INRCRDS_R99R_A + INRCRDS_NTL_A- arr(RDS_R9901 * TXINR_PA/100)) * null(RDS_TLDEC - RDS_R9901)
                       * positif(RDS_REF - RDS_TLDEC)
		       * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR))
            );

RECUP_INR_CRDS = (min(DO_INR_CRDS_A,arr(DO_INR_CRDS_A * (RDS_TLDEC - RDS_A)/DO_CRDS_A))
                    *positif(RDS_TLDEC-RDS_A)*positif(RDS_REF-RDS_A)
	        	* positif(RDS_A - RDS_R9901)
                    *positif(FLAG_RETARD + FLAG_DEFAUT))
		+ min(DO_INR_CRDS_A,arr((RDS_R9901 - RDS_A) * TXINR_PA/100))*positif(RDS_TLDEC - RDS_A)
		   * positif(RDS_R9901-RDS_A)
		* positif(DO_INR_CRDS_A)
		    *positif(FLAG_RETARD + FLAG_DEFAUT);
DO_CRDS2 = (RDS_REF - RDS_TLDEC_1) * positif(RDS_REF - RDS_TLDEC_1)* positif(RDS_A);
SUP_CRDS_MAX2 = (RDS_REF - max(0,RDS_R9901)) * positif(RDS_REF - max(0,RDS_R9901))* positif(RDS_A);
INRCRDS_RECT= arr((CRDS_RECT-CRDSIM) * (TXINR_PA/100)) * positif(CRDS_RECT) * FLAG_RECTIF;
INR_CRDS_TOT = max(INRCRDS_NTLDECD+INRCRDS_NTLDECD_1+(INRCRDS_TLDECD+INRCRDS_TLDEC_1)*TL_CS-INR_CRDS_TARDIF*null(1-IND_PASSAGE)+INRCRDS_R99R+RECUP_INR_CRDS,0) 
	       * (1-IND_RJLJ);
INCRD_TL2 = INRCRDS_TLDEC;
INCRD_TL_12 = INRCRDS_TLDEC_1;
INRRDS_NET2 = max(INRCRDS_NTLDECD+INRCRDS_TLDECD*TL_CS+INRCRDS_R99R+RECUP_INR_CRDS,0)*(1-IND_RJLJ)+DO_INR_CRDS2 * (-1);
INRRDS_NET_12 = max(INRCRDS_NTLDECD_1+INRCRDS_TLDEC_1*TL_CS,0)*(1-IND_RJLJ);
INRD_TL2 = INRCRDS_TLA * TL_CS;
INRD_TL_12 = INRCRDS_TLA_1 * TL_CS;
INCRD_NET2 = (INRRDS_NET2 +INRRDS_NET_12+ INCRD_NET_A+(INRCRDS_TL_A+INRCRDS_TL_1_A)*(1-null(TL_CS_A-TL_CS))*positif(TL_CS)) * positif(RDSN)* (1-IND_RJLJ);
CRDS_PRI2=RDS_R9901;
CRDS_ANT2=RDS_A;
CRDS_NTL2=CRDS_NTLDEC;
CRDS_NTL_12=CRDS_NTLDEC_1;
CRDS_TL2=RDS_TLDEC;
CRDS_TL_12=RDS_TLDEC_1;
CRDS_REF_INR=RDS_REF;
INRPRS_R99RA = INRPRS_R99R_A;
INRPRS_R99R = arr((PRS_R99R -PRSPROV) * (TXINR_PA/100)-INCPS_NET_A)
                  * positif(PRS_R99R-PRS_R99R_A)*positif(IND_PASSAGE-1);
INRPRS_R9901A = INRPRS_R9901_A;
INRPRS_R9901 = arr(PRS_R9901 * (TXINR_PA/100)-INCPS_NET_A) * positif(PRS_R9901- PRS_R9901_A)
              * positif(IND_PASSAGE-1) * positif(PRS_TLDEC-PRS_R9901) * positif(PRS_R9901_A)
             + (arr(PRS_R9901 * (TXINR_PA/100))-INCPS_NET_A) * positif(PRS_R9901- PRS_A)
              * positif(IND_PASSAGE-1) * positif(PRS_TLDEC-PRS_R9901) * (1-positif(PRS_R9901_A))
             + (INCPS_NET_A - arr(PRS_R9901 * (TXINR_PA/100))) * positif(PRS_A- PRS_R9901)
              * positif(IND_PASSAGE-1) * positif(PRS_TLDEC-PRS_R9901) * (1-positif(PRS_R9901_A)) * positif(PRS_R9901)
	     ;
DO_INR_PSC=DO_INR_PS_A;
INR_NTL_GLOB_PS2 = INRPRS_NTLDECD + INRPRS_NTL_A+ INRPRS_NTLDECD_1 + INRPRS_NTL_1_A;
INR_TL_GLOB_PS2 = INRPRS_TLDECD + INRPRS_TL_A+INRPRS_TLDEC_1 + INRPRS_TL_1_A;
INR_TOT_GLOB_PS2 = (INR_NTL_GLOB_PS2 + INR_TL_GLOB_PS2*TL_CS+INRPRS_R99R+INRPRS_R99R_A)  * (1-IND_RJLJ);
INR_TOT_GLOB_PSC = (INRPRS_NTLDECD+ INRPRS_NTL_A+ (INRPRS_TLDECD + INRPRS_TL_A)*TL_CS +INRPRS_R99R+INRPRS_R99R_A) * (1-IND_RJLJ) ;
DO_INR_PS2 = max(0,
           (arr(((INRPRS_TL_A+INRPRS_TL_1_A)*TL_CS_A*TL_CS + INRPRS_NTL_A+INRPRS_NTL_1_A)
           * min(1,((PRS_REF - PRS_TLDEC_1)/(PRS_REF-max(0,PRS_R9901)))) )
            * (1-positif(FLAG_RETARD + FLAG_DEFAUT))
            * positif(PRS_REF - PRS_TLDEC_1)* positif(PRS_REF - (max(0,PRS_R9901))))
              * (1-positif(FLAG_C02+FLAG_C22))
	     *(1-positif_ou_nul(PRS_TLDEC_1 - PRS_A))
           +arr(((INRPRS_TL_A+INRPRS_TL_1_A)*TL_CS_A*TL_CS)
             * min(1,((PRS_REF - PRS_TLDEC_1)/(PRS_REF-max(0,PRS_R9901)))))
             * (1-positif(FLAG_RETARD + FLAG_DEFAUT))
             * positif(PRS_REF - PRS_TLDEC_1)* positif(PRS_REF - (max(0,PRS_R9901)))
             * positif(FLAG_C02+FLAG_C22)
             *(1-positif_ou_nul(PRS_TLDEC_1 - PRS_A))
             * (1-positif(INRPRS_NTL_A+INRPRS_NTL_1_A))
          + (INRPRS_NTL_A*FLAG_C02+INRPRS_NTL_1_A*FLAG_C22) 
             *positif(PRS_REF - PRS_TLDEC_1)* positif(PRS_REF - (max(0,PRS_R9901))) * positif(FLAG_C02+FLAG_C22)
             * positif(INRPRS_NTL_A)*positif(INRPRS_NTL_1_A)
          + (INRPRS_NTL_A*FLAG_C02+INRPRS_NTL_1_A*FLAG_C22) 
             *positif(PRS_REF - PRS_TLDEC_1)* positif(PRS_REF - (max(0,PRS_R9901))) * positif(FLAG_C02+FLAG_C22)
             * min(1,((PRS_REF - PRS_TLDEC_1)/(PRS_REF-max(0,PRS_R9901))))
             * (1-positif(INRPRS_NTL_A)*positif(INRPRS_NTL_1_A))
          + ((INRPRS_TL_A+INRPRS_TL_1_A)*null(TL_CS) * TL_CS_A
          * (1- FLAG_DEFAUT)
             *positif(PRS_REF - PRS_TLDEC_1)* positif(PRS_REF - (max(0,PRS_R9901))))
         + ((INRPRS_TL_A + INRPRS_R99R_A+INRPRS_NTL_A - max(0,arr(PRS_TLDEC * TXINR_PA/100))) * positif(PRS_R9901 - PRS_TLDEC)
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * positif(ACODELAISINR)
         + ((INRPRS_R99R_A+INRPRS_NTL_A - max(0,arr(PRS_R9901 * TXINR_PA/100))) * positif(PRS_TLDEC-(PRS_R9901))
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
		       * positif(ACODELAISINR)
         + ((INRPRS_TL_A + INRPRS_R99R_A+INRPRS_NTL_A - max(0,arr(PRS_R9901 * TXINR_PA/100))) * null(PRS_TLDEC-(PRS_R9901))
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
		       * positif(ACODELAISINR)
         + (arr((INRPRS_TL_A*TL_CS_A *TL_CS+(INRPRS_NTL_A +INRPRS_R99R+INRPRS_R9901-INRPRS_RETDEF-INR_PS_TARDIF) 
                       * ((PRS_REF - PRS_TLDEC)/(PRS_REF-max(0,PRS_REF_A)))))
                       * positif(PRS_REF - PRS_TLDEC)  * positif(PRS_TLDEC - PRS_R9901) 
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR+0))
                       * positif(INRPRS_R99R_A+INRPRS_R9901_A+0)
         + (arr((INRPRS_TL_A*TL_CS_A*TL_CS +(INRPRS_NTL_A+INRPRS_RETDEF-(INR_PS_TARDIF-INRPRS_R9901))
	               *(PRS_REF - PRS_TLDEC)/(PRS_REF-max(0,PRS_R9901))))
                       * positif(PRS_REF - PRS_TLDEC) * positif(PRS_TLDEC - PRS_R9901) 
	               * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR+0))
                       * (1-positif(INRPRS_R99R_A+INRPRS_R9901_A+0))
         + ((INR_TOT_GLOB_PS - DO_INR_PS_A - arr(PRS_TLDEC * TXINR_PA/100))
                       * positif(PRS_R9901 - PRS_TLDEC) 
                       * positif(PRS_REF - PRS_TLDEC)
	               * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR+0))
         + ((INRPRS_R99R_A + INRPRS_NTL_A- arr(PRS_R9901 * TXINR_PA/100)) * null(PRS_TLDEC - PRS_R9901)
                       * positif(PRS_REF - PRS_TLDEC)
		       * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR))
            );

RECUP_INR_PRS = (min(DO_INR_PS_A,arr(DO_INR_PS_A * (PRS_TLDEC - PRS_A)/DO_PS_A))
                    *positif(PRS_TLDEC-PRS_A)*positif(PRS_REF-PRS_A)
                    *positif(FLAG_RETARD + FLAG_DEFAUT))
	        	* positif(PRS_A - PRS_R9901)
		+ min(DO_INR_PS_A,arr((PRS_R9901 - PRS_A) * TXINR_PA/100))*positif(PRS_TLDEC - PRS_A)
		   * positif(PRS_R9901-PRS_A)
		* positif(DO_INR_PS_A)
		    *positif(FLAG_RETARD + FLAG_DEFAUT);
DO_PS2 = (PRS_REF - PRS_TLDEC_1) * positif(PRS_REF - PRS_TLDEC_1)* positif(PRS_A);
SUP_PS_MAX2 = (PRS_REF - max(0,PRS_R9901)) * positif(PRS_REF - max(0,PRS_R9901))* positif(PRS_A);
INRPRS_RECT= arr((PS_RECT-PRSPROV) * (TXINR_PA/100)) * positif(PS_RECT) * FLAG_RECTIF;
INR_PS_TOT = max(INRPRS_NTLDECD+INRPRS_NTLDECD_1+(INRPRS_TLDECD+INRPRS_TLDEC_1)*TL_CS-INR_PS_TARDIF*null(1-IND_PASSAGE)+INRPRS_R99R+RECUP_INR_PRS,0) * (1-IND_RJLJ);
INCPS_TL2 = INRPRS_TLDECD;
INCPS_TL_12 = INRPRS_TLDEC_1;
INRPRS_NET2 = max(INRPRS_NTLDECD+INRPRS_TLDECD*TL_CS+INRPRS_R99R+RECUP_INR_PRS,0)*(1-IND_RJLJ)+DO_INR_PS2 * (-1);
INRPRS_NET_12 = max(INRPRS_NTLDECD_1+INRPRS_TLDEC_1*TL_CS,0)*(1-IND_RJLJ);
INPS_TL2 = INRPRS_TLA * TL_CS;
INPS_TL_12 = INRPRS_TLA_1 * TL_CS;
INCPS_NET2 = (INRPRS_NET2 + INRPRS_NET_12 + INCPS_NET_A+(INRPRS_TL_A+INRPRS_TL_1_A)*(1-null(TL_CS_A-TL_CS))*positif(TL_CS)) * positif(PRS) * (1-IND_RJLJ);
PS_PRI2=PRS_R9901;
PS_ANT2=PRS_A;
PS_NTL2=PRS_NTLDEC;
PS_NTL_12=PRS_NTLDEC_1;
PS_TL2=PRS_TLDEC;
PS_TL_12=PRS_TLDEC_1;
PS_REF_INR=PRS_REF;
INRTAXA_R99RA = INRTAXA_R99R_A;
INRTAXA_R99R = arr(TAXA_R99R * (TXINR_PA/100)-INCTAXA_NET_A) * positif(TAXA_R99R-TAXA_R99R_A)*positif(IND_PASSAGE-1);
INRTAXA_R9901A = INRTAXA_R9901_A;
INRTAXA_R9901 = arr(TAXA_R9901 * (TXINR_PA/100)-INCTAXA_NET_A) * positif(TAXA_R9901- TAXA_R9901_A)
              * positif(IND_PASSAGE-1) * positif(TAXA_TLDEC-TAXA_R9901) * positif(TAXA_R9901_A)
             + (arr(TAXA_R9901 * (TXINR_PA/100))-INCTAXA_NET_A) * positif(TAXA_R9901- TAXABASE_A)
              * positif(IND_PASSAGE-1) * positif(TAXA_TLDEC-TAXA_R9901) * (1-positif(TAXA_R9901_A))
             + (INCTAXA_NET_A - arr(TAXA_R9901 * (TXINR_PA/100))) * positif(TAXABASE_A- TAXA_R9901)
              * positif(IND_PASSAGE-1) * positif(TAXA_TLDEC-TAXA_R9901) * (1-positif(TAXA_R9901_A)) * positif(TAXA_R9901)
	     ;
DO_INR_TAXAC=DO_INR_TAXA_A;
INR_NTL_GLOB_TAXA2 = INRTAXA_NTLDECD + INRTAXA_NTL_A+ INRTAXA_NTLDECD_1 + INRTAXA_NTL_1_A;
INR_TL_GLOB_TAXA2 = INRTAXA_TLDECD + INRTAXA_TL_A+ INRTAXA_TLDEC_1 + INRTAXA_TL_1_A;
INR_TOT_GLOB_TAXA2 = max(0,INR_NTL_GLOB_TAXA2 + INR_TL_GLOB_TAXA2*TL_TAXAGA+INRTAXA_R99R+INRTAXA_R99R_A) * (1-IND_RJLJ);
INR_TOT_GLOB_TAXAC= (INRTAXA_NTLDECD+ INRTAXA_NTL_A+ (INRTAXA_TLDECD + INRTAXA_TL_A)*TL_TAXAGA +INRTAXA_R99R+INRTAXA_R99R_A) * (1-IND_RJLJ) ;
DO_INR_TAXA2 = max(0,
           (arr(((INRTAXA_TL_A+INRTAXA_TL_1_A)*TL_TAXAGA_A*TL_TAXAGA + INRTAXA_NTL_A+INRTAXA_NTL_1_A)
           * min(1,((TAXA_REF - TAXA_TLDEC_1)/(TAXA_REF-max(0,TAXA_R9901))))) 
             * (1-positif(FLAG_RETARD + FLAG_DEFAUT))
             * positif(TAXA_REF - TAXA_TLDEC_1)* positif(TAXA_REF - (max(0,TAXA_R9901))))
              * (1-positif(FLAG_C02+FLAG_C22))
	     *(1-positif_ou_nul(TAXA_TLDEC_1 - TAXABASE_A))
           +arr(((INRTAXA_TL_A+INRTAXA_TL_1_A)*TL_TAXAGA_A*TL_TAXAGA)
             * min(1,((TAXA_REF - TAXA_TLDEC_1)/(TAXA_REF-max(0,TAXA_R9901)))))
             * (1-positif(FLAG_RETARD + FLAG_DEFAUT))
             * positif(TAXA_REF - TAXA_TLDEC_1)* positif(TAXA_REF - (max(0,TAXA_R9901)))
             * positif(FLAG_C02+FLAG_C22)
             *(1-positif_ou_nul(TAXA_TLDEC_1 - TAXABASE_A))
             * (1-positif(INRTAXA_NTL_A+INRTAXA_NTL_1_A))
          + (INRTAXA_NTL_A*FLAG_C02+INRTAXA_NTL_1_A*FLAG_C22) 
             *positif(TAXA_REF - TAXA_TLDEC_1)* positif(TAXA_REF - (max(0,TAXA_R9901))) * positif(FLAG_C02+FLAG_C22)
             * positif(INRTAXA_NTL_A)*positif(INRTAXA_NTL_1_A)
          + (INRTAXA_NTL_A*FLAG_C02+INRTAXA_NTL_1_A*FLAG_C22) 
             *positif(TAXA_REF - TAXA_TLDEC_1)* positif(TAXA_REF - (max(0,TAXA_R9901))) * positif(FLAG_C02+FLAG_C22)
             * min(1,((TAXA_REF - TAXA_TLDEC_1)/(TAXA_REF-max(0,TAXA_R9901))))
             * (1-positif(INRTAXA_NTL_A)*positif(INRTAXA_NTL_1_A))
          + ((INRTAXA_TL_A+INRTAXA_TL_1_A)*null(TL_TAXAGA) * TL_TAXAGA_A
          * (1- FLAG_DEFAUT)
             *positif(TAXA_REF - TAXA_TLDEC_1)* positif(TAXA_REF - (max(0,TAXA_R9901))))
         + ((INRTAXA_TL_A + INRTAXA_R99R_A+INRTAXA_NTL_A - max(0,arr(TAXA_TLDEC * TXINR_PA/100))) * positif(TAXA_R9901 - TAXA_TLDEC)
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * positif(ACODELAISINR)
         + ((INRTAXA_R99R_A+INRTAXA_NTL_A - max(0,arr(TAXA_R9901 * TXINR_PA/100))) * positif(TAXA_TLDEC-(TAXA_R9901))
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
		       * positif(ACODELAISINR)
         + ((INRTAXA_TL_A + INRTAXA_R99R_A+INRTAXA_NTL_A - max(0,arr(TAXA_R9901 * TXINR_PA/100))) * null(TAXA_TLDEC-(TAXA_R9901))
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
		       * positif(ACODELAISINR)
         + (arr((INRTAXA_TL_A*TL_TAXAGA_A *TL_TAXAGA+(INRTAXA_NTL_A +INRTAXA_R99R+INRTAXA_R9901-INRTAXA_RETDEF-INR_TAXAGA_TARDIF) 
                       * ((TAXA_REF - TAXA_TLDEC)/(TAXA_REF-max(0,TAXA_REF_A)))))
                       * positif(TAXA_REF - TAXA_TLDEC)  * positif(TAXA_TLDEC - TAXA_R9901) 
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR+0))
                       * positif(INRTAXA_R99R_A+INRTAXA_R9901_A+0)
         + (arr((INRTAXA_TL_A*TL_TAXAGA_A*TL_TAXAGA +(INRTAXA_NTL_A+INRTAXA_RETDEF-(INR_TAXAGA_TARDIF-INRTAXA_R9901))
	               *(TAXA_REF - TAXA_TLDEC)/(TAXA_REF-max(0,TAXA_R9901))))
                       * positif(TAXA_REF - TAXA_TLDEC) * positif(TAXA_TLDEC - TAXA_R9901) 
	               * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR+0))
                       * (1-positif(INRTAXA_R99R_A+INRTAXA_R9901_A+0))
         + ((INR_TOT_GLOB_TAXA - DO_INR_TAXA_A - arr(TAXA_TLDEC * TXINR_PA/100))
                       * positif(TAXA_R9901 - TAXA_TLDEC) 
                       * positif(TAXA_REF - TAXA_TLDEC)
	               * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR+0))
         + ((INRTAXA_R99R_A + INRTAXA_NTL_A- arr(TAXA_R9901 * TXINR_PA/100)) * null(TAXA_TLDEC - TAXA_R9901)
                       * positif(TAXA_REF - TAXA_TLDEC)
		       * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR))
            );

RECUP_INR_TAXA = (min(DO_INR_TAXA_A,arr(DO_INR_TAXA_A * (TAXA_TLDEC - TAXABASE_A)/DO_TAXA_A))
                    *positif(TAXA_TLDEC-TAXABASE_A)*positif(TAXA_REF-TAXABASE_A)
                    * positif(TAXABASE_A - TAXA_R9901)
                    *positif(FLAG_RETARD + FLAG_DEFAUT))
		+ min(DO_INR_TAXA_A,arr((TAXA_R9901 - TAXABASE_A) * TXINR_PA/100))*positif(TAXA_TLDEC - TAXABASE_A)
                    * positif(TAXA_R9901-TAXABASE_A)
                    *positif(DO_INR_TAXA_A)
		    *positif(FLAG_RETARD + FLAG_DEFAUT);
DO_TAXA2 = (TAXA_REF - TAXA_TLDEC_1) * positif(TAXA_REF - TAXA_TLDEC_1)* positif(TAXABASE_A);
SUP_TAXA_MAX2 = (TAXA_REF - max(0,TAXA_R9901)) * positif(TAXA_REF - max(0,TAXA_R9901))* positif(TAXABASE_A);
INR_TAXAGA_TOT = max(INRTAXA_NTLDECD+INRTAXA_NTLDEC_1 + (INRTAXA_TLDEC+INRTAXA_TLDEC_1)*TL_TAXAGA-INR_TAXAGA_TARDIF*null(1-IND_PASSAGE)+INRTAXA_R99R+RECUP_INR_TAXA,0) 
	      * (1-IND_RJLJ);
INRTAXA_RECT= arr(TAXAGA_RECT * (TXINR_PA/100)) * positif(TAXAGA_RECT) * FLAG_RECTIF;
INCTAXA_TL2 = INRTAXA_TLDECD;
INCTAXA_TL_12 = INRTAXA_TLDEC_1;
INTAXA_TL2 = INRTAXA_TLA * TL_TAXAGA;
INTAXA_TL_12 = INRTAXA_TLA_1 * TL_TAXAGA;
INRTAXA_NET2 = max(INRTAXA_NTLDECD+INRTAXA_TLDECD*TL_TAXAGA+INRTAXA_R99R+RECUP_INR_TAXA,0)*(1-IND_RJLJ)+DO_INR_TAXA2 * (-1);
INRTAXA_NET_12 = max(INRTAXA_NTLDECD_1+INRTAXA_TLDEC_1*TL_TAXAGA,0)*(1-IND_RJLJ);
INCTAXA_NET2 = (INRTAXA_NET2 + INRTAXA_NET_12 + INCTAXA_NET_A+(INRTAXA_TL_A+INRTAXA_TL_1_A)*(1-null(TL_TAXAGA_A-TL_TAXAGA))*positif(TL_TAXAGA)) * positif(TAXABASE)* (1-IND_RJLJ);
TAXAGA_PRI2=TAXA_R9901;
TAXAGA_ANT2=TAXABASE_A;
TAXAGA_NTL2=TAXA_NTLDEC;
TAXAGA_NTL_12=TAXA_NTLDEC_1;
TAXAGA_TL2=TAXA_TLDEC;
TAXAGA_TL_12=TAXA_TLDEC_1;
TAXA_REF_INR=TAXA_REF;
INRCSAL_R99RA = INRCSAL_R99R_A;
INRCSAL_R99R = arr((CSAL_R99R-CSALPROV) * (TXINR_PA/100)-INCCSAL_NET_A) * positif(CSAL_R99R-CSAL_R99R_A)*positif(IND_PASSAGE-1);
INRCSAL_R9901A = INRCSAL_R9901_A;
INRCSAL_R9901 = arr(CSAL_R9901 * (TXINR_PA/100)-INCCSAL_NET_A) * positif(CSAL_R9901- CSAL_R9901_A)
              * positif(IND_PASSAGE-1) * positif(CSAL_TLDEC-CSAL_R9901) * positif(CSAL_R9901_A)
             + (arr(CSAL_R9901 * (TXINR_PA/100))-INCCSAL_NET_A) * positif(CSAL_R9901- CSALBASE_A)
              * positif(IND_PASSAGE-1) * positif(CSAL_TLDEC-CSAL_R9901) * (1-positif(CSAL_R9901_A))
             + (INCCSAL_NET_A - arr(CSAL_R9901 * (TXINR_PA/100))) * positif(CSALBASE_A- CSAL_R9901)
              * positif(IND_PASSAGE-1) * positif(CSAL_TLDEC-CSAL_R9901) * (1-positif(CSAL_R9901_A)) * positif(CSAL_R9901)
	     ;
DO_INR_CSALC=DO_INR_CSAL_A;
INR_NTL_GLOB_CSAL2 = INRCSAL_NTLDECD + INRCSAL_NTL_A+ INRCSAL_NTLDECD_1 + INRCSAL_NTL_1_A;
INR_TL_GLOB_CSAL2 = INRCSAL_TLDECD + INRCSAL_TL_A+ INRCSAL_TLDEC_1 + INRCSAL_TL_1_A;
INR_TOT_GLOB_CSAL2 = max(0,INR_NTL_GLOB_CSAL2 + INR_TL_GLOB_CSAL2*TL_CSAL+INRCSAL_R99R+INRCSAL_R99R_A) * (1-IND_RJLJ);
INR_TOT_GLOB_CSALC= (INRCSAL_NTLDECD+ INRCSAL_NTL_A+ (INRCSAL_TLDECD + INRCSAL_TL_A)*TL_CSAL +INRCSAL_R99R+INRCSAL_R99R_A) * (1-IND_RJLJ) ;
DO_INR_CSAL2 = max(0,
           (arr(((INRCSAL_TL_A+INRCSAL_TL_1_A)*TL_CSAL_A*TL_CSAL + INRCSAL_NTL_A+INRCSAL_NTL_1_A)
           * min(1,((CSAL_REF - CSAL_TLDEC_1)/(CSAL_REF-max(0,CSAL_R9901))))) 
             * (1-positif(FLAG_RETARD + FLAG_DEFAUT))
             * positif(CSAL_REF - CSAL_TLDEC_1)* positif(CSAL_REF - (max(0,CSAL_R9901))))
              * (1-positif(FLAG_C02+FLAG_C22))
	     *(1-positif_ou_nul(CSAL_TLDEC_1 - CSALBASE_A))
           +arr(((INRCSAL_TL_A+INRCSAL_TL_1_A)*TL_CSAL_A*TL_CSAL)
             * min(1,((CSAL_REF - CSAL_TLDEC_1)/(CSAL_REF-max(0,CSAL_R9901)))))
             * (1-positif(FLAG_RETARD + FLAG_DEFAUT))
             * positif(CSAL_REF - CSAL_TLDEC_1)* positif(CSAL_REF - (max(0,CSAL_R9901)))
             * positif(FLAG_C02+FLAG_C22)
             *(1-positif_ou_nul(CSAL_TLDEC_1 - CSALBASE_A))
             * (1-positif(INRCSAL_NTL_A+INRCSAL_NTL_1_A))
          + (INRCSAL_NTL_A*FLAG_C02+INRCSAL_NTL_1_A*FLAG_C22) 
             *positif(CSAL_REF - CSAL_TLDEC_1)* positif(CSAL_REF - (max(0,CSAL_R9901))) * positif(FLAG_C02+FLAG_C22)
             * positif(INRCSAL_NTL_A)*positif(INRCSAL_NTL_1_A)
          + (INRCSAL_NTL_A*FLAG_C02+INRCSAL_NTL_1_A*FLAG_C22) 
             *positif(CSAL_REF - CSAL_TLDEC_1)* positif(CSAL_REF - (max(0,CSAL_R9901))) * positif(FLAG_C02+FLAG_C22)
             * min(1,((CSAL_REF - CSAL_TLDEC_1)/(CSAL_REF-max(0,CSAL_R9901))))
             * (1-positif(INRCSAL_NTL_A)*positif(INRCSAL_NTL_1_A))
          + ((INRCSAL_TL_A+INRCSAL_TL_1_A)*null(TL_CSAL) * TL_CSAL_A
          * (1- FLAG_DEFAUT)
             *positif(CSAL_REF - CSAL_TLDEC_1)* positif(CSAL_REF - (max(0,CSAL_R9901))))
         + ((INRCSAL_TL_A + INRCSAL_R99R_A+INRCSAL_NTL_A - max(0,arr(CSAL_TLDEC * TXINR_PA/100))) * positif(CSAL_R9901 - CSAL_TLDEC)
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * positif(ACODELAISINR)
         + ((INRCSAL_R99R_A+INRCSAL_NTL_A - max(0,arr(CSAL_R9901 * TXINR_PA/100))) * positif(CSAL_TLDEC-(CSAL_R9901))
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
		       * positif(ACODELAISINR)
         + ((INRCSAL_TL_A + INRCSAL_R99R_A+INRCSAL_NTL_A - max(0,arr(CSAL_R9901 * TXINR_PA/100))) * null(CSAL_TLDEC-(CSAL_R9901))
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
		       * positif(ACODELAISINR)
         + (arr((INRCSAL_TL_A*TL_CSAL_A *TL_CSAL+(INRCSAL_NTL_A +INRCSAL_R99R+INRCSAL_R9901-INRCSAL_RETDEF-INR_CSAL_TARDIF) 
                       * ((CSAL_REF - CSAL_TLDEC)/(CSAL_REF-max(0,CSAL_REF_A)))))
                       * positif(CSAL_REF - CSAL_TLDEC)  * positif(CSAL_TLDEC - CSAL_R9901) 
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR+0))
                       * positif(INRCSAL_R99R_A+INRCSAL_R9901_A+0)
         + (arr((INRCSAL_TL_A*TL_CSAL_A*TL_CSAL +(INRCSAL_NTL_A+INRCSAL_RETDEF-(INR_CSAL_TARDIF-INRCSAL_R9901))
	               *(CSAL_REF - CSAL_TLDEC)/(CSAL_REF-max(0,CSAL_R9901))))
                       * positif(CSAL_REF - CSAL_TLDEC) * positif(CSAL_TLDEC - CSAL_R9901) 
	               * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR+0))
                       * (1-positif(INRCSAL_R99R_A+INRCSAL_R9901_A+0))
         + ((INR_TOT_GLOB_CSAL - DO_INR_CSAL_A - arr(CSAL_TLDEC * TXINR_PA/100))
                       * positif(CSAL_R9901 - CSAL_TLDEC) 
                       * positif(CSAL_REF - CSAL_TLDEC)
	               * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR+0))
         + ((INRCSAL_R99R_A + INRCSAL_NTL_A- arr(CSAL_R9901 * TXINR_PA/100)) * null(CSAL_TLDEC - CSAL_R9901)
                       * positif(CSAL_REF - CSAL_TLDEC)
		       * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR))
            );

RECUP_INR_CSAL = (min(DO_INR_CSAL_A,arr(DO_INR_CSAL_A * (CSAL_TLDEC - CSALBASE_A)/DO_CSAL_A))
                    *positif(CSAL_TLDEC-CSALBASE_A)*positif(CSAL_REF-CSALBASE_A)
                    * positif(CSALBASE_A - CSAL_R9901)
                    *positif(FLAG_RETARD + FLAG_DEFAUT))
		+ min(DO_INR_CSAL_A,arr((CSAL_R9901 - CSALBASE_A) * TXINR_PA/100))*positif(CSAL_TLDEC - CSALBASE_A)
                    * positif(CSAL_R9901-CSALBASE_A)
                    *positif(DO_INR_CSAL_A)
		    *positif(FLAG_RETARD + FLAG_DEFAUT);
DO_CSAL2 = (CSAL_REF - CSAL_TLDEC_1) * positif(CSAL_REF - CSAL_TLDEC_1)* positif(CSALBASE_A);
SUP_CSAL_MAX2 = (CSAL_REF - max(0,CSAL_R9901)) * positif(CSAL_REF - max(0,CSAL_R9901))* positif(CSALBASE_A);
INR_CSAL_TOT = max(INRCSAL_NTLDECD+INRCSAL_NTLDECD_1 + (INRCSAL_TLDECD+INRCSAL_TLDEC_1)*TL_CSAL-INR_CSAL_TARDIF*null(1-IND_PASSAGE)+INRCSAL_R99R+RECUP_INR_CSAL,0) 
	      * (1-IND_RJLJ);
INRCSAL_RECT= arr((CSAL_RECT-CSALPROV) * (TXINR_PA/100)) * positif(CSAL_RECT) * FLAG_RECTIF;
INCCSAL_TL2 = INRCSAL_TLDECD;
INCCSAL_TL_12 = INRCSAL_TLDEC_1;
INCSAL_TL2 = INRCSAL_TLA * TL_CSAL;
INCSAL_TL_12 = INRCSAL_TLA_1 * TL_CSAL;
INRCSAL_NET2 = max(INRCSAL_NTLDECD+INRCSAL_TLDECD*TL_CSAL+INRCSAL_R99R+RECUP_INR_CSAL,0)*(1-IND_RJLJ)+DO_INR_CSAL2 * (-1);
INRCSAL_NET_12 = max(INRCSAL_NTLDECD_1+INRCSAL_TLDEC_1*TL_CSAL,0)*(1-IND_RJLJ);
INCCSAL_NET2 = (INRCSAL_NET2 + INRCSAL_NET_12 + INCCSAL_NET_A+(INRCSAL_TL_A+INRCSAL_TL_1_A)*(1-null(TL_CSAL_A-TL_CSAL))*positif(TL_CSAL)) * positif(CSALBASE)* (1-IND_RJLJ);
CSAL_PRI2=CSAL_R9901;
CSAL_ANT2=CSALBASE_A;
CSAL_NTL2=CSAL_NTLDEC;
CSAL_NTL_12=CSAL_NTLDEC_1;
CSAL_TL2=CSAL_TLDEC;
CSAL_TL_12=CSAL_TLDEC_1;
CSAL_REF_INR=CSAL_REF;
INRCDIS_R99RA = INRCDIS_R99R_A;
INRCDIS_R99R = arr((CDIS_R99R-CSALPROV) * (TXINR_PA/100)-INCCDIS_NET_A) * positif(CDIS_R99R-CDIS_R99R_A)*positif(IND_PASSAGE-1);
INRCDIS_R9901A = INRCDIS_R9901_A;
INRCDIS_R9901 = arr(CDIS_R9901 * (TXINR_PA/100)-INCCDIS_NET_A) * positif(CDIS_R9901- CDIS_R9901_A)
              * positif(IND_PASSAGE-1) * positif(CDIS_TLDEC-CDIS_R9901) * positif(CDIS_R9901_A)
             + (arr(CDIS_R9901 * (TXINR_PA/100))-INCCDIS_NET_A) * positif(CDIS_R9901- CDISBASE_A)
              * positif(IND_PASSAGE-1) * positif(CDIS_TLDEC-CDIS_R9901) * (1-positif(CDIS_R9901_A))
             + (INCCDIS_NET_A - arr(CDIS_R9901 * (TXINR_PA/100))) * positif(CDISBASE_A- CDIS_R9901)
              * positif(IND_PASSAGE-1) * positif(CDIS_TLDEC-CDIS_R9901) * (1-positif(CDIS_R9901_A)) * positif(CDIS_R9901)
	     ;
DO_INR_CDISC=DO_INR_CDIS_A;
INR_NTL_GLOB_CDIS2 = INRCDIS_NTLDECD + INRCDIS_NTL_A+ INRCDIS_NTLDECD_1 + INRCDIS_NTL_1_A;
INR_TL_GLOB_CDIS2 = INRCDIS_TLDECD + INRCDIS_TL_A+ INRCDIS_TLDEC_1 + INRCDIS_TL_1_A;
INR_TOT_GLOB_CDIS2 = max(0,INR_NTL_GLOB_CDIS2 + INR_TL_GLOB_CDIS2*TL_CDIS+INRCDIS_R99R+INRCDIS_R99R_A) * (1-IND_RJLJ);
INR_TOT_GLOB_CDISC= (INRCDIS_NTLDECD+ INRCDIS_NTL_A+ (INRCDIS_TLDECD + INRCDIS_TL_A)*TL_CDIS +INRCDIS_R99R+INRCDIS_R99R_A) * (1-IND_RJLJ) ;
DO_INR_CDIS2 = max(0,
           (arr(((INRCDIS_TL_A+INRCDIS_TL_1_A)*TL_CDIS_A*TL_CDIS + INRCDIS_NTL_A+INRCDIS_NTL_1_A)
           * min(1,((CDIS_REF - CDIS_TLDEC_1)/(CDIS_REF-max(0,CDIS_R9901))))) 
             * (1-positif(FLAG_RETARD + FLAG_DEFAUT))
             * positif(CDIS_REF - CDIS_TLDEC_1)* positif(CDIS_REF - (max(0,CDIS_R9901))))
              * (1-positif(FLAG_C02+FLAG_C22))
	     *(1-positif_ou_nul(CDIS_TLDEC_1 - CDISBASE_A))
           +arr(((INRCDIS_TL_A+INRCDIS_TL_1_A)*TL_CDIS_A*TL_CDIS)
             * min(1,((CDIS_REF - CDIS_TLDEC_1)/(CDIS_REF-max(0,CDIS_R9901)))))
             * (1-positif(FLAG_RETARD + FLAG_DEFAUT))
             * positif(CDIS_REF - CDIS_TLDEC_1)* positif(CDIS_REF - (max(0,CDIS_R9901)))
             * positif(FLAG_C02+FLAG_C22)
             *(1-positif_ou_nul(CDIS_TLDEC_1 - CDISBASE_A))
             * (1-positif(INRCDIS_NTL_A+INRCDIS_NTL_1_A))
          + (INRCDIS_NTL_A*FLAG_C02+INRCDIS_NTL_1_A*FLAG_C22) 
             *positif(CDIS_REF - CDIS_TLDEC_1)* positif(CDIS_REF - (max(0,CDIS_R9901))) * positif(FLAG_C02+FLAG_C22)
             * positif(INRCDIS_NTL_A)*positif(INRCDIS_NTL_1_A)
          + (INRCDIS_NTL_A*FLAG_C02+INRCDIS_NTL_1_A*FLAG_C22) 
             *positif(CDIS_REF - CDIS_TLDEC_1)* positif(CDIS_REF - (max(0,CDIS_R9901))) * positif(FLAG_C02+FLAG_C22)
             * min(1,((CDIS_REF - CDIS_TLDEC_1)/(CDIS_REF-max(0,CDIS_R9901))))
             * (1-positif(INRCDIS_NTL_A)*positif(INRCDIS_NTL_1_A))
          + ((INRCDIS_TL_A+INRCDIS_TL_1_A)*null(TL_CDIS) * TL_CDIS_A
          * (1- FLAG_DEFAUT)
             *positif(CDIS_REF - CDIS_TLDEC_1)* positif(CDIS_REF - (max(0,CDIS_R9901))))
         + ((INRCDIS_TL_A + INRCDIS_R99R_A+INRCDIS_NTL_A - max(0,arr(CDIS_TLDEC * TXINR_PA/100))) * positif(CDIS_R9901 - CDIS_TLDEC)
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * positif(ACODELAISINR)
         + ((INRCDIS_R99R_A+INRCDIS_NTL_A - max(0,arr(CDIS_R9901 * TXINR_PA/100))) * positif(CDIS_TLDEC-(CDIS_R9901))
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
		       * positif(ACODELAISINR)
         + ((INRCDIS_TL_A + INRCDIS_R99R_A+INRCDIS_NTL_A - max(0,arr(CDIS_R9901 * TXINR_PA/100))) * null(CDIS_TLDEC-(CDIS_R9901))
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
		       * positif(ACODELAISINR)
         + (arr((INRCDIS_TL_A*TL_CDIS_A *TL_CDIS+(INRCDIS_NTL_A +INRCDIS_R99R+INRCDIS_R9901-INRCDIS_RETDEF-INR_CDIS_TARDIF) 
                       * ((CDIS_REF - CDIS_TLDEC)/(CDIS_REF-max(0,CDIS_REF_A)))))
                       * positif(CDIS_REF - CDIS_TLDEC)  * positif(CDIS_TLDEC - CDIS_R9901) 
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR+0))
                       * positif(INRCDIS_R99R_A+INRCDIS_R9901_A+0)
         + (arr((INRCDIS_TL_A*TL_CDIS_A*TL_CDIS +(INRCDIS_NTL_A+INRCDIS_RETDEF-(INR_CDIS_TARDIF-INRCDIS_R9901))
	               *(CDIS_REF - CDIS_TLDEC)/(CDIS_REF-max(0,CDIS_R9901))))
                       * positif(CDIS_REF - CDIS_TLDEC) * positif(CDIS_TLDEC - CDIS_R9901) 
	               * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR+0))
                       * (1-positif(INRCDIS_R99R_A+INRCDIS_R9901_A+0))
         + ((INR_TOT_GLOB_CDIS - DO_INR_CDIS_A - arr(CDIS_TLDEC * TXINR_PA/100))
                       * positif(CDIS_R9901 - CDIS_TLDEC) 
                       * positif(CDIS_REF - CDIS_TLDEC)
	               * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR+0))
         + ((INRCDIS_R99R_A + INRCDIS_NTL_A- arr(CDIS_R9901 * TXINR_PA/100)) * null(CDIS_TLDEC - CDIS_R9901)
                       * positif(CDIS_REF - CDIS_TLDEC)
		       * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR))
            );

RECUP_INR_CDIS = (min(DO_INR_CDIS_A,arr(DO_INR_CDIS_A * (CDIS_TLDEC - CDISBASE_A)/DO_CDIS_A))
                    *positif(CDIS_TLDEC-CDISBASE_A)*positif(CDIS_REF-CDISBASE_A)
                    * positif(CDISBASE_A - CDIS_R9901)
                    *positif(FLAG_RETARD + FLAG_DEFAUT))
		+ min(DO_INR_CDIS_A,arr((CDIS_R9901 - CDISBASE_A) * TXINR_PA/100))*positif(CDIS_TLDEC - CDISBASE_A)
                    * positif(CDIS_R9901-CDISBASE_A)
                    *positif(DO_INR_CDIS_A)
		    *positif(FLAG_RETARD + FLAG_DEFAUT);
DO_CDIS2 = (CDIS_REF - CDIS_TLDEC_1) * positif(CDIS_REF - CDIS_TLDEC_1)* positif(CDISBASE_A);
SUP_CDIS_MAX2 = (CDIS_REF - max(0,CDIS_R9901)) * positif(CDIS_REF - max(0,CDIS_R9901))* positif(CDISBASE_A);
INR_CDIS_TOT = max(INRCDIS_NTLDECD+INRCDIS_NTLDECD_1 + (INRCDIS_TLDECD+INRCDIS_TLDEC_1)*TL_CDIS-INR_CDIS_TARDIF*null(1-IND_PASSAGE)+INRCDIS_R99R+RECUP_INR_CDIS,0) 
	      * (1-IND_RJLJ);
INRCDIS_RECT= arr(CDIS_RECT * (TXINR_PA/100)) * positif(CDIS_RECT) * FLAG_RECTIF;
INCCDIS_TL2 = INRCDIS_TLDECD;
INCCDIS_TL_12 = INRCDIS_TLDEC_1;
INCDIS_TL2 = INRCDIS_TLA * TL_CDIS;
INCDIS_TL_12 = INRCDIS_TLA_1 * TL_CDIS;
INRCDIS_NET2 = max(INRCDIS_NTLDECD+INRCDIS_TLDECD*TL_CDIS+INRCDIS_R99R+RECUP_INR_CDIS,0)*(1-IND_RJLJ)+DO_INR_CDIS2 * (-1);
INRCDIS_NET_12 = max(INRCDIS_NTLDECD_1+INRCDIS_TLDEC_1*TL_CDIS,0)*(1-IND_RJLJ);
INCCDIS_NET2 = (INRCDIS_NET2 + INRCDIS_NET_12 + INCCDIS_NET_A+(INRCDIS_TL_A+INRCDIS_TL_1_A)*(1-null(TL_CDIS_A-TL_CDIS))*positif(TL_CDIS)) * positif(CDISBASE)* (1-IND_RJLJ);
CDIS_PRI2=CDIS_R9901;
CDIS_ANT2=CDISBASE_A;
CDIS_NTL2=CDIS_NTLDEC;
CDIS_NTL_12=CDIS_NTLDEC_1;
CDIS_TL2=CDIS_TLDEC;
CDIS_TL_12=CDIS_TLDEC_1;
CDIS_REF_INR=CDIS_REF;
TINR2 = positif(DO_INR_IR2+DO_INR_CSG2+DO_INR_CRDS2+DO_INR_PS2+DO_INR_TAXA2+DO_INR_CSAL2+DO_INR_CDIS2)
      * null(DO_INR_IR_A+DO_INR_CSG_A+DO_INR_CRDS_A+DO_INR_PS_A+DO_INR_TAXA_A+DO_INR_CSAL_A+DO_INR_CDIS_A)*TXINR_A
     + positif(DO_INR_IR2+DO_INR_CSG2+DO_INR_CRDS2+DO_INR_PS2+DO_INR_TAXA2+DO_INR_CSAL2+DO_INR_CDIS2)
      *positif(DO_INR_IR_A+DO_INR_CSG_A+DO_INR_CRDS_A+DO_INR_PS_A+DO_INR_TAXA_A+DO_INR_CSAL_A+DO_INR_CDIS_A)*TINR_A
     + positif(INRIR_R99R+INRCSG_R99R+INRCRDS_R99R+INRPRS_R99R+INRTAXA_R99R+INRCSAL_R99R+INRCSAL_R99R
               +(RECUP_INR_IR+RECUP_INR_CSG+RECUP_INR_CRDS+RECUP_INR_PRS+RECUP_INR_TAXA+RECUP_INR_CSAL+RECUP_INR_CDIS)*FLAG_RECTIF)
               *TXINR_PA
     + null(DO_INR_IR2+DO_INR_CSG2+DO_INR_CRDS2+DO_INR_PS2+DO_INR_TAXA2+DO_INR_CSAL2+DO_INR_CDIS2)
      *null(INRIR_R99R+INRCSG_R99R+INRCRDS_R99R+INRPRS_R99R+INRTAXA_R99R+INRCSAL_R99R+INRCDIS_R99R
               +(RECUP_INR_IR+RECUP_INR_CSG+RECUP_INR_CRDS+RECUP_INR_PRS+RECUP_INR_TAXA+RECUP_INR_CSAL+RECUP_INR_CDIS)*FLAG_RECTIF)
               *TXINR;
TINR_12=TXINRRED/2 * positif(INRIR_NET_12+INRCSG_NET2+INRRDS_NET_12+INRPRS_NET_12+INRTAXA_NET_12+INRCSAL_NET_12+INRCDIS_NET_12
			   + null(TL_IR+TL+TL_CS+TL_TAXAGA+TL_CSAL+TL_CDIS))+
       TINR_1_A * (1- positif(INRIR_NET_12+INRCSG_NET2+INRRDS_NET_12+INRPRS_NET_12+INRTAXA_NET_12+INRCSAL_NET_12+INRCDIS_NET_12));
NBREMOIS222 = (NBMOIS + max(0,NBMOIS2))
		  * positif(INRIR_NET_12+INRCSG_NET_12+INRRDS_NET_12+INRPRS_NET_12+INRTAXA_NET_12+INRCSAL_NET_12+INRCDIS_NET_12
		  +INRIR_NET2+INRCSG_NET2 +INRRDS_NET2+INRPRS_NET2+INRTAXA_NET2+INRCSAL_NET2+INRCDIS_NET2
			    +null(TL_IR)*positif(INRIR_TLDECD+INRIR_TLDEC_1)
			    +null(TL_TAXAGA)*positif(INRTAXA_TLDECD+INRTAXA_TLDEC_1)
			    +null(TL_CSAL)*positif(INRCSAL_TLDECD+INRCSAL_TLDEC_1)
			    +null(TL_CSAL)*positif(INRCDIS_TLDECD+INRCDIS_TLDEC_1)
			    +null(TL_CS)*positif(INRCSG_TLDECD+INRCSG_TLDEC_1+INRCRDS_TLDECD+INRCRDS_TLDEC_1+INRPRS_TLDECD+INRPRS_TLDEC_1))
		  + NBREMOIS222_A * (1- positif_ou_nul(INRIR_NET_12+INRCSG_NET_12+INRRDS_NET_12+INRPRS_NET_12+INRTAXA_NET_12+INRCSAL_NET_12
		+INRCDIS_NET_12 +INRIR_NET2+INRCSG_NET2+INRRDS_NET2+INRPRS_NET2+INRTAXA_NET2+INRCSAL_NET2+INRCDIS_NET2));
NBREMOISCS222 = (NBMOIS + max(0,NBMOIS2))
		  * positif(INRCSG_NET_12+INRRDS_NET_12+INRPRS_NET_12
		            +INRCSG_NET2 +INRRDS_NET2+INRPRS_NET2
			    +null(TL_CS)*positif(INRCSG_TLDECD+INRCSG_TLDEC_1+INRCRDS_TLDECD+INRCRDS_TLDEC_1+INRPRS_TLDECD+INRPRS_TLDEC_1))
		  + NBREMOISCS222_A * (1- positif_ou_nul(INRCSG_NET_12+INRRDS_NET_12+INRPRS_NET_12
		                       +INRCSG_NET2+INRRDS_NET2+INRPRS_NET2));
INRTOT = INR_TOT_GLOB_IR+ INR_TOT_GLOB_CSG + INR_TOT_GLOB_CRDS + INR_TOT_GLOB_PS
       +INR_TOT_GLOB_TAXA
       - DO_INR_IR - DO_INR_CSG - DO_INR_CRDS - DO_INR_PS -DO_INR_TAXAGA;
INRTOT_NET = INCIR_TL + INCCS_TL + INCPS_TL + INCRD_TL+INCTAXA_TL;
INRTOT_TL = INIR_TL + INPS_TL + INRD_TL+INTAXA_TL;
