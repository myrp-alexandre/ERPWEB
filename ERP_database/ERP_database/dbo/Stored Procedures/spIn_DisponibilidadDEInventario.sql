create PROCEDURE [dbo].[spIn_DisponibilidadDEInventario]   
  
        
      @fecha date = null ,  
      @IdEmpresa int ,  
      @IdSucursal int = null,  
      @IdBodega int = null,  
      @Categorias varchar(max) = null,  
      @IdUsuario varchar(40)  
        
        
AS  
BEGIN  
  
      declare @ConstainsCategorias varchar(max)  
      declare @Query varchar(max)  
      declare @ConstaisFecha varchar(max)  
      declare @enviaBodega varchar(max)  
      declare @enviaSucursal varchar(max) 
        
       
      delete in_rptDispInve where EmpresaSi = @IdEmpresa and IdUsuario = @IdUsuario  
  
                  if(@Categorias is null)  
                        set @ConstainsCategorias =''  
                  else  
                        set @ConstainsCategorias ='and v.IdCategoria in('+@Categorias+')'  
                    
                  if(@fecha is null)  
                        set @ConstaisFecha =''  
                  else  
                        set @ConstaisFecha ='where a.cm_fecha <= '''+Cast(@fecha as varchar(20))+''''  
                          
                   if(@IdBodega is null)  
                        set @enviaBodega =''  
                  else  
                        set @enviaBodega ='b.IdBodega ='+Cast(@IdBodega as varchar(20))+''+'and'        
                  
                  if(@IdSucursal is null)  
                        set @enviaSucursal =''  
                  else  
                        set @enviaSucursal=' b.IdSucursal = '+cast(@IdSucursal as varchar(20))+' and '      
                          
  
  
                  set @Query =      'insert into in_rptDispInve select b.IdEmpresa as EmpresaSi,b.IdSucursal as IdSucursalSi ,b.IdBodega as IdBodegaSi, b.IdProducto as IdProductoSi,z.Su_Descripcion,x.bo_Descripcion,c.pr_codigo ,c.pr_descripcion,C.IdCategoria ,c.pr_peso ,v.ca_Categoria, A.*,isnull(d.pr_Pedidos,0) as pr_Pedidos,'''+@IdUsuario+'''   from  in_producto_x_tb_bodega b   
                                         left join (select a.IdEmpresa,a.IdSucursal,a.IdBodega,b.IdProducto, isnull(sum(b.dm_cantidad),0)as stock from in_movi_inve a  
                                         inner join in_movi_inve_detalle b on a.IdEmpresa=b.IdEmpresa and a.IdSucursal= b.IdSucursal and a.IdBodega= b.IdBodega   
                                         and a.IdMovi_inven_tipo = b.IdMovi_inven_tipo and a.IdNumMovi= b.IdNumMovi   
                                         '+@ConstaisFecha+ '   
                                          group by a.IdEmpresa,a.IdSucursal,a.IdBodega,b.IdProducto   
                                         ) as a  on a.IdEmpresa = b.IdEmpresa  and a.IdSucursal = b.IdSucursal and a.IdBodega = b.IdBodega and a.IdProducto = b.IdProducto  
                                         left join in_producto c on b.IdEmpresa = c.IdEmpresa and b.IdProducto= c.IdProducto  
                                         left join vwFa_Producto_x_Pedidos d on a.IdEmpresa = d.IdEmpresa and a.IdSucursal= d.IdSucursal and a.IdBodega = d.IdBodega and a.IdProducto = d.IdProducto  
                                               inner join tb_bodega x on b.IdBodega = x.IdBodega and b.IdEmpresa= x.IdEmpresa and b.IdSucursal= x.IdSucursal  
                                         inner join tb_sucursal z on b.IdEmpresa= z.IdEmpresa  and b.IdSucursal= z.IdSucursal  
                                         inner join in_categorias v on c.IdEmpresa= v.IdEmpresa  and c.IdCategoria= v.IdCategoria  
                                          where '+@enviaBodega+' '+@enviaSucursal+'  b.IdEmpresa = '+Cast(@IdEmpresa as varchar(20))+' '+@ConstainsCategorias  
    --  print @Query   
       
EXEC(@Query )  
       select * from  in_rptDispInve where EmpresaSi = @IdEmpresa and IdUsuario = @IdUsuario  
        
END