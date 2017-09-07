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
regle irisf 1:
application : bareme , batch , iliad ;


BIDON = 1 ;

regle irisf 951010:
application : iliad ;


APPLI_GP      = 0 ;
APPLI_ILIAD   = 1 ;
APPLI_BATCH   = 0 ;

regle irisf 951020:
application : batch ;


APPLI_GP      = 0 ;
APPLI_ILIAD   = 0 ;
APPLI_BATCH   = 1 ;

regle 951030:
application : batch , iliad ;


SOMMEA71701 = positif(CELLIERJA) + positif(CELLIERJB) + positif(CELLIERJD) + positif(CELLIERJE)
	     + positif(CELLIERJF) + positif(CELLIERJG) + positif(CELLIERJH) + positif(CELLIERJJ)
	     + positif(CELLIERJK) + positif(CELLIERJL) + positif(CELLIERJM) + positif(CELLIERJN)
	     + positif(CELLIERJO) + positif(CELLIERJP) + positif(CELLIERJQ) + positif(CELLIERJR) 
	     + 0 ;

SOMMEA71702 = positif(CELLIERNA) + positif(CELLIERNB) + positif(CELLIERNC) + positif(CELLIERND)
             + positif(CELLIERNE) + positif(CELLIERNF) + positif(CELLIERNG) + positif(CELLIERNH) 
	     + positif(CELLIERNI) + positif(CELLIERNJ) + positif(CELLIERNK) + positif(CELLIERNL)
	     + positif(CELLIERNM) + positif(CELLIERNN) + positif(CELLIERNO) + positif(CELLIERNP) 
	     + positif(CELLIERNQ) + positif(CELLIERNR) + positif(CELLIERNS) + positif(CELLIERNT) 
	     + 0 ;

regle 951040:
application : batch , iliad ;

SOMMEA718 = (

   present( BAFV ) + (1 - null( V_FORVA+0 ))
 + present( BAFORESTV ) + present( BAFPVV ) + present( BAF1AV ) 
 + present( BAFC ) + (1 - null( V_FORCA+0 ))
 + present( BAFORESTC ) + present( BAFPVC ) + present( BAF1AC ) 
 + present( BAFP ) + (1 - null( V_FORPA+0 ))
 + present( BAFORESTP ) + present( BAFPVP ) + present( BAF1AP ) 
 + present( BACREV ) + present( 4BACREV ) + present( BA1AV ) + present( BACDEV ) 
 + present( BACREC ) + present( 4BACREC ) + present( BA1AC ) + present( BACDEC ) 
 + present( BACREP ) + present( 4BACREP ) + present( BA1AP ) + present( BACDEP ) 
 + present( BAHREV ) + present( 4BAHREV ) + present( BAHDEV ) 
 + present( BAHREC ) + present( 4BAHREC ) + present( BAHDEC ) 
 + present( BAHREP ) + present( 4BAHREP ) + present( BAHDEP ) 
 + present(COD5XT) + present(COD5XV) + present(COD5XU) + present(COD5XW)

 + present( MIBVENV ) + present( MIBPRESV ) + present( MIBPVV ) + present( MIB1AV ) + present( MIBDEV ) + present( BICPMVCTV )
 + present( MIBVENC ) + present( MIBPRESC ) + present( MIBPVC ) + present( MIB1AC ) + present( MIBDEC ) + present( BICPMVCTC )
 + present( MIBVENP ) + present( MIBPRESP ) + present( MIBPVP ) + present( MIB1AP ) + present( MIBDEP ) + present( BICPMVCTP )
 + present( BICNOV ) + present( LOCPROCGAV ) + present( BI1AV ) + present( BICDNV ) + present( LOCDEFPROCGAV )
 + present( BICNOC ) + present( LOCPROCGAC ) + present( BI1AC ) + present( BICDNC ) + present( LOCDEFPROCGAC )
 + present( BICNOP ) + present( LOCPROCGAP ) + present( BI1AP ) + present( BICDNP ) + present( LOCDEFPROCGAP )
 + present( BIHNOV ) + present( LOCPROV ) + present( BIHDNV ) + present( LOCDEFPROV )
 + present( BIHNOC ) + present( LOCPROC ) + present( BIHDNC ) + present( LOCDEFPROC )
 + present( BIHNOP ) + present( LOCPROP ) + present( BIHDNP ) + present( LOCDEFPROP )

 + present( MIBMEUV ) + present( MIBGITEV ) + present( LOCGITV ) + present( MIBNPVENV ) + present( MIBNPPRESV ) 
 + present( MIBNPPVV ) + present( MIBNP1AV ) + present( MIBNPDEV ) 
 + present( MIBMEUC ) + present( MIBGITEC ) + present( LOCGITC ) + present( MIBNPVENC ) + present( MIBNPPRESC ) 
 + present( MIBNPPVC ) + present( MIBNP1AC ) + present( MIBNPDEC ) 
 + present( MIBMEUP ) + present( MIBGITEP ) + present( LOCGITP ) + present( MIBNPVENP ) + present( MIBNPPRESP ) 
 + present( MIBNPPVP ) + present( MIBNP1AP ) + present( MIBNPDEP ) 
 + present( MIBNPDCT ) 
 + present( BICREV ) + present( LOCNPCGAV ) + present( LOCGITCV ) + present( BI2AV ) + present( BICDEV ) + present( LOCDEFNPCGAV )
 + present( BICREC ) + present( LOCNPCGAC ) + present( LOCGITCC ) + present( BI2AC ) + present( BICDEC ) + present( LOCDEFNPCGAC )
 + present( BICREP ) + present( LOCNPCGAPAC ) + present( LOCGITCP ) + present( BI2AP ) + present( BICDEP ) + present( LOCDEFNPCGAPAC )
 + present( BICHREV ) + present( LOCNPV ) + present( LOCGITHCV ) + present( BICHDEV ) + present( LOCDEFNPV )
 + present( BICHREC ) + present( LOCNPC ) + present( LOCGITHCC ) + present( BICHDEC ) + present( LOCDEFNPC )
 + present( BICHREP ) + present( LOCNPPAC ) + present( LOCGITHCP ) + present( BICHDEP ) + present( LOCDEFNPPAC )

 + present( BNCPROV ) + present( BNCPROPVV ) + present( BNCPRO1AV ) + present( BNCPRODEV ) + present( BNCPMVCTV )
 + present( BNCPROC ) + present( BNCPROPVC ) + present( BNCPRO1AC ) + present( BNCPRODEC ) + present( BNCPMVCTC )
 + present( BNCPROP ) + present( BNCPROPVP ) + present( BNCPRO1AP ) + present( BNCPRODEP ) + present( BNCPMVCTP )
 + present( BNCREV ) + present( BN1AV ) + present( BNCDEV ) 
 + present( BNCREC ) + present( BN1AC ) + present( BNCDEC ) 
 + present( BNCREP ) + present( BN1AP ) + present( BNCDEP ) 
 + present( BNHREV ) + present( BNHDEV ) 
 + present( BNHREC ) + present( BNHDEC ) 
 + present( BNHREP ) + present( BNHDEP ) 

 + present( BNCNPV ) + present( BNCNPPVV ) + present( BNCNP1AV ) + present( BNCNPDEV ) 
 + present( BNCNPC ) + present( BNCNPPVC ) + present( BNCNP1AC ) + present( BNCNPDEC ) 
 + present( BNCNPP ) + present( BNCNPPVP ) + present( BNCNP1AP ) + present( BNCNPDEP ) 
 + present( BNCNPDCT ) 
 + present ( BNCAABV ) + present( ANOCEP ) + present( PVINVE ) 
 + present( INVENTV ) + present ( BNCAADV ) + present( DNOCEP ) 
 + present ( BNCAABC ) + present( ANOVEP ) + present( PVINCE ) 
 + present( INVENTC ) + present ( BNCAADC ) + present( DNOCEPC )
 + present ( BNCAABP ) + present( ANOPEP ) + present( PVINPE ) 
 + present ( INVENTP ) + present ( BNCAADP ) + present( DNOCEPP )
 + 0
            ) ;

regle 951050:
application : batch , iliad ;

SOMMEA719 = (

   present( BAEXV ) + present ( BACREV ) + present( 4BACREV ) + present ( BA1AV ) + present ( BACDEV ) 
 + present( BAEXC ) + present ( BACREC ) + present( 4BACREC ) + present ( BA1AC ) + present ( BACDEC ) 
 + present( BAEXP ) + present ( BACREP ) + present( 4BACREP ) + present ( BA1AP ) + present ( BACDEP ) 
 + present( BAHEXV ) + present ( BAHREV ) + present( 4BAHREV ) + present ( BAHDEV ) 
 + present( BAHEXC ) + present ( BAHREC ) + present( 4BAHREC ) + present ( BAHDEC ) 
 + present( BAHEXP ) + present ( BAHREP ) + present( 4BAHREP ) + present ( BAHDEP ) 
 + present(COD5XT) + present(COD5XV) + present(COD5XU) + present(COD5XW)

 + present( BICEXV ) + present ( BICNOV ) + present ( LOCPROCGAV )
 + present ( BI1AV ) + present ( BICDNV ) + present ( LOCDEFPROCGAV )
 + present( BICEXC ) + present ( BICNOC ) + present ( LOCPROCGAC )
 + present ( BI1AC ) + present ( BICDNC ) + present ( LOCDEFPROCGAC )
 + present( BICEXP ) + present ( BICNOP ) + present ( LOCPROCGAP )
 + present ( BI1AP ) + present ( BICDNP ) + present ( LOCDEFPROCGAP )
 + present( BIHEXV ) + present ( BIHNOV ) + present ( LOCPROV )
 + present ( BIHDNV ) + present ( LOCDEFPROV )
 + present( BIHEXC ) + present ( BIHNOC ) + present ( LOCPROC )
 + present ( BIHDNC ) + present ( LOCDEFPROC )
 + present( BIHEXP ) + present ( BIHNOP ) + present ( LOCPROP )
 + present ( BIHDNP ) + present ( LOCDEFPROP )

 + present( BICNPEXV ) + present ( BICREV ) + present( LOCNPCGAV )
 + present ( BI2AV ) + present ( BICDEV ) + present( LOCDEFNPCGAV )
 + present( BICNPEXC ) + present ( BICREC ) + present( LOCNPCGAC )
 + present ( BI2AC ) + present ( BICDEC ) + present( LOCDEFNPCGAC )
 + present( BICNPEXP ) + present ( BICREP ) + present( LOCNPCGAPAC )
 + present ( BI2AP ) + present ( BICDEP ) + present( LOCDEFNPCGAPAC )
 + present( BICNPHEXV ) + present ( BICHREV ) + present ( LOCNPV )
 + present ( BICHDEV ) + present ( LOCDEFNPV )
 + present( BICNPHEXC ) + present ( BICHREC ) + present ( LOCNPC )
 + present ( BICHDEC ) + present ( LOCDEFNPC )
 + present( BICNPHEXP ) + present ( BICHREP ) + present ( LOCNPPAC )
 + present ( BICHDEP ) + present ( LOCDEFNPPAC )

 + present( BNCEXV ) + present ( BNCREV ) + present ( BN1AV ) + present ( BNCDEV ) 
 + present( BNCEXC ) + present ( BNCREC ) + present ( BN1AC ) + present ( BNCDEC ) 
 + present( BNCEXP ) + present ( BNCREP ) + present ( BN1AP ) + present ( BNCDEP ) 
 + present( BNHEXV ) + present ( BNHREV ) + present ( BNHDEV ) 
 + present( BNHEXC ) + present ( BNHREC ) + present ( BNHDEC ) 
 + present( BNHEXP ) + present ( BNHREP ) + present ( BNHDEP )
 + present( XHONOAAV ) + present( XHONOV ) 
 + present( XHONOAAC ) + present( XHONOC ) 
 + present( XHONOAAP ) + present( XHONOP )

 + present ( BNCNPREXAAV ) + present ( BNCAABV )   + present ( BNCAADV )  + present ( BNCNPREXV ) 
 + present( ANOCEP ) + present( DNOCEP ) + present( PVINVE ) + present( INVENTV )
 + present ( BNCNPREXAAC ) + present ( BNCAABC ) + present ( BNCAADC ) + present ( BNCNPREXC )
 + present( ANOVEP ) + present( DNOCEPC ) + present( PVINCE ) + present( INVENTC )
 + present ( BNCNPREXAAP ) + present ( BNCAABP ) + present ( BNCAADP ) + present ( BNCNPREXP )
 + present( ANOPEP ) + present( DNOCEPP ) + present( PVINPE ) + present( INVENTP )

 + 0
        ) ;

