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
public class ValidateAdmin {
    public static boolean validate=false;
    public static String userName;
    public ValidateAdmin(String usr, String psswd) throws Throwable{
        String statement = "SELECT * FROM usuarios WHERE usuario='"+usr+"' and contraseña='"+psswd+"' and tipo_usuario='admin'";
        new ProcedureValidateUser(statement);
        this.finalize();
    }
    
}
