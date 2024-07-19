Drop database if exists DBTonysKinal2023;

Create database DBTonysKinal2023;
Use DBTonysKinal2023;

-- -------------------------------- DDL ------------------------------------
Create table Empresas(
	codigoEmpresa int auto_increment not null,
    nombreEmpresa varchar(150) not null,
    direccion varchar(150) not null,
    telefono varchar(8),
    primary key PK_codigoEmpresa(codigoEmpresa)
);

Create table TipoEmpleado(
	codigoTipoEmpleado int not null auto_increment,
    descripcion varchar(50) not null,
	primary key PK_codigoTipoEmpleado(codigoTipoEmpleado)
);

Create table TipoPlato(
	codigoTipoPlato int not null auto_increment,
    descripcionTipo varchar(100) not null,
	primary key PK_codigoTipoPlato(codigoTipoPlato)
);

Create table Productos(
	codigoProducto int not null auto_increment, 
    nombreProducto varchar(150) not null,
    cantidad int not null,
	primary key PK_codigoProducto(codigoProducto)
);

Create table Empleados(
	codigoEmpleado int not null auto_increment, 
    numeroEmpleado int not null, 
    apellidosEmpleado varchar(150) not null,
    nombresEmpleado varchar(150) not null,
    direccionEmpleado varchar(150) not null, 
    telefonoContacto varchar(8) not null,
    gradoCocinero varchar(50),
    codigoTipoEmpleado int not null,
    primary key PK_codigoEmpleado(codigoEmpleado),
	constraint FK_Empleados_TipoEmpleado foreign key(codigoTipoEmpleado) 
		references TipoEmpleado(codigoTipoEmpleado)
);

Create table Servicios(
	codigoServicio int not null auto_increment, 
    fechaServicio date not null,
	tipoServicio varchar(150) not null, 
	horaServicio time not null,
	lugarServicio varchar(150) not null,
    telefonoContacto varchar(150) not null,
    codigoEmpresa int not null,
    primary key PK_codigoServicio(codigoServicio),
    constraint FK_Servicios_Empresas foreign key(codigoEmpresa) 
		references Empresas(codigoEmpresa)
);

Create table Presupuestos(
	codigoPresupuesto int not null auto_increment, 
	fechaSolicitud date not null,
	cantidadPresupuesto decimal(10,2) not null,
    codigoEmpresa int not null,
	primary key PK_codigoPresupuesto(codigoPresupuesto),
    constraint FK_Presupuestos_Empresas foreign key (codigoEmpresa)
		references Empresas(codigoEmpresa)
);

Create table Platos(
	codigoPlato int not null auto_increment, 
    cantidad int not null,
	nombrePlato varchar(50) not null, 
    descripcionPlato varchar(150) not null,
	precioPlato decimal(10,2) not null,
    codigoTipoPlato int not null,
	primary key PK_codigoPlato(codigoPlato),
	constraint FK_Platos_TipoPlato foreign key(codigoTipoPlato)
		references TipoPlato(codigoTipoPlato)
);

Create table Productos_has_Platos(
	Productos_codigoProducto int not null,
    codigoPlato int not null,
	codigoProducto int not null,
    primary key PK_Productos_codigoProducto(Productos_codigoProducto),
    constraint FK_Productos_has_Platos_Productos foreign key (codigoProducto)
		references Productos(codigoProducto),
	constraint FK_Productos_has_Platos_Platos foreign key (codigoPlato)
		references Platos(codigoPlato)
);

Create table Servicios_has_Platos(
	Servicios_codigoServicio int not null,
	codigoPlato int not null,
    codigoServicio int not null,
	primary key PK_Servicios_codigoServicio(Servicios_codigoServicio),
	constraint FK_Servicios_has_Platos_Servicios foreign key (codigoServicio)
		references Servicios(codigoServicio),
    constraint FK_Servicios_has_Platos_Platos foreign key (codigoPlato)
		references Platos(codigoPlato)
);

Create table Servicios_has_Empleados(
	Servicios_codigoServicio int not null,
    codigoServicio int not null,
	codigoEmpleado int not null,
	fechaEvento date not null,
	horaEvento time not null,
	lugarEvento varchar(150) not null,
    primary key PK_Servicios_codigoServicio(Servicios_codigoServicio),
    constraint FK_Servicios_has_Empleados_Servicios foreign key (codigoServicio)
		references Servicios(codigoServicio),
    constraint FK_Servicios_has_Empleados_Empleados foreign key (codigoEmpleado)
		references Empleados(codigoEmpleado)
);


