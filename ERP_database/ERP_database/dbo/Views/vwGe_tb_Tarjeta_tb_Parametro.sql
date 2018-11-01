CREATE VIEW [dbo].[vwGe_tb_Tarjeta_tb_Parametro] AS
( SELECT A.IdTarjeta , A.tr_Descripcion, A.Estado, A.IdBanco, B.IdEmpresa, B.IdCtaCble_Comision
      ,B.Porcetaje_Comision
      ,B.IdCobro_tipo_x_Tarj
      ,B.IdCobro_tipo_x_RetFu
      ,B.IdCobro_tipo_x_RetIva
      ,B.IdCtaCble_Tarj FROM   tb_tarjeta A, tb_tarjeta_parametro B
WHERE(A.IdTarjeta  = B.IdTarjeta))