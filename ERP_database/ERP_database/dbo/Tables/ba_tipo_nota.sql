CREATE TABLE [dbo].[ba_tipo_nota] (
    [IdEmpresa]     INT          NOT NULL,
    [IdTipoNota]    INT          NOT NULL,
    [Tipo]          VARCHAR (5)  NOT NULL,
    [Descripcion]   VARCHAR (50) NOT NULL,
    [IdCtaCble]     VARCHAR (20) NULL,
    [IdCentroCosto] VARCHAR (20) NULL,
    [Estado]        CHAR (1)     NULL,
    CONSTRAINT [PK_ba_tipo_nota] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdTipoNota] ASC),
    CONSTRAINT [FK_ba_tipo_nota_ct_centro_costo] FOREIGN KEY ([IdEmpresa], [IdCentroCosto]) REFERENCES [dbo].[ct_centro_costo] ([IdEmpresa], [IdCentroCosto]),
    CONSTRAINT [FK_ba_tipo_nota_ct_plancta] FOREIGN KEY ([IdEmpresa], [IdCtaCble]) REFERENCES [dbo].[ct_plancta] ([IdEmpresa], [IdCtaCble]),
    CONSTRAINT [FK_ba_tipo_nota_tb_empresa] FOREIGN KEY ([IdEmpresa]) REFERENCES [dbo].[tb_empresa] ([IdEmpresa])
);

