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
regle corrective base_tl_init 1202:
application :  oceans, iliad ;


TL_MF = IND_TL_MF;
RNI_INIT = RNI ;
ETR_INIT = IPMOND + IPTXMO ;
EFF_INIT = AUTOBICVV + AUTOBICPV + AUTOBNCV + XHONOAAV + XHONOV
	   + AUTOBICVC + AUTOBICPC + AUTOBNCC + XHONOAAC + XHONOC
	   + AUTOBICVP + AUTOBICPP + AUTOBNCP + XHONOAAP + XHONOP
	   + IPMOND + IPTXMO ;
PVQ_INIT = TTPVQ ;
PV_INIT  = BPTP3 + BPTP2 + BPTP4 + BPTP40 + BPTP18 + BPTPD + BPTPG + BPTP5 + BPTP19 + BPTPDIV + BPVCESDOM * positif(V_EAD+V_EAG);
RI_INIT  = (REDTL + CIMPTL) * (1-V_CNR) ;
CRDS_INIT = BRDS ;
TAXAGA_INIT = BASSURV + BASSURC ;
PCAP_INIT = BPCAPTAXV + BPCAPTAXC ;
CHR_INIT  = REVKIREHR + (RFRH2 + RFRH1) * positif(HRCONDTHEO) ;
CSAL_INIT = BPVOPTCS ; 
GAIN_INIT = GAINSAL ;
CDIS_INIT = GSALV + GSALC ;
RSE1_INIT = BRSE1 ;
RSE2_INIT = BRSE2 ;
RSE3_INIT = BRSE3 ;
RSE4_INIT = BRSE4 ;

regle corrective  base_tl 1204:
application :  oceans, iliad ;


RNI_TL = RNI ;
ETR_TL = IPMOND + IPTXMO ;
EFF_TL = AUTOBICVV + AUTOBICPV + AUTOBNCV + XHONOAAV + XHONOV
	 + AUTOBICVC + AUTOBICPC + AUTOBNCC + XHONOAAC + XHONOC
	 + AUTOBICVP + AUTOBICPP + AUTOBNCP + XHONOAAP + XHONOP
	 + IPMOND + IPTXMO ;
PVQ_TL = TTPVQ ;
PV_TL  = BPTP3 + BPTP2 + BPTP4 + BPTP40 + BPTP18 + BPTPD + BPTPG + BPTP5 + BPTP19 + BPTPDIV + BPVCESDOM * positif(V_EAD+V_EAG);
RI_TL  = (REDTL + CIMPTL) * (1 - V_CNR) ;
RDS_TL  = BRDS ;
TAXAGA_TL = BASSURV + BASSURC ;
PCAP_TL = BPCAPTAXV + BPCAPTAXC ;
CHR_TL  = REVKIREHR + (RFRH2 + RFRH1) * positif(HRCONDTHEO) ;
CSALA_TL = BPVOPTCS ;
GAINA_TL = GAINSAL ;
CDISA_TL = GSALV + GSALC;
RSE1A_TL = BRSE1 ;
RSE2A_TL = BRSE2 ;
RSE3A_TL = BRSE3 ;
RSE4A_TL = BRSE4 ;

regle corrective base_tl_rect 1206:
application :  oceans, iliad ;


RNI_RECT = RNI ;
ETR_RECT = IPMOND + IPTXMO ;
EFF_RECT = AUTOBICVV + AUTOBICPV + AUTOBNCV + XHONOAAV + XHONOV
	   + AUTOBICVC + AUTOBICPC + AUTOBNCC + XHONOAAC + XHONOC
	   + AUTOBICVP + AUTOBICPP + AUTOBNCP + XHONOAAP + XHONOP
	   + IPMOND + IPTXMO ;
PVQ_RECT = TTPVQ ;
PV_RECT  = BPTP3 + BPTP2 + BPTP4 + BPTP40 + BPTP18 + BPTPD + BPTPG + BPTP5 + BPTP19 + BPTPDIV + BPVCESDOM * positif(V_EAD+V_EAG);
RI_RECT  = RI_INIT - (REDTL + CIMPTL) * (1-V_CNR) ;
CRDS_RECT = BRDS ;
TAXAGA_RECT = BASSURV + BASSURC ;
PCAP_RECT = BPCAPTAXV + BPCAPTAXC ;
CHR_RECT  = REVKIREHR + (RFRH2 + RFRH1) * positif(HRCONDTHEO) ;
CSAL_RECT = BPVOPTCS ;
GAIN_RECT = GAINSAL ;
CDIS_RECT = GSALV + GSALC ;
RSE1_RECT = BRSE1 ;
RSE2_RECT = BRSE2 ;
RSE3_RECT = BRSE3 ;
RSE4_RECT = BRSE4 ;

CSG_RECT = CSG ;
PS_RECT  = PRS ;

