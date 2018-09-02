void SMTC_SetDrawingSize(SMTC_DWGSize)
{
        DBPropStatus = NULL;
        axlDBCreatePropDictEntry("SMTC_DWG_SIZE","STRING", true);
        DBPropStatus = axlDBAddProp(axlDBGetDesign(), list( "SMTC_DWG_SIZE" SMTC_DWGSize ) );

        if(DBPropStatus != 0) {
                axlMsgPut("Samtec Drawing Size Property was Set......%s", SMTC_DWGSize);
        }

        if(DBPropStatus == 1) {
                axlMsgPut("!!!!! UNABLE TO SET SAMTEC DRAWING SIZE PROPERTY !!!!!");
        }
}


void testStuff(new Var) {


}
