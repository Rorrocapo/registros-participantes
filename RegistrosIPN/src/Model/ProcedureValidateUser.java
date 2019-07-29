/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

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
    public static String userName;
    public ProcedureValidateUser(String statement,String user) throws Throwable{
        try {
                conn = con.getConexion();
                consulta = conn.prepareStatement(statement);
                resultado = consulta.executeQuery();
                if (resultado.next()) {
                    user=resultado.getString("usuario");
                    userName=user;
                    Controller.ValidateAdmin.validate=true;
                    Controller.ValidateUser.validate=true;
                } else {
                    Controller.ValidateAdmin.validate=false;
                    Controller.ValidateUser.validate=false;
                }
            } catch (Exception ex) {
                JOptionPane.showMessageDialog(null, ex);
            }
        this.finalize();
    }
}
