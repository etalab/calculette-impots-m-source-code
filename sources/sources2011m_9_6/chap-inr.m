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
CHR_PA = CHRBASE * null(1 - IND_PASSAGE) + CHR_PA_A;
INRCHR_RETDEF = (1 - IND_RJLJ) * (
               arr(CHRBASE * TXINR / 100) * FLAG_DEFAUT * null(IND_PASSAGE - 1)
                                )
             + INRCHR_RETDEF_A;
INR_CHR_TARDIF = (arr(CHRBASE * TXINR/100) * FLAG_RETARD * null(1-IND_PASSAGE)+INR_CHR_TARDIF_A) * (1-IND_RJLJ);
PCAP_PA = PCAPBASE * null(1 - IND_PASSAGE) + PCAP_PA_A;
INRPCAP_RETDEF = (1 - IND_RJLJ) * (
               arr(PCAPBASE * TXINR / 100) * FLAG_DEFAUT * null(IND_PASSAGE - 1)
                                )
             + INRPCAP_RETDEF_A;
INR_PCAP_TARDIF = (arr(PCAPBASE * TXINR/100) * FLAG_RETARD * null(1-IND_PASSAGE)+INR_PCAP_TARDIF_A) * (1-IND_RJLJ);
GAIN_PA = GAINBASE * null(1 - IND_PASSAGE) + GAIN_PA_A;
INRGAIN_RETDEF = (1 - IND_RJLJ) * (
               arr(GAINBASE * TXINR / 100) * FLAG_DEFAUT * null(IND_PASSAGE - 1)
                                )
             + INRGAIN_RETDEF_A;
INR_GAIN_TARDIF = (arr(GAINBASE * TXINR/100) * FLAG_RETARD * null(1-IND_PASSAGE)+INR_GAIN_TARDIF_A) * (1-IND_RJLJ);
RSE1_PA = RSE1BASE * null(1 - IND_PASSAGE) + RSE1_PA_A;
INRRSE1_RETDEF = (1 - IND_RJLJ) * (
               arr(RSE1BASE * TXINR / 100) * FLAG_DEFAUT * null(IND_PASSAGE - 1)
                                )
             + INRRSE1_RETDEF_A;
INR_RSE1_TARDIF = (arr(RSE1BASE * TXINR/100) * FLAG_RETARD * null(1-IND_PASSAGE)+INR_RSE1_TARDIF_A) * (1-IND_RJLJ);
RSE2_PA = RSE2BASE * null(1 - IND_PASSAGE) + RSE2_PA_A;
INRRSE2_RETDEF = (1 - IND_RJLJ) * (
               arr(RSE2BASE * TXINR / 100) * FLAG_DEFAUT * null(IND_PASSAGE - 1)
                                )
             + INRRSE2_RETDEF_A;
INR_RSE2_TARDIF = (arr(RSE2BASE * TXINR/100) * FLAG_RETARD * null(1-IND_PASSAGE)+INR_RSE2_TARDIF_A) * (1-IND_RJLJ);
RSE3_PA = RSE3BASE * null(1 - IND_PASSAGE) + RSE3_PA_A;
INRRSE3_RETDEF = (1 - IND_RJLJ) * (
               arr(RSE3BASE * TXINR / 100) * FLAG_DEFAUT * null(IND_PASSAGE - 1)
                                )
             + INRRSE3_RETDEF_A;
INR_RSE3_TARDIF = (arr(RSE3BASE * TXINR/100) * FLAG_RETARD * null(1-IND_PASSAGE)+INR_RSE3_TARDIF_A) * (1-IND_RJLJ);
RSE4_PA = RSE4BASE * null(1 - IND_PASSAGE) + RSE4_PA_A;
INRRSE4_RETDEF = (1 - IND_RJLJ) * (
               arr(RSE4BASE * TXINR / 100) * FLAG_DEFAUT * null(IND_PASSAGE - 1)
                                )
             + INRRSE4_RETDEF_A;
INR_RSE4_TARDIF = (arr(RSE4BASE * TXINR/100) * FLAG_RETARD * null(1-IND_PASSAGE)+INR_RSE4_TARDIF_A) * (1-IND_RJLJ);
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
CHR_TLDEC_1=IHAUTREVT;
PCAP_TLDEC_1=IPCAPTAXT;
GAIN_TLDEC_1=CGAINSAL;
RSE1_TLDEC_1=RSE1;
RSE2_TLDEC_1=RSE2;
RSE3_TLDEC_1=RSE3;
RSE4_TLDEC_1=RSE4;
CSAL_TLDEC_1=CSAL;
CDIS_TLDEC_1=CDIS;
regle corrective 108112:
application : oceans, iliad ;
INRIR_NTL = (1 - IND_RJLJ) * (1-FLAG_NINR) * (
			 null(2-FLAG_INR) * positif(IRNIN_INR - IRNIN_R99R)
                       * (
            (positif(IRNIN_INR - max(IRNIN_REF * (1-present(IRNIN_NTLDEC_198)),IRNIN_NTLDEC_198+0) )
            * arr((IRNIN_INR - max(IRNIN_REF * (1-present(IRNIN_NTLDEC_198)),IRNIN_NTLDEC_198+0)) * (TXINR / 100))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(IRNIN_INR - max(IRNIN_REF * (1-present(IRNIN_NTLDEC_198)),IRNIN_NTLDEC_198+0))
            * positif(IRNIN_INR-max(IRNIN_RECT * (1-present(IRNIN_NTLDEC_198)),IRNIN_NTLDEC_198+0))
            * arr((IRNIN_INR - max(IRNIN_REF * (1-present(IRNIN_NTLDEC_198)),IRNIN_NTLDEC_198+0)) * (TXINR / 100))
            * positif(FLAG_DEFAUT+FLAG_RETARD) * positif(IND_PASSAGE - 1))
                             )
                   +  null(3-FLAG_INR) * positif(IRNIN_INR - IRNIN_REF)
                       * (
            (positif(IRNIN_INR - max(IRNIN_REF * (1-present(IRNIN_NTLDEC_198)),IRNIN_NTLDEC_198+0) )
            * arr((min(IRNIN_INR,IRNIN_TLDEC_1) - max(IRNIN_REF * (1-present(IRNIN_NTLDEC_198)),IRNIN_NTLDEC_198+0)) * (TXINR / 100))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(IRNIN_INR - max(IRNIN_REF * (1-present(IRNIN_NTLDEC_198)),IRNIN_NTLDEC_198+0))
            * positif(IRNIN_INR-max(IRNIN_RECT * (1-present(IRNIN_NTLDEC_198)),IRNIN_NTLDEC_198+0))
            * arr((min(IRNIN_INR,IRNIN_TLDEC_1) - max(IRNIN_REF * (1-present(IRNIN_NTLDEC_198)),IRNIN_NTLDEC_198+0)) * (TXINR / 100))
            * positif(FLAG_DEFAUT+FLAG_RETARD) * positif(IND_PASSAGE - 1))
                             )
            + INRIR_RETDEF * null(IND_PASSAGE - 1)
                                                )
                                               ;
