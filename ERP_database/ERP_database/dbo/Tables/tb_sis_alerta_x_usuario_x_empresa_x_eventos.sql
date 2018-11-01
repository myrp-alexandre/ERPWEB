CREATE TABLE [dbo].[tb_sis_alerta_x_usuario_x_empresa_x_eventos] (
    [IdEmpresa]   INT          NOT NULL,
    [IdUsuario]   VARCHAR (50) NOT NULL,
    [CodAlerta]   VARCHAR (50) NOT NULL,
    [enum_evento] VARCHAR (20) NOT NULL,
    [observacion] VARCHAR (2)  NULL,
    CONSTRAINT [PK_tb_sis_alerta_x_usuario_x_empresa_x_eventos] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdUsuario] ASC, [CodAlerta] ASC, [enum_evento] ASC),
    CONSTRAINT [FK_tb_sis_alerta_x_usuario_x_empresa_x_eventos_tb_sis_alerta_x_usuario_x_empresa] FOREIGN KEY ([IdEmpresa], [IdUsuario], [CodAlerta]) REFERENCES [dbo].[tb_sis_alerta_x_usuario_x_empresa] ([IdEmpresa], [IdUsuario], [CodAlerta])
);

