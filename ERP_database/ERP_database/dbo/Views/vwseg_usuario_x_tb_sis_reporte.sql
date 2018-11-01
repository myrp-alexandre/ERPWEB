CREATE view vwseg_usuario_x_tb_sis_reporte as

SELECT        seg_usuario_x_tb_sis_reporte.IdUsuario, tb_sis_reporte.CodReporte, tb_sis_reporte.Nombre, tb_sis_reporte.NombreCorto, tb_sis_reporte.Modulo, tb_sis_reporte.VistaRpt, tb_sis_reporte.Formulario, 
                         tb_sis_reporte.Class_NomReporte, tb_sis_reporte.nom_Asembly, tb_sis_reporte.Orden,CAST(tb_sis_reporte.Observacion  as varchar(500)) as Observacion, 
						  tb_sis_reporte.VersionActual, tb_sis_reporte.Tipo_Balance, 
                         tb_sis_reporte.SQuery, tb_sis_reporte.Class_Info, tb_sis_reporte.Class_Bus, tb_sis_reporte.Class_Data, tb_sis_reporte.IdGrupo_Reporte, tb_sis_reporte.se_Muestra_Admin_Reporte, tb_sis_reporte.Estado, 
                         tb_sis_reporte.Store_proce_rpt, tb_sis_reporte.Disenio_reporte,CAST(1 as bit) esta_en_base
FROM            seg_usuario_x_tb_sis_reporte INNER JOIN
                         tb_sis_reporte ON seg_usuario_x_tb_sis_reporte.CodReporte = tb_sis_reporte.CodReporte

union

SELECT        seg_usuario.IdUsuario, tb_sis_reporte.CodReporte, tb_sis_reporte.Nombre, tb_sis_reporte.NombreCorto, tb_sis_reporte.Modulo, tb_sis_reporte.VistaRpt, tb_sis_reporte.Formulario, 
                         tb_sis_reporte.Class_NomReporte, tb_sis_reporte.nom_Asembly, tb_sis_reporte.Orden,cast( tb_sis_reporte.Observacion as varchar(500)), 
						  tb_sis_reporte.VersionActual, tb_sis_reporte.Tipo_Balance, 
                         tb_sis_reporte.SQuery, tb_sis_reporte.Class_Info, tb_sis_reporte.Class_Bus, tb_sis_reporte.Class_Data, tb_sis_reporte.IdGrupo_Reporte, tb_sis_reporte.se_Muestra_Admin_Reporte, tb_sis_reporte.Estado, 
                         tb_sis_reporte.Store_proce_rpt, tb_sis_reporte.Disenio_reporte,CAST(0 as bit) esta_en_base
FROM            tb_sis_reporte CROSS JOIN
                         seg_usuario
where not exists
(
	select * 
	from seg_usuario_x_tb_sis_reporte		A
	where A.IdUsuario=seg_usuario.IdUsuario
	and A.CodReporte=tb_sis_reporte.CodReporte
)