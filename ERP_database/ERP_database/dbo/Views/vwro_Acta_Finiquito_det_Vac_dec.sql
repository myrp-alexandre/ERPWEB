
create view vwro_Acta_Finiquito_det_Vac_dec as
select IdEmpresa,IdNominatipo,IdLiquidacion,IdEmpleado,Sec,Anio,Mes,Total_Remuneracion,Decimo,DiasTrabajados, 'Decimo cuarto no pagados' as ob from ro_Acta_Finiquito_Detalle_x_Decimos
union
select IdEmpresa,IdNominatipo,IdLiquidacion,IdEmpleado,Sec,Anio,Mes,Total_Remuneracion,Valor_Cancelar,DiasTrabajados, 'Vacaciones no gozadas' as ob from ro_Acta_Finiquito_Detalle_x_vacaciones