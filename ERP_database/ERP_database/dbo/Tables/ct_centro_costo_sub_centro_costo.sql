CREATE TABLE [dbo].[ct_centro_costo_sub_centro_costo] (
    [IdEmpresa]                      INT           NOT NULL,
    [IdCentroCosto]                  VARCHAR (20)  NOT NULL,
    [IdCentroCosto_sub_centro_costo] VARCHAR (20)  NOT NULL,
    [cod_subcentroCosto]             VARCHAR (25)  NULL,
    [Centro_costo]                   VARCHAR (200) NOT NULL,
    [pc_Estado]                      CHAR (1)      NOT NULL,
    [IdCtaCble]                      VARCHAR (20)  NULL,
    [Valor_depreciacion]             FLOAT (53)    NULL,
    CONSTRAINT [PK_ct_centro_costo_sub_centro_costo] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdCentroCosto] ASC, [IdCentroCosto_sub_centro_costo] ASC),
    CONSTRAINT [FK_ct_centro_costo_sub_centro_costo_ct_centro_costo] FOREIGN KEY ([IdEmpresa], [IdCentroCosto]) REFERENCES [dbo].[ct_centro_costo] ([IdEmpresa], [IdCentroCosto]),
    CONSTRAINT [FK_ct_centro_costo_sub_centro_costo_ct_plancta] FOREIGN KEY ([IdEmpresa], [IdCtaCble]) REFERENCES [dbo].[ct_plancta] ([IdEmpresa], [IdCtaCble])
);

