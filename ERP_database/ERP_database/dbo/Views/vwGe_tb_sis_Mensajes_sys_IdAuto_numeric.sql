CREATE VIEW [dbo].[vwGe_tb_sis_Mensajes_sys_IdAuto_numeric]
AS
SELECT    '000000'+cast(COUNT(idmensaje) as varchar(20)) as IdMensaje,'' as observacion 
FROM         [dbo].[tb_sis_Mensajes_sys]