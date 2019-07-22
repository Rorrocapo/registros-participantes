/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.ProcedureValidateUser;
import javax.swing.JPasswordField;
import javax.swing.JTextField;
import org.apache.commons.codec.digest.DigestUtils;

/**
 *
 * @author darkness
 */
public class ValidateAdmin {
    public static boolean validate=false;
    public static String userName;
    public ValidateAdmin(JTextField usr, JPasswordField psswd) throws Throwable{
        String user=usr.getText();
        String password= new String(psswd.getPassword());
        password= DigestUtils.md5Hex(password);
        String statement = "SELECT usuario FROM usuarios WHERE usuario='"+user+"' and contraseña='"+password+"' and tipo_usuario='admin'";
        new ProcedureValidateUser(statement,user);
        userName=Model.ProcedureValidateUser.userName;
        this.finalize();
    }
    
}
