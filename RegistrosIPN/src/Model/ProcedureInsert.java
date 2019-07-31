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
 * @author Darkness
 */
public class ProcedureInsert {
    Connection conn;
    Database con;
    PreparedStatement consulta;
    ResultSet resultado;
    public ProcedureInsert(String rfc,String nombre,String apellidoP,String apellidoM,String email, String telCasa,String telCel, String telOfi,
            String genero,String nombrePais,String nombreEstado,String nombreCiudad,String lugarResidencia,String nombreEmerg,String numeroEmerg,
            String discapacidad,String nivelEscolar,String añoEgreso,String nombreInstitucion,String titulo,String nombreCurso,String inicio,String termino,
            String actividadDesempeña,String enterado,String cursoInteresado,String nombreEmpresa,String sector,String añoRegistro,String nivelCurso,
            String moduloCurso,String usuario){
        int dialogButton = JOptionPane.YES_NO_OPTION;
            int dialogResult = JOptionPane.showConfirmDialog (null, "Verifique que los datos son los correctos antes de ingresar","Wait",dialogButton);
            if(dialogResult==JOptionPane.YES_OPTION){
            try {
                conn = con.getConexion();
                consulta = conn.prepareStatement("Call insertalumno(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
                if(rfc.equals("")){
                 consulta.setString(1, null);   
                }else consulta.setString(1, rfc);
                
                if(nombre.equals("")){
                    consulta.setString(2, null);
                }else consulta.setString(2, nombre);
                
                if(apellidoP.equals("")){
                    consulta.setString(3, null);
                }else consulta.setString(3, apellidoP);
                
                if(apellidoM.equals("")){
                    consulta.setString(4, null);
                }else consulta.setString(4, apellidoM);
                
                if(email.equals("")){
                    consulta.setString(5, null);
                }else consulta.setString(5, email);

                if(telCasa.equals("")){
                    consulta.setString(6, null);
                }else consulta.setString(6, telCasa);

                if(telCel.equals("")){
                    consulta.setString(7, null);
                }else consulta.setString(7, telCel);
                
                if(telOfi.equals("")){
                    consulta.setString(8, null);
                }else consulta.setString(8, telOfi);
                
                consulta.setString(9, "A");
                
                if(genero.equals("")){
                    consulta.setString(10, null);
                }else consulta.setString(10, genero);
                
                
                if(nombrePais.equals("")){
                    consulta.setString(11, null);
                }else consulta.setString(11, nombrePais);
                
                if(nombreEstado.equals("")){
                    consulta.setString(12, null);
                }else consulta.setString(12, nombreEstado);
                
                if(nombreCiudad.equals("")){
                    consulta.setString(13, null);
                }else consulta.setString(13, nombreCiudad);
                
                if(lugarResidencia.equals("")){
                    consulta.setString(14, null);
                }else consulta.setString(14, lugarResidencia);
                
                if(nombreEmerg.equals("")){
                    consulta.setString(15, null);
                }else consulta.setString(15, nombreEmerg);
                
                if(numeroEmerg.equals("")){
                    consulta.setString(16, null);
                }else consulta.setString(16, numeroEmerg);
                
                if(discapacidad.equals("")){
                    consulta.setString(17, null);
                }else consulta.setString(17, discapacidad);
                
                if(nivelEscolar.equals("Otro")){
                    consulta.setString(18, null);
                }else consulta.setString(18, nivelEscolar);
                
                if(añoEgreso.equals("")){
                    consulta.setString(19, null);
                }else consulta.setString(19, añoEgreso);
                
                if(nombreInstitucion.equals("")){
                    consulta.setString(20, null);
                }else consulta.setString(20, nombreInstitucion);
                
                if(titulo.equals("")){
                    consulta.setString(21, null);
                }else consulta.setString(21, titulo);
                
                if(nombreCurso.equals("")){
                    consulta.setString(22, null);
                }else consulta.setString(22, nombreCurso);
                
                if(inicio.equals("")){
                    consulta.setString(23, null);
                }else consulta.setString(23, inicio);
                
                if(termino.equals("")){
                    consulta.setString(24, null);
                }else consulta.setString(24, termino);
                
                if(actividadDesempeña.equals("")){
                    consulta.setString(25,null);
                }else consulta.setString(25, actividadDesempeña);
                
                if(enterado.equals("")){
                    consulta.setString(26,null);
                }else consulta.setString(26, enterado);
                
                if(cursoInteresado.equals("")){
                    consulta.setString(27, null);
                }else consulta.setString(27, cursoInteresado);
                
                if(nombreEmpresa.equals("")){
                    consulta.setString(28, null);
                }else consulta.setString(28, nombreEmpresa);
                
                if(sector.equals("")){
                    consulta.setString(29, null);
                }else consulta.setString(29, sector);
                
                consulta.setString(30, añoRegistro);
                
                if(nivelCurso.equals("Seleccionar")){
                    consulta.setString(31, null);
                }else consulta.setString(31, nivelCurso);
                
                if(moduloCurso.equals("Seleccionar")){
                    consulta.setString(32, null);
                }else consulta.setString(32, moduloCurso);
                
                consulta.setString(33, usuario);

                int result = consulta.executeUpdate();
                if (result > 0) {
                    try{
                        conn = con.getConexion();
                        consulta = conn.prepareStatement("select idMatricula from matricula_alumno,alumno,persona where idPersona=persona_idPersona and idAlumno=alumno_idAlumno and rfc=?");
                        consulta.setString(1, rfc);
                        resultado = consulta.executeQuery();
                        if(resultado.next()){
                            JOptionPane.showMessageDialog(null, "Alumno Guardado \nMatricula del alumno generado: "+resultado.getString("idMatricula"));
                            
                        }
                    }catch(Exception e){
                        JOptionPane.showMessageDialog(null, e);
                    }
                } else {
                    JOptionPane.showMessageDialog(null,"Error al guardar");
                }
            } catch (Exception ex) {
                JOptionPane.showMessageDialog(null, ex);
                ex.printStackTrace();
            }
            }
    }
}
