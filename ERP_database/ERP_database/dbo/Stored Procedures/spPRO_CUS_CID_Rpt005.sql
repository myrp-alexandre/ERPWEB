

CREATE  PROCEDURE [dbo].[spPRO_CUS_CID_Rpt005]  
(@i_IdEmpresa Int,
 @i_IdSucursal Int,
 @i_IdDespacho Numeric(18,0),
 @i_IdUsuario varchar(20), 
 @i_nom_pc varchar(50) 
  ) 
 AS /*SP para reporteria del ERP creado desde la pantalla Administración de reporte*/ 

 delete tbPRO_CUS_CID_Rpt005 where IdUsuario = @i_IdUsuario and nom_pc = @i_nom_pc 
 
 insert into tbPRO_CUS_CID_Rpt005 (IdEmpresa , IdUsuario , Fecha_Transac, nom_pc,
empresa,  
cliente, pe_cedulaRuc,
 IdUnidadMedida, FechaReg, FechaIniTras, FechaFinTras, 
PuntoPartida, PuntoLLegada, Placa, Chofer, TipoTransporte, 
 producto, CodigoBarraMaestro,cantidad,pesoxcant,peso,precio,
 ot,obra,
 det_observacion,
 NumDespacho,NumFactura,NumGuia,
 IdDespacho,Su_Descripcion,bo_Descripcion)

 SELECT    cab.IdEmpresa, @i_IdUsuario, GETDATE(), @i_nom_pc , 
 emp.em_nombre,  '' AS cl_RazonSocial , cli.pe_cedulaRuc,
 prod.IdUnidadMedida, cab.FechaReg, cab.FechaIniTras, cab.FechaFinTras, 
  cab.PuntoPartida, cab.PuntoLLegada, cab.Placa, cab.Chofer, cab.TipoTransporte, 
prod.pr_descripcion , det.CodigoBarraMaestro,det.Cantidad,(0*det.Cantidad)
 as subtotal, det.peso, det.precio,
ot.Codigo, ob.Descripcion, 
 det.Observacion,
 cab.NumDespacho,cab.NumFactura,cab.NumGuiaRemision,
 cab.IdDespacho ,cab.Su_Descripcion, cab.bo_Descripcion 
 
FROM         dbo.vwprd_Despacho AS cab INNER JOIN
                      dbo.prd_DespachoDet AS det ON cab.IdEmpresa = det.IdEmpresa 
                      AND cab.IdDespacho = det.IdDespacho AND cab.IdSucursal = det.IdSucursal INNER JOIN
                      dbo.tb_empresa AS emp ON cab.IdEmpresa = emp.IdEmpresa INNER JOIN
                      dbo.vwfa_cliente AS cli ON cli.IdEmpresa = cab.IdEmpresa 
                      AND cab.IdCliente = cli.IdCliente INNER JOIN
                      dbo.in_Producto AS prod ON det.IdProducto = prod.IdProducto 
                      AND det.IdEmpresa = prod.IdEmpresa
                      inner join prd_Orden_Taller ot on
                      ot.IdEmpresa = cab.IdEmpresa and det.IdSucursal = ot.IdSucursal and
                      det.IdOrdenTaller = ot.IdOrdenTaller 
                      inner join prd_Obra ob on
                      ob.IdEmpresa = cab.IdEmpresa and ob.CodObra = cab.CodObra 
                      
                      
                      where cab.IdEmpresa = @i_IdEmpresa and cab.IdDespacho = @i_IdDespacho 
                      and cab.IdSucursal =@i_IdSucursal
                     
--select * from tbPRO_CUS_CID_Rpt005 
--delete tbPRO_CUS_CID_Rpt005
--exec [spPRO_CUS_CID_Rpt005] 6,1,1,'5555','DESARROLLO3-PC'