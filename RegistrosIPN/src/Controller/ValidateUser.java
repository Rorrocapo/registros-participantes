/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.ProcedureValidateUser;

/**
 *
 * @author darkness
 */
public class ValidateUser {
    
    public static boolean validate=false;
    
    public  ValidateUser() throws Throwable{
        new ProcedureValidateUser(View.Session.user, View.Session.passwd);
        finalize();
    }
    
}