-- --------------------------* CRUD Create, Read, Update, Delete(Buscar) *--------------

-- -------------------------- Procedimientos almacenados -------------------------------

-- -------------------------- Agregar Empresa ----------------------------------------
Delimiter //
	Create procedure sp_AgregarEmpresa(in nombreEmpresa varchar(150),in direccion varchar(150),
		in telefono varchar(8))
			Begin
				Insert into Empresas(nombreEmpresa ,direccion,telefono)
					values (nombreEmpresa ,direccion,telefono);
			End//
Delimiter ;

-- ------------------- ListarEmpresas
Delimiter //
	Create procedure sp_ListarEmpresas()
		Begin
			Select 
				E.codigoEmpresa,
				E.nombreEmpresa,
				E.direccion,
				E.telefono
				from Empresas E;
		End//
Delimiter ;

-- ------------------ Buscar Empresa
Delimiter //
	Create procedure sp_BuscarEmpresa(in codEmpresa int)
		Begin
			Select 
			E.codigoEmpresa,
			E.nombreEmpresa,
            E.direccion,
            E.telefono
            from Empresas E
				where codigoEmpresa = codEmpresa; 
		End//
Delimiter ; 

-- -------------------- Eliminar Empresa
Delimiter //
	Create procedure sp_EliminarEmpresa(in codEmpresa int)
		Begin
			Delete from Empresas
				where codigoEmpresa = codEmpresa;
        End//
Delimiter ;

-- -------------------- Editar Empresa
Delimiter //
	Create procedure sp_EditarEmpresa(in codEmpresa int,
		in nomEmpresa varchar(150),in direc varchar(150),
		in tel varchar(8))
		Begin
			Update Empresas E
				set E.nombreEmpresa = nomEmpresa,
					E.direccion = direc,
                    E.telefono = tel
						where E.codigoEmpresa = codEmpresa;
        End//
Delimiter ;

-- --------------------------* CRUD Create, Read, Update, Delete(Buscar) *--------------
-- ---------------------- Agregar TipoEmpleado
Delimiter //
	Create procedure sp_AgregarTipoEmpleado(in descripcion varchar(50))
		Begin
			Insert into TipoEmpleado(descripcion)
				values(descripcion);
        End//
Delimiter ;

-- -----------------------Listar TipoEmpleados
Delimiter //
	Create procedure sp_ListarTipoEmpleados()
		Begin
			Select 
				TE.codigoTipoEmpleado,
                TE.descripcion
				from TipoEmpleado TE;
        End//
Delimiter ;

-- ---------------------- Buscar TipoEmpleado
Delimiter //
	Create procedure sp_BuscarTipoEmpleado(in codTipoEmpleado int)
		Begin
			Select 
				TE.codigoTipoEmpleado,
                TE.descripcion
				from TipoEmpleado TE
					where codigoTipoEmpleado = codTipoEmpleado;
        End//
Delimiter ;

-- ---------------------- Eliminar TipoEmpleado
Delimiter //
	Create procedure sp_EliminarTipoEmpleado(in codTipoEmpleado int)
		Begin
			Delete from TipoEmpleado
				where codigoTipoEmpleado = codTipoEmpleado;
        End//
Delimiter ;

-- ---------------------- Editar TipoEmpleado 
Delimiter //
	Create procedure sp_EditarTipoEmpleado(in codTipoEmpleado int,in descri varchar(50))
		Begin
			Update TipoEmpleado TE
				set TE.descripcion = descri
					where TE.codigoTipoEmpleado = codTipoEmpleado;
        End//
Delimiter ;


-- --------------------------* CRUD Create, Read, Update, Delete(Buscar) *--------------

-- -------------------------- Agregar TipoPlato 
Delimiter //
	Create procedure sp_AgregarTipoPlato(in descripcionTipo varchar(100))
		Begin
			Insert into TipoPlato(descripcionTipo)
				values(descripcionTipo);
		End//
Delimiter ; 

