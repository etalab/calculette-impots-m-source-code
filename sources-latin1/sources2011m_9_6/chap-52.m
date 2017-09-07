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
regle 507:
application : pro , oceans , bareme , iliad , batch  ;

TAUX1 =   (TX_BAR1  - TX_BAR0 ) ;
TAUX2 =   (TX_BAR2  - TX_BAR1 ) ;
TAUX3 =   (TX_BAR3  - TX_BAR2 ) ;
TAUX4 =   (TX_BAR4  - TX_BAR3 ) ;
regle 50700:
application : pro , oceans , bareme , iliad , batch  ;
pour x=0,5;y=1,2;z=1,2:
DSxyz = max( QFxyz - LIM_BAR1  , 0 ) * (TAUX1   / 100)
      + max( QFxyz - LIM_BAR2  , 0 ) * (TAUX2   / 100)
      + max( QFxyz - LIM_BAR3  , 0 ) * (TAUX3   / 100)
      + max( QFxyz - LIM_BAR4  , 0 ) * (TAUX4   / 100);
regle 50702:
application : pro , oceans  , iliad , batch  ;
WTXMARJ = (RB51) / ( NB1 * null(PLAFQF) + NB2 *null(1-PLAFQF)) ;
TXMARJ = max ( positif (WTXMARJ - LIM_BAR1) * TX_BAR1 , 
                max ( positif (WTXMARJ - LIM_BAR2) * TX_BAR2 , 
                      max ( positif (WTXMARJ - LIM_BAR3) * TX_BAR3 , 
                             max ( positif (WTXMARJ - LIM_BAR4) * TX_BAR4 ,0
                                 )
                          )
                     )
              )

          * ( 1 - positif ( 
                              present ( NRBASE ) 
                            + present ( NRINET ) 
                            + present ( IPTEFP ) 
                            + present ( IPTEFN ) 
                            + present ( PRODOM ) 
                            + present ( PROGUY ) 
                          )              
             )
          * (1- null(2 - V_REGCO))
  * positif(IDRS2+IPQ1);



regle 5071:
application : pro , oceans , bareme , iliad , batch  ;
pour y=1,2:
DS0y3 = max( QF0y3 - LIM_BAR1  , 0 ) * (TAUX1 /100)
      + max( QF0y3 - LIM_BAR2  , 0 ) * (TAUX2 /100)
      + max( QF0y3 - LIM_BAR3  , 0 ) * (TAUX3 /100)
      + max( QF0y3 - LIM_BAR4  , 0 ) * (TAUX4 /100);
pour y=1,2:
DS0y4 = max( QF0y4 - LIM_BAR1  , 0 ) * (TAUX1 /100)
      + max( QF0y4 - LIM_BAR2  , 0 ) * (TAUX2 /100)
      + max( QF0y4 - LIM_BAR3  , 0 ) * (TAUX3 /100)
      + max( QF0y4 - LIM_BAR4  , 0 ) * (TAUX4 /100);
pour x=0,5:
DSx15 = max( QFx15 - LIM_BAR1  , 0 ) * (TAUX1 /100)
      + max( QFx15 - LIM_BAR2  , 0 ) * (TAUX2 /100)
      + max( QFx15 - LIM_BAR3  , 0 ) * (TAUX3 /100)
      + max( QFx15 - LIM_BAR4  , 0 ) * (TAUX4 /100);
pour y=1,2:
DS0y6 = max( QF0y6 - LIM_BAR1  , 0 ) * (TAUX1 /100)
      + max( QF0y6 - LIM_BAR2  , 0 ) * (TAUX2 /100)
      + max( QF0y6 - LIM_BAR3  , 0 ) * (TAUX3 /100)
      + max( QF0y6 - LIM_BAR4  , 0 ) * (TAUX4 /100);
regle 508:
application : pro , oceans , bareme , iliad , batch  ;
NB1 = NBPT ;
NB2 = 1 + BOOL_0AM + BOOL_0AZ * V_0AV ;
regle 5080:
application : pro , oceans , bareme , iliad , batch  ;
pour y=1,2;z=1,2,3:
QF0yz = arr(RB0z) / NBy;
pour y=1,2;z=1,2:
QF5yz = arr(RB5z) / NBy;
pour y=1,2:
QF0y4 = arr(RB04) / NBy;
pour x=0,5:
QFx15 = arr(RBx5) / NB1;
pour y=1,2:
QF0y6 = arr(RB06) / NBy;
