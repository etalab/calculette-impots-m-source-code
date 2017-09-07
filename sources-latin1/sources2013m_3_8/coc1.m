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
verif 1507:
application : iliad  , batch;
si
    (
 ( FRNV + COD1AE > 0 et (present(TSHALLOV) + present(ALLOV) + present(SALEXTV)) = 0 )
     ou
 ( FRNC + COD1BE > 0 et (present(TSHALLOC) + present(ALLOC) + present(SALEXTC)) = 0 )
     ou
 ( FRN1 + COD1CE > 0 et (present(TSHALLO1) + present(ALLO1) + present(SALEXT1)) = 0 )
     ou
 ( FRN2 + COD1DE > 0 et (present(TSHALLO2) + present(ALLO2) + present(SALEXT2)) = 0 )
     ou
 ( FRN3 + COD1EE > 0 et (present(TSHALLO3) + present(ALLO3) + present(SALEXT3)) = 0 )
     ou
 ( FRN4 + COD1FE > 0 et (present(TSHALLO4) + present(ALLO4) + present(SALEXT4)) = 0 )
    )
alors erreur A143;
verif 1508:
application : iliad  , batch;
si ( 
   (TSHALLOV +0) < (GSALV + 0)
   et
   (GSALV + 0) > 0
   )
alors erreur A14401;
verif 1509:
application : iliad  , batch;
si ( 
   (TSHALLOC +0) < (GSALC + 0)
   et
   (GSALC + 0) > 0
   )
alors erreur A14402;
verif 153:
application : iliad , batch ;

si
   (
       (positif(PPETPV + 0) = 1 et (positif(PPENHV + 0) = 1 ou positif(PPEXTV + 0) = 1))
    ou (positif(PPETPC + 0) = 1 et (positif(PPENHC + 0) = 1 ou positif(PPEXTC + 0) = 1))
    ou (positif(PPETPP1 + 0) = 1 et (positif(PPENHP1 + 0) = 1 ou positif(PPEXT1 + 0) = 1))
    ou (positif(PPETPP2 + 0) = 1 et (positif(PPENHP2 + 0) = 1 ou positif(PPEXT2 + 0) = 1))
    ou (positif(PPETPP3 + 0) = 1 et (positif(PPENHP3 + 0) = 1 ou positif(PPEXT3 + 0) = 1))
    ou (positif(PPETPP4 + 0) = 1 et (positif(PPENHP4 + 0) = 1 ou positif(PPEXT4 + 0) = 1))
   )

alors erreur A153 ;
verif 154:
application : iliad , batch ;

si
      (positif(COD1AD + 0) = 1 et present(SALEXTV) = 0)
   ou (positif(COD1BD + 0) = 1 et present(SALEXTC) = 0) 
   ou (positif(COD1CD + 0) = 1 et present(SALEXT1) = 0) 
   ou (positif(COD1DD + 0) = 1 et present(SALEXT2) = 0) 
   ou (positif(COD1ED + 0) = 1 et present(SALEXT3) = 0) 
   ou (positif(COD1FD + 0) = 1 et present(SALEXT4) = 0) 

alors erreur A154 ;
verif 148:
application : iliad , batch ;

si (APPLI_OCEANS = 0) et (
   (
     V_NOTRAIT + 0 < 20
     et
     positif ( present ( IPTEFP ) + present ( IPTEFN ) + 0 ) = 0 
     et
     positif ( positif ( TSELUPPEV + 0 ) + positif ( TSELUPPEC + 0 )) = 1 
     et
     positif ( IND_TDR + 0 ) = 0
   )
   ou
   (
     V_NOTRAIT + 0 >= 20
     et
     positif ( present ( IPTEFP ) + present ( IPTEFN ) + 0 ) = 0 
     et
     positif ( positif ( TSELUPPEV + 0 ) + positif ( TSELUPPEC + 0 )) = 1 
     et
     positif_ou_nul ( IND_TDR ) = 0
   )                      )
alors erreur A148 ;
verif 1491:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   positif(IPTEFP + IPTEFN + 0) = 0
   et
   positif(TSELUPPEV + 0) + positif(SALEXTV + 0) = 2

