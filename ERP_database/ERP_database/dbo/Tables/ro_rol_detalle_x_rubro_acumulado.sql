CREATE TABLE [dbo].[ro_rol_detalle_x_rubro_acumulado] (
    [IdEmpresa]         INT          NOT NULL,
    [IdRol]             NUMERIC (18) NOT NULL,
    [IdEmpleado]        NUMERIC (18) NOT NULL,
    [IdRubro]           VARCHAR (50) NOT NULL,
    [IdNominaTipo]      INT          NOT NULL,
    [IdNominaTipoLiqui] INT          NOT NULL,
    [IdPeriodo]         INT          NOT NULL,
    [Valor]             FLOAT (53)   NOT NULL,
    [Estado]            VARCHAR (10) NULL,
    CONSTRAINT [PK_ro_rol_detalle_x_rubro_acumulado] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdRol] ASC, [IdEmpleado] ASC, [IdRubro] ASC),
    CONSTRAINT [FK_ro_rol_detalle_x_rubro_acumulado_ro_rol] FOREIGN KEY ([IdEmpresa], [IdRol]) REFERENCES [dbo].[ro_rol] ([IdEmpresa], [IdRol])
);



