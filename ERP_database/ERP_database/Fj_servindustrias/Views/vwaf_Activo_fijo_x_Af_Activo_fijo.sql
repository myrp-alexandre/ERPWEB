CREATE VIEW [Fj_servindustrias].[vwaf_Activo_fijo_x_Af_Activo_fijo]
	AS 
	SELECT        Af_Cabezal.IdEmpresa AS IdEmpresa_Cabezal, Af_Cabezal.IdActivoFijo AS IdActivoFijo_Cabezal, Af_Cabezal.CodActivoFijo AS CodActivoFijo_Cabezal, 
                         Af_Cabezal.Af_Nombre AS Af_Nombre_Cabezal, Af_Cabezal.Af_fecha_compra AS Af_fecha_compra_Cabezal, 
                         Af_Cabezal.Af_costo_compra AS Af_costo_compra_Cabezal, 0 AS IdEmpresa_oc_Cabezal, 
                         0 AS IdSucursal_oc_Cabezal, 0 AS IdOrdenCompra_Cabezal, 
                         0 AS Secuencia_oc_Cabezal, dbo.tb_persona.pe_nombreCompleto AS Proveedor, '' co_serie, 
                         '' co_factura, Af_Cabezal.Af_ValorSalvamento AS Af_ValorSalvamento_Cab, Af_Carrocerias.Af_costo_compra AS Af_costo_compra_Carroseria, 
                         cast(0 as bit) Es_carroceria, Af_Carrocerias.Af_ValorSalvamento AS Af_ValorSalvamento_Carroseria, Af_Carrocerias.IdActivoFijo AS IdActivoFijo_Carroceria
FROM            dbo.tb_persona INNER JOIN
                         dbo.cp_proveedor ON dbo.tb_persona.IdPersona = dbo.cp_proveedor.IdPersona RIGHT OUTER JOIN
                         dbo.Af_Activo_fijo_x_Af_Activo_fijo INNER JOIN
                         dbo.Af_Activo_fijo AS Af_Carrocerias ON dbo.Af_Activo_fijo_x_Af_Activo_fijo.IdEmpresa = Af_Carrocerias.IdEmpresa AND 
                         dbo.Af_Activo_fijo_x_Af_Activo_fijo.IdActivoFijo_hijo = Af_Carrocerias.IdActivoFijo INNER JOIN
                         dbo.Af_Activo_fijo AS Af_Cabezal ON dbo.Af_Activo_fijo_x_Af_Activo_fijo.IdEmpresa = Af_Cabezal.IdEmpresa AND 
                         dbo.Af_Activo_fijo_x_Af_Activo_fijo.IdActivoFijo_padre = Af_Cabezal.IdActivoFijo INNER JOIN
                         dbo.Af_Activo_fijo_Categoria ON Af_Cabezal.IdEmpresa = dbo.Af_Activo_fijo_Categoria.IdEmpresa AND 
                         Af_Cabezal.IdCategoriaAF = dbo.Af_Activo_fijo_Categoria.IdCategoriaAF ON  
                         dbo.cp_proveedor.IdEmpresa = Af_Cabezal.IdEmpresa AND  
                         dbo.cp_proveedor.IdEmpresa = Af_Carrocerias.IdEmpresa