-- -------------------------- Listar TipoPlatos
Delimiter //
	Create procedure sp_ListarTipoPlatos()
		Begin
			Select 
				TP.codigoTipoPlato,
                TP.descripcionTipo
                from TipoPlato TP;
        End //
Delimiter ;

call sp_ListarTipoPlatos();

-- ------------------------ Buscar TipoPlato 
Delimiter //
	Create procedure sp_BuscarTipoPlato(in codTipoPlato int)
		Begin
			Select 
				TP.codigoTipoPlato,
                TP.descripcionTipo
                from TipoPlato TP
					where codigoTipoPlato = codTipoPlato;
        End//
Delimiter ; 

-- ------------------------ Eliminar TipoPlato 
Delimiter //
	Create procedure sp_EliminarTipoPlato(in codTipoPlato int)
		Begin
			Delete from TipoPlato
				where codigoTipoPlato = codTipoPlato;
		End//
Delimiter ;

-- ------------------------ Editar TipoPlato
Delimiter //
	Create procedure sp_EditarTipoPlato(in codTipoPlato int, in descTipo varchar(100))
		Begin
			Update TipoPlato TP
                set TP.descripcionTipo = descTipo
					where codigoTipoPlato = codTipoPlato;
		End//
Delimiter ;	

-- --------------------------* CRUD Create, Read, Update, Delete(Buscar) *--------------

-- ---------------------------------- Agregar Producto --------------
Delimiter //
	Create procedure sp_AgregarProducto(in nombreProducto varchar(150), in cantidad int)
		Begin
			Insert into Productos(nombreProducto, cantidad)
				values(nombreProducto, cantidad);
        End//
Delimiter ; 

-- --------------------------------Listar Productos ---------------------------------------------
Delimiter //
	Create procedure sp_ListarProductos()
		Begin
			Select 
				P.codigoProducto,
                P.nombreProducto,
                P.cantidad
					from Productos P;
        End//
Delimiter ;

-- --------------------------------- Buscar Producto -----------------------------------------
Delimiter //
	Create procedure sp_BuscarProducto(in codProducto int)
		Begin
			Select 
				P.codigoProducto,
                P.nombreProducto,
                P.cantidad
					from Productos P
						where P.codigoProducto = codProducto;
		End//
Delimiter ;

-- --------------------------------- Eliminar Producto --------------------------------------------
Delimiter //
	Create procedure sp_EliminarProducto(in codProducto int)
		Begin
			Delete from Productos
				where codigoProducto = codProducto;
		End//
Delimiter ;

-- ---------------------------------Editar Producto
Delimiter //
	Create procedure sp_EditarProducto(in codProducto int,
		in nomProducto varchar(150), in cant int)
        Begin
			Update Productos P
				set P.nombreProducto = nomProducto,
					P.cantidad = cant
                    where codigoProducto = codProducto;
        End//
Delimiter ;

-- --------------------------* CRUD Create, Read, Update, Delete(Buscar) *--------------

-- ------------------------------- Agregar Empleado
Delimiter //
	Create procedure sp_AgregarEmpleado(in numeroEmpleado int,
		in apellidosEmpleado varchar(150), in nombresEmpleado varchar(150),
		in direccionEmpleado varchar(150), in telefonoContacto varchar(8),
        in gradoCocinero varchar(50), in codigoTipoEmpleado int)
		Begin
			Insert into Empleados(numeroEmpleado,apellidosEmpleado,
					nombresEmpleado,direccionEmpleado,
					telefonoContacto, gradoCocinero, codigoTipoEmpleado)
				values(numeroEmpleado,apellidosEmpleado,
					nombresEmpleado,direccionEmpleado,
					telefonoContacto, gradoCocinero, codigoTipoEmpleado);
        End//
Delimiter ; 

-- ------------------------------ Listar Empleados --------------------

Delimiter //
	Create procedure sp_ListarEmpleados()
		Begin
			Select 
				E.codigoEmpleado,
                E.numeroEmpleado,
                E.apellidosEmpleado,
                E.nombresEmpleado,
                E.direccionEmpleado,
                E.telefonoContacto,
                E.gradoCocinero,
                E.codigoTipoEmpleado
					From Empleados E;
		End//
Delimiter ;

