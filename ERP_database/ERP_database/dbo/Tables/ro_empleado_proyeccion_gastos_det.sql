CREATE TABLE [dbo].[ro_empleado_proyeccion_gastos_det] (
    [IdEmpresa]     INT           NOT NULL,
    [IdTransaccion] NUMERIC (18)  NOT NULL,
    [Secuencia]     INT           NOT NULL,
    [IdTipoGasto]   VARCHAR (10)  NOT NULL,
    [Valor]         FLOAT (53)    NOT NULL,
    [Observacion]   VARCHAR (500) NULL,
    CONSTRAINT [PK_ro_empleado_proyeccion_gastos_det_1] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdTransaccion] ASC, [Secuencia] ASC),
    CONSTRAINT [FK_ro_empleado_proyeccion_gastos_det_ro_empleado_proyeccion_gastos] FOREIGN KEY ([IdEmpresa], [IdTransaccion]) REFERENCES [dbo].[ro_empleado_proyeccion_gastos] ([IdEmpresa], [IdTransaccion])
);



