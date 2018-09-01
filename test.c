void smtc_setdrawingsize(char* smtc_dwgsize)
{
        int dbpropstatus=0;
        axldbcreatepropdictentry("SMTC_DWG_SIZE","STRING",true);
        dbpropstatus = axldbaddprop(axldbgetdesign());

        if(dbpropstatus != 0) {
                axlmsgput("Samtec Drawing Size Property was Set...... %s",smtc_dwgsize);
        }

        if(dbpropstatus == 1) {
                axlmsgput("!!!!! UNABLE TO SET SAMTEC DRAWING SIZE PROPERTY !!!!!");
        }
}
