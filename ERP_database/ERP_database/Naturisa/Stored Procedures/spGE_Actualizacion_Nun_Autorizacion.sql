CREATE procedure [Naturisa].[spGE_Actualizacion_Nun_Autorizacion] as
update fa_factura
set Fecha_Autorizacion=cbte_auto.FechaAutorizacion
,vt_autorizacion=cbte_auto.Numero_Autorizacion
from fa_factura fac,
(
		SELECT        IdEmpresa, IdComprobante, FechaAutorizacion, Numero_Autorizacion, EstadoDoc, IdTipoDocumento
		,SUBSTRING(IdComprobante,4,3) as IdEstablecimiento,SUBSTRING(IdComprobante,8,3) as IdPtoEmision
		,cast(SUBSTRING(rtrim(ltrim(right(IdComprobante,10))),charindex('-', rtrim(ltrim(right(IdComprobante,10))))+1,10) as numeric)
		as NumCbte
		FROM   DBFacturacion_Electronica.dbo.tb_Comprobante AS cbte
		WHERE        (IdTipoDocumento = '01')
		and RTRIM(LTRIM(cbte.EstadoDoc))='AUTORIZADO'
) as cbte_auto
where fac.IdEmpresa=cbte_auto.IdEmpresa
and fac.vt_serie1=cbte_auto.IdEstablecimiento
and fac.vt_serie2=cbte_auto.IdPtoEmision
and cast(fac.vt_NumFactura as numeric) =cbte_auto.NumCbte
and fac.vt_autorizacion is null


update cp_retencion
set NAutorizacion=cbte_x_ret.Numero_Autorizacion
,Fecha_Autorizacion=cbte_x_ret.FechaAutorizacion
from cp_retencion Ret,
(
		SELECT        IdEmpresa, IdComprobante, FechaAutorizacion, Numero_Autorizacion, EstadoDoc, IdTipoDocumento
		,SUBSTRING(IdComprobante,4,3) as IdEstablecimiento,SUBSTRING(IdComprobante,8,3) as IdPtoEmision
		,cast(SUBSTRING(rtrim(ltrim(right(IdComprobante,10))),charindex('-', rtrim(ltrim(right(IdComprobante,10))))+1,10) as numeric)
		as NumCbte
		FROM   DBFacturacion_Electronica.dbo.tb_Comprobante AS cbte
		WHERE        (IdTipoDocumento = '07')
		and RTRIM(LTRIM(cbte.EstadoDoc))='AUTORIZADO'
) as cbte_x_ret
where Ret.IdEmpresa=cbte_x_ret.IdEmpresa
and Ret.serie1=cbte_x_ret.IdEstablecimiento
and Ret.serie2=cbte_x_ret.IdPtoEmision
and cast(Ret.NumRetencion as numeric) =cbte_x_ret.NumCbte
and Ret.NAutorizacion is null




update fa_notaCreDeb
set Fecha_Autorizacion=cbte_auto.FechaAutorizacion
,NumAutorizacion=cbte_auto.Numero_Autorizacion
from fa_notaCreDeb fac,
(
		SELECT        IdEmpresa, IdComprobante, FechaAutorizacion, Numero_Autorizacion, EstadoDoc, IdTipoDocumento
		,SUBSTRING(IdComprobante,4,3) as IdEstablecimiento,SUBSTRING(IdComprobante,8,3) as IdPtoEmision
		,cast(SUBSTRING(rtrim(ltrim(right(IdComprobante,10))),charindex('-', rtrim(ltrim(right(IdComprobante,10))))+1,10) as numeric)
		as NumCbte
		FROM   DBFacturacion_Electronica.dbo.tb_Comprobante AS cbte
		WHERE        (IdTipoDocumento = '04') --NC
		and RTRIM(LTRIM(cbte.EstadoDoc))='AUTORIZADO'
) as cbte_auto
where fac.IdEmpresa=cbte_auto.IdEmpresa
and fac.Serie1=cbte_auto.IdEstablecimiento
and fac.Serie2=cbte_auto.IdPtoEmision
and cast(fac.NumNota_Impresa as numeric) =cbte_auto.NumCbte
and fac.CreDeb='C'
and fac.Fecha_Autorizacion is null




update fa_notaCreDeb
set Fecha_Autorizacion=cbte_auto.FechaAutorizacion
,NumAutorizacion=cbte_auto.Numero_Autorizacion
from fa_notaCreDeb fac,
(
		SELECT        IdEmpresa, IdComprobante, FechaAutorizacion, Numero_Autorizacion, EstadoDoc, IdTipoDocumento
		,SUBSTRING(IdComprobante,4,3) as IdEstablecimiento,SUBSTRING(IdComprobante,8,3) as IdPtoEmision
		,cast(SUBSTRING(rtrim(ltrim(right(IdComprobante,10))),charindex('-', rtrim(ltrim(right(IdComprobante,10))))+1,10) as numeric)
		as NumCbte
		FROM   DBFacturacion_Electronica.dbo.tb_Comprobante AS cbte
		WHERE        (IdTipoDocumento = '05') --ND
		and RTRIM(LTRIM(cbte.EstadoDoc))='AUTORIZADO'
) as cbte_auto
where fac.IdEmpresa=cbte_auto.IdEmpresa
and fac.Serie1=cbte_auto.IdEstablecimiento
and fac.Serie2=cbte_auto.IdPtoEmision
and cast(fac.NumNota_Impresa as numeric) =cbte_auto.NumCbte
and fac.CreDeb='D'
and fac.Fecha_Autorizacion is null