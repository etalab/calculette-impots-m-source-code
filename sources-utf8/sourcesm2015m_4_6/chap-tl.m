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
regle 21700:
application : iliad ;


RAP_RNI    = RNI_TL - RNI_INIT ;
RAP_EFF    = EFF_TL - EFF_INIT ;
RAP_PVQ    = PVQ_TL - PVQ_INIT ;
RAP_PV     = PV_TL - PV_INIT ;
RAP_RI     = - RI_TL + RI_INIT ;
RAP_CI     = CI_TL ;
RAP_CRDS   = RDS_TL - CRDS_INIT ;
RAP_RDS    = BRDS_TL - BRDS_INIT ;
RAP_PRS    = BPRS_TL - BPRS_INIT ;
RAP_TAXAGA = TAXAGA_TL - TAXAGA_INIT ;
RAP_CAP    = PCAP_TL - PCAP_INIT ;
RAP_LOY    = LOYA_TL - LOY_INIT ;
RAP_CHR    = CHR_TL - CHR_INIT ;
RAP_CVN    = CVNA_TL - CVN_INIT ;
RAP_CDIS   = CDISA_TL - CDIS_INIT ;
RAP_GLO    = GLOA_TL - GLO_INIT ;
RAP_RSE1   = RSE1A_TL - RSE1_INIT ;
RAP_RSE2   = RSE2A_TL - RSE2_INIT ;
RAP_RSE3   = RSE3A_TL - RSE3_INIT ;
RAP_RSE4   = RSE4A_TL - RSE4_INIT ;
RAP_RSE5   = RSE5A_TL - RSE5_INIT ;
RAP_RSE6   = RSE6A_TL - RSE6_INIT ;


NUM_IR_TL = max(0 , RAP_RNI
                   + RAP_EFF
                   + RAP_PVQ
                   + RAP_PV
                   + RAP_RI 
                   + RAP_CI) ;

NUM_CS_TL     = max(0 , RAP_CRDS) ;
NUM_RD_TL     = max(0 , RAP_RDS) ;
NUM_PS_TL     = max(0 , RAP_PRS) ;

NUM_TAXAGA_TL = max(0 , RAP_TAXAGA) ; 
NUM_CAP_TL    = max(0 , RAP_CAP) ;
NUM_LOY_TL    = max(0 , RAP_LOY) ;
NUM_CHR_TL    = max(0 , RAP_CHR) ;

NUM_CVN_TL    = max(0 , RAP_CVN) ;
NUM_CDIS_TL   = max(0 , RAP_CDIS) ;
NUM_GLO_TL    = max(0 , RAP_GLO) ;

NUM_RSE1_TL   = max(0 , RAP_RSE1) ;
NUM_RSE2_TL   = max(0 , RAP_RSE2) ;
NUM_RSE3_TL   = max(0 , RAP_RSE3) ;
NUM_RSE4_TL   = max(0 , RAP_RSE4) ;
NUM_RSE5_TL   = max(0 , RAP_RSE5) ;
NUM_RSE6_TL   = max(0 , RAP_RSE6) ;

regle 21710 :
application : iliad ;


DEN_IR_TL = max(0 , RNI_RECT 
                   + EFF_RECT
                   + PVQ_RECT
                   + PV_RECT
                   + RI_RECT 
                   + CI_RECT) ;

DEN_CS_TL     = max(0 , CRDS_RECT) ;
DEN_RD_TL     = max(0 , BRDS_RECT) ;
DEN_PS_TL     = max(0 , BPRS_RECT) ;

DEN_TAXAGA_TL = max(0 , TAXAGA_RECT) ;
DEN_CAP_TL    = max(0 , PCAP_RECT) ;
DEN_LOY_TL    = max(0 , LOY_RECT) ;
DEN_CHR_TL    = max(0 , CHR_RECT) ;

DEN_CVN_TL    = max(0 , CVN_RECT) ;
DEN_CDIS_TL   = max(0 , CDIS_RECT) ;
DEN_GLO_TL    = max(0 , GLO_RECT) ;

