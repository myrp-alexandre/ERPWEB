CREATE TABLE [dbo].[ro_rol_detalle] (
    [IdEmpresa]                      INT           NOT NULL,
    [IdNominaTipo]                   INT           NOT NULL,
    [IdNominaTipoLiqui]              INT           NOT NULL,
    [IdPeriodo]                      INT           NOT NULL,
    [IdEmpleado]                     NUMERIC (18)  NOT NULL,
    [IdRubro]                        VARCHAR (50)  NOT NULL,
    [Orden]                          INT           NOT NULL,
    [Valor]                          FLOAT (53)    NOT NULL,
    [rub_visible_reporte]            BIT           NULL,
    [Observacion]                    VARCHAR (255) NULL,
    [TipoMovimiento]                 VARCHAR (3)   NULL,
    [IdCentroCosto]                  VARCHAR (20)  NULL,
    [IdCentroCosto_sub_centro_costo] VARCHAR (20)  NULL,
    [IdPunto_cargo]                  INT           NULL,
    CONSTRAINT [PK_ro_rol_detalle] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdNominaTipo] ASC, [IdNominaTipoLiqui] ASC, [IdPeriodo] ASC, [IdEmpleado] ASC, [IdRubro] ASC),
    CONSTRAINT [FK_ro_rol_detalle_ro_empleado] FOREIGN KEY ([IdEmpresa], [IdEmpleado]) REFERENCES [dbo].[ro_empleado] ([IdEmpresa], [IdEmpleado]),
    CONSTRAINT [FK_ro_rol_detalle_ro_periodo_x_ro_Nomina_TipoLiqui] FOREIGN KEY ([IdEmpresa], [IdNominaTipo], [IdNominaTipoLiqui], [IdPeriodo]) REFERENCES [dbo].[ro_periodo_x_ro_Nomina_TipoLiqui] ([IdEmpresa], [IdNomina_Tipo], [IdNomina_TipoLiqui], [IdPeriodo]),
    CONSTRAINT [FK_ro_rol_detalle_ro_rol] FOREIGN KEY ([IdEmpresa], [IdNominaTipo], [IdNominaTipoLiqui], [IdPeriodo]) REFERENCES [dbo].[ro_rol] ([IdEmpresa], [IdNominaTipo], [IdNominaTipoLiqui], [IdPeriodo]),
    CONSTRAINT [FK_ro_rol_detalle_ro_rubro_tipo] FOREIGN KEY ([IdEmpresa], [IdRubro]) REFERENCES [dbo].[ro_rubro_tipo] ([IdEmpresa], [IdRubro])
);

