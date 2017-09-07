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
regle 8740:
application : pro , oceans , iliad , batch ;
XFORFAIT  = somme(i=V,C,P: FEXi);
regle 8741:
application : pro , oceans , iliad , batch ;
XACCESS  = somme(i=V,C,P: XACCESSi);
regle 8745:
application : pro , oceans , iliad , batch ;
pour i = V,P,C:
XBAi = BAHEXi + BAEXi ;
pour i = V,P,C:
XBIPi = BIHEXi + BICEXi;
pour i = V,P,C:
XBINPi = BICNPHEXi + BICNPEXi;
pour i = V,P,C:
XBNi = BNHEXi + BNCEXi ;
pour i = V,P,C:
XBNNPi = BNCNPREXi+BNCNPREXAAi ;
regle 872:
application : pro , oceans , iliad , batch ;
pour i=V,C,P:
XBICHDi = (BICEXi + BICNOi)  ;
pour i=V,C,P:
XBICNETi = XBICHDi - ( BICDNi )  ;
pour i=V,C,P:
XBICSi =  XBICNETi + BA1Ai ;
pour i=V,C,P:
XBICNPHDi = BICNPEXi + BICREi ;
pour i=V,C,P:
XBICNPNETi = XBICNPHDi - BICDEi ;
pour i=V,C,P:
XBICNPSi =  XBICNPNETi + BI2Ai ;
pour  i = V,C,P:
XBITi = max (0 , XBICNETi + max (0,XBICNPNETi )); 
pour  i = V,C,P:
XBISi = positif(max(0,XBICNETi + max(0,XBICNPNETi)))
        * ( BI2Ai  + BI1Ai  );

pour i=V,C,P:
XBICIMPi =  XBICHDi + XBICNPHDi ;
regle 8728:
application : pro , oceans , iliad , batch ;
pour i=V,C:
XTSBi =  somme(x=1..3:GLDxi) + TSBNi + BPCOSAi + TSASSUi + XETRANi + HEURESUPi + EXOCETi ;

pour i=1,2,3,4:
XTSBi =  TSBNi + HEURESUPPi ;
pour i=V,C:
XEXTSi = XTSBi + CARTSi + REMPLAi;
pour i=1,2,3,4:
XEXTSi = XTSBi + CARTSPi + REMPLAPi;
regle 8731:
application : pro , oceans , iliad , batch ;
pour i = V,C,1,2,3,4:
XTPS10i = arr (XEXTSi * TX_DEDFORFTS /100);
pour i = V,C,1,2,3,4:
XDFNi =  min( PLAF_DEDFORFTS , XTPS10i );
regle 8729:
application : pro , oceans , iliad , batch ;
pour i = V,C,1,2,3,4:
X10MINSi= max( min(XTSBi,DEDMINi) , XDFNi );
pour i = V,C,1,2,3,4:
XIND_10i= positif_ou_nul(X10MINSi-FRNi);
pour i = V,C,1,2,3,4:
XDFi = X10MINSi  ;
pour i = V,C,1,2,3,4:
XFPTi = XDFi * XIND_10i + FRDi * (1 - XIND_10i);
pour i = V,C,1,2,3,4:
XTSNTi =  XEXTSi - XFPTi;
regle 8734:
application : pro , oceans , iliad , batch ;
pour i = V,C,1,2,3,4:
XTSNi = positif (-XTSNTi) * min (0 , XTSNTi)
     + positif_ou_nul (XTSNTi) * XTSNTi;
regle 8735:
application : pro , oceans , iliad , batch ;
pour i = V,C:
XTSi = XTSNi -  somme(x=1..3: max(0,GLDxi - ABGLxi));
pour i = V,C:
XHSUPTSNNi = arr( positif(XTSNi) * 
         XTSNi  
         * (HEURESUPi/XEXTSi)) * XIND_10i
	 + (1-XIND_10i) * HEURESUPi;
pour i = 1,2,3,4:
XHSUPTSNNi = arr( positif(XTSNi) * 
         XTSNi  
         * (HEURESUPPi/XEXTSi)) * XIND_10i
	 + (1-XIND_10i) * HEURESUPPi;
HEURESUPTOT = somme(i=1..4: HEURESUPPi);
XHSUPTSTOT = somme(i=1..4: XHSUPTSNNi);
HEURSUP = XHSUPTSNNV +  XHSUPTSNNC +  XHSUPTSNN1 +  XHSUPTSNN2 +  XHSUPTSNN3 +  XHSUPTSNN4;  
pour i = V,C:
XTSNNi = arr( positif(XTSNi) * 
         XTSNi  
         * (TSASSUi/XEXTSi)) * XIND_10i
	 + (1-XIND_10i) * TSASSUi;
pour i = V,C:
XETSNNi = arr( positif(XTSNi) * 
         XTSNi  
         * (XETRANi/XEXTSi)) * XIND_10i
	 + (1-XIND_10i) * XETRANi;
pour i = V,C:
XEXOCETi = arr( positif(XTSNi) * 
         XTSNi  
         * (EXOCETi/XEXTSi)) * XIND_10i
	 + (1-XIND_10i) * EXOCETi;
XEXOCET = somme(i=V,C:XEXOCETi);
pour i = V,C:
DTSELUPPEi = TSELUPPEi * (1 - V_CNR);
pour i = V,C:
XLUXTSNNi = arr( positif(XTSNi) * XTSNi  
         * (DTSELUPPEi/XEXTSi)) * XIND_10i
	 + (1-XIND_10i) * DTSELUPPEi;