alors erreur A14901 ;
verif 1492:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   positif(IPTEFP + IPTEFN + 0) = 0
   et
   positif(TSELUPPEC + 0) + positif(SALEXTC + 0) = 2

alors erreur A14902 ;
verif non_auto_cc 1513:
application : iliad , batch ;

si (
     ( DETSV=1 et
       positif(present(TSHALLOV) + present(ALLOV) + present(CARTSV) + present(CARTSNBAV) + present(REMPLAV) + present(REMPLANBV)) = 0 )
 ou
     ( DETSC=1 et 
       positif(present(TSHALLOC) + present(ALLOC) + present(CARTSC) + present(CARTSNBAC) + present(REMPLAC) + present(REMPLANBC))=0 )
 ou
     ( DETS1=1 et 
       positif(present(TSHALLO1) + present(ALLO1) + present(CARTSP1) + present(CARTSNBAP1) + present(REMPLAP1) + present(REMPLANBP1))=0 )
 ou
     ( DETS2=1 et 
       positif(present(TSHALLO2) + present(ALLO2) + present(CARTSP2) + present(CARTSNBAP2) + present(REMPLAP2) + present(REMPLANBP2))=0 )
 ou
     ( DETS3=1 et
       positif(present(TSHALLO3) + present(ALLO3) + present(CARTSP3) + present(CARTSNBAP3) + present(REMPLAP3) + present(REMPLANBP3))=0 )
 ou
     ( DETS4=1 et
       positif(present(TSHALLO4) + present(ALLO4) + present(CARTSP4) + present(CARTSNBAP4) + present(REMPLAP4) + present(REMPLANBP4))=0 )
	)
alors erreur A146 ;
verif 1600:
application : iliad , batch ;

si

( DPVRCM > 0 et ((BPVRCM + PEA + GAINPEA) > 0 ))

alors erreur A320 ;
verif 1601:
application : iliad , batch ;
si

   positif(ABDETPLUS) + positif(ABDETMOINS) = 2 

alors erreur A321;
verif 324:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   positif(COD3SL + 0) + positif(COD3SM + 0) = 2

alors erreur A324 ;
verif 16021:
application : iliad , batch ;

si
   FIPDOMCOM + 0 > 0
   et 
   V_EAD + V_EAG + 0 = 0

alors erreur A747 ;
verif 16022:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   positif(TRAVITWT + 0) = 1
   et
   positif(MATISOSJ + 0) = 0

alors erreur A75101 ;
verif 16023:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   positif(TRAMURWC + 0) = 1
   et
   positif(CINRJ + 0) = 0

alors erreur A75102 ;
verif 16024:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   positif(TRATOIVG + 0) = 1
   et
   positif(CIDEP15 + 0) = 0

alors erreur A75103 ;
verif 16036:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   positif(CRECHOCON2 + 0) = 1
   et
   positif(CIBOIBAIL + CINRJBAIL + CINRJ + CIDEP15 + MATISOSJ + CHAUBOISN + CHAUBOISO + POMPESP + POMPESQ + POMPESR + CHAUFSOL + ENERGIEST + 0) = 0

alors erreur A74801 ;
verif 16037:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   positif(CRECHOBOI + 0) = 1
   et
   positif(CIBOIBAIL + CINRJBAIL + CRENRJ + CINRJ + CIDEP15 + MATISOSI + MATISOSJ + VOLISO + PORENT + ELESOL + CHAUBOISN
	   + CHAUBOISO + POMPESP + POMPESQ + POMPESR + CHAUFSOL + ENERGIEST + EAUPLUV + DIAGPERF + RESCHAL + 0) = 0

alors erreur A74802 ;
verif 1608:
application : iliad , batch ;
si
   positif(ABIMPPV + 0) = 1 
   et 
   positif(ABIMPMV + 0) = 1 