regle 951060:
application : batch , iliad ;

SOMMEA030 =     
                somme(i=1..4: positif(TSHALLOi) + positif(ALLOi)
		+ positif(CARTSPi) + positif(REMPLAPi)
		+ positif(CARTSNBAPi) + positif(REMPLANBPi)
                + positif(PRBRi)
		+ positif(CARPEPi) + positif(CARPENBAPi)
                + positif(PALIi) + positif(FRNi) 
		+ positif(PENSALPi) + positif(PENSALNBPi)
		)
 + positif(FEXP)  + positif(BAFP)  + positif(BAFORESTP) + positif(BAFPVP)  + positif(BAF1AP)
 + positif(BAEXP)  + positif(BACREP) + positif(4BACREP)  
 + positif(BA1AP)  + positif(BACDEP)
 + positif(BAHEXP)  + positif(BAHREP) + positif(4BAHREP) 
 + positif(BAHDEP) 
 + positif(MIBEXP) + positif(MIBVENP) + positif(MIBPRESP)  + positif(MIBPVP)  + positif(MIB1AP)  + positif(MIBDEP)
 + positif(BICPMVCTP) + positif(BICEXP) + positif(BICNOP) + positif(BI1AP)  
 + positif(BICDNP) 
 + positif(BIHEXP) + positif(BIHNOP) + positif(BIHDNP)  
 + positif(MIBNPEXP)  + positif(MIBNPVENP)  + positif(MIBNPPRESP)  + positif(MIBNPPVP)  + positif(MIBNP1AP)  + positif(MIBNPDEP)
 + positif(BICNPEXP)  + positif(BICREP) + positif(BI2AP)  + positif(BICDEP)  
 + positif(BICNPHEXP) + positif(BICHREP) + positif(BICHDEP) 
 + positif(BNCPROEXP)  + positif(BNCPROP)  + positif(BNCPROPVP)  + positif(BNCPRO1AP)  + positif(BNCPRODEP) + positif(BNCPMVCTP)
 + positif(BNCEXP)  + positif(BNCREP) + positif(BN1AP) 
 + positif(BNCDEP)
 + positif(BNHEXP)  + positif(BNHREP)  + positif(BNHDEP) + positif(BNCCRP)
 + positif(BNCNPP)  + positif(BNCNPPVP)  + positif(BNCNP1AP)  + positif(BNCNPDEP)
 + positif(ANOPEP) + positif(PVINPE) + positif(INVENTP) + positif(DNOCEPP) + positif(BNCCRFP)
 + positif(BNCAABP) + positif(BNCAADP)
 + positif(RCSP) 
 + positif(BAPERPP) + positif(BIPERPP) 
 + positif(PERPP) + positif(PERP_COTP) + positif(PLAF_PERPP)
 + somme(i=1..4: positif(PEBFi))
 + positif( COTF1 ) + positif( COTF2 ) + positif( COTF3 ) + positif( COTF4 )
 + positif (BNCNPREXAAP) + positif (BNCNPREXP)
 + positif(AUTOBICVP) + positif(AUTOBICPP) 
 + positif(AUTOBNCP) + positif(LOCPROCGAP) 
 + positif(LOCDEFPROCGAP)
 + positif(LOCPROP) + positif(LOCDEFPROP) 
 + positif(LOCNPCGAPAC) + positif(LOCGITCP) + positif(LOCGITHCP) 
 + positif(LOCDEFNPCGAPAC)
 + positif(LOCNPPAC) + positif(LOCDEFNPPAC) 
 + positif(XHONOAAP) + positif(XHONOP) + positif(XSPENPP)
 + positif(BANOCGAP) + positif(MIBMEUP) + positif(MIBGITEP) + positif(LOCGITP) 
 + positif(SALEXT1) + positif(COD1CE) + positif(COD1CH)
 + positif(SALEXT2) + positif(COD1DE) + positif(COD1DH)
 + positif(SALEXT3) + positif(COD1EE) + positif(COD1EH)
 + positif(SALEXT4) + positif(COD1FE) + positif(COD1FH)
 + positif(RDSYPP)
 + positif(PENIN1) + positif(PENIN2) + positif(PENIN3) + positif(PENIN4)
 + positif(CODRCZ) + positif(CODRDZ) + positif(CODREZ) + positif(CODRFZ)
 + 0 ;

regle 951070:
application : batch , iliad ;

SOMMEA031 = (

   positif( TSHALLOC ) + positif( ALLOC ) + positif( PRBRC ) 
 + positif( PALIC ) + positif( GSALC ) + positif( TSASSUC ) + positif( XETRANC ) 
 + positif( EXOCETC ) + positif( FRNC ) 
 + positif( PCAPTAXC )
 + positif( CARTSC ) + positif( PENSALC ) + positif( REMPLAC ) + positif( CARPEC ) 
 + positif( GLDGRATC ) 
 + positif( GLD1C ) + positif( GLD2C ) + positif( GLD3C ) 

 + positif( BPCOSAC ) 

 + positif( FEXC ) + positif( BAFC ) + positif( BAFORESTC ) + positif( BAFPVC ) + positif( BAF1AC ) 
 + positif( BAEXC ) + positif( BACREC ) + positif( 4BACREC ) + positif( BA1AC ) 
 + positif(BACDEC) + positif(BAHEXC) + positif(BAHREC) + positif(4BAHREC) 
 + positif(BAHDEC) + positif(BAPERPC) + positif(BANOCGAC) 
 + positif(COD5XU) + positif(COD5XW)
 + positif( AUTOBICVC ) + positif( AUTOBICPC ) + positif( AUTOBNCC ) 
 + positif( MIBEXC ) + positif( MIBVENC ) + positif( MIBPRESC ) + positif( MIBPVC ) 
 + positif( MIB1AC ) + positif( MIBDEC ) + positif( BICPMVCTC )
 + positif( BICEXC ) + positif( BICNOC ) + positif( LOCPROCGAC ) + positif( BI1AC ) 
 + positif (BICDNC)  
 + positif (LOCDEFPROCGAC)
 + positif( BIHEXC ) + positif( BIHNOC ) + positif( LOCPROC ) + positif(BIHDNC)  
 + positif (LOCDEFPROC) 
 + positif( BIPERPC ) 
 + positif( MIBNPEXC ) + positif( MIBNPVENC ) + positif( MIBNPPRESC ) + positif( MIBNPPVC ) + positif( MIBNP1AC ) + positif( MIBNPDEC ) 
 + positif( BICNPEXC ) + positif( BICREC ) + positif( LOCNPCGAC ) + positif( BI2AC ) 
 + positif (BICDEC)
 + positif (LOCDEFNPCGAC)
 + positif( MIBMEUC ) + positif( MIBGITEC ) + positif( LOCGITC ) + positif( LOCGITCC ) + positif( LOCGITHCC )
 + positif( BICNPHEXC ) + positif( BICHREC ) + positif( LOCNPC ) 
 + positif (BICHDEC) 
 + positif (LOCDEFNPC) 
 + positif( BNCPROEXC ) + positif( BNCPROC ) + positif( BNCPROPVC ) + positif( BNCPRO1AC ) + positif( BNCPRODEC ) + positif( BNCPMVCTC )
 + positif( BNCEXC ) + positif( BNCREC ) + positif( BN1AC ) 
 + positif (BNCDEC)  
 + positif( BNHEXC ) + positif( BNHREC ) + positif (BNHDEC) + positif( BNCCRC ) + positif( CESSASSC )
 + positif( XHONOAAC ) + positif( XHONOC ) + positif( XSPENPC )
 + positif( BNCNPC ) + positif( BNCNPPVC ) + positif( BNCNP1AC ) + positif( BNCNPDEC ) 
 + positif( BNCNPREXAAC ) + positif( BNCAABC ) + positif(BNCAADC) + positif( BNCNPREXC ) + positif( ANOVEP )
 + positif( PVINCE ) + positif( INVENTC ) + positif (DNOCEPC) + positif( BNCCRFC )
 + positif( RCSC ) + positif( PVSOCC )  
 + positif( PEBFC ) 
 + positif( PERPC ) + positif( PERP_COTC ) + positif( PLAF_PERPC )
 + positif( PERPPLAFCC ) + positif( PERPPLAFNUC1 ) + positif( PERPPLAFNUC2 ) + positif( PERPPLAFNUC3 )
 + positif( ELURASC )
 + positif(CODDBJ) + positif(CODEBJ)  
 + positif(SALEXTC) + positif(COD1BE) + positif(COD1BH)
 + positif(RDSYCJ)
 + positif(PENINC) + positif(CODRBZ)

 + 0 ) ;

regle 951080:
application : iliad , batch ;  

SOMMEA804 = SOMMEANOEXP 
	    + positif ( GLD1V ) + positif ( GLD2V ) + positif ( GLD3V ) 
            + positif ( GLD1C ) + positif ( GLD2C ) + positif ( GLD3C ) 
           ;

SOMMEA805 = SOMMEANOEXP + positif(CODDAJ) + positif(CODEAJ) + positif(CODDBJ) + positif(CODEBJ) 
            + positif ( CARTSV ) + positif ( CARTSNBAV ) + positif ( CARTSC ) + positif ( CARTSNBAC ) ;

regle 951090:
application : iliad , batch ;  

SOMMEA899 = present( BICEXV ) + present( BICNOV ) + present( BI1AV ) + present( BICDNV )
            + present( BICEXC ) + present( BICNOC ) + present( BI1AC ) + present( BICDNC )
	    + present( BICEXP ) + present( BICNOP ) + present( BI1AP ) + present( BICDNP )
	    + present( BIHEXV ) + present( BIHNOV ) + present( BIHDNV )
	    + present( BIHEXC ) + present( BIHNOC ) + present( BIHDNC )
	    + present( BIHEXP ) + present( BIHNOP ) + present( BIHDNP )
	    ;

