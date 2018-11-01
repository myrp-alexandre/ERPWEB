create view vwRo_Archivos_Bancos_Generacion_total_archivo as 
SELECT        IdEmpresa, IdArchivo,sum( Valor) Valor
FROM            dbo.ro_archivos_bancos_generacion_x_empleado
group by   IdEmpresa, IdArchivo