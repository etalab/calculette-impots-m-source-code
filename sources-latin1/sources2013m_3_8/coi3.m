#*************************************************************************************************************************
#
#Copyright or © or Copr.[DGFIP][2017]
#
#Ce logiciel a été initialement développé par la Direction Générale des 
#Finances Publiques pour permettre le calcul de l'impôt sur le revenu 2014 
#au titre des revenus perçus en 2013. La présente version a permis la 
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
verif 3511:
application : iliad , batch ;
si (APPLI_OCEANS+APPLI_COLBERT = 0) et 
   (( pour un i dans 0, 1, 2, 3, 4, 5, 6, 7: V_0Fi + 0 > V_ANREV )
   ou
   ( pour un j dans G, J, N, H, I, P et un i dans 0, 1, 2, 3: V_0ji + 0 > V_ANREV )) 
 ou (APPLI_COLBERT+APPLI_OCEANS=1) et 
   (( pour un i dans 0, 1, 2, 3, 4, 5, 6, 7: V_0Fi + 0 > V_ANREV )
   ou
   ( pour un j dans 0, 1, 2, 3: V_0Hj + 0 > V_ANREV ))

alors erreur AS02;
verif 3600:
application : iliad , batch  ;
si
   V_IND_TRAIT > 0 
   et
   V_0DN + V_0DP + 0 = 1 
   
alors erreur A011 ;
verif 3610:
application : iliad , batch  ;
si 
   APPLI_OCEANS = 0 
   et 
   V_IND_TRAIT > 0 
   et
   (V_0CF > 19 ou V_0CG > 19 ou V_0CH > 19 ou V_0CI > 19 ou V_0CR > 19 ou V_0DJ > 19 ou V_0DN > 19 ou V_0DP > 19)

alors erreur A019 ;
verif 3620:
application : iliad ;
si (APPLI_OCEANS=0) et 
   ( V_IND_TRAIT+0 = 4 
       et V_BT0CF + 0 = somme(i=0..5:positif(V_BT0Fi+0))
et V_BT0CH + 0 = somme(i=0..5:positif(V_BT0Hi+0))
 et V_0CF + 0 = somme(i=0..5:positif(V_0Fi+0))
  et V_0CH + 0 = somme(i=0..5:positif(V_0Hi+0))
  et
     (
       V_BT0CH + V_BT0CF + 0 > V_0CH + V_0CF
       ou 
       (V_BT0CF = 1 et V_0CF =1 et V_0CH + 0 = 0 et pour un i dans 0,1: V_0Fi = V_ANREV )
       ou
       (V_BT0CF = 1 et V_0CH =1 et V_0CF + 0 = 0 et pour un i dans 0,1: V_0Hi = V_ANREV )
       ou
       (V_BT0CH = 1 et V_0CH =1 et V_0CF + 0 = 0 et pour un i dans 0,1: V_0Hi = V_ANREV )
       ou
       (V_BT0CH = 1 et V_0CF =1 et V_0CH + 0 = 0 et pour un i dans 0,1: V_0Fi = V_ANREV )
     )
   )
alors erreur IM19;
verif 3214:
application : batch , iliad ;
si (APPLI_OCEANS+APPLI_COLBERT = 0) et 
    ( 
       V_BT0CF >0 
          et V_0CH >0 
              et positif(V_0CF+0) != 1
                   et V_BT0CF + 0 = somme(i=0..5:positif(V_BT0Fi+0)) 
                     et V_BT0CH + 0 = somme(i=0..5:positif(V_BT0Hi+0)) 
                       et V_0CF + 0 = somme(i=0..5:positif(V_0Fi+0)) 
                         et V_0CH + 0 = somme(i=0..5:positif(V_0Hi+0)) 
                           et ((     V_0CH < V_BT0CF   ) 
                                ou
                               (     V_0CH = V_BT0CF 
                                  et somme(i=0..5:V_0Hi+0) != somme(i=0..5:V_BT0Fi+0)         )
                                ou
                               (     V_0CH = V_BT0CF
                                  et somme(i=0..5:V_0Hi+0) = somme(i=0..5:V_BT0Fi+0)
                                  et somme(i=0..5: (1/V_0Hi)) != somme(i=0..5: (1/V_BT0Fi))   )
                               ou
                               (     V_0CH > V_BT0CF
        et somme(i=0..5:positif(somme(j=0..5:null(V_0Hj - V_BT0Fi)))*V_BT0Fi) != somme(i=0..5:V_BT0Fi) 
                               )
                               ou
                               (     V_0CH > V_BT0CF
        et somme(i=0..5:positif(somme(j=0..5:null(V_0Hj - V_BT0Fi)))*V_BT0Fi) = somme(i=0..5:V_BT0Fi) 
        et somme(i=0..5:positif(somme(j=0..5:null(V_0Hi - V_BT0Fj)))*V_0Hi) < somme(i=0..5:V_BT0Fi)
                               )
                              )  
    ) 

alors erreur I014;
verif 3215:
application : iliad ;
si 
    APPLI_OCEANS = 0 
    et 
    IREST >= LIM_RESTIT
     
alors erreur IM14 ;
verif 3630:
application : batch , iliad ;
si 
   APPLI_OCEANS = 0 
   et 
   positif(V_0CF + 0) != 1
   et
   (pour un i dans 0..7: positif(V_0Fi + 0) = 1)
   
alors erreur A021 ;
verif 3631:
application : batch, iliad ;
si 
   APPLI_OCEANS = 0 
   et 
   positif(V_0CH + 0) != 1
   et 
   (pour un i dans 0..5: positif(V_0Hi) = 1)
   
alors erreur A021 ;
verif 22:
application : batch, iliad ;

si 
   APPLI_OCEANS + APPLI_COLBERT = 0 
   et 
   V_NOTRAIT = 10 
   et 
   (positif(V_0J0) = 1 ou positif(V_0J1) = 1) 
   et
   (pour un i dans 0..5: V_BT0Fi = V_ANREV - 18)
   et
   (pour un i dans 0..5: V_0Ji = V_ANREV - 18)
   
alors erreur A022 ;
verif 3700:
application : bareme ;
 
si 
   ((V_9VV / 0.25) - arr(V_9VV / 0.25)) != 0
  
alors erreur A06501 ;
verif 3701:
application : bareme ;
 
si 
   V_9VV < 1 
   ou  
   V_9VV > 99.75 
   
alors erreur A06502 ;
