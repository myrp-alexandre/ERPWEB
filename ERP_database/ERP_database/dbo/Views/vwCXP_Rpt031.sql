--select * from tb_sis_reporte where modulo='CXP'

create view vwCXP_Rpt031
AS
SELECT        cp_conciliacion_Caja.IdEmpresa, cp_conciliacion_Caja.IdConciliacion_Caja, cp_conciliacion_Caja.IdPeriodo, cp_conciliacion_Caja.Fecha, cp_conciliacion_Caja.IdCaja, cp_conciliacion_Caja.IdEstadoCierre, 
                         cp_catalogo.Nombre AS nom_estado_cierre, cp_conciliacion_Caja.Observacion, cp_conciliacion_Caja.IdEmpresa_op, cp_conciliacion_Caja.IdOrdenPago_op, cp_conciliacion_Caja.IdCtaCble, 
                         cp_conciliacion_Caja.Saldo_cont_al_periodo, cp_conciliacion_Caja.Ingresos, cp_conciliacion_Caja.Total_Ing, cp_conciliacion_Caja.Total_fact_vale, cp_conciliacion_Caja.Total_fondo, 
                         cp_conciliacion_Caja.Dif_x_pagar_o_cobrar, caj_Caja.ca_Descripcion
FROM            cp_conciliacion_Caja INNER JOIN
                         caj_Caja ON cp_conciliacion_Caja.IdEmpresa = caj_Caja.IdEmpresa AND cp_conciliacion_Caja.IdCaja = caj_Caja.IdCaja INNER JOIN
                         cp_catalogo ON cp_conciliacion_Caja.IdEstadoCierre = cp_catalogo.IdCatalogo