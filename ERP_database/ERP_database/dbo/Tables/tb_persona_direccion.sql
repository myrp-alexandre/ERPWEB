CREATE TABLE [dbo].[tb_persona_direccion] (
    [IdPersona]       NUMERIC (18)   NOT NULL,
    [IdDireccion]     INT            NOT NULL,
    [prioridad]       INT            NOT NULL,
    [Direccion]       VARCHAR (1500) NOT NULL,
    [referencia]      VARCHAR (50)   NULL,
    [calle]           VARCHAR (50)   NULL,
    [cod_postal]      VARCHAR (50)   NULL,
    [IdPais]          VARCHAR (10)   NULL,
    [Provincia]       VARCHAR (50)   NULL,
    [Ciudad]          VARCHAR (50)   NULL,
    [estado]          BIT            NOT NULL,
    [IdTipoDireccion] INT            NOT NULL,
    CONSTRAINT [PK_tb_persona_direccion] PRIMARY KEY CLUSTERED ([IdPersona] ASC, [IdDireccion] ASC),
    CONSTRAINT [FK_tb_persona_direccion_tb_persona] FOREIGN KEY ([IdPersona]) REFERENCES [dbo].[tb_persona] ([IdPersona]),
    CONSTRAINT [FK_tb_persona_direccion_tb_persona_direccion_tipo] FOREIGN KEY ([IdTipoDireccion]) REFERENCES [dbo].[tb_persona_direccion_tipo] ([IdTipoDireccion])
);

