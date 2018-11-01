create view  Fj_servindustrias.vwfa_registro_unidades_x_equipo_det as 

SELECT        Fj_servindustrias.fa_registro_unidades_x_equipo_det.IdEmpresa, Fj_servindustrias.fa_registro_unidades_x_equipo_det.IdPeriodo, 
                         Fj_servindustrias.fa_registro_unidades_x_equipo_det.IdRegistro, Fj_servindustrias.fa_registro_unidades_x_equipo_det.IdFecha, 
                         Fj_servindustrias.fa_registro_unidades_x_equipo_det.IdActivoFijo, Fj_servindustrias.fa_registro_unidades_x_equipo_det.IdUnidad_Medida, 
                         Fj_servindustrias.fa_registro_unidades_x_equipo_det.IdTipo_Reg_cat, Fj_servindustrias.fa_registro_unidades_x_equipo_det.Valor, 
                         Fj_servindustrias.fa_registro_unidades_x_equipo_det.fecha_reg, Fj_servindustrias.fa_registro_unidades_x_equipo_det.fecha_modi, 
                         dbo.Af_Activo_fijo.CodActivoFijo
FROM            Fj_servindustrias.fa_registro_unidades_x_equipo_det INNER JOIN
                         dbo.Af_Activo_fijo ON Fj_servindustrias.fa_registro_unidades_x_equipo_det.IdEmpresa = dbo.Af_Activo_fijo.IdEmpresa AND 
                         Fj_servindustrias.fa_registro_unidades_x_equipo_det.IdActivoFijo = dbo.Af_Activo_fijo.IdActivoFijo