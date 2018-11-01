CREATE TABLE [Fj_servindustrias].[ct_distribucion_gastos_x_periodo] (
    [IdEmpresa]      INT            NOT NULL,
    [IdDistribucion] NUMERIC (18)   NOT NULL,
    [IdPeriodo]      INT            NOT NULL,
    [Fecha]          DATETIME       NOT NULL,
    [Observacion]    VARCHAR (1000) NOT NULL,
    [Estado]         BIT            NOT NULL,
    CONSTRAINT [PK_ct_distribucion_gastos_x_periodo] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdDistribucion] ASC)
);