alors erreur A323 ;
verif 1616:
application : iliad , batch ;
si (APPLI_OCEANS=0) et (
          (
                ( RDPRESREPORT +0  > V_BTPRESCOMP  +  LIM_REPORT )
           ou 
                ( PRESCOMP2000 + PRESCOMPJUGE  +0 > LIM_REPORT  et
                   V_BTPRESCOMP  + 0> 0 )
           ou
                ( RDPRESREPORT +0  > LIM_REPORT et V_BTPRESCOMP+0 = 0 )
          )
          et
          (
              1 - V_CNR > 0
          )
          et
          (
              RPRESCOMP > 0
          )
         et
          ((APPLI_ILIAD = 1 et V_NOTRAIT+0 < 16)
             ou APPLI_COLBERT = 1
             ou ((V_BTNI1+0) non dans (50,92) et APPLI_BATCH = 1))
	               )
alors erreur DD15;
verif 1606:
application : iliad , batch ;
si (APPLI_OCEANS = 0) et 
(   (1 - V_CNR > 0) et 
(RCMRDS > (LIM_CONTROLE + RCMABD 
                        + RCMAV 
                        + RCMHAD 
                        + RCMHAB  
			+ RCMTNC
			+ REVACT
			+ PROVIE
			+ DISQUO 
			+ INTERE
			+ REVPEA 
                        + COD2FA))
)
alors erreur DD14;
verif 1603:
application : batch , iliad ;
si (
   RFMIC > 0 et ( RFORDI > 0 ou RFDORD > 0 ou RFDHIS > 0 ou FONCI > 0 ou REAMOR > 0 et FONCINB > 0 ou REAMORNB > 0)
   )
alors erreur A420;
verif 1604:
application : batch , iliad;
si ( V_IND_TRAIT > 0)
   et
   (
   RFMIC >  LIM_MICFON
   )
alors erreur A421;
verif 422:
application : batch , iliad ;
si 
  (
   LOYIMP > 0 et ( present(RFORDI) = 0
		et 
		   present(FONCI) = 0
		et 
		   present(FONCINB) = 0
		et 
		   present(REAMOR) = 0
		et 
		   present(REAMORNB) = 0
		et 
		   present(RFDORD) = 0
                et 
		   present(RFDHIS) = 0
		et 
		   present(RFMIC) = 0)
  )
alors erreur A422;
verif 1609:
application : batch , iliad ;

 si (
    (RFROBOR > 0 et RFDANT > 0) et (present(RFORDI)=0
                                 et present(RFDORD)=0
                                 et present(RFDHIS)=0
                                    )
    )
alors erreur A423;
verif 1610:
application : batch , iliad ;

si 
   RFROBOR > 0 et (FONCI > 0 ou REAMOR > 0)

alors erreur A424 ;
verif 1605:
application : batch, iliad ;
si (APPLI_OCEANS = 0) et
	(
	RFMIC > 0 et RFDANT> 0

	)
alors erreur DD11;
verif 1607:
application : batch ,iliad;
si    (APPLI_COLBERT+APPLI_OCEANS=0) 
      et
      V_IND_TRAIT + 0 = 4
      et 
	(
	BAILOC98 > V_BTBAILOC98        
	ou
	( present(BAILOC98) = 1 et present(V_BTBAILOC98) = 0)
	)
alors erreur DD24;
verif 1538:                                                                    
application : iliad , batch ;                                 
si ( 
( RCSV > 0 et SOMMEA538VB = 0 )

ou
( RCSC > 0 et SOMMEA538CB = 0 )

ou
( RCSP > 0 et SOMMEA538PB = 0 )

)
alors erreur A538;
verif isf 967:                                                                    
application : iliad , batch ;                                 

si
   V_ZDC = 4
   et
   positif(V_0AZ + 0) = 1
   et
   positif(ISFBASE + 0) = 1

alors erreur A967 ;
verif isf 1700:                                                                    
application : iliad , batch;                                 
si
	(
	( (V_NOTRAIT +0 < 14) et (V_IND_TRAIT+0 = 4))
	et
	(ISFBASE <= LIM_ISFINF)
	)

alors erreur A98001 ;
verif isf 1710:                                                                    
application :  iliad , batch ;                                 
si
	(
        ((V_NOTRAIT +0 < 14) et (V_IND_TRAIT+0 = 4))
	et
	(ISFBASE >= LIM_ISFSUP)
	)
