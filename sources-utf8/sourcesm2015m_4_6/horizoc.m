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
verif corrective horizontale 760 :
application : iliad ;
si          (
            V_IND_TRAIT > 0
	    et
            SENS_RAPPEL non dans (1, 2, 3, 4)
	    )
alors erreur A760;
verif corrective horizontale 770 :
application : iliad ;
si          (
            V_IND_TRAIT > 0
	    et
            SENS_RAPPEL = 4 
	    et 
            PEN_RAPPEL non dans (07, 08, 09, 10, 11, 12, 17, 18, 31)
	    )
alors erreur A770;
verif corrective horizontale 780 :
application : iliad ;
si
 (
            V_IND_TRAIT > 0
	    et
	    (
            ANNEE_RAPPEL <= V_ANREV
            ou
            MOIS_RAPPEL non dans ( 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 )
	    )
 )

alors erreur A780;
