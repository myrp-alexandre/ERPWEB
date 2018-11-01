CREATE VIEW dbo.vwAf_CambioUbicacion
AS
SELECT        dbo.Af_CambioUbicacion_Activo.IdEmpresa, dbo.Af_CambioUbicacion_Activo.IdCambioUbicacion, dbo.Af_CambioUbicacion_Activo.IdActivoFijo, 
                         dbo.Af_Activo_fijo.Af_Nombre, dbo.Af_CambioUbicacion_Activo.FechaCambio, dbo.Af_CambioUbicacion_Activo.MotivoCambio, 
                         dbo.Af_CambioUbicacion_Activo.IdTipoCatalogo_Ubicacion_Actu, Ubicacion_Actu.Descripcion AS nom_ubicacion_act, 
                         dbo.Af_CambioUbicacion_Activo.IdTipoCatalogo_Ubicacion_Ant, Ubicacion_Ant.Descripcion AS nom_ubicacion_dest, 
                         dbo.Af_CambioUbicacion_Activo.IdDepartamento_Actu, Departamento_Act.nom_departamento AS nom_departamento_Act, 
                         dbo.Af_CambioUbicacion_Activo.IdDepartamento_Ant, Departamento_Ant.nom_departamento AS nom_departamento_Ant, 
                         dbo.Af_CambioUbicacion_Activo.IdCentroCosto_Actu, Centro_Ant.Centro_costo AS nom_CentroCosto_Actu, dbo.Af_CambioUbicacion_Activo.IdCentroCosto_Ant, 
                         Centro_Actu.Centro_costo AS nom_CentroCosto_Ant, dbo.Af_CambioUbicacion_Activo.IdSucursal_Actu, Sucursal_Actu.Su_Descripcion AS nom_Sucursal_Actu, 
                         dbo.Af_CambioUbicacion_Activo.IdSucursal_Ant, Sucursal_Ant.Su_Descripcion AS nom_Sucursal_Ant, Persona_Ant.pe_nombreCompleto AS nom_Cliente_Ant, 
                         Persona_Actu.pe_nombreCompleto AS nom_Cliente_Actu, dbo.Af_CambioUbicacion_Activo.IdEncargado_Ant, dbo.Af_CambioUbicacion_Activo.IdEncargado_Actu, 
                         Encargado_Ant.nom_encargado AS nom_Encargado_Ant, Encargado_Actu.nom_encargado AS nom_Encargado_Actu, 
                         dbo.Af_CambioUbicacion_Activo.IdCentroCosto_sub_centro_costo_Actu, dbo.Af_CambioUbicacion_Activo.IdCentroCosto_sub_centro_costo_Ant, 
                         SubCentro_Actu.Centro_costo AS nom_Centro_costo_sub_centro_costo_Actu, SubCentro_Ant.Centro_costo AS nom_Centro_costo_sub_centro_costo_Ant
