/*

scrip de tabla calendario 

CREATE TABLE [dbo].[tb_Calendario](
	[IdCalendario] [int] NOT NULL,
	[fecha] [date] NOT NULL,
	[NombreFecha] [varchar](30) NOT NULL,
	[NombreCortoFecha] [varchar](10) NOT NULL,
	[dia_x_semana] [int] NULL,
	[dia_x_mes] [int] NULL,
	[Inicial_del_Dia] [char](2) NULL,
	[NombreDia] [varchar](20) NULL,
	[Mes_x_anio] [int] NULL,
	[NombreMes] [varchar](30) NULL,
	[IdMes] [int] NULL,
	[NombreCortoMes] [varchar](15) NULL,
	[AnioFiscal] [int] NULL,
	[Semana_x_anio] [int] NULL,
	[NombreSemana] [varchar](25) NULL,
	[IdSemana] [int] NULL,
	[Trimestre_x_Anio] [int] NULL,
	[NombreTrimestre] [varchar](20) NULL,
	[IdTrimestre] [int] NULL,
	[IdPeriodo] [varchar](20) NULL,
 CONSTRAINT [PK_tb_Calendario] PRIMARY KEY CLUSTERED 
(
	[IdCalendario] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

*/


------ exec spSys_Generar_Calendario '01/01/2000' ,'12/31/2020'

CREATE proc [dbo].[spSys_Generar_Calendario]
(
@fechaInicial as date,
@fechaFinal  as date
)
as
/*
declare @fechaInicial date
declare @fechaFinal date
set @fechaInicial ='01/01/2013'
set @fechaFinal ='12/30/2013'

*/

declare		@w_IdCalendario		as int
declare 	@w_fecha	as	date
declare 	@w_NombreFecha	as	varchar(30)
declare 	@w_NombreCorteFecha	as	varchar(10)
declare 	@w_dia_x_semana	as	int
declare 	@w_dia_x_mes	as	int
declare 	@w_Inicial_del_Dia	as	char(1)
declare 	@w_NombreDia	as	varchar(20)
declare 	@w_Mes_x_anio	as	int
declare 	@w_NombreMes	as	varchar(30)
declare 	@w_IdMes	as	int
declare 	@w_NombreCortoMes	as	varchar(15)
declare 	@w_AnioFiscal	as	int
declare 	@w_Semana_x_anio	as	int
declare 	@w_NombreSemana	as	varchar(25)
declare 	@w_IdSemana	as	int
declare 	@w_Trimenestre_x_Anio	as	int
declare 	@w_NombreTrimestre	as	varchar(20)
declare 	@w_IdTrimestre	as	int
declare 	@w_IdPeriodo	as	varchar(20)

delete tb_Calendario



declare @i_NumerodeDias float
declare @i_CountdeDias float

set @i_NumerodeDias =DATEDIFF(day,@fechaInicial,@fechaFinal)+1



set @i_CountdeDias =1
while (@i_CountdeDias <=@i_NumerodeDias )
begin
	--select @i_CountdeDias
	
	
	
set @w_IdCalendario	=((YEAR(@fechaInicial)*100)+MONTH(@fechaInicial))*100+DAY(@fechaInicial)
set @w_fecha=@fechaInicial
set @w_NombreFecha=''
set @w_NombreCorteFecha=''

set @w_dia_x_semana= DATEPART(WEEKDAY ,@fechaInicial)
set @w_dia_x_mes=DAY(@fechaInicial)
set @w_Inicial_del_Dia=''
set @w_NombreDia= DATENAME(WEEKDAY,@fechaInicial)
set @w_Mes_x_anio= DATEPART(MONTH ,@fechaInicial)
set @w_NombreMes= DATENAME(MONTH,@fechaInicial)
set @w_IdMes=(YEAR(@fechaInicial)*100)+MONTH(@fechaInicial)
set @w_NombreCortoMes=''
set @w_AnioFiscal=YEAR(@fechaInicial)
set @w_Semana_x_anio= DATEPART(WEEK ,@fechaInicial)
set @w_NombreSemana=''
set @w_IdSemana=(YEAR(@fechaInicial)*100)+ DATEPART(WEEK ,@fechaInicial)
set @w_Trimenestre_x_Anio = DATEPART(QUARTER ,@fechaInicial)
set @w_NombreTrimestre=''
set @w_IdTrimestre=(YEAR(@fechaInicial)*100)+ DATEPART(QUARTER ,@fechaInicial)
set @w_IdPeriodo=(YEAR(@fechaInicial)*100)+MONTH(@fechaInicial)

	

		INSERT INTO tb_Calendario
		([IdCalendario]		,[fecha]		,[NombreFecha]	,[NombreCortoFecha]	
		,[dia_x_semana]		,[dia_x_mes]
		,[Inicial_del_Dia]	,[NombreDia]	,[Mes_x_anio]	,[NombreMes]		,[IdMes]			,[NombreCortoMes]
		,[AnioFiscal]		,[Semana_x_anio],[NombreSemana]	,[IdSemana]			,Trimestre_x_Anio,[NombreTrimestre]
		,[IdTrimestre]		,[IdPeriodo]
		)
		values     
		(@w_IdCalendario		,@w_fecha			,@w_NombreFecha		,@w_NombreCorteFecha	
		,@w_dia_x_semana		,@w_dia_x_mes
		,@w_Inicial_del_Dia		,@w_NombreDia		,@w_Mes_x_anio		,@w_NombreMes			,@w_IdMes				,@w_NombreCortoMes
		,@w_AnioFiscal			,@w_Semana_x_anio	,@w_NombreSemana	,@w_IdSemana			,@w_Trimenestre_x_Anio	,@w_NombreTrimestre
		,@w_IdTrimestre			,@w_IdPeriodo
		)




set @i_CountdeDias =@i_CountdeDias +1
set @fechaInicial=DATEADD(day,1,@fechaInicial)
end 

----------- actualizando -----------



update tb_Calendario 
set Nombredia=B.sdia 
from tb_Calendario A ,tb_dia B
where rtrim(ltrim(A.Nombredia))=rtrim(ltrim(B.sdiaIngles))


update tb_Calendario 
set NombreMes=B.smes
from tb_Calendario A ,tb_mes B
where rtrim(ltrim(A.NombreMes))=rtrim(ltrim(B.smesIngles))



update tb_Calendario 
set inicial_del_dia=substring(Nombredia,1,2)



update tb_Calendario 
set nombreCortoFecha=cast(dia_x_mes as varchar(2))+ ' ' + substring(nombreMes,1,3) + ' ' + substring(CAST(aniofiscal as varchar(4)),3,2)
,nombreFecha=cast(dia_x_mes as varchar(2))+ ' de ' + nombreMes + ' del ' + CAST(aniofiscal as varchar(4))
,nombreCortoMes= substring(nombreMes,1,3) + ' ' + CAST(aniofiscal as varchar(4))
,nombreSemana= 'Sem#: '  + CAST(semana_x_anio as varchar(4))+ ' ' + CAST(aniofiscal as varchar(4))
,nombreTrimestre='Tri#: ' + CAST(Trimestre_x_Anio as varchar(4))+ ' ' + CAST(aniofiscal as varchar(4))


-- select * from tb_Calendario

--select * from tb_mes 