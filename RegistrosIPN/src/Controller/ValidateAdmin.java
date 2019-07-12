/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.ProcedureValidateAdmin;

/**
 *
 * @author darkness
 */
public class ValidateAdmin {
    
    public static boolean validate=false;
    
    public  ValidateAdmin() throws Throwable{
        
        new ProcedureValidateAdmin(View.Session.user, View.Session.passwd);
        this.finalize();
        
    }
    
}