-- ------------------------------ Buscar Empleado --------------------------
Delimiter //
	Create procedure sp_BuscarEmpleado(in codEmpleado int)
		Begin
			Select 
				E.codigoEmpleado,
                E.numeroEmpleado,
                E.apellidosEmpleado,
                E.nombresEmpleado,
                E.direccionEmpleado,
                E.telefonoContacto,
                E.gradoCocinero,
                E.codigoTipoEmpleado
					from Empleados E
						where E.codigoEmpleado = codEmpleado;
		End//
Delimiter ;

-- ----------------------------------- Eliminar Empleado
Delimiter //
	Create procedure sp_EliminarEmpleado(in codEmpleado int)
		Begin
			Delete from Empleado
				where codigoEmpleado = codEmpleado;
        End//
Delimiter ;

-- ----------------------------------- Editar Empleado ---------------------------------
Delimiter //
	Create procedure sp_EditarEmpleado(in codEmpleado int,in numEmpleado int,
		in apeEmpleado varchar(150), in nomEmpleado varchar(150),
		in direcEmpleado varchar(150), in telContacto varchar(8),
        in gradCocinero varchar(50))
		Begin
			Update Empleados E
				set E.numeroEmpleado = numEmpleado,
					E.apellidosEmpleado = apeEmpleado, 
					E.nombresEmpleado = nomEmpleado,
					E.direccionEmpleado = direcEmpleado,
					E.telefonoContacto = telContacto,
					E.gradoCocinero = gradCocinero
						where E.codigoEmpleado = codEmpleado;
		
        End//
Delimiter ;

-- --------------------------* CRUD Create, Read, Update, Delete(Buscar) *--------------
-- -------------------------- Agregar Servicio------------------------------------------
Delimiter //
	Create procedure sp_AgregarServicio(in fechaServicio date, 
		in tipoServicio varchar(150), in horaServicio time, 
        in lugarServicio varchar(150),in telefonoContacto varchar(150), 
        in codigoEmpresa int)
        Begin 
			Insert into Servicios(fechaServicio, tipoServicio,
            lugarServicio, telefonoServicio, codigoEmpresa)
				values(fechaServicio, tipoServicio,
				lugarServicio, telefonoServicio, codigoEmpresa);
        End//
Delimiter ; 

-- --------------------------- Listar Servicios ---------------------------------------
Delimiter //
	Create procedure sp_ListarServicios()
		Begin 
			Select 
				S.codigoServicio,
                S.fechaServicio,
                S.tipoServicio,
                S.horaServicio,
                S.lugarServicio,
                S.telefonoContacto,
                S.codigoEmpresa
					from Servicios S;
		End//
Delimiter ;

-- ---------------------------- Buscar Servicio ----------------------------
Delimiter //
	Create procedure sp_BuscarServicio(in codServicio int )
		Begin 
			Select 
                S.fechaServicio,
                S.tipoServicio,
                S.horaServicio,
                S.lugarServicio,
                S.telefonoContacto,
                S.codigoEmpresa
					from Servicios S
						where S.codigoServicio = codServicio;
		End//
Delimiter ;

-- ----------------------------- Eliminar Servicio -------------------------------------------
Delimiter //
	Create procedure sp_EliminarServicio(in codServicio int)
		Begin
			Delete from Servicios
				where codigoServicio = codServicio;
        End//
Delimiter ;

-- ---------------------------- Editar Servicio --------------------------------------------
Delimiter //
	Create procedure sp_EditarServicio(in codServicio int, in fechServicio date, 
		in tipServicio varchar(150), in hrServicio time, 
        in lgrServicio varchar(150),in telContacto varchar(150))
			Begin
				Update Servicios S
					set S.fechaServicio = fechServicio,
						S.tipoServicio = tipServicio,
						S.horaServicio = hrServicio,
						S.lugarServicio = lgrServicio,
						S.telefonoContacto = telContacto
							where S.codigoServicio = codServicio;
            End//
Delimiter ;

-- --------------------------* CRUD Create, Read, Update, Delete(Buscar) *--------------
-- -------------------------- Agregar Presupuesto -----------------------------------
Delimiter //
	Create procedure sp_AgregarPresupuesto(in fechaSolicitud date, 
		in cantidadPresupuesto decimal(10,2), in codigoEmpresa int)
		Begin
			Insert into Presupuestos(fechaSolicitud,cantidadPresupuesto, codigoEmpresa)
				values(fechaSolicitud,cantidadPresupuesto, codigoEmpresa);
        End //
