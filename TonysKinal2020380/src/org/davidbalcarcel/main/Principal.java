package org.davidbalcarcel.main;

import java.io.IOException;
import java.io.InputStream;
import javafx.application.Application;
import static javafx.application.Application.launch;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.fxml.JavaFXBuilderFactory;
import javafx.geometry.Rectangle2D;
import javafx.scene.Scene;
import javafx.scene.image.Image;
import javafx.scene.layout.AnchorPane;
import javafx.stage.Screen;
import javafx.stage.Stage;
import org.davidbalcarcel.controller.EmpleadoController;
import org.davidbalcarcel.controller.EmpresaController;
import org.davidbalcarcel.controller.MenuPrincipalController;
import org.davidbalcarcel.controller.PlatoController;
import org.davidbalcarcel.controller.PresupuestoController;
import org.davidbalcarcel.controller.ProductoController;
import org.davidbalcarcel.controller.ProgramadorController;
import org.davidbalcarcel.controller.ServicioController;
import org.davidbalcarcel.controller.TipoEmpleadoController;
import org.davidbalcarcel.controller.TipoPlatoController;
public class Principal extends Application {
    private final String PAQUETE_VISTA = "/org/davidbalcarcel/view/";
    //Stage lo usamos como escenarioPrincipal
    //Ya que vamos hacer referencia a un objeto
    private Stage escenarioPrincipal;
    private Scene escena;
    
    @Override
    public void start(Stage escenarioPrincipal) throws IOException {
        this.escenarioPrincipal = escenarioPrincipal;
        this.escenarioPrincipal.setTitle("Tony´s Kinal 2023");
        escenarioPrincipal.getIcons().add(new Image("/org/davidbalcarcel/image/Menu.png"));
        //Parent root = FXMLLoader.load(getClass().getResource("/org/davidbalcarcel/view/MenuPrincipalView.fxml"));
        //Scene escena = new Scene(root);
        //escenarioPrincipal.setScene(escena);
        menuPrincipal();
        escenarioPrincipal.show();
        
        /*Rectangle2D centrar = Screen.getPrimary().getVisualBounds();
        escenarioPrincipal.setX((centrar.getWidth() - centrar.getWidth())/2);
        escenarioPrincipal.setY((centrar.getHeight() - centrar.getHeight())/2);*/
    }
    
    public void menuPrincipal(){
        try{
            MenuPrincipalController menu = (MenuPrincipalController)cambiarEscena("MenuPrincipalView.fxml",663,674);
            menu.setEscenarioPrincipal(this);
            escenarioPrincipal.centerOnScreen();
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public void ventanaProgramador(){
        try{
            ProgramadorController coder = (ProgramadorController)cambiarEscena("ProgramadorView.fxml",1260,500);
            coder.setEscenarioPrincipal(this);
            //escenarioPrincipal.setX(350);
            //escenarioPrincipal.setY(130);
            escenarioPrincipal.centerOnScreen();
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public void ventanaEmpresa(){
        try{
            EmpresaController vEmpresa = (EmpresaController)cambiarEscena("EmpresaView.fxml",1280,750);
            vEmpresa.setEscenarioPrincipal(this);
            /*Rectangle2D centrar = Screen.getPrimary().getVisualBounds();
            escenarioPrincipal.setX((centrar.getWidth() - centrar.getWidth())/2);
            escenarioPrincipal.setY((centrar.getHeight() - centrar.getHeight())/2);*/
            //escenarioPrincipal.setX(350);
            //escenarioPrincipal.setY(130);
            escenarioPrincipal.centerOnScreen();
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public void ventanaProducto(){
        try{
            ProductoController producto = (ProductoController)cambiarEscena("ProductoView.fxml",1280,750);
            producto.setEscenarioPrincipal(this);
            //escenarioPrincipal.setX(350);
            //escenarioPrincipal.setY(130);
            escenarioPrincipal.centerOnScreen();
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public void ventanaTipoEmpleado(){
        try{
            TipoEmpleadoController tipoEmpleado = (TipoEmpleadoController)cambiarEscena("TipoEmpleadoView.fxml", 1280,750);
            tipoEmpleado.setEscenarioPrincipal(this);
            //escenarioPrincipal.setX(350);
            //escenarioPrincipal.setY(130);
            escenarioPrincipal.centerOnScreen();
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public void ventanaTipoPlato(){
        try{
            TipoPlatoController tipoPlato = (TipoPlatoController)cambiarEscena("TipoPlatoView.fxml", 1280, 750);
            tipoPlato.setEscenarioPrincipal(this);
            //escenarioPrincipal.setX(350);
            //escenarioPrincipal.setY(130);
            escenarioPrincipal.centerOnScreen();
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public void ventanaPresupuesto(){
        try{
            PresupuestoController presupuesto = (PresupuestoController)cambiarEscena("PresupuestoView.fxml", 1280, 750);
            presupuesto.setEscenarioPrincipal(this);
            //escenarioPrincipal.setX(350);
            //escenarioPrincipal.setY(130);
            escenarioPrincipal.centerOnScreen();
        }catch(Exception e){
            e.printStackTrace();
        }        
    }
    
    public void ventanaEmpleado(){
        try{
            EmpleadoController empleado = (EmpleadoController)cambiarEscena("EmpleadoView.fxml", 1280, 750);
            empleado.setEscenarioPrincipal(this);
            escenarioPrincipal.centerOnScreen();
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public void ventanaServicio(){
        try{
            ServicioController servicio = (ServicioController)cambiarEscena("ServicioView.fxml", 1280, 750);
            servicio.setEscenarioPrincipal(this);
            escenarioPrincipal.centerOnScreen();
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public void ventanaPlato(){
        try{
            PlatoController plato = (PlatoController)cambiarEscena("PlatoView.fxml",1280,750);
            plato.setEscenarioPrincipal(this);
            escenarioPrincipal.centerOnScreen();
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public static void main(String[] args) {
        launch(args);
    }
    
    
    //Initializable:
    //Es con lo que trabaja JavaFX, ósea los objetos
    public Initializable cambiarEscena(String fxml, int ancho, int alto) throws IOException{
        Initializable result = null;
        FXMLLoader cargadorFXML = new FXMLLoader();
        InputStream archivo = Principal.class.getResourceAsStream(PAQUETE_VISTA + fxml);
        cargadorFXML.setBuilderFactory(new JavaFXBuilderFactory());
        cargadorFXML.setLocation(Principal.class.getResource(PAQUETE_VISTA+fxml));
        escena = new Scene((AnchorPane)cargadorFXML.load(archivo),ancho,alto);
        escenarioPrincipal.setScene(escena);
        escenarioPrincipal.sizeToScene();
        result = (Initializable)cargadorFXML.getController();
        return result;
    }

}