regle 876:
application : pro , oceans , iliad , batch ;
XELU = ELURASC + ELURASV ;
regle 875:
application : pro , oceans , iliad , batch ;
GLN2NET = arr(GLN2 * GL2 / REV2);
GLN3NET = arr(GLN3 * GL3 / REV3);
QUOKIRE =   GL1 + GL2 + GL3 + RPQ4
             + somme (x=V,C,1..4 : RPQPRRx+ GLFx+ RPQTSx+ RPQTSREMPx+RPQPALIMx)
             + RPQRF1 + GLRF2 + RPQRCMDC + RPQRCMFU + RPQRCMCH
             + RPQRCMTS + RPQRCMGO + RPQRCMTR + RPQRVO + RPQRVO5 + RPQRVO6 + RPQRVO7;
regle 8727:
application : pro , oceans , iliad , batch ;

VARREVKIRE =  BPCAPTAXV + BPCAPTAXC
              + somme( i=V,C,P: XBAi+XBIPi+XBINPi+XBNi+XBNNPi)
              + somme (i=V,C,P: MIBEXi + MIBNPEXi + BNCPROEXi + XSPENPi)
              + somme (i=V,C,P: BNCCRi)
              + somme (i=V,C,P: BNCCRFi)
              + somme (i=V,C: XETSNNi)
              + somme (i=V,C: XEXOCETi)
              + somme (i=V,C: XTSNNi)
              + somme (i=V,C,1,2,3,4: XHSUPTSNNi)
              + XFORFAIT + XACCESS 
              + RCMLIB + PPLIB + RCMLIBDIV
              + GAINABDET
              + PVJEUNENT
              + RCMEXCREF
              + XELU 
              + RCMIMPAT
              + PVPART
              + PVIMMO
              + PVTITRESOC 
              + BTP3A
              + (max(0,BTP3G + ABDETPLUS + ABIMPPV - ABDETMOINS - ABIMPMV) 
              + BPVCESDOM * positif(V_EAD+V_EAG) * (1-positif(IPVLOC)) + BPTP18 + BPTP40 + BPTP4 + BTP3N + BPTP2 )
	      ;

REVKIRE = (1-null(IND_TDR)) *
 arr (
       max ( 0, ( 
                  (1-positif(IPTEFP+IPTEFN+INDTEFF)) * (RI1)  
                  + positif(IPTEFP+IPTEFN+INDTEFF) * IPTEFP
                  + positif(IPTEFP+IPTEFN+INDTEFF) 
                  * positif(- TEFFN - DRBG - RNIDF + (APERPV + APERPC + APERPP)* (1 - positif(null(2-V_REGCO) + null(4-V_REGCO))) + QUOKIRE)*
		   ( (APERPV + APERPC + APERPP)* (1 - positif(null(2-V_REGCO) + null(4-V_REGCO)))
		   + QUOKIRE
                   ) 
                  + max(0,TEFFREVTOT*INDTEFF) * (1-positif(IPTEFP))
                )
                * (1-present(IND_TDR))
                + 
                   IND_TDR
		   + (1-positif(IPTEFP+IPTEFN+INDTEFF)) * 
		     (QUOKIRE + (APERPV + APERPC + APERPP)* (1 - positif(null(2-V_REGCO) + null(4-V_REGCO))) )
		   +  VARREVKIRE
             )
       ) 
       ;

pour i=V,C,P:
BNCCREAi = BNCCRi + BNCCRFi ;
QUOKIREHR =   GL1 + GL2 + GL3 + GL4
             + somme (x=V,C,1..4 : GLPRRx+ GLFx+ GLTSx+ GLTSREMPx+GLPALIMx)
             + GLRF1 + GLRF2 + GLRCMDC + GLRCMFU + GLRCMCH
             + GLRCMTS + GLRCMGO + GLRCMTR + GLRVO + GLRVO5 + GLRVO6 + GLRVO7;
REVKIREHR =  (1-null(IND_TDR)) *
 arr (
       max ( 0, ( 
                  (1-positif(IPTEFP+IPTEFN+INDTEFF)) * (RI1)  
                  + positif(IPTEFP+IPTEFN+INDTEFF) * IPTEFP
                  + positif(IPTEFP+IPTEFN+INDTEFF) 
                  * positif(- TEFFN - DRBG - RNIDF + (APERPV + APERPC + APERPP)* (1 - positif(null(2-V_REGCO) + null(4-V_REGCO))) + QUOKIREHR+(RFROBOR*V_INDTEO))*
		   ( (APERPV + APERPC + APERPP)* (1 - positif(null(2-V_REGCO) + null(4-V_REGCO))) 
		   + QUOKIREHR + (RFROBOR * V_INDTEO* (1-INDTEFF))
                   ) 
                  + max(0,TEFFREVTOT*INDTEFF) * (1-positif(IPTEFP))
                )
                * (1-present(IND_TDR))
                + 
                   IND_TDR
		   + (1-positif(IPTEFP+IPTEFN+INDTEFF)) * 
		     (QUOKIREHR + (APERPV + APERPC + APERPP)* (1 - positif(null(2-V_REGCO) + null(4-V_REGCO)))) 
		   +  VARREVKIRE
             )
       ) 
       ;
regle 410 :
application : batch, iliad, pro, oceans;
CDEVDUR_NBJ = PPENBJ;
CKIREDUR = arr(REVKIRE * 360/CDEVDUR_NBJ);
REVKIREDUR2 = CKIREDUR ;


