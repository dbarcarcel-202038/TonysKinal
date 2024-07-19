package org.davidbalcarcel.controller;

import com.mysql.jdbc.MysqlDataTruncation;
import java.net.URL;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.Month;
import java.time.format.TextStyle;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.ResourceBundle;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javax.swing.JOptionPane;
import org.davidbalcarcel.bean.Empresa;
import org.davidbalcarcel.db.Conexion;
import org.davidbalcarcel.main.Principal;
import org.davidbalcarcel.report.GenerarReporte;

public class EmpresaController implements Initializable {
    private enum operaciones{NUEVO, GUARDAR, ELIMINAR, ACTUALIZAR, CANCELAR, NINGUNO};
    private operaciones tipoDeOperacion = operaciones.NINGUNO;
    private Principal escenarioPrincipal;
    //ObservableList
    //Es una lista de objetos de un modelo de datos
    private ObservableList<Empresa> listaEmpresa;
            
   
    
    @FXML private TextField txtCodigoEmpresa;
    @FXML private TextField txtNombreEmpresa;
    @FXML private TextField txtDireccionEmpresa;
    @FXML private TextField txtTelefonoEmpresa;
    @FXML private TableView tblEmpresas;
    @FXML private TableColumn colCodigoEmpresa;
    @FXML private TableColumn colNombreEmpresa;
    @FXML private TableColumn colDireccionEmpresa;
    @FXML private TableColumn colTelefonoEmpresa;
    @FXML private Button btnNuevo;
    @FXML private Button btnEditar;
    @FXML private Button btnReporte;
    @FXML private Button btnEliminar;
    @FXML private ImageView imgNuevo;
    @FXML private ImageView imgEliminar;
    @FXML private ImageView imgEditar;
    @FXML private ImageView imgReporte;
    @FXML private Label lblFecha;
    
 
    
    @Override
    public void initialize(URL location, ResourceBundle resources ){
        cargarDatos();
        laFecha();
        
    }
    
   
    
    public void laFecha(){
        LocalDate ahora = LocalDate.now();
        Month mes = LocalDate.now().getMonth();
        String nombre = mes.getDisplayName(TextStyle.FULL, new Locale("es", "ES"));
        lblFecha.setText("Hoy es "+ahora.getDayOfMonth() + " de " + nombre + " de "+ahora.getYear() );
    }
    

    
    public void cargarDatos(){
        tblEmpresas.setItems(getEmpresa());
        colCodigoEmpresa.setCellValueFactory(new PropertyValueFactory<Empresa, Integer>("codigoEmpresa"));
        colNombreEmpresa.setCellValueFactory(new PropertyValueFactory<Empresa, Integer>("nombreEmpresa"));
        colDireccionEmpresa.setCellValueFactory(new PropertyValueFactory<Empresa, Integer>("direccion"));
        colTelefonoEmpresa.setCellValueFactory(new PropertyValueFactory<Empresa, Integer>("telefono"));
    }
    
