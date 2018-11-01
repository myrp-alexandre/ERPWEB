create view ro_Acta_Finiquito_Vacaciones_Decimos as 
select IdEmpresa,IdNominatipo,IdLiquidacion,IdEmpleado,Sec,Anio,Mes,Total_Remuneracion,Total_Vacaciones,Valor_Cancelar,DiasTrabajados,'Vacaciones no gozadas' as Observacion from ro_Acta_Finiquito_Detalle_x_vacaciones

union
select IdEmpresa,IdNominatipo,IdLiquidacion,IdEmpleado,Sec,Anio,Mes,Total_Remuneracion,decimo,0,DiasTrabajados ,'Decimo Tercer sueldo' as Observacion from ro_Acta_Finiquito_Detalle_x_decimos