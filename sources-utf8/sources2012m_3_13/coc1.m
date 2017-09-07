#*************************************************************************************************************************
#
#Copyright or © or Copr.[DGFIP][2017]
#
#Ce logiciel a été initialement développé par la Direction Générale des 
#Finances Publiques pour permettre le calcul de l'impôt sur le revenu 2013 
#au titre des revenus percus en 2012. La présente version a permis la 
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
 ( FRNV > 0 et (present(TSHALLOV) + present(ALLOV)) = 0 )
     ou
 ( FRNC > 0 et (present(TSHALLOC) + present(ALLOC)) = 0 )
     ou
 ( FRN1 > 0 et (present(TSHALLO1) + present(ALLO1)) = 0 )
     ou
 ( FRN2 > 0 et (present(TSHALLO2) + present(ALLO2)) = 0 )
     ou
 ( FRN3 > 0 et (present(TSHALLO3) + present(ALLO3)) = 0 )
     ou
 ( FRN4 > 0 et (present(TSHALLO4) + present(ALLO4)) = 0 )
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
       (positif(PPETPV)=1 et positif(PPENHV)=1)
    ou (positif(PPETPC)=1 et positif(PPENHC)=1)
    ou (positif(PPETPP1)=1 et positif(PPENHP1)=1)
    ou (positif(PPETPP2)=1 et positif(PPENHP2)=1)
    ou (positif(PPETPP3)=1 et positif(PPENHP3)=1)
    ou (positif(PPETPP4)=1 et positif(PPENHP4)=1)
   )
alors erreur A153;
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
alors erreur A148;
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
alors erreur A146;
verif 1600:
application : iliad , batch ;
si

( DPVRCM > 0 et ((BPVRCM + PEA + GAINPEA) > 0 ))

alors erreur A320;
verif 1601:
application : iliad , batch ;
si

   positif(ABDETPLUS) + positif(ABDETMOINS) = 2 

alors erreur A321;
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
verif 16025:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   positif(CRENRJRNOUV + 0) + positif(CRECHOBAS + 0) + positif(PARVITWS + 0) > 1

alors erreur A75001 ;
verif 16026:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   positif(VOLISOWU + 0) + positif(VOLISOWV + 0) > 1

alors erreur A75002 ;
verif 16027:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   positif(PORTEWW + 0) + positif(PORTEWX + 0) > 1

alors erreur A75003 ;
verif 16028:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   positif(ISOMURWA + 0) + positif(ISOMURWB + 0) > 1

alors erreur A75004 ;
verif 16029:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   positif(ISOTOIVE + 0) + positif(ISOTOIVF + 0) > 1

alors erreur A75005 ;
verif 16030:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   positif(CRENRJRNOUV + CRECHOBAS + PARVITWS + 0) + positif(MATISOSJ + 0) = 1

alors erreur A74901 ;
verif 16031:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   positif(VOLISOWU + VOLISOWV + 0) + positif(VOLISO + 0) = 1

alors erreur A74902 ;
verif 16032:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   positif(PORTEWW + PORTEWX + 0) + positif(PORENT + 0) = 1

alors erreur A74903 ;
verif 16033:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   positif(ISOMURWA + ISOMURWB + 0) + positif(CINRJ + 0) = 1

alors erreur A74904 ;
verif 16034:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   positif(ISOTOIVE + ISOTOIVF + 0) + positif(CIDEP15 + 0) = 1

alors erreur A74905 ;
verif 16035:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   positif(DEPENVTT + DEPENVTU + DEPENVTV + DEPENVTW + DEPENVTX + DEPENVTY + 0) = 1
   et
   positif(CIBOIBAIL + CINRJBAIL + CRENRJ + CINRJ + CIDEP15 + MATISOSI + MATISOSJ + VOLISO + PORENT + ELESOL + CHAUBOISN
	   + CHAUBOISO + POMPESP + POMPESQ + POMPESR + CHAUFSOL + ENERGIEST + EAUPLUV + DIAGPERF + RESCHAL + 0) = 1

alors erreur A752 ;
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
			+ REVPEA ))
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
	RFMIC > 0 et RFDANT > 0

	)
alors erreur DD11;
verif 1607:
application : batch ,iliad;
si    (APPLI_COLBERT+APPLI_OCEANS=0) et 
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
	(
	(present(ISFBASE) = 0)
	 et
	((ISFPMEDI + ISFPMEIN + ISFFIP + ISFFCPI + ISFDONF + ISFPLAF + ISFVBPAT + ISFDONEURO + ISFETRANG + ISFCONCUB + ISFPART + 0) > 0)
	)
alors erreur A981;

verif isf 1730:                                                                    
application : batch ,iliad  ;                                 
si
      (	
      (V_IND_TRAIT + 0 > 0)
      et
      ((positif(ISF_LIMINF + 0 ) + positif(ISF_LIMSUP + 0 )) = 2)
      )

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



