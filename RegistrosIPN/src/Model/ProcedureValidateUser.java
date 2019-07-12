/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import Controller.ValidateUser;
import View.Session;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.swing.JOptionPane;

/**
 *
 * @author darkness
 */
public class ProcedureValidateUser {
    Connection conn;
    Database con;
    PreparedStatement consulta;
    ResultSet resultado;
    public ProcedureValidateUser(String user, String psswd){
        try {
                conn = con.getConexion();
                consulta = conn.prepareStatement("SELECT * FROM usuarios WHERE usuario='"+user+"' and contraseña='"+psswd+"'");
                resultado = consulta.executeQuery();
                if (resultado.next()) {
                    Controller.ValidateUser.validate=true;
                } else {
                    Controller.ValidateUser.validate=false;
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
    }
    
}
