CREATE TABLE [dbo].[cp_orden_pago_x_nomina] (
    [IdEmpresa]         INT           NOT NULL,
    [IdNominaTipo]      INT           NOT NULL,
    [IdNominaTipoLiqui] INT           NOT NULL,
    [IdPeriodo]         INT           NOT NULL,
    [IdEmpleado]        NUMERIC (18)  NOT NULL,
    [IdRubro]           VARCHAR (50)  NOT NULL,
    [IdEmpresa_op]      INT           NOT NULL,
    [IdOrdenPago]       NUMERIC (18)  NOT NULL,
    [Observacion]       VARCHAR (100) NULL,
    CONSTRAINT [PK_cp_orden_pago_x_nomina] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdNominaTipo] ASC, [IdNominaTipoLiqui] ASC, [IdPeriodo] ASC, [IdEmpleado] ASC, [IdRubro] ASC),
    CONSTRAINT [FK_cp_orden_pago_x_nomina_cp_orden_pago] FOREIGN KEY ([IdEmpresa], [IdOrdenPago]) REFERENCES [dbo].[cp_orden_pago] ([IdEmpresa], [IdOrdenPago]),
    CONSTRAINT [FK_cp_orden_pago_x_nomina_ro_rol_detalle] FOREIGN KEY ([IdEmpresa], [IdNominaTipo], [IdNominaTipoLiqui], [IdPeriodo], [IdEmpleado], [IdRubro]) REFERENCES [dbo].[ro_rol_detalle] ([IdEmpresa], [IdNominaTipo], [IdNominaTipoLiqui], [IdPeriodo], [IdEmpleado], [IdRubro])
);

