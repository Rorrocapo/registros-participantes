/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import javax.swing.JTable;

/**
 *
 * @author Darke
 */
public class ShowTable{   
    public ShowTable(JTable table){
        new Model.ProcedureShowTable(table);
    } 
}