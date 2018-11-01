CREATE TABLE [dbo].[tb_tarjeta] (
    [IdTarjeta]         INT           NOT NULL,
    [tr_Descripcion]    VARCHAR (100) NOT NULL,
    [Estado]            CHAR (1)      NOT NULL,
    [IdBanco]           INT           NOT NULL,
    [IdUsuario]         VARCHAR (20)  NULL,
    [Fecha_Transaccion] DATETIME      NULL,
    [IdUsuarioUltModi]  VARCHAR (20)  NULL,
    [Fecha_UltMod]      DATETIME      NULL,
    [IdUsuarioUltAnu]   VARCHAR (20)  NULL,
    [Fecha_UltAnu]      DATETIME      NULL,
    [MotivoAnulacion]   VARCHAR (100) NULL,
    CONSTRAINT [PK_tb_tarjeta] PRIMARY KEY CLUSTERED ([IdTarjeta] ASC)
);

