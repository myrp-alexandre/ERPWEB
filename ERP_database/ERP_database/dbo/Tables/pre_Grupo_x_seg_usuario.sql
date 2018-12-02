CREATE TABLE [dbo].[pre_Grupo_x_seg_usuario] (
    [IdEmpresa]     INT          NOT NULL,
    [IdGrupo]       INT          NOT NULL,
    [Secuencia]     INT          NOT NULL,
    [IdUsuario]     VARCHAR (50) NOT NULL,
    [AsignaCuentas] BIT          NOT NULL,
    CONSTRAINT [PK_pre_Grupo_x_seg_usuario] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdGrupo] ASC, [Secuencia] ASC),
    CONSTRAINT [FK_pre_Grupo_x_seg_usuario_pre_Grupo] FOREIGN KEY ([IdEmpresa], [IdGrupo]) REFERENCES [dbo].[pre_Grupo] ([IdEmpresa], [IdGrupo]),
    CONSTRAINT [FK_pre_Grupo_x_seg_usuario_seg_usuario] FOREIGN KEY ([IdUsuario]) REFERENCES [dbo].[seg_usuario] ([IdUsuario])
);