SOMMEA859 = present( BICEXV ) + present( BICNOV ) + present( BI1AV ) + present( BICDNV )
            + present( BICEXC ) + present( BICNOC ) + present( BI1AC ) + present( BICDNC )
	    + present( BICEXP ) + present( BICNOP ) + present( BI1AP ) + present( BICDNP )
	    + present( BIHEXV ) + present( BIHNOV ) + present( BIHDNV )
	    + present( BIHEXC ) + present( BIHNOC ) + present( BIHDNC )
	    + present( BIHEXP ) + present( BIHNOP ) + present( BIHDNP )
	    ;

SOMMEA860 = present( BICEXV ) + present( BICNOV ) + present( BI1AV ) + present( BICDNV )
            + present( BICEXC ) + present( BICNOC ) + present( BI1AC ) + present( BICDNC )
	    + present( BICEXP ) + present( BICNOP ) + present( BI1AP ) + present( BICDNP )
	    + present( BIHEXV ) + present( BIHNOV ) + present( BIHDNV )
	    + present( BIHEXC ) + present( BIHNOC ) + present( BIHDNC )
	    + present( BIHEXP ) + present( BIHNOP ) + present( BIHDNP )
            + present( BNCEXV ) + present( BNCREV ) + present( BN1AV ) + present( BNCDEV )
	    + present( BNCEXC ) + present( BNCREC ) + present( BN1AC ) + present( BNCDEC )
	    + present( BNCEXP ) + present( BNCREP ) + present( BN1AP ) + present( BNCDEP )
	    + present( BNHEXV ) + present( BNHREV ) + present( BNHDEV )
	    + present( BNHEXC ) + present( BNHREC ) + present( BNHDEC )
	    + present( BNHEXP ) + present( BNHREP ) + present( BNHDEP )
            ;

SOMMEA895 = present(BAEXV) + present(BACREV) + present(4BACREV) + present(BA1AV) + present(BACDEV)
            + present(BAEXC) + present(BACREC) + present(4BACREC) + present(BA1AC) + present(BACDEC)
	    + present(BAEXP) + present(BACREP) + present(4BACREP) + present(BA1AP) + present(BACDEP)
	    + present(BAHEXV) + present(BAHREV) + present(4BAHREV) + present(BAHDEV)
	    + present(BAHEXC) + present(BAHREC) + present(4BAHREC) + present(BAHDEC)
	    + present(BAHEXP) + present(BAHREP) + present(4BAHREP) + present(BAHDEP)
	    + present(FEXV) + present(BAFV) + (1 - null(V_FORVA+0)) + present(BAFPVV) + present(BAF1AV)
            + present(FEXC) + present(BAFC) + (1 - null(V_FORCA+0)) + present(BAFPVC) + present(BAF1AC)
            + present(FEXP) + present(BAFP) + (1 - null(V_FORPA+0)) + present(BAFPVP) + present(BAF1AP) 
            + present(COD5XT) + present(COD5XV) + present(COD5XU) + present(COD5XW)
	    ;

SOMMEA898 = SOMMEA895 ;

SOMMEA881 =  
	     present(BAEXV) + present(BACREV) + present(4BACREV) + present(BA1AV) + present(BACDEV)
           + present(BAEXC) + present(BACREC) + present(4BACREC) + present(BA1AC) + present(BACDEC)
	   + present(BAEXP) + present(BACREP) + present(4BACREP) + present(BA1AP) + present(BACDEP)
	   + present(BAHEXV) + present(BAHREV) + present(4BAHREV) + present(BAHDEV)
	   + present(BAHEXC) + present(BAHREC) + present(4BAHREC) + present(BAHDEC)
	   + present(BAHEXP) + present(BAHREP) + present(4BAHREP) + present(BAHDEP)
           + present(COD5XT) + present(COD5XV) + present(COD5XU) + present(COD5XW)

	   + present( BICEXV ) + present( BICNOV ) + present( BI1AV ) + present( BICDNV )
	   + present( BICEXC ) + present( BICNOC ) + present( BI1AC )
	   + present( BICDNC ) + present( BICEXP ) + present( BICNOP ) 
	   + present( BI1AP ) + present( BICDNP ) + present( BIHEXV ) + present( BIHNOV )
	   + present( BIHDNV ) + present( BIHEXC )
	   + present( BIHNOC ) + present( BIHDNC ) 
	   + present( BIHEXP ) + present( BIHNOP ) + present( BIHDNP )
	   + present( BICNPEXV ) + present( BICREV ) + present( BI2AV )
	   + present( BICDEV ) + present( BICNPEXC ) + present( BICREC ) 
	   + present( BI2AC ) + present( BICDEC ) + present( BICNPEXP ) + present( BICREP )
	   + present( BI2AP ) + present( BICDEP ) + present( BICNPHEXV )
	   + present( BICHREV ) + present( BICHDEV ) 
	   + present( BICNPHEXC ) + present( BICHREC ) + present( BICHDEC )
	   + present( BICNPHEXP ) + present( BICHREP ) 
	   + present( BICHDEP ) 
	   + present( LOCPROCGAV ) + present( LOCDEFPROCGAV ) 
	   + present( LOCPROCGAC ) + present( LOCDEFPROCGAC ) 
	   + present( LOCPROCGAP ) + present( LOCDEFPROCGAP )
	   + present( LOCPROV ) + present( LOCDEFPROV ) + present( LOCPROC )
	   + present( LOCDEFPROC ) + present( LOCPROP ) + present( LOCDEFPROP )
	   + present( LOCNPCGAV ) + present( LOCGITCV ) + present( LOCDEFNPCGAV ) 
	   + present( LOCNPCGAC ) + present( LOCGITCC ) + present( LOCDEFNPCGAC ) 
	   + present( LOCNPCGAPAC ) + present( LOCGITCP ) + present( LOCDEFNPCGAPAC )
	   + present( LOCNPV ) + present( LOCGITHCV ) + present( LOCDEFNPV ) 
	   + present( LOCNPC ) + present( LOCGITHCC ) + present( LOCDEFNPC ) 
	   + present( LOCNPPAC ) + present( LOCGITHCP ) + present( LOCDEFNPPAC )
           + present( BAPERPV ) + present( BAPERPC ) + present( BAPERPP)
           + present( BANOCGAV ) + present( BANOCGAC ) + present( BANOCGAP )

	   + present(BNCEXV) + present(BNCREV) + present(BN1AV) + present(BNCDEV) 
	   + present(BNCEXC) + present(BNCREC) + present(BN1AC) + present(BNCDEC)
	   + present(BNCEXP) + present(BNCREP) + present(BN1AP) + present(BNCDEP) 
	   + present(BNHEXV) + present(BNHREV) + present(BNHDEV) 
	   + present(BNHEXC) + present(BNHREC) + present(BNHDEC) 
	   + present(BNHEXP) + present(BNHREP) + present(BNHDEP) 
           + present(XHONOAAV) + present(XHONOV) 
	   + present(XHONOAAC) + present(XHONOC) 
	   + present(XHONOAAP) + present(XHONOP)

	   + present(BNCAABV) + present(ANOCEP) + present(INVENTV) 
	   + present(PVINVE) + present(BNCAADV) + present(DNOCEP) 
	   + present(BNCAABC) + present(ANOVEP) + present(INVENTC) 
	   + present(PVINCE) + present(BNCAADC) + present(DNOCEPC)
	   + present(BNCAABP) + present(ANOPEP) + present(INVENTP)
	   + present(PVINPE) + present(BNCAADP) + present(DNOCEPP)
           + present(BNCNPREXAAV) + present(BNCNPREXAAC) + present(BNCNPREXAAP)
           + present(BNCNPREXV) + present(BNCNPREXC) + present(BNCNPREXP)
	   ;

SOMMEA858 = SOMMEA881 + present(TSHALLOV) + present(TSHALLOC) + present(TSASSUV) + present(TSASSUC)
                      + present(RFMIC) + present(RFORDI) + present(RFDORD) + present(RFDHIS) ;

SOMMEA861 = SOMMEA881 ;

SOMMEA890 = SOMMEA881  + present( TSHALLOV ) + present( TSHALLOC ) 
		       + present( CARTSV ) + present( CARTSC )
		       + present( CARTSNBAV ) + present( CARTSNBAC ) ;

SOMMEA891 = SOMMEA881 ;

SOMMEA892 = SOMMEA881 ;

SOMMEA893 = SOMMEA881 ;

SOMMEA894 = SOMMEA881 ;

SOMMEA896 = SOMMEA881 ;

SOMMEA897 = SOMMEA881 ;

SOMMEA885 =  present( BA1AV ) + present( BA1AC ) + present( BA1AP )
           + present( BI1AV ) + present( BI1AC ) + present( BI1AP ) 
	   + present( BN1AV ) + present( BN1AC ) + present( BN1AP ) ;

SOMMEA880 =  present ( BICEXV ) + present ( BICNOV ) + present ( BI1AV )
           + present ( BICDNV ) + present ( BICEXC ) + present ( BICNOC )
	   + present ( BI1AC ) + present ( BICDNC ) 
	   + present ( BICEXP ) + present ( BICNOP ) + present ( BI1AP )
	   + present ( BICDNP ) + present ( BIHEXV ) + present ( BIHNOV )
           + present ( BIHDNV ) + present ( BIHEXC )
	   + present ( BIHNOC ) + present ( BIHDNC ) 
	   + present ( BIHEXP ) + present ( BIHNOP ) + present ( BIHDNP )
	   + present ( LOCPROCGAV ) + present ( LOCDEFPROCGAV ) + present ( LOCPROCGAC )
	   + present ( LOCDEFPROCGAC ) + present ( LOCPROCGAP ) + present ( LOCDEFPROCGAP )
	   + present ( LOCPROV ) + present ( LOCDEFPROV ) + present ( LOCPROC )
	   + present ( LOCDEFPROC ) + present ( LOCPROP ) + present ( LOCDEFPROP )
	   ;

