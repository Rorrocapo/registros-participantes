/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import javax.swing.JTextField;

/**
 *
 * @author Darkness
 */
public class Insert {
    String rfc, nombre, apellidoP, apellidoM, email,  telCasa, telCel,  telOfi, genero, nombrePais, nombreEstado, 
            nombreCiudad, lugarResidencia, nombreEmerg, numeroEmerg,discapacidad, nivelEscolar, añoEgreso, 
            nombreInstitucion, titulo, nombreCurso, inicio, termino,actividadDesempeña, enterado, cursoInteresado, 
            nombreEmpresa, sector, añoRegistro, nivelCurso,moduloCurso,usuario;
    
    public Insert(JTextField rfcField,JTextField nombreField,JTextField apellidoPField,JTextField apellidoMField,JTextField emailField, JTextField telCasaField,String telCel, String telOfi,
            String genero,String nombrePais,String nombreEstado,String nombreCiudad,String lugarResidencia,String nombreEmerg,String numeroEmerg,
            String discapacidad,String nivelEscolar,String añoEgreso,String nombreInstitucion,String titulo,String nombreCurso,String inicio,String termino,
            String actividadDesempeña,String enterado,String cursoInteresado,String nombreEmpresa,String sector,String añoRegistro,String nivelCurso,
            String moduloCurso,String usuario ){
        
        new Model.ProcedureInsert(rfc, nombre, apellidoP, apellidoM, email, telCasa, telCel, telOfi, genero, nombrePais, nombreEstado, nombreCiudad, lugarResidencia, 
                nombreEmerg, numeroEmerg, discapacidad, nivelEscolar, añoEgreso, nombreInstitucion, titulo, nombreCurso, inicio, termino, actividadDesempeña, 
                enterado, cursoInteresado, nombreEmpresa, sector, añoRegistro, nivelCurso, moduloCurso, usuario);
    }
}
