CREATE TABLE [dbo].[ro_empleado_x_CuentaContable] (
    [IdEmpresa]   INT           NOT NULL,
    [IdEmpleado]  NUMERIC (18)  NOT NULL,
    [Secuencia]   INT           NOT NULL,
    [IdRubro]     VARCHAR (50)  NOT NULL,
    [IdCuentacon] VARCHAR (20)  NOT NULL,
    [Observacion] VARCHAR (MAX) NULL,
    CONSTRAINT [PK_ro_empleado_x_CuentaContable] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdEmpleado] ASC, [Secuencia] ASC),
    CONSTRAINT [FK_ro_empleado_x_CuentaContable_ct_plancta] FOREIGN KEY ([IdEmpresa], [IdCuentacon]) REFERENCES [dbo].[ct_plancta] ([IdEmpresa], [IdCtaCble]),
    CONSTRAINT [FK_ro_empleado_x_CuentaContable_ro_rubro_tipo] FOREIGN KEY ([IdEmpresa], [IdRubro]) REFERENCES [dbo].[ro_rubro_tipo] ([IdEmpresa], [IdRubro])
);