SOMMEA874 =  somme(i=V,C,1,2,3,4:present(TSHALLOi) + present(ALLOi) + present(PRBRi) + present(PALIi) + present(PENINi))
            + present ( CARTSV ) + present ( CARTSC ) + present ( CARTSP1 )
            + present ( CARTSP2 ) + present ( CARTSP3) + present ( CARTSP4 )
            + present ( CARTSNBAV ) + present ( CARTSNBAC ) + present ( CARTSNBAP1 )
            + present ( CARTSNBAP2 ) + present ( CARTSNBAP3) + present ( CARTSNBAP4 )
            + present ( REMPLAV ) + present ( REMPLAC ) + present ( REMPLAP1 )
            + present ( REMPLAP2 ) + present ( REMPLAP3 ) + present ( REMPLAP4 )
            + present ( REMPLANBV ) + present ( REMPLANBC ) + present ( REMPLANBP1 )
            + present ( REMPLANBP2 ) + present ( REMPLANBP3 ) + present ( REMPLANBP4 )
            + present ( CARPEV ) + present ( CARPEC ) + present ( CARPEP1 )
            + present ( CARPEP2 ) + present ( CARPEP3 ) + present ( CARPEP4 )
            + present ( CARPENBAV ) + present ( CARPENBAC ) + present ( CARPENBAP1 )
            + present ( CARPENBAP2 ) + present ( CARPENBAP3 ) + present ( CARPENBAP4 )
            + present ( PENSALV ) + present ( PENSALC ) + present ( PENSALP1 )
            + present ( PENSALP2 ) + present ( PENSALP3 ) + present ( PENSALP4 )
            + present ( PENSALNBV ) + present ( PENSALNBC ) + present ( PENSALNBP1 )
            + present ( PENSALNBP2 ) + present ( PENSALNBP3 ) + present ( PENSALNBP4 )
	    + somme(k=V,C,P: somme (i=C,H: present(BIiNOk)  
		           + somme(j = N: present(BIiDjk))) 
	                   + somme (i = I: present(Bi1Ak)) 
		  )
            + present(CODRAZ) + present(CODRBZ) + present(CODRCZ) 
            + present(CODRDZ) + present(CODREZ) + present(CODRFZ)
	    + present ( RVB1 ) + present ( RVB2 ) + present ( RVB3 ) + present ( RVB4 )
	    + present ( RENTAX ) + present ( RENTAX5 ) + present ( RENTAX6 ) + present ( RENTAX7 )
	    + present ( RENTAXNB ) + present ( RENTAXNB5 ) + present ( RENTAXNB6 ) + present ( RENTAXNB7 )
	    + present( RCMABD ) + present( RCMHAD ) + present( REGPRIV ) + present( RCMIMPAT )
	    + present( REVACT ) + present( DISQUO ) + present( RESTUC )
	    + present( REVACTNB ) + present( DISQUONB ) + present ( RESTUCNB )
            + present( COD2FA ) + present( RCMHAB ) + present( INTERE )
	    + present ( MIBVENV ) + present ( MIBPRESV ) + present ( MIB1AV ) + present ( MIBDEV ) 
	    + present ( MIBVENC ) + present ( MIBPRESC ) + present ( MIB1AC ) + present ( MIBDEC ) 
	    + present ( MIBVENP ) + present ( MIBPRESP ) + present ( MIB1AP ) + present ( MIBDEP ) 
	    + present( LOCPROCGAV ) + present( LOCDEFPROCGAV ) + present( LOCPROCGAC )
	    + present( LOCDEFPROCGAC ) + present( LOCPROCGAP ) + present( LOCDEFPROCGAP )
	    + present( LOCPROV ) + present( LOCDEFPROV ) + present( LOCPROC )
	    + present( LOCDEFPROC ) + present( LOCPROP ) + present( LOCDEFPROP )
	    + present( BICREV ) + present( LOCNPCGAV ) + present( LOCGITCV ) + present( BI2AV ) + present( BICDEV ) + present( LOCDEFNPCGAV ) 
	    + present( BICREC ) + present( LOCNPCGAC ) + present( LOCGITCC ) + present( BI2AC ) + present( BICDEC ) + present( LOCDEFNPCGAC ) 
	    + present( BICREP ) + present( LOCNPCGAPAC ) + present( LOCGITCP ) + present( BI2AP  ) + present( BICDEP ) + present( LOCDEFNPCGAPAC )
	    + present( BICHREV ) + present( LOCNPV ) + present( LOCGITHCV ) + present( BICHDEV ) + present( LOCDEFNPV ) 
	    + present( BICHREC ) + present( LOCNPC ) + present( LOCGITHCC ) + present( BICHDEC ) + present( LOCDEFNPC ) 
	    + present( BICHREP ) + present( LOCNPPAC ) + present( LOCGITHCP ) + present( BICHDEP ) + present( LOCDEFNPPAC )
	    + present( MIBMEUV ) + present( MIBGITEV ) + present( LOCGITV ) + present( MIBNPVENV ) 
	    + present( MIBNPPRESV ) + present( MIBNP1AV ) + present( MIBNPDEV ) 
	    + present( MIBMEUC ) + present( MIBGITEC ) + present( LOCGITC ) + present( MIBNPVENC ) 
	    + present( MIBNPPRESC ) + present( MIBNP1AC ) + present( MIBNPDEC ) 
	    + present( MIBMEUP ) + present( MIBGITEP ) + present( LOCGITP ) + present( MIBNPVENP ) 
	    + present( MIBNPPRESP ) + present( MIBNP1AP ) + present( MIBNPDEP ) 
	    + present ( BNCREV ) + present ( BN1AV ) + present ( BNCDEV )
	    + present ( BNCREC ) + present ( BN1AC ) + present ( BNCDEC )
	    + present ( BNCREP ) + present ( BN1AP ) + present ( BNCDEP )
	    + present ( BNHREV ) + present ( BNHDEV )
	    + present ( BNHREC ) + present ( BNHDEC )
	    + present ( BNHREP ) + present ( BNHDEP )
            + present ( BNCPROV ) + present ( BNCPRO1AV ) + present ( BNCPRODEV ) 
	    + present ( BNCPROC ) + present ( BNCPRO1AC ) + present ( BNCPRODEC ) 
	    + present ( BNCPROP ) + present ( BNCPRO1AP ) + present ( BNCPRODEP ) 
	    + present ( BNCNPV ) + present ( BNCNP1AV ) + present ( BNCNPDEV ) 
	    + present ( BNCNPC ) + present ( BNCNP1AC ) + present ( BNCNPDEC ) 
	    + present ( BNCNPP ) + present ( BNCNP1AP ) + present ( BNCNPDEP ) 
	    + present ( BNCAABV ) + present ( ANOCEP ) + present ( INVENTV ) 
	    + present ( PVINVE ) + present ( BNCAADV ) + present ( DNOCEP ) 
	    + present ( BNCAABC ) + present ( ANOVEP ) + present ( INVENTC ) 
	    + present ( PVINCE ) + present ( BNCAADC ) + present ( DNOCEPC )
	    + present ( BNCAABP ) + present ( ANOPEP ) + present ( INVENTP )
	    + present ( PVINPE ) + present ( BNCAADP ) + present ( DNOCEPP )
	    ;

SOMMEA877 =  present(BAEXV) + present(BACREV) + present(4BACREV) 
	   + present(BA1AV) + present(BACDEV) + present(BAEXC) 
	   + present(BACREC) + present(4BACREC)
	   + present(BA1AC) + present(BACDEC) + present(BAEXP) + present(BACREP) 
	   + present(4BACREP) + present(BA1AP) 
	   + present(BACDEP) + present(BAHEXV) + present(BAHREV)  
	   + present(4BAHREV) + present(BAHDEV) + present(BAHEXC) 
	   + present(BAHREC) + present(4BAHREC)
	   + present(BAHDEC) + present(BAHEXP) + present(BAHREP)  
	   + present(4BAHREP) + present(BAHDEP) + present(BICEXV) 
           + present(COD5XT) + present(COD5XV) + present(COD5XU) + present(COD5XW)

	   + present(BICNOV) + present(BI1AV) + present(BICDNV) 
           + present(BICEXC) + present(BICNOC)  
	   + present(BI1AC) + present(BICDNC) + present(BICEXP) 
           + present(BICNOP) + present(BI1AP) + present(BICDNP) 
           + present(BIHEXV) + present(BIHNOV) + present(BIHDNV) 
           + present(BIHEXC) + present(BIHNOC) + present(BIHDNC) 
           + present(BIHEXP) + present(BIHNOP) + present(BIHDNP) ;

SOMMEA879 =  
	     present(BACREV) + present(4BACREV) + present(BA1AV) + present(BACDEV) 
	   + present(BACREC) + present(4BACREC) + present(BA1AC) + present(BACDEC) 
           + present(BACREP) + present(4BACREP) + present(BA1AP) + present(BACDEP) 
	   + present(BAHREV) + present(4BAHREV) + present(BAHDEV) 
	   + present(BAHREC) + present(4BAHREC) + present(BAHDEC) 
           + present(BAHREP) + present(4BAHREP) + present(BAHDEP) 
           + present(COD5XT) + present(COD5XV) + present(COD5XU) + present(COD5XW)
	   
	   + present( BICNOV ) + present( BI1AV ) 
	   + present( BICDNV ) + present( BICNOC )  
	   + present( BI1AC ) + present( BICDNC ) + present( BICNOP ) 
	   + present( BI1AP ) + present( BICDNP )  
	   + present( BIHNOV ) + present( BIHDNV )  
	   + present( BIHNOC ) + present( BIHDNC )  
	   + present( BIHNOP ) + present( BIHDNP )  
	   + present( BICREV ) + present( BI2AV ) + present( BICDEV ) 
	   + present( BICREC ) + present( BI2AC ) 
	   + present( BICDEC ) + present( BICREP )  
	   + present( BI2AP ) + present( BICDEP ) + present( BICHREV ) 
	   + present( BICHDEV ) + present( BICHREC ) 
	   + present( BICHDEC ) + present( BICHREP ) 
	   + present( BICHDEP ) 
	   + present( LOCPROCGAV ) + present( LOCDEFPROCGAV ) + present( LOCPROCGAC )
	   + present( LOCDEFPROCGAC ) + present( LOCPROCGAP ) + present( LOCDEFPROCGAP )
	   + present( LOCPROV ) + present( LOCDEFPROV ) + present( LOCPROC )
	   + present( LOCDEFPROC ) + present( LOCPROP ) + present( LOCDEFPROP )
	   + present( LOCNPCGAV ) + present( LOCGITCV ) + present( LOCDEFNPCGAV ) 
	   + present( LOCNPCGAC ) + present( LOCGITCC ) + present( LOCDEFNPCGAC ) 
	   + present( LOCNPCGAPAC ) + present( LOCGITCP ) + present( LOCDEFNPCGAPAC )
	   + present( LOCNPV ) + present( LOCGITHCV ) + present( LOCDEFNPV ) 
	   + present( LOCNPC ) + present( LOCGITHCC ) + present( LOCDEFNPC ) 
	   + present( LOCNPPAC ) + present( LOCGITHCP ) + present( LOCDEFNPPAC )
	   + present(BNCREV) + present(BN1AV) + present(BNCDEV) 
	   + present(BNCREC) + present(BN1AC) + present(BNCDEC) 
	   + present(BNCREP) + present(BN1AP) + present(BNCDEP) 
	   + present(BNHREV) + present(BNHDEV) 
	   + present(BNHREC) + present(BNHDEC) 
	   + present(BNHREP) + present(BNHDEP) 
	   + present(BNCAABV) + present(ANOCEP) + present(INVENTV) 
	   + present(PVINVE) + present(BNCAADV) + present(DNOCEP) 
	   + present(BNCAABC) + present(ANOVEP) + present(INVENTC) 
	   + present(PVINCE) + present(BNCAADC) + present(DNOCEPC)
	   + present(BNCAABP) + present(ANOPEP) + present(INVENTP)
	   + present(PVINPE) + present(BNCAADP) + present(DNOCEPP)
	   ; 

