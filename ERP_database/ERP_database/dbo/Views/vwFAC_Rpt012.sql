CREATE VIEW [dbo].[vwFAC_Rpt012]
AS
SELECT        ISNULL(ROW_NUMBER() OVER (ORDER BY fa_proforma_det.IdEmpresa), 0) AS IdRow, dbo.fa_proforma_det.IdEmpresa, dbo.fa_proforma_det.IdSucursal, dbo.fa_proforma_det.IdProforma, dbo.fa_proforma_det.Secuencia, 
dbo.fa_TerminoPago.nom_TerminoPago, dbo.fa_proforma.pf_plazo, dbo.fa_proforma.pf_codigo, dbo.fa_proforma.pf_fecha, dbo.fa_proforma.estado, dbo.fa_proforma.pf_atencion_a, dbo.fa_Vendedor.Codigo, dbo.fa_Vendedor.Ve_Vendedor, 
dbo.in_Producto.pr_descripcion, dbo.fa_proforma_det.pd_cantidad, dbo.fa_proforma_det.pd_precio, dbo.fa_proforma_det.pd_por_descuento_uni, dbo.fa_proforma_det.pd_descuento_uni, dbo.fa_proforma_det.pd_precio_final, 
dbo.fa_proforma_det.pd_subtotal, dbo.fa_proforma_det.pd_por_iva, dbo.fa_proforma_det.pd_iva, dbo.fa_proforma_det.pd_total, dbo.in_Marca.Descripcion AS nom_marca, dbo.in_presentacion.nom_presentacion AS nom_modelo, 
in_Producto.pr_observacion, fa_proforma_det.IdProducto, fa_proforma.pr_dias_entrega
FROM            dbo.fa_proforma INNER JOIN
                         dbo.fa_proforma_det ON dbo.fa_proforma.IdEmpresa = dbo.fa_proforma_det.IdEmpresa AND dbo.fa_proforma.IdSucursal = dbo.fa_proforma_det.IdSucursal AND 
                         dbo.fa_proforma.IdProforma = dbo.fa_proforma_det.IdProforma INNER JOIN
                         dbo.in_Producto ON dbo.fa_proforma_det.IdEmpresa = dbo.in_Producto.IdEmpresa AND dbo.fa_proforma_det.IdProducto = dbo.in_Producto.IdProducto INNER JOIN
                         dbo.fa_Vendedor ON dbo.fa_proforma.IdEmpresa = dbo.fa_Vendedor.IdEmpresa AND dbo.fa_proforma.IdVendedor = dbo.fa_Vendedor.IdVendedor INNER JOIN
                         dbo.fa_TerminoPago ON dbo.fa_proforma.IdTerminoPago = dbo.fa_TerminoPago.IdTerminoPago INNER JOIN
                         dbo.in_presentacion ON dbo.in_Producto.IdEmpresa = dbo.in_presentacion.IdEmpresa AND dbo.in_Producto.IdPresentacion = dbo.in_presentacion.IdPresentacion INNER JOIN
                         dbo.in_Marca ON dbo.in_Producto.IdEmpresa = dbo.in_Marca.IdEmpresa AND dbo.in_Producto.IdMarca = dbo.in_Marca.IdMarca