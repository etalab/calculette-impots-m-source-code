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
regle isf 232:
application : iliad ;
SUPISF[X] = positif(FLAG_RETARD) * positif(FLAG_RECTIF) * null(X)
            * max(ISF4BASE,0)
            + (1 - positif(FLAG_RETARD) * positif(FLAG_RECTIF) * null(X))
	     * max(0,ISF4BASE - (TISF4BASE[FLAG_DERSTTR]));


regle 23111:
application : iliad ;
IRBASE = IRN - IRANT ;
CSBASE_MAJO = (CSG - CSGIM) * positif(CSG + RDSN + PRS + CSAL + CGAINSAL + RSE1
					  + RSE2 + RSE3 + RSE4 - SEUIL_61);
RDBASE_MAJO = (RDSN - CRDSIM) * positif(CSG + RDSN + PRS + CSAL + CGAINSAL + RSE1
					    + RSE2 + RSE3 + RSE4 - SEUIL_61);
PSBASE_MAJO = (PRS - PRSPROV) * positif(CSG + RDSN + PRS + CSAL + CGAINSAL + RSE1
					    + RSE2 + RSE3 + RSE4 - SEUIL_61);
CSALBASE_MAJO = (CSAL - CSALPROV) * positif(CSG + RDSN + PRS + CSAL + CGAINSAL + RSE1
						+ RSE2 + RSE3 + RSE4 - SEUIL_61);
CDISBASE_MAJO = CDIS * positif(CDIS + CSG + RDSN + PRS + CSAL + CGAINSAL + RSE1
                                          + RSE2 + RSE3 + RSE4 - SEUIL_61);
TAXABASE_MAJO = TAXASSUR * positif(IAMD1 + 1 - SEUIL_61);

HRBASE_MAJO = IHAUTREVT * positif(IAMD1 + 1 - SEUIL_61);

CAPBASE_MAJO = IPCAPTAXT * positif(IAMD1 + 1 - SEUIL_61);

GAINBASE_MAJO = (CGAINSAL - GAINPROV) * positif(CSG + RDSN + PRS + CSAL + CGAINSAL + RSE1
						+ RSE2 + RSE3 + RSE4 - SEUIL_61);

RSE1BASE_MAJO = RSE1N * positif(CSG + RDSN + PRS + CSAL + CGAINSAL + RSE1N
                                   + RSE2N + RSE3N + RSE4N - SEUIL_61);

RSE2BASE_MAJO = RSE2N * positif(CSG + RDSN + PRS + CSAL + CGAINSAL + RSE1N
				   + RSE2N + RSE3N + RSE4N - SEUIL_61);

RSE3BASE_MAJO = RSE3N * positif(CSG + RDSN + PRS + CSAL + CGAINSAL + RSE1N
				   + RSE2N + RSE3N + RSE4N - SEUIL_61);

RSE4BASE_MAJO = RSE4N * positif(CSG + RDSN + PRS + CSAL + CGAINSAL + RSE1N
                                   + RSE2N + RSE3N + RSE4N - SEUIL_61);

regle corrective 23112:
application :   iliad ;
TOT_BASE_MAJO = IRBASE + TAXABASE_MAJO + CAPBASE_MAJO + HRBASE_MAJO ;

TOT_REF = TIRBASE[FLAG_DERSTTR] +TTAXABASE[FLAG_DERSTTR]
	 +TPCAPBASE[FLAG_DERSTTR]+TCHRBASE[FLAG_DERSTTR];


TAXA_ISO = TAXASSUR * positif(IAMD1 + 1 - SEUIL_61) ; 
CAP_ISO  = IPCAPTAXT * positif(IAMD1 + 1 - SEUIL_61) ; 
HR_ISO   = IHAUTREVT  * positif(IAMD1 + 1 - SEUIL_61) ; 
SUPIR_PENA_RESTIT = max(0, min( IRBASE + TTAXABASE[FLAG_DERSTTR]+TPCAPBASE[FLAG_DERSTTR]+TCHRBASE[FLAG_DERSTTR]
				- TOT_REF ,
                                 min(
                                      min(IRBASE_IRECT , IRBASE) - TIRBASE[FLAG_DERSTTR] ,
                                      TOT_BASE_MAJO - TOT_REF
                                    )
                               )
                        );


SUPIR[X] =  null(X) * positif(FLAG_RETARD) * positif(FLAG_RECTIF)
                   * max( 0, min( 
			          min( IRBASE_IRECT , IRBASE ),
				  TOT_BASE_MAJO 
                                )
                            
                        )
	      +( 1 - positif(FLAG_RETARD) * positif(FLAG_RECTIF) * null(X))
		 * positif(null(X-3)+null(X-7)+null(X-8)+null(X-12)+null(X-13))
		 * SUPIR_PENA_RESTIT


             + (1 - positif(FLAG_RETARD) * positif(FLAG_RECTIF) * null(X))
             * (1 - positif((null(X-3)+null(X-7)+null(X-8)+null(X-12)+null(X-13))))
             * (1 - positif(null(X-1)))
	     * ((1 - positif(TARDIFEVT2)*null(X-2))
                       * max( 0 , min( max( 0, IRBASE + TTAXABASE[FLAG_DERSTTR]+TPCAPBASE[FLAG_DERSTTR]+TCHRBASE[FLAG_DERSTTR])
			               - max( 0 , TOT_REF ),
			               min(
				       		min(IRBASE_IRECT , IRBASE) - TIRBASE[FLAG_DERSTTR] ,
						max( 0 , TOT_BASE_MAJO ) - max( 0 , TOT_REF )
                                          )
                                     )
                            )
                 + positif(TARDIFEVT2) * null(X-2) * TIRBASE[FLAG_DERSTTR]
	       )

           + (1 - positif((null(X-3)+null(X-7)+null(X-8)+null(X-12)+null(X-13)))) 
              *  null(X-1)*positif( null(CSTRATE1 - 1)
			       +null(CSTRATE1 - 7)
		               +null(CSTRATE1 - 8)
			       +null(CSTRATE1 - 10)
		               +null(CSTRATE1 - 11)
	                       +null(CSTRATE1 - 17)
                               +null(CSTRATE1 - 18)) 
                       * max( 0 , min( max( 0, IRBASE + TTAXABASE[FLAG_DERSTTR]+TPCAPBASE[FLAG_DERSTTR]+TCHRBASE[FLAG_DERSTTR])
			               - max( 0 , TOT_REF ),
			               min(
				       		min(IRBASE_IRECT , IRBASE) - TIRBASE[FLAG_DERSTTR] ,
						max( 0 , TOT_BASE_MAJO ) - max( 0 , TOT_REF )
                                          )
                                     )
                            )


           + null(X-1)*positif( null(CSTRATE1 - 3)
	                       +null(CSTRATE1 - 4)
			       +null(CSTRATE1 - 5)
			       +null(CSTRATE1 - 6)
		               +null(CSTRATE1 - 55)) 
                              		* SUPIR_PENA_RESTIT ; 


SUP2IR[X] = null(X) * null(CODE_2042 - 17) * positif(FLAG_RETARD) * positif(FLAG_RECTIF)
                    * max( 0, min( 
			            min( IRBASE_IRECT , IRBASE ),
				    TOT_BASE_MAJO 
                                 )
                         )         

	      + ((positif(null(X-14)+null(X-15)+null(X-18)+null(X-20))
                    * SUPIR_PENA_RESTIT 
	          )
	          + (1 - positif(null(X-14)+null(X-15)+null(X-18)+null(X-20)))* 0)
                 * (1 - positif(null(X-1))) 
           + null(X-1)*positif( null(CSTRATE1 - 1)
                               +null(CSTRATE1 - 17)
	                       +null(CSTRATE1 - 2)
			       +null(CSTRATE1 - 10)
		               +null(CSTRATE1 - 30)) 
	             * SUPIR_PENA_RESTIT;

SUPCS[X] =  (1 - positif(FLAG_RETARD) * positif(FLAG_RECTIF) * null(X))
	 * max(0,CSBASE_MAJO - (TCSBASE[FLAG_DERSTTR] * positif(TNAPCR[FLAG_DERSTTR] + NAPCR_P + null(CSBASE_MAJO - TCSBASE[FLAG_DERSTTR]))))
         +  (positif(FLAG_RETARD) * positif(FLAG_RECTIF) * null(X))
         * max(CSBASE_MAJO,0); 
SUPPS[X] =  (1 - positif(FLAG_RETARD) * positif(FLAG_RECTIF) * null(X))
	 * max(0,PSBASE_MAJO - (TPSBASE[FLAG_DERSTTR] * positif(TNAPCR[FLAG_DERSTTR] + NAPCR_P + null(PSBASE_MAJO - TPSBASE[FLAG_DERSTTR]))))
         +  (positif(FLAG_RETARD) * positif(FLAG_RECTIF) * null(X))
         * max(PSBASE_MAJO,0); 
SUPRD[X] =  (1 - positif(FLAG_RETARD) * positif(FLAG_RECTIF) * null(X))
	 * max(0,RDBASE_MAJO - (TRDBASE[FLAG_DERSTTR] * positif(TNAPCR[FLAG_DERSTTR] + NAPCR_P + null(RDBASE_MAJO - TRDBASE[FLAG_DERSTTR]))))
         +  (positif(FLAG_RETARD) * positif(FLAG_RECTIF) * null(X))
         * max(RDBASE_MAJO,0); 
SUPCSAL[X] =  (1 - positif(FLAG_RETARD) * positif(FLAG_RECTIF) * null(X))
	 * max(0,CSALBASE_MAJO - (TCSALBASE[FLAG_DERSTTR] * positif(TNAPCR[FLAG_DERSTTR] + NAPCR_P + null(CSALBASE_MAJO - TCSALBASE[FLAG_DERSTTR]))))
         +  (positif(FLAG_RETARD) * positif(FLAG_RECTIF) * null(X))
         * max(CSALBASE_MAJO,0); 
SUPCDIS[X] =  (1 - positif(FLAG_RETARD) * positif(FLAG_RECTIF) * null(X))
	 * max(0,CDISBASE_MAJO - (TCDISBASE[FLAG_DERSTTR] * positif(TNAPCR[FLAG_DERSTTR] + NAPCR_P + null(CDISBASE_MAJO - TCDISBASE[FLAG_DERSTTR]))))
         +  (positif(FLAG_RETARD) * positif(FLAG_RECTIF) * null(X))
         * max(CDISBASE_MAJO,0); 
SUPGAIN[X] =  (1 - positif(FLAG_RETARD) * positif(FLAG_RECTIF) * null(X))
	 * max(0,GAINBASE_MAJO - (TGAINBASE[FLAG_DERSTTR] * positif(TNAPCR[FLAG_DERSTTR] + NAPCR_P + null(GAINBASE_MAJO - TGAINBASE[FLAG_DERSTTR]))))
         +  (positif(FLAG_RETARD) * positif(FLAG_RECTIF) * null(X))
         * max(GAINBASE_MAJO,0); 

SUPRSE1[X] =  (1 - positif(FLAG_RETARD) * positif(FLAG_RECTIF) * null(X))
	 * max(0,RSE1BASE_MAJO - (TRSE1BASE[FLAG_DERSTTR] * positif(TNAPCR[FLAG_DERSTTR] + NAPCR_P + null(RSE1BASE_MAJO - TRSE1BASE[FLAG_DERSTTR]))))
         +  (positif(FLAG_RETARD) * positif(FLAG_RECTIF) * null(X))
         * max(RSE1BASE_MAJO,0); 

SUPRSE2[X] =  (1 - positif(FLAG_RETARD) * positif(FLAG_RECTIF) * null(X))
	 * max(0,RSE2BASE_MAJO - (TRSE2BASE[FLAG_DERSTTR] * positif(TNAPCR[FLAG_DERSTTR] + NAPCR_P + null(RSE2BASE_MAJO - TRSE2BASE[FLAG_DERSTTR]))))
         +  (positif(FLAG_RETARD) * positif(FLAG_RECTIF) * null(X))
         * max(RSE2BASE_MAJO,0); 

SUPRSE3[X] =  (1 - positif(FLAG_RETARD) * positif(FLAG_RECTIF) * null(X))
	 * max(0, min(RSE3BASE2042_FIC , RSE3BASE_MAJO) - (TRSE3BASE[FLAG_DERSTTR] * positif(TNAPCR[FLAG_DERSTTR] + NAPCR_P + null(RSE3BASE_MAJO - TRSE3BASE[FLAG_DERSTTR]))))
         +  (positif(FLAG_RETARD) * positif(FLAG_RECTIF) * null(X))
         * max(RSE3BASE_MAJO,0); 

SUPRSE4[X] =  (1 - positif(FLAG_RETARD) * positif(FLAG_RECTIF) * null(X))
	 * max(0,RSE4BASE_MAJO - (TRSE4BASE[FLAG_DERSTTR] * positif(TNAPCR[FLAG_DERSTTR] + NAPCR_P + null(RSE4BASE_MAJO - TRSE4BASE[FLAG_DERSTTR]))))
         +  (positif(FLAG_RETARD) * positif(FLAG_RECTIF) * null(X))
         * max(RSE4BASE_MAJO,0); 

