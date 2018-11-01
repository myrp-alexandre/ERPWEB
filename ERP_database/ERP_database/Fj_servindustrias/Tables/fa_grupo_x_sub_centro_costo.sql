CREATE TABLE [Fj_servindustrias].[fa_grupo_x_sub_centro_costo] (
    [IdEmpresa]         INT           NOT NULL,
    [IdGrupo]           NUMERIC (18)  NOT NULL,
    [IdCentroCosto]     VARCHAR (20)  NOT NULL,
    [IdProducto]        NUMERIC (18)  NULL,
    [nom_Grupo]         VARCHAR (20)  NOT NULL,
    [Observacion]       VARCHAR (200) NULL,
    [Fecha]             DATE          NOT NULL,
    [Estado]            BIT           NOT NULL,
    [IdUsuario]         VARCHAR (50)  NULL,
    [Fecha_Transaccion] DATETIME      NULL,
    [IdUsuarioUltModi]  VARCHAR (50)  NULL,
    [Fecha_UltMod]      DATETIME      NULL,
    [IdUsuarioUltAnu]   VARCHAR (50)  NULL,
    [Fecha_UltAnu]      DATETIME      NULL,
    [MotivoAnulacion]   VARCHAR (50)  NULL,
    [nom_pc]            VARCHAR (50)  NULL,
    [ip]                VARCHAR (50)  NULL,
    CONSTRAINT [PK_fa_grupo_x_sub_centro_costo] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdGrupo] ASC),
    CONSTRAINT [FK_fa_grupo_x_sub_centro_costo_ct_centro_costo] FOREIGN KEY ([IdEmpresa], [IdCentroCosto]) REFERENCES [dbo].[ct_centro_costo] ([IdEmpresa], [IdCentroCosto]),
    CONSTRAINT [FK_fa_grupo_x_sub_centro_costo_in_Producto] FOREIGN KEY ([IdEmpresa], [IdProducto]) REFERENCES [dbo].[in_Producto] ([IdEmpresa], [IdProducto]),
    CONSTRAINT [FK_fa_grupo_x_sub_centro_costo_tb_empresa] FOREIGN KEY ([IdEmpresa]) REFERENCES [dbo].[tb_empresa] ([IdEmpresa])
);

