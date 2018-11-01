
create PROCEDURE [dbo].[spROL_Rpt020]
    @idempresa int,
        @idnomina_tipo int,
        @idRubro_25 int,
        @idRubro_50 int,
        @idRubro_100 int,
    @fecha_inicio date,
        @fecha_fin date
        
AS
BEGIN
      delete ro_HorasExtras_X_Rubros_TMP
        
 insert into  ro_HorasExtras_X_Rubros_TMP (IdEmpresa,IdNomina,IdDepartamento,IdEmpleado,Num_horas25,Valor_hora_25,Num_horas50,Valor_hora_50,Num_horas100,Valor_hora_100,Nomina,Nombre,Cedula,Departamento)
 select N.IdEmpresa,N.IdNomina_Tipo,D.IdDepartamento,N.IdEmpleado,0,0,0,0,0,0,N.descripcion_tiponomina,N.pe_apellido+' '+N.pe_nombre,N.pe_cedulaRuc,D.de_descripcion
 from  vwro_Empleado_Novedades as N, ro_Departamento as D, ro_empleado as E
 where N.FechaPago between  @fecha_inicio and @fecha_fin
 and N.IdEmpresa=E.IdEmpresa
 and N.IdEmpleado=E.IdEmpleado
 and D.IdDepartamento=E.IdDepartamento
 and N.IdRubro in (@idRubro_25,@idRubro_50,@idRubro_100)
 group by N.IdEmpresa,N.IdNomina_Tipo,D.IdDepartamento,N.IdEmpleado,N.descripcion_tiponomina,N.pe_apellido+' '+N.pe_nombre,N.pe_cedulaRuc,D.de_descripcion
 -- horas al 25%
 update ro_HorasExtras_X_Rubros_TMP set Num_horas25=(select cast( SUM(Num_Horas) as numeric(8,2)) from vwro_Empleado_Novedades as Nov
 where Nov.FechaPago between  @fecha_inicio and @fecha_fin
 and Nov.IdEmpresa=@idempresa
 and Nov.IdEmpleado=ro_HorasExtras_X_Rubros_TMP.IdEmpleado
 and Nov.IdRubro=@idRubro_25

 group by Nov.IdEmpleado)
 update ro_HorasExtras_X_Rubros_TMP set Valor_hora_25=(select cast(SUM(Valor) as numeric(8,2))  from vwro_Empleado_Novedades as Nov
  where Nov.FechaPago between  @fecha_inicio and @fecha_fin
  and Nov.IdEmpresa=@idempresa
  and Nov.IdEmpleado=ro_HorasExtras_X_Rubros_TMP.IdEmpleado
  and Nov.IdRubro=@idRubro_25
  group by Nov.IdEmpleado)


  -- horas al 50%
 update ro_HorasExtras_X_Rubros_TMP set Num_horas50=(select cast (SUM(Num_Horas) as numeric(8,2))  from vwro_Empleado_Novedades as Nov
 where Nov.FechaPago between  @fecha_inicio and @fecha_fin
 and Nov.IdEmpresa=@idempresa
 and Nov.IdEmpleado=ro_HorasExtras_X_Rubros_TMP.IdEmpleado
 and Nov.IdRubro=@idRubro_50
 group by Nov.IdEmpleado)

 update ro_HorasExtras_X_Rubros_TMP set Valor_hora_50=(select cast( SUM(Valor) as numeric(8,2))  from vwro_Empleado_Novedades as Nov
 where Nov.FechaPago between  @fecha_inicio and @fecha_fin
 and Nov.IdEmpresa=@idempresa
 and Nov.IdEmpleado=ro_HorasExtras_X_Rubros_TMP.IdEmpleado
 and Nov.IdRubro=@idRubro_50
 group by Nov.IdEmpleado)


 -- horas al 100%
 update ro_HorasExtras_X_Rubros_TMP set Num_horas100=(select CAST( SUM(Num_Horas) as numeric (8,2))  from vwro_Empleado_Novedades as Nov
 where Nov.FechaPago between  @fecha_inicio and @fecha_fin
 and Nov.IdEmpresa=@idempresa
 and Nov.IdEmpleado=ro_HorasExtras_X_Rubros_TMP.IdEmpleado
 and Nov.IdRubro=@idRubro_100
 group by Nov.IdEmpleado)

 update ro_HorasExtras_X_Rubros_TMP set Valor_hora_100=(select cast ( SUM(Valor) as numeric(8,2))  from vwro_Empleado_Novedades as Nov
  where Nov.FechaPago between  @fecha_inicio and @fecha_fin
  and Nov.IdEmpresa=@idempresa
  and Nov.IdEmpleado=ro_HorasExtras_X_Rubros_TMP.IdEmpleado
  and Nov.IdRubro=@idRubro_100
  group by Nov.IdEmpleado)



 select IdEmpresa,IdNomina,IdDepartamento,IdEmpleado,Num_horas25,Valor_hora_25,Num_horas50,Valor_hora_50,Num_horas100,Valor_hora_100,Nomina,Nombre,Cedula,Departamento from ro_HorasExtras_X_Rubros_TMP

END