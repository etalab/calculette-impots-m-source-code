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
verif 1800:
application : iliad , batch ;


si
   RG + 2 < PRODOM + PROGUY

alors erreur A800 ;
verif 18021:
application : iliad , batch ;


si
   (V_NOTRAIT >= 20
    et
    IPTEFP > 0
    et
    IPTEFN > 0)
   ou
   (V_NOTRAIT + 0 < 20
    et
    IPTEFP >= 0
    et
    IPTEFN >= 0
    et
    V_ROLCSG+0 < 40)

alors erreur A80201 ;
verif 18022:
application : iliad , batch ;


si
   (
    V_NOTRAIT + 0 < 20
    et
    IPTEFP + IPTEFN >= 0
    et
    PRODOM + PROGUY + CODDAJ + CODDBJ + CODEAJ + CODEBJ >= 0
   )
   ou
   (
    V_NOTRAIT >= 20
    et
    IPTEFP + IPTEFN > 0
    et
    PRODOM + PROGUY + CODDAJ + CODDBJ + CODEAJ + CODEBJ > 0
   )

alors erreur A80202 ;
verif 18023:
application : iliad , batch ;

si
   (
    V_NOTRAIT + 0 < 20
    et
    SOMMEA802 > 0
    et
    PRODOM + PROGUY + CODDAJ + CODDBJ + CODEAJ + CODEBJ >= 0
   )
   ou
   (
    V_NOTRAIT >= 20
    et
    SOMMEA802 > 0
    et
    PRODOM + PROGUY + CODDAJ + CODDBJ + CODEAJ + CODEBJ > 0
   )

alors erreur A80203 ;
verif 1803:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   positif(CODDAJ + CODDBJ + CODEAJ + CODEBJ + 0) = 1
   et
   V_REGCO + 0 != 1

alors erreur A803 ;
verif 1804:
application : iliad , batch ;


si
   PROGUY + PRODOM + CODDAJ + CODEAJ + CODDBJ + CODEBJ+ 0 > 0
   et
   SOMMEA804 > 0

alors erreur A804 ;
verif 1805:
application : iliad , batch ;


si
   V_IND_TRAIT > 0
   et
   positif(TREVEX) = 1
   et
   SOMMEA805 = 0

alors erreur A805 ;
verif 1806:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   positif(PROGUY + PRODOM + CODDAJ + CODEAJ + CODDBJ + CODEBJ + 0) = 1
   et
   ((positif(CARTSNBAV + 0) = 1
     et    
     null(CARTSNBAV - 4) = 0)
   ou
    (positif(CARTSNBAC + 0) = 1
     et 
     null(CARTSNBAC - 4) = 0))

alors erreur A806 ;
verif 1807:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   positif(PRELIBXT + 0) = 1
   et
   positif(PCAPTAXV + PCAPTAXC + 0) = 0

alors erreur A807 ;
verif 1808:
application : iliad , batch ;

si
   positif(COD5XT + COD5XV + COD5XU + COD5XW + 0) = 1
   et
   positif(PRODOM + PROGUY + CODEAJ + CODEBJ + CODDAJ + CODDBJ + 0) = 1

alors erreur A808 ;
verif 1810:
application : iliad ;

si
   V_NOTRAIT > 10
   et
   COD8RU + COD8RV > BCSGNORURV + 0

alors erreur A810 ;
verif 1821:
application : iliad , batch ;

si
   (V_IND_TRAIT > 0 )
   et
   present(BASRET) + present(IMPRET) = 1

alors erreur A821 ;
verif corrective 1850:
application : iliad ;

si 
   APPLI_OCEANS = 0 
   et 
   V_NOTRAIT > 20
   et
   (positif(CSPROVYD) = 1
    ou
    positif(CSPROVYE) = 1
    ou
    positif(CSPROVYF) = 1
    ou
    positif(CSPROVYG) = 1
    ou
    positif(CSPROVYH) = 1
    ou
    positif(COD8YL) = 1
    ou
    positif(CSPROVYN) = 1
    ou
    positif(CSPROVYP) = 1
    ou
    positif(COD8YT) = 1
    ou
    positif(CDISPROV) = 1
    ou
    positif(IRANT) = 1
    ou
    positif(CRDSIM) = 1
    ou
    positif(CSGIM) = 1
    ou
    positif(DCSGIM) = 1
    ou
    positif(PRSPROV) = 1)

alors erreur A850 ;
verif corrective 1851:
application : iliad ;

si
   APPLI_OCEANS = 0
   et
   V_NOTRAIT > 20
   et
   positif(CRDSIM) = 1

alors erreur A851 ;
verif corrective 1852:
application : iliad ;

si
   APPLI_OCEANS = 0
   et
   present(CSGIM) = 1
   et
   V_NOTRAIT > 20

alors erreur A852 ;
verif corrective 1853:
application : iliad ;