alors erreur A98002;
verif isf 1711:                                                                    
application : iliad;                                 
si 
	(
	 (
	   ((V_NOTRAIT + 0 = 14) ou (V_NOTRAIT+0 = 16)) 
         )
	 et
	 ( present(ISFBASE) = 1 )
	 et
	 ( ISFBASE + 0 <= LIM_ISFINF )
	)
alors erreur A98003;
verif isf 1712:                                                                    
application :  iliad;                                 
si 
	(
	( ISFBASE + 0 != 0 )
	  et
		(
		( V_NOTRAIT + 0 > 20 )
		  et
		( ISFBASE + 0 <= LIM_ISFINF )
		)
	)
alors erreur A98004;
verif isf 1713:                                                                    
application : iliad ;                                 
si 
	(
	( V_NOTRAIT + 0 > 13 )
	et
	( ISFBASE + 0 >= LIM_ISFSUP )
	)
alors erreur A98005;
verif isf 1720:                                                                    
application : iliad , batch ;                                 
                                                                              
si
   present(ISFBASE) = 0
   et
   (ISFPMEDI + ISFPMEIN + ISFFIP + ISFFCPI + ISFDONF + ISFPLAF + ISFVBPAT + ISFDONEURO + ISFETRANG + ISFCONCUB + ISFPART + 0) > 0
	
alors erreur A981 ;
verif isf 1730:                                                                    
application : batch ,iliad  ;                                 
si
   V_IND_TRAIT + 0 > 0
   et
   positif(ISF_LIMINF + 0) + positif(ISF_LIMSUP + 0) = 2

alors erreur A982 ;
verif isf 1740:                                                            
application : batch , iliad ;                                 
si (APPLI_OCEANS=0) et 
      (
		  (V_IND_TRAIT + 0 = 4)
		  et
		  (
		  positif(ISFCONCUB + 0 ) = 1
                  et
                  	(positif(V_0AM + V_0AO + 0 ) = 1
                         ou
                  		(positif(V_0AC + V_0AD + V_0AV + 0 )=1
                                 et
				 positif(V_0AB + 0)= 1 
		       	        )
			)
                  )
	)
alors erreur A983 ;
verif isf 1750:                                                            
application : batch , iliad  ;                              
si
      (
                  (V_IND_TRAIT + 0 = 4)
		  et
		  (
		  positif(ISFPART + 0 ) = 1
                  et
                  	(positif(V_0AM + V_0AO + 0 ) = 1
                         ou
                  		(positif(V_0AC + V_0AD + V_0AV + 0 )=1
                                 et
				 positif(V_0AB + 0)= 0 
		       	        )
			)
                   )
	)
alors erreur A984 ;
verif isf 1760:                                                           
application : batch , iliad  ;                             
si
      positif(ISF_LIMINF + ISF_LIMSUP + 0) = 1
      et
      ISFBASE > LIM_ISFINF 
      et 
      ISFBASE < LIM_ISFSUP

alors erreur A985;
verif isf 1770:                                                           
application : batch , iliad  ;                             
si (APPLI_OCEANS=0) et 
      (
      (V_NOTRAIT > 13)
      et
      (ISFCONCUB + 0 > 0 et ISFPART + 0 > 0)
      )
alors erreur A986;
verif isf 1780:                                                           
application : batch , iliad  ;                             
si (APPLI_OCEANS=0) et 
      (
     	 (
      		(V_NOTRAIT+0 = 14)
	 )
         et
         (
      		(V_ETCVL + 0 = 1)
		et
      		(ISFCONCUB + ISFPART + 0 = 0)
         )
      )
alors erreur A98701;
verif isf 1790:                                                           
application : batch , iliad  ;                             
si (APPLI_OCEANS=0) et 
   (
      (
      		(V_NOTRAIT+0 = 14)
      )
      et
      (
      		(present(V_ETCVL) = 1)
		et
		(V_ETCVL + 0 = 0)
		et
      		(ISFCONCUB + ISFPART + 0 > 0)
      )
   )
alors erreur A98702;