FROM            dbo.Af_Departamento AS Departamento_Act RIGHT OUTER JOIN
                         dbo.Af_Departamento AS Departamento_Ant RIGHT OUTER JOIN
                         Fj_servindustrias.fa_cliente_x_ct_centro_costo AS fa_cliente_x_ct_centro_costo_Actu INNER JOIN
                         dbo.fa_cliente AS Cliente_Actu ON fa_cliente_x_ct_centro_costo_Actu.IdEmpresa_cli = Cliente_Actu.IdEmpresa AND 
                         fa_cliente_x_ct_centro_costo_Actu.IdCliente_cli = Cliente_Actu.IdCliente INNER JOIN
                         dbo.tb_persona AS Persona_Actu ON Cliente_Actu.IdPersona = Persona_Actu.IdPersona RIGHT OUTER JOIN
                         dbo.tb_sucursal AS Sucursal_Ant RIGHT OUTER JOIN
                         dbo.Af_Encargado AS Encargado_Actu RIGHT OUTER JOIN
                         dbo.ct_centro_costo_sub_centro_costo AS SubCentro_Actu INNER JOIN
                         dbo.ct_centro_costo AS Centro_Actu ON SubCentro_Actu.IdEmpresa = Centro_Actu.IdEmpresa AND 
                         SubCentro_Actu.IdCentroCosto = Centro_Actu.IdCentroCosto RIGHT OUTER JOIN
                         dbo.Af_CambioUbicacion_Activo INNER JOIN
                         dbo.Af_Activo_fijo ON dbo.Af_CambioUbicacion_Activo.IdEmpresa = dbo.Af_Activo_fijo.IdEmpresa AND 
                         dbo.Af_CambioUbicacion_Activo.IdActivoFijo = dbo.Af_Activo_fijo.IdActivoFijo ON SubCentro_Actu.IdEmpresa = dbo.Af_CambioUbicacion_Activo.IdEmpresa AND 
                         SubCentro_Actu.IdCentroCosto = dbo.Af_CambioUbicacion_Activo.IdCentroCosto_Actu AND 
                         SubCentro_Actu.IdCentroCosto_sub_centro_costo = dbo.Af_CambioUbicacion_Activo.IdCentroCosto_sub_centro_costo_Actu LEFT OUTER JOIN
                         dbo.Af_Encargado AS Encargado_Ant ON dbo.Af_CambioUbicacion_Activo.IdEmpresa = Encargado_Ant.IdEmpresa AND 
                         dbo.Af_CambioUbicacion_Activo.IdEncargado_Ant = Encargado_Ant.IdEncargado ON Encargado_Actu.IdEmpresa = dbo.Af_CambioUbicacion_Activo.IdEmpresa AND 
                         Encargado_Actu.IdEncargado = dbo.Af_CambioUbicacion_Activo.IdEncargado_Actu ON Sucursal_Ant.IdEmpresa = dbo.Af_CambioUbicacion_Activo.IdEmpresa AND 
                         Sucursal_Ant.IdSucursal = dbo.Af_CambioUbicacion_Activo.IdSucursal_Ant LEFT OUTER JOIN
                         dbo.tb_sucursal AS Sucursal_Actu ON dbo.Af_CambioUbicacion_Activo.IdEmpresa = Sucursal_Actu.IdEmpresa AND 
                         dbo.Af_CambioUbicacion_Activo.IdSucursal_Actu = Sucursal_Actu.IdSucursal ON fa_cliente_x_ct_centro_costo_Actu.IdEmpresa_cli = Centro_Actu.IdEmpresa AND 
                         fa_cliente_x_ct_centro_costo_Actu.IdEmpresa_cc = Centro_Actu.IdEmpresa AND 
                         fa_cliente_x_ct_centro_costo_Actu.IdCentroCosto_cc = Centro_Actu.IdCentroCosto LEFT OUTER JOIN
                         Fj_servindustrias.fa_cliente_x_ct_centro_costo AS fa_cliente_x_ct_centro_costo_Ant INNER JOIN
                         dbo.fa_cliente AS Cliente_Ant ON fa_cliente_x_ct_centro_costo_Ant.IdEmpresa_cli = Cliente_Ant.IdEmpresa AND 
                         fa_cliente_x_ct_centro_costo_Ant.IdCliente_cli = Cliente_Ant.IdCliente INNER JOIN
                         dbo.tb_persona AS Persona_Ant ON Cliente_Ant.IdPersona = Persona_Ant.IdPersona RIGHT OUTER JOIN
                         dbo.ct_centro_costo AS Centro_Ant INNER JOIN
                         dbo.ct_centro_costo_sub_centro_costo AS SubCentro_Ant ON Centro_Ant.IdEmpresa = SubCentro_Ant.IdEmpresa AND 
                         Centro_Ant.IdCentroCosto = SubCentro_Ant.IdCentroCosto ON fa_cliente_x_ct_centro_costo_Ant.IdEmpresa_cc = Centro_Ant.IdEmpresa AND 
                         fa_cliente_x_ct_centro_costo_Ant.IdCentroCosto_cc = Centro_Ant.IdCentroCosto ON dbo.Af_CambioUbicacion_Activo.IdEmpresa = SubCentro_Ant.IdEmpresa AND 
                         dbo.Af_CambioUbicacion_Activo.IdCentroCosto_Ant = SubCentro_Ant.IdCentroCosto AND 
                         dbo.Af_CambioUbicacion_Activo.IdCentroCosto_sub_centro_costo_Ant = SubCentro_Ant.IdCentroCosto_sub_centro_costo ON 
                         Departamento_Ant.IdEmpresa = dbo.Af_CambioUbicacion_Activo.IdEmpresa AND 
                         Departamento_Ant.IdDepartamento = dbo.Af_CambioUbicacion_Activo.IdDepartamento_Ant ON 
                         Departamento_Act.IdEmpresa = dbo.Af_CambioUbicacion_Activo.IdEmpresa AND 
                         Departamento_Act.IdDepartamento = dbo.Af_CambioUbicacion_Activo.IdDepartamento_Actu LEFT OUTER JOIN
                         dbo.Af_Catalogo AS Ubicacion_Ant ON dbo.Af_CambioUbicacion_Activo.IdTipoCatalogo_Ubicacion_Ant = Ubicacion_Ant.IdCatalogo LEFT OUTER JOIN
                         dbo.Af_Catalogo AS Ubicacion_Actu ON dbo.Af_CambioUbicacion_Activo.IdTipoCatalogo_Ubicacion_Actu = Ubicacion_Actu.IdCatalogo