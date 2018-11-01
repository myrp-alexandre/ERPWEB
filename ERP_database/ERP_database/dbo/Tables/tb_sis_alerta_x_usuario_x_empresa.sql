CREATE TABLE [dbo].[tb_sis_alerta_x_usuario_x_empresa] (
    [IdEmpresa]  INT          NOT NULL,
    [IdUsuario]  VARCHAR (50) NOT NULL,
    [CodAlerta]  VARCHAR (50) NOT NULL,
    [IdSucursal] INT          NULL,
    CONSTRAINT [PK_tb_sis_alerta_x_usuario_x_empresa] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdUsuario] ASC, [CodAlerta] ASC),
    CONSTRAINT [FK_tb_sis_alerta_x_usuario_x_empresa_seg_usuario] FOREIGN KEY ([IdUsuario]) REFERENCES [dbo].[seg_usuario] ([IdUsuario]),
    CONSTRAINT [FK_tb_sis_alerta_x_usuario_x_empresa_tb_empresa] FOREIGN KEY ([IdEmpresa]) REFERENCES [dbo].[tb_empresa] ([IdEmpresa]),
    CONSTRAINT [FK_tb_sis_alerta_x_usuario_x_empresa_tb_sucursal] FOREIGN KEY ([IdEmpresa], [IdSucursal]) REFERENCES [dbo].[tb_sucursal] ([IdEmpresa], [IdSucursal])
);