SUPTAXA[X] =  null(X) * positif(FLAG_RETARD) * positif(FLAG_RECTIF)
		      * max(0, min( IRBASE + TAXABASE_MAJO ,
				       min(
				             min( TAXABASE_IRECT , TAXABASE_MAJO) ,
				             TOT_BASE_MAJO
				          )
                                  )
                           )


	      +( 1 - positif(FLAG_RETARD) * positif(FLAG_RECTIF) * null(X))
		 * positif(null(X-3)+null(X-7)+null(X-8)+null(X-12)+null(X-13))
	         * max(0, min( IRBASE + TAXABASE_MAJO + TPCAPBASE[FLAG_DERSTTR] + TCHRBASE[FLAG_DERSTTR]
			       - TOT_REF ,
				   min(
		                   	min( TAXABASE_IRECT , TAXABASE_MAJO) - TTAXABASE[FLAG_DERSTTR] ,
				   	TOT_BASE_MAJO - TOT_REF
                                      )
                             )
                       )			       


              + ( 1 - positif(FLAG_RETARD) * positif(FLAG_RECTIF) * null(X))
		* (1 - positif((null(X-3)+null(X-7)+null(X-8)+null(X-12)+null(X-13))))

		    * max( 0 , min( max( 0 , IRBASE + TAXABASE_MAJO + TPCAPBASE[FLAG_DERSTTR] + TCHRBASE[FLAG_DERSTTR] )
				     - max( 0 , TOT_REF ) ,
				    min(
			             min( TAXABASE_IRECT , TAXABASE_MAJO) - TTAXABASE[FLAG_DERSTTR] ,
			             max( 0 , TOT_BASE_MAJO )  - max( 0 , TOT_REF )
				     )
				  )
		         ) ;



SUP2TAXA[X] = null(X) * null(CODE_2042 - 17) * positif(FLAG_RETARD) * positif(FLAG_RECTIF)

		      * max(0, min( IRBASE + TAXABASE_MAJO ,
				       min(
				             min( TAXABASE_IRECT , TAXABASE_MAJO) ,
				             TOT_BASE_MAJO
				          )
                                  )
                           )

	      + (positif(null(X-14)+null(X-15)+null(X-18)+null(X-20))

	         * max(0, min( IRBASE + TAXABASE_MAJO + TPCAPBASE[FLAG_DERSTTR] + TCHRBASE[FLAG_DERSTTR]
			       - TOT_REF ,
				   min(
		                   	min( TAXABASE_IRECT , TAXABASE_MAJO) - TTAXABASE[FLAG_DERSTTR] ,
				   	TOT_BASE_MAJO - TOT_REF
                                      )
                             )
                       )			       
	        )
	     + (1 - positif(null(X-14)+null(X-15)+null(X-18)+null(X-20))) * 0
	     ;


SUPCAP[X] =  null(X) * positif(FLAG_RETARD) * positif(FLAG_RECTIF)
		    * max(0, min( IRBASE + TAXABASE_MAJO + CAPBASE_MAJO ,
				     min(
					    min( CAPBASE_IRECT , CAPBASE_MAJO) ,
                                            TOT_BASE_MAJO
					)
                                 )
                         )

	      +( 1 - positif(FLAG_RETARD) * positif(FLAG_RECTIF) * null(X))
		 * positif(null(X-3)+null(X-7)+null(X-8)+null(X-12)+null(X-13))
	         * max(0, min(IRBASE + TAXABASE_MAJO + CAPBASE_MAJO + TCHRBASE[FLAG_DERSTTR] - TOT_REF,
			      min(
			           min( CAPBASE_IRECT , CAPBASE_MAJO) - TPCAPBASE[FLAG_DERSTTR] , 
				   TOT_BASE_MAJO - TOT_REF
                                 )
                             )
                      )
	+( 1 - positif(FLAG_RETARD) * positif(FLAG_RECTIF) * null(X))
		* (1 - positif((null(X-3)+null(X-7)+null(X-8)+null(X-12)+null(X-13))))

	        * max( 0 , min( max( 0, IRBASE + TAXABASE_MAJO + CAPBASE_MAJO + TCHRBASE[FLAG_DERSTTR])
				 - max( 0 , TOT_REF ) ,  
				  min(
				     min( CAPBASE_IRECT , CAPBASE_MAJO) - TPCAPBASE[FLAG_DERSTTR] ,
				     max( 0 , TOT_BASE_MAJO ) - max( 0 , TOT_REF )
                                     )
                              )
                     ) ;

SUP2CAP[X] = null(X) * null(CODE_2042 - 17) * positif(FLAG_RETARD) * positif(FLAG_RECTIF)
		     * max(0, min( IRBASE + TAXABASE_MAJO + CAPBASE_MAJO ,
				     min(
					    min( CAPBASE_IRECT , CAPBASE_MAJO) ,
                                            TOT_BASE_MAJO
					)
                                 )
                          )
	      + (positif(null(X-14)+null(X-15)+null(X-18)+null(X-20))
	         * max(0, min(IRBASE + TAXABASE_MAJO + CAPBASE_MAJO + TCHRBASE[FLAG_DERSTTR] - TOT_REF,
			      min(
			           min( CAPBASE_IRECT , CAPBASE_MAJO) - TPCAPBASE[FLAG_DERSTTR] , 
				   TOT_BASE_MAJO - TOT_REF
                                 )
                             )
                      )

	        )
	     + (1 - positif(null(X-14)+null(X-15)+null(X-18)+null(X-20))) * 0
	     ;

SUPHR[X] =  null(X) * positif(FLAG_RETARD) * positif(FLAG_RECTIF)
		    * max(0, 
				     min(
					    min( HRBASE_IRECT , HRBASE_MAJO) ,
                                            TOT_BASE_MAJO
					)
                          )

	      +( 1 - positif(FLAG_RETARD) * positif(FLAG_RECTIF) * null(X))
		 * positif(null(X-3)+null(X-7)+null(X-8)+null(X-12)+null(X-13))
	         * max(0, min( 
		                min( HRBASE_IRECT, HRBASE_MAJO) - TCHRBASE[FLAG_DERSTTR] , 
                                TOT_BASE_MAJO - TOT_REF
                             )
                      )

              + ( 1 - positif(FLAG_RETARD) * positif(FLAG_RECTIF) * null(X))
		* (1 - positif((null(X-3)+null(X-7)+null(X-8)+null(X-12)+null(X-13))))
                * max( 0 , min( 
                                  min( HRBASE_IRECT, HRBASE_MAJO) - TCHRBASE[FLAG_DERSTTR] ,
			          max( 0 , TOT_BASE_MAJO ) - max( 0 , TOT_REF ) 
                              )
                     );


SUP2HR[X] = null(X) * null(CODE_2042 - 17) * positif(FLAG_RETARD) * positif(FLAG_RECTIF) 
		    * max(0, 
				     min(
					    min( HRBASE_IRECT , HRBASE_MAJO) ,
                                            TOT_BASE_MAJO
					)
                          )

	      + (positif(null(X-14)+null(X-15)+null(X-18)+null(X-20))

	         * max(0, min( 
		                min( HRBASE_IRECT, HRBASE_MAJO) - TCHRBASE[FLAG_DERSTTR] , 
                                TOT_BASE_MAJO - TOT_REF
                             )
                      )
	        )
	     + (1 - positif(null(X-14)+null(X-15)+null(X-18)+null(X-20))) * 0
	        ;
regle corrective 23113:
application : iliad;
TMAJOIR[X] = (1 - null((1 - IND_RJLJ) + (10 - TAUX_STRATE)))
	     * arr( (SUPIR[X] * TAUX_STRATE/100 ));
T2MAJOIR[X] = (1 - null(1 - IND_RJLJ))
	     * (
	     (positif(null(X - 0) * null(CODE_2042 - 17) 
		 +null(X-14)+null(X-15)+null(X-18)+null(X-20))
		*(null(X-20)*TL_IR*arr(SUP2IR[X] * TX1758A/100)
		  +(1-null(X-20)) * arr(SUP2IR[X] * TX1758A/100)))

	      + null(X-1) 
	                  * positif(null(X - 1) * null(CSTRATE1 - 17)
                               +null(CSTRATE1 - 1)
	                       +null(CSTRATE1 - 2)
			       +null(CSTRATE1 - 10)
		               +null(CSTRATE1 - 30)) * arr(SUP2IR[X] * TX1758A/100)

                 ); 

MAJOIR_ST = MAJOIRST_DEF * (1 - positif(FLAG_1STRATE)) + 
            TMAJOIR[X] + T2MAJOIR[X];
TMAJOCS[X] = (1 - null((1 - IND_RJLJ) + (10 - TAUX_STRATE)))
	     * arr( (SUPCS[X] * TAUX_STRATE/100 ));
MAJOCS_ST = MAJOCSST_DEF * (1 - positif(FLAG_1STRATE)) + 
            TMAJOCS[X] ;
TMAJOPS[X] = (1 - null((1 - IND_RJLJ) + (10 - TAUX_STRATE)))
	     * arr( (SUPPS[X] * TAUX_STRATE/100 ));
MAJOPS_ST = MAJOPSST_DEF * (1 - positif(FLAG_1STRATE)) + 
            TMAJOPS[X] ;
TMAJORD[X] = (1 - null((1 - IND_RJLJ) + (10 - TAUX_STRATE)))
	     * arr( (SUPRD[X] * TAUX_STRATE/100 ));
MAJORD_ST = MAJORDST_DEF * (1 - positif(FLAG_1STRATE)) + 
            TMAJORD[X] ;
TMAJOCSAL[X] = (1 - null((1 - IND_RJLJ) + (10 - TAUX_STRATE)))
	     * arr( (SUPCSAL[X] * TAUX_STRATE/100 ));
MAJOCSAL_ST = MAJOCSALST_DEF * (1 - positif(FLAG_1STRATE)) + 
            TMAJOCSAL[X] ;
TMAJOCDIS[X] = (1 - null((1 - IND_RJLJ) + (10 - TAUX_STRATE)))
	     * arr( (SUPCDIS[X] * TAUX_STRATE/100 ));
MAJOCDIS_ST = MAJOCDISST_DEF * (1 - positif(FLAG_1STRATE)) + 
            TMAJOCDIS[X] ;
TMAJOGAIN[X] = (1 - null((1 - IND_RJLJ) + (10 - TAUX_STRATE)))
	     * arr( (SUPGAIN[X] * TAUX_STRATE/100 ));
MAJOGAIN_ST = MAJOGAINST_DEF * (1 - positif(FLAG_1STRATE)) + 
TMAJOGAIN[X] ;
TMAJORSE1[X] = (1 - null((1 - IND_RJLJ) + (10 - TAUX_STRATE)))
	     * arr( (SUPRSE1[X] * TAUX_STRATE/100 ));
MAJORSE1_ST = MAJORSE1ST_DEF * (1 - positif(FLAG_1STRATE)) + 
            TMAJORSE1[X] ;
TMAJORSE2[X] = (1 - null((1 - IND_RJLJ) + (10 - TAUX_STRATE)))
	     * arr( (SUPRSE2[X] * TAUX_STRATE/100 ));
MAJORSE2_ST = MAJORSE2ST_DEF * (1 - positif(FLAG_1STRATE)) + 
            TMAJORSE2[X] ;
TMAJORSE3[X] = (1 - null((1 - IND_RJLJ) + (10 - TAUX_STRATE)))
	     * arr( (SUPRSE3[X] * TAUX_STRATE/100 ));
MAJORSE3_ST = MAJORSE3ST_DEF * (1 - positif(FLAG_1STRATE)) + 
            TMAJORSE3[X] ;
TMAJORSE4[X] = (1 - null((1 - IND_RJLJ) + (10 - TAUX_STRATE)))
	     * arr( (SUPRSE4[X] * TAUX_STRATE/100 ));
MAJORSE4_ST = MAJORSE4ST_DEF * (1 - positif(FLAG_1STRATE)) + 
            TMAJORSE4[X] ;
TMAJOTAXA[X] = (1 - null((1 - IND_RJLJ) + (10 - TAUX_STRATE)))
	     * arr( (SUPTAXA[X] * TAUX_STRATE/100 ));
T2MAJOTAXA[X] = (1 - null(1 - IND_RJLJ))
	     * (positif(null(X - 0) * null(CODE_2042 - 17) 
	        + null(X-14)+null(X-15)+null(X-18)+null(X-20))
		*(null(X-20)*TL_TAXAGA*arr(SUP2TAXA[X] * TX1758A/100)
		  +(1-null(X-20)) * arr(SUP2TAXA[X] * TX1758A/100)));
MAJOTAXA_ST = MAJOTAXAST_DEF * (1 - positif(FLAG_1STRATE)) + 
            TMAJOTAXA[X] + T2MAJOTAXA[X];
TMAJOHR[X] = (1 - null((1 - IND_RJLJ) + (10 - TAUX_STRATE)))
	     * arr( (SUPHR[X] * TAUX_STRATE/100 ));
T2MAJOHR[X] = (1 - null(1 - IND_RJLJ))
	     * (positif(null(X - 0) * null(CODE_2042 - 17) 
	        + null(X-14)+null(X-15)+null(X-18)+null(X-20))
		*(null(X-20)*TL_CHR*arr(SUP2HR[X] * TX1758A/100)
		  +(1-null(X-20)) * arr(SUP2HR[X] * TX1758A/100)));
MAJOHR_ST = MAJOHRST_DEF * (1 - positif(FLAG_1STRATE)) + 
            TMAJOHR[X] + T2MAJOHR[X];
TMAJOCAP[X] = (1 - null((1 - IND_RJLJ) + (10 - TAUX_STRATE)))
	     * arr( (SUPCAP[X] * TAUX_STRATE/100 ));
