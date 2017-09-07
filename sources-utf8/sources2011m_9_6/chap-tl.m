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
regle 21700:
application : oceans , iliad ;


RAP_RNI    = RNI_TL - RNI_INIT ;
RAP_EFF    = EFF_TL - EFF_INIT ;
RAP_PVQ    = PVQ_TL - PVQ_INIT ;
RAP_PV     = PV_TL - PV_INIT ;
RAP_RI     = - RI_TL + RI_INIT ;
RAP_CI     = CI_TL ;
RAP_CRDS   = RDS_TL - CRDS_INIT ;
RAP_TAXAGA = TAXAGA_TL - TAXAGA_INIT ;
RAP_CAP    = PCAP_TL - PCAP_INIT ;
RAP_CHR    = CHR_TL - CHR_INIT ;
RAP_CSAL   = CSALA_TL - CSAL_INIT ;
RAP_GAIN   = GAINA_TL - GAIN_INIT ;
RAP_CDIS   = CDISA_TL - CDIS_INIT ;
RAP_RSE1   = RSE1A_TL - RSE1_INIT ;
RAP_RSE2   = RSE2A_TL - RSE2_INIT ;
RAP_RSE3   = RSE3A_TL - RSE3_INIT ;
RAP_RSE4   = RSE4A_TL - RSE4_INIT ;


NUM_IR_TL = max(0 , RAP_RNI
                   + RAP_EFF
                   + RAP_PVQ
                   + RAP_PV
                   + RAP_RI 
                   + RAP_CI) ;

NUM_CS_TL     = max(0 , RAP_CRDS) ;

NUM_TAXAGA_TL = max(0 , RAP_TAXAGA) ; 
NUM_CAP_TL    = max(0 , RAP_CAP) ;
NUM_CHR_TL    = max(0 , RAP_CHR) ;

NUM_CSAL_TL   = max(0 , RAP_CSAL) ;
NUM_GAIN_TL   = max(0 , RAP_GAIN) ; 
NUM_CDIS_TL   = max(0 , RAP_CDIS) ;

NUM_RSE1_TL   = max(0 , RAP_RSE1) ;
NUM_RSE2_TL   = max(0 , RAP_RSE2) ;
NUM_RSE3_TL   = max(0 , RAP_RSE3) ;
NUM_RSE4_TL   = max(0 , RAP_RSE4) ;
regle 21710 :
application : oceans , iliad ;


DEN_IR_TL = max(0 , RNI_RECT 
                   + EFF_RECT
                   + PVQ_RECT
                   + PV_RECT
                   + RI_RECT 
                   + CI_RECT) ;

DEN_CS_TL     = max(0 , CRDS_RECT) ;

DEN_TAXAGA_TL = max(0 , TAXAGA_RECT) ;
DEN_CAP_TL    = max(0 , PCAP_RECT) ;
DEN_CHR_TL    = max(0 , CHR_RECT) ;

DEN_CSAL_TL   = max(0 , CSAL_RECT) ;
DEN_GAIN_TL   = max(0 , GAIN_RECT) ;
DEN_CDIS_TL   = max(0 , CDIS_RECT) ;

DEN_RSE1_TL = max(0 , RSE1_RECT) ;
DEN_RSE2_TL = max(0 , RSE2_RECT) ;
DEN_RSE3_TL = max(0 , RSE3_RECT) ;
DEN_RSE4_TL = max(0 , RSE4_RECT) ;

regle 21720 :
application : oceans , iliad ;
enchaineur : ENCH_TL ;


TL_IR = (1 - positif(TL_MF*positif(MFIR+0)+FLAG_RETARD+FLAG_DEFAUT+PASS_TLIR))
            *( positif(   positif (NUM_IR_TL+0)
                          * positif (DEN_IR_TL+0)
                          * positif (NUM_IR_TL / DEN_IR_TL  - 0.05 )
                     )
            )
           + positif(TL_MF*positif(MFIR+0)+FLAG_RETARD+FLAG_DEFAUT+PASS_TLIR) ;

TL_CS = (1 - positif(TL_MF*positif(MFCS)+FLAG_RETARD+FLAG_DEFAUT)) * (positif(TL_MF*positif(MFCS) + positif (NUM_CS_TL / DEN_CS_TL  - 0.05 )) )
         + positif(TL_MF*positif(MFCS)+FLAG_RETARD+FLAG_DEFAUT);


