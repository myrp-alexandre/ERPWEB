CREATE TABLE [Fj_servindustrias].[fa_pre_facturacion] (
    [IdEmpresa]        INT          NOT NULL,
    [IdPreFacturacion] NUMERIC (18) NOT NULL,
    [IdPeriodo]        INT          NOT NULL,
    [Observacion]      VARCHAR (50) NOT NULL,
    [estado_cierre]    BIT          NOT NULL,
    [fecha]            DATETIME     NOT NULL,
    [estado]           CHAR (1)     NOT NULL,
    [IdCentroCosto]    VARCHAR (20) NOT NULL,
    [TotalEquipos]     INT          NOT NULL,
    [ValorFacturar]    FLOAT (53)   NOT NULL,
    CONSTRAINT [PK_fa_pre_facturacion_1] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdPreFacturacion] ASC)
);