Delimiter ;   

-- ---------------------------- Listar Presupuestos ---------------------------------------
Delimiter //
	Create procedure sp_ListarPresupuestos()
		Begin
			Select 
            P.codigoPresupuesto,
            P.fechaSolicitud,
            P.cantidadPresupuesto,
            P.codigoEmpresa
            From Presupuestos P;
        End //
Delimiter ;  

-- -------------------------------- Buscar Presupuesto ------------------------------------
Delimiter //
	Create procedure sp_BuscarPresupuesto(in codPresupuesto int)
		Begin
			Select 
				P.codigoPresupuesto,
				P.fechaSolicitud,
				P.cantidadPresupuesto,
				P.codigoEmpresa
				From Presupuestos P
					where P.codigoPresupuesto = codPresupuesto;
		End //
Delimiter ;

-- ---------------------------------- Eliminar Presupuesto ------------------------------
Delimiter //
	Create procedure sp_EliminarPresupuesto(in codPresupuesto int)
		Begin
			Delete from Presupuestos
				where codigoPresupuesto = codPresupuesto;
        End //
Delimiter ;

-- ----------------------------------- Editar Presupuesto ----------------------------
Delimiter //
	Create procedure sp_EditarPresupuesto(in codPresupuesto int, 
		in fechSolicitud date, in cantPresupuesto decimal(10,2))
		Begin
			Update Presupuestos P
				set P.fechaSolicitud = fechSolicitud,
					P.cantidadPresupuesto = cantPresupuesto
						where P.codigoPresupuesto = codPresupuesto;
        End //
Delimiter ;

-- --------------------------* CRUD Create, Read, Update, Delete(Buscar) *--------------
-- --------------------------Agregar Plato ---------------------------------------
Delimiter //
	Create procedure sp_AgregarPlato(in cantidad int, in nombrePlato varchar(50),
		in descripcionPlato varchar(150), in precioPlato decimal(10,2),
        in codigoTipoPlato int)
		Begin
			Insert into Platos(cantidad, nombrePlato,descripcionPlato, 
            precioPlato, codigoTipoPlato)
				values(cantidad, nombrePlato,descripcionPlato, 
				precioPlato, codigoTipoPlato);
        End//
Delimiter ;

-- ------------------------ Listar Platos ------------------------------------------
Delimiter //
	Create procedure sp_ListarPlatos()
		Begin
			Select 
				P.codigoPlato,
                P.cantidad,
                P.nombrePlato,
                P.descripcionPlato,
                P.precioPlato,
                P.codigoTipoPlato
                From Platos P;
        End//
Delimiter ;

-- ---------------------------- Buscar Plato- ---------------------
Delimiter //
	Create procedure sp_BuscarPlato(in codPlato int)
		Begin
			Select 
				P.codigoPlato,
                P.cantidad,
                P.nombrePlato,
                P.descripcionPlato,
                P.precioPlato,
                P.codigoTipoPlato
				From Platos P
					where P.codigoPlato = codPlato;
		End //
Delimiter ;

-- -------------------------- Eliminar Plato -------------------------
Delimiter //
	Create procedure sp_EliminarPlato(in codPlato int)
		Begin
			Delete from Platos 
				where codigoPlato = codPlato;
        End //
Delimiter ;

-- ---------------------------- Editar Plato ---------------------------
Delimiter //
	Create procedure sp_EditarPlato(in codPlato int, in cant int,
		in nomPlato varchar(50),in descPlato varchar(150), 
        in precPlato decimal(10,2),in codTipoPlato int)
        Begin
			Update Platos P
				set P.cantidad = cant,
					P.nombrePlato = nomPlato,
					P.descripcionPlato = descPlato,
					P.precioPlato = precPlato,
					P.codigoTipoPlato = codTipoPlato
						where P.codigoPlato = codPlato;
        End//
Delimiter ;

-- --------------------------* CRUD Create, Read, Update, Delete(Buscar) *--------------
-- --------------------------Agregar Productos_has_Platos -------------------------------
Delimiter //
	Create procedure sp_AgregarProductos_has_Platos(in codigoPlato int, in codigoProducto int)
		Begin
			Insert into Productos_has_Platos(codigoPlato, codigoProducto)
				values(codigoPlato, codigoProducto);
        End //