T2MAJOCAP[X] = (1 - null(1 - IND_RJLJ))
	     * (positif(null(X - 0) * null(CODE_2042 - 17) 
	        + null(X-14)+null(X-15)+null(X-18)+null(X-20))
		*(null(X-20)*TL_CAP*arr(SUP2CAP[X] * TX1758A/100)
		  +(1-null(X-20)) * arr(SUP2CAP[X] * TX1758A/100)));
MAJOCAP_ST = MAJOCAPST_DEF * (1 - positif(FLAG_1STRATE)) + 
            TMAJOCAP[X] + T2MAJOCAP[X];
regle isf 233:
application : iliad;
TMAJOISF[X] = (1 - null((1 - IND_RJLJ) + (10 - TAUX_STRATE)))
	     * arr( (SUPISF[X] * TAUX_STRATE/100 ));
MAJOISF_ST = MAJOISFST_DEF * (1 - positif(FLAG_1STRATE)) + 
            TMAJOISF[X] ;
regle corrective 23114:
application : iliad;

MAJOIR07_TARDIF = max(0,arr(FLAG_TRTARDIF * TAUX_2042/100 *
                            min(min(IRBASE2042_FIC,IRBASE),
                                max(0, IRBASE)
                               )
                            )
			* STR_TR16 
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	              ); 
MAJOIR08_TARDIF = max(0,arr(FLAG_TRTARDIF * TAUX_2042/100 *
                            min(min(IRBASE2042_FIC,IRBASE),
                                max(0, IRBASE)
                               )
                            )
			* STR_TR11 
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	              ); 
MAJOIR17_1TARDIF = max(0,arr(FLAG_TRTARDIF * TAUX_2042/100 *
                            min(min(IRBASE2042_FIC,IRBASE),
                                max(0, IRBASE)
                               )
                            )

			* STR_TR15 
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	              ); 
MAJOIR17_2TARDIF = max(0,arr(FLAG_TRTARDIF * TX1758A/100 *
                            min(min(IRBASE2042_FIC,IRBASE),
                                max(0, IRBASE)
                               )
                            )
			* STR_TR15 
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	              ); 
MAJOIR_TARDIF = somme(x = 07,08: MAJOIR0x_TARDIF) 
		+ MAJOIR17_1TARDIF + MAJOIR17_2TARDIF;
MAJOCS07_TARDIF = max(0,arr(FLAG_TRTARDIF * CSBASE_MAJO * TAUX_2042/100)
			* STR_TR16 
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	);
MAJOCS08_TARDIF = max(0,arr(FLAG_TRTARDIF * CSBASE_MAJO * TAUX_2042/100)
			* STR_TR11 
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	);
MAJOCS17_TARDIF = max(0,arr(FLAG_TRTARDIF * CSBASE_MAJO * TAUX_2042/100)
			* STR_TR15 
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	);
MAJOCS_TARDIF = somme(x = 07,08,17 : MAJOCSx_TARDIF);
MAJOPS07_TARDIF = max(0,arr(FLAG_TRTARDIF * PSBASE_MAJO * TAUX_2042/100)
			* STR_TR16 
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	);
MAJOPS08_TARDIF = max(0,arr(FLAG_TRTARDIF * PSBASE_MAJO * TAUX_2042/100)
			* STR_TR11 
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	);
MAJOPS17_TARDIF = max(0,arr(FLAG_TRTARDIF * PSBASE_MAJO * TAUX_2042/100)
			* STR_TR15 
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	);
MAJOPS_TARDIF = somme(x = 07,08,17 : MAJOPSx_TARDIF);
MAJORD07_TARDIF = max(0,arr(FLAG_TRTARDIF * RDBASE_MAJO * TAUX_2042/100)
			* STR_TR16
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	);
MAJORD08_TARDIF = max(0,arr(FLAG_TRTARDIF * RDBASE_MAJO * TAUX_2042/100)
			* STR_TR11 
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	);
MAJORD17_TARDIF = max(0,arr(FLAG_TRTARDIF * RDBASE_MAJO * TAUX_2042/100)
			* STR_TR15 
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	);
MAJORD_TARDIF = somme(x = 07,08,17 : MAJORDx_TARDIF);
MAJOCSAL07_TARDIF = max(0,arr(FLAG_TRTARDIF * CSALBASE_MAJO * TAUX_2042/100)
			* STR_TR16
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	);
MAJOCSAL08_TARDIF = max(0,arr(FLAG_TRTARDIF * CSALBASE_MAJO * TAUX_2042/100)
			* STR_TR11 
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	);
MAJOCSAL17_TARDIF = max(0,arr(FLAG_TRTARDIF * CSALBASE_MAJO * TAUX_2042/100)
			* STR_TR15 
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	);
MAJOCSAL_TARDIF = somme(x = 07,08,17 : MAJOCSALx_TARDIF);
MAJOGAIN07_TARDIF = max(0,arr(FLAG_TRTARDIF * GAINBASE_MAJO * TAUX_2042/100)
			* STR_TR16
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	);
MAJOGAIN08_TARDIF = max(0,arr(FLAG_TRTARDIF * GAINBASE_MAJO * TAUX_2042/100)
			* STR_TR11 
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	);
MAJOGAIN17_TARDIF = max(0,arr(FLAG_TRTARDIF * GAINBASE_MAJO * TAUX_2042/100)
			* STR_TR15 
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	);
MAJOGAIN_TARDIF = somme(x = 07,08,17 : MAJOGAINx_TARDIF);
MAJOCDIS07_TARDIF = max(0,arr(FLAG_TRTARDIF * CDISBASE_MAJO * TAUX_2042/100)
			* STR_TR16
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	);
MAJOCDIS08_TARDIF = max(0,arr(FLAG_TRTARDIF * CDISBASE_MAJO * TAUX_2042/100)
			* STR_TR11 
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	);
MAJOCDIS17_TARDIF = max(0,arr(FLAG_TRTARDIF * CDISBASE_MAJO * TAUX_2042/100)
			* STR_TR15 
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	);
MAJOCDIS_TARDIF = somme(x = 07,08,17 : MAJOCDISx_TARDIF);
MAJORSE107_TARDIF = max(0,arr(FLAG_TRTARDIF * RSE1BASE_MAJO * TAUX_2042/100)
			* STR_TR16
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	                );
MAJORSE108_TARDIF = max(0,arr(FLAG_TRTARDIF * RSE1BASE_MAJO * TAUX_2042/100)
			* STR_TR11 
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	                );
MAJORSE117_TARDIF = max(0,arr(FLAG_TRTARDIF * RSE1BASE_MAJO * TAUX_2042/100)
			* STR_TR15 
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	                );
MAJORSE1_TARDIF = somme(x = 07,08,17 : MAJORSE1x_TARDIF);
MAJORSE207_TARDIF = max(0,arr(FLAG_TRTARDIF * RSE2BASE_MAJO * TAUX_2042/100)
			* STR_TR16
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	                );
MAJORSE208_TARDIF = max(0,arr(FLAG_TRTARDIF * RSE2BASE_MAJO * TAUX_2042/100)
			* STR_TR11 
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	                );
MAJORSE217_TARDIF = max(0,arr(FLAG_TRTARDIF * RSE2BASE_MAJO * TAUX_2042/100)
			* STR_TR15 
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	                );
MAJORSE2_TARDIF = somme(x = 07,08,17 : MAJORSE2x_TARDIF);
MAJORSE307_TARDIF = max(0,arr(FLAG_TRTARDIF * RSE3BASE_MAJO * TAUX_2042/100)
			* STR_TR16
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	                );
MAJORSE308_TARDIF = max(0,arr(FLAG_TRTARDIF * RSE3BASE_MAJO * TAUX_2042/100)
			* STR_TR11 
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	                );
MAJORSE317_TARDIF = max(0,arr(FLAG_TRTARDIF * RSE3BASE_MAJO * TAUX_2042/100)
			* STR_TR15 
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	                );
MAJORSE3_TARDIF = somme(x = 07,08,17 : MAJORSE3x_TARDIF);
MAJORSE407_TARDIF = max(0,arr(FLAG_TRTARDIF * RSE4BASE_MAJO * TAUX_2042/100)
			* STR_TR16
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	                );
MAJORSE408_TARDIF = max(0,arr(FLAG_TRTARDIF * RSE4BASE_MAJO * TAUX_2042/100)
			* STR_TR11 
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	                );
MAJORSE417_TARDIF = max(0,arr(FLAG_TRTARDIF * RSE4BASE_MAJO * TAUX_2042/100)
			* STR_TR15 
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	                );
MAJORSE4_TARDIF = somme(x = 07,08,17 : MAJORSE4x_TARDIF);
MAJOHR07_TARDIF = max(0,arr(FLAG_TRTARDIF * TAUX_2042/100 *
                            min(min(HRBASE2042_FIC,HRBASE_MAJO),
			        max(0, IRBASE+TAXABASE_MAJO+CAPBASE_MAJO+HRBASE_MAJO)
                               )
                           )
			* STR_TR16
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	              );

MAJOHR08_TARDIF = max(0,arr(FLAG_TRTARDIF * TAUX_2042/100 *
                            min(min(HRBASE2042_FIC,HRBASE_MAJO),
			        max(0, IRBASE+TAXABASE_MAJO+CAPBASE_MAJO+HRBASE_MAJO)
                               )
                           )
			* STR_TR11 
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	                );
MAJOHR17_1TARDIF = max(0,arr(FLAG_TRTARDIF * TAUX_2042/100 *
                            min(min(HRBASE2042_FIC,HRBASE_MAJO),
			        max(0, IRBASE+TAXABASE_MAJO+CAPBASE_MAJO+HRBASE_MAJO)
                               )
                           )

			* STR_TR15
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	              );
MAJOHR17_2TARDIF = max(0,arr(FLAG_TRTARDIF * TX1758A/100 *
                            min(min(HRBASE2042_FIC,HRBASE_MAJO),
			        max(0, IRBASE+TAXABASE_MAJO+CAPBASE_MAJO+HRBASE_MAJO)
                               )
                           )

			* STR_TR15
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	              );
MAJOHR_TARDIF = somme(x = 07,08 : MAJOHR0x_TARDIF) 
		+ MAJOHR17_1TARDIF + MAJOHR17_2TARDIF;
MAJOCAP07_TARDIF = max(0,arr(FLAG_TRTARDIF * TAUX_2042/100 *
                             min(min(CAPBASE2042_FIC,CAPBASE_MAJO),
			         max(0, IRBASE + TAXABASE_MAJO + CAPBASE_MAJO)
                                )
                            )
			* STR_TR16
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	               );

MAJOCAP08_TARDIF = max(0,arr(FLAG_TRTARDIF * TAUX_2042/100 *
			     min(min(CAPBASE2042_FIC,CAPBASE_MAJO),
			         max(0, IRBASE + TAXABASE_MAJO + CAPBASE_MAJO)
                                )
                             )
			* STR_TR11 
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	               );

MAJOCAP17_1TARDIF = max(0,arr(FLAG_TRTARDIF * TAUX_2042/100 *
                              min(min(CAPBASE2042_FIC,CAPBASE_MAJO),
			          max(0, IRBASE + TAXABASE_MAJO + CAPBASE_MAJO)
                                 )
                             )
			* STR_TR15
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	               );

MAJOCAP17_2TARDIF = max(0,arr(FLAG_TRTARDIF * TX1758A/100 *
                              min(min(CAPBASE2042_FIC,CAPBASE_MAJO),
			          max(0, IRBASE + TAXABASE_MAJO + CAPBASE_MAJO)
                                 )
                             )
			* STR_TR15
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	               );
MAJOCAP_TARDIF = somme(x = 07,08 : MAJOCAP0x_TARDIF) 
		+ MAJOCAP17_1TARDIF + MAJOCAP17_2TARDIF;

MAJOTAXA07_TARDIF = max(0,arr(FLAG_TRTARDIF * TAUX_2042/100 * 
                             min(min(TAXABASE2042_FIC,TAXABASE_MAJO),
			         max(0, IRBASE + TAXABASE_MAJO)
                                )
                              )
			* STR_TR16
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	                );
MAJOTAXA08_TARDIF = max(0,arr(FLAG_TRTARDIF * TAUX_2042/100 *
			      min(min(TAXABASE2042_FIC,TAXABASE_MAJO),
                                  max(0, IRBASE + TAXABASE_MAJO)
				 )	   
                              ) 
			* STR_TR11 
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	);
MAJOTA17_1TARDIF = max(0,arr(FLAG_TRTARDIF * TAUX_2042/100 *
                             min(min(TAXABASE2042_FIC,TAXABASE_MAJO),
			         max(0, IRBASE + TAXABASE_MAJO)
                                )
                            ) 
			* STR_TR15
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	               );
MAJOTA17_2TARDIF = max(0,arr(FLAG_TRTARDIF * TX1758A/100 *
                             min(min(TAXABASE2042_FIC,TAXABASE_MAJO),
                                  max(0, IRBASE + TAXABASE_MAJO)
                                )
                            )
			* STR_TR15
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
	              );
MAJOTAXA_TARDIF = somme(x = 07,08 : MAJOTAXA0x_TARDIF) 
		+ MAJOTA17_1TARDIF + MAJOTA17_2TARDIF;
