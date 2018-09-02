void SMTC_SetDrawingSize(SMTC_DWGSize)
{
        int DBPropStatus = null;
        axlDBCreatePropDictEntry("SMTC_DWG_SIZE","STRING", true);
        DBPropStatus = axlDBAddProp(axlDBGetDesign());

        if(DBPropStatus != 0) {
                axlMsgPut("Samtec Drawing Size Property was Set......" , SMTC_DWGSize);
        }

        if(DBPropStatus == 1) {
                axlMsgPut("!!!!! UNABLE TO SET SAMTEC DRAWING SIZE PROPERTY !!!!!");
        }
}
 
