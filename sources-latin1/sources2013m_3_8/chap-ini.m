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
regle irisf 1:
application : bareme,batch,iliad;
BIDON=1;

regle irisf 1000140:
application :  iliad;
APPLI_GP      = 0 ;
APPLI_ILIAD   = 1 ;
APPLI_BATCH   = 0 ;
regle irisf 1000150:
application :  batch;
APPLI_GP      = 0 ;
APPLI_ILIAD   = 0 ;
APPLI_BATCH   = 1 ;
regle 1000717:
application : batch, iliad ;
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

regle 1000718:
application : batch, iliad ;

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

regle 1000719:
application : batch, iliad ;

SOMMEA719 = (

   present( BAEXV ) + present ( BACREV ) + present( 4BACREV ) + present ( BA1AV ) + present ( BACDEV ) 
 + present( BAEXC ) + present ( BACREC ) + present( 4BACREC ) + present ( BA1AC ) + present ( BACDEC ) 
 + present( BAEXP ) + present ( BACREP ) + present( 4BACREP ) + present ( BA1AP ) + present ( BACDEP ) 
 + present( BAHEXV ) + present ( BAHREV ) + present( 4BAHREV ) + present ( BAHDEV ) 
 + present( BAHEXC ) + present ( BAHREC ) + present( 4BAHREC ) + present ( BAHDEC ) 
 + present( BAHEXP ) + present ( BAHREP ) + present( 4BAHREP ) + present ( BAHDEP ) 

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

regle 1000530:
application : batch, iliad;

SOMMEA030 =     
                somme(i=1..4: positif(TSHALLOi) + positif(ALLOi)
		+ positif(CARTSPi) + positif(REMPLAPi)
		+ positif(CARTSNBAPi) + positif(REMPLANBPi)
		+ positif(HEURESUPPi)
                + positif(PRBRi)
		+ positif(CARPEPi) + positif(CARPENBAPi)
                + positif(PALIi) + positif(FRNi) + positif(PPETPPi) + positif(PPENHPi)
		+ positif(PENSALPi) + positif(PENSALNBPi)
		)
 + positif(RSAPAC1) + positif(RSAPAC2)
 + positif(FEXP)  + positif(BAFP)  + positif(BAFORESTP) + positif(BAFPVP)  + positif(BAF1AP)
 + positif(BAEXP)  + positif(BACREP) + positif(4BACREP)  
 + positif(BA1AP)  + positif(BACDEP * (1 - positif(ART1731BIS) ))
 + positif(BAHEXP)  + positif(BAHREP) + positif(4BAHREP) 
 + positif(BAHDEP * (1 - positif(ART1731BIS) )) 
 + positif(MIBEXP) + positif(MIBVENP) + positif(MIBPRESP)  + positif(MIBPVP)  + positif(MIB1AP)  + positif(MIBDEP)
 + positif(BICPMVCTP) + positif(BICEXP) + positif(BICNOP) + positif(BI1AP)  
 + positif(BICDNP * (1 - positif(ART1731BIS) )) 
 + positif(BIHEXP) + positif(BIHNOP) + positif(BIHDNP * (1 - positif(ART1731BIS) ))  
 + positif(MIBNPEXP)  + positif(MIBNPVENP)  + positif(MIBNPPRESP)  + positif(MIBNPPVP)  + positif(MIBNP1AP)  + positif(MIBNPDEP)
 + positif(BICNPEXP)  + positif(BICREP) + positif(BI2AP)  + positif(min(BICDEP,BICDEP1731+0) * positif(ART1731BIS) + BICDEP * (1 - ART1731BIS))  
 + positif(BICNPHEXP) + positif(BICHREP) + positif(min(BICHDEP,BICHDEP1731+0) * positif(ART1731BIS) + BICHDEP * (1 - ART1731BIS)) 
 + positif(BNCPROEXP)  + positif(BNCPROP)  + positif(BNCPROPVP)  + positif(BNCPRO1AP)  + positif(BNCPRODEP) + positif(BNCPMVCTP)
 + positif(BNCEXP)  + positif(BNCREP) + positif(BN1AP) 
 + positif(BNCDEP * (1 - positif(ART1731BIS) ))
 + positif(BNHEXP)  + positif(BNHREP)  + positif(BNHDEP * (1 - positif(ART1731BIS) )) + positif(BNCCRP)
 + positif(BNCNPP)  + positif(BNCNPPVP)  + positif(BNCNP1AP)  + positif(BNCNPDEP)
 + positif(ANOPEP) + positif(PVINPE) + positif(INVENTP) + positif(min(DNOCEPP,DNOCEPP1731+0) * positif(ART1731BIS) + DNOCEPP * (1 - ART1731BIS)) + positif(BNCCRFP)
 + positif(BNCAABP) + positif(min(BNCAADP,BNCAADP1731+0) * positif(ART1731BIS) + BNCAADP * (1 - ART1731BIS))
 + positif(RCSP) + positif(PPEACP) + positif(PPENJP)
 + positif(BAPERPP) + positif(BIPERPP) 
 + positif(PERPP) + positif(PERP_COTP) + positif(RACCOTP) + positif(PLAF_PERPP)
 + somme(i=1..4: positif(PEBFi))
 + positif( COTF1 ) + positif( COTF2 ) + positif( COTF3 ) + positif( COTF4 )
 + positif (BNCNPREXAAP) + positif (BNCNPREXP)
 + positif(AUTOBICVP) + positif(AUTOBICPP) 
 + positif(AUTOBNCP) + positif(LOCPROCGAP) 
 + positif(LOCDEFPROCGAP * (1 - positif(ART1731BIS) ))
 + positif(LOCPROP) + positif(LOCDEFPROP * (1 - positif(ART1731BIS) )) 
 + positif(LOCNPCGAPAC) + positif(LOCGITCP) + positif(LOCGITHCP) 
 + positif(min(LOCDEFNPCGAPAC,LOCDEFNPCGAPAC1731+0) * positif(ART1731BIS) + LOCDEFNPCGAPAC * (1 - ART1731BIS))
 + positif(LOCNPPAC) + positif(min(LOCDEFNPPAC,LOCDEFNPPAC1731+0) * positif(ART1731BIS) + LOCDEFNPPAC * (1 - ART1731BIS)) 
 + positif(XHONOAAP) + positif(XHONOP) + positif(XSPENPP)
 + positif(BANOCGAP) + positif(MIBMEUP) + positif(MIBGITEP) + positif(LOCGITP) 
 + positif(SALEXT1) + positif(COD1CD) + positif(COD1CE) + positif(PPEXT1) + positif(COD1CH)
 + positif(SALEXT2) + positif(COD1DD) + positif(COD1DE) + positif(PPEXT2) + positif(COD1DH)
 + positif(SALEXT3) + positif(COD1ED) + positif(COD1EE) + positif(PPEXT3) + positif(COD1EH)
 + positif(SALEXT4) + positif(COD1FD) + positif(COD1FE) + positif(PPEXT4) + positif(COD1FH)
 + positif(RDSYPP)
 + 0 ;

regle 1000531:
application : batch, iliad;

SOMMEA031 = (

   positif( TSHALLOC ) + positif( ALLOC ) + positif( HEURESUPC ) + positif( PRBRC ) 
 + positif( PALIC ) + positif( GSALC ) + positif( TSASSUC ) + positif( XETRANC ) 
 + positif( TSELUPPEC ) + positif( EXOCETC ) + positif( FRNC ) 
 + positif( PPETPC ) + positif( PPENHC )  + positif( PCAPTAXC )
 + positif( CARTSC ) + positif( PENSALC ) + positif( REMPLAC ) + positif( CARPEC ) 
 + positif( GLDGRATC ) 
 + positif( GLD1C ) + positif( GLD2C ) + positif( GLD3C ) 

 + positif( BPV18C ) + positif( BPCOPTC ) + positif( BPV40C )
 + positif( BPCOSAC ) + positif( CVNSALAC )

 + positif( FEXC ) + positif( BAFC ) + positif( BAFORESTC ) + positif( BAFPVC ) + positif( BAF1AC ) 
 + positif( BAEXC ) + positif( BACREC ) + positif( 4BACREC ) + positif( BA1AC ) 
 + positif(BACDEC * (1 - positif(ART1731BIS) )) 
 + positif( BAHEXC ) + positif( BAHREC ) + positif( 4BAHREC ) 
 + positif (BAHDEC * (1 - positif(ART1731BIS) ))   + positif( BAPERPC ) + positif( BANOCGAC ) 
 + positif( AUTOBICVC ) + positif( AUTOBICPC ) + positif( AUTOBNCC ) 
 + positif( MIBEXC ) + positif( MIBVENC ) + positif( MIBPRESC ) + positif( MIBPVC ) 
 + positif( MIB1AC ) + positif( MIBDEC ) + positif( BICPMVCTC )
 + positif( BICEXC ) + positif( BICNOC ) + positif( LOCPROCGAC ) + positif( BI1AC ) 
 + positif (BICDNC * (1 - positif(ART1731BIS) ))  
 + positif (LOCDEFPROCGAC * (1 - positif(ART1731BIS) ))
 + positif( BIHEXC ) + positif( BIHNOC ) + positif( LOCPROC ) + positif(BIHDNC * (1 - positif(ART1731BIS) ))  
 + positif (LOCDEFPROC * (1 - positif(ART1731BIS) )) 
 + positif( BIPERPC ) 
 + positif( MIBNPEXC ) + positif( MIBNPVENC ) + positif( MIBNPPRESC ) + positif( MIBNPPVC ) + positif( MIBNP1AC ) + positif( MIBNPDEC ) 
 + positif( BICNPEXC ) + positif( BICREC ) + positif( LOCNPCGAC ) + positif( BI2AC ) 
 + positif (min(BICDEC,BICDEC1731+0) * positif(ART1731BIS) + BICDEC * (1 - ART1731BIS))
 + positif (min(LOCDEFNPCGAC,LOCDEFNPCGAC1731+0) * positif(ART1731BIS) + LOCDEFNPCGAC * (1 - ART1731BIS))
 + positif( MIBMEUC ) + positif( MIBGITEC ) + positif( LOCGITC ) + positif( LOCGITCC ) + positif( LOCGITHCC )
 + positif( BICNPHEXC ) + positif( BICHREC ) + positif( LOCNPC ) 
 + positif (min(BICHDEC,BICHDEC1731+0) * positif(ART1731BIS) + BICHDEC * (1 - ART1731BIS)) 
 + positif (min(LOCDEFNPC,LOCDEFNPC1731+0) * positif(ART1731BIS) + LOCDEFNPC * (1 - ART1731BIS)) 
 + positif( BNCPROEXC ) + positif( BNCPROC ) + positif( BNCPROPVC ) + positif( BNCPRO1AC ) + positif( BNCPRODEC ) + positif( BNCPMVCTC )
 + positif( BNCEXC ) + positif( BNCREC ) + positif( BN1AC ) 
 + positif (BNCDEC * (1 - positif(ART1731BIS) ))  
 + positif( BNHEXC ) + positif( BNHREC ) + positif (BNHDEC * (1 - positif(ART1731BIS) )) + positif( BNCCRC ) + positif( CESSASSC )
 + positif( XHONOAAC ) + positif( XHONOC ) + positif( XSPENPC )
 + positif( BNCNPC ) + positif( BNCNPPVC ) + positif( BNCNP1AC ) + positif( BNCNPDEC ) 
 + positif( BNCNPREXAAC ) + positif( BNCAABC ) + positif(min(BNCAADC,BNCAADC1731+0) * positif(ART1731BIS) + BNCAADC * (1 - ART1731BIS)) + positif( BNCNPREXC ) + positif( ANOVEP )
 + positif( PVINCE ) + positif( INVENTC ) + positif (min(DNOCEPC,DNOCEPC1731+0) * positif(ART1731BIS) + DNOCEPC * (1 - ART1731BIS)) + positif( BNCCRFC )
 + positif( RCSC ) + positif( PVSOCC ) + positif( PPEACC ) + positif( PPENJC ) 
 + positif( PEBFC ) 
 + positif( PERPC ) + positif( PERP_COTC ) + positif( RACCOTC ) + positif( PLAF_PERPC )
 + positif( PERPPLAFCC ) + positif( PERPPLAFNUC1 ) + positif( PERPPLAFNUC2 ) + positif( PERPPLAFNUC3 )
 + positif( ELURASC )
 + positif(CODDBJ) + positif(CODEBJ)  
 + positif(SALEXTC) + positif(COD1BD) + positif(COD1BE) + positif(PPEXTC) + positif(COD1BH)
 + positif(RDSYCJ)

 + 0 ) ;
regle 1000804:
application : iliad , batch;  


SOMMEA804 = SOMMEANOEXP 
	    + positif ( GLD1V ) + positif ( GLD2V ) + positif ( GLD3V ) 
            + positif ( GLD1C ) + positif ( GLD2C ) + positif ( GLD3C ) 
           ;

SOMMEA805 = SOMMEANOEXP + positif(CODDAJ) + positif(CODEAJ) + positif(CODDBJ) + positif(CODEBJ) ;

regle 1000993:
application : iliad ;  



INDAUTREQUE9YA = positif (positif( 4BACREC ) + positif( 4BACREP ) + positif( 4BACREV )
 + positif( 4BAHREC ) + positif( 4BAHREP ) + positif( 4BAHREV )
 + positif( ABDETMOINS ) + positif( ABDETPLUS ) + positif( ABIMPMV )
 + positif( ABIMPPV ) + positif( ABPVNOSURSIS ) 
 + positif( ACODELAISINR ) + positif( ALLECS ) + positif( ALLO1 )
 + positif( ALLO2 ) + positif( ALLO3 ) + positif( ALLO4 )
 + positif( ALLOC ) + positif( ALLOV ) + positif( ANOCEP )
 + positif( ANOPEP ) + positif( ANOVEP ) + positif( ASCAPA )
 + positif( AUTOBICPC ) + positif( AUTOBICPP ) + positif( AUTOBICPV )
 + positif( AUTOBICVC ) + positif( AUTOBICVP ) + positif( AUTOBICVV )
 + positif( AUTOBNCC ) + positif( AUTOBNCP ) + positif( AUTOBNCV )
 + positif( AUTOVERSLIB ) + positif( AUTOVERSSUP ) + positif( AVETRAN )
 + positif( BA1AC ) + positif( BA1AP ) + positif( BA1AV )
 + positif (BACDEC * (1 - positif(ART1731BIS) )) 
 + positif (BACDEP * (1 - positif(ART1731BIS) )) 
 + positif (BACDEV * (1 - positif(ART1731BIS) ))
 + positif( BACREC ) + positif( BACREP ) + positif( BACREV )
 + positif( BAEXC ) + positif( BAEXP ) + positif( BAEXV )
 + positif( BAF1AC ) + positif( BAF1AP ) + positif( BAF1AV )
 + positif( BAFC ) + positif( BAFORESTC ) + positif( BAFORESTP )
 + positif( BAFORESTV ) + positif( BAFP ) + positif( BAFPVC )
 + positif( BAFPVP ) + positif( BAFPVV ) + positif( BAFV )
 + positif (BAHDEC * (1 - positif(ART1731BIS) )) 
 + positif (BAHDEP * (1 - positif(ART1731BIS) )) 
 + positif (BAHDEV * (1 - positif(ART1731BIS) ))
 + positif( BAHEXC ) + positif( BAHEXP ) + positif( BAHEXV )
 + positif( BAHREC ) + positif( BAHREP ) + positif( BAHREV )
 + positif( BAILOC98 ) + positif( BANOCGAC ) + positif( BANOCGAP )
 + positif( BANOCGAV ) + positif( BAPERPC ) + positif( BAPERPP )
 + positif( BAPERPV ) + positif( BASRET ) + positif( BI1AC )
 + positif( BI1AP ) + positif( BI1AV ) + positif( BI2AC )
 + positif( BI2AP ) + positif( BI2AV ) + positif(min(BICDEC,BICDEC1731+0) * positif(ART1731BIS) + BICDEC * (1 - ART1731BIS)) 
 + positif (min(BICDEP,BICDEP1731+0) * positif(ART1731BIS) + BICDEP * (1 - ART1731BIS)) 
 + positif (min(BICDEV,BICDEV1731+0) * positif(ART1731BIS) + BICDEV * (1 - ART1731BIS)) 
 + positif (BICDNC * (1 - positif(ART1731BIS) ))
 + positif (BICDNP * (1 - positif(ART1731BIS) )) 
 + positif (BICDNV * (1 - positif(ART1731BIS) ))
 + positif( BICEXC )
 + positif( BICEXP ) + positif( BICEXV ) 
 + positif (min(BICHDEC,BICHDEC1731+0) * positif(ART1731BIS) + BICHDEC * (1 - ART1731BIS))
 + positif (min(BICHDEP,BICHDEP1731+0) * positif(ART1731BIS) + BICHDEP * (1 - ART1731BIS)) 
 + positif (min(BICHDEV,BICHDEV1731+0) * positif(ART1731BIS) + BICHDEV * (1 - ART1731BIS))
 + positif( BICHREC )
 + positif( BICHREP ) + positif( BICHREV ) + positif( BICNOC )
 + positif( BICNOP ) + positif( BICNOV ) + positif( BICNPEXC )
 + positif( BICNPEXP ) + positif( BICNPEXV ) + positif( BICNPHEXC )
 + positif( BICNPHEXP ) + positif( BICNPHEXV ) + positif( BICPMVCTC )
 + positif( BICPMVCTP ) + positif( BICPMVCTV ) + positif( BICREC )
 + positif( BICREP ) + positif( BICREV ) + positif( BIGREST )
 + positif (BIHDNC * (1 - positif(ART1731BIS) )) 
 + positif (BIHDNP * (1 - positif(ART1731BIS) )) 
 + positif (BIHDNV * (1 - positif(ART1731BIS) ))
 + positif( BIHEXC ) + positif( BIHEXP ) + positif( BIHEXV )
 + positif( BIHNOC ) + positif( BIHNOP ) + positif( BIHNOV )
 + positif( BIPERPC ) + positif( BIPERPP ) + positif( BIPERPV )
 + positif( BN1AC ) + positif( BN1AP ) + positif( BN1AV )
 + positif( BNCAABC ) + positif( BNCAABP ) + positif( BNCAABV )
 + positif (min(BNCAADC,BNCAADC1731+0) * positif(ART1731BIS) + BNCAADC * (1 - ART1731BIS))
 + positif (min(BNCAADP,BNCAADP1731+0) * positif(ART1731BIS) + BNCAADP * (1 - ART1731BIS)) 
 + positif (min(BNCAADV,BNCAADV1731+0) * positif(ART1731BIS) + BNCAADV * (1 - ART1731BIS))
 + positif( BNCCRC ) + positif( BNCCRFC ) + positif( BNCCRFP )
 + positif( BNCCRFV ) + positif( BNCCRP ) + positif( BNCCRV )
 + positif (BNCDEC * (1 - positif(ART1731BIS) ))
 + positif (BNCDEP * (1 - positif(ART1731BIS) )) 
 + positif (BNCDEV * (1 - positif(ART1731BIS) ))
 + positif( BNCEXC ) + positif( BNCEXP ) + positif( BNCEXV )

 + positif( BNCNP1AC ) + positif( BNCNP1AP ) + positif( BNCNP1AV )
 + positif( BNCNPC ) + positif( BNCNPDCT ) + positif( BNCNPDEC )
 + positif( BNCNPDEP ) + positif( BNCNPDEV ) + positif( BNCNPP )
 + positif( BNCNPPVC ) + positif( BNCNPPVP ) + positif( BNCNPPVV )
 + positif( BNCNPREXAAC ) + positif( BNCNPREXAAP ) + positif( BNCNPREXAAV )
 + positif( BNCNPREXC ) + positif( BNCNPREXP ) + positif( BNCNPREXV )
 + positif( BNCNPV ) + positif( BNCPMVCTC ) + positif( BNCPMVCTP )
 + positif( BNCPMVCTV ) + positif( BNCPRO1AC ) + positif( BNCPRO1AP )
 + positif( BNCPRO1AV ) + positif( BNCPROC ) + positif( BNCPRODEC )
 + positif( BNCPRODEP ) + positif( BNCPRODEV ) + positif( BNCPROEXC )
 + positif( BNCPROEXP ) + positif( BNCPROEXV ) + positif( BNCPROP )
 + positif( BNCPROPVC ) + positif( BNCPROPVP ) + positif( BNCPROPVV )
 + positif( BNCPROV ) + positif( BNCREC ) + positif( BNCREP )
 + positif( BNCREV ) 
 + positif (BNHDEC * (1 - positif(ART1731BIS) )) 
 + positif (BNHDEP * (1 - positif(ART1731BIS) ))
 + positif (BNHDEV * (1 - positif(ART1731BIS) ))
 + positif( BNHEXC ) + positif( BNHEXP )
 + positif( BNHEXV ) + positif( BNHREC ) + positif( BNHREP )
 + positif( BNHREV ) + positif( BPCOPTC ) + positif( BPCOPTV )
 + positif( BPCOSAC ) + positif( BPCOSAV ) + positif( BPV18C )
 + positif( BPV18V ) + positif( BPV40C ) + positif( BPV40V )
 + positif( BPVKRI ) 
 + positif( BPVRCM ) + positif( BPVSJ ) + positif( BPVSK )
 + positif( BRAS ) + positif( CARPEC ) + positif( CARPENBAC )
 + positif( CARPENBAP1 ) + positif( CARPENBAP2 ) + positif( CARPENBAP3 )
 + positif( CARPENBAP4 ) + positif( CARPENBAV ) + positif( CARPEP1 )
 + positif( CARPEP2 ) + positif( CARPEP3 ) + positif( CARPEP4 )
 + positif( CARPEV ) + positif( CARTSC ) + positif( CARTSNBAC )
 + positif( CARTSNBAP1 ) + positif( CARTSNBAP2 ) + positif( CARTSNBAP3 )
 + positif( CARTSNBAP4 ) + positif( CARTSNBAV ) + positif( CARTSP1 )
 + positif( CARTSP2 ) + positif( CARTSP3 ) + positif( CARTSP4 )
 + positif( CARTSV ) + positif( CASECHR ) + positif( CASEPRETUD )
 + positif( CBETRAN ) + positif( CELLIERHJ ) + positif( CELLIERHK )
 + positif( CELLIERHL ) + positif( CELLIERHM ) + positif( CELLIERHN )
 + positif( CELLIERHO ) + positif( CELLIERJA ) + positif( CELLIERJB )
 + positif( CELLIERJD ) + positif( CELLIERJE ) + positif( CELLIERJF )
 + positif( CELLIERJG ) + positif( CELLIERJH ) + positif( CELLIERJJ )
 + positif( CELLIERJK ) + positif( CELLIERJL ) + positif( CELLIERJM )
 + positif( CELLIERJN ) + positif( CELLIERJO ) + positif( CELLIERJP )
 + positif( CELLIERJQ ) + positif( CELLIERJR ) + positif( CELLIERNA )
 + positif( CELLIERNB ) + positif( CELLIERNC ) + positif( CELLIERND )
 + positif( CELLIERNE ) + positif( CELLIERNF ) + positif( CELLIERNG )
 + positif( CELLIERNH ) + positif( CELLIERNI ) + positif( CELLIERNJ )
 + positif( CELLIERNK ) + positif( CELLIERNL ) + positif( CELLIERNM )
 + positif( CELLIERNN ) + positif( CELLIERNO ) + positif( CELLIERNP )
 + positif( CELLIERNQ ) + positif( CELLIERNR ) + positif( CELLIERNS )
 + positif( CELLIERNT ) + positif( CELLIERFA ) + positif( CELLIERFB)
 + positif( CELLIERFC) + positif( CELLIERFD)
 + positif( CELREPGJ ) + positif( CELREPGK ) + positif( CELREPGL )
 + positif( CELREPGP ) + positif( CELREPGS ) + positif( CELREPGT )
 + positif( CELREPGU ) + positif( CELREPGV ) + positif( CELREPGW )
 + positif( CELREPGX )
 + positif( CELREPHA ) + positif( CELREPHB )
 + positif( CELREPHD ) + positif( CELREPHE ) + positif( CELREPHF )
 + positif( CELREPHG ) + positif( CELREPHH ) + positif( CELREPHR )
 + positif( CELREPHS ) + positif( CELREPHT ) + positif( CELREPHU )
 + positif( CELREPHV ) + positif( CELREPHW ) + positif( CELREPHX )
 + positif( CELREPHZ ) + positif( CELRREDLA ) + positif( CELRREDLB )
 + positif( CELRREDLC ) + positif( CELRREDLD ) + positif( CELRREDLE )
 + positif( CELRREDLF ) + positif( CELRREDLM ) + positif( CELRREDLS )
 + positif( CELRREDLZ ) + positif( CELRREDMG )
 + positif( CESSASSC ) + positif( CESSASSV )
 + positif( CHAUBOISN ) + positif( CHAUBOISO ) + positif( CHAUFSOL )
 + positif( CHENF1 ) + positif( CHENF2 ) + positif( CHENF3 )
 + positif( CHENF4 ) + positif( CHNFAC ) + positif( CHRDED )
 + positif( CHRFAC ) + positif( CIAQCUL ) + positif( CIBOIBAIL )
 + positif( CICORSENOW ) +  positif( CIDEP15 )
 + positif( CIIMPPRO ) + positif( CIIMPPRO2 ) + positif( CIINVCORSE )
 + positif( CINE1 ) + positif( CINE2 ) + positif( CINRJ )
 + positif( CINRJBAIL ) + positif( CMAJ ) + positif( CMAJ_ISF )
 + positif( CO2044P ) + positif( CO2047 ) + positif( CO2102 )
 + positif( CODCHA ) + positif( CODSIR ) + positif( CONVCREA )
 + positif( CONVHAND ) + positif( COTF1 ) + positif( COTF2 )
 + positif( COTF3 ) + positif( COTF4 ) + positif( COTFC )
 + positif( COTFORET ) + positif( COTFV ) + positif( CREAGRIBIO )
 + positif( CREAIDE ) + positif( CREAPP ) + positif( CREARTS )
 + positif( CRECHOBOI ) + positif( CRECHOCON2 )
 + positif( CRECONGAGRI ) + positif( CREDPVREP ) + positif( CREFAM )
 + positif( CREFORMCHENT ) + positif( CREINTERESSE ) + positif( CRENRJ )
 + positif( CREPROSP ) + positif( CRERESTAU )
 + positif( CRIGA ) + positif( CVNSALAC ) + positif( CVNSALAV )
 + positif (min(DABNCNP1,DABNCNP11731+0) * positif(ART1731BIS) + DABNCNP1 * (1 - ART1731BIS)) 
 + positif (min(DABNCNP2,DABNCNP21731+0) * positif(ART1731BIS) + DABNCNP2 * (1 - ART1731BIS)) 
 + positif (min(DABNCNP3,DABNCNP31731+0) * positif(ART1731BIS) + DABNCNP3 * (1 - ART1731BIS))
 + positif (min(DABNCNP4,DABNCNP41731+0) * positif(ART1731BIS) + DABNCNP4 * (1 - ART1731BIS)) 
 + positif (min(DABNCNP5,DABNCNP51731+0) * positif(ART1731BIS) + DABNCNP5 * (1 - ART1731BIS)) 
 + positif (min(DABNCNP6,DABNCNP61731+0) * positif(ART1731BIS) + DABNCNP6 * (1 - ART1731BIS))
 + positif (min(DAGRI1,DAGRI11731+0) * positif(ART1731BIS) + DAGRI1 * (1 - ART1731BIS))
 + positif (min(DAGRI2,DAGRI21731+0) * positif(ART1731BIS) + DAGRI2 * (1 - ART1731BIS)) 
 + positif (min(DAGRI3,DAGRI31731+0) * positif(ART1731BIS) + DAGRI3 * (1 - ART1731BIS))
 + positif (min(DAGRI4,DAGRI41731+0) * positif(ART1731BIS) + DAGRI4 * (1 - ART1731BIS)) 
 + positif (min(DAGRI5,DAGRI51731+0) * positif(ART1731BIS) + DAGRI5 * (1 - ART1731BIS)) 
 + positif (min(DAGRI6,DAGRI61731+0) * positif(ART1731BIS) + DAGRI6 * (1 - ART1731BIS))
 + positif( DATDEPETR ) + positif( DATOCEANS ) + positif( DATRETETR )
 + positif( DCSG ) 
 + positif (DEFAA0 * (1 - positif(ART1731BIS) ))
 + positif (DEFAA1 * (1 - positif(ART1731BIS) ))
 + positif (DEFAA2 * (1 - positif(ART1731BIS) )) 
 + positif (DEFAA3 * (1 - positif(ART1731BIS) )) 
 + positif (DEFAA4 * (1 - positif(ART1731BIS) ))
 + positif (DEFAA5 * (1 - positif(ART1731BIS) ))
 + positif (min(DEFBIC1,DEFBIC11731+0) * positif(ART1731BIS) + DEFBIC1 * (1 - ART1731BIS)) 
 + positif (min(DEFBIC2,DEFBIC21731+0) * positif(ART1731BIS) + DEFBIC2 * (1 - ART1731BIS))
 + positif (min(DEFBIC3,DEFBIC31731+0) * positif(ART1731BIS) + DEFBIC3 * (1 - ART1731BIS)) 
 + positif (min(DEFBIC4,DEFBIC41731+0) * positif(ART1731BIS) + DEFBIC4 * (1 - ART1731BIS)) 
 + positif (min(DEFBIC5,DEFBIC51731+0) * positif(ART1731BIS) + DEFBIC5 * (1 - ART1731BIS))
 + positif (min(DEFBIC6,DEFBIC61731+0) * positif(ART1731BIS) + DEFBIC6 * (1 - ART1731BIS)) 
 + positif (min(DEFRCM,DEFRCM1731+0) * positif(ART1731BIS) + DEFRCM * (1 - ART1731BIS))
 + positif (min(DEFRCM2,DEFRCM21731+0) * positif(ART1731BIS) + DEFRCM2 * (1 - ART1731BIS))
 + positif (min(DEFRCM3,DEFRCM31731+0) * positif(ART1731BIS) + DEFRCM3 * (1 - ART1731BIS)) 
 + positif (min(DEFRCM4,DEFRCM41731+0) * positif(ART1731BIS) + DEFRCM4 * (1 - ART1731BIS)) 
 + positif (min(DEFRCM5,DEFRCM51731+0) * positif(ART1731BIS) + DEFRCM5 * (1 - ART1731BIS))
 + positif (min(DEFRCM5,DEFRCM51731+0) * positif(ART1731BIS) + DEFRCM5 * (1 - ART1731BIS)) 
 + positif (min(DEFZU,DEFZU1731+0) * positif(ART1731BIS) + DEFZU * (1 - ART1731BIS))  + positif( DEPCHOBAS )
 + positif( DEPENV ) + positif( DEPMOBIL ) + positif( DETS1 )
 + positif( DETS2 ) + positif( DETS3 ) + positif( DETS4 )
 + positif( DETSC ) + positif( DETSV ) + positif( DIAGPERF )
 + positif( DIREPARGNE ) + positif( DISQUO ) + positif( DISQUONB )
 + positif (min(DNOCEP,DNOCEP1731+0) * positif(ART1731BIS) + DNOCEP * (1 - ART1731BIS))
 + positif (min(DNOCEPC,DNOCEPC1731+0) * positif(ART1731BIS) + DNOCEPC * (1 - ART1731BIS)) 
 + positif (min(DNOCEPP,DNOCEPP1731+0) * positif(ART1731BIS) + DNOCEPP * (1 - ART1731BIS))
 + positif( DONAUTRE ) + positif( DONETRAN ) + positif( DPVRCM )
 + positif( EAUPLUV ) + positif( ELESOL ) + positif( ELURASC )
 + positif( ELURASV ) + positif( ENERGIEST ) + positif( ESFP )
 + positif( EXOCETC ) + positif( EXOCETV ) + positif( FCPI )
 + positif( FEXC ) + positif( FEXP ) + positif( FEXV )
 + positif( FFIP ) + positif( FIPCORSE ) + positif( FIPDOMCOM )
 + positif( FONCI ) + positif( FONCINB ) + positif( FORET )
 + positif( FRN1 ) + positif( FRN2 ) + positif( FRN3 )
 + positif( FRN4 ) + positif( FRNC ) + positif( FRNV )
 + positif( GAINABDET ) + positif( GAINPEA ) 
 + positif( GLD1C ) + positif( GLD1V )
 + positif( GLD2C ) + positif( GLD2V ) + positif( GLD3C )
 + positif( GLD3V ) + positif( GLDGRATC ) + positif( GLDGRATV )
 + positif( GSALC ) + positif( GSALV ) + positif( HEURESUPC )
 + positif( HEURESUPP1 ) + positif( HEURESUPP2 ) + positif( HEURESUPP3 )
 + positif( HEURESUPP4 ) + positif( HEURESUPV ) + positif( IMPRET )
 + positif( INAIDE ) + positif( INDECS ) + positif( INDJNONIMPC )
 + positif( INDJNONIMPV ) 
 + positif( INDPVSURSI ) + positif( INDPVSURSI2 ) + positif( IND_TDR )
 + positif( INTDIFAGRI ) + positif( INTERE ) + positif( INTERENB )
 + positif( INVDIR2009 ) + positif( INVDOMRET50 ) + positif( INVDOMRET60 )
 + positif( INVENDEB2009 ) + positif( INVENDI ) + positif( INVENTC )
 + positif( INVENTP ) + positif( INVENTV ) + positif( INVIMP )
 + positif( INVLGAUTRE ) + positif( INVLGDEB ) + positif( INVLGDEB2009 )
 + positif( INVLGDEB2010 ) + positif( INVLOCHOTR ) + positif( INVLOCHOTR1 )
 + positif( INVLOCXN ) + positif( INVLOCXV ) + positif( COD7UY )
 + positif( COD7UZ ) + positif( INVLOG2008 ) + positif( INVLOG2009 )
 + positif( INVLOGHOT ) + positif( INVLOGREHA ) + positif( INVLOGSOC )
 + positif( INVNPROF1 ) + positif( INVNPROF2 ) + positif( INVNPROREP )
 + positif( INVOMENTKT ) + positif( INVOMENTKU ) + positif( INVOMENTMN )
 + positif( INVOMENTNU ) + positif( INVOMENTNV ) + positif( INVOMENTNW )
 + positif( INVOMENTNY ) + positif( INVOMENTRG )
 + positif( INVOMENTRI ) + positif( INVOMENTRJ )
 + positif( INVOMENTRK ) + positif( INVOMENTRL ) + positif( INVOMENTRM )
 + positif( INVOMENTRO ) + positif( INVOMENTRP )
 + positif( INVOMENTRQ ) + positif( INVOMENTRR ) 
 + positif( INVOMENTRT ) + positif( INVOMENTRU ) + positif( INVOMENTRV )
 + positif( INVOMENTRW ) + positif( INVOMENTRY )
 + positif( INVOMLOGOA ) + positif( INVOMLOGOB ) + positif( INVOMLOGOC )
 + positif( INVOMLOGOH ) + positif( INVOMLOGOI ) + positif( INVOMLOGOJ )
 + positif( INVOMLOGOK ) + positif( INVOMLOGOL ) + positif( INVOMLOGOM )
 + positif( INVOMLOGON ) + positif( INVOMLOGOO ) + positif( INVOMLOGOP )
 + positif( INVOMLOGOQ ) + positif( INVOMLOGOR ) + positif( INVOMLOGOS )
 + positif( INVOMLOGOT ) + positif( INVOMLOGOU ) + positif( INVOMLOGOV )
 + positif( INVOMLOGOW ) + positif( INVOMQV ) + positif( INVOMREP )
 + positif( INVOMRETPA ) + positif( INVOMRETPB ) + positif( INVOMRETPD )
 + positif( INVOMRETPE ) + positif( INVOMRETPF ) + positif( INVOMRETPH )
 + positif( INVOMRETPI ) + positif( INVOMRETPJ ) + positif( INVOMRETPL )
 + positif( INVOMRETPM ) + positif( INVOMRETPN ) + positif( INVOMRETPO )
 + positif( INVOMRETPP ) + positif( INVOMRETPR )
 + positif( INVOMRETPS ) + positif( INVOMRETPT ) + positif( INVOMRETPU )
 + positif( INVOMRETPW ) + positif( INVOMRETPX )
 + positif( INVOMRETPY ) + positif( INVOMSOCKH ) + positif( INVOMSOCKI )
 + positif( INVOMSOCQJ ) + positif( INVOMSOCQS ) + positif( INVOMSOCQU )
 + positif( INVOMSOCQW ) + positif( INVOMSOCQX ) + positif( INVREDMEU )
 + positif( INVREPMEU ) + positif( INVREPNPRO ) + positif( INVRETRO1 )
 + positif( INVRETRO2 ) + positif( INVSOC2010 ) + positif( INVSOCNRET )
 + positif( IPBOCH ) + positif( IPCHER ) + positif( IPELUS )
 + positif( IPMOND ) + positif( IPPNCS ) + positif( IPPRICORSE )
 + positif( IPRECH ) + positif( IPREP ) + positif( IPREPCORSE )
 + positif( IPSOUR ) + positif( IPSURSI ) + positif(VARIPTEFN) 
 + positif( VARIPTEFP ) + positif( IPTXMO ) + positif( IPVLOC )
 + positif( ISFBASE ) + positif( ISFCONCUB ) + positif( ISFDONEURO )
 + positif( ISFDONF ) + positif( ISFETRANG ) + positif( ISFFCPI )
 + positif( ISFFIP ) + positif( ISFPART ) + positif( ISFPLAF )
 + positif( ISFPMEDI ) + positif( ISFPMEIN ) + positif( ISFVBPAT )
 + positif( ISF_LIMINF ) + positif( ISF_LIMSUP ) 
 + positif (min(LNPRODEF1,LNPRODEF11731+0) * positif(ART1731BIS) + LNPRODEF1 * (1 - ART1731BIS)) 
 + positif (min(LNPRODEF10,LNPRODEF101731+0) * positif(ART1731BIS) + LNPRODEF10 * (1 - ART1731BIS)) 
 + positif (min(LNPRODEF2,LNPRODEF21731+0) * positif(ART1731BIS) + LNPRODEF2 * (1 - ART1731BIS))
 + positif (min(LNPRODEF3,LNPRODEF31731+0) * positif(ART1731BIS) + LNPRODEF3 * (1 - ART1731BIS)) 
 + positif (min(LNPRODEF4,LNPRODEF41731+0) * positif(ART1731BIS) + LNPRODEF4 * (1 - ART1731BIS)) 
 + positif (min(LNPRODEF5,LNPRODEF51731+0) * positif(ART1731BIS) + LNPRODEF5 * (1 - ART1731BIS))
 + positif (min(LNPRODEF6,LNPRODEF61731+0) * positif(ART1731BIS) + LNPRODEF6 * (1 - ART1731BIS)) 
 + positif (min(LNPRODEF7,LNPRODEF71731+0) * positif(ART1731BIS) + LNPRODEF7 * (1 - ART1731BIS)) 
 + positif (min(LNPRODEF8,LNPRODEF81731+0) * positif(ART1731BIS) + LNPRODEF8 * (1 - ART1731BIS))
 + positif (min(LNPRODEF9,LNPRODEF91731+0) * positif(ART1731BIS) + LNPRODEF9 * (1 - ART1731BIS)) 
 + positif (min(LOCDEFNPC,LOCDEFNPC1731+0) * positif(ART1731BIS) + LOCDEFNPC * (1 - ART1731BIS))
 + positif (min(LOCDEFNPCGAC,LOCDEFNPCGAC1731+0) * positif(ART1731BIS) + LOCDEFNPCGAC * (1 - ART1731BIS))
 + positif (min(LOCDEFNPCGAPAC,LOCDEFNPCGAPAC1731+0) * positif(ART1731BIS) + LOCDEFNPCGAPAC * (1 - ART1731BIS))
 + positif (min(LOCDEFNPCGAV,LOCDEFNPCGAV1731+0) * positif(ART1731BIS) + LOCDEFNPCGAV * (1 - ART1731BIS))
 + positif (min(LOCDEFNPPAC,LOCDEFNPPAC1731+0) * positif(ART1731BIS) + LOCDEFNPPAC * (1 - ART1731BIS))
 + positif (min(LOCDEFNPV,LOCDEFNPV1731+0) * positif(ART1731BIS) + LOCDEFNPV * (1 - ART1731BIS))
 + positif (LOCDEFPROCGAC * (1 - positif(ART1731BIS) ))
 + positif (LOCDEFPROCGAP * (1 - positif(ART1731BIS) )) 
 + positif (LOCDEFPROCGAV * (1 - positif(ART1731BIS) )) 
 + positif (LOCDEFPROC * (1 - positif(ART1731BIS) )) 
 + positif (LOCDEFPROP * (1 - positif(ART1731BIS) ))
 + positif (LOCDEFPROV * (1 - positif(ART1731BIS) ))
 + positif( LOCGITC ) + positif( LOCGITCC )
 + positif( LOCGITCP ) + positif( LOCGITCV ) + positif( LOCGITHCC )
 + positif( LOCGITHCP ) + positif( LOCGITHCV ) + positif( LOCGITP )
 + positif( LOCGITV ) + positif( LOCMEUBIA ) + positif( LOCMEUBIB )
 + positif( LOCMEUBIC ) + positif( LOCMEUBID ) + positif( LOCMEUBIE )
 + positif( LOCMEUBIF ) + positif( LOCMEUBIG ) + positif( LOCMEUBIH )
 + positif( LOCMEUBII ) + positif( LOCMEUBIX ) + positif( LOCMEUBIZ )
 + positif( LOCMEUBJV ) + positif( LOCMEUBJW ) + positif( LOCMEUBJX ) + positif( LOCMEUBJY )
 + positif( LOCNPC ) + positif( LOCNPCGAC ) + positif( LOCNPCGAPAC )
 + positif( LOCNPCGAV ) + positif( LOCNPPAC ) + positif( LOCNPV )
 + positif( LOCPROC ) + positif( LOCPROCGAC ) + positif( LOCPROCGAP )
 + positif( LOCPROCGAV ) + positif( LOCPROP ) + positif( LOCPROV )
 + positif( LOCRESINEUV ) + positif( LOYELEV ) + positif( LOYIMP )
 + positif( MATISOSI ) + positif( MATISOSJ ) + positif( MEUBLENP )
 + positif( MIB1AC ) + positif( MIB1AP ) + positif( MIB1AV )
 + positif( MIBDEC ) + positif( MIBDEP ) + positif( MIBDEV )
 + positif( MIBEXC ) + positif( MIBEXP ) + positif( MIBEXV )
 + positif( MIBGITEC ) + positif( MIBGITEP ) + positif( MIBGITEV )
 + positif( MIBMEUC ) + positif( MIBMEUP ) + positif( MIBMEUV )
 + positif( MIBNP1AC ) + positif( MIBNP1AP ) + positif( MIBNP1AV )
 + positif( MIBNPDCT ) + positif( MIBNPDEC ) + positif( MIBNPDEP )
 + positif( MIBNPDEV ) + positif( MIBNPEXC ) + positif( MIBNPEXP )
 + positif( MIBNPEXV ) + positif( MIBNPPRESC ) + positif( MIBNPPRESP )
 + positif( MIBNPPRESV ) + positif( MIBNPPVC ) + positif( MIBNPPVP )
 + positif( MIBNPPVV ) + positif( MIBNPVENC ) + positif( MIBNPVENP )
 + positif( MIBNPVENV ) + positif( MIBPRESC ) + positif( MIBPRESP )
 + positif( MIBPRESV ) + positif( MIBPVC ) + positif( MIBPVP )
 + positif( MIBPVV ) + positif( MIBVENC ) + positif( MIBVENP )
 + positif( MIBVENV ) + positif( MOISAN ) + positif( MOISAN_ISF )
 + positif( NBACT ) + positif( NCHENF1 ) + positif( NCHENF2 )
 + positif( NCHENF3 ) + positif( NCHENF4 ) + positif( NRBASE )
 + positif( NRETROC40 ) + positif( NRETROC50 ) + positif( NRINET )
 + positif( NUPROP ) + positif( OPTPLAF15 ) + positif( PAAP )
 + positif( PAAV ) + positif( PALI1 ) + positif( PALI2 )
 + positif( PALI3 ) + positif( PALI4 ) + positif( PALIC )
 + positif( PALIV ) + positif( PATNAT )
 + positif( PATNAT1 ) + positif( PATNAT2 ) + positif( PCAPTAXC )
 + positif( PCAPTAXV ) + positif( PEA ) + positif( PEBF1 )
 + positif( PEBF2 ) + positif( PEBF3 ) + positif( PEBF4 )
 + positif( PEBFC ) + positif( PEBFV ) + positif( PENECS )
 + positif( PENSALC ) + positif( PENSALNBC ) + positif( PENSALNBP1 )
 + positif( PENSALNBP2 ) + positif( PENSALNBP3 ) + positif( PENSALNBP4 )
 + positif( PENSALNBV ) + positif( PENSALP1 ) + positif( PENSALP2 )
 + positif( PENSALP3 ) + positif( PENSALP4 ) + positif( PENSALV )
 + positif( PERPC ) + positif( PERPIMPATRIE ) + positif( PERPMUTU )
 + positif( PERPP ) + positif( PERPPLAFCC ) + positif( PERPPLAFCP )
 + positif( PERPPLAFCV ) + positif( PERPPLAFNUC1 ) + positif( PERPPLAFNUC2 )
 + positif( PERPPLAFNUC3 ) + positif( PERPPLAFNUP1 ) + positif( PERPPLAFNUP2 )
 + positif( PERPPLAFNUP3 ) + positif( PERPPLAFNUV1 ) + positif( PERPPLAFNUV2 )
 + positif( PERPPLAFNUV3 ) + positif( PERPV ) + positif( PERP_COTC )
 + positif( PERP_COTP ) + positif( PERP_COTV ) 
 + positif( PLAF_PERPC ) + positif( PLAF_PERPP ) + positif( PLAF_PERPV )
 + positif( POMPESP ) + positif( POMPESQ ) + positif( POMPESR )
 + positif( PORENT ) 
 + positif( PPEACC ) + positif( PPEACP ) + positif( PPEACV )
 + positif( PPEISFPIR ) + positif( PPENHC ) + positif( PPENHP1 )
 + positif( PPENHP2 ) + positif( PPENHP3 ) + positif( PPENHP4 )
 + positif( PPENHV ) + positif( PPENJC ) + positif( PPENJP )
 + positif( PPENJV ) + positif( PPEREVPRO ) + positif( PPETPC )
 + positif( PPETPP1 ) + positif( PPETPP2 ) + positif( PPETPP3 )
 + positif( PPETPP4 ) + positif( PPETPV ) + positif( PPLIB )
 + positif( PRBR1 ) + positif( PRBR2 ) + positif( PRBR3 )
 + positif( PRBR4 ) + positif( PRBRC ) + positif( PRBRV )
 + positif( PREHABT ) + positif( PREHABT2 )
 + positif( PREHABTN ) + positif( PREHABTN1 ) + positif( PREHABTN2 )
 + positif( PREHABTVT ) + positif( PRELIBXT ) + positif( PREMAIDE )
 + positif( PREREV ) + positif( PRESCOMP2000 ) + positif( PRESCOMPJUGE )
 + positif( PRESINTER ) + positif( PRETUD ) + positif( PRETUDANT )
 + positif( PRODOM ) + positif( PROGUY ) + positif( PROVIE )
 + positif( PROVIENB ) + positif( PTZDEVDUR ) + positif( PTZDEVDURN )
 + positif( PVEXOSEC ) + positif( PVIMMO )
 + positif( PVIMPOS ) + positif( PVINCE ) + positif( PVINPE )
 + positif( PVINVE ) + positif( PVJEUNENT ) + positif( PVMOBNR )
 + positif( PVPART ) + positif( PVREP8 ) + positif( PVREPORT )
 + positif( PVSOCC ) + positif( PVSOCV ) + positif( PVSURSI )
 + positif( PVSURSIWF ) + positif( PVSURSIWG ) + positif( PVTAXSB )
 + positif( PVTITRESOC ) + positif( R1649 )
 + positif( RACCOTC ) + positif( RACCOTP ) + positif( RACCOTV )
 + positif( RCCURE ) + positif( RCMABD ) + positif( RCMAV )
 + positif( RCMAVFT ) + positif( RCMFR ) + positif( RCMHAB )
 + positif( RCMHAD ) + positif( RCMIMPAT ) + positif( RCMLIB )
 + positif( RCMRDS ) + positif( RCMSOC )
 + positif( RCMTNC ) + positif( RCSC ) + positif( RCSP )
 + positif( RCSV ) + positif( RDCOM ) + positif( RDDOUP )
 + positif( RDENL ) + positif( RDENLQAR ) + positif( RDENS )
 + positif( RDENSQAR ) + positif( RDENU ) + positif( RDENUQAR )
 + positif( RDEQPAHA ) + positif( RDFOREST ) + positif( RDFORESTGES )
 + positif( RDFORESTRA ) + positif( RDGARD1 )
 + positif( RDGARD1QAR ) + positif( RDGARD2 ) + positif( RDGARD2QAR )
 + positif( RDGARD3 ) + positif( RDGARD3QAR ) + positif( RDGARD4 )
 + positif( RDGARD4QAR ) + positif( RDMECENAT )
 + positif( RDPRESREPORT ) + positif( RDREP ) + positif( RDRESU )
 + positif( RDSNO ) + positif( RDSYCJ ) + positif( RDSYPP )
 + positif( RDSYVO ) + positif( RDTECH ) + positif( RE168 )
 + positif( REAMOR ) + positif( REAMORNB ) + positif( REDMEUBLE )
 + positif( REDREPNPRO ) + positif( REGCI ) + positif( REGPRIV )
 + positif( REMPLAC ) + positif( REMPLANBC ) + positif( REMPLANBP1 )
 + positif( REMPLANBP2 ) + positif( REMPLANBP3 ) + positif( REMPLANBP4 )
 + positif( REMPLANBV ) + positif( REMPLAP1 ) + positif( REMPLAP2 )
 + positif( REMPLAP3 ) + positif( REMPLAP4 ) + positif( REMPLAV )
 + positif( RENTAX ) + positif( RENTAX5 ) + positif( RENTAX6 )
 + positif( RENTAX7 ) + positif( RENTAXNB ) + positif( RENTAXNB5 )
 + positif( RENTAXNB6 ) + positif( RENTAXNB7 ) + positif( REPDON03 )
 + positif( REPDON04 ) + positif( REPDON05 ) + positif( REPDON06 )
 + positif( REPDON07 ) + positif( REPFOR ) + positif( REPFOR1 )
 + positif( REPFOR2 ) + positif( REPGROREP1 ) + positif( REPGROREP11 ) + positif( REPGROREP12 )
 + positif( REPGROREP2 ) + positif( REPINVDOMPRO3 )
 + positif( REPINVLOCINV ) + positif( REPINVLOCREA ) + positif( REPINVTOU )
 + positif( REPMEUBLE ) + positif( REPSINFOR ) + positif( REPSINFOR1 )
 + positif( REPSINFOR2 ) + positif( REPSNO1 ) + positif( REPSNO2 )
 + positif( REPSNO3 ) + positif( REPSNON ) + positif( REPSOF )
 + positif( RESCHAL ) + positif( RESIVIANT ) + positif( RESIVIEU )
 + positif( RESTIMOPPAU ) + positif( RESTIMOSAUV ) + positif( RESTUC )
 + positif( RESTUCNB ) + positif( RETROCOMLH ) + positif( RETROCOMLI )
 + positif( RETROCOMMB ) + positif( RETROCOMMC ) + positif( REVACT )
 + positif( REVACTNB ) + positif( REVCSXA ) + positif( REVCSXB )
 + positif( REVCSXC ) + positif( REVCSXD ) + positif( REVCSXE )
 + positif( REVFONC ) + positif( REVMAR1 ) + positif( REVMAR2 )
 + positif( REVMAR3 ) + positif( REVPEA ) + positif( REVPEANB )
 + positif(min(RFDANT,RFDANT1731+0) * positif(ART1731BIS) + RFDANT * (1 - ART1731BIS)) 
 + positif(RFDHIS) 
 + positif(min(RFDORD,RFDORD1731+0) * positif(ART1731BIS) + RFDORD * (1 - ART1731BIS))
 + positif( RFMIC ) + positif( RFORDI ) + positif( RFRH1 )
 + positif( RFRH2 ) + positif( RFRN2 ) + positif( RFRN3 )
 + positif( RFROBOR ) + positif( RIMOPPAUANT ) + positif( RIMOPPAURE )
 + positif( RIMOSAUVANT ) + positif( RIMOSAUVRF ) + positif( RINVLOCINV )
 + positif( COD7SY ) + positif( COD7SX )
 + positif( RINVLOCREA ) + positif( RISKTEC )
 + positif( VARRMOND ) + positif( RSAFOYER ) + positif( RSAPAC1 )
 + positif( RSAPAC2 ) + positif( RSOCREPRISE ) + positif( RVAIDAS )
 + positif( RVAIDE ) + positif( RVB1 ) + positif( RVB2 )
 + positif( RVB3 ) + positif( RVB4 ) + positif( RVCURE )
 + positif( SALECS ) + positif( SALECSG ) 
 + positif( SINISFORET ) + positif( SUBSTITRENTE )
 + positif( TAX1649 ) + positif( TEFFHRC ) + positif( TRAMURWC )
 + positif( TRATOIVG ) + positif( TRAVITWT ) + positif( TSASSUC )
 + positif( TSASSUV ) + positif( TSELUPPEC ) + positif( TSELUPPEV )
 + positif( TSHALLO1 ) + positif( TSHALLO2 ) + positif( TSHALLO3 )
 + positif( TSHALLO4 ) + positif( TSHALLOC ) + positif( TSHALLOV )
 + positif( VIEUMEUB ) + positif( VOLISO ) 
 + positif( XETRANC ) + positif( XETRANV )
 + positif( XHONOAAC ) + positif( XHONOAAP ) + positif( XHONOAAV )
 + positif( XHONOC ) + positif( XHONOP ) + positif( XHONOV )
 + positif( XSPENPC ) + positif( XSPENPP ) + positif( XSPENPV )
  );

regle 10009931:
application : iliad , batch;  

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

SOMMEA895 = present( BAEXV ) + present( BACREV ) + present( 4BACREV )
            + present( BA1AV ) + present( BACDEV )
            + present( BAEXC ) + present( BACREC ) + present( 4BACREC )
            + present( BA1AC ) + present( BACDEC )
	    + present( BAEXP ) + present( BACREP ) + present( 4BACREP )
	    + present( BA1AP ) + present( BACDEP )
	    + present( BAHEXV ) + present( BAHREV ) + present( 4BAHREV )
	    + present( BAHDEV )
	    + present( BAHEXC ) + present( BAHREC ) + present( 4BAHREC )
	    + present( BAHDEC )
	    + present( BAHEXP ) + present( BAHREP ) + present( 4BAHREP )
	    + present( BAHDEP )
	    + present( FEXV ) + present( BAFV ) + (1 - null( V_FORVA+0 )) + present( BAFPVV ) + present( BAF1AV )
            + present( FEXC ) + present( BAFC ) + (1 - null( V_FORCA+0 )) + present( BAFPVC ) + present( BAF1AC )
            + present( FEXP ) + present( BAFP ) + (1 - null( V_FORPA+0 )) + present( BAFPVP ) + present( BAF1AP ) 
	    ;

SOMMEA898 = SOMMEA895 ;

SOMMEA881 =  
	     present( BAEXV ) + present( BACREV ) + present( 4BACREV ) + present( BA1AV ) + present( BACDEV )
           + present( BAEXC ) + present( BACREC ) + present( 4BACREC ) + present( BA1AC ) + present( BACDEC )
	   + present( BAEXP ) + present( BACREP ) + present( 4BACREP ) + present( BA1AP ) + present( BACDEP )
	   + present( BAHEXV ) + present( BAHREV ) + present( 4BAHREV ) + present( BAHDEV )
	   + present( BAHEXC ) + present( BAHREC ) + present( 4BAHREC ) + present( BAHDEC )
	   + present( BAHEXP ) + present( BAHREP ) + present( 4BAHREP ) + present( BAHDEP )

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

	   + present( BNCEXV ) + present( BNCREV ) + present( BN1AV ) + present( BNCDEV ) 
	   + present( BNCEXC ) + present( BNCREC ) + present( BN1AC ) + present( BNCDEC )
	   + present( BNCEXP ) + present( BNCREP ) + present( BN1AP ) + present( BNCDEP ) 
	   + present( BNHEXV ) + present( BNHREV ) + present( BNHDEV ) 
	   + present( BNHEXC ) + present( BNHREC ) + present( BNHDEC ) 
	   + present( BNHEXP ) + present( BNHREP ) + present( BNHDEP ) 
           + present( XHONOAAV ) + present( XHONOV ) 
	   + present( XHONOAAC ) + present( XHONOC ) 
	   + present( XHONOAAP ) + present( XHONOP )

	   + present ( BNCAABV ) + present ( ANOCEP ) + present ( INVENTV ) 
	   + present ( PVINVE ) + present ( BNCAADV ) + present ( DNOCEP ) 
	   + present ( BNCAABC ) + present ( ANOVEP ) + present ( INVENTC ) 
	   + present ( PVINCE ) + present ( BNCAADC ) + present ( DNOCEPC )
	   + present ( BNCAABP ) + present ( ANOPEP ) + present ( INVENTP )
	   + present ( PVINPE ) + present ( BNCAADP ) + present ( DNOCEPP )
           + present( BNCNPREXAAV ) + present( BNCNPREXAAC ) + present( BNCNPREXAAP )
           + present( BNCNPREXV ) + present( BNCNPREXC ) + present( BNCNPREXP )
	   ;

SOMMEA858 = SOMMEA881 ;

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

SOMMEA874 =  somme(i=V,C,1,2,3,4:present(TSHALLOi) + present(ALLOi) + present(PRBRi) + present(PALIi))
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

SOMMEA877 =  present ( BAEXV ) + present ( BACREV ) + present( 4BACREV ) 
	   + present ( BA1AV ) + present ( BACDEV ) + present ( BAEXC ) 
	   + present ( BACREC ) + present( 4BACREC )
	   + present ( BA1AC ) + present ( BACDEC ) + present ( BAEXP ) + present ( BACREP ) 
	   + present( 4BACREP ) + present ( BA1AP ) 
	   + present ( BACDEP ) + present ( BAHEXV ) + present ( BAHREV )  
	   + present( 4BAHREV ) + present ( BAHDEV ) + present ( BAHEXC ) 
	   + present ( BAHREC ) + present( 4BAHREC )
	   + present ( BAHDEC ) + present ( BAHEXP ) + present ( BAHREP )  
	   + present( 4BAHREP ) + present ( BAHDEP ) + present ( BICEXV ) 
	   + present ( BICNOV ) + present ( BI1AV ) + present ( BICDNV ) 
	   + present ( BICEXC ) + present ( BICNOC )  
	   + present ( BI1AC ) + present ( BICDNC ) + present ( BICEXP ) 
           + present ( BICNOP ) + present ( BI1AP ) + present ( BICDNP ) 
           + present ( BIHEXV ) + present ( BIHNOV )  
           + present ( BIHDNV ) + present ( BIHEXC ) + present ( BIHNOC ) 
	   + present ( BIHDNC ) + present ( BIHEXP ) 
	   + present ( BIHNOP ) + present ( BIHDNP ) ;

SOMMEA879 =  
	     present( BACREV ) + present( 4BACREV ) + present( BA1AV ) + present( BACDEV ) 
	   + present( BACREC ) + present( 4BACREC ) + present( BA1AC ) + present( BACDEC ) 
           + present( BACREP ) + present( 4BACREP ) + present( BA1AP ) + present( BACDEP ) 
	   + present( BAHREV ) + present( 4BAHREV ) + present( BAHDEV ) 
	   + present( BAHREC ) + present( 4BAHREC ) + present( BAHDEC ) 
           + present( BAHREP ) + present( 4BAHREP ) + present( BAHDEP ) 
	   
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
	   + present( BNCREV ) + present( BN1AV ) + present( BNCDEV ) 
	   + present( BNCREC ) + present( BN1AC ) + present( BNCDEC ) 
	   + present( BNCREP ) + present( BN1AP ) + present( BNCDEP ) 
	   + present( BNHREV ) + present( BNHDEV ) 
	   + present( BNHREC ) + present( BNHDEC ) 
	   + present( BNHREP ) + present( BNHDEP ) 
	   + present ( BNCAABV ) + present ( ANOCEP ) + present ( INVENTV ) 
	   + present ( PVINVE ) + present ( BNCAADV ) + present ( DNOCEP ) 
	   + present ( BNCAABC ) + present ( ANOVEP ) + present ( INVENTC ) 
	   + present ( PVINCE ) + present ( BNCAADC ) + present ( DNOCEPC )
	   + present ( BNCAABP ) + present ( ANOPEP ) + present ( INVENTP )
	   + present ( PVINPE ) + present ( BNCAADP ) + present ( DNOCEPP )
	   ; 

SOMMEA884 =  present ( TSHALLOV ) + present ( TSHALLOC ) + present ( TSHALLO1 ) + present ( TSHALLO2 ) 
           + present ( TSHALLO3 ) + present ( TSHALLO4 )  
           + present( ALLOV ) + present( ALLOC ) + present( ALLO1 ) + present( ALLO2 ) + present( ALLO3 ) + present( ALLO4 ) 
	   + present ( PALIV ) + present ( PALIC ) + present ( PALI1 ) + present ( PALI2 ) + present ( PALI3 ) + present ( PALI4 ) 
	   + present ( PRBRV ) + present ( PRBRC ) + present ( PRBR1 ) + present ( PRBR2 ) + present ( PRBR3 ) + present ( PRBR4 )  
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
	   + present ( REVACT ) + present ( DISQUO ) + present ( REVACTNB ) + present ( DISQUONB ) 
	   + present ( RCMHAD )  
	   + present ( RCMABD )  

	   + present( RFORDI )  + present( RFMIC ) + present( FONCI ) + present( REAMOR ) 
           + present( BPVRCM ) + present( PVTAXSB ) + present( BPVKRI )
	   + present( BACREV ) + present( 4BACREV )
	   + present( BACREC ) + present( 4BACREC )
	   + present( BACREP ) + present( 4BACREP )
	   + present( BAHREV ) + present( 4BAHREV )
	   + present( BAHREC ) + present( 4BAHREC )
	   + present( BAHREP ) + present( 4BAHREP )
	   + present( BICNOV ) + present( LOCPROCGAV ) 
	   + present( BICNOC ) + present( LOCPROCGAC ) 
	   + present( BICNOP ) + present( LOCPROCGAP ) 
	   + present( BIHNOV ) + present( LOCPROV )
	   + present( BIHNOC ) + present( LOCPROC ) 
	   + present( BIHNOP ) + present( LOCPROP )
	   + present( MIBVENV ) + present( MIBPRESV ) 
	   + present( MIBVENC ) + present( MIBPRESC ) 
	   + present( MIBVENP ) + present( MIBPRESP ) 

	   + present ( BICREV ) + present ( LOCNPCGAV ) + present ( LOCGITCV )
	   + present ( BICREC ) + present ( LOCNPCGAC ) + present ( LOCGITCC )
	   + present ( BICREP ) + present ( LOCNPCGAPAC ) + present ( LOCGITCP )
	   + present ( BICHREV ) + present ( LOCNPV ) + present ( LOCGITHCV )
	   + present ( BICHREC ) + present ( LOCNPC ) + present ( LOCGITHCC )
	   + present ( BICHREP ) + present ( LOCNPPAC ) + present ( LOCGITHCP ) 
           + present ( MIBMEUV ) + present ( MIBGITEV ) + present ( LOCGITV ) + present ( MIBNPVENV ) + present ( MIBNPPRESV ) 
	   + present ( MIBMEUC ) + present ( MIBGITEC ) + present ( LOCGITC ) + present ( MIBNPVENC ) + present ( MIBNPPRESC ) 
	   + present ( MIBMEUP ) + present ( MIBGITEP ) + present ( LOCGITP ) + present ( MIBNPVENP ) + present ( MIBNPPRESP ) 
	   + present ( BNCREV ) + present ( BNCREC ) + present ( BNCREP ) 
	   + present ( BNHREV ) + present ( BNHREC ) + present ( BNHREP ) 
	   + present ( BNCPROV ) + present ( BNCPROC ) + present ( BNCPROP ) 

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

 somme(i=V,C,1,2,3,4: present(TSHALLOi) + present(ALLOi) +  present(PRBRi) + present(PALIi))
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

regle 10009932:
application : iliad , batch;  
SOMMEANOEXP = positif ( PEBFV ) + positif ( COTFV ) + positif ( PEBFC ) + positif ( COTFC ) 
              + positif ( PEBF1 ) + positif ( COTF1 ) + positif ( PEBF2 ) + positif ( COTF2 ) 
              + positif ( PEBF3 ) + positif ( COTF3 ) + positif ( PEBF4 ) + positif ( COTF4 ) 
              + positif ( PENSALV ) + positif ( PENSALNBV ) + positif ( PENSALC ) + positif ( PENSALNBC )
              + positif ( PENSALP1 ) + positif ( PENSALNBP1 ) + positif ( PENSALP2 ) + positif ( PENSALNBP2 )
              + positif ( PENSALP3 ) + positif ( PENSALNBP3 ) + positif ( PENSALP4 ) + positif ( PENSALNBP4 )
              + positif ( CARPEV ) + positif ( CARPENBAV ) + positif ( CARPEC ) + positif ( CARPENBAC )
              + positif ( CARPEP1 ) + positif ( CARPENBAP1 ) + positif ( CARPEP2 ) + positif ( CARPENBAP2 )
              + positif ( CARPEP3 ) + positif ( CARPENBAP3 ) + positif ( CARPEP4 ) + positif ( CARPENBAP4 )
              + positif ( CARTSV ) + positif ( CARTSNBAV ) + positif ( CARTSC ) + positif ( CARTSNBAC ) 
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
              + 0
             ;

regle 10009933:
application : iliad , batch;  

SOMMEA709 = positif(REPINVLOCINV) + positif(RINVLOCINV) + positif(RINVLOCREA) + positif(REPINVLOCREA) + positif(REPINVTOU) 
            + positif(INVLOGREHA) + positif(INVLOCXN) + positif(INVLOCXV) + positif(COD7UY) + positif(COD7UZ)
            + 0
	    ;
regle 10739:
application : iliad , batch ;  

SOMMEA739 = positif(INVSOCNRET) + positif(INVOMSOCKH) + positif(INVOMSOCKI) + positif(INVSOC2010) + positif(INVOMSOCQU) 
	    + positif(INVLOGSOC) + positif(INVOMSOCQJ) + positif(INVOMSOCQS) + positif(INVOMSOCQW) + positif(INVOMSOCQX) 
	    + positif(NRETROC40) + positif(NRETROC50) + positif(RETROCOMMB) + positif(RETROCOMMC) + positif(RETROCOMLH) 
	    + positif(RETROCOMLI) + positif(INVRETRO2) + positif(INVDOMRET60) + positif(INVRETRO1) + positif(INVDOMRET50) 
	    + positif(INVOMRETPO) + positif(INVOMRETPT) + positif(INVOMRETPN) + positif(INVOMRETPP) + positif(INVOMRETPS) 
	    + positif(INVOMRETPU) + positif(INVENDI) + positif(INVOMENTKT) + positif(INVOMENTKU) + positif(INVIMP) 
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
	    + 0 ;
regle 10009935:
application : iliad,  batch ;  

SOMMEA700 = 
          (
   present ( BAEXV ) + present ( BACREV ) + present ( 4BACREV ) + present ( BA1AV ) + present ( BACDEV ) 
 + present ( BAEXC ) + present ( BACREC ) + present ( 4BACREC ) + present ( BA1AC ) + present ( BACDEC ) 
 + present ( BAEXP ) + present ( BACREP ) + present ( 4BACREP ) + present ( BA1AP ) + present ( BACDEP ) 
 + present ( BAPERPV ) + present ( BAPERPC ) + present ( BAPERPP )
 + present ( BANOCGAV ) + present ( BANOCGAC ) + present ( BANOCGAP )
 + present ( BAHEXV ) + present ( BAHREV ) + present ( 4BAHREV )
 + present ( BAHEXC ) + present ( BAHREC ) + present ( 4BAHREC )
 + present ( BAHEXP ) + present ( BAHREP ) + present ( 4BAHREP )

 + present (BICEXV ) + present ( BICNOV ) + present ( LOCPROCGAV )
 + present ( BI1AV ) + present ( BICDNV ) + present ( LOCDEFPROCGAV )
 + present (BICEXC ) + present ( BICNOC ) + present ( LOCPROCGAC )
 + present ( BI1AC ) + present ( BICDNC ) + present ( LOCDEFPROCGAC )
 + present (BICEXP ) + present ( BICNOP ) + present ( LOCPROCGAP )
 + present ( BI1AP ) + present ( BICDNP ) + present ( LOCDEFPROCGAP )

 + present (BICNPEXV ) + present ( BICREV ) + present ( LOCNPCGAV ) + present ( LOCGITCV )
 + present ( BI2AV ) + present ( BICDEV ) + present ( LOCDEFNPCGAV )
 + present (BICNPEXC ) + present ( BICREC ) + present ( LOCNPCGAC ) + present ( LOCGITCC )
 + present ( BI2AC ) + present ( BICDEC ) + present ( LOCDEFNPCGAC )
 + present (BICNPEXP ) + present ( BICREP ) + present ( LOCNPCGAPAC ) + present ( LOCGITCP )
 + present ( BI2AP ) + present ( BICDEP ) + present ( LOCDEFNPCGAPAC )

 + present (BNCEXV ) + present ( BNCREV ) + present ( BN1AV ) + present ( BNCDEV )
 + present (BNCEXC ) + present ( BNCREC ) + present ( BN1AC ) + present ( BNCDEC )
 + present (BNCEXP ) + present ( BNCREP ) + present ( BN1AP ) + present ( BNCDEP )
 + present ( BNHEXV ) + present ( BNHREV ) 
 + present ( BNHEXC ) + present ( BNHREC ) 
 + present ( BNHEXP ) + present ( BNHREP ) 
 + present ( XHONOAAV ) + present ( XHONOAAC ) + present ( XHONOAAP )

 + present ( BNCNPREXAAV ) + present ( BNCNPREXV ) + present ( BNCNPREXAAC )
 + present ( BNCNPREXC ) + present ( BNCNPREXAAP ) + present ( BNCNPREXP )
 + present ( BNCAABV ) + present ( BNCAADV ) + present ( ANOCEP ) 
 + present ( PVINVE ) + present ( INVENTV )
 + present ( BNCAABC ) + present ( BNCAADC ) + present ( DNOCEP ) 
 + present ( ANOVEP ) + present ( PVINCE ) + present ( INVENTC )
 + present ( BNCAABP ) + present ( BNCAADP ) + present ( DNOCEPC )
 + present ( ANOPEP ) + present ( PVINPE ) + present ( INVENTP )
 + present ( DNOCEPP )
          ) ;

regle 10009936:
application : iliad , batch;  
V_CNR  =   (V_REGCO+0) dans (2,4);
V_CNR2 =   (V_REGCO+0) dans (2,3,4);
V_CR2  =   (V_REGCO+0) dans (2);
V_EAD  =   (V_REGCO+0) dans (5);
V_EAG  =   (V_REGCO+0) dans (6,7);
regle 10009950:
application : iliad , batch;  
VARIPTEFN =  null(4-V_IND_TRAIT) * IPTEFN 
	   + null(5-V_IND_TRAIT) * (max(0,(IPTEFN * (1 - positif(ART1731BIS) )) - DEFZU*ART1731BIS) * present (IPTEFN)) ;
VARIPTEFP = null(4-V_IND_TRAIT) * IPTEFP 
            + null(5-V_IND_TRAIT) * (IPTEFP + max(0,DEFZU*ART1731BIS - IPTEFN )) * positif(present(IPTEFP)+present(IPTEFN));

VARDMOND = null(4-V_IND_TRAIT) * DMOND 
            + null(5-V_IND_TRAIT) * max(0,(DMOND * (1 - positif(ART1731BIS) ))- DEFZU*ART1731BIS)  * present(DMOND);

VARRMOND = null(4-V_IND_TRAIT) * RMOND 
            + null(5-V_IND_TRAIT) * (RMOND + max(0,DEFZU*ART1731BIS - DMOND)) * positif(present(RMOND)+present(DMOND));

regle 10009960:
application : iliad , batch;  
FLAGRETARD = FLAG_RETARD+0;
FLAGRETARD08 = FLAG_RETARD08+0;
FLAGDEFAUT = FLAG_DEFAUT+0;
FLAGDEFAUT10 = FLAG_DEFAUT10+0;
FLAGDEFAUT11 = FLAG_DEFAUT11+0;
regle 1011005:
application : iliad , batch;  
INDCODDAJ = positif(present(CODDAJ)+present(CODDBJ)+present(CODEAJ)+present(CODEBJ));
regle 1000200:
application : iliad , batch;  

DEFRI = positif( RIDEFRI 
                 + DEFRIGLOBSUP + DEFRIGLOBINF + DEFRIBASUP + DEFRIBAINF + DEFRIBIC 
                 + DEFRILOC + DEFRIBNC + DEFRIRF + DEFRIRCM + DEFRITS + DEFRIMOND + 0) ;

regle 1000270:
application : iliad , batch;  


RIDEFRI = positif( PREM8_11) *  positif( RED_AVT_DS1731 ) * positif( IDOM11TOUT - DEC11TOUT) 
         
          + (1-positif(PREM8_11)) * positif( RED_AVT_DS1731 ) * (1 - positif( IDOM111731 - DEC111731 - ITRED1731 ))
            * positif( IDOM11TOUT - DEC11TOUT) ;

regle 1000290:
application : iliad , batch;  


SOMMEBA = 
  BAFV
 + BAFC
 + BAFP
 + BAFORESTV
 + BAFORESTC
 + BAFORESTP
 + BAFPVV
 + BAFPVC
 + BAFPVP
 + BACREV
 + BAHREV
 + BACREC
 + BAHREC
 + BACREP
 + BAHREP +0;
SOMMEBIC =
  MIBNPVENV
 + MIBNPVENC
 + MIBNPVENP
 + MIBNPPRESV
 + MIBNPPRESC
 + MIBNPPRESP
 + MIBNPPVV
 + MIBNPPVC
 + MIBNPPVP
 + BICREV
 + BICHREV
 + BICREC
 + BICHREC
 + BICREP
 + BICHREP+0;
SOMMELOC = 
  MIBMEUV
 + MIBMEUC
 + MIBMEUP
 + MIBGITEV
 + MIBGITEC
 + MIBGITEP
 + LOCGITV
 + LOCGITC
 + LOCGITP+0;
SOMMEBNC =
  BNCNPV
 + BNCNPC
 + BNCNPP
 + BNCNPPVV
 + BNCNPPVC
 + BNCNPPVP
 + BNCAABV
 + ANOCEP
 + BNCAABC
 + ANOVEP
 + BNCAABP
 + ANOPEP+0;
SOMMERF =
  RFORDI
 + RFMIC
 + FONCI
 + REAMOR+0;
SOMMERCM =
  RCMAV
 + RCMABD
 + RCMTNC
 + REGPRIV
 + RCMHAB
 + RCMHAD
 + PROVIE
 + REVACT
 + REVPEA
 + RESTUC
 + INTERE
 + DISQUO+0;

regle 1000300:
application : iliad , batch;  


VARBA = positif(SOMMEBATOUT - max(SOMMEBAP2,SOMMEBA1731))+0;
VARBIC = positif(SOMMEBICTOUT - max(SOMMEBICP2,SOMMEBIC1731))+0;
VARLOC = positif(SOMMELOCTOUT - max(SOMMELOCP2,SOMMELOC1731))+0;
VARBNC = positif(SOMMEBNCTOUT - max(SOMMEBNCP2,SOMMEBNC1731))+0;
VARRF = positif(SOMMERFTOUT - max(SOMMERFP2,SOMMERF1731))+0;
VARRCM = positif(SOMMERCMTOUT - max(SOMMERCMP2,SOMMERCM1731))+0;
VAR8ZU = positif(DEF8ZUTOUT - max(DEF8ZUP2,DEF8ZU1731))+0;

regle 1000310:
application : iliad , batch;  
DEFRIGLOBSUP =  
              positif(PREM8_11)  * CODERAPPEL *
            positif(SHBATOUT - SEUIL_IMPDEFBA) * positif(RFDHIS1731 + BICDNV1731 + BIHDNV1731 + BICDNC1731 + BIHDNC1731
 + BICDNP1731 + BIHDNP1731 + LOCDEFPROCGAV1731 + LOCDEFPROV1731 + LOCDEFPROCGAC1731 + LOCDEFPROC1731 + LOCDEFPROCGAP1731 + LOCDEFPROP1731
 + BNCDEV1731 + BNHDEV1731 + BNCDEC1731 + BNHDEC1731 + BNCDEP1731 + BNHDEP1731 + DEFAA51731 + DEFAA41731 + DEFAA31731 + DEFAA21731
 + DEFAA11731 + DEFAA01731)
            + (1-positif(PREM8_11)) * CODERAPPEL *
            positif(SHBATOUT - SEUIL_IMPDEFBA) * positif(RFDHIS1731 + BICDNV1731 + BIHDNV1731 + BICDNC1731 + BIHDNC1731
 + FRNV1731 + FRNC1731 + FRN11731 + FRN21731 + FRN31731 + FRN41731
 + BICDNP1731 + BIHDNP1731 + LOCDEFPROCGAV1731 + LOCDEFPROV1731 + LOCDEFPROCGAC1731 + LOCDEFPROC1731 + LOCDEFPROCGAP1731 + LOCDEFPROP1731
 + BNCDEV1731 + BNHDEV1731 + BNCDEC1731 + BNHDEC1731 + BNCDEP1731 + BNHDEP1731 + DEFAA51731 + DEFAA41731 + DEFAA31731 + DEFAA21731
 + DEFAA11731 + DEFAA01731) * positif(abs(DRBG1731))+0;
DEFRIGLOBINF =  
              positif(PREM8_11)  * CODERAPPEL *
             (1-positif(SHBATOUT - SEUIL_IMPDEFBA)) * positif(RFDHIS1731 + BICDNV1731 + BIHDNV1731 + BICDNC1731 + BIHDNC1731
          +BACDEV1731 + BAHDEV1731 + BACDEC1731 + BAHDEC1731 + BACDEP1731 + BAHDEP1731
 + FRNV1731 + FRNC1731 + FRN11731 + FRN21731 + FRN31731 + FRN41731
 + BICDNP1731 + BIHDNP1731 + LOCDEFPROCGAV1731 + LOCDEFPROV1731 + LOCDEFPROCGAC1731 + LOCDEFPROC1731 + LOCDEFPROCGAP1731 + LOCDEFPROP1731
 + BNCDEV1731 + BNHDEV1731 + BNCDEC1731 + BNHDEC1731 + BNCDEP1731 + BNHDEP1731 + DEFAA51731 + DEFAA41731 + DEFAA31731 + DEFAA21731
 + DEFAA11731 + DEFAA01731 )
            + (1-positif(PREM8_11)) * CODERAPPEL *
             (1-positif(SHBATOUT - SEUIL_IMPDEFBA)) * positif(RFDHIS1731 + BICDNV1731 + BIHDNV1731 + BICDNC1731 + BIHDNC1731
          +BACDEV1731 + BAHDEV1731 + BACDEC1731 + BAHDEC1731 + BACDEP1731 + BAHDEP1731
 + BICDNP1731 + BIHDNP1731 + LOCDEFPROCGAV1731 + LOCDEFPROV1731 + LOCDEFPROCGAC1731 + LOCDEFPROC1731 + LOCDEFPROCGAP1731 + LOCDEFPROP1731
 + BNCDEV1731 + BNHDEV1731 + BNCDEC1731 + BNHDEC1731 + BNCDEP1731 + BNHDEP1731 + DEFAA51731 + DEFAA41731 + DEFAA31731 + DEFAA21731
 + DEFAA11731 + DEFAA01731) * positif(abs(DRBG1731))+0;
DEFRIBASUP = 
              positif(PREM8_11)  * CODERAPPEL *
             positif(DAGRI61731 + DAGRI51731 + DAGRI41731 + DAGRI11731 + DAGRI31731 + DAGRI21731 + BACDEV1731 + BAHDEV1731 + BACDEC1731 + BAHDEC1731 + BACDEP1731 + BAHDEP1731 )
             * positif(VARBA + PRESENTBA) * positif(SHBATOUT - SEUIL_IMPDEFBA)
            + (1-positif(PREM8_11)) * CODERAPPEL *
             positif(DAGRI61731 + DAGRI51731 + DAGRI41731 + DAGRI11731 + DAGRI31731 + DAGRI21731 + BACDEV1731 + BAHDEV1731 + BACDEC1731 + BAHDEC1731 + BACDEP1731 + BAHDEP1731 )
            * null(RBAT1731 + BAQTOTAVIS1731) * positif(VARBA) * positif(SHBATOUT - SEUIL_IMPDEFBA)+0;
DEFRIBAINF = 
              positif(PREM8_11)  * CODERAPPEL *
             positif(DAGRI61731 + DAGRI51731 + DAGRI41731 + DAGRI11731 + DAGRI31731 + DAGRI21731 )
             * positif(VARBA+PRESENTBA) * (1-positif(SHBATOUT - SEUIL_IMPDEFBA))
            + (1-positif(PREM8_11)) * CODERAPPEL *
             positif(DAGRI61731 + DAGRI51731 + DAGRI41731 + DAGRI11731 + DAGRI31731 + DAGRI21731 )
            * null(RBAT1731 + BAQTOTAVIS1731) * positif(VARBA) * (1-positif(SHBATOUT - SEUIL_IMPDEFBA))+0;
DEFRIBIC = 
              positif(PREM8_11)  * CODERAPPEL *
             positif(DEFBIC61731 + DEFBIC51731 + DEFBIC41731 + DEFBIC31731 + DEFBIC21731 + DEFBIC11731 + BICDEV1731
                 + BICHDEV1731 + BICDEC1731 + BICHDEC1731 + BICDEP1731 + BICHDEP1731)
            * positif(VARBIC+PRESENTBIC )
            + (1-positif(PREM8_11)) * CODERAPPEL *
             positif(DEFBIC61731 + DEFBIC51731 + DEFBIC41731 + DEFBIC31731 + DEFBIC21731 + DEFBIC11731 + BICDEV1731
                 + BICHDEV1731 + BICDEC1731 + BICHDEC1731 + BICDEP1731 + BICHDEP1731)
          * null(BICNPF1731) * positif(VARBIC)+0;
DEFRILOC = 
              positif(PREM8_11)  * CODERAPPEL *
             positif( LNPRODEF101731 + LNPRODEF91731 + LNPRODEF81731 + LNPRODEF71731 + LNPRODEF61731 + LNPRODEF51731 + LNPRODEF41731 + LNPRODEF31731
 + LNPRODEF21731 + LNPRODEF11731 + LOCDEFNPCGAV1731 + LOCDEFNPV1731 + LOCDEFNPCGAC1731 + LOCDEFNPC1731 + LOCDEFNPCGAPAC1731 + LOCDEFNPPAC1731)
           * positif(VARLOC+ PRESENTLOC )
            + (1-positif(PREM8_11)) * CODERAPPEL *
             positif( LNPRODEF101731 + LNPRODEF91731 + LNPRODEF81731 + LNPRODEF71731 + LNPRODEF61731 + LNPRODEF51731 + LNPRODEF41731 + LNPRODEF31731
 + LNPRODEF21731 + LNPRODEF11731 + LOCDEFNPCGAV1731 + LOCDEFNPV1731 + LOCDEFNPCGAC1731 + LOCDEFNPC1731 + LOCDEFNPCGAPAC1731 + LOCDEFNPPAC1731)
          * null(NPLOCNETF1731) * positif(VARLOC)+0;
DEFRIBNC = 
              positif(PREM8_11)  * CODERAPPEL *
             positif( DABNCNP61731  + DABNCNP51731 + DABNCNP41731
                   + DABNCNP31731 + DABNCNP21731  + DABNCNP11731 + BNCAADV1731
                   + DNOCEPC1731 + DNOCEPP1731  + BNCAADC1731 + BNCAADP1731  + DNOCEP1731)
           * positif(VARBNC+ PRESENTBNC)
            + (1-positif(PREM8_11)) * CODERAPPEL *
             positif( DABNCNP61731  + DABNCNP51731 + DABNCNP41731  + DABNCNP31731 + DABNCNP21731  
                  + DABNCNP11731 + BNCAADV1731  
                  + DNOCEPC1731 + DNOCEPP1731  + BNCAADC1731 + BNCAADP1731  + DNOCEP1731)
          * null(BNCIF1731) * positif(VARBNC)+0;
DEFRIRF = 
              positif(PREM8_11)  * CODERAPPEL *
             positif(RFDORD1731+ RFDANT1731)  * positif(VARRF+PRESENTRF)
            + (1-positif(PREM8_11)) * CODERAPPEL *
             positif(RFDORD1731+ RFDANT1731) * (1-positif(RRFI1731+REVRF1731)) * positif(VARRF)+0;
DEFRIRCM = positif(RCMFR1731) * null(RRCM1731+REVRCM1731) * positif(VARRCM)+0;
DEFRITS = 
              positif(PREM8_11)  * CODERAPPEL *
           ( present(FRNV1731) * null(TSPRV) 
             +present(FRNC1731) * null(TSPRV)
             +positif(present(FRN11731)+ present(FRN21731)+ present(FRN31731)+ present(FRN41731))) * null(TSPRP) +0;
DEFRIMOND = positif(PREM8_11)  * CODERAPPEL * positif(present(IPTEFN1731)+present(DMOND1731)+present(DEFZU1731))
            + (1-positif(PREM8_11)) * CODERAPPEL *
                positif(present(IPTEFN1731)+present(DMOND1731)+present(DEFZU1731)) * VAR8ZU;
regle 1000320:
application : iliad   , batch ;
ART1731 = positif( FLAG_1731)
                      +  positif(DEFRI) * (
                       positif(positif(PREM8_11) * null(VARR30R32) 
                         + null(CODERAPHOR)))
                                                ;

regle 1000330:
application : iliad   , batch ;

PRESENTBA = positif(present( BAFV1731 ) + present( BAFC1731 ) + present( BAFP1731 ) + present( BAFORESTV1731 )
                  + present( BAFORESTC1731 ) + present( BAFORESTP1731 ) + present( BAFPVV1731 ) + present( BAFPVC1731 )
                  + present( BAFPVP1731 ) + present( BACREV1731 ) + present( BAHREV1731 ) + present( BACREC1731 )
                  + present( BAHREC1731 ) + present(BACREP1731 ) + present( BAHREP1731 ));
PRESENTBIC = positif( present( MIBNPVENV1731 )  + present( MIBNPVENC1731 ) + present(MIBNPVENP1731 ) + present( MIBNPPRESV1731 ) + present( MIBNPPRESC1731 )  
                    + present( MIBNPPRESP1731 ) + present( MIBNPPVV1731 ) + present( MIBNPPVC1731 ) + present( MIBNPPVP1731 ) + present( BICREV1731 )
                    + present( BICHREV1731 ) + present( BICREC1731 ) + present( BICREP1731 ) + present( BICHREP1731 ));
PRESENTBNC = positif( present( BNCNPV1731 ) + present( BNCNPC1731 ) + present( BNCNPP1731 ) + present( BNCNPPVV1731 ) + present( BNCNPPVC1731 )
                    + present( BNCNPPVP1731 ) + present( BNCAABV1731 ) + present( ANOCEP1731 ) + present( BNCAABC1731 )
                    + present( ANOVEP1731 ) + present( BNCAABP1731 ) + present( ANOPEP1731 ));
PRESENTLOC = positif(present( MIBMEUV1731 ) + present( MIBMEUC1731 ) + present( MIBMEUP1731 ) + present( MIBGITEV1731 ) + present( MIBGITEC1731 ) 
                   + present( MIBGITEP1731 ) + present( LOCGITV1731 ) + present( LOCGITC1731 ) + present( LOCGITP1731 )
                    + present( LOCNPCGAV1731 ) + present( LOCNPV1731 ) + present( LOCNPCGAC1731 ) + present( LOCNPC1731 ) + present( LOCNPCGAPAC1731 )
                    + present( LOCNPPAC1731 ) + present( LOCGITCV1731 ) + present( LOCGITHCV1731 ) + present( LOCGITCC1731 ) + present( LOCGITHCC1731 )
                    + present( LOCGITCP1731 ) + present( LOCGITHCP1731 ));
PRESENTRF = positif(  present( RFORDI1731 ) + present(RFMIC1731 ) + present( FONCI1731 ) + present( REAMOR1731 ) );
 # ======================================================================
