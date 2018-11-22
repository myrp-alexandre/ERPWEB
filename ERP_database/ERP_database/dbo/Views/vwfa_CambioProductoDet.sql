CREATE VIEW vwfa_CambioProductoDet
AS
SELECT        fa_CambioProductoDet.IdEmpresa, fa_CambioProductoDet.IdSucursal, fa_CambioProductoDet.IdBodega, fa_CambioProductoDet.IdCambio, fa_CambioProductoDet.Secuencia, fa_CambioProductoDet.IdCbteVta, 
                         fa_CambioProductoDet.SecuenciaFact, fa_CambioProductoDet.IdProductoFact, fa_CambioProductoDet.IdProductoCambio, fa_CambioProductoDet.CantidadFact, fa_CambioProductoDet.CantidadCambio, 
                         fa_CambioProductoDet.IdDevolucion, in_Producto_1.pr_descripcion AS pr_descripcionFact, in_Producto.pr_descripcion AS pr_descripcionCambio
FROM            fa_CambioProductoDet LEFT OUTER JOIN
                         in_Producto AS in_Producto_1 ON fa_CambioProductoDet.IdProductoFact = in_Producto_1.IdProducto AND fa_CambioProductoDet.IdEmpresa = in_Producto_1.IdEmpresa LEFT OUTER JOIN
                         in_Producto ON fa_CambioProductoDet.IdProductoCambio = in_Producto.IdProducto AND fa_CambioProductoDet.IdEmpresa = in_Producto.IdEmpresa