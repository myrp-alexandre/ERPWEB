
--EXEC [Fj_servindustrias].[spCONTA_FJ_Rpt001] 1,'01/05/2017','13/12/2017',103,103,1,6
CREATE PROCEDURE [Fj_servindustrias].[spCONTA_FJ_Rpt001]
(
@IdEmpresa int,
@Fecha_ini datetime,
@Fecha_fin datetime,
@IdPunto_cargo_ini int,
@IdPunto_cargo_fin int,
@Mostrar_saldo_0 bit,
@IdNivel int
)
AS

DECLARE @IdPeriodo int
SET @IdPeriodo = cast(cast(YEAR(@Fecha_fin) as varchar(4)) + right('00'+cast(month(@fecha_fin) as varchar(2)),2) as int)

DELETE [Fj_servindustrias].[ct_spCONTA_FJ_Rpt001]

BEGIN --INSERTO DATA
INSERT INTO [Fj_servindustrias].[ct_spCONTA_FJ_Rpt001]
           ([IdEmpresa]				           ,[IdCtaCble]				           ,[IdPunto_cargo]			           ,[pc_Cuenta]			           ,[nom_punto_cargo]			           ,[IdNivelCta]
           ,[IdGrupoCble]			           ,[gc_Orden]				           ,[IdCtaCblePadre]		           ,[gc_estado_financiero]         ,[pc_EsMovimiento]			           ,[gc_GrupoCble]
		   ,[bg_saldo_inicial]				   ,[bg_debitos_mes]		           ,[bg_creditos_mes]		           ,[bg_saldo_mes]			       ,[bg_saldo_final]					   ,[IdCtaCble_2]
		   ,[IdCtaCblePadre_2]				   ,[bg_saldo_inicial_mov]			   ,[bg_debitos_mes_mov]			   ,[bg_creditos_mes_mov]		   ,[bg_saldo_mes_mov]					   ,[bg_saldo_final_mov]) 

SELECT      cta.IdEmpresa					   ,CAST(cta.IdCtaCble	as numeric)	   ,pc.IdPunto_cargo				   ,cta.pc_Cuenta				   ,pc.nom_punto_cargo					    ,cta.IdNivelCta
		   ,cta.IdGrupoCble					   ,gru.gc_Orden					   ,cast(cta.IdCtaCblePadre as numeric),gru.gc_estado_financiero	   ,cta.pc_EsMovimiento						,gru.gc_GrupoCble
		   ,0								   ,0								   ,0								   ,0							   ,0										,cta.IdCtaCble
		   ,cta.IdCtaCblePadre				   ,0								   ,0								   ,0							   ,0									    ,0
FROM            ct_plancta AS cta INNER JOIN
ct_grupocble AS gru ON cta.IdGrupoCble = gru.IdGrupoCble INNER JOIN
Fj_servindustrias.vwct_punto_cargo_x_Af_Activo_fijo AS pc ON cta.IdEmpresa = pc.IdEmpresa
WHERE cta.IdEmpresa = @IdEmpresa and pc.IdPunto_cargo between @IdPunto_cargo_ini and @IdPunto_cargo_fin and gru.gc_estado_financiero = 'ER'
/*
DECLARE @IdCtaCble_utilidad varchar(20)
SELECT @IdCtaCble_utilidad = IdCtaCble FROM ct_anio_fiscal_x_cuenta_utilidad
WHERE IdEmpresa = @IdEmpresa and IdanioFiscal = YEAR(@Fecha_fin)
*/
INSERT INTO [Fj_servindustrias].[ct_spCONTA_FJ_Rpt001]
           ([IdEmpresa]				           ,[IdCtaCble]				           ,[IdPunto_cargo]			           ,[pc_Cuenta]			           ,[nom_punto_cargo]			           ,[IdNivelCta]
           ,[IdGrupoCble]			           ,[gc_Orden]				           ,[IdCtaCblePadre]		           ,[gc_estado_financiero]         ,[pc_EsMovimiento]			           ,[gc_GrupoCble]
		   ,[bg_saldo_inicial]				   ,[bg_debitos_mes]		           ,[bg_creditos_mes]		           ,[bg_saldo_mes]			       ,[bg_saldo_final]					   ,[IdCtaCble_2]
		   ,[IdCtaCblePadre_2]				   ,[bg_saldo_inicial_mov]			   ,[bg_debitos_mes_mov]			   ,[bg_creditos_mes_mov]		   ,[bg_saldo_mes_mov]					   ,[bg_saldo_final_mov]) 

