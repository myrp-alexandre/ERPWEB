CREATE TABLE [dbo].[ro_rol_detalle_x_rubro_acumulado] (
    [IdEmpresa]         INT          NOT NULL,
    [IdNominaTipo]      INT          NOT NULL,
    [IdNominaTipoLiqui] INT          NOT NULL,
    [IdPeriodo]         INT          NOT NULL,
    [IdEmpleado]        NUMERIC (18) NOT NULL,
    [IdRubro]           VARCHAR (50) NOT NULL,
    [Valor]             FLOAT (53)   NOT NULL,
    [Estado]            VARCHAR (10) NULL,
    CONSTRAINT [PK_ro_rol_detalle_x_rubro_acumulado] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdNominaTipo] ASC, [IdNominaTipoLiqui] ASC, [IdPeriodo] ASC, [IdEmpleado] ASC, [IdRubro] ASC)
);

