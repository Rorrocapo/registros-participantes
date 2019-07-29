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
 * @author Darkness
 */
public class ProcedureCreateDeleteUser {
    private Connection conn;
    private Database con;
    private PreparedStatement consulta;
    private ResultSet resultado;
    public ProcedureCreateDeleteUser(String usr, String psswd,String type,boolean task){
        if(task){
            CreateUser(usr,psswd,type);
        }else {
            DeleteUser(usr,type);
        }
    }
    
    public void CreateUser(String usr, String psswd,String type){
        try {
                conn = con.getConexion();
                consulta = conn.prepareStatement("insert into usuarios(usuario,contraseña,tipo_usuario) values(upper(?),?,?)");
                consulta.setString(1, usr);
                consulta.setString(2, psswd);
                consulta.setString(3, type);
                int result = consulta.executeUpdate();
                if (result > 0) {
                    JOptionPane.showMessageDialog(null, "Se ha creado el usuario exitosamente.");
                } else {
                    JOptionPane.showMessageDialog(null, "Error al crear usario");
                }
            } catch (Exception ex) {
               JOptionPane.showMessageDialog(null, ex);
            }
    }
    
    public void DeleteUser(String usr,String type){
        try{
                conn = con.getConexion();
                consulta = conn.prepareStatement("call eliminar(?,?)");
                consulta.setString(1, usr);
                consulta.setString(2, type);
                int result = consulta.executeUpdate();
                if (result > 0) {
                    JOptionPane.showMessageDialog(null, "Se ha eliminado el usuario exitosamente.");
                } else {
                    JOptionPane.showMessageDialog(null, "Usuario no existe o solo queda un administrador.\nDebe quedar aunque sea un administrador");
                }
        }catch(Exception ex){
            JOptionPane.showMessageDialog(null, ex);
        }
    }
}