DEN_RSE1_TL = max(0 , RSE1_RECT) ;
DEN_RSE2_TL = max(0 , RSE2_RECT) ;
DEN_RSE3_TL = max(0 , RSE3_RECT) ;
DEN_RSE4_TL = max(0 , RSE4_RECT) ;
DEN_RSE5_TL = max(0 , RSE5_RECT) ;
DEN_RSE6_TL = max(0 , RSE6_RECT) ;

regle 21720 :
application : iliad ;
enchaineur : ENCH_TL ;

RETARPRIM = null(V_IND_TRAIT - 4) * null(CMAJ - 7) ;

TL_IR = (1 - positif(TL_MF*positif(MFIR+0)+RETARPRIM+FLAG_RETARD+FLAG_DEFAUT+PASS_TLIR))
            * positif(positif (NUM_IR_TL+0) * positif (DEN_IR_TL+0) * positif(NUM_IR_TL / DEN_IR_TL  - 0.05))
           + positif(TL_MF*positif(MFIR+0) + RETARPRIM + FLAG_RETARD + FLAG_DEFAUT + PASS_TLIR) ;

TL_CS = (1 - positif(TL_MF*positif(MFCS) + RETARPRIM + FLAG_RETARD + FLAG_DEFAUT)) * positif(NUM_CS_TL / DEN_CS_TL  - 0.05) 
         + positif(TL_MF*positif(MFCS) + RETARPRIM + FLAG_RETARD + FLAG_DEFAUT) ;

TL_RD = (1 - positif(TL_MF*positif(MFRD) + RETARPRIM + FLAG_RETARD + FLAG_DEFAUT)) * positif(NUM_RD_TL / DEN_RD_TL  - 0.05)
         + positif(TL_MF*positif(MFRD) + RETARPRIM + FLAG_RETARD + FLAG_DEFAUT) ;

TL_PS = (1 - positif(TL_MF*positif(MFPS) + RETARPRIM + FLAG_RETARD + FLAG_DEFAUT)) * positif(NUM_PS_TL / DEN_PS_TL  - 0.05)
         + positif(TL_MF*positif(MFPS) + RETARPRIM + FLAG_RETARD + FLAG_DEFAUT) ;


TL_TAXAGA = ( 1 - positif(TL_MF * positif(MFTAXAGA) + RETARPRIM + FLAG_RETARD + FLAG_DEFAUT)) * (positif(TL_MF * positif(MFTAXAGA) + positif(NUM_TAXAGA_TL / DEN_TAXAGA_TL - 0.05)))
            + positif(TL_MF * positif(MFTAXAGA) + RETARPRIM + FLAG_RETARD + FLAG_DEFAUT) ;

TL_CAP = ( 1 - positif(TL_MF * positif(MFPCAP) + RETARPRIM + FLAG_RETARD + FLAG_DEFAUT)) * (positif(TL_MF * positif(MFPCAP) + positif(NUM_CAP_TL / DEN_CAP_TL - 0.05)))
            + positif(TL_MF * positif(MFPCAP) + RETARPRIM + FLAG_RETARD + FLAG_DEFAUT) ;

TL_LOY = ( 1 - positif(TL_MF * positif(MFLOY) + RETARPRIM + FLAG_RETARD + FLAG_DEFAUT)) * (positif(TL_MF * positif(MFLOY) + positif(NUM_LOY_TL / DEN_LOY_TL - 0.05)))
            + positif(TL_MF * positif(MFLOY) + RETARPRIM + FLAG_RETARD + FLAG_DEFAUT) ;

TL_CHR = ( 1 - positif(TL_MF * positif(MFIR + MFPCAP) + RETARPRIM + FLAG_RETARD + FLAG_DEFAUT)) * (positif(TL_MF * positif(MFIR + MFPCAP) + positif(NUM_CHR_TL / DEN_CHR_TL - 0.05)))
            + positif(TL_MF * positif(MFIR + MFPCAP) * (1 - null(MFCHR7)) + RETARPRIM + FLAG_RETARD + FLAG_DEFAUT) ;

