


create view [dbo].[vwcxc_EstadoCobro_Actual]
as
select A.IdEmpresa,A.IdSucursal,A.IdCobro,A.IdEstadoCobro,A.Secuencia,A.observacion,A.Fecha
from cxc_cobro_x_EstadoCobro A
where  cast(A.IdEmpresa as varchar(20)) + CAST(A.IdSucursal as varchar(20)) + CAST(A.IdCobro as varchar(20)) +  CAST(A.Secuencia  as varchar(20))
in (
	SELECT      cast(IdEmpresa as varchar(20)) + CAST(IdSucursal as varchar(20)) + CAST(IdCobro as varchar(20)) +  CAST(MAX(Secuencia) as varchar(20))
	FROM         cxc_cobro_x_EstadoCobro
	GROUP BY IdEmpresa, IdSucursal, IdCobro
	)