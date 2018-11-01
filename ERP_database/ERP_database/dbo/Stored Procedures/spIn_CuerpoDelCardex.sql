CREATE PROCEDURE [dbo].[spIn_CuerpoDelCardex]   
  @IdEmpresa int,     
  @IdBodega Int,    
  @IdSucursal int,    
  @IdProducto numeric(18,0),    
  @FechaInicial date,  
  @FechaFinal date    
AS  
BEGIN  
  
 select b.cm_fecha, d.Su_Descripcion,e.bo_Descripcion,c.tm_descripcion as Mov_Inv_Tipo,a.IdNumMovi,a.mv_tipo_movi,f.pr_descripcion,a.dm_cantidad  
    ,a.mv_costo,0 dm_peso from in_movi_inve_detalle a  
    inner join in_movi_inve b on a.IdEmpresa = b.IdEmpresa and a.IdSucursal = b.IdSucursal and a.IdBodega = b.IdBodega   
                    and a.IdNumMovi = b.IdNumMovi and a.IdMovi_inven_tipo = b.IdMovi_inven_tipo  
    inner join in_movi_inven_tipo c on a.IdEmpresa = c.IdEmpresa and a.IdMovi_inven_tipo = c.IdMovi_inven_tipo  
    inner join tb_sucursal d on a.IdSucursal = d.IdSucursal and a.IdEmpresa = d.IdEmpresa  
    inner join tb_bodega e on a.IdBodega= e.IdBodega and a.IdEmpresa= e.IdEmpresa  and a.IdSucursal = e.IdSucursal
    inner join in_Producto f on f.IdEmpresa= a.IdEmpresa and f.IdProducto= a.IdProducto  
    where a.IdEmpresa = @IdEmpresa and a.IdBodega= @IdBodega and a.IdSucursal=@IdSucursal  
    and a.IdProducto = @IdProducto and b.cm_fecha between @FechaInicial and @FechaFinal  
  
  
END