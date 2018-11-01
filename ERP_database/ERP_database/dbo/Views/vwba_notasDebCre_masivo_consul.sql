CREATE  view [dbo].[vwba_notasDebCre_masivo_consul]
as
select     IdEmpresa, IdTransaccion, tm_fecha, tm_observacion,tm_tipo, tm_IdUsuario ,COUNT(*) TotalTransacciones
FROM         vwba_notasDebCre_masivo 
group by IdEmpresa, IdTransaccion,  tm_fecha, tm_observacion, tm_tipo ,tm_IdUsuario