Delimiter ;   

-- ------------------------Listar Productos_has_Platos --------------------------------
Delimiter //
	Create procedure sp_ListarProductos_has_Platos()
		Begin
			Select 
            PhP.Productos_codigoProducto,
            PhP.codigoPlato,
            PhP.codigoProducto
            From Productos_has_Platos PhP;
        End //
Delimiter ;   

-- --------------------------- Buscar Productos_has_Platos -------------------------------------
Delimiter //
	Create procedure sp_BuscarProductos_has_Platos(in Productos_codProducto int)
		Begin
			Select 
				PhP.Productos_codigoProducto,
				PhP.codigoPlato,
				PhP.codigoProducto
				From Productos_has_Platos PhP
					where PhP.Productos_codigoProducto = Productos_codProducto;
		End //
Delimiter ;

-- ---------------------------------- Eliminar Productos_has_Platos-------------------------
/*
Delimiter //
	Create procedure sp_EliminarProductos_has_Platos(in Productos_codProducto int)
		Begin
			Delete from Productos_has_Platos
				where Productos_codigoProducto = Productos_codProducto;
        End //
Delimiter ;
*/
-- ---------------------------------- Editar Productos_has_Platos ----------------------
/*

Delimiter //
	Create procedure sp_EditarProductos_has_Platos(in Productos_codProducto int,
		in codPlato int, in codProducto int)
		Begin
			Update Productos_has_Platos PhP
				set 
					PhP.codigoPlato = codPlato,
					PhP.codigoProducto = codProducto
						where Productos_codigoProducto = Productos_codProducto;
        End //
Delimiter ;

*/

-- --------------------------* CRUD Create, Read, Update, Delete(Buscar) *--------------

-- -------------------------- Agregar Servicios_has_Platos --------------------------------
Delimiter //
	Create procedure sp_AgregarServicios_has_Platos(in codigoPlato int, codigoServicio int)
		Begin
			Insert into Servicios_has_Platos(codigoPlato, codigoServicio)
				values(codigoPlato, codigoServicio);
        End //
Delimiter ;   

-- --------------------------- Listar Servicios_has_Platos -------------------------------
Delimiter //
	Create procedure sp_ListarServicios_has_Platos()
		Begin
			Select 
				ShP.Servicios_codigoServicio,
                ShP.codigoPlato,
                ShP.codigoServicio
				From Servicios_has_Platos ShP;
        End //
Delimiter ;    
    
-- --------------------------- Buscar Servicios_has_Platos -------------------------------
Delimiter //
	Create procedure sp_BuscarServicios_has_Platos(in Servicios_codServicio int)
		Begin
			Select 
				ShP.Servicios_codigoServicio,
                ShP.codigoPlato,
                ShP.codigoServicio
				From Servicios_has_Platos ShP
					where ShP.Servicios_codigoServicio = Servicios_codServicio;
		End //
Delimiter ;

-- --------------------------- Eliminar Servicios_has_Platos -------------------------------
/*
Delimiter //
	Create procedure sp_EliminarServicios_has_Platos(in Servicios_codServicio int)
		Begin
			Delete from Servicios_has_Platos
				where Servicios_codigoServicio = Servicios_codServicio;
        End //
Delimiter ;
*/
-- --------------------------- Editar Servicios_has_Platos -------------------------------
/*
Delimiter //
	Create procedure sp_EditarServicios_has_Platos(in Servicios_codServicio int,
		in codPlato int, codServicio int)
			Begin
				Update Servicios_has_Platos ShP
					set ShP.Servicios_codigoServicio = Servicios_codServicio,
						ShP.codigoPlato = codPlato,
						ShP.codigoServicio = codServicio
							where ShP.Servicios_codigoServicio = Servicios_codServicio;
            End//
Delimiter ;
*/

-- --------------------------* CRUD Create, Read, Update, Delete(Buscar) *--------------