TL_TAXAGA = ( 1 - positif(TL_MF * positif(MFTAXAGA) + FLAG_RETARD + FLAG_DEFAUT))
		 * (positif(TL_MF * positif(MFTAXAGA) + positif(NUM_TAXAGA_TL / DEN_TAXAGA_TL - 0.05)))
            + positif(TL_MF * positif(MFTAXAGA) + FLAG_RETARD + FLAG_DEFAUT) ;

TL_CAP = ( 1 - positif(TL_MF * positif(MFPCAP) + FLAG_RETARD + FLAG_DEFAUT))
		 * (positif(TL_MF * positif(MFPCAP) + positif(NUM_CAP_TL / DEN_CAP_TL - 0.05)))
            + positif(TL_MF * positif(MFPCAP) + FLAG_RETARD + FLAG_DEFAUT) ;

TL_CHR = ( 1 - positif(TL_MF * positif(MFIR) + FLAG_RETARD + FLAG_DEFAUT))
		 * (positif(TL_MF * positif(MFIR) + positif(NUM_CHR_TL / DEN_CHR_TL - 0.05)))
            + positif(TL_MF * positif(MFIR) + FLAG_RETARD + FLAG_DEFAUT) ;

TL_CSAL = (1 - positif(TL_MF * positif(MFCSAL)+FLAG_RETARD+FLAG_DEFAUT)) * (positif(TL_MF * positif(MFCSAL) + positif (NUM_CSAL_TL / DEN_CSAL_TL  - 0.05 )) )
         + positif(TL_MF * positif(MFCSAL)+FLAG_RETARD+FLAG_DEFAUT) ;

TL_GAIN = (1 - positif(TL_MF * positif(MFGAIN)+FLAG_RETARD+FLAG_DEFAUT)) * (positif(TL_MF * positif(MFGAIN) + positif (NUM_GAIN_TL / DEN_GAIN_TL  - 0.05 )) )
	 + positif(TL_MF * positif(MFGAIN)+FLAG_RETARD+FLAG_DEFAUT) ;

TL_CDIS = (1 - positif(TL_MF * positif(MFCDIS)+FLAG_RETARD+FLAG_DEFAUT)) * (positif(TL_MF * positif(MFCDIS) + positif (NUM_CDIS_TL / DEN_CDIS_TL  - 0.05 )) )
         + positif(TL_MF * positif(MFCDIS)+FLAG_RETARD+FLAG_DEFAUT) ;

TL_RSE1 = (1 - positif(TL_MF * positif(MFRSE1)+FLAG_RETARD+FLAG_DEFAUT)) * (positif(TL_MF * positif(MFRSE1) + positif (NUM_RSE1_TL / DEN_RSE1_TL  - 0.05 )) )
         + positif(TL_MF * positif(MFRSE1)+FLAG_RETARD+FLAG_DEFAUT) ;

TL_RSE2 = (1 - positif(TL_MF * positif(MFRSE2)+FLAG_RETARD+FLAG_DEFAUT)) * (positif(TL_MF * positif(MFRSE2) + positif (NUM_RSE2_TL / DEN_RSE2_TL  - 0.05 )) )
         + positif(TL_MF * positif(MFRSE2)+FLAG_RETARD+FLAG_DEFAUT) ;

TL_RSE3 = (1 - positif(TL_MF * positif(MFRSE3)+FLAG_RETARD+FLAG_DEFAUT)) * (positif(TL_MF * positif(MFRSE3) + positif (NUM_RSE3_TL / DEN_RSE3_TL  - 0.05 )) )
         + positif(TL_MF * positif(MFRSE3)+FLAG_RETARD+FLAG_DEFAUT) ;

TL_RSE4 = (1 - positif(TL_MF * positif(MFRSE4)+FLAG_RETARD+FLAG_DEFAUT)) * (positif(TL_MF * positif(MFRSE4) + positif (NUM_RSE4_TL / DEN_RSE4_TL  - 0.05 )) )
         + positif(TL_MF * positif(MFRSE4)+FLAG_RETARD+FLAG_DEFAUT) ;