SOMMEA884 =  present(TSHALLOV) + present(TSHALLOC) + present(TSHALLO1) + present(TSHALLO2) 
           + present(TSHALLO3) + present(TSHALLO4)  
           + present(PCAPTAXV) + present(PCAPTAXC)
           + present(ALLOV) + present(ALLOC) + present(ALLO1) + present(ALLO2) + present(ALLO3) + present(ALLO4) 
	   + present(PALIV) + present(PALIC) + present(PALI1) + present(PALI2) + present(PALI3) + present(PALI4) 
	   + present(PRBRV) + present(PRBRC) + present(PRBR1) + present(PRBR2) + present(PRBR3) + present(PRBR4)  
           + present(CARTSV) + present(CARTSC) + present(CARTSP1)
           + present(CARTSP2) + present(CARTSP3) + present(CARTSP4)
           + present(CARTSNBAV) + present(CARTSNBAC) + present(CARTSNBAP1)
           + present(CARTSNBAP2) + present(CARTSNBAP3) + present(CARTSNBAP4)
           + present(REMPLAV) + present(REMPLAC) + present(REMPLAP1)
           + present(REMPLAP2) + present(REMPLAP3) + present(REMPLAP4)
           + present(REMPLANBV) + present(REMPLANBC) + present(REMPLANBP1)
           + present(REMPLANBP2) + present(REMPLANBP3) + present(REMPLANBP4)
           + present(CARPEV) + present(CARPEC) + present(CARPEP1)
           + present(CARPEP2) + present(CARPEP3) + present(CARPEP4)
           + present(CARPENBAV) + present(CARPENBAC) + present(CARPENBAP1)
           + present(CARPENBAP2) + present(CARPENBAP3) + present(CARPENBAP4)
           + present(PENSALV) + present(PENSALC) + present(PENSALP1)
           + present(PENSALP2) + present(PENSALP3) + present(PENSALP4)
           + present(PENSALNBV) + present(PENSALNBC) + present(PENSALNBP1)
           + present(PENSALNBP2) + present(PENSALNBP3) + present(PENSALNBP4)
	   + present(REVACT) + present(DISQUO) + present(REVACTNB) + present(DISQUONB) + present(COD2FA)
	   + present(RCMHAD)  + present(RCMABD)  
           + present(PENINV) + present(PENINC) + present(PENIN1) + present(PENIN2) + present(PENIN3) + present(PENIN4)
           + present(CODRAZ) + present(CODRBZ) + present(CODRCZ) + present(CODRDZ) + present(CODREZ) + present(CODRFZ)

	   + present(RFORDI)  + present(RFMIC) + present(FONCI) + present(REAMOR) 
           + present(BPVRCM) + present(PVTAXSB) + present(COD3SC) + present(BPV18V) 
           + present(BPCOPTV) + present(BPV40V) + present(COD3SL) + present(CODRVG)
	   + present(BACREV) + present(4BACREV) + present(BAHREV) + present(4BAHREV) + present(BA1AV)
	   + present(BACREC) + present(4BACREC) + present(BAHREC) + present(4BAHREC) + present(BA1AC)
	   + present(BACREP) + present(4BACREP) + present(BAHREP) + present(4BAHREP) + present(BA1AP)
           + present(COD5XT) + present(COD5XV) + present(COD5XU) + present(COD5XW)
	   + present(BICNOV) + present(LOCPROCGAV) + present(BIHNOV) + present(LOCPROV)
	   + present(BICNOC) + present(LOCPROCGAC) + present(BIHNOC) + present(LOCPROC) 
	   + present(BICNOP) + present(LOCPROCGAP) + present(BIHNOP) + present(LOCPROP)
	   + present(MIBVENV) + present(MIBPRESV) + present(BI1AV)
	   + present(MIBVENC) + present(MIBPRESC) + present(BI1AC)
	   + present(MIBVENP) + present(MIBPRESP) + present(BI1AP)

	   + present(BICREV) + present(LOCNPCGAV) + present(LOCGITCV)
	   + present(BICREC) + present(LOCNPCGAC) + present(LOCGITCC)
	   + present(BICREP) + present(LOCNPCGAPAC) + present(LOCGITCP)
	   + present(BICHREV) + present(LOCNPV) + present(LOCGITHCV)
	   + present(BICHREC) + present(LOCNPC) + present(LOCGITHCC)
	   + present(BICHREP) + present(LOCNPPAC) + present(LOCGITHCP) 
           + present(MIBMEUV) + present(MIBGITEV) + present(LOCGITV) + present(MIBNPVENV) + present(MIBNPPRESV) 
	   + present(MIBMEUC) + present(MIBGITEC) + present(LOCGITC) + present(MIBNPVENC) + present(MIBNPPRESC) 
	   + present(MIBMEUP) + present(MIBGITEP) + present(LOCGITP) + present(MIBNPVENP) + present(MIBNPPRESP) 
	   + present(BNCREV) + present(BNCREC) + present(BNCREP) 
	   + present(BNHREV) + present(BNHREC) + present(BNHREP) 
	   + present(BNCPROV) + present(BNCPROC) + present(BNCPROP) 
           + present(BN1AV) + present(BN1AC) + present(BN1AP)

	   + present ( BNCAABV ) + present ( ANOCEP ) + present ( INVENTV ) 
	   + present ( PVINVE ) + present ( BNCAADV ) + present ( DNOCEP ) 
	   + present ( BNCAABC ) + present ( ANOVEP ) + present ( INVENTC ) 
	   + present ( PVINCE ) + present ( BNCAADC ) + present ( DNOCEPC )
	   + present ( BNCAABP ) + present ( ANOPEP ) + present ( INVENTP )
	   + present ( PVINPE ) + present ( BNCAADP ) + present ( DNOCEPP )
	   + present ( BNCNPV ) + present ( BNCNPC ) + present ( BNCNPP ) 

	   ;

SOMMEA538VB =  present( BAFORESTV ) + present( BAFPVV ) + present( BACREV ) + present( 4BACREV ) 
	     + present( BAHREV ) + present( 4BAHREV ) + present( MIBVENV ) + present( MIBPRESV ) 
	     + present( MIBPVV ) + present( BICNOV ) + present( LOCPROCGAV ) + present( BIHNOV ) 
	     + present( LOCPROV ) + present( MIBNPVENV ) + present( MIBNPPRESV ) + present( MIBNPPVV ) 
	     + present( BICREV ) + present( LOCNPCGAV ) + present( LOCGITCV ) + present( BICHREV ) 
	     + present( LOCNPV ) + present( LOCGITHCV )
             + present( BNCPROV ) + present( BNCPROPVV ) + present( BNCREV ) + present( BNHREV ) 
	     + present( BNCNPV ) + present( BNCNPPVV ) + present( ANOCEP ) + present( BNCAABV ) 
	     + present( MIBMEUV ) + present( MIBGITEV ) + present( LOCGITV ) + present( INVENTV ) ;

SOMMEA538CB =  present( BAFORESTC ) + present( BAFPVC ) + present( BACREC ) + present( 4BACREC ) 
	     + present( BAHREC ) + present( 4BAHREC ) + present( MIBVENC ) + present( MIBPRESC )
             + present( MIBPVC ) + present( BICNOC ) + present( LOCPROCGAC ) + present( BIHNOC )
             + present( LOCPROC ) + present( MIBNPVENC ) + present( MIBNPPRESC ) + present( MIBNPPVC )
             + present( BICREC ) + present( LOCNPCGAC ) + present( LOCGITCC ) + present( BICHREC ) 
	     + present( LOCNPC ) + present( LOCGITHCC )
             + present( BNCPROC ) + present( BNCPROPVC ) + present( BNCREC ) + present( BNHREC )
	     + present( BNCNPC ) + present( BNCNPPVC ) + present( ANOVEP ) + present( BNCAABC ) 
	     + present( MIBMEUC ) + present( MIBGITEC ) + present( LOCGITC ) + present( INVENTC ) ;

SOMMEA538PB =  present( BAFORESTP ) + present( BAFPVP ) + present( BACREP ) + present( 4BACREP ) 
	     + present( BAHREP ) + present( 4BAHREP ) + present( MIBVENP ) + present( MIBPRESP )
             + present( MIBPVP ) + present( BICNOP ) + present( LOCPROCGAP ) + present( BIHNOP )
	     + present( LOCPROP ) + present( MIBNPVENP ) + present( MIBNPPRESP ) + present( MIBNPPVP )
             + present( BICREP ) + present( LOCNPCGAPAC ) + present( LOCGITCP ) + present( BICHREP ) 
	     + present( LOCNPPAC ) + present( LOCGITHCP )
	     + present( BNCPROP ) + present( BNCPROPVP ) + present( BNCREP ) + present( BNHREP )
	     + present( BNCNPP ) + present( BNCNPPVP ) + present( ANOPEP ) + present( BNCAABP ) 
	     + present( MIBMEUP ) + present( MIBGITEP ) + present( LOCGITP ) + present( INVENTP ) ;

SOMMEA538VP =  present ( BAF1AV ) + present ( BA1AV ) + present ( MIB1AV ) + present ( BI1AV )
             + present ( MIBNP1AV ) + present ( BI2AV ) + present ( BNCPRO1AV ) + present ( BN1AV )
	     + present ( BNCNP1AV ) + present ( PVINVE ) ;


SOMMEA538CP =  present ( BAF1AC ) + present ( BA1AC ) + present ( MIB1AC ) + present ( BI1AC )
             + present ( MIBNP1AC ) + present ( BI2AC ) + present ( BNCPRO1AC ) + present ( BN1AC )
	     + present ( BNCNP1AC ) + present ( PVINCE ) ;

SOMMEA538PP =  present ( BAF1AP ) + present ( BA1AP ) + present ( MIB1AP ) + present ( BI1AP )
             + present ( MIBNP1AP ) + present ( BI2AP ) + present ( BNCPRO1AP ) + present ( BN1AP )
	     + present ( BNCNP1AP ) + present ( PVINPE ) ;

SOMMEA538 = SOMMEA538VB + SOMMEA538CB + SOMMEA538PB + SOMMEA538VP + SOMMEA538CP + SOMMEA538PP ;

SOMMEA090 =  somme(i=V,C,1..4:TSHALLOi + ALLOi + DETSi + FRNi + PRBRi + PALIi)
            + somme(i=V,C:CARTSi + REMPLAi + PEBFi + CARPEi + PENSALi)
            + somme(i=1..4:CARTSPi + REMPLAPi + PEBFi + CARPEPi + PENSALPi + RVBi)
	    + somme(i=1..3:GLDiV + GLDiC)
	    + RENTAX + RENTAX5 + RENTAX6 + RENTAX7
	    + BPCOSAV + BPCOSAC + GLDGRATV + GLDGRATC
	    ; 

