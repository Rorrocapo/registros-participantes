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
import javax.swing.JTextField;

/**
 *
 * @author Darke
 */
public class SearchUser {
    Connection conn;
    Database con;
    PreparedStatement consulta;
    ResultSet resultado;
    public SearchUser(JTextField user,JTextField type) throws Throwable{
        try {
                conn = con.getConexion();
                consulta = conn.prepareStatement("select tipo_usuario from usuarios where usuario=?");
                consulta.setString(1, user.getText());
                resultado = consulta.executeQuery();
                if (resultado.next()) {
                    type.setText(resultado.getString("tipo_usuario"));
                }else{
                    JOptionPane.showMessageDialog(null, "Usuario no existe");
                }
            } catch (Exception ex) {
                JOptionPane.showMessageDialog(null, ex);
            }
        this.finalize();
    }
}
