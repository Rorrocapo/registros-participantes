/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import javax.swing.JComboBox;
import javax.swing.JTextField;
import org.apache.commons.codec.digest.DigestUtils;

/**
 *
 * @author Darke
 */
public class CreateUser {
    private boolean task=true;
    private String user,password,typeUser;
    public CreateUser(JTextField usr, JTextField psswd, JComboBox type) throws Throwable{
        user= usr.getText();
        password= DigestUtils.md5Hex(psswd.getText()); 
        typeUser= type.getSelectedItem().toString();
        new Model.ProcedureCreateDeleteUser(user, password, typeUser ,task);
       this.finalize();
    }
}