TL_CVN = (1 - positif(TL_MF * positif(MFCVN)+RETARPRIM+FLAG_RETARD+FLAG_DEFAUT)) * (positif(TL_MF * positif(MFCVN) + positif (NUM_CVN_TL / DEN_CVN_TL  - 0.05 )) )
	 + positif(TL_MF * positif(MFCVN)+RETARPRIM+FLAG_RETARD+FLAG_DEFAUT) ;

TL_CDIS = (1 - positif(TL_MF * positif(MFCDIS)+RETARPRIM+FLAG_RETARD+FLAG_DEFAUT)) * (positif(TL_MF * positif(MFCDIS) + positif (NUM_CDIS_TL / DEN_CDIS_TL  - 0.05 )) )
         + positif(TL_MF * positif(MFCDIS)+RETARPRIM+FLAG_RETARD+FLAG_DEFAUT) ;

TL_GLO = (1 - positif(TL_MF * positif(MFGLO)+RETARPRIM+FLAG_RETARD+FLAG_DEFAUT)) * (positif(TL_MF * positif(MFGLO) + positif (NUM_GLO_TL / DEN_GLO_TL  - 0.05 )) )
         + positif(TL_MF * positif(MFGLO)+RETARPRIM+FLAG_RETARD+FLAG_DEFAUT) ;

TL_RSE1 = (1 - positif(TL_MF * positif(MFRSE1)+RETARPRIM+FLAG_RETARD+FLAG_DEFAUT)) * (positif(TL_MF * positif(MFRSE1) + positif (NUM_RSE1_TL / DEN_RSE1_TL  - 0.05 )) )
         + positif(TL_MF * positif(MFRSE1)+RETARPRIM+FLAG_RETARD+FLAG_DEFAUT) ;

TL_RSE2 = (1 - positif(TL_MF * positif(MFRSE2)+RETARPRIM+FLAG_RETARD+FLAG_DEFAUT)) * (positif(TL_MF * positif(MFRSE2) + positif (NUM_RSE2_TL / DEN_RSE2_TL  - 0.05 )) )
         + positif(TL_MF * positif(MFRSE2)+RETARPRIM+FLAG_RETARD+FLAG_DEFAUT) ;

TL_RSE3 = (1 - positif(TL_MF * positif(MFRSE3)+RETARPRIM+FLAG_RETARD+FLAG_DEFAUT)) * (positif(TL_MF * positif(MFRSE3) + positif (NUM_RSE3_TL / DEN_RSE3_TL  - 0.05 )) )
         + positif(TL_MF * positif(MFRSE3)+RETARPRIM+FLAG_RETARD+FLAG_DEFAUT) ;

TL_RSE4 = (1 - positif(TL_MF * positif(MFRSE4)+RETARPRIM+FLAG_RETARD+FLAG_DEFAUT)) * (positif(TL_MF * positif(MFRSE4) + positif (NUM_RSE4_TL / DEN_RSE4_TL  - 0.05 )) )
         + positif(TL_MF * positif(MFRSE4)+RETARPRIM+FLAG_RETARD+FLAG_DEFAUT) ;

TL_RSE5 = (1 - positif(TL_MF * positif(MFRSE5)+RETARPRIM+FLAG_RETARD+FLAG_DEFAUT)) * (positif(TL_MF * positif(MFRSE5) + positif (NUM_RSE5_TL / DEN_RSE5_TL  - 0.05 )) )
         + positif(TL_MF * positif(MFRSE5)+RETARPRIM+FLAG_RETARD+FLAG_DEFAUT) ;

TL_RSE6 = (1 - positif(TL_MF * positif(MFRSE6)+RETARPRIM+FLAG_RETARD+FLAG_DEFAUT)) * (positif(TL_MF * positif(MFRSE6) + positif (NUM_RSE6_TL / DEN_RSE6_TL  - 0.05 )) )
         + positif(TL_MF * positif(MFRSE6)+RETARPRIM+FLAG_RETARD+FLAG_DEFAUT) ;

