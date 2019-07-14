/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import java.sql.Connection;
import java.sql.*;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.swing.JOptionPane;

/**
 *
 * @author Darke
 */
public class Database {
    private static Connection conex;
    private static final String usuario = "root";
    private static final String password = "";
    private static final String url = "jdbc:mysql://localhost:3306/base_datos_ipn";
    boolean status;
    
    public Database(){
        conex = null;
        try{
            Class.forName("com.mysql.jdbc.Driver");
            conex = DriverManager.getConnection(url, usuario, password);
            if(conex != null){
                System.out.println("Conexion Exitosa");
                status=true;
            }else{
                System.out.println("Error al conectar");
                status=false;
            }
        }catch(ClassNotFoundException | SQLException ex){
            System.out.printf(ex.toString());
            JOptionPane.showMessageDialog(null,"<html><b>Problemas para conectar a la base de datos.</b></html>\n"
                    + "<html><b>Error:</b></html>\n"+ex
            +"\n\n<html><b>Contactar al administrador para resolver el problema</b></html>.");
            System.exit(0);
        }
    }
    
    public static Connection getConexion(){
        return conex;
    }
    
    public static void desconnect(){
        conex = null;
        if(conex == null){
            System.out.println("Conexion terminada");
        }
    }
    
    public static ResultSet getTabla(String consulta){
        Connection cn = getConexion();
        Statement st;
        ResultSet datos=null;
        try{
            st=cn.createStatement();
            datos=st.executeQuery(consulta);
        }catch(Exception e){
         System.out.println(e.toString());
        }
        return datos;
    }
   
}