SOMMEA862 =  

      present( MIBEXV ) + present( MIBVENV ) + present( MIBPRESV ) 
    + present( MIBPVV ) + present( MIB1AV ) + present( MIBDEV ) + present( BICPMVCTV )
    + present( MIBEXC ) + present( MIBVENC ) + present( MIBPRESC ) 
    + present( MIBPVC ) + present( MIB1AC ) + present( MIBDEC ) + present( BICPMVCTC ) 
    + present( MIBEXP ) + present( MIBVENP ) + present( MIBPRESP ) 
    + present( MIBPVP ) + present( MIB1AP ) + present( MIBDEP ) + present( BICPMVCTP ) 
    + present( BICEXV ) + present( BICNOV ) + present( LOCPROCGAV ) 
    + present( BI1AV ) + present( BICDNV ) + present( LOCDEFPROCGAV ) 
    + present( BICEXC ) + present( BICNOC ) + present( LOCPROCGAC ) 
    + present( BI1AC ) + present( BICDNC ) + present( LOCDEFPROCGAC ) 
    + present( BICEXP ) + present( BICNOP ) + present( LOCPROCGAP ) 
    + present( BI1AP ) + present( BICDNP ) + present( LOCDEFPROCGAP ) 
    + present( BIHEXV ) + present( BIHNOV ) + present( LOCPROV ) + present( BIHDNV ) + present( LOCDEFPROV ) 
    + present( BIHEXC ) + present( BIHNOC ) + present( LOCPROC ) + present( BIHDNC ) + present( LOCDEFPROC )
    + present( BIHEXP ) + present( BIHNOP ) + present( LOCPROP ) + present( BIHDNP ) + present( LOCDEFPROP ) 

    + present( MIBMEUV ) + present( MIBGITEV ) + present( LOCGITV ) + present( MIBNPEXV ) + present( MIBNPVENV ) 
    + present( MIBNPPRESV ) + present( MIBNPPVV ) + present( MIBNP1AV ) + present( MIBNPDEV ) 
    + present( MIBMEUC ) + present( MIBGITEC ) + present( LOCGITC ) + present( MIBNPEXC ) + present( MIBNPVENC ) 
    + present( MIBNPPRESC ) + present( MIBNPPVC ) + present( MIBNP1AC ) + present( MIBNPDEC ) 
    + present( MIBMEUP ) + present( MIBGITEP ) + present( LOCGITP ) + present( MIBNPEXP ) + present( MIBNPVENP ) 
    + present( MIBNPPRESP ) + present( MIBNPPVP ) + present( MIBNP1AP ) + present( MIBNPDEP ) 
    + present( MIBNPDCT )
    + present( BICNPEXV ) + present( BICREV ) + present( LOCNPCGAV ) + present( LOCGITCV )
    + present( BI2AV ) + present( BICDEV ) + present( LOCDEFNPCGAV )
    + present( BICNPEXC ) + present( BICREC ) + present( LOCNPCGAC ) + present( LOCGITCC )
    + present( BI2AC ) + present( BICDEC ) + present( LOCDEFNPCGAC )
    + present( BICNPEXP ) + present( BICREP ) + present( LOCNPCGAPAC ) + present( LOCGITCP )
    + present( BI2AP ) + present( BICDEP ) + present( LOCDEFNPCGAPAC )
    + present( BICNPHEXV ) + present( BICHREV ) + present( LOCNPV )
    + present( LOCGITHCV ) + present( BICHDEV ) + present( LOCDEFNPV ) 
    + present( BICNPHEXC ) + present( BICHREC ) + present( LOCNPC ) 
    + present( LOCGITHCC ) + present( BICHDEC ) + present( LOCDEFNPC ) 
    + present( BICNPHEXP ) + present( BICHREP ) + present( LOCNPPAC ) 
    + present( LOCGITHCP ) + present( BICHDEP ) + present( LOCDEFNPPAC )

    + present( BNCPROEXV ) + present( BNCPROV ) + present( BNCPROPVV ) 
    + present( BNCPRO1AV ) + present( BNCPRODEV ) + present( BNCPMVCTV )
    + present( BNCPROEXC ) + present( BNCPROC ) + present( BNCPROPVC ) 
    + present( BNCPRO1AC ) + present( BNCPRODEC ) + present( BNCPMVCTC )
    + present( BNCPROEXP ) + present( BNCPROP ) + present( BNCPROPVP ) 
    + present( BNCPRO1AP ) + present( BNCPRODEP ) + present( BNCPMVCTP )
    + present( BNCPMVCTV ) 
    + present( BNCEXV ) + present( BNCREV ) + present( BN1AV ) + present( BNCDEV ) 
    + present( BNCEXC ) + present( BNCREC ) + present( BN1AC ) + present( BNCDEC )
    + present( BNCEXP ) + present( BNCREP ) + present( BN1AP ) + present( BNCDEP ) 
    + present( BNHEXV ) + present( BNHREV ) + present( BNHDEV ) 
    + present( BNHEXC ) + present( BNHREC ) + present( BNHDEC ) 
    + present( BNHEXP ) + present( BNHREP ) + present( BNHDEP ) 

    + present( XSPENPV ) + present( BNCNPV ) + present( BNCNPPVV ) + present( BNCNP1AV ) + present( BNCNPDEV )
    + present( XSPENPC ) + present( BNCNPC ) + present( BNCNPPVC ) + present( BNCNP1AC ) + present( BNCNPDEC ) 
    + present( XSPENPP ) + present( BNCNPP ) + present( BNCNPPVP ) + present( BNCNP1AP ) + present( BNCNPDEP ) 
    + present( BNCNPDCT ) 
    + present( BNCNPREXAAV ) + present( BNCAABV ) + present( BNCAADV ) + present( BNCNPREXV )
    + present( ANOCEP ) + present( DNOCEP ) + present( PVINVE ) + present( INVENTV )
    + present( BNCNPREXAAC ) + present( BNCAABC ) + present( BNCAADC ) + present( BNCNPREXC ) 
    + present( ANOVEP ) + present( DNOCEPC ) + present( PVINCE ) + present( INVENTC )
    + present( BNCNPREXAAP ) + present( BNCAABP ) + present( BNCAADP ) + present( BNCNPREXP ) 
    + present( ANOPEP ) + present( DNOCEPP ) + present( PVINPE ) + present( INVENTP )
	    ;

SOMMEDD55 =

 somme(i=V,C,1,2,3,4: present(TSHALLOi) + present(ALLOi) +  present(PRBRi) + present(PALIi) + present(PENINi))
 + present ( CARTSV ) + present ( CARTSC ) + present ( CARTSP1 )
 + present ( CARTSP2 ) + present ( CARTSP3) + present ( CARTSP4 )
 + present ( CARTSNBAV ) + present ( CARTSNBAC ) + present ( CARTSNBAP1 )
 + present ( CARTSNBAP2 ) + present ( CARTSNBAP3) + present ( CARTSNBAP4 )
 + present ( REMPLAV ) + present ( REMPLAC ) + present ( REMPLAP1 )
 + present ( REMPLAP2 ) + present ( REMPLAP3 ) + present ( REMPLAP4 )
 + present ( REMPLANBV ) + present ( REMPLANBC ) + present ( REMPLANBP1 )
 + present ( REMPLANBP2 ) + present ( REMPLANBP3 ) + present ( REMPLANBP4 )
 + present ( CARPEV ) + present ( CARPEC ) + present ( CARPEP1 )
 + present ( CARPEP2 ) + present ( CARPEP3 ) + present ( CARPEP4 )
 + present ( CARPENBAV ) + present ( CARPENBAC ) + present ( CARPENBAP1 )
 + present ( CARPENBAP2 ) + present ( CARPENBAP3 ) + present ( CARPENBAP4 )
 + present ( PENSALV ) + present ( PENSALC ) + present ( PENSALP1 )
 + present ( PENSALP2 ) + present ( PENSALP3 ) + present ( PENSALP4 )
 + present ( PENSALNBV ) + present ( PENSALNBC ) + present ( PENSALNBP1 )
 + present ( PENSALNBP2 ) + present ( PENSALNBP3 ) + present ( PENSALNBP4 )
 + present ( PCAPTAXV ) + present ( PCAPTAXC )
 + present(CODRAZ) + present(CODRBZ) + present(CODRCZ) + present(CODRDZ) + present(CODREZ) + present(CODRFZ)

 + present ( BACREV ) + present ( 4BACREV ) + present ( BA1AV ) + present ( BACDEV )
 + present ( BACREC ) + present ( 4BACREC ) + present ( BA1AC ) + present ( BACDEC )
 + present ( BACREP ) + present ( 4BACREP ) + present ( BA1AP ) + present ( BACDEP )
 + present ( BAHREV ) + present ( 4BAHREV ) + present ( BAHDEV ) 
 + present ( BAHREC ) + present ( 4BAHREC ) + present ( BAHDEC ) 
 + present ( BAHREP ) + present ( 4BAHREP ) + present ( BAHDEP )

 + present ( BICNOV ) + present ( BI1AV )
 + present ( BICDNV ) + present ( BICNOC )
 + present ( BI1AC ) + present ( BICDNC )
 + present ( BICNOP ) 
 + present ( BI1AP ) + present ( BICDNP ) 
 + present ( BIHNOV ) + present ( BIHDNV )
 + present ( BIHNOC ) 
 + present ( BIHDNC ) + present ( BIHNOP )
 + present ( BIHDNP ) 
 + present ( MIBVENV ) + present ( MIBPRESV ) + present ( MIB1AV )
 + present ( MIBDEV ) + present ( MIBVENC ) + present ( MIBPRESC )
 + present ( MIB1AC ) + present ( MIBDEC ) + present ( MIBVENP )
 + present ( MIBPRESP ) + present ( MIB1AP ) + present ( MIBDEP )
 + present(LOCPROCGAV) + present(LOCDEFPROCGAV) + present( LOCPROCGAC)
 + present(LOCDEFPROCGAC) + present(LOCPROCGAP) + present(LOCDEFPROCGAP)
 + present(LOCPROV) + present(LOCDEFPROV) + present(LOCPROC)
 + present(LOCDEFPROC) + present(LOCPROP) + present(LOCDEFPROP)

 + present(BICREV) + present(LOCNPCGAV) + present ( BI2AV ) + present ( BICDEV ) + present(LOCDEFNPCGAV) 
 + present(BICREC) + present(LOCNPCGAC) + present ( BI2AC ) + present ( BICDEC ) + present(LOCDEFNPCGAC)
 + present(BICREP) + present(LOCNPCGAPAC) + present ( BI2AP ) + present ( BICDEP ) + present(LOCDEFNPCGAPAC)
 + present(BICHREV) + present(LOCNPV) + present(BICHDEV) + present(LOCDEFNPV)
 + present(BICHREC) + present(LOCNPC) + present(BICHDEC) + present(LOCDEFNPC)
 + present(BICHREP) + present(LOCNPPAC) + present(BICHDEP) + present(LOCDEFNPPAC) 
 + present(MIBNPVENV) + present(MIBNPPRESV) + present(MIBNP1AV) + present(MIBNPDEV) 
 + present(MIBNPVENC) + present(MIBNPPRESC) + present(MIBNP1AC) + present(MIBNPDEC) 
 + present(MIBNPVENP) + present(MIBNPPRESP) + present(MIBNP1AP) + present(MIBNPDEP)
 + present(MIBMEUV) + present(MIBGITEV)
 + present(MIBMEUC) + present(MIBGITEC)
 + present(MIBMEUP) + present(MIBGITEP)
 + present(LOCGITCV ) + present(LOCGITCC) + present(LOCGITCP)
 + present(LOCGITHCV) + present(LOCGITHCC) + present(LOCGITHCP)
 + present(LOCGITV) + present(LOCGITC) + present(LOCGITP)

 + present ( BNCREV ) + present ( BN1AV ) + present ( BNCDEV )
 + present ( BNCREC ) + present ( BN1AC ) + present ( BNCDEC )
 + present ( BNCREP ) + present ( BN1AP ) + present ( BNCDEP )
 + present ( BNHREV ) + present ( BNHDEV ) 
 + present ( BNHREC ) + present ( BNHDEC ) 
 + present ( BNHREP ) + present ( BNHDEP )
 + present ( BNCPROV ) + present ( BNCPRO1AV ) + present ( BNCPRODEV )
 + present ( BNCPROC ) + present ( BNCPRO1AC ) + present ( BNCPRODEC )
 + present ( BNCPROP ) + present ( BNCPRO1AP ) + present ( BNCPRODEP )

 + present ( BNCNPV ) + present ( BNCNP1AV ) + present ( BNCNPDEV )
 + present ( BNCNPC ) + present ( BNCNP1AC ) + present ( BNCNPDEC )
 + present ( BNCNPP ) + present ( BNCNP1AP ) + present ( BNCNPDEP )
 + present ( BNCAABV ) + present ( ANOCEP ) + present ( PVINVE ) + present ( BNCAADV ) + present ( DNOCEP )
 + present ( BNCAABC ) + present ( ANOVEP ) + present ( PVINCE ) + present ( BNCAADC ) + present ( DNOCEPC )
 + present ( BNCAABP ) + present ( ANOPEP ) + present ( PVINPE ) + present ( BNCAADP ) + present ( DNOCEPP )
 + present ( INVENTV ) + present ( INVENTC ) + present ( INVENTP )

 ;