si
   APPLI_OCEANS = 0
   et
   present(PRSPROV) = 1
   et
   V_NOTRAIT > 20

alors erreur A853 ;
verif 1858:
application : iliad , batch ;

si
   COD8TL + COD8UW + 0 > 0
   et
   SOMMEA858 = 0

alors erreur A858 ;
verif 1859:
application : iliad , batch ;

si
   PRESINTER > 0
   et
   SOMMEA859 = 0

alors erreur A859 ;
verif 1862:
application : iliad , batch ;

si
   AUTOVERSLIB > 0
   et
   SOMMEA862 = 0

alors erreur A862 ;
verif corrective 1863:
application : iliad ;

si
   APPLI_OCEANS = 0
   et
   positif(AUTOVERSSUP + 0) = 1
   et
   positif(AUTOBICVV + AUTOBICPV + AUTOBNCV
           + AUTOBICVC + AUTOBICPC + AUTOBNCC
           + AUTOBICVP + AUTOBICPP + AUTOBNCP + 0) = 0

alors erreur A863 ;
verif 1864:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   COD8YL + 0 > CGLOA + 0

alors erreur A864 ;
verif 1865:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   COD8YT + 0 > CVNN + 0

alors erreur A865 ;
verif 18661:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   CSPROVYD + 0 > max(0 , RSE1 + PRSE1 - CIRSE1) + 0

alors erreur A86601 ;
verif 18662:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   CSPROVYE + 0 > max(0 , RSE5 + PRSE5 - CIRSE5) + 0

alors erreur A86602 ;
verif 18663:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   CSPROVYF + 0 > max(0 , RSE8TV + arr(max(0 , RSE8TV - CIRSE8TV - CSPROVYF) * TXINT/100) - CIRSE8TV) + 0

alors erreur A86603 ;
verif 18664:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   CSPROVYG + 0 > max(0 , RSE3 + PRSE3 - CIRSE3) + 0

alors erreur A86604 ;
verif 18665:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   CSPROVYH + 0 > max(0 , RSE8TX + arr(max(0 , RSE8TX - CIRSE8TX - CSPROVYH) * TXINT/100) - CIRSE8TX) + 0

alors erreur A86605 ;
verif 18666:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   CSPROVYN + 0 > max(0 , RSE8SA + arr(max(0 , RSE8SA - CIRSE8SA - CSPROVYN) * TXINT/100) - CIRSE8SA) + 0

alors erreur A86606 ;
verif 18667:
application : iliad , batch ;

si
   V_IND_TRAIT > 0
   et
   CSPROVYP + 0 > max(0 , RSE8SB + arr(max(0 , RSE8SB - CIRSE8SB - CSPROVYP) * TXINT/100) - CIRSE8SB) + 0

alors erreur A86607 ;
verif 1868:
application : batch , iliad ;

si
   V_IND_TRAIT + 0 > 0
   et
   (CDISPROV + 0 > CDIS + 0
    ou
    (positif(CDISPROV + 0) = 1 et positif(GSALV + GSALC + 0) = 0))

alors erreur A868 ;
verif 1870:
application : batch , iliad ;


si
   positif(DCSGIM) = 1 
   et 
   positif(CSGIM + 0) != 1
    
alors erreur A870 ;
verif 1871:
application : batch , iliad ;

si
   CRDSIM > RDSN

alors erreur A871 ;
verif 1872:
application : iliad , batch ;

si
   V_IND_TRAIT + 0 > 0
   et
   PRSPROV > PRS

alors erreur A872 ;
verif 1873:
application : iliad , batch ;

si
   APPLI_OCEANS = 0
   et
   CSGIM > CSG
    
alors erreur A873 ;
verif 1874:
application : iliad , batch ;


si
   IPSOUR >= 0
   et
   V_CNR + 0 = 0
   et
   SOMMEA874 = 0

alors erreur A874 ;
verif 1875:
application : iliad , batch ;

si
   max(0 , IRB + TAXASSUR + IPCAPTAXT + TAXLOY + IHAUTREVT + PTOTD
               - IAVT - RCMAVFT - CICA - I2DH - CICORSE - CIRECH - CICAP
               - CICHR - CICULTUR - CREREVET - CIGLO - CIDONENTR) < IRANT

alors erreur A875 ;
verif 1877:
application : iliad , batch ;


si
   (IPRECH + 0 > 0 ou IPCHER + 0 > 0)
   et
   SOMMEA877 = 0

alors erreur A877 ;
verif 1879:
application : iliad , batch ;


si
   CIINVCORSE + CICORSENOW + 0 > 0
   et
   SOMMEA879 = 0

alors erreur A879 ;
verif 1880:
application : iliad , batch ;


si
   CRIGA > 0
   et
   SOMMEA880 = 0

alors erreur A880 ;
verif 1881:
application : iliad , batch ;


