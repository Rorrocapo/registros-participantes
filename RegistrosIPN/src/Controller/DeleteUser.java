/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import javax.swing.JComboBox;
import javax.swing.JOptionPane;
import javax.swing.JTextField;

/**
 *
 * @author Darke
 */
public class DeleteUser {
    private boolean task=false;
    private String user,typeUser;
    public DeleteUser(JTextField usr,JTextField type) throws Throwable{
        user=usr.getText();
        typeUser=type.getText();
        
        if(user.isEmpty() || typeUser.isEmpty()){
            JOptionPane.showMessageDialog(null, "Necesita buscar un usuario primero para eliminarlo.");
        }else{
            new Model.ProcedureCreateDeleteUser(user, null, typeUser, task);
        }
        
        this.finalize();
    }
}
