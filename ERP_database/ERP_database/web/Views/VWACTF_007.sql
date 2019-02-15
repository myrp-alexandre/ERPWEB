CREATE VIEW web.VWACTF_007
AS
SELECT Af_Activo_fijo.IdEmpresa, Af_Activo_fijo.IdActivoFijo, Af_Activo_fijo.Af_fecha_compra, Af_Activo_fijo.Af_costo_compra, Af_Activo_fijo.Estado, Af_Activo_fijo.Af_observacion, Af_Activo_fijo.Af_Nombre, tb_sucursal.Su_Descripcion, 
                  Af_Activo_fijo_tipo.Af_Descripcion AS NomTipo, Af_Activo_fijo_Categoria.Descripcion AS NomCategoria, Af_Departamento.Descripcion AS NomDepartamento, tb_persona.pe_nombreCompleto AS NomEncargado, 
                  tb_persona_1.pe_nombreCompleto AS NomCustodio
FROM     Af_Activo_fijo INNER JOIN
                  Af_Activo_fijo_Categoria ON Af_Activo_fijo.IdEmpresa = Af_Activo_fijo_Categoria.IdEmpresa AND Af_Activo_fijo.IdCategoriaAF = Af_Activo_fijo_Categoria.IdCategoriaAF INNER JOIN
                  Af_Activo_fijo_tipo ON Af_Activo_fijo_Categoria.IdEmpresa = Af_Activo_fijo_tipo.IdEmpresa AND Af_Activo_fijo_Categoria.IdActivoFijoTipo = Af_Activo_fijo_tipo.IdActivoFijoTipo INNER JOIN
                  Af_Departamento ON Af_Activo_fijo.IdEmpresa = Af_Departamento.IdEmpresa AND Af_Activo_fijo.IdDepartamento = Af_Departamento.IdDepartamento INNER JOIN
                  ro_empleado ON Af_Activo_fijo.IdEmpresa = ro_empleado.IdEmpresa AND Af_Activo_fijo.IdEmpresa = ro_empleado.IdEmpresa AND Af_Activo_fijo.IdEmpleadoEncargado = ro_empleado.IdEmpleado INNER JOIN
                  ro_empleado AS ro_empleado_1 ON Af_Activo_fijo.IdEmpresa = ro_empleado_1.IdEmpresa AND Af_Activo_fijo.IdEmpresa = ro_empleado_1.IdEmpresa AND Af_Activo_fijo.IdEmpleadoCustodio = ro_empleado_1.IdEmpleado INNER JOIN
                  tb_persona AS tb_persona_1 ON ro_empleado_1.IdPersona = tb_persona_1.IdPersona INNER JOIN
                  tb_persona ON ro_empleado.IdPersona = tb_persona.IdPersona INNER JOIN
                  tb_sucursal ON Af_Activo_fijo.IdEmpresa = tb_sucursal.IdEmpresa AND Af_Activo_fijo.IdSucursal = tb_sucursal.IdSucursal