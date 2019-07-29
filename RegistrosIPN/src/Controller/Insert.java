/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import javax.swing.JComboBox;
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
    
    public Insert(JTextField rfcField,JTextField nombreField,JTextField apellidoPField,JTextField apellidoMField,JTextField emailField, JTextField telCasaField,JTextField telCelField, JTextField telOfiField,
            JTextField generoField,JTextField nombrePaisField,JTextField nombreEstadoField,JTextField nombreCiudadField,JTextField lugarResidenciaField,JTextField nombreEmergField,JTextField numeroEmergField,
            JTextField discapacidadField,JComboBox nivelEscolarField,JTextField añoEgresoField,JTextField nombreInstitucionField,JTextField tituloField,JTextField nombreCursoField,JTextField inicioField,JTextField terminoField,
            JTextField actividadDesempeñaField,JTextField enteradoField,JTextField cursoInteresadoField,JTextField nombreEmpresaField,JTextField sectorField,JTextField añoRegistroField,JComboBox nivelCursoField,
            JComboBox moduloCursoField,JTextField usuarioField ){
        
        rfc=rfcField.getText(); nombre=nombreField.getText(); apellidoP=apellidoPField.getText(); apellidoM=apellidoMField.getText();email=emailField.getText();
        telCasa=telCasaField.getText(); telCel=telCelField.getText(); telOfi=telOfiField.getText(); genero=generoField.getText();nombrePais=nombrePaisField.getText();
        nombreEstado=nombreEstadoField.getText();nombreCiudad=nombreCiudadField.getText();lugarResidencia=lugarResidenciaField.getText();nombreEmerg=nombreEmergField.getText();
        numeroEmerg=numeroEmergField.getText();discapacidad=discapacidadField.getText();
        nivelEscolar=nivelEscolarField.getSelectedItem().toString();añoEgreso=añoEgresoField.getText();nombreInstitucion=nombreInstitucionField.getText();
        titulo=tituloField.getText();nombreCurso=nombreCursoField.getText();inicio=inicioField.getText();termino=terminoField.getText();
        actividadDesempeña=actividadDesempeñaField.getText();enterado=enteradoField.getText();cursoInteresado=cursoInteresadoField.getText();
        nombreEmpresa=nombreEmpresaField.getText();sector=sectorField.getText();añoRegistro=añoRegistroField.getText();nivelCurso=nivelCursoField.getSelectedItem().toString();
        moduloCurso=moduloCursoField.getSelectedItem().toString();usuario=usuarioField.getText();
        
        new Model.ProcedureInsert(rfc, nombre, apellidoP, apellidoM, email, telCasa, telCel, telOfi, genero, nombrePais, nombreEstado, nombreCiudad, lugarResidencia, 
                nombreEmerg, numeroEmerg, discapacidad, nivelEscolar, añoEgreso, nombreInstitucion, titulo, nombreCurso, inicio, termino, actividadDesempeña, 
                enterado, cursoInteresado, nombreEmpresa, sector, añoRegistro, nivelCurso, moduloCurso, usuario);
    }
}
