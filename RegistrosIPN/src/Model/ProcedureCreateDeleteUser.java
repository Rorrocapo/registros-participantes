/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.swing.JComboBox;
import javax.swing.JOptionPane;
import javax.swing.JTextField;
import org.apache.commons.codec.digest.DigestUtils;

/**
 *
 * @author Darke
 */
public class ProcedureCreateDeleteUser {
    private Connection conn;
    private Database con;
    private PreparedStatement consulta;
    private ResultSet resultado;
    private String user,password,typeUser;
    public ProcedureCreateDeleteUser(JTextField usr, JTextField psswd,JComboBox type,boolean task){
        user= usr.getText();
        password= DigestUtils.md5Hex(psswd.getText()); 
        typeUser= type.getSelectedItem().toString();
        
        if(task){
            CreateUser();
        }else {
            DeleteUser();
        }
    }
    
    public void CreateUser(){
        try {
                conn = con.getConexion();
                consulta = conn.prepareStatement("insert into usuarios(usuario,contraseña,tipo_usuario) values(upper(?),?,?)");
                consulta.setString(1, user);
                consulta.setString(2, password);
                consulta.setString(3, typeUser);
                int result = consulta.executeUpdate();
                if (result > 0) {
                    JOptionPane.showMessageDialog(null, "Se ha creado el usuario exitosamente.");
                } else {
                    JOptionPane.showMessageDialog(null, "Error al crear usario");
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
    }
    
    public void DeleteUser(){
        try{
                conn = con.getConexion();
                consulta = conn.prepareStatement("delete from usuarios where usuario=?");
                consulta.setString(1, user);
                int result = consulta.executeUpdate();
                if (result > 0) {
                    JOptionPane.showMessageDialog(null, "Se ha creado el usuario exitosamente.");
                } else {
                    JOptionPane.showMessageDialog(null, "Error al crear usario");
                }
        }catch(Exception ex){
            
        }
    }
}
