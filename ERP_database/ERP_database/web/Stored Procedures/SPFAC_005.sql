--exec WEB.SPFAC_005 1,1,99999,1,99999,'2018/08/01','2018/08/31',0,0
CREATE  PROCEDURE [web].[SPFAC_005]
(
@IdEmpresa int,
@IdSucursal_ini int,
@IdSucursal_fin int,
@IdCliente_ini numeric,
@IdCliente_fin numeric,
@Fecha_ini datetime,
@fecha_fin datetime,
@MostrarSaldo0 bit,
@MostrarContactos bit
)
AS

SELECT        IdEmpresa, IdSucursal, IdCliente, IdContacto, NomCliente, NomContacto, TipoDocumento, EsExportacion, Su_Descripcion, Su_CodigoEstablecimiento,
SUM(SubtotalIVA0) SubtotalIVA0, SUM(SubtotalIVA) SubtotalIVA, SUM(vt_iva) vt_iva, SUM(Total) Total, SUM(VRetenIVA) VRetenIVA, 
SUM(VRetenFTE)VRetenFTE, SUM(ValorACobrar) ValorACobrar, ISNULL(sum(VCobrado),0) AS VCobrado, ISNULL(round(sum(Saldo),2),0) AS Saldo, isnull(COUNT(IdEmpresa),0) AS CantFactContacto
FROM            web.VWFAC_005
where IdEmpresa = @IdEmpresa and IdSucursal between @IdSucursal_ini and @IdSucursal_fin and IdCliente between @IdCliente_ini and @IdCliente_fin and vt_fecha between @Fecha_ini and @fecha_fin
AND @MostrarSaldo0 = 1 and @MostrarContactos = 1
GROUP BY IdEmpresa, IdSucursal, IdCliente, IdContacto, NomCliente, NomContacto, TipoDocumento, EsExportacion, Su_Descripcion, Su_CodigoEstablecimiento

UNION ALL

SELECT        IdEmpresa, IdSucursal, IdCliente, IdContacto, NomCliente, NomContacto, TipoDocumento, EsExportacion, Su_Descripcion, Su_CodigoEstablecimiento,
SUM(SubtotalIVA0) SubtotalIVA0, SUM(SubtotalIVA) SubtotalIVA, SUM(vt_iva) vt_iva, SUM(Total) Total, SUM(VRetenIVA) VRetenIVA, 
SUM(VRetenFTE)VRetenFTE, SUM(ValorACobrar) ValorACobrar, ISNULL(sum(VCobrado),0) AS VCobrado, ISNULL(round(sum(Saldo),2),0) AS Saldo, isnull(COUNT(IdEmpresa),0) AS CantFactContacto
FROM            web.VWFAC_005
where IdEmpresa = @IdEmpresa and IdSucursal between @IdSucursal_ini and @IdSucursal_fin and IdCliente between @IdCliente_ini and @IdCliente_fin and vt_fecha between @Fecha_ini and @fecha_fin
AND round(Saldo,2) > 0
AND @MostrarSaldo0 = 0 and @MostrarContactos = 1
GROUP BY IdEmpresa, IdSucursal, IdCliente, IdContacto, NomCliente, NomContacto, TipoDocumento, EsExportacion, Su_Descripcion, Su_CodigoEstablecimiento

UNION ALL

SELECT        IdEmpresa, IdSucursal, IdCliente, 0, NomCliente, '', TipoDocumento, EsExportacion, Su_Descripcion, Su_CodigoEstablecimiento,
SUM(SubtotalIVA0) SubtotalIVA0, SUM(SubtotalIVA) SubtotalIVA, SUM(vt_iva) vt_iva, SUM(Total) Total, SUM(VRetenIVA) VRetenIVA, 
SUM(VRetenFTE)VRetenFTE, SUM(ValorACobrar) ValorACobrar, ISNULL(sum(VCobrado),0) AS VCobrado, ISNULL(round(sum(Saldo),2),0) AS Saldo, isnull(COUNT(IdEmpresa),0) AS CantFactContacto
FROM            web.VWFAC_005
where IdEmpresa = @IdEmpresa and IdSucursal between @IdSucursal_ini and @IdSucursal_fin and IdCliente between @IdCliente_ini and @IdCliente_fin and vt_fecha between @Fecha_ini and @fecha_fin
AND @MostrarSaldo0 = 1 and @MostrarContactos = 0
GROUP BY IdEmpresa, IdSucursal, IdCliente, NomCliente, TipoDocumento, EsExportacion, Su_Descripcion, Su_CodigoEstablecimiento

UNION ALL

SELECT        IdEmpresa, IdSucursal, IdCliente, 0, NomCliente, '', TipoDocumento, EsExportacion, Su_Descripcion, Su_CodigoEstablecimiento,
SUM(SubtotalIVA0) SubtotalIVA0, SUM(SubtotalIVA) SubtotalIVA, SUM(vt_iva) vt_iva, SUM(Total) Total, SUM(VRetenIVA) VRetenIVA, 
SUM(VRetenFTE)VRetenFTE, SUM(ValorACobrar) ValorACobrar, ISNULL(sum(VCobrado),0) AS VCobrado, ISNULL(round(sum(Saldo),2),0) AS Saldo, isnull(COUNT(IdEmpresa),0) AS CantFactContacto
FROM            web.VWFAC_005
where IdEmpresa = @IdEmpresa and IdSucursal between @IdSucursal_ini and @IdSucursal_fin and IdCliente between @IdCliente_ini and @IdCliente_fin and vt_fecha between @Fecha_ini and @fecha_fin
AND round(Saldo,2) > 0
AND @MostrarSaldo0 = 0 and @MostrarContactos = 0
GROUP BY IdEmpresa, IdSucursal, IdCliente,  NomCliente,  TipoDocumento, EsExportacion, Su_Descripcion, Su_CodigoEstablecimiento