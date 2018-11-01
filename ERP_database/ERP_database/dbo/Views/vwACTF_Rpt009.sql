CREATE VIEW [dbo].[vwACTF_Rpt009] AS
SELECT af.IdEmpresa, af.IdActivoFijo, suc.IdSucursal, suc.Su_Descripcion, af.CodActivoFijo, AF.Af_Codigo_Barra,
	af.Af_Nombre, af.Af_fecha_compra, cat.Descripcion	
 FROM Af_Activo_fijo af INNER JOIN 
		tb_sucursal suc ON suc.IdEmpresa = af.IdEmpresa AND suc.IdSucursal = af.IdSucursal INNER JOIN
		Af_Catalogo cat ON af.IdTipoCatalogo_Ubicacion = cat.IdCatalogo