CREATE TABLE [web].[ro_SPROL_022] (
    [IdEmpresa]         INT           NOT NULL,
    [IdEmpleado]        NUMERIC (18)  NOT NULL,
    [IdRubro]           VARCHAR (10)  NOT NULL,
    [IdPeriodo]         INT           NOT NULL,
    [IdNominaTipo]      INT           NOT NULL,
    [IdNominaTipoLiqui] INT           NOT NULL,
    [Valor]             FLOAT (53)    NOT NULL,
    [IdSucursal]        INT           NOT NULL,
    [IdArea]            INT           NOT NULL,
    [ru_descripcion]    VARCHAR (MAX) NULL,
    CONSTRAINT [PK_ro_SPROL_022_1] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdEmpleado] ASC, [IdRubro] ASC)
);

