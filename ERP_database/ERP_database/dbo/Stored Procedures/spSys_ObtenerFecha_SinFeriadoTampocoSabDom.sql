
CREATE PROCEDURE [dbo].[spSys_ObtenerFecha_SinFeriadoTampocoSabDom]
 @FechaInicial datetime ,
 @Dias int 
AS
BEGIN
	select top (@Dias) *,Cast(SUBSTRING( CAST(IdMes as varchar(10)),LEN(IdMes)-1,LEN(IdMes)) as int)as Mes 
	from tb_Calendario where AnioFiscal = 2013 
	and Inicial_del_Dia not in ('Sa','Do') and EsFeriado <> 'S'
	and fecha >= @FechaInicial

END