IRNIN_TARDIF = IRBASE * FLAG_TRTARDIF ;
CSG_TARDIF = CSBASE_MAJO * FLAG_TRTARDIF ;
RDS_TARDIF = RDBASE_MAJO* FLAG_TRTARDIF;
PRS_TARDIF = PSBASE_MAJO * FLAG_TRTARDIF;
CSAL_TARDIF = CSALBASE_MAJO * FLAG_TRTARDIF;
CDIS_TARDIF = CDISBASE_MAJO * FLAG_TRTARDIF;
GAIN_TARDIF = GAINBASE_MAJO * FLAG_TRTARDIF;
RSE1_TARDIF = RSE1BASE_MAJO * FLAG_TRTARDIF;
RSE2_TARDIF = RSE2BASE_MAJO * FLAG_TRTARDIF;
RSE3_TARDIF = RSE3BASE_MAJO * FLAG_TRTARDIF;
RSE4_TARDIF = RSE4BASE_MAJO * FLAG_TRTARDIF;
TAXA_TARDIF = TAXABASE_MAJO * FLAG_TRTARDIF;
HR_TARDIF = HRBASE_MAJO * FLAG_TRTARDIF;
CAP_TARDIF = CAPBASE_MAJO * FLAG_TRTARDIF;
regle isf 234:
application : iliad;
MAJOISF07_TARDIF =  max(0,arr(FLAG_TRTARDIF * ISF4BASE * TAUX_2042/100)
			* STR_TR16
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
                     );
MAJOISF08_TARDIF = max(0,arr(FLAG_TRTARDIF * ISF4BASE * TAUX_2042/100)
			* STR_TR11
		        * (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
		     );
MAJOISF17_TARDIF = max(0,arr(FLAG_TRTARDIF * ISF4BASE * TAUX_2042/100)
			* STR_TR15
			* (1 - null((1 -IND_RJLJ) + (10 - TAUX_2042)))
		     );
MAJOISF_TARDIF = somme(x = 07,08,17 : MAJOISFx_TARDIF);
ISF_TARDIF = ISF4BASE * FLAG_TRTARDIF ;
regle corrective 231141:
application : iliad;
FLAG_TRTARDIF_R = FLAG_RETARD * FLAG_RECTIF * FLAG_1STRATE 
		 * (null(CSTRATE99 - 7) + null(CSTRATE99 - 8) + null(CSTRATE99 - 17) );
MAJOIR07TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-7) * TMAJOIR[00];
MAJOIR08TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-8) * TMAJOIR[00];
MAJOIR17_1TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-17) * TMAJOIR[00];
MAJOIR17_2TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-17) * TMAJOIR[00];
MAJOIRTARDIF_R = somme(x = 07,08: MAJOIR0xTARDIF_R) 
		+ MAJOIR17_1TARDIF_R + MAJOIR17_2TARDIF_R;
MAJOCS07TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-7) * TMAJOCS[00];
MAJOCS08TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-8) * TMAJOCS[00];
MAJOCS17TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-17) * TMAJOCS[00];
MAJOCSTARDIF_R = somme(x = 07,08,17: MAJOCSxTARDIF_R);
MAJOPS07TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-7) * TMAJOPS[00];
MAJOPS08TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-8) * TMAJOPS[00];
MAJOPS17TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-17) * TMAJOPS[00];
MAJOPSTARDIF_R = somme(x = 07,08,17: MAJOPSxTARDIF_R);
MAJORD07TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-7) * TMAJORD[00];
MAJORD08TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-8) * TMAJORD[00];
MAJORD17TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-17) * TMAJORD[00];
MAJORDTARDIF_R = somme(x = 07,08,17: MAJORDxTARDIF_R);
MAJOCSAL07TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-7) * TMAJOCSAL[00];
MAJOCSAL08TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-8) * TMAJOCSAL[00];
MAJOCSAL17TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-17) * TMAJOCSAL[00];
MAJOCSALTARDIF_R = somme(x = 07,08,17: MAJOCSALxTARDIF_R);
MAJOCDIS07TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-7) * TMAJOCDIS[00];
MAJOCDIS08TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-8) * TMAJOCDIS[00];
MAJOCDIS17TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-17) * TMAJOCDIS[00];
MAJOCDISTARDIF_R = somme(x = 07,08,17: MAJOCDISxTARDIF_R);
MAJOGAIN07TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-7) * TMAJOGAIN[00];
MAJOGAIN08TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-8) * TMAJOGAIN[00];
MAJOGAIN17TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-17) * TMAJOGAIN[00];
MAJOGAINTARDIF_R = somme(x = 07,08,17: MAJOGAINxTARDIF_R);
MAJORSE107TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-7) * TMAJORSE1[00];
MAJORSE108TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-8) * TMAJORSE1[00];
MAJORSE117TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-17) * TMAJORSE1[00];
MAJORSE1TARDIF_R = somme(x = 07,08,17: MAJORSE1xTARDIF_R);
MAJORSE207TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-7) * TMAJORSE2[00];
MAJORSE208TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-8) * TMAJORSE2[00];
MAJORSE217TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-17) * TMAJORSE2[00];
MAJORSE2TARDIF_R = somme(x = 07,08,17: MAJORSE2xTARDIF_R);
MAJORSE307TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-7) * TMAJORSE3[00];
MAJORSE308TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-8) * TMAJORSE3[00];
MAJORSE317TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-17) * TMAJORSE3[00];
MAJORSE3TARDIF_R = somme(x = 07,08,17: MAJORSE3xTARDIF_R);
MAJORSE407TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-7) * TMAJORSE4[00];
MAJORSE408TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-8) * TMAJORSE4[00];
MAJORSE417TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-17) * TMAJORSE4[00];
MAJORSE4TARDIF_R = somme(x = 07,08,17: MAJORSE4xTARDIF_R);
MAJOTAXA07TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-7) * TMAJOTAXA[00];
MAJOTAXA08TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-8) * TMAJOTAXA[00];
MAJOTA17_1TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-17) * TMAJOTAXA[00];
MAJOTA17_2TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-17) * TMAJOTAXA[00];
MAJOTAXATARDIF_R = somme(x = 07,08: MAJOTAXA0xTARDIF_R) 
		+ MAJOTA17_1TARDIF_R + MAJOTA17_2TARDIF_R;
MAJOHR07TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-7) * TMAJOHR[00];
MAJOHR08TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-8) * TMAJOHR[00];
MAJOHR17_1TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-17) * TMAJOHR[00];
MAJOHR17_2TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-17) * TMAJOHR[00];
MAJOHRTARDIF_R = somme(x = 07,08: MAJOHR0xTARDIF_R) 
		+ MAJOHR17_1TARDIF_R + MAJOHR17_2TARDIF_R;
MAJOCAP07TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-7) * TMAJOCAP[00];
MAJOCAP08TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-8) * TMAJOCAP[00];
MAJOCP17_1TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-17) * TMAJOCAP[00];
MAJOCP17_2TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-17) * TMAJOCAP[00];
MAJOCAPTARDIF_R = somme(x = 07,08: MAJOCAP0xTARDIF_R) 
		+ MAJOCP17_1TARDIF_R + MAJOCP17_2TARDIF_R;
regle corrective 231142:
application : iliad;
FLAG_TRTARDIF_F = FLAG_RETARD * positif(FLAG_TRDEGTR);
MAJOIR07TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 7) * arr(IRNIN * TAUX_2042/100);
MAJOIR08TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 8) * arr(IRNIN * TAUX_2042/100);
MAJOIR17_1TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 17) * arr(IRNIN * TAUX_2042/100);
MAJOIR17_2TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 17) * arr(IRNIN * TX1758A/100);




MAJOIRTARDIF_F = somme(x = 07,08: MAJOIR0xTARDIF_F) 
		+ MAJOIR17_1TARDIF_F + MAJOIR17_2TARDIF_F;
MAJOCS07TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 7) * arr(CSBASE_MAJO * TAUX_2042/100);
MAJOCS08TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 8) * arr(CSBASE_MAJO * TAUX_2042/100);
MAJOCS17TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 17) * arr(CSBASE_MAJO * TAUX_2042/100);
MAJOCSTARDIF_F = somme(x = 07,08,17: MAJOCSxTARDIF_F);
MAJOPS07TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 7) * arr(PSBASE_MAJO * TAUX_2042/100);
MAJOPS08TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 8) * arr(PSBASE_MAJO * TAUX_2042/100);
MAJOPS17TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 17) * arr(PSBASE_MAJO * TAUX_2042/100);
MAJOPSTARDIF_F = somme(x = 07,08,17: MAJOPSxTARDIF_F);
MAJORD07TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 7) * arr(RDBASE_MAJO * TAUX_2042/100);
MAJORD08TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 8) * arr(RDBASE_MAJO * TAUX_2042/100);
MAJORD17TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 17) * arr(RDBASE_MAJO * TAUX_2042/100);
MAJORDTARDIF_F = somme(x = 07,08,17: MAJORDxTARDIF_F);
MAJOCSAL07TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 7) * arr(CSALBASE_MAJO * TAUX_2042/100);
MAJOCSAL08TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 8) * arr(CSALBASE_MAJO * TAUX_2042/100);
MAJOCSAL17TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 17) * arr(CSALBASE_MAJO * TAUX_2042/100);
MAJOCSALTARDIF_F = somme(x = 07,08,17: MAJOCSALxTARDIF_F);
MAJOCDIS07TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 7) * arr(CDISBASE_MAJO * TAUX_2042/100);
MAJOCDIS08TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 8) * arr(CDISBASE_MAJO * TAUX_2042/100);
MAJOCDIS17TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 17) * arr(CDISBASE_MAJO * TAUX_2042/100);
MAJOCDISTARDIF_F = somme(x = 07,08,17: MAJOCDISxTARDIF_F);
MAJOGAIN07TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 7) * arr(GAINBASE_MAJO * TAUX_2042/100);
MAJOGAIN08TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 8) * arr(GAINBASE_MAJO * TAUX_2042/100);
MAJOGAIN17TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 17) * arr(GAINBASE_MAJO * TAUX_2042/100);
MAJOGAINTARDIF_F = somme(x = 07,08,17: MAJOGAINxTARDIF_F);
MAJORSE107TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 7) * arr(RSE1BASE_MAJO * TAUX_2042/100);
MAJORSE108TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 8) * arr(RSE1BASE_MAJO * TAUX_2042/100);
MAJORSE117TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 17) * arr(RSE1BASE_MAJO * TAUX_2042/100);
MAJORSE1TARDIF_F = somme(x = 07,08,17: MAJORSE1xTARDIF_F);
MAJORSE207TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 7) * arr(RSE2BASE_MAJO * TAUX_2042/100);
MAJORSE208TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 8) * arr(RSE2BASE_MAJO * TAUX_2042/100);
MAJORSE217TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 17) * arr(RSE2BASE_MAJO * TAUX_2042/100);
MAJORSE2TARDIF_F = somme(x = 07,08,17: MAJORSE2xTARDIF_F);
MAJORSE307TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 7) * arr(RSE3BASE_MAJO * TAUX_2042/100);
MAJORSE308TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 8) * arr(RSE3BASE_MAJO * TAUX_2042/100);
MAJORSE317TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 17) * arr(RSE3BASE_MAJO * TAUX_2042/100);
MAJORSE3TARDIF_F = somme(x = 07,08,17: MAJORSE3xTARDIF_F);
MAJORSE407TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 7) * arr(RSE4BASE_MAJO * TAUX_2042/100);
MAJORSE408TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 8) * arr(RSE4BASE_MAJO * TAUX_2042/100);
MAJORSE417TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 17) * arr(RSE4BASE_MAJO * TAUX_2042/100);
MAJORSE4TARDIF_F = somme(x = 07,08,17: MAJORSE4xTARDIF_F);

MAJOTAXA07TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 7) * 
		     arr( TAUX_2042/100 * min(min(TAXABASE2042_FIC,TAXABASE_MAJO), 
		                           max(0, IRBASE + TAXABASE_MAJO)
                                             )
		        );

MAJOTAXA08TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 8) *
		     arr( TAUX_2042/100 * min(min(TAXABASE2042_FIC,TAXABASE_MAJO), 
		                           max(0, IRBASE + TAXABASE_MAJO)
                                             )
		        );

MAJOTA17_1TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 17) * 
		     arr( TAUX_2042/100 * min(min(TAXABASE2042_FIC,TAXABASE_MAJO), 
		                           max(0, IRBASE + TAXABASE_MAJO)
                                             )
                        );

MAJOTA17_2TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 17) * 
		     arr( TX1758A/100 * min(min(TAXABASE2042_FIC,TAXABASE_MAJO), 
		                           max(0, IRBASE + TAXABASE_MAJO)
                                           )

                        );

MAJOTAXATARDIF_F = somme(x = 07,08: MAJOTAXA0xTARDIF_F) 
		+ MAJOTA17_1TARDIF_F + MAJOTA17_2TARDIF_F;
MAJOHR07TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 7) * 
		   arr( TAUX_2042/100 * min(min(HRBASE2042_FIC,HRBASE_MAJO),
                                            max(0, IRBASE+TAXABASE_MAJO+CAPBASE_MAJO+HRBASE_MAJO)
                                           )
                      );

MAJOHR08TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 8) * 
		   arr( TAUX_2042/100 * min(min(HRBASE2042_FIC,HRBASE_MAJO),
                                            max(0, IRBASE+TAXABASE_MAJO+CAPBASE_MAJO+HRBASE_MAJO)
                                           )
                      );


MAJOHR17_1TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 17) * 

		   arr( TAUX_2042/100 * min(min(HRBASE2042_FIC,HRBASE_MAJO),
                                            max(0, IRBASE+TAXABASE_MAJO+CAPBASE_MAJO+HRBASE_MAJO)
                                           )
                      );