    public void seleccionarElemento(){
        if(tblEmpresas.getSelectionModel().getSelectedItem() != null){
        txtCodigoEmpresa.setText(String.valueOf(((Empresa)tblEmpresas.getSelectionModel().getSelectedItem()).getCodigoEmpresa()));
        txtNombreEmpresa.setText(((Empresa)tblEmpresas.getSelectionModel().getSelectedItem()).getNombreEmpresa());
        txtDireccionEmpresa.setText(((Empresa)tblEmpresas.getSelectionModel().getSelectedItem()).getDireccion());
        txtTelefonoEmpresa.setText(((Empresa)tblEmpresas.getSelectionModel().getSelectedItem()).getTelefono());
        }else{
            JOptionPane.showMessageDialog(null, "Debe seleccionar un elemento");
        }
    }
    

    
    public ObservableList<Empresa> getEmpresa(){
        ArrayList<Empresa> lista = new ArrayList<Empresa>();
        try{
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("Call sp_ListarEmpresas");
            ResultSet result = procedimiento.executeQuery();
            while(result.next()){
                lista.add(new Empresa(result.getInt("codigoEmpresa"),
                            result.getString("nombreEmpresa"),
                            result.getString("direccion"),
                            result.getString("telefono")));
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return listaEmpresa = FXCollections.observableList(lista);
    }
    
  
    public void nuevo(){
        switch(tipoDeOperacion){
            case NINGUNO:
                limpiarControles();
                activarControles();
                btnNuevo.setText("Guardar");
                btnEliminar.setText("Cancelar");
                btnEditar.setDisable(true);
                btnReporte.setDisable(true);
                imgNuevo.setImage(new Image("/org/davidbalcarcel/image/1904659-arrow-backup-down-download-save-storage-transfer_122509.png"));
                imgEliminar.setImage(new Image("/org/davidbalcarcel/image/cancel_close_delete_exit_logout_remove_x_icon_123217.png"));
                tipoDeOperacion = operaciones.GUARDAR;
                break;
            case GUARDAR:
                guardar();
                limpiarControles();
                desactivarControles();
                btnNuevo.setText("Nuevo");
                btnEliminar.setText("Eliminar");
                btnEditar.setDisable(false);
                btnReporte.setDisable(false);
                imgNuevo.setImage(new Image("/org/davidbalcarcel/image/addnewdocument_118445.png"));
                imgEliminar.setImage(new Image("/org/davidbalcarcel/image/delete_remove_bin_icon-icons.com_72400.png"));
                tipoDeOperacion = operaciones.NINGUNO;
                cargarDatos();
                break;
        }
    }
    
    public void eliminar(){
        switch (tipoDeOperacion){
            case GUARDAR:
                limpiarControles();
                desactivarControles();
                btnNuevo.setText("Nuevo");
                btnEliminar.setText("Eliminar");    
                btnEditar.setDisable(false);
                btnReporte.setDisable(false);
                imgNuevo.setImage(new Image("/org/davidbalcarcel/image/addnewdocument_118445.png"));                
                imgEliminar.setImage(new Image("/org/davidbalcarcel/image/delete_remove_bin_icon-icons.com_72400.png"));
                tipoDeOperacion = operaciones.NINGUNO;
                break;
            default:
                if(tblEmpresas.getSelectionModel().getSelectedItem() != null){
                    int respuesta = JOptionPane.showConfirmDialog(null, "¿Esta seguro de eliminar el registro?", "Eliminar Empresa", JOptionPane.YES_NO_OPTION, JOptionPane.QUESTION_MESSAGE);
                    if(respuesta == JOptionPane.YES_OPTION){
                        try{
                            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("call sp_EliminarEmpresa(?)");
                            procedimiento.setInt(1, ((Empresa)tblEmpresas.getSelectionModel().getSelectedItem()).getCodigoEmpresa());
                            procedimiento.execute();
                            listaEmpresa.remove(tblEmpresas.getSelectionModel().getSelectedIndex());
                            limpiarControles();  
                            cargarDatos();
                        }catch(SQLException e){
                            JOptionPane.showMessageDialog(null,"nop");  
                        }catch(Exception e){
                            e.printStackTrace();
                        }
                    }else if(respuesta == JOptionPane.NO_OPTION){
                    limpiarControles();
                    cargarDatos();
                }    
                }else{
                    JOptionPane.showMessageDialog(null, "Debe seleccionar un elemento");
                }
        }
    }
    
        public void editar(){
        switch(tipoDeOperacion){
            case NINGUNO:
                if(tblEmpresas.getSelectionModel().getSelectedItem() != null){
                   btnNuevo.setDisable(true);
                   btnEliminar.setDisable(true);
                   btnEditar.setText("Actualizar");
                   btnReporte.setText("Cancelar");
                   imgEditar.setImage(new Image("/org/davidbalcarcel/image/1904659-arrow-backup-down-download-save-storage-transfer_122509.png"));
                   imgReporte.setImage(new Image("/org/davidbalcarcel/image/cancel_close_delete_exit_logout_remove_x_icon_123217.png"));
                   activarControles();
                   tipoDeOperacion = operaciones.ACTUALIZAR;
                }else{
                    JOptionPane.showMessageDialog(null, "Debe seleccionar un elemento");
                }
                break;
            case ACTUALIZAR:    
                actualizar();
                limpiarControles();
                desactivarControles();
                btnNuevo.setDisable(false);
                btnEliminar.setDisable(false);
                btnEditar.setText("Editar");
                btnReporte.setText("Reporte");
                imgEditar.setImage(new Image("/org/davidbalcarcel/image/353430-checkbox-edit-pen-pencil_107516.png"));
                imgReporte.setImage(new Image("/org/davidbalcarcel/image/3775748-check-date-list-planner-time_108972.png"));
                tipoDeOperacion = operaciones.NINGUNO;
                cargarDatos();
                break;
        }
    }
    
    public void reporte(){
        switch(tipoDeOperacion){
            case ACTUALIZAR:
                limpiarControles();
                desactivarControles();
                btnNuevo.setDisable(false);
                btnEliminar.setDisable(false);
                btnEditar.setText("Editar");
                btnReporte.setText("Reporte");
                imgEditar.setImage(new Image("/org/davidbalcarcel/image/353430-checkbox-edit-pen-pencil_107516.png"));
                imgReporte.setImage(new Image("/org/davidbalcarcel/image/3775748-check-date-list-planner-time_108972.png"));
                tipoDeOperacion = operaciones.NINGUNO;
                cargarDatos();
                break;
            case NINGUNO:
                imprimirReporte();
                break;
        }
    }    
    

    
    public void guardar(){
        Empresa registro = new Empresa();
        //registro.setCodigoEmpresa(Integer.parseInt(txtCodigoEmpresa.getText()));
        //No ingresar si no hay datos
        
        if(txtNombreEmpresa.getText().isEmpty() || txtDireccionEmpresa.getText().isEmpty()|| txtTelefonoEmpresa.getText().isEmpty()){
            JOptionPane.showMessageDialog(null, "Dejó un dato vacío \n Porfavor llene todos los campos");
        }else{
            registro.setNombreEmpresa(txtNombreEmpresa.getText());
            registro.setDireccion(txtDireccionEmpresa.getText());
            if (txtTelefonoEmpresa.getText().trim().matches("\\d{8}")) {
            registro.setTelefono(txtTelefonoEmpresa.getText());
                try{
                    PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("call sp_AgregarEmpresa (?,?,?)");
                    procedimiento.setString(1, registro.getNombreEmpresa());
                    procedimiento.setString(2, registro.getDireccion());
                    procedimiento.setString(3, registro.getTelefono());
                    procedimiento.execute();
                    listaEmpresa.add(registro);
                }catch(MysqlDataTruncation error){
                    JOptionPane.showMessageDialog(null,"Verifique el número ", "AVISO", JOptionPane.WARNING_MESSAGE);
                }catch(NumberFormatException error){
                    JOptionPane.showMessageDialog(null,"Valor incorrecto", "AVISO", JOptionPane.WARNING_MESSAGE);                    
                }catch(Exception e){
                    e.printStackTrace();
                }
            }else{
                JOptionPane.showMessageDialog(null,"Teléfono Incorrecto", "ERROR", JOptionPane.WARNING_MESSAGE);
            }
        }   
    }
    
    public void actualizar(){
        if(txtNombreEmpresa.getText().isEmpty()|| txtDireccionEmpresa.getText().isEmpty()|| txtTelefonoEmpresa.getText().isEmpty()){
            JOptionPane.showMessageDialog(null,"Dejo un dato sin ingresar. \n Porfavor llenar todos los campos");        
        }else{
            try{   
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("call sp_EditarEmpresa(?,?,?,?)");
            Empresa registro = (Empresa)tblEmpresas.getSelectionModel().getSelectedItem();
            registro.setNombreEmpresa(txtNombreEmpresa.getText());
            registro.setDireccion(txtDireccionEmpresa.getText());
            registro.setTelefono(txtTelefonoEmpresa.getText());
            procedimiento.setInt(1, registro.getCodigoEmpresa());
            procedimiento.setString(2, registro.getNombreEmpresa());
            procedimiento.setString(3, registro.getDireccion());
            procedimiento.setString(4, registro.getTelefono());
            procedimiento.execute();
            }catch(Exception e){
                e.printStackTrace();
            }
        }
    }
    
    public void imprimirReporte(){
        Map parametros = new HashMap();
        parametros.put("codigoEmpresa", null);
        GenerarReporte.mostrarReporte("ReporteEmpresas.jasper", "Reporte de empresas", parametros);
    }
    

    
    public void desactivarControles(){
        txtCodigoEmpresa.setEditable(false);
        txtNombreEmpresa.setEditable(false);
        txtDireccionEmpresa.setEditable(false);
        txtTelefonoEmpresa.setEditable(false);
    }
    
    public void activarControles(){
        txtCodigoEmpresa.setEditable(false);
        txtNombreEmpresa.setEditable(true);
        txtDireccionEmpresa.setEditable(true);
        txtTelefonoEmpresa.setEditable(true);
    }
    
    public void limpiarControles(){
        txtCodigoEmpresa.setText("");
        txtNombreEmpresa.setText("");
        txtDireccionEmpresa.setText("");
        txtTelefonoEmpresa.setText("");
    }
    

    
    public Principal getEscenarioPrincipal() {
        return escenarioPrincipal;
    }

    public void setEscenarioPrincipal(Principal escenarioPrincipal) {
        this.escenarioPrincipal = escenarioPrincipal;
    }
    
    public void menuPrincipal(){
        escenarioPrincipal.menuPrincipal();
    }
    
    public void ventanaPresupuesto(){
        escenarioPrincipal.ventanaPresupuesto();
    }
    
    public void ventanaServicio(){
        escenarioPrincipal.ventanaServicio();
    }
    
}
