/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableColumnModel;

/**
 *
 * @author Darke
 */
public class ProcedureShowTable {
    Connection conn;
    Database con;
    PreparedStatement consulta;
    ResultSet resultado;
    public ProcedureShowTable(JTable table, JTextField counter, boolean typeUser, String statement) throws Throwable{
        DefaultTableModel modelo = new DefaultTableModel();
        TableColumnModel cols  = table.getColumnModel();
        ResultSet rs = Database.getTabla(statement);
        modelo.setColumnIdentifiers(new Object[]{"Matricula","RFC","Nombre(s)","Apellido P.","Apellido M","Genero","Email","Lugar de residencia","Pais","Estado","Ciudad","Tel. de casa"
        ,"Tel. Celular","Tel. de oficina","Nivel Escolar","Título","Institucion","Año de egreso","Nombre de contacto de emergencia","Tel. Contacto de emergencia","Discapacidad",
        "Nombre de la empresa","Actividad que labora","Sector laboral de la empresa","¿Cómo se entero?","Otro curso interesado","Curso que tomó","Nivel","Módulo","Inicio","Termino",
        "Usuario","Dia registrado"});
        try{
            while(rs.next()){//añade los registros al modelo
                modelo.addRow(new Object[]{rs.getString("idMatricula"),rs.getString("rfc"),rs.getString("nombre"),rs.getString("apellido_paterno"),rs.getString("apellido_materno")
                ,rs.getString("genero"),rs.getString("email"),rs.getString("lugar_residencia"),rs.getString("nombre_pais"),rs.getString("nombre_estado"),rs.getString("nombre_ciudad"),
                rs.getString("tel_fijo"),rs.getString("tel_cel"),rs.getString("tel_oficina"),rs.getString("nivel_escolar"),rs.getString("nombre_titulo"),rs.getString("nombre_institucion")
                ,rs.getString("año_egreso"),rs.getString("nombre_contacto_emergencia"),rs.getString("tel_contacto_emergencia"),rs.getString("discapacidad"),rs.getString("nombre_empresa")
                ,rs.getString("actividad_labora"),rs.getString("sector_laboral"),rs.getString("enterado_programa"),rs.getString("curso_interesado"),rs.getString("curso_tomado")
                ,rs.getString("nivel"),rs.getString("modulo"),rs.getString("inicio"),rs.getString("termino"),rs.getString("usuario_registro"),rs.getString("dia_registrado")});
            }  
            table.setModel(modelo);
            for(int i=0;i<table.getColumnCount();i++){
                cols.getColumn(i).setPreferredWidth(100);
            }
            cols.getColumn(6).setPreferredWidth(150);
            cols.getColumn(7).setPreferredWidth(220);
            table.scrollRectToVisible(table.getCellRect(table.getRowCount()-1, 0,true));
        }catch(Exception e){
            System.out.println(e);
        }
        
        try {
                conn = con.getConexion();
                consulta = conn.prepareStatement("SELECT count(*) FROM tabla_registros ");
                resultado = consulta.executeQuery();
                if (resultado.next()) {
                    counter.setText(resultado.getString("count(*)"));
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        
        if(typeUser){
            DefaultTableModel modeloUsr = new DefaultTableModel();
            TableColumnModel colsUsr  = View.AdminWindow.tableUsers.getColumnModel();
            ResultSet rsUsr = Database.getTabla("select usuario, count(usuario_registro) from usuarios left join tabla_registros on usuario=usuario_registro group by usuario");
            modeloUsr.setColumnIdentifiers(new Object[]{"Usuario","Contador"});
            
            try{
                while(rsUsr.next()){//añade los registros al modelo
                    modeloUsr.addRow(new Object[]{rsUsr.getString("usuario"),rsUsr.getString("count(usuario_registro)")});
                }  
            View.AdminWindow.tableUsers.setModel(modeloUsr);
            for(int i=0;i<View.AdminWindow.tableUsers.getColumnCount();i++){
                colsUsr.getColumn(i).setPreferredWidth(100);
            }
            colsUsr.getColumn(6).setPreferredWidth(150);
            colsUsr.getColumn(7).setPreferredWidth(220);
            View.AdminWindow.tableUsers.scrollRectToVisible(View.AdminWindow.tableUsers.getCellRect(View.AdminWindow.tableUsers.getRowCount()-1, 0,true));
            }catch(Exception e){
                System.out.println(e);
            }
            
        }
        
        this.finalize();
    }
}
    