MAJOHR17_2TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 17) *
		   arr( TX1758A/100 * min(min(HRBASE2042_FIC,HRBASE_MAJO),
                                            max(0, IRBASE+TAXABASE_MAJO+CAPBASE_MAJO+HRBASE_MAJO)
                                           )
                      );
MAJOHRTARDIF_F = somme(x = 07,08: MAJOHR0xTARDIF_F) 
		+ MAJOHR17_1TARDIF_F + MAJOHR17_2TARDIF_F;
MAJOCAP07TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 7) * 
		    arr( TAUX_2042/100 * min(min(CAPBASE2042_FIC,CAPBASE_MAJO),
                                             max(0, IRBASE + TAXABASE_MAJO + CAPBASE_MAJO)
                                            )
                       );

MAJOCAP08TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 8) * 
		    arr( TAUX_2042/100 * min(min(CAPBASE2042_FIC,CAPBASE_MAJO),
                                             max(0, IRBASE + TAXABASE_MAJO + CAPBASE_MAJO)
                                            )
                       );

MAJOCP17_1TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 17) * 
		     arr( TAUX_2042/100 * min(min(CAPBASE2042_FIC,CAPBASE_MAJO),
                                              max(0, IRBASE + TAXABASE_MAJO + CAPBASE_MAJO)
                                             )
                        );

MAJOCP17_2TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 17) * 
		     arr( TX1758A/100 * min(min(CAPBASE2042_FIC,CAPBASE_MAJO),
                                              max(0, IRBASE + TAXABASE_MAJO + CAPBASE_MAJO)
                                             )
                        );

MAJOCAPTARDIF_F = somme(x = 07,08: MAJOCAP0xTARDIF_F) 
		+ MAJOCP17_1TARDIF_F + MAJOCP17_2TARDIF_F;
regle corrective 231143:
application : iliad;
MAJOIR07TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJOIR07_TARDIF
		    + FLAG_TRTARDIF_R * MAJOIR07TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJOIR07TARDIF_R,MAJOIR07TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJOIRTARDIF_REF, MAJOIR07TARDIF_F))
		    + FLAG_TRMAJOP * MAJOIR07TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJOIR07TARDIF_R
			    + (1 - positif(FLAG_RECTIF)) * MAJOIR07TARDIF_A)
		   ) ;
MAJOIR08TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJOIR08_TARDIF
		    + FLAG_TRTARDIF_R * MAJOIR08TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJOIR08TARDIF_R,MAJOIR08TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJOIRTARDIF_REF, MAJOIR08TARDIF_F))
		    + FLAG_TRMAJOP * MAJOIR08TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJOIR08TARDIF_R
			 + (1 - positif(FLAG_RECTIF)) * MAJOIR08TARDIF_A)
		   ) ;
MAJOIR17_1TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJOIR17_1TARDIF
		    + FLAG_TRTARDIF_R * MAJOIR17_1TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJOIR17_1TARDIF_R,MAJOIR17_1TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJOIRTARDIF_REF/2, MAJOIR17_1TARDIF_F))
		    + FLAG_TRMAJOP * MAJOIR17_1TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJOIR17_1TARDIF_R
			    + (1 - positif(FLAG_RECTIF)) * MAJOIR17_1TARDIF_A)
		   ) ;
MAJOIR17_2TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJOIR17_2TARDIF
		    + FLAG_TRTARDIF_R * MAJOIR17_2TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJOIR17_2TARDIF_R,MAJOIR17_2TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJOIRTARDIF_REF/2, MAJOIR17_2TARDIF_F))
		    + FLAG_TRMAJOP * MAJOIR17_2TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJOIR17_2TARDIF_R
			    + (1 - positif(FLAG_RECTIF)) * MAJOIR17_2TARDIF_A)
		   ) ;
MAJOIRTARDIF_D = somme(x = 07..08: MAJOIR0xTARDIF_D) 
		+ MAJOIR17_1TARDIF_D + MAJOIR17_2TARDIF_D;
MAJOCS07TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJOCS07_TARDIF
		    + FLAG_TRTARDIF_R * MAJOCS07TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJOCS07TARDIF_R,MAJOCS07TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJOCS07TARDIF_A, MAJOCS07TARDIF_F))
		    + FLAG_TRMAJOP * MAJOCS07TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJOCS07TARDIF_R
			    + (1 - positif(FLAG_RECTIF)) * MAJOCS07TARDIF_A)
		   ) ;
MAJOCS08TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJOCS08_TARDIF
		    + FLAG_TRTARDIF_R * MAJOCS08TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJOCS08TARDIF_R,MAJOCS08TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJOCS08TARDIF_A, MAJOCS08TARDIF_F))
		    + FLAG_TRMAJOP * MAJOCS08TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJOCS08TARDIF_R
			 + (1 - positif(FLAG_RECTIF)) * MAJOCS08TARDIF_A)
		   ) ;
MAJOCS17TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJOCS17_TARDIF
		    + FLAG_TRTARDIF_R * MAJOCS17TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJOCS17TARDIF_R,MAJOCS17TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJOCS17TARDIF_A, MAJOCS17TARDIF_F))
		    + FLAG_TRMAJOP * MAJOCS17TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJOCS17TARDIF_R
			    + (1 - positif(FLAG_RECTIF)) * MAJOCS17TARDIF_A)
		   ) ;
MAJOCSTARDIF_D = somme(x = 07,08,17: MAJOCSxTARDIF_D);
MAJOPS07TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJOPS07_TARDIF
		    + FLAG_TRTARDIF_R * MAJOPS07TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJOPS07TARDIF_R,MAJOPS07TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJOPS07TARDIF_A, MAJOPS07TARDIF_F))
		    + FLAG_TRMAJOP * MAJOPS07TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJOPS07TARDIF_R
			    + (1 - positif(FLAG_RECTIF)) * MAJOPS07TARDIF_A)
		   ) ;
MAJOPS08TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJOPS08_TARDIF
		    + FLAG_TRTARDIF_R * MAJOPS08TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJOPS08TARDIF_R,MAJOPS08TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJOPS08TARDIF_A, MAJOPS08TARDIF_F))
		    + FLAG_TRMAJOP * MAJOPS08TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJOPS08TARDIF_R
			 + (1 - positif(FLAG_RECTIF)) * MAJOPS08TARDIF_A)
		   ) ;
MAJOPS17TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJOPS17_TARDIF
		    + FLAG_TRTARDIF_R * MAJOPS17TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJOPS17TARDIF_R,MAJOPS17TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJOPS17TARDIF_A, MAJOPS17TARDIF_F))
		    + FLAG_TRMAJOP * MAJOPS17TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJOPS17TARDIF_R
			    + (1 - positif(FLAG_RECTIF)) * MAJOPS17TARDIF_A)
		   ) ;
MAJOPSTARDIF_D = somme(x = 07,08,17: MAJOPSxTARDIF_D);
MAJORD07TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJORD07_TARDIF
		    + FLAG_TRTARDIF_R * MAJORD07TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJORD07TARDIF_R,MAJORD07TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJORD07TARDIF_A, MAJORD07TARDIF_F))
		    + FLAG_TRMAJOP * MAJORD07TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJORD07TARDIF_R
			    + (1 - positif(FLAG_RECTIF)) * MAJORD07TARDIF_A)
		   ) ;
MAJORD08TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJORD08_TARDIF
		    + FLAG_TRTARDIF_R * MAJORD08TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJORD08TARDIF_R,MAJORD08TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJORD08TARDIF_A, MAJORD08TARDIF_F))
		    + FLAG_TRMAJOP * MAJORD08TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJORD08TARDIF_R
			 + (1 - positif(FLAG_RECTIF)) * MAJORD08TARDIF_A)
		   ) ;
MAJORD17TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJORD17_TARDIF
		    + FLAG_TRTARDIF_R * MAJORD17TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJORD17TARDIF_R,MAJORD17TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJORD17TARDIF_A, MAJORD17TARDIF_F))
		    + FLAG_TRMAJOP * MAJORD17TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJORD17TARDIF_R
			    + (1 - positif(FLAG_RECTIF)) * MAJORD17TARDIF_A)
		   ) ;
MAJORDTARDIF_D = somme(x = 07,08,17: MAJORDxTARDIF_D);
MAJOCSAL07TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJOCSAL07_TARDIF
		    + FLAG_TRTARDIF_R * MAJOCSAL07TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJOCSAL07TARDIF_R,MAJOCSAL07TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJOCSAL07TARDIF_A, MAJOCSAL07TARDIF_F))
		    + FLAG_TRMAJOP * MAJOCSAL07TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJOCSAL07TARDIF_R
			    + (1 - positif(FLAG_RECTIF)) * MAJOCSAL07TARDIF_A)
		   ) ;
MAJOCSAL08TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJOCSAL08_TARDIF
		    + FLAG_TRTARDIF_R * MAJOCSAL08TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJOCSAL08TARDIF_R,MAJOCSAL08TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJOCSAL08TARDIF_A, MAJOCSAL08TARDIF_F))
		    + FLAG_TRMAJOP * MAJOCSAL08TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJOCSAL08TARDIF_R
			 + (1 - positif(FLAG_RECTIF)) * MAJOCSAL08TARDIF_A)
		   ) ;
MAJOCSAL17TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJOCSAL17_TARDIF
		    + FLAG_TRTARDIF_R * MAJOCSAL17TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJOCSAL17TARDIF_R,MAJOCSAL17TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJOCSAL17TARDIF_A, MAJOCSAL17TARDIF_F))
		    + FLAG_TRMAJOP * MAJOCSAL17TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJOCSAL17TARDIF_R
			    + (1 - positif(FLAG_RECTIF)) * MAJOCSAL17TARDIF_A)
		   ) ;
MAJOCSALTARDIF_D = somme(x = 07,08,17: MAJOCSALxTARDIF_D);
MAJOGAIN07TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJOGAIN07_TARDIF
		    + FLAG_TRTARDIF_R * MAJOGAIN07TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJOGAIN07TARDIF_R,MAJOGAIN07TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJOGAIN07TARDIF_A, MAJOGAIN07TARDIF_F))
		    + FLAG_TRMAJOP * MAJOGAIN07TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJOGAIN07TARDIF_R
			    + (1 - positif(FLAG_RECTIF)) * MAJOGAIN07TARDIF_A)
		   ) ;
MAJOGAIN08TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJOGAIN08_TARDIF
		    + FLAG_TRTARDIF_R * MAJOGAIN08TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJOGAIN08TARDIF_R,MAJOGAIN08TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJOGAIN08TARDIF_A, MAJOGAIN08TARDIF_F))
		    + FLAG_TRMAJOP * MAJOGAIN08TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJOGAIN08TARDIF_R
			 + (1 - positif(FLAG_RECTIF)) * MAJOGAIN08TARDIF_A)
		   ) ;
MAJOGAIN17TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJOGAIN17_TARDIF
		    + FLAG_TRTARDIF_R * MAJOGAIN17TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJOGAIN17TARDIF_R,MAJOGAIN17TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJOGAIN17TARDIF_A, MAJOGAIN17TARDIF_F))
		    + FLAG_TRMAJOP * MAJOGAIN17TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJOGAIN17TARDIF_R
			    + (1 - positif(FLAG_RECTIF)) * MAJOGAIN17TARDIF_A)
		   ) ;
MAJOGAINTARDIF_D = somme(x = 07,08,17: MAJOGAINxTARDIF_D);
MAJOCDIS07TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJOCDIS07_TARDIF
		    + FLAG_TRTARDIF_R * MAJOCDIS07TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJOCDIS07TARDIF_R,MAJOCDIS07TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJOCDIS07TARDIF_A, MAJOCDIS07TARDIF_F))
		    + FLAG_TRMAJOP * MAJOCDIS07TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJOCDIS07TARDIF_R
			    + (1 - positif(FLAG_RECTIF)) * MAJOCDIS07TARDIF_A)
		   ) ;
MAJOCDIS08TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJOCDIS08_TARDIF
		    + FLAG_TRTARDIF_R * MAJOCDIS08TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJOCDIS08TARDIF_R,MAJOCDIS08TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJOCDIS08TARDIF_A, MAJOCDIS08TARDIF_F))
		    + FLAG_TRMAJOP * MAJOCDIS08TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJOCDIS08TARDIF_R
			 + (1 - positif(FLAG_RECTIF)) * MAJOCDIS08TARDIF_A)
		   ) ;
MAJOCDIS17TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJOCDIS17_TARDIF
		    + FLAG_TRTARDIF_R * MAJOCDIS17TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJOCDIS17TARDIF_R,MAJOCDIS17TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJOCDIS17TARDIF_A, MAJOCDIS17TARDIF_F))
		    + FLAG_TRMAJOP * MAJOCDIS17TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJOCDIS17TARDIF_R
			    + (1 - positif(FLAG_RECTIF)) * MAJOCDIS17TARDIF_A)
		   ) ;
MAJOCDISTARDIF_D = somme(x = 07,08,17: MAJOCDISxTARDIF_D);
MAJORSE107TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJORSE107_TARDIF
		    + FLAG_TRTARDIF_R * MAJORSE107TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJORSE107TARDIF_R,MAJORSE107TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJORSE107TARDIF_A, MAJORSE107TARDIF_F))
		    + FLAG_TRMAJOP * MAJORSE107TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJORSE107TARDIF_R
			    + (1 - positif(FLAG_RECTIF)) * MAJORSE107TARDIF_A)
		   ) ;