INRCSG_NTL = (1 - IND_RJLJ) * (1-FLAG_NINR) * (
			 null(2 - FLAG_INR) * positif(CSG-CSG_R99R) 
			* (
            (positif(CSG * positif(CSG+PRS+RDSN-SEUIL_REC_CP2) - max(CSG_NTLDEC_198,CSG_REF* (1-present(CSG_NTLDEC_198))))
            * arr((CSG - max(CSG_NTLDEC_198,CSG_REF* (1-present(CSG_NTLDEC_198)))-CSGIM) * (TXINR / 100))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(CSG* positif(CSG+PRS+RDSN-SEUIL_REC_CP2)  - max(CSG_NTLDEC_198,CSG_REF* (1-present(CSG_NTLDEC_198))))
            * arr((CSG - max(CSG_NTLDEC_198,CSG_REF* (1-present(CSG_NTLDEC_198)))-CSGIM) * (TXINR / 100))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                              )
                      + null(3 - FLAG_INR) * positif(CSG-CSG_REF) 
			* (
            (positif(CSG * positif(CSG+PRS+RDSN-SEUIL_REC_CP2) - max(CSG_NTLDEC_198,CSG_REF* (1-present(CSG_NTLDEC_198))))
            * arr((min(CSG,CSG_TLDEC_1) - max(CSG_NTLDEC_198,CSG_REF* (1-present(CSG_NTLDEC_198)))-CSGIM) * (TXINR / 100))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(CSG* positif(CSG+PRS+RDSN-SEUIL_REC_CP2)  - max(CSG_NTLDEC_198,CSG_REF* (1-present(CSG_NTLDEC_198))+0))
            * arr((min(CSG,CSG_TLDEC_1) - max(CSG_NTLDEC_198,CSG_REF)* (1-present(CSG_NTLDEC_198))-CSGIM) * (TXINR / 100))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
			    )
            + INRCSG_RETDEF * null(IND_PASSAGE - 1)
                              )
             ;
INRPRS_NTL = (1 - IND_RJLJ) * (1-FLAG_NINR) * (
			   null(2 - FLAG_INR) * positif(PRS-PRS_R99R) 
			   * (
            (positif(PRS* positif(CSG+PRS+RDSN-SEUIL_REC_CP2)  - max(PRS_NTLDEC_198,PRS_REF* (1-present(PRS_NTLDEC_198))+0)) 
            * arr((PRS  - max(PRS_NTLDEC_198,PRS_REF* (1-present(PRS_NTLDEC_198)))-PRSPROV) * (TXINR / 100))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(PRS * positif(CSG+PRS+RDSN-SEUIL_REC_CP2) - max(PRS_NTLDEC_198,PRS_REF* (1-present(PRS_NTLDEC_198))+0))
            * arr((PRS - max(PRS_NTLDEC_198,PRS_REF* (1-present(PRS_NTLDEC_198)))-PRSPROV) * (TXINR / 100))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                        )
                        + null(3 - FLAG_INR) * positif(PRS-PRS_REF) 
			   * (
            (positif(PRS* positif(CSG+PRS+RDSN-SEUIL_REC_CP2)  - max(PRS_NTLDEC_198,PRS_REF* (1-present(PRS_NTLDEC_198))+0)) 
            * arr((min(PRS,PRS_TLDEC_1)  - max(PRS_NTLDEC_198,PRS_REF* (1-present(PRS_NTLDEC_198)))-PRSPROV) * (TXINR / 100))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(PRS * positif(CSG+PRS+RDSN-SEUIL_REC_CP2) - max(PRS_NTLDEC_198,PRS_REF* (1-present(PRS_NTLDEC_198))+0))
            * arr((min(PRS,PRS_TLDEC_1) - max(PRS_NTLDEC_198,PRS_REF* (1-present(PRS_NTLDEC_198)))-PRSPROV) * (TXINR / 100))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                        )
            + INRPRS_RETDEF * null(IND_PASSAGE - 1)
                            )
             ;
INRCRDS_NTL = (1 - IND_RJLJ) * (1-FLAG_NINR) * (
		       null(2 - FLAG_INR) * positif(RDSN - RDS_R99R) 
		      * (
            (positif(RDSN * positif(CSG+PRS+RDSN-SEUIL_REC_CP2) - max(CRDS_NTLDEC_198,RDS_REF* (1-present(CRDS_NTLDEC_198))+0))
            * arr((RDSN - max(CRDS_NTLDEC_198,RDS_REF* (1-present(CRDS_NTLDEC_198)))-CRDSIM) * (TXINR / 100))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(RDSN * positif(CSG+PRS+RDSN-SEUIL_REC_CP2) - max(CRDS_NTLDEC_198,RDS_REF* (1-present(CRDS_NTLDEC_198))+0))
            * arr((RDSN -max(CRDS_NTLDEC_198,RDS_REF* (1-present(CRDS_NTLDEC_198)))-CRDSIM) * (TXINR / 100))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                         )
                    +  null(3 - FLAG_INR) * positif(RDSN - RDS_REF) 
		      * (
            (positif(RDSN * positif(CSG+PRS+RDSN-SEUIL_REC_CP2) - max(CRDS_NTLDEC_198,RDS_REF* (1-present(CRDS_NTLDEC_198))+0))
            * arr((min(RDSN,RDS_TLDEC_1) - max(CRDS_NTLDEC_198,RDS_REF* (1-present(CRDS_NTLDEC_198)))-CRDSIM) * (TXINR / 100))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(RDSN * positif(CSG+PRS+RDSN-SEUIL_REC_CP2) - max(CRDS_NTLDEC_198,RDS_REF* (1-present(CRDS_NTLDEC_198))+0))
            * arr((min(RDSN,RDS_TLDEC_1) -max(CRDS_NTLDEC_198,RDS_REF* (1-present(CRDS_NTLDEC_198)))-CRDSIM) * (TXINR / 100))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                         )
            + INRCRDS_RETDEF * null(IND_PASSAGE - 1)
                            )
             ;
INRTAXA_NTL = (1 - IND_RJLJ) * (1-FLAG_NINR) * (
		     null(2 - FLAG_INR) * positif(TAXABASE - TAXA_R99R) 
		     * (
             (positif(TAXABASE - max(TAXA_NTLDEC_198,TAXA_REF* (1-present(TAXA_NTLDEC_198))+0))
            * arr((TAXABASE - max(TAXA_NTLDEC_198,TAXA_REF* (1-present(TAXA_NTLDEC_198)))) * (TXINR / 100))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(TAXABASE - max(TAXA_NTLDEC_198,TAXA_REF* (1-present(TAXA_NTLDEC_198))+0))
            * arr((TAXABASE - max(TAXA_NTLDEC_198,TAXA_REF* (1-present(TAXA_NTLDEC_198)))) * (TXINR / 100))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
		     + null(3 - FLAG_INR) * positif(TAXABASE - TAXA_REF) 
		     * (
             (positif(TAXABASE - max(TAXA_NTLDEC_198,TAXA_REF* (1-present(TAXA_NTLDEC_198))+0))
            * arr((min(TAXABASE,TAXA_TLDEC_1) - max(TAXA_NTLDEC_198,TAXA_REF* (1-present(TAXA_NTLDEC_198)))) * (TXINR / 100))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(TAXABASE - max(TAXA_NTLDEC_198,TAXA_REF* (1-present(TAXA_NTLDEC_198))+0))
            * arr((min(TAXABASE,TAXA_TLDEC_1) - max(TAXA_NTLDEC_198,TAXA_REF* (1-present(TAXA_NTLDEC_198)))) * (TXINR / 100))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
            + INRTAXA_RETDEF * null(IND_PASSAGE - 1)
                            )
	     ; 
INRCSAL_NTL = (1 - IND_RJLJ) * (1-FLAG_NINR) * (
		       null(2 - FLAG_INR) * positif(CSALBASE - CSAL_R99R) 
		       * (
             (positif(CSALBASE - max(CSAL_NTLDEC_198,CSAL_REF* (1-present(CSAL_NTLDEC_198))+0))
            * arr((CSALBASE - max(CSAL_NTLDEC_198,CSAL_REF* (1-present(CSAL_NTLDEC_198)))-CSALPROV) * (TXINR / 100))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(CSALBASE - max(CSAL_NTLDEC_198,CSAL_REF* (1-present(CSAL_NTLDEC_198))+0)) 
            * arr((CSALBASE - max(CSAL_NTLDEC_198,CSAL_REF* (1-present(CSAL_NTLDEC_198)))-CSALPROV) * (TXINR / 100))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
		       + null(3 - FLAG_INR) * positif(CSALBASE - CSAL_REF) 
		       * (
             (positif(CSALBASE - max(CSAL_NTLDEC_198,CSAL_REF+0)-CSALPROV* (1-present(CSAL_NTLDEC_198)))
            * arr((min(CSALBASE,CSAL_TLDEC_1) - max(CSAL_NTLDEC_198,CSAL_REF* (1-present(CSAL_NTLDEC_198)))-CSALPROV) * (TXINR / 100))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(CSALBASE - max(CSAL_NTLDEC_198,CSAL_REF-CSALPROV* (1-present(CSAL_NTLDEC_198))+0))
            * arr((min(CSALBASE,CSAL_TLDEC_1) - max(CSAL_NTLDEC_198,CSAL_REF* (1-present(CSAL_NTLDEC_198)))-CSALPROV) * (TXINR / 100))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
            + INRCSAL_RETDEF * null(IND_PASSAGE - 1)
                            )
	     ; 
INRCDIS_NTL = (1 - IND_RJLJ) * (1-FLAG_NINR) * (
		       null(2 - FLAG_INR) * positif(CDISBASE - CDIS_R99R) 
		       * (
             (positif(CDISBASE - max(CDIS_NTLDEC_198,CDIS_REF* (1-present(CDIS_NTLDEC_198))+0))
            * arr((CDISBASE - max(CDIS_NTLDEC_198,CDIS_REF* (1-present(CDIS_NTLDEC_198)))-CDISPROV) * (TXINR / 100))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(CDISBASE - max(CDIS_NTLDEC_198,CDIS_REF* (1-present(CDIS_NTLDEC_198))+0)) 
            * arr((CDISBASE - max(CDIS_NTLDEC_198,CDIS_REF* (1-present(CDIS_NTLDEC_198)))-CDISPROV) * (TXINR / 100))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
		       + null(3 - FLAG_INR) * positif(CDISBASE - CDIS_REF) 
		       * (
             (positif(CDISBASE - max(CDIS_NTLDEC_198,CDIS_REF+0))
            * arr((min(CDISBASE,CDIS_TLDEC_1) - max(CDIS_NTLDEC_198,CDIS_REF* (1-present(CDIS_NTLDEC_198)))-CDISPROV) * (TXINR / 100))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(CDISBASE - max(CDIS_NTLDEC_198,CDIS_REF* (1-present(CDIS_NTLDEC_198))+0))
            * arr((min(CDISBASE,CDIS_TLDEC_1) - max(CDIS_NTLDEC_198,CDIS_REF* (1-present(CDIS_NTLDEC_198)))-CDISPROV) * (TXINR / 100))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
            + INRCDIS_RETDEF * null(IND_PASSAGE - 1)
                            )
	     ; 
INRCHR_NTL = (1 - IND_RJLJ) * (1-FLAG_NINR) * (
		       null(2 - FLAG_INR) * positif(CHRBASE - CHR_R99R) 
		       * (
             (positif(CHRBASE - max(CHR_NTLDEC_198,CHR_REF* (1-present(CHR_NTLDEC_198))+0))
            * arr((CHRBASE - max(CHR_NTLDEC_198,CHR_REF* (1-present(CHR_NTLDEC_198)))) * (TXINR / 100))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(CHRBASE - max(CHR_NTLDEC_198,CHR_REF* (1-present(CHR_NTLDEC_198))+0)) 
            * arr((CHRBASE - max(CHR_NTLDEC_198,CHR_REF* (1-present(CHR_NTLDEC_198)))) * (TXINR / 100))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
		       + null(3 - FLAG_INR) * positif(CHRBASE - CHR_REF) 
		       * (
             (positif(CHRBASE - max(CHR_NTLDEC_198,CHR_REF+0))
            * arr((min(CHRBASE,CHR_TLDEC_1) - max(CHR_NTLDEC_198,CHR_REF* (1-present(CHR_NTLDEC_198)))) * (TXINR / 100))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(CHRBASE - max(CHR_NTLDEC_198,CHR_REF* (1-present(CHR_NTLDEC_198))+0))
            * arr((min(CHRBASE,CHR_TLDEC_1) - max(CHR_NTLDEC_198,CHR_REF* (1-present(CHR_NTLDEC_198)))) * (TXINR / 100))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
            + INRCHR_RETDEF * null(IND_PASSAGE - 1)
                            )
	     ; 
INRPCAP_NTL = (1 - IND_RJLJ) * (1-FLAG_NINR) * (
		       null(2 - FLAG_INR) * positif(PCAPBASE - PCAP_R99R) 
		       * (
             (positif(PCAPBASE - max(PCAP_NTLDEC_198,PCAP_REF* (1-present(PCAP_NTLDEC_198))+0))
            * arr((PCAPBASE - max(PCAP_NTLDEC_198,PCAP_REF* (1-present(PCAP_NTLDEC_198)))) * (TXINR / 100))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(PCAPBASE - max(PCAP_NTLDEC_198,PCAP_REF* (1-present(PCAP_NTLDEC_198))+0)) 
            * arr((PCAPBASE - max(PCAP_NTLDEC_198,PCAP_REF* (1-present(PCAP_NTLDEC_198)))) * (TXINR / 100))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
		       + null(3 - FLAG_INR) * positif(PCAPBASE - PCAP_REF) 
		       * (
             (positif(PCAPBASE - max(PCAP_NTLDEC_198,PCAP_REF+0))
            * arr((min(PCAPBASE,PCAP_TLDEC_1) - max(PCAP_NTLDEC_198,PCAP_REF* (1-present(PCAP_NTLDEC_198)))) * (TXINR / 100))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(PCAPBASE - max(PCAP_NTLDEC_198,PCAP_REF* (1-present(PCAP_NTLDEC_198))+0))
            * arr((min(PCAPBASE,PCAP_TLDEC_1) - max(PCAP_NTLDEC_198,PCAP_REF* (1-present(PCAP_NTLDEC_198)))) * (TXINR / 100))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
            + INRPCAP_RETDEF * null(IND_PASSAGE - 1)
                            )
	     ; 
INRGAIN_NTL = (1 - IND_RJLJ) * (1-FLAG_NINR) * (
		       null(2 - FLAG_INR) * positif(GAINBASE - GAIN_R99R) 
		       * (
             (positif(GAINBASE - max(GAIN_NTLDEC_198,GAIN_REF* (1-present(GAIN_NTLDEC_198))+0))
            * arr((GAINBASE - max(GAIN_NTLDEC_198,GAIN_REF* (1-present(GAIN_NTLDEC_198)))-GAINPROV) * (TXINR / 100))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(GAINBASE - max(GAIN_NTLDEC_198,GAIN_REF* (1-present(GAIN_NTLDEC_198))+0)) 
            * arr((GAINBASE - max(GAIN_NTLDEC_198,GAIN_REF* (1-present(GAIN_NTLDEC_198)))-GAINPROV) * (TXINR / 100))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
		       + null(3 - FLAG_INR) * positif(GAINBASE - GAIN_REF) 
		       * (
             (positif(GAINBASE - max(GAIN_NTLDEC_198,GAIN_REF+0))
            * arr((min(GAINBASE,GAIN_TLDEC_1) - max(GAIN_NTLDEC_198,GAIN_REF* (1-present(GAIN_NTLDEC_198)))-GAINPROV) * (TXINR / 100))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(GAINBASE - max(GAIN_NTLDEC_198,GAIN_REF* (1-present(GAIN_NTLDEC_198))+0))
            * arr((min(GAINBASE,GAIN_TLDEC_1) - max(GAIN_NTLDEC_198,GAIN_REF* (1-present(GAIN_NTLDEC_198)))-GAINPROV) * (TXINR / 100))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
            + INRGAIN_RETDEF * null(IND_PASSAGE - 1)
                            )
	     ; 
INRRSE1_NTL = (1 - IND_RJLJ) * (1-FLAG_NINR) * (
		       null(2 - FLAG_INR) * positif(RSE1BASE - RSE1_R99R) 
		       * (
             (positif(RSE1BASE - max(RSE1_NTLDEC_198,RSE1_REF* (1-present(RSE1_NTLDEC_198))+0))
            * arr((RSE1BASE - max(RSE1_NTLDEC_198,RSE1_REF* (1-present(RSE1_NTLDEC_198)))) * (TXINR / 100))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(RSE1BASE - max(RSE1_NTLDEC_198,RSE1_REF* (1-present(RSE1_NTLDEC_198))+0)) 
            * arr((RSE1BASE - max(RSE1_NTLDEC_198,RSE1_REF* (1-present(RSE1_NTLDEC_198)))) * (TXINR / 100))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
		       + null(3 - FLAG_INR) * positif(RSE1BASE - RSE1_REF) 
		       * (
             (positif(RSE1BASE - max(RSE1_NTLDEC_198,RSE1_REF+0))
            * arr((min(RSE1BASE,RSE1_TLDEC_1) - max(RSE1_NTLDEC_198,RSE1_REF* (1-present(RSE1_NTLDEC_198)))) * (TXINR / 100))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(RSE1BASE - max(RSE1_NTLDEC_198,RSE1_REF* (1-present(RSE1_NTLDEC_198))+0))
            * arr((min(RSE1BASE,RSE1_TLDEC_1) - max(RSE1_NTLDEC_198,RSE1_REF* (1-present(RSE1_NTLDEC_198)))) * (TXINR / 100))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
            + INRRSE1_RETDEF * null(IND_PASSAGE - 1)
                            )
	     ; 
INRRSE2_NTL = (1 - IND_RJLJ) * (1-FLAG_NINR) * (
		       null(2 - FLAG_INR) * positif(RSE2BASE - RSE2_R99R) 
		       * (
             (positif(RSE2BASE - max(RSE2_NTLDEC_198,RSE2_REF* (1-present(RSE2_NTLDEC_198))+0))
            * arr((RSE2BASE - max(RSE2_NTLDEC_198,RSE2_REF* (1-present(RSE2_NTLDEC_198)))) * (TXINR / 100))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(RSE2BASE - max(RSE2_NTLDEC_198,RSE2_REF* (1-present(RSE2_NTLDEC_198))+0)) 
            * arr((RSE2BASE - max(RSE2_NTLDEC_198,RSE2_REF* (1-present(RSE2_NTLDEC_198)))) * (TXINR / 100))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
		       + null(3 - FLAG_INR) * positif(RSE2BASE - RSE2_REF) 
		       * (
             (positif(RSE2BASE - max(RSE2_NTLDEC_198,RSE2_REF+0))
            * arr((min(RSE2BASE,RSE2_TLDEC_1) - max(RSE2_NTLDEC_198,RSE2_REF* (1-present(RSE2_NTLDEC_198)))) * (TXINR / 100))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(RSE2BASE - max(RSE2_NTLDEC_198,RSE2_REF* (1-present(RSE2_NTLDEC_198))+0))
            * arr((min(RSE2BASE,RSE2_TLDEC_1) - max(RSE2_NTLDEC_198,RSE2_REF* (1-present(RSE2_NTLDEC_198)))) * (TXINR / 100))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
            + INRRSE2_RETDEF * null(IND_PASSAGE - 1)
                            )
	     ; 
INRRSE3_NTL = (1 - IND_RJLJ) * (1-FLAG_NINR) * (
		       null(2 - FLAG_INR) * positif(RSE3BASE - RSE3_R99R) 
		       * (
             (positif(RSE3BASE - max(RSE3_NTLDEC_198,RSE3_REF* (1-present(RSE3_NTLDEC_198))+0))
            * arr((RSE3BASE - max(RSE3_NTLDEC_198,RSE3_REF* (1-present(RSE3_NTLDEC_198)))) * (TXINR / 100))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(RSE3BASE - max(RSE3_NTLDEC_198,RSE3_REF* (1-present(RSE3_NTLDEC_198))+0)) 
            * arr((RSE3BASE - max(RSE3_NTLDEC_198,RSE3_REF* (1-present(RSE3_NTLDEC_198)))) * (TXINR / 100))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
		       + null(3 - FLAG_INR) * positif(RSE3BASE - RSE3_REF) 
		       * (
             (positif(RSE3BASE - max(RSE3_NTLDEC_198,RSE3_REF+0))
            * arr((min(RSE3BASE,RSE3_TLDEC_1) - max(RSE3_NTLDEC_198,RSE3_REF* (1-present(RSE3_NTLDEC_198)))) * (TXINR / 100))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(RSE3BASE - max(RSE3_NTLDEC_198,RSE3_REF* (1-present(RSE3_NTLDEC_198))+0))
            * arr((min(RSE3BASE,RSE3_TLDEC_1) - max(RSE3_NTLDEC_198,RSE3_REF* (1-present(RSE3_NTLDEC_198)))) * (TXINR / 100))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
            + INRRSE3_RETDEF * null(IND_PASSAGE - 1)
                            )
	     ; 
INRRSE4_NTL = (1 - IND_RJLJ) * (1-FLAG_NINR) * (
		       null(2 - FLAG_INR) * positif(RSE4BASE - RSE4_R99R) 
		       * (
             (positif(RSE4BASE - max(RSE4_NTLDEC_198,RSE4_REF* (1-present(RSE4_NTLDEC_198))+0))
            * arr((RSE4BASE - max(RSE4_NTLDEC_198,RSE4_REF* (1-present(RSE4_NTLDEC_198)))) * (TXINR / 100))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(RSE4BASE - max(RSE4_NTLDEC_198,RSE4_REF* (1-present(RSE4_NTLDEC_198))+0)) 
            * arr((RSE4BASE - max(RSE4_NTLDEC_198,RSE4_REF* (1-present(RSE4_NTLDEC_198)))) * (TXINR / 100))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
		       + null(3 - FLAG_INR) * positif(RSE4BASE - RSE4_REF) 
		       * (
             (positif(RSE4BASE - max(RSE4_NTLDEC_198,RSE4_REF+0))
            * arr((min(RSE4BASE,RSE4_TLDEC_1) - max(RSE4_NTLDEC_198,RSE4_REF* (1-present(RSE4_NTLDEC_198)))) * (TXINR / 100))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(RSE4BASE - max(RSE4_NTLDEC_198,RSE4_REF* (1-present(RSE4_NTLDEC_198))+0))
            * arr((min(RSE4BASE,RSE4_TLDEC_1) - max(RSE4_NTLDEC_198,RSE4_REF* (1-present(RSE4_NTLDEC_198)))) * (TXINR / 100))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
            + INRRSE4_RETDEF * null(IND_PASSAGE - 1)
                            )
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
            * arr((CSG - max(CSG_NTLDEC,CSG_REF)-CSGIM) * (TXINRRED / 200))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(CSG* positif(CSG+PRS+RDSN-SEUIL_REC_CP2)  - max(CSG_NTLDEC,CSG_REF+0))
            * arr((CSG - max(CSG_NTLDEC,CSG_REF)-CSGIM) * (TXINRRED / 200))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                              )
                      + null(3 - FLAG_INR) * positif(CSG-CSG_REF) 
			* (
            (positif(CSG * positif(CSG+PRS+RDSN-SEUIL_REC_CP2) - max(CSG_NTLDEC,CSG_REF+0))
            * arr((min(CSG,CSG_TLDEC_1) - max(CSG_NTLDEC,CSG_REF)-CSGIM) * (TXINRRED / 200))
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
            * arr((PRS  - max(PRS_NTLDEC,PRS_REF)-PRSPROV) * (TXINRRED / 200))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(PRS * positif(CSG+PRS+RDSN-SEUIL_REC_CP2) - max(PRS_NTLDEC,PRS_REF+0))
            * arr((PRS - max(PRS_NTLDEC,PRS_REF)-PRSPROV) * (TXINRRED / 200))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                        )
                        + null(3 - FLAG_INR) * positif(PRS-PRS_REF) 
			   * (
            (positif(PRS* positif(CSG+PRS+RDSN-SEUIL_REC_CP2)  - max(PRS_NTLDEC,PRS_REF+0)) 
            * arr((min(PRS,PRS_TLDEC_1)  - max(PRS_NTLDEC,PRS_REF)-PRSPROV) * (TXINRRED / 200))
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
             (positif(CSALBASE - max(CSAL_NTLDEC,CSAL_REF+0))
            * arr((min(CSALBASE,CSAL_TLDEC_1) - max(CSAL_NTLDEC,CSAL_REF)-CSALPROV) * (TXINRRED / 200))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(CSALBASE - max(CSAL_NTLDEC,CSAL_REF))
            * arr((min(CSALBASE,CSAL_TLDEC_1) - max(CSAL_NTLDEC,CSAL_REF)-CSALPROV) * (TXINRRED / 200))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
                            )
	     ; 
INRCDIS_NTL_1 = (1 - IND_RJLJ) * (1-FLAG_NINR) * (
		       null(2 - FLAG_INR) * positif(CDISBASE - CDIS_R99R) 
		       * (
             (positif(CDISBASE - max(CDIS_NTLDEC,CDIS_REF+0))
            * arr((CDISBASE - max(CDIS_NTLDEC,CDIS_REF)-CDISPROV) * (TXINRRED / 200))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(CDISBASE - max(CDIS_NTLDEC,CDIS_REF+0)) 
            * arr((CDISBASE - max(CDIS_NTLDEC,CDIS_REF)-CDISPROV) * (TXINRRED / 200))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
		       + null(3 - FLAG_INR) * positif(CDISBASE - CDIS_REF) 
		       * (
             (positif(CDISBASE - max(CDIS_NTLDEC,CDIS_REF+0))
            * arr((min(CDISBASE,CDIS_TLDEC_1) - max(CDIS_NTLDEC,CDIS_REF)-CDISPROV) * (TXINRRED / 200))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(CDISBASE - max(CDIS_NTLDEC,CDIS_REF+0))
            * arr((min(CDISBASE,CDIS_TLDEC_1) - max(CDIS_NTLDEC,CDIS_REF)-CDISPROV) * (TXINRRED / 200))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
                            )
	     ; 
INRCHR_NTL_1 = (1 - IND_RJLJ) * (1-FLAG_NINR) * (
		       null(2 - FLAG_INR) * positif(CHRBASE - CHR_R99R) 
		       * (
             (positif(CHRBASE - max(CHR_NTLDEC,CHR_REF+0))
            * arr((CHRBASE - max(CHR_NTLDEC,CHR_REF)) * (TXINRRED / 200))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(CHRBASE - max(CHR_NTLDEC,CHR_REF+0)) 
            * arr((CHRBASE - max(CHR_NTLDEC,CHR_REF)) * (TXINRRED / 200))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
		       + null(3 - FLAG_INR) * positif(CHRBASE - CHR_REF) 
		       * (
             (positif(CHRBASE - max(CHR_NTLDEC,CHR_REF+0))
            * arr((min(CHRBASE,CHR_TLDEC_1) - max(CHR_NTLDEC,CHR_REF)) * (TXINRRED / 200))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(CHRBASE - max(CHR_NTLDEC,CHR_REF+0))
            * arr((min(CHRBASE,CHR_TLDEC_1) - max(CHR_NTLDEC,CHR_REF)) * (TXINRRED / 200))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
                            )
	     ; 
INRPCAP_NTL_1 = (1 - IND_RJLJ) * (1-FLAG_NINR) * (
		       null(2 - FLAG_INR) * positif(PCAPBASE - PCAP_R99R) 
		       * (
             (positif(PCAPBASE - max(PCAP_NTLDEC,PCAP_REF+0))
            * arr((PCAPBASE - max(PCAP_NTLDEC,PCAP_REF)) * (TXINRRED / 200))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(PCAPBASE - max(PCAP_NTLDEC,PCAP_REF+0)) 
            * arr((PCAPBASE - max(PCAP_NTLDEC,PCAP_REF)) * (TXINRRED / 200))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
		       + null(3 - FLAG_INR) * positif(PCAPBASE - PCAP_REF) 
		       * (
             (positif(PCAPBASE - max(PCAP_NTLDEC,PCAP_REF+0))
            * arr((min(PCAPBASE,PCAP_TLDEC_1) - max(PCAP_NTLDEC,PCAP_REF)) * (TXINRRED / 200))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(PCAPBASE - max(PCAP_NTLDEC,PCAP_REF+0))
            * arr((min(PCAPBASE,PCAP_TLDEC_1) - max(PCAP_NTLDEC,PCAP_REF)) * (TXINRRED / 200))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
                            )
	     ; 
INRGAIN_NTL_1 = (1 - IND_RJLJ) * (1-FLAG_NINR) * (
		       null(2 - FLAG_INR) * positif(GAINBASE - GAIN_R99R) 
		       * (
             (positif(GAINBASE - max(GAIN_NTLDEC,GAIN_REF+0))
            * arr((GAINBASE - max(GAIN_NTLDEC,GAIN_REF)-GAINPROV) * (TXINRRED / 200))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(GAINBASE - max(GAIN_NTLDEC,GAIN_REF+0)) 
            * arr((GAINBASE - max(GAIN_NTLDEC,GAIN_REF)-GAINPROV) * (TXINRRED / 200))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
		       + null(3 - FLAG_INR) * positif(GAINBASE - GAIN_REF) 
		       * (
             (positif(GAINBASE - max(GAIN_NTLDEC,GAIN_REF+0))
            * arr((min(GAINBASE,GAIN_TLDEC_1) - max(GAIN_NTLDEC,GAIN_REF)-GAINPROV) * (TXINRRED / 200))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(GAINBASE - max(GAIN_NTLDEC,GAIN_REF+0))
            * arr((min(GAINBASE,GAIN_TLDEC_1) - max(GAIN_NTLDEC,GAIN_REF)-GAINPROV) * (TXINRRED / 200))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
                            )
	     ; 
INRRSE1_NTL_1 = (1 - IND_RJLJ) * (1-FLAG_NINR) * (
		       null(2 - FLAG_INR) * positif(RSE1BASE - RSE1_R99R) 
		       * (
             (positif(RSE1BASE - max(RSE1_NTLDEC,RSE1_REF+0))
            * arr((RSE1BASE - max(RSE1_NTLDEC,RSE1_REF)) * (TXINRRED / 200))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(RSE1BASE - max(RSE1_NTLDEC,RSE1_REF+0)) 
            * arr((RSE1BASE - max(RSE1_NTLDEC,RSE1_REF)) * (TXINRRED / 200))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
		       + null(3 - FLAG_INR) * positif(RSE1BASE - RSE1_REF) 
		       * (
             (positif(RSE1BASE - max(RSE1_NTLDEC,RSE1_REF+0))
            * arr((min(RSE1BASE,RSE1_TLDEC_1) - max(RSE1_NTLDEC,RSE1_REF)) * (TXINRRED / 200))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(RSE1BASE - max(RSE1_NTLDEC,RSE1_REF+0))
            * arr((min(RSE1BASE,RSE1_TLDEC_1) - max(RSE1_NTLDEC,RSE1_REF)) * (TXINRRED / 200))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
                            )
	     ; 
INRRSE2_NTL_1 = (1 - IND_RJLJ) * (1-FLAG_NINR) * (
		       null(2 - FLAG_INR) * positif(RSE2BASE - RSE2_R99R) 
		       * (
             (positif(RSE2BASE - max(RSE2_NTLDEC,RSE2_REF+0))
            * arr((RSE2BASE - max(RSE2_NTLDEC,RSE2_REF)) * (TXINRRED / 200))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(RSE2BASE - max(RSE2_NTLDEC,RSE2_REF+0)) 
            * arr((RSE2BASE - max(RSE2_NTLDEC,RSE2_REF)) * (TXINRRED / 200))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
		       + null(3 - FLAG_INR) * positif(RSE2BASE - RSE2_REF) 
		       * (
             (positif(RSE2BASE - max(RSE2_NTLDEC,RSE2_REF+0))
            * arr((min(RSE2BASE,RSE2_TLDEC_1) - max(RSE2_NTLDEC,RSE2_REF)) * (TXINRRED / 200))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(RSE2BASE - max(RSE2_NTLDEC,RSE2_REF+0))
            * arr((min(RSE2BASE,RSE2_TLDEC_1) - max(RSE2_NTLDEC,RSE2_REF)) * (TXINRRED / 200))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
                            )
	     ; 
INRRSE3_NTL_1 = (1 - IND_RJLJ) * (1-FLAG_NINR) * (
		       null(2 - FLAG_INR) * positif(RSE3BASE - RSE3_R99R) 
		       * (
             (positif(RSE3BASE - max(RSE3_NTLDEC,RSE3_REF+0))
            * arr((RSE3BASE - max(RSE3_NTLDEC,RSE3_REF)) * (TXINRRED / 200))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(RSE3BASE - max(RSE3_NTLDEC,RSE3_REF+0)) 
            * arr((RSE3BASE - max(RSE3_NTLDEC,RSE3_REF)) * (TXINRRED / 200))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
		       + null(3 - FLAG_INR) * positif(RSE3BASE - RSE3_REF) 
		       * (
             (positif(RSE3BASE - max(RSE3_NTLDEC,RSE3_REF+0))
            * arr((min(RSE3BASE,RSE3_TLDEC_1) - max(RSE3_NTLDEC,RSE3_REF)) * (TXINRRED / 200))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(RSE3BASE - max(RSE3_NTLDEC,RSE3_REF+0))
            * arr((min(RSE3BASE,RSE3_TLDEC_1) - max(RSE3_NTLDEC,RSE3_REF)) * (TXINRRED / 200))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
                            )
	     ; 
INRRSE4_NTL_1 = (1 - IND_RJLJ) * (1-FLAG_NINR) * (
		       null(2 - FLAG_INR) * positif(RSE4BASE - RSE4_R99R) 
		       * (
             (positif(RSE4BASE - max(RSE4_NTLDEC,RSE4_REF+0))
            * arr((RSE4BASE - max(RSE4_NTLDEC,RSE4_REF)) * (TXINRRED / 200))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(RSE4BASE - max(RSE4_NTLDEC,RSE4_REF+0)) 
            * arr((RSE4BASE - max(RSE4_NTLDEC,RSE4_REF)) * (TXINRRED / 200))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
		       + null(3 - FLAG_INR) * positif(RSE4BASE - RSE4_REF) 
		       * (
             (positif(RSE4BASE - max(RSE4_NTLDEC,RSE4_REF+0))
            * arr((min(RSE4BASE,RSE4_TLDEC_1) - max(RSE4_NTLDEC,RSE4_REF)) * (TXINRRED / 200))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(RSE4BASE - max(RSE4_NTLDEC,RSE4_REF+0))
            * arr((min(RSE4BASE,RSE4_TLDEC_1) - max(RSE4_NTLDEC,RSE4_REF)) * (TXINRRED / 200))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
                            )
	     ; 
regle corrective 1082:
application : oceans, iliad ;
INRIR_TLACQ = positif(IRNIN_INR - max(max(IRNIN_REF,IRNIN_RECT)*(1-present(IRNIN_TLDEC_199)),
				       max(IRNIN_NTLDEC_1*(1-present(IRNIN_TLDEC_199)),IRNIN_TLDEC_199+0))) * null(3-FLAG_INR)
            * arr((IRNIN_INR - max(max(IRNIN_REF,IRNIN_RECT)*(1-present(IRNIN_TLDEC_199)),
						   max(IRNIN_NTLDEC_1*(1-present(IRNIN_TLDEC_199)),IRNIN_TLDEC_199+0))) * (TXINR / 100));
INRIR_TLA = (1 - IND_RJLJ) * (1-FLAG_NINR) * INRIR_TLACQ;
INRCSG_TLACQ = positif(CSG - max(CSG_REF*(1-present(CSG_TLDEC_199)),
					max(CSG_NTLDEC_1*(1-present(CSG_TLDEC_199)),CSG_TLDEC_199+0))) * null(3 - FLAG_INR)
            * arr((CSG - max(CSG_REF*(1-present(CSG_TLDEC_199)),
				       max(CSG_NTLDEC_1*(1-present(CSG_TLDEC_199)),CSG_TLDEC_199))-CSGIM*(1-positif(CSG_A))) * (TXINR / 100));
INRCSG_TLA = (1 - IND_RJLJ) * (1-FLAG_NINR) * INRCSG_TLACQ;
INRPRS_TLACQ = positif(PRS - max(PRS_REF*(1-present(PRS_TLDEC_199)),
                                          max(PRS_NTLDEC_1*(1-present(PRS_TLDEC_199)),PRS_TLDEC_199+0))) * null(3 - FLAG_INR)
            * arr((PRS - max(PRS_REF*(1-present(PRS_TLDEC_199)),
					  max(PRS_NTLDEC_1*(1-present(PRS_TLDEC_199)),PRS_TLDEC_199))-PRSPROV*(1-positif(PRS_A))) * (TXINR / 100))  ;
INRPRS_TLA = (1 - IND_RJLJ) * (1-FLAG_NINR) * INRPRS_TLACQ;
INRCRDS_TLACQ = positif(RDSN - max(RDS_REF*(1-present(RDS_TLDEC_199)),
						 max(CRDS_NTLDEC_1*(1-present(RDS_TLDEC_199)), RDS_TLDEC_199+0))) * null(3 - FLAG_INR)
            * arr((RDSN - max(RDS_REF*(1-present(RDS_TLDEC_199)),
							     max(CRDS_NTLDEC_1*(1-present(RDS_TLDEC_199)), RDS_TLDEC_199))-CRDSIM*(1-positif(RDS_A))) * (TXINR / 100))  ;
INRCRDS_TLA = (1 - IND_RJLJ) * (1-FLAG_NINR) * INRCRDS_TLACQ;
INRTAXA_TLACQ = positif(TAXABASE - max(TAXA_REF*(1-present(TAXA_TLDEC_199)),
						 max(TAXA_NTLDEC_1*(1-present(TAXA_TLDEC_199)), TAXA_TLDEC_199+0)))*null(3- FLAG_INR)
            * arr((TAXABASE - max(TAXA_REF*(1-present(TAXA_TLDEC_199)),
							     max(TAXA_NTLDEC_1*(1-present(TAXA_TLDEC_199)), TAXA_TLDEC_199))) * (TXINR / 100))  ;
INRTAXA_TLA = (1 - IND_RJLJ) * (1-FLAG_NINR) * INRTAXA_TLACQ;
INRCSAL_TLACQ = positif(CSALBASE - max(CSAL_REF*(1-present(CSAL_TLDEC_199)),
						 max(CSAL_NTLDEC_1*(1-present(CSAL_TLDEC_199)), CSAL_TLDEC_199+0)))*null(3- FLAG_INR)
            * arr((CSALBASE - max(CSAL_REF*(1-present(CSAL_TLDEC_199)),
							     max(CSAL_NTLDEC_1*(1-present(CSAL_TLDEC_199)), CSAL_TLDEC_199))-CSALPROV*(1-positif(CSAL_A))) * (TXINR / 100))  ;
INRCSAL_TLA = (1 - IND_RJLJ) * (1-FLAG_NINR) * INRCSAL_TLACQ;
INRCDIS_TLACQ = positif(CDISBASE - max(CDIS_REF*(1-present(CDIS_TLDEC_199)),
						 max(CDIS_NTLDEC_1*(1-present(CDIS_TLDEC_199)), CDIS_TLDEC_199+0)))*null(3- FLAG_INR)
            * arr((CDISBASE - max(CDIS_REF*(1-present(CDIS_TLDEC_199)),
							     max(CDIS_NTLDEC_1*(1-present(CDIS_TLDEC_199)), CDIS_TLDEC_199))-CDISPROV*(1-positif(CDIS_A))) * (TXINR / 100))  ;
INRCDIS_TLA = (1 - IND_RJLJ) * (1-FLAG_NINR) * INRCDIS_TLACQ;
INRCHR_TLACQ = positif(CHRBASE - max(CHR_REF*(1-present(CHR_TLDEC_199)),
						 max(CHR_NTLDEC_1*(1-present(CHR_TLDEC_199)), CHR_TLDEC_199+0)))*null(3- FLAG_INR)
            * arr((CHRBASE - max(CHR_REF*(1-present(CHR_TLDEC_199)),
							     max(CHR_NTLDEC_1*(1-present(CHR_TLDEC_199)), CHR_TLDEC_199))) * (TXINR / 100))  ;
INRCHR_TLA = (1 - IND_RJLJ) * (1-FLAG_NINR) * INRCHR_TLACQ;
INRPCAP_TLACQ = positif(PCAPBASE - max(PCAP_REF*(1-present(PCAP_TLDEC_199)),
						 max(PCAP_NTLDEC_1*(1-present(PCAP_TLDEC_199)), PCAP_TLDEC_199+0)))*null(3- FLAG_INR)
            * arr((PCAPBASE - max(PCAP_REF*(1-present(PCAP_TLDEC_199)),
							     max(PCAP_NTLDEC_1*(1-present(PCAP_TLDEC_199)), PCAP_TLDEC_199))) * (TXINR / 100))  ;
INRPCAP_TLA = (1 - IND_RJLJ) * (1-FLAG_NINR) * INRPCAP_TLACQ;
INRGAIN_TLACQ = positif(GAINBASE - max(GAIN_REF*(1-present(GAIN_TLDEC_199)),
						 max(GAIN_NTLDEC_1*(1-present(GAIN_TLDEC_199)), GAIN_TLDEC_199+0)))*null(3- FLAG_INR)
            * arr((GAINBASE - max(GAIN_REF*(1-present(GAIN_TLDEC_199)),
							     max(GAIN_NTLDEC_1*(1-present(GAIN_TLDEC_199)), GAIN_TLDEC_199))-GAINPROV*(1-positif(GAIN_A))) * (TXINR / 100))  ;
INRGAIN_TLA = (1 - IND_RJLJ) * (1-FLAG_NINR) * INRGAIN_TLACQ;
INRRSE1_TLACQ = positif(RSE1BASE - max(RSE1_REF*(1-present(RSE1_TLDEC_199)),
						 max(RSE1_NTLDEC_1*(1-present(RSE1_TLDEC_199)), RSE1_TLDEC_199+0)))*null(3- FLAG_INR)
            * arr((RSE1BASE - max(RSE1_REF*(1-present(RSE1_TLDEC_199)),
							     max(RSE1_NTLDEC_1*(1-present(RSE1_TLDEC_199)), RSE1_TLDEC_199))) * (TXINR / 100))  ;
INRRSE1_TLA = (1 - IND_RJLJ) * (1-FLAG_NINR) * INRRSE1_TLACQ;
INRRSE2_TLACQ = positif(RSE2BASE - max(RSE2_REF*(1-present(RSE2_TLDEC_199)),
						 max(RSE2_NTLDEC_1*(1-present(RSE2_TLDEC_199)), RSE2_TLDEC_199+0)))*null(3- FLAG_INR)
            * arr((RSE2BASE - max(RSE2_REF*(1-present(RSE2_TLDEC_199)),
							     max(RSE2_NTLDEC_1*(1-present(RSE2_TLDEC_199)), RSE2_TLDEC_199))) * (TXINR / 100))  ;
INRRSE2_TLA = (1 - IND_RJLJ) * (1-FLAG_NINR) * INRRSE2_TLACQ;
INRRSE3_TLACQ = positif(RSE3BASE - max(RSE3_REF*(1-present(RSE3_TLDEC_199)),
						 max(RSE3_NTLDEC_1*(1-present(RSE3_TLDEC_199)), RSE3_TLDEC_199+0)))*null(3- FLAG_INR)
            * arr((RSE3BASE - max(RSE3_REF*(1-present(RSE3_TLDEC_199)),
							     max(RSE3_NTLDEC_1*(1-present(RSE3_TLDEC_199)), RSE3_TLDEC_199))) * (TXINR / 100))  ;
INRRSE3_TLA = (1 - IND_RJLJ) * (1-FLAG_NINR) * INRRSE3_TLACQ;
INRRSE4_TLACQ = positif(RSE4BASE - max(RSE4_REF*(1-present(RSE4_TLDEC_199)),
						 max(RSE4_NTLDEC_1*(1-present(RSE4_TLDEC_199)), RSE4_TLDEC_199+0)))*null(3- FLAG_INR)
            * arr((RSE4BASE - max(RSE4_REF*(1-present(RSE4_TLDEC_199)),
							     max(RSE4_NTLDEC_1*(1-present(RSE4_TLDEC_199)), RSE4_TLDEC_199))) * (TXINR / 100))  ;
INRRSE4_TLA = (1 - IND_RJLJ) * (1-FLAG_NINR) * INRRSE4_TLACQ;
regle corrective 108212:
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
            * arr((TAXABASE - max(TAXA_REF*null(TAXABASE-TAXABASE_A),TAXA_TLDEC)) * (TXINRRED / 200))*(1-positif(FLAG_C22+FLAG_C02))
	    +
               positif(TAXABASE - TAXA_TLDEC) * null(3-FLAG_INR)
            * arr((TAXABASE - TAXA_TLDEC) * (TXINRRED / 200)) * positif(FLAG_C22+FLAG_C02);
INRTAXA_TLA_1 = (1 - IND_RJLJ) * (1-FLAG_NINR) * INRTAXA_TLACQ_1;
INRCSAL_TLACQ_1 = positif(CSALBASE - max(CSAL_REF*null(CSALBASE-CSALBASE_A),CSAL_TLDEC+0))*null(3- FLAG_INR)
            * arr((CSALBASE - max(CSAL_REF*null(CSALBASE-CSALBASE_A),CSAL_TLDEC)-CSALPROV*(1-positif(CSAL_A))) * (TXINRRED / 200))*(1-positif(FLAG_C22+FLAG_C02))
	    +
               positif(CSALBASE - CSAL_TLDEC) * null(3-FLAG_INR)
            * arr((CSALBASE - CSAL_TLDEC) * (TXINRRED / 200)) * positif(FLAG_C22+FLAG_C02);
INRCSAL_TLA_1 = (1 - IND_RJLJ) * (1-FLAG_NINR) * INRCSAL_TLACQ_1;
INRCDIS_TLACQ_1 = positif(CDISBASE - max(CDIS_REF*null(CDISBASE-CDISBASE_A),CDIS_TLDEC+0))*null(3- FLAG_INR)
            * arr((CDISBASE - max(CDIS_REF*null(CDISBASE-CDISBASE_A),CDIS_TLDEC)-CDISPROV*(1-positif(CDIS_A))) * (TXINRRED / 200))*(1-positif(FLAG_C22+FLAG_C02))
	    +
               positif(CDISBASE - CDIS_TLDEC) * null(3-FLAG_INR)
            * arr((CDISBASE - CDIS_TLDEC) * (TXINRRED / 200)) * positif(FLAG_C22+FLAG_C02);
INRCDIS_TLA_1 = (1 - IND_RJLJ) * (1-FLAG_NINR) * INRCDIS_TLACQ_1;
INRCHR_TLACQ_1 = positif(CHRBASE - max(CHR_REF*null(CHRBASE-CHRBASE_A),CHR_TLDEC+0))*null(3- FLAG_INR)
            * arr((CHRBASE - max(CHR_REF*null(CHRBASE-CHRBASE_A),CHR_TLDEC)) * (TXINRRED / 200))*(1-positif(FLAG_C22+FLAG_C02))
	    +
               positif(CHRBASE - CHR_TLDEC) * null(3-FLAG_INR)
            * arr((CHRBASE - CHR_TLDEC) * (TXINRRED / 200)) * positif(FLAG_C22+FLAG_C02);
INRCHR_TLA_1 = (1 - IND_RJLJ) * (1-FLAG_NINR) * INRCHR_TLACQ_1;
INRPCAP_TLACQ_1 = positif(PCAPBASE - max(PCAP_REF*null(PCAPBASE-PCAPBASE_A),PCAP_TLDEC+0))*null(3- FLAG_INR)
            * arr((PCAPBASE - max(PCAP_REF*null(PCAPBASE-PCAPBASE_A),PCAP_TLDEC)) * (TXINRRED / 200))*(1-positif(FLAG_C22+FLAG_C02))
	    +
               positif(PCAPBASE - PCAP_TLDEC) * null(3-FLAG_INR)
            * arr((PCAPBASE - PCAP_TLDEC) * (TXINRRED / 200)) * positif(FLAG_C22+FLAG_C02);
INRPCAP_TLA_1 = (1 - IND_RJLJ) * (1-FLAG_NINR) * INRPCAP_TLACQ_1;
INRGAIN_TLACQ_1 = positif(GAINBASE - max(GAIN_REF*null(GAINBASE-GAINBASE_A),GAIN_TLDEC+0))*null(3- FLAG_INR)
            * arr((GAINBASE - max(GAIN_REF*null(GAINBASE-GAINBASE_A),GAIN_TLDEC)-GAINPROV*(1-positif(GAIN_A))) * (TXINRRED / 200))*(1-positif(FLAG_C22+FLAG_C02))
	    +
               positif(GAINBASE - GAIN_TLDEC) * null(3-FLAG_INR)
            * arr((GAINBASE - GAIN_TLDEC) * (TXINRRED / 200)) * positif(FLAG_C22+FLAG_C02);
INRGAIN_TLA_1 = (1 - IND_RJLJ) * (1-FLAG_NINR) * INRGAIN_TLACQ_1;
INRRSE1_TLACQ_1 = positif(RSE1BASE - max(RSE1_REF*null(RSE1BASE-RSE1BASE_A),RSE1_TLDEC+0))*null(3- FLAG_INR)
            * arr((RSE1BASE - max(RSE1_REF*null(RSE1BASE-RSE1BASE_A),RSE1_TLDEC)) * (TXINRRED / 200))*(1-positif(FLAG_C22+FLAG_C02))
	    +
               positif(RSE1BASE - RSE1_TLDEC) * null(3-FLAG_INR)
            * arr((RSE1BASE - RSE1_TLDEC) * (TXINRRED / 200)) * positif(FLAG_C22+FLAG_C02);
INRRSE1_TLA_1 = (1 - IND_RJLJ) * (1-FLAG_NINR) * INRRSE1_TLACQ_1;
INRRSE2_TLACQ_1 = positif(RSE2BASE - max(RSE2_REF*null(RSE2BASE-RSE2BASE_A),RSE2_TLDEC+0))*null(3- FLAG_INR)
            * arr((RSE2BASE - max(RSE2_REF*null(RSE2BASE-RSE2BASE_A),RSE2_TLDEC)) * (TXINRRED / 200))*(1-positif(FLAG_C22+FLAG_C02))
	    +
               positif(RSE2BASE - RSE2_TLDEC) * null(3-FLAG_INR)
            * arr((RSE2BASE - RSE2_TLDEC) * (TXINRRED / 200)) * positif(FLAG_C22+FLAG_C02);
INRRSE2_TLA_1 = (1 - IND_RJLJ) * (1-FLAG_NINR) * INRRSE2_TLACQ_1;
INRRSE3_TLACQ_1 = positif(RSE3BASE - max(RSE3_REF*null(RSE3BASE-RSE3BASE_A),RSE3_TLDEC+0))*null(3- FLAG_INR)
            * arr((RSE3BASE - max(RSE3_REF*null(RSE3BASE-RSE3BASE_A),RSE3_TLDEC)) * (TXINRRED / 200))*(1-positif(FLAG_C22+FLAG_C02))
	    +
               positif(RSE3BASE - RSE3_TLDEC) * null(3-FLAG_INR)
            * arr((RSE3BASE - RSE3_TLDEC) * (TXINRRED / 200)) * positif(FLAG_C22+FLAG_C02);
INRRSE3_TLA_1 = (1 - IND_RJLJ) * (1-FLAG_NINR) * INRRSE3_TLACQ_1;
INRRSE4_TLACQ_1 = positif(RSE4BASE - max(RSE4_REF*null(RSE4BASE-RSE4BASE_A),RSE4_TLDEC+0))*null(3- FLAG_INR)
            * arr((RSE4BASE - max(RSE4_REF*null(RSE4BASE-RSE4BASE_A),RSE4_TLDEC)) * (TXINRRED / 200))*(1-positif(FLAG_C22+FLAG_C02))
	    +
               positif(RSE4BASE - RSE4_TLDEC) * null(3-FLAG_INR)
            * arr((RSE4BASE - RSE4_TLDEC) * (TXINRRED / 200)) * positif(FLAG_C22+FLAG_C02);
INRRSE4_TLA_1 = (1 - IND_RJLJ) * (1-FLAG_NINR) * INRRSE4_TLACQ_1;
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
INRCHR_TLADEC_1 = INRCHR_TLACQ_1;
INRCHR_TL_1_AD = INRCHR_TL_1_A;
INRPCAP_TLADEC_1 = INRPCAP_TLACQ_1;
INRPCAP_TL_1_AD = INRPCAP_TL_1_A;
INRGAIN_TLADEC_1 = INRGAIN_TLACQ_1;
INRGAIN_TL_1_AD = INRGAIN_TL_1_A;
INRRSE1_TLADEC_1 = INRRSE1_TLACQ_1;
INRRSE1_TL_1_AD = INRRSE1_TL_1_A;
INRRSE2_TLADEC_1 = INRRSE2_TLACQ_1;
INRRSE2_TL_1_AD = INRRSE2_TL_1_A;
INRRSE3_TLADEC_1 = INRRSE3_TLACQ_1;
INRRSE3_TL_1_AD = INRRSE3_TL_1_A;
INRRSE4_TLADEC_1 = INRRSE4_TLACQ_1;
INRRSE4_TL_1_AD = INRRSE4_TL_1_A;
INRIR_TLDEC_1 = INRIR_TLA_1+INRIR_RETDEF*null(INRIR_RETDEF_A);
INRCSG_TLDEC_1 = INRCSG_TLA_1 + INRCSG_RETDEF * null(INRCSG_RETDEF_A);
INRPRS_TLDEC_1 = INRPRS_TLA_1 + INRPRS_RETDEF * null(INRPRS_RETDEF_A);
INRCRDS_TLDEC_1 = INRCRDS_TLA_1 + INRCRDS_RETDEF * null(INRCRDS_RETDEF_A);
INRTAXA_TLDEC_1 = INRTAXA_TLA_1 + INRTAXA_RETDEF * null(INRTAXA_RETDEF_A);
INRCSAL_TLDEC_1 = INRCSAL_TLA_1 + INRCSAL_RETDEF * null(INRCSAL_RETDEF_A);
INRCDIS_TLDEC_1 = INRCDIS_TLA_1 + INRCDIS_RETDEF * null(INRCDIS_RETDEF_A);
INRCHR_TLDEC_1 = INRCHR_TLA_1 + INRCHR_RETDEF * null(INRCHR_RETDEF_A);
INRPCAP_TLDEC_1 = INRPCAP_TLA_1 + INRPCAP_RETDEF * null(INRPCAP_RETDEF_A);
INRGAIN_TLDEC_1 = INRGAIN_TLA_1 + INRGAIN_RETDEF * null(INRGAIN_RETDEF_A);
INRRSE1_TLDEC_1 = INRRSE1_TLA_1 + INRRSE1_RETDEF * null(INRRSE1_RETDEF_A);
INRRSE2_TLDEC_1 = INRRSE2_TLA_1 + INRRSE2_RETDEF * null(INRRSE2_RETDEF_A);
INRRSE3_TLDEC_1 = INRRSE3_TLA_1 + INRRSE3_RETDEF * null(INRRSE3_RETDEF_A);
INRRSE4_TLDEC_1 = INRRSE4_TLA_1 + INRRSE4_RETDEF * null(INRRSE4_RETDEF_A);
INRIR_NTLDECD = INRIR_NTLDEC * positif_ou_nul(IRNIN_TLDEC_1 - IRNIN_NTLDEC) + INRIR_NTL *positif(IRNIN_NTLDEC-IRNIN_TLDEC_1);
INRCSG_NTLDECD = INRCSG_NTLDEC * positif_ou_nul(CSG_TLDEC_1 - CSG_NTLDEC) + INRCSG_NTL *positif(CSG_NTLDEC-CSG_TLDEC_1);
INRCRDS_NTLDECD = INRCRDS_NTLDEC * positif_ou_nul(RDS_TLDEC_1 - CRDS_NTLDEC) + INRCRDS_NTL *positif(CRDS_NTLDEC-RDS_TLDEC_1);
INRPRS_NTLDECD = INRPRS_NTLDEC * positif_ou_nul(PRS_TLDEC_1 - PRS_NTLDEC) + INRPRS_NTL *positif(PRS_NTLDEC-PRS_TLDEC_1);
INRCSAL_NTLDECD = INRCSAL_NTLDEC * positif_ou_nul(CSAL_TLDEC_1 - CSAL_NTLDEC) + INRCSAL_NTL *positif(CSAL_NTLDEC-CSAL_TLDEC_1);
INRCDIS_NTLDECD = INRCDIS_NTLDEC * positif_ou_nul(CDIS_TLDEC_1 - CDIS_NTLDEC) + INRCDIS_NTL *positif(CDIS_NTLDEC-CDIS_TLDEC_1);
INRTAXA_NTLDECD = INRTAXA_NTLDEC * positif_ou_nul(TAXA_TLDEC_1 - TAXA_NTLDEC) + INRTAXA_NTL *positif(TAXA_NTLDEC-TAXA_TLDEC_1);
INRCHR_NTLDECD = INRCHR_NTLDEC * positif_ou_nul(CHR_TLDEC_1 - CHR_NTLDEC) + INRCHR_NTL *positif(CHR_NTLDEC-CHR_TLDEC_1);
INRPCAP_NTLDECD = INRPCAP_NTLDEC * positif_ou_nul(PCAP_TLDEC_1 - PCAP_NTLDEC) + INRPCAP_NTL *positif(PCAP_NTLDEC-PCAP_TLDEC_1);
INRGAIN_NTLDECD = INRGAIN_NTLDEC * positif_ou_nul(GAIN_TLDEC_1 - GAIN_NTLDEC) + INRGAIN_NTL *positif(GAIN_NTLDEC-GAIN_TLDEC_1);
INRRSE1_NTLDECD = INRRSE1_NTLDEC * positif_ou_nul(RSE1_TLDEC_1 - RSE1_NTLDEC) + INRRSE1_NTL *positif(RSE1_NTLDEC-RSE1_TLDEC_1);
INRRSE2_NTLDECD = INRRSE2_NTLDEC * positif_ou_nul(RSE2_TLDEC_1 - RSE2_NTLDEC) + INRRSE2_NTL *positif(RSE2_NTLDEC-RSE2_TLDEC_1);
INRRSE3_NTLDECD = INRRSE3_NTLDEC * positif_ou_nul(RSE3_TLDEC_1 - RSE3_NTLDEC) + INRRSE3_NTL *positif(RSE3_NTLDEC-RSE3_TLDEC_1);
INRRSE4_NTLDECD = INRRSE4_NTLDEC * positif_ou_nul(RSE4_TLDEC_1 - RSE4_NTLDEC) + INRRSE4_NTL *positif(RSE4_NTLDEC-RSE4_TLDEC_1);
INRIR_NTLDECD_1 = INRIR_NTLDEC_1 * positif_ou_nul(IRNIN_TLDEC_1 - IRNIN_NTLDEC_1) + INRIR_NTL_1 *positif(IRNIN_NTLDEC_1-IRNIN_TLDEC_1);
INRCSG_NTLDECD_1 = INRCSG_NTLDEC_1 * positif_ou_nul(CSG_TLDEC_1 - CSG_NTLDEC_1) + INRCSG_NTL_1 *positif(CSG_NTLDEC_1-CSG_TLDEC_1);
INRCRDS_NTLDECD_1 = INRCRDS_NTLDEC_1 * positif_ou_nul(RDS_TLDEC_1 - CRDS_NTLDEC_1) + INRCRDS_NTL_1 *positif(CRDS_NTLDEC_1-RDS_TLDEC_1);
INRPRS_NTLDECD_1 = INRPRS_NTLDEC_1 * positif_ou_nul(PRS_TLDEC_1 - PRS_NTLDEC_1) + INRPRS_NTL_1 *positif(PRS_NTLDEC_1-PRS_TLDEC_1);
INRCSAL_NTLDECD_1 = INRCSAL_NTLDEC_1 * positif_ou_nul(CSAL_TLDEC_1 - CSAL_NTLDEC_1) + INRCSAL_NTL_1 *positif(CSAL_NTLDEC_1-CSAL_TLDEC_1);
INRCDIS_NTLDECD_1 = INRCDIS_NTLDEC_1 * positif_ou_nul(CDIS_TLDEC_1 - CDIS_NTLDEC_1) + INRCDIS_NTL_1 *positif(CDIS_NTLDEC_1-CDIS_TLDEC_1);
INRTAXA_NTLDECD_1 = INRTAXA_NTLDEC_1 * positif_ou_nul(TAXA_TLDEC_1 - TAXA_NTLDEC_1) + INRTAXA_NTL_1 *positif(TAXA_NTLDEC_1-TAXA_TLDEC_1);
INRCHR_NTLDECD_1 = INRCHR_NTLDEC_1 * positif_ou_nul(CHR_TLDEC_1 - CHR_NTLDEC_1) + INRCHR_NTL_1 *positif(CHR_NTLDEC_1-CHR_TLDEC_1);
INRPCAP_NTLDECD_1 = INRPCAP_NTLDEC_1 * positif_ou_nul(PCAP_TLDEC_1 - PCAP_NTLDEC_1) + INRPCAP_NTL_1 *positif(PCAP_NTLDEC_1-PCAP_TLDEC_1);
INRGAIN_NTLDECD_1 = INRGAIN_NTLDEC_1 * positif_ou_nul(GAIN_TLDEC_1 - GAIN_NTLDEC_1) + INRGAIN_NTL_1 *positif(GAIN_NTLDEC_1-GAIN_TLDEC_1);
INRRSE1_NTLDECD_1 = INRRSE1_NTLDEC_1 * positif_ou_nul(RSE1_TLDEC_1 - RSE1_NTLDEC_1) + INRRSE1_NTL_1 *positif(RSE1_NTLDEC_1-RSE1_TLDEC_1);
INRRSE2_NTLDECD_1 = INRRSE2_NTLDEC_1 * positif_ou_nul(RSE2_TLDEC_1 - RSE2_NTLDEC_1) + INRRSE2_NTL_1 *positif(RSE2_NTLDEC_1-RSE2_TLDEC_1);
INRRSE3_NTLDECD_1 = INRRSE3_NTLDEC_1 * positif_ou_nul(RSE3_TLDEC_1 - RSE3_NTLDEC_1) + INRRSE3_NTL_1 *positif(RSE3_NTLDEC_1-RSE3_TLDEC_1);
INRRSE4_NTLDECD_1 = INRRSE4_NTLDEC_1 * positif_ou_nul(RSE4_TLDEC_1 - RSE4_NTLDEC_1) + INRRSE4_NTL_1 *positif(RSE4_NTLDEC_1-RSE4_TLDEC_1);
INRIR_TLDECD = INRIR_TLDEC * positif_ou_nul(IRNIN_TLDEC_1 - IRNIN_TLDEC) + INRIR_TLA *positif(IRNIN_TLDEC-IRNIN_TLDEC_1);
INRCSG_TLDECD = INRCSG_TLDEC * positif_ou_nul(CSG_TLDEC_1 - CSG_TLDEC) + INRCSG_TLA *positif(CSG_TLDEC-CSG_TLDEC_1);
INRCRDS_TLDECD = INRCRDS_TLDEC * positif_ou_nul(RDS_TLDEC_1 - RDS_TLDEC) + INRCRDS_TLA *positif(RDS_TLDEC-RDS_TLDEC_1);
INRPRS_TLDECD = INRPRS_TLDEC * positif_ou_nul(PRS_TLDEC_1 - PRS_TLDEC) + INRPRS_TLA *positif(PRS_TLDEC-PRS_TLDEC_1);
INRCSAL_TLDECD = INRCSAL_TLDEC * positif_ou_nul(CSAL_TLDEC_1 - CSAL_TLDEC) + INRCSAL_TLA *positif(CSAL_TLDEC-CSAL_TLDEC_1);
INRCDIS_TLDECD = INRCDIS_TLDEC * positif_ou_nul(CDIS_TLDEC_1 - CDIS_TLDEC) + INRCDIS_TLA *positif(CDIS_TLDEC-CDIS_TLDEC_1);
INRTAXA_TLDECD = INRTAXA_TLDEC * positif_ou_nul(TAXA_TLDEC_1 - TAXA_TLDEC) + INRTAXA_TLA *positif(TAXA_TLDEC-TAXA_TLDEC_1);
INRCHR_TLDECD = INRCHR_TLDEC * positif_ou_nul(CHR_TLDEC_1 - CHR_TLDEC) + INRCHR_TLA *positif(CHR_TLDEC-CHR_TLDEC_1);
INRPCAP_TLDECD = INRPCAP_TLDEC * positif_ou_nul(PCAP_TLDEC_1 - PCAP_TLDEC) + INRPCAP_TLA *positif(PCAP_TLDEC-PCAP_TLDEC_1);
INRGAIN_TLDECD = INRGAIN_TLDEC * positif_ou_nul(GAIN_TLDEC_1 - GAIN_TLDEC) + INRGAIN_TLA *positif(GAIN_TLDEC-GAIN_TLDEC_1);
INRRSE1_TLDECD = INRRSE1_TLDEC * positif_ou_nul(RSE1_TLDEC_1 - RSE1_TLDEC) + INRRSE1_TLA *positif(RSE1_TLDEC-RSE1_TLDEC_1);
INRRSE2_TLDECD = INRRSE2_TLDEC * positif_ou_nul(RSE2_TLDEC_1 - RSE2_TLDEC) + INRRSE2_TLA *positif(RSE2_TLDEC-RSE2_TLDEC_1);
INRRSE3_TLDECD = INRRSE3_TLDEC * positif_ou_nul(RSE3_TLDEC_1 - RSE3_TLDEC) + INRRSE3_TLA *positif(RSE3_TLDEC-RSE3_TLDEC_1);
INRRSE4_TLDECD = INRRSE4_TLDEC * positif_ou_nul(RSE4_TLDEC_1 - RSE4_TLDEC) + INRRSE4_TLA *positif(RSE4_TLDEC-RSE4_TLDEC_1);
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
DO_INR_IR982 = max(0,
          arr((IRNIN_REF - IRNIN_NTLDEC_198) * TXINRRED_A/200) 
            *positif(IRNIN_REF - IRNIN_NTLDEC_198))*(1-positif(DO_INR_IR2)) * present(IRNIN_NTLDEC_198);
DO_INR_IR992 = max(0,
          arr((IRNIN_REF - IRNIN_TLDEC_199) * TXINRRED_A/200)
            *positif(IRNIN_REF - IRNIN_TLDEC_199))*(1-positif(DO_INR_IR2)) * present(IRNIN_TLDEC_199);
SUP_IR_MAX2 = (IRNIN_REF - max(0,IRNIN_R9901)) * positif(IRNIN_REF - max(0,IRNIN_R9901))* positif(IRNIN_INR_A);
INRIR_RECT= arr(IRNIN_RECT * (TXINR_PA/100)) * positif(IRNIN_RECT) * FLAG_RECTIF;
INR_IR_TOT = max(INRIR_NTLDECD_1+INRIR_NTLDECD + (INRIR_TLDECD+INRIR_TLDEC_1)*TL_IR-INR_IR_TARDIF*null(1-IND_PASSAGE)+INRIR_R99R+RECUP_INR_IR,0)* (1-IND_RJLJ);
INCIR_TL2 = INRIR_TLDECD;
INCIR_TL_12 = INRIR_TLDEC_1;
INRIR_NET2 = max(INRIR_NTLDECD +INRIR_TLDECD*TL_IR+INRIR_R99R+RECUP_INR_IR,0)* (1-IND_RJLJ)* (1-FLAG_NINR)+DO_INR_IR2 * (-1);
INRIR_NET_12 = max(INRIR_NTLDECD_1 +INRIR_TLDEC_1*TL_IR,0)*(1-FLAG_NINR)* (1-IND_RJLJ) + (DO_INR_IR982 + DO_INR_IR992)*(-1);
INIR_TL2 = INRIR_TLA * TL_IR;
INIR_TL_12 = INRIR_TLA_1 * TL_IR;
INCIR_NET2 = max(0,(INRIR_NET2 +INRIR_NET_12
                  + (INCIR_NET_A-(INR_IR_TARDIF_A+INRIR_RETDEF_A)*positif(INRIR_NET2+INRIR_NET_12-INR_IR_TARDIF_A-INRIR_RETDEF_A)
									       *positif(ACODELAISINR)*(1-positif(INDACOINR_A)))
                  + ((INRIR_TL_A+INRIR_TL_1_A)*(1-null(TL_IR_A-TL_IR))*TL_IR))) *positif(IRNIN_INR)* (1-IND_RJLJ) ;
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
          + arr((INRCSG_NTL_A*FLAG_C02+INRCSG_NTL_1_A*FLAG_C22) 
             *positif(CSG_REF - CSG_TLDEC_1)* positif(CSG_REF - (max(0,CSG_R9901))) * positif(FLAG_C02+FLAG_C22)
	     * min(1,((CSG_REF - CSG_TLDEC_1)/(CSG_REF-max(0,CSG_R9901)))))
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
DO_INR_CSG982 = max(0,
          arr((CSG_REF - CSG_NTLDEC_198) * TXINRRED_A/200) 
            *positif(CSG_REF - CSG_NTLDEC_198))*(1-positif(DO_INR_CSG2)) * present(CSG_NTLDEC_198);
DO_INR_CSG992 = max(0,
          arr((CSG_REF - CSG_TLDEC_199) * TXINRRED_A/200)
            *positif(CSG_REF - CSG_TLDEC_199))*(1-positif(DO_INR_CSG2)) * present(CSG_TLDEC_199);
INRCSG_RECT= arr((CSG_RECT-CSGIM) * (TXINR_PA/100)) * positif(CSG_RECT) * FLAG_RECTIF;
INR_CSG_TOT = max(INRCSG_NTLDECD+INRCSG_NTLDECD_1+(INRCSG_TLDECD+INRCSG_TLDEC_1)*TL_CS-INR_CSG_TARDIF*null(1-IND_PASSAGE)+INRCSG_R99R+RECUP_INR_CSG,0)*(1-IND_RJLJ);
INRCSG_NET2 = max(INRCSG_NTLDECD+INRCSG_TLDECD*TL_CS+INRCSG_R99R+RECUP_INR_CSG,0)*(1-IND_RJLJ)+DO_INR_CSG2 * (-1);
INRCSG_NET_12 = max(INRCSG_NTLDECD_1+INRCSG_TLDEC_1*TL_CS,0)*(1-IND_RJLJ)+ (DO_INR_CSG982 + DO_INR_CSG992)*(-1);
INCCS_NET2 = max(0,(INRCSG_NET2 +INRCSG_NET_12+ INCCS_NET_A+(INRCSG_TL_A+INRCSG_TL_1_A)*(1-null(TL_CS_A-TL_CS))*positif(TL_CS))) * positif(CSG)* (1-IND_RJLJ);
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
          + arr((INRCRDS_NTL_A*FLAG_C02+INRCRDS_NTL_1_A*FLAG_C22) 
             *positif(RDS_REF - RDS_TLDEC_1)* positif(RDS_REF - (max(0,RDS_R9901))) * positif(FLAG_C02+FLAG_C22)
             * min(1,((RDS_REF - RDS_TLDEC_1)/(RDS_REF-max(0,RDS_R9901)))))
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
DO_INR_CRDS982 = max(0,
          arr((RDS_REF - CRDS_NTLDEC_198) * TXINRRED_A/200) 
            *positif(RDS_REF - CRDS_NTLDEC_198))*(1-positif(DO_INR_CRDS2)) * present(CRDS_NTLDEC_198);
DO_INR_CRDS992 = max(0,
          arr((RDS_REF - RDS_TLDEC_199) * TXINRRED_A/200)
            *positif(RDS_REF - RDS_TLDEC_199))*(1-positif(DO_INR_CRDS2)) * present(RDS_TLDEC_199);
INRCRDS_RECT= arr((CRDS_RECT-CRDSIM) * (TXINR_PA/100)) * positif(CRDS_RECT) * FLAG_RECTIF;
INR_CRDS_TOT = max(INRCRDS_NTLDECD+INRCRDS_NTLDECD_1+(INRCRDS_TLDECD+INRCRDS_TLDEC_1)*TL_CS-INR_CRDS_TARDIF*null(1-IND_PASSAGE)+INRCRDS_R99R+RECUP_INR_CRDS,0) 
	       * (1-IND_RJLJ);
INCRD_TL2 = INRCRDS_TLDEC;
INCRD_TL_12 = INRCRDS_TLDEC_1;
INRRDS_NET2 = max(INRCRDS_NTLDECD+INRCRDS_TLDECD*TL_CS+INRCRDS_R99R+RECUP_INR_CRDS,0)*(1-IND_RJLJ)+DO_INR_CRDS2 * (-1);
INRRDS_NET_12 = max(INRCRDS_NTLDECD_1+INRCRDS_TLDEC_1*TL_CS,0)*(1-IND_RJLJ)+ (DO_INR_CRDS982 + DO_INR_CRDS992)*(-1);
INRD_TL2 = INRCRDS_TLA * TL_CS;
INRD_TL_12 = INRCRDS_TLA_1 * TL_CS;
INCRD_NET2 = max(0,(INRRDS_NET2 +INRRDS_NET_12+ INCRD_NET_A+(INRCRDS_TL_A+INRCRDS_TL_1_A)*(1-null(TL_CS_A-TL_CS))*positif(TL_CS))) * positif(RDSN)* (1-IND_RJLJ);
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
          + arr((INRPRS_NTL_A*FLAG_C02+INRPRS_NTL_1_A*FLAG_C22) 
             *positif(PRS_REF - PRS_TLDEC_1)* positif(PRS_REF - (max(0,PRS_R9901))) * positif(FLAG_C02+FLAG_C22)
             * min(1,((PRS_REF - PRS_TLDEC_1)/(PRS_REF-max(0,PRS_R9901)))))
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
DO_INR_PRS982 = max(0,
          arr((PRS_REF - PRS_NTLDEC_198) * TXINRRED_A/200) 
            *positif(PRS_REF - PRS_NTLDEC_198))*(1-positif(DO_INR_PS2)) * present(PRS_NTLDEC_198);
DO_INR_PRS992 = max(0,
          arr((PRS_REF - PRS_TLDEC_199) * TXINRRED_A/200)
            *positif(PRS_REF - PRS_TLDEC_199))*(1-positif(DO_INR_PS2)) * present(PRS_TLDEC_199);
INRPRS_RECT= arr((PS_RECT-PRSPROV) * (TXINR_PA/100)) * positif(PS_RECT) * FLAG_RECTIF;
INR_PS_TOT = max(INRPRS_NTLDECD+INRPRS_NTLDECD_1+(INRPRS_TLDECD+INRPRS_TLDEC_1)*TL_CS-INR_PS_TARDIF*null(1-IND_PASSAGE)+INRPRS_R99R+RECUP_INR_PRS,0) * (1-IND_RJLJ);
INCPS_TL2 = INRPRS_TLDECD;
INCPS_TL_12 = INRPRS_TLDEC_1;
INRPRS_NET2 = max(INRPRS_NTLDECD+INRPRS_TLDECD*TL_CS+INRPRS_R99R+RECUP_INR_PRS,0)*(1-IND_RJLJ)+DO_INR_PS2 * (-1);
INRPRS_NET_12 = max(INRPRS_NTLDECD_1+INRPRS_TLDEC_1*TL_CS,0)*(1-IND_RJLJ) + (DO_INR_PRS982 + DO_INR_PRS992)*(-1);
INPS_TL2 = INRPRS_TLA * TL_CS;
INPS_TL_12 = INRPRS_TLA_1 * TL_CS;
INCPS_NET2 = max(0,(INRPRS_NET2 + INRPRS_NET_12 + INCPS_NET_A+(INRPRS_TL_A+INRPRS_TL_1_A)*(1-null(TL_CS_A-TL_CS))*positif(TL_CS))) * positif(PRS) * (1-IND_RJLJ);
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
          + arr((INRTAXA_NTL_A*FLAG_C02+INRTAXA_NTL_1_A*FLAG_C22) 
             *positif(TAXA_REF - TAXA_TLDEC_1)* positif(TAXA_REF - (max(0,TAXA_R9901))) * positif(FLAG_C02+FLAG_C22)
             * min(1,((TAXA_REF - TAXA_TLDEC_1)/(TAXA_REF-max(0,TAXA_R9901)))))
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
DO_INR_TAXA982 = max(0,
          arr((TAXA_REF - TAXA_NTLDEC_198) * TXINRRED_A/200) 
            *positif(TAXA_REF - TAXA_NTLDEC_198))*(1-positif(DO_INR_TAXA2)) * present(TAXA_NTLDEC_198);
DO_INR_TAXA992 = max(0,
          arr((TAXA_REF - TAXA_TLDEC_199) * TXINRRED_A/200)
            *positif(TAXA_REF - TAXA_TLDEC_199))*(1-positif(DO_INR_TAXA2)) * present(TAXA_TLDEC_199);
INR_TAXAGA_TOT = max(INRTAXA_NTLDECD+INRTAXA_NTLDEC_1 + (INRTAXA_TLDEC+INRTAXA_TLDEC_1)*TL_TAXAGA-INR_TAXAGA_TARDIF*null(1-IND_PASSAGE)+INRTAXA_R99R+RECUP_INR_TAXA,0) 
	      * (1-IND_RJLJ);
INRTAXA_RECT= arr(TAXAGA_RECT * (TXINR_PA/100)) * positif(TAXAGA_RECT) * FLAG_RECTIF;
INCTAXA_TL2 = INRTAXA_TLDECD;
INCTAXA_TL_12 = INRTAXA_TLDEC_1;
INTAXA_TL2 = INRTAXA_TLA * TL_TAXAGA;
INTAXA_TL_12 = INRTAXA_TLA_1 * TL_TAXAGA;
INRTAXA_NET2 = max(INRTAXA_NTLDECD+INRTAXA_TLDECD*TL_TAXAGA+INRTAXA_R99R+RECUP_INR_TAXA,0)*(1-IND_RJLJ)+DO_INR_TAXA2 * (-1);
INRTAXA_NET_12 = max(INRTAXA_NTLDECD_1+INRTAXA_TLDEC_1*TL_TAXAGA,0)*(1-IND_RJLJ)+ (DO_INR_TAXA982 + DO_INR_TAXA992)*(-1);
INCTAXA_NET2 = max(0,(INRTAXA_NET2 + INRTAXA_NET_12 + INCTAXA_NET_A+(INRTAXA_TL_A+INRTAXA_TL_1_A)*(1-null(TL_TAXAGA_A-TL_TAXAGA))*positif(TL_TAXAGA))) * positif(TAXABASE)* (1-IND_RJLJ);
TAXAGA_PRI2=TAXA_R9901;
TAXAGA_ANT2=TAXABASE_A;
TAXAGA_NTL2=TAXA_NTLDEC;
TAXAGA_NTL_12=TAXA_NTLDEC_1;
TAXAGA_TL2=TAXA_TLDEC;
TAXAGA_TL_12=TAXA_TLDEC_1;
TAXA_REF_INR=TAXA_REF;

regle corrective 1084:
application : oceans, iliad ;
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
          + arr((INRCSAL_NTL_A*FLAG_C02+INRCSAL_NTL_1_A*FLAG_C22) 
             *positif(CSAL_REF - CSAL_TLDEC_1)* positif(CSAL_REF - (max(0,CSAL_R9901))) * positif(FLAG_C02+FLAG_C22)
             * min(1,((CSAL_REF - CSAL_TLDEC_1)/(CSAL_REF-max(0,CSAL_R9901)))))
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
DO_INR_CSAL982 = max(0,
          arr((CSAL_REF - CSAL_NTLDEC_198) * TXINRRED_A/200) 
            *positif(CSAL_REF - CSAL_NTLDEC_198))*(1-positif(DO_INR_CSAL2)) * present(CSAL_NTLDEC_198);
DO_INR_CSAL992 = max(0,
          arr((CSAL_REF - CSAL_TLDEC_199) * TXINRRED_A/200)
            *positif(CSAL_REF - CSAL_TLDEC_199))*(1-positif(DO_INR_CSAL2)) * present(CSAL_TLDEC_199);
INR_CSAL_TOT = max(INRCSAL_NTLDECD+INRCSAL_NTLDECD_1 + (INRCSAL_TLDECD+INRCSAL_TLDEC_1)*TL_CSAL-INR_CSAL_TARDIF*null(1-IND_PASSAGE)+INRCSAL_R99R+RECUP_INR_CSAL,0) 
	      * (1-IND_RJLJ);
INRCSAL_RECT= arr((CSAL_RECT-CSALPROV) * (TXINR_PA/100)) * positif(CSAL_RECT) * FLAG_RECTIF;
INCCSAL_TL2 = INRCSAL_TLDECD;
INCCSAL_TL_12 = INRCSAL_TLDEC_1;
INCSAL_TL2 = INRCSAL_TLA * TL_CSAL;
INCSAL_TL_12 = INRCSAL_TLA_1 * TL_CSAL;
INRCSAL_NET2 = max(INRCSAL_NTLDECD+INRCSAL_TLDECD*TL_CSAL+INRCSAL_R99R+RECUP_INR_CSAL,0)*(1-IND_RJLJ)+DO_INR_CSAL2 * (-1);
INRCSAL_NET_12 = max(INRCSAL_NTLDECD_1+INRCSAL_TLDEC_1*TL_CSAL,0)*(1-IND_RJLJ) + (DO_INR_CSAL982 + DO_INR_CSAL992)*(-1);
INCCSAL_NET2 = max(0,(INRCSAL_NET2 + INRCSAL_NET_12 + INCCSAL_NET_A+(INRCSAL_TL_A+INRCSAL_TL_1_A)*(1-null(TL_CSAL_A-TL_CSAL))*positif(TL_CSAL))) * positif(CSALBASE)* (1-IND_RJLJ);
CSAL_PRI2=CSAL_R9901;
CSAL_ANT2=CSALBASE_A;
CSAL_NTL2=CSAL_NTLDEC;
CSAL_NTL_12=CSAL_NTLDEC_1;
CSAL_TL2=CSAL_TLDEC;
CSAL_TL_12=CSAL_TLDEC_1;
CSAL_REF_INR=CSAL_REF;
INRCDIS_R99RA = INRCDIS_R99R_A;
INRCDIS_R99R = arr((CDIS_R99R-CDISPROV) * (TXINR_PA/100)-INCCDIS_NET_A) * positif(CDIS_R99R-CDIS_R99R_A)*positif(IND_PASSAGE-1);
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
          + arr((INRCDIS_NTL_A*FLAG_C02+INRCDIS_NTL_1_A*FLAG_C22) 
             *positif(CDIS_REF - CDIS_TLDEC_1)* positif(CDIS_REF - (max(0,CDIS_R9901))) * positif(FLAG_C02+FLAG_C22)
             * min(1,((CDIS_REF - CDIS_TLDEC_1)/(CDIS_REF-max(0,CDIS_R9901)))))
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
DO_INR_CDIS982 = max(0,
          arr((CDIS_REF - CDIS_NTLDEC_198) * TXINRRED_A/200) 
            *positif(CDIS_REF - CDIS_NTLDEC_198))*(1-positif(DO_INR_CDIS2)) * present(CDIS_NTLDEC_198);
DO_INR_CDIS992 = max(0,
          arr((CDIS_REF - CDIS_TLDEC_199) * TXINRRED_A/200)
            *positif(CDIS_REF - CDIS_TLDEC_199))*(1-positif(DO_INR_CDIS2)) * present(CDIS_TLDEC_199);
INR_CDIS_TOT = max(INRCDIS_NTLDECD+INRCDIS_NTLDECD_1 + (INRCDIS_TLDECD+INRCDIS_TLDEC_1)*TL_CDIS-INR_CDIS_TARDIF*null(1-IND_PASSAGE)+INRCDIS_R99R+RECUP_INR_CDIS,0) 
	      * (1-IND_RJLJ);
INRCDIS_RECT= arr((CDIS_RECT -CDISPROV)* (TXINR_PA/100)) * positif(CDIS_RECT) * FLAG_RECTIF;
INCCDIS_TL2 = INRCDIS_TLDECD;
INCCDIS_TL_12 = INRCDIS_TLDEC_1;
INCDIS_TL2 = INRCDIS_TLA * TL_CDIS;
INCDIS_TL_12 = INRCDIS_TLA_1 * TL_CDIS;
INRCDIS_NET2 = max(INRCDIS_NTLDECD+INRCDIS_TLDECD*TL_CDIS+INRCDIS_R99R+RECUP_INR_CDIS,0)*(1-IND_RJLJ)+DO_INR_CDIS2 * (-1);
INRCDIS_NET_12 = max(INRCDIS_NTLDECD_1+INRCDIS_TLDEC_1*TL_CDIS,0)*(1-IND_RJLJ)+ (DO_INR_CDIS982 + DO_INR_CDIS992)*(-1);
INCCDIS_NET2 = max(0,(INRCDIS_NET2 + INRCDIS_NET_12 + INCCDIS_NET_A+(INRCDIS_TL_A+INRCDIS_TL_1_A)*(1-null(TL_CDIS_A-TL_CDIS))*positif(TL_CDIS))) * positif(CDISBASE)* (1-IND_RJLJ);
CDIS_PRI2=CDIS_R9901;
CDIS_ANT2=CDISBASE_A;
CDIS_NTL2=CDIS_NTLDEC;
CDIS_NTL_12=CDIS_NTLDEC_1;
CDIS_TL2=CDIS_TLDEC;
CDIS_TL_12=CDIS_TLDEC_1;
CDIS_REF_INR=CDIS_REF;
INRCHR_R99RA = INRCHR_R99R_A;
INRCHR_R99R = arr((CHR_R99R) * (TXINR_PA/100)-INCCHR_NET_A) * positif(CHR_R99R-CHR_R99R_A)*positif(IND_PASSAGE-1);
INRCHR_R9901A = INRCHR_R9901_A;
INRCHR_R9901 = arr(CHR_R9901 * (TXINR_PA/100)-INCCHR_NET_A) * positif(CHR_R9901- CHR_R9901_A)
              * positif(IND_PASSAGE-1) * positif(CHR_TLDEC-CHR_R9901) * positif(CHR_R9901_A)
             + (arr(CHR_R9901 * (TXINR_PA/100))-INCCHR_NET_A) * positif(CHR_R9901- CHRBASE_A)
              * positif(IND_PASSAGE-1) * positif(CHR_TLDEC-CHR_R9901) * (1-positif(CHR_R9901_A))
             + (INCCHR_NET_A - arr(CHR_R9901 * (TXINR_PA/100))) * positif(CHRBASE_A- CHR_R9901)
              * positif(IND_PASSAGE-1) * positif(CHR_TLDEC-CHR_R9901) * (1-positif(CHR_R9901_A)) * positif(CHR_R9901)
	     ;
DO_INR_CHRC=DO_INR_CHR_A;
INR_NTL_GLOB_CHR2 = INRCHR_NTLDECD + INRCHR_NTL_A+ INRCHR_NTLDECD_1 + INRCHR_NTL_1_A;
INR_TL_GLOB_CHR2 = INRCHR_TLDECD + INRCHR_TL_A+ INRCHR_TLDEC_1 + INRCHR_TL_1_A;
INR_TOT_GLOB_CHR2 = max(0,INR_NTL_GLOB_CHR2 + INR_TL_GLOB_CHR2*TL_CHR+INRCHR_R99R+INRCHR_R99R_A) * (1-IND_RJLJ);
INR_TOT_GLOB_CHRC= (INRCHR_NTLDECD+ INRCHR_NTL_A+ (INRCHR_TLDECD + INRCHR_TL_A)*TL_CHR +INRCHR_R99R+INRCHR_R99R_A) * (1-IND_RJLJ) ;
DO_INR_CHR2 = max(0,
           (arr(((INRCHR_TL_A+INRCHR_TL_1_A)*TL_CHR_A*TL_CHR + INRCHR_NTL_A+INRCHR_NTL_1_A)
           * min(1,((CHR_REF - CHR_TLDEC_1)/(CHR_REF-max(0,CHR_R9901))))) 
             * (1-positif(FLAG_RETARD + FLAG_DEFAUT))
             * positif(CHR_REF - CHR_TLDEC_1)* positif(CHR_REF - (max(0,CHR_R9901))))
              * (1-positif(FLAG_C02+FLAG_C22))
	     *(1-positif_ou_nul(CHR_TLDEC_1 - CHRBASE_A))
           +arr(((INRCHR_TL_A+INRCHR_TL_1_A)*TL_CHR_A*TL_CHR)
             * min(1,((CHR_REF - CHR_TLDEC_1)/(CHR_REF-max(0,CHR_R9901)))))
             * (1-positif(FLAG_RETARD + FLAG_DEFAUT))
             * positif(CHR_REF - CHR_TLDEC_1)* positif(CHR_REF - (max(0,CHR_R9901)))
             * positif(FLAG_C02+FLAG_C22)
             *(1-positif_ou_nul(CHR_TLDEC_1 - CHRBASE_A))
             * (1-positif(INRCHR_NTL_A+INRCHR_NTL_1_A))
          + (INRCHR_NTL_A*FLAG_C02+INRCHR_NTL_1_A*FLAG_C22) 
             *positif(CHR_REF - CHR_TLDEC_1)* positif(CHR_REF - (max(0,CHR_R9901))) * positif(FLAG_C02+FLAG_C22)
             * positif(INRCHR_NTL_A)*positif(INRCHR_NTL_1_A)
          + arr((INRCHR_NTL_A*FLAG_C02+INRCHR_NTL_1_A*FLAG_C22) 
             *positif(CHR_REF - CHR_TLDEC_1)* positif(CHR_REF - (max(0,CHR_R9901))) * positif(FLAG_C02+FLAG_C22)
             * min(1,((CHR_REF - CHR_TLDEC_1)/(CHR_REF-max(0,CHR_R9901)))))
             * (1-positif(INRCHR_NTL_A)*positif(INRCHR_NTL_1_A))
          + ((INRCHR_TL_A+INRCHR_TL_1_A)*null(TL_CHR) * TL_CHR_A
          * (1- FLAG_DEFAUT)
             *positif(CHR_REF - CHR_TLDEC_1)* positif(CHR_REF - (max(0,CHR_R9901))))
         + ((INRCHR_TL_A + INRCHR_R99R_A+INRCHR_NTL_A - max(0,arr(CHR_TLDEC * TXINR_PA/100))) * positif(CHR_R9901 - CHR_TLDEC)
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * positif(ACODELAISINR)
         + ((INRCHR_R99R_A+INRCHR_NTL_A - max(0,arr(CHR_R9901 * TXINR_PA/100))) * positif(CHR_TLDEC-(CHR_R9901))
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
		       * positif(ACODELAISINR)
         + ((INRCHR_TL_A + INRCHR_R99R_A+INRCHR_NTL_A - max(0,arr(CHR_R9901 * TXINR_PA/100))) * null(CHR_TLDEC-(CHR_R9901))
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
		       * positif(ACODELAISINR)
         + (arr((INRCHR_TL_A*TL_CHR_A *TL_CHR+(INRCHR_NTL_A +INRCHR_R99R+INRCHR_R9901-INRCHR_RETDEF-INR_CHR_TARDIF) 
                       * ((CHR_REF - CHR_TLDEC)/(CHR_REF-max(0,CHR_REF_A)))))
                       * positif(CHR_REF - CHR_TLDEC)  * positif(CHR_TLDEC - CHR_R9901) 
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR+0))
                       * positif(INRCHR_R99R_A+INRCHR_R9901_A+0)
         + (arr((INRCHR_TL_A*TL_CHR_A*TL_CHR +(INRCHR_NTL_A+INRCHR_RETDEF-(INR_CHR_TARDIF-INRCHR_R9901))
	               *(CHR_REF - CHR_TLDEC)/(CHR_REF-max(0,CHR_R9901))))
                       * positif(CHR_REF - CHR_TLDEC) * positif(CHR_TLDEC - CHR_R9901) 
	               * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR+0))
                       * (1-positif(INRCHR_R99R_A+INRCHR_R9901_A+0))
         + ((INR_TOT_GLOB_CHR - DO_INR_CHR_A - arr(CHR_TLDEC * TXINR_PA/100))
                       * positif(CHR_R9901 - CHR_TLDEC) 
                       * positif(CHR_REF - CHR_TLDEC)
	               * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR+0))
         + ((INRCHR_R99R_A + INRCHR_NTL_A- arr(CHR_R9901 * TXINR_PA/100)) * null(CHR_TLDEC - CHR_R9901)
                       * positif(CHR_REF - CHR_TLDEC)
		       * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR))
            );

RECUP_INR_CHR = (min(DO_INR_CHR_A,arr(DO_INR_CHR_A * (CHR_TLDEC - CHRBASE_A)/DO_CHR_A))
                    *positif(CHR_TLDEC-CHRBASE_A)*positif(CHR_REF-CHRBASE_A)
                    * positif(CHRBASE_A - CHR_R9901)
                    *positif(FLAG_RETARD + FLAG_DEFAUT))
		+ min(DO_INR_CHR_A,arr((CHR_R9901 - CHRBASE_A) * TXINR_PA/100))*positif(CHR_TLDEC - CHRBASE_A)
                    * positif(CHR_R9901-CHRBASE_A)
                    *positif(DO_INR_CHR_A)
		    *positif(FLAG_RETARD + FLAG_DEFAUT);
DO_CHR2 = (CHR_REF - CHR_TLDEC_1) * positif(CHR_REF - CHR_TLDEC_1)* positif(CHRBASE_A);
SUP_CHR_MAX2 = (CHR_REF - max(0,CHR_R9901)) * positif(CHR_REF - max(0,CHR_R9901))* positif(CHRBASE_A);
DO_INR_CHR982 = max(0,
          arr((CHR_REF - CHR_NTLDEC_198) * TXINRRED_A/200) 
            *positif(CHR_REF - CHR_NTLDEC_198))*(1-positif(DO_INR_CHR2)) * present(CHR_NTLDEC_198);
DO_INR_CHR992 = max(0,
          arr((CHR_REF - CHR_TLDEC_199) * TXINRRED_A/200)
            *positif(CHR_REF - CHR_TLDEC_199))*(1-positif(DO_INR_CHR2)) * present(CHR_TLDEC_199);
INR_CHR_TOT = max(INRCHR_NTLDECD+INRCHR_NTLDECD_1 + (INRCHR_TLDECD+INRCHR_TLDEC_1)*TL_CHR-INR_CHR_TARDIF*null(1-IND_PASSAGE)+INRCHR_R99R+RECUP_INR_CHR,0) 
	      * (1-IND_RJLJ);
INRCHR_RECT= arr((CHR_RECT)* (TXINR_PA/100)) * positif(CHR_RECT) * FLAG_RECTIF;
INCCHR_TL2 = INRCHR_TLDECD;
INCCHR_TL_12 = INRCHR_TLDEC_1;
INCHR_TL2 = INRCHR_TLA * TL_CHR;
INCHR_TL_12 = INRCHR_TLA_1 * TL_CHR;
INRCHR_NET2 = max(INRCHR_NTLDECD+INRCHR_TLDECD*TL_CHR+INRCHR_R99R+RECUP_INR_CHR,0)*(1-IND_RJLJ)+DO_INR_CHR2 * (-1);
INRCHR_NET_12 = max(INRCHR_NTLDECD_1+INRCHR_TLDEC_1*TL_CHR,0)*(1-IND_RJLJ)+ (DO_INR_CHR982 + DO_INR_CHR992)*(-1);
INCCHR_NET2 = max(0,(INRCHR_NET2 + INRCHR_NET_12 + INCCHR_NET_A+(INRCHR_TL_A+INRCHR_TL_1_A)*(1-null(TL_CHR_A-TL_CHR))*positif(TL_CHR))) * positif(CHRBASE)* (1-IND_RJLJ);
CHR_PRI2=CHR_R9901;
CHR_ANT2=CHRBASE_A;
CHR_NTL2=CHR_NTLDEC;
CHR_NTL_12=CHR_NTLDEC_1;
CHR_TL2=CHR_TLDEC;
CHR_TL_12=CHR_TLDEC_1;
CHR_REF_INR=CHR_REF;
INRPCAP_R99RA = INRPCAP_R99R_A;
INRPCAP_R99R = arr((PCAP_R99R) * (TXINR_PA/100)-INCPCAP_NET_A) * positif(PCAP_R99R-PCAP_R99R_A)*positif(IND_PASSAGE-1);
INRPCAP_R9901A = INRPCAP_R9901_A;
INRPCAP_R9901 = arr(PCAP_R9901 * (TXINR_PA/100)-INCPCAP_NET_A) * positif(PCAP_R9901- PCAP_R9901_A)
              * positif(IND_PASSAGE-1) * positif(PCAP_TLDEC-PCAP_R9901) * positif(PCAP_R9901_A)
             + (arr(PCAP_R9901 * (TXINR_PA/100))-INCPCAP_NET_A) * positif(PCAP_R9901- PCAPBASE_A)
              * positif(IND_PASSAGE-1) * positif(PCAP_TLDEC-PCAP_R9901) * (1-positif(PCAP_R9901_A))
             + (INCPCAP_NET_A - arr(PCAP_R9901 * (TXINR_PA/100))) * positif(PCAPBASE_A- PCAP_R9901)
              * positif(IND_PASSAGE-1) * positif(PCAP_TLDEC-PCAP_R9901) * (1-positif(PCAP_R9901_A)) * positif(PCAP_R9901)
	     ;
DO_INR_PCAPC=DO_INR_PCAP_A;
INR_NTL_GLOB_PCAP2 = INRPCAP_NTLDECD + INRPCAP_NTL_A+ INRPCAP_NTLDECD_1 + INRPCAP_NTL_1_A;
INR_TL_GLOB_PCAP2 = INRPCAP_TLDECD + INRPCAP_TL_A+ INRPCAP_TLDEC_1 + INRPCAP_TL_1_A;
INR_TOT_GLOB_PCAP2 = max(0,INR_NTL_GLOB_PCAP2 + INR_TL_GLOB_PCAP2*TL_CAP+INRPCAP_R99R+INRPCAP_R99R_A) * (1-IND_RJLJ);
INR_TOT_GLOB_PCAPC= (INRPCAP_NTLDECD+ INRPCAP_NTL_A+ (INRPCAP_TLDECD + INRPCAP_TL_A)*TL_CAP +INRPCAP_R99R+INRPCAP_R99R_A) * (1-IND_RJLJ) ;
DO_INR_PCAP2 = max(0,
           (arr(((INRPCAP_TL_A+INRPCAP_TL_1_A)*TL_CAP_A*TL_CAP+INRPCAP_NTL_A+INRPCAP_NTL_1_A)
           * min(1,((PCAP_REF - PCAP_TLDEC_1)/(PCAP_REF-max(0,PCAP_R9901))))) 
             * (1-positif(FLAG_RETARD + FLAG_DEFAUT))
             * positif(PCAP_REF - PCAP_TLDEC_1)* positif(PCAP_REF - (max(0,PCAP_R9901))))
              * (1-positif(FLAG_C02+FLAG_C22))
	     *(1-positif_ou_nul(PCAP_TLDEC_1 - PCAPBASE_A))
           +arr(((INRPCAP_TL_A+INRPCAP_TL_1_A)*TL_CAP_A*TL_CAP)
             * min(1,((PCAP_REF - PCAP_TLDEC_1)/(PCAP_REF-max(0,PCAP_R9901)))))
             * (1-positif(FLAG_RETARD + FLAG_DEFAUT))
             * positif(PCAP_REF - PCAP_TLDEC_1)* positif(PCAP_REF - (max(0,PCAP_R9901)))
             * positif(FLAG_C02+FLAG_C22)
             *(1-positif_ou_nul(PCAP_TLDEC_1 - PCAPBASE_A))
             * (1-positif(INRPCAP_NTL_A+INRPCAP_NTL_1_A))
          + (INRPCAP_NTL_A*FLAG_C02+INRPCAP_NTL_1_A*FLAG_C22) 
             *positif(PCAP_REF - PCAP_TLDEC_1)* positif(PCAP_REF - (max(0,PCAP_R9901))) * positif(FLAG_C02+FLAG_C22)
             * positif(INRPCAP_NTL_A)*positif(INRPCAP_NTL_1_A)
          + arr((INRPCAP_NTL_A*FLAG_C02+INRPCAP_NTL_1_A*FLAG_C22) 
             *positif(PCAP_REF - PCAP_TLDEC_1)* positif(PCAP_REF - (max(0,PCAP_R9901))) * positif(FLAG_C02+FLAG_C22)
             * min(1,((PCAP_REF - PCAP_TLDEC_1)/(PCAP_REF-max(0,PCAP_R9901)))))
             * (1-positif(INRPCAP_NTL_A)*positif(INRPCAP_NTL_1_A))
          + ((INRPCAP_TL_A+INRPCAP_TL_1_A)*null(TL_CAP) * TL_CAP_A
          * (1- FLAG_DEFAUT)
             *positif(PCAP_REF - PCAP_TLDEC_1)* positif(PCAP_REF - (max(0,PCAP_R9901))))
         + ((INRPCAP_TL_A + INRPCAP_R99R_A+INRPCAP_NTL_A - max(0,arr(PCAP_TLDEC * TXINR_PA/100))) * positif(PCAP_R9901 - PCAP_TLDEC)
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * positif(ACODELAISINR)
         + ((INRPCAP_R99R_A+INRPCAP_NTL_A - max(0,arr(PCAP_R9901 * TXINR_PA/100))) * positif(PCAP_TLDEC-(PCAP_R9901))
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
		       * positif(ACODELAISINR)
         + ((INRPCAP_TL_A + INRPCAP_R99R_A+INRPCAP_NTL_A - max(0,arr(PCAP_R9901 * TXINR_PA/100))) * null(PCAP_TLDEC-(PCAP_R9901))
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
		       * positif(ACODELAISINR)
         + (arr((INRPCAP_TL_A*TL_CAP_A *TL_CAP+(INRPCAP_NTL_A +INRPCAP_R99R+INRPCAP_R9901-INRPCAP_RETDEF-INR_PCAP_TARDIF) 
                       * ((PCAP_REF - PCAP_TLDEC)/(PCAP_REF-max(0,PCAP_REF_A)))))
                       * positif(PCAP_REF - PCAP_TLDEC)  * positif(PCAP_TLDEC - PCAP_R9901) 
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR+0))
                       * positif(INRPCAP_R99R_A+INRPCAP_R9901_A+0)
         + (arr((INRPCAP_TL_A*TL_CAP_A*TL_CAP +(INRPCAP_NTL_A+INRPCAP_RETDEF-(INR_PCAP_TARDIF-INRPCAP_R9901))
	               *(PCAP_REF - PCAP_TLDEC)/(PCAP_REF-max(0,PCAP_R9901))))
                       * positif(PCAP_REF - PCAP_TLDEC) * positif(PCAP_TLDEC - PCAP_R9901) 
	               * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR+0))
                       * (1-positif(INRPCAP_R99R_A+INRPCAP_R9901_A+0))
         + ((INR_TOT_GLOB_PCAP - DO_INR_PCAP_A - arr(PCAP_TLDEC * TXINR_PA/100))
                       * positif(PCAP_R9901 - PCAP_TLDEC) 
                       * positif(PCAP_REF - PCAP_TLDEC)
	               * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR+0))
         + ((INRPCAP_R99R_A + INRPCAP_NTL_A- arr(PCAP_R9901 * TXINR_PA/100)) * null(PCAP_TLDEC - PCAP_R9901)
                       * positif(PCAP_REF - PCAP_TLDEC)
		       * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR))
            );

RECUP_INR_PCAP = (min(DO_INR_PCAP_A,arr(DO_INR_PCAP_A * (PCAP_TLDEC - PCAPBASE_A)/DO_PCAP_A))
                    *positif(PCAP_TLDEC-PCAPBASE_A)*positif(PCAP_REF-PCAPBASE_A)
                    * positif(PCAPBASE_A - PCAP_R9901)
                    *positif(FLAG_RETARD + FLAG_DEFAUT))
		+ min(DO_INR_PCAP_A,arr((PCAP_R9901 - PCAPBASE_A) * TXINR_PA/100))*positif(PCAP_TLDEC - PCAPBASE_A)
                    * positif(PCAP_R9901-PCAPBASE_A)
                    *positif(DO_INR_PCAP_A)
		    *positif(FLAG_RETARD + FLAG_DEFAUT);
DO_PCAP2 = (PCAP_REF - PCAP_TLDEC_1) * positif(PCAP_REF - PCAP_TLDEC_1)* positif(PCAPBASE_A);
SUP_PCAP_MAX2 = (PCAP_REF - max(0,PCAP_R9901)) * positif(PCAP_REF - max(0,PCAP_R9901))* positif(PCAPBASE_A);
DO_INR_PCAP982 = max(0,
          arr((PCAP_REF - PCAP_NTLDEC_198) * TXINRRED_A/200) 
            *positif(PCAP_REF - PCAP_NTLDEC_198))*(1-positif(DO_INR_PCAP2)) * present(PCAP_NTLDEC_198);
DO_INR_PCAP992 = max(0,
          arr((PCAP_REF - PCAP_TLDEC_199) * TXINRRED_A/200)
            *positif(PCAP_REF - PCAP_TLDEC_199))*(1-positif(DO_INR_PCAP2)) * present(PCAP_TLDEC_199);
INR_PCAP_TOT = max(INRPCAP_NTLDECD+INRPCAP_NTLDECD_1 + (INRPCAP_TLDECD+INRPCAP_TLDEC_1)*TL_CAP-INR_PCAP_TARDIF*null(1-IND_PASSAGE)+INRPCAP_R99R+RECUP_INR_PCAP,0) 
	      * (1-IND_RJLJ);
INRPCAP_RECT= arr((PCAP_RECT)* (TXINR_PA/100)) * positif(PCAP_RECT) * FLAG_RECTIF;
INCPCAP_TL2 = INRPCAP_TLDECD;
INCPCAP_TL_12 = INRPCAP_TLDEC_1;
INPCAP_TL2 = INRPCAP_TLA * TL_CAP;
INPCAP_TL_12 = INRPCAP_TLA_1 * TL_CAP;
INRPCAP_NET2 = max(INRPCAP_NTLDECD+INRPCAP_TLDECD*TL_CAP+INRPCAP_R99R+RECUP_INR_PCAP,0)*(1-IND_RJLJ)+DO_INR_PCAP2 * (-1);
INRPCAP_NET_12 = max(INRPCAP_NTLDECD_1+INRPCAP_TLDEC_1*TL_CAP,0)*(1-IND_RJLJ)+ (DO_INR_PCAP982 + DO_INR_PCAP992)*(-1);
INCPCAP_NET2 = max(0,(INRPCAP_NET2 + INRPCAP_NET_12 + INCPCAP_NET_A+(INRPCAP_TL_A+INRPCAP_TL_1_A)*(1-null(TL_CAP_A-TL_CAP))*positif(TL_CAP))) * positif(PCAPBASE)* (1-IND_RJLJ);
PCAP_PRI2=PCAP_R9901;
PCAP_ANT2=PCAPBASE_A;
PCAP_NTL2=PCAP_NTLDEC;
PCAP_NTL_12=PCAP_NTLDEC_1;
PCAP_TL2=PCAP_TLDEC;
PCAP_TL_12=PCAP_TLDEC_1;
PCAP_REF_INR=PCAP_REF;
INRGAIN_R99RA = INRGAIN_R99R_A;
INRGAIN_R99R = arr((GAIN_R99R-GAINPROV) * (TXINR_PA/100)-INCGAIN_NET_A) * positif(GAIN_R99R-GAIN_R99R_A)*positif(IND_PASSAGE-1);
INRGAIN_R9901A = INRGAIN_R9901_A;
INRGAIN_R9901 = arr(GAIN_R9901 * (TXINR_PA/100)-INCGAIN_NET_A) * positif(GAIN_R9901- GAIN_R9901_A)
              * positif(IND_PASSAGE-1) * positif(GAIN_TLDEC-GAIN_R9901) * positif(GAIN_R9901_A)
             + (arr(GAIN_R9901 * (TXINR_PA/100))-INCGAIN_NET_A) * positif(GAIN_R9901- GAINBASE_A)
              * positif(IND_PASSAGE-1) * positif(GAIN_TLDEC-GAIN_R9901) * (1-positif(GAIN_R9901_A))
             + (INCGAIN_NET_A - arr(GAIN_R9901 * (TXINR_PA/100))) * positif(GAINBASE_A- GAIN_R9901)
              * positif(IND_PASSAGE-1) * positif(GAIN_TLDEC-GAIN_R9901) * (1-positif(GAIN_R9901_A)) * positif(GAIN_R9901)
	     ;
DO_INR_GAINC=DO_INR_GAIN_A;
INR_NTL_GLOB_GAIN2 = INRGAIN_NTLDECD + INRGAIN_NTL_A+ INRGAIN_NTLDECD_1 + INRGAIN_NTL_1_A;
INR_TL_GLOB_GAIN2 = INRGAIN_TLDECD + INRGAIN_TL_A+ INRGAIN_TLDEC_1 + INRGAIN_TL_1_A;
INR_TOT_GLOB_GAIN2 = max(0,INR_NTL_GLOB_GAIN2 + INR_TL_GLOB_GAIN2*TL_GAIN+INRGAIN_R99R+INRGAIN_R99R_A) * (1-IND_RJLJ);
INR_TOT_GLOB_GAINC= (INRGAIN_NTLDECD+ INRGAIN_NTL_A+ (INRGAIN_TLDECD + INRGAIN_TL_A)*TL_GAIN +INRGAIN_R99R+INRGAIN_R99R_A) * (1-IND_RJLJ) ;
DO_INR_GAIN2 = max(0,
           (arr(((INRGAIN_TL_A+INRGAIN_TL_1_A)*TL_GAIN_A*TL_GAIN + INRGAIN_NTL_A+INRGAIN_NTL_1_A)
           * min(1,((GAIN_REF - GAIN_TLDEC_1)/(GAIN_REF-max(0,GAIN_R9901))))) 
             * (1-positif(FLAG_RETARD + FLAG_DEFAUT))
             * positif(GAIN_REF - GAIN_TLDEC_1)* positif(GAIN_REF - (max(0,GAIN_R9901))))
              * (1-positif(FLAG_C02+FLAG_C22))
	     *(1-positif_ou_nul(GAIN_TLDEC_1 - GAINBASE_A))
           +arr(((INRGAIN_TL_A+INRGAIN_TL_1_A)*TL_GAIN_A*TL_GAIN)
             * min(1,((GAIN_REF - GAIN_TLDEC_1)/(GAIN_REF-max(0,GAIN_R9901)))))
             * (1-positif(FLAG_RETARD + FLAG_DEFAUT))
             * positif(GAIN_REF - GAIN_TLDEC_1)* positif(GAIN_REF - (max(0,GAIN_R9901)))
             * positif(FLAG_C02+FLAG_C22)
             *(1-positif_ou_nul(GAIN_TLDEC_1 - GAINBASE_A))
             * (1-positif(INRGAIN_NTL_A+INRGAIN_NTL_1_A))
          + (INRGAIN_NTL_A*FLAG_C02+INRGAIN_NTL_1_A*FLAG_C22) 
             *positif(GAIN_REF - GAIN_TLDEC_1)* positif(GAIN_REF - (max(0,GAIN_R9901))) * positif(FLAG_C02+FLAG_C22)
             * positif(INRGAIN_NTL_A)*positif(INRGAIN_NTL_1_A)
          + arr((INRGAIN_NTL_A*FLAG_C02+INRGAIN_NTL_1_A*FLAG_C22) 
             *positif(GAIN_REF - GAIN_TLDEC_1)* positif(GAIN_REF - (max(0,GAIN_R9901))) * positif(FLAG_C02+FLAG_C22)
             * min(1,((GAIN_REF - GAIN_TLDEC_1)/(GAIN_REF-max(0,GAIN_R9901)))))
             * (1-positif(INRGAIN_NTL_A)*positif(INRGAIN_NTL_1_A))
          + ((INRGAIN_TL_A+INRGAIN_TL_1_A)*null(TL_GAIN) * TL_GAIN_A
          * (1- FLAG_DEFAUT)
             *positif(GAIN_REF - GAIN_TLDEC_1)* positif(GAIN_REF - (max(0,GAIN_R9901))))
         + ((INRGAIN_TL_A + INRGAIN_R99R_A+INRGAIN_NTL_A - max(0,arr(GAIN_TLDEC * TXINR_PA/100))) * positif(GAIN_R9901 - GAIN_TLDEC)
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * positif(ACODELAISINR)
         + ((INRGAIN_R99R_A+INRGAIN_NTL_A - max(0,arr(GAIN_R9901 * TXINR_PA/100))) * positif(GAIN_TLDEC-(GAIN_R9901))
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
		       * positif(ACODELAISINR)
         + ((INRGAIN_TL_A + INRGAIN_R99R_A+INRGAIN_NTL_A - max(0,arr(GAIN_R9901 * TXINR_PA/100))) * null(GAIN_TLDEC-(GAIN_R9901))
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
		       * positif(ACODELAISINR)
         + (arr((INRGAIN_TL_A*TL_GAIN_A *TL_GAIN+(INRGAIN_NTL_A +INRGAIN_R99R+INRGAIN_R9901-INRGAIN_RETDEF-INR_GAIN_TARDIF) 
                       * ((GAIN_REF - GAIN_TLDEC)/(GAIN_REF-max(0,GAIN_REF_A)))))
                       * positif(GAIN_REF - GAIN_TLDEC)  * positif(GAIN_TLDEC - GAIN_R9901) 
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR+0))
                       * positif(INRGAIN_R99R_A+INRGAIN_R9901_A+0)
         + (arr((INRGAIN_TL_A*TL_GAIN_A*TL_GAIN +(INRGAIN_NTL_A+INRGAIN_RETDEF-(INR_GAIN_TARDIF-INRGAIN_R9901))
	               *(GAIN_REF - GAIN_TLDEC)/(GAIN_REF-max(0,GAIN_R9901))))
                       * positif(GAIN_REF - GAIN_TLDEC) * positif(GAIN_TLDEC - GAIN_R9901) 
	               * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR+0))
                       * (1-positif(INRGAIN_R99R_A+INRGAIN_R9901_A+0))
         + ((INR_TOT_GLOB_GAIN - DO_INR_GAIN_A - arr(GAIN_TLDEC * TXINR_PA/100))
                       * positif(GAIN_R9901 - GAIN_TLDEC) 
                       * positif(GAIN_REF - GAIN_TLDEC)
	               * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR+0))
         + ((INRGAIN_R99R_A + INRGAIN_NTL_A- arr(GAIN_R9901 * TXINR_PA/100)) * null(GAIN_TLDEC - GAIN_R9901)
                       * positif(GAIN_REF - GAIN_TLDEC)
		       * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR))
            );

RECUP_INR_GAIN = (min(DO_INR_GAIN_A,arr(DO_INR_GAIN_A * (GAIN_TLDEC - GAINBASE_A)/DO_GAIN_A))
                    *positif(GAIN_TLDEC-GAINBASE_A)*positif(GAIN_REF-GAINBASE_A)
                    * positif(GAINBASE_A - GAIN_R9901)
                    *positif(FLAG_RETARD + FLAG_DEFAUT))
		+ min(DO_INR_GAIN_A,arr((GAIN_R9901 - GAINBASE_A) * TXINR_PA/100))*positif(GAIN_TLDEC - GAINBASE_A)
                    * positif(GAIN_R9901-GAINBASE_A)
                    *positif(DO_INR_GAIN_A)
		    *positif(FLAG_RETARD + FLAG_DEFAUT);
DO_GAIN2 = (GAIN_REF - GAIN_TLDEC_1) * positif(GAIN_REF - GAIN_TLDEC_1)* positif(GAINBASE_A);
SUP_GAIN_MAX2 = (GAIN_REF - max(0,GAIN_R9901)) * positif(GAIN_REF - max(0,GAIN_R9901))* positif(GAINBASE_A);
DO_INR_GAIN982 = max(0,
          arr((GAIN_REF - GAIN_NTLDEC_198) * TXINRRED_A/200) 
            *positif(GAIN_REF - GAIN_NTLDEC_198))*(1-positif(DO_INR_GAIN2)) * present(GAIN_NTLDEC_198);
DO_INR_GAIN992 = max(0,
          arr((GAIN_REF - GAIN_TLDEC_199) * TXINRRED_A/200)
            *positif(GAIN_REF - GAIN_TLDEC_199))*(1-positif(DO_INR_GAIN2)) * present(GAIN_TLDEC_199);
INR_GAIN_TOT = max(INRGAIN_NTLDECD+INRGAIN_NTLDECD_1 + (INRGAIN_TLDECD+INRGAIN_TLDEC_1)*TL_GAIN-INR_GAIN_TARDIF*null(1-IND_PASSAGE)+INRGAIN_R99R+RECUP_INR_GAIN,0) 
	      * (1-IND_RJLJ);
INRGAIN_RECT= arr((GAIN_RECT -GAINPROV)* (TXINR_PA/100)) * positif(GAIN_RECT) * FLAG_RECTIF;
INCGAIN_TL2 = INRGAIN_TLDECD;
INCGAIN_TL_12 = INRGAIN_TLDEC_1;
INGAIN_TL2 = INRGAIN_TLA * TL_GAIN;
INGAIN_TL_12 = INRGAIN_TLA_1 * TL_GAIN;
INRGAIN_NET2 = max(INRGAIN_NTLDECD+INRGAIN_TLDECD*TL_GAIN+INRGAIN_R99R+RECUP_INR_GAIN,0)*(1-IND_RJLJ)+DO_INR_GAIN2 * (-1);
INRGAIN_NET_12 = max(INRGAIN_NTLDECD_1+INRGAIN_TLDEC_1*TL_GAIN,0)*(1-IND_RJLJ)+ (DO_INR_GAIN982 + DO_INR_GAIN992)*(-1);
INCGAIN_NET2 = max(0,(INRGAIN_NET2 + INRGAIN_NET_12 + INCGAIN_NET_A+(INRGAIN_TL_A+INRGAIN_TL_1_A)*(1-null(TL_GAIN_A-TL_GAIN))*positif(TL_GAIN))) * positif(GAINBASE)* (1-IND_RJLJ);
GAIN_PRI2=GAIN_R9901;
GAIN_ANT2=GAINBASE_A;
GAIN_NTL2=GAIN_NTLDEC;
GAIN_NTL_12=GAIN_NTLDEC_1;
GAIN_TL2=GAIN_TLDEC;
GAIN_TL_12=GAIN_TLDEC_1;
GAIN_REF_INR=GAIN_REF;
INRRSE1_R99RA = INRRSE1_R99R_A;
INRRSE1_R99R = arr((RSE1_R99R) * (TXINR_PA/100)-INCRSE1_NET_A) * positif(RSE1_R99R-RSE1_R99R_A)*positif(IND_PASSAGE-1);
INRRSE1_R9901A = INRRSE1_R9901_A;
INRRSE1_R9901 = arr(RSE1_R9901 * (TXINR_PA/100)-INCRSE1_NET_A) * positif(RSE1_R9901- RSE1_R9901_A)
              * positif(IND_PASSAGE-1) * positif(RSE1_TLDEC-RSE1_R9901) * positif(RSE1_R9901_A)
             + (arr(RSE1_R9901 * (TXINR_PA/100))-INCRSE1_NET_A) * positif(RSE1_R9901- RSE1BASE_A)
              * positif(IND_PASSAGE-1) * positif(RSE1_TLDEC-RSE1_R9901) * (1-positif(RSE1_R9901_A))
             + (INCRSE1_NET_A - arr(RSE1_R9901 * (TXINR_PA/100))) * positif(RSE1BASE_A- RSE1_R9901)
              * positif(IND_PASSAGE-1) * positif(RSE1_TLDEC-RSE1_R9901) * (1-positif(RSE1_R9901_A)) * positif(RSE1_R9901)
	     ;
DO_INR_RSE1C=DO_INR_RSE1_A;
INR_NTL_GLOB_RSE12 = INRRSE1_NTLDECD + INRRSE1_NTL_A+ INRRSE1_NTLDECD_1 + INRRSE1_NTL_1_A;
INR_TL_GLOB_RSE12 = INRRSE1_TLDECD + INRRSE1_TL_A+ INRRSE1_TLDEC_1 + INRRSE1_TL_1_A;
INR_TOT_GLOB_RSE12 = max(0,INR_NTL_GLOB_RSE12 + INR_TL_GLOB_RSE12*TL_RSE1+INRRSE1_R99R+INRRSE1_R99R_A) * (1-IND_RJLJ);
INR_TOT_GLOB_RSE1C= (INRRSE1_NTLDECD+ INRRSE1_NTL_A+ (INRRSE1_TLDECD + INRRSE1_TL_A)*TL_RSE1 +INRRSE1_R99R+INRRSE1_R99R_A) * (1-IND_RJLJ) ;
DO_INR_RSE12 = max(0,
           (arr(((INRRSE1_TL_A+INRRSE1_TL_1_A)*TL_RSE1_A*TL_RSE1 + INRRSE1_NTL_A+INRRSE1_NTL_1_A)
           * min(1,((RSE1_REF - RSE1_TLDEC_1)/(RSE1_REF-max(0,RSE1_R9901))))) 
             * (1-positif(FLAG_RETARD + FLAG_DEFAUT))
             * positif(RSE1_REF - RSE1_TLDEC_1)* positif(RSE1_REF - (max(0,RSE1_R9901))))
              * (1-positif(FLAG_C02+FLAG_C22))
	     *(1-positif_ou_nul(RSE1_TLDEC_1 - RSE1BASE_A))
           +arr(((INRRSE1_TL_A+INRRSE1_TL_1_A)*TL_RSE1_A*TL_RSE1)
             * min(1,((RSE1_REF - RSE1_TLDEC_1)/(RSE1_REF-max(0,RSE1_R9901)))))
             * (1-positif(FLAG_RETARD + FLAG_DEFAUT))
             * positif(RSE1_REF - RSE1_TLDEC_1)* positif(RSE1_REF - (max(0,RSE1_R9901)))
             * positif(FLAG_C02+FLAG_C22)
             *(1-positif_ou_nul(RSE1_TLDEC_1 - RSE1BASE_A))
             * (1-positif(INRRSE1_NTL_A+INRRSE1_NTL_1_A))
          + (INRRSE1_NTL_A*FLAG_C02+INRRSE1_NTL_1_A*FLAG_C22) 
             *positif(RSE1_REF - RSE1_TLDEC_1)* positif(RSE1_REF - (max(0,RSE1_R9901))) * positif(FLAG_C02+FLAG_C22)
             * positif(INRRSE1_NTL_A)*positif(INRRSE1_NTL_1_A)
          + arr((INRRSE1_NTL_A*FLAG_C02+INRRSE1_NTL_1_A*FLAG_C22) 
             *positif(RSE1_REF - RSE1_TLDEC_1)* positif(RSE1_REF - (max(0,RSE1_R9901))) * positif(FLAG_C02+FLAG_C22)
             * min(1,((RSE1_REF - RSE1_TLDEC_1)/(RSE1_REF-max(0,RSE1_R9901)))))
             * (1-positif(INRRSE1_NTL_A)*positif(INRRSE1_NTL_1_A))
          + ((INRRSE1_TL_A+INRRSE1_TL_1_A)*null(TL_RSE1) * TL_RSE1_A
          * (1- FLAG_DEFAUT)
             *positif(RSE1_REF - RSE1_TLDEC_1)* positif(RSE1_REF - (max(0,RSE1_R9901))))
         + ((INRRSE1_TL_A + INRRSE1_R99R_A+INRRSE1_NTL_A - max(0,arr(RSE1_TLDEC * TXINR_PA/100))) * positif(RSE1_R9901 - RSE1_TLDEC)
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * positif(ACODELAISINR)
         + ((INRRSE1_R99R_A+INRRSE1_NTL_A - max(0,arr(RSE1_R9901 * TXINR_PA/100))) * positif(RSE1_TLDEC-(RSE1_R9901))
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
		       * positif(ACODELAISINR)
         + ((INRRSE1_TL_A + INRRSE1_R99R_A+INRRSE1_NTL_A - max(0,arr(RSE1_R9901 * TXINR_PA/100))) * null(RSE1_TLDEC-(RSE1_R9901))
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
		       * positif(ACODELAISINR)
         + (arr((INRRSE1_TL_A*TL_RSE1_A *TL_RSE1+(INRRSE1_NTL_A +INRRSE1_R99R+INRRSE1_R9901-INRRSE1_RETDEF-INR_RSE1_TARDIF) 
                       * ((RSE1_REF - RSE1_TLDEC)/(RSE1_REF-max(0,RSE1_REF_A)))))
                       * positif(RSE1_REF - RSE1_TLDEC)  * positif(RSE1_TLDEC - RSE1_R9901) 
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR+0))
                       * positif(INRRSE1_R99R_A+INRRSE1_R9901_A+0)
         + (arr((INRRSE1_TL_A*TL_RSE1_A*TL_RSE1 +(INRRSE1_NTL_A+INRRSE1_RETDEF-(INR_RSE1_TARDIF-INRRSE1_R9901))
	               *(RSE1_REF - RSE1_TLDEC)/(RSE1_REF-max(0,RSE1_R9901))))
                       * positif(RSE1_REF - RSE1_TLDEC) * positif(RSE1_TLDEC - RSE1_R9901) 
	               * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR+0))
                       * (1-positif(INRRSE1_R99R_A+INRRSE1_R9901_A+0))
         + ((INR_TOT_GLOB_RSE1 - DO_INR_RSE1_A - arr(RSE1_TLDEC * TXINR_PA/100))
                       * positif(RSE1_R9901 - RSE1_TLDEC) 
                       * positif(RSE1_REF - RSE1_TLDEC)
	               * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR+0))
         + ((INRRSE1_R99R_A + INRRSE1_NTL_A- arr(RSE1_R9901 * TXINR_PA/100)) * null(RSE1_TLDEC - RSE1_R9901)
                       * positif(RSE1_REF - RSE1_TLDEC)
		       * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR))
            );

RECUP_INR_RSE1 = (min(DO_INR_RSE1_A,arr(DO_INR_RSE1_A * (RSE1_TLDEC - RSE1BASE_A)/DO_RSE1_A))
                    *positif(RSE1_TLDEC-RSE1BASE_A)*positif(RSE1_REF-RSE1BASE_A)
                    * positif(RSE1BASE_A - RSE1_R9901)
                    *positif(FLAG_RETARD + FLAG_DEFAUT))
		+ min(DO_INR_RSE1_A,arr((RSE1_R9901 - RSE1BASE_A) * TXINR_PA/100))*positif(RSE1_TLDEC - RSE1BASE_A)
                    * positif(RSE1_R9901-RSE1BASE_A)
                    *positif(DO_INR_RSE1_A)
		    *positif(FLAG_RETARD + FLAG_DEFAUT);
DO_RSE12 = (RSE1_REF - RSE1_TLDEC_1) * positif(RSE1_REF - RSE1_TLDEC_1)* positif(RSE1BASE_A);
SUP_RSE1_MAX2 = (RSE1_REF - max(0,RSE1_R9901)) * positif(RSE1_REF - max(0,RSE1_R9901))* positif(RSE1BASE_A);
DO_INR_RSE1982 = max(0,
          arr((RSE1_REF - RSE1_NTLDEC_198) * TXINRRED_A/200) 
            *positif(RSE1_REF - RSE1_NTLDEC_198))*(1-positif(DO_INR_RSE12)) * present(RSE1_NTLDEC_198);
DO_INR_RSE1992 = max(0,
          arr((RSE1_REF - RSE1_TLDEC_199) * TXINRRED_A/200)
            *positif(RSE1_REF - RSE1_TLDEC_199))*(1-positif(DO_INR_RSE12)) * present(RSE1_TLDEC_199);
INR_RSE1_TOT = max(INRRSE1_NTLDECD+INRRSE1_NTLDECD_1 + (INRRSE1_TLDECD+INRRSE1_TLDEC_1)*TL_RSE1-INR_RSE1_TARDIF*null(1-IND_PASSAGE)+INRRSE1_R99R+RECUP_INR_RSE1,0) 
	      * (1-IND_RJLJ);
INRRSE1_RECT= arr((RSE1_RECT)* (TXINR_PA/100)) * positif(RSE1_RECT) * FLAG_RECTIF;
INCRSE1_TL2 = INRRSE1_TLDECD;
INCRSE1_TL_12 = INRRSE1_TLDEC_1;
INRSE1_TL2 = INRRSE1_TLA * TL_RSE1;
INRSE1_TL_12 = INRRSE1_TLA_1 * TL_RSE1;
INRRSE1_NET2 = max(INRRSE1_NTLDECD+INRRSE1_TLDECD*TL_RSE1+INRRSE1_R99R+RECUP_INR_RSE1,0)*(1-IND_RJLJ)+DO_INR_RSE12 * (-1);
INRRSE1_NET_12 = max(INRRSE1_NTLDECD_1+INRRSE1_TLDEC_1*TL_RSE1,0)*(1-IND_RJLJ)+ (DO_INR_RSE1982 + DO_INR_RSE1992)*(-1);
INCRSE1_NET2 = max(0,(INRRSE1_NET2 + INRRSE1_NET_12 + INCRSE1_NET_A+(INRRSE1_TL_A+INRRSE1_TL_1_A)*(1-null(TL_RSE1_A-TL_RSE1))*positif(TL_RSE1))) * positif(RSE1BASE)* (1-IND_RJLJ);
RSE1_PRI2=RSE1_R9901;
RSE1_ANT2=RSE1BASE_A;
RSE1_NTL2=RSE1_NTLDEC;
RSE1_NTL_12=RSE1_NTLDEC_1;
RSE1_TL2=RSE1_TLDEC;
RSE1_TL_12=RSE1_TLDEC_1;
RSE1_REF_INR=RSE1_REF;
INRRSE2_R99RA = INRRSE2_R99R_A;
INRRSE2_R99R = arr((RSE2_R99R) * (TXINR_PA/100)-INCRSE2_NET_A) * positif(RSE2_R99R-RSE2_R99R_A)*positif(IND_PASSAGE-1);
INRRSE2_R9901A = INRRSE2_R9901_A;
INRRSE2_R9901 = arr(RSE2_R9901 * (TXINR_PA/100)-INCRSE2_NET_A) * positif(RSE2_R9901- RSE2_R9901_A)
              * positif(IND_PASSAGE-1) * positif(RSE2_TLDEC-RSE2_R9901) * positif(RSE2_R9901_A)
             + (arr(RSE2_R9901 * (TXINR_PA/100))-INCRSE2_NET_A) * positif(RSE2_R9901- RSE2BASE_A)
              * positif(IND_PASSAGE-1) * positif(RSE2_TLDEC-RSE2_R9901) * (1-positif(RSE2_R9901_A))
             + (INCRSE2_NET_A - arr(RSE2_R9901 * (TXINR_PA/100))) * positif(RSE2BASE_A- RSE2_R9901)
              * positif(IND_PASSAGE-1) * positif(RSE2_TLDEC-RSE2_R9901) * (1-positif(RSE2_R9901_A)) * positif(RSE2_R9901)
	     ;
DO_INR_RSE2C=DO_INR_RSE2_A;
INR_NTL_GLOB_RSE22 = INRRSE2_NTLDECD + INRRSE2_NTL_A+ INRRSE2_NTLDECD_1 + INRRSE2_NTL_1_A;
INR_TL_GLOB_RSE22 = INRRSE2_TLDECD + INRRSE2_TL_A+ INRRSE2_TLDEC_1 + INRRSE2_TL_1_A;
INR_TOT_GLOB_RSE22 = max(0,INR_NTL_GLOB_RSE22 + INR_TL_GLOB_RSE22*TL_RSE2+INRRSE2_R99R+INRRSE2_R99R_A) * (1-IND_RJLJ);
INR_TOT_GLOB_RSE2C= (INRRSE2_NTLDECD+ INRRSE2_NTL_A+ (INRRSE2_TLDECD + INRRSE2_TL_A)*TL_RSE2 +INRRSE2_R99R+INRRSE2_R99R_A) * (1-IND_RJLJ) ;
DO_INR_RSE22 = max(0,
           (arr(((INRRSE2_TL_A+INRRSE2_TL_1_A)*TL_RSE2_A*TL_RSE2 + INRRSE2_NTL_A+INRRSE2_NTL_1_A)
           * min(1,((RSE2_REF - RSE2_TLDEC_1)/(RSE2_REF-max(0,RSE2_R9901))))) 
             * (1-positif(FLAG_RETARD + FLAG_DEFAUT))
             * positif(RSE2_REF - RSE2_TLDEC_1)* positif(RSE2_REF - (max(0,RSE2_R9901))))
              * (1-positif(FLAG_C02+FLAG_C22))
	     *(1-positif_ou_nul(RSE2_TLDEC_1 - RSE2BASE_A))
           +arr(((INRRSE2_TL_A+INRRSE2_TL_1_A)*TL_RSE2_A*TL_RSE2)
             * min(1,((RSE2_REF - RSE2_TLDEC_1)/(RSE2_REF-max(0,RSE2_R9901)))))
             * (1-positif(FLAG_RETARD + FLAG_DEFAUT))
             * positif(RSE2_REF - RSE2_TLDEC_1)* positif(RSE2_REF - (max(0,RSE2_R9901)))
             * positif(FLAG_C02+FLAG_C22)
             *(1-positif_ou_nul(RSE2_TLDEC_1 - RSE2BASE_A))
             * (1-positif(INRRSE2_NTL_A+INRRSE2_NTL_1_A))
          + (INRRSE2_NTL_A*FLAG_C02+INRRSE2_NTL_1_A*FLAG_C22) 
             *positif(RSE2_REF - RSE2_TLDEC_1)* positif(RSE2_REF - (max(0,RSE2_R9901))) * positif(FLAG_C02+FLAG_C22)
             * positif(INRRSE2_NTL_A)*positif(INRRSE2_NTL_1_A)
          + arr((INRRSE2_NTL_A*FLAG_C02+INRRSE2_NTL_1_A*FLAG_C22) 
             *positif(RSE2_REF - RSE2_TLDEC_1)* positif(RSE2_REF - (max(0,RSE2_R9901))) * positif(FLAG_C02+FLAG_C22)
             * min(1,((RSE2_REF - RSE2_TLDEC_1)/(RSE2_REF-max(0,RSE2_R9901)))))
             * (1-positif(INRRSE2_NTL_A)*positif(INRRSE2_NTL_1_A))
          + ((INRRSE2_TL_A+INRRSE2_TL_1_A)*null(TL_RSE2) * TL_RSE2_A
          * (1- FLAG_DEFAUT)
             *positif(RSE2_REF - RSE2_TLDEC_1)* positif(RSE2_REF - (max(0,RSE2_R9901))))
         + ((INRRSE2_TL_A + INRRSE2_R99R_A+INRRSE2_NTL_A - max(0,arr(RSE2_TLDEC * TXINR_PA/100))) * positif(RSE2_R9901 - RSE2_TLDEC)
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * positif(ACODELAISINR)
         + ((INRRSE2_R99R_A+INRRSE2_NTL_A - max(0,arr(RSE2_R9901 * TXINR_PA/100))) * positif(RSE2_TLDEC-(RSE2_R9901))
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
		       * positif(ACODELAISINR)
         + ((INRRSE2_TL_A + INRRSE2_R99R_A+INRRSE2_NTL_A - max(0,arr(RSE2_R9901 * TXINR_PA/100))) * null(RSE2_TLDEC-(RSE2_R9901))
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
		       * positif(ACODELAISINR)
         + (arr((INRRSE2_TL_A*TL_RSE2_A *TL_RSE2+(INRRSE2_NTL_A +INRRSE2_R99R+INRRSE2_R9901-INRRSE2_RETDEF-INR_RSE2_TARDIF) 
                       * ((RSE2_REF - RSE2_TLDEC)/(RSE2_REF-max(0,RSE2_REF_A)))))
                       * positif(RSE2_REF - RSE2_TLDEC)  * positif(RSE2_TLDEC - RSE2_R9901) 
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR+0))
                       * positif(INRRSE2_R99R_A+INRRSE2_R9901_A+0)
         + (arr((INRRSE2_TL_A*TL_RSE2_A*TL_RSE2 +(INRRSE2_NTL_A+INRRSE2_RETDEF-(INR_RSE2_TARDIF-INRRSE2_R9901))
	               *(RSE2_REF - RSE2_TLDEC)/(RSE2_REF-max(0,RSE2_R9901))))
                       * positif(RSE2_REF - RSE2_TLDEC) * positif(RSE2_TLDEC - RSE2_R9901) 
	               * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR+0))
                       * (1-positif(INRRSE2_R99R_A+INRRSE2_R9901_A+0))
         + ((INR_TOT_GLOB_RSE2 - DO_INR_RSE2_A - arr(RSE2_TLDEC * TXINR_PA/100))
                       * positif(RSE2_R9901 - RSE2_TLDEC) 
                       * positif(RSE2_REF - RSE2_TLDEC)
	               * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR+0))
         + ((INRRSE2_R99R_A + INRRSE2_NTL_A- arr(RSE2_R9901 * TXINR_PA/100)) * null(RSE2_TLDEC - RSE2_R9901)
                       * positif(RSE2_REF - RSE2_TLDEC)
		       * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR))
            );

RECUP_INR_RSE2 = (min(DO_INR_RSE2_A,arr(DO_INR_RSE2_A * (RSE2_TLDEC - RSE2BASE_A)/DO_RSE2_A))
                    *positif(RSE2_TLDEC-RSE2BASE_A)*positif(RSE2_REF-RSE2BASE_A)
                    * positif(RSE2BASE_A - RSE2_R9901)
                    *positif(FLAG_RETARD + FLAG_DEFAUT))
		+ min(DO_INR_RSE2_A,arr((RSE2_R9901 - RSE2BASE_A) * TXINR_PA/100))*positif(RSE2_TLDEC - RSE2BASE_A)
                    * positif(RSE2_R9901-RSE2BASE_A)
                    *positif(DO_INR_RSE2_A)
		    *positif(FLAG_RETARD + FLAG_DEFAUT);
DO_RSE22 = (RSE2_REF - RSE2_TLDEC_1) * positif(RSE2_REF - RSE2_TLDEC_1)* positif(RSE2BASE_A);
SUP_RSE2_MAX2 = (RSE2_REF - max(0,RSE2_R9901)) * positif(RSE2_REF - max(0,RSE2_R9901))* positif(RSE2BASE_A);
DO_INR_RSE2982 = max(0,
          arr((RSE2_REF - RSE2_NTLDEC_198) * TXINRRED_A/200) 
            *positif(RSE2_REF - RSE2_NTLDEC_198))*(1-positif(DO_INR_RSE22)) * present(RSE2_NTLDEC_198);
DO_INR_RSE2992 = max(0,
          arr((RSE2_REF - RSE2_TLDEC_199) * TXINRRED_A/200)
            *positif(RSE2_REF - RSE2_TLDEC_199))*(1-positif(DO_INR_RSE22)) * present(RSE2_TLDEC_199);
INR_RSE2_TOT = max(INRRSE2_NTLDECD+INRRSE2_NTLDECD_1 + (INRRSE2_TLDECD+INRRSE2_TLDEC_1)*TL_RSE2-INR_RSE2_TARDIF*null(1-IND_PASSAGE)+INRRSE2_R99R+RECUP_INR_RSE2,0) 
	      * (1-IND_RJLJ);
INRRSE2_RECT= arr((RSE2_RECT)* (TXINR_PA/100)) * positif(RSE2_RECT) * FLAG_RECTIF;
INCRSE2_TL2 = INRRSE2_TLDECD;
INCRSE2_TL_12 = INRRSE2_TLDEC_1;
INRSE2_TL2 = INRRSE2_TLA * TL_RSE2;
INRSE2_TL_12 = INRRSE2_TLA_1 * TL_RSE2;
INRRSE2_NET2 = max(INRRSE2_NTLDECD+INRRSE2_TLDECD*TL_RSE2+INRRSE2_R99R+RECUP_INR_RSE2,0)*(1-IND_RJLJ)+DO_INR_RSE22 * (-1);
INRRSE2_NET_12 = max(INRRSE2_NTLDECD_1+INRRSE2_TLDEC_1*TL_RSE2,0)*(1-IND_RJLJ)+ (DO_INR_RSE2982 + DO_INR_RSE2992)*(-1);
INCRSE2_NET2 = max(0,(INRRSE2_NET2 + INRRSE2_NET_12 + INCRSE2_NET_A+(INRRSE2_TL_A+INRRSE2_TL_1_A)*(1-null(TL_RSE2_A-TL_RSE2))*positif(TL_RSE2))) * positif(RSE2BASE)* (1-IND_RJLJ);
RSE2_PRI2=RSE2_R9901;
RSE2_ANT2=RSE2BASE_A;
RSE2_NTL2=RSE2_NTLDEC;
RSE2_NTL_12=RSE2_NTLDEC_1;
RSE2_TL2=RSE2_TLDEC;
RSE2_TL_12=RSE2_TLDEC_1;
RSE2_REF_INR=RSE2_REF;
INRRSE3_R99RA = INRRSE3_R99R_A;
INRRSE3_R99R = arr((RSE3_R99R) * (TXINR_PA/100)-INCRSE3_NET_A) * positif(RSE3_R99R-RSE3_R99R_A)*positif(IND_PASSAGE-1);
INRRSE3_R9901A = INRRSE3_R9901_A;
INRRSE3_R9901 = arr(RSE3_R9901 * (TXINR_PA/100)-INCRSE3_NET_A) * positif(RSE3_R9901- RSE3_R9901_A)
              * positif(IND_PASSAGE-1) * positif(RSE3_TLDEC-RSE3_R9901) * positif(RSE3_R9901_A)
             + (arr(RSE3_R9901 * (TXINR_PA/100))-INCRSE3_NET_A) * positif(RSE3_R9901- RSE3BASE_A)
              * positif(IND_PASSAGE-1) * positif(RSE3_TLDEC-RSE3_R9901) * (1-positif(RSE3_R9901_A))
             + (INCRSE3_NET_A - arr(RSE3_R9901 * (TXINR_PA/100))) * positif(RSE3BASE_A- RSE3_R9901)
              * positif(IND_PASSAGE-1) * positif(RSE3_TLDEC-RSE3_R9901) * (1-positif(RSE3_R9901_A)) * positif(RSE3_R9901)
	     ;
DO_INR_RSE3C=DO_INR_RSE3_A;
INR_NTL_GLOB_RSE32 = INRRSE3_NTLDECD + INRRSE3_NTL_A+ INRRSE3_NTLDECD_1 + INRRSE3_NTL_1_A;
INR_TL_GLOB_RSE32 = INRRSE3_TLDECD + INRRSE3_TL_A+ INRRSE3_TLDEC_1 + INRRSE3_TL_1_A;
INR_TOT_GLOB_RSE32 = max(0,INR_NTL_GLOB_RSE32 + INR_TL_GLOB_RSE32*TL_RSE3+INRRSE3_R99R+INRRSE3_R99R_A) * (1-IND_RJLJ);
INR_TOT_GLOB_RSE3C= (INRRSE3_NTLDECD+ INRRSE3_NTL_A+ (INRRSE3_TLDECD + INRRSE3_TL_A)*TL_RSE3 +INRRSE3_R99R+INRRSE3_R99R_A) * (1-IND_RJLJ) ;
DO_INR_RSE32 = max(0,
           (arr(((INRRSE3_TL_A+INRRSE3_TL_1_A)*TL_RSE3_A*TL_RSE3 + INRRSE3_NTL_A+INRRSE3_NTL_1_A)
           * min(1,((RSE3_REF - RSE3_TLDEC_1)/(RSE3_REF-max(0,RSE3_R9901))))) 
             * (1-positif(FLAG_RETARD + FLAG_DEFAUT))
             * positif(RSE3_REF - RSE3_TLDEC_1)* positif(RSE3_REF - (max(0,RSE3_R9901))))
              * (1-positif(FLAG_C02+FLAG_C22))
	     *(1-positif_ou_nul(RSE3_TLDEC_1 - RSE3BASE_A))
           +arr(((INRRSE3_TL_A+INRRSE3_TL_1_A)*TL_RSE3_A*TL_RSE3)
             * min(1,((RSE3_REF - RSE3_TLDEC_1)/(RSE3_REF-max(0,RSE3_R9901)))))
             * (1-positif(FLAG_RETARD + FLAG_DEFAUT))
             * positif(RSE3_REF - RSE3_TLDEC_1)* positif(RSE3_REF - (max(0,RSE3_R9901)))
             * positif(FLAG_C02+FLAG_C22)
             *(1-positif_ou_nul(RSE3_TLDEC_1 - RSE3BASE_A))
             * (1-positif(INRRSE3_NTL_A+INRRSE3_NTL_1_A))
          + (INRRSE3_NTL_A*FLAG_C02+INRRSE3_NTL_1_A*FLAG_C22) 
             *positif(RSE3_REF - RSE3_TLDEC_1)* positif(RSE3_REF - (max(0,RSE3_R9901))) * positif(FLAG_C02+FLAG_C22)
             * positif(INRRSE3_NTL_A)*positif(INRRSE3_NTL_1_A)
          + arr((INRRSE3_NTL_A*FLAG_C02+INRRSE3_NTL_1_A*FLAG_C22) 
             *positif(RSE3_REF - RSE3_TLDEC_1)* positif(RSE3_REF - (max(0,RSE3_R9901))) * positif(FLAG_C02+FLAG_C22)
             * min(1,((RSE3_REF - RSE3_TLDEC_1)/(RSE3_REF-max(0,RSE3_R9901)))))
             * (1-positif(INRRSE3_NTL_A)*positif(INRRSE3_NTL_1_A))
          + ((INRRSE3_TL_A+INRRSE3_TL_1_A)*null(TL_RSE3) * TL_RSE3_A
          * (1- FLAG_DEFAUT)
             *positif(RSE3_REF - RSE3_TLDEC_1)* positif(RSE3_REF - (max(0,RSE3_R9901))))
         + ((INRRSE3_TL_A + INRRSE3_R99R_A+INRRSE3_NTL_A - max(0,arr(RSE3_TLDEC * TXINR_PA/100))) * positif(RSE3_R9901 - RSE3_TLDEC)
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * positif(ACODELAISINR)
         + ((INRRSE3_R99R_A+INRRSE3_NTL_A - max(0,arr(RSE3_R9901 * TXINR_PA/100))) * positif(RSE3_TLDEC-(RSE3_R9901))
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
		       * positif(ACODELAISINR)
         + ((INRRSE3_TL_A + INRRSE3_R99R_A+INRRSE3_NTL_A - max(0,arr(RSE3_R9901 * TXINR_PA/100))) * null(RSE3_TLDEC-(RSE3_R9901))
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
		       * positif(ACODELAISINR)
         + (arr((INRRSE3_TL_A*TL_RSE3_A *TL_RSE3+(INRRSE3_NTL_A +INRRSE3_R99R+INRRSE3_R9901-INRRSE3_RETDEF-INR_RSE3_TARDIF) 
                       * ((RSE3_REF - RSE3_TLDEC)/(RSE3_REF-max(0,RSE3_REF_A)))))
                       * positif(RSE3_REF - RSE3_TLDEC)  * positif(RSE3_TLDEC - RSE3_R9901) 
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR+0))
                       * positif(INRRSE3_R99R_A+INRRSE3_R9901_A+0)
         + (arr((INRRSE3_TL_A*TL_RSE3_A*TL_RSE3 +(INRRSE3_NTL_A+INRRSE3_RETDEF-(INR_RSE3_TARDIF-INRRSE3_R9901))
	               *(RSE3_REF - RSE3_TLDEC)/(RSE3_REF-max(0,RSE3_R9901))))
                       * positif(RSE3_REF - RSE3_TLDEC) * positif(RSE3_TLDEC - RSE3_R9901) 
	               * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR+0))
                       * (1-positif(INRRSE3_R99R_A+INRRSE3_R9901_A+0))
         + ((INR_TOT_GLOB_RSE3 - DO_INR_RSE3_A - arr(RSE3_TLDEC * TXINR_PA/100))
                       * positif(RSE3_R9901 - RSE3_TLDEC) 
                       * positif(RSE3_REF - RSE3_TLDEC)
	               * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR+0))
         + ((INRRSE3_R99R_A + INRRSE3_NTL_A- arr(RSE3_R9901 * TXINR_PA/100)) * null(RSE3_TLDEC - RSE3_R9901)
                       * positif(RSE3_REF - RSE3_TLDEC)
		       * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR))
            );

RECUP_INR_RSE3 = (min(DO_INR_RSE3_A,arr(DO_INR_RSE3_A * (RSE3_TLDEC - RSE3BASE_A)/DO_RSE3_A))
                    *positif(RSE3_TLDEC-RSE3BASE_A)*positif(RSE3_REF-RSE3BASE_A)
                    * positif(RSE3BASE_A - RSE3_R9901)
                    *positif(FLAG_RETARD + FLAG_DEFAUT))
		+ min(DO_INR_RSE3_A,arr((RSE3_R9901 - RSE3BASE_A) * TXINR_PA/100))*positif(RSE3_TLDEC - RSE3BASE_A)
                    * positif(RSE3_R9901-RSE3BASE_A)
                    *positif(DO_INR_RSE3_A)
		    *positif(FLAG_RETARD + FLAG_DEFAUT);
DO_RSE32 = (RSE3_REF - RSE3_TLDEC_1) * positif(RSE3_REF - RSE3_TLDEC_1)* positif(RSE3BASE_A);
SUP_RSE3_MAX2 = (RSE3_REF - max(0,RSE3_R9901)) * positif(RSE3_REF - max(0,RSE3_R9901))* positif(RSE3BASE_A);
DO_INR_RSE3982 = max(0,
          arr((RSE3_REF - RSE3_NTLDEC_198) * TXINRRED_A/200) 
            *positif(RSE3_REF - RSE3_NTLDEC_198))*(1-positif(DO_INR_RSE32)) * present(RSE3_NTLDEC_198);
DO_INR_RSE3992 = max(0,
          arr((RSE3_REF - RSE3_TLDEC_199) * TXINRRED_A/200)
            *positif(RSE3_REF - RSE3_TLDEC_199))*(1-positif(DO_INR_RSE32)) * present(RSE3_TLDEC_199);
INR_RSE3_TOT = max(INRRSE3_NTLDECD+INRRSE3_NTLDECD_1 + (INRRSE3_TLDECD+INRRSE3_TLDEC_1)*TL_RSE3-INR_RSE3_TARDIF*null(1-IND_PASSAGE)+INRRSE3_R99R+RECUP_INR_RSE3,0) 
	      * (1-IND_RJLJ);
INRRSE3_RECT= arr((RSE3_RECT)* (TXINR_PA/100)) * positif(RSE3_RECT) * FLAG_RECTIF;
INCRSE3_TL2 = INRRSE3_TLDECD;
INCRSE3_TL_12 = INRRSE3_TLDEC_1;
INRSE3_TL2 = INRRSE3_TLA * TL_RSE3;
INRSE3_TL_12 = INRRSE3_TLA_1 * TL_RSE3;
INRRSE3_NET2 = max(INRRSE3_NTLDECD+INRRSE3_TLDECD*TL_RSE3+INRRSE3_R99R+RECUP_INR_RSE3,0)*(1-IND_RJLJ)+DO_INR_RSE32 * (-1);
INRRSE3_NET_12 = max(INRRSE3_NTLDECD_1+INRRSE3_TLDEC_1*TL_RSE3,0)*(1-IND_RJLJ)+ (DO_INR_RSE3982 + DO_INR_RSE3992)*(-1);
INCRSE3_NET2 = max(0,(INRRSE3_NET2 + INRRSE3_NET_12 + INCRSE3_NET_A+(INRRSE3_TL_A+INRRSE3_TL_1_A)*(1-null(TL_RSE3_A-TL_RSE3))*positif(TL_RSE3))) * positif(RSE3BASE)* (1-IND_RJLJ);
RSE3_PRI2=RSE3_R9901;
RSE3_ANT2=RSE3BASE_A;
RSE3_NTL2=RSE3_NTLDEC;
RSE3_NTL_12=RSE3_NTLDEC_1;
RSE3_TL2=RSE3_TLDEC;
RSE3_TL_12=RSE3_TLDEC_1;
RSE3_REF_INR=RSE3_REF;
INRRSE4_R99RA = INRRSE4_R99R_A;
INRRSE4_R99R = arr((RSE4_R99R) * (TXINR_PA/100)-INCRSE4_NET_A) * positif(RSE4_R99R-RSE4_R99R_A)*positif(IND_PASSAGE-1);
INRRSE4_R9901A = INRRSE4_R9901_A;
INRRSE4_R9901 = arr(RSE4_R9901 * (TXINR_PA/100)-INCRSE4_NET_A) * positif(RSE4_R9901- RSE4_R9901_A)
              * positif(IND_PASSAGE-1) * positif(RSE4_TLDEC-RSE4_R9901) * positif(RSE4_R9901_A)
             + (arr(RSE4_R9901 * (TXINR_PA/100))-INCRSE4_NET_A) * positif(RSE4_R9901- RSE4BASE_A)
              * positif(IND_PASSAGE-1) * positif(RSE4_TLDEC-RSE4_R9901) * (1-positif(RSE4_R9901_A))
             + (INCRSE4_NET_A - arr(RSE4_R9901 * (TXINR_PA/100))) * positif(RSE4BASE_A- RSE4_R9901)
              * positif(IND_PASSAGE-1) * positif(RSE4_TLDEC-RSE4_R9901) * (1-positif(RSE4_R9901_A)) * positif(RSE4_R9901)
	     ;
DO_INR_RSE4C=DO_INR_RSE4_A;
INR_NTL_GLOB_RSE42 = INRRSE4_NTLDECD + INRRSE4_NTL_A+ INRRSE4_NTLDECD_1 + INRRSE4_NTL_1_A;
INR_TL_GLOB_RSE42 = INRRSE4_TLDECD + INRRSE4_TL_A+ INRRSE4_TLDEC_1 + INRRSE4_TL_1_A;
INR_TOT_GLOB_RSE42 = max(0,INR_NTL_GLOB_RSE42 + INR_TL_GLOB_RSE42*TL_RSE4+INRRSE4_R99R+INRRSE4_R99R_A) * (1-IND_RJLJ);
INR_TOT_GLOB_RSE4C= (INRRSE4_NTLDECD+ INRRSE4_NTL_A+ (INRRSE4_TLDECD + INRRSE4_TL_A)*TL_RSE4 +INRRSE4_R99R+INRRSE4_R99R_A) * (1-IND_RJLJ) ;
DO_INR_RSE42 = max(0,
           (arr(((INRRSE4_TL_A+INRRSE4_TL_1_A)*TL_RSE4_A*TL_RSE4 + INRRSE4_NTL_A+INRRSE4_NTL_1_A)
           * min(1,((RSE4_REF - RSE4_TLDEC_1)/(RSE4_REF-max(0,RSE4_R9901))))) 
             * (1-positif(FLAG_RETARD + FLAG_DEFAUT))
             * positif(RSE4_REF - RSE4_TLDEC_1)* positif(RSE4_REF - (max(0,RSE4_R9901))))
              * (1-positif(FLAG_C02+FLAG_C22))
	     *(1-positif_ou_nul(RSE4_TLDEC_1 - RSE4BASE_A))
           +arr(((INRRSE4_TL_A+INRRSE4_TL_1_A)*TL_RSE4_A*TL_RSE4)
             * min(1,((RSE4_REF - RSE4_TLDEC_1)/(RSE4_REF-max(0,RSE4_R9901)))))
             * (1-positif(FLAG_RETARD + FLAG_DEFAUT))
             * positif(RSE4_REF - RSE4_TLDEC_1)* positif(RSE4_REF - (max(0,RSE4_R9901)))
             * positif(FLAG_C02+FLAG_C22)
             *(1-positif_ou_nul(RSE4_TLDEC_1 - RSE4BASE_A))
             * (1-positif(INRRSE4_NTL_A+INRRSE4_NTL_1_A))
          + (INRRSE4_NTL_A*FLAG_C02+INRRSE4_NTL_1_A*FLAG_C22) 
             *positif(RSE4_REF - RSE4_TLDEC_1)* positif(RSE4_REF - (max(0,RSE4_R9901))) * positif(FLAG_C02+FLAG_C22)
             * positif(INRRSE4_NTL_A)*positif(INRRSE4_NTL_1_A)
          + arr((INRRSE4_NTL_A*FLAG_C02+INRRSE4_NTL_1_A*FLAG_C22) 
             *positif(RSE4_REF - RSE4_TLDEC_1)* positif(RSE4_REF - (max(0,RSE4_R9901))) * positif(FLAG_C02+FLAG_C22)
             * min(1,((RSE4_REF - RSE4_TLDEC_1)/(RSE4_REF-max(0,RSE4_R9901)))))
             * (1-positif(INRRSE4_NTL_A)*positif(INRRSE4_NTL_1_A))
          + ((INRRSE4_TL_A+INRRSE4_TL_1_A)*null(TL_RSE4) * TL_RSE4_A
          * (1- FLAG_DEFAUT)
             *positif(RSE4_REF - RSE4_TLDEC_1)* positif(RSE4_REF - (max(0,RSE4_R9901))))
         + ((INRRSE4_TL_A + INRRSE4_R99R_A+INRRSE4_NTL_A - max(0,arr(RSE4_TLDEC * TXINR_PA/100))) * positif(RSE4_R9901 - RSE4_TLDEC)
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * positif(ACODELAISINR)
         + ((INRRSE4_R99R_A+INRRSE4_NTL_A - max(0,arr(RSE4_R9901 * TXINR_PA/100))) * positif(RSE4_TLDEC-(RSE4_R9901))
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
		       * positif(ACODELAISINR)
         + ((INRRSE4_TL_A + INRRSE4_R99R_A+INRRSE4_NTL_A - max(0,arr(RSE4_R9901 * TXINR_PA/100))) * null(RSE4_TLDEC-(RSE4_R9901))
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
		       * positif(ACODELAISINR)
         + (arr((INRRSE4_TL_A*TL_RSE4_A *TL_RSE4+(INRRSE4_NTL_A +INRRSE4_R99R+INRRSE4_R9901-INRRSE4_RETDEF-INR_RSE4_TARDIF) 
                       * ((RSE4_REF - RSE4_TLDEC)/(RSE4_REF-max(0,RSE4_REF_A)))))
                       * positif(RSE4_REF - RSE4_TLDEC)  * positif(RSE4_TLDEC - RSE4_R9901) 
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR+0))
                       * positif(INRRSE4_R99R_A+INRRSE4_R9901_A+0)
         + (arr((INRRSE4_TL_A*TL_RSE4_A*TL_RSE4 +(INRRSE4_NTL_A+INRRSE4_RETDEF-(INR_RSE4_TARDIF-INRRSE4_R9901))
	               *(RSE4_REF - RSE4_TLDEC)/(RSE4_REF-max(0,RSE4_R9901))))
                       * positif(RSE4_REF - RSE4_TLDEC) * positif(RSE4_TLDEC - RSE4_R9901) 
	               * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR+0))
                       * (1-positif(INRRSE4_R99R_A+INRRSE4_R9901_A+0))
         + ((INR_TOT_GLOB_RSE4 - DO_INR_RSE4_A - arr(RSE4_TLDEC * TXINR_PA/100))
                       * positif(RSE4_R9901 - RSE4_TLDEC) 
                       * positif(RSE4_REF - RSE4_TLDEC)
	               * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR+0))
         + ((INRRSE4_R99R_A + INRRSE4_NTL_A- arr(RSE4_R9901 * TXINR_PA/100)) * null(RSE4_TLDEC - RSE4_R9901)
                       * positif(RSE4_REF - RSE4_TLDEC)
		       * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR))
            );

RECUP_INR_RSE4 = (min(DO_INR_RSE4_A,arr(DO_INR_RSE4_A * (RSE4_TLDEC - RSE4BASE_A)/DO_RSE4_A))
                    *positif(RSE4_TLDEC-RSE4BASE_A)*positif(RSE4_REF-RSE4BASE_A)
                    * positif(RSE4BASE_A - RSE4_R9901)
                    *positif(FLAG_RETARD + FLAG_DEFAUT))
		+ min(DO_INR_RSE4_A,arr((RSE4_R9901 - RSE4BASE_A) * TXINR_PA/100))*positif(RSE4_TLDEC - RSE4BASE_A)
                    * positif(RSE4_R9901-RSE4BASE_A)
                    *positif(DO_INR_RSE4_A)
		    *positif(FLAG_RETARD + FLAG_DEFAUT);
DO_RSE42 = (RSE4_REF - RSE4_TLDEC_1) * positif(RSE4_REF - RSE4_TLDEC_1)* positif(RSE4BASE_A);
SUP_RSE4_MAX2 = (RSE4_REF - max(0,RSE4_R9901)) * positif(RSE4_REF - max(0,RSE4_R9901))* positif(RSE4BASE_A);
DO_INR_RSE4982 = max(0,
          arr((RSE4_REF - RSE4_NTLDEC_198) * TXINRRED_A/200) 
            *positif(RSE4_REF - RSE4_NTLDEC_198))*(1-positif(DO_INR_RSE42)) * present(RSE4_NTLDEC_198);
DO_INR_RSE4992 = max(0,
          arr((RSE4_REF - RSE4_TLDEC_199) * TXINRRED_A/200)
            *positif(RSE4_REF - RSE4_TLDEC_199))*(1-positif(DO_INR_RSE42)) * present(RSE4_TLDEC_199);
INR_RSE4_TOT = max(INRRSE4_NTLDECD+INRRSE4_NTLDECD_1 + (INRRSE4_TLDECD+INRRSE4_TLDEC_1)*TL_RSE4-INR_RSE4_TARDIF*null(1-IND_PASSAGE)+INRRSE4_R99R+RECUP_INR_RSE4,0) 
	      * (1-IND_RJLJ);
INRRSE4_RECT= arr((RSE4_RECT )* (TXINR_PA/100)) * positif(RSE4_RECT) * FLAG_RECTIF;
INCRSE4_TL2 = INRRSE4_TLDECD;
INCRSE4_TL_12 = INRRSE4_TLDEC_1;
INRSE4_TL2 = INRRSE4_TLA * TL_RSE4;
INRSE4_TL_12 = INRRSE4_TLA_1 * TL_RSE4;
INRRSE4_NET2 = max(INRRSE4_NTLDECD+INRRSE4_TLDECD*TL_RSE4+INRRSE4_R99R+RECUP_INR_RSE4,0)*(1-IND_RJLJ)+DO_INR_RSE42 * (-1);
INRRSE4_NET_12 = max(INRRSE4_NTLDECD_1+INRRSE4_TLDEC_1*TL_RSE4,0)*(1-IND_RJLJ)+ (DO_INR_RSE4982 + DO_INR_RSE4992)*(-1);
INCRSE4_NET2 = max(0,(INRRSE4_NET2 + INRRSE4_NET_12 + INCRSE4_NET_A+(INRRSE4_TL_A+INRRSE4_TL_1_A)*(1-null(TL_RSE4_A-TL_RSE4))*positif(TL_RSE4))) * positif(RSE4BASE)* (1-IND_RJLJ);
RSE4_PRI2=RSE4_R9901;
RSE4_ANT2=RSE4BASE_A;
RSE4_NTL2=RSE4_NTLDEC;
RSE4_NTL_12=RSE4_NTLDEC_1;
RSE4_TL2=RSE4_TLDEC;
RSE4_TL_12=RSE4_TLDEC_1;
RSE4_REF_INR=RSE4_REF;
regle isf 1108001:
application : oceans, iliad ;
DATISFAA = arr( (V_DATISF/10000 - inf(V_DATISF/10000))*10000 );
DATISFMM = inf( (V_DATISF/1000000 - inf(V_DATISF/1000000))*100 );
DATISFDIFA =max(0, ((DATISFAA-1) - (V_ANREV + 1))) * 12;
DATISFDIFM = (DATISFMM - 7) * null(DATISFAA - (V_ANREV + 1))
	   + (6 + DATISFMM-1) * positif(DATISFAA - (V_ANREV + 1));
DATISFTOT = DATISFDIFA + DATISFDIFM;
TXINRISF = max(0,(NBMOIS * TXMOISRETARD2) + max(0,(max(0,(NBMOIS2-DATISFTOT)) * positif(V_DATISF) * TXMOISRETARD2)));

TXINRREDISF = max(0,(NBMOIS * TXMOISRETARD2*TXMOISRED*2) + max(0,(max(0,(NBMOIS2-DATISFTOT)) * positif(V_DATISF) * TXMOISRETARD2 * TXMOISRED * 2)));
regle isf 11081:
application : oceans, iliad ;
ISF_PA = ISF4BASE * null(1 - IND_PASSAGE) + ISF_PA_A;
TXINRISF_PA = TXINRISF * null(1 - IND_PASSAGE) + TXINRISF_PA_A;
INRISF_RETDEF = (1 - IND_RJLJ) * (
               arr(ISF4BASE * TXINRISF / 100) * FLAG_DEFAUT * null(IND_PASSAGE - 1)
                                )
             + INRISF_RETDEF_A;
INR_ISF_TARDIF = (arr(ISF4BASE * TXINRISF/100) * FLAG_RETARD * null(1-IND_PASSAGE)+INR_ISF_TARDIF_A) * (1-IND_RJLJ);
regle isf 110811:
application : oceans, iliad ;
ISF_TLDEC_1=ISF4;
regle isf 1108112:
application : oceans, iliad ;
INRISF_NTL = (1 - IND_RJLJ) * (1-FLAG_NINR) * (
		     null(2 - FLAG_INR) * positif(ISF4BASE - ISF_R99R) 
		     * (
             (positif(ISF4BASE - max(ISF_NTLDEC_198,ISF_REF* (1-present(ISF_NTLDEC_198))+0))
            * arr((ISF4BASE - max(ISF_NTLDEC_198,ISF_REF* (1-present(ISF_NTLDEC_198)))) * (TXINRISF / 100))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(ISF4BASE - max(ISF_NTLDEC_198,ISF_REF* (1-present(ISF_NTLDEC_198))+0))
            * arr((ISF4BASE - max(ISF_NTLDEC_198,ISF_REF* (1-present(ISF_NTLDEC_198)))) * (TXINRISF / 100))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
		     + null(3 - FLAG_INR) * positif(ISF4BASE - ISF_REF) 
		     * (
             (positif(ISF4BASE - max(ISF_NTLDEC_198,ISF_REF* (1-present(ISF_NTLDEC_198))+0))
            * arr((min(ISF4BASE,ISF_TLDEC_1) - max(ISF_NTLDEC_198,ISF_REF* (1-present(ISF_NTLDEC_198)))) * (TXINRISF / 100))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(ISF4BASE - max(ISF_NTLDEC_198,ISF_REF* (1-present(ISF_NTLDEC_198))+0))
            * arr((min(ISF4BASE,ISF_TLDEC_1) - max(ISF_NTLDEC_198,ISF_REF* (1-present(ISF_NTLDEC_198)))) * (TXINRISF / 100))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
            + INRISF_RETDEF * null(IND_PASSAGE - 1)
                            )
	     ; 
regle isf 1108111:
application : oceans, iliad ;
INRISF_NTL_1 = (1 - IND_RJLJ) * (1-FLAG_NINR) * (
		     null(2 - FLAG_INR) * positif(ISF4BASE - ISF_R99R) 
		     * (
             (positif(ISF4BASE - max(ISF_NTLDEC,ISF_REF+0))
            * arr((ISF4BASE - max(ISF_NTLDEC,ISF_REF)) * (TXINRREDISF / 200))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(ISF4BASE - max(ISF_NTLDEC,ISF_REF+0))
            * arr((ISF4BASE - max(ISF_NTLDEC,ISF_REF)) * (TXINRREDISF / 200))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
		     + null(3 - FLAG_INR) * positif(ISF4BASE - ISF_REF) 
		     * (
             (positif(ISF4BASE - max(ISF_NTLDEC,ISF_REF+0))
            * arr((min(ISF4BASE,ISF_TLDEC_1) - max(ISF_NTLDEC,ISF_REF)) * (TXINRREDISF / 200))
            * null(FLAG_DEFAUT + FLAG_RETARD))
            +
            (positif(ISF4BASE - max(ISF_NTLDEC,ISF_REF+0))
            * arr((min(ISF4BASE,ISF_TLDEC_1) - max(ISF_NTLDEC,ISF_REF)) * (TXINRREDISF / 200))
            * positif(FLAG_DEFAUT + FLAG_RETARD) * positif(IND_PASSAGE - 1))
                                                             )
                            )
	     ; 
regle isf 11082:
application : oceans, iliad ;
INRISF_TLACQ = positif(ISF4BASE - max(ISF_REF*(1-present(ISF_TLDEC_199)),
						 max(ISF_NTLDEC_1*(1-present(ISF_TLDEC_199)), ISF_TLDEC_199+0)))*null(3- FLAG_INR)
            * arr((ISF4BASE - max(ISF_REF*(1-present(ISF_TLDEC_199)),
							     max(ISF_NTLDEC_1*(1-present(ISF_TLDEC_199)), ISF_TLDEC_199))) * (TXINRISF / 100))  ;
INRISF_TLA = (1 - IND_RJLJ) * (1-FLAG_NINR) * INRISF_TLACQ;
regle isf 1108212:
application : oceans, iliad ;
INRISF_TLACQ_1 = positif(ISF4BASE - max(ISF_REF*null(ISF4BASE-ISF4BASE_A),ISF_TLDEC+0))*null(3- FLAG_INR)
            * arr((ISF4BASE - max(ISF_REF*null(ISF4BASE-ISF4BASE_A),ISF_TLDEC)) * (TXINRREDISF / 200))
	    +
               positif(ISF4BASE - ISF_TLDEC) * null(3-FLAG_INR)
            * arr((ISF4BASE - ISF_TLDEC) * (TXINRREDISF / 200)) * positif(FLAG_C22+FLAG_C02);
INRISF_TLA_1 = (1 - IND_RJLJ) * (1-FLAG_NINR) * INRISF_TLACQ_1;
regle isf 11083:
application : oceans, iliad ;
INRISF_TLADEC_1 = INRISF_TLACQ_1;
INRISF_TL_1_AD = INRISF_TL_1_A;
INRISF_TLDEC_1 = INRISF_TLA_1 + INRISF_RETDEF * null(INRISF_RETDEF_A);
INRISF_NTLDECD = INRISF_NTLDEC * positif_ou_nul(ISF_TLDEC_1 - ISF_NTLDEC) + INRISF_NTL *positif(ISF_NTLDEC-ISF_TLDEC_1);
INRISF_NTLDECD_1 = INRISF_NTLDEC_1 * positif_ou_nul(ISF_TLDEC_1 - ISF_NTLDEC_1) + INRISF_NTL_1 *positif(ISF_NTLDEC_1-ISF_TLDEC_1);
INRISF_TLDECD = INRISF_TLDEC * positif_ou_nul(ISF_TLDEC_1 - ISF_TLDEC) + INRISF_TLA *positif(ISF_TLDEC-ISF_TLDEC_1);
INRISF_R99RA = INRISF_R99R_A;
INRISF_R99R = arr(ISF_R99R * (TXINRISF_PA/100)-INCISF_NET_A) * positif(ISF_R99R-ISF_R99R_A)*positif(IND_PASSAGE-1);
INRISF_R9901A = INRISF_R9901_A;
INRISF_R9901 = arr(ISF_R9901 * (TXINRISF_PA/100)-INCISF_NET_A) * positif(ISF_R9901- ISF_R9901_A)
              * positif(IND_PASSAGE-1) * positif(ISF_TLDEC-ISF_R9901) * positif(ISF_R9901_A)
             + (arr(ISF_R9901 * (TXINRISF_PA/100))-INCISF_NET_A) * positif(ISF_R9901- ISF4BASE_A)
              * positif(IND_PASSAGE-1) * positif(ISF_TLDEC-ISF_R9901) * (1-positif(ISF_R9901_A))
             + (INCISF_NET_A - arr(ISF_R9901 * (TXINRISF_PA/100))) * positif(ISF4BASE_A- ISF_R9901)
              * positif(IND_PASSAGE-1) * positif(ISF_TLDEC-ISF_R9901) * (1-positif(ISF_R9901_A)) * positif(ISF_R9901)
	     ;
DO_INR_ISFC=DO_INR_ISF_A;
INR_NTL_GLOB_ISF2 = INRISF_NTLDECD + INRISF_NTL_A+ INRISF_NTLDECD_1 + INRISF_NTL_1_A;
INR_TL_GLOB_ISF2 = INRISF_TLDECD + INRISF_TL_A+ INRISF_TLDEC_1 + INRISF_TL_1_A;
INR_TOT_GLOB_ISF2 = max(0,INR_NTL_GLOB_ISF2 + INR_TL_GLOB_ISF2*TL_ISF+INRISF_R99R+INRISF_R99R_A) * (1-IND_RJLJ);
INR_TOT_GLOB_ISFC= (INRISF_NTLDECD+ INRISF_NTL_A+ (INRISF_TLDECD + INRISF_TL_A)*TL_ISF +INRISF_R99R+INRISF_R99R_A) * (1-IND_RJLJ) ;
DO_INR_ISF2 = max(0,
           (arr(((INRISF_TL_A+INRISF_TL_1_A)*TL_ISF_A*TL_ISF + INRISF_NTL_A+INRISF_NTL_1_A)
           * min(1,((ISF_REF - ISF_TLDEC_1)/(ISF_REF-max(0,ISF_R9901))))) 
             * (1-positif(FLAG_RETARD + FLAG_DEFAUT))
             * positif(ISF_REF - ISF_TLDEC_1)* positif(ISF_REF - (max(0,ISF_R9901))))
              * (1-positif(FLAG_C02+FLAG_C22))
	     *(1-positif_ou_nul(ISF_TLDEC_1 - ISF4BASE_A))
           +arr(((INRISF_TL_A+INRISF_TL_1_A)*TL_ISF_A*TL_ISF)
             * min(1,((ISF_REF - ISF_TLDEC_1)/(ISF_REF-max(0,ISF_R9901)))))
             * (1-positif(FLAG_RETARD + FLAG_DEFAUT))
             * positif(ISF_REF - ISF_TLDEC_1)* positif(ISF_REF - (max(0,ISF_R9901)))
             * positif(FLAG_C02+FLAG_C22)
             *(1-positif_ou_nul(ISF_TLDEC_1 - ISF4BASE_A))
             * (1-positif(INRISF_NTL_A+INRISF_NTL_1_A))
          + (INRISF_NTL_A*FLAG_C02+INRISF_NTL_1_A*FLAG_C22) 
             *positif(ISF_REF - ISF_TLDEC_1)* positif(ISF_REF - (max(0,ISF_R9901))) * positif(FLAG_C02+FLAG_C22)
             * positif(INRISF_NTL_A)*positif(INRISF_NTL_1_A)
          + arr((INRISF_NTL_A*FLAG_C02+INRISF_NTL_1_A*FLAG_C22) 
             *positif(ISF_REF - ISF_TLDEC_1)* positif(ISF_REF - (max(0,ISF_R9901))) * positif(FLAG_C02+FLAG_C22)
             * min(1,((ISF_REF - ISF_TLDEC_1)/(ISF_REF-max(0,ISF_R9901)))))
             * (1-positif(INRISF_NTL_A)*positif(INRISF_NTL_1_A))
          + ((INRISF_TL_A+INRISF_TL_1_A)*null(TL_ISF) * TL_ISF_A
          * (1- FLAG_DEFAUT)
             *positif(ISF_REF - ISF_TLDEC_1)* positif(ISF_REF - (max(0,ISF_R9901))))
         + ((INRISF_TL_A + INRISF_R99R_A+INRISF_NTL_A - max(0,arr(ISF_TLDEC * TXINRISF_PA/100))) * positif(ISF_R9901 - ISF_TLDEC)
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * positif(ACODELAISINR)
         + ((INRISF_R99R_A+INRISF_NTL_A - max(0,arr(ISF_R9901 * TXINRISF_PA/100))) * positif(ISF_TLDEC-(ISF_R9901))
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
		       * positif(ACODELAISINR)
         + ((INRISF_TL_A + INRISF_R99R_A+INRISF_NTL_A - max(0,arr(ISF_R9901 * TXINRISF_PA/100))) * null(ISF_TLDEC-(ISF_R9901))
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
		       * positif(ACODELAISINR)
         + (arr((INRISF_TL_A*TL_ISF_A *TL_ISF+(INRISF_NTL_A +INRISF_R99R+INRISF_R9901-INRISF_RETDEF-INR_ISF_TARDIF) 
                       * ((ISF_REF - ISF_TLDEC)/(ISF_REF-max(0,ISF_REF_A)))))
                       * positif(ISF_REF - ISF_TLDEC)  * positif(ISF_TLDEC - ISF_R9901) 
                       * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR+0))
                       * positif(INRISF_R99R_A+INRISF_R9901_A+0)
         + (arr((INRISF_TL_A*TL_ISF_A*TL_ISF +(INRISF_NTL_A+INRISF_RETDEF-(INR_ISF_TARDIF-INRISF_R9901))
	               *(ISF_REF - ISF_TLDEC)/(ISF_REF-max(0,ISF_R9901))))
                       * positif(ISF_REF - ISF_TLDEC) * positif(ISF_TLDEC - ISF_R9901) 
	               * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR+0))
                       * (1-positif(INRISF_R99R_A+INRISF_R9901_A+0))
         + ((INR_TOT_GLOB_ISF - DO_INR_ISF_A - arr(ISF_TLDEC * TXINRISF_PA/100))
                       * positif(ISF_R9901 - ISF_TLDEC) 
                       * positif(ISF_REF - ISF_TLDEC)
	               * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR+0))
         + ((INRISF_R99R_A + INRISF_NTL_A- arr(ISF_R9901 * TXINRISF_PA/100)) * null(ISF_TLDEC - ISF_R9901)
                       * positif(ISF_REF - ISF_TLDEC)
		       * positif(FLAG_RETARD + FLAG_DEFAUT))
                       * (1-positif(ACODELAISINR))
            );

RECUP_INR_ISF = (min(DO_INR_ISF_A,arr(DO_INR_ISF_A * (ISF_TLDEC - ISF4BASE_A)/DO_ISF_A))
                    *positif(ISF_TLDEC-ISF_A)*positif(ISF_REF-ISF4BASE_A)
                    * positif(ISF4BASE_A -ISF_R9901)
                    *positif(FLAG_RETARD + FLAG_DEFAUT))
		+ min(DO_INR_ISF_A,arr((ISF_R9901 - ISF4BASE_A) * TXINRISF_PA/100))*positif(ISF_TLDEC - ISF4BASE_A)
                    * positif(ISF_R9901-ISF4BASE_A)
                    *positif(DO_INR_ISF_A)
		    *positif(FLAG_RETARD + FLAG_DEFAUT);
DO_ISF2 = (ISF_REF - ISF_TLDEC_1) * positif(ISF_REF - ISF_TLDEC_1)* positif(ISF4BASE_A);
SUP_ISF_MAX2 = (ISF_REF - max(0,ISF_R9901)) * positif(ISF_REF - max(0,ISF_R9901))* positif(ISF4BASE_A);
DO_INR_ISF982 = max(0,
          arr((ISF_REF - ISF_NTLDEC_198) * TXINRREDISF_A/200) 
            *positif(ISF_REF - ISF_NTLDEC_198))*(1-positif(DO_INR_ISF2)) * present(ISF_NTLDEC_198);
DO_INR_ISF992 = max(0,
          arr((ISF_REF - ISF_TLDEC_199) * TXINRREDISF_A/200)
            *positif(ISF_REF - ISF_TLDEC_199))*(1-positif(DO_INR_ISF2)) * present(ISF_TLDEC_199);
INR_ISF_TOT = max(INRISF_NTLDECD+INRISF_NTLDEC_1 + (INRISF_TLDEC+INRISF_TLDEC_1)*TL_ISF-INR_ISF_TARDIF*null(1-IND_PASSAGE)+INRISF_R99R+RECUP_INR_ISF,0) 
	      * (1-IND_RJLJ);
INRISF_RECT= arr(ISF_RECT * (TXINRISF_PA/100)) * positif(ISF_RECT) * FLAG_RECTIF;
INCISF_TL2 = INRISF_TLDECD;
INCISF_TL_12 = INRISF_TLDEC_1;
INISF_TL2 = INRISF_TLA * TL_ISF;
INISF_TL_12 = INRISF_TLA_1 * TL_ISF;
INRISF_NET2 = max(INRISF_NTLDECD+INRISF_TLDECD*TL_ISF+INRISF_R99R+RECUP_INR_ISF,0)* positif(ISF4BASE - ISF_P)*(1-IND_RJLJ)+DO_INR_ISF2 * (-1);
INRISF_NET_12 = max(INRISF_NTLDECD_1+INRISF_TLDEC_1*TL_ISF,0) *(1-IND_RJLJ)+ (DO_INR_ISF982 + DO_INR_ISF992)*(-1);
INCISF_NET2 = max(0,(INRISF_NET2 + INRISF_NET_12 + INCISF_NET_A+(INRISF_TL_A+INRISF_TL_1_A)*(1-null(TL_ISF_A-TL_ISF))*positif(TL_ISF))) * positif(ISF4BASE)* (1-IND_RJLJ);
ISF_PRI2=ISF_R9901;
ISF_ANT2=ISF4BASE_A;
ISF_NTL2=ISF_NTLDEC;
ISF_NTL_12=ISF_NTLDEC_1;
ISF_TL2=ISF_TLDEC;
ISF_TL_12=ISF_TLDEC_1;
ISF_REF_INR=ISF_REF;
regle corrective 11090:
application : oceans, iliad ;
TINR2 = positif(DO_INR_IR2+DO_INR_CSG2+DO_INR_CRDS2+DO_INR_PS2+DO_INR_TAXA2+DO_INR_CSAL2+DO_INR_CDIS2+DO_INR_ISF2
			   +DO_INR_CHR2+DO_INR_PCAP2+DO_INR_GAIN2+DO_INR_RSE12+DO_INR_RSE22+DO_INR_RSE32+DO_INR_RSE42)
      * null(DO_INR_IR_A+DO_INR_CSG_A+DO_INR_CRDS_A+DO_INR_PS_A+DO_INR_TAXA_A+DO_INR_CSAL_A+DO_INR_CDIS_A+DO_INR_ISF_A
			   +DO_INR_CHR_A+DO_INR_PCAP_A+DO_INR_GAIN_A+DO_INR_RSE1_A+DO_INR_RSE2_A+DO_INR_RSE3_A+DO_INR_RSE4_A)*TINR_A
     + positif(DO_INR_IR2+DO_INR_CSG2+DO_INR_CRDS2+DO_INR_PS2+DO_INR_TAXA2+DO_INR_CSAL2+DO_INR_CDIS2+DO_INR_ISF2
				+DO_INR_CHR2+DO_INR_PCAP2+DO_INR_GAIN2+DO_INR_RSE12+DO_INR_RSE22+DO_INR_RSE32+DO_INR_RSE42)
      *positif(DO_INR_IR_A+DO_INR_CSG_A+DO_INR_CRDS_A+DO_INR_PS_A+DO_INR_TAXA_A+DO_INR_CSAL_A+DO_INR_CDIS_A+DO_INR_ISF_A
			   +DO_INR_CHR_A+DO_INR_PCAP_A+DO_INR_GAIN_A+DO_INR_RSE1_A+DO_INR_RSE2_A+DO_INR_RSE3_A+DO_INR_RSE4_A)*TINR_A
     + positif(INRIR_R99R+INRCSG_R99R+INRCRDS_R99R+INRPRS_R99R+INRTAXA_R99R+INRCSAL_R99R+INRCSAL_R99R+INRISF_R99R
		  +INRCHR_R99R+INRPCAP_R99R+INRGAIN_R99R+INRRSE1_R99R+INRRSE2_R99R+INRRSE3_R99R+INRRSE4_R99R
               +(RECUP_INR_IR+RECUP_INR_CSG+RECUP_INR_CRDS+RECUP_INR_PRS+RECUP_INR_TAXA+RECUP_INR_CSAL+RECUP_INR_CDIS+RECUP_INR_ISF
	       +RECUP_INR_CHR+RECUP_INR_PCAP+RECUP_INR_GAIN+RECUP_INR_RSE1+RECUP_INR_RSE2+RECUP_INR_RSE2+RECUP_INR_RSE2+RECUP_INR_RSE4)*FLAG_RECTIF)
               *TXINR_PA
     + null(DO_INR_IR2+DO_INR_CSG2+DO_INR_CRDS2+DO_INR_PS2+DO_INR_TAXA2+DO_INR_CSAL2+DO_INR_CDIS2+DO_INR_ISF2
				+DO_INR_CHR2+DO_INR_PCAP2+DO_INR_GAIN2+DO_INR_RSE12+DO_INR_RSE22+DO_INR_RSE32+DO_INR_RSE42)
      *null(INRIR_R99R+INRCSG_R99R+INRCRDS_R99R+INRPRS_R99R+INRTAXA_R99R+INRCSAL_R99R+INRCDIS_R99R+INRISF_R99R
		  +INRCHR_R99R+INRPCAP_R99R+INRGAIN_R99R+INRRSE1_R99R+INRRSE2_R99R+INRRSE3_R99R+INRRSE4_R99R
               +(RECUP_INR_IR+RECUP_INR_CSG+RECUP_INR_CRDS+RECUP_INR_PRS+RECUP_INR_TAXA+RECUP_INR_CSAL+RECUP_INR_CDIS+RECUP_INR_ISF
	       +RECUP_INR_CHR+RECUP_INR_PCAP+RECUP_INR_GAIN+RECUP_INR_RSE1+RECUP_INR_RSE2+RECUP_INR_RSE2+RECUP_INR_RSE2+RECUP_INR_RSE4)*FLAG_RECTIF)
               *TXINR;
TINR_12=TXINRRED/2 * positif(INRIR_NET_12+INRCSG_NET_12+INRRDS_NET_12+INRPRS_NET_12+INRTAXA_NET_12+INRCSAL_NET_12+INRCDIS_NET_12+INRISF_NET_12
                          + INRCHR_NET_12+INRPCAP_NET_12+INRGAIN_NET_12+INRRSE1_NET_12+INRRSE2_NET_12+INRRSE3_NET_12+INRRSE4_NET_12
			   + null(TL_IR+TL+TL_CS+TL_TAXAGA+TL_CSAL+TL_CDIS+TL_CHR+TL_CAP+TL_GAIN+TL_RSE1+TL_RSE2+TL_RSE3+TL_RSE4))+
       TINR_1_A * (1- positif(INRIR_NET_12+INRCSG_NET_12+INRRDS_NET_12+INRPRS_NET_12+INRTAXA_NET_12+INRCSAL_NET_12+INRCDIS_NET_12+INRISF_NET_12
                          +INRCHR_NET_12+INRPCAP_NET_12+INRGAIN_NET_12+INRRSE1_NET_12+INRRSE2_NET_12+INRRSE3_NET_12+INRRSE4_NET_12));
NBREMOIS222 = (NBMOIS + max(0,NBMOIS2))
		  * positif(INRIR_NET_12+INRCSG_NET_12+INRRDS_NET_12+INRPRS_NET_12+INRTAXA_NET_12+INRCSAL_NET_12+INRCDIS_NET_12+INRISF_NET_12
                          +INRCHR_NET_12+INRPCAP_NET_12+INRGAIN_NET_12+INRRSE1_NET_12+INRRSE2_NET_12+INRRSE3_NET_12+INRRSE4_NET_12
		  +INRIR_NET2+INRCSG_NET2 +INRRDS_NET2+INRPRS_NET2+INRTAXA_NET2+INRCSAL_NET2+INRCDIS_NET2+INRISF_NET2
                          + INRCHR_NET2+INRPCAP_NET2+INRGAIN_NET2+INRRSE1_NET2+INRRSE2_NET2+INRRSE3_NET2+INRRSE4_NET2
			    +null(TL_IR)*positif(INRIR_TLDECD+INRIR_TLDEC_1)
			    +null(TL_TAXAGA)*positif(INRTAXA_TLDECD+INRTAXA_TLDEC_1)
			    +null(TL_CSAL)*positif(INRCSAL_TLDECD+INRCSAL_TLDEC_1)
			    +null(TL_CSAL)*positif(INRCDIS_TLDECD+INRCDIS_TLDEC_1)
			    +null(TL_CS)*positif(INRCSG_TLDECD+INRCSG_TLDEC_1+INRCRDS_TLDECD+INRCRDS_TLDEC_1+INRPRS_TLDECD+INRPRS_TLDEC_1))
		  + NBREMOIS222_A * (1- positif_ou_nul(INRIR_NET_12+INRCSG_NET_12+INRRDS_NET_12+INRPRS_NET_12+INRTAXA_NET_12+INRCSAL_NET_12+INRISF_NET_12
                          +INRCHR_NET_12+INRPCAP_NET_12+INRGAIN_NET_12+INRRSE1_NET_12+INRRSE2_NET_12+INRRSE3_NET_12+INRRSE4_NET_12+INRCDIS_NET_12
                          +INRCHR_NET2+INRPCAP_NET2+INRGAIN_NET2+INRRSE1_NET2+INRRSE2_NET2+INRRSE3_NET2+INRRSE4_NET2
		          +INRIR_NET2+INRCSG_NET2+INRRDS_NET2+INRPRS_NET2+INRTAXA_NET2+INRCSAL_NET2+INRCDIS_NET2+INRISF_NET2));
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
regle isf 11091:
application : oceans, iliad ;
TINRISF2 = positif(DO_INR_IR2+DO_INR_CSG2+DO_INR_CRDS2+DO_INR_PS2+DO_INR_TAXA2+DO_INR_CSAL2+DO_INR_CDIS2+DO_INR_ISF2)
      * null(DO_INR_IR_A+DO_INR_CSG_A+DO_INR_CRDS_A+DO_INR_PS_A+DO_INR_TAXA_A+DO_INR_CSAL_A+DO_INR_CDIS_A+DO_INR_ISF_A)*TXINRISF_A
     + positif(DO_INR_IR2+DO_INR_CSG2+DO_INR_CRDS2+DO_INR_PS2+DO_INR_TAXA2+DO_INR_CSAL2+DO_INR_CDIS2+DO_INR_ISF2)
      *positif(DO_INR_IR_A+DO_INR_CSG_A+DO_INR_CRDS_A+DO_INR_PS_A+DO_INR_TAXA_A+DO_INR_CSAL_A+DO_INR_CDIS_A+DO_INR_ISF2)*TINRISF_A
     + positif(INRIR_R99R+INRCSG_R99R+INRCRDS_R99R+INRPRS_R99R+INRTAXA_R99R+INRCSAL_R99R+INRCSAL_R99R+INRISF_R99R
               +(RECUP_INR_IR+RECUP_INR_CSG+RECUP_INR_CRDS+RECUP_INR_PRS+RECUP_INR_TAXA+RECUP_INR_CSAL+RECUP_INR_CDIS+RECUP_INR_ISF)*FLAG_RECTIF)
               *TXINRISF_PA
     + null(DO_INR_IR2+DO_INR_CSG2+DO_INR_CRDS2+DO_INR_PS2+DO_INR_TAXA2+DO_INR_CSAL2+DO_INR_CDIS2+DO_INR_ISF2)
      *null(INRIR_R99R+INRCSG_R99R+INRCRDS_R99R+INRPRS_R99R+INRTAXA_R99R+INRCSAL_R99R+INRCDIS_R99R+INRISF_R99R
               +(RECUP_INR_IR+RECUP_INR_CSG+RECUP_INR_CRDS+RECUP_INR_PRS+RECUP_INR_TAXA+RECUP_INR_CSAL+RECUP_INR_CDIS+RECUP_INR_ISF)*FLAG_RECTIF)
               *TXINRISF;
TINRISF_12=TXINRREDISF/2 * positif(INRIR_NET_12+INRCSG_NET2+INRRDS_NET_12+INRPRS_NET_12+INRTAXA_NET_12+INRCSAL_NET_12+INRCDIS_NET_12+INRISF_NET_12
			   + null(TL_IR+TL+TL_CS+TL_TAXAGA+TL_CSAL+TL_CDIS))+
       TINR_1_A * (1- positif(INRIR_NET_12+INRCSG_NET2+INRRDS_NET_12+INRPRS_NET_12+INRTAXA_NET_12+INRCSAL_NET_12+INRCDIS_NET_12+INRISF_NET_12));
NBREMOISISF222 = (NBMOIS + max(0,(max(0,(NBMOIS2-DATISFTOT)) * positif(V_DATISF))))
		  * positif(INRIR_NET_12+INRCSG_NET_12+INRRDS_NET_12+INRPRS_NET_12+INRTAXA_NET_12+INRCSAL_NET_12+INRCDIS_NET_12+INRISF_NET_12
		  +INRIR_NET2+INRCSG_NET2 +INRRDS_NET2+INRPRS_NET2+INRTAXA_NET2+INRCSAL_NET2+INRCDIS_NET2+INRISF_NET2
			    +null(TL_IR)*positif(INRIR_TLDECD+INRIR_TLDEC_1)
			    +null(TL_TAXAGA)*positif(INRTAXA_TLDECD+INRTAXA_TLDEC_1)
			    +null(TL_CSAL)*positif(INRCSAL_TLDECD+INRCSAL_TLDEC_1)
			    +null(TL_CSAL)*positif(INRCDIS_TLDECD+INRCDIS_TLDEC_1)
			    +null(TL_CS)*positif(INRCSG_TLDECD+INRCSG_TLDEC_1+INRCRDS_TLDECD+INRCRDS_TLDEC_1+INRPRS_TLDECD+INRPRS_TLDEC_1))
		  + NBREMOIS222ISF_A * (1- positif_ou_nul(INRIR_NET_12+INRCSG_NET_12+INRRDS_NET_12+INRPRS_NET_12+INRTAXA_NET_12+INRCSAL_NET_12+INRISF_NET_12
		+INRCDIS_NET_12 +INRIR_NET2+INRCSG_NET2+INRRDS_NET2+INRPRS_NET2+INRTAXA_NET2+INRCSAL_NET2+INRCDIS_NET2+INRISF_NET2));