-- --------------------------- Agregar Servicios_has_Empleados -------------------------------
Delimiter //
	Create procedure sp_AgregarServicios_has_Empleados(in codigoServicio int, in codigoEmpleado int,
		in fechaEvento date, in horaEvento time, lugarEvento varchar(150))
		Begin
			Insert into Servicios_has_Empleados(codigoServicio, codigoEmpleado,fechaEvento, horaEvento, lugarEvento)
				values(codigoServicio, codigoEmpleado,fechaEvento, horaEvento, lugarEvento);
        End //
Delimiter ;  

-- --------------------------- Listar Servicios_has_Empleados -------------------------------
Delimiter //
	Create procedure sp_ListarServicios_has_Empleados()
		Begin
			Select 
				ShE.Servicios_codigoServicio,
				ShE.codigoServicio,
				ShE.codigoEmpleado,
				ShE.fechaEvento,
				ShE.horaEvento,
                ShE.lugarEvento
				From Servicios_has_Empleados ShE;
        End //
Delimiter ; 
-- --------------------------- Buscar Servicios_has_Empleados -------------------------------
Delimiter //
	Create procedure sp_BuscarServicios_has_Empleados(in Servicios_codServicio int)
		Begin
			Select 
				ShE.Servicios_codigoServicio,
				ShE.codigoServicio,
				ShE.codigoEmpleado,
				ShE.fechaEvento,
				ShE.horaEvento,
                ShE.lugarEvento
				From Servicios_has_Empleados ShE
					where ShE.Servicios_codigoServicio = Servicios_codServicio;
        End//
Delimiter ;
-- --------------------------- Eliminar Servicios_has_Empleados -------------------------------

Delimiter //
	Create procedure sp_EliminarServicios_has_Empleados(in Servicios_codServicio int)
		Begin
			Delete from Servicios_has_Empleados
				where Servicios_codigoServicio = Servicios_codServicio;
        End //
Delimiter ;

-- --------------------------- Editar Servicios_has_Empleados ----------------------------------

Delimiter //
	Create procedure sp_EditarServicios_has_Empleados(in Servicios_codServicio int,
		in fechEvento date,in hrEvento time, lgrEvento varchar(150))
			Begin
				Update Servicios_has_Empleados ShE
					set	ShE.fechaEvento = fechEvento,
						ShE.horaEvento = hrEvento,
						ShE.lugarEvento = lgrEvento
						where ShE.Servicios_codigoServicio = Servicios_codServicio;
            End//
Delimiter ;


call sp_AgregarEmpresa('Pizza Hut','Zona 5 Villa Nueva','12345678');

call sp_AgregarProducto('Papas',12);

call sp_AgregarTipoEmpleado('El mejor empleado');

call sp_AgregarTipoPlato('El mejor plato de la historia');

call sp_AgregarPresupuesto('2023-02-12',122.2,1);
call sp_AgregarPresupuesto('2015-05-15',987.5,1);
call sp_AgregarPresupuesto('2022-09-10',540.2,1);
call sp_AgregarPresupuesto('2021-11-23',1254.5,1);

SELECT EM.codigoEmpresa, EM.nombreEmpresa, EM.direccion, EM.telefono, S.codigoServicio, S.tipoServicio, S.lugarServicio, S.horaServicio, SE.fechaEvento, E.nombresEmpleado, E.apellidosEmpleado, TE.descripcion, P.nombrePlato, P.cantidad, PRE.cantidadPresupuesto, PR.nombreProducto, PR.cantidad
FROM Empresas EM
INNER JOIN Servicios S ON EM.codigoEmpresa = S.codigoEmpresa
INNER JOIN servicios_has_empleados SE ON S.codigoServicio = SE.codigoServicio
INNER JOIN Empleados E ON SE.codigoEmpleado = E.codigoEmpleado
INNER JOIN TipoEmpleado TE ON E.codigoTipoEmpleado = TE.codigoTipoEmpleado
INNER JOIN servicios_has_platos SP ON S.codigoServicio = SE.codigoServicio
INNER JOIN Platos P ON SP.codigoPlato = P.codigoPlato
INNER JOIN productos_has_platos PP ON P.codigoPlato = PP.codigoPlato
INNER JOIN Productos PR ON PP.codigoProducto = PR.codigoProducto
INNER JOIN Presupuestos PRE ON EM.codigoEmpresa = PRE.codigoEmpresa
WHERE EM.codigoEmpresa = 1;