MAJORSE108TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJORSE108_TARDIF
		    + FLAG_TRTARDIF_R * MAJORSE108TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJORSE108TARDIF_R,MAJORSE108TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJORSE108TARDIF_A, MAJORSE108TARDIF_F))
		    + FLAG_TRMAJOP * MAJORSE108TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJORSE108TARDIF_R
			 + (1 - positif(FLAG_RECTIF)) * MAJORSE108TARDIF_A)
		   ) ;
MAJORSE117TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJORSE117_TARDIF
		    + FLAG_TRTARDIF_R * MAJORSE117TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJORSE117TARDIF_R,MAJORSE117TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJORSE117TARDIF_A, MAJORSE117TARDIF_F))
		    + FLAG_TRMAJOP * MAJORSE117TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJORSE117TARDIF_R
			    + (1 - positif(FLAG_RECTIF)) * MAJORSE117TARDIF_A)
		   ) ;
MAJORSE1TARDIF_D = somme(x = 07,08,17: MAJORSE1xTARDIF_D);
MAJORSE207TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJORSE207_TARDIF
		    + FLAG_TRTARDIF_R * MAJORSE207TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJORSE207TARDIF_R,MAJORSE207TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJORSE207TARDIF_A, MAJORSE207TARDIF_F))
		    + FLAG_TRMAJOP * MAJORSE207TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJORSE207TARDIF_R
			    + (1 - positif(FLAG_RECTIF)) * MAJORSE207TARDIF_A)
		   ) ;
MAJORSE208TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJORSE208_TARDIF
		    + FLAG_TRTARDIF_R * MAJORSE208TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJORSE208TARDIF_R,MAJORSE208TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJORSE208TARDIF_A, MAJORSE208TARDIF_F))
		    + FLAG_TRMAJOP * MAJORSE208TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJORSE208TARDIF_R
			 + (1 - positif(FLAG_RECTIF)) * MAJORSE208TARDIF_A)
		   ) ;
MAJORSE217TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJORSE217_TARDIF
		    + FLAG_TRTARDIF_R * MAJORSE217TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJORSE217TARDIF_R,MAJORSE217TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJORSE217TARDIF_A, MAJORSE217TARDIF_F))
		    + FLAG_TRMAJOP * MAJORSE217TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJORSE217TARDIF_R
			    + (1 - positif(FLAG_RECTIF)) * MAJORSE217TARDIF_A)
		   ) ;
MAJORSE2TARDIF_D = somme(x = 07,08,17: MAJORSE2xTARDIF_D);
MAJORSE307TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJORSE307_TARDIF
		    + FLAG_TRTARDIF_R * MAJORSE307TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJORSE307TARDIF_R,MAJORSE307TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJORSE307TARDIF_A, MAJORSE307TARDIF_F))
		    + FLAG_TRMAJOP * MAJORSE307TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJORSE307TARDIF_R
			    + (1 - positif(FLAG_RECTIF)) * MAJORSE307TARDIF_A)
		   ) ;
MAJORSE308TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJORSE308_TARDIF
		    + FLAG_TRTARDIF_R * MAJORSE308TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJORSE308TARDIF_R,MAJORSE308TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJORSE308TARDIF_A, MAJORSE308TARDIF_F))
		    + FLAG_TRMAJOP * MAJORSE308TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJORSE308TARDIF_R
			 + (1 - positif(FLAG_RECTIF)) * MAJORSE308TARDIF_A)
		   ) ;
MAJORSE317TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJORSE317_TARDIF
		    + FLAG_TRTARDIF_R * MAJORSE317TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJORSE317TARDIF_R,MAJORSE317TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJORSE317TARDIF_A, MAJORSE317TARDIF_F))
		    + FLAG_TRMAJOP * MAJORSE317TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJORSE317TARDIF_R
			    + (1 - positif(FLAG_RECTIF)) * MAJORSE317TARDIF_A)
		   ) ;
MAJORSE3TARDIF_D = somme(x = 07,08,17: MAJORSE3xTARDIF_D);
MAJORSE407TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJORSE407_TARDIF
		    + FLAG_TRTARDIF_R * MAJORSE407TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJORSE407TARDIF_R,MAJORSE407TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJORSE407TARDIF_A, MAJORSE407TARDIF_F))
		    + FLAG_TRMAJOP * MAJORSE407TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJORSE407TARDIF_R
			    + (1 - positif(FLAG_RECTIF)) * MAJORSE407TARDIF_A)
		   ) ;
MAJORSE408TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJORSE408_TARDIF
		    + FLAG_TRTARDIF_R * MAJORSE408TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJORSE408TARDIF_R,MAJORSE408TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJORSE408TARDIF_A, MAJORSE408TARDIF_F))
		    + FLAG_TRMAJOP * MAJORSE408TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJORSE408TARDIF_R
			 + (1 - positif(FLAG_RECTIF)) * MAJORSE408TARDIF_A)
		   ) ;
MAJORSE417TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJORSE417_TARDIF
		    + FLAG_TRTARDIF_R * MAJORSE417TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJORSE417TARDIF_R,MAJORSE417TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJORSE417TARDIF_A, MAJORSE417TARDIF_F))
		    + FLAG_TRMAJOP * MAJORSE417TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJORSE417TARDIF_R
			    + (1 - positif(FLAG_RECTIF)) * MAJORSE417TARDIF_A)
		   ) ;
MAJORSE4TARDIF_D = somme(x = 07,08,17: MAJORSE4xTARDIF_D);
MAJOTAXA07TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJOTAXA07_TARDIF
		    + FLAG_TRTARDIF_R * MAJOTAXA07TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJOTAXA07TARDIF_R,MAJOTAXA07TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJOTAXA07TARDIF_A, MAJOTAXA07TARDIF_F))
		    + FLAG_TRMAJOP * MAJOTAXA07TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJOTAXA07TARDIF_R
			    + (1 - positif(FLAG_RECTIF)) * MAJOTAXA07TARDIF_A)
		   ) ;
MAJOTAXA08TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJOTAXA08_TARDIF
		    + FLAG_TRTARDIF_R * MAJOTAXA08TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJOTAXA08TARDIF_R,MAJOTAXA08TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJOTAXA08TARDIF_A, MAJOTAXA08TARDIF_F))
		    + FLAG_TRMAJOP * MAJOTAXA08TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJOTAXA08TARDIF_R
			 + (1 - positif(FLAG_RECTIF)) * MAJOTAXA08TARDIF_A)
		   ) ;
MAJOTA17_1TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJOTA17_1TARDIF
		    + FLAG_TRTARDIF_R * MAJOTA17_1TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJOTA17_1TARDIF_R,MAJOTA17_1TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJOTA17_1TARDIF_A, MAJOTA17_1TARDIF_F))
		    + FLAG_TRMAJOP * MAJOTA17_1TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJOTA17_1TARDIF_R
			    + (1 - positif(FLAG_RECTIF)) * MAJOTA17_1TARDIF_A)
		   ) ;
MAJOTA17_2TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJOTA17_2TARDIF
		    + FLAG_TRTARDIF_R * MAJOTA17_2TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJOTA17_2TARDIF_R,MAJOTA17_2TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJOTA17_2TARDIF_A, MAJOTA17_2TARDIF_F))
		    + FLAG_TRMAJOP * MAJOTA17_2TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJOTA17_2TARDIF_R
			    + (1 - positif(FLAG_RECTIF)) * MAJOTA17_2TARDIF_A)
		   ) ;
MAJOTAXATARDIF_D = somme(x = 07,08: MAJOTAXA0xTARDIF_D) 
		+ MAJOTA17_1TARDIF_D + MAJOTA17_2TARDIF_D;
MAJOHR07TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJOHR07_TARDIF
		    + FLAG_TRTARDIF_R * MAJOHR07TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJOHR07TARDIF_R,MAJOHR07TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJOHR07TARDIF_A, MAJOHR07TARDIF_F))
		    + FLAG_TRMAJOP * MAJOHR07TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJOHR07TARDIF_R
			    + (1 - positif(FLAG_RECTIF)) * MAJOHR07TARDIF_A)
		   ) ;
MAJOHR08TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJOHR08_TARDIF
		    + FLAG_TRTARDIF_R * MAJOHR08TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJOHR08TARDIF_R,MAJOHR08TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJOHR08TARDIF_A, MAJOHR08TARDIF_F))
		    + FLAG_TRMAJOP * MAJOHR08TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJOHR08TARDIF_R
			 + (1 - positif(FLAG_RECTIF)) * MAJOHR08TARDIF_A)
		   ) ;
MAJOHR17_1TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJOHR17_1TARDIF
		    + FLAG_TRTARDIF_R * MAJOHR17_1TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJOHR17_1TARDIF_R,MAJOHR17_1TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJOHR17_1TARDIF_A, MAJOHR17_1TARDIF_F))
		    + FLAG_TRMAJOP * MAJOHR17_1TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJOHR17_1TARDIF_R
			    + (1 - positif(FLAG_RECTIF)) * MAJOHR17_1TARDIF_A)
		   ) ;
MAJOHR17_2TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJOHR17_2TARDIF
		    + FLAG_TRTARDIF_R * MAJOHR17_2TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJOHR17_2TARDIF_R,MAJOHR17_2TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJOHR17_2TARDIF_A, MAJOHR17_2TARDIF_F))
		    + FLAG_TRMAJOP * MAJOHR17_2TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJOHR17_2TARDIF_R
			    + (1 - positif(FLAG_RECTIF)) * MAJOHR17_2TARDIF_A)
		   ) ;
MAJOHRTARDIF_D = somme(x = 07,08: MAJOHR0xTARDIF_D) 
		+ MAJOHR17_1TARDIF_D + MAJOHR17_2TARDIF_D;
MAJOCAP07TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJOCAP07_TARDIF
		    + FLAG_TRTARDIF_R * MAJOCAP07TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJOCAP07TARDIF_R,MAJOCAP07TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJOCAP07TARDIF_A, MAJOCAP07TARDIF_F))
		    + FLAG_TRMAJOP * MAJOCAP07TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJOCAP07TARDIF_R
			    + (1 - positif(FLAG_RECTIF)) * MAJOCAP07TARDIF_A)
		   ) ;
MAJOCAP08TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJOCAP08_TARDIF
		    + FLAG_TRTARDIF_R * MAJOCAP08TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJOCAP08TARDIF_R,MAJOCAP08TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJOCAP08TARDIF_A, MAJOCAP08TARDIF_F))
		    + FLAG_TRMAJOP * MAJOCAP08TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJOCAP08TARDIF_R
			 + (1 - positif(FLAG_RECTIF)) * MAJOCAP08TARDIF_A)
		   ) ;
MAJOCP17_1TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJOCAP17_1TARDIF
		    + FLAG_TRTARDIF_R * MAJOCP17_1TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJOCP17_1TARDIF_R,MAJOCP17_1TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJOCP17_1TARDIF_A, MAJOCP17_1TARDIF_F))
		    + FLAG_TRMAJOP * MAJOCP17_1TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJOCP17_1TARDIF_R
			    + (1 - positif(FLAG_RECTIF)) * MAJOCP17_1TARDIF_A)
		   ) ;
MAJOCP17_2TARDIF_D = FLAG_RETARD *
		    (FLAG_TRTARDIF * MAJOCAP17_2TARDIF
		    + FLAG_TRTARDIF_R * MAJOCP17_2TARDIF_R
		    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJOCP17_2TARDIF_R,MAJOCP17_2TARDIF_F)
					 + (1 - positif(FLAG_RECTIF)) * min(MAJOCP17_2TARDIF_A, MAJOCP17_2TARDIF_F))
		    + FLAG_TRMAJOP * MAJOCP17_2TARDIF_A
		    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP)) 
			  * (positif(FLAG_RECTIF) * MAJOCP17_2TARDIF_R
			    + (1 - positif(FLAG_RECTIF)) * MAJOCP17_2TARDIF_A)
		   ) ;
MAJOCAPTARDIF_D = somme(x = 07,08: MAJOCAP0xTARDIF_D) 
		+ MAJOCP17_1TARDIF_D + MAJOCP17_2TARDIF_D;
regle isf 235:
application : iliad;
MAJOISF07TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-7) * TMAJOISF[00];
MAJOISF08TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-8) * TMAJOISF[00];
MAJOISF17TARDIF_R = FLAG_RETARD * FLAG_RECTIF * null(CSTRATE99-17) * TMAJOISF[00];
MAJOISFTARDIF_R = somme(x = 07,08,17: MAJOISFxTARDIF_R);
MAJOISF07TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 7) * arr(ISF4BASE * TAUX_2042/100);
MAJOISF08TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 8) * arr(ISF4BASE * TAUX_2042/100);
MAJOISF17TARDIF_F = FLAG_RETARD * null(FLAG_TRDEGTR - 17) * arr(ISF4BASE * TAUX_2042/100);
MAJOISFTARDIF_F = somme(x = 07,08,17: MAJOISFxTARDIF_F);
MAJOISF07TARDIF_D = FLAG_RETARD *
		   (FLAG_TRTARDIF * MAJOISF07_TARDIF
		   + FLAG_TRTARDIF_R * MAJOISF07TARDIF_R
		   + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJOISF07TARDIF_R,MAJOISF07TARDIF_F)
 		   + (1 - positif(FLAG_RECTIF)) * min(MAJOISF07TARDIF_A, MAJOISF07TARDIF_F))
 		   + FLAG_TRMAJOP * MAJOISF07TARDIF_A
 		   + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP))
		       * (positif(FLAG_RECTIF) * MAJOISF07TARDIF_R
                           + (1 - positif(FLAG_RECTIF)) * MAJOISF07TARDIF_A)
                   ) ;