SELECT		@IdEmpresa						   ,CAST('999999' AS numeric),IdPunto_cargo					   ,'UTILIDAD O PERDIDA DEL EJERCICIO',nom_punto_cargo,					   @IdNivel
			,'PATRI'						   ,@IdNivel						   ,NULL								,'PATRIMONIO'					,'S'									,'PATRI'
			,0								   ,0								   ,0								   ,0							   ,0										,999999
		   ,null				   ,0								   ,0								   ,0							   ,0									    ,0
FROM Fj_servindustrias.vwct_punto_cargo_x_Af_Activo_fijo
WHERE IdEmpresa = @IdEmpresa and IdPunto_cargo between @IdPunto_cargo_ini and @IdPunto_cargo_fin
END




BEGIN --ACTUALIZO SALDO INICIAL
UPDATE [Fj_servindustrias].[ct_spCONTA_FJ_Rpt001] SET bg_saldo_inicial = a.dc_Valor, bg_saldo_inicial_mov = a.dc_Valor
FROM(
SELECT dis.IdEmpresa, dis.IdCtaCble, dis.IdPunto_cargo, sum(dis.dc_Valor) dc_Valor
FROM(
SELECT        det.IdEmpresa, det.IdCtaCble, det.IdPunto_cargo, sum(det.dc_Valor) dc_Valor
FROM            ct_cbtecble AS cab INNER JOIN
            ct_cbtecble_det AS det ON cab.IdEmpresa = det.IdEmpresa AND cab.IdTipoCbte = det.IdTipoCbte AND cab.IdCbteCble = det.IdCbteCble
WHERE cab.IdEmpresa = @IdEmpresa and cab.cb_Fecha < @Fecha_ini and det.IdPunto_cargo between @IdPunto_cargo_ini and @IdPunto_cargo_fin
group by det.IdEmpresa, det.IdCtaCble, det.IdPunto_cargo

) dis group by dis.IdEmpresa, dis.IdCtaCble, dis.IdPunto_cargo
) A where [Fj_servindustrias].[ct_spCONTA_FJ_Rpt001].IdEmpresa = a.IdEmpresa
and [Fj_servindustrias].[ct_spCONTA_FJ_Rpt001].IdCtaCble_2 = a.IdCtaCble
and [Fj_servindustrias].[ct_spCONTA_FJ_Rpt001].IdPunto_cargo = a.IdPunto_cargo
END

BEGIN --ACTUALIZO DEBITOS 
UPDATE [Fj_servindustrias].[ct_spCONTA_FJ_Rpt001] SET bg_debitos_mes = a.dc_Valor, bg_debitos_mes_mov = a.dc_Valor
FROM(

SELECT dis.IdEmpresa, dis.IdCtaCble, dis.IdPunto_cargo, sum(dis.dc_Valor) dc_Valor
FROM(
SELECT        det.IdEmpresa, det.IdCtaCble, det.IdPunto_cargo, sum(det.dc_Valor) dc_Valor
FROM            ct_cbtecble AS cab INNER JOIN
            ct_cbtecble_det AS det ON cab.IdEmpresa = det.IdEmpresa AND cab.IdTipoCbte = det.IdTipoCbte AND cab.IdCbteCble = det.IdCbteCble
WHERE cab.IdEmpresa = @IdEmpresa and cab.cb_Fecha between @Fecha_ini and @Fecha_fin and det.IdPunto_cargo between @IdPunto_cargo_ini and @IdPunto_cargo_fin
and det.dc_Valor > 0
group by det.IdEmpresa, det.IdCtaCble, det.IdPunto_cargo


UNION

SELECT Fj_servindustrias.ct_distribucion_gastos_x_periodo.IdEmpresa,  Fj_servindustrias.ct_distribucion_gastos_x_periodo_det.IdCtaCble, 
                  Fj_servindustrias.ct_distribucion_gastos_x_periodo_det.IdPunto_cargo, SUM(Fj_servindustrias.ct_distribucion_gastos_x_periodo_det.valor) AS valor
FROM     Fj_servindustrias.ct_distribucion_gastos_x_periodo INNER JOIN
                  Fj_servindustrias.ct_distribucion_gastos_x_periodo_det ON Fj_servindustrias.ct_distribucion_gastos_x_periodo.IdEmpresa = Fj_servindustrias.ct_distribucion_gastos_x_periodo_det.IdEmpresa AND 
                  Fj_servindustrias.ct_distribucion_gastos_x_periodo.IdDistribucion = Fj_servindustrias.ct_distribucion_gastos_x_periodo_det.IdDistribucion
where Fj_servindustrias.ct_distribucion_gastos_x_periodo.IdEmpresa = @IdEmpresa and Fj_servindustrias.ct_distribucion_gastos_x_periodo.IdPeriodo = @IdPeriodo
and Fj_servindustrias.ct_distribucion_gastos_x_periodo_det.valor > 0
GROUP BY Fj_servindustrias.ct_distribucion_gastos_x_periodo.IdEmpresa, Fj_servindustrias.ct_distribucion_gastos_x_periodo.IdPeriodo, Fj_servindustrias.ct_distribucion_gastos_x_periodo_det.IdCtaCble, 
                  Fj_servindustrias.ct_distribucion_gastos_x_periodo_det.IdPunto_cargo
) dis group by dis.IdEmpresa, dis.IdCtaCble, dis.IdPunto_cargo

) A where [Fj_servindustrias].[ct_spCONTA_FJ_Rpt001].IdEmpresa = a.IdEmpresa
and [Fj_servindustrias].[ct_spCONTA_FJ_Rpt001].IdCtaCble_2 = a.IdCtaCble
and [Fj_servindustrias].[ct_spCONTA_FJ_Rpt001].IdPunto_cargo = a.IdPunto_cargo
END

