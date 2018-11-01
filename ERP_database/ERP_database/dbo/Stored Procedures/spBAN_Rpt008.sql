
CREATE PROCEDURE [dbo].[spBAN_Rpt008]
	@IdEmpresa as int,	
	@fecha_Ini as datetime,
	@fecha_Fin as datetime
	 
AS
BEGIN


select * from (

                         select A.IdEmpresa,
  null idTipoFlujo  ,
  null descripcion_flujo , 
   A.ba_descripcion,
  A.ba_Num_Cuenta,
  'SALDO INCIAL' as Des_tipo_cbte,
  ABS(sum(A.dc_Valor)) dc_Valor, 
  0 AS Orden,1 as id_Des_tipo_cbte
                        from
                        (
                        SELECT        ct_cbtecble.IdEmpresa, ba_Banco_Cuenta.ba_descripcion,ba_Banco_Cuenta.ba_Num_Cuenta, ct_cbtecble_det.IdCtaCble, ct_cbtecble_det.dc_Valor
                        FROM            ct_cbtecble INNER JOIN
                                                                         ct_cbtecble_det ON ct_cbtecble.IdEmpresa = ct_cbtecble_det.IdEmpresa AND ct_cbtecble.IdTipoCbte = ct_cbtecble_det.IdTipoCbte AND 
                                                                         ct_cbtecble.IdCbteCble = ct_cbtecble_det.IdCbteCble INNER JOIN
                                                                         ba_Banco_Cuenta ON ct_cbtecble_det.IdEmpresa = ba_Banco_Cuenta.IdEmpresa AND ct_cbtecble_det.IdCtaCble = ba_Banco_Cuenta.IdCtaCble
                        where ct_cbtecble.cb_Fecha < @fecha_Ini
                        and ct_cbtecble.IdEmpresa=@IdEmpresa
						-- carlos cedeño
						and      (NOT EXISTS
                             (SELECT        R.IdEmpresa
                               FROM            ct_cbtecble_Reversado AS R
                               WHERE        R.IdEmpresa = ct_cbtecble_det.IdEmpresa AND R.IdTipoCbte = ct_cbtecble_det.IdTipoCbte AND r.IdCbteCble = ct_cbtecble_det.IdCbteCble)) AND 
                                 ct_cbtecble.cb_Observacion NOT LIKE '%**REVERS%' AND SUBSTRING(ct_cbtecble.cb_Observacion, 1, 2) != '**'


                        ) as A
                        group by A.IdEmpresa, A.ba_descripcion,A.ba_Num_Cuenta, A.IdCtaCble


                        UNION




						select A.IdEmpresa,A.IdTipoFlujo,A.Descricion,'' as ba_descripcion,'' as ba_Num_Cuenta,a.tipo,ABS(SUM(A.dc_Valor)) AS dc_Valor,
						 1 AS Orden ,a.id_tipo from
(
    SELECT       
	 ba_TipoFlujo.IdEmpresa, 
	ba_TipoFlujo.IdTipoFlujo,
	 ba_TipoFlujo.Descricion, 
     ct_cbtecble_det.dc_Valor, 
     tipo = case 
       when ct_cbtecble_det.dc_Valor>0 then 'INGRESOS'
       when ct_cbtecble_det.dc_Valor<0 then 'EGRESOS'
       end 
     ,
	 1 AS Orden,
	  id_tipo = case 
       when ct_cbtecble_det.dc_Valor>0 then 2
       when ct_cbtecble_det.dc_Valor<0 then 3
       end 
                        FROM            ba_Cbte_Ban_tipo_x_ct_CbteCble_tipo INNER JOIN
    ba_Cbte_Ban_tipo ON ba_Cbte_Ban_tipo_x_ct_CbteCble_tipo.CodTipoCbteBan = ba_Cbte_Ban_tipo.CodTipoCbteBan INNER JOIN
    ct_cbtecble INNER JOIN
    ct_cbtecble_det ON ct_cbtecble.IdEmpresa = ct_cbtecble_det.IdEmpresa AND ct_cbtecble.IdTipoCbte = ct_cbtecble_det.IdTipoCbte AND 
    ct_cbtecble.IdCbteCble = ct_cbtecble_det.IdCbteCble INNER JOIN
    ba_Banco_Cuenta ON ct_cbtecble_det.IdCtaCble = ba_Banco_Cuenta.IdCtaCble AND ct_cbtecble_det.IdEmpresa = ba_Banco_Cuenta.IdEmpresa ON 
    ba_Cbte_Ban_tipo_x_ct_CbteCble_tipo.IdEmpresa = ct_cbtecble.IdEmpresa AND 
    ba_Cbte_Ban_tipo_x_ct_CbteCble_tipo.IdTipoCbteCble = ct_cbtecble.IdTipoCbte INNER JOIN
    ba_Cbte_Ban ON ct_cbtecble.IdEmpresa = ba_Cbte_Ban.IdEmpresa AND ct_cbtecble.IdTipoCbte = ba_Cbte_Ban.IdTipocbte AND 
    ct_cbtecble.IdCbteCble = ba_Cbte_Ban.IdCbteCble AND ba_Banco_Cuenta.IdEmpresa = ba_Cbte_Ban.IdEmpresa AND 
     ba_Banco_Cuenta.IdBanco = ba_Cbte_Ban.IdBanco INNER JOIN
     ba_TipoFlujo ON ba_Cbte_Ban.IdEmpresa = ba_TipoFlujo.IdEmpresa 
	 AND ba_Cbte_Ban.IdTipoFlujo = ba_TipoFlujo.IdTipoFlujo

	   where ct_cbtecble.IdEmpresa=@IdEmpresa
       and ct_cbtecble.cb_Fecha between @fecha_Ini and @fecha_Fin

	   -- carlos cedeño
						and      (NOT EXISTS
                             (SELECT        R.IdEmpresa
                               FROM            ct_cbtecble_Reversado AS R
                               WHERE        R.IdEmpresa = ct_cbtecble_det.IdEmpresa AND R.IdTipoCbte = ct_cbtecble_det.IdTipoCbte AND r.IdCbteCble = ct_cbtecble_det.IdCbteCble)) AND 
                                 ct_cbtecble.cb_Observacion NOT LIKE '%**REVERS%' AND SUBSTRING(ct_cbtecble.cb_Observacion, 1, 2) != '**'

	 ) as A
	 group by A.IdEmpresa,A.IdTipoFlujo,A.Descricion,a.tipo,a.id_tipo 
             
                    

                        UNION 



						  select A.IdEmpresa,
  null idTipoFlujo  ,
  null descripcion_flujo , 
   A.ba_descripcion,
  A.ba_Num_Cuenta,
  'SALDO FINAL' as Des_tipo_cbte,
  ABS(sum(A.dc_Valor)) dc_Valor, 
  2 AS Orden,4 as id_Des_tipo_cbte
                        from
                        (
                        SELECT        ct_cbtecble.IdEmpresa, ba_Banco_Cuenta.ba_descripcion,ba_Banco_Cuenta.ba_Num_Cuenta, ct_cbtecble_det.IdCtaCble, ct_cbtecble_det.dc_Valor
                        FROM            ct_cbtecble INNER JOIN
                                                                         ct_cbtecble_det ON ct_cbtecble.IdEmpresa = ct_cbtecble_det.IdEmpresa AND ct_cbtecble.IdTipoCbte = ct_cbtecble_det.IdTipoCbte AND 
                                                                         ct_cbtecble.IdCbteCble = ct_cbtecble_det.IdCbteCble INNER JOIN
                                                                         ba_Banco_Cuenta ON ct_cbtecble_det.IdEmpresa = ba_Banco_Cuenta.IdEmpresa AND ct_cbtecble_det.IdCtaCble = ba_Banco_Cuenta.IdCtaCble
                       where ct_cbtecble.cb_Fecha <= @fecha_Fin
                        and ct_cbtecble.IdEmpresa=@IdEmpresa

						-- carlos cedeño
						and      (NOT EXISTS
                             (SELECT        R.IdEmpresa
                               FROM            ct_cbtecble_Reversado AS R
                               WHERE        R.IdEmpresa = ct_cbtecble_det.IdEmpresa AND R.IdTipoCbte = ct_cbtecble_det.IdTipoCbte AND r.IdCbteCble = ct_cbtecble_det.IdCbteCble)) AND 
                                 ct_cbtecble.cb_Observacion NOT LIKE '%**REVERS%' AND SUBSTRING(ct_cbtecble.cb_Observacion, 1, 2) != '**'

                        ) as A
                        group by A.IdEmpresa, A.ba_descripcion,A.ba_Num_Cuenta, A.IdCtaCble





) as A
order by A.Orden
end