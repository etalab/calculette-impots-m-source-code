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
verif corrective horizontale 666:
application : iliad ;
si
   (
      ( COD_RAPPEL = 1 et MONT_RAPPEL > 19) ou
      ( COD_RAPPEL = 2 et MONT_RAPPEL > 19) ou
      ( COD_RAPPEL = 3 et MONT_RAPPEL > 19) ou
      ( COD_RAPPEL = 4 et MONT_RAPPEL > 19) ou
      ( COD_RAPPEL = 5 et MONT_RAPPEL > 19) ou
      ( COD_RAPPEL = 6 et MONT_RAPPEL > 19) ou
      ( COD_RAPPEL = 7 et MONT_RAPPEL > 19) ou
      ( COD_RAPPEL = 8 et MONT_RAPPEL > 19)
   )
alors erreur A019;
verif corrective horizontale 777:
application : iliad ;
si
    (
      COD_RAPPEL = 1401 et MONT_RAPPEL > 45 
     )
alors erreur A14001;
verif corrective horizontale 888:
application : iliad ;
si
    (
      COD_RAPPEL = 1411 et MONT_RAPPEL > 25 
     )
alors erreur A14101;
verif corrective horizontale 999:
application : iliad ;
si
  (
    COD_RAPPEL = 2020 et MONT_RAPPEL > 9

  )
alors erreur A00101;