BEGIN --ACTUALIZO CREDITOS
UPDATE [Fj_servindustrias].[ct_spCONTA_FJ_Rpt001] SET bg_creditos_mes = a.dc_Valor, bg_creditos_mes_mov = a.dc_Valor
FROM(
SELECT dis.IdEmpresa, dis.IdCtaCble, dis.IdPunto_cargo, sum(dis.dc_Valor) dc_Valor
FROM(

SELECT        det.IdEmpresa, det.IdCtaCble, det.IdPunto_cargo, sum(det.dc_Valor) dc_Valor
FROM            ct_cbtecble AS cab INNER JOIN
            ct_cbtecble_det AS det ON cab.IdEmpresa = det.IdEmpresa AND cab.IdTipoCbte = det.IdTipoCbte AND cab.IdCbteCble = det.IdCbteCble
WHERE cab.IdEmpresa = @IdEmpresa and cab.cb_Fecha between @Fecha_ini and @Fecha_fin and det.IdPunto_cargo between @IdPunto_cargo_ini and @IdPunto_cargo_fin
and det.dc_Valor < 0
group by det.IdEmpresa, det.IdCtaCble, det.IdPunto_cargo

UNION

SELECT Fj_servindustrias.ct_distribucion_gastos_x_periodo.IdEmpresa,  Fj_servindustrias.ct_distribucion_gastos_x_periodo_det.IdCtaCble, 
                  Fj_servindustrias.ct_distribucion_gastos_x_periodo_det.IdPunto_cargo, SUM(Fj_servindustrias.ct_distribucion_gastos_x_periodo_det.valor) AS valor
FROM     Fj_servindustrias.ct_distribucion_gastos_x_periodo INNER JOIN
                  Fj_servindustrias.ct_distribucion_gastos_x_periodo_det ON Fj_servindustrias.ct_distribucion_gastos_x_periodo.IdEmpresa = Fj_servindustrias.ct_distribucion_gastos_x_periodo_det.IdEmpresa AND 
                  Fj_servindustrias.ct_distribucion_gastos_x_periodo.IdDistribucion = Fj_servindustrias.ct_distribucion_gastos_x_periodo_det.IdDistribucion
where Fj_servindustrias.ct_distribucion_gastos_x_periodo.IdEmpresa = @IdEmpresa and Fj_servindustrias.ct_distribucion_gastos_x_periodo.IdPeriodo = @IdPeriodo
and Fj_servindustrias.ct_distribucion_gastos_x_periodo_det.valor < 0
GROUP BY Fj_servindustrias.ct_distribucion_gastos_x_periodo.IdEmpresa, Fj_servindustrias.ct_distribucion_gastos_x_periodo.IdPeriodo, Fj_servindustrias.ct_distribucion_gastos_x_periodo_det.IdCtaCble, 
                  Fj_servindustrias.ct_distribucion_gastos_x_periodo_det.IdPunto_cargo
) dis group by dis.IdEmpresa, dis.IdCtaCble, dis.IdPunto_cargo

) A where [Fj_servindustrias].[ct_spCONTA_FJ_Rpt001].IdEmpresa = a.IdEmpresa
and [Fj_servindustrias].[ct_spCONTA_FJ_Rpt001].IdCtaCble_2 = a.IdCtaCble
and [Fj_servindustrias].[ct_spCONTA_FJ_Rpt001].IdPunto_cargo = a.IdPunto_cargo
END

BEGIN --ACTUALIZO SALDO MES Y SALDO FINAL
UPDATE [Fj_servindustrias].[ct_spCONTA_FJ_Rpt001] SET bg_saldo_mes_mov = bg_debitos_mes + bg_creditos_mes, bg_saldo_final_mov = bg_saldo_inicial + bg_debitos_mes + bg_creditos_mes
END

BEGIN --ACTUALIZO VALOR PADRES

