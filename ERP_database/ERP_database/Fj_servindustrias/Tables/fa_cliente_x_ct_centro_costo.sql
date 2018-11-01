CREATE TABLE [Fj_servindustrias].[fa_cliente_x_ct_centro_costo] (
    [IdEmpresa_cli]    INT           NOT NULL,
    [IdCliente_cli]    NUMERIC (18)  NOT NULL,
    [IdEmpresa_cc]     INT           NOT NULL,
    [IdCentroCosto_cc] VARCHAR (20)  NOT NULL,
    [Observacion]      VARCHAR (150) NOT NULL,
    CONSTRAINT [PK_fa_cliente_x_ct_centro_costo] PRIMARY KEY CLUSTERED ([IdEmpresa_cc] ASC, [IdCentroCosto_cc] ASC, [IdEmpresa_cli] ASC, [IdCliente_cli] ASC)
);

