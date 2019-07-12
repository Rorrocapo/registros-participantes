/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import java.sql.ResultSet;
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableColumnModel;

/**
 *
 * @author Darke
 */
public class ProcedureShowTable {
    public ProcedureShowTable(JTable table){
        DefaultTableModel modelo = new DefaultTableModel();
        TableColumnModel cols  = table.getColumnModel();
        ResultSet rs = Database.getTabla("select *from tabla_registros");
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
            
        }catch(Exception e){
            System.out.println(e);
        }
    }
}
    