SOMMEA802 = present( AUTOBICVV ) + present ( AUTOBICPV ) + present ( AUTOBICVC ) + present ( AUTOBICPC )
	    + present( AUTOBICVP ) + present ( AUTOBICPP ) 
	    + present( AUTOBNCV ) + present ( AUTOBNCC ) + present ( AUTOBNCP ) 
	    + present ( XHONOAAV ) + present ( XHONOV )
	    + present( XHONOAAC ) + present ( XHONOC ) + present ( XHONOAAP ) + present ( XHONOP ) 
            + present(SALEXTV) + present(SALEXTC) + present(SALEXT1) + present(SALEXT2) + present(SALEXT3) + present(SALEXT4)
            + present(COD1AE) + present(COD1BE) + present(COD1CE) + present(COD1DE) + present(COD1EE) + present(COD1FE)
            + present(COD1AH) + present(COD1BH) + present(COD1CH) + present(COD1DH) + present(COD1EH) + present(COD1FH)
            ;

regle 951100:
application : iliad , batch ;  


SOMMEANOEXP = positif ( PEBFV ) + positif ( COTFV ) + positif ( PEBFC ) + positif ( COTFC ) 
              + positif ( PEBF1 ) + positif ( COTF1 ) + positif ( PEBF2 ) + positif ( COTF2 ) 
              + positif ( PEBF3 ) + positif ( COTF3 ) + positif ( PEBF4 ) + positif ( COTF4 ) 
              + positif ( PENSALV ) + positif ( PENSALNBV ) + positif ( PENSALC ) + positif ( PENSALNBC )
              + positif ( PENSALP1 ) + positif ( PENSALNBP1 ) + positif ( PENSALP2 ) + positif ( PENSALNBP2 )
              + positif ( PENSALP3 ) + positif ( PENSALNBP3 ) + positif ( PENSALP4 ) + positif ( PENSALNBP4 )
              + positif ( CARPEV ) + positif ( CARPENBAV ) + positif ( CARPEC ) + positif ( CARPENBAC )
              + positif ( CARPEP1 ) + positif ( CARPENBAP1 ) + positif ( CARPEP2 ) + positif ( CARPENBAP2 )
              + positif ( CARPEP3 ) + positif ( CARPENBAP3 ) + positif ( CARPEP4 ) + positif ( CARPENBAP4 )
              + positif ( CARTSP1 ) + positif ( CARTSNBAP1 ) + positif ( CARTSP2 ) + positif ( CARTSNBAP2 ) 
              + positif ( CARTSP3 ) + positif ( CARTSNBAP3 ) + positif ( CARTSP4 ) + positif ( CARTSNBAP4 ) 
              + positif ( REMPLAV ) + positif ( REMPLANBV ) + positif ( REMPLAC ) + positif ( REMPLANBC )
              + positif ( REMPLAP1 ) + positif ( REMPLANBP1 ) + positif ( REMPLAP2 ) + positif ( REMPLANBP2 )
              + positif ( REMPLAP3 ) + positif ( REMPLANBP3 ) + positif ( REMPLAP4 ) + positif ( REMPLANBP4 )
              + positif ( RENTAX ) + positif ( RENTAX5 ) + positif ( RENTAX6 ) + positif ( RENTAX7 )
              + positif ( RENTAXNB ) + positif ( RENTAXNB5 ) + positif ( RENTAXNB6 ) + positif ( RENTAXNB7 )
              + positif ( FONCI ) + positif ( FONCINB ) + positif ( REAMOR ) + positif ( REAMORNB )
              + positif ( REVACT ) + positif ( REVACTNB ) + positif ( REVPEA ) + positif ( REVPEANB )
              + positif ( PROVIE ) + positif ( PROVIENB ) + positif ( DISQUO ) + positif ( DISQUONB )
              + positif ( RESTUC ) + positif ( RESTUCNB ) + positif ( INTERE ) + positif ( INTERENB )
              + positif( 4BACREV ) + positif( 4BAHREV ) + positif( 4BACREC )
              + positif( 4BAHREC ) + positif( 4BACREP ) + positif( 4BAHREP )
              + positif(CODRAZ) + positif(CODRBZ) + positif(CODRCZ) + positif(CODRDZ) + positif(CODREZ) + positif(CODRFZ)
              + positif(CODNAZ) + positif(CODNBZ) + positif(CODNCZ) + positif(CODNDZ) + positif(CODNEZ) + positif(CODNFZ)
              + positif(CODRVG) + positif(CODNVG)
              + 0
             ;

regle 951110:
application : iliad , batch ;  

SOMMEA709 = positif(RINVLOCINV) + positif(RINVLOCREA) + positif(REPINVTOU) 
            + positif(INVLOGREHA) + positif(INVLOCXN) + positif(INVLOCXV) + positif(COD7UY) + positif(COD7UZ)
            + 0 ;

regle 951120:
application : iliad , batch ;  

SOMMEA739 = positif(INVOMSOCKH) + positif(INVOMSOCKI) + positif(INVSOC2010) + positif(INVOMSOCQU) 
	    + positif(INVLOGSOC) + positif(INVOMSOCQJ) + positif(INVOMSOCQS) + positif(INVOMSOCQW) + positif(INVOMSOCQX) 
	    + positif(RETROCOMMB) + positif(RETROCOMMC) + positif(RETROCOMLH) 
	    + positif(RETROCOMLI) + positif(INVRETRO2) + positif(INVDOMRET60) + positif(INVRETRO1) + positif(INVDOMRET50) 
	    + positif(INVOMRETPO) + positif(INVOMRETPT) + positif(INVOMRETPN) + positif(INVOMRETPP) + positif(INVOMRETPS) 
	    + positif(INVOMRETPU) + positif(INVOMENTKT) + positif(INVOMENTKU) + positif(INVIMP) 
	    + positif(INVDIR2009) + positif(INVOMRETPR) + positif(INVOMRETPW) + positif(INVLGAUTRE) + positif(INVLGDEB2010) 
	    + positif(INVLOG2009) + positif(INVOMLOGOB) + positif(INVOMLOGOC) + positif(INVOMLOGOM) + positif(INVOMLOGON)
	    + positif(INVOMRETPB) + positif(INVOMRETPF) + positif(INVOMRETPJ) + positif(INVOMRETPA) + positif(INVOMRETPE) 
	    + positif(INVOMRETPI) + positif(INVOMRETPY) + positif(INVOMRETPX) + positif(INVOMENTRG) + positif(INVOMRETPD) 
	    + positif(INVOMRETPH) + positif(INVOMRETPL) + positif(INVOMENTRI) + positif(INVOMLOGOI) + positif(INVOMLOGOJ) 
	    + positif(INVOMLOGOK) + positif(INVOMLOGOP) + positif(INVOMLOGOQ) + positif(INVOMLOGOR) + positif(INVOMENTRL) 
	    + positif(INVOMENTRQ) + positif(INVOMENTRV) + positif(INVOMENTNV) + positif(INVOMENTRK) + positif(INVOMENTRP)
	    + positif(INVOMENTRU) + positif(INVOMENTNU) + positif(INVOMENTRM) + positif(INVOMENTRR) + positif(INVOMENTRW) 
	    + positif(INVOMENTNW) + positif(INVOMENTRO) + positif(INVOMENTRT) + positif(INVOMENTRY) + positif(INVOMENTNY) 
	    + positif(INVOMLOGOT) + positif(INVOMLOGOU) + positif(INVOMLOGOV) + positif(INVOMLOGOW)
            + positif(CODHOD) + positif(CODHOE) + positif(CODHOF) + positif(CODHOG) + positif(CODHOX) + positif(CODHOY)
            + positif(CODHOZ) + positif(CODHRA) + positif(CODHRB) + positif(CODHRC) + positif(CODHRD)
            + positif(CODHSA) + positif(CODHSB) + positif(CODHSC) + positif(CODHSE) + positif(CODHSF) + positif(CODHSG)
            + positif(CODHSH) + positif(CODHSJ) + positif(CODHSK) + positif(CODHSL) + positif(CODHSM) + positif(CODHSO)
            + positif(CODHSP) + positif(CODHSQ) + positif(CODHSR) + positif(CODHST) + positif(CODHSU) + positif(CODHSV)
            + positif(CODHSW) + positif(CODHSY) + positif(CODHSZ) + positif(CODHTA) + positif(CODHTB) + positif(CODHTD) 
            + positif(CODHAA) + positif(CODHAB) + positif(CODHAC) + positif(CODHAE) + positif(CODHAF) + positif(CODHAG)
            + positif(CODHAH) + positif(CODHAJ) + positif(CODHAK) + positif(CODHAL) + positif(CODHAM) + positif(CODHAO)
            + positif(CODHAP) + positif(CODHAQ) + positif(CODHAR) + positif(CODHAT) + positif(CODHAU) + positif(CODHAV)
            + positif(CODHAW) + positif(CODHAY) + positif(CODHBA) + positif(CODHBB) + positif(CODHBE) + positif(CODHBG)
            + positif(CODHBI) + positif(CODHBJ) + positif(CODHBK) + positif(CODHBL) + positif(CODHBN) + positif(CODHBO)
            + positif(CODHBP) + positif(CODHBQ) + positif(CODHBS) + positif(CODHBT) + positif(CODHBU) + positif(CODHBV)
            + positif(CODHBX) + positif(CODHBY) + positif(CODHBZ) + positif(CODHCA) + positif(CODHCC) + positif(CODHCD)
            + positif(CODHCE) + positif(CODHCF)
            + positif(CODHUA) + positif(CODHUB) + positif(CODHUC) + positif(CODHUD) + positif(CODHUE) + positif(CODHUF)
            + positif(CODHUG) + positif(CODHUH) + positif(CODHUI) + positif(CODHUJ) + positif(CODHUK) + positif(CODHUL)
            + positif(CODHUM) + positif(CODHUN)
            + positif(CODHXA) + positif(CODHXB) + positif(CODHXC) + positif(CODHXE) + positif(CODHXF) + positif(CODHXG) 
            + positif(CODHXH) + positif(CODHXI) + positif(CODHXK) 
	    + 0 ;