MAJOISF08TARDIF_D = FLAG_RETARD *
                    (FLAG_TRTARDIF * MAJOISF08_TARDIF
                   + FLAG_TRTARDIF_R * MAJOISF08TARDIF_R
                   + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJOISF08TARDIF_R,MAJOISF08TARDIF_F)
                                         + (1 - positif(FLAG_RECTIF)) * min(MAJOISF08TARDIF_A, MAJOISF08TARDIF_F))
                   + FLAG_TRMAJOP * MAJOISF08TARDIF_A
                   + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP))
                        * (positif(FLAG_RECTIF) * MAJOISF08TARDIF_R
                           + (1 - positif(FLAG_RECTIF)) * MAJOISF08TARDIF_A)
                    ) ;


MAJOISF17TARDIF_D = FLAG_RETARD *
                    (FLAG_TRTARDIF * MAJOISF17_TARDIF
		    + FLAG_TRTARDIF_R * MAJOISF17TARDIF_R
                    + FLAG_TRTARDIF_F * ( positif(FLAG_RECTIF) * min(MAJOISF17TARDIF_R,MAJOISF17TARDIF_F)
		                          + (1 - positif(FLAG_RECTIF)) * min(MAJOISF17TARDIF_A, MAJOISF17TARDIF_F))
                    + FLAG_TRMAJOP * MAJOISF17TARDIF_A
                    + (1 - positif(FLAG_TRTARDIF + FLAG_TRTARDIF_R + FLAG_TRTARDIF_F + FLAG_TRMAJOP))
			   * (positif(FLAG_RECTIF) * MAJOISF17TARDIF_R
                               + (1 - positif(FLAG_RECTIF)) * MAJOISF17TARDIF_A)
		    ) ;


MAJOISFTARDIF_D = somme(x = 07,08,17: MAJOISFxTARDIF_D);
regle corrective 10941:
application : iliad;
TIRBASE[0] =   positif(FLAG_RETARD) *
                   (IRBASE_REF * (1 - positif(FLAG_NBSTRTR))
                   + TIRBASE[0] * positif(FLAG_NBSTRTR))
              + (1 - positif(FLAG_RETARD)) * TIRBASE[0]  + 0 
                ;
TNAPCR[0] =   positif(FLAG_RETARD) *
                   (NAPCRTARDIF_A * (1 - positif(FLAG_NBSTRTR))
                   + TNAPCR[0] * positif(FLAG_NBSTRTR))
              + (1 - positif(FLAG_RETARD)) * TNAPCR[0] + 0 
                ;
TCSBASE[0] =   positif(FLAG_RETARD) *
                   (CSGTARDIF_A * (1 - positif(FLAG_NBSTRTR))
                   + TCSBASE[0] * positif(FLAG_NBSTRTR))
              + (1 - positif(FLAG_RETARD)) * TCSBASE[0] + 0 
                ;
TPSBASE[0] =   positif(FLAG_RETARD) *
                   (PRSTARDIF_A * (1 - positif(FLAG_NBSTRTR))
                   + TPSBASE[0] * positif(FLAG_NBSTRTR))
              + (1 - positif(FLAG_RETARD)) * TPSBASE[0] + 0 
                ;
TRDBASE[0] =   positif(FLAG_RETARD) *
                   (RDSTARDIF_A * (1 - positif(FLAG_NBSTRTR))
                   + TRDBASE[0] * positif(FLAG_NBSTRTR))
              + (1 - positif(FLAG_RETARD)) * TRDBASE[0] + 0 
                ;
TCSALBASE[0] =   positif(FLAG_RETARD) *
                   (CSALTARDIF_A * (1 - positif(FLAG_NBSTRTR))
                   + TCSALBASE[0] * positif(FLAG_NBSTRTR))
              + (1 - positif(FLAG_RETARD)) * TCSALBASE[0] + 0 
                ;
TGAINBASE[0] =   positif(FLAG_RETARD) *
                   (GAINTARDIF_A * (1 - positif(FLAG_NBSTRTR))
                   + TGAINBASE[0] * positif(FLAG_NBSTRTR))
              + (1 - positif(FLAG_RETARD)) * TGAINBASE[0] + 0 
                ;
TCDISBASE[0] =   positif(FLAG_RETARD) *
                   (CDISTARDIF_A * (1 - positif(FLAG_NBSTRTR))
                   + TCDISBASE[0] * positif(FLAG_NBSTRTR))
              + (1 - positif(FLAG_RETARD)) * TCDISBASE[0] + 0 
                ;
TRSE1BASE[0] =   positif(FLAG_RETARD) *
                   (RSE1TARDIF_A * (1 - positif(FLAG_NBSTRTR))
                   + TRSE1BASE[0] * positif(FLAG_NBSTRTR))
              + (1 - positif(FLAG_RETARD)) * TRSE1BASE[0] + 0 
                ;
TRSE2BASE[0] =   positif(FLAG_RETARD) *
                   (RSE2TARDIF_A * (1 - positif(FLAG_NBSTRTR))
                   + TRSE2BASE[0] * positif(FLAG_NBSTRTR))
              + (1 - positif(FLAG_RETARD)) * TRSE2BASE[0] + 0 
                ;
TRSE3BASE[0] =   positif(FLAG_RETARD) *
                   (RSE3TARDIF_A * (1 - positif(FLAG_NBSTRTR))
                   + TRSE3BASE[0] * positif(FLAG_NBSTRTR))
              + (1 - positif(FLAG_RETARD)) * TRSE3BASE[0] + 0 
                ;
TRSE4BASE[0] =   positif(FLAG_RETARD) *
                   (RSE4TARDIF_A * (1 - positif(FLAG_NBSTRTR))
                   + TRSE4BASE[0] * positif(FLAG_NBSTRTR))
              + (1 - positif(FLAG_RETARD)) * TRSE4BASE[0] + 0 
                ;
TTAXABASE[0] =  positif(FLAG_RETARD) *
                   (TAXATARDIF_A * (1 - positif(FLAG_NBSTRTR))
                   + TTAXABASE[0] * positif(FLAG_NBSTRTR))
              + (1 - positif(FLAG_RETARD)) * TTAXABASE[0] + 0 
                ;
TCHRBASE[0] =  positif(FLAG_RETARD) *
                   (HRTARDIF_A * (1 - positif(FLAG_NBSTRTR))
                   + TCHRBASE[0] * positif(FLAG_NBSTRTR))
              + (1 - positif(FLAG_RETARD)) * TCHRBASE[0] + 0 
                ;
TPCAPBASE[0] =  positif(FLAG_RETARD) *
                   (CAPTARDIF_A * (1 - positif(FLAG_NBSTRTR))
                   + TPCAPBASE[0] * positif(FLAG_NBSTRTR))
              + (1 - positif(FLAG_RETARD)) * TPCAPBASE[0] + 0 
                ;

TISF4BASE[0] =   positif(FLAG_RETARD) *
                  (ISFTARDIF_A * (1 - positif(FLAG_NBSTRTR))
                   + TISF4BASE[0] * positif(FLAG_NBSTRTR))
              + (1 - positif(FLAG_RETARD)) * TISF4BASE[0] + 0
                ;

regle corrective 23115:
application : iliad;
pour x = 07,08,10,11,17,31:
PROPIRx = arr((T_RABPx / T_RABP) * 10000)/10000 
        * FLAG_TRMAJOP ;
pour x = 07,08,10,11,17,31:
PROPCSx = arr((T_RABPCSx / T_RABPCS) * 10000)/10000 
        * FLAG_TRMAJOP  + 0 ;
pour x = 07,08,10,11,17,31:
PROPRDx = arr((T_RABPRDx / T_RABPRD) * 10000)/10000 
        * FLAG_TRMAJOP ;
pour x = 07,08,10,11,17,31:
PROPPSx = arr((T_RABPPSx / T_RABPPS) * 10000)/10000 
        * FLAG_TRMAJOP ;
regle corrective 23116:
application : iliad;
pour x = 08,11,31:
MAJOIR_Px = arr( max(0,IRNIN) * PROPIRx * Tx/100)
         * FLAG_TRMAJOP ;
pour x = 08,11,31:
MAJOCS_Px = arr( max(0,CSG) * PROPCSx * Tx/100)
         * FLAG_TRMAJOP ;
pour x = 08,11,31:
MAJORD_Px = arr( max(0,RDSN) * PROPRDx * Tx/100)
         * FLAG_TRMAJOP ;
pour x = 08,11,31:
MAJOPS_Px = arr( max(0,PRS) * PROPPSx * Tx/100)
         * FLAG_TRMAJOP ;
regle corrective 23117:
application : iliad;
MAJOIR_P07 = arr( max(0,IRNIN) * PROPIR07 * T07/100)
	 * (1 - null((1 -IND_RJLJ) + (10 - T07)))
         * FLAG_TRMAJOP;
MAJOIR_P10_1 = arr( max(0,IRNIN) * PROPIR10 * T10/100)
	 * (1 - null((1 -IND_RJLJ) + (10 - T10)))
         * FLAG_TRMAJOP;
MAJOIR_P10_2 = arr( max(0,IRNIN) * PROPIR10 * TX1758A/100)
	 * (1 - null((1 -IND_RJLJ) + (10 - TX1758A)))
         * FLAG_TRMAJOP;
MAJOIR_P17_1 = arr( max(0,IRNIN) * PROPIR17 * T17/100)
	 * (1 - null((1 -IND_RJLJ) + (10 - T17)))
         * FLAG_TRMAJOP;
MAJOIR_P17_2 = arr( max(0,IRNIN) * PROPIR17 * TX1758A/100)
	 * (1 - null((1 -IND_RJLJ) + (10 - TX1758A)))
         * FLAG_TRMAJOP;
pour x = 07,10,17:
MAJOCS_Px = arr( max(0,CSG) * PROPCSx * Tx/100)
	 * (1 - null((1 -IND_RJLJ) + (10 - Tx)))
         * FLAG_TRMAJOP;
pour x = 07,10,17:
MAJORD_Px = arr( max(0,RDSN) * PROPRDx * Tx/100)
	 * (1 - null((1 -IND_RJLJ) + (10 - Tx)))
         * FLAG_TRMAJOP;
pour x = 07,10,17:
MAJOPS_Px = arr( max(0,PRS) * PROPPSx * Tx/100)
	 * (1 - null((1 -IND_RJLJ) + (10 - Tx)))
         * FLAG_TRMAJOP;
regle corrective 231171:
application : iliad;
IRNIN_MAJOP = IRBASE * FLAG_TRMAJOP ;
CSG_MAJOP = CSBASE_MAJO * FLAG_TRMAJOP ;
RDS_MAJOP = RDBASE_MAJO * FLAG_TRMAJOP;
PRS_MAJOP = PSBASE_MAJO * FLAG_TRMAJOP;
regle corrective 23118:
application : iliad;
PROPIR = somme(i=07,08,10,11,17,31 : PROPIRi)
		* FLAG_TRMAJOP
		* FLAG_RETARD ;
PROPCS = somme(i=07,08,10,11,17,31 : PROPCSi)
		* FLAG_TRMAJOP
		* FLAG_RETARD ;
PROPRD = somme(i=07,08,10,11,17,31 : PROPRDi)
		* FLAG_TRMAJOP
		* FLAG_RETARD ;
PROPPS = somme(i=07,08,10,11,17,31 : PROPPSi)
		* FLAG_TRMAJOP
		* FLAG_RETARD ;
regle corrective 231181:
application :  iliad;
MAJOIR07TARDIF_P =  arr(MAJOIR07TARDIF_D * (1 - PROPIR_A))
		* FLAG_TRTARDIF_F
		* FLAG_RETARD 
		* positif(PROPIR_A) ;

MAJOIR08TARDIF_P =  arr(MAJOIR08TARDIF_D * (1 - PROPIR_A))
		* FLAG_TRTARDIF_F
		* FLAG_RETARD 
		* positif(PROPIR_A)
		+ 0;
MAJOIR17_1TARDIF_P =  arr(MAJOIR17_1TARDIF_D * (1 - PROPIR_A))
		* FLAG_TRTARDIF_F
		* FLAG_RETARD 
		* positif(PROPIR_A) ;
MAJOIR17_2TARDIF_P =  arr(MAJOIR17_2TARDIF_D * (1 - PROPIR_A))
		* FLAG_TRTARDIF_F
		* FLAG_RETARD 
		* positif(PROPIR_A) ;


MAJOIRTARDIF_P = somme (x = 07,08 : MAJOIR0xTARDIF_P) 
		  + MAJOIR17_1TARDIF_P + MAJOIR17_2TARDIF_P;
MAJOCS07TARDIF_P =  arr(MAJOCS07TARDIF_D * (1 - PROPCS_A))
		* FLAG_TRTARDIF_F
		* FLAG_RETARD 
		* positif(PROPCS_A);
MAJOCS08TARDIF_P =  arr(MAJOCS08TARDIF_D * (1 - PROPCS_A))
		* FLAG_TRTARDIF_F
		* FLAG_RETARD 
		* positif(PROPCS_A);
MAJOCS17TARDIF_P =  arr(MAJOCS17TARDIF_D * (1 - PROPCS_A))
		* FLAG_TRTARDIF_F
		* FLAG_RETARD 
		* positif(PROPCS_A);
MAJOCSTARDIF_P = somme (x = 07,08,17 : MAJOCSxTARDIF_P);
MAJORD07TARDIF_P =  arr(MAJORD07TARDIF_D * (1 - PROPRD_A))
		* FLAG_TRTARDIF_F
		* FLAG_RETARD 
		* positif(PROPRD_A);
