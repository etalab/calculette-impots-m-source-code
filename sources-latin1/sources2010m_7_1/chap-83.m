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
regle 831:
application : pro , oceans , iliad , batch  ;
RRFI = RFON + DRCF + max(0,RFMIC - MICFR - RFDANT) ;
regle 8311:
application : pro , oceans , iliad , batch  ;
MICFR = present(RFMIC) * arr(RFMIC * TX_MICFON/100);
regle 8316:
application : pro , iliad , batch  ;
RMF = max(0,RFMIC - MICFR);
RMFN = max(0,RFMIC - MICFR - RFDANT);
regle 832:
application : pro , oceans , iliad , batch  ;
RFCD = RFORDI + FONCI + REAMOR;
regle 833:
application : pro , oceans , iliad , batch  ;
RFCE = max(0,RFCD-RFDORD);
DFCE = min(0,RFCD-RFDORD);
RFCF = max(0,RFCE-RFDHIS);
DRCF  = min(0,RFCE-RFDHIS);
RFCG = max(0,RFCF-RFDANT);
DFCG = min(0,RFCF-RFDANT);
regle 834:
application : pro , oceans , iliad , batch  ;
RFON = arr(RFCG*RFORDI/RFCD);
2REVF = min( arr (RFCG*(FONCI)/RFCD) , RFCG-RFON);
3REVF = min( arr (RFCG*(REAMOR)/RFCD) , RFCG-RFON-2REVF);
RFQ = FONCI + REAMOR;
 
