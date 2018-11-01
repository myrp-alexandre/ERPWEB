CREATE TABLE [dbo].[tb_sis_formulario] (
    [IdFormulario]   VARCHAR (250) NOT NULL,
    [cod_Formulario] VARCHAR (250) NOT NULL,
    [nom_Formulario] VARCHAR (250) NOT NULL,
    [CodModulo]      VARCHAR (20)  NOT NULL,
    [Text]           VARCHAR (50)  NOT NULL,
    [observacion]    VARCHAR (550) NOT NULL,
    [estado]         BIT           NOT NULL,
    [nom_Asembly]    VARCHAR (250) NOT NULL,
    CONSTRAINT [PK_tb_sis_formulario] PRIMARY KEY CLUSTERED ([IdFormulario] ASC),
    CONSTRAINT [FK_tb_sis_formulario_tb_modulo] FOREIGN KEY ([CodModulo]) REFERENCES [dbo].[tb_modulo] ([CodModulo])
);

