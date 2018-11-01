
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spPRD_Rpt_RPRD001]
	-- Add the parameters for the stored procedure here
	@i_IdEmpresa	Int,
	@i_IdSucursal	Int,
	@i_IdBodega		Int,
	@i_IdMovi_inven_tipo	Int,
	@i_IdNumMovi	NUmERIC(18),
	@i_IdUsuario varchar(20),
	@i_nom_pc varchar(50)
	AS
BEGIN
	delete from tbPRD_Rpt_RPRD001 where IdUsuario =@i_IdUsuario and nom_pc =@i_nom_pc;

	Insert into tbPRD_Rpt_RPRD001 ( 
	IdEmpresa, IdSucursal, IdBodega, IdMovi_inven_tipo ,IdNumMovi ,Secuencia ,IdProducto,
	CodigoBarra ,  IdUsuario, Fecha_Transac, nom_pc,pr_descripcion)
	select mv.IdEmpresa, mv.IdSucursal, mv.IdBodega,mv.IdMovi_inven_tipo ,mv.IdNumMovi 
	,mv.Secuencia ,mv.IdProducto, mv.CodigoBarra, @i_IdUsuario, GETDATE(),@i_nom_pc, prd.pr_descripcion
	from in_movi_inve_detalle_x_Producto_CusCider mv inner join in_Producto prd
	on mv.IdEmpresa = prd.IdEmpresa and mv.IdProducto = prd.IdProducto
	where mv.IdEmpresa= @i_IdEmpresa and mv.IdSucursal= @i_IdSucursal 
	and mv.IdBodega= @i_IdBodega and mv.IdMovi_inven_tipo = @i_IdMovi_inven_tipo 
	and mv.IdNumMovi = @i_IdNumMovi 
	



END