DECLARE @Contador int
set @Contador = @IdNivel
	WHILE @Contador > 0
	BEGIN

		UPDATE [Fj_servindustrias].[ct_spCONTA_FJ_Rpt001] 
		SET bg_saldo_inicial = a.bg_saldo_inicial, 
		bg_debitos_mes = A.bg_debitos_mes, 
		bg_creditos_mes = A.bg_creditos_mes
		FROM(
		SELECT        IdEmpresa, IdPunto_cargo, IdCtaCblePadre, sum(bg_saldo_inicial) bg_saldo_inicial, SUM(bg_debitos_mes) AS bg_debitos_mes, SUM(bg_creditos_mes) AS bg_creditos_mes
		FROM            Fj_servindustrias.ct_spCONTA_FJ_Rpt001
		GROUP BY IdEmpresa, IdPunto_cargo, IdCtaCblePadre
		) A where [Fj_servindustrias].[ct_spCONTA_FJ_Rpt001].IdEmpresa = a.IdEmpresa
		and [Fj_servindustrias].[ct_spCONTA_FJ_Rpt001].IdCtaCble = a.IdCtaCblePadre
		and [Fj_servindustrias].[ct_spCONTA_FJ_Rpt001].IdPunto_cargo = a.IdPunto_cargo

		SET @Contador = @Contador - 1
	END
END

BEGIN --ACTUALIZO SALDO MES Y SALDO FINAL
UPDATE [Fj_servindustrias].[ct_spCONTA_FJ_Rpt001] 
SET bg_saldo_mes = bg_debitos_mes + bg_creditos_mes, 
bg_saldo_final = bg_saldo_inicial + bg_debitos_mes + bg_creditos_mes
END

BEGIN --CALCULO UTILIDAD
UPDATE Fj_servindustrias.ct_spCONTA_FJ_Rpt001 
SET bg_saldo_inicial = A.bg_saldo_inicial_mov,
bg_saldo_inicial_mov = a.bg_saldo_inicial_mov,
bg_debitos_mes = a.bg_debitos_mes_mov,
bg_debitos_mes_mov = a.bg_debitos_mes_mov,
bg_creditos_mes = a.bg_creditos_mes_mov,
bg_creditos_mes_mov = a.bg_creditos_mes_mov,
bg_saldo_mes = a.bg_saldo_mes_mov,
bg_saldo_mes_mov = a.bg_saldo_mes_mov,
bg_saldo_final = a.bg_saldo_final_mov,
bg_saldo_final_mov = a.bg_saldo_final_mov
FROM(
select IdEmpresa,IdPunto_cargo, sum(bg_saldo_inicial_mov) bg_saldo_inicial_mov,
sum(bg_creditos_mes_mov) bg_creditos_mes_mov, 
sum(bg_debitos_mes_mov)bg_debitos_mes_mov, 
sum(bg_saldo_mes_mov) bg_saldo_mes_mov,
sum(bg_saldo_final_mov)bg_saldo_final_mov 
from Fj_servindustrias.ct_spCONTA_FJ_Rpt001
group by IdEmpresa,IdPunto_cargo
) A WHERE Fj_servindustrias.ct_spCONTA_FJ_Rpt001.IdEmpresa = A.IdEmpresa
AND Fj_servindustrias.ct_spCONTA_FJ_Rpt001.IdPunto_cargo = A.IdPunto_cargo
AND Fj_servindustrias.ct_spCONTA_FJ_Rpt001.IdCtaCble_2 = 999999
END

IF(@Mostrar_saldo_0 = 0)
BEGIN
	DELETE Fj_servindustrias.ct_spCONTA_FJ_Rpt001 WHERE bg_saldo_mes = 0
END

SELECT [IdEmpresa]      ,[IdCtaCble]      ,[IdPunto_cargo]      ,[pc_Cuenta]      ,[nom_punto_cargo]      ,[IdNivelCta]      ,[IdGrupoCble]      ,[gc_Orden]
      ,[IdCtaCblePadre]      ,[gc_estado_financiero]      ,[pc_EsMovimiento]      ,[gc_GrupoCble]      ,[bg_saldo_inicial]      ,[bg_debitos_mes]      ,[bg_creditos_mes]
      ,[bg_saldo_mes]      ,[bg_saldo_final]      ,[IdCtaCble_2]      ,[IdCtaCblePadre_2]      ,[bg_saldo_inicial_mov]      ,[bg_debitos_mes_mov]      ,[bg_creditos_mes_mov]
      ,[bg_saldo_mes_mov]      ,[bg_saldo_final_mov]
FROM [Fj_servindustrias].[ct_spCONTA_FJ_Rpt001]
ORDER BY IdEmpresa, IdPunto_cargo, IdCtaCble_2