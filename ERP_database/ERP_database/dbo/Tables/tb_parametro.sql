CREATE TABLE [dbo].[tb_parametro] (
    [IdParametro] VARCHAR (50)  NOT NULL,
    [IdTipoParam] VARCHAR (50)  NOT NULL,
    [Valor]       VARCHAR (50)  NOT NULL,
    [descripcion] VARCHAR (400) NULL,
    CONSTRAINT [PK_tb_parametro] PRIMARY KEY CLUSTERED ([IdParametro] ASC),
    CONSTRAINT [FK_tb_parametro_tb_parametro_tipo] FOREIGN KEY ([IdTipoParam]) REFERENCES [dbo].[tb_parametro_tipo] ([IdTipoParam])
);

