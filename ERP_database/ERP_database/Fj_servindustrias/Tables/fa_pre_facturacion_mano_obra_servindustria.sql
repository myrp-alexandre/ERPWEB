CREATE TABLE [Fj_servindustrias].[fa_pre_facturacion_mano_obra_servindustria] (
    [IdEmpresa]                      INT          NOT NULL,
    [IdPrefacturacion]               NUMERIC (18) NOT NULL,
    [Secuencia]                      INT          NOT NULL,
    [IdActivoFijo]                   INT          NULL,
    [IdEmpleado]                     NUMERIC (18) NULL,
    [IdCargo]                        INT          NULL,
    [IdCentroCosto]                  VARCHAR (20) NULL,
    [IdCentroCosto_sub_centro_costo] VARCHAR (20) NULL,
    [IdPeriodo]                      INT          NOT NULL,
    [Salario]                        FLOAT (53)   NOT NULL,
    [HorasExtras]                    FLOAT (53)   NOT NULL,
    [Alimentacion]                   FLOAT (53)   NOT NULL,
    [TotalIngresos]                  FLOAT (53)   NOT NULL,
    [Total_mas_Beneficios]           FLOAT (53)   NOT NULL,
    [TotalManoObra]                  FLOAT (53)   NOT NULL,
    CONSTRAINT [PK_fa_pre_facturacion_mano_obra_servindustria_1] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdPrefacturacion] ASC, [Secuencia] ASC),
    CONSTRAINT [FK_fa_pre_facturacion_mano_obra_servindustria_Af_Activo_fijo] FOREIGN KEY ([IdEmpresa], [IdActivoFijo]) REFERENCES [dbo].[Af_Activo_fijo] ([IdEmpresa], [IdActivoFijo]),
    CONSTRAINT [FK_fa_pre_facturacion_mano_obra_servindustria_fa_pre_facturacion] FOREIGN KEY ([IdEmpresa], [IdPrefacturacion]) REFERENCES [Fj_servindustrias].[fa_pre_facturacion] ([IdEmpresa], [IdPreFacturacion]),
    CONSTRAINT [FK_fa_pre_facturacion_mano_obra_servindustria_ro_cargo] FOREIGN KEY ([IdEmpresa], [IdCargo]) REFERENCES [dbo].[ro_cargo] ([IdEmpresa], [IdCargo]),
    CONSTRAINT [FK_fa_pre_facturacion_mano_obra_servindustria_ro_empleado] FOREIGN KEY ([IdEmpresa], [IdEmpleado]) REFERENCES [dbo].[ro_empleado] ([IdEmpresa], [IdEmpleado])
);