si
   CREFAM > 0
   et
   SOMMEA881 = 0

alors erreur A881 ;
verif 18821:
application : iliad , batch ;


si
  (
   IPMOND > 0
   et
   (present(IPTEFP) = 0 et present(IPTEFN) = 0)
  )
  ou
  (
   (present(IPTEFP) = 1 ou present(IPTEFN) = 1)
   et
   present(IPMOND) = 0
  )

alors erreur A88201 ;
verif 18822:
application : iliad , batch ;

si
   (present(IPMOND)
    + present(SALEXTV) + present(SALEXTC) + present(SALEXT1) + present(SALEXT2) + present(SALEXT3) + present(SALEXT4)
    + present(COD1AH) + present(COD1BH) + present(COD1CH) + present(COD1DH) + present(COD1EH) + present(COD1FH)) = 0
   et
   positif_ou_nul(TEFFHRC + COD8YJ) = 1

alors erreur A88202 ;
verif 1883:
application : iliad , batch ;


si
   IPBOCH > 0
   et
   CIIMPPRO + CIIMPPRO2 + REGCI + PRELIBXT + COD8XF + COD8XG + COD8XH + COD8XV + COD8XY + 0 = 0

alors erreur A883 ;
verif 1884:
application : iliad , batch ;


si
   REGCI + COD8XY > 0
   et
   SOMMEA884 = 0

alors erreur A884 ;
verif 18851:
application : iliad , batch ;


si
   positif(CIIMPPRO2 + 0) = 1
   et
   present(BPVSJ) = 0

alors erreur A88501 ;
verif 18852:
application : iliad , batch ;

si
   positif(COD8XV + 0) = 1
   et
   present(COD2FA) = 0

alors erreur A88502 ;
verif 18853:
application : iliad , batch ;

si
   positif(CIIMPPRO + 0) = 1
   et
   somme(i=V,C,P:present(BA1Ai) + present(BI1Ai) + present(BN1Ai)) = 0

alors erreur A88503 ;
verif 18854:
application : iliad , batch ;

si
   positif(COD8XF + 0) = 1
   et
   present(BPV18V) = 0

alors erreur A88504 ;
verif 18855:
application : iliad , batch ;

si
   positif(COD8XG + 0) = 1
   et
   present(BPCOPTV) = 0

alors erreur A88505 ;
verif 18856:
application : iliad , batch ;

si
   positif(COD8XH + 0) = 1
   et
   present(BPV40V) = 0

alors erreur A88506 ;
verif 1886:
application : iliad , batch ;


si
   IPPNCS > 0
   et
   positif(REGCI + CIIMPPRO + CIIMPPRO2 + COD8XV + COD8XF + COD8XG + COD8XH + COD8PA + 0) != 1

alors erreur A886 ;
verif 1887:
application : iliad , batch ;


si
   APPLI_OCEANS = 0
   et
   REGCI + 0 > IPBOCH + 0

alors erreur A887 ;
verif 1888:
application : iliad , batch ;


si
   IPELUS > 0
   et
   positif(present(TSHALLOV) + present(TSHALLOC) + present(CARTSV) + present(CARTSC) + present(CARTSNBAV) + present(CARTSNBAC)) = 0
   et
   positif(present(ALLOV) + present(ALLOC) + present(REMPLAV) + present(REMPLAC) + present(REMPLANBV) + present(REMPLANBC)) = 0

alors erreur A888 ;
verif 1889:
application : iliad , batch ;


si
   (APPLI_OCEANS = 0)
   et
   REVFONC + 0 > IND_TDR + 0
   et
   present(IND_TDR) = 0

alors erreur A889 ;
verif 1890:
application : iliad , batch ;


si
   CREAPP > 0
   et
   SOMMEA890 = 0

alors erreur A890 ;
verif 1891:
application : iliad , batch ;


si
   CREPROSP > 0
   et
   SOMMEA891 = 0

alors erreur A891 ;
verif 1893:
application : iliad , batch ;


si
   CREFORMCHENT > 0
   et
   SOMMEA893 = 0

alors erreur A893 ;
verif 1894:
application : iliad , batch ;


si
   CREINTERESSE > 0
   et
   SOMMEA894 = 0

alors erreur A894 ;
verif 1895:
application : iliad , batch ;


si
   CREAGRIBIO > 0
   et
   SOMMEA895 = 0

alors erreur A895 ;
verif 1896:
application : iliad , batch ;

si
   CREARTS > 0
   et
   SOMMEA896 = 0

alors erreur A896 ;
verif 1898:
application : iliad , batch ;

si
   CRECONGAGRI > 0
   et
   SOMMEA898 = 0

alors erreur A898 ;
verif 1899:
application : iliad , batch ;


si
   CRERESTAU > 0
   et
   SOMMEA899 = 0

alors erreur A899 ;
