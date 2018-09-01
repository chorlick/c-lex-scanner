; ###############################################################################################
; ####                      Set the Drawing Size for Symbols and Boards                      ####
; ####                                                                                       ####
; ####  Purpose                : Set the Samtec Drawing Size for designs and footprints      ####
; ####                                                                                       ####
; ####  Written by             : Greg Horlick                                                ####
; ####                                                                                       ####
; ####  Revision Hisory        : Created 07/02/18, Ver 18070201                              ####
; ####                                                                                       ####
; ####  INPUT PARAMETERS       : SMTC_DWGSize - a string that contains the Drawing Format    ####
; ####                                          page size                                    ####
; ####                                                                                       ####
; ####  RETURN PARAMETERS      : None - tests to see if the property can be set and outputs  ####
; ####                                  message to the allegro cmd window of success         ####
; ####                                                                                       ####
; ####  Usage: INTERNAL SAMTEC UTILITY                                                       ####
; ####                                                                                       ####
; ####  Encryption (Standalone):                                                             ####
; ####        encrypt("SMTC_SetDrawingSize.ils"  "SMTC_SetDrawingSize.ile")                  ####
; ####        load  "SMTC_SetDrawingSize.ile"                                                ####
; ####                                                                                       ####
; ###############################################################################################

procedure( SMTC_SetDrawingSize( SMTC_DWGSize )
			let( ( DBStatus )
				; ###############################################################################
				; #### DBPropStatus - a flag to test if the command could set the database   ####
				; #### property.                                                             ####
				; #### nil indicates an error was encountered. otherwise print a msg         ####
				; ###############################################################################

				DBPropStatus = nil

				axlDBCreatePropDictEntry( "SMTC_DWG_SIZE"   "STRING" t)
				DBPropStatus = axlDBAddProp( axlDBGetDesign() list( "SMTC_DWG_SIZE" SMTC_DWGSize ) )

				if( DBPropStatus != nil then
					axlMsgPut("Samtec Drawing Size Property was Set...... %s" SMTC_DWGSize )
				else
					axlMsgPut("!!!!! UNABLE TO SET SAMTEC DRAWING SIZE PROPERTY !!!!!" )
					)    ; end if the property was set successfully
			)    ; end let
		)    ; end procedure - SMTC_SetDrawingSize