regle 951130:
application : iliad , batch ;  

SOMMEA700 = 
          (
   present(BAEXV) + present(BACREV) + present(4BACREV) + present(BA1AV) + present(BACDEV) 
 + present(BAEXC) + present(BACREC) + present(4BACREC) + present(BA1AC) + present(BACDEC) 
 + present(BAEXP) + present(BACREP) + present(4BACREP) + present(BA1AP) + present(BACDEP) 
 + present(BAPERPV) + present(BAPERPC) + present(BAPERPP)
 + present(BANOCGAV) + present(BANOCGAC) + present(BANOCGAP)
 + present(BAHEXV) + present(BAHREV) + present(4BAHREV)
 + present(BAHEXC) + present(BAHREC) + present(4BAHREC)
 + present(BAHEXP) + present(BAHREP) + present(4BAHREP)
 + present(COD5XT) + present(COD5XV) + present(COD5XU) + present(COD5XW)

 + present(BICEXV) + present(BICNOV) + present(LOCPROCGAV)
 + present(BI1AV) + present(BICDNV) + present(LOCDEFPROCGAV)
 + present(BICEXC) + present(BICNOC) + present(LOCPROCGAC)
 + present(BI1AC) + present(BICDNC) + present(LOCDEFPROCGAC)
 + present(BICEXP) + present(BICNOP) + present(LOCPROCGAP)
 + present(BI1AP) + present(BICDNP) + present(LOCDEFPROCGAP)

 + present(BICNPEXV) + present(BICREV) + present(LOCNPCGAV) + present(LOCGITCV)
 + present(BI2AV) + present(BICDEV) + present(LOCDEFNPCGAV)
 + present(BICNPEXC) + present(BICREC) + present(LOCNPCGAC) + present(LOCGITCC)
 + present(BI2AC) + present(BICDEC) + present(LOCDEFNPCGAC)
 + present(BICNPEXP) + present(BICREP) + present(LOCNPCGAPAC) + present(LOCGITCP)
 + present(BI2AP) + present(BICDEP) + present(LOCDEFNPCGAPAC)

 + present(BNCEXV) + present(BNCREV) + present(BN1AV) + present(BNCDEV)
 + present(BNCEXC) + present(BNCREC) + present(BN1AC) + present(BNCDEC)
 + present(BNCEXP) + present(BNCREP) + present(BN1AP) + present(BNCDEP)
 + present(BNHEXV) + present(BNHREV) 
 + present(BNHEXC) + present(BNHREC) 
 + present(BNHEXP) + present(BNHREP) 
 + present(XHONOAAV) + present(XHONOAAC) + present(XHONOAAP)

 + present(BNCNPREXAAV) + present(BNCNPREXV) + present(BNCNPREXAAC)
 + present(BNCNPREXC) + present(BNCNPREXAAP) + present(BNCNPREXP)
 + present(BNCAABV) + present(BNCAADV) + present(ANOCEP) 
 + present(PVINVE) + present(INVENTV)
 + present(BNCAABC) + present(BNCAADC) + present(DNOCEP) 
 + present(ANOVEP) + present(PVINCE) + present(INVENTC)
 + present(BNCAABP) + present(BNCAADP) + present(DNOCEPC)
 + present(ANOPEP) + present(PVINPE) + present(INVENTP)
 + present(DNOCEPP)
          ) ;

regle 951140:
application : iliad , batch ;  

V_CNR  =   (V_REGCO+0) dans (2);
V_CNR2 =   (V_REGCO+0) dans (2,3);
V_EAD  =   (V_REGCO+0) dans (5);
V_EAG  =   (V_REGCO+0) dans (6,7);

regle 951150:
application : iliad , batch ;  

VARIPTEFN =  IPTEFN * (1-positif(SOMMEMOND_2+PREM8_11));
VARIPTEFP = (IPTEFP + max(0,DEFZU*positif(SOMMEMOND_2)*(1-PREM8_11)+DEFZU*PREM8_11 - IPTEFN )) * positif(present(IPTEFP)+present(IPTEFN));

VARDMOND = DMOND* (1-positif(SOMMEMOND_2+PREM8_11));

VARRMOND = (RMOND + max(0,DEFZU*positif(SOMMEMOND_2)*(1-PREM8_11)+DEFZU*PREM8_11 - DMOND)) * positif(present(RMOND)+present(DMOND));

regle 951160:
application : iliad , batch ;  

FLAGRETARD = FLAG_RETARD + 0 ;
FLAGRETARD08 = FLAG_RETARD08 + 0 ;
FLAGDEFAUT = FLAG_DEFAUT + 0 ;
FLAGDEFAUT10 = FLAG_DEFAUT10 + 0 ;
FLAGDEFAUT11 = FLAG_DEFAUT11 + 0 ;

regle 951170:
application : iliad , batch ;  


INDCODDAJ = positif(present(CODDAJ) + present(CODDBJ) + present(CODEAJ) + present(CODEBJ)) ;

regle 951180:
application : iliad , batch ;  


DEFRI = positif(RIDEFRI + DEFRITS + DEFRIBA + DEFRIBIC + DEFRILOC + 
                DEFRIBNC + DEFRIRCM + DEFRIRF + DEFRIGLOB + DEFRIMOND + 0) ;

DEFRIMAJ = positif(DEFRIMAJ_DEF + DEFRI) ;

regle 951190:
application : iliad , batch ;  

SOMMEBAINF = positif(null(SOMMEBA_2+0) + (1-positif(SHBA - SEUIL_IMPDEFBA))) ;
SOMMEBASUP = positif(SOMMEBA_2 * positif(SHBA - SEUIL_IMPDEFBA)) ;
SOMMEGLOB_1 = SOMMEGLOBAL_1 ;
SOMMEGLOB_2 = SOMMEGLOBAL_2 ;
SOMMEBA = SOMMEBA_1 + SOMMEBA_2 ;
SOMMEBIC = SOMMEBIC_1 + SOMMEBIC_2 ;
SOMMELOC = SOMMELOC_1 + SOMMELOC_2 ;
SOMMEBNC = SOMMEBNC_1 + SOMMEBNC_2 ;
SOMMERF = SOMMERF_1 + SOMMERF_2 ;
SOMMERCM = SOMMERCM_1 + SOMMERCM_2 ;

regle 951200:
application : iliad , batch ;

SOMDEFTS =
   FRNV * positif (FRNV - 10MINSV)
 + FRNC * positif (FRNC - 10MINSC)
 + FRN1 * positif (FRN1 - 10MINS1)
 + FRN2 * positif (FRN2 - 10MINS2)
 + FRN3 * positif (FRN3 - 10MINS3)
 + FRN4 * positif (FRN4 - 10MINS4);
SOMDEFBIC =
     BICNOV
   + BIHNOV * MAJREV
   + BICNOC
   + BIHNOC * MAJREV
   + BICNOP
   + BIHNOP * MAJREV 
   - BIPN
   +BICPMVCTV +BICPMVCTC +BICPMVCTP;
SOMDEFBNC =
     BNCREV
    + BNHREV * MAJREV
    + BNCREC
    + BNHREC * MAJREV
    + BNCREP
    + BNHREP * MAJREV
    - BNRTOT
+BNCPMVCTV +BNCPMVCTC +BNCPMVCTP;
SOMDEFLOC =
      LOCPROCGAV
    + LOCPROV * MAJREV
    + LOCPROCGAC
    + LOCPROC * MAJREV
    + LOCPROCGAP
    + LOCPROP * MAJREV
    - PLOCNETF;
SOMDEFANT =
   DEFAA5
 + DEFAA4
 + DEFAA3
 + DEFAA2
 + DEFAA1
 + DEFAA0;
SOMDEFICIT =SOMDEFANT+SOMDEFLOC+SOMDEFBNC
                          +SOMDEFBANI * positif((1-positif(SHBA-SEUIL_IMPDEFBA))*positif(SOMMEBA_2+DAGRIIMP1731))
                          +SOMDEFBANI * positif((1-positif(null(SOMMEBA_2)*positif(DAGRI1731)*null(DAGRIIMP1731)))*(1-positif(SHBA-SEUIL_IMPDEFBA)) *
                                         (1-positif((1-positif(SHBA-SEUIL_IMPDEFBA))*positif(SOMMEBA_2+DAGRIIMP1731))))
                          +SOMDEFTS+SOMDEFBIC+RFDHIS;
SFSOMDEFICIT = SFSOMDEFBANI * positif((1-positif(SHBA-SEUIL_IMPDEFBA))*positif(SOMMEBA_2+DAGRIIMP1731))
              +SFSOMDEFBANI * positif((1-positif(null(SOMMEBA_2)*positif(DAGRI1731)*null(DAGRIIMP1731)))*(1-positif(SHBA-SEUIL_IMPDEFBA)) *
                                         (1-positif((1-positif(SHBA-SEUIL_IMPDEFBA))*positif(SOMMEBA_2+DAGRIIMP1731))));
SOMDEFICITHTS =SOMDEFANT+SOMDEFLOC+SOMDEFBNC
                          +SOMDEFBANI * positif((1-positif(SHBA-SEUIL_IMPDEFBA))*positif(SOMMEBA_2+DAGRIIMP1731))
                          +SOMDEFBANI * positif((1-positif(null(SOMMEBA_2)*positif(DAGRI1731)*null(DAGRIIMP1731)))*(1-positif(SHBA-SEUIL_IMPDEFBA)) *
                                         (1-positif((1-positif(SHBA-SEUIL_IMPDEFBA))*positif(SOMMEBA_2+DAGRIIMP1731))))
                          +SOMDEFBIC+RFDHIS;

regle 951210:
application : iliad , batch ;  

DEFRITS = positif(
                positif(max(FRNV,10MINSV)-max(FRDV,10MINSV)) 
              + positif(max(FRNC,10MINSC)-max(FRDC,10MINSC)) 
              + positif(max(FRN1,10MINS1)-max(FRD1,10MINS1)) 
              + positif(max(FRN2,10MINS2)-max(FRD2,10MINS2)) 
              + positif(max(FRN3,10MINS3)-max(FRD3,10MINS3)) 
              + positif(max(FRN4,10MINS4)-max(FRD4,10MINS4))) ;
DEFRIBA =  positif(DEFBANIF)+0;
DEFRIBIC = positif(DEFBICNPF)+0;
DEFRILOC = positif(DEFLOCNPF)+0;
DEFRIBNC = positif(DEFBNCNPF)+0;
DEFRIRCM = positif(positif(RCMFRTEMP-RCMFRART1731) + positif(min(REPRCM,REPRCMB)-REPRCMBIS)+0);
DEFRIRF =  positif(DEFRFNONI)+0;
DEFRIGLOB = positif(DFANTIMPU)+0;
DEFRIMOND = positif(positif(TEFFP_2-TEFFP_1)+positif(TEFFN_2*(-1)-TEFFN_1*(-1)) +positif(RMOND_2-RMOND_1)+positif(DMOND_2*(-1)-DMOND_1*(-1)))+0;

regle 951220:
application : iliad ;


ANO1731 = positif(RIDEFRI) *  positif(SOMMERI_1);