MAJORD08TARDIF_P =  arr(MAJORD08TARDIF_D * (1 - PROPRD_A))
		* FLAG_TRTARDIF_F
		* FLAG_RETARD 
		* positif(PROPRD_A);
MAJORD17TARDIF_P =  arr(MAJORD17TARDIF_D * (1 - PROPRD_A))
		* FLAG_TRTARDIF_F
		* FLAG_RETARD 
		* positif(PROPRD_A);
MAJORDTARDIF_P = somme (x = 07,08,17 : MAJORDxTARDIF_P);
MAJOPS07TARDIF_P =  arr(MAJOPS07TARDIF_D * (1 - PROPPS_A))
		* FLAG_TRTARDIF_F
		* FLAG_RETARD 
		* positif(PROPPS_A);
MAJOPS08TARDIF_P =  arr(MAJOPS08TARDIF_D * (1 - PROPPS_A))
		* FLAG_TRTARDIF_F
		* FLAG_RETARD 
		* positif(PROPPS_A);
MAJOPS17TARDIF_P =  arr(MAJOPS17TARDIF_D * (1 - PROPPS_A))
		* FLAG_TRTARDIF_F
		* FLAG_RETARD 
		* positif(PROPPS_A);
MAJOPSTARDIF_P = somme (x = 07,08,17 : MAJOPSxTARDIF_P);
regle corrective 23119:
application :   iliad ;
MAJOTO =  MAJOIR_ST + MAJOPIR_TOT  
	+ FLAG_RETARD * (1 - positif(FLAG_RECTIF)) * MAJOIRTARDIF_A
	+ FLAG_TRTARDIF * MAJOIRTARDIF_D
	+ FLAG_TRTARDIF_F 
	       * (positif(PROPIR_A) * MAJOIRTARDIF_P
	       + (1 - positif(PROPIR_A)) * MAJOIRTARDIF_D)
	- FLAG_TRTARDIF_F * (positif(FLAG_RECTIF) * MAJOIRTARDIF_R
			   + (1 - positif(FLAG_RECTIF)) * MAJOIRTARDIF_A)

        + MAJOCS_ST + MAJOPCS_TOT  
	+ FLAG_RETARD * (1 - positif(FLAG_RECTIF)) * MAJOCSTARDIF_A
	+ FLAG_TRTARDIF * MAJOCSTARDIF_D
	+ FLAG_TRTARDIF_F 
	       * (positif(PROPCS_A) * MAJOCSTARDIF_P
	       + (1 - positif(PROPCS_A)) * MAJOCSTARDIF_D)
	- FLAG_TRTARDIF_F * (positif(FLAG_RECTIF) * MAJOCSTARDIF_R
			   + (1 - positif(FLAG_RECTIF)) * MAJOCSTARDIF_A)

        + MAJOPS_ST + MAJOPPS_TOT  
	+ FLAG_RETARD * (1 - positif(FLAG_RECTIF)) * MAJOPSTARDIF_A
	+ FLAG_TRTARDIF * MAJOPSTARDIF_D
	+ FLAG_TRTARDIF_F 
	       * (positif(PROPPS_A) * MAJOPSTARDIF_P
	       + (1 - positif(PROPPS_A)) * MAJOPSTARDIF_D)
	- FLAG_TRTARDIF_F * (positif(FLAG_RECTIF) * MAJOPSTARDIF_R
			   + (1 - positif(FLAG_RECTIF)) * MAJOPSTARDIF_A)

        + MAJORD_ST + MAJOPRD_TOT  
	+ FLAG_RETARD * (1 - positif(FLAG_RECTIF)) * MAJORDTARDIF_A
	+ FLAG_TRTARDIF * MAJORDTARDIF_D
	+ FLAG_TRTARDIF_F 
	       * (positif(PROPRD_A) * MAJORDTARDIF_P
	       + (1 - positif(PROPRD_A)) * MAJORDTARDIF_D)
	- FLAG_TRTARDIF_F * (positif(FLAG_RECTIF) * MAJORDTARDIF_R
			   + (1 - positif(FLAG_RECTIF)) * MAJORDTARDIF_A)

        + MAJOCSAL_ST 
	+ FLAG_RETARD * (1 - positif(FLAG_RECTIF)) * MAJOCSALTARDIF_A
	+ FLAG_TRTARDIF * MAJOCSALTARDIF_D
	+ FLAG_TRTARDIF_F * MAJOCSALTARDIF_D
	- FLAG_TRTARDIF_F * (positif(FLAG_RECTIF) * MAJOCSALTARDIF_R
			   + (1 - positif(FLAG_RECTIF)) * MAJOCSALTARDIF_A)

        + MAJOGAIN_ST 
	+ FLAG_RETARD * (1 - positif(FLAG_RECTIF)) * MAJOGAINTARDIF_A
	+ FLAG_TRTARDIF * MAJOGAINTARDIF_D
	+ FLAG_TRTARDIF_F * MAJOGAINTARDIF_D
	- FLAG_TRTARDIF_F * (positif(FLAG_RECTIF) * MAJOGAINTARDIF_R
			   + (1 - positif(FLAG_RECTIF)) * MAJOGAINTARDIF_A)

        + MAJOCDIS_ST 
	+ FLAG_RETARD * (1 - positif(FLAG_RECTIF)) * MAJOCDISTARDIF_A
	+ FLAG_TRTARDIF * MAJOCDISTARDIF_D
	+ FLAG_TRTARDIF_F * MAJOCDISTARDIF_D
	- FLAG_TRTARDIF_F * (positif(FLAG_RECTIF) * MAJOCDISTARDIF_R
			   + (1 - positif(FLAG_RECTIF)) * MAJOCDISTARDIF_A)

        + MAJOTAXA_ST  
	+ FLAG_RETARD * (1 - positif(FLAG_RECTIF)) * MAJOTAXATARDIF_A
	+ FLAG_TRTARDIF * MAJOTAXATARDIF_D
	+ FLAG_TRTARDIF_F * MAJOTAXATARDIF_D
	- FLAG_TRTARDIF_F * (positif(FLAG_RECTIF) * MAJOTAXATARDIF_R
			   + (1 - positif(FLAG_RECTIF)) * MAJOTAXATARDIF_A)


        + MAJOCAP_ST 
	+ FLAG_RETARD * (1 - positif(FLAG_RECTIF)) * MAJOCAPTARDIF_A
	+ FLAG_TRTARDIF * MAJOCAPTARDIF_D
	+ FLAG_TRTARDIF_F * MAJOCAPTARDIF_D
	- FLAG_TRTARDIF_F * (positif(FLAG_RECTIF) * MAJOCAPTARDIF_R
			   + (1 - positif(FLAG_RECTIF)) * MAJOCAPTARDIF_A)


        + MAJORSE1_ST 
	+ FLAG_RETARD * (1 - positif(FLAG_RECTIF)) * MAJORSE1TARDIF_A
	+ FLAG_TRTARDIF * MAJORSE1TARDIF_D
	+ FLAG_TRTARDIF_F * MAJORSE1TARDIF_D
	- FLAG_TRTARDIF_F * (positif(FLAG_RECTIF) * MAJORSE1TARDIF_R
			   + (1 - positif(FLAG_RECTIF)) * MAJORSE1TARDIF_A)


        + MAJORSE2_ST 
	+ FLAG_RETARD * (1 - positif(FLAG_RECTIF)) * MAJORSE2TARDIF_A
	+ FLAG_TRTARDIF * MAJORSE2TARDIF_D
	+ FLAG_TRTARDIF_F * MAJORSE2TARDIF_D
	- FLAG_TRTARDIF_F * (positif(FLAG_RECTIF) * MAJORSE2TARDIF_R
			   + (1 - positif(FLAG_RECTIF)) * MAJORSE2TARDIF_A)


        + MAJORSE3_ST 
	+ FLAG_RETARD * (1 - positif(FLAG_RECTIF)) * MAJORSE3TARDIF_A
	+ FLAG_TRTARDIF * MAJORSE3TARDIF_D
	+ FLAG_TRTARDIF_F * MAJORSE3TARDIF_D
	- FLAG_TRTARDIF_F * (positif(FLAG_RECTIF) * MAJORSE3TARDIF_R
			   + (1 - positif(FLAG_RECTIF)) * MAJORSE3TARDIF_A)


        + MAJORSE4_ST 
	+ FLAG_RETARD * (1 - positif(FLAG_RECTIF)) * MAJORSE4TARDIF_A
	+ FLAG_TRTARDIF * MAJORSE4TARDIF_D
	+ FLAG_TRTARDIF_F * MAJORSE4TARDIF_D
	- FLAG_TRTARDIF_F * (positif(FLAG_RECTIF) * MAJORSE4TARDIF_R
			   + (1 - positif(FLAG_RECTIF)) * MAJORSE4TARDIF_A)


        + MAJOHR_ST 
	+ FLAG_RETARD * (1 - positif(FLAG_RECTIF)) * MAJOHRTARDIF_A
	+ FLAG_TRTARDIF * MAJOHRTARDIF_D
	+ FLAG_TRTARDIF_F * MAJOHRTARDIF_D
	- FLAG_TRTARDIF_F * (positif(FLAG_RECTIF) * MAJOHRTARDIF_R
			   + (1 - positif(FLAG_RECTIF)) * MAJOHRTARDIF_A)

	;


regle corrective 1071:
application : iliad ;
RFDEQ = FLAG_NUNV * (- abs(DRCF)) ;
pour x= 01..12,30,31,55:
RFDEQx = FLAG_NUNV * ( arr(RFDEQ * RBRFx/RBRF) ) ;
regle corrective 23121:
application : iliad;
NARF = FLAG_NUNV * ( RFCG - RFCG_R ) ;
NBRF = FLAG_NUNV * ( -abs(DRFRP) + abs(DRFRP_R) );
NABA = FLAG_NUNV * ( max(0,BANOR) - max(0,BANOR_R) ) ;
NBBA = FLAG_NUNV * ( -abs(DEFBA) + abs(DEFBA_R) );
NALO = FLAG_NUNV * ( BICNPF - BICNPF_R ) ;
NBLO = FLAG_NUNV * ( -abs(DLMRN) + abs(DLMRN_R) );
NANC = FLAG_NUNV * ( BALNP - BALNP_R ) ;
NBNC = FLAG_NUNV * ( -abs(DALNP) + abs(DALNP_R) );
NACO = FLAG_NUNV * ( RNI - RNI_R ) ;
NBCO = FLAG_NUNV * ( -abs(RNIDF) + abs(RNIDF_R) );
regle corrective 23122:
application : iliad ;
pour x=01..12,30,31,55;i=BA,LO,NC:
RNix = FLAG_NUNV * ( arr( RNi * (RBix / RBi) ) );
pour x=01..12,30,31,55:
RNRFx = FLAG_NUNV * ( arr((RNRF-RFDEQ)* RBRFx / RBRF) );
pour x=01..12,30,31,55;i=RF,BA,LO,NC:
NCix = FLAG_NUNV *  RNix ;
regle corrective 23123:
application : iliad;
pour x=01..12,30,31,55;i=RF,BA,LO,NC:
NUiNx = FLAG_NUNV * ( arr (
              positif (NAi + NBi) * ( NCix * (NAi / (NAi + NBi)))
             +
             ( 1 - positif (NAi + NBi)) * NCix   
                   ));
pour x=01..12,30,31,55;i=RF,BA,LO,NC:
NViDx = FLAG_NUNV * ( NCix - NUiNx ) ;
regle corrective 23124:
application : iliad ;
NUTN = somme(x=1..6:somme(t=RF,BA,LO,NC:NUtN0x));
pour x=01..12,30,31,55:
RNCOx = FLAG_NUNV *  arr( (RNCO+RFDEQ+NUTN) * 
   ((RBCOx+RFDEQx+somme(t=RF,BA,LO,NC:NUtNx)) / (RBCO+RFDEQ+NUTN)) ) ;
pour x=01..12,30,31,55:
NCCOx = FLAG_NUNV * RNCOx ;
regle corrective 23125:
application : iliad ;
pour x=01..12,30,31,55:
NUCONx = FLAG_NUNV * ( arr( 
               positif (NACO + NBCO) * (NCCOx * (NACO / (NACO + NBCO)))
               +
              (1 - positif (NACO + NBCO)) * positif_ou_nul (NBCO)* NCCOx 
                    ) ) ;
pour x=01..12,30,31,55:
NVCODx = FLAG_NUNV * ( NCCOx - NUCONx ) ;
pour x=01..12,31,55:
NUTOTx = FLAG_NUNV * ( positif(NUCONx) * NUCONx ) ;
NUTOT30 = FLAG_NUNV *  R1649 ;
NUTOT = FLAG_NUNV * ( somme(t=01..12,30,31,55: NUTOTt) );
regle corrective 23126:
application : iliad ;
pour x=01..12,30,31,55:
NUPTOTx = FLAG_NUNV * (RBPCx + NURFNx);
NUPTOT = FLAG_NUNV * somme(t=01..12,30,31,55: NUPTOTt);
pour x=01..12,30,31,55:
NUCTOTx = FLAG_NUNV * (RBCCx + NURFNx) ;
NUCTOT = FLAG_NUNV * somme(t=01..12,30,31,55: NUCTOTt);
pour x=01..12,30,31,55:
NUDTOTx = FLAG_NUNV * (RBDCx + NURFNx);
NUDTOT = FLAG_NUNV * somme(t=01..12,30,31,55: NUDTOTt);
