CREATE TABLE [dbo].[ro_empleado_x_ro_tipoNomina] (
    [IdEmpresa]    INT          NOT NULL,
    [IdEmpleado]   NUMERIC (18) NOT NULL,
    [IdTipoNomina] INT          NOT NULL,
    [observacion]  VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_ro_empleado_x_ro_tipoNomina] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdEmpleado] ASC, [IdTipoNomina] ASC),
    CONSTRAINT [FK_ro_empleado_x_ro_tipoNomina_ro_empleado] FOREIGN KEY ([IdEmpresa], [IdEmpleado]) REFERENCES [dbo].[ro_empleado] ([IdEmpresa], [IdEmpleado]),
    CONSTRAINT [FK_ro_empleado_x_ro_tipoNomina_ro_Nomina_Tipo] FOREIGN KEY ([IdEmpresa], [IdTipoNomina]) REFERENCES [dbo].[ro_Nomina_Tipo] ([IdEmpresa], [IdNomina_Tipo])
);

