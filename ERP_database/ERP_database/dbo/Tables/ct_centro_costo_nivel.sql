CREATE TABLE [dbo].[ct_centro_costo_nivel] (
    [IdEmpresa]         INT           NOT NULL,
    [IdNivel]           INT           NOT NULL,
    [ni_descripcion]    VARCHAR (20)  NOT NULL,
    [ni_digitos]        TINYINT       NOT NULL,
    [Estado]            CHAR (1)      NULL,
    [IdUsuario]         VARCHAR (20)  NULL,
    [Fecha_Transaccion] DATETIME      NULL,
    [IdUsuarioUltModi]  VARCHAR (20)  NULL,
    [Fecha_UltMod]      DATETIME      NULL,
    [IdUsuarioUltAnu]   VARCHAR (20)  NULL,
    [Fecha_UltAnu]      DATETIME      NULL,
    [MotivoAnulacion]   VARCHAR (100) NULL,
    CONSTRAINT [PK_ct_centro_costo_nivel] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdNivel] ASC),
    CONSTRAINT [FK_ct_centro_costo_nivel_tb_empresa] FOREIGN KEY ([IdEmpresa]) REFERENCES [dbo].[tb_empresa] ([IdEmpresa])
);

